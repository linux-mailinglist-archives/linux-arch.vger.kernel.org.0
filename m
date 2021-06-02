Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519FA398A1A
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jun 2021 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFBM4o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Jun 2021 08:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhFBM4n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Jun 2021 08:56:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0A93613F1;
        Wed,  2 Jun 2021 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622638500;
        bh=Gb1jSzZgXPTfvYqSsFl4X7ozxzFoz0HLXy0fq/WZtik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJn2qqH7S+Lfu/yaubMzR6Uwb/4v7iZ7/BptH0vFpRYoC3Ii1N1EOpH/SMzxEzu6e
         HzlGNDuAsQ/Gkj0SPN6SPS8vw8LMD7UXQwgQxBu2iJmLfIYNDSHvEV1rsAU9UVqoZ+
         1jLjxaqpWXoZRrrQKKBWACOlg5jl7C2cuPnkLHuXE4ScYlLTLkvxcs6lvmdl4oHpn7
         3imfcxZH3xCYsrmNwXSvtbgq9Iwn8oXHS2Oj9IXV4tWcUxqnZmqmYsFpOvYth27mlj
         l6PjWykTq9Nft67NXXAjqj4S8sDRhyfVEUJjjq2KS7ooi4qop9WjYZVVrmo/e5zV0r
         bsXUQPRDlHpwg==
