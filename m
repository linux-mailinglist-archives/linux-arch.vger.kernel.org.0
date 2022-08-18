Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20996598A2E
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345361AbiHRRN3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 13:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345249AbiHRRM7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 13:12:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0822D2E9A;
        Thu, 18 Aug 2022 10:06:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35758B82233;
        Thu, 18 Aug 2022 17:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA52EC43143;
        Thu, 18 Aug 2022 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660842243;
        bh=eI+BeODzJuGuPBr1clasHban6mMJqv3UK7aUeqEcB8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kbOakDHE66giYnB6Bn1Jy2QW+FgWlILrbwUSthFrEN3v4hJMuKBWpd7j/wUtvtHoZ
         Qn2WaWUdS6g10PGX9MCrXfaXKCE0UkRYrzvTYZs6cjg0hb4AnIRqiyhENldSe9a4/J
         Ad44ZTiFs8yY837CXq2ehYjZYGvqjktGtFY8rtKc7RfoRSfQXCaDPtotV1dThETFTW
         /AJgW81zlgRzjIJO+qSh1UfPkXkzQTqGnK1j80q1U9LB33q97nPi+uq2bNiERNL5LH
         Jy/8yNt2jz2NjR1jB/ydemylVewqxYHfCPniRjUp5YSC5Xc0bTFYt8aFL+T4VdM5WM
         IoS8/5dtnhsSQ==
Received: by mail-wm1-f54.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso2881330wmh.5;
        Thu, 18 Aug 2022 10:04:02 -0700 (PDT)
X-Gm-Message-State: ACgBeo3GVSE7nuEbU8mWRTdaIjNZ3pDsWbt7JvJssIybfVl6KCYLjL/i
        48eqCSwF19xYjuctgFHmN616b+B/rkdgLtcqM0I=
X-Google-Smtp-Source: AA6agR74AzqZrWGfcbOLb/zPBX3PTM+9qUNuxTmVglewVi6HaQl45jE8ROWEa9eM/qNPeCh+nfxj6U5ImKEZ+URJs1o=
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id
 l20-20020a7bc354000000b0039c675321f8mr2493093wmj.113.1660842240705; Thu, 18
 Aug 2022 10:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220818030707.2836607-1-chenhuacai@loongson.cn>
