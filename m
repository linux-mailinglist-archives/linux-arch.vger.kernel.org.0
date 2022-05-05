Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7F51BCA3
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 11:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354839AbiEEKDP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 06:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354797AbiEEKDN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 06:03:13 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C510506F4;
        Thu,  5 May 2022 02:59:27 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id w124so3692739vsb.8;
        Thu, 05 May 2022 02:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoTiDbKSQ06IqNUVzO81nJKbuUKuW+Zfqrx8UpY8nOc=;
        b=XWmma0qvFMAZpy2JqxFinHffBlRke6AV0LYCVsTLzfwlhuL1eB6F1T6r+tOPHdWkED
         au1lbV5WgxigUaY4fXN7eqIC3uWKmbZZlt2z5oPQmrDGnhXouyQbm6/wsybg5c9WQYnv
         ApSfm/3P2x7Xq+5NDI97p57k18tZj7ce2AVy1YyMPiszGrNhRjicnEuiH5Lx8SRh5boc
         awGwVYi2fUahnfRr9G/Ohk3xA0ngizELvwqOyOiLlnxeGYpT/uw3qpjWja5ckZAIluWk
         Enxzu3RCH/fuMfQGJ3+gk20kbld19yCvwRDPn1puxuRqQxuJKX8CqcFmuO8Eq/uN+fHx
         m2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoTiDbKSQ06IqNUVzO81nJKbuUKuW+Zfqrx8UpY8nOc=;
        b=zEacrUpHU16J3NzlARVRrx+c7SWgD/4m4PwDpRrrmT65vDEnmyOqEIyuSPAwnMyVei
         j0zbh4senhGMiuixSu0R+b1S0EvWXDqzOKMRu8SmMvpzLF4/YD7B6nvuh6hXCl2/NAoG
         5VS9Llh0OpW1xBZmhQMRLS1mJslgexL0puwAudt+d/f8pX6mCv6kRXBZ6BNxK6xLCAPc
         I2MxMsG5nKykxUukDkVZxoYN5NmUJdPaWFek+HSEnTz77lw/BMAVdg37Ofv2rdmO0l4v
         BV5qFjEZaY/EcDWAjCaD/uryCc2IbmAaBowU8kpad4SpTrlilgsg/o8ESkr9+tF7fIQl
         dWog==
X-Gm-Message-State: AOAM532U8OLm4wVOtXsdT4D+E2pObciAG9ZcUKihiN22KwCZ0rS0VZQN
        mhW2GLaSgLcw/qoDNWgQrZeYB9TmENY/Ee/L3OxZtWI5fB8=
X-Google-Smtp-Source: ABdhPJyPt9LfJBu8ZVFrWVaKq127LIpEf9sV0p8/uRoLNQ24Po1fIpSEieaodzrrEhcabAd9hJquN3YpRztr24/VRIw=
X-Received: by 2002:a67:e9d1:0:b0:32c:eb44:efd6 with SMTP id
 q17-20020a67e9d1000000b0032ceb44efd6mr7725838vso.16.1651744765868; Thu, 05
 May 2022 02:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-21-chenhuacai@loongson.cn> <CAK8P3a2SPTLLrZtSz0LT0LqMpq4SKCScD4vLvr+DJn+u5W_CdA@mail.gmail.com>
 <CAMj1kXEDpJwLDD4ZGLwzdo1KcJG_90iD9MnBVamCK06YKF7BdA@mail.gmail.com>
In-Reply-To: <CAMj1kXEDpJwLDD4ZGLwzdo1KcJG_90iD9MnBVamCK06YKF7BdA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 5 May 2022 17:59:17 +0800
Message-ID: <CAAhV-H4eR5YvhABp9L4FBmofWwH+XM3V_nOjatQTV_M7Gihs7g@mail.gmail.com>
Subject: Re: [PATCH V9 20/24] LoongArch: Add efistub booting support
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ard,

