Return-Path: <linux-arch+bounces-1285-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ABC8246AB
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 17:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13541F2177A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 16:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707E1225D8;
	Thu,  4 Jan 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNNVouCQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD425565;
	Thu,  4 Jan 2024 16:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6836C433B6;
	Thu,  4 Jan 2024 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704387084;
	bh=/O08vCHajpvw1Rc518HR1WgtRPRPdQ2wO5g9HKaqQZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LNNVouCQ7kkf1s4M4e+Ug9Gu5ulcmaGMNzB3FPvPs+R7/eBI7ut7UbP+fYvmuHINk
	 EN3jJMkyo81ljMJs4GGkOLrbrz1ypSHfmnwoEOL+Hkfq5P5+QvVEbYIKu6QxOOCeR/
	 Pzyk62YvjYc5gEiS2z9bAjN4WZnV1fSzmH4xThSAnnkW+InBrMaAKhcN/jEHaL3AdO
	 4TJViPAQT+J9T0l4korFIqiUujj9K7kZxD7u+bL2Eq/utH9LFU9UIfwCbJbp1p3Pjb
	 IMEOHifN2Ch05EV+y7cfS+TdxJZxHggX0wdX/LeTQBzOBkBZjX5WYoArY1NdZPT06T
	 zfbyAgnqnmlAA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50ea226bda8so737687e87.2;
        Thu, 04 Jan 2024 08:51:24 -0800 (PST)
X-Gm-Message-State: AOJu0YwW1tFcuOQC3/1aZ7ZyECZoINPApDWrrD8C+IbVNDjzDsFCe7b9
	rpVJAwslEUUSh4Br8m7tG02FFb50painN/e3A1A=
X-Google-Smtp-Source: AGHT+IHRR7/L+jg0JGpYQggGGUYhoDQhuYPy2emnnzvE1eZlb+I0OuUWy5vnZch8St2OV9Ll01H5JKblC8uJ2O1XJbE=
X-Received: by 2002:a05:6512:2251:b0:50e:74c1:6e65 with SMTP id
 i17-20020a056512225100b0050e74c16e65mr566380lfu.81.1704387082580; Thu, 04 Jan
 2024 08:51:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104095421.12772-1-tzimmermann@suse.de> <20240104095421.12772-5-tzimmermann@suse.de>
In-Reply-To: <20240104095421.12772-5-tzimmermann@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 4 Jan 2024 17:51:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHEJubE42e6cUiEUv=Z66d9Gqw0EM7Wts9hrHzf8ZDsGQ@mail.gmail.com>
Message-ID: <CAMj1kXHEJubE42e6cUiEUv=Z66d9Gqw0EM7Wts9hrHzf8ZDsGQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arch/x86: Do not include <asm/bootparam.h> in
 several files
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

