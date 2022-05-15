Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9417527803
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiEOOWO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 10:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiEOOWN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 10:22:13 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2259DF4A;
        Sun, 15 May 2022 07:22:10 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id a127so13054096vsa.3;
        Sun, 15 May 2022 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRcUVukoKxXgLwlooiS9O+urGBtPA+DXWr6FkRu/KNw=;
        b=gtbBXSW8/wnC6xq7bYN+55NV7t5wjt4WzoBC49Y3saejNga3xLlbMElYKyadePkYC2
         Vaxlz6rjThf+IBvQXcb3VRPDzz6ioN9HELbTTBIJXviOnxMEBayMOpaGWa+mhWSkdpoD
         xKf4t0d5Gk1kpPbJdO8e5yEWEU973AbcjP3eJqgeEQ/pSZbxVmih37IC1Gz2+T9fLt7S
         BEtUkzFUDkjP7vUhES33qbGsy1CS7yeisFLcepFuxBhDPymO2UEmr4HeCOFaabbdpIuY
         Tl0vbEKHZWmw96NRyz98tXJsRhTbzgX4Mf39pxNPMfXLyRCQ93eQpxZa80TNPrGJvHXr
         j0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRcUVukoKxXgLwlooiS9O+urGBtPA+DXWr6FkRu/KNw=;
        b=zhEdUWf2ituYr1YXQHSINcOtfak0jorq/+K4rGjsfSZ5CLq6Ya8THR+KyckH7eXiSW
         QiVNtzrIn7c9NMOp2Zzzn5cWFSrNPqGle3/v2s1rrskVlBJiR0xHoWe13oOeSG9Z9Gt4
         Agn7QJOelym+xC4LK4569AodKkCO+4YagUc31CnmgKdRh6NqpUV2z73DvfpYQhbY2Te/
         Ig4lRvGMYhcnNqDLLPlZd+Mjf0ytX1pW70puhzJZIVcEhIIryuVxDAQXCJtoUylkRZZD
         LNA3b95fj9N4eobwA01Wrwp4lIiXckc2FZBHQClKNti1KDWomTDtTZz9LTLCi+E85XaR
         Ijwg==
X-Gm-Message-State: AOAM530ORmGuqDzOUfGuGj49AdH6T527g8mwuXSOqtIYGedOCpBhMw5w
        zgeDvHkmqHTWfqTx3L96i19cq/HT6rRQoFWHasY=
X-Google-Smtp-Source: ABdhPJyxySgj/QeAaXQdEgBNGclp5eIokEXmnC0gkGhH7RntvdbnNDzZz7JSRtlT9jgUXfJgM7NqxaXyymSHNoBEups=
X-Received: by 2002:a67:ea4f:0:b0:328:1db4:d85c with SMTP id
 r15-20020a67ea4f000000b003281db4d85cmr4643793vso.20.1652624529627; Sun, 15
 May 2022 07:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-17-chenhuacai@loongson.cn> <80d3d49b-bacc-6a8e-f0b6-c360c56e2bde@xen0n.name>
In-Reply-To: <80d3d49b-bacc-6a8e-f0b6-c360c56e2bde@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 22:21:58 +0800
Message-ID: <CAAhV-H40Hp6jHnBugdAJuaQRbwrLQnMjED0V2gLGj_bcvExZAg@mail.gmail.com>
Subject: Re: [PATCH V10 16/22] LoongArch: Add misc common routines
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
        Stephen Rothwell <sfr@canb.auug.org.au>
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

Hi, Xuerui,

