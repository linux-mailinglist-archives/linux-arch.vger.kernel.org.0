Return-Path: <linux-arch+bounces-12064-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98282ABFCEA
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 20:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1471894224
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F446289E15;
	Wed, 21 May 2025 18:37:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A7289820;
	Wed, 21 May 2025 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852664; cv=none; b=l9o2qRO4tQUaAj2mLN2Ie46dp3HPGhLN7YF3Sho5rdIlR+y90HwK/BMi4JAb+gUW81KvahykUYiyqtDCTULEwYPFu4LEjz0BuQg5oSCkYNYtkDJG+xpQy7RW1KeA/UMR6jRX3dFvvAmTevt7cTTfmNqIq5k/Zm/HL5QK4RG4vHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852664; c=relaxed/simple;
	bh=Aos9Ol6hokUVBuT33LhS3DKWl1E6gsmX4YWWAPnjFxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSAhNqeaNeKR9H7TzGveIoCfNtcxoDQlonJh+JEWyTSZIvPnW7e7byasFm/8Rd2VjM5qYHQCkTuCAyiw5ZMDLzIzYfIjydqbgI2bzN+sYYfRkX3H6wuljOrE2YlRPU5C9F8RqgZvggsqSnsuWjaKqzNBYdRfKraUbnvmPjSSeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1811C4CEE4;
	Wed, 21 May 2025 18:37:39 +0000 (UTC)
Date: Wed, 21 May 2025 19:37:37 +0100
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
Subject: Re: [PATCH v2 1/7] asm-generic: barrier: add
 smp_cond_load_relaxed_timewait()
Message-ID: <aC4dcZ2veeavM2dR@arm.com>
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
 <20250502085223.1316925-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502085223.1316925-2-ankur.a.arora@oracle.com>

Hi Ankur,

Sorry, it took me some time to get back to this series (well, I tried
once and got stuck on what wait_policy is supposed to mean, so decided
to wait until I had more coffee ;)).

On Fri, May 02, 2025 at 01:52:17AM -0700, Ankur Arora wrote:
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21d..a7be98e906f4 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -273,6 +273,64 @@ do {									\
>  })
>  #endif
>  
> +/*
> + * Non-spin primitive that allows waiting for stores to an address,
> + * with support for a timeout. This works in conjunction with an
> + * architecturally defined wait_policy.
> + */
> +#ifndef __smp_timewait_store
> +#define __smp_timewait_store(ptr, val) do { } while (0)
> +#endif
> +
> +#ifndef __smp_cond_load_relaxed_timewait
> +#define __smp_cond_load_relaxed_timewait(ptr, cond_expr, wait_policy,	\
> +					 time_expr, time_end) ({	\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	u32 __n = 0, __spin = 0;					\
> +	u64 __prev = 0, __end = (time_end);				\
> +	bool __wait = false;						\
> +									\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_relax();						\
> +		if (++__n < __spin)					\
> +			continue;					\
> +		if (!(__prev = wait_policy((time_expr), __prev, __end,	\
> +					  &__spin, &__wait)))		\
> +			break;						\
> +		if (__wait)						\
> +			__smp_timewait_store(__PTR, VAL);		\
> +		__n = 0;						\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})
> +#endif
> +
> +/**
> + * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
> + * guarantees until a timeout expires.
> + * @ptr: pointer to the variable to wait on
> + * @cond: boolean expression to wait for
> + * @wait_policy: policy handler that adjusts the number of times we spin or
> + *  wait for cacheline to change (depends on architecture, not supported in
> + *  generic code.) before evaluating the time-expr.
> + * @time_expr: monotonic expression that evaluates to the current time
> + * @time_end: compared against time_expr
> + *
> + * Equivalent to using READ_ONCE() on the condition variable.
> + */
> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr, wait_policy,	\
> +					 time_expr, time_end) ({	\
> +	__unqual_scalar_typeof(*ptr) _val;;				\
> +	_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
> +					      wait_policy, time_expr,	\
> +					      time_end);		\
> +	(typeof(*ptr))_val;						\
> +})

IIUC, a generic user of this interface would need a wait_policy() that
is aware of the arch details (event stream, WFET etc.), given the
__smp_timewait_store() implementation in patch 3. This becomes clearer
in patch 7 where one needs to create rqspinlock_cond_timewait().

The __spin count can be arch specific, not part of some wait_policy,
even if such policy is most likely implemented in the arch code (as the
generic caller has no clue what it means). The __wait decision, again, I
don't think it should be the caller of this API to decide how to handle,
it's something internal to the API implementation based on whether the
event stream (or later WFET) is available.

The ___cond_timewait() implementation in patch 4 sets __wait if either
the event stream of WFET is available. However, __smp_timewait_store()
only uses WFE as per the __cmpwait_relaxed() implementation. So you
can't really decouple wait_policy() from how the spinning is done, in an
arch-specific way. In this implementation, wait_policy() would need to
say how to wait - WFE, WFET. That's not captured (and I don't think it
should, we can't expand the API every time we have a new method of
waiting).

I still think this interface can be simpler and fairly generic, not with
wait_policy specific to rqspinlock or poll_idle. Maybe you can keep a
policy argument for an internal __smp_cond_load_relaxed_timewait() if
it's easier to structure the code this way but definitely not for
smp_cond_*().

Another aspect I'm not keen on is the arbitrary fine/coarse constants.
Can we not have the caller pass a slack value (in ns or 0 if it doesn't
care) to smp_cond_load_relaxed_timewait() and let the arch code decide
which policy to use?

In summary, I see the API something like:

#define smp_cond_load_relaxed_timewait(ptr, cond_expr,
				       time_expr, time_end, slack_ns)

We can even drop time_end if we capture it in time_expr returning a bool
(like we do with cond_expr).

Thanks.

-- 
Catalin

