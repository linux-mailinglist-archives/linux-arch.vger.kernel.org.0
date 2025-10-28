Return-Path: <linux-arch+bounces-14382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D9C15059
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 15:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35B7B351828
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D2A226CF9;
	Tue, 28 Oct 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBRPGeiy"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293418626;
	Tue, 28 Oct 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660034; cv=none; b=mKn4eQjOKBlDdr3oaUcsowb2LbIIy/mXhpclss/qYE/fktgK2eSDUIR7v+8CC69enkMLtKuRC5xZa2Tul3XUAeoqcdGPyGjxR0meKl+PrmPbpdY/KtZM2Zx8pIAcHUe+GNyGjkS7xhIwXBVp9mRLDKDfeTVhmL4FLqucUiTRLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660034; c=relaxed/simple;
	bh=MF/2zsZwtCVjQVdBsn7UVVx9xBhDIK+KrSqUNMSbxwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnszsC+RP47NG5/ONHgfgqgDuyZmMaFUDRUC/x5XahgFYjMLpoY4GRLTrSy1TmEWTYvb1sx08EIpHvNWPA8aZWc2LspgTOdVIqz0dCHL/UqQ2qKPwEkKmtTAv4WUoMcmHxhzqV0rle1AfoiREI3KfxhfDHu60M2/RH87hyk3Ubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBRPGeiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9390C116C6;
	Tue, 28 Oct 2025 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761660033;
	bh=MF/2zsZwtCVjQVdBsn7UVVx9xBhDIK+KrSqUNMSbxwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBRPGeiy1Xn7eADQ9yFvkjIS2p83OMRe4k2CO4ITc0ALWFN0ZWRqZGjvsq0KHLGHX
	 9cLYR4EEJw7n2OOILsuLBxlnyUxNKQ48TBEmQOfsOJWlMu7MQczs8PAvuoeQ7dv4ga
	 VOOh+zSbwQI9UVXLYMTTaAF8VC5Qe0AH08UMx6o59oif+TOluzOhoNUJlPqWrkWdWa
	 F3YMSrmA8q04Tc3o7V5G0rOnVvXrSlmYuCHYUdaC1/9bEi1kSPQjNs6B/CMP7UMuA7
	 kBZG8J5QQqHSS4JWOSkiN2pZrTn7EOaJWqEI8O7YB913GvijwyU/Jjvqzu6dZc0XeA
	 6pjFmq9Y38R2g==
Date: Tue, 28 Oct 2025 15:00:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 23/29] context-tracking: Introduce work deferral
 infrastructure
Message-ID: <aQDMfu0tzecFzoGr@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-24-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251010153839.151763-24-vschneid@redhat.com>

