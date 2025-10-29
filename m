Return-Path: <linux-arch+bounces-14415-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE76C1CD0F
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 19:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 767814E0758
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 18:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EB53563EB;
	Wed, 29 Oct 2025 18:45:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9953563F3;
	Wed, 29 Oct 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763510; cv=none; b=r8L74rvqibM2K5bk481sk+Jjdb3sjcA9j69zApdPBTv079Kym/rYqcaZcTXewGXRCaYf1nfOslIkL5D7yh0PwiNSlEQ7Xq00m+7u00rBKkbbxlcIwpyiC2qEtRuBCtFLfnTu8R1AZ034SAwP/1sst0c5T4F+EuGhlXozcbJ+lLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763510; c=relaxed/simple;
	bh=S35Fm961GY2YlSo8uAUGRL5gwuLjqeaZeUi+ydZ6nRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyarhpXqZZHkwzk0nZTz68TNoC1dUMatpX3C2NRbe/MlspI5wyYzDKc++4dqFLMkpWxydOFGLePMEDf3F+ldcSeYgTASaeGZqVj6bWbXCW+FvbxeHAnppbT5+PDVAAFHCdWRVCC+9nWPEe6HjSeBWxu3Xu11bd2aK+IGIqb62uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 39E041608C8;
	Wed, 29 Oct 2025 18:45:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 8881018;
	Wed, 29 Oct 2025 18:44:57 +0000 (UTC)
Date: Wed, 29 Oct 2025 14:45:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann
 <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [patch V3 08/12] rseq: Implement time slice extension
 enforcement timer
Message-ID: <20251029144538.5eb5c772@gandalf.local.home>
In-Reply-To: <20251029130403.923191772@linutronix.de>
References: <20251029125514.496134233@linutronix.de>
	<20251029130403.923191772@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ptwwk4m8hbhzsxqoo5cwfwd4cz7ghnc3
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 8881018
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19JDM0v7jHtUmDmJ4SLbqYwfkLUzOp4lIs=
X-HE-Tag: 1761763497-913457
X-HE-Meta: U2FsdGVkX1+LpLZQLCQRUd8UBz/WIsR4X+8kjxCCHNCLpDg8Ev6f+AXGW/EGJGlFpw7aPAmHGOy7hpv6R/FqtK7+7U3YRJAVeKqz1cfQBmyAoaGBmhG7s4ZiPIcqb7qNex/VaCEX1sTNfkL0uik+2LPnsu0wY5QD9/J8Sop2BqB5BFTxXj6tHWu0SAWr/4SIEOvBfLc623Mej8HTGGzb/YKLy30zLIJlmo9x6kpVcdRqNQU2zBmDFsatH904udUqn/yVuPsnogXtcVwCpJ4seJerK/TaYB7LA26QEypxMB6aVNNAhnG3mtX31JKtYlm0

