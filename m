Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB95277D8
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 15:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiEONjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiEONi7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 09:38:59 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8DA2726;
        Sun, 15 May 2022 06:38:57 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id ay15so4892763uab.9;
        Sun, 15 May 2022 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYbdkXH0Nmwsc+6QYvYgBJSmCscJOeoc9/YrZk+sHoc=;
        b=nxJMcA+ev02Egprt1R2I25BS8xRwjplaL4tL4G0/fc5apatTCf02nitoPF6y8lQaA4
         wpFaOtAbEkhfXKEpfAspUP6WaCIfpzRuEAZ7uHy75Ezw7Tsr0cs0QKJi/w5pcnUk4QFn
         t41hfSQS83zPcNOxW9TdT8tt6TPPDc+pngcj7e4lWIVcEe5nM9T1t1od6i0F6H4GpNDE
         /wc1Dg/KKLBI5aJfBdbwLgQpron5KqFMQymGWWOpcxVlL/fVex/90d5G2UPtE4bmZVlR
         LK14Y1UbO1ki0LmBMikILeNj/y+l4tYldsOmJW9is85orNQOdwq3kWdobIbHVjlu8ve9
         kTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYbdkXH0Nmwsc+6QYvYgBJSmCscJOeoc9/YrZk+sHoc=;
        b=ArzJhbc/ZoNJ/hYCV06SdSgkdIzdT+36Mom/vl+yJWi68COanqJg4lswCi19BAVA+y
         DghrM53UEnXG6qhwRWIpONHLjEs4fb8NBnl1woFPBAvelZnH/wUGkrxitB6XQndC278S
         sblRiJYAwZvtoEzCuyMGWsCPRISKj+ukmgSGtFcneaYvv4FePeG/rWhFLCU7bpuTUgk4
         4C09xU8m8NNDs25U2BWpDwCjcxSfxt6ozWiAiKPzwgm2SVZwAxVjFKle1qplNBXkE45F
         aI6sz/omUgebzh0uBBrW1QYQq3nvguf2yStSyx9dya74hxS9vgM0bn5bRGWzL2pvDz0U
         L6aw==
X-Gm-Message-State: AOAM5304YyrbJ9LDwX1VQx8v5ePIZYd6WzTVSETMA7GIkT6pLX+MGou2
        bxkIrI9qIyOTfHEz+/PTeBrKrt4JiSu+0+3sJGo=
X-Google-Smtp-Source: ABdhPJyyd/cdH6Z2bqFmSGSZaNZPG7CWnoEl0UTG3PW0e1zNcqNqUmrnn89hQslQ2kfvfrE7SzTNUXlXYTNYx+uIQdA=
X-Received: by 2002:ab0:6999:0:b0:368:a1e8:74c9 with SMTP id
 t25-20020ab06999000000b00368a1e874c9mr1256120uaq.21.1652621936901; Sun, 15
 May 2022 06:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-13-chenhuacai@loongson.cn> <138da137-bb15-e3b9-c0fd-6106cf20fc96@xen0n.name>
In-Reply-To: <138da137-bb15-e3b9-c0fd-6106cf20fc96@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 21:38:45 +0800
Message-ID: <CAAhV-H5YQmrmq-n7xuNXO5DM2B05Jt9AFqS=k3WSS5mUU+FM0A@mail.gmail.com>
Subject: Re: [PATCH V10 12/22] LoongArch: Add memory management
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

