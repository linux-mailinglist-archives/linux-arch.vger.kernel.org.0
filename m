Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABD73CCBF4
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 03:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhGSB3W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Jul 2021 21:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhGSB3Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Jul 2021 21:29:16 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B49C061762
        for <linux-arch@vger.kernel.org>; Sun, 18 Jul 2021 18:26:16 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id w1so14445333ilg.10
        for <linux-arch@vger.kernel.org>; Sun, 18 Jul 2021 18:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNr9P5csFc1QUex+1iMizVw8xdmLyXbVfpo7xboh6Og=;
        b=AELDyOWmlgGpYzC0Yx8/9a954f8t1BlHirK2G2gRhLidtOdGIlN2G5kmLqGoafCRtm
         9Lw6WIkMRiXSdxodfRNsBBzwOpQyZiRX4la8KUwYWLFjIWheAWqBrXNVGTqRrHsx+Xu7
         uggevV9NZJvPi9q4jpuN4FUPnfvzRftaJW+n+JXhdR53AnKlEWSdOJVbpUrdtb3R0p7n
         oW3rOvjjqS9JJOEPWLktWzrIYq5ZI2e0zVSd/u6a6IRRE29EfGv60xIqt73o2BbJ1Ghk
         m68xTRli1r/bmBS+2lEa+svdHHJjoSYXRTPLIqLFiqD/9wbdmbBnbkBQWYzO6HwG4LHv
         oDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNr9P5csFc1QUex+1iMizVw8xdmLyXbVfpo7xboh6Og=;
        b=iLkHrXhXpw9SE0pHCumlNcJpv04D9vlp846KtCCKWY2UMm0fxAYwaFOUUlpUSQogSX
         pBeb0S69LCRiiQX6CF9aNWbuocG3YDpXaj27+I5wkG0Sxo3jTZWlGbHphXU/Tkocp5Fb
         efCt3aKTjwjr9bEaUzP0RhVmmayxCjDiH9eBme3N/cj3gpWp8l3N0OkeDbDVejR+i1+e
         WvlTMLpZWaJJpNkdBih8yXnpta364NrN5vqDcvQAgVz6v6C8fspb3fyKVz30fFaJce0u
         wsmH3GsomMkTWwDIGQs0UPGA/iJFaw1stnCZbfG7qux/kVShe7rRde788kPjq0ObElmd
         Z9rw==
X-Gm-Message-State: AOAM532FKHbYu8lAKbBemtlgknH+QduVsiCPFmqNKorj5oLVU+aeD1dY
        69NpxV1+Tgt71meQnfQAoVRIe9HGrZdvw5eR/gs=
X-Google-Smtp-Source: ABdhPJw3YtLeA9OCHazLibpKTwx831OYoJhniBK8QINeV8ZOzLXkH52l0dRDRv/tOJw/q7HF4eRjvK52vY64K4f3WIU=
X-Received: by 2002:a92:dc10:: with SMTP id t16mr6423363iln.95.1626657976254;
 Sun, 18 Jul 2021 18:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-4-chenhuacai@loongson.cn> <CAK8P3a0RHFvzvGXMrJ369gDVC7fpH5XJp+AX-ZiAu0JskTzZqg@mail.gmail.com>
In-Reply-To: <CAK8P3a0RHFvzvGXMrJ369gDVC7fpH5XJp+AX-ZiAu0JskTzZqg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 19 Jul 2021 09:26:04 +0800
Message-ID: <CAAhV-H796UQNaRkiaJhYRHsO-36KE_5d6sT=sJaKXCKfHtP-Mg@mail.gmail.com>
Subject: Re: [PATCH 03/19] LoongArch: Add build infrastructure
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Tue, Jul 6, 2021 at 6:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
>  Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> > --- /dev/null
> > +++ b/arch/loongarch/Kbuild
> > @@ -0,0 +1,21 @@
> > +# Fail on warnings - also for files referenced in subdirs
> > +# -Werror can be disabled for specific files using:
> > +# CFLAGS_<file.o> := -Wno-error
> > +ifeq ($(W),)
> > +subdir-ccflags-y := -Werror
> > +endif
>
> This tends to break building with 'make W=12' or similar, I would recommend not
> adding -Werror. It is a good idea though to have your CI systems build
> with -Werror
> enabled on the command line though.
If we use W=???, corresponding flags will be used; if we don't use
W=???, -Werrer flag is used here. So it seems not break the building.

>
> > +# platform specific definitions
> > +include arch/loongarch/Kbuild.platforms
> > +obj-y := $(platform-y)
> > +
>
> I would recommend not planning on having platform specific files. The way
> we do it on modern platforms (arm64, rv64) is to have all the device drivers
> in the driver subsystems instead.
>
> > +       select GENERIC_IOMAP
>
> GENERIC_IOMAP is one of those you probably don't want here. If PCI I/O
> space is mapped into MMIO registers, just do what arm64 has and make
> ioport_map() return a pointer, then make ioread32() an alias for readl().
OK, I will try.

