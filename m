Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B2351D329
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 10:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241766AbiEFITG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 04:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390010AbiEFISw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 04:18:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2CD6831D;
        Fri,  6 May 2022 01:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAE86B83406;
        Fri,  6 May 2022 08:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384BCC385C0;
        Fri,  6 May 2022 08:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651824905;
        bh=NVpqgnYsGL9Q0oIOy8n7qWMWKGAFKbRwrpZ0f4z4yVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h+4RgSx4uU+r0XJhyT0LRkqnR8ZhhIFISBzab8sN4hGVodpn20Ywirpe6l5um88xH
         z4WPyplUyeALxjKbmgR2eV6gscO+vI57D8kaLqx+ayGbt3ZMsfSxiE1j2S+yvJl1RX
         u6RNT401RgW2oehuFwMspybK4C0EF7D6RhfFBzm4WPhNjMMYSg5IxVWBb3QKgbmRTk
         xRvnE2Tj7msbILR8obHLRUR0/ucdETzAHnlntS5ho+lwClxccBjX7YYsUYfCTsMCiD
         9bJIjEQ7x0Y4Dk4ZB44qXzan30oNg8IXM0gb8xzM2Om79CbScpPtrb6radxtRhCWkK
         MUG8hsNGrkR7Q==
Received: by mail-ot1-f44.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so4489729oty.3;
        Fri, 06 May 2022 01:15:05 -0700 (PDT)
X-Gm-Message-State: AOAM530sg0wGH4SfRd0axpUWVUqKSASRvfK8U/bSD6kfWy4/saBppI0E
        l0jMp51euaYtM1xypMud8MS09XSyYH/NwnDLnas=
X-Google-Smtp-Source: ABdhPJy+XTaZGYBaRZlLY7Jg1dXnPv6KMAnzlzn1zcfTh+s5lIND/4tbtUCV62qmEOr2MK+eB/1taP+zN9kWiyB0f84=
X-Received: by 2002:a9d:84f:0:b0:605:e229:3c82 with SMTP id
 73-20020a9d084f000000b00605e2293c82mr656656oty.71.1651824904143; Fri, 06 May
 2022 01:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-21-chenhuacai@loongson.cn> <CAK8P3a2SPTLLrZtSz0LT0LqMpq4SKCScD4vLvr+DJn+u5W_CdA@mail.gmail.com>
 <CAMj1kXEDpJwLDD4ZGLwzdo1KcJG_90iD9MnBVamCK06YKF7BdA@mail.gmail.com> <CAAhV-H4eR5YvhABp9L4FBmofWwH+XM3V_nOjatQTV_M7Gihs7g@mail.gmail.com>
In-Reply-To: <CAAhV-H4eR5YvhABp9L4FBmofWwH+XM3V_nOjatQTV_M7Gihs7g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 6 May 2022 10:14:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFD8_CuijJFgQbrxvY4MVBLmKQKFKmYhD1NBFLn3v=+FQ@mail.gmail.com>
Message-ID: <CAMj1kXFD8_CuijJFgQbrxvY4MVBLmKQKFKmYhD1NBFLn3v=+FQ@mail.gmail.com>
Subject: Re: [PATCH V9 20/24] LoongArch: Add efistub booting support
To:     Huacai Chen <chenhuacai@gmail.com>
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 5 May 2022 at 11:59, Huacai Chen <chenhuacai@gmail.com> wrote:
>
> Hi, Ard,
>
> On Tue, May 3, 2022 at 3:24 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Sat, 30 Apr 2022 at 11:56, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > This patch adds efistub booting support, which is the standard UEFI boot
> > > > protocol for us to use.
> > > >
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > >
> > > It's good to see that you completed this. Unfortunately you did not add Ard
> > > Biesheuvel to Cc, he is the one who needs to review this code. Adding him
> > > to Cc now, with the full patch quoted below for him (no more comments
> > > from me there).
> > >
> >
> > Thanks Arnd,
> >
> > >
> > > > ---
> > > >  arch/loongarch/Kbuild                         |   3 +
> > > >  arch/loongarch/Kconfig                        |   8 +
> > > >  arch/loongarch/Makefile                       |  18 +-
> > > >  arch/loongarch/boot/Makefile                  |  23 +
> > > >  arch/loongarch/kernel/efi-header.S            | 100 +++++
> > > >  arch/loongarch/kernel/head.S                  |  44 +-
> > > >  arch/loongarch/kernel/image-vars.h            |  30 ++
> > > >  arch/loongarch/kernel/vmlinux.lds.S           |  23 +-
> > > >  drivers/firmware/efi/Kconfig                  |   4 +-
> > > >  drivers/firmware/efi/libstub/Makefile         |  14 +-
> > > >  drivers/firmware/efi/libstub/loongarch-stub.c | 425 ++++++++++++++++++
> > > >  include/linux/pe.h                            |   1 +
> > > >  12 files changed, 680 insertions(+), 13 deletions(-)
> > > >  create mode 100644 arch/loongarch/boot/Makefile
> > > >  create mode 100644 arch/loongarch/kernel/efi-header.S
> > > >  create mode 100644 arch/loongarch/kernel/image-vars.h
> > > >  create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.c
> > > >
...
> > > > diff --git a/arch/loongarch/kernel/efi-header.S b/arch/loongarch/kernel/efi-header.S
> > > > new file mode 100644
> > > > index 000000000000..ceb44524944a
> > > > --- /dev/null
> > > > +++ b/arch/loongarch/kernel/efi-header.S
> > > > @@ -0,0 +1,100 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > > > + */
> > > > +
> > > > +#include <linux/pe.h>
> > > > +#include <linux/sizes.h>
> > > > +
> > > > +       .macro  __EFI_PE_HEADER
> > > > +       .long   PE_MAGIC
> > > > +coff_header:
> >
> > Please use .L prefixed local symbol definitions in this file, so we
> > don't clutter up the core kernel's global symbol table.
> I found that ARM64 uses .L prefix while RISCV doesn't, so I suppose
> that both OK?
>