On Sun, May 15, 2022 at 9:04 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi,
>
> On 5/14/22 16:03, Huacai Chen wrote:
> > Add some misc common routines for LoongArch, including: asm-offsets
> > routines, cmpxchg and futex functions, i/o memory access functions,
> > rtc functions, frame-buffer functions, procfs information display, etc.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/asm-offsets.h |   5 +
> >   arch/loongarch/include/asm/fb.h          |  23 ++
> >   arch/loongarch/include/asm/futex.h       | 107 ++++++++++
> >   arch/loongarch/include/asm/io.h          | 129 ++++++++++++
> >   arch/loongarch/include/uapi/asm/swab.h   |  52 +++++
> >   arch/loongarch/kernel/asm-offsets.c      | 254 +++++++++++++++++++++++
> >   arch/loongarch/kernel/io.c               |  94 +++++++++
> >   arch/loongarch/kernel/proc.c             | 122 +++++++++++
> >   arch/loongarch/kernel/rtc.c              |  36 ++++
> >   9 files changed, 822 insertions(+)
> >   create mode 100644 arch/loongarch/include/asm/asm-offsets.h
> >   create mode 100644 arch/loongarch/include/asm/fb.h
> >   create mode 100644 arch/loongarch/include/asm/futex.h
> >   create mode 100644 arch/loongarch/include/asm/io.h
> >   create mode 100644 arch/loongarch/include/uapi/asm/swab.h
> >   create mode 100644 arch/loongarch/kernel/asm-offsets.c
> >   create mode 100644 arch/loongarch/kernel/io.c
> >   create mode 100644 arch/loongarch/kernel/proc.c
> >   create mode 100644 arch/loongarch/kernel/rtc.c
> >
> > diff --git a/arch/loongarch/include/asm/asm-offsets.h b/arch/loongarch/include/asm/asm-offsets.h
> > new file mode 100644
> > index 000000000000..d9ad88d293e7
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/asm-offsets.h
> > @@ -0,0 +1,5 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <generated/asm-offsets.h>
> > diff --git a/arch/loongarch/include/asm/fb.h b/arch/loongarch/include/asm/fb.h
> > new file mode 100644
> > index 000000000000..3116bde8772d
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/fb.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_FB_H_
> > +#define _ASM_FB_H_
> > +
> > +#include <linux/fb.h>
> > +#include <linux/fs.h>
> > +#include <asm/page.h>
> > +
> > +static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
> > +                             unsigned long off)
> > +{
> > +     vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> > +}
> > +
> > +static inline int fb_is_primary_device(struct fb_info *info)
> > +{
> > +     return 0;
> > +}
> So our behavior seems to be in line with arm64. Nice. At least that's
> what diff says. ;-)
> > +
> > +#endif /* _ASM_FB_H_ */
> > diff --git a/arch/loongarch/include/asm/futex.h b/arch/loongarch/include/asm/futex.h
> > new file mode 100644
> > index 000000000000..b27d55f92db7
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/futex.h
> > @@ -0,0 +1,107 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_FUTEX_H
> > +#define _ASM_FUTEX_H
> > +
> > +#include <linux/futex.h>
> > +#include <linux/uaccess.h>
> > +#include <asm/barrier.h>
> > +#include <asm/compiler.h>
> > +#include <asm/errno.h>
> > +
> > +#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)           \
> > +{                                                                    \
> > +     __asm__ __volatile__(                                           \
> > +     "1:     ll.w    %1, %4 # __futex_atomic_op\n"           \
> > +     "       " insn  "                               \n"     \
> > +     "2:     sc.w    $t0, %2                         \n"     \
> > +     "       beq     $t0, $zero, 1b                  \n"     \
> > +     "3:                                             \n"     \
> > +     "       .section .fixup,\"ax\"                  \n"     \
> > +     "4:     li.w    %0, %6                          \n"     \
> > +     "       b       3b                              \n"     \
> > +     "       .previous                               \n"     \
> > +     "       .section __ex_table,\"a\"               \n"     \
> > +     "       "__UA_ADDR "\t1b, 4b                    \n"     \
> > +     "       "__UA_ADDR "\t2b, 4b                    \n"     \
> > +     "       .previous                               \n"     \
> > +     : "=r" (ret), "=&r" (oldval),                           \
> > +       "=ZC" (*uaddr)                                        \
> > +     : "0" (0), "ZC" (*uaddr), "Jr" (oparg),                 \
> > +       "i" (-EFAULT)                                         \
> > +     : "memory", "t0");                                      \
> > +}
> > +
> > +static inline int
> > +arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
> > +{
> > +     int oldval = 0, ret = 0;
> > +
> > +     pagefault_disable();
> > +
> > +     switch (op) {
> > +     case FUTEX_OP_SET:
> > +             __futex_atomic_op("move $t0, %z5", ret, oldval, uaddr, oparg);
> > +             break;
> > +     case FUTEX_OP_ADD:
> > +             __futex_atomic_op("add.w $t0, %1, %z5", ret, oldval, uaddr, oparg);
> > +             break;
> > +     case FUTEX_OP_OR:
> > +             __futex_atomic_op("or   $t0, %1, %z5", ret, oldval, uaddr, oparg);
> > +             break;
> > +     case FUTEX_OP_ANDN:
> > +             __futex_atomic_op("and  $t0, %1, %z5", ret, oldval, uaddr, ~oparg);
> > +             break;
> > +     case FUTEX_OP_XOR:
> > +             __futex_atomic_op("xor  $t0, %1, %z5", ret, oldval, uaddr, oparg);
> > +             break;
> > +     default:
> > +             ret = -ENOSYS;
> > +     }
> > +
> > +     pagefault_enable();
> > +
> > +     if (!ret)
> > +             *oval = oldval;
> > +
> > +     return ret;
> > +}
> > +
> > +static inline int
> > +futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval, u32 newval)
> > +{
> > +     int ret = 0;
> > +     u32 val = 0;
> > +
> > +     if (!access_ok(uaddr, sizeof(u32)))
> > +             return -EFAULT;
> > +
> > +     __asm__ __volatile__(
> > +     "# futex_atomic_cmpxchg_inatomic                        \n"
> > +     "1:     ll.w    %1, %3                                  \n"
> > +     "       bne     %1, %z4, 3f                             \n"
> > +     "       or      $t0, %z5, $zero                         \n"
> > +     "2:     sc.w    $t0, %2                                 \n"
> > +     "       beq     $zero, $t0, 1b                          \n"
> > +     "3:                                                     \n"
> > +     "       .section .fixup,\"ax\"                          \n"
> > +     "4:     li.d    %0, %6                                  \n"
> > +     "       b       3b                                      \n"
> > +     "       .previous                                       \n"
> > +     "       .section __ex_table,\"a\"                       \n"
> > +     "       "__UA_ADDR "\t1b, 4b                            \n"
> > +     "       "__UA_ADDR "\t2b, 4b                            \n"
> > +     "       .previous                                       \n"
> > +     : "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
> > +     : GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
> > +       "i" (-EFAULT)
> > +     : "memory", "t0");
> > +
> > +     *uval = val;
> > +
> > +     return ret;
> > +}
> > +
> > +#endif /* _ASM_FUTEX_H */
> > diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
> > new file mode 100644
> > index 000000000000..7de50a6c3100
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/io.h
> > @@ -0,0 +1,129 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_IO_H
> > +#define _ASM_IO_H
> > +
> > +#define ARCH_HAS_IOREMAP_WC
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +
> > +#include <asm/addrspace.h>
> > +#include <asm/bug.h>
> > +#include <asm/byteorder.h>
> > +#include <asm/cpu.h>
> > +#include <asm/page.h>
> > +#include <asm/pgtable-bits.h>
> > +#include <asm/string.h>
> > +
> > +/*
> > + * On LoongArch, I/O ports mappring is following:
> > + *
> > + *           |         ....          |
> > + *           |-----------------------|
> > + *           | pci io ports(64K~32M) |
> > + *           |-----------------------|
> > + *           | isa io ports(0  ~16K) |
> > + * PCI_IOBASE ->|-----------------------|
> > + *           |         ....          |
> Please use spaces for ASCII art, so they don't get mangled when shown
> with different tab sizes or in diffs.
OK, thanks.

> > + */
> > +#define PCI_IOBASE   ((void __iomem *)(vm_map_base + (2 * PAGE_SIZE)))
> > +#define PCI_IOSIZE   SZ_32M
> > +#define ISA_IOSIZE   SZ_16K
> > +#define IO_SPACE_LIMIT       (PCI_IOSIZE - 1)
> > +
> > +/*
> > + * Change "struct page" to physical address.
> > + */
> > +#define page_to_phys(page)   ((phys_addr_t)page_to_pfn(page) << PAGE_SHIFT)
> > +
> > +extern void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size);
> > +extern void __init early_iounmap(void __iomem *addr, unsigned long size);
> > +
> > +#define early_memremap early_ioremap
> > +#define early_memunmap early_iounmap
> > +
> > +static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
> > +                                      unsigned long prot_val)
> > +{
> > +     if (prot_val == _CACHE_CC)
> > +             return (void __iomem *)(unsigned long)(CACHE_BASE + offset);
> > +     else
> > +             return (void __iomem *)(unsigned long)(UNCACHE_BASE + offset);
> > +}
> > +
> > +/*
> > + * ioremap -   map bus memory into CPU space
> > + * @offset:    bus address of the memory
> > + * @size:      size of the resource to map
> > + *
> > + * ioremap performs a platform specific sequence of operations to
> > + * make bus memory CPU accessible via the readb/readw/readl/writeb/
> > + * writew/writel functions and the other mmio helpers. The returned
> > + * address is not guaranteed to be usable directly as a virtual
> > + * address.
> > + */
> > +#define ioremap(offset, size)                                        \
> > +     ioremap_prot((offset), (size), _CACHE_SUC)
> > +
> > +/*
> > + * ioremap_wc - map bus memory into CPU space
> > + * @offset:     bus address of the memory
> > + * @size:       size of the resource to map
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
> > +#define ioremap_wc(offset, size)                             \
> > +     ioremap_prot((offset), (size), _CACHE_WUC)
> > +
> > +/*
> > + * ioremap_cache -  map bus memory into CPU space
> > + * @offset:      bus address of the memory
> > + * @size:        size of the resource to map
> > + *
> > + * ioremap_cache performs a platform specific sequence of operations to
> > + * make bus memory CPU accessible via the readb/readw/readl/writeb/
> > + * writew/writel functions and the other mmio helpers. The returned
> > + * address is not guaranteed to be usable directly as a virtual
> > + * address.
> > + *
> > + * This version of ioremap ensures that the memory is marked cachable by
> > + * the CPU.  Also enables full write-combining.       Useful for some
> > + * memory-like regions on I/O busses.
> > + */
> > +#define ioremap_cache(offset, size)                          \
> > +     ioremap_prot((offset), (size), _CACHE_CC)
> > +
> > +static inline void iounmap(const volatile void __iomem *addr)
> > +{
> > +}
> > +
> > +#define mmiowb() asm volatile ("dbar 0" ::: "memory")
> > +
> > +/*
> > + * String version of I/O memory access operations.
> > + */
> > +extern void __memset_io(volatile void __iomem *dst, int c, size_t count);
> > +extern void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count);
> > +extern void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count);
> > +#define memset_io(c, v, l)     __memset_io((c), (v), (l))
> > +#define memcpy_fromio(a, c, l) __memcpy_fromio((a), (c), (l))
> > +#define memcpy_toio(c, a, l)   __memcpy_toio((c), (a), (l))
> > +
> > +#include <asm-generic/io.h>
> > +
> > +#endif /* _ASM_IO_H */
> > diff --git a/arch/loongarch/include/uapi/asm/swab.h b/arch/loongarch/include/uapi/asm/swab.h
> > new file mode 100644
> I've tested with gcc 12.1.0, the asm-generic version of swab expressions
> can be compiled into the optimal insn sequence both under -O2 and -Os.
> So this file could be removed while not affecting performance of related
> operations.
OK, remove it.

