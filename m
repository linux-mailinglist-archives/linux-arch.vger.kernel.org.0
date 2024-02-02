Return-Path: <linux-arch+bounces-2004-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD1B84754F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 17:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A0CB27C65
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8E11487DD;
	Fri,  2 Feb 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG3aw7tl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EEB1487C8;
	Fri,  2 Feb 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892482; cv=none; b=l8l25wJ26JQLsW86D12G/IyY5ecfl6PNDHDkimBYQzfecXi+MEjZT3nOwBgNWelq44KlezKu/at82B024KU+3qtnKIi+YizeTjrSSal4KTjF05PLvtsoakqH9J5pYb5zSTq8HhP4wyb5C6IaTsL0KCglkCckrLFUalp+8UC2GmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892482; c=relaxed/simple;
	bh=JgopPRZDkeJ504qLn52YYKQiMJtnK8wjFyuPtWnOKXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sc1dXvJoRy2Lxql6Pd2nT68Vh9QiIxgoFBpiJhoDwgVRmU8itH/+E5DvKQhcmw5ctW/K3iwY3zQjmYY4DMOPo12nDQfgUz+OxWaHuqpLiTEvYOj8clx9P14XQisj+gFnBB0kEAgaiVO2BN1btmTBNM3VdJjaL+zKeYyIN+mmlEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG3aw7tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198B0C43394;
	Fri,  2 Feb 2024 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892482;
	bh=JgopPRZDkeJ504qLn52YYKQiMJtnK8wjFyuPtWnOKXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PG3aw7tlJMXVaQLCoRJvFQ0dpWlFwC+WdreweqFU8VlB6NboUZYW9T+Ra0qe/uXxw
	 5E03RwldmMVSY1dFX+Lmi7b5uBW7xTr/pGHJpSvKSIj96nYg6JSj2WSRxJRJuS1+R/
	 YfX+zke7lP8UbQN6Qz2FX1eGzuMR36BBmaEre5E8JZCUkcjYDs48y0VWMNQGxQVse1
	 MMXuTYOkg7aSvHf2Z40+6tBaSgghK7Yj+R86rBpwpGseUxbM6846BNb+wLASaHZKQw
	 0vMwBYYBgCBPCN1WGZqNDvrDe7VOh1Ajco8Aa0421lBrGUSFCCXBUPKf0iNaV/2O3q
	 /BhQE7oeOPF1w==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d040a62a76so24910631fa.0;
        Fri, 02 Feb 2024 08:48:01 -0800 (PST)
X-Gm-Message-State: AOJu0YyDKbg3JeNy88JCPYpGewVlJqTyBokKGIBfqclR9NeeXcbtPVlk
	xZZ0vqqyAEGbegbX1QLtElorTWgoXLpxZpB89ZIUs0s0frhlmqKQGu8GdKyDmlW7iZkfG3ZdoRh
	THMOnAz5Iw8Q20uP8GcHaZQqrLn8=
X-Google-Smtp-Source: AGHT+IFugakFdvGMphcNYRZ2YJWc4YeX7dLyfpL3BRPOlCx/iVvhVhVDVo9CIK8HF9iqX/xcv1hh0SMS9nPQH88SNfo=
X-Received: by 2002:a2e:99cc:0:b0:2cc:811f:f9ae with SMTP id
 l12-20020a2e99cc000000b002cc811ff9aemr1561250ljj.47.1706892480294; Fri, 02
 Feb 2024 08:48:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-23-ardb+git@google.com> <20240131083511.GIZboGP8jPIrUZA8DF@fat_crate.local>
 <CAMj1kXG9W0XeEVR4tXDDg0Ai9XPsZGrTJaSRYUqgTV-xtFxjdQ@mail.gmail.com>
 <20240131092952.GCZboTECip8DbWtYtz@fat_crate.local> <8b38ef82-ec2b-4845-9732-15713a0e2a85@amd.com>
 <CAMj1kXH4U7X3_xgwhYUgbWqVfnzL5Dx0QaUhb_5TpZGQEh=_8g@mail.gmail.com> <20240202163510.GDZb0Zvj8qOndvFOiZ@fat_crate.local>
In-Reply-To: <20240202163510.GDZb0Zvj8qOndvFOiZ@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 2 Feb 2024 17:47:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFziPbzQt=eC2kg+7uW9vS_32YHq+37S_zdycNkY04UCg@mail.gmail.com>
Message-ID: <CAMj1kXFziPbzQt=eC2kg+7uW9vS_32YHq+37S_zdycNkY04UCg@mail.gmail.com>
Subject: Re: [PATCH] x86/Kconfig: Remove CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 17:35, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Feb 01, 2024 at 05:15:51PM +0100, Ard Biesheuvel wrote:
> > OK, I'll remove it in the next rev.
>
> Considering how it simplifies sme_enable() even more, I'd like to
> expedite this one.
>
> Thx.
>
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Fri, 2 Feb 2024 17:29:32 +0100
> Subject: [PATCH] x86/Kconfig: Remove CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
>
> It was meant well at the time but nothing's using it so get rid of it.
>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt  |  4 +---
>  Documentation/arch/x86/amd-memory-encryption.rst | 16 ++++++++--------
>  arch/x86/Kconfig                                 | 13 -------------
>  arch/x86/mm/mem_encrypt_identity.c               | 11 +----------
>  4 files changed, 10 insertions(+), 34 deletions(-)
>

