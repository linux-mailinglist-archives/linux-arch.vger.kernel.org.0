Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7A3BCA2A
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhGFKit (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:38:49 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40883 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhGFKit (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:38:49 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQusJ-1lnIRq2dFf-00Nwwk for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021
 12:36:09 +0200
Received: by mail-wr1-f53.google.com with SMTP id q17so5097494wrv.2
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:36:09 -0700 (PDT)
X-Gm-Message-State: AOAM531Hu1T6FbobutElsfb6+mCiSE2xqTs/Wb+5XdhRK9ktC3d3X/wj
        TCHYWdNhZKuaDV0v8sNp5v8bx93OHIKrYcL7Tew=
X-Google-Smtp-Source: ABdhPJwzGchqKKDzES9W2MJ46AViuI59XwhpxDqEwbVLg3oVwsT1PB71wt7D5xCUXyBGIk519cq5bYKuCTK9y3qSdyg=
X-Received: by 2002:adf:fd8e:: with SMTP id d14mr21798736wrr.361.1625567769318;
 Tue, 06 Jul 2021 03:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-4-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-4-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:35:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1TTuzpOUELWhmFwo8LNmyt9QT8TVdoRFCisXBt1yr=5g@mail.gmail.com>
Message-ID: <CAK8P3a1TTuzpOUELWhmFwo8LNmyt9QT8TVdoRFCisXBt1yr=5g@mail.gmail.com>
Subject: Re: [PATCH 03/19] LoongArch: Add build infrastructure
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TrtwAoMJrh4J9un8nCNY0+wKBuy8WSgPRJKKUOZKUwpi+G6P8BO
 j/A8SHF9sQlkwkN7x3m9xtHWse/lvbmhj27DyLkskMrNPPaBX3QpyKfyaXRzWU32SRBoo6R
 3OqhSgc/rDDvvv0uLTYVYGGqF4bLx7bI55nth6ozcbp9gnlLAuKaZAV2JCUQu51k6PVDTCi
 Fn8G5mv1cGDI9LopL0TmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V7Lb1SpRuo0=:/DHNpI1xygqyRk9lPNAiuP
 n5uYhL8oKl8UmQvBM+ZXDvVMwSe384gSAoVSvGjHGampj3xYgmjabxlMjGG3RVK5MnRStsznI
 2Fz4hPNlrxXgZqvgH4d1ccB1nZ45/kiRb1ZBhwsmyXRhotyxuKL0P52FJG0GDumCs/RdMcBAu
 Fsp9sFLrYn6OIZbNNGdDSMLO4NVByymUS3OeL0e1fSers2moLOguF7oxohCCwS1hSwpk2T/OJ
 bz0dfyTDHsBQ22SL1MMSgGWqf9oR378xTvonOZRzbUVZIKAJqxBgbdCB3LJRHlSvKiR2r4txl
 h9FaA4FpNQirgnfTDaUyNEEqrme7QmloKpfOzAxEsY21CznEpsIQg3+kUYPD/IZWMq3j3Sn79
 F+F6y+Yyj2L8uN0Gp5eWs7BnHPXyB0jJKIfCMr+8WRDHmUjWlhVH+FswzYe0ynrtkLpTVw7qv
 HMsnFCFHEsbnz/hgJhjujYTYHs9vQfers9pfLI5pRqGy4wta7IwWDKymfv2gBQaJjUjYVHFH1
 Yo/1yOxtqTn5ZaQzhuaiB8E3r8cFzH4LIqzBUa9NUdeCG0p7uKmC3vhEUtNN42P6XQueUiWMA
 bD43Pvjj2q2V3+cawRoBmSV3bf/pN/RlUcvj5uEyRc2JLodY46szvu2ASNBHLhoyI8XusVkDR
 WLMi3z6+UAzufdRWXkXiVv5yh7noRIW/TWR73EwYpMwvgExi6q8jV+hae+hnA3OBZOChgyHUA
 2SmRRi879knDTLSSfdZvWQYms7PzJB8cqOsMOnfnnAYMFJ+84sif5ZEcDxxlAiypA0HWLN5pj
 Hltj0LHmXDYxCEHYhNE4On/mGsi3zFp/fw97103xxSJ8Wfm5/9RJNvYjIXftd+Mzza62WDQpF
 DewbKKlzdx8SmAHmg8pV+x93DkxgiEtfXAnk8L+ss6Gdmxv87klDe2mkru8uJCOpviJ04gXJ5
 cfYW1mCg1lmweYWtP5JrA33Kh1ra2zYPlvTzq/hpE6jWJXcrkBuYl
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> --- /dev/null
> +++ b/arch/loongarch/Kbuild
> @@ -0,0 +1,21 @@
> +# Fail on warnings - also for files referenced in subdirs
> +# -Werror can be disabled for specific files using:
> +# CFLAGS_<file.o> := -Wno-error
> +ifeq ($(W),)
> +subdir-ccflags-y := -Werror
> +endif

This tends to break building with 'make W=12' or similar, I would recommend not
adding -Werror. It is a good idea though to have your CI systems build
with -Werror enabled on the command line though.

> +# platform specific definitions
> +include arch/loongarch/Kbuild.platforms
> +obj-y := $(platform-y)
> +

I would recommend not planning on having platform specific files. The way
we do it on modern platforms (arm64, rv64) is to have all the device drivers
in the driver subsystems instead.

> +       select GENERIC_IOMAP

GENERIC_IOMAP is one of those you probably don't want here. If PCI I/O
space is mapped into MMIO registers, just do what arm64 has and make
ioport_map() return a pointer, then make ioread32() an alias for readl().

> +       select HAVE_CBPF_JIT if !64BIT
> +       select HAVE_EBPF_JIT if 64BIT

These look like you incorrectly copied them from MIPS. I don't see any EBPF_JIT
implemementation (I may have missed that, as I'm still starting), but
you probably
don't want the CBPF version for 32-bit anyway.

> +       select HAVE_IDE

drivers/ide/ was just removed,so this line can go as well.

> +       select VIRT_TO_BUS

Remove this: if you still require a driver that fails to use the dma-mapping
API, fix the driver instead so it can work with IOMMUs.

> +menu "Machine selection"
> +
> +choice
> +       prompt "System type"
> +       default MACH_LOONGSON64
> +
> +config MACH_LOONGSON64
> +       bool "Loongson 64-bit family of machines"

There should generally not be a 'choice' menu to select between
different machine types, but instead the kernel should be able
to run on all platforms that have the same instruction set.

Maybe just make this a silent option and use 'select
MACH_LOONGSON64' so you can pick up the device drivers
that mips uses.

> +       select ARCH_MIGHT_HAVE_PC_PARPORT
> +       select ARCH_MIGHT_HAVE_PC_SERIO
> +       select GENERIC_ISA_DMA
> +       select ISA

Do you actually have ISA-style add-on cards? If not, then
remove the ISA options. If you do, which drivers are they?


> +config CPU_LOONGSON64
> +       bool "Loongson 64-bit CPU"
> +       depends on SYS_HAS_CPU_LOONGSON64
> +       select CPU_SUPPORTS_64BIT_KERNEL
> +       select GPIOLIB
> +       select SWIOTLB
> +       select ARCH_SUPPORTS_ATOMIC_RMW
> +       help
> +         The Loongson 64-bit processor implements the LoongArch64 (the 64-bit
> +         version of LoongArch) instruction set.
> +
> +endchoice
> +
> +config SYS_HAS_CPU_LOONGSON64
> +       bool
> +
> +endmenu
> +
> +config SYS_SUPPORTS_32BIT_KERNEL
> +       bool
> +config SYS_SUPPORTS_64BIT_KERNEL
> +       bool
> +config CPU_SUPPORTS_32BIT_KERNEL
> +       bool
> +config CPU_SUPPORTS_64BIT_KERNEL
> +       bool

Same for the CPUs: I would suggest you keep this simple until you get
to the point of actually having multiple CPUs that you need to distinguish.

Different 64-bit CPUs are hopefully going to be compatible with one
another, so they should not be listed as mutually exclusive in a
'choice' statement. The complexity with two levels of 32/64 support
is probably not going to be helpful here either.

The 'select' statements that you have under CPU_LOONGSON64
ook like they should just be in the top level.

GPIOLIB and SWIOTLB could just be left user selectable, if turning
them off results only in run-time loss of functionality but not a
build failure.

> +menu "Kernel type"
> +
> +choice
> +       prompt "Kernel code model"
> +       help
> +         You should only select this option if you have a workload that
> +         actually benefits from 64-bit processing or if your machine has
> +         large memory.  You will only be presented a single option in this
> +         menu if your system does not support both 32-bit and 64-bit kernels.
> +
> +config 32BIT
> +       bool "32-bit kernel"
> +       depends on CPU_SUPPORTS_32BIT_KERNEL && SYS_SUPPORTS_32BIT_KERNEL
> +       help
> +         Select this option if you want to build a 32-bit kernel.
> +
> +config 64BIT
> +       bool "64-bit kernel"
> +       depends on CPU_SUPPORTS_64BIT_KERNEL && SYS_SUPPORTS_64BIT_KERNEL
> +       help
> +         Select this option if you want to build a 64-bit kernel.
> +
> +endchoice

Since you don't support any 32-bit target at the moment, just make CONFIG_64BIT
a default-on statement, and make it user-selectable only when you add a 32-bit
target.


> +choice
> +       prompt "Kernel page size"
> +       default PAGE_SIZE_16KB
> +
> +config PAGE_SIZE_4KB
> +       bool "4kB"
> +       help
> +         This option select the standard 4kB Linux page size.
> +
> +config PAGE_SIZE_16KB
> +       bool "16kB"
> +       help
> +         This option select the standard 16kB Linux page size.
> +
> +config PAGE_SIZE_64KB
> +       bool "64kB"
> +       help
> +         This option select the standard 64kB Linux page size.
> +
> +endchoice
> +
> +choice
> +       prompt "Virtual memory address space bits"
> +       default VA_BITS_40
> +       help
> +         Allows choosing one of multiple possible virtual memory
> +         address space bits for applications. The level of page
> +         translation table is determined by a combination of page
> +         size and virtual memory address space bits.
> +
> +config VA_BITS_40
> +       bool "40-bits"
> +       depends on 64BIT
> +       help
> +         Support a maximum at least 40 bits of application virtual memory.
> +
> +config VA_BITS_48
> +       bool "48-bits"
> +       depends on 64BIT
> +       help
> +         Support a maximum at least 48 bits of application virtual memory.
> +
> +endchoice

Isn't the size of the address space tied to the page size?

         Arnd