No, please change this.

> >
> > > > +       .short  IMAGE_FILE_MACHINE_LOONGARCH            /* Machine */
> > > > +       .short  section_count                           /* NumberOfSections */
> > > > +       .long   0                                       /* TimeDateStamp */
> > > > +       .long   0                                       /* PointerToSymbolTable */
> > > > +       .long   0                                       /* NumberOfSymbols */
> > > > +       .short  section_table - optional_header         /* SizeOfOptionalHeader */
> > > > +       .short  IMAGE_FILE_DEBUG_STRIPPED | \
> > > > +               IMAGE_FILE_EXECUTABLE_IMAGE | \
> > > > +               IMAGE_FILE_LINE_NUMS_STRIPPED           /* Characteristics */
> > > > +
> > > > +optional_header:
> > > > +       .short  PE_OPT_MAGIC_PE32PLUS                   /* PE32+ format */
> > > > +       .byte   0x02                                    /* MajorLinkerVersion */
> > > > +       .byte   0x14                                    /* MinorLinkerVersion */
> > > > +       .long   __inittext_end - efi_header_end         /* SizeOfCode */
> > > > +       .long   _end - __initdata_begin                 /* SizeOfInitializedData */
> > > > +       .long   0                                       /* SizeOfUninitializedData */
> > > > +       .long   __efistub_efi_pe_entry - _head          /* AddressOfEntryPoint */
> > > > +       .long   efi_header_end - _head                  /* BaseOfCode */
> > > > +
> > > > +extra_header_fields:
> > > > +       .quad   0                                       /* ImageBase */
> > > > +       .long   PECOFF_SEGMENT_ALIGN                    /* SectionAlignment */
> > > > +       .long   PECOFF_FILE_ALIGN                       /* FileAlignment */
> > > > +       .short  0                                       /* MajorOperatingSystemVersion */
> > > > +       .short  0                                       /* MinorOperatingSystemVersion */
> > > > +       .short  0                                       /* MajorImageVersion */
> > > > +       .short  0                                       /* MinorImageVersion */
> >
> > Once you enable EFI_GENERIC_STUB, set the above fields to
> > EFISTUB_MAJOR_IMAGE_VERSION/EFISTUB_MINOR_IMAGE_VERSION, so
> > bootloaders know they can use the LoadFile2 based initrd loader.
> OK, versions will be filled.
>
> >
> > > > +       .short  0                                       /* MajorSubsystemVersion */
> > > > +       .short  0                                       /* MinorSubsystemVersion */
> > > > +       .long   0                                       /* Win32VersionValue */
> > > > +
> > > > +       .long   _end - _head                            /* SizeOfImage */
> > > > +
> > > > +       /* Everything before the kernel image is considered part of the header */
> > > > +       .long   efi_header_end - _head                  /* SizeOfHeaders */
> > > > +       .long   0                                       /* CheckSum */
> > > > +       .short  IMAGE_SUBSYSTEM_EFI_APPLICATION         /* Subsystem */
> > > > +       .short  0                                       /* DllCharacteristics */
> > > > +       .quad   0                                       /* SizeOfStackReserve */
> > > > +       .quad   0                                       /* SizeOfStackCommit */
> > > > +       .quad   0                                       /* SizeOfHeapReserve */
> > > > +       .quad   0                                       /* SizeOfHeapCommit */
> > > > +       .long   0                                       /* LoaderFlags */
> > > > +       .long   (section_table - .) / 8                 /* NumberOfRvaAndSizes */
> > > > +
> > > > +       .quad   0                                       /* ExportTable */
> > > > +       .quad   0                                       /* ImportTable */
> > > > +       .quad   0                                       /* ResourceTable */
> > > > +       .quad   0                                       /* ExceptionTable */
> > > > +       .quad   0                                       /* CertificationTable */
> > > > +       .quad   0                                       /* BaseRelocationTable */
> > > > +
> > > > +       /* Section table */
> > > > +section_table:
> > > > +       .ascii  ".text\0\0\0"
> > > > +       .long   __inittext_end - efi_header_end         /* VirtualSize */
> > > > +       .long   efi_header_end - _head                  /* VirtualAddress */
> > > > +       .long   __inittext_end - efi_header_end         /* SizeOfRawData */
> > > > +       .long   efi_header_end - _head                  /* PointerToRawData */
> > > > +
> > > > +       .long   0                                       /* PointerToRelocations */
> > > > +       .long   0                                       /* PointerToLineNumbers */
> > > > +       .short  0                                       /* NumberOfRelocations */
> > > > +       .short  0                                       /* NumberOfLineNumbers */
> > > > +       .long   IMAGE_SCN_CNT_CODE | \
> > > > +               IMAGE_SCN_MEM_READ | \
> > > > +               IMAGE_SCN_MEM_EXECUTE                   /* Characteristics */
> > > > +
> > > > +       .ascii  ".data\0\0\0"
> > > > +       .long   _end - __initdata_begin                 /* VirtualSize */
> > > > +       .long   __initdata_begin - _head                /* VirtualAddress */
> > > > +       .long   _edata - __initdata_begin               /* SizeOfRawData */
> > > > +       .long   __initdata_begin - _head                /* PointerToRawData */
> > > > +
> > > > +       .long   0                                       /* PointerToRelocations */
> > > > +       .long   0                                       /* PointerToLineNumbers */
> > > > +       .short  0                                       /* NumberOfRelocations */
> > > > +       .short  0                                       /* NumberOfLineNumbers */
> > > > +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA | \
> > > > +               IMAGE_SCN_MEM_READ | \
> > > > +               IMAGE_SCN_MEM_WRITE                     /* Characteristics */
> > > > +
> > > > +       .org 0x20e
> > > > +       .word kernel_version - 512 -  _head
> > > > +
> > > > +       .set    section_count, (. - section_table) / 40
> > > > +efi_header_end:
> > > > +       .endm
> > > > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > > > index b4a0b28da3e7..361b72e8bfc5 100644
> > > > --- a/arch/loongarch/kernel/head.S
> > > > +++ b/arch/loongarch/kernel/head.S
> > > > @@ -11,11 +11,53 @@
> > > >  #include <asm/regdef.h>
> > > >  #include <asm/loongarch.h>
> > > >  #include <asm/stackframe.h>
> > > > +#include <generated/compile.h>
> > > > +#include <generated/utsrelease.h>
> > > >
> > > > -SYM_ENTRY(_stext, SYM_L_GLOBAL, SYM_A_NONE)
> > > > +#ifdef CONFIG_EFI_STUB
> > > > +
> > > > +#include "efi-header.S"
> > > > +
> > > > +       __HEAD
> > > > +
> > > > +_head:
> > > > +       /* "MZ", MS-DOS header */
> > > > +       .word   MZ_MAGIC
> > > > +       .org    0x28
> > > > +       .ascii  "Loongson\0"
> >
> > Is this part of a special boot protocol? It would be better not to
> > overload EFI and PE/COFF with your own hacks if we can avoid it.
> This is used as a magic string and Grub will check it.
>

