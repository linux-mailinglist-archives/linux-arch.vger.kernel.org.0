Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874CF467BC7
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhLCQxs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 11:53:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44044 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382133AbhLCQxr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 11:53:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF76AB8282E;
        Fri,  3 Dec 2021 16:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B076C53FAD;
        Fri,  3 Dec 2021 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638550220;
        bh=NvqpCn6gmzVGbROFmIAFiwMxY9P9P62fl6FU57E57u8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=COwM0Fwa2n2sP4Zp/2KdA2kD/7FRLAgWwswfbQGVE019al/2E72S0I6zxhZgmnN8x
         o9TLGkkgNbsZPJrdMm3Lnk3KasjDuoL6FVHR2P8ZK/PnX3M7IPaVrT9SFbAkcs1lek
         ipBvK95kmlmGAN5i1R0/QXrvlDO1dC30bTlg6Yhb+vqw5IteUj/f0vosDsJPLuHYX7
         DItfJU9A90tKRt07eZgqN1U8CGUa1aFK9xoIvjFSRdB/Adx782GperYpgg70HVzmhM
         RhK2duaAxcQikcnj6poZp+E5jOQoux+FWJFSIFzaXCQPWtB/4ue8WRzFjQFJr4+QLJ
         ngvJIJmM5F1eQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 370875C02A9; Fri,  3 Dec 2021 08:50:20 -0800 (PST)
Date:   Fri, 3 Dec 2021 08:50:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v3 04/25] kcsan: Add core support for a subset of weak
 memory modeling
Message-ID: <20211203165020.GR641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211130114433.2580590-1-elver@google.com>
 <20211130114433.2580590-5-elver@google.com>
 <YanbzWyhR0LwdinE@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YanbzWyhR0LwdinE@elver.google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 03, 2021 at 09:56:45AM +0100, Marco Elver wrote:
> On Tue, Nov 30, 2021 at 12:44PM +0100, Marco Elver wrote:
> [...]
> > v3:
> > * Remove kcsan_noinstr hackery, since we now try to avoid adding any
> >   instrumentation to .noinstr.text in the first place.
> [...]
> 
> I missed some cleanups after changes from v2 to v3 -- the below cleanup
> is missing.
> 
> Full replacement patch attached.

I pulled this into -rcu with the other patches from your v3 post, thank
you all!

							Thanx, Paul

> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 2254cb75cbb0..916060913966 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -12,7 +12,6 @@
>  #include <linux/delay.h>
>  #include <linux/export.h>
>  #include <linux/init.h>
> -#include <linux/instrumentation.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/moduleparam.h>
> @@ -21,8 +20,6 @@
>  #include <linux/sched.h>
>  #include <linux/uaccess.h>
>  
> -#include <asm/sections.h>
> -
>  #include "encoding.h"
>  #include "kcsan.h"
>  #include "permissive.h"
> @@ -1086,9 +1083,7 @@ noinline void __tsan_func_entry(void *call_pc)
>  	if (!IS_ENABLED(CONFIG_KCSAN_WEAK_MEMORY))
>  		return;
>  
> -	instrumentation_begin();
>  	add_kcsan_stack_depth(1);
> -	instrumentation_end();
>  }
>  EXPORT_SYMBOL(__tsan_func_entry);
>  
> @@ -1100,7 +1095,6 @@ noinline void __tsan_func_exit(void)
>  	if (!IS_ENABLED(CONFIG_KCSAN_WEAK_MEMORY))
>  		return;
>  
> -	instrumentation_begin();
>  	reorder_access = get_reorder_access(get_ctx());
>  	if (!reorder_access)
>  		goto out;
> @@ -1120,7 +1114,6 @@ noinline void __tsan_func_exit(void)
>  	}
>  out:
>  	add_kcsan_stack_depth(-1);
> -	instrumentation_end();
>  }
>  EXPORT_SYMBOL(__tsan_func_exit);
>  

