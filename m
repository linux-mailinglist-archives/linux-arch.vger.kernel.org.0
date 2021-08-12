Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811D53EA3E2
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 13:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhHLLkC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 07:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhHLLkB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 07:40:01 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE621C061765
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:39:36 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id i13so6481496ilm.11
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0wWoSxZUHl9VAmkaix27x3+GGnF/qyM2ieQD9shx6A=;
        b=cA2OjKSbMInt+NUGGQRLQFFs/6Fc1RQaWozcCvU9Kl4pMairN9tu0f9FYj3MzuKImD
         +5LZ4L1LvkdpnRFHLfngHwEKPKUNwZW76+0Nm4dIgKCHi86wMm4y5qTn2RPpa6dGM4fd
         9W4fe+BJ0HqhNPcu5cvgWlQpXfuxuNcywpbz5TuJK+Z9JS0/dRldRII6CcoJa+pmu1qN
         8KSkSR5v5I7CqMBnF+i9Ij1iUx2CZrTGPSBCFrj2Y6h9dLFQF544lrzvVSWsnX8ErRG7
         1du74OiFCgEt2FE5b7U9lk/7JGl09funrVIPCjoZQQ1yv6vPsZgixN2uYECtupvXC5l+
         QLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0wWoSxZUHl9VAmkaix27x3+GGnF/qyM2ieQD9shx6A=;
        b=VnwybQgXy6E5i7ilzo2L4sykAW92noU6foDWAbe2yOGVOgxR8CJeYVYME155Qd4JXS
         013GZh7iJY/IhXbgpXytTQ8pGVbe81IXQ7LBn6zOkb1O0iQv4/kC5KCsxhEIOtMCP+/Q
         Azxercz7VbPS3b1oBzAOxgbddc8Y54TXraauVs4hWimo9F4h04g0W+7ry+08D+OJAFVj
         L1zCHEAknYZ6KceOzCbx85SBAO+VtmeCMaLRENghfR9Q915bkbtlj+QIyl9yMXhFWxEC
         ns45jYZw5X99Bd9TDKooD+BXX3hOcClpB25OmSL7kuCu/YFrWvuqwW+cd4Mc/vtu+vOG
         rngg==
X-Gm-Message-State: AOAM531WUELL+pVwwvwzPYIaplyW/x1RYwK4vzA/BQpTDVzdMLg4f58j
        5Wd8ZDWXwfAXCVsOePXV9Qk6+1bgrso7N/h+kkE=
X-Google-Smtp-Source: ABdhPJz+K93enw2bys9Znj7L8SO936Zc8C5/3+B86eiMKcV0yU7+FbEXrz5Eh7l2aL+rkF0004GBwUS/KcER2wxyv38=
X-Received: by 2002:a92:da0d:: with SMTP id z13mr2390206ilm.95.1628768376075;
 Thu, 12 Aug 2021 04:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-18-chenhuacai@loongson.cn> <YOQ/P/C7yfgCeKct@hirez.programming.kicks-ass.net>
In-Reply-To: <YOQ/P/C7yfgCeKct@hirez.programming.kicks-ass.net>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 19:39:23 +0800
Message-ID: <CAAhV-H47zeE5mHD6Yv0oEWp_=JkHO_uyc6j+MRCovOtJeL-37Q@mail.gmail.com>
Subject: Re: [PATCH 17/19] LoongArch: Add multi-processor (SMP) support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

Hi, Peter,

