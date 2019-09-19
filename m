Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11EDB82F5
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 22:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbfISUy2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 16:54:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5781 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbfISUy1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Sep 2019 16:54:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02CA97F75E;
        Thu, 19 Sep 2019 20:54:27 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66B4519D70;
        Thu, 19 Sep 2019 20:54:14 +0000 (UTC)
Subject: Re: [PATCH v4 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20190906142541.34061-1-alex.kogan@oracle.com>
 <20190906142541.34061-4-alex.kogan@oracle.com>
 <3ae2b6a2-ffe6-2ca1-e5bf-2292db50e26f@redhat.com>
 <87B87982-670F-4F12-9EE0-DC89A059FAEC@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6c08767a-f60c-077d-4e94-66ea189db6f1@redhat.com>
Date:   Thu, 19 Sep 2019 16:54:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87B87982-670F-4F12-9EE0-DC89A059FAEC@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Thu, 19 Sep 2019 20:54:27 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/19/19 11:55 AM, Alex Kogan wrote:
>>> +/*
>>> + * cna_try_find_next - scan the main waiting queue looking for the first
>>> + * thread running on the same NUMA node as the lock holder. If found (call it
>>> + * thread T), move all threads in the main queue between the lock holder and
>>> + * T to the end of the secondary queue and return T; otherwise, return NULL.
>>> + *
>>> + * Schematically, this may look like the following (nn stands for numa_node and
>>> + * et stands for encoded_tail).
>>> + *
>>> + *     when cna_try_find_next() is called (the secondary queue is empty):
>>> + *
>>> + *  A+------------+   B+--------+   C+--------+   T+--------+
>>> + *   |mcs:next    | -> |mcs:next| -> |mcs:next| -> |mcs:next| -> NULL
>>> + *   |mcs:locked=1|    |cna:nn=0|    |cna:nn=2|    |cna:nn=1|
>>> + *   |cna:nn=1    |    +--------+    +--------+    +--------+
>>> + *   +----------- +
>>> + *
>>> + *     when cna_try_find_next() returns (the secondary queue contains B and C):
>>> + *
>>> + *  A+----------------+    T+--------+
>>> + *   |mcs:next        | ->  |mcs:next| -> NULL
>>> + *   |mcs:locked=B.et | -+  |cna:nn=1|
>>> + *   |cna:nn=1        |  |  +--------+
>>> + *   +--------------- +  |
>>> + *                       |
>>> + *                       +->  B+--------+   C+--------+
>>> + *                             |mcs:next| -> |mcs:next|
>>> + *                             |cna:nn=0|    |cna:nn=2|
>>> + *                             |cna:tail| -> +--------+
>>> + *                             +--------+
>>> + *
>>> + * The worst case complexity of the scan is O(n), where n is the number
>>> + * of current waiters. However, the fast path, which is expected to be the
>>> + * common case, is O(1).
>>> + */
>>> +static struct mcs_spinlock *cna_try_find_next(struct mcs_spinlock *node,
>>> +					      struct mcs_spinlock *next)
>>> +{
>>> +	struct cna_node *cn = (struct cna_node *)node;
>>> +	struct cna_node *cni = (struct cna_node *)next;
>>> +	struct cna_node *first, *last = NULL;
>>> +	int my_numa_node = cn->numa_node;
>>> +
>>> +	/* fast path: immediate successor is on the same NUMA node */
>>> +	if (cni->numa_node == my_numa_node)
>>> +		return next;
>>> +
>>> +	/* find any next waiter on 'our' NUMA node */
>>> +	for (first = cni;
>>> +	     cni && cni->numa_node != my_numa_node;
>>> +	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
>>> +		;
>>> +
>>> +	/* if found, splice any skipped waiters onto the secondary queue */
>>> +	if (cni && last)
>>> +		cna_splice_tail(cn, first, last);
>>> +
>>> +	return (struct mcs_spinlock *)cni;
>>> +}
>> At the Linux Plumbers Conference last week, Will has raised the concern
>> about the latency of the O(1) cna_try_find_next() operation that will
>> add to the lock hold time.
> While the worst case complexity of the scan is O(n), I _think it can be proven
> that the amortized complexity is O(1). For intuition, consider a two-node 
> system with N threads total. In the worst case scenario, the scan will go 
> over N/2 threads running on a different node. If the scan ultimately “fails”
> (no thread from the lock holder’s node is found), the lock will be passed
> to the first thread from a different node and then between all those N/2 threads,
> with a scan of just one node for the next N/2 - 1 passes. Otherwise, those 
> N/2 threads will be moved to the secondary queue. On the next lock handover, 
> we pass the lock either to the next thread in the main queue (as it has to be 
> from our node) or to the first node in the secondary queue. In both cases, we 
> scan just one node, and in the latter case, we have again N/2 - 1 passes with 
> a scan of just one node each.
I agree that it should not be a problem for a 2-socket. For larger SMP
systems with 8, 16 or even 32 sockets, it can be an issue as those
systems are also more likely to have more lock contention and hence
longer wait queues.
>> One way to hide some of the latency is to do
>> a pre-scan before acquiring the lock. The CNA code could override the
>> pv_wait_head_or_lock() function to call cna_try_find_next() as a
>> pre-scan and return 0. What do you think?
> This is certainly possible, but I do not think it would completely eliminate 
> the worst case scenario. It will probably make it even less likely, but at 
> the same time, we will reduce the chance of actually finding a thread from the
> same node (that may enter the main queue while we wait for the owner & pending 
> to go away).

When I said prescan, I mean to move the front queue entries that are
from non-local nodes to the secondary queue before acquiring the lock.
After acquiring the lock, you can repeat the scan in case the prescan
didn't find any local node queue entry. Yes, we will need to do the
similar operation twice.

Yes, it does not eliminate the worst case scenario, but it should help
in reducing the average lock hold time.

Of course, the probabilistic (or deterministic) check to go to the next
local node entry or to the secondary queue should be done before
pre-scan so that we won't waste the effort.

Cheers,
Longman

