Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B23599691
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 10:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347411AbiHSIGN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 04:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347356AbiHSIGL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 04:06:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6497DEA79;
        Fri, 19 Aug 2022 01:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E4B2616E2;
        Fri, 19 Aug 2022 08:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0123C433D7;
        Fri, 19 Aug 2022 08:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660896368;
        bh=rXXWhhBn+0xtVzWuTrtJZZ6BjBgEXNj9xItqOiIWAVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P68mqwHUEWtjVV2hDDOg0haw9LEl7MLH+FJJTteH960Si2WsFhZtQnWAyv7N2E8sa
         j6/6ozHxxtdDHBsLAWaSr9mHdGoqDvFx+oFoD6gFhwqTtUdRt6vyz67bzQdi/HWlFO
         3SacYpt38md+e1XZlta6nc8rY581lueLG8ImVfeuUtbZucfBvMaCXM/X2Nb+i7qaG4
         u94Zsyo6r/fWf3d2AnmbO4n6ngpGt22jI7HxidlHke+Cbt+DB6PLAHjUmp5F2rWhBn
         UXrHx/NyBwUex6Q8RknR8IyGheA5fcRQuxWm2BUPOXS9YSocF5DmTFdkjY2Srxux2s
         anQ/j/Qe43ACA==
Received: by mail-vk1-f176.google.com with SMTP id j11so1887230vkk.11;
        Fri, 19 Aug 2022 01:06:08 -0700 (PDT)
X-Gm-Message-State: ACgBeo0fVdgW+a/m5F4Xw+5+Zr+T118pQTOojZ6Wqr+mq1omKrzNhI48
        NxHX6CSfLw8SKfCzY5DvuA8E+5vRJwlnhFGWMYI=
X-Google-Smtp-Source: AA6agR7/t27dZB5YRjGxFiCG4kqQTgVI9Ca4suahxZo7lzGwdv9YKe41qUz6ji7ZPOk1pEwtzrVJZt7C+0Egmt2zmrQ=
X-Received: by 2002:a1f:b248:0:b0:377:aa0c:941 with SMTP id
 b69-20020a1fb248000000b00377aa0c0941mr2732757vkf.37.1660896367398; Fri, 19
 Aug 2022 01:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220818030707.2836607-1-chenhuacai@loongson.cn> <04243a9f-5ade-955b-1a9b-41e94593a35b@loongson.cn>
In-Reply-To: <04243a9f-5ade-955b-1a9b-41e94593a35b@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 19 Aug 2022 16:05:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H58hemwRchHbjO-Q9av9k_rj6k7gewdHKJzusZkeYiU-g@mail.gmail.com>
Message-ID: <CAAhV-H58hemwRchHbjO-Q9av9k_rj6k7gewdHKJzusZkeYiU-g@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Add efistub booting support
To:     maobibo <maobibo@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Bibo,

