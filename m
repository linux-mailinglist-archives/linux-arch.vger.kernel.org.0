Return-Path: <linux-arch+bounces-13095-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC6B1E6CF
	for <lists+linux-arch@lfdr.de>; Fri,  8 Aug 2025 12:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09A43AB9FE
	for <lists+linux-arch@lfdr.de>; Fri,  8 Aug 2025 10:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CDF227E95;
	Fri,  8 Aug 2025 10:52:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282A5695;
	Fri,  8 Aug 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650322; cv=none; b=KEoUyRLDJ++/+nIl0fR0kAN9Np/i2eGdcqKd0D6vM41dd19NdYUgpFB8b551pmeWWCqMWvA0rf/NB8LHlJsJuv06yWzXlLqzWR6ePE4sHQwhmPkdj5kmYTzCr6LiCUV0+2axdI/RZnCx/kmKRDgMLpwdvuUZjFGY7vluczKlgE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650322; c=relaxed/simple;
	bh=KesZR+F59DfKiQMTTe/qycskddKZgXqP+OvKbQU0IZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izK5HpFA/3aEZLWD8OkjUj3/bGayfxlvz9CZmffYxc7GFxT8UqyVcgeBUX1btP94n1LbqvIjZ8QmfVUTqg89/g3RJaBv45YE+q4MkCqg9itE1UNJl3KBLd2M0e8Q/u5LJ9OLZsrb4MwYjOVBrH4W+uPG07qxhdFSoiWbM8GPGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48690C4CEED;
	Fri,  8 Aug 2025 10:51:58 +0000 (UTC)
Date: Fri, 8 Aug 2025 11:51:55 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, will@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
Message-ID: <aJXWyxzkA3x61fKA@arm.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627044805.945491-2-ankur.a.arora@oracle.com>

On Thu, Jun 26, 2025 at 09:48:01PM -0700, Ankur Arora wrote:
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21d..d33c2701c9ee 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -273,6 +273,101 @@ do {									\
>  })
>  #endif
>  
> +#ifndef SMP_TIMEWAIT_SPIN_BASE
> +#define SMP_TIMEWAIT_SPIN_BASE		16
> +#endif
> +
> +/*
> + * Policy handler that adjusts the number of times we spin or
> + * wait for cacheline to change before evaluating the time-expr.
> + *
> + * The generic version only supports spinning.
> + */
> +static inline u64 ___smp_cond_spinwait(u64 now, u64 prev, u64 end,
> +				       u32 *spin, bool *wait, u64 slack)
> +{
> +	if (now >= end)
> +		return 0;
> +
> +	*spin = SMP_TIMEWAIT_SPIN_BASE;
> +	*wait = false;
> +	return now;
> +}
> +
> +#ifndef __smp_cond_policy
> +#define __smp_cond_policy ___smp_cond_spinwait
> +#endif
> +
> +/*
> + * Non-spin primitive that allows waiting for stores to an address,
> + * with support for a timeout. This works in conjunction with an
> + * architecturally defined policy.
> + */
> +#ifndef __smp_timewait_store
> +#define __smp_timewait_store(ptr, val)	do { } while (0)
> +#endif
> +
> +#ifndef __smp_cond_load_relaxed_timewait
> +#define __smp_cond_load_relaxed_timewait(ptr, cond_expr, policy,	\
> +					 time_expr, time_end,		\
> +					 slack) ({			\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_BASE;			\
> +	u64 __prev = 0, __end = (time_end);				\
> +	u64 __slack = slack;						\
> +	bool __wait = false;						\
> +									\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_relax();						\
> +		if (++__n < __spin)					\
> +			continue;					\
> +		if (!(__prev = policy((time_expr), __prev, __end,	\
> +					  &__spin, &__wait, __slack)))	\
> +			break;						\
> +		if (__wait)						\
> +			__smp_timewait_store(__PTR, VAL);		\
> +		__n = 0;						\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})
> +#endif

TBH, this still looks over-engineered to me, especially with the second
patch trying to reduce the spin loops based on the remaining time. Does
any of the current users of this interface need it to get more precise?

Also I feel the spinning added to poll_idle() is more of an architecture
choice as some CPUs could not cope with local_clock() being called too
frequently. The above generic implementation takes a spin into
consideration even if an arch implementation doesn't need it (e.g. WFET
or WFE). Yes, the arch policy could set a spin of 0 but it feels overly
complicated for the generic implementation.

Can we instead have the generic implementation without any spinning?
Just polling a variable with cpu_relax() like
smp_cond_load_acquire/relaxed() with the additional check for time. We
redefine it in the arch code.

> +#define __check_time_types(type, a, b)			\
> +		(__same_type(typeof(a), type) &&	\
> +		 __same_type(typeof(b), type))
> +
> +/**
> + * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
> + * guarantees until a timeout expires.
> + * @ptr: pointer to the variable to wait on
> + * @cond: boolean expression to wait for
> + * @time_expr: monotonic expression that evaluates to the current time
> + * @time_end: end time, compared against time_expr
> + * @slack: how much timer overshoot can the caller tolerate?
> + * Useful for when we go into wait states. A value of 0 indicates a high
> + * tolerance.
> + *
> + * Note that all times (time_expr, time_end, and slack) are in microseconds,
> + * with no mandated precision.
> + *
> + * Equivalent to using READ_ONCE() on the condition variable.
> + */
> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr, time_expr,	\
> +				       time_end, slack) ({		\
> +	__unqual_scalar_typeof(*ptr) _val;				\
> +	BUILD_BUG_ON_MSG(!__check_time_types(u64, time_expr, time_end),	\
> +			 "incompatible time units");			\
> +	_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
> +						__smp_cond_policy,	\
> +						time_expr, time_end,	\
> +						slack);			\
> +	(typeof(*ptr))_val;						\
> +})

Looking at the current user of the acquire variant - rqspinlock, it does
not even bother with a time_expr but rather added the time condition to
cond_expr. I don't think it has any "slack" requirements, only that
there's no deadlock eventually.

About poll_idle(), are there any slack requirement or we get away
without?

I think we have two ways forward (well, at least):

1. Clearly define what time_end is and we won't need a time_expr at all.
   This may work for poll_idle(), not sure about rqspinlock. The
   advantage is that we can drop the 'slack' argument since none of the
   current users seem to need it. The downside is that we need to know
   exactly what this time_end is to convert it to timer cycles for a
   WFET implementation on arm64.

2. Drop time_end and only leave time_expr as a bool (we don't care
   whether it uses ns, jiffies or whatever underneath, it's just a
   bool). In this case, we could use a 'slack' argument mostly to make a
   decision on whether we use WFET, WFE or just polling with
   cpu_relax(). For WFET, the wait time would be based on the slack
   value rather than some absolute end time which we won't have.

I'd go with (2), it looks simpler. Maybe even drop the 'slack' argument
for the time being until we have a clear user. The fallback on arm64
would be from wfe (if event streaming available), wfet with the same
period as the event stream (in the absence of a slack argument) or
cpu_relax().

-- 
Catalin

