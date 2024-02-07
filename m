Return-Path: <linux-arch+bounces-2112-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A484D84CB92
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 14:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75431C2158B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E324276C98;
	Wed,  7 Feb 2024 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cZxdnFNj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0813776057;
	Wed,  7 Feb 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312593; cv=none; b=V9rLdjMh/Umm/2R5P+2ygE9GMQOulO/WNNGzxSO2XZfyB76//6kEm5wD/QBjusswCeS20Ng0s9aVief2gxDczsRcAQXnCLE/AKqywuHxQfapT07lYDTr9xjd9v109UdFLcfiGV1lcCXqcCVfYwKzULM3jaqGv9KefgAicQj+kWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312593; c=relaxed/simple;
	bh=GOVzmtWSf66S4P82oUwpsGJAlkj0KnTZycg0imHhp4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTAiST6W68nvuj1Mts8YxRNnYXixQ1yCgbL12kZUrQlCR+koZq7JCnpb6l46QFHuaP3CjGhVFCs2NR+5Wj461SlTsjZax0V9fefReGU7R5UmY+xH10e3tVxRzGpmMlTe6Z2TTpvLxoS++mHClLdfxEs6Y0UtG1AvICiH1/pOYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cZxdnFNj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9250040E016D;
	Wed,  7 Feb 2024 13:29:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1JezrvZZ9vpp; Wed,  7 Feb 2024 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707312586; bh=cq31hkoyQSWq8+AdjDLIdicd23/yb2pyABjFoySQ434=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZxdnFNj1RRZ8qo48nykAUGkBFTwZDESkMk3QDKq3It+3g304jQrXfl00+SFTSVmi
	 FDQBOGjKsNb6luVHSPtL1GQjPRjZs7J7lxT23EOXKrmTHO/vOERNtcaqPdWjziL79f
	 hukqyXdUH2PYhu5ObSzQutXPKMzr2SE8yTP7s3SrSrF8jXrhLUvvoI2+j0Ud1AmxRH
	 cQN8ZXAUyuVyyVXyX+/8fLCZ+6Gc9zRjtxfoYUQwv2nCpfO2HfIa8/D1rMU5zMTqzl
	 UrVGjjFP8fhBeo4BAcKnGHc0KsbeRGNe1rvMwceDTn5p4khbEPEWRQKgUgNFVvJa8J
	 S1EqAdQSM14B/5FkIEvfzjIINi+cwla7U0qoWdtCaWWcYa8UxG6u83ob3As3YjsANb
	 +dv5hKUKpnXMvT+xyhP2BK3wNms3birB9r//n40t7jrzImgLICU1d/79VNfOa90I+w
	 +f2IJUo565VMRqz8vl6L7CvsW7+9ile5spDqEoYwzcDQsZmk1ASzNRDswsFGe3GMYs
	 bNC0Pl/B18tkGOjuaLnUTCfR+utkE/z79Syjr1JlhD6gAxhH99EGj3Y67Jzj/Pup4h
	 EIlJ7nm5slsbPM7VVR/JCOK4fSi4qvg4H9M8iriA/B1D3/L0NzPQandrNxaJ9eIebo
	 uOaMR7qrZ/p1m0VqXf2sJMGY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05BF140E0192;
	Wed,  7 Feb 2024 13:29:27 +0000 (UTC)
Date: Wed, 7 Feb 2024 14:29:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 06/19] x86/startup_64: Drop global variables keeping
 track of LA57 state
Message-ID: <20240207132922.GSZcOFspSGaVluJo92@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-27-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129180502.4069817-27-ardb+git@google.com>

On Mon, Jan 29, 2024 at 07:05:09PM +0100, Ard Biesheuvel wrote:
>  static inline bool pgtable_l5_enabled(void)
>  {
>  	return __pgtable_l5_enabled;
>  }
>  #else
> -#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
> +#define pgtable_l5_enabled() !!(native_read_cr4() & X86_CR4_LA57)
>  #endif /* USE_EARLY_PGTABLE_L5 */

Can we drop this ifdeffery and simply have __pgtable_l5_enabled always
present and contain the correct value?

So that we don't have an expensive CR4 read hidden in
pgtable_l5_enabled()?

For the sake of simplicity, pgtable_l5_enabled() can be defined outside
of CONFIG_X86_5LEVEL and since both vendors support 5level now, might as
well start dropping the CONFIG ifdeffery slowly...

Other than that - a nice cleanup!

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