Le Fri, Oct 10, 2025 at 05:38:33PM +0200, Valentin Schneider a écrit :
> smp_call_function() & friends have the unfortunate habit of sending IPIs to
> isolated, NOHZ_FULL, in-userspace CPUs, as they blindly target all online
> CPUs.
> 
> Some callsites can be bent into doing the right, such as done by commit:
> 
>   cc9e303c91f5 ("x86/cpu: Disable frequency requests via aperfmperf IPI for nohz_full CPUs")
> 
> Unfortunately, not all SMP callbacks can be omitted in this
> fashion. However, some of them only affect execution in kernelspace, which
> means they don't have to be executed *immediately* if the target CPU is in
> userspace: stashing the callback and executing it upon the next kernel entry
> would suffice. x86 kernel instruction patching or kernel TLB invalidation
> are prime examples of it.
> 
> Reduce the RCU dynticks counter width to free up some bits to be used as a
> deferred callback bitmask. Add some build-time checks to validate that
> setup.
> 
> Presence of CT_RCU_WATCHING in the ct_state prevents queuing deferred work.
> 
> Later commits introduce the bit:callback mappings.
> 
> Link: https://lore.kernel.org/all/20210929151723.162004989@infradead.org/
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  arch/Kconfig                                 |  9 +++
>  arch/x86/Kconfig                             |  1 +
>  arch/x86/include/asm/context_tracking_work.h | 16 +++++
>  include/linux/context_tracking.h             | 21 ++++++
>  include/linux/context_tracking_state.h       | 30 ++++++---
>  include/linux/context_tracking_work.h        | 26 ++++++++
>  kernel/context_tracking.c                    | 69 +++++++++++++++++++-
>  kernel/time/Kconfig                          |  5 ++
>  8 files changed, 165 insertions(+), 12 deletions(-)
>  create mode 100644 arch/x86/include/asm/context_tracking_work.h
>  create mode 100644 include/linux/context_tracking_work.h
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index d1b4ffd6e0856..a33229e017467 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -968,6 +968,15 @@ config HAVE_CONTEXT_TRACKING_USER_OFFSTACK
>  	  - No use of instrumentation, unless instrumentation_begin() got
>  	    called.
>  
> +config HAVE_CONTEXT_TRACKING_WORK
> +	bool
> +	help
> +	  Architecture supports deferring work while not in kernel context.
> +	  This is especially useful on setups with isolated CPUs that might
> +	  want to avoid being interrupted to perform housekeeping tasks (for
> +	  ex. TLB invalidation or icache invalidation). The housekeeping
> +	  operations are performed upon re-entering the kernel.
> +
>  config HAVE_TIF_NOHZ
>  	bool
>  	help
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 05880301212e3..3f1557b7acd8f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -222,6 +222,7 @@ config X86
>  	select HAVE_CMPXCHG_LOCAL
>  	select HAVE_CONTEXT_TRACKING_USER		if X86_64
>  	select HAVE_CONTEXT_TRACKING_USER_OFFSTACK	if HAVE_CONTEXT_TRACKING_USER
> +	select HAVE_CONTEXT_TRACKING_WORK		if X86_64
>  	select HAVE_C_RECORDMCOUNT
>  	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
>  	select HAVE_OBJTOOL_NOP_MCOUNT		if HAVE_OBJTOOL_MCOUNT
> diff --git a/arch/x86/include/asm/context_tracking_work.h b/arch/x86/include/asm/context_tracking_work.h
> new file mode 100644
> index 0000000000000..5f3b2d0977235
> --- /dev/null
> +++ b/arch/x86/include/asm/context_tracking_work.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_CONTEXT_TRACKING_WORK_H
> +#define _ASM_X86_CONTEXT_TRACKING_WORK_H
> +
> +static __always_inline void arch_context_tracking_work(enum ct_work work)
> +{
> +	switch (work) {
> +	case CT_WORK_n:
> +		// Do work...
> +		break;
> +	case CT_WORK_MAX:
> +		WARN_ON_ONCE(true);
> +	}
> +}
> +
> +#endif
> diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
> index af9fe87a09225..0b0faa040e9b5 100644
> --- a/include/linux/context_tracking.h
> +++ b/include/linux/context_tracking.h
> @@ -5,6 +5,7 @@
>  #include <linux/sched.h>
>  #include <linux/vtime.h>
>  #include <linux/context_tracking_state.h>
> +#include <linux/context_tracking_work.h>
>  #include <linux/instrumentation.h>
>  
>  #include <asm/ptrace.h>
> @@ -137,6 +138,26 @@ static __always_inline unsigned long ct_state_inc(int incby)
>  	return raw_atomic_add_return(incby, this_cpu_ptr(&context_tracking.state));
>  }
>  
> +#ifdef CONFIG_CONTEXT_TRACKING_WORK
> +static __always_inline unsigned long ct_state_inc_clear_work(int incby)
> +{
> +	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
> +	unsigned long new, old, state;
> +
> +	state = arch_atomic_read(&ct->state);
> +	do {
> +		old = state;
> +		new = old & ~CT_WORK_MASK;
> +		new += incby;
> +		state = arch_atomic_cmpxchg(&ct->state, old, new);
> +	} while (old != state);
> +
> +	return new;
> +}
> +#else
> +#define ct_state_inc_clear_work(x) ct_state_inc(x)
> +#endif
> +
>  static __always_inline bool warn_rcu_enter(void)
>  {
>  	bool ret = false;
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index 0b81248aa03e2..d2c302133672f 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -5,6 +5,7 @@
>  #include <linux/percpu.h>
>  #include <linux/static_key.h>
>  #include <linux/context_tracking_irq.h>
> +#include <linux/context_tracking_work.h>
>  
>  /* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
>  #define CT_NESTING_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
> @@ -39,16 +40,19 @@ struct context_tracking {
>  };
>  
>  /*
> - * We cram two different things within the same atomic variable:
> + * We cram up to three different things within the same atomic variable:
>   *
> - *                     CT_RCU_WATCHING_START  CT_STATE_START
> - *                                |                |
> - *                                v                v
> - *     MSB [ RCU watching counter ][ context_state ] LSB
> - *         ^                       ^
> - *         |                       |
> - * CT_RCU_WATCHING_END        CT_STATE_END
> + *                     CT_RCU_WATCHING_START                  CT_STATE_START
> + *                                |         CT_WORK_START          |
> + *                                |               |                |
> + *                                v               v                v
> + *     MSB [ RCU watching counter ][ context work ][ context_state ] LSB
> + *         ^                       ^               ^
> + *         |                       |               |
> + *         |                  CT_WORK_END          |
> + * CT_RCU_WATCHING_END                        CT_STATE_END
>   *
> + * The [ context work ] region spans 0 bits if CONFIG_CONTEXT_WORK=n
>   * Bits are used from the LSB upwards, so unused bits (if any) will always be in
>   * upper bits of the variable.
>   */
> @@ -59,18 +63,24 @@ struct context_tracking {
>  #define CT_STATE_START 0
>  #define CT_STATE_END   (CT_STATE_START + CT_STATE_WIDTH - 1)
>  
> -#define CT_RCU_WATCHING_MAX_WIDTH (CT_SIZE - CT_STATE_WIDTH)
> +#define CT_WORK_WIDTH (IS_ENABLED(CONFIG_CONTEXT_TRACKING_WORK) ? CT_WORK_MAX_OFFSET : 0)
> +#define	CT_WORK_START (CT_STATE_END + 1)
> +#define CT_WORK_END   (CT_WORK_START + CT_WORK_WIDTH - 1)
> +
> +#define CT_RCU_WATCHING_MAX_WIDTH (CT_SIZE - CT_WORK_WIDTH - CT_STATE_WIDTH)
>  #define CT_RCU_WATCHING_WIDTH     (IS_ENABLED(CONFIG_RCU_DYNTICKS_TORTURE) ? 2 : CT_RCU_WATCHING_MAX_WIDTH)
> -#define CT_RCU_WATCHING_START     (CT_STATE_END + 1)
> +#define CT_RCU_WATCHING_START     (CT_WORK_END + 1)
>  #define CT_RCU_WATCHING_END       (CT_RCU_WATCHING_START + CT_RCU_WATCHING_WIDTH - 1)
>  #define CT_RCU_WATCHING           BIT(CT_RCU_WATCHING_START)
>  
>  #define CT_STATE_MASK        GENMASK(CT_STATE_END,        CT_STATE_START)
> +#define CT_WORK_MASK         GENMASK(CT_WORK_END,         CT_WORK_START)
>  #define CT_RCU_WATCHING_MASK GENMASK(CT_RCU_WATCHING_END, CT_RCU_WATCHING_START)
>  
>  #define CT_UNUSED_WIDTH (CT_RCU_WATCHING_MAX_WIDTH - CT_RCU_WATCHING_WIDTH)
>  
>  static_assert(CT_STATE_WIDTH        +
> +	      CT_WORK_WIDTH         +
>  	      CT_RCU_WATCHING_WIDTH +
>  	      CT_UNUSED_WIDTH       ==
>  	      CT_SIZE);
> diff --git a/include/linux/context_tracking_work.h b/include/linux/context_tracking_work.h
> new file mode 100644
> index 0000000000000..c68245f8d77c5
> --- /dev/null
> +++ b/include/linux/context_tracking_work.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CONTEXT_TRACKING_WORK_H
> +#define _LINUX_CONTEXT_TRACKING_WORK_H
> +
> +#include <linux/bitops.h>
> +
> +enum {
> +	CT_WORK_n_OFFSET,
> +	CT_WORK_MAX_OFFSET
> +};
> +
> +enum ct_work {
> +	CT_WORK_n        = BIT(CT_WORK_n_OFFSET),
> +	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
> +};
> +
> +#include <asm/context_tracking_work.h>
> +
> +#ifdef CONFIG_CONTEXT_TRACKING_WORK
> +extern bool ct_set_cpu_work(unsigned int cpu, enum ct_work work);
> +#else
> +static inline bool
> +ct_set_cpu_work(unsigned int cpu, unsigned int work) { return false; }
> +#endif
> +
> +#endif
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index fb5be6e9b423f..3238bb1f41ff4 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -72,6 +72,70 @@ static __always_inline void rcu_task_trace_heavyweight_exit(void)
>  #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
>  }
>  
> +#ifdef CONFIG_CONTEXT_TRACKING_WORK
> +static noinstr void ct_work_flush(unsigned long seq)
> +{
> +	int bit;
> +
> +	seq = (seq & CT_WORK_MASK) >> CT_WORK_START;
> +
> +	/*
> +	 * arch_context_tracking_work() must be noinstr, non-blocking,
> +	 * and NMI safe.
> +	 */
> +	for_each_set_bit(bit, &seq, CT_WORK_MAX)
> +		arch_context_tracking_work(BIT(bit));
> +}
> +
> +/**
> + * ct_set_cpu_work - set work to be run at next kernel context entry
> + *
> + * If @cpu is not currently executing in kernelspace, it will execute the
> + * callback mapped to @work (see arch_context_tracking_work()) at its next
> + * entry into ct_kernel_enter_state().
> + *
> + * If it is already executing in kernelspace, this will be a no-op.
> + */
> +bool ct_set_cpu_work(unsigned int cpu, enum ct_work work)
> +{
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> +	unsigned int old;
> +	bool ret = false;
> +
> +	if (!ct->active)
> +		return false;
> +
> +	preempt_disable();
> +
> +	old = atomic_read(&ct->state);
> +
> +	/*
> +	 * The work bit must only be set if the target CPU is not executing
> +	 * in kernelspace.
> +	 * CT_RCU_WATCHING is used as a proxy for that - if the bit is set, we
> +	 * know for sure the CPU is executing in the kernel whether that be in
> +	 * NMI, IRQ or process context.
> +	 * Set CT_RCU_WATCHING here and let the cmpxchg do the check for us;
> +	 * the state could change between the atomic_read() and the cmpxchg().
> +	 */
> +	old |= CT_RCU_WATCHING;

Most of the time, the task should be either idle or in userspace. I'm still not
sure why you start with a bet that the CPU is in the kernel with RCU watching.

> +	/*
> +	 * Try setting the work until either
> +	 * - the target CPU has entered kernelspace
> +	 * - the work has been set
> +	 */
> +	do {
> +		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_START));
> +	} while (!ret && !(old & CT_RCU_WATCHING));

