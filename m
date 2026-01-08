Return-Path: <linux-arch+bounces-15718-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04277D0657F
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 22:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D02993033704
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 21:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C53329C49;
	Thu,  8 Jan 2026 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEvhVbYG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16153B28D;
	Thu,  8 Jan 2026 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767908187; cv=none; b=LFcsefuFA9EV4QV0eVJpuJrRXnhQaBjFUgbqjQF2jhDGFbGmi7G5Njs9BRo71+RxIO3pdD/Rch9Y13DFoLikXttcDI6bsdrAYmqKGBjCV5C+s3ieClouKxqfreddzb8vyRdcIgBX9Hw4B+i8cCt40Akrq5zMvxzwe/x1sEk42Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767908187; c=relaxed/simple;
	bh=696IrOu76SRxS3ELMb4EMuTyFrySf8d6GgyT3GbkOtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZON8AnOoqyvmagobHX+stflkTj5hviP39LCTTD14uxM8DgHJ58F/5mGOuuLXmUwICcCdTD3BXZakFG6kKdqRwIJNW4MylC0qcoQ03hh+r6diLlAVBgD3CQjxMkM0R//nOxR96fVw2CNJMYXOJBvDiwtlkZrZaZL3ibawiLj1dxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEvhVbYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB7AC116C6;
	Thu,  8 Jan 2026 21:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767908186;
	bh=696IrOu76SRxS3ELMb4EMuTyFrySf8d6GgyT3GbkOtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEvhVbYGzHaylLZ3smRb3VqvIOtYSaxbNOfYNnCKsrIfCEm/0stGFamSf4nPTK0cD
	 tl7y3UnHIp41qrwJXE3Q3pYCLRmJ9GadkWivw/kCsGnP2fv/Ch794cAK/nSu+TK+wL
	 CCtpT5RnLiiEyiwOtHvZ+BcZyuEZ9pv6pAPaCu5ZsSFeYbzy60s1rRF8wk6BRHGbNc
	 SYTGlJu9YRBBmZz0iV4froHl59Wc1g7PbOLQCRHbBkQYxf3M1Rp2fbnJJDq48Yl9Se
	 rFER0DCrMr6yPP8W4Ufm6UFgy0YOz7in6dq5BVR1hs8AJKdsfRMkrKDOFqvxChKHFP
	 FrlKvzl+xdIjA==
Date: Thu, 8 Jan 2026 21:36:19 +0000
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
Subject: Re: [PATCH v8 02/12] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
Message-ID: <aWAjU_QS7kwcyCse@willie-the-truck>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-3-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215044919.460086-3-ankur.a.arora@oracle.com>

On Sun, Dec 14, 2025 at 08:49:09PM -0800, Ankur Arora wrote:
> Support waiting in smp_cond_load_relaxed_timeout() via
> __cmpwait_relaxed(). To ensure that we wake from waiting in
> WFE periodically and don't block forever if there are no stores
> to ptr, this path is only used when the event-stream is enabled.
> 
> Note that when using __cmpwait_relaxed() we ignore the timeout
> value, allowing an overshoot by upto the event-stream period.
> And, in the unlikely event that the event-stream is unavailable,
> fallback to spin-waiting.
> 
> Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check in
> each iteration of smp_cond_load_relaxed_timeout().
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
> 
> Notes:
>    - cpu_poll_relax() now takes an additional parameter.
> 
>    - added a comment detailing why we define SMP_TIMEOUT_POLL_COUNT=1 and
>      how it ties up with smp_cond_load_relaxed_timeout().
> 
>    - explicitly include <asm/vdso/processor.h> for cpu_relax().
> 
>  arch/arm64/include/asm/barrier.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 9495c4441a46..6190e178db51 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -12,6 +12,7 @@
>  #include <linux/kasan-checks.h>
>  
>  #include <asm/alternative-macros.h>
> +#include <asm/vdso/processor.h>
>  
>  #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
>  #define nops(n)		asm volatile(__nops(n))
> @@ -219,6 +220,26 @@ do {									\
>  	(typeof(*ptr))VAL;						\
>  })
>  
> +/* Re-declared here to avoid include dependency. */
> +extern bool arch_timer_evtstrm_available(void);
> +
> +/*
> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
> + * for the ptr value to change.
> + *
> + * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
> + * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
> + * time-check in each iteration.
> + */
> +#define SMP_TIMEOUT_POLL_COUNT	1
> +
> +#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
> +	if (arch_timer_evtstrm_available())				\
> +		__cmpwait_relaxed(ptr, val);				\
> +	else								\
> +		cpu_relax();						\
> +} while (0)

Acked-by: Will Deacon <will@kernel.org>

Will

