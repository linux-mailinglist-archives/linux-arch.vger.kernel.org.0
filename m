Return-Path: <linux-arch+bounces-1131-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265AE81867B
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 12:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B995B28154A
	for <lists+linux-arch@lfdr.de>; Tue, 19 Dec 2023 11:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FAB18032;
	Tue, 19 Dec 2023 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ5wW2eq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAC18023;
	Tue, 19 Dec 2023 11:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEDCC43397;
	Tue, 19 Dec 2023 11:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702985937;
	bh=z/k+YLVG8n9w0gU6sDLuJgWPnnGVRssnALfrFYt48Kc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YZ5wW2eq3iLNVR0D3INYFDiHoOy9u7hHTIJmjfZrOmN9uEHlkSe2+p1LY8oA6Uqc6
	 o5VzCD0CAEUBSZX5jaeRxTi5InLpxumraBNOcnXdpYcCmIgQhPonNmzT7snKzERGqd
	 zXQcfBxETiC4pkV1PQZtn8g0yu7/g/wQxuvUn5kEjX/SZ57kCv2F9jYZTXCk3hJCF1
	 ArW8C+v3dmdH8zKR2xalj8md0QUM4CNJ58TnTYVq9vpI6ZDXlVXiI9XFFYvVPkZRmO
	 ySmRvSCKaphWrtDvYj4JXREjfOyKuw8GYmjokI38G2QdDaMQwV7V+r1gD6t2hGcj2/
	 WB8ZmBIkPNq5g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cc7b4709edso12475221fa.0;
        Tue, 19 Dec 2023 03:38:57 -0800 (PST)
X-Gm-Message-State: AOJu0YybCozzdw1vas2RZEgUc3jQQxA72MjecCrfqmbovMfxNWkvZiu3
	2mvMT+9Cr8J5l1hmGIJ89djinZdKkNVJ5DSL/LQ=
X-Google-Smtp-Source: AGHT+IGy+6E+Sn9s6ye17sM7ASYkS54eKGlyAxWBRLZL4jRxMOyZr0iV3s8QFFjT31FJTJwCyWvX4/ab2jc+J0WE6aE=
X-Received: by 2002:a2e:8897:0:b0:2cc:7013:4b40 with SMTP id
 k23-20020a2e8897000000b002cc70134b40mr1369809lji.68.1702985935277; Tue, 19
 Dec 2023 03:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215122614.5481-1-tzimmermann@suse.de> <20231215122614.5481-3-tzimmermann@suse.de>
In-Reply-To: <20231215122614.5481-3-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 19 Dec 2023 12:38:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHrn-PxpMGnR4VoHv7kHvQYyf8SS9i1irm9Gi_uBseciw@mail.gmail.com>
Message-ID: <CAMj1kXHrn-PxpMGnR4VoHv7kHvQYyf8SS9i1irm9Gi_uBseciw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arch/x86: Add <asm/ima-efi.h> for arch_ima_efi_boot_mode
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

Hi Thomas,

On Fri, 15 Dec 2023 at 13:26, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> The header file <asm/efi.h> contains the macro arch_ima_efi_boot_mode,
> which expands to use struct boot_params from <asm/bootparams.h>. Many
> drivers include <linux/efi.h>, but do not use boot parameters. Changes
> to bootparam.h or its included headers can easily trigger large,
> unnessary rebuilds of the kernel.
>
> Moving x86's arch_ima_efi_boot_mode to <asm/ima-efi.h> and including
> <asm/setup.h> separates that dependency from the rest of the EFI
> interfaces. The only user is in ima_efi.c. As the file already declares
> a default value for arch_ima_efi_boot_mode, move this define into
> asm-generic for all other architectures.
>
> With arch_ima_efi_boot_mode removed from efi.h, <asm/bootparam.h> can
> later be removed from further x86 header files.
>

Apologies if I missed this in v1 but is the new asm-generic header
really necessary? Could we instead turn arch_ima_efi_boot_mode into a
function that is a static inline { return unset; } by default, but can
be emitted out of line in one of the x86/platform/efi.c source files,
where referring to boot_params is fine?





> v2:
>         * remove extra declaration of boot_params (Ard)
>

Please don't put the revision log here, but below the --- so that 'git
am' will ignore it.


> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  arch/x86/include/asm/efi.h       |  3 ---
>  arch/x86/include/asm/ima-efi.h   | 11 +++++++++++
>  include/asm-generic/Kbuild       |  1 +
>  include/asm-generic/ima-efi.h    | 16 ++++++++++++++++
>  security/integrity/ima/ima_efi.c |  5 +----
>  5 files changed, 29 insertions(+), 7 deletions(-)
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
> index 000000000000..b4d904e66b39
> --- /dev/null
> +++ b/arch/x86/include/asm/ima-efi.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_IMA_EFI_H
> +#define _ASM_X86_IMA_EFI_H
> +
> +#include <asm/setup.h>
> +
> +#define arch_ima_efi_boot_mode boot_params.secure_boot
> +
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
>

