Return-Path: <linux-arch+bounces-751-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A70808BFD
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 16:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58581C20753
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 15:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625144387;
	Thu,  7 Dec 2023 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ1SiA1f"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AB4436B;
	Thu,  7 Dec 2023 15:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9C8C433C9;
	Thu,  7 Dec 2023 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701963461;
	bh=Y1Iv0HzuzWq6SDtWi2zLmZf5F4ZxjGawlQfjfRbYTcs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IZ1SiA1fMex+Cn7sZ3mGGgEsQKycl5xuVs2tZt/3FPy61GHzqniU+vEQZxwGSH+Tu
	 pI2U/BMzazWiCu8DHJoQ2L+mn+Lt9a0YkM8DCU32dDfqp8yvCtSKz0vXhUG7Q147FX
	 L9SHw78pQUo/ZoowK+uSMn22QGo6vITEtTcQBch+VcBFDF7jGHDxhwqOeoOG0ltCrW
	 2iU1aglSiOqM5aFENWC+WnUvyYg5vH4jjjVPf3pXa0h82woGpBGEzg9gyO+Agyucd5
	 tagdj7TpAQ0zolL2oRFRNuHD51gm+ink2JEI/ChIK2Fp4AP3qQD6wc4xPzC9jK6v/i
	 pwitTJCTgzNpw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so11240261fa.1;
        Thu, 07 Dec 2023 07:37:41 -0800 (PST)
X-Gm-Message-State: AOJu0Yyuf0GDbXtxsO64+931uIWV/uaxuZ9+K+vtYzeBo4bHkqs6tRYc
	/woRH7PFwWXiVIq5mwhIgIBrCS+1TsQ0WQYZYN0=
X-Google-Smtp-Source: AGHT+IEwOXyStlfeZ1K+swzpMVgw+3cQ440ws6vmLcJBwnL1URbIHuXCR3i2n5CKsKT+qUnn6WCBxzOqXnVczgv9avg=
X-Received: by 2002:a2e:8053:0:b0:2c9:eda1:cd1 with SMTP id
 p19-20020a2e8053000000b002c9eda10cd1mr1146473ljg.85.1701963459467; Thu, 07
 Dec 2023 07:37:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206125433.18420-1-tzimmermann@suse.de> <20231206125433.18420-3-tzimmermann@suse.de>
In-Reply-To: <20231206125433.18420-3-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Dec 2023 16:37:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHq5CxdNei24MOnX_78h70bJQYd8HMQnT80DSqwZkFuSQ@mail.gmail.com>
Message-ID: <CAMj1kXHq5CxdNei24MOnX_78h70bJQYd8HMQnT80DSqwZkFuSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arch/x86: Add <asm/ima-efi.h> for arch_ima_efi_boot_mode
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
> The header file <asm/efi.h> contains the macro arch_ima_efi_boot_mode,
> which expands to use struct boot_params from <asm/bootparams.h>. Many
> drivers include <linux/efi.h>, but do not use boot parameters. Changes
> to bootparam.h or its included headers can easily trigger large,
> unnessary rebuilds of the kernel.
>
> Moving x86's arch_ima_efi_boot_mode to <asm/ima-efi.h> and including
> <asm/bootparam.h> separates that dependency from the rest of the EFI
> interfaces. The only user is in ima_efi.c. As the file already declares
> a default value for arch_ima_efi_boot_mode, move this define into
> asm-generic for all other architectures.
>
> With arch_ima_efi_boot_mode removed from efi.h, <asm/bootparam.h> can
> later be removed from further x86 header files.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  arch/x86/include/asm/efi.h       |  3 ---
>  arch/x86/include/asm/ima-efi.h   | 12 ++++++++++++
>  include/asm-generic/Kbuild       |  1 +
>  include/asm-generic/ima-efi.h    | 16 ++++++++++++++++
>  security/integrity/ima/ima_efi.c |  5 +----
>  5 files changed, 30 insertions(+), 7 deletions(-)
>  create mode 100644 arch/x86/include/asm/ima-efi.h
>  create mode 100644 include/asm-generic/ima-efi.h
>
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index c4555b269a1b..99f31176c892 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -418,9 +418,6 @@ extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
>  extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
>                                      void *buf, struct efi_mem_range *mem);
>
> -#define arch_ima_efi_boot_mode \
> -       ({ extern struct boot_params boot_params; boot_params.secure_boot; })
> -
>  #ifdef CONFIG_EFI_RUNTIME_MAP
>  int efi_get_runtime_map_size(void);
>  int efi_get_runtime_map_desc_size(void);
> diff --git a/arch/x86/include/asm/ima-efi.h b/arch/x86/include/asm/ima-efi.h
> new file mode 100644
> index 000000000000..3fe054937077
> --- /dev/null
> +++ b/arch/x86/include/asm/ima-efi.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_IMA_EFI_H
> +#define _ASM_X86_IMA_EFI_H
> +
> +#include <asm/bootparam.h>
> +
> +#define arch_ima_efi_boot_mode \
> +       ({ extern struct boot_params boot_params; boot_params.secure_boot; })
> +

Could you please check whether this kludge is still needed now that we
no longer have conflicting declarations of boot_params? (i.e., drop
the ({ }) and the extern declaration)



> +#include <asm-generic/ima-efi.h>
> +
> +#endif /* _ASM_X86_IMA_EFI_H */
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index def242528b1d..4fd16e71e8cd 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -26,6 +26,7 @@ mandatory-y += ftrace.h
>  mandatory-y += futex.h
>  mandatory-y += hardirq.h
>  mandatory-y += hw_irq.h
> +mandatory-y += ima-efi.h
>  mandatory-y += io.h
>  mandatory-y += irq.h
>  mandatory-y += irq_regs.h
> diff --git a/include/asm-generic/ima-efi.h b/include/asm-generic/ima-efi.h
> new file mode 100644
> index 000000000000..f87f5edef440
> --- /dev/null
> +++ b/include/asm-generic/ima-efi.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __ASM_GENERIC_IMA_EFI_H_
> +#define __ASM_GENERIC_IMA_EFI_H_
> +
> +#include <linux/efi.h>
> +
> +/*
> + * Only include this header file from your architecture's <asm/ima-efi.h>.
> + */
> +
> +#ifndef arch_ima_efi_boot_mode
> +#define arch_ima_efi_boot_mode efi_secureboot_mode_unset
> +#endif
> +
> +#endif /* __ASM_GENERIC_FB_H_ */
> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
> index 138029bfcce1..56bbee271cec 100644
> --- a/security/integrity/ima/ima_efi.c
> +++ b/security/integrity/ima/ima_efi.c
> @@ -6,10 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/ima.h>
>  #include <asm/efi.h>
> -
> -#ifndef arch_ima_efi_boot_mode
> -#define arch_ima_efi_boot_mode efi_secureboot_mode_unset
> -#endif
> +#include <asm/ima-efi.h>
>
>  static enum efi_secureboot_mode get_sb_mode(void)
>  {
> --
> 2.43.0
>

