Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851E33D38E6
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 12:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhGWKAo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 06:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhGWKAn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jul 2021 06:00:43 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DFAC061575
        for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2021 03:41:16 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id u15so1872083iol.13
        for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2021 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPca7QxqHcMBgLBXOpPfPyxNt2HHNAS5ZW0uQhR1JxY=;
        b=sY96YTDxgtcNWaekS2u+C2EDMZZLrn5bsIMnyOakr0blyJTChZUdbj6FnJuZ6evf5S
         aaN361FwBVqne8ESLFXpEKoozyBekr/Bct6tu00hAfmpAWCCubBZz0NkfTaxw3dNNHR6
         vBjyN0UKu1/8VSABKsNCxuUmNJK+1cob4N79fl6KGVY32qtfHordQqpPgXiGK+tMCrZI
         j7+F82LAvJk8drx0APWMsByh+GhJ4wb3DPeAEs2PiIjyI9c+LnGPlkp8JlalbuClRc82
         Hc+UlsrbUEvic2OZJv5IM8RLoFscBOnl3v3qjhmnGbi93/Gp+2/Mby2bEWbQm4Xpvb04
         awKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPca7QxqHcMBgLBXOpPfPyxNt2HHNAS5ZW0uQhR1JxY=;
        b=ad8eQFrRaZaus/6UupKdJLPKQKyIH1+0IHJxRjMfDEXdBkKK//aNXPNigxSVUrdWCe
         PoOBSE6/pMZx7PxEVWLemrYBoFR/8l2imlQVmWeKTHHJFVJbQMK7n6qyl2WejjlnmA0s
         JVyOa9IZpHkgvMyau+bJLm/utU8t14vzk60oEPNizwk59k5rlM+Mcxow2K2CQtus4pRp
         nEds2829x8KVKtsSycfFieCnvY58hUqbVob+mEjEAHQZU8hO/kn8sdGSVGGbVGcy9I81
         +6iMLilMpxFLSmP7TRVB/jra8c+hqzuoqUD160ByF32XaHsMlo78KcnFtoWe+MbXg1Ik
         aqiQ==
X-Gm-Message-State: AOAM5331t1Bw40jpvUav02qrNZKKUofnUMARaA8UN/5xj0qCQ+3x9VsQ
        GOPX1PrC5usqdQF3sI28P9U6CNpco/S80hVjp2c=
X-Google-Smtp-Source: ABdhPJwa+oA2dgIk4WxkXJb/NxD3SC8wgjjyj2G0RqwR5KRKCSKydKaobsuPo+y6IxAhLmTvGSSxNGf+3GvqALDthWY=
X-Received: by 2002:a02:93a7:: with SMTP id z36mr3540217jah.112.1627036875639;
 Fri, 23 Jul 2021 03:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-13-chenhuacai@loongson.cn> <CAK8P3a0+jk=09mGdnWu9c+JWkwDKM+ffv=QvJs2uMY7WOg85AQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0+jk=09mGdnWu9c+JWkwDKM+ffv=QvJs2uMY7WOg85AQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 23 Jul 2021 18:41:00 +0800
Message-ID: <CAAhV-H6PDr=YZdc=2NJ6hceE7HoKB-WcUHi3GEgtfO8nbxOV3g@mail.gmail.com>
Subject: Re: [PATCH 12/19] LoongArch: Add misc common routines
To:     Arnd Bergmann <arnd@arndb.de>
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

On Tue, Jul 6, 2021 at 6:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> > +
> > +#ifdef ARCH_HAS_USABLE_BUILTIN_POPCOUNT
> > +
> > +#include <asm/types.h>
> > +
> > +static inline unsigned int __arch_hweight32(unsigned int w)
> > +{
> > +       return __builtin_popcount(w);
> > +}
>
> This looks like you incorrect copied it from MIPS: For a new architecture,
> you should know whether __builtin_popcount is usable or not.
Sorry, this is my fault.

