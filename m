Return-Path: <linux-arch+bounces-12519-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAFBAEE4E6
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 18:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C9F3A4548
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97014291C05;
	Mon, 30 Jun 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="VoZvzgPS"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379C29009A;
	Mon, 30 Jun 2025 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301886; cv=none; b=vA51dUDU9bGGBX9CDSghJ5GPKc6HzLNWQyEG4dzBa9a5csEe8MUcV6MPeeUiuO3pSdgJyJ8Ov1oHFDJQhKFh9G++MBcMs9aAn13WgWpQ7mkAaY4b3Xj95FV94B9u2TrvYPntfPuvXrqDY5pYxAb3vfk84U6JHgdNjiR+ikkVi/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301886; c=relaxed/simple;
	bh=BfXV8nqJ4EJ9pAm1ijz8SPYTeiXmwHI+9FWI3o9x+xA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sm9AzbnzBf+el2HZ738JzlG79iJztnb7vNyvaO9M1AFrjUC7b1ZzplF4e+OWYQDkmw/6OcGP5w7mfIhdAtwuHzpgnzqBtvJZlgtgbM7G8JrBlb861/a1t8d8N79fPQloGKtjH4iCXpal7je7pkv3dhmW0OM9UPw3dipWNBg33mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=VoZvzgPS; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1751301223;
	bh=BfXV8nqJ4EJ9pAm1ijz8SPYTeiXmwHI+9FWI3o9x+xA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VoZvzgPSHgQz64AOBA4PTZyz7X7SB6QqJVzFGTBWN9We1UDw27WHcc32a2BX+JIRN
	 UfnaQgWCo3DgKP0YpEAm67lwobotgv3nGri4FqNmT4TeH22VyWpt7h7FJLLM2i1O6W
	 vXMpYk2kyO941eYmixOvVjyWGh4ORET2NNPiW2jI=
Received: by gentwo.org (Postfix, from userid 1003)
	id 0D18540748; Mon, 30 Jun 2025 09:33:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 0BDDB401E1;
	Mon, 30 Jun 2025 09:33:43 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:33:43 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, arnd@arndb.de, 
    catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org, 
    akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com, 
    ast@kernel.org, memxor@gmail.com, zhenglifeng1@huawei.com, 
    xueshuai@linux.alibaba.com, joao.m.martins@oracle.com, 
    boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v3 5/5] arm64: barrier: Handle waiting in
 smp_cond_load_relaxed_timewait()
In-Reply-To: <20250627044805.945491-6-ankur.a.arora@oracle.com>
Message-ID: <e2e8788d-86b4-092a-37f5-286b776cc061@gentwo.org>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com> <20250627044805.945491-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 26 Jun 2025, Ankur Arora wrote:

> @@ -222,6 +223,53 @@ do {									\
>  #define __smp_timewait_store(ptr, val)					\
>  		__cmpwait_relaxed(ptr, val)
>
> +/*
> + * Redefine ARCH_TIMER_EVT_STREAM_PERIOD_US locally to avoid include hell.
> + */
> +#define __ARCH_TIMER_EVT_STREAM_PERIOD_US 100UL
> +extern bool arch_timer_evtstrm_available(void);
> +
> +static inline u64 ___smp_cond_spinwait(u64 now, u64 prev, u64 end,
> +				       u32 *spin, bool *wait, u64 slack);
> +/*
> + * To minimize time spent spinning, we want to allow a large overshoot.
> + * So, choose a default slack value of the event-stream period.
> + */
> +#define SMP_TIMEWAIT_DEFAULT_US __ARCH_TIMER_EVT_STREAM_PERIOD_US
> +
> +static inline u64 ___smp_cond_timewait(u64 now, u64 prev, u64 end,
> +				       u32 *spin, bool *wait, u64 slack)
> +{
> +	bool wfet = alternative_has_cap_unlikely(ARM64_HAS_WFXT);
> +	bool wfe, ev = arch_timer_evtstrm_available();

An unitialized and initialized variable on the same line. Maybe separate
that. Looks confusing and unusual to me.

> +	u64 evt_period = __ARCH_TIMER_EVT_STREAM_PERIOD_US;
> +	u64 remaining = end - now;
> +
> +	if (now >= end)
> +		return 0;
> +	/*
> +	 * Use WFE if there's enough slack to get an event-stream wakeup even
> +	 * if we don't come out of the WFE due to natural causes.
> +	 */
> +	wfe = ev && ((remaining + slack) > evt_period);

The line above does not matter for the wfet case and the calculation is
ignored. We hope that in the future wfet will be the default case.

