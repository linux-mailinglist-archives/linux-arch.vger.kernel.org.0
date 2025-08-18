Return-Path: <linux-arch+bounces-13190-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3BB2AFCD
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 19:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222BF560C55
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 17:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CCC24C07F;
	Mon, 18 Aug 2025 17:55:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5D35950;
	Mon, 18 Aug 2025 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539708; cv=none; b=HY3FhGnCD0weQHfP1YG+NKc9bE8bRbVTpOetpDzo4wbnB6FZXaRnDEtXriBnZa5219guhndnCIG7snkdsQrhr3mP+uZWVltNM5rHfrEonvMVdloZ4a7cNoI+SnQyvH4FfpxMmkUdD7ds5C/xWewQSlv7+DS1Rdyg1lYvZTYqO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539708; c=relaxed/simple;
	bh=VJ1CkKtywdMxJWNUL6EhAq1DnqQL7DbmlHelKHs9YL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXlRiLsOrTW5aisPrA2fOUn6ZQUSxZAOPkup6Km/xW5IbWeqmrRpuw/IVaqYFhd1wqWkllFT5HSnX8CMQAl/fT65moU/ijjJhodBtaaK1f9WDCFNRAp0XZtIj+bXp1GvGsJcXDciu2l+9d7VuELyHFmqjpFRXxZYo+ecRSQmbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47FDC4CEEB;
	Mon, 18 Aug 2025 17:55:04 +0000 (UTC)
Date: Mon, 18 Aug 2025 18:55:02 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, will@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	rafael@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
Message-ID: <aKNo9pxx2w9sjJjc@arm.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com>
 <aJXWyxzkA3x61fKA@arm.com>
 <877bz98sqb.fsf@oracle.com>
 <aJy414YufthzC1nv@arm.com>
 <87bjoi2wdf.fsf@oracle.com>
 <aJ3K4tQCztOXF6hO@arm.com>
 <87plctwq7x.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plctwq7x.fsf@oracle.com>

On Sun, Aug 17, 2025 at 03:14:26PM -0700, Ankur Arora wrote:
> So, I tried to pare back the code and the following (untested) is
> what I came up with. Given the straight-forward rate-limiting, and the
> current users not needing accurate timekeeping, this uses a
> bool time_check_expr. Figured I'd keep it simple until someone actually
> needs greater complexity as you suggested.
> 
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21d..e8793347a395 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -273,6 +273,34 @@ do {                                                                       \
>  })
>  #endif
> 
> +
> +#ifndef SMP_TIMEWAIT_SPIN_COUNT
> +#define SMP_TIMEWAIT_SPIN_COUNT                200
> +#endif
> +
> +#ifndef smp_cond_load_relaxed_timewait
> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr,                 \
> +                                       time_check_expr)                \
> +({                                                                     \
> +       typeof(ptr) __PTR = (ptr);                                      \
> +       __unqual_scalar_typeof(*ptr) VAL;                               \
> +       u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_COUNT;                  \
> +                                                                       \
> +       for (;;) {                                                      \
> +               VAL = READ_ONCE(*__PTR);                                \
> +               if (cond_expr)                                          \
> +                       break;                                          \
> +               cpu_relax();                                            \
> +               if (++__n < __spin)                                     \
> +                       continue;                                       \
> +               if ((time_check_expr))                                  \
> +                       break;                                          \
> +               __n = 0;                                                \
> +       }                                                               \
> +       (typeof(*ptr))VAL;                                              \
> +})
> +#endif

This looks fine, at least as it would be used by poll_idle(). The only
reason for not folding time_check_expr into cond_expr is the poll_idle()
requirement to avoid calling time_check_expr too often.

> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index f5801b0ba9e9..c9934ab68da2 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -219,6 +219,43 @@ do {                                                                       \
>         (typeof(*ptr))VAL;                                              \
>  })
> 
> +extern bool arch_timer_evtstrm_available(void);
> +
> +#ifndef SMP_TIMEWAIT_SPIN_COUNT
> +#define SMP_TIMEWAIT_SPIN_COUNT                200
> +#endif
> +
> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr,                 \
> +                                         time_check_expr)              \
> +({                                                                     \
> +       typeof(ptr) __PTR = (ptr);                                      \
> +       __unqual_scalar_typeof(*ptr) VAL;                               \
> +       u32 __n = 0, __spin = 0;                                        \
> +       bool __wfet = alternative_has_cap_unlikely(ARM64_HAS_WFXT);     \
> +       bool __wfe = arch_timer_evtstrm_available();                    \
> +       bool __wait = false;                                            \
> +                                                                       \
> +       if (__wfet || __wfe)                                            \
> +               __wait = true;                                          \
> +       else                                                            \
> +               __spin = SMP_TIMEWAIT_SPIN_COUNT;                       \
> +                                                                       \
> +       for (;;) {                                                      \
> +               VAL = READ_ONCE(*__PTR);                                \
> +               if (cond_expr)                                          \
> +                       break;                                          \
> +               cpu_relax();                                            \
> +               if (++__n < __spin)                                     \
> +                       continue;                                       \
> +               if ((time_check_expr))                                  \
> +                       break;                                          \
> +               if (__wait)                                             \
> +                       __cmpwait_relaxed(__PTR, VAL);                  \
> +               __n = 0;                                                \
> +       }                                                               \
> +       (typeof(*ptr))VAL;                                              \
> +})

For arm64, I wouldn't bother with the spin count. Since cpu_relax()
doesn't do anything, I doubt it makes any difference, especially as we
are likely to use WFE anyway. If we do add one, I'd like it backed by
some numbers to show it makes a difference in practice.

The question is whether 100us granularity is good enough for poll_idle()
(I came to the conclusion it's fine for rqspinlock, given their 1ms
deadlock check).

>  #include <asm-generic/barrier.h>
> 
> __cmpwait_relaxed() will need adjustment to set a deadline for WFET.

Yeah, __cmpwait_relaxed() doesn't use WFET as it doesn't need a timeout
(it just happens to have one with the event stream).

We could extend this or create a new one that uses WFET and takes an
argument. If extending this one, for example a timeout argument of 0
means WFE, non-zero means WFET cycles. This adds a couple of more
instructions.

What I had in mind of time_expr was a ktime_t would be something like:

	for (;;) {
		VAL = READ_ONCE(*__PTR);
		if (cond_expr)
			break;

		cycles = some_func_of(time_expr);	// see __udelay()
		if (cycles <= 0)
			break;

		if (__wfet) {
			__cmpwait_relaxed(__PTR, VAL, get_cycles() + cycles);
		} else if (__wfe && cycles >= timer_evt_period) {
			__cmpwait_relaxed(__PTR, VAL, 0);
		} else {
			cpu_relax();
		}
	}

Now, if we don't care about the time check granularity (for now) and
time_check_expr is a bool (this seems to work better for rqspinlock), I
think we could do something like:

	for (;;) {
		VAL = READ_ONCE(*__PTR);
		if (cond_expr)
			break;
		if (time_check_expr)
			break;

		if (__wfe) {
			__cmpwait_relaxed(__PTR, VAL, 0);
		} else if (__wfet) {
			__cmpwait_relaxed(__PTR, VAL, get_cycles() + timer_evt_period);
		} else {
			cpu_relax();
		}
	}

We go with WFE first in this case to avoid get_cycles() unnecessarily.

I'd suggest we add the WFET support in __cmpwait_relaxed() (or a
different function) as a separate patch, doesn't even need to be part of
this series. WFE is good enough to get things moving. WFET will only
make a difference if (1) we disable the event stream or (2) we need
better accuracy of the timeout.

> AFAICT the rqspinlock code should be able to work by specifying something
> like:
>   ((ktime_get_mono_fast_ns() > tval)) || (deadlock_check(&lock_context)))
> as the time_check_expr.

Why not the whole RES_CHECK_TIMEOUT(...) as in rqspinlock.c? It does the
deadlock check only after a timeout over a millisecond. Just follow the
res_atomic_cond_read_acquire() calls but replace '||' with a comma.

> I think they also want to rate limit how often deadlock_check() is
> called, so they can redefine SMP_TIMEWAIT_SPIN_COUNT to some large
> value for arm64.

Everyone would want a different rate of checking other stuff, so I think
this needs to go in their time_check_expr.

-- 
Catalin