> > index 000000000000..95e02676b6fa
> > --- /dev/null
> > +++ b/arch/loongarch/include/uapi/asm/swab.h
> > @@ -0,0 +1,52 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Authors: Jun Yi <yijun@loongson.cn>
> > + *          Huacai Chen <chenhuacai@loongson.cn>
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_SWAB_H
> > +#define _ASM_SWAB_H
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/types.h>
> > +
> > +#define __SWAB_64_THRU_32__
> > +
> > +static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
> > +{
> > +     __asm__(
> > +     "       revb.2h %0, %1                  \n"
> > +     : "=r" (x)
> > +     : "r" (x));
> > +
> > +     return x;
> > +}
> > +#define __arch_swab16 __arch_swab16
> > +
> > +static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
> > +{
> > +     __asm__(
> > +     "       revb.2h %0, %1                  \n"
> > +     "       rotri.w %0, %0, 16              \n"
> > +     : "=r" (x)
> > +     : "r" (x));
> > +
> > +     return x;
> > +}
> > +#define __arch_swab32 __arch_swab32
> > +
> > +#ifdef __loongarch64
> > +static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
> > +{
> > +     __asm__(
> > +     "       revb.4h %0, %1                  \n"
> > +     "       revh.d  %0, %0                  \n"
> > +     : "=r" (x)
> > +     : "r" (x));
> > +
> > +     return x;
> > +}
> > +#define __arch_swab64 __arch_swab64
> > +#endif /* __loongarch64 */
> > +#endif /* _ASM_SWAB_H */
> > diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
> > new file mode 100644
> > index 000000000000..3531e3c60a6e
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/asm-offsets.c
> > @@ -0,0 +1,254 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * asm-offsets.c: Calculate pt_regs and task_struct offsets.
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/types.h>
> > +#include <linux/sched.h>
> > +#include <linux/mm.h>
> > +#include <linux/kbuild.h>
> > +#include <linux/suspend.h>
> > +#include <asm/cpu-info.h>
> > +#include <asm/ptrace.h>
> > +#include <asm/processor.h>
> > +
> > +void output_ptreg_defines(void)
> > +{
> > +     COMMENT("LoongArch pt_regs offsets.");
> > +     OFFSET(PT_R0, pt_regs, regs[0]);
> > +     OFFSET(PT_R1, pt_regs, regs[1]);
> > +     OFFSET(PT_R2, pt_regs, regs[2]);
> > +     OFFSET(PT_R3, pt_regs, regs[3]);
> > +     OFFSET(PT_R4, pt_regs, regs[4]);
> > +     OFFSET(PT_R5, pt_regs, regs[5]);
> > +     OFFSET(PT_R6, pt_regs, regs[6]);
> > +     OFFSET(PT_R7, pt_regs, regs[7]);
> > +     OFFSET(PT_R8, pt_regs, regs[8]);
> > +     OFFSET(PT_R9, pt_regs, regs[9]);
> > +     OFFSET(PT_R10, pt_regs, regs[10]);
> > +     OFFSET(PT_R11, pt_regs, regs[11]);
> > +     OFFSET(PT_R12, pt_regs, regs[12]);
> > +     OFFSET(PT_R13, pt_regs, regs[13]);
> > +     OFFSET(PT_R14, pt_regs, regs[14]);
> > +     OFFSET(PT_R15, pt_regs, regs[15]);
> > +     OFFSET(PT_R16, pt_regs, regs[16]);
> > +     OFFSET(PT_R17, pt_regs, regs[17]);
> > +     OFFSET(PT_R18, pt_regs, regs[18]);
> > +     OFFSET(PT_R19, pt_regs, regs[19]);
> > +     OFFSET(PT_R20, pt_regs, regs[20]);
> > +     OFFSET(PT_R21, pt_regs, regs[21]);
> > +     OFFSET(PT_R22, pt_regs, regs[22]);
> > +     OFFSET(PT_R23, pt_regs, regs[23]);
> > +     OFFSET(PT_R24, pt_regs, regs[24]);
> > +     OFFSET(PT_R25, pt_regs, regs[25]);
> > +     OFFSET(PT_R26, pt_regs, regs[26]);
> > +     OFFSET(PT_R27, pt_regs, regs[27]);
> > +     OFFSET(PT_R28, pt_regs, regs[28]);
> > +     OFFSET(PT_R29, pt_regs, regs[29]);
> > +     OFFSET(PT_R30, pt_regs, regs[30]);
> > +     OFFSET(PT_R31, pt_regs, regs[31]);
> > +     OFFSET(PT_CRMD, pt_regs, csr_crmd);
> > +     OFFSET(PT_PRMD, pt_regs, csr_prmd);
> > +     OFFSET(PT_EUEN, pt_regs, csr_euen);
> > +     OFFSET(PT_ECFG, pt_regs, csr_ecfg);
> > +     OFFSET(PT_ESTAT, pt_regs, csr_estat);
> > +     OFFSET(PT_ERA, pt_regs, csr_era);
> > +     OFFSET(PT_BVADDR, pt_regs, csr_badvaddr);
> > +     OFFSET(PT_ORIG_A0, pt_regs, orig_a0);
> > +     DEFINE(PT_SIZE, sizeof(struct pt_regs));
> > +     BLANK();
> > +}
> > +
> > +void output_task_defines(void)
> > +{
> > +     COMMENT("LoongArch task_struct offsets.");
> > +     OFFSET(TASK_STATE, task_struct, __state);
> > +     OFFSET(TASK_THREAD_INFO, task_struct, stack);
> > +     OFFSET(TASK_FLAGS, task_struct, flags);
> > +     OFFSET(TASK_MM, task_struct, mm);
> > +     OFFSET(TASK_PID, task_struct, pid);
> > +     DEFINE(TASK_STRUCT_SIZE, sizeof(struct task_struct));
> > +     BLANK();
> > +}
> > +
> > +void output_thread_info_defines(void)
> > +{
> > +     COMMENT("LoongArch thread_info offsets.");
> > +     OFFSET(TI_TASK, thread_info, task);
> > +     OFFSET(TI_FLAGS, thread_info, flags);
> > +     OFFSET(TI_TP_VALUE, thread_info, tp_value);
> > +     OFFSET(TI_CPU, thread_info, cpu);
> > +     OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
> > +     OFFSET(TI_REGS, thread_info, regs);
> > +     DEFINE(_THREAD_SIZE, THREAD_SIZE);
> > +     DEFINE(_THREAD_MASK, THREAD_MASK);
> > +     DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
> > +     DEFINE(_IRQ_STACK_START, IRQ_STACK_START);
> > +     BLANK();
> > +}
> > +
> > +void output_thread_defines(void)
> > +{
> > +     COMMENT("LoongArch specific thread_struct offsets.");
> > +     OFFSET(THREAD_REG01, task_struct, thread.reg01);
> > +     OFFSET(THREAD_REG03, task_struct, thread.reg03);
> > +     OFFSET(THREAD_REG22, task_struct, thread.reg22);
> > +     OFFSET(THREAD_REG23, task_struct, thread.reg23);
> > +     OFFSET(THREAD_REG24, task_struct, thread.reg24);
> > +     OFFSET(THREAD_REG25, task_struct, thread.reg25);
> > +     OFFSET(THREAD_REG26, task_struct, thread.reg26);
> > +     OFFSET(THREAD_REG27, task_struct, thread.reg27);
> > +     OFFSET(THREAD_REG28, task_struct, thread.reg28);
> > +     OFFSET(THREAD_REG29, task_struct, thread.reg29);
> > +     OFFSET(THREAD_REG30, task_struct, thread.reg30);
> > +     OFFSET(THREAD_REG31, task_struct, thread.reg31);
> > +     OFFSET(THREAD_CSRCRMD, task_struct,
> > +            thread.csr_crmd);
> > +     OFFSET(THREAD_CSRPRMD, task_struct,
> > +            thread.csr_prmd);
> > +     OFFSET(THREAD_CSREUEN, task_struct,
> > +            thread.csr_euen);
> > +     OFFSET(THREAD_CSRECFG, task_struct,
> > +            thread.csr_ecfg);
> > +
> > +     OFFSET(THREAD_SCR0, task_struct, thread.scr0);
> > +     OFFSET(THREAD_SCR1, task_struct, thread.scr1);
> > +     OFFSET(THREAD_SCR2, task_struct, thread.scr2);
> > +     OFFSET(THREAD_SCR3, task_struct, thread.scr3);
> > +
> > +     OFFSET(THREAD_EFLAGS, task_struct, thread.eflags);
> > +
> > +     OFFSET(THREAD_FPU, task_struct, thread.fpu);
> > +
> > +     OFFSET(THREAD_BVADDR, task_struct, \
> > +            thread.csr_badvaddr);
> > +     OFFSET(THREAD_ECODE, task_struct, \
> > +            thread.error_code);
> > +     OFFSET(THREAD_TRAPNO, task_struct, thread.trap_nr);
> > +     BLANK();
> > +}
> > +
> > +void output_thread_fpu_defines(void)
> > +{
> > +     OFFSET(THREAD_FPR0, loongarch_fpu, fpr[0]);
> > +     OFFSET(THREAD_FPR1, loongarch_fpu, fpr[1]);
> > +     OFFSET(THREAD_FPR2, loongarch_fpu, fpr[2]);
> > +     OFFSET(THREAD_FPR3, loongarch_fpu, fpr[3]);
> > +     OFFSET(THREAD_FPR4, loongarch_fpu, fpr[4]);
> > +     OFFSET(THREAD_FPR5, loongarch_fpu, fpr[5]);
> > +     OFFSET(THREAD_FPR6, loongarch_fpu, fpr[6]);
> > +     OFFSET(THREAD_FPR7, loongarch_fpu, fpr[7]);
> > +     OFFSET(THREAD_FPR8, loongarch_fpu, fpr[8]);
> > +     OFFSET(THREAD_FPR9, loongarch_fpu, fpr[9]);
> > +     OFFSET(THREAD_FPR10, loongarch_fpu, fpr[10]);
> > +     OFFSET(THREAD_FPR11, loongarch_fpu, fpr[11]);
> > +     OFFSET(THREAD_FPR12, loongarch_fpu, fpr[12]);
> > +     OFFSET(THREAD_FPR13, loongarch_fpu, fpr[13]);
> > +     OFFSET(THREAD_FPR14, loongarch_fpu, fpr[14]);
> > +     OFFSET(THREAD_FPR15, loongarch_fpu, fpr[15]);
> > +     OFFSET(THREAD_FPR16, loongarch_fpu, fpr[16]);
> > +     OFFSET(THREAD_FPR17, loongarch_fpu, fpr[17]);
> > +     OFFSET(THREAD_FPR18, loongarch_fpu, fpr[18]);
> > +     OFFSET(THREAD_FPR19, loongarch_fpu, fpr[19]);
> > +     OFFSET(THREAD_FPR20, loongarch_fpu, fpr[20]);
> > +     OFFSET(THREAD_FPR21, loongarch_fpu, fpr[21]);
> > +     OFFSET(THREAD_FPR22, loongarch_fpu, fpr[22]);
> > +     OFFSET(THREAD_FPR23, loongarch_fpu, fpr[23]);
> > +     OFFSET(THREAD_FPR24, loongarch_fpu, fpr[24]);
> > +     OFFSET(THREAD_FPR25, loongarch_fpu, fpr[25]);
> > +     OFFSET(THREAD_FPR26, loongarch_fpu, fpr[26]);
> > +     OFFSET(THREAD_FPR27, loongarch_fpu, fpr[27]);
> > +     OFFSET(THREAD_FPR28, loongarch_fpu, fpr[28]);
> > +     OFFSET(THREAD_FPR29, loongarch_fpu, fpr[29]);
> > +     OFFSET(THREAD_FPR30, loongarch_fpu, fpr[30]);
> > +     OFFSET(THREAD_FPR31, loongarch_fpu, fpr[31]);
> > +
> > +     OFFSET(THREAD_FCSR, loongarch_fpu, fcsr);
> > +     OFFSET(THREAD_FCC,  loongarch_fpu, fcc);
> > +     OFFSET(THREAD_VCSR, loongarch_fpu, vcsr);
> > +     BLANK();
> > +}
> > +
> > +void output_mm_defines(void)
> > +{
> > +     COMMENT("Size of struct page");
> > +     DEFINE(STRUCT_PAGE_SIZE, sizeof(struct page));
> > +     BLANK();
> > +     COMMENT("Linux mm_struct offsets.");
> > +     OFFSET(MM_USERS, mm_struct, mm_users);
> > +     OFFSET(MM_PGD, mm_struct, pgd);
> > +     OFFSET(MM_CONTEXT, mm_struct, context);
> > +     BLANK();
> > +     DEFINE(_PGD_T_SIZE, sizeof(pgd_t));
> > +     DEFINE(_PMD_T_SIZE, sizeof(pmd_t));
> > +     DEFINE(_PTE_T_SIZE, sizeof(pte_t));
> > +     BLANK();
> > +     DEFINE(_PGD_T_LOG2, PGD_T_LOG2);
> > +#ifndef __PAGETABLE_PMD_FOLDED
> > +     DEFINE(_PMD_T_LOG2, PMD_T_LOG2);
> > +#endif
> > +     DEFINE(_PTE_T_LOG2, PTE_T_LOG2);
> > +     BLANK();
> > +     DEFINE(_PGD_ORDER, PGD_ORDER);
> > +#ifndef __PAGETABLE_PMD_FOLDED
> > +     DEFINE(_PMD_ORDER, PMD_ORDER);
> > +#endif
> > +     DEFINE(_PTE_ORDER, PTE_ORDER);
> > +     BLANK();
> > +     DEFINE(_PMD_SHIFT, PMD_SHIFT);
> > +     DEFINE(_PGDIR_SHIFT, PGDIR_SHIFT);
> > +     BLANK();
> > +     DEFINE(_PTRS_PER_PGD, PTRS_PER_PGD);
> > +     DEFINE(_PTRS_PER_PMD, PTRS_PER_PMD);
> > +     DEFINE(_PTRS_PER_PTE, PTRS_PER_PTE);
> > +     BLANK();
> > +     DEFINE(_PAGE_SHIFT, PAGE_SHIFT);
> > +     DEFINE(_PAGE_SIZE, PAGE_SIZE);
> > +     BLANK();
> > +}
> > +
> > +void output_sc_defines(void)
> > +{
> > +     COMMENT("Linux sigcontext offsets.");
> > +     OFFSET(SC_REGS, sigcontext, sc_regs);
> > +     OFFSET(SC_PC, sigcontext, sc_pc);
> > +     BLANK();
> > +}
> > +
> > +void output_signal_defines(void)
> > +{
> > +     COMMENT("Linux signal numbers.");
> > +     DEFINE(_SIGHUP, SIGHUP);
> > +     DEFINE(_SIGINT, SIGINT);
> > +     DEFINE(_SIGQUIT, SIGQUIT);
> > +     DEFINE(_SIGILL, SIGILL);
> > +     DEFINE(_SIGTRAP, SIGTRAP);
> > +     DEFINE(_SIGIOT, SIGIOT);
> > +     DEFINE(_SIGABRT, SIGABRT);
> > +     DEFINE(_SIGFPE, SIGFPE);
> > +     DEFINE(_SIGKILL, SIGKILL);
> > +     DEFINE(_SIGBUS, SIGBUS);
> > +     DEFINE(_SIGSEGV, SIGSEGV);
> > +     DEFINE(_SIGSYS, SIGSYS);
> > +     DEFINE(_SIGPIPE, SIGPIPE);
> > +     DEFINE(_SIGALRM, SIGALRM);
> > +     DEFINE(_SIGTERM, SIGTERM);
> > +     DEFINE(_SIGUSR1, SIGUSR1);
> > +     DEFINE(_SIGUSR2, SIGUSR2);
> > +     DEFINE(_SIGCHLD, SIGCHLD);
> > +     DEFINE(_SIGPWR, SIGPWR);
> > +     DEFINE(_SIGWINCH, SIGWINCH);
> > +     DEFINE(_SIGURG, SIGURG);
> > +     DEFINE(_SIGIO, SIGIO);
> > +     DEFINE(_SIGSTOP, SIGSTOP);
> > +     DEFINE(_SIGTSTP, SIGTSTP);
> > +     DEFINE(_SIGCONT, SIGCONT);
> > +     DEFINE(_SIGTTIN, SIGTTIN);
> > +     DEFINE(_SIGTTOU, SIGTTOU);
> > +     DEFINE(_SIGVTALRM, SIGVTALRM);
> > +     DEFINE(_SIGPROF, SIGPROF);
> > +     DEFINE(_SIGXCPU, SIGXCPU);
> > +     DEFINE(_SIGXFSZ, SIGXFSZ);
> > +     BLANK();
> > +}
> > diff --git a/arch/loongarch/kernel/io.c b/arch/loongarch/kernel/io.c
> > new file mode 100644
> > index 000000000000..cb85bda5a6ad
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/io.c
> > @@ -0,0 +1,94 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/export.h>
> > +#include <linux/types.h>
> > +#include <linux/io.h>
> > +
> > +/*
> > + * Copy data from IO memory space to "real" memory space.
> > + */
> > +void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
> > +{
> > +     while (count && !IS_ALIGNED((unsigned long)from, 8)) {
> > +             *(u8 *)to = __raw_readb(from);
> > +             from++;
> > +             to++;
> > +             count--;
> > +     }
> > +
> > +     while (count >= 8) {
> > +             *(u64 *)to = __raw_readq(from);
> > +             from += 8;
> > +             to += 8;
> > +             count -= 8;
> > +     }
> > +
> > +     while (count) {
> > +             *(u8 *)to = __raw_readb(from);
> > +             from++;
> > +             to++;
> > +             count--;
> > +     }
> > +}
> > +EXPORT_SYMBOL(__memcpy_fromio);
> > +
> > +/*
> > + * Copy data from "real" memory space to IO memory space.
> > + */
> > +void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
> > +{
> > +     while (count && !IS_ALIGNED((unsigned long)to, 8)) {
> > +             __raw_writeb(*(u8 *)from, to);
> > +             from++;
> > +             to++;
> > +             count--;
> > +     }
> > +
> > +     while (count >= 8) {
> > +             __raw_writeq(*(u64 *)from, to);
> > +             from += 8;
> > +             to += 8;
> > +             count -= 8;
> > +     }
> > +
> > +     while (count) {
> > +             __raw_writeb(*(u8 *)from, to);
> > +             from++;
> > +             to++;
> > +             count--;
> > +     }
> > +}
> > +EXPORT_SYMBOL(__memcpy_toio);
> > +
> > +/*
> > + * "memset" on IO memory space.
> > + */
> > +void __memset_io(volatile void __iomem *dst, int c, size_t count)
> > +{
> > +     u64 qc = (u8)c;
> > +
> > +     qc |= qc << 8;
> > +     qc |= qc << 16;
> > +     qc |= qc << 32;
> > +
> > +     while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
> > +             __raw_writeb(c, dst);
> > +             dst++;
> > +             count--;
> > +     }
> > +
> > +     while (count >= 8) {
> > +             __raw_writeq(qc, dst);
> > +             dst += 8;
> > +             count -= 8;
> > +     }
> > +
> > +     while (count) {
> > +             __raw_writeb(c, dst);
> > +             dst++;
> > +             count--;
> > +     }
> > +}
> > +EXPORT_SYMBOL(__memset_io);
> > diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.c
> > new file mode 100644
> > index 000000000000..d1f36b510297
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/proc.c
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <linux/delay.h>
> > +#include <linux/kernel.h>
> > +#include <linux/sched.h>
> > +#include <linux/seq_file.h>
> > +#include <asm/bootinfo.h>
> > +#include <asm/cpu.h>
> > +#include <asm/cpu-features.h>
> > +#include <asm/idle.h>
> > +#include <asm/processor.h>
> > +#include <asm/time.h>
> > +
> > +/*
> > + * No lock; only written during early bootup by CPU 0.
> > + */
> > +static RAW_NOTIFIER_HEAD(proc_cpuinfo_chain);
> > +
> > +int __ref register_proc_cpuinfo_notifier(struct notifier_block *nb)
> > +{
> > +     return raw_notifier_chain_register(&proc_cpuinfo_chain, nb);
> > +}
> > +
> > +int proc_cpuinfo_notifier_call_chain(unsigned long val, void *v)
> > +{
> > +     return raw_notifier_call_chain(&proc_cpuinfo_chain, val, v);
> > +}
> > +
> > +static int show_cpuinfo(struct seq_file *m, void *v)
> > +{
> > +     unsigned long n = (unsigned long) v - 1;
> > +     unsigned int version = cpu_data[n].processor_id & 0xff;
> > +     unsigned int fp_version = cpu_data[n].fpu_vers;
> > +     struct proc_cpuinfo_notifier_args proc_cpuinfo_notifier_args;
> > +
> > +     /*
> > +      * For the first processor also print the system type
> > +      */
> > +     if (n == 0)
> > +             seq_printf(m, "system type\t\t: %s\n", get_system_type());
> We could output an additional newline to break the "global" section from
> the following blocks describing processors.
> > +
> > +     seq_printf(m, "processor\t\t: %ld\n", n);
> > +     seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
> > +     seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
> > +     seq_printf(m, "CPU Family\t\t: %s\n", __cpu_family[n]);
> > +     seq_printf(m, "Model Name\t\t: %s\n", __cpu_full_name[n]);
> > +     seq_printf(m, "CPU Revision\t\t: 0x%02x\n", version);
> > +     seq_printf(m, "FPU Revision\t\t: 0x%02x\n", fp_version);
> > +     seq_printf(m, "CPU MHz\t\t\t: %llu.%02llu\n",
> > +                   cpu_clock_freq / 1000000, (cpu_clock_freq / 10000) % 100);
> > +     seq_printf(m, "BogoMIPS\t\t: %llu.%02llu\n",
> > +                   (lpj_fine * cpu_clock_freq / const_clock_freq) / (500000/HZ),
> > +                   ((lpj_fine * cpu_clock_freq / const_clock_freq) / (5000/HZ)) % 100);
> > +     seq_printf(m, "TLB Entries\t\t: %d\n", cpu_data[n].tlbsize);
> > +     seq_printf(m, "Address Sizes\t\t: %d bits physical, %d bits virtual\n",
> > +                   cpu_pabits + 1, cpu_vabits + 1);
> > +
> > +     seq_printf(m, "ISA\t\t\t:");
> > +     if (cpu_has_loongarch32)
> > +             seq_printf(m, "%s", " loongarch32");
> > +     if (cpu_has_loongarch64)
> > +             seq_printf(m, "%s", " loongarch64");
> Those printf's could simply be like seq_printf(m, " loongarch32"),
> without the "%s". Same for all occurrences below.
OK, thanks.

> > +     seq_printf(m, "\n");
> > +
> > +     seq_printf(m, "Features\t\t:");
> > +     if (cpu_has_cpucfg)     seq_printf(m, "%s", " cpucfg");
> > +     if (cpu_has_lam)        seq_printf(m, "%s", " lam");
> > +     if (cpu_has_ual)        seq_printf(m, "%s", " ual");
> > +     if (cpu_has_fpu)        seq_printf(m, "%s", " fpu");
> > +     if (cpu_has_lsx)        seq_printf(m, "%s", " lsx");
> > +     if (cpu_has_lasx)       seq_printf(m, "%s", " lasx");
> > +     if (cpu_has_complex)    seq_printf(m, "%s", " complex");
> > +     if (cpu_has_crypto)     seq_printf(m, "%s", " crypto");
> > +     if (cpu_has_lvz)        seq_printf(m, "%s", " lvz");
> > +     if (cpu_has_lbt_x86)    seq_printf(m, "%s", " lbt_x86");
> > +     if (cpu_has_lbt_arm)    seq_printf(m, "%s", " lbt_arm");
> > +     if (cpu_has_lbt_mips)   seq_printf(m, "%s", " lbt_mips");
> > +     seq_printf(m, "\n");
> > +
> > +     seq_printf(m, "Hardware Watchpoint\t: %s",
> > +                   cpu_has_watch ? "yes, " : "no\n");
> > +     if (cpu_has_watch) {
> > +             seq_printf(m, "iwatch count: %d, dwatch count: %d\n",
> > +                   cpu_data[n].watch_ireg_count, cpu_data[n].watch_dreg_count);
> > +     }
> > +
> > +     proc_cpuinfo_notifier_args.m = m;
> > +     proc_cpuinfo_notifier_args.n = n;
> > +
> > +     raw_notifier_call_chain(&proc_cpuinfo_chain, 0,
> > +                             &proc_cpuinfo_notifier_args);
> > +
> > +     seq_printf(m, "\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static void *c_start(struct seq_file *m, loff_t *pos)
> > +{
> > +     unsigned long i = *pos;
> > +
> > +     return i < NR_CPUS ? (void *)(i + 1) : NULL;
> > +}
> > +
> > +static void *c_next(struct seq_file *m, void *v, loff_t *pos)
> > +{
> > +     ++*pos;
> > +     return c_start(m, pos);
> > +}
> > +
> > +static void c_stop(struct seq_file *m, void *v)
> > +{
> > +}
> > +
> > +const struct seq_operations cpuinfo_op = {
> > +     .start  = c_start,
> > +     .next   = c_next,
> > +     .stop   = c_stop,
> > +     .show   = show_cpuinfo,
> > +};
> > diff --git a/arch/loongarch/kernel/rtc.c b/arch/loongarch/kernel/rtc.c
> > new file mode 100644
> > index 000000000000..d7568385219f
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/rtc.c
> > @@ -0,0 +1,36 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <asm/loongson.h>
> > +
> > +#define RTC_TOYREAD0    0x2C
> > +#define RTC_YEAR        0x30
> > +
> > +unsigned long loongson_get_rtc_time(void)
> > +{
> > +     unsigned int year, mon, day, hour, min, sec;
> > +     unsigned int value;
> > +
> > +     value = ls7a_readl(LS7A_RTC_REG_BASE + RTC_TOYREAD0);
> > +     sec = (value >> 4) & 0x3f;
> > +     min = (value >> 10) & 0x3f;
> > +     hour = (value >> 16) & 0x1f;
> > +     day = (value >> 21) & 0x1f;
> > +     mon = (value >> 26) & 0x3f;
> > +     year = ls7a_readl(LS7A_RTC_REG_BASE + RTC_YEAR);
> > +
> > +     year = 1900 + year;
> > +
> > +     return mktime64(year, mon, day, hour, min, sec);
> > +}
> > +
> > +void read_persistent_clock64(struct timespec64 *ts)
> > +{
> > +     ts->tv_sec = loongson_get_rtc_time();
> > +     ts->tv_nsec = 0;
> > +}
>
> As Alexandre pointed out, just remove this rtc.c file.
OK, thanks.

Huacai
>
> With the other points addressed:
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
