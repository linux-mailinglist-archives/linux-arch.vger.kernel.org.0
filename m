Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C58252776A
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 14:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiEOMif (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 08:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiEOMie (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 08:38:34 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3EB275D4;
        Sun, 15 May 2022 05:38:29 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id y74so12889062vsy.7;
        Sun, 15 May 2022 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gfkbMmk8wyZ+ot1wQRLuDLFskAEpe8DDAFw8n0s/9os=;
        b=SDhHYxjYv8kNiOHuRJD/w4nMBnFqCnR8EfN8OoE109nRhBnqQKO07TwkhQCw2akb88
         D5u+kq/pV2iQcudd+kbQQQYGg7aIfmBspaRyoPrpQryqay5KJIQxBtZ64vjEQ9eFMOZH
         UdBIop6zXuMKrpX8FGOHgrurNCciRcmIMo31AIGXULD1vPBzW4EWFrYQHDobU9YDARlo
         qrxXP8qUTZTj8dVoRQ0vxqgpwf707bIy0vesC33I/LAi4fa3g4Zgf2lcgSJdtpp13tt2
         FRlbICZ0cmCj2+ylXecWlXsWiW/UzMWtZeE7rGEfvKK8LYVIEyJicunVLVRF7qtGAgiS
         lUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gfkbMmk8wyZ+ot1wQRLuDLFskAEpe8DDAFw8n0s/9os=;
        b=jGN8WP85LFWpAJPqcLH82MnAuzDrDAWgsG7o0tFIcMSjAsmzlzrt9+2qy/X6qyOMqt
         XzClu4jHxada3Abd3BMVPuC0jUNTlCnNLgncFr9ZYjekepza99QoQZgzOTALkKlxpTFA
         DAdJeywO9WhNV6csfohkboZojo1c61Z/wbTIKijBNf3JiCaEKU0coglhSx5J8ZC8fO0V
         lgpdVWi+gEXxHdKv8PhgU0pdeESlc/2P+ZypCX52ArvZmP99GX/sD+pgL1rGYIvUBaNM
         1YVeFDmSz6kaWR7vmpoOUj/biWKM5R2J38JEP7cic8MMoo+5p86laWQY/qxyl6jUi4QB
         yGiw==
X-Gm-Message-State: AOAM5330XN1KXG8UU3CdOpbX7zI9RTYQDTEJN20MsC0A6yih9GN1EhDG
        GGLQFGcd6leL7bv48cQdfneqb3x01Gr/fy+cZZc=
X-Google-Smtp-Source: ABdhPJwWFCLjbfn4Hk994Ns/ZWh4ZBoR5ri6yLAQMyNVRG67wQGL4be64fqHhmXKO8spX3rBvqIIvleojm4kq6o2OLM=
X-Received: by 2002:a67:ea4f:0:b0:328:1db4:d85c with SMTP id
 r15-20020a67ea4f000000b003281db4d85cmr4530018vso.20.1652618307857; Sun, 15
 May 2022 05:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-10-chenhuacai@loongson.cn> <e7616076-d8b1-defc-5762-b8ee91cb89fc@xen0n.name>
In-Reply-To: <e7616076-d8b1-defc-5762-b8ee91cb89fc@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 20:38:14 +0800
Message-ID: <CAAhV-H6yUKgew018Dj=9AyxYu0ofbBpG9vO3yjmyWSZ9S77BAA@mail.gmail.com>
Subject: Re: [PATCH V10 09/22] LoongArch: Add boot and setup routines
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Sun, May 15, 2022 at 4:45 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi,
>
> On 5/14/22 16:03, Huacai Chen wrote:
> > Add basic boot, setup and reset routines for LoongArchi support.
>
> typo -- "LoongArchi".
>
> This sentence could just be "Add basic boot, setup and reset routines
> for LoongArch".
>
> > LoongArch uses UEFI-based firmware. The firmware uses ACPI and DMI/
> > SMBIOS to pass configuration information to the Linux kernel.
> "The firmware passes configuration information to the kernel via ACPI
> and DMI/SMBIOS."
> >
> > Now the boot information passed to kernel is like this:
> > 1, kernel get 2 register values (a0 and a1) from bootloader.
> > 2, a0 is a "efi boot flag" to distinguish UEFI BIOS and non-UEFI BIOS.
> > 3, a1 is a "fdt pointer", including systable, memmap, cmdline and initr=
d
> >     information.
>
> This paragraph is hopelessly Chinglish, let me reword a bit:
>
> Currently an ad-hoc interface between the kernel and the bootloader is
> implemented. Kernel gets 2 values from the bootloader, passed in
> registers a0 and a1; a0 is an "EFI boot flag" distinguishing UEFI and
> non-UEFI firmware, while a1 is a pointer to an FDT with systable,
> memmap, cmdline and initrd information.
>
> >
> > The above interface is an internal interface between bootloader (grub,
> > efistub, etc.) and the raw kernel. You can use this method to boot the
> > Linux kernel in raw elf format, but it is recommend to use the standard
> > UEFI boot protocol (efistub).
> This interface is used by existing bootloaders for booting kernels in
> raw ELF format. However, the standard UEFI boot protocol (EFISTUB) is
> preferred down the road.
Thank you for helping me to improve the words.

> >
> > ECR for adding LoongArch support in ACPI:
> > https://mantis.uefi.org/mantis/view.php?id=3D2203
> >
> > ECR for adding LoongArch support in ACPI (version update):
> > https://mantis.uefi.org/mantis/view.php?id=3D2268
> >
> > ECR for adding LoongArch support in UEFI:
> > https://mantis.uefi.org/mantis/view.php?id=3D2313
> >
> > ACPI changes of LoongArch have been approved in the last year, but the
> > new version of ACPI SPEC hasn't been made public yet. And UEFI changes
> > of LoongArch are under review now.
> >
> > Cc: linux-efi@vger.kernel.org
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/acenv.h            |  17 +
> >   arch/loongarch/include/asm/acpi.h             |  38 ++
> >   arch/loongarch/include/asm/bootinfo.h         |  41 +++
> >   arch/loongarch/include/asm/dmi.h              |  24 ++
> >   arch/loongarch/include/asm/efi.h              |  41 +++
> >   arch/loongarch/include/asm/reboot.h           |  10 +
> >   arch/loongarch/include/asm/setup.h            |  21 ++
> >   arch/loongarch/kernel/acpi.c                  | 338 +++++++++++++++++
> >   arch/loongarch/kernel/cacheinfo.c             | 122 ++++++
> >   arch/loongarch/kernel/cpu-probe.c             | 292 +++++++++++++++
> >   arch/loongarch/kernel/efi-header.S            | 100 +++++
> >   arch/loongarch/kernel/efi.c                   | 229 ++++++++++++
> >   arch/loongarch/kernel/env.c                   |  70 ++++
> >   arch/loongarch/kernel/head.S                  |  97 +++++
> >   arch/loongarch/kernel/image-vars.h            |  29 ++
> >   arch/loongarch/kernel/mem.c                   |  64 ++++
> >   arch/loongarch/kernel/reset.c                 |  90 +++++
> >   arch/loongarch/kernel/setup.c                 | 348 +++++++++++++++++=
+
> >   arch/loongarch/kernel/time.c                  | 220 +++++++++++
> >   arch/loongarch/kernel/topology.c              |  13 +
> >   drivers/firmware/efi/Kconfig                  |   2 +-
> >   drivers/firmware/efi/libstub/Makefile         |  10 +
> >   .../firmware/efi/libstub/efi-stub-helper.c    |   2 +-
> >   drivers/firmware/efi/libstub/efi-stub.c       |   2 +-
> >   drivers/firmware/efi/libstub/loongarch-stub.c |  87 +++++
> >   include/linux/efi.h                           |   1 +
> >   include/linux/pe.h                            |   1 +
> >   27 files changed, 2306 insertions(+), 3 deletions(-)
> >   create mode 100644 arch/loongarch/include/asm/acenv.h
> >   create mode 100644 arch/loongarch/include/asm/acpi.h
> >   create mode 100644 arch/loongarch/include/asm/bootinfo.h
> >   create mode 100644 arch/loongarch/include/asm/dmi.h
> >   create mode 100644 arch/loongarch/include/asm/efi.h
> >   create mode 100644 arch/loongarch/include/asm/reboot.h
> >   create mode 100644 arch/loongarch/include/asm/setup.h
> >   create mode 100644 arch/loongarch/kernel/acpi.c
> >   create mode 100644 arch/loongarch/kernel/cacheinfo.c
> >   create mode 100644 arch/loongarch/kernel/cpu-probe.c
> >   create mode 100644 arch/loongarch/kernel/efi-header.S
> >   create mode 100644 arch/loongarch/kernel/efi.c
> >   create mode 100644 arch/loongarch/kernel/env.c
> >   create mode 100644 arch/loongarch/kernel/head.S
> >   create mode 100644 arch/loongarch/kernel/image-vars.h
> >   create mode 100644 arch/loongarch/kernel/mem.c
> >   create mode 100644 arch/loongarch/kernel/reset.c
> >   create mode 100644 arch/loongarch/kernel/setup.c
> >   create mode 100644 arch/loongarch/kernel/time.c
> >   create mode 100644 arch/loongarch/kernel/topology.c
> >   create mode 100644 drivers/firmware/efi/libstub/loongarch-stub.c
> >
> > diff --git a/arch/loongarch/include/asm/acenv.h b/arch/loongarch/includ=
e/asm/acenv.h
> > new file mode 100644
> > index 000000000000..290a15a41258
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/acenv.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * LoongArch specific ACPICA environments and implementation
> > + *
> > + * Author: Jianmin Lv <lvjianmin@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#ifndef _ASM_LOONGARCH_ACENV_H
> > +#define _ASM_LOONGARCH_ACENV_H
> > +
> > +/* The head file is required by ACPI core, but we have nothing to fill
> > + * it now, update it later when needed.
> > + */
> > +
> > +#endif /* _ASM_LOONGARCH_ACENV_H */
> > diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include=
/asm/acpi.h
> > new file mode 100644
> > index 000000000000..62044cd5b7bc
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/acpi.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Author: Jianmin Lv <lvjianmin@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#ifndef _ASM_LOONGARCH_ACPI_H
> > +#define _ASM_LOONGARCH_ACPI_H
> > +
> > +#ifdef CONFIG_ACPI
> > +extern int acpi_strict;
> > +extern int acpi_disabled;
> > +extern int acpi_pci_disabled;
> > +extern int acpi_noirq;
> > +
> > +#define acpi_os_ioremap acpi_os_ioremap
> > +void __init __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_=
size size);
> > +
> > +static inline void disable_acpi(void)
> > +{
> > +     acpi_disabled =3D 1;
> > +     acpi_pci_disabled =3D 1;
> > +     acpi_noirq =3D 1;
> > +}
> > +
> > +static inline bool acpi_has_cpu_in_madt(void)
> > +{
> > +     return true;
> > +}
> > +
> > +extern struct list_head acpi_wakeup_device_list;
> > +
> > +#endif /* !CONFIG_ACPI */
> > +
> > +#define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
> > +
> > +#endif /* _ASM_LOONGARCH_ACPI_H */
> > diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/inc=
lude/asm/bootinfo.h
> > new file mode 100644
> > index 000000000000..0076a9e1a817
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/bootinfo.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_BOOTINFO_H
> > +#define _ASM_BOOTINFO_H
> > +
> > +#include <linux/types.h>
> > +#include <asm/setup.h>
> > +
> > +const char *get_system_type(void);
> > +
> > +extern void init_environ(void);
> > +extern void memblock_init(void);
> > +extern void platform_init(void);
> > +
> > +struct loongson_board_info {
> > +     int bios_size;
> > +     char *bios_vendor;
> > +     char *bios_version;
> > +     char *bios_release_date;
> > +     char *board_name;
> > +     char *board_vendor;
> > +};
> > +
> > +struct loongson_system_configuration {
> > +     int nr_cpus;
> > +     int nr_nodes;
> > +     int nr_io_pics;
> > +     int boot_cpu_id;
> > +     int cores_per_node;
> > +     int cores_per_package;
> > +     char *cpuname;
> > +};
> > +
> > +extern u64 efi_system_table;
> > +extern struct loongson_board_info b_info;
> > +extern struct loongson_system_configuration loongson_sysconf;
> > +extern unsigned long fw_arg0, fw_arg1, fw_arg2;
> > +
> > +#endif /* _ASM_BOOTINFO_H */
> > diff --git a/arch/loongarch/include/asm/dmi.h b/arch/loongarch/include/=
asm/dmi.h
> > new file mode 100644
> > index 000000000000..605493417753
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/dmi.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_DMI_H
> > +#define _ASM_DMI_H
> > +
> > +#include <linux/io.h>
> > +#include <linux/memblock.h>
> > +
> > +#define dmi_early_remap(x, l)        dmi_remap(x, l)
> > +#define dmi_early_unmap(x, l)        dmi_unmap(x)
> > +#define dmi_alloc(l)         memblock_alloc(l, PAGE_SIZE)
> > +
> > +static inline void *dmi_remap(u64 phys_addr, unsigned long size)
> > +{
> > +     return ((void *)TO_CACHE(phys_addr));
> > +}
> > +
> > +static inline void dmi_unmap(void *addr)
> > +{
> > +}
> > +
> > +#endif /* _ASM_DMI_H */
> > diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/=
asm/efi.h
> > new file mode 100644
> > index 000000000000..319c50ac8b33
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/efi.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_LOONGARCH_EFI_H
> > +#define _ASM_LOONGARCH_EFI_H
> > +
> > +#include <linux/efi.h>
> > +
> > +void __init efi_init(void);
> > +void __init efi_runtime_init(void);
> > +void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
> > +
> > +#define ARCH_EFI_IRQ_FLAGS_MASK  0x00000001  /*bit0: CP0 Status.IE*/
>
> Stray MIPS-ism that is wrong for LoongArch as well. This needs to refer
> to CSR.CRMD.IE which is the bit 2:
>
> #define ARCH_EFI_IRQ_FLAGS_MASK  0x00000004  /* bit 2: CSR.CRMD.IE */
OK, thanks, this is my mistake.

>
> > +
> > +#define arch_efi_call_virt_setup()               \
> > +({                                               \
> > +})
> > +
> > +#define arch_efi_call_virt(p, f, args...)        \
> > +({                                               \
> > +     efi_##f##_t * __f;                       \
> > +     __f =3D p->f;                              \
> > +     __f(args);                               \
> > +})
> > +
> > +#define arch_efi_call_virt_teardown()            \
> > +({                                               \
> > +})
> > +
> > +#define EFI_ALLOC_ALIGN              SZ_64K
> > +
> > +struct screen_info *alloc_screen_info(void);
> > +void free_screen_info(struct screen_info *si);
> > +
> > +static inline unsigned long efi_get_max_initrd_addr(unsigned long imag=
e_addr)
> > +{
> > +     return ULONG_MAX;
> > +}
> > +
> > +#endif /* _ASM_LOONGARCH_EFI_H */
> > diff --git a/arch/loongarch/include/asm/reboot.h b/arch/loongarch/inclu=
de/asm/reboot.h
> > new file mode 100644
> > index 000000000000..51151749d8f0
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/reboot.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_REBOOT_H
> > +#define _ASM_REBOOT_H
> > +
> > +extern void (*pm_restart)(void);
> > +
> > +#endif /* _ASM_REBOOT_H */
> > diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/includ=
e/asm/setup.h
> > new file mode 100644
> > index 000000000000..6d7d2a3e23dd
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/setup.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#ifndef _LOONGARCH_SETUP_H
> > +#define _LOONGARCH_SETUP_H
> > +
> > +#include <linux/types.h>
> > +#include <uapi/asm/setup.h>
> > +
> > +#define VECSIZE 0x200
> > +
> > +extern unsigned long eentry;
> > +extern unsigned long tlbrentry;
> > +extern void cpu_cache_init(void);
> > +extern void per_cpu_trap_init(int cpu);
> > +extern void set_handler(unsigned long offset, void *addr, unsigned lon=
g len);
> > +extern void set_merr_handler(unsigned long offset, void *addr, unsigne=
d long len);
> > +
> > +#endif /* __SETUP_H */
> > diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.=
c
> > new file mode 100644
> > index 000000000000..506ab9912c51
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/acpi.c
> > @@ -0,0 +1,338 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * acpi.c - Architecture-Specific Low-Level ACPI Boot Support
> > + *
> > + * Author: Jianmin Lv <lvjianmin@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/acpi.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/memblock.h>
> > +#include <linux/serial_core.h>
> > +#include <asm/io.h>
> > +#include <asm/loongson.h>
> > +
> > +int acpi_disabled;
> > +EXPORT_SYMBOL(acpi_disabled);
> > +int acpi_noirq;
> > +int acpi_pci_disabled;
> > +EXPORT_SYMBOL(acpi_pci_disabled);
> > +int acpi_strict =3D 1; /* We have no workarounds on LoongArch */
> > +int num_processors;
> > +int disabled_cpus;
> > +enum acpi_irq_model_id acpi_irq_model =3D ACPI_IRQ_MODEL_PLATFORM;
> > +
> > +u64 acpi_saved_sp;
> > +
> > +#define MAX_CORE_PIC 256
> > +
> > +#define PREFIX                       "ACPI: "
> > +
> > +int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
> > +{
> > +     if (irqp !=3D NULL)
> > +             *irqp =3D acpi_register_gsi(NULL, gsi, -1, -1);
> > +     return (*irqp >=3D 0) ? 0 : -EINVAL;
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
> > +
> > +int acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
> > +{
> > +     if (gsi)
> > +             *gsi =3D isa_irq;
> > +     return 0;
> > +}
> > +
> > +/*
> > + * success: return IRQ number (>=3D0)
> > + * failure: return < 0
> > + */
> > +int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int po=
larity)
> > +{
> > +     int id;
> > +     struct irq_fwspec fwspec;
> > +
> > +     switch (gsi) {
> > +     case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
> > +             fwspec.fwnode =3D liointc_domain->fwnode;
> > +             fwspec.param[0] =3D gsi - GSI_MIN_CPU_IRQ;
> > +             fwspec.param_count =3D 1;
> > +
> > +             return irq_create_fwspec_mapping(&fwspec);
> > +
> > +     case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
> > +             if (!pch_lpc_domain)
> > +                     return -EINVAL;
> > +
> > +             fwspec.fwnode =3D pch_lpc_domain->fwnode;
> > +             fwspec.param[0] =3D gsi - GSI_MIN_LPC_IRQ;
> > +             fwspec.param[1] =3D acpi_dev_get_irq_type(trigger, polari=
ty);
> > +             fwspec.param_count =3D 2;
> > +
> > +             return irq_create_fwspec_mapping(&fwspec);
> > +
> > +     case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
> > +             id =3D find_pch_pic(gsi);
> > +             if (id < 0)
> > +                     return -EINVAL;
> > +
> > +             fwspec.fwnode =3D pch_pic_domain[id]->fwnode;
> > +             fwspec.param[0] =3D gsi - acpi_pchpic[id]->gsi_base;
> > +             fwspec.param[1] =3D IRQ_TYPE_LEVEL_HIGH;
> > +             fwspec.param_count =3D 2;
> > +
> > +             return irq_create_fwspec_mapping(&fwspec);
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_register_gsi);
> > +
> > +void acpi_unregister_gsi(u32 gsi)
> > +{
> > +
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> > +
> > +void __init __iomem * __acpi_map_table(unsigned long phys, unsigned lo=
ng size)
> > +{
> > +
> > +     if (!phys || !size)
> > +             return NULL;
> > +
> > +     return early_memremap(phys, size);
> > +}
> > +void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
> > +{
> > +     if (!map || !size)
> > +             return;
> > +
> > +     early_memunmap(map, size);
> > +}
> > +
> > +void __init __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_=
size size)
> > +{
> > +     if (!memblock_is_memory(phys))
> > +             return ioremap(phys, size);
> > +     else
> > +             return ioremap_cache(phys, size);
> > +}
> > +
> > +void __init acpi_boot_table_init(void)
> > +{
> > +     /*
> > +      * If acpi_disabled, bail out
> > +      */
> > +     if (acpi_disabled)
> > +             return;
> > +
> > +     /*
> > +      * Initialize the ACPI boot-time table parser.
> > +      */
> > +     if (acpi_table_init()) {
> > +             disable_acpi();
> > +             return;
> > +     }
> > +}
> > +
> > +static int __init
> > +acpi_parse_cpuintc(union acpi_subtable_headers *header, const unsigned=
 long end)
> > +{
> > +     struct acpi_madt_core_pic *processor =3D NULL;
> > +
> > +     processor =3D (struct acpi_madt_core_pic *)header;
> > +     if (BAD_MADT_ENTRY(processor, end))
> > +             return -EINVAL;
> > +
> > +     acpi_table_print_madt_entry(&header->common);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init
> > +acpi_parse_liointc(union acpi_subtable_headers *header, const unsigned=
 long end)
> > +{
> > +     struct acpi_madt_lio_pic *liointc =3D NULL;
> > +
> > +     liointc =3D (struct acpi_madt_lio_pic *)header;
> > +
> > +     if (BAD_MADT_ENTRY(liointc, end))
> > +             return -EINVAL;
> > +
> > +     acpi_liointc =3D liointc;
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init
> > +acpi_parse_eiointc(union acpi_subtable_headers *header, const unsigned=
 long end)
> > +{
> > +     static int id =3D 0;
> > +     struct acpi_madt_eio_pic *eiointc =3D NULL;
> > +
> > +     eiointc =3D (struct acpi_madt_eio_pic *)header;
> > +
> > +     if (BAD_MADT_ENTRY(eiointc, end))
> > +             return -EINVAL;
> > +
> > +     acpi_eiointc[id++] =3D eiointc;
> > +     loongson_sysconf.nr_io_pics =3D id;
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init
> > +acpi_parse_htintc(union acpi_subtable_headers *header, const unsigned =
long end)
> > +{
> > +     struct acpi_madt_ht_pic *htintc =3D NULL;
> > +
> > +     htintc =3D (struct acpi_madt_ht_pic *)header;
> > +
> > +     if (BAD_MADT_ENTRY(htintc, end))
> > +             return -EINVAL;
> > +
> > +     acpi_htintc =3D htintc;
> > +     loongson_sysconf.nr_io_pics =3D 1;
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init
> > +acpi_parse_pch_pic(union acpi_subtable_headers *header, const unsigned=
 long end)
> > +{
> > +     static int id =3D 0;
> > +     struct acpi_madt_bio_pic *pchpic =3D NULL;
> > +
> > +     pchpic =3D (struct acpi_madt_bio_pic *)header;
> > +
> > +     if (BAD_MADT_ENTRY(pchpic, end))
> > +             return -EINVAL;
> > +
> > +     acpi_pchpic[id++] =3D pchpic;
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init
> > +acpi_parse_pch_msi(union acpi_subtable_headers *header, const unsigned=
 long end)
> > +{
> > +     static int id =3D 0;
> > +     struct acpi_madt_msi_pic *pchmsi =3D NULL;
> > +
> > +     pchmsi =3D (struct acpi_madt_msi_pic *)header;
> > +
> > +     if (BAD_MADT_ENTRY(pchmsi, end))
> > +             return -EINVAL;
> > +
> > +     acpi_pchmsi[id++] =3D pchmsi;
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init
> > +acpi_parse_pch_lpc(union acpi_subtable_headers *header, const unsigned=
 long end)
> > +{
> > +     struct acpi_madt_lpc_pic *pchlpc =3D NULL;
> > +
> > +     pchlpc =3D (struct acpi_madt_lpc_pic *)header;
> > +
> > +     if (BAD_MADT_ENTRY(pchlpc, end))
> > +             return -EINVAL;
> > +
> > +     acpi_pchlpc =3D pchlpc;
> > +
> > +     return 0;
> > +}
> > +
> > +static void __init acpi_process_madt(void)
> > +{
> > +     int error;
> > +
> > +     /* Parse MADT CPUINTC entries */
> > +     error =3D acpi_table_parse_madt(ACPI_MADT_TYPE_CORE_PIC, acpi_par=
se_cpuintc, MAX_CORE_PIC);
> > +     if (error < 0) {
> > +             disable_acpi();
> > +             pr_err(PREFIX "Invalid BIOS MADT (CPUINTC entries), ACPI =
disabled\n");
> > +             return;
> > +     }
> > +
> > +     loongson_sysconf.nr_cpus =3D num_processors;
> > +
> > +     /* Parse MADT LIOINTC entries */
> > +     error =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC, acpi_pars=
e_liointc, 1);
> > +     if (error < 0) {
> > +             disable_acpi();
> > +             pr_err(PREFIX "Invalid BIOS MADT (LIOINTC entries), ACPI =
disabled\n");
> > +             return;
> > +     }
> > +
> > +     /* Parse MADT EIOINTC entries */
> > +     error =3D acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC, acpi_pars=
e_eiointc, MAX_IO_PICS);
> > +     if (error < 0) {
> > +             disable_acpi();
> > +             pr_err(PREFIX "Invalid BIOS MADT (EIOINTC entries), ACPI =
disabled\n");
> > +             return;
> > +     }
> > +
> > +     /* Parse MADT HTVEC entries */
> > +     error =3D acpi_table_parse_madt(ACPI_MADT_TYPE_HT_PIC, acpi_parse=
_htintc, 1);
> > +     if (error < 0) {
> > +             disable_acpi();
> > +             pr_err(PREFIX "Invalid BIOS MADT (HTVEC entries), ACPI di=
sabled\n");
> > +             return;
> > +     }
> > +
> > +     /* Parse MADT PCHPIC entries */
> > +     error =3D acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC, acpi_pars=
e_pch_pic, MAX_IO_PICS);
> > +     if (error < 0) {
> > +             disable_acpi();
> > +             pr_err(PREFIX "Invalid BIOS MADT (PCHPIC entries), ACPI d=
isabled\n");
> > +             return;
> > +     }
> > +
> > +     /* Parse MADT PCHMSI entries */
> > +     error =3D acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, acpi_pars=
e_pch_msi, MAX_IO_PICS);
> > +     if (error < 0) {
> > +             disable_acpi();
> > +             pr_err(PREFIX "Invalid BIOS MADT (PCHMSI entries), ACPI d=
isabled\n");
> > +             return;
> > +     }
> > +
> > +     /* Parse MADT PCHLPC entries */
> > +     error =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC, acpi_pars=
e_pch_lpc, 1);
> > +     if (error < 0) {
> > +             disable_acpi();
> > +             pr_err(PREFIX "Invalid BIOS MADT (PCHLPC entries), ACPI d=
isabled\n");
> > +             return;
> > +     }
> > +}
> > +
> > +int __init acpi_boot_init(void)
> > +{
> > +     /*
> > +      * If acpi_disabled, bail out
> > +      */
> > +     if (acpi_disabled)
> > +             return -1;
> > +
> > +     loongson_sysconf.boot_cpu_id =3D read_csr_cpuid();
> > +
> > +     /*
> > +      * Process the Multiple APIC Description Table (MADT), if present
> > +      */
> > +     acpi_process_madt();
> > +
> > +     /* Do not enable ACPI SPCR console by default */
> > +     acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
> > +
> > +     return 0;
> > +}
> > +
> > +void __init arch_reserve_mem_area(acpi_physical_address addr, size_t s=
ize)
> > +{
> > +     memblock_reserve(addr, size);
> > +}
> > diff --git a/arch/loongarch/kernel/cacheinfo.c b/arch/loongarch/kernel/=
cacheinfo.c
> > new file mode 100644
> > index 000000000000..8c9fe29e98f0
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/cacheinfo.c
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * LoongArch cacheinfo support
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/cacheinfo.h>
> > +
> > +/* Populates leaf and increments to next leaf */
> > +#define populate_cache(cache, leaf, c_level, c_type)         \
> > +do {                                                         \
> > +     leaf->type =3D c_type;                                    \
> > +     leaf->level =3D c_level;                                  \
> > +     leaf->coherency_line_size =3D c->cache.linesz;            \
> > +     leaf->number_of_sets =3D c->cache.sets;                   \
> > +     leaf->ways_of_associativity =3D c->cache.ways;            \
> > +     leaf->size =3D c->cache.linesz * c->cache.sets *          \
> > +             c->cache.ways;                                  \
> > +     leaf++;                                                 \
> > +} while (0)
> > +
> > +int init_cache_level(unsigned int cpu)
> > +{
> > +     struct cpuinfo_loongarch *c =3D &current_cpu_data;
> > +     struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> > +     int levels =3D 0, leaves =3D 0;
> > +
> > +     /*
> > +      * If Dcache is not set, we assume the cache structures
> > +      * are not properly initialized.
> > +      */
> > +     if (c->dcache.waysize)
> > +             levels +=3D 1;
> > +     else
> > +             return -ENOENT;
> > +
> > +
> > +     leaves +=3D (c->icache.waysize) ? 2 : 1;
> > +
> > +     if (c->vcache.waysize) {
> > +             levels++;
> > +             leaves++;
> > +     }
> > +
> > +     if (c->scache.waysize) {
> > +             levels++;
> > +             leaves++;
> > +     }
> > +
> > +     if (c->tcache.waysize) {
> > +             levels++;
> > +             leaves++;
> > +     }
> > +
> > +     this_cpu_ci->num_levels =3D levels;
> > +     this_cpu_ci->num_leaves =3D leaves;
> > +     return 0;
> > +}
> > +
> > +static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf=
,
> > +                                        struct cacheinfo *sib_leaf)
> > +{
> > +     return !((this_leaf->level =3D=3D 1) || (this_leaf->level =3D=3D =
2));
> > +}
> > +
> > +static void cache_cpumap_setup(unsigned int cpu)
> > +{
> > +     struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> > +     struct cacheinfo *this_leaf, *sib_leaf;
> > +     unsigned int index;
> > +
> > +     for (index =3D 0; index < this_cpu_ci->num_leaves; index++) {
> > +             unsigned int i;
> > +
> > +             this_leaf =3D this_cpu_ci->info_list + index;
> > +             /* skip if shared_cpu_map is already populated */
> > +             if (!cpumask_empty(&this_leaf->shared_cpu_map))
> > +                     continue;
> > +
> > +             cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
> > +             for_each_online_cpu(i) {
> > +                     struct cpu_cacheinfo *sib_cpu_ci =3D get_cpu_cach=
einfo(i);
> > +
> > +                     if (i =3D=3D cpu || !sib_cpu_ci->info_list)
> > +                             continue;/* skip if itself or no cacheinf=
o */
> > +                     sib_leaf =3D sib_cpu_ci->info_list + index;
> > +                     if (cache_leaves_are_shared(this_leaf, sib_leaf))=
 {
> > +                             cpumask_set_cpu(cpu, &sib_leaf->shared_cp=
u_map);
> > +                             cpumask_set_cpu(i, &this_leaf->shared_cpu=
_map);
> > +                     }
> > +             }
> > +     }
> > +}
> > +
> > +int populate_cache_leaves(unsigned int cpu)
> > +{
> > +     int level =3D 1;
> > +     struct cpuinfo_loongarch *c =3D &current_cpu_data;
> > +     struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> > +     struct cacheinfo *this_leaf =3D this_cpu_ci->info_list;
> > +
> > +     if (c->icache.waysize) {
> > +             populate_cache(dcache, this_leaf, level, CACHE_TYPE_DATA)=
;
> > +             populate_cache(icache, this_leaf, level++, CACHE_TYPE_INS=
T);
> > +     } else {
> > +             populate_cache(dcache, this_leaf, level++, CACHE_TYPE_UNI=
FIED);
> > +     }
> > +
> > +     if (c->vcache.waysize)
> > +             populate_cache(vcache, this_leaf, level++, CACHE_TYPE_UNI=
FIED);
> > +
> > +     if (c->scache.waysize)
> > +             populate_cache(scache, this_leaf, level++, CACHE_TYPE_UNI=
FIED);
> > +
> > +     if (c->tcache.waysize)
> > +             populate_cache(tcache, this_leaf, level++, CACHE_TYPE_UNI=
FIED);
> > +
> > +     cache_cpumap_setup(cpu);
> > +     this_cpu_ci->cpu_map_populated =3D true;
> > +
> > +     return 0;
> > +}
> > diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/=
cpu-probe.c
> > new file mode 100644
> > index 000000000000..ad1c4cde0dd6
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/cpu-probe.c
> > @@ -0,0 +1,292 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Processor capabilities determination functions.
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/ptrace.h>
> > +#include <linux/smp.h>
> > +#include <linux/stddef.h>
> > +#include <linux/export.h>
> > +#include <linux/printk.h>
> > +#include <linux/uaccess.h>
> > +
> > +#include <asm/cpu-features.h>
> > +#include <asm/elf.h>
> > +#include <asm/fpu.h>
> > +#include <asm/loongarch.h>
> > +#include <asm/pgtable-bits.h>
> > +#include <asm/setup.h>
> > +
> > +/* Hardware capabilities */
> > +unsigned int elf_hwcap __read_mostly;
> > +EXPORT_SYMBOL_GPL(elf_hwcap);
> > +
> > +/*
> > + * Determine the FCSR mask for FPU hardware.
> > + */
> > +static inline void cpu_set_fpu_fcsr_mask(struct cpuinfo_loongarch *c)
> > +{
> > +     unsigned long sr, mask, fcsr, fcsr0, fcsr1;
> > +
> > +     fcsr =3D c->fpu_csr0;
> > +     mask =3D FPU_CSR_ALL_X | FPU_CSR_ALL_E | FPU_CSR_ALL_S | FPU_CSR_=
RM;
> > +
> > +     sr =3D read_csr_euen();
> > +     enable_fpu();
> > +
> > +     fcsr0 =3D fcsr & mask;
> > +     write_fcsr(LOONGARCH_FCSR0, fcsr0);
> > +     fcsr0 =3D read_fcsr(LOONGARCH_FCSR0);
> > +
> > +     fcsr1 =3D fcsr | ~mask;
> > +     write_fcsr(LOONGARCH_FCSR0, fcsr1);
> > +     fcsr1 =3D read_fcsr(LOONGARCH_FCSR0);
> > +
> > +     write_fcsr(LOONGARCH_FCSR0, fcsr);
> > +
> > +     write_csr_euen(sr);
> > +
> > +     c->fpu_mask =3D ~(fcsr0 ^ fcsr1) & ~mask;
> > +}
> > +
> > +static inline void set_elf_platform(int cpu, const char *plat)
> > +{
> > +     if (cpu =3D=3D 0)
> > +             __elf_platform =3D plat;
> > +}
> > +
> > +/* MAP BASE */
> > +unsigned long vm_map_base;
> > +EXPORT_SYMBOL_GPL(vm_map_base);
> > +
> > +static void cpu_probe_addrbits(struct cpuinfo_loongarch *c)
> > +{
> > +#ifdef __NEED_ADDRBITS_PROBE
> > +     c->pabits =3D (read_cpucfg(LOONGARCH_CPUCFG1) & CPUCFG1_PABITS) >=
> 4;
> > +     c->vabits =3D (read_cpucfg(LOONGARCH_CPUCFG1) & CPUCFG1_VABITS) >=
> 12;
> > +     vm_map_base =3D 0UL - (1UL << c->vabits);
> > +#endif
> > +}
> > +
> > +static void set_isa(struct cpuinfo_loongarch *c, unsigned int isa)
> > +{
> > +     switch (isa) {
> > +     case LOONGARCH_CPU_ISA_LA64:
> > +             c->isa_level |=3D LOONGARCH_CPU_ISA_LA64;
> > +             fallthrough;
> > +     case LOONGARCH_CPU_ISA_LA32S:
> > +             c->isa_level |=3D LOONGARCH_CPU_ISA_LA32S;
> > +             fallthrough;
> > +     case LOONGARCH_CPU_ISA_LA32R:
> > +             c->isa_level |=3D LOONGARCH_CPU_ISA_LA32R;
> > +             break;
> > +     }
> > +}
> > +
> > +static void cpu_probe_common(struct cpuinfo_loongarch *c)
> > +{
> > +     unsigned int config;
> > +     unsigned long asid_mask;
> > +
> > +     c->options =3D LOONGARCH_CPU_CPUCFG | LOONGARCH_CPU_CSR |
> > +                  LOONGARCH_CPU_TLB | LOONGARCH_CPU_VINT | LOONGARCH_C=
PU_WATCH;
> > +
> > +     elf_hwcap |=3D HWCAP_LOONGARCH_CRC32;
> > +
> > +     config =3D read_cpucfg(LOONGARCH_CPUCFG1);
> > +     if (config & CPUCFG1_UAL) {
> > +             c->options |=3D LOONGARCH_CPU_UAL;
> > +             elf_hwcap |=3D HWCAP_LOONGARCH_UAL;
> > +     }
> > +
> > +     config =3D read_cpucfg(LOONGARCH_CPUCFG2);
> > +     if (config & CPUCFG2_LAM) {
> > +             c->options |=3D LOONGARCH_CPU_LAM;
> > +             elf_hwcap |=3D HWCAP_LOONGARCH_LAM;
> > +     }
> > +     if (config & CPUCFG2_FP) {
> > +             c->options |=3D LOONGARCH_CPU_FPU;
> > +             elf_hwcap |=3D HWCAP_LOONGARCH_FPU;
> > +     }
> > +     if (config & CPUCFG2_COMPLEX) {
> > +             c->options |=3D LOONGARCH_CPU_COMPLEX;
> > +             elf_hwcap |=3D HWCAP_LOONGARCH_COMPLEX;
> > +     }
> > +     if (config & CPUCFG2_CRYPTO) {
> > +             c->options |=3D LOONGARCH_CPU_CRYPTO;
> > +             elf_hwcap |=3D HWCAP_LOONGARCH_CRYPTO;
> > +     }
> > +     if (config & CPUCFG2_LVZP) {
> > +             c->options |=3D LOONGARCH_CPU_LVZ;
> > +             elf_hwcap |=3D HWCAP_LOONGARCH_LVZ;
> > +     }
> > +
> > +     config =3D read_cpucfg(LOONGARCH_CPUCFG6);
> > +     if (config & CPUCFG6_PMP)
> > +             c->options |=3D LOONGARCH_CPU_PMP;
> > +
> > +     config =3D iocsr_readl(LOONGARCH_IOCSR_FEATURES);
> > +     if (config & IOCSRF_CSRIPI)
> > +             c->options |=3D LOONGARCH_CPU_CSRIPI;
> > +     if (config & IOCSRF_EXTIOI)
> > +             c->options |=3D LOONGARCH_CPU_EXTIOI;
> > +     if (config & IOCSRF_FREQSCALE)
> > +             c->options |=3D LOONGARCH_CPU_SCALEFREQ;
> > +     if (config & IOCSRF_FLATMODE)
> > +             c->options |=3D LOONGARCH_CPU_FLATMODE;
> > +     if (config & IOCSRF_EIODECODE)
> > +             c->options |=3D LOONGARCH_CPU_EIODECODE;
> > +     if (config & IOCSRF_VM)
> > +             c->options |=3D LOONGARCH_CPU_HYPERVISOR;
> > +
> > +     config =3D csr_readl(LOONGARCH_CSR_ASID);
> > +     config =3D (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
> > +     asid_mask =3D GENMASK(config - 1, 0);
> > +     set_cpu_asid_mask(c, asid_mask);
> > +
> > +     config =3D read_csr_prcfg1();
> > +     c->kscratch_mask =3D GENMASK((config & CSR_CONF1_KSNUM) - 1, 0);
> > +     c->kscratch_mask &=3D ~(EXC_KSCRATCH_MASK | PERCPU_KSCRATCH_MASK =
| KVM_KSCRATCH_MASK);
> > +
> > +     config =3D read_csr_prcfg3();
> > +     switch (config & CSR_CONF3_TLBTYPE) {
> > +     case 0:
> > +             c->tlbsizemtlb =3D 0;
> > +             c->tlbsizestlbsets =3D 0;
> > +             c->tlbsizestlbways =3D 0;
> > +             c->tlbsize =3D 0;
> > +             break;
> > +     case 1:
> > +             c->tlbsizemtlb =3D ((config & CSR_CONF3_MTLBSIZE) >> CSR_=
CONF3_MTLBSIZE_SHIFT) + 1;
> > +             c->tlbsizestlbsets =3D 0;
> > +             c->tlbsizestlbways =3D 0;
> > +             c->tlbsize =3D c->tlbsizemtlb + c->tlbsizestlbsets * c->t=
lbsizestlbways;
> > +             break;
> > +     case 2:
> > +             c->tlbsizemtlb =3D ((config & CSR_CONF3_MTLBSIZE) >> CSR_=
CONF3_MTLBSIZE_SHIFT) + 1;
> > +             c->tlbsizestlbsets =3D 1 << ((config & CSR_CONF3_STLBIDX)=
 >> CSR_CONF3_STLBIDX_SHIFT);
> > +             c->tlbsizestlbways =3D ((config & CSR_CONF3_STLBWAYS) >> =
CSR_CONF3_STLBWAYS_SHIFT) + 1;
> > +             c->tlbsize =3D c->tlbsizemtlb + c->tlbsizestlbsets * c->t=
lbsizestlbways;
> > +             break;
> > +     default:
> > +             pr_warn("Warning: unimplemented tlb type\n");
> > +     }
> > +}
> > +
> > +#define MAX_NAME_LEN 32
> > +#define VENDOR_OFFSET        0
> > +#define CPUNAME_OFFSET       9
> > +
> > +static char cpu_full_name[MAX_NAME_LEN] =3D "        -        ";
> > +
> > +static inline void cpu_probe_loongson(struct cpuinfo_loongarch *c, uns=
igned int cpu)
> > +{
> > +     uint64_t *vendor =3D (void *)(&cpu_full_name[VENDOR_OFFSET]);
> > +     uint64_t *cpuname =3D (void *)(&cpu_full_name[CPUNAME_OFFSET]);
> > +
> > +     __cpu_full_name[cpu] =3D cpu_full_name;
> > +     *vendor =3D iocsr_readq(LOONGARCH_IOCSR_VENDOR);
> > +     *cpuname =3D iocsr_readq(LOONGARCH_IOCSR_CPUNAME);
> > +
> > +     switch (c->processor_id & PRID_SERIES_MASK) {
> > +     case PRID_SERIES_LA132:
> > +             c->cputype =3D CPU_LOONGSON32;
> > +             set_isa(c, LOONGARCH_CPU_ISA_LA32S);
> > +             __cpu_family[cpu] =3D "Loongson-32bit";
> > +             pr_info("32-bit Loongson Processor probed (LA132 Core)\n"=
);
> > +             break;
> > +     case PRID_SERIES_LA264:
> > +             c->cputype =3D CPU_LOONGSON64;
> > +             set_isa(c, LOONGARCH_CPU_ISA_LA64);
> > +             __cpu_family[cpu] =3D "Loongson-64bit";
> > +             pr_info("64-bit Loongson Processor probed (LA264 Core)\n"=
);
> > +             break;
> > +     case PRID_SERIES_LA364:
> > +             c->cputype =3D CPU_LOONGSON64;
> > +             set_isa(c, LOONGARCH_CPU_ISA_LA64);
> > +             __cpu_family[cpu] =3D "Loongson-64bit";
> > +             pr_info("64-bit Loongson Processor probed (LA364 Core)\n"=
);
> > +             break;
> > +     case PRID_SERIES_LA464:
> > +             c->cputype =3D CPU_LOONGSON64;
> > +             set_isa(c, LOONGARCH_CPU_ISA_LA64);
> > +             __cpu_family[cpu] =3D "Loongson-64bit";
> > +             pr_info("64-bit Loongson Processor probed (LA464 Core)\n"=
);
> > +             break;
> > +     case PRID_SERIES_LA664:
> > +             c->cputype =3D CPU_LOONGSON64;
> > +             set_isa(c, LOONGARCH_CPU_ISA_LA64);
> > +             __cpu_family[cpu] =3D "Loongson-64bit";
> > +             pr_info("64-bit Loongson Processor probed (LA664 Core)\n"=
);
> > +             break;
> > +     default: /* Default to 64 bit */
> > +             c->cputype =3D CPU_LOONGSON64;
> > +             set_isa(c, LOONGARCH_CPU_ISA_LA64);
> > +             __cpu_family[cpu] =3D "Loongson-64bit";
> > +             pr_info("64-bit Loongson Processor probed (Unknown Core)\=
n");
> > +     }
> > +}
> > +
> > +#ifdef CONFIG_64BIT
> > +/* For use by uaccess.h */
> > +u64 __ua_limit;
> > +EXPORT_SYMBOL(__ua_limit);
> > +#endif
> > +
> > +const char *__cpu_family[NR_CPUS];
> > +const char *__cpu_full_name[NR_CPUS];
> > +const char *__elf_platform;
> > +
> > +static void cpu_report(void)
> > +{
> > +     struct cpuinfo_loongarch *c =3D &current_cpu_data;
> > +
> > +     pr_info("CPU%d revision is: %08x (%s)\n",
> > +             smp_processor_id(), c->processor_id, cpu_family_string())=
;
> > +     if (c->options & LOONGARCH_CPU_FPU)
> > +             pr_info("FPU%d revision is: %08x\n", smp_processor_id(), =
c->fpu_vers);
> > +}
> > +
> > +void cpu_probe(void)
> > +{
> > +     unsigned int cpu =3D smp_processor_id();
> > +     struct cpuinfo_loongarch *c =3D &current_cpu_data;
> > +
> > +     /*
> > +      * Set a default elf platform, cpu probe may later
> > +      * overwrite it with a more precise value
> > +      */
> > +     set_elf_platform(cpu, "loongarch");
> > +
> > +     c->cputype      =3D CPU_UNKNOWN;
> > +     c->processor_id =3D read_cpucfg(LOONGARCH_CPUCFG0);
> > +     c->fpu_vers     =3D (read_cpucfg(LOONGARCH_CPUCFG2) >> 3) & 0x3;
> > +
> > +     c->fpu_csr0     =3D FPU_CSR_RN;
> > +     c->fpu_mask     =3D FPU_CSR_RSVD;
> > +
> > +     cpu_probe_common(c);
> > +
> > +     per_cpu_trap_init(cpu);
> > +
> > +     switch (c->processor_id & PRID_COMP_MASK) {
> > +     case PRID_COMP_LOONGSON:
> > +             cpu_probe_loongson(c, cpu);
> > +             break;
> > +     }
> > +
> > +     BUG_ON(!__cpu_family[cpu]);
> > +     BUG_ON(c->cputype =3D=3D CPU_UNKNOWN);
> > +
> > +     cpu_probe_addrbits(c);
> > +
> > +#ifdef CONFIG_64BIT
> > +     if (cpu =3D=3D 0)
> > +             __ua_limit =3D ~((1ull << cpu_vabits) - 1);
> > +#endif
> > +
> > +     cpu_report();
> > +}
> > diff --git a/arch/loongarch/kernel/efi-header.S b/arch/loongarch/kernel=
/efi-header.S
> > new file mode 100644
> > index 000000000000..d299cac4e691
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/efi-header.S
> > @@ -0,0 +1,100 @@
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
> > +     .short  IMAGE_FILE_MACHINE_LOONGARCH            /* Machine */
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
> > +     .org 0x20e
> > +     .word kernel_version - 512 -  _head
> > +
> > +     .set    .Lsection_count, (. - .Lsection_table) / 40
> > +.Lefi_header_end:
> > +     .endm
> > diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
> > new file mode 100644
> > index 000000000000..69ebdd4220ec
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/efi.c
> > @@ -0,0 +1,229 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * EFI initialization
> > + *
> > + * Author: Jianmin Lv <lvjianmin@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/efi.h>
> > +#include <linux/efi-bgrt.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/export.h>
> > +#include <linux/io.h>
> > +#include <linux/kobject.h>
> > +#include <linux/memblock.h>
> > +#include <linux/reboot.h>
> > +#include <linux/uaccess.h>
> > +
> > +#include <asm/early_ioremap.h>
> > +#include <asm/efi.h>
> > +#include <asm/tlb.h>
> > +#include <asm/loongson.h>
> > +
> > +static unsigned long efi_nr_tables;
> > +static unsigned long efi_config_table;
> > +static unsigned long screen_info_table __initdata =3D EFI_INVALID_TABL=
E_ADDR;
> > +
> > +static efi_system_table_t *efi_systab;
> > +static efi_config_table_type_t arch_tables[] __initdata =3D {
> > +     {LINUX_EFI_LARCH_SCREEN_INFO_TABLE_GUID, &screen_info_table, "SIN=
FO"},
> > +     {},
> > +};
> > +
> > +static void __init init_screen_info(void)
> > +{
> > +     struct screen_info *si;
> > +
> > +     if (screen_info_table =3D=3D EFI_INVALID_TABLE_ADDR)
> > +             return;
> > +
> > +     si =3D early_memremap_ro(screen_info_table, sizeof(*si));
> > +     if (!si) {
> > +             pr_err("Could not map screen_info config table\n");
> > +             return;
> > +     }
> > +     screen_info =3D *si;
> > +     early_memunmap(si, sizeof(*si));
> > +
> > +     if (screen_info.orig_video_isVGA =3D=3D VIDEO_TYPE_EFI)
> > +             memblock_reserve(screen_info.lfb_base, screen_info.lfb_si=
ze);
> > +}
> > +
> > +static void __init create_tlb(u32 index, u64 vppn, u32 ps, u32 mat)
> > +{
> > +     unsigned long tlblo0, tlblo1;
> > +
> > +     write_csr_pagesize(ps);
> > +
> > +     tlblo0 =3D vppn | CSR_TLBLO0_V | CSR_TLBLO0_WE |
> > +             CSR_TLBLO0_GLOBAL | (mat << CSR_TLBLO0_CCA_SHIFT);
> > +     tlblo1 =3D tlblo0 + (1 << ps);
> > +
> > +     csr_writeq(vppn, LOONGARCH_CSR_TLBEHI);
> > +     csr_writeq(tlblo0, LOONGARCH_CSR_TLBELO0);
> > +     csr_writeq(tlblo1, LOONGARCH_CSR_TLBELO1);
> > +     csr_xchgl(0, CSR_TLBIDX_EHINV, LOONGARCH_CSR_TLBIDX);
> > +     csr_xchgl(index, CSR_TLBIDX_IDX, LOONGARCH_CSR_TLBIDX);
> > +
> > +     tlb_write_indexed();
> > +}
> > +
> > +#define MTLB_ENTRY_INDEX     0x800
> > +
> > +/* Create VA =3D=3D PA mapping as UEFI */
> > +static void __init fix_efi_mapping(void)
> > +{
> > +     unsigned int index =3D MTLB_ENTRY_INDEX;
> > +     unsigned int tlbnr =3D boot_cpu_data.tlbsizemtlb - 2;
> > +     unsigned long i, vppn;
> > +
> > +     /* Low Memory, Cached */
> > +     create_tlb(index++, 0x00000000, PS_128M, 1);
> > +     /* MMIO Registers, Uncached */
> > +     create_tlb(index++, 0x10000000, PS_128M, 0);
> > +
> > +     /* High Memory, Cached */
> > +     for (i =3D 0; i < tlbnr; i++) {
> > +             vppn =3D 0x80000000ULL + (i * SZ_2G);
> > +             create_tlb(index++, vppn, PS_1G, 1);
> > +     }
> > +}
> > +
> > +/*
> > + * set_virtual_map() - create a virtual mapping for the EFI memory map=
 and call
> > + * efi_set_virtual_address_map enter virtual for runtime service
> > + *
> > + * This function populates the virt_addr fields of all memory region d=
escriptors
> > + * in @memory_map whose EFI_MEMORY_RUNTIME attribute is set. Those des=
criptors
> > + * are also copied to @runtime_map, and their total count is returned =
in @count.
> > + */
> > +static unsigned int __init set_virtual_map(void)
> > +{
> > +     int count =3D 0;
> > +     unsigned int size;
> > +     unsigned long attr;
> > +     efi_status_t status;
> > +     efi_runtime_services_t *rt;
> > +     efi_set_virtual_address_map_t *svam;
> > +     efi_memory_desc_t *in, runtime_map[32];
> > +
> > +     size =3D sizeof(efi_memory_desc_t);
> > +
> > +     for_each_efi_memory_desc(in) {
> > +             attr =3D in->attribute;
> > +             if (!(attr & EFI_MEMORY_RUNTIME))
> > +                     continue;
> > +
> > +             if (attr & (EFI_MEMORY_WB | EFI_MEMORY_WT))
> > +                     in->virt_addr =3D TO_CACHE(in->phys_addr);
> > +             else
> > +                     in->virt_addr =3D TO_UNCACHE(in->phys_addr);
> > +
> > +             memcpy(&runtime_map[count++], in, size);
> > +     }
> > +
> > +     rt =3D early_memremap_ro((unsigned long)efi_systab->runtime, size=
of(*rt));
> > +
> > +     /* Install the new virtual address map */
> > +     svam =3D rt->set_virtual_address_map;
> > +
> > +     fix_efi_mapping();
> > +
> > +     status =3D svam(size * count, size, efi.memmap.desc_version,
> > +                     (efi_memory_desc_t *)TO_PHYS((unsigned long)runti=
me_map));
> > +
> > +     local_flush_tlb_all();
> > +     write_csr_pagesize(PS_DEFAULT_SIZE);
> > +
> > +     if (status !=3D EFI_SUCCESS)
> > +             return -1;
> > +
> > +     return 0;
> > +}
> > +
> > +void __init efi_runtime_init(void)
> > +{
> > +     efi_status_t status;
> > +
> > +     if (!efi_enabled(EFI_BOOT))
> > +             return;
> > +
> > +     if (!efi_systab->runtime)
> > +             return;
> > +
> > +     status =3D set_virtual_map();
> > +     if (status < 0)
> > +             return;
> > +
> > +     if (efi_runtime_disabled()) {
> > +             pr_info("EFI runtime services will be disabled.\n");
> > +             return;
> > +     }
> > +
> > +     efi.runtime =3D (efi_runtime_services_t *)efi_systab->runtime;
> > +     efi.runtime_version =3D (unsigned int)efi.runtime->hdr.revision;
> > +
> > +     efi_native_runtime_setup();
> > +     set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> > +}
> > +
> > +void __init efi_init(void)
> > +{
> > +     int size;
> > +     void *config_tables;
> > +
> > +     if (!efi_system_table)
> > +             return;
> > +
> > +     efi_systab =3D (efi_system_table_t *)early_memremap_ro(efi_system=
_table, sizeof(efi_systab));
> > +     if (!efi_systab) {
> > +             pr_err("Can't find EFI system table.\n");
> > +             return;
> > +     }
> > +
> > +     set_bit(EFI_64BIT, &efi.flags);
> > +     efi_nr_tables    =3D efi_systab->nr_tables;
> > +     efi_config_table =3D (unsigned long)efi_systab->tables;
> > +
> > +     size =3D sizeof(efi_config_table_t);
> > +     config_tables =3D early_memremap(efi_config_table, efi_nr_tables =
* size);
> > +     efi_config_parse_tables(config_tables, efi_systab->nr_tables, arc=
h_tables);
> > +     early_memunmap(config_tables, efi_nr_tables * size);
> > +
> > +     init_screen_info();
> > +}
> > +
> > +static ssize_t boardinfo_show(struct kobject *kobj,
> > +                           struct kobj_attribute *attr, char *buf)
> > +{
> > +     return sprintf(buf,
> > +             "BIOS Information\n"
> > +             "Vendor\t\t\t: %s\n"
> > +             "Version\t\t\t: %s\n"
> > +             "ROM Size\t\t: %d KB\n"
> > +             "Release Date\t\t: %s\n\n"
> > +             "Board Information\n"
> > +             "Manufacturer\t\t: %s\n"
> > +             "Board Name\t\t: %s\n"
> > +             "Family\t\t\t: LOONGSON64\n\n",
> > +             b_info.bios_vendor, b_info.bios_version,
> > +             b_info.bios_size, b_info.bios_release_date,
> > +             b_info.board_vendor, b_info.board_name);
> > +}
> > +
> > +static struct kobj_attribute boardinfo_attr =3D __ATTR(boardinfo, 0444=
,
> > +                                                  boardinfo_show, NULL=
);
> > +
> > +static int __init boardinfo_init(void)
> > +{
> > +     if (!efi_kobj)
> > +             return -EINVAL;
> > +
> > +     return sysfs_create_file(efi_kobj, &boardinfo_attr.attr);
> > +}
> > +late_initcall(boardinfo_init);
> > diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
> > new file mode 100644
> > index 000000000000..bf2593f1e536
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/env.c
> > @@ -0,0 +1,70 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/acpi.h>
> > +#include <linux/efi.h>
> > +#include <linux/export.h>
> > +#include <linux/memblock.h>
> > +#include <linux/of_fdt.h>
> > +#include <asm/early_ioremap.h>
> > +#include <asm/bootinfo.h>
> > +#include <asm/loongson.h>
> > +
> > +u64 efi_system_table;
> > +struct loongson_system_configuration loongson_sysconf;
> > +EXPORT_SYMBOL(loongson_sysconf);
> > +
> > +u64 loongson_chipcfg[MAX_PACKAGES];
> > +u64 loongson_chiptemp[MAX_PACKAGES];
> > +u64 loongson_freqctrl[MAX_PACKAGES];
> > +unsigned long long smp_group[MAX_PACKAGES];
> > +
> > +static void __init register_addrs_set(u64 *registers, const u64 addr, =
int num)
> > +{
> > +     u64 i;
> > +
> > +     for (i =3D 0; i < num; i++) {
> > +             *registers =3D (i << 44) | addr;
> > +             registers++;
> > +     }
> > +}
> > +
> > +void __init init_environ(void)
> > +{
> > +     int efi_boot =3D fw_arg0;
> > +     struct efi_memory_map_data data;
> > +     void *fdt_ptr =3D early_memremap_ro(fw_arg1, SZ_64K);
> > +
> > +     if (efi_boot)
> > +             set_bit(EFI_BOOT, &efi.flags);
> > +     else
> > +             clear_bit(EFI_BOOT, &efi.flags);
> > +
> > +     early_init_dt_scan(fdt_ptr);
> > +     early_init_fdt_reserve_self();
> > +     efi_system_table =3D efi_get_fdt_params(&data);
> > +
> > +     efi_memmap_init_early(&data);
> > +     memblock_reserve(data.phys_map & PAGE_MASK,
> > +                      PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MA=
SK)));
> > +
> > +     register_addrs_set(smp_group, TO_UNCACHE(0x1fe01000), 16);
> > +     register_addrs_set(loongson_chipcfg, TO_UNCACHE(0x1fe00180), 16);
> > +     register_addrs_set(loongson_chiptemp, TO_UNCACHE(0x1fe0019c), 16)=
;
> > +     register_addrs_set(loongson_freqctrl, TO_UNCACHE(0x1fe001d0), 16)=
;
> > +}
> > +
> > +static int __init init_cpu_fullname(void)
> > +{
> > +     int cpu;
> > +
> > +     if (loongson_sysconf.cpuname && !strncmp(loongson_sysconf.cpuname=
, "Loongson", 8)) {
> > +             for (cpu =3D 0; cpu < NR_CPUS; cpu++)
> > +                     __cpu_full_name[cpu] =3D loongson_sysconf.cpuname=
;
> > +     }
> > +     return 0;
> > +}
> > +arch_initcall(init_cpu_fullname);
> > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.=
S
> > new file mode 100644
> > index 000000000000..f0b3e76bb762
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/head.S
> > @@ -0,0 +1,97 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/init.h>
> > +#include <linux/threads.h>
> > +
> > +#include <asm/addrspace.h>
> > +#include <asm/asm.h>
> > +#include <asm/asmmacro.h>
> > +#include <asm/regdef.h>
> > +#include <asm/loongarch.h>
> > +#include <asm/stackframe.h>
> > +#include <generated/compile.h>
> > +#include <generated/utsrelease.h>
> > +
> > +#ifdef CONFIG_EFI_STUB
> > +
> > +#include "efi-header.S"
> > +
> > +     __HEAD
> > +
> > +_head:
> > +     .word   MZ_MAGIC                /* "MZ", MS-DOS header */
> > +     .org    0x28
> > +     .ascii  "Loongson\0"            /* Magic number for BootLoader */
>
> If you must use a magic number, "Loongson" is not recommended, because
> this string lacks uniqueness in the Loongson/LoongArch world. Too many
> things are called "Loongson foo" right now, and the string is so
> ordinary people don't immediately think of it as "magic".
>
> I recommended using some other interesting text (and encoding) for the
> magic number, in a different communication venue, but I think that
> proposal got ignored by you without any explanation whatsoever. For now
> I'll just repeat myself:
>
> For an interesting magic number related to Loongson/LoongArch/Loong
> (like dragons but not exactly the same, let's not expand on that front)
> in general, it's perhaps better to use GB18030-encoded four-character
> dragon-related idioms. It's GB18030 because one Chinese character is 2
> bytes in this encoding, and being non-UTF-8 it's unlikely any user input
> would accidentally resemble it. So we get 8 bytes that appear as huge
> negative numbers if cast into C long, and random enough that collisions
> are highly unlikely.
>
> For example, I chose 4 famous dragon-related phrases from the I Ching,
> in both simplified and traditional characters:
>
> =E6=BD=9C=E9=BE=99=E5=8B=BF=E7=94=A8: 0xc7b1c1facef0d3c3
> =E8=A7=81=E9=BE=99=E5=9C=A8=E7=94=B0: 0xbcfbc1fad4daccef
> =E9=A3=9E=E9=BE=99=E5=9C=A8=E5=A4=A9: 0xb7c9c1fad4daccec
> =E4=BA=A2=E9=BE=99=E6=9C=89=E6=82=94: 0xbfbac1fad3d0bbda
> =E6=BD=9B=E9=BE=8D=E5=8B=BF=E7=94=A8: 0x9d93fd88cef0d3c3
> =E8=A6=8B=E9=BE=8D=E5=9C=A8=E7=94=B0: 0xd28afd88d4daccef
> =E9=A3=9B=E9=BE=8D=E5=9C=A8=E5=A4=A9: 0xef77fd88d4daccec
> =E4=BA=A2=E9=BE=8D=E6=9C=89=E6=82=94: 0xbfbafd88d3d0bbda
>
> and I think each of them is better than "Loongson".
ARM64_IMAGE_MAGIC is "ARM64", RISCV_IMAGE_MAGIC is "RISCV", so I think
we use "Loongson" as a magic is just OK.

>
> > +     .org    0x3c
> > +     .long   pe_header - _head       /* Offset to the PE header */
> > +
> > +pe_header:
> > +     __EFI_PE_HEADER
> > +
> > +SYM_DATA(kernel_asize, .long _end - _text);
> > +SYM_DATA(kernel_fsize, .long _edata - _text);
> > +SYM_DATA(kernel_offset, .long kernel_offset - _text);
> > +
> > +kernel_version:
> > +     .ascii  UTS_RELEASE " (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST =
") " UTS_VERSION "\0"
> > +
> > +#endif
> > +
> > +     __REF
> > +
> > +SYM_ENTRY(_stext, SYM_L_GLOBAL, SYM_A_NONE)
> > +
> > +SYM_CODE_START(kernel_entry)                 # kernel entry point
> > +
> > +     /* Config direct window and set PG */
> > +     li.d            t0, CSR_DMW0_INIT       # UC, PLV0, 0x8000 xxxx x=
xxx xxxx
> > +     csrwr           t0, LOONGARCH_CSR_DMWIN0
> > +     li.d            t0, CSR_DMW1_INIT       # CA, PLV0, 0x9000 xxxx x=
xxx xxxx
> > +     csrwr           t0, LOONGARCH_CSR_DMWIN1
> > +     /* Enable PG */
> > +     li.w            t0, 0xb0                # PLV=3D0, IE=3D0, PG=3D1
> > +     csrwr           t0, LOONGARCH_CSR_CRMD
> > +     li.w            t0, 0x04                # PLV=3D0, PIE=3D1, PWE=
=3D0
> > +     csrwr           t0, LOONGARCH_CSR_PRMD
> > +     li.w            t0, 0x00                # FPE=3D0, SXE=3D0, ASXE=
=3D0, BTE=3D0
> > +     csrwr           t0, LOONGARCH_CSR_EUEN
> > +
> > +     /* We might not get launched at the address the kernel is linked =
to,
> > +        so we jump there.  */
> > +     la.abs          t0, 0f
> > +     jirl            zero, t0, 0
> > +0:
> > +     la              t0, __bss_start         # clear .bss
> > +     st.d            zero, t0, 0
> > +     la              t1, __bss_stop - LONGSIZE
> > +1:
> > +     addi.d          t0, t0, LONGSIZE
> > +     st.d            zero, t0, 0
> > +     bne             t0, t1, 1b
> > +
> > +     la              t0, fw_arg0
> > +     st.d            a0, t0, 0               # firmware arguments
> > +     la              t0, fw_arg1
> > +     st.d            a1, t0, 0
> > +     la              t0, fw_arg2
> > +     st.d            a2, t0, 0
> We don't use a2 any more with this revision of boot protocol, so this
> could get removed.
> > +
> > +     /* KScratch3 used for percpu base, initialized as 0 */
> > +     csrwr           zero, PERCPU_BASE_KS
>
> KScratch3 is MIPS-ism, it's SAVE3 in LoongArch.
OK, I will change all KScratch to KSave.

Huacai
>
> Also, reading the manual it's only guaranteed that at least 1 SAVE
> register is available, and we're not checking CSR.PRCFG1.SAVENum for
> number of implemented SAVE registers.
>
> Having said that, the only LoongArch implementation does have this
> register, and future models would require adaptation to work after all,
> so keeping as-is is somewhat okay.
>
> (No further comments below.)
>
> > +     /* GPR21 used for percpu base (runtime), initialized as 0 */
> > +     or              u0, zero, zero
> > +
> > +     la              tp, init_thread_union
> > +     /* Set the SP after an empty pt_regs.  */
> > +     PTR_LI          sp, (_THREAD_SIZE - 32 - PT_SIZE)
> > +     PTR_ADD         sp, sp, tp
> > +     set_saved_sp    sp, t0, t1
> > +     PTR_ADDI        sp, sp, -4 * SZREG      # init stack pointer
> > +
> > +     bl              start_kernel
> > +
> > +SYM_CODE_END(kernel_entry)
> > +
> > +SYM_ENTRY(kernel_entry_end, SYM_L_GLOBAL, SYM_A_NONE)
> (rest of patch snipped)