On Tue, May 3, 2022 at 3:24 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 30 Apr 2022 at 11:56, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > This patch adds efistub booting support, which is the standard UEFI boot
> > > protocol for us to use.
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >
> > It's good to see that you completed this. Unfortunately you did not add Ard
> > Biesheuvel to Cc, he is the one who needs to review this code. Adding him
> > to Cc now, with the full patch quoted below for him (no more comments
> > from me there).
> >
>
> Thanks Arnd,
>
> >
> > > ---
> > >  arch/loongarch/Kbuild                         |   3 +
> > >  arch/loongarch/Kconfig                        |   8 +
> > >  arch/loongarch/Makefile                       |  18 +-
> > >  arch/loongarch/boot/Makefile                  |  23 +
> > >  arch/loongarch/kernel/efi-header.S            | 100 +++++
> > >  arch/loongarch/kernel/head.S                  |  44 +-
> > >  arch/loongarch/kernel/image-vars.h            |  30 ++
> > >  arch/loongarch/kernel/vmlinux.lds.S           |  23 +-
> > >  drivers/firmware/efi/Kconfig                  |   4 +-
> > >  drivers/firmware/efi/libstub/Makefile         |  14 +-
> > >  drivers/firmware/efi/libstub/loongarch-stub.c | 425 ++++++++++++++++++
> > >  include/linux/pe.h                            |   1 +
> > >  12 files changed, 680 insertions(+), 13 deletions(-)
> > >  create mode 100644 arch/loongarch/boot/Makefile
> > >  create mode 100644 arch/loongarch/kernel/efi-header.S
> > >  create mode 100644 arch/loongarch/kernel/image-vars.h
> > >  create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.c
> > >
> > > diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
> > > index 1ad35aabdd16..ab5373d0a24f 100644
> > > --- a/arch/loongarch/Kbuild
> > > +++ b/arch/loongarch/Kbuild
> > > @@ -1,3 +1,6 @@
> > >  obj-y += kernel/
> > >  obj-y += mm/
> > >  obj-y += vdso/
> > > +
> > > +# for cleaning
> > > +subdir- += boot
> > > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > > index 44b763046893..55225ee5f868 100644
> > > --- a/arch/loongarch/Kconfig
> > > +++ b/arch/loongarch/Kconfig
> > > @@ -265,6 +265,14 @@ config EFI
> > >           resultant kernel should continue to boot on existing non-EFI
> > >           platforms.
> > >
> > > +config EFI_STUB
> > > +       bool "EFI boot stub support"
> > > +       default y
> > > +       depends on EFI
> > > +       help
> > > +         This kernel feature allows the kernel to be loaded directly by
> > > +         EFI firmware without the use of a bootloader.
> > > +
>
> Please enable EFI_GENERIC_STUB here
>
> > >  config FORCE_MAX_ZONEORDER
> > >         int "Maximum zone order"
> > >         range 14 64 if PAGE_SIZE_64KB
> > > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > > index c4b3f53cd276..d88a792dafbe 100644
> > > --- a/arch/loongarch/Makefile
> > > +++ b/arch/loongarch/Makefile
> > > @@ -3,6 +3,14 @@
> > >  # Author: Huacai Chen <chenhuacai@loongson.cn>
> > >  # Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > >
> > > +boot   := arch/loongarch/boot
> > > +
> > > +ifndef CONFIG_EFI_STUB
> > > +KBUILD_IMAGE   = $(boot)/vmlinux
> > > +else
> > > +KBUILD_IMAGE   = $(boot)/vmlinux.efi
> > > +endif
> > > +
> > >  #
> > >  # Select the object file format to substitute into the linker script.
> > >  #
> > > @@ -30,8 +38,6 @@ ld-emul                       = $(64bit-emul)
> > >  cflags-y               += -mabi=lp64s
> > >  endif
> > >
> > > -all-y                  := vmlinux
> > > -
> > >  #
> > >  # GCC uses -G0 -mabicalls -fpic as default.  We don't want PIC in the kernel
> > >  # code since it only slows down the whole thing.  At some point we might make
> > > @@ -75,6 +81,7 @@ endif
> > >  head-y := arch/loongarch/kernel/head.o
> > >
> > >  libs-y += arch/loongarch/lib/
> > > +libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> > >
> > >  ifeq ($(KBUILD_EXTMOD),)
> > >  prepare: vdso_prepare
> > > @@ -86,12 +93,13 @@ PHONY += vdso_install
> > >  vdso_install:
> > >         $(Q)$(MAKE) $(build)=arch/loongarch/vdso $@
> > >
> > > -all:   $(all-y)
> > > +all:   $(KBUILD_IMAGE)
> > >
> > > -CLEAN_FILES += vmlinux
> > > +$(KBUILD_IMAGE): vmlinux
> > > +       $(Q)$(MAKE) $(build)=$(boot) $(bootvars-y) $@
> > >
> > >  install:
> > > -       $(Q)install -D -m 755 vmlinux $(INSTALL_PATH)/vmlinux-$(KERNELRELEASE)
> > > +       $(Q)install -D -m 755 $(KBUILD_IMAGE) $(INSTALL_PATH)/vmlinux-$(KERNELRELEASE)
> > >         $(Q)install -D -m 644 .config $(INSTALL_PATH)/config-$(KERNELRELEASE)
> > >         $(Q)install -D -m 644 System.map $(INSTALL_PATH)/System.map-$(KERNELRELEASE)
> > >
> > > diff --git a/arch/loongarch/boot/Makefile b/arch/loongarch/boot/Makefile
> > > new file mode 100644
> > > index 000000000000..66f2293c34b2
> > > --- /dev/null
> > > +++ b/arch/loongarch/boot/Makefile
> > > @@ -0,0 +1,23 @@
> > > +#
> > > +# arch/loongarch/boot/Makefile
> > > +#
> > > +# Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > > +#
> > > +
> > > +drop-sections := .comment .note .options .note.gnu.build-id
> > > +strip-flags   := $(addprefix --remove-section=,$(drop-sections)) -S
> > > +
> > > +targets := vmlinux
> > > +quiet_cmd_strip = STRIP          $@
> > > +      cmd_strip = $(STRIP) -s $@
> > > +
> > > +$(obj)/vmlinux: vmlinux FORCE
> > > +       $(call if_changed,copy)
> > > +       $(call if_changed,strip)
> > > +
>
> I don't think you are supposed to use if_changed twice on the same target.
OK, thanks.

>
> > > +targets += vmlinux.efi
> > > +quiet_cmd_eficopy = OBJCOPY $@
> > > +      cmd_eficopy = $(OBJCOPY) -O binary $(strip-flags) $< $@
> > > +
>
> You could use the generic cmd_objcopy here instead of inventing your
> own. Just set OBJCOPYFLAGS_vmlinux.efi to the right value.
OK, thanks.

>
> > > +$(obj)/vmlinux.efi: $(obj)/vmlinux FORCE
> > > +       $(call if_changed,eficopy)
> > > diff --git a/arch/loongarch/kernel/efi-header.S b/arch/loongarch/kernel/efi-header.S
> > > new file mode 100644
> > > index 000000000000..ceb44524944a
> > > --- /dev/null
> > > +++ b/arch/loongarch/kernel/efi-header.S
> > > @@ -0,0 +1,100 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > > + */
> > > +
> > > +#include <linux/pe.h>
> > > +#include <linux/sizes.h>
> > > +
> > > +       .macro  __EFI_PE_HEADER
> > > +       .long   PE_MAGIC
> > > +coff_header:
>
> Please use .L prefixed local symbol definitions in this file, so we
> don't clutter up the core kernel's global symbol table.
I found that ARM64 uses .L prefix while RISCV doesn't, so I suppose
that both OK?

