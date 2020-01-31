Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B140E14ED7A
	for <lists+linux-arch@lfdr.de>; Fri, 31 Jan 2020 14:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgAaNgP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jan 2020 08:36:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgAaNgP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jan 2020 08:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zkWQFvNGpyBhr4Z4R18Fg//7D+HlhUyWDEfob7HxLtM=; b=MLVXeNH6V8F7iyHCSO+kGRmnMj
        er/WT5xKENnE+xjDnVXChNEvHWdzdla/YNQowJ/FFcugyH81ijwLCw6adsqUwLl+3Mq9a7PrrK4gz
        QI4mF+Yjs9NDsnOg84wiFn4jwcrpWhqqY0r8+bdqrWIIXqg7/4lAKU1wVoJzISg/4LO8+dr2nzh0g
        8b+/niV9OTPqAGZ5qhSqe8UIBJrbEx9dhjODYiKNWqXcWJDlWRYw2IIqmsaK/7GyrbsXxr+dE2ZJp
        SW7GZf9wX43Tv4jOD1G4fP/3UyexMloEtBWBlE/Qdo2avw3tPwwjAMKIhuY/Eom2kzUMkDH//l7Ws
        6MwPToFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixWSZ-0000FP-Vu; Fri, 31 Jan 2020 13:35:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B5FA3007F2;
        Fri, 31 Jan 2020 14:33:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3984F20247167; Fri, 31 Jan 2020 14:35:43 +0100 (CET)
Date:   Fri, 31 Jan 2020 14:35:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200131133543.GD14914@hirez.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
 <20200122095127.GC14946@hirez.programming.kicks-ass.net>
 <20200122170456.GY14879@hirez.programming.kicks-ass.net>
 <D6ED40A0-E96D-41F6-AA74-0901C2C37476@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D6ED40A0-E96D-41F6-AA74-0901C2C37476@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 30, 2020 at 05:01:15PM -0500, Alex Kogan wrote:

