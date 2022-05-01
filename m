Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87A45168E1
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 01:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356037AbiEAXkR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 19:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEAXkQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 19:40:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1012FFCC;
        Sun,  1 May 2022 16:36:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2EA6B81022;
        Sun,  1 May 2022 23:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63731C385AF;
        Sun,  1 May 2022 23:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651448205;
        bh=FD/MvOjXOJMs+WIZQ9APVh6aG7JtQtTqmWf9h4niJg8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JAsLq6Hx8J8K8vOqtLVC/h3u3dlUoeK+njg6ySIumCc4+jSjcsYcs7E23NdSrLmmR
         tXc0LW4TkpPgnw8AOFhZboVEwd0oRz17xukziedf5zRNQhmHNoQMiEEzP9XLbqevaz
         sisTmXBwgzXDfGkwHYR4tEsXrMigq5ajIqMm2v6t5LScXqvGKUOvFtYQFn8da/OOzs
         JZBsObsNlvNg1x7nFHFFliygc5r84mWr5bYFThpjeAJsweHc0gskxhRd5sFLQe4EML
         IsNH4S7yz9JoFqgpnF+wu0qXOzZJkZa9IuPxyX3LTtqFcJoMfoPiiai1aHQUKv1JSQ
         WfoIq+MWt7H2A==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-deb9295679so13011155fac.6;
        Sun, 01 May 2022 16:36:45 -0700 (PDT)
X-Gm-Message-State: AOAM530pYOsR1NyyBoe/0BcQah7oTqrOWd3uvhEZHZ1Dcjx5B+DjsebH
        3jMceUtrxuUVlydVbMP3y7jg1m3Kd6KLa92kvJI=
X-Google-Smtp-Source: ABdhPJznWtXmzauXS7/suSWFgKiTmOIf+WRaWBBayiplHWpaWQypVHFnSlzT8EZ9Lk4kAb7aViqoEu/ZCNofYPJT97E=
X-Received: by 2002:a05:6870:b4a4:b0:e9:4fdc:8ce with SMTP id
 y36-20020a056870b4a400b000e94fdc08cemr3746626oap.126.1651448204328; Sun, 01
 May 2022 16:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-22-chenhuacai@loongson.cn> <CAK8P3a0LwJ3mMQMFkxGxr+umCMM3dKGRnLF+dMCmD5j43hq2sA@mail.gmail.com>
In-Reply-To: <CAK8P3a0LwJ3mMQMFkxGxr+umCMM3dKGRnLF+dMCmD5j43hq2sA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 May 2022 01:36:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFTBpHSZ-Cvhs064nUudx2dWPfWN99Ectr9qA5KgLRngw@mail.gmail.com>
Message-ID: <CAMj1kXFTBpHSZ-Cvhs064nUudx2dWPfWN99Ectr9qA5KgLRngw@mail.gmail.com>
Subject: Re: [PATCH V9 21/24] LoongArch: Add zboot (compressed kernel) support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
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
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-efi <linux-efi@vger.kernel.org>
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

On Sat, 30 Apr 2022 at 13:07, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > This patch adds zboot (self-extracting compressed kernel) support, all
> > existing in-kernel compressing algorithm and efistub are supported.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> I have no objections to adding a decompressor in principle, and
> the implementation seems reasonable. However, I think we should try to
> be consistent between architectures. On both arm64 and riscv, the
> maintainers decided to not include a decompressor and instead leave
> it up to the boot loader to decompress the kernel and enter it from there.
>

The reason we don't want to add more decompressors is because it
forces us to do a bare-metal boot twice, i.e., create an ID map,
discover memory, etc etc.
If I am reading this patch correctly, the kernel image is just
decompressed to VMLINUX_LOAD_ADDRESS, regardless of what EFI thinks
that memory is being used for. That kind of misses the point of
booting with EFI.

> As I understand it, this is not part of the UEFI boot flow though, so it
> means that you don't get any compressed kernel images at all when
> booting using UEFI (let me know if that is wrong). I assume this is why
> you decided to include the decompressor here after all.
>

The PE/COFF executable format does not support compression, and so EFI
does not support this natively. Currently, it is left to the
bootloader to figure out whether the image is compressed or not, and
perform the decompression before calling the EFI entrypoint if needed.
This is what GRUB and systemd-boot do today (on non-x86)

I had a stab at doing something similar in EFI, but relying only on
the generic EFI boot services. The advantage of EFI is that you enter
a main() function in C with MMU and caches on, with a memory map, heap
allocator, etc available.

Code for arm64 is here:
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-decompressor

> I think we should first aim for consistency here, and handle this the
> same way across the modern architectures, either leaving the
> decompressor code out, or adding it consistently. Maybe it would
> even be possible to have the decompressor code as part of the
> EFI stub and share it between the three architectures (x86 and
> 32-bit arm already support loading compressed kernels using EFI).
>

