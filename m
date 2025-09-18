Return-Path: <linux-arch+bounces-13685-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E9DB86D42
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 22:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572C1170925
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22F02E174B;
	Thu, 18 Sep 2025 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHXnZyZM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8E280A5F;
	Thu, 18 Sep 2025 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225929; cv=none; b=HbZXbSLEKrHNqLINKwNO2319IhPWt+0bxCY9AdGoxMp6BvuGYshZKuV5/+4xeEjcGFGP94EuCi4RBwNBvOd+DiyltAI5rpDkMGCWVxXmiJ1zE7QeH1hbxdHRo4N8gqiPYm012ly7AVbc5GGyYK2g8l+5Ymw1C3lOejPwIMRlIVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225929; c=relaxed/simple;
	bh=PQIMs0F7qBnCSupIdEq0faegbRGXgcQzWl1UXppJGbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnImUSR/RIAwJLuBRqZv4ofEQnMwuxQBuW5aqE8yYCv/FL4Hjmtb7VBn6wLdcbqYqRjVQ07FLEXORtKYSXc82/H1mWc3sPS1KCyW6hhT14MUkx+E+ypfEtcSjmWxY/Ycx2nFHTIF1Ki/oYcWvpoZGNsKKhRDjHwluaasPMmp6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHXnZyZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02954C4CEE7;
	Thu, 18 Sep 2025 20:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758225929;
	bh=PQIMs0F7qBnCSupIdEq0faegbRGXgcQzWl1UXppJGbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHXnZyZM8mmUiXmySeoga6YEwlAuUym90fpQsvxBtazDC9J2vBBK/2cKyENL8ZZu7
	 NyuC/fsSYikHLmuHuihMMB9G6jgy1k6E6R/xJ8DcdfGUS26EiL+MjosTAKllF7m1TY
	 Or/Wfzxgl59lHT/058iyjD8l/XIRejR8pT57ChS07D6CAA9XWqvQ8UelMJVcipOUpg
	 8owRDGRgOYOKt2HGSDMbRQCc4tV5mAe7T4V/lkdZ5jMimDyaPTmtZBtQsaI20kCCA4
	 Q5y4Ei6XDYcM90nA/5ag4RXb5hSaDJJSx15phpSANwIbrq4gv1DOnqX+aJCy0pCC95
	 kLAJU8qUUKb/A==
Date: Thu, 18 Sep 2025 21:05:22 +0100
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
Subject: Re: [PATCH v5 2/5] arm64: barrier: Add
 smp_cond_load_relaxed_timeout()
Message-ID: <aMxmAuK-adVaVezk@willie-the-truck>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-3-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911034655.3916002-3-ankur.a.arora@oracle.com>

On Wed, Sep 10, 2025 at 08:46:52PM -0700, Ankur Arora wrote:
> Add smp_cond_load_relaxed_timeout(), a timed variant of
> smp_cond_load_relaxed().
> 
> This uses __cmpwait_relaxed() to do the actual waiting, with the
> event-stream guaranteeing that we wake up from WFE periodically
> and not block forever in case there are no stores to the cacheline.
> 
> For cases when the event-stream is unavailable, fallback to
> spin-waiting.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Haris Okanovic <harisokn@amazon.com>
> Tested-by: Haris Okanovic <harisokn@amazon.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/arm64/include/asm/barrier.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index f5801b0ba9e9..4f0d9ed7a072 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -219,6 +219,29 @@ do {									\
>  	(typeof(*ptr))VAL;						\
>  })
>  
> +/* Re-declared here to avoid include dependency. */
> +extern bool arch_timer_evtstrm_available(void);
> +
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
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

It'd be an awful lot nicer if we could just use the generic code if
wfe isn't available. One option would be to make that available as
e.g. __smp_cond_load_relaxed_timeout_cpu_relax() and call it from the
arch code when !arch_timer_evtstrm_available() but a potentially cleaner
version would be to introduce something like cpu_poll_relax() and use
that in the core code.

So arm64 would do:

#define SMP_TIMEOUT_SPIN_COUNT	1
#define cpu_poll_relax(ptr, val)	do {				\
	if (arch_timer_evtstrm_available())				\
		__cmpwait_relaxed(ptr, val);				\
	else								\
		cpu_relax();						\
} while (0)

and then the core code would have:

#ifndef cpu_poll_relax
#define cpu_poll_relax(p, v)	cpu_relax()
#endif

and could just use cpu_poll_relax() in the generic implementation of
smp_cond_load_relaxed_timeout().

Will

