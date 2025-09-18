Return-Path: <linux-arch+bounces-13682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BA6B86BAA
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 21:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6273B90B4
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 19:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5302E11D5;
	Thu, 18 Sep 2025 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTraG5KV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC52D374D;
	Thu, 18 Sep 2025 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224569; cv=none; b=kYbJkLAg1wgDNQel6cCAjROwaRCdn6JE3w3KQpAY5zF7gpFQa1CyPNgTcQEIpCHQAvJjgOBP3ZuuC4teF1NqZykeML3ASJXT8YTyew/YH4I0dowJ/rypcCr3r9YO7kIKdrpZyBkBr8++FGOTzc4fJgi3CMdvo70QA3UKSFQh6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224569; c=relaxed/simple;
	bh=80s6EU2PHaHFue3+G09GZK98h4BmkrZlLT7WXXnyY3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV1HOgPzTkFwSQt1x6zK5fyAjrOw/dlSmaAI9denrwZZXOqCzMVVGCBEsaEWxIA/LKiAb1SdpGesyT1VNskzGTwCUx0nMsafXhc/xdhKFUSAA4m6tinRhXmnBgins1jSUrGg5u5iUYrA8UzMORdiOSZ+cuSZnh2N2KKvKF5uRjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTraG5KV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B097EC4CEE7;
	Thu, 18 Sep 2025 19:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758224569;
	bh=80s6EU2PHaHFue3+G09GZK98h4BmkrZlLT7WXXnyY3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTraG5KVrM9q6OFeTaJV+aEPHYI4rOJGKWFXc93LgVImNtlkPgm9zsOGuGnOa46An
	 Vs2IWSrfYN1Hxy4jgIwOt+xJx6xfEBkTwz76KbwcgF06E7Cn2LOMUL5oQJgnttZAUV
	 H8bm/SlxpbZ/w/pOHI7Zv/LyEadATKp1Iy3JkCdgq2NG2U73Tf4Oij1lm/XdBwLwLT
	 s9oen8O3FEewQaM4Z3/KaMkTCbAxT/1MwRd80sxjk/KIlPmhuZh9R/H8y1fg0ZWask
	 5kMVtaKYZ7JnQuXNY47clmxnGRb0n3j5Rcy5f9CQULBpe5y6gTroM9iIaQkniXGMdW
	 66+L4fidi7h3A==
Date: Thu, 18 Sep 2025 20:42:42 +0100
From: Will Deacon <will@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, catalin.marinas@arm.com, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Message-ID: <aMxgsh3AVO5_CCqf@willie-the-truck>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911034655.3916002-2-ankur.a.arora@oracle.com>

On Wed, Sep 10, 2025 at 08:46:51PM -0700, Ankur Arora wrote:
> Add smp_cond_load_relaxed_timeout(), which extends
> smp_cond_load_relaxed() to allow waiting for a duration.
> 
> The additional parameter allows for the timeout check.
> 
> The waiting is done via the usual cpu_relax() spin-wait around the
> condition variable with periodic evaluation of the time-check.
> 
> The number of times we spin is defined by SMP_TIMEOUT_SPIN_COUNT
> (chosen to be 200 by default) which, assuming each cpu_relax()
> iteration takes around 20-30 cycles (measured on a variety of x86
> platforms), amounts to around 4000-6000 cycles.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Haris Okanovic <harisokn@amazon.com>
> Tested-by: Haris Okanovic <harisokn@amazon.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  include/asm-generic/barrier.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21d..8483e139954f 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -273,6 +273,41 @@ do {									\
>  })
>  #endif
>  
> +#ifndef SMP_TIMEOUT_SPIN_COUNT
> +#define SMP_TIMEOUT_SPIN_COUNT		200
> +#endif
> +
> +/**
> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> + * guarantees until a timeout expires.
> + * @ptr: pointer to the variable to wait on
> + * @cond: boolean expression to wait for
> + * @time_check_expr: expression to decide when to bail out
> + *
> + * Equivalent to using READ_ONCE() on the condition variable.
> + */
> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
> +({									\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	u32 __n = 0, __spin = SMP_TIMEOUT_SPIN_COUNT;			\
> +									\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_relax();						\
> +		if (++__n < __spin)					\
> +			continue;					\
> +		if (time_check_expr)					\
> +			break;						\

There's a funny discrepancy here when compared to the arm64 version in
the next patch. Here, if we time out, then the value returned is
potentially quite stale because it was read before the last cpu_relax().
In the arm64 patch, the timeout check is before the cmpwait/cpu_relax(),
which I think is better.

Regardless, I think having the same behaviour for the two implementations
would be a good idea.

Will