On Thu, 4 Jan 2024 at 10:54, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Remove the include statement for <asm/bootparam.h> from several files
> that don't require it. Limits the exposure of the boot parameters
> within the Linux kernel code.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> ---
>
> v3:
>         * revert of e820/types.h required
> v2:
>         * clean up misc.h and e820/types.h
>         * include bootparam.h in several source files
> ---
>  arch/x86/boot/compressed/acpi.c       | 2 ++
>  arch/x86/boot/compressed/cmdline.c    | 2 ++
>  arch/x86/boot/compressed/efi.c        | 2 ++
>  arch/x86/boot/compressed/misc.h       | 3 ++-
>  arch/x86/boot/compressed/pgtable_64.c | 1 +
>  arch/x86/boot/compressed/sev.c        | 1 +
>  arch/x86/include/asm/kexec.h          | 1 -
>  arch/x86/include/asm/mem_encrypt.h    | 2 +-
>  arch/x86/include/asm/sev.h            | 3 ++-
>  arch/x86/include/asm/x86_init.h       | 2 --
>  arch/x86/kernel/crash.c               | 1 +
>  arch/x86/kernel/sev-shared.c          | 2 ++
>  arch/x86/platform/pvh/enlighten.c     | 1 +
>  arch/x86/xen/enlighten_pvh.c          | 1 +
>  arch/x86/xen/vga.c                    | 1 -
>  15 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 18d15d1ce87d..f196b1d1ddf8 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -5,6 +5,8 @@
>  #include "../string.h"
>  #include "efi.h"
>
> +#include <asm/bootparam.h>
> +
>  #include <linux/numa.h>
>
>  /*
> diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
> index c1bb180973ea..e162d7f59cc5 100644
> --- a/arch/x86/boot/compressed/cmdline.c
> +++ b/arch/x86/boot/compressed/cmdline.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "misc.h"
>
> +#include <asm/bootparam.h>
> +
>  static unsigned long fs;
>  static inline void set_fs(unsigned long seg)
>  {
> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> index 6edd034b0b30..f2e50f9758e6 100644
> --- a/arch/x86/boot/compressed/efi.c
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -7,6 +7,8 @@
>
>  #include "misc.h"
>
> +#include <asm/bootparam.h>
> +
>  /**
>   * efi_get_type - Given a pointer to boot_params, determine the type of EFI environment.
>   *
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index c0d502bd8716..01c89c410efd 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -33,7 +33,6 @@
>  #include <linux/elf.h>
>  #include <asm/page.h>
>  #include <asm/boot.h>
> -#include <asm/bootparam.h>
>  #include <asm/desc_defs.h>
>
>  #include "tdx.h"
> @@ -53,6 +52,8 @@
>  #define memptr unsigned
>  #endif
>
> +struct boot_param;
> +

Typo?

Interestingly, it still builds fine for me without any warnings.


>  /* boot/compressed/vmlinux start and end markers */
>  extern char _head[], _end[];
>
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index 51f957b24ba7..c882e1f67af0 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "misc.h"
> +#include <asm/bootparam.h>
>  #include <asm/e820/types.h>
>  #include <asm/processor.h>
>  #include "pgtable.h"
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 454acd7a2daf..13beae767e48 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -12,6 +12,7 @@
>   */
>  #include "misc.h"
>
> +#include <asm/bootparam.h>
>  #include <asm/pgtable_types.h>
>  #include <asm/sev.h>
>  #include <asm/trapnr.h>
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

Unfortunately, the SEV/SNP code is a bit of a kludge given that it
declares routines in headers under arch/x86/include/asm, and defines
them in two different places (the decompressor and the kernel proper).

So while I feel that we should avoid relying on incomplete struct
definitions, this one (and the one below) seems fine to me for now.
If/when someone gets around to cleaning up the SEV/SNP header files,
to split the init code from the more widely used mm types etc, we can
revisit this.


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
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index c92d88680dbf..564cff7ed33a 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -26,6 +26,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/memblock.h>
>
> +#include <asm/bootparam.h>
>  #include <asm/processor.h>
>  #include <asm/hardirq.h>
>  #include <asm/nmi.h>
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index ccb0915e84e1..4962ec42dc68 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -9,6 +9,8 @@
>   * and is included directly into both code-bases.
>   */
>
> +#include <asm/setup_data.h>
> +
>  #ifndef __BOOT_COMPRESSED
>  #define error(v)       pr_err(v)
>  #define has_cpuflag(f) boot_cpu_has(f)
> diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
> index 00a92cb2c814..944e0290f2c0 100644
> --- a/arch/x86/platform/pvh/enlighten.c
> +++ b/arch/x86/platform/pvh/enlighten.c
> @@ -3,6 +3,7 @@
>
>  #include <xen/hvc-console.h>
>
> +#include <asm/bootparam.h>
>  #include <asm/io_apic.h>
>  #include <asm/hypervisor.h>
>  #include <asm/e820/api.h>
> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
> index ada3868c02c2..9e9db601bd52 100644
> --- a/arch/x86/xen/enlighten_pvh.c
> +++ b/arch/x86/xen/enlighten_pvh.c
> @@ -4,6 +4,7 @@
>
>  #include <xen/hvc-console.h>
>
> +#include <asm/bootparam.h>
>  #include <asm/io_apic.h>
>  #include <asm/hypervisor.h>
>  #include <asm/e820/api.h>
> diff --git a/arch/x86/xen/vga.c b/arch/x86/xen/vga.c
> index d97adab8420f..f7547807b0bd 100644
> --- a/arch/x86/xen/vga.c
> +++ b/arch/x86/xen/vga.c
> @@ -2,7 +2,6 @@
>  #include <linux/screen_info.h>
>  #include <linux/init.h>
>
> -#include <asm/bootparam.h>
>  #include <asm/setup.h>
>
>  #include <xen/interface/xen.h>
> --
> 2.43.0
>
>