>
> > > +       .short  IMAGE_FILE_MACHINE_LOONGARCH            /* Machine */
> > > +       .short  section_count                           /* NumberOfSections */
> > > +       .long   0                                       /* TimeDateStamp */
> > > +       .long   0                                       /* PointerToSymbolTable */
> > > +       .long   0                                       /* NumberOfSymbols */
> > > +       .short  section_table - optional_header         /* SizeOfOptionalHeader */
> > > +       .short  IMAGE_FILE_DEBUG_STRIPPED | \
> > > +               IMAGE_FILE_EXECUTABLE_IMAGE | \
> > > +               IMAGE_FILE_LINE_NUMS_STRIPPED           /* Characteristics */
> > > +
> > > +optional_header:
> > > +       .short  PE_OPT_MAGIC_PE32PLUS                   /* PE32+ format */
> > > +       .byte   0x02                                    /* MajorLinkerVersion */
> > > +       .byte   0x14                                    /* MinorLinkerVersion */
> > > +       .long   __inittext_end - efi_header_end         /* SizeOfCode */
> > > +       .long   _end - __initdata_begin                 /* SizeOfInitializedData */
> > > +       .long   0                                       /* SizeOfUninitializedData */
> > > +       .long   __efistub_efi_pe_entry - _head          /* AddressOfEntryPoint */
> > > +       .long   efi_header_end - _head                  /* BaseOfCode */
> > > +
> > > +extra_header_fields:
> > > +       .quad   0                                       /* ImageBase */
> > > +       .long   PECOFF_SEGMENT_ALIGN                    /* SectionAlignment */
> > > +       .long   PECOFF_FILE_ALIGN                       /* FileAlignment */
> > > +       .short  0                                       /* MajorOperatingSystemVersion */
> > > +       .short  0                                       /* MinorOperatingSystemVersion */
> > > +       .short  0                                       /* MajorImageVersion */
> > > +       .short  0                                       /* MinorImageVersion */
>
> Once you enable EFI_GENERIC_STUB, set the above fields to
> EFISTUB_MAJOR_IMAGE_VERSION/EFISTUB_MINOR_IMAGE_VERSION, so
> bootloaders know they can use the LoadFile2 based initrd loader.
OK, versions will be filled.

>
> > > +       .short  0                                       /* MajorSubsystemVersion */
> > > +       .short  0                                       /* MinorSubsystemVersion */
> > > +       .long   0                                       /* Win32VersionValue */
> > > +
> > > +       .long   _end - _head                            /* SizeOfImage */
> > > +
> > > +       /* Everything before the kernel image is considered part of the header */
> > > +       .long   efi_header_end - _head                  /* SizeOfHeaders */
> > > +       .long   0                                       /* CheckSum */
> > > +       .short  IMAGE_SUBSYSTEM_EFI_APPLICATION         /* Subsystem */
> > > +       .short  0                                       /* DllCharacteristics */
> > > +       .quad   0                                       /* SizeOfStackReserve */
> > > +       .quad   0                                       /* SizeOfStackCommit */
> > > +       .quad   0                                       /* SizeOfHeapReserve */
> > > +       .quad   0                                       /* SizeOfHeapCommit */
> > > +       .long   0                                       /* LoaderFlags */
> > > +       .long   (section_table - .) / 8                 /* NumberOfRvaAndSizes */
> > > +
> > > +       .quad   0                                       /* ExportTable */
> > > +       .quad   0                                       /* ImportTable */
> > > +       .quad   0                                       /* ResourceTable */
> > > +       .quad   0                                       /* ExceptionTable */
> > > +       .quad   0                                       /* CertificationTable */
> > > +       .quad   0                                       /* BaseRelocationTable */
> > > +
> > > +       /* Section table */
> > > +section_table:
> > > +       .ascii  ".text\0\0\0"
> > > +       .long   __inittext_end - efi_header_end         /* VirtualSize */
> > > +       .long   efi_header_end - _head                  /* VirtualAddress */
> > > +       .long   __inittext_end - efi_header_end         /* SizeOfRawData */
> > > +       .long   efi_header_end - _head                  /* PointerToRawData */
> > > +
> > > +       .long   0                                       /* PointerToRelocations */
> > > +       .long   0                                       /* PointerToLineNumbers */
> > > +       .short  0                                       /* NumberOfRelocations */
> > > +       .short  0                                       /* NumberOfLineNumbers */
> > > +       .long   IMAGE_SCN_CNT_CODE | \
> > > +               IMAGE_SCN_MEM_READ | \
> > > +               IMAGE_SCN_MEM_EXECUTE                   /* Characteristics */
> > > +
> > > +       .ascii  ".data\0\0\0"
> > > +       .long   _end - __initdata_begin                 /* VirtualSize */
> > > +       .long   __initdata_begin - _head                /* VirtualAddress */
> > > +       .long   _edata - __initdata_begin               /* SizeOfRawData */
> > > +       .long   __initdata_begin - _head                /* PointerToRawData */
> > > +
> > > +       .long   0                                       /* PointerToRelocations */
> > > +       .long   0                                       /* PointerToLineNumbers */
> > > +       .short  0                                       /* NumberOfRelocations */
> > > +       .short  0                                       /* NumberOfLineNumbers */
> > > +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA | \
> > > +               IMAGE_SCN_MEM_READ | \
> > > +               IMAGE_SCN_MEM_WRITE                     /* Characteristics */
> > > +
> > > +       .org 0x20e
> > > +       .word kernel_version - 512 -  _head
> > > +
> > > +       .set    section_count, (. - section_table) / 40
> > > +efi_header_end:
> > > +       .endm
> > > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > > index b4a0b28da3e7..361b72e8bfc5 100644
> > > --- a/arch/loongarch/kernel/head.S
> > > +++ b/arch/loongarch/kernel/head.S
> > > @@ -11,11 +11,53 @@
> > >  #include <asm/regdef.h>
> > >  #include <asm/loongarch.h>
> > >  #include <asm/stackframe.h>
> > > +#include <generated/compile.h>
> > > +#include <generated/utsrelease.h>
> > >
> > > -SYM_ENTRY(_stext, SYM_L_GLOBAL, SYM_A_NONE)
> > > +#ifdef CONFIG_EFI_STUB
> > > +
> > > +#include "efi-header.S"
> > > +
> > > +       __HEAD
> > > +
> > > +_head:
> > > +       /* "MZ", MS-DOS header */
> > > +       .word   MZ_MAGIC
> > > +       .org    0x28
> > > +       .ascii  "Loongson\0"
>
> Is this part of a special boot protocol? It would be better not to
> overload EFI and PE/COFF with your own hacks if we can avoid it.
This is used as a magic string and Grub will check it.

