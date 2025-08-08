Return-Path: <linux-arch+bounces-13094-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00ABB1E5B1
	for <lists+linux-arch@lfdr.de>; Fri,  8 Aug 2025 11:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18991169BFE
	for <lists+linux-arch@lfdr.de>; Fri,  8 Aug 2025 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2857D24E01D;
	Fri,  8 Aug 2025 09:38:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F71E379B;
	Fri,  8 Aug 2025 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645931; cv=none; b=l12WWQwUJ91e6FainDJtS8OKKjJz/WIh3oSpWPmXP0P0om0vKpk+Iue6KUFy7CpG81khrZFaWPfM37NrvGxreKjuNIZz84ar2Ph/oH/a+WhqTfDgITDZOOp4CsKzB0ZL+L7E34DAN49trfCY93kfLVK0E6NM87Lycc6u3VBMgCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645931; c=relaxed/simple;
	bh=RdyVEV9witUQiWCKmjvS5s5+mAuLhEZqVQa9JqDWC0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNmkGEtzlNfgA093d/7sOW2U1YYSZOxfMQIGkEieP0vBPpg/O2w2C68NNruEFiresNpbMp/myvCwIz7/FS6X6was50dxQ//i13vwUHAappHg4wZHG4nO8aE43whi/6b/bcg8Ei71sYyZ8NWBsCeWiYi4DWuHdyewFB6S9Wix+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB714C4CEED;
	Fri,  8 Aug 2025 09:38:47 +0000 (UTC)
Date: Fri, 8 Aug 2025 10:38:44 +0100
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
Subject: Re: [PATCH v3 3/5] asm-generic: barrier: Add
 smp_cond_load_acquire_timewait()
Message-ID: <aJXFpKEm7-abCAFc@arm.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627044805.945491-4-ankur.a.arora@oracle.com>

On Thu, Jun 26, 2025 at 09:48:03PM -0700, Ankur Arora wrote:
> diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
> index 9ea0a74e5892..f1b6a428013e 100644
> --- a/arch/arm64/include/asm/rqspinlock.h
> +++ b/arch/arm64/include/asm/rqspinlock.h
> @@ -86,7 +86,7 @@
>  
>  #endif
>  
> -#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
> +#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0ULL, 1ULL, 0)
>  
>  #include <asm-generic/rqspinlock.h>
>  
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 8299c57d1110..dd7c9ca2dff3 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -388,6 +388,28 @@ static inline u64 ___smp_cond_spinwait(u64 now, u64 prev, u64 end,
>  	(typeof(*ptr))_val;						\
>  })
>  
> +/**
> + * smp_cond_load_acquire_timewait() - (Spin) wait for cond with ACQUIRE ordering
> + * until a timeout expires.
> + *
> + * Arguments: same as smp_cond_load_relaxed_timeout().
> + *
> + * Equivalent to using smp_cond_load_acquire() on the condition variable with
> + * a timeout.
> + */
> +#ifndef smp_cond_load_acquire_timewait
> +#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
> +				       time_expr, time_end,		\
> +				       slack) ({			\
> +	__unqual_scalar_typeof(*ptr) _val;				\
> +	_val = smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
> +					      time_expr, time_end,	\
> +					      slack);			\
> +	/* Depends on the control dependency of the wait above. */	\
> +	smp_acquire__after_ctrl_dep();					\
> +	(typeof(*ptr))_val;						\
> +})
> +#endif

Using #ifndef in the generic file is the correct thing to do, it allows
architectures to redefine it. Why we have a similar #ifndef in the arm64
rqspinlock.h, no idea, none of the arm64 maintainers acked that patch
(shouldn't have gone in really, we were still discussing the
implementation at the time; I also think it's slightly wrong).

Your change above to rqspinlock.h makes this even more confusing when
you look at the overall result with all the patches applied. We end up
with the same macro in asm/rqspinlock.h but with different number of
arguments.

I'd start with ripping out the current arm64 implementation, add a
generic implementation to barrier.h and then override it in the arch
code.

-- 
Catalin