In-Reply-To: <20220818030707.2836607-1-chenhuacai@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 Aug 2022 19:03:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEVNdgY6mO-e=v16Q95DRnzYy3c9zLH1nhx4VYqjWgxPA@mail.gmail.com>
Message-ID: <CAMj1kXEVNdgY6mO-e=v16Q95DRnzYy3c9zLH1nhx4VYqjWgxPA@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Add efistub booting support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 18 Aug 2022 at 05:07, Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> This patch adds efistub booting support, which is the standard UEFI boot
> protocol for us to use.
>
> We use generic efistub, which means we can pass boot information (i.e.,
> system table, memory map, kernel command line, initrd) via a light FDT
> and drop a lot of non-standard code.
>
> We use a flat mapping to map the efi runtime in the kernel's address
> space. In efi, VA = PA; in kernel, VA = PA + PAGE_OFFSET. As a result,
> flat mapping is not identity mapping, SetVirtualAddressMap() is still
> needed for the efi runtime.
>
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V1 --> V2:
> 1, Call SetVirtualAddressMap() in stub;
> 2, Use core kernel data directly in alloc_screen_info();
> 3, Remove the magic number in MS-DOS header;
> 4, Disable EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER;
> 5, Some other small changes suggested by Ard Biesheuvel.
>
>  arch/loongarch/Kconfig                        |  9 ++
>  arch/loongarch/Makefile                       |  7 +-
>  arch/loongarch/boot/Makefile                  |  8 +-
>  arch/loongarch/include/asm/efi.h              | 10 +-
>  arch/loongarch/kernel/efi-header.S            | 99 +++++++++++++++++++
>  arch/loongarch/kernel/efi.c                   |  3 +
>  arch/loongarch/kernel/head.S                  | 20 ++++
>  arch/loongarch/kernel/image-vars.h            | 30 ++++++
>  arch/loongarch/kernel/setup.c                 | 12 +--
>  arch/loongarch/kernel/vmlinux.lds.S           |  1 +
>  drivers/firmware/efi/Kconfig                  |  4 +-
>  drivers/firmware/efi/libstub/Makefile         | 10 ++
>  drivers/firmware/efi/libstub/efi-stub.c       | 31 ++++--
>  drivers/firmware/efi/libstub/loongarch-stub.c | 60 +++++++++++
>  include/linux/pe.h                            |  2 +
>  15 files changed, 282 insertions(+), 24 deletions(-)
>  create mode 100644 arch/loongarch/kernel/efi-header.S
>  create mode 100644 arch/loongarch/kernel/image-vars.h
>  create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 9478f9646fa5..4cb412a82afa 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -324,6 +324,15 @@ config EFI
>           This enables the kernel to use EFI runtime services that are
>           available (such as the EFI variable services).
>
> +config EFI_STUB
> +       bool "EFI boot stub support"
> +       default y
> +       depends on EFI
> +       select EFI_GENERIC_STUB
> +       help
> +         This kernel feature allows the kernel to be loaded directly by
> +         EFI firmware without the use of a bootloader.
> +
>  config SMP
>         bool "Multi-Processing support"
>         help
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index ec3de6191276..2bd0a574ed73 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -7,7 +7,11 @@ boot   := arch/loongarch/boot
>
>  KBUILD_DEFCONFIG := loongson3_defconfig
>
> -KBUILD_IMAGE   = $(boot)/vmlinux
> +ifndef CONFIG_EFI_STUB
> +KBUILD_IMAGE   = $(boot)/vmlinux.elf
> +else
> +KBUILD_IMAGE   = $(boot)/vmlinux.efi
> +endif
>

Nit: I am not 100% whether it matters or not, but all other
architectures use := for these assignments.

Also, in order to be able to use vmlinux.elf or vmlinux.efi as a make
target directly, other architectures seem to use something like

all:    $(notdir $(KBUILD_IMAGE))

vmlinux.elf vmlinux.efi: vmlinux
        $(Q)$(MAKE) $(build)=$(boot) $(bootvars-y) $(boot)/$@

Adopting this will make it easier to wire up the generic zboot support too.