On Sun, May 15, 2022 at 5:42 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi,
>
> Compared to other areas, I'm not that familiar with mm in general, so
> this review may not be as in-depth as I'd like. Still...
>
> On 5/14/22 16:03, Huacai Chen wrote:
> > Add memory management support for LoongArch, including: cache and tlb
> > management, page fault handling and ioremap/mmap support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/cache.h        |  13 +
> >   arch/loongarch/include/asm/cacheflush.h   |  80 ++++
> >   arch/loongarch/include/asm/cacheops.h     |  37 ++
> >   arch/loongarch/include/asm/fixmap.h       |  13 +
> >   arch/loongarch/include/asm/hugetlb.h      |  79 ++++
> >   arch/loongarch/include/asm/page.h         | 113 +++++
> >   arch/loongarch/include/asm/pgalloc.h      | 103 +++++
> >   arch/loongarch/include/asm/pgtable-bits.h | 131 ++++++
> >   arch/loongarch/include/asm/pgtable.h      | 532 ++++++++++++++++++++++
> >   arch/loongarch/include/asm/shmparam.h     |  12 +
> >   arch/loongarch/include/asm/sparsemem.h    |  23 +
> >   arch/loongarch/include/asm/tlb.h          | 216 +++++++++
> >   arch/loongarch/include/asm/tlbflush.h     |  35 ++
> >   arch/loongarch/include/asm/vmalloc.h      |   4 +
> >   arch/loongarch/mm/cache.c                 | 140 ++++++
> >   arch/loongarch/mm/extable.c               |  22 +
> >   arch/loongarch/mm/fault.c                 | 261 +++++++++++
> >   arch/loongarch/mm/hugetlbpage.c           |  87 ++++
> >   arch/loongarch/mm/init.c                  | 165 +++++++
> >   arch/loongarch/mm/ioremap.c               |  27 ++
> >   arch/loongarch/mm/maccess.c               |  10 +
> >   arch/loongarch/mm/mmap.c                  | 125 +++++
> >   arch/loongarch/mm/page.S                  |  84 ++++
> >   arch/loongarch/mm/pgtable.c               | 130 ++++++
> >   arch/loongarch/mm/tlb.c                   | 282 ++++++++++++
> >   arch/loongarch/mm/tlbex.S                 | 477 +++++++++++++++++++
> >   26 files changed, 3201 insertions(+)
> >   create mode 100644 arch/loongarch/include/asm/cache.h
> >   create mode 100644 arch/loongarch/include/asm/cacheflush.h
> >   create mode 100644 arch/loongarch/include/asm/cacheops.h
> >   create mode 100644 arch/loongarch/include/asm/fixmap.h
> >   create mode 100644 arch/loongarch/include/asm/hugetlb.h
> >   create mode 100644 arch/loongarch/include/asm/page.h
> >   create mode 100644 arch/loongarch/include/asm/pgalloc.h
> >   create mode 100644 arch/loongarch/include/asm/pgtable-bits.h
> >   create mode 100644 arch/loongarch/include/asm/pgtable.h
> >   create mode 100644 arch/loongarch/include/asm/shmparam.h
> >   create mode 100644 arch/loongarch/include/asm/sparsemem.h
> >   create mode 100644 arch/loongarch/include/asm/tlb.h
> >   create mode 100644 arch/loongarch/include/asm/tlbflush.h
> >   create mode 100644 arch/loongarch/include/asm/vmalloc.h
> >   create mode 100644 arch/loongarch/mm/cache.c
> >   create mode 100644 arch/loongarch/mm/extable.c
> >   create mode 100644 arch/loongarch/mm/fault.c
> >   create mode 100644 arch/loongarch/mm/hugetlbpage.c
> >   create mode 100644 arch/loongarch/mm/init.c
> >   create mode 100644 arch/loongarch/mm/ioremap.c
> >   create mode 100644 arch/loongarch/mm/maccess.c
> >   create mode 100644 arch/loongarch/mm/mmap.c
> >   create mode 100644 arch/loongarch/mm/page.S
> >   create mode 100644 arch/loongarch/mm/pgtable.c
> >   create mode 100644 arch/loongarch/mm/tlb.c
> >   create mode 100644 arch/loongarch/mm/tlbex.S
> >
> (snip)
> > diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/asm/tlb.h
> > new file mode 100644
> > index 000000000000..a9dda11c494b
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/tlb.h
> > @@ -0,0 +1,216 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef __ASM_TLB_H
> > +#define __ASM_TLB_H
> > +
> > +#include <linux/mm_types.h>
> > +#include <asm/cpu-features.h>
> > +#include <asm/loongarch.h>
> > +
> > +/*
> > + * TLB Invalidate Flush
> > + */
> > +static inline void tlbclr(void)
> > +{
> > +     __asm__ __volatile__("tlbclr");
> > +}
> > +
> > +static inline void tlbflush(void)
> > +{
> > +     __asm__ __volatile__("tlbflush");
> > +}
> > +
> > +/*
> > + * TLB R/W operations.
> > + */
> > +static inline void tlb_probe(void)
> > +{
> > +     __asm__ __volatile__("tlbsrch");
> > +}
> > +
> > +static inline void tlb_read(void)
> > +{
> > +     __asm__ __volatile__("tlbrd");
> > +}
> > +
> > +static inline void tlb_write_indexed(void)
> > +{
> > +     __asm__ __volatile__("tlbwr");
> > +}
> > +
> > +static inline void tlb_write_random(void)
> > +{
> > +     __asm__ __volatile__("tlbfill");
> > +}
> > +
> > +/*
> > + * Guest TLB Invalidate Flush
> > + */
> > +static inline void guest_tlbflush(void)
> > +{
> > +     __asm__ __volatile__(
> > +             ".word 0x6482401\n\t");
> > +}
>
> Do we want to add guest mm ops this early? KVM isn't part of initial
> bring-up. Leaving as-is would save some later work, though, and I'll
> leave the judgment to other reviewers as to whether to remove these. (My
> recommendation would of course be in favor of removal.)
>
> Plus it's interesting to see undocumented instruction words, this
> satisfies curiosity ;-)
>
> (Always better to properly support in binutils though.)
OK, they should be removed at present.

