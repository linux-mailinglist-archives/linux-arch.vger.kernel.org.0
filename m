Return-Path: <linux-arch+bounces-15717-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 771BCD0656A
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 22:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6A543012E84
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 21:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8B328B6C;
	Thu,  8 Jan 2026 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6S6ftNb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD36284B58;
	Thu,  8 Jan 2026 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767908153; cv=none; b=JlgjZckWdC5zo1JqZxa8+m5EvWGgXu9qepF12T9YhJV02QYny5c9WLQJpSNl81uiGjqmtgnwyqlZJWLSlHa8AN4I0snAUIFbdPucJLl/zCyD6JuwCZbhZVeDNv0rmkeFiORrLe0rmFzd3JsSI43D6yTMmLZI/HkvAFcR7Y/hAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767908153; c=relaxed/simple;
	bh=RYTc/j72DSJS6wvoSkh81+TKqgFZgRCTQkO2un1ijM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBoiPOXYtBkI1/+e1AuGZNwtpk+6DHHbB0+g2iHem812/14SnyLsCUUl+U2Z5jDnzdDFHZXrUrMO2UeycohB/Xg6/DLbG1xPRDMIDaSuFfh+2rJ7YZWUjCVFNp3DhNKRg+tXjkkHOhhlxdx40Eg19uj9lVA7+IbDH70xyHf0MDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6S6ftNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB41C116C6;
	Thu,  8 Jan 2026 21:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767908153;
	bh=RYTc/j72DSJS6wvoSkh81+TKqgFZgRCTQkO2un1ijM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6S6ftNbmXXW0NysORAKoesBalPZCAHs3vhEl1XKviZ8aGUT+rkYbX+89sY1BH6Bu
	 IDuaw5rtrfiadKN9BlQdam9Vv9jp3Goe8wpCMxsOugTx3KsG/drreadnhAfoiCOPkQ
	 J+r6EYbK72MpG+7aSljrzhCKyvgrVLXfAd0hAIRWRpsD7v3c90oczl4D0U/LYegu/i
	 sKBmG632pcGxeyceXA2jEYF/+QZdSS5yQv6Dduhpb+dCeH6lA4sziidz9QIKST3peM
	 RciUgkFv1yKETzqr3mr/SPoDiKjV7xPdrnnpoqsb9cCZTjjUvCXkN2QsY7NodcrDjQ
	 ByslcFSRZ9xvQ==
Date: Thu, 8 Jan 2026 21:35:45 +0000
From: Will Deacon <will@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 04/12] arm64: support WFET in
 smp_cond_relaxed_timeout()
Message-ID: <aWAjMbSqN2g7v58Z@willie-the-truck>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-5-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215044919.460086-5-ankur.a.arora@oracle.com>

On Sun, Dec 14, 2025 at 08:49:11PM -0800, Ankur Arora wrote:
> +#define __CMPWAIT_CASE(w, sfx, sz)						\
> +static inline void __cmpwait_case_##sz(volatile void *ptr,			\
> +				       unsigned long val,			\
> +				       s64 timeout_ns)				\
> +{										\
> +	unsigned long tmp;							\
> +										\
> +	if (!alternative_has_cap_unlikely(ARM64_HAS_WFXT) || timeout_ns <= 0) {	\
> +		asm volatile(							\
> +		"	sevl\n"							\
> +		"	wfe\n"							\
> +		"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
> +		"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
> +		"	cbnz	%" #w "[tmp], 1f\n"				\
> +		"	wfe\n"							\
> +		"1:"								\
> +		: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
> +		: [val] "r" (val));						\
> +	} else {								\
> +		u64 ecycles = arch_timer_read_counter() +			\
> +				NSECS_TO_CYCLES(timeout_ns);			\
> +		asm volatile(							\
> +		"	sevl\n"							\
> +		"	wfe\n"							\
> +		"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
> +		"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
> +		"	cbnz	%" #w "[tmp], 2f\n"				\
> +		"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
> +		"2:"								\
> +		: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
> +		: [val] "r" (val), [ecycles] "r" (ecycles));			\
> +	}									\

Why not have a separate helper for the WFXT version and avoid the runtime
check on timeout_ns?

Will