So this applies blindly to idle as well, right? It should work but note that
idle entry code before RCU watches is also fragile.

The rest looks good.

Thanks!


> +
> +	preempt_enable();
> +	return ret;
> +}
> +#else
> +static __always_inline void ct_work_flush(unsigned long work) { }
> +static __always_inline void ct_work_clear(struct context_tracking *ct) { }
> +#endif
> +
>  /*
>   * Record entry into an extended quiescent state.  This is only to be
>   * called when not already in an extended quiescent state, that is,
> @@ -88,7 +152,7 @@ static noinstr void ct_kernel_exit_state(int offset)
>  	rcu_task_trace_heavyweight_enter();  // Before CT state update!
>  	// RCU is still watching.  Better not be in extended quiescent state!
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !rcu_is_watching_curr_cpu());
> -	(void)ct_state_inc(offset);
> +	(void)ct_state_inc_clear_work(offset);
>  	// RCU is no longer watching.
>  }
>  
> @@ -99,7 +163,7 @@ static noinstr void ct_kernel_exit_state(int offset)
>   */
>  static noinstr void ct_kernel_enter_state(int offset)
>  {
> -	int seq;
> +	unsigned long seq;
>  
>  	/*
>  	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
> @@ -107,6 +171,7 @@ static noinstr void ct_kernel_enter_state(int offset)
>  	 * critical section.
>  	 */
>  	seq = ct_state_inc(offset);
> +	ct_work_flush(seq);
>  	// RCU is now watching.  Better not be in an extended quiescent state!
>  	rcu_task_trace_heavyweight_exit();  // After CT state update!
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & CT_RCU_WATCHING));
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index 7c6a52f7836ce..1a0c027aad141 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -181,6 +181,11 @@ config CONTEXT_TRACKING_USER_FORCE
>  	  Say N otherwise, this option brings an overhead that you
>  	  don't want in production.
>  
> +config CONTEXT_TRACKING_WORK
> +	bool
> +	depends on HAVE_CONTEXT_TRACKING_WORK && CONTEXT_TRACKING_USER
> +	default y
> +
>  config NO_HZ
>  	bool "Old Idle dynticks config"
>  	help
> -- 
> 2.51.0
> 

-- 
Frederic Weisbecker
SUSE Labs

