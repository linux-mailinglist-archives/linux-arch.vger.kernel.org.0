Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F96393102
	for <lists+linux-arch@lfdr.de>; Thu, 27 May 2021 16:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhE0Oii (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 May 2021 10:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233092AbhE0Oih (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 May 2021 10:38:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92D22611AE;
        Thu, 27 May 2021 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622126224;
        bh=j3oO2WMkdw8E5RxV/xTsNs7cKG+L3BAICIgf/n3PQ00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tod3tbhDBUe2F+HRQJn/kDud2qI4/v+oiF0PpkgOzmdQxk+xKBIICLBp3st2ukXhM
         T+gTxGYckUjj6rZfj0aU0IXKarWsAx3pTJNneZO9A+7VyG4f6zBw+K2GxHHoRNieVt
         NsZUDc0FlU3iQRl/+gVCfaq8oifIncLwmPNNHzw5JPWeXMOCvegxEOuitrBhp/PJxw
         PpsqOVjLcOKg5h+HUSJ/NtTMYvKP+KHet1yF48zneltYVtumLwGGX4YOmacQN7KfTi
         JWvVx5YKjqAMuEiBPS/W/tkSHFR1w8a42nbSqGgEnsat4mec/rMwP0qnYvmUyCFwg5
         HbvOlCerYwNiQ==
Date:   Thu, 27 May 2021 15:36:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 16/22] sched: Defer wakeup in ttwu() for unschedulable
 frozen tasks
Message-ID: <20210527143657.GA23086@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YK+oSPlNQJKiMYYc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK+oSPlNQJKiMYYc@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 27, 2021 at 04:10:16PM +0200, Peter Zijlstra wrote:
> On Tue, May 25, 2021 at 04:14:26PM +0100, Will Deacon wrote:
> > diff --git a/kernel/freezer.c b/kernel/freezer.c
> > index dc520f01f99d..8f3d950c2a87 100644
> > --- a/kernel/freezer.c
> > +++ b/kernel/freezer.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/freezer.h>
> >  #include <linux/kthread.h>
> > +#include <linux/mmu_context.h>
> >  
> >  /* total number of freezing conditions in effect */
> >  atomic_t system_freezing_cnt = ATOMIC_INIT(0);
> > @@ -146,9 +147,16 @@ bool freeze_task(struct task_struct *p)
> >  void __thaw_task(struct task_struct *p)
> >  {
> >  	unsigned long flags;
> > +	const struct cpumask *mask = task_cpu_possible_mask(p);
> >  
> >  	spin_lock_irqsave(&freezer_lock, flags);
> > -	if (frozen(p))
> > +	/*
> > +	 * Wake up frozen tasks. On asymmetric systems where tasks cannot
> > +	 * run on all CPUs, ttwu() may have deferred a wakeup generated
> > +	 * before thaw_secondary_cpus() had completed so we generate
> > +	 * additional wakeups here for tasks in the PF_FREEZER_SKIP state.
> > +	 */
> > +	if (frozen(p) || (frozen_or_skipped(p) && mask != cpu_possible_mask))
> >  		wake_up_process(p);
> >  	spin_unlock_irqrestore(&freezer_lock, flags);
> >  }
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 42e2aecf087c..6cb9677d635a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3529,6 +3529,19 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  	if (!(p->state & state))
> >  		goto unlock;
> >  
> > +#ifdef CONFIG_FREEZER
> > +	/*
> > +	 * If we're going to wake up a thread which may be frozen, then
> > +	 * we can only do so if we have an active CPU which is capable of
> > +	 * running it. This may not be the case when resuming from suspend,
> > +	 * as the secondary CPUs may not yet be back online. See __thaw_task()
> > +	 * for the actual wakeup.
> > +	 */
> > +	if (unlikely(frozen_or_skipped(p)) &&
> > +	    !cpumask_intersects(cpu_active_mask, task_cpu_possible_mask(p)))
> > +		goto unlock;
> > +#endif
> > +
> >  	trace_sched_waking(p);
> >  
> >  	/* We're going to change ->state: */
> 
> OK, I really hate this. This is slowing down the very hot wakeup path
> for the silly freezer that *never* happens. Let me try and figure out if
> there's another option.

I'm definitely open to alternative suggestions here. An easy thing to do
would be move the 'flags' field up in task_struct so that the previous
access to state pulls it in for us.

Will
