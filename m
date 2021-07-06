Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08B83BCB38
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 13:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGFLDB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhGFLDA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 07:03:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4D4C61A14
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 11:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625569221;
        bh=GXaXn0PqV9COLbpw+gsG/1jFZ+jGw0+eubf23DzgIss=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nxxcp70bTGcI+yYqr+en3rBVcREiFVeIyxZxG5hBhVEzEvqzRj0N8lI/SjcrR2VW1
         397CX3QDONn4I72NPv4wfGEJtKsKOH4PiIBXy/6tKnuK+WriUF8cmk9S74aGdiQ0cC
         nsiPEufCnCV0FPscXNqNld2BVsrgUSNPvvRV36a2NiBxYyAGdKL705qD3u1vrJfyb8
         EcPyeZLZzpiyqpf/Te2FDxJIfeUx/YDehhZ9ATn66vGzYNuDZ4+7CatDs78qVcRcsD
         1rIwrzjOGsqI7HMtOPyGaYKIgxMEF9+BZnOnsWMqMtRVa8dZdMGCbOq4mywzBfW++m
         f4fI2vpUkSPaQ==
Received: by mail-wr1-f49.google.com with SMTP id u8so25529508wrq.8
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 04:00:21 -0700 (PDT)
X-Gm-Message-State: AOAM533mX3RJx30bQYKKnd+u1jUaVXMKROAjSUUsiD7VvzKhckxrELen
        PTMXHcJ00zLlh8K2A5Ubh3wOmtWgTIDSJma3bS0=
X-Google-Smtp-Source: ABdhPJy2KiPiJ5/W0cGHXSvkrxgmEURs/3JnVunlLheZKyYK2o5Oen6gIAPFP//7AxLgMtLyrrynsHCYIrkUNjEFPz4=
X-Received: by 2002:adf:e107:: with SMTP id t7mr21136635wrz.165.1625569220510;
 Tue, 06 Jul 2021 04:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-13-chenhuacai@loongson.cn> <CAK8P3a0+jk=09mGdnWu9c+JWkwDKM+ffv=QvJs2uMY7WOg85AQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0+jk=09mGdnWu9c+JWkwDKM+ffv=QvJs2uMY7WOg85AQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 13:00:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1JSp2BWKL2TuC2-sh+ku8iFSwT5exOU_X6WBgO9xFVsA@mail.gmail.com>
Message-ID: <CAK8P3a1JSp2BWKL2TuC2-sh+ku8iFSwT5exOU_X6WBgO9xFVsA@mail.gmail.com>
Subject: Re: [PATCH 12/19] LoongArch: Add misc common routines
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

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> +
> +#ifdef ARCH_HAS_USABLE_BUILTIN_POPCOUNT
> +
> +#include <asm/types.h>
> +
> +static inline unsigned int __arch_hweight32(unsigned int w)
> +{
> +       return __builtin_popcount(w);
> +}

This looks like you incorrect copied it from MIPS: For a new architecture,
you should know whether __builtin_popcount is usable or not.

