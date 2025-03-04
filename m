Return-Path: <linux-arch+bounces-10523-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC436A4ED04
	for <lists+linux-arch@lfdr.de>; Tue,  4 Mar 2025 20:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E9C47A8975
	for <lists+linux-arch@lfdr.de>; Tue,  4 Mar 2025 19:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DB220371A;
	Tue,  4 Mar 2025 19:16:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1F1EE7AD;
	Tue,  4 Mar 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115759; cv=none; b=Lx78yybCdE5YRoTjwN2S0Edz+DgDdYrCl4HPUr56ryosoXNRhs1Au1MYEp2yQvASyrtMCtiY3/SeKxuuhWtsjLTsqmT9guNfFmnwoEE97RQ2A0P41c4cHReaUg7j+y2KmK9JoIuk8x4z3XePCgYwH/CPl3WT04J/qlrZpJvXgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115759; c=relaxed/simple;
	bh=EX2yCH5S4Sr+3vHjRGwcGccOr3tHhewaJmApX8U9vdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oekSEBM8dGSmvX0OpVq8azsUqwxDGU1qsqXX6eCHDF8pwhq9XY3tn4g+YUwwXwUxo1TfJwchRtNxagCv3so7q8LDTyDc0LJDw1q4hQiQARKFntM8hyynmOSUpFfB6pu3T4qKRQWtJlwYa7nSOnWOUaKM4bcKIM/gJyF609p9BrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4CBC4CEE5;
	Tue,  4 Mar 2025 19:15:57 +0000 (UTC)
Date: Tue, 4 Mar 2025 19:15:54 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	will@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, memxor@gmail.com,
	zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/4] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
Message-ID: <Z8dRalfxYcJIcLGj@arm.com>
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
 <20250203214911.898276-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203214911.898276-2-ankur.a.arora@oracle.com>
X-TUID: lLrdoPZx9Q90

On Mon, Feb 03, 2025 at 01:49:08PM -0800, Ankur Arora wrote:
> Add smp_cond_load_relaxed_timewait(), a timed variant of
> smp_cond_load_relaxed(). This is useful for cases where we want to
> wait on a conditional variable but don't want to wait indefinitely.

Bikeshedding: why not "timeout" rather than "timewait"?

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21d..31de8ed2a05e 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -273,6 +273,54 @@ do {									\
>  })
>  #endif
>  
> +#ifndef smp_cond_time_check_count
> +/*
> + * Limit how often smp_cond_load_relaxed_timewait() evaluates time_expr_ns.
> + * This helps reduce the number of instructions executed while spin-waiting.
> + */
> +#define smp_cond_time_check_count	200
> +#endif

While this was indeed added to the poll_idle() loop, it feels completely
random in a generic implementation. It's highly dependent on the
time_expr_ns passed. Can the caller not move the loop in time_expr_ns
before invoking this macro?

> +
> +/**
> + * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
> + * guarantees until a timeout expires.
> + * @ptr: pointer to the variable to wait on
> + * @cond: boolean expression to wait for
> + * @time_expr_ns: evaluates to the current time
> + * @time_limit_ns: compared against time_expr_ns
> + *
> + * Equivalent to using READ_ONCE() on the condition variable.
> + *
> + * Note that the time check in time_expr_ns can be synchronous or
> + * asynchronous.
> + * In the generic version the check is synchronous but kept coarse
> + * to minimize instructions executed while spin-waiting.
> + */

Not sure exactly what synchronous vs asynchronous here mean. I see the
latter more like an interrupt. I guess what you have in mind is the WFE
wakeup events on arm64, though they don't interrupt the instruction
flow. I'd not bother specifying this at all.

> +#ifndef __smp_cond_load_relaxed_spinwait
> +#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
> +					 time_limit_ns) ({		\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	unsigned int __count = 0;					\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_relax();						\
> +		if (__count++ < smp_cond_time_check_count)		\
> +			continue;					\
> +		if ((time_expr_ns) >= (time_limit_ns))			\
> +			break;						\
> +		__count = 0;						\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})
> +#endif
> +
> +#ifndef smp_cond_load_relaxed_timewait
> +#define smp_cond_load_relaxed_timewait  __smp_cond_load_relaxed_spinwait
> +#endif

What I don't particularly like about this interface is (1) no idea of
what time granularity it offers, how much it can slip past the deadline,
even though there's some nanoseconds implied and (2) time_expr_ns leaves
the caller to figure out why time function to use for tracking the time.
Well, I can be ok with (2) if we make it a bit more generic.

The way it is written, I guess the type of the time expression and limit
no longer matters as long as you can compare them. The naming implies
nanoseconds but we don't have such precision, especially with the WFE
implementation for arm64. We could add a slack range argument like the
delta_ns for some of the hrtimer API and let the arch code decide
whether to honour it.

What about we drop the time_limit_ns and build it into the time_expr_ns
as a 'time_cond' argument? The latter would return the result of some
comparison and the loop bails out if true. An additional argument would
be the minimum granularity for checking the time_cond and the arch code
may decide to fall back to busy loops if the granularity is larger than
what the caller required.

-- 
Catalin

