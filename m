Return-Path: <linux-arch+bounces-2557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F285D68C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EB61C22BC6
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C053F9CE;
	Wed, 21 Feb 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LzqgQM4K"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746D3F8D1;
	Wed, 21 Feb 2024 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513996; cv=none; b=VO2qSQ1qXmvUp7DjQ634/M2Kyc+nUcvdl+Runq0qxmFzecCp0oiSbgkpzm6yOHnZtj6rf2BWJ03PZZZTB42sOgnx1+1siGxb0WU6m5up7y4n4s78KbB1StIthV1UdlwROLMp6IKlMqlJv80T9FQ/TZPBNzW7cxglTKHPsrCF7xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513996; c=relaxed/simple;
	bh=R3ecc9Ts/GBCtJBRYSv0uTYkBoX57GTw7u+YuZof/bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2IRQbWbK1Gjvf6k06Zlj5Zl8H0hZQlkr64Sn+AOa7O/Ll4qhoqslMs6itrkNJADob+7bdx+V+LJ5hAB9dG3FSuW+ICT3G9tVPoXP9MV3e5MdH2eczhEs3fmhlpuQMqlwPnNpVP3P9kl+vkl5+Ok5rKQGIsLHhwWtOSG4T+G/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LzqgQM4K; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 51FB240E01B5;
	Wed, 21 Feb 2024 11:13:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VdnO9hExmfTW; Wed, 21 Feb 2024 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708513988; bh=7D8KBxpM5jnl/zzwxkSLq6PL9JPAOEgY2PxHWbXhgiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzqgQM4KGPs5IzmlSorvL/Z7yygSU+rwzx5loPMC9AwBOl9uQEJhka2HjkKcF5n7n
	 id5PdJ9XtKd7TzYF2vSua8rlkl4/wEnb8ukyh0am3Seeb2qX0wDaLq72fMij46I7nt
	 gB/RiHyucUBgdou2TVzcwQkfHmn5O1B7r5W1I3K8f0f5voUbnOyvpiyfL8Xx4b5/wB
	 XfEIw+hCAUTbYfikWWevSUgIY/0GC233n+QW4ndvUKhNMuTaMz+Z4m4qevwBSwB29Q
	 ogB6w4vcsZx8uXJ6hyX/5caPUAlQpA9VSzkiaXibZqVM76n2lW4y4/Oglkzv4KIBH7
	 fORcx+6MKrHpn/4z1D6Ukfy3CSxHW+1ZpI62JsQMSh1AxQ5ur6HtOYJ5QNLPmxrD8N
	 k0kunkX7+Wfoy4308jKHyDeHQ5PUKBy7S90M8UXZ3ONWHC+OjdH5jmPpjq9E+47csS
	 zY14zTpg4nf4IMVXSwSLZbR6kr3exw4lE1JggQAePLhTr83h3LFcAz/hN3j5/soLHE
	 GShxMWCpap4JX55etqbIq8GB7EZwGa4SN1NNHbwmOZ5+rh/mcG4z4CfZyb27nxdiRy
	 Nc74tSXYfN75rkK0X+dBz7wl6Vgn5HKqJg3XM3ZTJSVqxp46OIdrb1sUSzLdgk0KtR
	 R7BziJRebUQuaaod+gGCoB1g=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE42340E01A9;
	Wed, 21 Feb 2024 11:12:50 +0000 (UTC)
Date: Wed, 21 Feb 2024 12:12:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>,
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
Subject: Re: [PATCH v4 04/11] x86/startup_64: Defer assignment of 5-level
 paging global variables
Message-ID: <20240221111245.GDZdXarZsZd7eZw_BK@fat_crate.local>
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-17-ardb+git@google.com>
 <20240220184513.GAZdTzOQN33Nccwkno@fat_crate.local>
 <CAMj1kXF=cGHR4FVUqGrobjB4HxTmm=1upn3TpVEC-_8D9GM=uQ@mail.gmail.com>
 <20240221100916.GCZdXLzHb-31GMw-f-@fat_crate.local>
 <CAMj1kXGqHf3b3zho_0CPccTkgXRnTrxsG_qDjhP9P+US-u2AGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGqHf3b3zho_0CPccTkgXRnTrxsG_qDjhP9P+US-u2AGw@mail.gmail.com>

On Wed, Feb 21, 2024 at 11:20:13AM +0100, Ard Biesheuvel wrote:
> Just the below should be sufficient
> 
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -22,7 +22,7 @@ typedef struct { pteval_t pte; } pte_t;
>  typedef struct { pmdval_t pmd; } pmd_t;
> 
> -#ifdef CONFIG_X86_5LEVEL
>  extern unsigned int __pgtable_l5_enabled;
> 
> +#ifdef CONFIG_X86_5LEVEL
>  #ifdef USE_EARLY_PGTABLE_L5

Perhaps but the CONFIG_X86_5LEVEL ifdeffery is just ugly and getting
unnecessary.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