>
> > +
> > +/*
> > + * Guest TLB R/W operations.
> > + */
> > +static inline void guest_tlb_probe(void)
> > +{
> > +     __asm__ __volatile__(
> > +             ".word 0x6482801\n\t");
> > +}
> > +
> > +static inline void guest_tlb_read(void)
> > +{
> > +     __asm__ __volatile__(
> > +             ".word 0x6482c01\n\t");
> > +}
> > +
> > +static inline void guest_tlb_write_indexed(void)
> > +{
> > +     __asm__ __volatile__(
> > +             ".word 0x6483001\n\t");
> > +}
> > +
> > +static inline void guest_tlb_write_random(void)
> > +{
> > +     __asm__ __volatile__(
> > +             ".word 0x6483401\n\t");
> > +}
> > +
> > +enum invtlb_ops {
> > +     /* Invalid all tlb */
> > +     INVTLB_ALL = 0x0,
> > +     /* Invalid current tlb */
> > +     INVTLB_CURRENT_ALL = 0x1,
> > +     /* Invalid all global=1 lines in current tlb */
> > +     INVTLB_CURRENT_GTRUE = 0x2,
> > +     /* Invalid all global=0 lines in current tlb */
> > +     INVTLB_CURRENT_GFALSE = 0x3,
> > +     /* Invalid global=0 and matched asid lines in current tlb */
> > +     INVTLB_GFALSE_AND_ASID = 0x4,
> > +     /* Invalid addr with global=0 and matched asid in current tlb */
> > +     INVTLB_ADDR_GFALSE_AND_ASID = 0x5,
> > +     /* Invalid addr with global=1 or matched asid in current tlb */
> > +     INVTLB_ADDR_GTRUE_OR_ASID = 0x6,
> > +     /* Invalid matched gid in guest tlb */
> > +     INVGTLB_GID = 0x9,
> > +     /* Invalid global=1, matched gid in guest tlb */
> > +     INVGTLB_GID_GTRUE = 0xa,
> > +     /* Invalid global=0, matched gid in guest tlb */
> > +     INVGTLB_GID_GFALSE = 0xb,
> > +     /* Invalid global=0, matched gid and asid in guest tlb */
> > +     INVGTLB_GID_GFALSE_ASID = 0xc,
> > +     /* Invalid global=0 , matched gid, asid and addr in guest tlb */
> > +     INVGTLB_GID_GFALSE_ASID_ADDR = 0xd,
> > +     /* Invalid global=1 , matched gid, asid and addr in guest tlb */
> > +     INVGTLB_GID_GTRUE_ASID_ADDR = 0xe,
> > +     /* Invalid all gid gva-->gpa guest tlb */
> > +     INVGTLB_ALLGID_GVA_TO_GPA = 0x10,
> > +     /* Invalid all gid gpa-->hpa tlb */
> > +     INVTLB_ALLGID_GPA_TO_HPA = 0x11,
> > +     /* Invalid all gid tlb, including  gva-->gpa and gpa-->hpa */
> > +     INVTLB_ALLGID = 0x12,
> > +     /* Invalid matched gid gva-->gpa guest tlb */
> > +     INVGTLB_GID_GVA_TO_GPA = 0x13,
> > +     /* Invalid matched gid gpa-->hpa tlb */
> > +     INVTLB_GID_GPA_TO_HPA = 0x14,
> > +     /* Invalid matched gid tlb,including gva-->gpa and gpa-->hpa */
> > +     INVTLB_GID_ALL = 0x15,
> > +     /* Invalid matched gid and addr gpa-->hpa tlb */
> > +     INVTLB_GID_ADDR = 0x16,
> > +};
> > +
> > +/*
> > + * invtlb op info addr
> > + * (0x1 << 26) | (0x24 << 20) | (0x13 << 15) |
> > + * (addr << 10) | (info << 5) | op
> > + */
> > +static inline void invtlb(u32 op, u32 info, u64 addr)
> > +{
> > +     __asm__ __volatile__(
> > +             "parse_r addr,%0\n\t"
> > +             "parse_r info,%1\n\t"
> > +             ".word ((0x6498000) | (addr << 10) | (info << 5) | %2)\n\t"
> Isn't INVTLB already supported by binutils?
> > +             :
> > +             : "r"(addr), "r"(info), "i"(op)
> > +             :
> > +             );
> > +}
> > +
> > +static inline void invtlb_addr(u32 op, u32 info, u64 addr)
> > +{
> > +     __asm__ __volatile__(
> > +             "parse_r addr,%0\n\t"
> > +             ".word ((0x6498000) | (addr << 10) | (0 << 5) | %1)\n\t"
> > +             :
> > +             : "r"(addr), "i"(op)
> > +             :
> > +             );
> > +}
> > +
> > +static inline void invtlb_info(u32 op, u32 info, u64 addr)
> > +{
> > +     __asm__ __volatile__(
> > +             "parse_r info,%0\n\t"
> > +             ".word ((0x6498000) | (0 << 10) | (info << 5) | %1)\n\t"
> > +             :
> > +             : "r"(info), "i"(op)
> > +             :
> > +             );
> > +}
> > +
> > +static inline void invtlb_all(u32 op, u32 info, u64 addr)
> > +{
> > +     __asm__ __volatile__(
> > +             ".word ((0x6498000) | (0 << 10) | (0 << 5) | %0)\n\t"
> > +             :
> > +             : "i"(op)
> > +             :
> > +             );
> > +}
> > +
>
> (rest of patch snipped for brevity)
>
> Admittedly I didn't really look into the rest for correctness, only
> briefly checking code style. However as several people (me included)
> already used the port for heavy compilation loads, stresses and things
> like that, the code should be in good standing too.
>
> With the nits addressed:
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
Thanks for your review.

Huacai
>
