Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464B96B46C
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 04:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfGQCQd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 22:16:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfGQCQd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jul 2019 22:16:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69B073082128;
        Wed, 17 Jul 2019 02:16:32 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-180.rdu2.redhat.com [10.10.122.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9697E60922;
        Wed, 17 Jul 2019 02:16:29 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
Date:   Tue, 16 Jul 2019 22:16:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190715192536.104548-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 17 Jul 2019 02:16:32 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/15/19 3:25 PM, Alex Kogan wrote:
> +/*
> + * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
> + *
> + * In CNA, spinning threads are organized in two queues, a main queue for
> + * threads running on the same node as the current lock holder, and a
> + * secondary queue for threads running on other nodes. At the unlock time,
> + * the lock holder scans the main queue looking for a thread running on
> + * the same node. If found (call it thread T), all threads in the main queue
> + * between the current lock holder and T are moved to the end of the
> + * secondary queue, and the lock is passed to T. If such T is not found, the
> + * lock is passed to the first node in the secondary queue. Finally, if the
> + * secondary queue is empty, the lock is passed to the next thread in the
> + * main queue. To avoid starvation of threads in the secondary queue,
> + * those threads are moved back to the head of the main queue
> + * after a certain expected number of intra-node lock hand-offs.
> + *
> + * For more details, see https://arxiv.org/abs/1810.05600.
> + *
> + * Authors: Alex Kogan <alex.kogan@oracle.com>
> + *          Dave Dice <dave.dice@oracle.com>
> + */
> +
> +struct cna_node {
> +	struct	mcs_spinlock mcs;
> +	u32	numa_node;
> +	u32	encoded_tail;
> +	struct	cna_node *tail;    /* points to the secondary queue tail */
> +};
> +
> +#define CNA_NODE(ptr) ((struct cna_node *)(ptr))
> +
> +static void cna_init_node(struct mcs_spinlock *node)
> +{
> +	struct cna_node *cn = CNA_NODE(node);
> +	struct mcs_spinlock *base_node;
> +	int cpuid;
> +
> +	BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
> +	/* we store a pointer in the node's @locked field */
> +	BUILD_BUG_ON(sizeof(uintptr_t) > sizeof_field(struct mcs_spinlock, locked));
> +
> +	cpuid = smp_processor_id();
> +	cn->numa_node = cpu_to_node(cpuid);
> +
> +	base_node = this_cpu_ptr(&qnodes[0].mcs);
> +	cn->encoded_tail = encode_tail(cpuid, base_node->count - 1);
> +}
> +
> +/**
> + * find_successor - Scan the main waiting queue looking for the first
> + * thread running on the same node as the lock holder. If found (call it
> + * thread T), move all threads in the main queue between the lock holder
> + * and T to the end of the secondary queue and return T; otherwise, return NULL.
> + */

Here you talk about main and secondary queues. However, there is no
mention of what are those queues. As I am familiar with qspinlock queue,
I can figure out that the main queue is the mcs_node->next chain that
starts from the MCS lock holder. The secondary queue is a separate MCS
node chain with its head stored in the mcs_node->locked value of the MCS
lock holder and the tail stored in the cna->tail. More detail comments
on what and where they are will help to improve the readability of the
code. A simple graphic to illustrate those queues will help too, for example

/*
 * MCS lock holder
 * ===============
 *    mcs_node
 *   +--------+      +----+         +----+
 *   | next   | ---> |next| -> ...  |next| -> NULL  [Main queue]
 *   | locked | -+   +----+         +----+
 *   +--------+  |
 *               |   +----+         +----+
 *               +-> |next| -> ...  |next| -> X     [Secondary queue]
 *    cna_node       +----+         +----+
 *   +--------*                       ^
 *   | tail   | ----------------------+
 *   +--------*   
 *
 * N.B. locked = 1 if secondary queue is absent.
 */

> +static struct cna_node *find_successor(struct mcs_spinlock *me)
> +{
> +	struct cna_node *me_cna = CNA_NODE(me);
> +	struct cna_node *head_other, *tail_other, *cur;
As you have talked about secondary queue, how about head_2nd, tail_2nd
instead of *_other?

Cheers,
Longman

