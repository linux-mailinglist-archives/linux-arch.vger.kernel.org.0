Return-Path: <linux-arch+bounces-752-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8AC808C04
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 16:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A32C1F2125A
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E0444C8D;
	Thu,  7 Dec 2023 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwBLlw5e"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80114437A;
	Thu,  7 Dec 2023 15:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A55C433CB;
	Thu,  7 Dec 2023 15:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701963494;
	bh=wvVN+1YIFHu6pwuC8my2GQeLCZBlFO2tSFyxQF8MEoA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BwBLlw5eO1GwXbEIAOPxS00/C0TZYafXou2wc/4do1UG3aFN+nnzSSA5mXnu5gzKN
	 ++ArkvzxIsTVYgdlDD09GaZYkw39DyQv1MnL2HE5ZYiAz9G4nwmeRvLiEHI6TF6Xyj
	 F7Bc/ntE8UuQznRkoo3k4paYxXtP+YekIgDKu2H+MKFd34HqpLv5BmOkBcd98Pbz5/
	 z2/qkCKtoad7MxiAD6wrFdoxf4fJlbly5v09CObEup7PTOfw1PGFtZ+H3Nt1pTXmNL
	 dE6ZRSVjo/L+4RdBt852KgFxEL0soBCSeoF9rDgb0+BD0qvXdOf108VvM3RvpnF5ep
	 bJkkQ5ND3sEBQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ca0d14976aso11119651fa.2;
        Thu, 07 Dec 2023 07:38:14 -0800 (PST)
X-Gm-Message-State: AOJu0YxqTAcfQiOF++ADXxtRp33L6X1oImJKGUwdKA6Z/W8STMjfgRgT
	mCOZh+pmvmsUEA1DR3zatZUwizz9hSeCalHRIy8=
X-Google-Smtp-Source: AGHT+IFvQXuCu2DYdb90avyxL8P6qli6omWybxLqio1Iex9LuiGceMcEqs0UsqxMj6ERwpyXfaCn99dgbPE4v3Fpqtg=
X-Received: by 2002:a2e:9686:0:b0:2ca:c76:c021 with SMTP id
 q6-20020a2e9686000000b002ca0c76c021mr1610161lji.68.1701963492420; Thu, 07 Dec
 2023 07:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206125433.18420-1-tzimmermann@suse.de> <20231206125433.18420-4-tzimmermann@suse.de>
In-Reply-To: <20231206125433.18420-4-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Dec 2023 16:38:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE7JtotB=V7hrkbseDUwkwgUdkd5ownrsAdhayEqpy4sA@mail.gmail.com>
Message-ID: <CAMj1kXE7JtotB=V7hrkbseDUwkwgUdkd5ownrsAdhayEqpy4sA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arch/x86: Do not include <asm/bootparam.h> in several
 header files
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, javierm@redhat.com, linux-arch@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 13:54, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Remove the include statement for <asm/bootparam.h> from several header
> files that don't require it. Limits the exposure of the boot parameters
> within the Linux kernel code.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/include/asm/kexec.h       | 1 -
>  arch/x86/include/asm/mem_encrypt.h | 2 +-
>  arch/x86/include/asm/sev.h         | 3 ++-
>  arch/x86/include/asm/x86_init.h    | 2 --
>  4 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index c9f6a6c5de3c..91ca9a9ee3a2 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -25,7 +25,6 @@
>
>  #include <asm/page.h>
>  #include <asm/ptrace.h>
> -#include <asm/bootparam.h>
>
>  struct kimage;
>
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 359ada486fa9..c1a8a3408c18 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -15,7 +15,7 @@
>  #include <linux/init.h>
>  #include <linux/cc_platform.h>
>
> -#include <asm/bootparam.h>
> +struct boot_params;
>
>  #ifdef CONFIG_X86_MEM_ENCRYPT
>  void __init mem_encrypt_init(void);
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 5b4a1ce3d368..8dad8b1613bf 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -13,7 +13,6 @@
>
>  #include <asm/insn.h>
>  #include <asm/sev-common.h>
> -#include <asm/bootparam.h>
>  #include <asm/coco.h>
>
>  #define GHCB_PROTOCOL_MIN      1ULL
> @@ -22,6 +21,8 @@
>
>  #define        VMGEXIT()                       { asm volatile("rep; vmmcall\n\r"); }
>
> +struct boot_params;
> +
>  enum es_result {
>         ES_OK,                  /* All good */
>         ES_UNSUPPORTED,         /* Requested operation not supported */
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index c878616a18b8..f062715578a0 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -2,8 +2,6 @@
>  #ifndef _ASM_X86_PLATFORM_H
>  #define _ASM_X86_PLATFORM_H
>
> -#include <asm/bootparam.h>
> -
>  struct ghcb;
>  struct mpc_bus;
>  struct mpc_cpu;
> --
> 2.43.0
>