>  #
>  # Select the object file format to substitute into the linker script.
> @@ -75,6 +79,7 @@ endif
>  head-y := arch/loongarch/kernel/head.o
>
>  libs-y += arch/loongarch/lib/
> +libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>
>  ifeq ($(KBUILD_EXTMOD),)
>  prepare: vdso_prepare
> diff --git a/arch/loongarch/boot/Makefile b/arch/loongarch/boot/Makefile
> index 0125b17edc98..fecf34f50e56 100644
> --- a/arch/loongarch/boot/Makefile
> +++ b/arch/loongarch/boot/Makefile
> @@ -8,9 +8,13 @@ drop-sections := .comment .note .options .note.gnu.build-id
>  strip-flags   := $(addprefix --remove-section=,$(drop-sections)) -S
>  OBJCOPYFLAGS_vmlinux.efi := -O binary $(strip-flags)
>
> -targets := vmlinux
>  quiet_cmd_strip = STRIP          $@
>        cmd_strip = $(STRIP) -s -o $@ $<
>
> -$(obj)/vmlinux: vmlinux FORCE
> +targets := vmlinux.elf
> +$(obj)/vmlinux.elf: vmlinux FORCE
>         $(call if_changed,strip)
> +
> +targets += vmlinux.efi
> +$(obj)/vmlinux.efi: vmlinux FORCE
> +       $(call if_changed,objcopy)
> diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
> index 9d44c6948be1..c7507a240f30 100644
> --- a/arch/loongarch/include/asm/efi.h
> +++ b/arch/loongarch/include/asm/efi.h
> @@ -18,8 +18,14 @@ void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
>
>  #define EFI_ALLOC_ALIGN                SZ_64K
>
> -struct screen_info *alloc_screen_info(void);
> -void free_screen_info(struct screen_info *si);
> +static inline struct screen_info *alloc_screen_info(void)
> +{
> +       return &screen_info;
> +}
> +
> +static inline void free_screen_info(struct screen_info *si)
> +{
> +}
>
>  static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
>  {
> diff --git a/arch/loongarch/kernel/efi-header.S b/arch/loongarch/kernel/efi-header.S
> new file mode 100644
> index 000000000000..8c1d229a2afa
> --- /dev/null
> +++ b/arch/loongarch/kernel/efi-header.S
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/pe.h>
> +#include <linux/sizes.h>
> +
> +       .macro  __EFI_PE_HEADER
> +       .long   PE_MAGIC
> +.Lcoff_header:
> +       .short  IMAGE_FILE_MACHINE_LOONGARCH64          /* Machine */
> +       .short  .Lsection_count                         /* NumberOfSections */
> +       .long   0                                       /* TimeDateStamp */
> +       .long   0                                       /* PointerToSymbolTable */
> +       .long   0                                       /* NumberOfSymbols */
> +       .short  .Lsection_table - .Loptional_header     /* SizeOfOptionalHeader */
> +       .short  IMAGE_FILE_DEBUG_STRIPPED | \
> +               IMAGE_FILE_EXECUTABLE_IMAGE | \
> +               IMAGE_FILE_LINE_NUMS_STRIPPED           /* Characteristics */
> +
> +.Loptional_header:
> +       .short  PE_OPT_MAGIC_PE32PLUS                   /* PE32+ format */
> +       .byte   0x02                                    /* MajorLinkerVersion */
> +       .byte   0x14                                    /* MinorLinkerVersion */
> +       .long   __inittext_end - .Lefi_header_end       /* SizeOfCode */
> +       .long   _end - __initdata_begin                 /* SizeOfInitializedData */
> +       .long   0                                       /* SizeOfUninitializedData */
> +       .long   __efistub_efi_pe_entry - _head          /* AddressOfEntryPoint */
> +       .long   .Lefi_header_end - _head                /* BaseOfCode */
> +
> +.Lextra_header_fields:
> +       .quad   0                                       /* ImageBase */
> +       .long   PECOFF_SEGMENT_ALIGN                    /* SectionAlignment */
> +       .long   PECOFF_FILE_ALIGN                       /* FileAlignment */
> +       .short  0                                       /* MajorOperatingSystemVersion */
> +       .short  0                                       /* MinorOperatingSystemVersion */
> +       .short  LINUX_EFISTUB_MAJOR_VERSION             /* MajorImageVersion */
> +       .short  LINUX_EFISTUB_MINOR_VERSION             /* MinorImageVersion */
> +       .short  0                                       /* MajorSubsystemVersion */
> +       .short  0                                       /* MinorSubsystemVersion */
> +       .long   0                                       /* Win32VersionValue */
> +
> +       .long   _end - _head                            /* SizeOfImage */
> +
> +       /* Everything before the kernel image is considered part of the header */
> +       .long   .Lefi_header_end - _head                /* SizeOfHeaders */
> +       .long   0                                       /* CheckSum */
> +       .short  IMAGE_SUBSYSTEM_EFI_APPLICATION         /* Subsystem */
> +       .short  0                                       /* DllCharacteristics */
> +       .quad   0                                       /* SizeOfStackReserve */
> +       .quad   0                                       /* SizeOfStackCommit */
> +       .quad   0                                       /* SizeOfHeapReserve */
> +       .quad   0                                       /* SizeOfHeapCommit */
> +       .long   0                                       /* LoaderFlags */
> +       .long   (.Lsection_table - .) / 8               /* NumberOfRvaAndSizes */
> +
> +       .quad   0                                       /* ExportTable */
> +       .quad   0                                       /* ImportTable */
> +       .quad   0                                       /* ResourceTable */
> +       .quad   0                                       /* ExceptionTable */
> +       .quad   0                                       /* CertificationTable */
> +       .quad   0                                       /* BaseRelocationTable */
> +
> +       /* Section table */
> +.Lsection_table:
> +       .ascii  ".text\0\0\0"
> +       .long   __inittext_end - .Lefi_header_end       /* VirtualSize */
> +       .long   .Lefi_header_end - _head                /* VirtualAddress */
> +       .long   __inittext_end - .Lefi_header_end       /* SizeOfRawData */
> +       .long   .Lefi_header_end - _head                /* PointerToRawData */
> +
> +       .long   0                                       /* PointerToRelocations */
> +       .long   0                                       /* PointerToLineNumbers */
> +       .short  0                                       /* NumberOfRelocations */
> +       .short  0                                       /* NumberOfLineNumbers */
> +       .long   IMAGE_SCN_CNT_CODE | \
> +               IMAGE_SCN_MEM_READ | \
> +               IMAGE_SCN_MEM_EXECUTE                   /* Characteristics */
> +
> +       .ascii  ".data\0\0\0"
> +       .long   _end - __initdata_begin                 /* VirtualSize */
> +       .long   __initdata_begin - _head                /* VirtualAddress */
> +       .long   _edata - __initdata_begin               /* SizeOfRawData */
> +       .long   __initdata_begin - _head                /* PointerToRawData */
> +
> +       .long   0                                       /* PointerToRelocations */
> +       .long   0                                       /* PointerToLineNumbers */
> +       .short  0                                       /* NumberOfRelocations */
> +       .short  0                                       /* NumberOfLineNumbers */
> +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA | \
> +               IMAGE_SCN_MEM_READ | \
> +               IMAGE_SCN_MEM_WRITE                     /* Characteristics */
> +
> +       .set    .Lsection_count, (. - .Lsection_table) / 40
> +
> +       .balign 0x10000                                 /* PECOFF_SEGMENT_ALIGN */
> +.Lefi_header_end:
> +       .endm
> diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> index a50b60c587fa..1f1f755fb425 100644
> --- a/arch/loongarch/kernel/efi.c
> +++ b/arch/loongarch/kernel/efi.c
> @@ -69,4 +69,7 @@ void __init efi_init(void)
>         config_tables = early_memremap(efi_config_table, efi_nr_tables * size);
>         efi_config_parse_tables(config_tables, efi_systab->nr_tables, arch_tables);
>         early_memunmap(config_tables, efi_nr_tables * size);
> +
> +       if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
> +               memblock_reserve(screen_info.lfb_base, screen_info.lfb_size);
>  }
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index c60eb66793e3..01bac62a6442 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -12,6 +12,26 @@
>  #include <asm/loongarch.h>
>  #include <asm/stackframe.h>
>
> +#ifdef CONFIG_EFI_STUB
> +
> +#include "efi-header.S"
> +
> +       __HEAD
> +
> +_head:
> +       .word   MZ_MAGIC                /* "MZ", MS-DOS header */
> +       .org    0x3c                    /* 0x04 ~ 0x3b reserved */
> +       .long   pe_header - _head       /* Offset to the PE header */
> +
> +pe_header:
> +       __EFI_PE_HEADER
> +
> +SYM_DATA(kernel_asize, .long _end - _text);
> +SYM_DATA(kernel_fsize, .long _edata - _text);
> +SYM_DATA(kernel_offset, .long kernel_offset - _text);
> +