> >From 7ac337afb7bec3cc5c5bd5e4155b08bdb554bc7d Mon Sep 17 00:00:00 2001
> From: Marco Elver <elver@google.com>
> Date: Thu, 5 Aug 2021 14:57:45 +0200
> Subject: [PATCH v4 04/25] kcsan: Add core support for a subset of weak memory
>  modeling
> 
> Add support for modeling a subset of weak memory, which will enable
> detection of a subset of data races due to missing memory barriers.
> 
> KCSAN's approach to detecting missing memory barriers is based on
> modeling access reordering, and enabled if `CONFIG_KCSAN_WEAK_MEMORY=y`,
> which depends on `CONFIG_KCSAN_STRICT=y`. The feature can be enabled or
> disabled at boot and runtime via the `kcsan.weak_memory` boot parameter.
> 
> Each memory access for which a watchpoint is set up, is also selected
> for simulated reordering within the scope of its function (at most 1
> in-flight access).
> 
> We are limited to modeling the effects of "buffering" (delaying the
> access), since the runtime cannot "prefetch" accesses (therefore no
> acquire modeling). Once an access has been selected for reordering, it
> is checked along every other access until the end of the function scope.
> If an appropriate memory barrier is encountered, the access will no
> longer be considered for reordering.
> 
> When the result of a memory operation should be ordered by a barrier,
> KCSAN can then detect data races where the conflict only occurs as a
> result of a missing barrier due to reordering accesses.
> 
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v4:
> * Remove redundant instrumentation_begin/end() now that kcsan_noinstr no
>   longer exists.
> 
> v3:
> * Remove kcsan_noinstr hackery, since we now try to avoid adding any
>   instrumentation to .noinstr.text in the first place.
> * Restrict config WEAK_MEMORY to only be enabled with tooling where
>   we actually remove instrumentation from noinstr.
> * Don't define kcsan_weak_memory bool if !KCSAN_WEAK_MEMORY.
> 
> v2:
> * Define kcsan_noinstr as noinline if we rely on objtool nop'ing out
>   calls, to avoid things like LTO inlining it.
> ---
>  include/linux/kcsan-checks.h |  10 +-
>  include/linux/kcsan.h        |  10 +-
>  include/linux/sched.h        |   3 +
>  kernel/kcsan/core.c          | 202 ++++++++++++++++++++++++++++++++---
>  lib/Kconfig.kcsan            |  20 ++++
>  scripts/Makefile.kcsan       |   9 +-
>  6 files changed, 235 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> index 5f5965246877..a1c6a89fde71 100644
> --- a/include/linux/kcsan-checks.h
> +++ b/include/linux/kcsan-checks.h
> @@ -99,7 +99,15 @@ void kcsan_set_access_mask(unsigned long mask);
>  
>  /* Scoped access information. */
>  struct kcsan_scoped_access {
> -	struct list_head list;
> +	union {
> +		struct list_head list; /* scoped_accesses list */
> +		/*
> +		 * Not an entry in scoped_accesses list; stack depth from where
> +		 * the access was initialized.
> +		 */
> +		int stack_depth;
> +	};
> +
>  	/* Access information. */
>  	const volatile void *ptr;
>  	size_t size;
> diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
> index 13cef3458fed..c07c71f5ba4f 100644
> --- a/include/linux/kcsan.h
> +++ b/include/linux/kcsan.h
> @@ -49,8 +49,16 @@ struct kcsan_ctx {
>  	 */
>  	unsigned long access_mask;
>  
> -	/* List of scoped accesses. */
> +	/* List of scoped accesses; likely to be empty. */
>  	struct list_head scoped_accesses;
> +
> +#ifdef CONFIG_KCSAN_WEAK_MEMORY
> +	/*
> +	 * Scoped access for modeling access reordering to detect missing memory
> +	 * barriers; only keep 1 to keep fast-path complexity manageable.
> +	 */
> +	struct kcsan_scoped_access reorder_access;
> +#endif
>  };
>  
>  /**
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 78c351e35fec..0cd40b010487 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1339,6 +1339,9 @@ struct task_struct {
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	struct irqtrace_events		kcsan_save_irqtrace;
>  #endif
> +#ifdef CONFIG_KCSAN_WEAK_MEMORY
> +	int				kcsan_stack_depth;
> +#endif
>  #endif
>  
>  #if IS_ENABLED(CONFIG_KUNIT)
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index bd359f8ee63a..481f8a524089 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -40,6 +40,13 @@ module_param_named(udelay_interrupt, kcsan_udelay_interrupt, uint, 0644);
>  module_param_named(skip_watch, kcsan_skip_watch, long, 0644);
>  module_param_named(interrupt_watcher, kcsan_interrupt_watcher, bool, 0444);
>  
> +#ifdef CONFIG_KCSAN_WEAK_MEMORY
> +static bool kcsan_weak_memory = true;
> +module_param_named(weak_memory, kcsan_weak_memory, bool, 0644);
> +#else
> +#define kcsan_weak_memory false
> +#endif
> +
>  bool kcsan_enabled;
>  
>  /* Per-CPU kcsan_ctx for interrupts */
> @@ -351,6 +358,67 @@ void kcsan_restore_irqtrace(struct task_struct *task)
>  #endif
>  }
>  
> +static __always_inline int get_kcsan_stack_depth(void)
> +{
> +#ifdef CONFIG_KCSAN_WEAK_MEMORY
> +	return current->kcsan_stack_depth;
> +#else
> +	BUILD_BUG();
> +	return 0;
> +#endif
> +}
> +
> +static __always_inline void add_kcsan_stack_depth(int val)
> +{
> +#ifdef CONFIG_KCSAN_WEAK_MEMORY
> +	current->kcsan_stack_depth += val;
> +#else
> +	BUILD_BUG();
> +#endif
> +}
> +
> +static __always_inline struct kcsan_scoped_access *get_reorder_access(struct kcsan_ctx *ctx)
> +{
> +#ifdef CONFIG_KCSAN_WEAK_MEMORY
> +	return ctx->disable_scoped ? NULL : &ctx->reorder_access;
> +#else
> +	return NULL;
> +#endif
> +}
> +
> +static __always_inline bool
> +find_reorder_access(struct kcsan_ctx *ctx, const volatile void *ptr, size_t size,
> +		    int type, unsigned long ip)
> +{
> +	struct kcsan_scoped_access *reorder_access = get_reorder_access(ctx);
> +
> +	if (!reorder_access)
> +		return false;
> +
> +	/*
> +	 * Note: If accesses are repeated while reorder_access is identical,
> +	 * never matches the new access, because !(type & KCSAN_ACCESS_SCOPED).
> +	 */
> +	return reorder_access->ptr == ptr && reorder_access->size == size &&
> +	       reorder_access->type == type && reorder_access->ip == ip;
> +}
> +
> +static inline void
> +set_reorder_access(struct kcsan_ctx *ctx, const volatile void *ptr, size_t size,
> +		   int type, unsigned long ip)
> +{
> +	struct kcsan_scoped_access *reorder_access = get_reorder_access(ctx);
> +
> +	if (!reorder_access || !kcsan_weak_memory)
> +		return;
> +
> +	reorder_access->ptr		= ptr;
> +	reorder_access->size		= size;
> +	reorder_access->type		= type | KCSAN_ACCESS_SCOPED;
> +	reorder_access->ip		= ip;
> +	reorder_access->stack_depth	= get_kcsan_stack_depth();
> +}
> +
>  /*
>   * Pull everything together: check_access() below contains the performance
>   * critical operations; the fast-path (including check_access) functions should
> @@ -389,8 +457,10 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
>  	 * The access_mask check relies on value-change comparison. To avoid
>  	 * reporting a race where e.g. the writer set up the watchpoint, but the
>  	 * reader has access_mask!=0, we have to ignore the found watchpoint.
> +	 *
> +	 * reorder_access is never created from an access with access_mask set.
>  	 */
> -	if (ctx->access_mask)
> +	if (ctx->access_mask && !find_reorder_access(ctx, ptr, size, type, ip))
>  		return;
>  
>  	/*
> @@ -440,11 +510,13 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
>  	const bool is_assert = (type & KCSAN_ACCESS_ASSERT) != 0;
>  	atomic_long_t *watchpoint;
>  	u64 old, new, diff;
> -	unsigned long access_mask;
>  	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
> +	bool interrupt_watcher = kcsan_interrupt_watcher;
>  	unsigned long ua_flags = user_access_save();
>  	struct kcsan_ctx *ctx = get_ctx();
> +	unsigned long access_mask = ctx->access_mask;
>  	unsigned long irq_flags = 0;
> +	bool is_reorder_access;
>  
>  	/*
>  	 * Always reset kcsan_skip counter in slow-path to avoid underflow; see
> @@ -467,6 +539,17 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
>  		goto out;
>  	}
>  
> +	/*
> +	 * The local CPU cannot observe reordering of its own accesses, and
> +	 * therefore we need to take care of 2 cases to avoid false positives:
> +	 *
> +	 *	1. Races of the reordered access with interrupts. To avoid, if
> +	 *	   the current access is reorder_access, disable interrupts.
> +	 *	2. Avoid races of scoped accesses from nested interrupts (below).
> +	 */
> +	is_reorder_access = find_reorder_access(ctx, ptr, size, type, ip);
> +	if (is_reorder_access)
> +		interrupt_watcher = false;
>  	/*
>  	 * Avoid races of scoped accesses from nested interrupts (or scheduler).
>  	 * Assume setting up a watchpoint for a non-scoped (normal) access that
> @@ -482,7 +565,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
>  	 * information is lost if dirtied by KCSAN.
>  	 */
>  	kcsan_save_irqtrace(current);
> -	if (!kcsan_interrupt_watcher)
> +	if (!interrupt_watcher)
>  		local_irq_save(irq_flags);
>  
>  	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
> @@ -503,7 +586,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
>  	 * Read the current value, to later check and infer a race if the data
>  	 * was modified via a non-instrumented access, e.g. from a device.
>  	 */
> -	old = read_instrumented_memory(ptr, size);
> +	old = is_reorder_access ? 0 : read_instrumented_memory(ptr, size);
>  
>  	/*
>  	 * Delay this thread, to increase probability of observing a racy
> @@ -515,8 +598,17 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
>  	 * Re-read value, and check if it is as expected; if not, we infer a
>  	 * racy access.
>  	 */
> -	access_mask = ctx->access_mask;
> -	new = read_instrumented_memory(ptr, size);
> +	if (!is_reorder_access) {
> +		new = read_instrumented_memory(ptr, size);
> +	} else {
> +		/*
> +		 * Reordered accesses cannot be used for value change detection,
> +		 * because the memory location may no longer be accessible and
> +		 * could result in a fault.
> +		 */
> +		new = 0;
> +		access_mask = 0;
> +	}
>  
>  	diff = old ^ new;
>  	if (access_mask)
> @@ -585,11 +677,20 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
>  	 */
>  	remove_watchpoint(watchpoint);
>  	atomic_long_dec(&kcsan_counters[KCSAN_COUNTER_USED_WATCHPOINTS]);
> +
>  out_unlock:
> -	if (!kcsan_interrupt_watcher)
> +	if (!interrupt_watcher)
>  		local_irq_restore(irq_flags);
>  	kcsan_restore_irqtrace(current);
>  	ctx->disable_scoped--;
> +
> +	/*
> +	 * Reordered accesses cannot be used for value change detection,
> +	 * therefore never consider for reordering if access_mask is set.
> +	 * ASSERT_EXCLUSIVE are not real accesses, ignore them as well.
> +	 */
> +	if (!access_mask && !is_assert)
> +		set_reorder_access(ctx, ptr, size, type, ip);
>  out:
>  	user_access_restore(ua_flags);
>  }
> @@ -597,7 +698,6 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
>  static __always_inline void
>  check_access(const volatile void *ptr, size_t size, int type, unsigned long ip)
>  {
> -	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
>  	atomic_long_t *watchpoint;
>  	long encoded_watchpoint;
>  
> @@ -608,12 +708,14 @@ check_access(const volatile void *ptr, size_t size, int type, unsigned long ip)
>  	if (unlikely(size == 0))
>  		return;
>  
> +again:
>  	/*
>  	 * Avoid user_access_save in fast-path: find_watchpoint is safe without
>  	 * user_access_save, as the address that ptr points to is only used to
>  	 * check if a watchpoint exists; ptr is never dereferenced.
>  	 */
> -	watchpoint = find_watchpoint((unsigned long)ptr, size, !is_write,
> +	watchpoint = find_watchpoint((unsigned long)ptr, size,
> +				     !(type & KCSAN_ACCESS_WRITE),
>  				     &encoded_watchpoint);
>  	/*
>  	 * It is safe to check kcsan_is_enabled() after find_watchpoint in the
> @@ -627,9 +729,42 @@ check_access(const volatile void *ptr, size_t size, int type, unsigned long ip)
>  	else {
>  		struct kcsan_ctx *ctx = get_ctx(); /* Call only once in fast-path. */
>  
> -		if (unlikely(should_watch(ctx, ptr, size, type)))
> +		if (unlikely(should_watch(ctx, ptr, size, type))) {
>  			kcsan_setup_watchpoint(ptr, size, type, ip);
> -		else if (unlikely(ctx->scoped_accesses.prev))
> +			return;
> +		}
> +
> +		if (!(type & KCSAN_ACCESS_SCOPED)) {
> +			struct kcsan_scoped_access *reorder_access = get_reorder_access(ctx);
> +
> +			if (reorder_access) {
> +				/*
> +				 * reorder_access check: simulates reordering of
> +				 * the access after subsequent operations.
> +				 */
> +				ptr = reorder_access->ptr;
> +				type = reorder_access->type;
> +				ip = reorder_access->ip;
> +				/*
> +				 * Upon a nested interrupt, this context's
> +				 * reorder_access can be modified (shared ctx).
> +				 * We know that upon return, reorder_access is
> +				 * always invalidated by setting size to 0 via
> +				 * __tsan_func_exit(). Therefore we must read
> +				 * and check size after the other fields.
> +				 */
> +				barrier();
> +				size = READ_ONCE(reorder_access->size);
> +				if (size)
> +					goto again;
> +			}
> +		}
> +
> +		/*
> +		 * Always checked last, right before returning from runtime;
> +		 * if reorder_access is valid, checked after it was checked.
> +		 */
> +		if (unlikely(ctx->scoped_accesses.prev))
>  			kcsan_check_scoped_accesses();
>  	}
>  }
> @@ -916,19 +1051,56 @@ DEFINE_TSAN_VOLATILE_READ_WRITE(8);
>  DEFINE_TSAN_VOLATILE_READ_WRITE(16);
>  
>  /*
> - * The below are not required by KCSAN, but can still be emitted by the
> - * compiler.
> + * Function entry and exit are used to determine the validty of reorder_access.
> + * Reordering of the access ends at the end of the function scope where the
> + * access happened. This is done for two reasons:
> + *
> + *	1. Artificially limits the scope where missing barriers are detected.
> + *	   This minimizes false positives due to uninstrumented functions that
> + *	   contain the required barriers but were missed.
> + *
> + *	2. Simplifies generating the stack trace of the access.
>   */
>  void __tsan_func_entry(void *call_pc);
> -void __tsan_func_entry(void *call_pc)
> +noinline void __tsan_func_entry(void *call_pc)
>  {
> +	if (!IS_ENABLED(CONFIG_KCSAN_WEAK_MEMORY))
> +		return;
> +
> +	add_kcsan_stack_depth(1);
>  }
>  EXPORT_SYMBOL(__tsan_func_entry);
> +
>  void __tsan_func_exit(void);
> -void __tsan_func_exit(void)
> +noinline void __tsan_func_exit(void)
>  {
> +	struct kcsan_scoped_access *reorder_access;
> +
> +	if (!IS_ENABLED(CONFIG_KCSAN_WEAK_MEMORY))
> +		return;
> +
> +	reorder_access = get_reorder_access(get_ctx());
> +	if (!reorder_access)
> +		goto out;
> +
> +	if (get_kcsan_stack_depth() <= reorder_access->stack_depth) {
> +		/*
> +		 * Access check to catch cases where write without a barrier
> +		 * (supposed release) was last access in function: because
> +		 * instrumentation is inserted before the real access, a data
> +		 * race due to the write giving up a c-s would only be caught if
> +		 * we do the conflicting access after.
> +		 */
> +		check_access(reorder_access->ptr, reorder_access->size,
> +			     reorder_access->type, reorder_access->ip);
> +		reorder_access->size = 0;
> +		reorder_access->stack_depth = INT_MIN;
> +	}
> +out:
> +	add_kcsan_stack_depth(-1);
>  }
>  EXPORT_SYMBOL(__tsan_func_exit);
> +
>  void __tsan_init(void);
>  void __tsan_init(void)
>  {
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index e0a93ffdef30..e4394ea8068b 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -191,6 +191,26 @@ config KCSAN_STRICT
>  	  closely aligns with the rules defined by the Linux-kernel memory
>  	  consistency model (LKMM).
>  
> +config KCSAN_WEAK_MEMORY
> +	bool "Enable weak memory modeling to detect missing memory barriers"
> +	default y
> +	depends on KCSAN_STRICT
> +	# We can either let objtool nop __tsan_func_{entry,exit}() and builtin
> +	# atomics instrumentation in .noinstr.text, or use a compiler that can
> +	# implement __no_kcsan to really remove all instrumentation.
> +	depends on STACK_VALIDATION || CC_IS_GCC
> +	help
> +	  Enable support for modeling a subset of weak memory, which allows
> +	  detecting a subset of data races due to missing memory barriers.
> +
> +	  Depends on KCSAN_STRICT, because the options strenghtening certain
> +	  plain accesses by default (depending on !KCSAN_STRICT) reduce the
> +	  ability to detect any data races invoving reordered accesses, in
> +	  particular reordered writes.
> +
> +	  Weak memory modeling relies on additional instrumentation and may
> +	  affect performance.
> +
>  config KCSAN_REPORT_VALUE_CHANGE_ONLY
>  	bool "Only report races where watcher observed a data value change"
>  	default y
> diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
> index 37cb504c77e1..4c7f0d282e42 100644
> --- a/scripts/Makefile.kcsan
> +++ b/scripts/Makefile.kcsan
> @@ -9,7 +9,12 @@ endif
>  
>  # Keep most options here optional, to allow enabling more compilers if absence
>  # of some options does not break KCSAN nor causes false positive reports.
> -export CFLAGS_KCSAN := -fsanitize=thread \
> -	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
> +kcsan-cflags := -fsanitize=thread -fno-optimize-sibling-calls \
>  	$(call cc-option,$(call cc-param,tsan-compound-read-before-write=1),$(call cc-option,$(call cc-param,tsan-instrument-read-before-write=1))) \
>  	$(call cc-param,tsan-distinguish-volatile=1)
> +
> +ifndef CONFIG_KCSAN_WEAK_MEMORY
> +kcsan-cflags += $(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0))
> +endif
> +
> +export CFLAGS_KCSAN := $(kcsan-cflags)
> -- 
> 2.34.0.384.gca35af8252-goog
> 

