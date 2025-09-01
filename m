Return-Path: <linux-arch+bounces-13347-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42BB3E1F8
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 13:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0D53B478D
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 11:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88712517AA;
	Mon,  1 Sep 2025 11:47:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FCE2556E;
	Mon,  1 Sep 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727250; cv=none; b=a5QdnDuzZPL0bHk+A/sw+twH35hUCopSVmAhgvvN9M5GiuNo82q7f1h9B43FvYjItWNi2WsdwlGs/jRWu9qj/9Y1NC4Eb9sldMKyTprwag+QBvzCgUct5d8+CdyprS7mGikGyvmV6tBtlgqPQ+SnllnOvWnPlq2GNrgLxhj0X50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727250; c=relaxed/simple;
	bh=tFionfIMj0aSS0RmvX+tE6TywOORduMBpmk2bOJR4vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGEWDSzhZxrCXz04inYMpUFEGu5+2UUFbLnS1N0DX9yw/5kqcRVk7rqRnhnpR3ToSWryTWi6kD2vW+i1pNaWkLLl2Dem4D1a9jbfhRECEpBPzZDrua7+kwB6Ju3IHPMn+b7kmIzvXhQ5XYhUz+sd9PI2q9bTNPAzTB2RV+f3Mo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A105C4CEF0;
	Mon,  1 Sep 2025 11:47:26 +0000 (UTC)
Date: Mon, 1 Sep 2025 12:47:24 +0100
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
Subject: Re: [PATCH v4 2/5] arm64: barrier: Add
 smp_cond_load_relaxed_timewait()
Message-ID: <aLWHzEAx_-BozA4V@arm.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <20250829080735.3598416-3-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829080735.3598416-3-ankur.a.arora@oracle.com>

On Fri, Aug 29, 2025 at 01:07:32AM -0700, Ankur Arora wrote:
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index f5801b0ba9e9..9b29abc212db 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -219,6 +219,28 @@ do {									\
>  	(typeof(*ptr))VAL;						\
>  })
>  
> +extern bool arch_timer_evtstrm_available(void);

In theory, this doesn't work if CONFIG_ARM_ARCH_TIMER is disabled,
though that's not the case for arm64. Maybe add a short comment that's
re-declared here to avoid include dependencies.

> +
> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr, time_check_expr)	\
> +({									\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	bool __wfe = arch_timer_evtstrm_available();			\
> +									\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		if (time_check_expr)					\
> +			break;						\
> +		if (likely(__wfe))					\
> +			__cmpwait_relaxed(__PTR, VAL);			\
> +		else							\
> +			cpu_relax();					\
> +	}								\
> +	(typeof(*ptr)) VAL;						\
> +})
> +
>  #include <asm-generic/barrier.h>
>  
>  #endif	/* __ASSEMBLY__ */

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

