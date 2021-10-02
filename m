Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130CC41FAF7
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 12:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhJBK6N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 06:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhJBK6M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 06:58:12 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021F4C061570;
        Sat,  2 Oct 2021 03:56:26 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id o124so14229485vsc.6;
        Sat, 02 Oct 2021 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZDzH47Dz/ksIEdFbbXgylzT5snJB3UJlYzzHZgtiMs=;
        b=EVx18iHOLbr2XRZVJs6G0GOXrttzREBj3rB+Ny3fOn2c9Y2uJ/9aurk8L0P/CSNabi
         d4xhpcvzjs6OTR4r4jtR5rPFHBtwtD+Lzeab06saUTleZp8KIkuocdK3qvjzQQNsMX9T
         vOO2hfi5Ba06Y3CRsovkzWZ3DHWFXmRuAyMBon9uazooxzGMtMjsDswubkhSTDykHtCM
         GXmfQM9uBGwHcb+A+BfEbqvqedrzbQ2hXKD8ScTtLxSuK7+N+hAqMRRC8rS6LccxnMcV
         I8mO7Ej9L/qXmHkdZkaZErhWwKwirYDncLHFJE/YXknthyy/blNu6OYQ6Z2VPrZ4gscp
         bXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZDzH47Dz/ksIEdFbbXgylzT5snJB3UJlYzzHZgtiMs=;
        b=r4knJOhL/X/Do5LWmaw1wIhzSvBGA5OkARnvVTkF+O3QiblnM+0F4xKkyFwNtOyi2o
         0AXU76PMP+MBtmx2/EPyj6EvgSc7fB1qBL4HYi0rzE7CCD8N9gKs7bbsIIsMofBdExy8
         erSbYAqTQKe/2AHNaYkeqdHprHdGCOXJ4bg3T3ZXEJ7SoE09DBz91ITjX93K00FT1rA7
         G2iWQEL/nLtmieY/sfNJibPQuZJs/YJeXfwzQ1cQkEejuPvipZXCAdp7BH87aWu7vCXV
         GETtKPMZbpyCsvuoiDo1b0fJNEUPZ6w6lbnUFHRtVF8MovfOb8U7Bh5wDnSgZakp3FXj
         CYyQ==
X-Gm-Message-State: AOAM5310BkKvyYKp4EObRLaijIQxNzydCpkQnsBzY1yh21Q+LZFe5fnD
        PVEuwdT3klNyo991xsY8ngVKYw6FWoIxiwHZDf0aj1/N7ZU=
X-Google-Smtp-Source: ABdhPJxLu9VPb640hE+Q0NwHhgWU7quRsTmWFc/lWTk6lQKCHUnWRVysPhOSBGKHw1e+E27JS3Hs85hVugU5zPR5bjU=
X-Received: by 2002:a67:cb96:: with SMTP id h22mr7789599vsl.3.1633172186082;
 Sat, 02 Oct 2021 03:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-17-chenhuacai@loongson.cn> <YVbq/kAZQimL3Vpc@hirez.programming.kicks-ass.net>
In-Reply-To: <YVbq/kAZQimL3Vpc@hirez.programming.kicks-ass.net>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 2 Oct 2021 18:56:13 +0800
Message-ID: <CAAhV-H6kp9_goRQNNPiUwygmsdtr9oKUAWOvPp2MxgKO2iix_w@mail.gmail.com>
Subject: Re: [PATCH V4 16/22] LoongArch: Add misc common routines
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Peter,