On Wed, 29 Oct 2025 14:22:26 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -86,8 +86,24 @@ static __always_inline bool rseq_slice_e
>  {
>  	return static_branch_likely(&rseq_slice_extension_key);
>  }
> +
> +extern unsigned int rseq_slice_ext_nsecs;
> +bool __rseq_arm_slice_extension_timer(void);
> +
> +static __always_inline bool rseq_arm_slice_extension_timer(void)
> +{
> +	if (!rseq_slice_extension_enabled())
> +		return false;
> +
> +	if (likely(!current->rseq.slice.state.granted))
> +		return false;
> +
> +	return __rseq_arm_slice_extension_timer();
> +}
> +
>  #else /* CONFIG_RSEQ_SLICE_EXTENSION */
>  static inline bool rseq_slice_extension_enabled(void) { return false; }
> +static inline bool rseq_arm_slice_extension_timer(void) { return false; }
>  #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
>  
>  bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
> @@ -542,17 +558,19 @@ static __always_inline void clear_tif_rs
>  static __always_inline bool
>  rseq_exit_to_user_mode_restart(struct pt_regs *regs, unsigned long ti_work)
>  {
> -	if (likely(!test_tif_rseq(ti_work)))
> -		return false;
> -
> -	if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
> -		current->rseq.event.slowpath = true;
> -		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> -		return true;
> +	if (unlikely(test_tif_rseq(ti_work))) {
> +		if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
> +			current->rseq.event.slowpath = true;
> +			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +			return true;

Just to make sure I understand this. By setting TIF_NOTIFY_RESUME and
returning true it can still comeback to set the timer?

I guess this also begs the question of if user space can use both the
restartable sequences at the same time as requesting an extended time slice?

> +		}
> +		clear_tif_rseq();
>  	}
> -
> -	clear_tif_rseq();
> -	return false;
> +	/*
> +	 * Arm the slice extension timer if nothing to do anymore and the
> +	 * task really goes out to user space.
> +	 */
> +	return rseq_arm_slice_extension_timer();
>  }
>  
>  #endif /* CONFIG_GENERIC_ENTRY */
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -89,9 +89,11 @@ union rseq_slice_state {
>  /**
>   * struct rseq_slice - Status information for rseq time slice extension
>   * @state:	Time slice extension state
> + * @expires:	The time when a grant expires
>   */
>  struct rseq_slice {
>  	union rseq_slice_state	state;
> +	u64			expires;
>  };
>  
>  /**
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -71,6 +71,8 @@
>  #define RSEQ_BUILD_SLOW_PATH
>  
>  #include <linux/debugfs.h>
> +#include <linux/hrtimer.h>
> +#include <linux/percpu.h>
>  #include <linux/prctl.h>
>  #include <linux/ratelimit.h>
>  #include <linux/rseq_entry.h>
> @@ -499,8 +501,78 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>  }
>  
>  #ifdef CONFIG_RSEQ_SLICE_EXTENSION
> +struct slice_timer {
> +	struct hrtimer	timer;
> +	void		*cookie;
> +};
> +
> +unsigned int rseq_slice_ext_nsecs __read_mostly = 30 * NSEC_PER_USEC;
> +static DEFINE_PER_CPU(struct slice_timer, slice_timer);
>  DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
>  
> +static enum hrtimer_restart rseq_slice_expired(struct hrtimer *tmr)
> +{
> +	struct slice_timer *st = container_of(tmr, struct slice_timer, timer);
> +
> +	if (st->cookie == current && current->rseq.slice.state.granted) {
> +		rseq_stat_inc(rseq_stats.s_expired);
> +		set_need_resched_current();
> +	}
> +	return HRTIMER_NORESTART;
> +}
> +
> +bool __rseq_arm_slice_extension_timer(void)
> +{
> +	struct slice_timer *st = this_cpu_ptr(&slice_timer);
> +	struct task_struct *curr = current;
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	/*
> +	 * This check prevents that a granted time slice extension exceeds

           This check prevents a granted time slice ...

> +	 * the maximum scheduling latency when the grant expired before
> +	 * going out to user space. Don't bother to clear the grant here,
> +	 * it will be cleaned up automatically before going out to user
> +	 * space.
> +	 */
> +	if ((unlikely(curr->rseq.slice.expires < ktime_get_mono_fast_ns()))) {
> +		set_need_resched_current();
> +		return true;
> +	}
> +
> +	/*
> +	 * Store the task pointer as a cookie for comparison in the timer
> +	 * function. This is safe as the timer is CPU local and cannot be
> +	 * in the expiry function at this point.
> +	 */

I'm just curious in this scenario:

  1) Task A requests an extension and is granted.
      st->cookie = Task A
      hrtimer_start();

  2) Before getting back to user space, a RT kernel thread wakes up and
     preempts Task A. Does this clear the timer?

  3) RT kernel thread finishes but then schedules Task B within the expiry.

  4) Task B requests an extension (assuming it had a short time slice that
     allowed it to end before the expiry of the original timer).

I guess it doesn't matter that st->cookie = Task B, as Task A was already
scheduled out. But would calling hrtimer_start() on an existing timer cause
any issue?

I guess it doesn't matter as it looks like the code in hrtimer_start() does
indeed remove an existing timer.