On Thu, Aug 18, 2022 at 9:12 PM maobibo <maobibo@loongson.cn> wrote:
>
> Huacai,
>
> This patch is much better than before.
> It works well on qemu virt machine platform, and I reply inline.
>
> =E5=9C=A8 2022/8/18 11:07, Huacai Chen =E5=86=99=E9=81=93:
> > This patch adds efistub booting support, which is the standard UEFI boo=
t
> > protocol for us to use.
> >
> > We use generic efistub, which means we can pass boot information (i.e.,
> > system table, memory map, kernel command line, initrd) via a light FDT
> > and drop a lot of non-standard code.
> >
> > We use a flat mapping to map the efi runtime in the kernel's address
> > space. In efi, VA =3D PA; in kernel, VA =3D PA + PAGE_OFFSET. As a resu=
lt,
> > flat mapping is not identity mapping, SetVirtualAddressMap() is still
> > needed for the efi runtime.
> >
> > Tested-by: Xi Ruoyao <xry111@xry111.site>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > V1 --> V2:
> > 1, Call SetVirtualAddressMap() in stub;
> > 2, Use core kernel data directly in alloc_screen_info();
> > 3, Remove the magic number in MS-DOS header;
> > 4, Disable EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER;
> > 5, Some other small changes suggested by Ard Biesheuvel.
> >
> >  arch/loongarch/Kconfig                        |  9 ++
> >  arch/loongarch/Makefile                       |  7 +-
> >  arch/loongarch/boot/Makefile                  |  8 +-
> >  arch/loongarch/include/asm/efi.h              | 10 +-
> >  arch/loongarch/kernel/efi-header.S            | 99 +++++++++++++++++++
> >  arch/loongarch/kernel/efi.c                   |  3 +
> >  arch/loongarch/kernel/head.S                  | 20 ++++
> >  arch/loongarch/kernel/image-vars.h            | 30 ++++++
> >  arch/loongarch/kernel/setup.c                 | 12 +--
> >  arch/loongarch/kernel/vmlinux.lds.S           |  1 +
> >  drivers/firmware/efi/Kconfig                  |  4 +-
> >  drivers/firmware/efi/libstub/Makefile         | 10 ++
> >  drivers/firmware/efi/libstub/efi-stub.c       | 31 ++++--
> >  drivers/firmware/efi/libstub/loongarch-stub.c | 60 +++++++++++
> >  include/linux/pe.h                            |  2 +
> >  15 files changed, 282 insertions(+), 24 deletions(-)
> >  create mode 100644 arch/loongarch/kernel/efi-header.S
> >  create mode 100644 arch/loongarch/kernel/image-vars.h
> >  create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.c
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 9478f9646fa5..4cb412a82afa 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -324,6 +324,15 @@ config EFI
> >         This enables the kernel to use EFI runtime services that are
> >         available (such as the EFI variable services).
> >
> > +config EFI_STUB
> > +     bool "EFI boot stub support"
> > +     default y
> > +     depends on EFI
> > +     select EFI_GENERIC_STUB
> > +     help
> > +       This kernel feature allows the kernel to be loaded directly by
> > +       EFI firmware without the use of a bootloader.
> > +
> >  config SMP
> >       bool "Multi-Processing support"
> >       help
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index ec3de6191276..2bd0a574ed73 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -7,7 +7,11 @@ boot :=3D arch/loongarch/boot
> >
> >  KBUILD_DEFCONFIG :=3D loongson3_defconfig
> >
> > -KBUILD_IMAGE =3D $(boot)/vmlinux
> > +ifndef CONFIG_EFI_STUB
> > +KBUILD_IMAGE =3D $(boot)/vmlinux.elf
> > +else
> > +KBUILD_IMAGE =3D $(boot)/vmlinux.efi
> > +endif
> >
> >  #
> >  # Select the object file format to substitute into the linker script.
> > @@ -75,6 +79,7 @@ endif
> >  head-y :=3D arch/loongarch/kernel/head.o
> >
> >  libs-y +=3D arch/loongarch/lib/
> > +libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/l=
ib.a
> >
> >  ifeq ($(KBUILD_EXTMOD),)
> >  prepare: vdso_prepare
> > diff --git a/arch/loongarch/boot/Makefile b/arch/loongarch/boot/Makefil=
e
> > index 0125b17edc98..fecf34f50e56 100644
> > --- a/arch/loongarch/boot/Makefile
> > +++ b/arch/loongarch/boot/Makefile
> > @@ -8,9 +8,13 @@ drop-sections :=3D .comment .note .options .note.gnu.b=
uild-id
> >  strip-flags   :=3D $(addprefix --remove-section=3D,$(drop-sections)) -=
S
> >  OBJCOPYFLAGS_vmlinux.efi :=3D -O binary $(strip-flags)
> >
> > -targets :=3D vmlinux
> >  quiet_cmd_strip =3D STRIP        $@
> >        cmd_strip =3D $(STRIP) -s -o $@ $<
> >
> > -$(obj)/vmlinux: vmlinux FORCE
> > +targets :=3D vmlinux.elf
> > +$(obj)/vmlinux.elf: vmlinux FORCE
> >       $(call if_changed,strip)
> > +
> > +targets +=3D vmlinux.efi
> > +$(obj)/vmlinux.efi: vmlinux FORCE
> > +     $(call if_changed,objcopy)
> > diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/=
asm/efi.h
> > index 9d44c6948be1..c7507a240f30 100644
> > --- a/arch/loongarch/include/asm/efi.h
> > +++ b/arch/loongarch/include/asm/efi.h
> > @@ -18,8 +18,14 @@ void efifb_setup_from_dmi(struct screen_info *si, co=
nst char *opt);
> >
> >  #define EFI_ALLOC_ALIGN              SZ_64K
> >
> > -struct screen_info *alloc_screen_info(void);
> > -void free_screen_info(struct screen_info *si);
> > +static inline struct screen_info *alloc_screen_info(void)
> > +{
> > +     return &screen_info;
> > +}
> > +
> > +static inline void free_screen_info(struct screen_info *si)
> > +{
> > +}
> >
> >  static inline unsigned long efi_get_max_initrd_addr(unsigned long imag=
e_addr)
> >  {
> > diff --git a/arch/loongarch/kernel/efi-header.S b/arch/loongarch/kernel=
/efi-header.S
> > new file mode 100644
> > index 000000000000..8c1d229a2afa
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/efi-header.S
> > @@ -0,0 +1,99 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/pe.h>
> > +#include <linux/sizes.h>
> > +
> > +     .macro  __EFI_PE_HEADER
> > +     .long   PE_MAGIC
> > +.Lcoff_header:
> > +     .short  IMAGE_FILE_MACHINE_LOONGARCH64          /* Machine */
> > +     .short  .Lsection_count                         /* NumberOfSectio=
ns */
> > +     .long   0                                       /* TimeDateStamp =
*/
> > +     .long   0                                       /* PointerToSymbo=
lTable */
> > +     .long   0                                       /* NumberOfSymbol=
s */
> > +     .short  .Lsection_table - .Loptional_header     /* SizeOfOptional=
Header */
> > +     .short  IMAGE_FILE_DEBUG_STRIPPED | \
> > +             IMAGE_FILE_EXECUTABLE_IMAGE | \
> > +             IMAGE_FILE_LINE_NUMS_STRIPPED           /* Characteristic=
s */
> > +
> > +.Loptional_header:
> > +     .short  PE_OPT_MAGIC_PE32PLUS                   /* PE32+ format *=
/
> > +     .byte   0x02                                    /* MajorLinkerVer=
sion */
> > +     .byte   0x14                                    /* MinorLinkerVer=
sion */
> > +     .long   __inittext_end - .Lefi_header_end       /* SizeOfCode */
> > +     .long   _end - __initdata_begin                 /* SizeOfInitiali=
zedData */
> > +     .long   0                                       /* SizeOfUninitia=
lizedData */
> > +     .long   __efistub_efi_pe_entry - _head          /* AddressOfEntry=
Point */
> > +     .long   .Lefi_header_end - _head                /* BaseOfCode */
> > +
> > +.Lextra_header_fields:
> > +     .quad   0                                       /* ImageBase */
> > +     .long   PECOFF_SEGMENT_ALIGN                    /* SectionAlignme=
nt */
> > +     .long   PECOFF_FILE_ALIGN                       /* FileAlignment =
*/
> > +     .short  0                                       /* MajorOperating=
SystemVersion */
> > +     .short  0                                       /* MinorOperating=
SystemVersion */
> > +     .short  LINUX_EFISTUB_MAJOR_VERSION             /* MajorImageVers=
ion */
> > +     .short  LINUX_EFISTUB_MINOR_VERSION             /* MinorImageVers=
ion */
> > +     .short  0                                       /* MajorSubsystem=
Version */
> > +     .short  0                                       /* MinorSubsystem=
Version */
> > +     .long   0                                       /* Win32VersionVa=
lue */
> > +
> > +     .long   _end - _head                            /* SizeOfImage */
> > +
> > +     /* Everything before the kernel image is considered part of the h=
eader */
> > +     .long   .Lefi_header_end - _head                /* SizeOfHeaders =
*/
> > +     .long   0                                       /* CheckSum */
> > +     .short  IMAGE_SUBSYSTEM_EFI_APPLICATION         /* Subsystem */
> > +     .short  0                                       /* DllCharacteris=
tics */
> > +     .quad   0                                       /* SizeOfStackRes=
erve */
> > +     .quad   0                                       /* SizeOfStackCom=
mit */
> > +     .quad   0                                       /* SizeOfHeapRese=
rve */
> > +     .quad   0                                       /* SizeOfHeapComm=
it */
> > +     .long   0                                       /* LoaderFlags */
> > +     .long   (.Lsection_table - .) / 8               /* NumberOfRvaAnd=
Sizes */
> > +
> > +     .quad   0                                       /* ExportTable */
> > +     .quad   0                                       /* ImportTable */
> > +     .quad   0                                       /* ResourceTable =
*/
> > +     .quad   0                                       /* ExceptionTable=
 */
> > +     .quad   0                                       /* CertificationT=
able */
> > +     .quad   0                                       /* BaseRelocation=
Table */
> > +
> > +     /* Section table */
> > +.Lsection_table:
> > +     .ascii  ".text\0\0\0"
> > +     .long   __inittext_end - .Lefi_header_end       /* VirtualSize */
> > +     .long   .Lefi_header_end - _head                /* VirtualAddress=
 */
> > +     .long   __inittext_end - .Lefi_header_end       /* SizeOfRawData =
*/
> > +     .long   .Lefi_header_end - _head                /* PointerToRawDa=
ta */
> > +
> > +     .long   0                                       /* PointerToReloc=
ations */
> > +     .long   0                                       /* PointerToLineN=
umbers */
> > +     .short  0                                       /* NumberOfReloca=
tions */
> > +     .short  0                                       /* NumberOfLineNu=
mbers */
> > +     .long   IMAGE_SCN_CNT_CODE | \
> > +             IMAGE_SCN_MEM_READ | \
> > +             IMAGE_SCN_MEM_EXECUTE                   /* Characteristic=
s */
> > +
> > +     .ascii  ".data\0\0\0"
> > +     .long   _end - __initdata_begin                 /* VirtualSize */
> > +     .long   __initdata_begin - _head                /* VirtualAddress=
 */
> > +     .long   _edata - __initdata_begin               /* SizeOfRawData =
*/
> > +     .long   __initdata_begin - _head                /* PointerToRawDa=
ta */
> > +
> > +     .long   0                                       /* PointerToReloc=
ations */
> > +     .long   0                                       /* PointerToLineN=
umbers */
> > +     .short  0                                       /* NumberOfReloca=
tions */
> > +     .short  0                                       /* NumberOfLineNu=
mbers */
> > +     .long   IMAGE_SCN_CNT_INITIALIZED_DATA | \
> > +             IMAGE_SCN_MEM_READ | \
> > +             IMAGE_SCN_MEM_WRITE                     /* Characteristic=
s */
> > +
> > +     .set    .Lsection_count, (. - .Lsection_table) / 40
> > +
> > +     .balign 0x10000                                 /* PECOFF_SEGMENT=
_ALIGN */
> > +.Lefi_header_end:
> > +     .endm
> > diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> > index a50b60c587fa..1f1f755fb425 100644
> > --- a/arch/loongarch/kernel/efi.c
> > +++ b/arch/loongarch/kernel/efi.c
> > @@ -69,4 +69,7 @@ void __init efi_init(void)
> >       config_tables =3D early_memremap(efi_config_table, efi_nr_tables =
* size);
> >       efi_config_parse_tables(config_tables, efi_systab->nr_tables, arc=
h_tables);
> >       early_memunmap(config_tables, efi_nr_tables * size);
> > +
> > +     if (screen_info.orig_video_isVGA =3D=3D VIDEO_TYPE_EFI)
> > +             memblock_reserve(screen_info.lfb_base, screen_info.lfb_si=
ze);
> >  }
> > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.=
S
> > index c60eb66793e3..01bac62a6442 100644
> > --- a/arch/loongarch/kernel/head.S
> > +++ b/arch/loongarch/kernel/head.S
> > @@ -12,6 +12,26 @@
> >  #include <asm/loongarch.h>
> >  #include <asm/stackframe.h>
> >
> > +#ifdef CONFIG_EFI_STUB
> > +
> > +#include "efi-header.S"
> > +
> > +     __HEAD
> > +
> > +_head:
> > +     .word   MZ_MAGIC                /* "MZ", MS-DOS header */
> > +     .org    0x3c                    /* 0x04 ~ 0x3b reserved */
> > +     .long   pe_header - _head       /* Offset to the PE header */
> > +
> > +pe_header:
> > +     __EFI_PE_HEADER
> > +
> > +SYM_DATA(kernel_asize, .long _end - _text);
> > +SYM_DATA(kernel_fsize, .long _edata - _text);
> > +SYM_DATA(kernel_offset, .long kernel_offset - _text);
> > +
> > +#endif
> > +
> >       __REF
> >
> >  SYM_CODE_START(kernel_entry)                 # kernel entry point
> > diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel=
/image-vars.h
> > new file mode 100644
> > index 000000000000..c901ebb903f2
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/image-vars.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef __LOONGARCH_KERNEL_IMAGE_VARS_H
> > +#define __LOONGARCH_KERNEL_IMAGE_VARS_H
> > +
> > +#ifdef CONFIG_EFI_STUB
> > +
> > +__efistub_memcmp             =3D memcmp;
> > +__efistub_memchr             =3D memchr;
> > +__efistub_memcpy             =3D memcpy;
> > +__efistub_memmove            =3D memmove;
> > +__efistub_memset             =3D memset;
> > +__efistub_strcat             =3D strcat;
> > +__efistub_strcmp             =3D strcmp;
> > +__efistub_strlen             =3D strlen;
> > +__efistub_strncat            =3D strncat;
> > +__efistub_strnstr            =3D strnstr;
> > +__efistub_strnlen            =3D strnlen;
> > +__efistub_strrchr            =3D strrchr;
> > +__efistub_kernel_entry               =3D kernel_entry;
> > +__efistub_kernel_asize               =3D kernel_asize;
> > +__efistub_kernel_fsize               =3D kernel_fsize;
> > +__efistub_kernel_offset              =3D kernel_offset;
> > +__efistub_screen_info                =3D screen_info;
> > +
> > +#endif
> > +
> > +#endif /* __LOONGARCH_KERNEL_IMAGE_VARS_H */
> > diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setu=
p.c
> > index 23ee293e1cd2..f938aae3e92c 100644
> > --- a/arch/loongarch/kernel/setup.c
> > +++ b/arch/loongarch/kernel/setup.c
> > @@ -49,9 +49,7 @@
> >  #define SMBIOS_CORE_PACKAGE_OFFSET   0x23
> >  #define LOONGSON_EFI_ENABLE          (1 << 3)
> >
> > -#ifdef CONFIG_VT
> > -struct screen_info screen_info;
> > -#endif
> > +struct screen_info screen_info __section(".data");
> >
> >  unsigned long fw_arg0, fw_arg1;
> >  DEFINE_PER_CPU(unsigned long, kernelsp);
> > @@ -122,16 +120,9 @@ static void __init parse_cpu_table(const struct dm=
i_header *dm)
> >
> >  static void __init parse_bios_table(const struct dmi_header *dm)
> >  {
> > -     int bios_extern;
> >       char *dmi_data =3D (char *)dm;
> >
> > -     bios_extern =3D *(dmi_data + SMBIOS_BIOSEXTERN_OFFSET);
> >       b_info.bios_size =3D (*(dmi_data + SMBIOS_BIOSSIZE_OFFSET) + 1) <=
< 6;
> > -
> > -     if (bios_extern & LOONGSON_EFI_ENABLE)
> > -             set_bit(EFI_BOOT, &efi.flags);
> > -     else
> > -             clear_bit(EFI_BOOT, &efi.flags);
> >  }
> >
> >  static void __init find_tokens(const struct dmi_header *dm, void *dumm=
y)
> > @@ -145,6 +136,7 @@ static void __init find_tokens(const struct dmi_hea=
der *dm, void *dummy)
> >               break;
> >       }
> >  }
> > +
> >  static void __init smbios_parse(void)
> >  {
> >       b_info.bios_vendor =3D (void *)dmi_get_system_info(DMI_BIOS_VENDO=
R);
> > diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kerne=
l/vmlinux.lds.S
> > index 69c76f26c1c5..36d042739f3c 100644
> > --- a/arch/loongarch/kernel/vmlinux.lds.S
> > +++ b/arch/loongarch/kernel/vmlinux.lds.S
> > @@ -12,6 +12,7 @@
> >  #define BSS_FIRST_SECTIONS *(.bss..swapper_pg_dir)
> >
> >  #include <asm-generic/vmlinux.lds.h>
> > +#include "image-vars.h"
> >
> >  /*
> >   * Max avaliable Page Size is 64K, so we set SectionAlignment
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfi=
g
> > index 6cb7384ad2ac..cbf1c55dc224 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -107,7 +107,7 @@ config EFI_GENERIC_STUB
> >
> >  config EFI_ARMSTUB_DTB_LOADER
> >       bool "Enable the DTB loader"
> > -     depends on EFI_GENERIC_STUB && !RISCV
> > +     depends on EFI_GENERIC_STUB && !RISCV && !LOONGARCH
> >       default y
> >       help
> >         Select this config option to add support for the dtb=3D command
> > @@ -124,7 +124,7 @@ config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
> >       bool "Enable the command line initrd loader" if !X86
> >       depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
> >       default y if X86
> > -     depends on !RISCV
> > +     depends on !RISCV && !LOONGARCH
> >       help
> >         Select this config option to add support for the initrd=3D comm=
and
> >         line parameter, allowing an initrd that resides on the same vol=
ume
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/e=
fi/libstub/Makefile
> > index d0537573501e..1588c61939e7 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -26,6 +26,8 @@ cflags-$(CONFIG_ARM)                :=3D $(subst $(CC=
_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                  $(call cc-option,-mno-single-pic-base)
> >  cflags-$(CONFIG_RISCV)               :=3D $(subst $(CC_FLAGS_FTRACE),,=
$(KBUILD_CFLAGS)) \
> >                                  -fpic
> > +cflags-$(CONFIG_LOONGARCH)   :=3D $(subst $(CC_FLAGS_FTRACE),,$(KBUILD=
_CFLAGS)) \
> > +                                -fpic
> >
> >  cflags-$(CONFIG_EFI_GENERIC_STUB) +=3D -I$(srctree)/scripts/dtc/libfdt
> >
> > @@ -70,6 +72,8 @@ lib-$(CONFIG_ARM)           +=3D arm32-stub.o
> >  lib-$(CONFIG_ARM64)          +=3D arm64-stub.o
> >  lib-$(CONFIG_X86)            +=3D x86-stub.o
> >  lib-$(CONFIG_RISCV)          +=3D riscv-stub.o
> > +lib-$(CONFIG_LOONGARCH)              +=3D loongarch-stub.o
> > +
> >  CFLAGS_arm32-stub.o          :=3D -DTEXT_OFFSET=3D$(TEXT_OFFSET)
> >
> >  # Even when -mbranch-protection=3Dnone is set, Clang will generate a
> > @@ -125,6 +129,12 @@ STUBCOPY_FLAGS-$(CONFIG_RISCV)   +=3D --prefix-all=
oc-sections=3D.init \
> >                                  --prefix-symbols=3D__efistub_
> >  STUBCOPY_RELOC-$(CONFIG_RISCV)       :=3D R_RISCV_HI20
> >
> > +# For LoongArch, keep all the symbols in .init section and make sure t=
hat no
> > +# absolute symbols references doesn't exist.
> > +STUBCOPY_FLAGS-$(CONFIG_LOONGARCH)   +=3D --prefix-alloc-sections=3D.i=
nit \
> > +                                        --prefix-symbols=3D__efistub_
> > +STUBCOPY_RELOC-$(CONFIG_LOONGARCH)   :=3D R_LARCH_MARK_LA
> > +
> >  $(obj)/%.stub.o: $(obj)/%.o FORCE
> >       $(call if_changed,stubcopy)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware=
/efi/libstub/efi-stub.c
> > index f515394cce6e..efb9219d8d49 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub.c
> > @@ -40,14 +40,19 @@
> >
> >  #ifdef CONFIG_ARM64
> >  # define EFI_RT_VIRTUAL_LIMIT        DEFAULT_MAP_WINDOW_64
> > -#elif defined(CONFIG_RISCV)
> > +#elif defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
> >  # define EFI_RT_VIRTUAL_LIMIT        TASK_SIZE_MIN
> > -#else
> > +#else /* Only if TASK_SIZE is a constant */
> >  # define EFI_RT_VIRTUAL_LIMIT        TASK_SIZE
> >  #endif
> >
> > +/*
> > + * 0: No flat mapping
> > + * 1: Flat mapping that VA =3D PA
> > + * 2: Flat mapping that VA =3D PA + PAGE_OFFSET
> > + */
> > +static int flat_va_mapping;
> >  static u64 virtmap_base =3D EFI_RT_VIRTUAL_BASE;
> > -static bool flat_va_mapping;
> >
> >  const efi_system_table_t *efi_system_table;
> >
> > @@ -121,6 +126,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t han=
dle,
> >  {
> >       efi_loaded_image_t *image;
> >       efi_status_t status;
> > +     unsigned long attrib;
> >       unsigned long image_addr;
> >       unsigned long image_size =3D 0;
> >       /* addr/point and size pairs for memory management*/
> > @@ -254,9 +260,11 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t ha=
ndle,
> >        * The easiest way to achieve that is to simply use a 1:1 mapping=
.
> >        */
> >       prop_tbl =3D get_efi_config_table(EFI_PROPERTIES_TABLE_GUID);
> > -     flat_va_mapping =3D prop_tbl &&
> > -                       (prop_tbl->memory_protection_attribute &
> > -                        EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_E=
XECUTABLE_PE_DATA);
> > +     attrib =3D prop_tbl ? prop_tbl->memory_protection_attribute : 0;
> > +     if (attrib & EFI_PROPERTIES_RUNTIME_MEMORY_PROTECTION_NON_EXECUTA=
BLE_PE_DATA)
> > +             flat_va_mapping =3D 1;
> > +     if (IS_ENABLED(CONFIG_LOONGARCH))
> > +             flat_va_mapping =3D 2;
> >
> >       /* force efi_novamap if SetVirtualAddressMap() is unsupported */
> >       efi_novamap |=3D !(get_supported_rt_services() &
> > @@ -338,7 +346,16 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map=
, unsigned long map_size,
> >               paddr =3D in->phys_addr;
> >               size =3D in->num_pages * EFI_PAGE_SIZE;
> >
> > -             in->virt_addr =3D in->phys_addr;
> > +             switch (flat_va_mapping) {
> > +             case 1:
> > +                     in->virt_addr =3D in->phys_addr;
> > +                     break;
> > +             case 2:
> > +                     in->virt_addr =3D in->phys_addr + PAGE_OFFSET;
> It is useful for cachable runtime memory, however there exists uncachable=
 runtime physical address also.
Yes, so we will change to use the UNCACHE_BASE, as discussed.

>
> > +                     break;
> > +             default:
> > +                     in->virt_addr =3D in->phys_addr;
> > +             }
> >               if (efi_novamap) {
> >                       continue;
> >               }
> > diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/fi=
rmware/efi/libstub/loongarch-stub.c
> > new file mode 100644
> > index 000000000000..b7ef8d2df59e
> > --- /dev/null
> > +++ b/drivers/firmware/efi/libstub/loongarch-stub.c
> > @@ -0,0 +1,60 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Author: Yun Liu <liuyun@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <asm/efi.h>
> > +#include <asm/addrspace.h>
> > +#include "efistub.h"
> > +
> > +typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long fdt)=
;
> > +
> > +extern int kernel_asize;
> > +extern int kernel_fsize;
> > +extern int kernel_offset;
> > +extern kernel_entry_t kernel_entry;
> > +
> > +efi_status_t check_platform_features(void)
> > +{
> > +     return EFI_SUCCESS;
> > +}
> > +
> > +efi_status_t handle_kernel_image(unsigned long *image_addr,
> > +                              unsigned long *image_size,
> > +                              unsigned long *reserve_addr,
> > +                              unsigned long *reserve_size,
> > +                              efi_loaded_image_t *image,
> > +                              efi_handle_t image_handle)
> > +{
> > +     efi_status_t status;
> > +     unsigned long kernel_addr =3D 0;
> > +
> > +     kernel_addr =3D (unsigned long)&kernel_offset - kernel_offset;
> > +
> > +     status =3D efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel=
_asize,
> > +                                  PHYSADDR(VMLINUX_LOAD_ADDRESS), SZ_2=
M, 0x0);
> > +
> > +     *image_addr =3D kernel_addr;
> > +     *image_size =3D kernel_asize;
> > +
> > +     return status;
> > +}
> > +
> > +void __noreturn efi_enter_kernel(unsigned long entrypoint, unsigned lo=
ng fdt, unsigned long fdt_size)
> > +{
> > +     kernel_entry_t real_kernel_entry;
> > +
> > +     /* Config Direct Mapping */
> > +     csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
> > +     csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
> > +
> > +     real_kernel_entry =3D (kernel_entry_t)
> > +             ((unsigned long)&kernel_entry - entrypoint + VMLINUX_LOAD=
_ADDRESS);
> > +
> > +     if (!efi_novamap)
> > +             real_kernel_entry(true, fdt);
> > +     else
> > +             real_kernel_entry(false, fdt);
> Do we need turn off mmu and jump to physical kernel entry address ?
> Or jump to direct mapped address like this?
I don't think so, we will immediately turn on mmu after jumping, this
operation seems meaningless.

Huacai
>
> regards
> bibo,mao
>
> > +}
> > diff --git a/include/linux/pe.h b/include/linux/pe.h
> > index daf09ffffe38..1d3836ef9d92 100644
> > --- a/include/linux/pe.h
> > +++ b/include/linux/pe.h
> > @@ -65,6 +65,8 @@
> >  #define      IMAGE_FILE_MACHINE_SH5          0x01a8
> >  #define      IMAGE_FILE_MACHINE_THUMB        0x01c2
> >  #define      IMAGE_FILE_MACHINE_WCEMIPSV2    0x0169
> > +#define      IMAGE_FILE_MACHINE_LOONGARCH32  0x6232
> > +#define      IMAGE_FILE_MACHINE_LOONGARCH64  0x6264
> >
> >  /* flags */
> >  #define IMAGE_FILE_RELOCS_STRIPPED           0x0001
>
