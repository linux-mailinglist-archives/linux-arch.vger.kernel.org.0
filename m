Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2426AC31
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 17:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfGPPur (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 11:50:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfGPPur (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 11:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3+YkI0FnsgmXiczrxAjXgi7U2TnIjSbvE8IfvgJlhPg=; b=ED7cS30sIVrEbi1Rwq0uchd+O
        qy7xH/iD39WtaozjvVqAsvYb9/aD3mw+rljvNMErgrmYcSSwAzNEewkV0z9g3CXxIAfhsX1F/AvrX
        8ZW5zWYmekf17Oyath2w15ox/7rfrOrohusEoQw6AbsqzAX7O2ShESoK3DkGXKA+S1be5/9hquOX8
        oenAKGfd2UncPbemM8z2ZHvgdF9z8yHrPBSus1d7R7wwp/MopKlXsaRkDY0o862sn/VndGvD9/m2b
        yuHpHBseRs7yY+4fJBxTl3Xfe77kotfouaYvcCSmsaLta7K4EW0kRCKvGvkCBSOuZ2hJ+QL5EqB3s
        fIU3yKTLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnPii-0005WM-VJ; Tue, 16 Jul 2019 15:50:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B879C20B15D63; Tue, 16 Jul 2019 17:50:22 +0200 (CEST)
Date:   Tue, 16 Jul 2019 17:50:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190716155022.GR3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715192536.104548-4-alex.kogan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 15, 2019 at 03:25:34PM -0400, Alex Kogan wrote:
> +static struct cna_node *find_successor(struct mcs_spinlock *me)
> +{
> +	struct cna_node *me_cna = CNA_NODE(me);
> +	struct cna_node *head_other, *tail_other, *cur;
> +	struct cna_node *next = CNA_NODE(READ_ONCE(me->next));
> +	int my_node;
> +
> +	/* @next should be set, else we would not be calling this function. */
> +	WARN_ON_ONCE(next == NULL);
> +
> +	my_node = me_cna->numa_node;
> +
> +	/*
> +	 * Fast path - check whether the immediate successor runs on
> +	 * the same node.
> +	 */
> +	if (next->numa_node == my_node)
> +		return next;
> +
> +	head_other = next;
> +	tail_other = next;
> +
> +	/*
> +	 * Traverse the main waiting queue starting from the successor of my
> +	 * successor, and look for a thread running on the same node.
> +	 */
> +	cur = CNA_NODE(READ_ONCE(next->mcs.next));
> +	while (cur) {
> +		if (cur->numa_node == my_node) {
> +			/*
> +			 * Found a thread on the same node. Move threads
> +			 * between me and that node into the secondary queue.
> +			 */
> +			if (me->locked > 1)
> +				CNA_NODE(me->locked)->tail->mcs.next =
> +					(struct mcs_spinlock *)head_other;
> +			else
> +				me->locked = (uintptr_t)head_other;
> +			tail_other->mcs.next = NULL;
> +			CNA_NODE(me->locked)->tail = tail_other;
> +			return cur;
> +		}
> +		tail_other = cur;
> +		cur = CNA_NODE(READ_ONCE(cur->mcs.next));
> +	}
> +	return NULL;
> +}

static void cna_move(struct cna_node *cn, struct cna_node *cni)
{
	struct cna_node *head, *tail;

	/* remove @cni */
	WRITE_ONCE(cn->mcs.next, cni->mcs.next);

	/* stick @cni on the 'other' list tail */
	cni->mcs.next = NULL;

	if (cn->mcs.locked <= 1) {
		/* head = tail = cni */
		head = cni;
		head->tail = cni;
		cn->mcs.locked = head->encoded_tail;
	} else {
		/* add to tail */
		head = (struct cna_node *)decode_tail(cn->mcs.locked);
		tail = tail->tail;
		tail->next = cni;
	}
}

static struct cna_node *cna_find_next(struct mcs_spinlock *node)
{
	struct cna_node *cni, *cn = (struct cna_node *)node;

	while ((cni = (struct cna_node *)READ_ONCE(cn->mcs.next))) {
		if (likely(cni->node == cn->node))
			break;

		cna_move(cn, cni);
	}

	return cni;
}

> +static inline bool cna_set_locked_empty_mcs(struct qspinlock *lock, u32 val,
> +					struct mcs_spinlock *node)
> +{
> +	/* Check whether the secondary queue is empty. */
> +	if (node->locked <= 1) {
> +		if (atomic_try_cmpxchg_relaxed(&lock->val, &val,
> +				_Q_LOCKED_VAL))
> +			return true; /* No contention */
> +	} else {
> +		/*
> +		 * Pass the lock to the first thread in the secondary
> +		 * queue, but first try to update the queue's tail to
> +		 * point to the last node in the secondary queue.


That comment doesn't make sense; there's at least one conditional
missing.

> +		 */
> +		struct cna_node *succ = CNA_NODE(node->locked);
> +		u32 new = succ->tail->encoded_tail + _Q_LOCKED_VAL;
> +
> +		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
> +			arch_mcs_spin_unlock_contended(&succ->mcs.locked, 1);
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}

static cna_try_clear_tail(struct qspinlock *lock, u32 val, struct mcs_spinlock *node)
{
	if (node->locked <= 1)
		return __try_clear_tail(lock, val, node);

	/* the other case */
}

> +static inline void cna_pass_mcs_lock(struct mcs_spinlock *node,
> +				     struct mcs_spinlock *next)
> +{
> +	struct cna_node *succ = NULL;
> +	u64 *var = &next->locked;
> +	u64 val = 1;
> +
> +	succ = find_successor(node);

This makes unlock O(n), which is 'funneh' and undocumented.

> +
> +	if (succ) {
> +		var = &succ->mcs.locked;
> +		/*
> +		 * We unlock a successor by passing a non-zero value,
> +		 * so set @val to 1 iff @locked is 0, which will happen
> +		 * if we acquired the MCS lock when its queue was empty
> +		 */
> +		val = node->locked + (node->locked == 0);
> +	} else if (node->locked > 1) { /* if the secondary queue is not empty */
> +		/* pass the lock to the first node in that queue */
> +		succ = CNA_NODE(node->locked);
> +		succ->tail->mcs.next = next;
> +		var = &succ->mcs.locked;

> +	}	/*
> +		 * Otherwise, pass the lock to the immediate successor
> +		 * in the main queue.
> +		 */

I don't think this mis-indented comment can happen. The call-site
guarantees @next is non-null.

Therefore, cna_find_next() will either return it, or place it on the
secondary list. If it (cna_find_next) returns NULL, we must have a
non-empty secondary list.

In no case do I see this tertiary condition being possible.

> +
> +	arch_mcs_spin_unlock_contended(var, val);
> +}

This also renders this @next argument superfluous.

static cna_mcs_pass_lock(struct mcs_spinlock *node, struct mcs_spinlock *next)
{
	next = cna_find_next(node);
	if (!next) {
		BUG_ON(node->locked <= 1);
		next = (struct cna_node *)decode_tail(node->locked);
		node->locked = 1;
	}

	arch_mcs_pass_lock(&next->mcs.locked, node->locked);
}