These are a bit nasty: could you perhaps add a comment that explains
why exactly we need to emit these values like this? Using
kernel_offset with an offset to itself just to be able to refer to
_text from loongarch-stub.c is especially horrid, so bonus points if
you can find a better way to do that, preferably without asm
variables.

> +#endif
> +
>         __REF
>
>  SYM_CODE_START(kernel_entry)                   # kernel entry point
> diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
> new file mode 100644
> index 000000000000..c901ebb903f2
> --- /dev/null
> +++ b/arch/loongarch/kernel/image-vars.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef __LOONGARCH_KERNEL_IMAGE_VARS_H
> +#define __LOONGARCH_KERNEL_IMAGE_VARS_H
> +
> +#ifdef CONFIG_EFI_STUB
> +
> +__efistub_memcmp               = memcmp;
> +__efistub_memchr               = memchr;
> +__efistub_memcpy               = memcpy;
> +__efistub_memmove              = memmove;
> +__efistub_memset               = memset;
> +__efistub_strcat               = strcat;
> +__efistub_strcmp               = strcmp;
> +__efistub_strlen               = strlen;
> +__efistub_strncat              = strncat;
> +__efistub_strnstr              = strnstr;
> +__efistub_strnlen              = strnlen;
> +__efistub_strrchr              = strrchr;
> +__efistub_kernel_entry         = kernel_entry;
> +__efistub_kernel_asize         = kernel_asize;
> +__efistub_kernel_fsize         = kernel_fsize;
> +__efistub_kernel_offset                = kernel_offset;
> +__efistub_screen_info          = screen_info;
> +
> +#endif
> +
> +#endif /* __LOONGARCH_KERNEL_IMAGE_VARS_H */
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index 23ee293e1cd2..f938aae3e92c 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -49,9 +49,7 @@
>  #define SMBIOS_CORE_PACKAGE_OFFSET     0x23
>  #define LOONGSON_EFI_ENABLE            (1 << 3)
>
> -#ifdef CONFIG_VT
> -struct screen_info screen_info;
> -#endif
> +struct screen_info screen_info __section(".data");
>
>  unsigned long fw_arg0, fw_arg1;
>  DEFINE_PER_CPU(unsigned long, kernelsp);
> @@ -122,16 +120,9 @@ static void __init parse_cpu_table(const struct dmi_header *dm)
>
>  static void __init parse_bios_table(const struct dmi_header *dm)
>  {
> -       int bios_extern;
>         char *dmi_data = (char *)dm;
>
> -       bios_extern = *(dmi_data + SMBIOS_BIOSEXTERN_OFFSET);
>         b_info.bios_size = (*(dmi_data + SMBIOS_BIOSSIZE_OFFSET) + 1) << 6;
> -
> -       if (bios_extern & LOONGSON_EFI_ENABLE)
> -               set_bit(EFI_BOOT, &efi.flags);
> -       else
> -               clear_bit(EFI_BOOT, &efi.flags);
>  }
>

