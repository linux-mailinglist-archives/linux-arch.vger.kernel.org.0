Return-Path: <linux-arch+bounces-2181-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B00C8510D5
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 11:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E35C1C220EF
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777418021;
	Mon, 12 Feb 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ewZU95JZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D2179B8;
	Mon, 12 Feb 2024 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733774; cv=none; b=EttkAj+zji33FwdqQgP75l63Fot0DVD2AytoX6yAJnCmpar11x26oBNJS8XTYIchOotywXCjaXvoCw2fYrvuXohpYlgVMuiHdNsJqt20+mnLGWnnEm4ljpdf6nAkCI9E+YPUbwcJ0iyZwi3nWqhfoHY44NBnUfHsU5PvQri2nYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733774; c=relaxed/simple;
	bh=lM1ikn/+ntRnbPmGODrfBa9eMNqWS/z2GjeqQpt4V0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqG8JbQ/Us0RtJAH6gJDUbU+Xm73c40s7MSP1TSrPyV2SLSK1j02t+XBqatSuMBqMmhHYuR9XZf1KB6hrDUqjL4UCm4dMIVA5gJoNlyzLVbZUCY7ZvTCA9Bv32hakX0l77A/TXrTkFHAG8mDKmavfIYaoIsO7q/06JF6gdwg8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ewZU95JZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 54CE940E01A9;
	Mon, 12 Feb 2024 10:29:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Qfqc-ypnMKxE; Mon, 12 Feb 2024 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707733765; bh=8zzxZzAd70wLVlqCQfwTbwt/dFp7veEPvkKLq3mmCGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewZU95JZ5AgG6rZJLPSyQ4+uco/ylQ/tMZeYqEi7wKs9BhYt/fG7UUUw5O9c+EANz
	 PSom6AgWUMW2IS8WNEUftXLmPq3pN41pcL/lPl3Gs6sVikGhK3Uv147SDRM8qFdvI6
	 O4ICiy7mrjH18ayfOBcEHRXSI6KU7zjCK+FPdkrx5XyyVDvrNUmK2FIFkjCrUY9t07
	 nvzxQimDDhYzoLZ/30kpmiOwB5+s5SJLLA0GPjtbH2OhEd6GpQvU2vLDKH5OACoh1G
	 x6of9WfDLm8z5xPXQIpU5179BSwfJtwmo/F5n+6nHTVmrW2ALHtwLNfqohPSK3dJex
	 6mv7RMbVLCXcVyjluiK0DvUKxPZQJX35vKF2OgcMN8GTmDVlu+J/P8efvxpIzznLs5
	 rSdU+n7H8mrAxoeQFuNMu3BI9kHDsGDETqPzTo1hCZU6qiXdg/ThRjEoX/Tb/EvajN
	 MDn4GSgKo/gzOq5gv9mJ8vEjCA+/zEBCindjhc+OeCGhW1bIBjK1hsHd3hKxmzky79
	 fYJiCPIT3BcOQJ7wOUlO0HtgmUFu/x4VyJL+53TbPc3MTLnVijXoCKik3ByfmwzdLN
	 vFdwoJq+FzycmgelzaQn/+VPw3wnvDRgmxWLpW74v7xdmEab8qX0+E4Pv6uzS4FS+l
	 1ln5F/fr/a3P8lcfbf0/v0YQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5EF940E0192;
	Mon, 12 Feb 2024 10:29:07 +0000 (UTC)
Date: Mon, 12 Feb 2024 11:29:01 +0100
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
Subject: Re: [PATCH v3 08/19] x86/head64: Replace pointer fixups with PIE
 codegen
Message-ID: <20240212102901.GVZcny7WeK_ZWt0HEP@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-29-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129180502.4069817-29-ardb+git@google.com>

On Mon, Jan 29, 2024 at 07:05:11PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Some of the C code in head64.c may be called from a different virtual
> address than it was linked at. Currently, we deal with this by using

Yeah, make passive pls: "Currently, this is done by using... "

> ordinary, position dependent codegen, and fixing up all symbol
> references on the fly. This is fragile and tricky to maintain. It is
> also unnecessary: we can use position independent codegen (with hidden
		   ^^^
Ditto: "use ..."

In the comments below too, pls, where it says "we".

> visibility) to ensure that all compiler generated symbol references are
> RIP-relative, removing the need for fixups entirely.
> 
> It does mean we need explicit references to kernel virtual addresses to
> be generated by hand, so generate those using a movabs instruction in
> inline asm in the handful places where we actually need this.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/Makefile                 |  8 ++
>  arch/x86/boot/compressed/Makefile |  2 +-
>  arch/x86/include/asm/desc.h       |  3 +-
>  arch/x86/include/asm/setup.h      |  4 +-
>  arch/x86/kernel/Makefile          |  5 ++
>  arch/x86/kernel/head64.c          | 88 +++++++-------------
>  arch/x86/kernel/head_64.S         |  5 +-
>  7 files changed, 51 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 1a068de12a56..2b5954e75318 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -168,6 +168,14 @@ else
>          KBUILD_CFLAGS += -mcmodel=kernel
>          KBUILD_RUSTFLAGS += -Cno-redzone=y
>          KBUILD_RUSTFLAGS += -Ccode-model=kernel
> +
> +	PIE_CFLAGS-$(CONFIG_STACKPROTECTOR)	+= -fno-stack-protector

Main Makefile has

KBUILD_CFLAGS += -fno-PIE

and this ends up being:

gcc -Wp,-MMD,arch/x86/kernel/.head64.s.d -nostdinc ... -fno-PIE ... -fpie ... -fverbose-asm -S -o arch/x86/kernel/head64.s arch/x86/kernel/head64.c

Can you pls remove -fno-PIE from those TUs which use PIE_CFLAGS so that
there's no confusion when staring at V=1 output?

> +	PIE_CFLAGS-$(CONFIG_LTO)		+= -fno-lto
> +
> +	PIE_CFLAGS := -fpie -mcmodel=small $(PIE_CFLAGS-y) \
> +		      -include $(srctree)/include/linux/hidden.h
> +
> +	export PIE_CFLAGS
>  endif
>  
>  #

Other than that, that code becomes much more readable, cool!

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