Indeed. One disadvantage of my approach is that both the inner and
outer EFI executables need to be signed for secure boot, as it uses
the EFI boot services. But that is the point, really. The firmware
already knows how to load and start images, so better to make use of
it.


> Adding the arm64, risc-v and uefi maintainers for further discussion here,
> see full below.
>
>        Arnd
>
> > ---
> >  arch/loongarch/Kbuild                         |   2 +-
> >  arch/loongarch/Kconfig                        |  11 ++
> >  arch/loongarch/Makefile                       |  26 ++-
> >  arch/loongarch/boot/Makefile                  |  55 ++++++
> >  arch/loongarch/boot/boot.lds.S                |  64 +++++++
> >  arch/loongarch/boot/decompress.c              |  98 +++++++++++
> >  arch/loongarch/boot/string.c                  | 166 ++++++++++++++++++
> >  arch/loongarch/boot/zheader.S                 | 100 +++++++++++
> >  arch/loongarch/boot/zkernel.S                 |  99 +++++++++++
> >  arch/loongarch/tools/Makefile                 |  15 ++
> >  arch/loongarch/tools/calc_vmlinuz_load_addr.c |  51 ++++++
> >  arch/loongarch/tools/elf-entry.c              |  66 +++++++
> >  12 files changed, 749 insertions(+), 4 deletions(-)
> >  create mode 100644 arch/loongarch/boot/boot.lds.S
> >  create mode 100644 arch/loongarch/boot/decompress.c
> >  create mode 100644 arch/loongarch/boot/string.c
> >  create mode 100644 arch/loongarch/boot/zheader.S
> >  create mode 100644 arch/loongarch/boot/zkernel.S
> >  create mode 100644 arch/loongarch/tools/Makefile
> >  create mode 100644 arch/loongarch/tools/calc_vmlinuz_load_addr.c
> >  create mode 100644 arch/loongarch/tools/elf-entry.c
> >
> > diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
> > index ab5373d0a24f..d907fdd7ca08 100644
> > --- a/arch/loongarch/Kbuild
> > +++ b/arch/loongarch/Kbuild
> > @@ -3,4 +3,4 @@ obj-y += mm/
> >  obj-y += vdso/
> >
> >  # for cleaning
> > -subdir- += boot
> > +subdir- += boot tools
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 55225ee5f868..6c1042746b2d 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -107,6 +107,7 @@ config LOONGARCH
> >         select PERF_USE_VMALLOC
> >         select RTC_LIB
> >         select SPARSE_IRQ
> > +       select SYS_SUPPORTS_ZBOOT
> >         select SYSCTL_EXCEPTION_TRACE
> >         select SWIOTLB
> >         select TRACE_IRQFLAGS_SUPPORT
> > @@ -143,6 +144,16 @@ config LOCKDEP_SUPPORT
> >         bool
> >         default y
> >
> > +config SYS_SUPPORTS_ZBOOT
> > +       bool
> > +       select HAVE_KERNEL_GZIP
> > +       select HAVE_KERNEL_BZIP2
> > +       select HAVE_KERNEL_LZ4
> > +       select HAVE_KERNEL_LZMA
> > +       select HAVE_KERNEL_LZO
> > +       select HAVE_KERNEL_XZ
> > +       select HAVE_KERNEL_ZSTD
> > +
> >  config MACH_LOONGSON32
> >         def_bool 32BIT
> >
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index d88a792dafbe..1ed5b8466565 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -5,12 +5,31 @@
> >
> >  boot   := arch/loongarch/boot
> >
> > +ifndef CONFIG_SYS_SUPPORTS_ZBOOT
> > +
> >  ifndef CONFIG_EFI_STUB
> >  KBUILD_IMAGE   = $(boot)/vmlinux
> >  else
> >  KBUILD_IMAGE   = $(boot)/vmlinux.efi
> >  endif
> >
> > +else
> > +
> > +ifndef CONFIG_EFI_STUB
> > +KBUILD_IMAGE   = $(boot)/vmlinuz
> > +else
> > +KBUILD_IMAGE   = $(boot)/vmlinuz.efi
> > +endif
> > +
> > +endif
> > +
> > +load-y         = 0x9000000000200000
> > +bootvars-y     = VMLINUX_LOAD_ADDRESS=$(load-y)
> > +
> > +archscripts: scripts_basic
> > +       $(Q)$(MAKE) $(build)=arch/loongarch/tools elf-entry
> > +       $(Q)$(MAKE) $(build)=arch/loongarch/tools calc_vmlinuz_load_addr
> > +
> >  #
> >  # Select the object file format to substitute into the linker script.
> >  #
> > @@ -55,9 +74,6 @@ KBUILD_CFLAGS_MODULE          += -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
> >  cflags-y += -ffreestanding
> >  cflags-y += $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
> >
> > -load-y         = 0x9000000000200000
> > -bootvars-y     = VMLINUX_LOAD_ADDRESS=$(load-y)
> > -
> >  drivers-$(CONFIG_PCI)          += arch/loongarch/pci/
> >
> >  KBUILD_AFLAGS  += $(cflags-y)
> > @@ -99,7 +115,11 @@ $(KBUILD_IMAGE): vmlinux
> >         $(Q)$(MAKE) $(build)=$(boot) $(bootvars-y) $@
> >
> >  install:
> > +ifndef CONFIG_SYS_SUPPORTS_ZBOOT
> >         $(Q)install -D -m 755 $(KBUILD_IMAGE) $(INSTALL_PATH)/vmlinux-$(KERNELRELEASE)
> > +else
> > +       $(Q)install -D -m 755 $(KBUILD_IMAGE) $(INSTALL_PATH)/vmlinuz-$(KERNELRELEASE)
> > +endif
> >         $(Q)install -D -m 644 .config $(INSTALL_PATH)/config-$(KERNELRELEASE)
> >         $(Q)install -D -m 644 System.map $(INSTALL_PATH)/System.map-$(KERNELRELEASE)
> >
> > diff --git a/arch/loongarch/boot/Makefile b/arch/loongarch/boot/Makefile
> > index 66f2293c34b2..c26a36004ae2 100644
> > --- a/arch/loongarch/boot/Makefile
> > +++ b/arch/loongarch/boot/Makefile
> > @@ -21,3 +21,58 @@ quiet_cmd_eficopy = OBJCOPY $@
> >
> >  $(obj)/vmlinux.efi: $(obj)/vmlinux FORCE
> >         $(call if_changed,eficopy)
> > +
> > +# zboot
> > +extra-y        += boot.lds
> > +$(obj)/boot.lds: $(obj)/vmlinux.bin FORCE
> > +CPPFLAGS_boot.lds = $(KBUILD_CPPFLAGS) -DVMLINUZ_LOAD_ADDRESS=$(zload-y)
> > +
> > +entry-y        = $(shell $(objtree)/arch/loongarch/tools/elf-entry $(obj)/vmlinux)
> > +zload-y = $(shell $(objtree)/arch/loongarch/tools/calc_vmlinuz_load_addr \
> > +                               $(obj)/vmlinux.bin $(VMLINUX_LOAD_ADDRESS))
> > +
> > +BOOT_HEAP_SIZE := 0x400000
> > +BOOT_STACK_SIZE        := 0x002000
> > +
> > +KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
> > +       -DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
> > +       -DBOOT_STACK_SIZE=$(BOOT_STACK_SIZE)
> > +
> > +KBUILD_CFLAGS := $(KBUILD_CFLAGS) -fpic -D__KERNEL__ \
> > +       -DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
> > +       -DBOOT_STACK_SIZE=$(BOOT_STACK_SIZE)
> > +
> > +targets += vmlinux.bin
> > +OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary $(strip-flags)
> > +$(obj)/vmlinux.bin: $(obj)/vmlinux FORCE
> > +       $(call if_changed,objcopy)
> > +
> > +tool_$(CONFIG_KERNEL_GZIP)    = gzip
> > +tool_$(CONFIG_KERNEL_BZIP2)   = bzip2_with_size
> > +tool_$(CONFIG_KERNEL_LZ4)     = lz4_with_size
> > +tool_$(CONFIG_KERNEL_LZMA)    = lzma_with_size
> > +tool_$(CONFIG_KERNEL_LZO)     = lzo_with_size
> > +tool_$(CONFIG_KERNEL_XZ)      = xzkern_with_size
> > +tool_$(CONFIG_KERNEL_ZSTD)    = zstd22_with_size
> > +
> > +targets += vmlinux.bin.z
> > +$(obj)/vmlinux.bin.z: $(obj)/vmlinux.bin FORCE
> > +       $(call if_changed,$(tool_y))
> > +
> > +targets += $(notdir $(vmlinuzobjs-y))
> > +vmlinuzobjs-y := $(obj)/zkernel.o $(obj)/decompress.o $(obj)/string.o
> > +vmlinuzobjs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> > +$(obj)/zkernel.o: $(obj)/vmlinux.bin.z
> > +AFLAGS_zkernel.o = $(KBUILD_AFLAGS) -DVMLINUZ_LOAD_ADDRESS=$(zload-y) -DKERNEL_ENTRY=$(entry-y)
> > +
> > +quiet_cmd_zld = LD      $@
> > +      cmd_zld = $(LD) $(KBUILD_LDFLAGS) -T $< $(vmlinuzobjs-y) -o $@
> > +
> > +targets += vmlinuz
> > +$(obj)/vmlinuz: $(src)/boot.lds $(vmlinuzobjs-y) FORCE
> > +       $(call if_changed,zld)
> > +       $(call if_changed,strip)
> > +
> > +targets += vmlinuz.efi
> > +$(obj)/vmlinuz.efi: $(obj)/vmlinuz FORCE
> > +       $(call if_changed,eficopy)
> > diff --git a/arch/loongarch/boot/boot.lds.S b/arch/loongarch/boot/boot.lds.S
> > new file mode 100644
> > index 000000000000..23e698782afd
> > --- /dev/null
> > +++ b/arch/loongarch/boot/boot.lds.S
> > @@ -0,0 +1,64 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * ld.script for compressed kernel support of LoongArch
> > + *
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include "../kernel/image-vars.h"
> > +
> > +/*
> > + * Max avaliable Page Size is 64K, so we set SectionAlignment
> > + * field of EFI application to 64K.
> > + */
> > +PECOFF_FILE_ALIGN = 0x200;
> > +PECOFF_SEGMENT_ALIGN = 0x10000;
> > +
> > +OUTPUT_ARCH(loongarch)
> > +ENTRY(kernel_entry)
> > +PHDRS {
> > +       text PT_LOAD FLAGS(7); /* RWX */
> > +}
> > +SECTIONS
> > +{
> > +       . = VMLINUZ_LOAD_ADDRESS;
> > +
> > +       _text = .;
> > +       .head.text : {
> > +               *(.head.text)
> > +       }
> > +
> > +       .text : {
> > +               *(.text)
> > +               *(.init.text)
> > +               *(.rodata)
> > +       }: text
> > +
> > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > +       _data = .;
> > +       .data : {
> > +               *(.data)
> > +               *(.init.data)
> > +               /* Put the compressed image here */
> > +               __image_begin = .;
> > +               *(.image)
> > +               __image_end = .;
> > +               CONSTRUCTORS
> > +               . = ALIGN(PECOFF_FILE_ALIGN);
> > +       }
> > +       _edata = .;
> > +
> > +       .bss : {
> > +               *(.bss)
> > +               *(.init.bss)
> > +       }
> > +       . = ALIGN(PECOFF_SEGMENT_ALIGN);
> > +       _end = .;
> > +
> > +       /DISCARD/ : {
> > +               *(.options)
> > +               *(.comment)
> > +               *(.note)
> > +       }
> > +}
> > diff --git a/arch/loongarch/boot/decompress.c b/arch/loongarch/boot/decompress.c
> > new file mode 100644
> > index 000000000000..8f55fcd8f285
> > --- /dev/null
> > +++ b/arch/loongarch/boot/decompress.c
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/kernel.h>
> > +#include <linux/string.h>
> > +#include <linux/libfdt.h>
> > +
> > +#include <asm/addrspace.h>
> > +
> > +/*
> > + * These two variables specify the free mem region
> > + * that can be used for temporary malloc area
> > + */
> > +unsigned long free_mem_ptr;
> > +unsigned long free_mem_end_ptr;
> > +
> > +/* The linker tells us where the image is. */
> > +extern unsigned char __image_begin, __image_end;
> > +
> > +#define puts(s) do {} while (0)
> > +#define puthex(val) do {} while (0)
> > +
> > +void error(char *x)
> > +{
> > +       puts("\n\n");
> > +       puts(x);
> > +       puts("\n\n -- System halted");
> > +
> > +       while (1)
> > +               ;       /* Halt */
> > +}
> > +
> > +/* activate the code for pre-boot environment */
> > +#define STATIC static
> > +
> > +#include "../../../../lib/ashldi3.c"
> > +
> > +#ifdef CONFIG_KERNEL_GZIP
> > +#include "../../../../lib/decompress_inflate.c"
> > +#endif
> > +
> > +#ifdef CONFIG_KERNEL_BZIP2
> > +#include "../../../../lib/decompress_bunzip2.c"
> > +#endif
> > +
> > +#ifdef CONFIG_KERNEL_LZ4
> > +#include "../../../../lib/decompress_unlz4.c"
> > +#endif
> > +
> > +#ifdef CONFIG_KERNEL_LZMA
> > +#include "../../../../lib/decompress_unlzma.c"
> > +#endif
> > +
> > +#ifdef CONFIG_KERNEL_LZO
> > +#include "../../../../lib/decompress_unlzo.c"
> > +#endif
> > +
> > +#ifdef CONFIG_KERNEL_XZ
> > +#include "../../../../lib/decompress_unxz.c"
> > +#endif
> > +
> > +#ifdef CONFIG_KERNEL_ZSTD
> > +#include "../../../../lib/decompress_unzstd.c"
> > +#endif
> > +
> > +void decompress_kernel(unsigned long boot_heap_start)
> > +{
> > +       unsigned long zimage_start, zimage_size;
> > +
> > +       zimage_start = (unsigned long)(&__image_begin);
> > +       zimage_size = (unsigned long)(&__image_end) -
> > +           (unsigned long)(&__image_begin);
> > +
> > +       puts("zimage at:     ");
> > +       puthex(zimage_start);
> > +       puts(" ");
> > +       puthex(zimage_size + zimage_start);
> > +       puts("\n");
> > +
> > +       /* This area are prepared for mallocing when decompressing */
> > +       free_mem_ptr = boot_heap_start;
> > +       free_mem_end_ptr = boot_heap_start + BOOT_HEAP_SIZE;
> > +
> > +       /* Display standard Linux/LoongArch boot prompt */
> > +       puts("Uncompressing Linux at load address ");
> > +       puthex(VMLINUX_LOAD_ADDRESS);
> > +       puts("\n");
> > +
> > +       /* Decompress the kernel with according algorithm */
> > +       __decompress((char *)zimage_start, zimage_size, 0, 0,
> > +                  (void *)VMLINUX_LOAD_ADDRESS, 0, 0, error);
> > +
> > +       puts("Now, booting the kernel...\n");
> > +}
> > diff --git a/arch/loongarch/boot/string.c b/arch/loongarch/boot/string.c
> > new file mode 100644
> > index 000000000000..3f746e7c2bb5
> > --- /dev/null
> > +++ b/arch/loongarch/boot/string.c
> > @@ -0,0 +1,166 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * arch/loongarch/boot/string.c
> > + *
> > + * Very small subset of simple string routines
> > + */
> > +
> > +#include <linux/types.h>
> > +
> > +void __weak *memset(void *s, int c, size_t n)
> > +{
> > +       int i;
> > +       char *ss = s;
> > +
> > +       for (i = 0; i < n; i++)
> > +               ss[i] = c;
> > +       return s;
> > +}
> > +
> > +void __weak *memcpy(void *dest, const void *src, size_t n)
> > +{
> > +       int i;
> > +       const char *s = src;
> > +       char *d = dest;
> > +
> > +       for (i = 0; i < n; i++)
> > +               d[i] = s[i];
> > +       return dest;
> > +}
> > +
> > +void __weak *memmove(void *dest, const void *src, size_t n)
> > +{
> > +       int i;
> > +       const char *s = src;
> > +       char *d = dest;
> > +
> > +       if (d < s) {
> > +               for (i = 0; i < n; i++)
> > +                       d[i] = s[i];
> > +       } else if (d > s) {
> > +               for (i = n - 1; i >= 0; i--)
> > +                       d[i] = s[i];
> > +       }
> > +
> > +       return dest;
> > +}
> > +
> > +int __weak memcmp(const void *cs, const void *ct, size_t count)
> > +{
> > +       int res = 0;
> > +       const unsigned char *su1, *su2;
> > +
> > +       for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--) {
> > +               res = *su1 - *su2;
> > +               if (res != 0)
> > +                       break;
> > +       }
> > +       return res;
> > +}
> > +
> > +int __weak strcmp(const char *str1, const char *str2)
> > +{
> > +       int delta = 0;
> > +       const unsigned char *s1 = (const unsigned char *)str1;
> > +       const unsigned char *s2 = (const unsigned char *)str2;
> > +
> > +       while (*s1 || *s2) {
> > +               delta = *s1 - *s2;
> > +               if (delta)
> > +                       return delta;
> > +               s1++;
> > +               s2++;
> > +       }
> > +       return 0;
> > +}
> > +
> > +size_t __weak strlen(const char *s)
> > +{
> > +       const char *sc;
> > +
> > +       for (sc = s; *sc != '\0'; ++sc)
> > +               /* nothing */;
> > +       return sc - s;
> > +}
> > +
> > +size_t __weak strnlen(const char *s, size_t count)
> > +{
> > +       const char *sc;
> > +
> > +       for (sc = s; count-- && *sc != '\0'; ++sc)
> > +               /* nothing */;
> > +       return sc - s;
> > +}
> > +
> > +char * __weak strnstr(const char *s1, const char *s2, size_t len)
> > +{
> > +       size_t l2;
> > +
> > +       l2 = strlen(s2);
> > +       if (!l2)
> > +               return (char *)s1;
> > +       while (len >= l2) {
> > +               len--;
> > +               if (!memcmp(s1, s2, l2))
> > +                       return (char *)s1;
> > +               s1++;
> > +       }
> > +       return NULL;
> > +}
> > +
> > +#undef strcat
> > +char * __weak strcat(char *dest, const char *src)
> > +{
> > +       char *tmp = dest;
> > +
> > +       while (*dest)
> > +               dest++;
> > +       while ((*dest++ = *src++) != '\0')
> > +               ;
> > +       return tmp;
> > +}
> > +
> > +char * __weak strncat(char *dest, const char *src, size_t count)
> > +{
> > +       char *tmp = dest;
> > +
> > +       if (count) {
> > +               while (*dest)
> > +                       dest++;
> > +               while ((*dest++ = *src++) != 0) {
> > +                       if (--count == 0) {
> > +                               *dest = '\0';
> > +                               break;
> > +                       }
> > +               }
> > +       }
> > +       return tmp;
> > +}
> > +
> > +char * __weak strpbrk(const char *cs, const char *ct)
> > +{
> > +       const char *sc1, *sc2;
> > +
> > +       for (sc1 = cs; *sc1 != '\0'; ++sc1) {
> > +               for (sc2 = ct; *sc2 != '\0'; ++sc2) {
> > +                       if (*sc1 == *sc2)
> > +                               return (char *)sc1;
> > +               }
> > +       }
> > +       return NULL;
> > +}
> > +
> > +char * __weak strsep(char **s, const char *ct)
> > +{
> > +       char *sbegin = *s;
> > +       char *end;
> > +
> > +       if (sbegin == NULL)
> > +               return NULL;
> > +
> > +       end = strpbrk(sbegin, ct);
> > +       if (end)
> > +               *end++ = '\0';
> > +       *s = end;
> > +       return sbegin;
> > +}
> > diff --git a/arch/loongarch/boot/zheader.S b/arch/loongarch/boot/zheader.S
> > new file mode 100644
> > index 000000000000..4bc50d953ec7
> > --- /dev/null
> > +++ b/arch/loongarch/boot/zheader.S
> > @@ -0,0 +1,100 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/pe.h>
> > +#include <linux/sizes.h>
> > +
> > +       .macro  __EFI_PE_HEADER
> > +       .long   PE_MAGIC
> > +coff_header:
> > +       .short  IMAGE_FILE_MACHINE_LOONGARCH            /* Machine */
> > +       .short  section_count                           /* NumberOfSections */
> > +       .long   0                                       /* TimeDateStamp */
> > +       .long   0                                       /* PointerToSymbolTable */
> > +       .long   0                                       /* NumberOfSymbols */
> > +       .short  section_table - optional_header         /* SizeOfOptionalHeader */
> > +       .short  IMAGE_FILE_DEBUG_STRIPPED | \
> > +               IMAGE_FILE_EXECUTABLE_IMAGE | \
> > +               IMAGE_FILE_LINE_NUMS_STRIPPED           /* Characteristics */
> > +
> > +optional_header:
> > +       .short  PE_OPT_MAGIC_PE32PLUS                   /* PE32+ format */
> > +       .byte   0x02                                    /* MajorLinkerVersion */
> > +       .byte   0x14                                    /* MinorLinkerVersion */
> > +       .long   _data - efi_header_end                  /* SizeOfCode */
> > +       .long   _end - _data                            /* SizeOfInitializedData */
> > +       .long   0                                       /* SizeOfUninitializedData */
> > +       .long   __efistub_efi_pe_entry - _head          /* AddressOfEntryPoint */
> > +       .long   efi_header_end - _head                  /* BaseOfCode */
> > +
> > +extra_header_fields:
> > +       .quad   0                                       /* ImageBase */
> > +       .long   PECOFF_SEGMENT_ALIGN                    /* SectionAlignment */
> > +       .long   PECOFF_FILE_ALIGN                       /* FileAlignment */
> > +       .short  0                                       /* MajorOperatingSystemVersion */
> > +       .short  0                                       /* MinorOperatingSystemVersion */
> > +       .short  0                                       /* MajorImageVersion */
> > +       .short  0                                       /* MinorImageVersion */
> > +       .short  0                                       /* MajorSubsystemVersion */
> > +       .short  0                                       /* MinorSubsystemVersion */
> > +       .long   0                                       /* Win32VersionValue */
> > +
> > +       .long   _end - _head                            /* SizeOfImage */
> > +
> > +       /* Everything before the kernel image is considered part of the header */
> > +       .long   efi_header_end - _head                  /* SizeOfHeaders */
> > +       .long   0                                       /* CheckSum */
> > +       .short  IMAGE_SUBSYSTEM_EFI_APPLICATION         /* Subsystem */
> > +       .short  0                                       /* DllCharacteristics */
> > +       .quad   0                                       /* SizeOfStackReserve */
> > +       .quad   0                                       /* SizeOfStackCommit */
> > +       .quad   0                                       /* SizeOfHeapReserve */
> > +       .quad   0                                       /* SizeOfHeapCommit */
> > +       .long   0                                       /* LoaderFlags */
> > +       .long   (section_table - .) / 8                 /* NumberOfRvaAndSizes */
> > +
> > +       .quad   0                                       /* ExportTable */
> > +       .quad   0                                       /* ImportTable */
> > +       .quad   0                                       /* ResourceTable */
> > +       .quad   0                                       /* ExceptionTable */
> > +       .quad   0                                       /* CertificationTable */
> > +       .quad   0                                       /* BaseRelocationTable */
> > +
> > +       /* Section table */
> > +section_table:
> > +       .ascii  ".text\0\0\0"
> > +       .long   _data - efi_header_end                  /* VirtualSize */
> > +       .long   efi_header_end - _head                  /* VirtualAddress */
> > +       .long   _data - efi_header_end                  /* SizeOfRawData */
> > +       .long   efi_header_end - _head                  /* PointerToRawData */
> > +
> > +       .long   0                                       /* PointerToRelocations */
> > +       .long   0                                       /* PointerToLineNumbers */
> > +       .short  0                                       /* NumberOfRelocations */
> > +       .short  0                                       /* NumberOfLineNumbers */
> > +       .long   IMAGE_SCN_CNT_CODE | \
> > +               IMAGE_SCN_MEM_READ | \
> > +               IMAGE_SCN_MEM_EXECUTE                   /* Characteristics */
> > +
> > +       .ascii  ".data\0\0\0"
> > +       .long   _end - _data                            /* VirtualSize */
> > +       .long   _data - _head                           /* VirtualAddress */
> > +       .long   _edata - _data                          /* SizeOfRawData */
> > +       .long   _data - _head                           /* PointerToRawData */
> > +
> > +       .long   0                                       /* PointerToRelocations */
> > +       .long   0                                       /* PointerToLineNumbers */
> > +       .short  0                                       /* NumberOfRelocations */
> > +       .short  0                                       /* NumberOfLineNumbers */
> > +       .long   IMAGE_SCN_CNT_INITIALIZED_DATA | \
> > +               IMAGE_SCN_MEM_READ | \
> > +               IMAGE_SCN_MEM_WRITE                     /* Characteristics */
> > +
> > +       .org 0x20e
> > +       .word kernel_version - 512 -  _head
> > +
> > +       .set    section_count, (. - section_table) / 40
> > +efi_header_end:
> > +       .endm
> > diff --git a/arch/loongarch/boot/zkernel.S b/arch/loongarch/boot/zkernel.S
> > new file mode 100644
> > index 000000000000..13a8a14a2328
> > --- /dev/null
> > +++ b/arch/loongarch/boot/zkernel.S
> > @@ -0,0 +1,99 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/linkage.h>
> > +#include <asm/addrspace.h>
> > +#include <asm/asm.h>
> > +#include <asm/loongarch.h>
> > +#include <asm/regdef.h>
> > +#include <generated/compile.h>
> > +#include <generated/utsrelease.h>
> > +
> > +#ifdef CONFIG_EFI_STUB
> > +
> > +#include "zheader.S"
> > +
> > +       __HEAD
> > +
> > +_head:
> > +       /* "MZ", MS-DOS header */
> > +       .word   MZ_MAGIC
> > +       .org    0x28
> > +       .ascii  "Loongson\0"
> > +       .org    0x3c
> > +       /* Offset to the PE header */
> > +       .long   pe_header - _head
> > +
> > +pe_header:
> > +       __EFI_PE_HEADER
> > +
> > +kernel_asize:
> > +       .long _end - _text
> > +
> > +kernel_fsize:
> > +       .long _edata - _text
> > +
> > +kernel_vaddr:
> > +       .quad VMLINUZ_LOAD_ADDRESS
> > +
> > +kernel_offset:
> > +       .long kernel_offset - _text
> > +
> > +kernel_version:
> > +       .ascii  UTS_RELEASE " (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") " UTS_VERSION "\0"
> > +
> > +SYM_L_GLOBAL(kernel_asize)
> > +SYM_L_GLOBAL(kernel_fsize)
> > +SYM_L_GLOBAL(kernel_vaddr)
> > +SYM_L_GLOBAL(kernel_offset)
> > +
> > +#endif
> > +
> > +       __INIT
> > +
> > +SYM_CODE_START(kernel_entry)
> > +       /* Save boot rom start args */
> > +       move    s0, a0
> > +       move    s1, a1
> > +       move    s2, a2
> > +       move    s3, a3
> > +
> > +       /* Config Direct Mapping */
> > +       li.d    t0, CSR_DMW0_INIT
> > +       csrwr   t0, LOONGARCH_CSR_DMWIN0
> > +       li.d    t0, CSR_DMW1_INIT
> > +       csrwr   t0, LOONGARCH_CSR_DMWIN1
> > +
> > +       /* Clear BSS */
> > +       la.abs  a0, _edata
> > +       la.abs  a2, _end
> > +1:     st.d    zero, a0, 0
> > +       addi.d  a0, a0, 8
> > +       bne     a2, a0, 1b
> > +
> > +       la.abs  a0, .heap          /* heap address */
> > +       la.abs  sp, .stack + 8192  /* stack address */
> > +
> > +       la      ra, 2f
> > +       la      t4, decompress_kernel
> > +       jirl    zero, t4, 0
> > +2:
> > +       move    a0, s0
> > +       move    a1, s1
> > +       move    a2, s2
> > +       move    a3, s3
> > +       PTR_LI  t4, KERNEL_ENTRY
> > +       jirl    zero, t4, 0
> > +3:
> > +       b       3b
> > +SYM_CODE_END(kernel_entry)
> > +
> > +       .comm .heap, BOOT_HEAP_SIZE, 4
> > +       .comm .stack, BOOT_STACK_SIZE, 4
> > +
> > +       .align 4
> > +       .section .image, "a", %progbits
> > +       .incbin "arch/loongarch/boot/vmlinux.bin.z"
> > diff --git a/arch/loongarch/tools/Makefile b/arch/loongarch/tools/Makefile
> > new file mode 100644
> > index 000000000000..8a6181c82a91
> > --- /dev/null
> > +++ b/arch/loongarch/tools/Makefile
> > @@ -0,0 +1,15 @@
> > +#
> > +# arch/loongarch/boot/Makefile
> > +#
> > +# Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > +#
> > +
> > +hostprogs := elf-entry
> > +PHONY += elf-entry
> > +elf-entry: $(obj)/elf-entry
> > +       @:
> > +
> > +hostprogs += calc_vmlinuz_load_addr
> > +PHONY += calc_vmlinuz_load_addr
> > +calc_vmlinuz_load_addr: $(obj)/calc_vmlinuz_load_addr
> > +       @:
> > diff --git a/arch/loongarch/tools/calc_vmlinuz_load_addr.c b/arch/loongarch/tools/calc_vmlinuz_load_addr.c
> > new file mode 100644
> > index 000000000000..5e2ca6b4dff6
> > --- /dev/null
> > +++ b/arch/loongarch/tools/calc_vmlinuz_load_addr.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <errno.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/stat.h>
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       unsigned long long vmlinux_size, vmlinux_load_addr, vmlinuz_load_addr;
> > +       struct stat sb;
> > +
> > +       if (argc != 3) {
> > +               fprintf(stderr, "Usage: %s <pathname> <vmlinux_load_addr>\n", argv[0]);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       if (stat(argv[1], &sb) == -1) {
> > +               perror("stat");
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       /* Convert hex characters to dec number */
> > +       errno = 0;
> > +       if (sscanf(argv[2], "%llx", &vmlinux_load_addr) != 1) {
> > +               if (errno != 0)
> > +                       perror("sscanf");
> > +               else
> > +                       fprintf(stderr, "No matching characters\n");
> > +
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       vmlinux_size = (uint64_t)sb.st_size;
> > +       vmlinuz_load_addr = vmlinux_load_addr + vmlinux_size;
> > +
> > +       /*
> > +        * Align with 64KB: KEXEC needs load sections to be aligned to PAGE_SIZE,
> > +        * which may be as large as 64KB depending on the kernel configuration.
> > +        */
> > +
> > +       vmlinuz_load_addr += (0x10000 - vmlinux_size % 0x10000);
> > +
> > +       printf("0x%llx\n", vmlinuz_load_addr);
> > +
> > +       return EXIT_SUCCESS;
> > +}
> > diff --git a/arch/loongarch/tools/elf-entry.c b/arch/loongarch/tools/elf-entry.c
> > new file mode 100644
> > index 000000000000..c80721e0dee1
> > --- /dev/null
> > +++ b/arch/loongarch/tools/elf-entry.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <elf.h>
> > +#include <inttypes.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +
> > +__attribute__((noreturn))
> > +static void die(const char *msg)
> > +{
> > +       fputs(msg, stderr);
> > +       exit(EXIT_FAILURE);
> > +}
> > +
> > +int main(int argc, const char *argv[])
> > +{
> > +       uint64_t entry;
> > +       size_t nread;
> > +       FILE *file;
> > +       union {
> > +               Elf32_Ehdr ehdr32;
> > +               Elf64_Ehdr ehdr64;
> > +       } hdr;
> > +
> > +       if (argc != 2)
> > +               die("Usage: elf-entry <elf-file>\n");
> > +
> > +       file = fopen(argv[1], "r");
> > +       if (!file) {
> > +               perror("Unable to open input file");
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       nread = fread(&hdr, 1, sizeof(hdr), file);
> > +       if (nread != sizeof(hdr)) {
> > +               fclose(file);
> > +               perror("Unable to read input file");
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       if (memcmp(hdr.ehdr32.e_ident, ELFMAG, SELFMAG)) {
> > +               fclose(file);
> > +               die("Input is not an ELF\n");
> > +       }
> > +
> > +       switch (hdr.ehdr32.e_ident[EI_CLASS]) {
> > +       case ELFCLASS32:
> > +               /* Sign extend to form a canonical address */
> > +               entry = (int64_t)(int32_t)hdr.ehdr32.e_entry;
> > +               break;
> > +
> > +       case ELFCLASS64:
> > +               entry = hdr.ehdr64.e_entry;
> > +               break;
> > +
> > +       default:
> > +               fclose(file);
> > +               die("Invalid ELF class\n");
> > +       }
> > +
> > +       fclose(file);
> > +       printf("0x%016" PRIx64 "\n", entry);
> > +
> > +       return EXIT_SUCCESS;
> > +}
> > --
> > 2.27.0
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