On Tue, Jul 6, 2021 at 7:32 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 06, 2021 at 12:18:18PM +0800, Huacai Chen wrote:
> > diff --git a/arch/loongarch/include/asm/barrier.h b/arch/loongarch/include/asm/barrier.h
> > index 8ab8d8f15b88..ad09a3b31cba 100644
> > --- a/arch/loongarch/include/asm/barrier.h
> > +++ b/arch/loongarch/include/asm/barrier.h
> > @@ -20,6 +20,19 @@
> >  #define mb()         fast_mb()
> >  #define iob()                fast_iob()
> >
> > +#define __smp_mb()   __asm__ __volatile__("dbar 0" : : : "memory")
> > +#define __smp_rmb()  __asm__ __volatile__("dbar 0" : : : "memory")
> > +#define __smp_wmb()  __asm__ __volatile__("dbar 0" : : : "memory")
>
> :-(
>
> > +
> > +#ifdef CONFIG_SMP
> > +#define __WEAK_LLSC_MB               "       dbar 0  \n"
> > +#else
> > +#define __WEAK_LLSC_MB               "               \n"
> > +#endif
>
> Isn't that spelled smp_mb() ?
Yes, but __WEAK_LLSC_MB is used in inline asm.

>
> > +
> > +#define __smp_mb__before_atomic()    barrier()
> > +#define __smp_mb__after_atomic()     __smp_mb()
>
> Clarification please.
>
> Does this imply LL is sequentially consistent, while SC is not?
I'm wrong here, no mb() is needed after atomic operations.

Huacai
>
> > +
> >  /**
> >   * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
> >   * @index: array element index
> > @@ -48,6 +61,112 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
> >       return mask;
> >  }
> >
> > +#define __smp_load_acquire(p)                                                        \
> > +({                                                                           \
> > +     union { typeof(*p) __val; char __c[1]; } __u;                           \
> > +     unsigned long __tmp = 0;                                                        \
> > +     compiletime_assert_atomic_type(*p);                                     \
> > +     switch (sizeof(*p)) {                                                   \
> > +     case 1:                                                                 \
> > +             *(__u8 *)__u.__c = *(volatile __u8 *)p;                         \
> > +             __smp_mb();                                                     \
> > +             break;                                                          \
> > +     case 2:                                                                 \
> > +             *(__u16 *)__u.__c = *(volatile __u16 *)p;                       \
> > +             __smp_mb();                                                     \
> > +             break;                                                          \
> > +     case 4:                                                                 \
> > +             __asm__ __volatile__(                                           \
> > +             "amor.w %[val], %[tmp], %[mem]  \n"                             \
> > +             : [val] "=&r" (*(__u32 *)__u.__c)                               \
> > +             : [mem] "ZB" (*(u32 *) p), [tmp] "r" (__tmp)                    \
> > +             : "memory");                                                    \
> > +             break;                                                          \
> > +     case 8:                                                                 \
> > +             __asm__ __volatile__(                                           \
> > +             "amor.d %[val], %[tmp], %[mem]  \n"                             \
> > +             : [val] "=&r" (*(__u64 *)__u.__c)                               \
> > +             : [mem] "ZB" (*(u64 *) p), [tmp] "r" (__tmp)                    \
> > +             : "memory");                                                    \
> > +             break;                                                          \
> > +     default:                                                                \
> > +             barrier();                                                      \
> > +             __builtin_memcpy((void *)__u.__c, (const void *)p, sizeof(*p)); \
> > +             __smp_mb();                                                     \
> > +     }                                                                       \
> > +     __u.__val;                                                              \
> > +})
> > +
> > +#define __smp_store_release(p, v)                                            \
> > +do {                                                                         \
> > +     union { typeof(*p) __val; char __c[1]; } __u =                          \
> > +             { .__val = (__force typeof(*p)) (v) };                          \
> > +     unsigned long __tmp;                                                    \
> > +     compiletime_assert_atomic_type(*p);                                     \
> > +     switch (sizeof(*p)) {                                                   \
> > +     case 1:                                                                 \
> > +             __smp_mb();                                                     \
> > +             *(volatile __u8 *)p = *(__u8 *)__u.__c;                         \
> > +             break;                                                          \
> > +     case 2:                                                                 \
> > +             __smp_mb();                                                     \
> > +             *(volatile __u16 *)p = *(__u16 *)__u.__c;                       \
> > +             break;                                                          \
> > +     case 4:                                                                 \
> > +             __asm__ __volatile__(                                           \
> > +             "amswap.w %[tmp], %[val], %[mem]        \n"                     \
> > +             : [mem] "+ZB" (*(u32 *)p), [tmp] "=&r" (__tmp)                  \
> > +             : [val] "r" (*(__u32 *)__u.__c)                                 \
> > +             : );                                                            \
> > +             break;                                                          \
> > +     case 8:                                                                 \
> > +             __asm__ __volatile__(                                           \
> > +             "amswap.d %[tmp], %[val], %[mem]        \n"                     \
> > +             : [mem] "+ZB" (*(u64 *)p), [tmp] "=&r" (__tmp)                  \
> > +             : [val] "r" (*(__u64 *)__u.__c)                                 \
> > +             : );                                                            \
> > +             break;                                                          \
> > +     default:                                                                \
> > +             __smp_mb();                                                     \
> > +             __builtin_memcpy((void *)p, (const void *)__u.__c, sizeof(*p)); \
> > +             barrier();                                                      \
> > +     }                                                                       \
> > +} while (0)
>
> What's the actual ordering of those AMO things?
>