> +	st->cookie = curr;
> +	hrtimer_start(&st->timer, curr->rseq.slice.expires, HRTIMER_MODE_ABS_PINNED_HARD);
> +	/* Arm the syscall entry work */
> +	set_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
> +	return false;
> +}
> +
> +static void rseq_cancel_slice_extension_timer(void)
> +{
> +	struct slice_timer *st = this_cpu_ptr(&slice_timer);
> +
> +	/*
> +	 * st->cookie can be safely read as preemption is disabled and the
> +	 * timer is CPU local.
> +	 *
> +	 * As this is most probably the first expiring timer, the cancel is

           As this is probably the first ...

> +	 * expensive as it has to reprogram the hardware, but that's less
> +	 * expensive than going through a full hrtimer_interrupt() cycle
> +	 * for nothing.
> +	 *
> +	 * hrtimer_try_to_cancel() is sufficient here as the timer is CPU
> +	 * local and once the hrtimer code disabled interrupts the timer
> +	 * callback cannot be running.
> +	 */
> +	if (st->cookie == current)
> +		hrtimer_try_to_cancel(&st->timer);

If the above scenario did happen, the timer will go off as
st->cookie == current would likely be false?

Hmm, if it does go off and the task did schedule back in, would it get its
need_resched set? This is a very unlikely scenario thus I guess it doesn't
really matter.

I'm just thinking about corner cases and how it could affect this code and
possibly cause noticeable issues.

-- Steve


> +}
> +
>  static inline void rseq_slice_set_need_resched(struct task_struct *curr)
>  {
>  	/*
> @@ -558,10 +630,11 @@ void rseq_syscall_enter_work(long syscal
>  	rseq_stat_inc(rseq_stats.s_yielded);
>  
>  	/*
> -	 * Required to make set_tsk_need_resched() correct on PREEMPT[RT]
> -	 * kernels.
> +	 * Required to stabilize the per CPU timer pointer and to make
> +	 * set_tsk_need_resched() correct on PREEMPT[RT] kernels.
>  	 */
>  	scoped_guard(preempt) {
> +		rseq_cancel_slice_extension_timer();
>  		/*
>  		 * Now that preemption is disabled, quickly check whether
>  		 * the task was already rescheduled before arriving here.
> @@ -652,6 +725,31 @@ SYSCALL_DEFINE0(rseq_slice_yield)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SYSCTL
> +static const unsigned int rseq_slice_ext_nsecs_min = 10 * NSEC_PER_USEC;
> +static const unsigned int rseq_slice_ext_nsecs_max = 50 * NSEC_PER_USEC;
> +
> +static const struct ctl_table rseq_slice_ext_sysctl[] = {
> +	{
> +		.procname	= "rseq_slice_extension_nsec",
> +		.data		= &rseq_slice_ext_nsecs,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_douintvec_minmax,
> +		.extra1		= (unsigned int *)&rseq_slice_ext_nsecs_min,
> +		.extra2		= (unsigned int *)&rseq_slice_ext_nsecs_max,
> +	},
> +};
> +
> +static void rseq_slice_sysctl_init(void)
> +{
> +	if (rseq_slice_extension_enabled())
> +		register_sysctl_init("kernel", rseq_slice_ext_sysctl);
> +}
> +#else /* CONFIG_SYSCTL */
> +static inline void rseq_slice_sysctl_init(void) { }
> +#endif  /* !CONFIG_SYSCTL */
> +
>  static int __init rseq_slice_cmdline(char *str)
>  {
>  	bool on;
> @@ -664,4 +762,17 @@ static int __init rseq_slice_cmdline(cha
>  	return 1;
>  }
>  __setup("rseq_slice_ext=", rseq_slice_cmdline);
> +
> +static int __init rseq_slice_init(void)
> +{
> +	unsigned int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		hrtimer_setup(per_cpu_ptr(&slice_timer.timer, cpu), rseq_slice_expired,
> +			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
> +	}
> +	rseq_slice_sysctl_init();
> +	return 0;
> +}
> +device_initcall(rseq_slice_init);
>  #endif /* CONFIG_RSEQ_SLICE_EXTENSION */


