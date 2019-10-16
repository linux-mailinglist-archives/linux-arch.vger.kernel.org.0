Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22913D9544
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbfJPPQw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 11:16:52 -0400
Received: from foss.arm.com ([217.140.110.172]:43070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730806AbfJPPQv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Oct 2019 11:16:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B25BA142F;
        Wed, 16 Oct 2019 08:16:50 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F416A3F68E;
        Wed, 16 Oct 2019 08:16:45 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:16:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, npiggin@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191016151643.GC46264@lakrids.cambridge.arm.com>
References: <20191016083959.186860-1-elver@google.com>
 <20191016083959.186860-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016083959.186860-2-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 16, 2019 at 10:39:52AM +0200, Marco Elver wrote:
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2c2e56bd8913..34a1d9310304 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1171,6 +1171,13 @@ struct task_struct {
>  #ifdef CONFIG_KASAN
>  	unsigned int			kasan_depth;
>  #endif
> +#ifdef CONFIG_KCSAN
> +	/* See comments at kernel/kcsan/core.c: struct cpu_state. */
> +	int				kcsan_disable;
> +	int				kcsan_atomic_next;
> +	int				kcsan_atomic_region;
> +	bool				kcsan_atomic_region_flat;
> +#endif

Should these be unsigned?

> +/*
> + * Per-CPU state that should be used instead of 'current' if we are not in a
> + * task.
> + */
> +struct cpu_state {
> +	int disable; /* disable counter */
> +	int atomic_next; /* number of following atomic ops */
> +
> +	/*
> +	 * We use separate variables to store if we are in a nestable or flat
> +	 * atomic region. This helps make sure that an atomic region with
> +	 * nesting support is not suddenly aborted when a flat region is
> +	 * contained within. Effectively this allows supporting nesting flat
> +	 * atomic regions within an outer nestable atomic region. Support for
> +	 * this is required as there are cases where a seqlock reader critical
> +	 * section (flat atomic region) is contained within a seqlock writer
> +	 * critical section (nestable atomic region), and the "mismatching
> +	 * kcsan_end_atomic()" warning would trigger otherwise.
> +	 */
> +	int atomic_region;
> +	bool atomic_region_flat;
> +};
> +static DEFINE_PER_CPU(struct cpu_state, this_state) = {
> +	.disable = 0,
> +	.atomic_next = 0,
> +	.atomic_region = 0,
> +	.atomic_region_flat = 0,
> +};

These are the same as in task_struct, so I think it probably makes sense
to have a common structure for these, e.g.

| struct kcsan_ctx {
| 	int	disable;
| 	int	atomic_next;
| 	int	atomic_region;
| 	bool	atomic_region_flat;
| };

... which you then place within task_struct, e.g.

| #ifdef CONFIG_KCSAN
| 	struct kcsan_ctx	kcsan_ctx;
| #endif

... and here, e.g.

| static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx);

That would simplify a number of cases below where you have to choose one
or the other, as you can choose the pointer, then handle the rest in a
common way.

e.g. for:

> +static inline bool is_atomic(const volatile void *ptr)
> +{
> +	if (in_task()) {
> +		if (unlikely(current->kcsan_atomic_next > 0)) {
> +			--current->kcsan_atomic_next;
> +			return true;
> +		}
> +		if (unlikely(current->kcsan_atomic_region > 0 ||
> +			     current->kcsan_atomic_region_flat))
> +			return true;
> +	} else { /* interrupt */
> +		if (unlikely(this_cpu_read(this_state.atomic_next) > 0)) {
> +			this_cpu_dec(this_state.atomic_next);
> +			return true;
> +		}
> +		if (unlikely(this_cpu_read(this_state.atomic_region) > 0 ||
> +			     this_cpu_read(this_state.atomic_region_flat)))
> +			return true;
> +	}
> +
> +	return kcsan_is_atomic(ptr);
> +}

... you could have something like:

| struct kcsan_ctx *kcsan_get_ctx(void)
| {
| 	return in_task() ? &current->kcsan_ctx : this_cpu_ptr(kcsan_cpu_ctx);
| }
|
| static inline bool is_atomic(const volatile void *ptr)
| {
| 	struct kcsan_ctx *ctx = kcsan_get_ctx();
|	if (unlikely(ctx->atomic_next > 0) {
|		--ctx->atomic_next;
| 		return true;
| 	}
| 	if (unlikely(ctx->atomic_region > 0 || ctx->atomic_region_flat))
| 		return true;
|
| 	return kcsan_is_atomic(ptr);
| }

... avoiding duplicating the checks for task/irq contexts.

It's not clear to me how either that or the original code works if a
softirq is interrupted by a hardirq. IIUC most of the fields should
remain stable over that window, since the hardirq should balance most
changes it makes before returning, but I don't think that's true for
atomic_next. Can't that be corrupted from the PoV of the softirq
handler?

[...]

> +void kcsan_begin_atomic(bool nest)
> +{
> +	if (nest) {
> +		if (in_task())
> +			++current->kcsan_atomic_region;
> +		else
> +			this_cpu_inc(this_state.atomic_region);
> +	} else {
> +		if (in_task())
> +			current->kcsan_atomic_region_flat = true;
> +		else
> +			this_cpu_write(this_state.atomic_region_flat, true);
> +	}
> +}

Assuming my suggestion above wasn't bogus, this can be:

| void kcsan_begin_atomic(boot nest)
| {
| 	struct kcsan_ctx *ctx = kcsan_get_ctx();
| 	if (nest)
| 		ctx->atomic_region++;
| 	else
| 		ctx->atomic_region_flat = true;
| }

> +void kcsan_end_atomic(bool nest)
> +{
> +	if (nest) {
> +		int prev =
> +			in_task() ?
> +				current->kcsan_atomic_region-- :
> +				(this_cpu_dec_return(this_state.atomic_region) +
> +				 1);
> +		if (prev == 0) {
> +			kcsan_begin_atomic(true); /* restore to 0 */
> +			kcsan_disable_current();
> +			WARN(1, "mismatching %s", __func__);
> +			kcsan_enable_current();
> +		}
> +	} else {
> +		if (in_task())
> +			current->kcsan_atomic_region_flat = false;
> +		else
> +			this_cpu_write(this_state.atomic_region_flat, false);
> +	}
> +}

... similarly:

| void kcsan_end_atomic(bool nest)
| {
| 	struct kcsan_ctx *ctx = kcsan_get_ctx();
| 
| 	if (nest)
| 		if (ctx->kcsan_atomic_region--) {
| 			kcsan_begin_atomic(true); /* restore to 0 */
| 			kcsan_disable_current();
| 			WARN(1, "mismatching %s"\ __func__);
| 			kcsan_enable_current();
| 		}
| 	} else {
| 		ctx->atomic_region_flat = true;
| 	}
| }

> +void kcsan_atomic_next(int n)
> +{
> +	if (in_task())
> +		current->kcsan_atomic_next = n;
> +	else
> +		this_cpu_write(this_state.atomic_next, n);
> +}

... and:

| void kcsan_atomic_nextint n)
| {
| 	kcsan_get_ctx()->atomic_next = n;
| }

Thanks,
Mark.