Date:   Wed, 2 Jun 2021 13:54:53 +0100
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
Subject: Re: [RFC][PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <20210602125452.GG30593@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YLXt+/Wr5/KWymPC@hirez.programming.kicks-ass.net>
 <YLYZv4v68OnAlx+3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLYZv4v68OnAlx+3@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On Tue, Jun 01, 2021 at 01:27:59PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 01, 2021 at 10:21:15AM +0200, Peter Zijlstra wrote:
> > 
> > Hi,
> > 
> > This here rewrites the core freezer to behave better wrt thawing. By
> > replacing PF_FROZEN with TASK_FROZEN, a special block state, it is
> > ensured frozen tasks stay frozen until woken and don't randomly wake up
> > early, as is currently possible.
> > 
> > As such, it does away with PF_FROZEN and PF_FREEZER_SKIP (yay).
> > 
> > It does however completely wreck kernel/cgroup/legacy_freezer.c and I've
> > not yet spend any time on trying to figure out that code, will do so
> > shortly.
> > 
> > Other than that, the freezer seems to work fine, I've tested it with:
> > 
> >   echo freezer > /sys/power/pm_test
> >   echo mem > /sys/power/state
> > 
> > Even while having a GDB session active, and that all works.
> > 
> > Another notable bit is in init/do_mounts_initrd.c; afaict that has been
> > 'broken' for quite a while and is simply removed.
> > 
> > Please have a look.
> > 
> > Somewhat-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> cgroup crud now compiles, also fixed some allmodconfig fails.

There's a lot here, but generally I really like the look of it, especially
making the "freezable" waits explicit. I've left a few comments below.

>  drivers/android/binder.c       |   4 +-
>  drivers/media/pci/pt3/pt3.c    |   4 +-
>  fs/cifs/inode.c                |   4 +-
>  fs/cifs/transport.c            |   5 +-
>  fs/coredump.c                  |   4 +-
>  fs/nfs/file.c                  |   3 +-
>  fs/nfs/inode.c                 |  12 +-
>  fs/nfs/nfs3proc.c              |   3 +-
>  fs/nfs/nfs4proc.c              |  14 +--
>  fs/nfs/nfs4state.c             |   3 +-
>  fs/nfs/pnfs.c                  |   4 +-
>  fs/xfs/xfs_trans_ail.c         |   8 +-
>  include/linux/completion.h     |   2 +
>  include/linux/freezer.h        | 244 ++---------------------------------------
>  include/linux/sched.h          |   9 +-
>  include/linux/sunrpc/sched.h   |   7 +-
>  include/linux/wait.h           |  40 ++++++-
>  init/do_mounts_initrd.c        |   7 +-
>  kernel/cgroup/legacy_freezer.c |  23 ++--
>  kernel/exit.c                  |   4 +-
>  kernel/fork.c                  |   4 +-
>  kernel/freezer.c               | 115 +++++++++++++------
>  kernel/futex.c                 |   4 +-
>  kernel/hung_task.c             |   4 +-
>  kernel/power/main.c            |   5 +-
>  kernel/power/process.c         |  10 +-
>  kernel/sched/completion.c      |  16 +++
>  kernel/sched/core.c            |   2 +-
>  kernel/signal.c                |  14 +--
>  kernel/time/hrtimer.c          |   4 +-
>  mm/khugepaged.c                |   4 +-
>  net/sunrpc/sched.c             |  12 +-
>  net/unix/af_unix.c             |   8 +-
>  33 files changed, 225 insertions(+), 381 deletions(-)

There's also Documentation/power/freezing-of-tasks.rst to update. I'm not
sure if fs/proc/array.c should be updated to display frozen tasks; I
couldn't see how that was useful, but thought I'd mention it anyway.

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2982cfab1ae9..bfadc1dbcf24 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -95,7 +95,12 @@ struct task_group;
>  #define TASK_WAKING			0x0200
>  #define TASK_NOLOAD			0x0400
>  #define TASK_NEW			0x0800
> -#define TASK_STATE_MAX			0x1000
> +#define TASK_FREEZABLE			0x1000
> +#define __TASK_FREEZABLE_UNSAFE		0x2000

Give that this is only needed to avoid lockdep checks, maybe we should avoid
allocating the bit if lockdep is not enabled? Otherwise, people might start
to use it for other things.

> +#define TASK_FROZEN			0x4000
> +#define TASK_STATE_MAX			0x8000
> +
> +#define TASK_FREEZABLE_UNSAFE		(TASK_FREEZABLE | __TASK_FREEZABLE_UNSAFE)

We probably want to preserve the "DO NOT ADD ANY NEW CALLERS OF THIS STATE"
comment for the unsafe stuff.

> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index dc520f01f99d..df235fba6989 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -13,8 +13,8 @@
>  #include <linux/kthread.h>
>  
>  /* total number of freezing conditions in effect */
> -atomic_t system_freezing_cnt = ATOMIC_INIT(0);
> -EXPORT_SYMBOL(system_freezing_cnt);
> +DEFINE_STATIC_KEY_FALSE(freezer_active);
> +EXPORT_SYMBOL(freezer_active);
>  
>  /* indicate whether PM freezing is in effect, protected by
>   * system_transition_mutex
> @@ -29,7 +29,7 @@ static DEFINE_SPINLOCK(freezer_lock);
>   * freezing_slow_path - slow path for testing whether a task needs to be frozen
>   * @p: task to be tested
>   *
> - * This function is called by freezing() if system_freezing_cnt isn't zero
> + * This function is called by freezing() if freezer_active isn't zero
>   * and tests whether @p needs to enter and stay in frozen state.  Can be
>   * called under any context.  The freezers are responsible for ensuring the
>   * target tasks see the updated state.
> @@ -52,41 +52,67 @@ bool freezing_slow_path(struct task_struct *p)
>  }
>  EXPORT_SYMBOL(freezing_slow_path);
>  
> +/* Recursion relies on tail-call optimization to not blow away the stack */
> +static bool __frozen(struct task_struct *p)
> +{
> +	if (p->state == TASK_FROZEN)
> +		return true;

READ_ONCE()?

> +
> +	/*
> +	 * If stuck in TRACED, and the ptracer is FROZEN, we're frozen too.
> +	 */
> +	if (task_is_traced(p))
> +		return frozen(rcu_dereference(p->parent));
> +
> +	/*
> +	 * If stuck in STOPPED and the parent is FROZEN, we're frozen too.
> +	 */
> +	if (task_is_stopped(p))
> +		return frozen(rcu_dereference(p->real_parent));

This looks convincing, but I really can't tell if we're missing anything.

> +static bool __freeze_task(struct task_struct *p)
> +{
> +	unsigned long flags;
> +	unsigned int state;
> +	bool frozen = false;
> +
> +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> +	state = READ_ONCE(p->state);
> +	if (state & TASK_FREEZABLE) {
> +		/*
> +		 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE,
> +		 * since they can suffer spurious wakeups.
> +		 */
> +		WARN_ON_ONCE(!(state & TASK_NORMAL));
> +
> +#ifdef CONFIG_LOCKDEP
> +		/*
> +		 * It's dangerous to freeze with locks held; there be dragons there.
> +		 */
> +		if (!(state & __TASK_FREEZABLE_UNSAFE))
> +			WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> +#endif
> +
> +		p->state = TASK_FROZEN;
> +		frozen = true;
> +	}
> +	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> +
> +	return frozen;
> +}
> +
>  /**
>   * freeze_task - send a freeze request to given task
>   * @p: task to send the request to
> @@ -116,20 +173,8 @@ bool freeze_task(struct task_struct *p)
>  {
>  	unsigned long flags;
>  
> -	/*
> -	 * This check can race with freezer_do_not_count, but worst case that
> -	 * will result in an extra wakeup being sent to the task.  It does not
> -	 * race with freezer_count(), the barriers in freezer_count() and
> -	 * freezer_should_skip() ensure that either freezer_count() sees
> -	 * freezing == true in try_to_freeze() and freezes, or
> -	 * freezer_should_skip() sees !PF_FREEZE_SKIP and freezes the task
> -	 * normally.
> -	 */
> -	if (freezer_should_skip(p))
> -		return false;
> -
>  	spin_lock_irqsave(&freezer_lock, flags);
> -	if (!freezing(p) || frozen(p)) {
> +	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
>  		spin_unlock_irqrestore(&freezer_lock, flags);
>  		return false;
>  	}

I've been trying to figure out how this serialises with ttwu(), given that
frozen(p) will go and read p->state. I suppose it works out because only the
freezer can wake up tasks from the FROZEN state, but it feels a bit brittle.

> @@ -137,7 +182,7 @@ bool freeze_task(struct task_struct *p)
>  	if (!(p->flags & PF_KTHREAD))
>  		fake_signal_wake_up(p);
>  	else
> -		wake_up_state(p, TASK_INTERRUPTIBLE);
> +		wake_up_state(p, TASK_INTERRUPTIBLE); // TASK_NORMAL ?!?
>  
>  	spin_unlock_irqrestore(&freezer_lock, flags);
>  	return true;
> @@ -148,8 +193,8 @@ void __thaw_task(struct task_struct *p)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&freezer_lock, flags);
> -	if (frozen(p))
> -		wake_up_process(p);
> +	WARN_ON_ONCE(freezing(p));
> +	wake_up_state(p, TASK_FROZEN | TASK_NORMAL);

Why do we need TASK_NORMAL here?

Will
