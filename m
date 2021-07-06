Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C873BC93F
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhGFKPQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhGFKPQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 06:15:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E39FD619B0
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 10:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625566357;
        bh=v/MeCCtXyxx0wLxtrcHeEpKLfb80vVMbeBsQcrjr46k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rJm93h4ps+gDUWUWCGphC15Cer46dej6PPdH84DvX0gKuq3zgW42DId7pACX8EtGL
         V8d5pXAJjFkmZcb+JsYB3XaG17G/VvaRN/jZYPlVFmcSZ0oaeqp+xv22oFvTkWWENP
         CyQSIm65jj2oRR3fbjpNtceAOHQJLafNy3tba3yq8FJAZonuw2urX6CXgfqOvL72e/
         8rLLsVO7dHWe44NtHvt46moVAjmghCnUwIrWv2cemuCmbaGUY97H7OHSV5dLOIOGOo
         tClMR+4fMdbbdleyiZLptuDET6u4Qc4IaVyY+kBSBqEILNQDoGMZsp7z2WZJrxNCms
         wgedxpg0FlWew==
Received: by mail-wm1-f52.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so1853658wmq.3
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:12:37 -0700 (PDT)
X-Gm-Message-State: AOAM532eyGSFV/y5xkggcMB0OJYKmHxuZS4jEHB+7yFOTIAw/ytV/Il1
        Lw1GN7aoDngdDUpHgc7hJVoEdfjFhjZS+LbOdpA=
X-Google-Smtp-Source: ABdhPJyBZZjXhCFhxZ3O+UJ4Skp1sVkJ+zsT2q7LxUSbjzWxyMUulSr98toNnPyQ/QbtbhUBIdhMPegHJ3ITzyLo2F8=
X-Received: by 2002:a05:600c:3205:: with SMTP id r5mr3811528wmp.75.1625566356454;
 Tue, 06 Jul 2021 03:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-4-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-4-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 12:12:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0RHFvzvGXMrJ369gDVC7fpH5XJp+AX-ZiAu0JskTzZqg@mail.gmail.com>
Message-ID: <CAK8P3a0RHFvzvGXMrJ369gDVC7fpH5XJp+AX-ZiAu0JskTzZqg@mail.gmail.com>
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
with -Werror
enabled on the command line though.

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
