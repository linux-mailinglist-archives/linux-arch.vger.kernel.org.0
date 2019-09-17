Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BBB54E2
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2019 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfIQSHY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Sep 2019 14:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfIQSHY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Sep 2019 14:07:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78B6E8A1C8E;
        Tue, 17 Sep 2019 18:07:23 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4B9319C6A;
        Tue, 17 Sep 2019 18:07:21 +0000 (UTC)
Subject: Re: [PATCH v4 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20190906142541.34061-1-alex.kogan@oracle.com>
 <20190906142541.34061-5-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <506c7d1c-faef-d094-3baa-6aaaf9089c60@redhat.com>
Date:   Tue, 17 Sep 2019 14:07:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190906142541.34061-5-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Tue, 17 Sep 2019 18:07:23 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/6/19 10:25 AM, Alex Kogan wrote:
> Choose the next lock holder among spinning threads running on the same
> node with high probability rather than always. With small probability,
> hand the lock to the first thread in the secondary queue or, if that
> queue is empty, to the immediate successor of the current lock holder
> in the main queue.  Thus, assuming no failures while threads hold the
> lock, every thread would be able to acquire the lock after a bounded
> number of lock transitions, with high probability.
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  kernel/locking/qspinlock_cna.h | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
> index f983debf20bb..e86182e6163b 100644
> --- a/kernel/locking/qspinlock_cna.h
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -4,6 +4,7 @@
>  #endif
>  
>  #include <linux/topology.h>
> +#include <linux/random.h>
>  
>  /*
>   * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
> @@ -50,6 +51,34 @@ struct cna_node {
>  	struct	cna_node *tail;    /* points to the secondary queue tail */
>  };
>  
> +/* Per-CPU pseudo-random number seed */
> +static DEFINE_PER_CPU(u32, seed);
> +
> +/*
> + * Controls the probability for intra-node lock hand-off. It can be
> + * tuned and depend, e.g., on the number of CPUs per node. For now,
> + * choose a value that provides reasonable long-term fairness without
> + * sacrificing performance compared to a version that does not have any
> + * fairness guarantees.
> + */
> +#define INTRA_NODE_HANDOFF_PROB_ARG (16)
> +
> +/*
> + * Return false with probability 1 / 2^@num_bits.
> + * Intuitively, the larger @num_bits the less likely false is to be returned.
> + * @num_bits must be a number between 0 and 31.
> + */
> +static bool probably(unsigned int num_bits)
> +{
> +	u32 s;
> +
> +	s = this_cpu_read(seed);
> +	s = next_pseudo_random32(s);
> +	this_cpu_write(seed, s);
> +
> +	return s & ((1 << num_bits) - 1);
> +}
> +
>  static void __init cna_init_nodes_per_cpu(unsigned int cpu)
>  {
>  	struct mcs_spinlock *base = per_cpu_ptr(&qnodes[0].mcs, cpu);
> @@ -202,9 +231,11 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
>  
>  	/*
>  	 * Try to find a successor running on the same NUMA node
> -	 * as the current lock holder.
> +	 * as the current lock holder. For long-term fairness,
> +	 * search for such a thread with high probability rather than always.
>  	 */
> -	new_next = cna_try_find_next(node, next);
> +	if (probably(INTRA_NODE_HANDOFF_PROB_ARG))
> +		new_next = cna_try_find_next(node, next);
>  
>  	if (new_next) {		          /* if such successor is found */
>  		next_holder = new_next;

Because the accounting is done per cpu, not per lock, there is no
guaranteed maximum of times for passing the lock to waiters in the same
node versus other nodes for a given lock. So lock starvation is still
theoretically possible. How about just keeping a count of how many times
a lock is passed to waiters of the same node in the CNA structure? So if
the count reaches a threshold, the lock will be passed to the one in the
secondary queue. 16 bits should be enough for node ID. That will leave
16 bits to store the count without increasing the size of the CNA structure.

Cheers,
Longman