Works for me.

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 31b3a25680d0..2cb70a384af8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3320,9 +3320,7 @@
>
>         mem_encrypt=    [X86-64] AMD Secure Memory Encryption (SME) control
>                         Valid arguments: on, off
> -                       Default (depends on kernel configuration option):
> -                         on  (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y)
> -                         off (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=n)
> +                       Default: off
>                         mem_encrypt=on:         Activate SME
>                         mem_encrypt=off:        Do not activate SME
>
> diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
> index 07caa8fff852..414bc7402ae7 100644
> --- a/Documentation/arch/x86/amd-memory-encryption.rst
> +++ b/Documentation/arch/x86/amd-memory-encryption.rst
> @@ -87,14 +87,14 @@ The state of SME in the Linux kernel can be documented as follows:
>           kernel is non-zero).
>
>  SME can also be enabled and activated in the BIOS. If SME is enabled and
> -activated in the BIOS, then all memory accesses will be encrypted and it will
> -not be necessary to activate the Linux memory encryption support.  If the BIOS
> -merely enables SME (sets bit 23 of the MSR_AMD64_SYSCFG), then Linux can activate
> -memory encryption by default (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y) or
> -by supplying mem_encrypt=on on the kernel command line.  However, if BIOS does
> -not enable SME, then Linux will not be able to activate memory encryption, even
> -if configured to do so by default or the mem_encrypt=on command line parameter
> -is specified.
> +activated in the BIOS, then all memory accesses will be encrypted and it
> +will not be necessary to activate the Linux memory encryption support.
> +
> +If the BIOS merely enables SME (sets bit 23 of the MSR_AMD64_SYSCFG),
> +then memory encryption can be enabled by supplying mem_encrypt=on on the
> +kernel command line.  However, if BIOS does not enable SME, then Linux
> +will not be able to activate memory encryption, even if configured to do
> +so by default or the mem_encrypt=on command line parameter is specified.
>
>  Secure Nested Paging (SNP)
>  ==========================
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5edec175b9bf..58d3593bc4f2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1539,19 +1539,6 @@ config AMD_MEM_ENCRYPT
>           This requires an AMD processor that supports Secure Memory
>           Encryption (SME).
>
> -config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
> -       bool "Activate AMD Secure Memory Encryption (SME) by default"
> -       depends on AMD_MEM_ENCRYPT
> -       help
> -         Say yes to have system memory encrypted by default if running on
> -         an AMD processor that supports Secure Memory Encryption (SME).
> -
> -         If set to Y, then the encryption of system memory can be
> -         deactivated with the mem_encrypt=off command line option.
> -
> -         If set to N, then the encryption of system memory can be
> -         activated with the mem_encrypt=on command line option.
> -
>  # Common NUMA Features
>  config NUMA
>         bool "NUMA Memory Allocation and Scheduler Support"
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 7f72472a34d6..efe9f217fcf9 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -97,7 +97,6 @@ static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
>
>  static char sme_cmdline_arg[] __initdata = "mem_encrypt";
>  static char sme_cmdline_on[]  __initdata = "on";
> -static char sme_cmdline_off[] __initdata = "off";
>
>  static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
>  {
> @@ -504,7 +503,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>
>  void __init sme_enable(struct boot_params *bp)
>  {
> -       const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
> +       const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
>         unsigned int eax, ebx, ecx, edx;
>         unsigned long feature_mask;
>         unsigned long me_mask;
> @@ -587,12 +586,6 @@ void __init sme_enable(struct boot_params *bp)
>         asm ("lea sme_cmdline_on(%%rip), %0"
>              : "=r" (cmdline_on)
>              : "p" (sme_cmdline_on));
> -       asm ("lea sme_cmdline_off(%%rip), %0"
> -            : "=r" (cmdline_off)
> -            : "p" (sme_cmdline_off));
> -
> -       if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
> -               sme_me_mask = me_mask;
>
>         cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
>                                      ((u64)bp->ext_cmd_line_ptr << 32));
> @@ -602,8 +595,6 @@ void __init sme_enable(struct boot_params *bp)
>
>         if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
>                 sme_me_mask = me_mask;
> -       else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
> -               sme_me_mask = 0;
>
>  out:
>         if (sme_me_mask) {
> --
> 2.43.0
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