>
> > +static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
> > +                                  int size)
> > +{
> > +       switch (size) {
> > +       case 1:
> > +       case 2:
> > +               return __xchg_small(ptr, x, size);
>
> If there is no native sub-word xchg(), then better make this BUILD_BUG(),
> see the riscv implementation.
>
> > +
> > +static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> > +                                     unsigned long new, unsigned int size)
> > +{
> > +       switch (size) {
> > +       case 1:
> > +       case 2:
> > +               return __cmpxchg_small(ptr, old, new, size);
>
> Same here.
16bit cmpxchg is used by qspinlock. Yes, you suggest we should not use
qspinlock, but our test results show that ticket spinlock is even
worse... So, we want to keep cmpxchg_small() and qspinlock.

>
> > +++ b/arch/loongarch/include/asm/fb.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_FB_H_
> > +#define _ASM_FB_H_
> > +
> > +#include <linux/fb.h>
> > +#include <linux/fs.h>
> > +#include <asm/page.h>
> > +
> > +static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
> > +                               unsigned long off)
> > +{
> > +       vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +}
>
> Do you have a writethrough or write-combine map type? noncached makes
> this slower than necessary.
OK, thanks, this writecombine will be used.

> > +/*
> > + * On LoongArch I/O ports are memory mapped, so we access them using normal
> > + * load/store instructions. loongarch_io_port_base is the virtual address to
> > + * which all ports are being mapped.  For sake of efficiency some code
> > + * assumes that this is an address that can be loaded with a single lui
> > + * instruction, so the lower 16 bits must be zero. Should be true on any
> > + * sane architecture; generic code does not use this assumption.
> > + */
> > +extern unsigned long loongarch_io_port_base;
> > +
> > +static inline void set_io_port_base(unsigned long base)
> > +{
> > +       loongarch_io_port_base = base;
> > +}
>
> If you are able to map this to a fixed virtual address (in fixmap or elsewhere),
> you can just use the asm-generic version.
OK, we will try the asm-generic version.

>
> > +/*
> > + * ISA I/O bus memory addresses are 1:1 with the physical address.
> > + */
> > +static inline unsigned long isa_virt_to_bus(volatile void *address)
> > +{
> > +       return virt_to_phys(address);
> > +}
> > +
> > +static inline void *isa_bus_to_virt(unsigned long address)
> > +{
> > +       return phys_to_virt(address);
> > +}
> > +/*
> > + * However PCI ones are not necessarily 1:1 and therefore these interfaces
> > + * are forbidden in portable PCI drivers.
> > + *
> > + * Allow them for x86 for legacy drivers, though.
> > + */
> > +#define virt_to_bus virt_to_phys
> > +#define bus_to_virt phys_to_virt
>
> As mentioned in another patch, these should not exist on new architectures.
OK, they will be removed.

>
> > +
> > +static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
> > +       unsigned long prot_val)
> > +{
> > +       /* This only works for !HIGHMEM currently */
>
> Do you support highmem? I would expect new architectures to no longer
> implement that. Just use a 64-bit kernel on systems with lots of ram.
Emmm, 64-bit kernel doesn't need highmem.

>
> > +#define ioremap(offset, size)                                  \
> > +       ioremap_prot((offset), (size), _CACHE_SUC)
> > +#define ioremap_uc ioremap
>
> Remove ioremap_uc(), it should never be called here.
It is used by lib/devres.c.

>
> > +/*
> > + * ioremap_wc     -   map bus memory into CPU space
> > + * @offset:    bus address of the memory
> > + * @size:      size of the resource to map
> > + *
> > + * ioremap_wc performs a platform specific sequence of operations to
> > + * make bus memory CPU accessible via the readb/readw/readl/writeb/
> > + * writew/writel functions and the other mmio helpers. The returned
> > + * address is not guaranteed to be usable directly as a virtual
> > + * address.
> > + *
> > + * This version of ioremap ensures that the memory is marked uncachable
> > + * but accelerated by means of write-combining feature. It is specifically
> > + * useful for PCIe prefetchable windows, which may vastly improve a
> > + * communications performance. If it was determined on boot stage, what
> > + * CPU CCA doesn't support WUC, the method shall fall-back to the
> > + * _CACHE_SUC option (see cpu_probe() method).
> > + */
> > +#define ioremap_wc(offset, size)                               \
> > +       ioremap_prot((offset), (size), boot_cpu_data.writecombine)
>
> It seems this is all copied from MIPS again. Are you sure you need to support
> both versions with a runtime conditional?
Emmm, this will be removed.

>
> > +#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type)                         \
> > +                                                                       \
> > +static inline void pfx##write##bwlq(type val,                          \
> > +                                   volatile void __iomem *mem)         \
> > +{                                                                      \
>
> Please don't add another copy of these macros. Use the version from
> include/asm-generic, or modify it as needed if it doesn't quite work.
On Loongson platform, we should put a wmb() before MMIO write. The
generic readw()/readl()/outw()/outl() have wmb(), but the __raw
versions don't have. I want to know what is the design goal of the
__raw version, are they supposed to be used in scenarios that the
ordering needn't be cared?

>
> > diff --git a/arch/loongarch/include/asm/vga.h b/arch/loongarch/include/asm/vga.h
> > new file mode 100644
> > index 000000000000..eef95f2f837a
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/vga.h
> > @@ -0,0 +1,56 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Access to VGA videoram
> > + *
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
>
> I think it would be better not to support VGA console, but to use the EFI
> framebuffer.
OK, this will be removed.

>
>
> > diff --git a/arch/loongarch/kernel/cmpxchg.c b/arch/loongarch/kernel/cmpxchg.c
> > new file mode 100644
> > index 000000000000..30f9f1ee4f0a
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/cmpxchg.c
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <asm/cmpxchg.h>
> > +
> > +unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
> > +{
>
> This file should not be there, I think you just copied it from the MIPS version.
>
> Which brings me to an important point: anything you copied from elsewhere
> is clearly not copyrighted by Loongson. I think you need to go through each
> file and update the copyright and author statements to reflect who actually
> wrote the code. At least you won't have to update this file if you remove it ;-)
>
>
>        Arnd