Why? I don't think it is a good idea to have hacks like this, because
it means that
a) the kernel is no longer a standard PE/COFF image, and so you need a
special loader to load it;
b) the loader has to parse the file manually before loading it, which
is problematic when using EFI device paths that, e.g., evaluate to a
HTTP boot target or something like that.



> >
> > > > +       .org    0x3c
> > > > +       /* Offset to the PE header */
> > > > +       .long   pe_header - _head
> > > > +
> > > > +pe_header:
> > > > +       __EFI_PE_HEADER
> > > > +
> > > > +kernel_asize:
> > > > +       .long _end - _text
> > > > +
> > > > +kernel_fsize:
> > > > +       .long _edata - _text
> > > > +
> > > > +kernel_vaddr:
> > > > +       .quad VMLINUX_LOAD_ADDRESS
> > > > +
> > > > +kernel_offset:
> > > > +       .long kernel_offset - _text
> > > > +
> > > > +kernel_version:
> > > > +       .ascii  UTS_RELEASE " (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") " UTS_VERSION "\0"
> > > > +
> > > > +SYM_L_GLOBAL(kernel_asize)
> > > > +SYM_L_GLOBAL(kernel_fsize)
> > > > +SYM_L_GLOBAL(kernel_vaddr)
> > > > +SYM_L_GLOBAL(kernel_offset)
> >
> > I think you can simplify this to
> >
> > SYM_DATA(kernel_asize, .long _end - _text);
> >
> > etc etc (which implies the .globl annotation)
> OK, thanks.
>
> >
> >
> > > > +
> > > > +#endif
> > > >
> > > >         __REF
> > > >
> > > > +SYM_ENTRY(_stext, SYM_L_GLOBAL, SYM_A_NONE)
> > > > +
> > > >  SYM_CODE_START(kernel_entry)                   # kernel entry point
> > > >
> > > >         /* Config direct window and set PG */
> > > > diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
> > > > new file mode 100644
> > > > index 000000000000..0162402b6212
> > > > --- /dev/null
> > > > +++ b/arch/loongarch/kernel/image-vars.h
> > > > @@ -0,0 +1,30 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +/*
> > > > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > > > + */
> > > > +#ifndef __LOONGARCH_KERNEL_IMAGE_VARS_H
> > > > +#define __LOONGARCH_KERNEL_IMAGE_VARS_H
> > > > +
> > > > +#ifdef CONFIG_EFI_STUB
> > > > +
> > > > +__efistub_memcmp               = memcmp;
> > > > +__efistub_memcpy               = memcpy;
> > > > +__efistub_memmove              = memmove;
> > > > +__efistub_memset               = memset;
> > > > +__efistub_strcat               = strcat;
> > > > +__efistub_strcmp               = strcmp;
> > > > +__efistub_strlen               = strlen;
> > > > +__efistub_strncat              = strncat;
> > > > +__efistub_strnstr              = strnstr;
> > > > +__efistub_strnlen              = strnlen;
> > > > +__efistub_strpbrk              = strpbrk;
> > > > +__efistub_strsep               = strsep;
> > > > +__efistub_kernel_entry         = kernel_entry;
> > > > +__efistub_kernel_asize         = kernel_asize;
> > > > +__efistub_kernel_fsize         = kernel_fsize;
> > > > +__efistub_kernel_vaddr         = kernel_vaddr;
> > > > +__efistub_kernel_offset                = kernel_offset;
> > > > +
> > > > +#endif
> > > > +
> > > > +#endif /* __LOONGARCH_KERNEL_IMAGE_VARS_H */
> > > > diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> > > > index 02abfaaa4892..7da4c4d7c50d 100644
> > > > --- a/arch/loongarch/kernel/vmlinux.lds.S
> > > > +++ b/arch/loongarch/kernel/vmlinux.lds.S
> > > > @@ -12,6 +12,14 @@
> > > >  #define BSS_FIRST_SECTIONS *(.bss..swapper_pg_dir)
> > > >
> > > >  #include <asm-generic/vmlinux.lds.h>
> > > > +#include "image-vars.h"
> > > > +
> > > > +/*
> > > > + * Max avaliable Page Size is 64K, so we set SectionAlignment
> > > > + * field of EFI application to 64K.
> > > > + */
> > > > +PECOFF_FILE_ALIGN = 0x200;
> > > > +PECOFF_SEGMENT_ALIGN = 0x10000;
> > > >
> > > >  OUTPUT_ARCH(loongarch)
> > > >  ENTRY(kernel_entry)
> > > > @@ -27,6 +35,9 @@ SECTIONS
> > > >         . = VMLINUX_LOAD_ADDRESS;
> > > >
> > > >         _text = .;
> > > > +       HEAD_TEXT_SECTION
> > > > +
> > > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > > >         .text : {
> > > >                 TEXT_TEXT
> > > >                 SCHED_TEXT
> > > > @@ -38,11 +49,12 @@ SECTIONS
> > > >                 *(.fixup)
> > > >                 *(.gnu.warning)
> > > >         } :text = 0
> > > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > > >         _etext = .;
> > > >
> > > >         EXCEPTION_TABLE(16)
> > > >
> > > > -       . = ALIGN(PAGE_SIZE);
> > > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > > >         __init_begin = .;
> > > >         __inittext_begin = .;
> > > >
> > > > @@ -51,6 +63,7 @@ SECTIONS
> > > >                 EXIT_TEXT
> > > >         }
> > > >
> > > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > > >         __inittext_end = .;
> > > >
> > > >         __initdata_begin = .;
> > > > @@ -60,6 +73,10 @@ SECTIONS
> > > >                 EXIT_DATA
> > > >         }
> > > >
> > > > +       .init.bss : {
> > > > +               *(.init.bss)
> > > > +       }
> > > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > > >         __initdata_end = .;
> > > >
> > > >         __init_end = .;
> > > > @@ -71,11 +88,11 @@ SECTIONS
> > > >         .sdata : {
> > > >                 *(.sdata)
> > > >         }
> > > > -
> > > > -       . = ALIGN(SZ_64K);
> > > > +       .edata_padding : { BYTE(0); . = ALIGN(PECOFF_FILE_ALIGN); }
> > > >         _edata =  .;
> > > >
> > > >         BSS_SECTION(0, SZ_64K, 8)
> > > > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > > >
> > > >         _end = .;
> > > >
> > > > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > > > index 2c3dac5ecb36..ecb4e0b1295a 100644
> > > > --- a/drivers/firmware/efi/Kconfig
> > > > +++ b/drivers/firmware/efi/Kconfig
> > > > @@ -121,9 +121,9 @@ config EFI_ARMSTUB_DTB_LOADER
> > > >
> > > >  config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
> > > >         bool "Enable the command line initrd loader" if !X86
> > > > -       depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
> > > > -       default y if X86
> > > >         depends on !RISCV
> > > > +       depends on EFI_STUB && (EFI_GENERIC_STUB || X86 || LOONGARCH)
> > > > +       default y if (X86 || LOONGARCH)
> >
> > Don't enable the command line initrd loader please. It is deprecated,
> > and has been replaced with the LoadFile2 protocol based one, which is
> > more flexible.
> >
> > Uboot already implements it, as well as EDK2. GRUB does not implement
> > this yet afair, but it should not be that hard to add.
> If we don't select this, is it possible to load initrd in the UEFI shell?
>