>
> > > +       .org    0x3c
> > > +       /* Offset to the PE header */
> > > +       .long   pe_header - _head
> > > +
> > > +pe_header:
> > > +       __EFI_PE_HEADER
> > > +
> > > +kernel_asize:
> > > +       .long _end - _text
> > > +
> > > +kernel_fsize:
> > > +       .long _edata - _text
> > > +
> > > +kernel_vaddr:
> > > +       .quad VMLINUX_LOAD_ADDRESS
> > > +
> > > +kernel_offset:
> > > +       .long kernel_offset - _text
> > > +
> > > +kernel_version:
> > > +       .ascii  UTS_RELEASE " (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") " UTS_VERSION "\0"
> > > +
> > > +SYM_L_GLOBAL(kernel_asize)
> > > +SYM_L_GLOBAL(kernel_fsize)
> > > +SYM_L_GLOBAL(kernel_vaddr)
> > > +SYM_L_GLOBAL(kernel_offset)
>
> I think you can simplify this to
>
> SYM_DATA(kernel_asize, .long _end - _text);
>
> etc etc (which implies the .globl annotation)
OK, thanks.

>
>
> > > +
> > > +#endif
> > >
> > >         __REF
> > >
> > > +SYM_ENTRY(_stext, SYM_L_GLOBAL, SYM_A_NONE)
> > > +
> > >  SYM_CODE_START(kernel_entry)                   # kernel entry point
> > >
> > >         /* Config direct window and set PG */
> > > diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
> > > new file mode 100644
> > > index 000000000000..0162402b6212
> > > --- /dev/null
> > > +++ b/arch/loongarch/kernel/image-vars.h
> > > @@ -0,0 +1,30 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > > + */
> > > +#ifndef __LOONGARCH_KERNEL_IMAGE_VARS_H
> > > +#define __LOONGARCH_KERNEL_IMAGE_VARS_H
> > > +
> > > +#ifdef CONFIG_EFI_STUB
> > > +
> > > +__efistub_memcmp               = memcmp;
> > > +__efistub_memcpy               = memcpy;
> > > +__efistub_memmove              = memmove;
> > > +__efistub_memset               = memset;
> > > +__efistub_strcat               = strcat;
> > > +__efistub_strcmp               = strcmp;
> > > +__efistub_strlen               = strlen;
> > > +__efistub_strncat              = strncat;
> > > +__efistub_strnstr              = strnstr;
> > > +__efistub_strnlen              = strnlen;
> > > +__efistub_strpbrk              = strpbrk;
> > > +__efistub_strsep               = strsep;
> > > +__efistub_kernel_entry         = kernel_entry;
> > > +__efistub_kernel_asize         = kernel_asize;
> > > +__efistub_kernel_fsize         = kernel_fsize;
> > > +__efistub_kernel_vaddr         = kernel_vaddr;
> > > +__efistub_kernel_offset                = kernel_offset;
> > > +
> > > +#endif
> > > +
> > > +#endif /* __LOONGARCH_KERNEL_IMAGE_VARS_H */
> > > diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> > > index 02abfaaa4892..7da4c4d7c50d 100644
> > > --- a/arch/loongarch/kernel/vmlinux.lds.S
> > > +++ b/arch/loongarch/kernel/vmlinux.lds.S
> > > @@ -12,6 +12,14 @@
> > >  #define BSS_FIRST_SECTIONS *(.bss..swapper_pg_dir)
> > >
> > >  #include <asm-generic/vmlinux.lds.h>
> > > +#include "image-vars.h"
> > > +
> > > +/*
> > > + * Max avaliable Page Size is 64K, so we set SectionAlignment
> > > + * field of EFI application to 64K.
> > > + */
> > > +PECOFF_FILE_ALIGN = 0x200;
> > > +PECOFF_SEGMENT_ALIGN = 0x10000;
> > >
> > >  OUTPUT_ARCH(loongarch)
> > >  ENTRY(kernel_entry)
> > > @@ -27,6 +35,9 @@ SECTIONS
> > >         . = VMLINUX_LOAD_ADDRESS;
> > >
> > >         _text = .;
> > > +       HEAD_TEXT_SECTION
> > > +
> > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > >         .text : {
> > >                 TEXT_TEXT
> > >                 SCHED_TEXT
> > > @@ -38,11 +49,12 @@ SECTIONS
> > >                 *(.fixup)
> > >                 *(.gnu.warning)
> > >         } :text = 0
> > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > >         _etext = .;
> > >
> > >         EXCEPTION_TABLE(16)
> > >
> > > -       . = ALIGN(PAGE_SIZE);
> > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > >         __init_begin = .;
> > >         __inittext_begin = .;
> > >
> > > @@ -51,6 +63,7 @@ SECTIONS
> > >                 EXIT_TEXT
> > >         }
> > >
> > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > >         __inittext_end = .;
> > >
> > >         __initdata_begin = .;
> > > @@ -60,6 +73,10 @@ SECTIONS
> > >                 EXIT_DATA
> > >         }
> > >
> > > +       .init.bss : {
> > > +               *(.init.bss)
> > > +       }
> > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > >         __initdata_end = .;
> > >
> > >         __init_end = .;
> > > @@ -71,11 +88,11 @@ SECTIONS
> > >         .sdata : {
> > >                 *(.sdata)
> > >         }
> > > -
> > > -       . = ALIGN(SZ_64K);
> > > +       .edata_padding : { BYTE(0); . = ALIGN(PECOFF_FILE_ALIGN); }
> > >         _edata =  .;
> > >
> > >         BSS_SECTION(0, SZ_64K, 8)
> > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > >
> > >         _end = .;
> > >
> > > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > > index 2c3dac5ecb36..ecb4e0b1295a 100644
> > > --- a/drivers/firmware/efi/Kconfig
> > > +++ b/drivers/firmware/efi/Kconfig
> > > @@ -121,9 +121,9 @@ config EFI_ARMSTUB_DTB_LOADER
> > >
> > >  config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
> > >         bool "Enable the command line initrd loader" if !X86
> > > -       depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
> > > -       default y if X86
> > >         depends on !RISCV
> > > +       depends on EFI_STUB && (EFI_GENERIC_STUB || X86 || LOONGARCH)
> > > +       default y if (X86 || LOONGARCH)
>
> Don't enable the command line initrd loader please. It is deprecated,
> and has been replaced with the LoadFile2 protocol based one, which is
> more flexible.
>
> Uboot already implements it, as well as EDK2. GRUB does not implement
> this yet afair, but it should not be that hard to add.
If we don't select this, is it possible to load initrd in the UEFI shell?