> > +/*
> > + * cna_order_queue - scan the primary queue looking for the first lock node on
> > + * the same NUMA node as the lock holder and move any skipped nodes onto the
> > + * secondary queue.
> Oh man, you took out the ascii figure I was working so hard to put in. Oh well.

Right; sorry about that. The reason it's gone is that it was mostly
identical to the one higher up in the file and didn't consider all
cases this code deals with.

Instead I gifted you cna_splice_head() :-)

> > + *
> > + * Returns 0 if a matching node is found; otherwise return the encoded pointer
> > + * to the last element inspected (such that a subsequent scan can continue there).
> > + *
> > + * The worst case complexity of the scan is O(n), where n is the number
> > + * of current waiters. However, the amortized complexity is close to O(1),
> > + * as the immediate successor is likely to be running on the same node once
> > + * threads from other nodes are moved to the secondary queue.
> > + *
> > + * XXX does not compute; given equal contention it should average to O(nr_nodes).
> Let me try to convince you. Under contention, the immediate waiter would be
> a local one. So the scan would typically take O(1) steps. We need to consider
> the extra work/steps we take to move nodes to the secondary queue. The
> number of such nodes is O(n) (to be more precise, it is O(n-m), where m
> is nr_cpus_per_node), and we spend a constant amount of work, per node, 
> to scan those nodes and move them to the secondary queue. So in 2^thresholds
> lock handovers, we scan 2^thresholds x 1 + n-m nodes. Assuming 
> 2^thresholds > n, the amortized complexity of this function then is O(1).

There is no threshold in this patch. That's the next patch, and
I've been procrastinating on that one, mostly also because of the
'reasonable' claim without data.

But Ah!, I think I see, after nr_cpus tries, all remote waiters are on
the secondary queue and only local waiters will remain. That will indeed
depress the average a lot.

> > + */
> > +static u32 cna_order_queue(struct mcs_spinlock *node,
> > +			   struct mcs_spinlock *iter)
> > +{
> > +	struct cna_node *cni = (struct cna_node *)READ_ONCE(iter->next);
> > +	struct cna_node *cn = (struct cna_node *)node;
> > +	int nid = cn->numa_node;
> > +	struct cna_node *last;
> > +
> > +	/* find any next waiter on 'our' NUMA node */
> > +	for (last = cn;
> > +	     cni && cni->numa_node != nid;
> > +	     last = cni, cni = (struct cna_node *)READ_ONCE(cni->mcs.next))
> > +		;
> > +
> > +	if (!cna)
> Should be ‘cni’

Yeah, I think the build robots told me the same; in any case, that's
already fixed in the version you can find in my queue.git thing.

> > +		return last->encoded_tail; /* continue from here */
> > +
> > +	if (last != cn)	/* did we skip any waiters? */
> > +		cna_splice_tail(node, node->next, (struct mcs_spinlock *)last);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * cna_splice_head -- splice the entire secondary queue onto the head of the
> > + * primary queue.
> > + */
> > +static cna_splice_head(struct qspinlock *lock, u32 val,
> > +		       struct mcs_spinlock *node, struct mcs_spinlock *next)
> Missing return value type (struct mcs_spinlock *).

Yeah, robots beat you again.

> > +{
> > +	struct mcs_spinlock *head_2nd, *tail_2nd;
> > +
> > +	tail_2nd = decode_tail(node->locked);
> > +	head_2nd = tail_2nd->next;
> I understand that you are trying to avoid repeating those two lines
> in both places this function is called from, but you do it at the cost
> of adding the following unnecessary if-statement, and in general this function
> looks clunky.

Let me show you the current form:

/*
 * cna_splice_head -- splice the entire secondary queue onto the head of the
 * primary queue.
 *
 * Returns the new primary head node or NULL on failure.
 */
static struct mcs_spinlock *
cna_splice_head(struct qspinlock *lock, u32 val,
		struct mcs_spinlock *node, struct mcs_spinlock *next)
{
	struct mcs_spinlock *head_2nd, *tail_2nd;
	u32 new;

	tail_2nd = decode_tail(node->locked);
	head_2nd = tail_2nd->next;

	if (!next) {
		/*
		 * When the primary queue is empty; our tail becomes the primary tail.
		 */

		/*
		 * Speculatively break the secondary queue's circular link; such that when
		 * the secondary tail becomes the primary tail it all works out.
		 */
		tail_2nd->next = NULL;

		/*
		 * tail_2nd->next = NULL		xchg_tail(lock, tail)
		 *
		 * cmpxchg_release(&lock, val, new)	WRITE_ONCE(prev->next, node);
		 *
		 * Such that if the cmpxchg() succeeds, our stores won't collide.
		 */
		new = ((struct cna_node *)tail_2nd)->encoded_tail | _Q_LOCKED_VAL;
		if (!atomic_try_cmpxchg_release(&lock->val, &val, new)) {
			/*
			 * Note; when this cmpxchg fails due to concurrent
			 * queueing of a new waiter, then we'll try again in
			 * cna_pass_lock() if required.
			 *
			 * Restore the secondary queue's circular link.
			 */
			tail_2nd->next = head_2nd;
			return NULL;
		}

	} else {
		/*
		 * If the primary queue is not empty; the primary tail doesn't need
		 * to change and we can simply link our tail to the old head.
		 */
		tail_2nd->next = next;
	}

	/* That which was the secondary queue head, is now the primary queue head */
	return head_2nd;
}

The function as a whole is self-contained and consistent, it deals with
the splice 2nd to 1st queue, for all possible cases. You only have to
think about the list splice in one place, here, instead of two places.

I don't think it will actually result in more branches emitted; the
compiler should be able to use value propagation to eliminate stuff.

> > +static inline bool cna_try_clear_tail(struct qspinlock *lock, u32 val,
> > +				      struct mcs_spinlock *node)
> > +{
> > +	struct mcs_spinlock *next;
> > +
> > +	/*
> > +	 * We're here because the primary queue is empty; check the secondary
> > +	 * queue for remote waiters.
> > +	 */
> > +	if (node->locked > 1) {
> > +		/*
> > +		 * When there are waiters on the secondary queue move them back
> > +		 * onto the primary queue and let them rip.
> > +		 */
> > +		next = cna_splice_head(lock, val, node, NULL);
> > +		if (next) {
> And, again, this if-statement is here only because you moved the rest of the code
> into cna_splice_head(). Perhaps, with cna_extract_2dary_head_tail() you can
> bring that code back?

I don't see the objection, you already had a branch there, from the
cmpxchg(), this is the same branch, the compiler should fold the lot. We
can add an __always_inline if you're worried.

> > +			arch_mcs_pass_lock(&head_2nd->locked, 1);
> Should be next->locked. Better yet, ‘next' should be called ‘head_2nd’.

Yeah, fixed already. Those damn build bots figured it didn't compile.

> > +			return true;
> > +		}
> > +
> > +		return false;
> > +	}
> > +
> > +	/* Both queues empty. */
> > +	return __try_clear_tail(lock, val, node);
> > +}
> > +
> > +static inline void cna_pass_lock(struct mcs_spinlock *node,
> > +				 struct mcs_spinlock *next)
> > +{
> > +	struct cna_node *cn = (struct cna_node *)node;
> > +	u32 partial_order = cn->partial_order;
> > +	u32 val = _Q_LOCKED_VAL;
> > +
> > +	/* cna_wait_head_or_lock() left work for us. */
> > +	if (partial_order) {
> > +		partial_order = cna_order_queue(node, decode_tail(partial_order));
> > +
> > +	if (!partial_order) {
> > +		/*
> > +		 * We found a local waiter; reload @next in case we called
> > +		 * cna_order_queue() above.
> > +		 */
> > +		next = node->next;
> > +		val |= node->locked;	/* preseve secondary queue */
> This is wrong. node->locked can be 0, 1 or an encoded tail at this point, and
> the latter case will be handled incorrectly.
> 
> Should be 
> 		  if (node->locked) val = node->locked;
> instead.

I'm confused, who cares about the locked bit when it has an encoded tail on?

The generic code only cares about it being !0, and the cna code always
checks if it has a tail (>1 , <=1) first.