On Fri, Oct 1, 2021 at 7:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Sep 27, 2021 at 02:42:53PM +0800, Huacai Chen wrote:
> >  arch/loongarch/include/asm/cmpxchg.h     | 137 ++++++++++++
> >  arch/loongarch/kernel/cmpxchg.c          | 107 ++++++++++
>
> This really should have gone into the atomics/locking patch.
>
> > diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
> > new file mode 100644
> > index 000000000000..13ee1b62dc12
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/cmpxchg.h
> > @@ -0,0 +1,137 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef __ASM_CMPXCHG_H
> > +#define __ASM_CMPXCHG_H
> > +
> > +#include <linux/bug.h>
> > +#include <asm/barrier.h>
> > +#include <asm/compiler.h>
> > +
> > +#define __xchg_asm(amswap_db, m, val)                \
> > +({                                           \
> > +             __typeof(val) __ret;            \
> > +                                             \
> > +             __asm__ __volatile__ (          \
> > +             " "amswap_db" %1, %z2, %0 \n"   \
> > +             : "+ZB" (*m), "=&r" (__ret)     \
> > +             : "Jr" (val)                    \
> > +             : "memory");                    \
> > +                                             \
> > +             __ret;                          \
> > +})
> > +
> > +extern unsigned long __xchg_small(volatile void *ptr, unsigned long x,
> > +                               unsigned int size);
> > +
> > +static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
> > +                                int size)
> > +{
> > +     switch (size) {
> > +     case 1:
> > +     case 2:
> > +             return __xchg_small(ptr, x, size);
> > +
> > +     case 4:
> > +             return __xchg_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
> > +
> > +     case 8:
> > +             return __xchg_asm("amswap_db.d", (volatile u64 *)ptr, (u64)x);
> > +
> > +     default:
> > +             BUILD_BUG();
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +#define arch_xchg(ptr, x)                                            \
> > +({                                                                   \
> > +     __typeof__(*(ptr)) __res;                                       \
> > +                                                                     \
> > +     __res = (__typeof__(*(ptr)))                                    \
> > +             __xchg((ptr), (unsigned long)(x), sizeof(*(ptr)));      \
> > +                                                                     \
> > +     __res;                                                          \
> > +})
> > +
> > +#define __cmpxchg_asm(ld, st, m, old, new)                           \
> > +({                                                                   \
> > +     __typeof(old) __ret;                                            \
> > +                                                                     \
> > +     __asm__ __volatile__(                                           \
> > +     "1:     " ld "  %0, %2          # __cmpxchg_asm \n"             \
> > +     "       bne     %0, %z3, 2f                     \n"             \
> > +     "       or      $t0, %z4, $zero                 \n"             \
> > +     "       " st "  $t0, %1                         \n"             \
> > +     "       beq     $zero, $t0, 1b                  \n"             \
> > +     "2:                                             \n"             \
> > +     : "=&r" (__ret), "=ZB"(*m)                                      \
> > +     : "ZB"(*m), "Jr" (old), "Jr" (new)                              \
> > +     : "t0", "memory");                                              \
> > +                                                                     \
> > +     __ret;                                                          \
> > +})
> > +
> > +extern unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
> > +                                  unsigned long new, unsigned int size);
> > +
> > +static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> > +                                   unsigned long new, unsigned int size)
> > +{
> > +     switch (size) {
> > +     case 1:
> > +     case 2:
> > +             return __cmpxchg_small(ptr, old, new, size);
> > +
> > +     case 4:
> > +             return __cmpxchg_asm("ll.w", "sc.w", (volatile u32 *)ptr,
> > +                                  (u32)old, new);
> > +
> > +     case 8:
> > +             return __cmpxchg_asm("ll.d", "sc.d", (volatile u64 *)ptr,
> > +                                  (u64)old, new);
> > +
> > +     default:
> > +             BUILD_BUG();
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +#define arch_cmpxchg_local(ptr, old, new)                            \
> > +     ((__typeof__(*(ptr)))                                           \
> > +             __cmpxchg((ptr),                                        \
> > +                       (unsigned long)(__typeof__(*(ptr)))(old),     \
> > +                       (unsigned long)(__typeof__(*(ptr)))(new),     \
> > +                       sizeof(*(ptr))))
> > +
> > +#define arch_cmpxchg(ptr, old, new)                                  \
> > +({                                                                   \
> > +     __typeof__(*(ptr)) __res;                                       \
> > +                                                                     \
> > +     __res = arch_cmpxchg_local((ptr), (old), (new));                \
> > +                                                                     \
> > +     __res;                                                          \
> > +})
> > +
> > +#ifdef CONFIG_64BIT
> > +#define arch_cmpxchg64_local(ptr, o, n)                                      \
> > +  ({                                                                 \
> > +     BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> > +     arch_cmpxchg_local((ptr), (o), (n));                            \
> > +  })
> > +
> > +#define arch_cmpxchg64(ptr, o, n)                                    \
> > +  ({                                                                 \
> > +     BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> > +     arch_cmpxchg((ptr), (o), (n));                                  \
> > +  })
> > +#else
> > +#include <asm-generic/cmpxchg-local.h>
> > +#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
> > +#define arch_cmpxchg64(ptr, o, n) arch_cmpxchg64_local((ptr), (o), (n))
> > +#endif
> > +
> > +#endif /* __ASM_CMPXCHG_H */
>
> > diff --git a/arch/loongarch/kernel/cmpxchg.c b/arch/loongarch/kernel/cmpxchg.c
> > new file mode 100644
> > index 000000000000..81bb9d01a3b5
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/cmpxchg.c
> > @@ -0,0 +1,107 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + *
> > + * Derived from MIPS:
> > + * Copyright (C) 2017 Imagination Technologies
> > + * Author: Paul Burton <paul.burton@mips.com>
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <asm/cmpxchg.h>
> > +
> > +unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
> > +{
> > +     u32 old32, mask, temp;
> > +     volatile u32 *ptr32;
> > +     unsigned int shift;
> > +
> > +     /* Check that ptr is naturally aligned */
> > +     WARN_ON((unsigned long)ptr & (size - 1));
> > +
> > +     /* Mask value to the correct size. */
> > +     mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
> > +     val &= mask;
> > +
> > +     /*
> > +      * Calculate a shift & mask that correspond to the value we wish to
> > +      * exchange within the naturally aligned 4 byte integerthat includes
> > +      * it.
> > +      */
> > +     shift = (unsigned long)ptr & 0x3;
> > +     shift *= BITS_PER_BYTE;
> > +     mask <<= shift;
> > +
> > +     /*
> > +      * Calculate a pointer to the naturally aligned 4 byte integer that
> > +      * includes our byte of interest, and load its value.
> > +      */
> > +     ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
> > +
> > +     asm volatile (
> > +     "1:     ll.w            %0, %3          \n"
> > +     "       and             %1, %0, %4      \n"
> > +     "       or              %1, %1, %5      \n"
> > +     "       sc.w            %1, %2          \n"
> > +     "       beqz            %1, 1b          \n"
> > +     : "=&r" (old32), "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*ptr32)
> > +     : GCC_OFF_SMALL_ASM() (*ptr32), "Jr" (~mask), "Jr" (val << shift)
> > +     : "memory");
> > +
> > +     return (old32 & mask) >> shift;
> > +}
> > +
> > +unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
> > +                           unsigned long new, unsigned int size)
> > +{
> > +     u32 mask, old32, new32, load32, load;
> > +     volatile u32 *ptr32;
> > +     unsigned int shift;
> > +
> > +     /* Check that ptr is naturally aligned */
> > +     WARN_ON((unsigned long)ptr & (size - 1));
> > +
> > +     /* Mask inputs to the correct size. */
> > +     mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
> > +     old &= mask;
> > +     new &= mask;
> > +
> > +     /*
> > +      * Calculate a shift & mask that correspond to the value we wish to
> > +      * compare & exchange within the naturally aligned 4 byte integer
> > +      * that includes it.
> > +      */
> > +     shift = (unsigned long)ptr & 0x3;
> > +     shift *= BITS_PER_BYTE;
> > +     mask <<= shift;
> > +
> > +     /*
> > +      * Calculate a pointer to the naturally aligned 4 byte integer that
> > +      * includes our byte of interest, and load its value.
> > +      */
> > +     ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
> > +     load32 = *ptr32;
> > +
> > +     while (true) {
> > +             /*
> > +              * Ensure the byte we want to exchange matches the expected
> > +              * old value, and if not then bail.
> > +              */
> > +             load = (load32 & mask) >> shift;
> > +             if (load != old)
> > +                     return load;
> > +
> > +             /*
> > +              * Calculate the old & new values of the naturally aligned
> > +              * 4 byte integer that include the byte we want to exchange.
> > +              * Attempt to exchange the old value for the new value, and
> > +              * return if we succeed.
> > +              */
> > +             old32 = (load32 & ~mask) | (old << shift);
> > +             new32 = (load32 & ~mask) | (new << shift);
> > +             load32 = arch_cmpxchg(ptr32, old32, new32);
> > +             if (load32 == old32)
> > +                     return old;
> > +     }
>
> This is absolutely terrible, that really wants to be a single ll/sc
> loop.
OK, let's have a try.

Huacai
>
> > +}