>
> > >         help
> > >           Select this config option to add support for the initrd= command
> > >           line parameter, allowing an initrd that resides on the same volume
> > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > index d0537573501e..663e9d317299 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -26,6 +26,8 @@ cflags-$(CONFIG_ARM)          := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > >                                    $(call cc-option,-mno-single-pic-base)
> > >  cflags-$(CONFIG_RISCV)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > >                                    -fpic
> > > +cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > +                                  -fpic
> > >
> > >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > >
> > > @@ -55,7 +57,7 @@ KCOV_INSTRUMENT                       := n
> > >  lib-y                          := efi-stub-helper.o gop.o secureboot.o tpm.o \
> > >                                    file.o mem.o random.o randomalloc.o pci.o \
> > >                                    skip_spaces.o lib-cmdline.o lib-ctype.o \
> > > -                                  alignedmem.o relocate.o vsprintf.o
> > > +                                  alignedmem.o relocate.o string.o vsprintf.o
> > >
> > >  # include the stub's generic dependencies from lib/ when building for ARM/arm64
> > >  efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> > > @@ -63,13 +65,15 @@ efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> > >  $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
> > >         $(call if_changed_rule,cc_o_c)
> > >
> > > -lib-$(CONFIG_EFI_GENERIC_STUB) += efi-stub.o fdt.o string.o \
> > > +lib-$(CONFIG_EFI_GENERIC_STUB) += efi-stub.o fdt.o \
> > >                                    $(patsubst %.c,lib-%.o,$(efi-deps-y))
> > >
> > >  lib-$(CONFIG_ARM)              += arm32-stub.o
> > >  lib-$(CONFIG_ARM64)            += arm64-stub.o
> > >  lib-$(CONFIG_X86)              += x86-stub.o
> > >  lib-$(CONFIG_RISCV)            += riscv-stub.o
> > > +lib-$(CONFIG_LOONGARCH)                += loongarch-stub.o
> > > +
> > >  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > >
> > >  # Even when -mbranch-protection=none is set, Clang will generate a
> > > @@ -125,6 +129,12 @@ STUBCOPY_FLAGS-$(CONFIG_RISCV)     += --prefix-alloc-sections=.init \
> > >                                    --prefix-symbols=__efistub_
> > >  STUBCOPY_RELOC-$(CONFIG_RISCV) := R_RISCV_HI20
> > >
> > > +# For LoongArch, keep all the symbols in .init section and make sure that no
> > > +# absolute symbols references doesn't exist.
> > > +STUBCOPY_FLAGS-$(CONFIG_LOONGARCH)     += --prefix-alloc-sections=.init \
> > > +                                          --prefix-symbols=__efistub_
> > > +STUBCOPY_RELOC-$(CONFIG_LOONGARCH)     := R_LARCH_MARK_LA
> > > +
> > >  $(obj)/%.stub.o: $(obj)/%.o FORCE
> > >         $(call if_changed,stubcopy)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > new file mode 100644
> > > index 000000000000..399641a0b0cb
> > > --- /dev/null
> > > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > @@ -0,0 +1,425 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Author: Yun Liu <liuyun@loongson.cn>
> > > + *         Huacai Chen <chenhuacai@loongson.cn>
> > > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > > + */
> > > +
> > > +#include <linux/efi.h>
> > > +#include <linux/sort.h>
> > > +#include <asm/efi.h>
> > > +#include <asm/addrspace.h>
> > > +#include <asm/boot_param.h>
> > > +#include "efistub.h"
> > > +
> > > +#define MAX_ARG_COUNT          128
> > > +#define CMDLINE_MAX_SIZE       0x200
> > > +
> > > +static int argc;
> > > +static char **argv;
> > > +const efi_system_table_t *efi_system_table;
> > > +static efi_guid_t screen_info_guid = LINUX_EFI_LARCH_SCREEN_INFO_TABLE_GUID;
> > > +static unsigned int map_entry[LOONGSON3_BOOT_MEM_MAP_MAX];
> > > +static struct efi_mmap mmap_array[EFI_MAX_MEMORY_TYPE][LOONGSON3_BOOT_MEM_MAP_MAX];
> > > +
> > > +struct exit_boot_struct {
> > > +       struct boot_params *bp;
> > > +       unsigned int *runtime_entry_count;
> > > +};
> > > +
> > > +typedef void (*kernel_entry_t)(int argc, char *argv[], struct boot_params *boot_p);
> > > +
> > > +extern int kernel_asize;
> > > +extern int kernel_fsize;
> > > +extern int kernel_offset;
> > > +extern unsigned long kernel_vaddr;
> > > +extern kernel_entry_t kernel_entry;
> > > +
> > > +unsigned char efi_crc8(char *buff, int size)
> > > +{
> > > +       int sum, cnt;
> > > +
> > > +       for (sum = 0, cnt = 0; cnt < size; cnt++)
> > > +               sum = (char) (sum + *(buff + cnt));
> > > +
> > > +       return (char)(0x100 - sum);
> > > +}
> > > +
> > > +struct screen_info *alloc_screen_info(void)
> > > +{
> > > +       efi_status_t status;
> > > +       struct screen_info *si;
> > > +
> > > +       status = efi_bs_call(allocate_pool,
> > > +                       EFI_RUNTIME_SERVICES_DATA, sizeof(*si), (void **)&si);
> > > +       if (status != EFI_SUCCESS)
> > > +               return NULL;
> > > +
> > > +       status = efi_bs_call(install_configuration_table, &screen_info_guid, si);
> > > +       if (status == EFI_SUCCESS)
> > > +               return si;
> > > +
> > > +       efi_bs_call(free_pool, si);
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > > +static void setup_graphics(void)
> > > +{
> > > +       unsigned long size;
> > > +       efi_status_t status;
> > > +       efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
> > > +       void **gop_handle = NULL;
> > > +       struct screen_info *si = NULL;
> > > +
> > > +       size = 0;
> > > +       status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
> > > +                               &gop_proto, NULL, &size, gop_handle);
> > > +       if (status == EFI_BUFFER_TOO_SMALL) {
> > > +               si = alloc_screen_info();
> > > +               efi_setup_gop(si, &gop_proto, size);
> > > +       }
> > > +}
> > > +
> > > +struct boot_params *bootparams_init(efi_system_table_t *sys_table)
> > > +{
> > > +       efi_status_t status;
> > > +       struct boot_params *p;
> > > +       unsigned char sig[8] = {'B', 'P', 'I', '0', '1', '0', '0', '2'};
> > > +
> > > +       status = efi_bs_call(allocate_pool, EFI_RUNTIME_SERVICES_DATA, SZ_64K, (void **)&p);
> > > +       if (status != EFI_SUCCESS)
> > > +               return NULL;
> > > +
> > > +       memset(p, 0, SZ_64K);
> > > +       memcpy(&p->signature, sig, sizeof(long));
> > > +
> > > +       return p;
> > > +}
> > > +
> > > +static unsigned long convert_priv_cmdline(char *cmdline_ptr,
> > > +               unsigned long rd_addr, unsigned long rd_size)
> > > +{
> > > +       unsigned int rdprev_size;
> > > +       unsigned int cmdline_size;
> > > +       efi_status_t status;
> > > +       char *pstr, *substr;
> > > +       char *initrd_ptr = NULL;
> > > +       char convert_str[CMDLINE_MAX_SIZE];
> > > +       static char cmdline_array[CMDLINE_MAX_SIZE];
> > > +
> > > +       cmdline_size = strlen(cmdline_ptr);
> > > +       snprintf(cmdline_array, CMDLINE_MAX_SIZE, "kernel ");
> > > +
> > > +       initrd_ptr = strstr(cmdline_ptr, "initrd=");
> > > +       if (!initrd_ptr) {
> > > +               snprintf(cmdline_array, CMDLINE_MAX_SIZE, "kernel %s", cmdline_ptr);
> > > +               goto completed;
> > > +       }
> > > +       snprintf(convert_str, CMDLINE_MAX_SIZE, " initrd=0x%lx,0x%lx", rd_addr, rd_size);
> > > +       rdprev_size = cmdline_size - strlen(initrd_ptr);
> > > +       strncat(cmdline_array, cmdline_ptr, rdprev_size);
> > > +
> > > +       cmdline_ptr = strnstr(initrd_ptr, " ", CMDLINE_MAX_SIZE);
> > > +       strcat(cmdline_array, convert_str);
> > > +       if (!cmdline_ptr)
> > > +               goto completed;
> > > +
> > > +       strcat(cmdline_array, cmdline_ptr);
> > > +
> > > +completed:
> > > +       status = efi_allocate_pages((MAX_ARG_COUNT + 1) * (sizeof(char *)),
> > > +                                       (unsigned long *)&argv, ULONG_MAX);
> > > +       if (status != EFI_SUCCESS) {
> > > +               efi_err("Alloc argv mmap_array error\n");
> > > +               return status;
> > > +       }
> > > +
> > > +       argc = 0;
> > > +       pstr = cmdline_array;
> > > +
> > > +       substr = strsep(&pstr, " \t");
> > > +       while (substr != NULL) {
> > > +               if (strlen(substr)) {
> > > +                       argv[argc++] = substr;
> > > +                       if (argc == MAX_ARG_COUNT) {
> > > +                               efi_err("Argv mmap_array full!\n");
> > > +                               break;
> > > +                       }
> > > +               }
> > > +               substr = strsep(&pstr, " \t");
> > > +       }
> > > +
> > > +       return EFI_SUCCESS;
> > > +}
> > > +
> > > +unsigned int efi_memmap_sort(struct loongsonlist_mem_map *memmap,
> > > +                       unsigned int index, unsigned int mem_type)
> > > +{
> > > +       unsigned int i, t;
> > > +       unsigned long msize;
> > > +
> > > +       for (i = 0; i < map_entry[mem_type]; i = t) {
> > > +               msize = mmap_array[mem_type][i].mem_size;
> > > +               for (t = i + 1; t < map_entry[mem_type]; t++) {
> > > +                       if (mmap_array[mem_type][i].mem_start + msize <
> > > +                                       mmap_array[mem_type][t].mem_start)
> > > +                               break;
> > > +
> > > +                       msize += mmap_array[mem_type][t].mem_size;
> > > +               }
> > > +               memmap->map[index].mem_type = mem_type;
> > > +               memmap->map[index].mem_start = mmap_array[mem_type][i].mem_start;
> > > +               memmap->map[index].mem_size = msize;
> > > +               memmap->map[index].attribute = mmap_array[mem_type][i].attribute;
> > > +               index++;
> > > +       }
> > > +
> > > +       return index;
> > > +}
> > > +
> > > +static efi_status_t mk_mmap(struct efi_boot_memmap *map, struct boot_params *p)
> > > +{
>
> Are you passing a different representation of the memory map to the
> core kernel? I think it would be easier just to pass the EFI memory
> map like other EFI arches do, and reuse all of the code that we
> already have.
Yes, this different representation is used by our "boot_params", the
interface between bootloader (including efistub) and the core kernel.
>
> > > +       char checksum;
> > > +       unsigned int i;
> > > +       unsigned int nr_desc;
> > > +       unsigned int mem_type;
> > > +       unsigned long count;
> > > +       efi_memory_desc_t *mem_desc;
> > > +       struct loongsonlist_mem_map *mhp = NULL;
> > > +
> > > +       memset(map_entry, 0, sizeof(map_entry));
> > > +       memset(mmap_array, 0, sizeof(mmap_array));
> > > +
> > > +       if (!strncmp((char *)p, "BPI", 3)) {
> > > +               p->flags |= BPI_FLAGS_UEFI_SUPPORTED;
> > > +               p->systemtable = (efi_system_table_t *)efi_system_table;
> > > +               p->extlist_offset = sizeof(*p) + sizeof(unsigned long);
> > > +               mhp = (struct loongsonlist_mem_map *)((char *)p + p->extlist_offset);
> > > +
> > > +               memcpy(&mhp->header.signature, "MEM", sizeof(unsigned long));
> > > +               mhp->header.length = sizeof(*mhp);
> > > +               mhp->desc_version = *map->desc_ver;
> > > +               mhp->map_count = 0;
> > > +       }
> > > +       if (!(*(map->map_size)) || !(*(map->desc_size)) || !mhp) {
> > > +               efi_err("get memory info error\n");
> > > +               return EFI_INVALID_PARAMETER;
> > > +       }
> > > +       nr_desc = *(map->map_size) / *(map->desc_size);
> > > +
> > > +       /*
> > > +        * According to UEFI SPEC, mmap_buf is the accurate Memory Map
> > > +        * mmap_array now we can fill platform specific memory structure.
> > > +        */
> > > +       for (i = 0; i < nr_desc; i++) {
> > > +               mem_desc = (efi_memory_desc_t *)((void *)(*map->map) + (i * (*(map->desc_size))));
> > > +               switch (mem_desc->type) {
> > > +               case EFI_RESERVED_TYPE:
> > > +               case EFI_RUNTIME_SERVICES_CODE:
> > > +               case EFI_RUNTIME_SERVICES_DATA:
> > > +               case EFI_MEMORY_MAPPED_IO:
> > > +               case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
> > > +               case EFI_UNUSABLE_MEMORY:
> > > +               case EFI_PAL_CODE:
> > > +                       mem_type = ADDRESS_TYPE_RESERVED;
> > > +                       break;
> > > +
> > > +               case EFI_ACPI_MEMORY_NVS:
> > > +                       mem_type = ADDRESS_TYPE_NVS;
> > > +                       break;
> > > +
> > > +               case EFI_ACPI_RECLAIM_MEMORY:
> > > +                       mem_type = ADDRESS_TYPE_ACPI;
> > > +                       break;
> > > +
> > > +               case EFI_LOADER_CODE:
> > > +               case EFI_LOADER_DATA:
> > > +               case EFI_PERSISTENT_MEMORY:
> > > +               case EFI_BOOT_SERVICES_CODE:
> > > +               case EFI_BOOT_SERVICES_DATA:
> > > +               case EFI_CONVENTIONAL_MEMORY:
> > > +                       mem_type = ADDRESS_TYPE_SYSRAM;
> > > +                       break;
> > > +
> > > +               default:
> > > +                       continue;
> > > +               }
> > > +
> > > +               mmap_array[mem_type][map_entry[mem_type]].mem_type = mem_type;
> > > +               mmap_array[mem_type][map_entry[mem_type]].mem_start =
> > > +                                               mem_desc->phys_addr & TO_PHYS_MASK;
> > > +               mmap_array[mem_type][map_entry[mem_type]].mem_size =
> > > +                                               mem_desc->num_pages << EFI_PAGE_SHIFT;
> > > +               mmap_array[mem_type][map_entry[mem_type]].attribute =
> > > +                                               mem_desc->attribute;
> > > +               map_entry[mem_type]++;
> > > +       }
> > > +
> > > +       count = mhp->map_count;
> > > +       /* Sort EFI memmap and add to BPI for kernel */
> > > +       for (i = 0; i < LOONGSON3_BOOT_MEM_MAP_MAX; i++) {
> > > +               if (!map_entry[i])
> > > +                       continue;
> > > +               count = efi_memmap_sort(mhp, count, i);
> > > +       }
> > > +
> > > +       mhp->map_count = count;
> > > +       mhp->header.checksum = 0;
> > > +
> > > +       checksum = efi_crc8((char *)mhp, mhp->header.length);
> > > +       mhp->header.checksum = checksum;
> > > +
> > > +       return EFI_SUCCESS;
> > > +}
> > > +
> > > +static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
> > > +{
> > > +       efi_status_t status;
> > > +       struct exit_boot_struct *p = priv;
> > > +
> > > +       status = mk_mmap(map, p->bp);
> > > +       if (status != EFI_SUCCESS) {
> > > +               efi_err("Make kernel memory map failed!\n");
> > > +               return status;
> > > +       }
> > > +
> > > +       return EFI_SUCCESS;
> > > +}
> > > +
> > > +static efi_status_t exit_boot_services(struct boot_params *boot_params, void *handle)
> > > +{
> > > +       unsigned int desc_version;
> > > +       unsigned int runtime_entry_count = 0;
> > > +       unsigned long map_size, key, desc_size, buff_size;
> > > +       efi_status_t status;
> > > +       efi_memory_desc_t *mem_map;
> > > +       struct efi_boot_memmap map;
> > > +       struct exit_boot_struct priv;
> > > +
> > > +       map.map                 = &mem_map;
> > > +       map.map_size            = &map_size;
> > > +       map.desc_size           = &desc_size;
> > > +       map.desc_ver            = &desc_version;
> > > +       map.key_ptr             = &key;
> > > +       map.buff_size           = &buff_size;
> > > +       status = efi_get_memory_map(&map);
> > > +       if (status != EFI_SUCCESS) {
> > > +               efi_err("Unable to retrieve UEFI memory map.\n");
> > > +               return status;
> > > +       }
> > > +
> > > +       priv.bp = boot_params;
> > > +       priv.runtime_entry_count = &runtime_entry_count;
> > > +
> > > +       /* Might as well exit boot services now */
> > > +       status = efi_exit_boot_services(handle, &map, &priv, exit_boot_func);
> > > +       if (status != EFI_SUCCESS)
> > > +               return status;
> > > +
> > > +       return EFI_SUCCESS;
> > > +}
> > > +
> > > +/*
> > > + * EFI entry point for the LoongArch EFI stub.
> > > + */
> > > +efi_status_t __efiapi efi_pe_entry(efi_handle_t handle, efi_system_table_t *sys_table)
>
> Why are you not using the generic EFI stub boot flow?
Hmmm, as I know, we define our own "boot_params", a interface between
bootloader (including efistub) and the core kernel to pass memmap,
cmdline and initrd information, three years ago. This method looks
like the X86 way, while different from the generic stub (which is
called arm stub before 5.8). In these years, many products have
already use the "boot_params" interface (including UEFI, PMON, Grub,
Kernel, etc., but most of them haven't be upstream). Replace
boot_params with FDT (i.e., the generic stub way) is difficult for us,
because it means a big broken of compatibility.

Huacai
>
> > > +{
> > > +       unsigned int cmdline_size = 0;
> > > +       unsigned long kernel_addr = 0;
> > > +       unsigned long initrd_addr = 0;
> > > +       unsigned long initrd_size = 0;
> > > +       enum efi_secureboot_mode secure_boot;
> > > +       char *cmdline_ptr = NULL;
> > > +       struct boot_params *boot_p;
> > > +       efi_status_t status;
> > > +       efi_loaded_image_t *image;
> > > +       efi_guid_t loaded_image_proto;
> > > +       kernel_entry_t real_kernel_entry;
> > > +
> > > +       /* Config Direct Mapping */
> > > +       csr_writeq(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> > > +       csr_writeq(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> > > +
>
> Why is this needed? Doesn't the EFI firmware enter the EFI loader with
> this mapping enabled?
>
> > > +       efi_system_table = sys_table;
> > > +       loaded_image_proto = LOADED_IMAGE_PROTOCOL_GUID;
> > > +       kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
> > > +       real_kernel_entry = (kernel_entry_t)
> > > +               ((unsigned long)&kernel_entry - kernel_addr + kernel_vaddr);
> > > +
> > > +       /* Check if we were booted by the EFI firmware */
> > > +       if (sys_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
> > > +               goto fail;
> > > +
> > > +       /*
> > > +        * Get a handle to the loaded image protocol.  This is used to get
> > > +        * information about the running image, such as size and the command
> > > +        * line.
> > > +        */
> > > +       status = sys_table->boottime->handle_protocol(handle,
> > > +                                       &loaded_image_proto, (void *)&image);
> > > +       if (status != EFI_SUCCESS) {
> > > +               efi_err("Failed to get loaded image protocol\n");
> > > +               goto fail;
> > > +       }
> > > +
> > > +       /* Get the command line from EFI, using the LOADED_IMAGE protocol. */
> > > +       cmdline_ptr = efi_convert_cmdline(image, &cmdline_size);
> > > +       if (!cmdline_ptr) {
> > > +               efi_err("Getting command line failed!\n");
> > > +               goto fail_free_cmdline;
> > > +       }
> > > +
> > > +#ifdef CONFIG_CMDLINE_BOOL
> > > +       if (cmdline_size == 0)
> > > +               efi_parse_options(CONFIG_CMDLINE);
> > > +#endif
> > > +       if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) && cmdline_size > 0)
> > > +               efi_parse_options(cmdline_ptr);
> > > +
> > > +       efi_info("Booting Linux Kernel...\n");
> > > +
> > > +       efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
> > > +                           PHYSADDR(kernel_vaddr), SZ_2M, PHYSADDR(kernel_vaddr));
> > > +
> > > +       setup_graphics();
> > > +       secure_boot = efi_get_secureboot();
> > > +       efi_enable_reset_attack_mitigation();
> > > +
> > > +       status = efi_load_initrd(image, &initrd_addr, &initrd_size, SZ_4G, ULONG_MAX);
> > > +       if (status != EFI_SUCCESS) {
> > > +               efi_err("Failed get initrd addr!\n");
> > > +               goto fail_free;
> > > +       }
> > > +
> > > +       status = convert_priv_cmdline(cmdline_ptr, initrd_addr, initrd_size);
> > > +       if (status != EFI_SUCCESS) {
> > > +               efi_err("Covert cmdline failed!\n");
> > > +               goto fail_free;
> > > +       }
> > > +
> > > +       boot_p = bootparams_init(sys_table);
> > > +       if (!boot_p) {
> > > +               efi_err("Create BPI struct error!\n");
> > > +               goto fail;
> > > +       }
> > > +
> > > +       status = exit_boot_services(boot_p, handle);
> > > +       if (status != EFI_SUCCESS) {
> > > +               efi_err("exit_boot services failed!\n");
> > > +               goto fail_free;
> > > +       }
> > > +
> > > +       real_kernel_entry(argc, argv, boot_p);
> > > +
> > > +       return EFI_SUCCESS;
> > > +
> > > +fail_free:
> > > +       efi_free(initrd_size, initrd_addr);
> > > +
> > > +fail_free_cmdline:
> > > +       efi_free(cmdline_size, (unsigned long)cmdline_ptr);
> > > +
> > > +fail:
> > > +       return status;
> > > +}
> > > diff --git a/include/linux/pe.h b/include/linux/pe.h
> > > index daf09ffffe38..f4bb0b6a416d 100644
> > > --- a/include/linux/pe.h
> > > +++ b/include/linux/pe.h
> > > @@ -65,6 +65,7 @@
> > >  #define        IMAGE_FILE_MACHINE_SH5          0x01a8
> > >  #define        IMAGE_FILE_MACHINE_THUMB        0x01c2
> > >  #define        IMAGE_FILE_MACHINE_WCEMIPSV2    0x0169
> > > +#define        IMAGE_FILE_MACHINE_LOONGARCH    0x6264
> > >
> > >  /* flags */
> > >  #define IMAGE_FILE_RELOCS_STRIPPED           0x0001
> > > --
> > > 2.27.0
> > >