Why is this taken from the SMBIOS data?

>  static void __init find_tokens(const struct dmi_header *dm, void *dummy)
> @@ -145,6 +136,7 @@ static void __init find_tokens(const struct dmi_header *dm, void *dummy)
>                 break;
>         }
>  }
> +
>  static void __init smbios_parse(void)
>  {
>         b_info.bios_vendor = (void *)dmi_get_system_info(DMI_BIOS_VENDOR);
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> index 69c76f26c1c5..36d042739f3c 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -12,6 +12,7 @@
>  #define BSS_FIRST_SECTIONS *(.bss..swapper_pg_dir)
>
>  #include <asm-generic/vmlinux.lds.h>
> +#include "image-vars.h"
>
>  /*
>   * Max avaliable Page Size is 64K, so we set SectionAlignment
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 6cb7384ad2ac..cbf1c55dc224 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -107,7 +107,7 @@ config EFI_GENERIC_STUB
>
>  config EFI_ARMSTUB_DTB_LOADER
>         bool "Enable the DTB loader"
> -       depends on EFI_GENERIC_STUB && !RISCV
> +       depends on EFI_GENERIC_STUB && !RISCV && !LOONGARCH
>         default y
>         help
>           Select this config option to add support for the dtb= command
> @@ -124,7 +124,7 @@ config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
>         bool "Enable the command line initrd loader" if !X86
>         depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
>         default y if X86
> -       depends on !RISCV
> +       depends on !RISCV && !LOONGARCH
>         help
>           Select this config option to add support for the initrd= command
>           line parameter, allowing an initrd that resides on the same volume
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index d0537573501e..1588c61939e7 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -26,6 +26,8 @@ cflags-$(CONFIG_ARM)          := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>                                    $(call cc-option,-mno-single-pic-base)
>  cflags-$(CONFIG_RISCV)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>                                    -fpic
> +cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> +                                  -fpic
>
>  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
>
> @@ -70,6 +72,8 @@ lib-$(CONFIG_ARM)             += arm32-stub.o
>  lib-$(CONFIG_ARM64)            += arm64-stub.o
>  lib-$(CONFIG_X86)              += x86-stub.o
>  lib-$(CONFIG_RISCV)            += riscv-stub.o
> +lib-$(CONFIG_LOONGARCH)                += loongarch-stub.o
> +
>  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
>
>  # Even when -mbranch-protection=none is set, Clang will generate a
> @@ -125,6 +129,12 @@ STUBCOPY_FLAGS-$(CONFIG_RISCV)     += --prefix-alloc-sections=.init \
>                                    --prefix-symbols=__efistub_
>  STUBCOPY_RELOC-$(CONFIG_RISCV) := R_RISCV_HI20
>
> +# For LoongArch, keep all the symbols in .init section and make sure that no
> +# absolute symbols references doesn't exist.
> +STUBCOPY_FLAGS-$(CONFIG_LOONGARCH)     += --prefix-alloc-sections=.init \
> +                                          --prefix-symbols=__efistub_
> +STUBCOPY_RELOC-$(CONFIG_LOONGARCH)     := R_LARCH_MARK_LA
> +
>  $(obj)/%.stub.o: $(obj)/%.o FORCE
>         $(call if_changed,stubcopy)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index f515394cce6e..efb9219d8d49 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -40,14 +40,19 @@
>
>  #ifdef CONFIG_ARM64
>  # define EFI_RT_VIRTUAL_LIMIT  DEFAULT_MAP_WINDOW_64
> -#elif defined(CONFIG_RISCV)
> +#elif defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
>  # define EFI_RT_VIRTUAL_LIMIT  TASK_SIZE_MIN
> -#else
> +#else /* Only if TASK_SIZE is a constant */
>  # define EFI_RT_VIRTUAL_LIMIT  TASK_SIZE
>  #endif
>
> +/*
> + * 0: No flat mapping
> + * 1: Flat mapping that VA = PA
> + * 2: Flat mapping that VA = PA + PAGE_OFFSET
> + */
> +static int flat_va_mapping;
>  static u64 virtmap_base = EFI_RT_VIRTUAL_BASE;
> -static bool flat_va_mapping;
>

Can we change this around a bit?

static bool flat_va_mapping = __is_defined(EFI_RT_FIXED_VIRTUAL_OFFSET);

#ifndef EFI_RT_FIXED_VIRTUAL_OFFSET
#define EFI_RT_FIXED_VIRTUAL_OFFSET 0
#endif

Then, in your arch's asm/efi.h, you can add

#define EFI_RT_FIXED_VIRTUAL_OFFSET PAGE_OFFSET

...
> @@ -254,9 +260,11 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>          * The easiest way to achieve that is to simply use a 1:1 mapping.
>          */
>         prop_tbl = get_efi_config_table(EFI_PROPERTIES_TABLE_GUID);
> -       flat_va_mapping = prop_tbl &&
> -                         (prop_tbl->memory_protection_attribute &
> -                          EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA);
> +       attrib = prop_tbl ? prop_tbl->memory_protection_attribute : 0;
> +       if (attrib & EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTABLE_PE_DATA)
> +               flat_va_mapping = 1;
> +       if (IS_ENABLED(CONFIG_LOONGARCH))
> +               flat_va_mapping = 2;
>

Keep the original code but change it into

flat_va_mapping |= ....

(and drop the rest of the change)

>         /* force efi_novamap if SetVirtualAddressMap() is unsupported */
>         efi_novamap |= !(get_supported_rt_services() &
> @@ -338,7 +346,16 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
>                 paddr = in->phys_addr;
>                 size = in->num_pages * EFI_PAGE_SIZE;
>
> -               in->virt_addr = in->phys_addr;

Change this into

               in->virt_addr = in->phys_addr + EFI_RT_FIXED_VIRTUAL_OFFSET;

> +               switch (flat_va_mapping) {
> +               case 1:
> +                       in->virt_addr = in->phys_addr;
> +                       break;
> +               case 2:
> +                       in->virt_addr = in->phys_addr + PAGE_OFFSET;
> +                       break;
> +               default:
> +                       in->virt_addr = in->phys_addr;
> +               }

And drop the switch

>                 if (efi_novamap) {
>                         continue;
>                 }
> diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
> new file mode 100644
> index 000000000000..b7ef8d2df59e
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author: Yun Liu <liuyun@loongson.cn>
> + *         Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <asm/efi.h>
> +#include <asm/addrspace.h>
> +#include "efistub.h"
> +
> +typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long fdt);
> +
> +extern int kernel_asize;
> +extern int kernel_fsize;
> +extern int kernel_offset;
> +extern kernel_entry_t kernel_entry;
> +
> +efi_status_t check_platform_features(void)
> +{
> +       return EFI_SUCCESS;
> +}
> +
> +efi_status_t handle_kernel_image(unsigned long *image_addr,
> +                                unsigned long *image_size,
> +                                unsigned long *reserve_addr,
> +                                unsigned long *reserve_size,
> +                                efi_loaded_image_t *image,
> +                                efi_handle_t image_handle)
> +{
> +       efi_status_t status;
> +       unsigned long kernel_addr = 0;
> +
> +       kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
> +
> +       status = efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
> +                                    PHYSADDR(VMLINUX_LOAD_ADDRESS), SZ_2M, 0x0);
> +
> +       *image_addr = kernel_addr;
> +       *image_size = kernel_asize;
> +
> +       return status;
> +}
> +
> +void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned long fdt, unsigned long fdt_size)
> +{
> +       kernel_entry_t real_kernel_entry;
> +
> +       /* Config Direct Mapping */
> +       csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> +       csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> +
> +       real_kernel_entry = (kernel_entry_t)
> +               ((unsigned long)&kernel_entry - entrypoint + VMLINUX_LOAD_ADDRESS);
> +
> +       if (!efi_novamap)
> +               real_kernel_entry(true, fdt);
> +       else
> +               real_kernel_entry(false, fdt);
> +}
> diff --git a/include/linux/pe.h b/include/linux/pe.h
> index daf09ffffe38..1d3836ef9d92 100644
> --- a/include/linux/pe.h
> +++ b/include/linux/pe.h
> @@ -65,6 +65,8 @@
>  #define        IMAGE_FILE_MACHINE_SH5          0x01a8
>  #define        IMAGE_FILE_MACHINE_THUMB        0x01c2
>  #define        IMAGE_FILE_MACHINE_WCEMIPSV2    0x0169
> +#define        IMAGE_FILE_MACHINE_LOONGARCH32  0x6232
> +#define        IMAGE_FILE_MACHINE_LOONGARCH64  0x6264
>
>  /* flags */
>  #define IMAGE_FILE_RELOCS_STRIPPED           0x0001

This is looking really good now! Thanks for taking my feedback so seriously.

We will have to figure out how to queue this up, given that I intend
to queue the generic EFI zboot changes for v6.1 as well.
