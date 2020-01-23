Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195F314655C
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 11:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgAWKHE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 05:07:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60824 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWKHE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 05:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RNXTHzMWdAtx6D8MqtDjnWjGOecOvXnxd0b3aezRlbM=; b=qf3j5dyRRR2IDX21GjmYWm3EM
        gP7mN6IpY9OVHkaeBYNVonbidUDC8jdSaYepv223StC0EYxFYf8wIwQPwbPB8P3RHPnLgVIDpaq3H
        DiKB5VOUgs/ifvf6KqRW/fD9Ul8fWz8HhKfn03sIlXtEE+/3Dvj0gywlJvrBd63Dc3JaD+RXnHkUr
        +jN0JwEthW71geXwAsmHSD2c5s0pqueSyQd9StM8rWB+YwVZoyoNJKw1TOP1x6C93JSAGoRuSvZOX
        eFWaJWsTDzeN6ldkbGMpN29bDi7KoX6ZNoGicpVQJIRaOHXNQri1TCO2letCRjl8vKhuNdh3U3ycY
        P4JXp25aA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuZNo-0003Ff-11; Thu, 23 Jan 2020 10:06:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E162F300B8D;
        Thu, 23 Jan 2020 11:04:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D52CE2B6E7A17; Thu, 23 Jan 2020 11:06:35 +0100 (CET)
Date:   Thu, 23 Jan 2020 11:06:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Subject: Re: [PATCH v9 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200123100635.GE14946@hirez.programming.kicks-ass.net>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-4-alex.kogan@oracle.com>
 <20200123092658.GC14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123092658.GC14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 10:26:58AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 14, 2020 at 10:59:18PM -0500, Alex Kogan wrote:
> > +/* this function is called only when the primary queue is empty */
> > +static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
> > +				       struct mcs_spinlock *node)
> > +{
> > +	struct mcs_spinlock *head_2nd, *tail_2nd;
> > +	u32 new;
> > +
> > +	/* If the secondary queue is empty, do what MCS does. */
> > +	if (node->locked <= 1)
> > +		return __try_clear_tail(lock, val, node);
> > +
> > +	/*
> > +	 * Try to update the tail value to the last node in the secondary queue.
> > +	 * If successful, pass the lock to the first thread in the secondary
> > +	 * queue. Doing those two actions effectively moves all nodes from the
> > +	 * secondary queue into the main one.
> > +	 */
> > +	tail_2nd = decode_tail(node->locked);
> > +	head_2nd = tail_2nd->next;
> > +	new = ((struct cna_node *)tail_2nd)->encoded_tail + _Q_LOCKED_VAL;
> > +
> > +	if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {
> > +		/*
> > +		 * Try to reset @next in tail_2nd to NULL, but no need to check
> > +		 * the result - if failed, a new successor has updated it.
> > +		 */
> 
> I think you actually have an ordering bug here; the load of head_2nd
> *must* happen before the atomic_try_cmpxchg(), otherwise it might
> observe the new next and clear a valid next pointer.
> 
> What would be the best fix for that; I'm thinking:
> 
> 	head_2nd = smp_load_acquire(&tail_2nd->next);
> 
> Will?

Hmm, given we've not passed the lock around yet; why wouldn't something
like this work:

	smp_store_release(&tail_2nd->next, NULL);

	if (!atomic_try_cmpxchg_relaxed(&lock, &val, new)) {
		tail_2nd->next = head_2nd;
		return false;
	}

The whole second queue is only ever modified by the lock owner, and that
is us, so we can pre-terminate the secondary queue (break the circular
link), try the cmpxchg and fix it back up when it fails.


> > +		cmpxchg_relaxed(&tail_2nd->next, head_2nd, NULL);
> > +		arch_mcs_pass_lock(&head_2nd->locked, 1);
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