>
> > +       select HAVE_CBPF_JIT if !64BIT
> > +       select HAVE_EBPF_JIT if 64BIT
>
> These look like you incorrectly copied them from MIPS. I don't see any EBPF_JIT
> implemementation (I may have missed that, as I'm still starting), but
> you probably
> don't want the CBPF version for 32-bit anyway.
OK, they should be removed at this time.

>
> > +       select HAVE_IDE
>
> drivers/ide/ was just removed,so this line can go as well.
>
> > +       select VIRT_TO_BUS
>
> Remove this: if you still require a driver that fails to use the dma-mapping
> API, fix the driver instead so it can work with IOMMUs.
OK, they will be removed in the next version.

>
> > +menu "Machine selection"
> > +
> > +choice
> > +       prompt "System type"
> > +       default MACH_LOONGSON64
> > +
> > +config MACH_LOONGSON64
> > +       bool "Loongson 64-bit family of machines"
>
> There should generally not be a 'choice' menu to select between
> different machine types, but instead the kernel should be able
> to run on all platforms that have the same instruction set.
>
> Maybe just make this a silent option and use 'select
> MACH_LOONGSON64' so you can pick up the device drivers
> that mips uses.
OK, thanks.

>
> > +       select ARCH_MIGHT_HAVE_PC_PARPORT
> > +       select ARCH_MIGHT_HAVE_PC_SERIO
> > +       select GENERIC_ISA_DMA
> > +       select ISA
>
> Do you actually have ISA-style add-on cards? If not, then
> remove the ISA options. If you do, which drivers are they?
Yes, there is an LPC controller in LS7A, and superio is connected on
it for laptops.

>
> > +config CPU_LOONGSON64
> > +       bool "Loongson 64-bit CPU"
> > +       depends on SYS_HAS_CPU_LOONGSON64
> > +       select CPU_SUPPORTS_64BIT_KERNEL
> > +       select GPIOLIB
> > +       select SWIOTLB
> > +       select ARCH_SUPPORTS_ATOMIC_RMW
> > +       help
> > +         The Loongson 64-bit processor implements the LoongArch64 (the 64-bit
> > +         version of LoongArch) instruction set.
> > +
> > +endchoice
> > +
> > +config SYS_HAS_CPU_LOONGSON64
> > +       bool
> > +
> > +endmenu
> > +
> > +config SYS_SUPPORTS_32BIT_KERNEL
> > +       bool
> > +config SYS_SUPPORTS_64BIT_KERNEL
> > +       bool
> > +config CPU_SUPPORTS_32BIT_KERNEL
> > +       bool
> > +config CPU_SUPPORTS_64BIT_KERNEL
> > +       bool
>
> Same for the CPUs: I would suggest you keep this simple until you get
> to the point of actually having multiple CPUs that you need to distinguish.
>
> Different 64-bit CPUs are hopefully going to be compatible with one
> another, so they should not be listed as mutually exclusive in a
> 'choice' statement. The complexity with two levels of 32/64 support
> is probably not going to be helpful here either.
>
> The 'select' statements that you have under CPU_LOONGSON64
> ook like they should just be in the top level.
>
> GPIOLIB and SWIOTLB could just be left user selectable, if turning
> them off results only in run-time loss of functionality but not a
> build failure.
>
> > +menu "Kernel type"
> > +
> > +choice
> > +       prompt "Kernel code model"
> > +       help
> > +         You should only select this option if you have a workload that
> > +         actually benefits from 64-bit processing or if your machine has
> > +         large memory.  You will only be presented a single option in this
> > +         menu if your system does not support both 32-bit and 64-bit kernels.
> > +
> > +config 32BIT
> > +       bool "32-bit kernel"
> > +       depends on CPU_SUPPORTS_32BIT_KERNEL && SYS_SUPPORTS_32BIT_KERNEL
> > +       help
> > +         Select this option if you want to build a 32-bit kernel.
> > +
> > +config 64BIT
> > +       bool "64-bit kernel"
> > +       depends on CPU_SUPPORTS_64BIT_KERNEL && SYS_SUPPORTS_64BIT_KERNEL
> > +       help
> > +         Select this option if you want to build a 64-bit kernel.
> > +
> > +endchoice
>
> Since you don't support any 32-bit target at the moment, just make CONFIG_64BIT
> a default-on statement, and make it user-selectable only when you add a 32-bit
> target.
OK.

Huacai
>
> > +choice
> > +       prompt "Kernel page size"
> > +       default PAGE_SIZE_16KB
> > +
> > +config PAGE_SIZE_4KB
> > +       bool "4kB"
> > +       help
> > +         This option select the standard 4kB Linux page size.
> > +
> > +config PAGE_SIZE_16KB
> > +       bool "16kB"
> > +       help
> > +         This option select the standard 16kB Linux page size.
> > +
> > +config PAGE_SIZE_64KB
> > +       bool "64kB"
> > +       help
> > +         This option select the standard 64kB Linux page size.
> > +
> > +endchoice
> > +
> > +choice
> > +       prompt "Virtual memory address space bits"
> > +       default VA_BITS_40
> > +       help
> > +         Allows choosing one of multiple possible virtual memory
> > +         address space bits for applications. The level of page
> > +         translation table is determined by a combination of page
> > +         size and virtual memory address space bits.
> > +
> > +config VA_BITS_40
> > +       bool "40-bits"
> > +       depends on 64BIT
> > +       help
> > +         Support a maximum at least 40 bits of application virtual memory.
> > +
> > +config VA_BITS_48
> > +       bool "48-bits"
> > +       depends on 64BIT
> > +       help
> > +         Support a maximum at least 48 bits of application virtual memory.
> > +
> > +endchoice
>
> Isn't the size of the address space tied to the page size?
>
>          Arnd
