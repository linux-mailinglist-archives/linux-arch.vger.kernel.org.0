Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BB335DDCA
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 13:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhDMLbJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 07:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhDMLbJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 07:31:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC6BC061574;
        Tue, 13 Apr 2021 04:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1VjW7Uh2w6eNF/Gh7/5tKwqhApl8TRKkl5CPq/5mjX8=; b=NRLLelL8Ga05tj1rNply/2Wu0A
        0MMzohQtk7bke27oT/QYPTkIoAbKYNnrkGRjK0/3mDSPetn1+UapsIc4CC9vsPoEIslrjl9CyL8cw
        1TGggkCrjn8D9NEu8QqK/5lCicZVwWoIAjdNoNeaVSVWOqPcQfXw1ddtGqGoBP8u+m3b1oaNXK/PU
        T7MXoKO04QlPU+p3f8cYrL7cOA4slQzDFGcpSbEXuy8wo8LsAYzDOJlYt2CalQxju++QK/B0oYRPJ
        uzgldAkScT9P9oTM+iK1kjcyYUNCrYglaZ8mqS69A1+QHDLB+qh2t1ZrtM+CrDCkXpXmpgTOw4vbL
        5INccSUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWHFC-0093aR-OI; Tue, 13 Apr 2021 11:30:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06EEE300033;
        Tue, 13 Apr 2021 13:30:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88F7C2C4C642E; Tue, 13 Apr 2021 13:30:06 +0200 (CEST)
Date:   Tue, 13 Apr 2021 13:30:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Subject: Re: [PATCH v14 3/6] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <YHWAvjymlE5svU71@hirez.programming.kicks-ass.net>
References: <20210401153156.1165900-1-alex.kogan@oracle.com>
 <20210401153156.1165900-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401153156.1165900-4-alex.kogan@oracle.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 11:31:53AM -0400, Alex Kogan wrote:

> +/*
> + * cna_splice_tail -- splice the next node from the primary queue onto
> + * the secondary queue.
> + */
> +static void cna_splice_next(struct mcs_spinlock *node,
> +			    struct mcs_spinlock *next,
> +			    struct mcs_spinlock *nnext)

You forgot to update the comment when you changed the name on this
thing.

> +/*
> + * cna_order_queue - check whether the next waiter in the main queue is on
> + * the same NUMA node as the lock holder; if not, and it has a waiter behind
> + * it in the main queue, move the former onto the secondary queue.
> + */
> +static void cna_order_queue(struct mcs_spinlock *node)
> +{
> +	struct mcs_spinlock *next = READ_ONCE(node->next);
> +	struct cna_node *cn = (struct cna_node *)node;
> +	int numa_node, next_numa_node;
> +
> +	if (!next) {
> +		cn->partial_order = LOCAL_WAITER_NOT_FOUND;
> +		return;
> +	}
> +
> +	numa_node = cn->numa_node;
> +	next_numa_node = ((struct cna_node *)next)->numa_node;
> +
> +	if (next_numa_node != numa_node) {
> +		struct mcs_spinlock *nnext = READ_ONCE(next->next);
> +
> +		if (nnext) {
> +			cna_splice_next(node, next, nnext);
> +			next = nnext;
> +		}
> +		/*
> +		 * Inherit NUMA node id of primary queue, to maintain the
> +		 * preference even if the next waiter is on a different node.
> +		 */
> +		((struct cna_node *)next)->numa_node = numa_node;
> +	}
> +}

So the obvious change since last time I looked a this is that it now
only looks 1 entry ahead. Which makes sense I suppose.

I'm not really a fan of the 'partial_order' name combined with that
silly enum { LOCAL_WAITER_FOUND, LOCAL_WAITER_NOT_FOUND }. That's just
really bad naming all around. The enum is about having a waiter while
the variable is about partial order, that doesn't match at all.

If you rename the variable to 'has_waiter' and simply use 0,1 values,
things would be ever so more readable. But I don't think that makes
sense, see below.

I'm also not sure about that whole numa_node thing, why would you
over-write the numa node, why at this point ?

> +
> +/* Abuse the pv_wait_head_or_lock() hook to get some work done */
> +static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
> +						 struct mcs_spinlock *node)
> +{
> +	/*
> +	 * Try and put the time otherwise spent spin waiting on
> +	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
> +	 */
> +	cna_order_queue(node);
> +
> +	return 0; /* we lied; we didn't wait, go do so now */

So here we inspect one entry ahead and then quit. I can't rmember, but
did we try something like:

	/*
	 * Try and put the time otherwise spent spin waiting on
	 * _Q_LOCKED_PENDING_MASK to use by sorting our lists.
	 * Move one entry at a go until either the list is fully
	 * sorted or we ran out of spin condition.
	 */
	while (READ_ONCE(lock->val) & _Q_LOCKED_PENDING_MASK &&
	       node->partial_order)
		cna_order_queue(node);

	return 0;

This will keep moving @next to the remote list until such a time that
we're forced to continue or @next is local.

> +}
> +
> +static inline void cna_lock_handoff(struct mcs_spinlock *node,
> +				 struct mcs_spinlock *next)
> +{
> +	struct cna_node *cn = (struct cna_node *)node;
> +	u32 val = 1;
> +
> +	u32 partial_order = cn->partial_order;
> +
> +	if (partial_order == LOCAL_WAITER_NOT_FOUND)
> +		cna_order_queue(node);
> +

AFAICT this is where playing silly games with ->numa_node belong; but
right along with that goes a comment that describes why any of that
makes sense.

I mean, if you leave your node, for any reason, why bother coming back
to it, why not accept it is a sign of the gods you're overdue for a
node-change?

Was the efficacy of this scheme tested?

> +	/*
> +	 * We have a local waiter, either real or fake one;
> +	 * reload @next in case it was changed by cna_order_queue().
> +	 */
> +	next = node->next;
> +	if (node->locked > 1)
> +		val = node->locked;	/* preseve secondary queue */

IIRC we used to do:

	val |= node->locked;

Which is simpler for not having branches. Why change a good thing?

> +
> +	arch_mcs_lock_handoff(&next->locked, val);
> +}