> +static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
> +                                  int size)
> +{
> +       switch (size) {
> +       case 1:
> +       case 2:
> +               return __xchg_small(ptr, x, size);

If there is no native sub-word xchg(), then better make this BUILD_BUG(),
see the riscv implementation.

> +
> +static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> +                                     unsigned long new, unsigned int size)
> +{
> +       switch (size) {
> +       case 1:
> +       case 2:
> +               return __cmpxchg_small(ptr, old, new, size);

Same here.

> +++ b/arch/loongarch/include/asm/fb.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_FB_H_
> +#define _ASM_FB_H_
> +
> +#include <linux/fb.h>
> +#include <linux/fs.h>
> +#include <asm/page.h>
> +
> +static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
> +                               unsigned long off)
> +{
> +       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +}

Do you have a writethrough or write-combine map type? noncached makes
this slower than necessary.
> +/*
> + * On LoongArch I/O ports are memory mapped, so we access them using normal
> + * load/store instructions. loongarch_io_port_base is the virtual address to
> + * which all ports are being mapped.  For sake of efficiency some code
> + * assumes that this is an address that can be loaded with a single lui
> + * instruction, so the lower 16 bits must be zero. Should be true on any
> + * sane architecture; generic code does not use this assumption.
> + */
> +extern unsigned long loongarch_io_port_base;
> +
> +static inline void set_io_port_base(unsigned long base)
> +{
> +       loongarch_io_port_base = base;
> +}

If you are able to map this to a fixed virtual address (in fixmap or elsewhere),
you can just use the asm-generic version.

> +/*
> + * ISA I/O bus memory addresses are 1:1 with the physical address.
> + */
> +static inline unsigned long isa_virt_to_bus(volatile void *address)
> +{
> +       return virt_to_phys(address);
> +}
> +
> +static inline void *isa_bus_to_virt(unsigned long address)
> +{
> +       return phys_to_virt(address);
> +}
> +/*
> + * However PCI ones are not necessarily 1:1 and therefore these interfaces
> + * are forbidden in portable PCI drivers.
> + *
> + * Allow them for x86 for legacy drivers, though.
> + */
> +#define virt_to_bus virt_to_phys
> +#define bus_to_virt phys_to_virt

As mentioned in another patch, these should not exist on new architectures.

> +
> +static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
> +       unsigned long prot_val)
> +{
> +       /* This only works for !HIGHMEM currently */

Do you support highmem? I would expect new architectures to no longer
implement that. Just use a 64-bit kernel on systems with lots of ram.

> +#define ioremap(offset, size)                                  \
> +       ioremap_prot((offset), (size), _CACHE_SUC)
> +#define ioremap_uc ioremap

Remove ioremap_uc(), it should never be called here.

> +/*
> + * ioremap_wc     -   map bus memory into CPU space
> + * @offset:    bus address of the memory
> + * @size:      size of the resource to map
> + *
> + * ioremap_wc performs a platform specific sequence of operations to
> + * make bus memory CPU accessible via the readb/readw/readl/writeb/
> + * writew/writel functions and the other mmio helpers. The returned
> + * address is not guaranteed to be usable directly as a virtual
> + * address.
> + *
> + * This version of ioremap ensures that the memory is marked uncachable
> + * but accelerated by means of write-combining feature. It is specifically
> + * useful for PCIe prefetchable windows, which may vastly improve a
> + * communications performance. If it was determined on boot stage, what
> + * CPU CCA doesn't support WUC, the method shall fall-back to the
> + * _CACHE_SUC option (see cpu_probe() method).
> + */
> +#define ioremap_wc(offset, size)                               \
> +       ioremap_prot((offset), (size), boot_cpu_data.writecombine)

It seems this is all copied from MIPS again. Are you sure you need to support
both versions with a runtime conditional?

> +#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type)                         \
> +                                                                       \
> +static inline void pfx##write##bwlq(type val,                          \
> +                                   volatile void __iomem *mem)         \
> +{                                                                      \

Please don't add another copy of these macros. Use the version from
include/asm-generic, or modify it as needed if it doesn't quite work.

> diff --git a/arch/loongarch/include/asm/vga.h b/arch/loongarch/include/asm/vga.h
> new file mode 100644
> index 000000000000..eef95f2f837a
> --- /dev/null
> +++ b/arch/loongarch/include/asm/vga.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Access to VGA videoram
> + *
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */

I think it would be better not to support VGA console, but to use the EFI
framebuffer.


> diff --git a/arch/loongarch/kernel/cmpxchg.c b/arch/loongarch/kernel/cmpxchg.c
> new file mode 100644
> index 000000000000..30f9f1ee4f0a
> --- /dev/null
> +++ b/arch/loongarch/kernel/cmpxchg.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/bitops.h>
> +#include <asm/cmpxchg.h>
> +
> +unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
> +{

This file should not be there, I think you just copied it from the MIPS version.

Which brings me to an important point: anything you copied from elsewhere
is clearly not copyrighted by Loongson. I think you need to go through each
file and update the copyright and author statements to reflect who actually
wrote the code. At least you won't have to update this file if you remove it ;-)


       Arnd
