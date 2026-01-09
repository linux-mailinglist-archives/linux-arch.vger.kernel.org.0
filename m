Return-Path: <linux-arch+bounces-15725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CA1D0A996
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 15:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DFCA307CA54
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E103535E537;
	Fri,  9 Jan 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF2XfVts"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6523D7F0;
	Fri,  9 Jan 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968263; cv=none; b=Eq9x7nR5Vk/fwFQn0fPDF67cyI6fM5yoymxkdFzrrFq/e31ceeECqGsP0vj+rVMLgbhSfXq5rxnxQvFShyNQ6aENPNEx/7wpK4oIEtnn/lOrU7GdMnepGNDCGs/iGJz2lTJfzrjSzTwOoKuQtlHQPkag8ReUBMwvgXt6NjtQ53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968263; c=relaxed/simple;
	bh=vd6qb39sTCFIUF7Ocpe41fwG41sMttVN9wEPA6KuLdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1193g285H/0fsYxiORr+aYT5hd7Ee3m8w1sjKKkl8cLFwfkGKMhksJtsg4EMu2RUlY+TfOk7E46alMCTlQhx/YG4mf8uB+lB6kdg9xDS/5snmc3PUy17uxMxmhxSEhLppGmgwIciG8b1oDikDv/oQ8obxB+YV2Mx0gfrwco9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF2XfVts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557A6C4CEF1;
	Fri,  9 Jan 2026 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767968263;
	bh=vd6qb39sTCFIUF7Ocpe41fwG41sMttVN9wEPA6KuLdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VF2XfVtsVmxwgr7tNzF6S0PyJO39O2U1i8oLEPbI9UicTnmj3CA3DCV/TKVdUCS64
	 ZkHCVp44eV2grPDXSkPW0Z8aG9vRddVH/p63dPSSd1ph33FncCIEKGEERzrS+UCV0p
	 Hnz3RKFUrv5pBvfPwvMQ+T+r1fBA5T34KRTqeumkeQbSZJxmj4YF7VJ5f3n8LlDkMc
	 C6giBS8IyHow7R+YXARHYsLkXqbK9nuhk/uqP05QmbfwJzU2AkePgc/+aUvppcqSXY
	 rvyubWUR7Z93PsF2dmIviy3JmsFvfdonb57CEtEhrYqRj+k1Ez9FiXjjOTHgNwrIEz
	 TbSJm+pyb+0+w==
Date: Fri, 9 Jan 2026 14:17:36 +0000
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
Message-ID: <aWEOALG07jHC_oHC@willie-the-truck>
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
> Extend __cmpwait_relaxed() to __cmpwait_relaxed_timeout() which takes
> an additional timeout value in ns.
> 
> Lacking WFET, or with zero or negative value of timeout we fallback
> to WFE.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/arm64/include/asm/barrier.h |  8 ++--
>  arch/arm64/include/asm/cmpxchg.h | 72 ++++++++++++++++++++++----------
>  2 files changed, 55 insertions(+), 25 deletions(-)

Sorry, just spotted something else on this...

> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 6190e178db51..fbd71cd4ef4e 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -224,8 +224,8 @@ do {									\
>  extern bool arch_timer_evtstrm_available(void);
>  
>  /*
> - * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
> - * for the ptr value to change.
> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
> + * __cmpwait_relaxed_timeout() for the ptr value to change.
>   *
>   * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
>   * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
> @@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
>  #define SMP_TIMEOUT_POLL_COUNT	1
>  
>  #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
> -	if (arch_timer_evtstrm_available())				\
> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
> +		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
> +	else if (arch_timer_evtstrm_available())			\
>  		__cmpwait_relaxed(ptr, val);				\

Don't you want to make sure that we have the event stream available for
__cmpwait_relaxed_timeout() too? Otherwise, a large timeout is going to
cause problems.

Will