Yes, if you build the shell to include the 'initrd' command.

Please refer to the following EDK2 module:
OvmfPkg/LinuxInitrdDynamicShellCommand/LinuxInitrdDynamicShellCommand.inf

The initrd= command line parameter only permits initrd images that are
in the same file system as the one the kernel was loaded from, which
is overly restrictive, and doesn't work at all if the Image was not
loaded from a file system to begin with.

> >
> > > >         help
> > > >           Select this config option to add support for the initrd= command
> > > >           line parameter, allowing an initrd that resides on the same volume
> > > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > > index d0537573501e..663e9d317299 100644
> > > > --- a/drivers/firmware/efi/libstub/Makefile
> > > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > > @@ -26,6 +26,8 @@ cflags-$(CONFIG_ARM)          := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > >                                    $(call cc-option,-mno-single-pic-base)
> > > >  cflags-$(CONFIG_RISCV)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > >                                    -fpic
> > > > +cflags-$(CONFIG_LOONGARCH)     := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > > +                                  -fpic
> > > >
> > > >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > > >
> > > > @@ -55,7 +57,7 @@ KCOV_INSTRUMENT                       := n
> > > >  lib-y                          := efi-stub-helper.o gop.o secureboot.o tpm.o \
> > > >                                    file.o mem.o random.o randomalloc.o pci.o \
> > > >                                    skip_spaces.o lib-cmdline.o lib-ctype.o \
> > > > -                                  alignedmem.o relocate.o vsprintf.o
> > > > +                                  alignedmem.o relocate.o string.o vsprintf.o
> > > >
> > > >  # include the stub's generic dependencies from lib/ when building for ARM/arm64
> > > >  efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> > > > @@ -63,13 +65,15 @@ efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
> > > >  $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
> > > >         $(call if_changed_rule,cc_o_c)
> > > >
> > > > -lib-$(CONFIG_EFI_GENERIC_STUB) += efi-stub.o fdt.o string.o \
> > > > +lib-$(CONFIG_EFI_GENERIC_STUB) += efi-stub.o fdt.o \
> > > >                                    $(patsubst %.c,lib-%.o,$(efi-deps-y))
> > > >
> > > >  lib-$(CONFIG_ARM)              += arm32-stub.o
> > > >  lib-$(CONFIG_ARM64)            += arm64-stub.o
> > > >  lib-$(CONFIG_X86)              += x86-stub.o
> > > >  lib-$(CONFIG_RISCV)            += riscv-stub.o
> > > > +lib-$(CONFIG_LOONGARCH)                += loongarch-stub.o
> > > > +
> > > >  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > > >
> > > >  # Even when -mbranch-protection=none is set, Clang will generate a
> > > > @@ -125,6 +129,12 @@ STUBCOPY_FLAGS-$(CONFIG_RISCV)     += --prefix-alloc-sections=.init \
> > > >                                    --prefix-symbols=__efistub_
> > > >  STUBCOPY_RELOC-$(CONFIG_RISCV) := R_RISCV_HI20
> > > >
> > > > +# For LoongArch, keep all the symbols in .init section and make sure that no
> > > > +# absolute symbols references doesn't exist.
> > > > +STUBCOPY_FLAGS-$(CONFIG_LOONGARCH)     += --prefix-alloc-sections=.init \
> > > > +                                          --prefix-symbols=__efistub_
> > > > +STUBCOPY_RELOC-$(CONFIG_LOONGARCH)     := R_LARCH_MARK_LA
> > > > +
> > > >  $(obj)/%.stub.o: $(obj)/%.o FORCE
> > > >         $(call if_changed,stubcopy)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > > new file mode 100644
> > > > index 000000000000..399641a0b0cb
> > > > --- /dev/null
> > > > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > > > @@ -0,0 +1,425 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Author: Yun Liu <liuyun@loongson.cn>
> > > > + *         Huacai Chen <chenhuacai@loongson.cn>
> > > > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > > > + */
> > > > +
> > > > +#include <linux/efi.h>
> > > > +#include <linux/sort.h>
> > > > +#include <asm/efi.h>
> > > > +#include <asm/addrspace.h>
> > > > +#include <asm/boot_param.h>
> > > > +#include "efistub.h"
> > > > +
> > > > +#define MAX_ARG_COUNT          128
> > > > +#define CMDLINE_MAX_SIZE       0x200
> > > > +
> > > > +static int argc;
> > > > +static char **argv;
> > > > +const efi_system_table_t *efi_system_table;
> > > > +static efi_guid_t screen_info_guid = LINUX_EFI_LARCH_SCREEN_INFO_TABLE_GUID;
> > > > +static unsigned int map_entry[LOONGSON3_BOOT_MEM_MAP_MAX];
> > > > +static struct efi_mmap mmap_array[EFI_MAX_MEMORY_TYPE][LOONGSON3_BOOT_MEM_MAP_MAX];
> > > > +
> > > > +struct exit_boot_struct {
> > > > +       struct boot_params *bp;
> > > > +       unsigned int *runtime_entry_count;
> > > > +};
> > > > +
> > > > +typedef void (*kernel_entry_t)(int argc, char *argv[], struct boot_params *boot_p);
> > > > +
> > > > +extern int kernel_asize;
> > > > +extern int kernel_fsize;
> > > > +extern int kernel_offset;
> > > > +extern unsigned long kernel_vaddr;
> > > > +extern kernel_entry_t kernel_entry;
> > > > +
> > > > +unsigned char efi_crc8(char *buff, int size)
> > > > +{
> > > > +       int sum, cnt;
> > > > +
> > > > +       for (sum = 0, cnt = 0; cnt < size; cnt++)
> > > > +               sum = (char) (sum + *(buff + cnt));
> > > > +
> > > > +       return (char)(0x100 - sum);
> > > > +}
> > > > +
> > > > +struct screen_info *alloc_screen_info(void)
> > > > +{
> > > > +       efi_status_t status;
> > > > +       struct screen_info *si;
> > > > +
> > > > +       status = efi_bs_call(allocate_pool,
> > > > +                       EFI_RUNTIME_SERVICES_DATA, sizeof(*si), (void **)&si);
> > > > +       if (status != EFI_SUCCESS)
> > > > +               return NULL;
> > > > +
> > > > +       status = efi_bs_call(install_configuration_table, &screen_info_guid, si);
> > > > +       if (status == EFI_SUCCESS)
> > > > +               return si;
> > > > +
> > > > +       efi_bs_call(free_pool, si);
> > > > +
> > > > +       return NULL;
> > > > +}
> > > > +
> > > > +static void setup_graphics(void)
> > > > +{
> > > > +       unsigned long size;
> > > > +       efi_status_t status;
> > > > +       efi_guid_t gop_proto = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
> > > > +       void **gop_handle = NULL;
> > > > +       struct screen_info *si = NULL;
> > > > +
> > > > +       size = 0;
> > > > +       status = efi_bs_call(locate_handle, EFI_LOCATE_BY_PROTOCOL,
> > > > +                               &gop_proto, NULL, &size, gop_handle);
> > > > +       if (status == EFI_BUFFER_TOO_SMALL) {
> > > > +               si = alloc_screen_info();
> > > > +               efi_setup_gop(si, &gop_proto, size);
> > > > +       }
> > > > +}
> > > > +
> > > > +struct boot_params *bootparams_init(efi_system_table_t *sys_table)
> > > > +{
> > > > +       efi_status_t status;
> > > > +       struct boot_params *p;
> > > > +       unsigned char sig[8] = {'B', 'P', 'I', '0', '1', '0', '0', '2'};
> > > > +
> > > > +       status = efi_bs_call(allocate_pool, EFI_RUNTIME_SERVICES_DATA, SZ_64K, (void **)&p);
> > > > +       if (status != EFI_SUCCESS)
> > > > +               return NULL;
> > > > +
> > > > +       memset(p, 0, SZ_64K);
> > > > +       memcpy(&p->signature, sig, sizeof(long));
> > > > +
> > > > +       return p;
> > > > +}
> > > > +
> > > > +static unsigned long convert_priv_cmdline(char *cmdline_ptr,
> > > > +               unsigned long rd_addr, unsigned long rd_size)
> > > > +{
> > > > +       unsigned int rdprev_size;
> > > > +       unsigned int cmdline_size;
> > > > +       efi_status_t status;
> > > > +       char *pstr, *substr;
> > > > +       char *initrd_ptr = NULL;
> > > > +       char convert_str[CMDLINE_MAX_SIZE];
> > > > +       static char cmdline_array[CMDLINE_MAX_SIZE];
> > > > +
> > > > +       cmdline_size = strlen(cmdline_ptr);
> > > > +       snprintf(cmdline_array, CMDLINE_MAX_SIZE, "kernel ");
> > > > +
> > > > +       initrd_ptr = strstr(cmdline_ptr, "initrd=");
> > > > +       if (!initrd_ptr) {
> > > > +               snprintf(cmdline_array, CMDLINE_MAX_SIZE, "kernel %s", cmdline_ptr);
> > > > +               goto completed;
> > > > +       }
> > > > +       snprintf(convert_str, CMDLINE_MAX_SIZE, " initrd=0x%lx,0x%lx", rd_addr, rd_size);
> > > > +       rdprev_size = cmdline_size - strlen(initrd_ptr);
> > > > +       strncat(cmdline_array, cmdline_ptr, rdprev_size);
> > > > +
> > > > +       cmdline_ptr = strnstr(initrd_ptr, " ", CMDLINE_MAX_SIZE);
> > > > +       strcat(cmdline_array, convert_str);
> > > > +       if (!cmdline_ptr)
> > > > +               goto completed;
> > > > +
> > > > +       strcat(cmdline_array, cmdline_ptr);
> > > > +
> > > > +completed:
> > > > +       status = efi_allocate_pages((MAX_ARG_COUNT + 1) * (sizeof(char *)),
> > > > +                                       (unsigned long *)&argv, ULONG_MAX);
> > > > +       if (status != EFI_SUCCESS) {
> > > > +               efi_err("Alloc argv mmap_array error\n");
> > > > +               return status;
> > > > +       }
> > > > +
> > > > +       argc = 0;
> > > > +       pstr = cmdline_array;
> > > > +
> > > > +       substr = strsep(&pstr, " \t");
> > > > +       while (substr != NULL) {
> > > > +               if (strlen(substr)) {
> > > > +                       argv[argc++] = substr;
> > > > +                       if (argc == MAX_ARG_COUNT) {
> > > > +                               efi_err("Argv mmap_array full!\n");
> > > > +                               break;
> > > > +                       }
> > > > +               }
> > > > +               substr = strsep(&pstr, " \t");
> > > > +       }
> > > > +
> > > > +       return EFI_SUCCESS;
> > > > +}
> > > > +
> > > > +unsigned int efi_memmap_sort(struct loongsonlist_mem_map *memmap,
> > > > +                       unsigned int index, unsigned int mem_type)
> > > > +{
> > > > +       unsigned int i, t;
> > > > +       unsigned long msize;
> > > > +
> > > > +       for (i = 0; i < map_entry[mem_type]; i = t) {
> > > > +               msize = mmap_array[mem_type][i].mem_size;
> > > > +               for (t = i + 1; t < map_entry[mem_type]; t++) {
> > > > +                       if (mmap_array[mem_type][i].mem_start + msize <
> > > > +                                       mmap_array[mem_type][t].mem_start)
> > > > +                               break;
> > > > +
> > > > +                       msize += mmap_array[mem_type][t].mem_size;
> > > > +               }
> > > > +               memmap->map[index].mem_type = mem_type;
> > > > +               memmap->map[index].mem_start = mmap_array[mem_type][i].mem_start;
> > > > +               memmap->map[index].mem_size = msize;
> > > > +               memmap->map[index].attribute = mmap_array[mem_type][i].attribute;
> > > > +               index++;
> > > > +       }
> > > > +
> > > > +       return index;
> > > > +}
> > > > +
> > > > +static efi_status_t mk_mmap(struct efi_boot_memmap *map, struct boot_params *p)
> > > > +{
> >
> > Are you passing a different representation of the memory map to the
> > core kernel? I think it would be easier just to pass the EFI memory
> > map like other EFI arches do, and reuse all of the code that we
> > already have.
> Yes, this different representation is used by our "boot_params", the
> interface between bootloader (including efistub) and the core kernel.

So how does the core kernel consume the EFI memory map? Only through
this mechanism?

> >
> > > > +       char checksum;
> > > > +       unsigned int i;
> > > > +       unsigned int nr_desc;
> > > > +       unsigned int mem_type;
> > > > +       unsigned long count;
> > > > +       efi_memory_desc_t *mem_desc;
> > > > +       struct loongsonlist_mem_map *mhp = NULL;
> > > > +
> > > > +       memset(map_entry, 0, sizeof(map_entry));
> > > > +       memset(mmap_array, 0, sizeof(mmap_array));
> > > > +
> > > > +       if (!strncmp((char *)p, "BPI", 3)) {
> > > > +               p->flags |= BPI_FLAGS_UEFI_SUPPORTED;
> > > > +               p->systemtable = (efi_system_table_t *)efi_system_table;
> > > > +               p->extlist_offset = sizeof(*p) + sizeof(unsigned long);
> > > > +               mhp = (struct loongsonlist_mem_map *)((char *)p + p->extlist_offset);
> > > > +
> > > > +               memcpy(&mhp->header.signature, "MEM", sizeof(unsigned long));
> > > > +               mhp->header.length = sizeof(*mhp);
> > > > +               mhp->desc_version = *map->desc_ver;
> > > > +               mhp->map_count = 0;
> > > > +       }
> > > > +       if (!(*(map->map_size)) || !(*(map->desc_size)) || !mhp) {
> > > > +               efi_err("get memory info error\n");
> > > > +               return EFI_INVALID_PARAMETER;
> > > > +       }
> > > > +       nr_desc = *(map->map_size) / *(map->desc_size);
> > > > +
> > > > +       /*
> > > > +        * According to UEFI SPEC, mmap_buf is the accurate Memory Map
> > > > +        * mmap_array now we can fill platform specific memory structure.
> > > > +        */
> > > > +       for (i = 0; i < nr_desc; i++) {
> > > > +               mem_desc = (efi_memory_desc_t *)((void *)(*map->map) + (i * (*(map->desc_size))));
> > > > +               switch (mem_desc->type) {
> > > > +               case EFI_RESERVED_TYPE:
> > > > +               case EFI_RUNTIME_SERVICES_CODE:
> > > > +               case EFI_RUNTIME_SERVICES_DATA:
> > > > +               case EFI_MEMORY_MAPPED_IO:
> > > > +               case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
> > > > +               case EFI_UNUSABLE_MEMORY:
> > > > +               case EFI_PAL_CODE:
> > > > +                       mem_type = ADDRESS_TYPE_RESERVED;
> > > > +                       break;
> > > > +
> > > > +               case EFI_ACPI_MEMORY_NVS:
> > > > +                       mem_type = ADDRESS_TYPE_NVS;
> > > > +                       break;
> > > > +
> > > > +               case EFI_ACPI_RECLAIM_MEMORY:
> > > > +                       mem_type = ADDRESS_TYPE_ACPI;
> > > > +                       break;
> > > > +
> > > > +               case EFI_LOADER_CODE:
> > > > +               case EFI_LOADER_DATA:
> > > > +               case EFI_PERSISTENT_MEMORY:
> > > > +               case EFI_BOOT_SERVICES_CODE:
> > > > +               case EFI_BOOT_SERVICES_DATA:
> > > > +               case EFI_CONVENTIONAL_MEMORY:
> > > > +                       mem_type = ADDRESS_TYPE_SYSRAM;
> > > > +                       break;
> > > > +
> > > > +               default:
> > > > +                       continue;
> > > > +               }
> > > > +
> > > > +               mmap_array[mem_type][map_entry[mem_type]].mem_type = mem_type;
> > > > +               mmap_array[mem_type][map_entry[mem_type]].mem_start =
> > > > +                                               mem_desc->phys_addr & TO_PHYS_MASK;
> > > > +               mmap_array[mem_type][map_entry[mem_type]].mem_size =
> > > > +                                               mem_desc->num_pages << EFI_PAGE_SHIFT;
> > > > +               mmap_array[mem_type][map_entry[mem_type]].attribute =
> > > > +                                               mem_desc->attribute;
> > > > +               map_entry[mem_type]++;
> > > > +       }
> > > > +
> > > > +       count = mhp->map_count;
> > > > +       /* Sort EFI memmap and add to BPI for kernel */
> > > > +       for (i = 0; i < LOONGSON3_BOOT_MEM_MAP_MAX; i++) {
> > > > +               if (!map_entry[i])
> > > > +                       continue;
> > > > +               count = efi_memmap_sort(mhp, count, i);
> > > > +       }
> > > > +
> > > > +       mhp->map_count = count;
> > > > +       mhp->header.checksum = 0;
> > > > +
> > > > +       checksum = efi_crc8((char *)mhp, mhp->header.length);
> > > > +       mhp->header.checksum = checksum;
> > > > +
> > > > +       return EFI_SUCCESS;
> > > > +}
> > > > +
> > > > +static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
> > > > +{
> > > > +       efi_status_t status;
> > > > +       struct exit_boot_struct *p = priv;
> > > > +
> > > > +       status = mk_mmap(map, p->bp);
> > > > +       if (status != EFI_SUCCESS) {
> > > > +               efi_err("Make kernel memory map failed!\n");
> > > > +               return status;
> > > > +       }
> > > > +
> > > > +       return EFI_SUCCESS;
> > > > +}
> > > > +
> > > > +static efi_status_t exit_boot_services(struct boot_params *boot_params, void *handle)
> > > > +{
> > > > +       unsigned int desc_version;
> > > > +       unsigned int runtime_entry_count = 0;
> > > > +       unsigned long map_size, key, desc_size, buff_size;
> > > > +       efi_status_t status;
> > > > +       efi_memory_desc_t *mem_map;
> > > > +       struct efi_boot_memmap map;
> > > > +       struct exit_boot_struct priv;
> > > > +
> > > > +       map.map                 = &mem_map;
> > > > +       map.map_size            = &map_size;
> > > > +       map.desc_size           = &desc_size;
> > > > +       map.desc_ver            = &desc_version;
> > > > +       map.key_ptr             = &key;
> > > > +       map.buff_size           = &buff_size;
> > > > +       status = efi_get_memory_map(&map);
> > > > +       if (status != EFI_SUCCESS) {
> > > > +               efi_err("Unable to retrieve UEFI memory map.\n");
> > > > +               return status;
> > > > +       }
> > > > +
> > > > +       priv.bp = boot_params;
> > > > +       priv.runtime_entry_count = &runtime_entry_count;
> > > > +
> > > > +       /* Might as well exit boot services now */
> > > > +       status = efi_exit_boot_services(handle, &map, &priv, exit_boot_func);
> > > > +       if (status != EFI_SUCCESS)
> > > > +               return status;
> > > > +
> > > > +       return EFI_SUCCESS;
> > > > +}
> > > > +
> > > > +/*
> > > > + * EFI entry point for the LoongArch EFI stub.
> > > > + */
> > > > +efi_status_t __efiapi efi_pe_entry(efi_handle_t handle, efi_system_table_t *sys_table)
> >
> > Why are you not using the generic EFI stub boot flow?
> Hmmm, as I know, we define our own "boot_params", a interface between
> bootloader (including efistub) and the core kernel to pass memmap,
> cmdline and initrd information, three years ago. This method looks
> like the X86 way, while different from the generic stub (which is
> called arm stub before 5.8). In these years, many products have
> already use the "boot_params" interface (including UEFI, PMON, Grub,
> Kernel, etc., but most of them haven't be upstream). Replace
> boot_params with FDT (i.e., the generic stub way) is difficult for us,
> because it means a big broken of compatibility.
>

OK, I understand. So using the generic stub is not possible for you.

So as long as you don't enable deprecated features such as initrd=, or
rely on special hacks like putting magic numbers at fixed offsets in
the image, I'm fine with this approach.
