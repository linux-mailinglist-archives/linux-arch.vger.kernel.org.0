Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A3D52780A
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 16:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiEOO1n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 10:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbiEOO1f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 10:27:35 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133262A738;
        Sun, 15 May 2022 07:27:34 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id b7so8689753vsq.1;
        Sun, 15 May 2022 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9vRTPqB5km30EFKjWmm0hrMIjYZDUFzlrTxSPIyZiQ=;
        b=ZJp0s8GJQ9ks7sfZP2k27G/amm1idme92/B2z0A6v2QeGVI5S+7Us05uo2fwqYvMIW
         wOjDpGTORiAyrHhlaMx2FUQ2X9rAko/+TC78063SjAViJtc5JQ+brMQAnT01MJKpug5b
         KpRZkdUVFqSE6UZ/pc/x2/q7LgrqzzIhKZIQx2qPKs7oHfd+wsqzyYPD725/gIA9Te6c
         PlxxjD3CA1skJUORTTcuUWgO6E6VkrS3LuH8WxErVORbxTvzRrDmknrpebAJEF/Bsz5J
         TeozRHQysdf6CCVl3eLbDNsbFubtDVZG7VqOEote+VsNeqtwkNER/t8gpH1i1krD0cnL
         BNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9vRTPqB5km30EFKjWmm0hrMIjYZDUFzlrTxSPIyZiQ=;
        b=fHdNI4cukCGcb1/F9MyXSuSuTpF1c9kGolJNxd6mfjPrk2zsCsoiQF1E4Lc7MI/oLe
         KsGsgS/LBUwb6ij4ok4+skggcw88CXDr+Xplxs3o0q+1PITi85CjuOyTeiwp5F3ZxYpU
         TO/9NJzGe+wJGEcmTGkxThpLXm7vkn+6RhpIOF2DlYa3z/+UxV9oSr7vlksDUcfijW8o
         rUBcwqNyuHnEJr3v95TQmTvglnFsC0wbaNlnEj2+96iDIRuS6XHorEtoJ09LNYm1mwqx
         z75G3C2In4Q5XaihLywqRbfDU/ipSVTP9rVeY+qhDGGetIhcOtSpgyutlCnABNMRGqmN
         efqg==
X-Gm-Message-State: AOAM530CmIfACXRu3QG636pjjEPloGiKaGwo+644bk3Yd2/rtu3INOGt
        KNXX4HXEuEjfmlSvL3DckUo6MybUgKB+g5ytXyg=
X-Google-Smtp-Source: ABdhPJzl8DqChoIZcduHgXwXTDDwxdZueVyjU+Q/M9I0zijuBBjQwAQjJ8bZ0MNRrNk5smwQknzm9LqsjOzIZH83eW0=
X-Received: by 2002:a67:b142:0:b0:32c:e806:a0b0 with SMTP id
 z2-20020a67b142000000b0032ce806a0b0mr4963831vsl.71.1652624853135; Sun, 15 May
 2022 07:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-18-chenhuacai@loongson.cn> <28828250-ced3-9b03-26fc-63323be12f3a@xen0n.name>
In-Reply-To: <28828250-ced3-9b03-26fc-63323be12f3a@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 22:27:22 +0800
Message-ID: <CAAhV-H7bCwKpV7j5HMdhjHAive8xGFa1KVkNS+jonfExzMcYzA@mail.gmail.com>
Subject: Re: [PATCH V10 17/22] LoongArch: Add some library functions
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

On Sun, May 15, 2022 at 9:12 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi,
>
> On 5/14/22 16:03, Huacai Chen wrote:
> > Add some library functions for LoongArch, including: delay, memset,
> > memcpy, memmove, copy_user, strncpy_user, strnlen_user and tlb dump
> > functions.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/delay.h  |  26 +++++++
> >   arch/loongarch/include/asm/string.h |  12 +++
> >   arch/loongarch/lib/clear_user.S     |  43 +++++++++++
> >   arch/loongarch/lib/copy_user.S      |  47 ++++++++++++
> >   arch/loongarch/lib/delay.c          |  43 +++++++++++
> >   arch/loongarch/lib/dump_tlb.c       | 111 ++++++++++++++++++++++++++++
> >   6 files changed, 282 insertions(+)
> >   create mode 100644 arch/loongarch/include/asm/delay.h
> >   create mode 100644 arch/loongarch/include/asm/string.h
> >   create mode 100644 arch/loongarch/lib/clear_user.S
> >   create mode 100644 arch/loongarch/lib/copy_user.S
> >   create mode 100644 arch/loongarch/lib/delay.c
> >   create mode 100644 arch/loongarch/lib/dump_tlb.c
> >
> > diff --git a/arch/loongarch/include/asm/delay.h b/arch/loongarch/include/asm/delay.h
> > new file mode 100644
> > index 000000000000..016b3aca65cb
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/delay.h
> > @@ -0,0 +1,26 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> This file is derived from MIPS so copyright should be marked here.
> > + */
> > +#ifndef _ASM_DELAY_H
> > +#define _ASM_DELAY_H
> > +
> > +#include <linux/param.h>
> > +
> > +extern void __delay(unsigned long loops);
> Argument is called "cycles" in the .c file.
OK, thanks.

> > +extern void __ndelay(unsigned long ns);
> > +extern void __udelay(unsigned long us);
> > +
> > +#define ndelay(ns) __ndelay(ns)
> > +#define udelay(us) __udelay(us)
> > +
> > +/* make sure "usecs *= ..." in udelay do not overflow. */
> > +#if HZ >= 1000
> > +#define MAX_UDELAY_MS        1
> > +#elif HZ <= 200
> > +#define MAX_UDELAY_MS        5
> > +#else
> > +#define MAX_UDELAY_MS        (1000 / HZ)
> > +#endif
> > +
> > +#endif /* _ASM_DELAY_H */
> > diff --git a/arch/loongarch/include/asm/string.h b/arch/loongarch/include/asm/string.h
> > new file mode 100644
> > index 000000000000..b07e60ded957
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/string.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_STRING_H
> > +#define _ASM_STRING_H
> > +
> > +extern void *memset(void *__s, int __c, size_t __count);
> > +extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
> > +extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
> > +
> > +#endif /* _ASM_STRING_H */
> > diff --git a/arch/loongarch/lib/clear_user.S b/arch/loongarch/lib/clear_user.S
> > new file mode 100644
> > index 000000000000..b8168d22ac80
> > --- /dev/null
> > +++ b/arch/loongarch/lib/clear_user.S
> > @@ -0,0 +1,43 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <asm/asm.h>
> > +#include <asm/asmmacro.h>
> > +#include <asm/export.h>
> > +#include <asm/regdef.h>
> > +
> > +.macro fixup_ex from, to, offset, fix
> > +.if \fix
> > +     .section .fixup, "ax"
> > +\to: addi.d  v0, a1, \offset
> > +     jr      ra
> > +     .previous
> > +.endif
> > +     .section __ex_table, "a"
> > +     PTR     \from\()b, \to\()b
> > +     .previous
> > +.endm
> > +
> > +/*
> > + * unsigned long __clear_user(void *addr, size_t size)
> > + *
> > + * a0: addr
> > + * a1: size
> > + */
> > +SYM_FUNC_START(__clear_user)
> > +     beqz    a1, 2f
> > +
> > +1:   st.b    zero, a0, 0
> > +     addi.d  a0, a0, 1
> > +     addi.d  a1, a1, -1
> > +     bgt     a1, zero, 1b
> > +
> > +2:   move    v0, a1
> > +     jr      ra
> > +
> > +     fixup_ex 1, 3, 0, 1
> > +SYM_FUNC_END(__clear_user)
> > +
> > +EXPORT_SYMBOL(__clear_user)
> > diff --git a/arch/loongarch/lib/copy_user.S b/arch/loongarch/lib/copy_user.S
> > new file mode 100644
> > index 000000000000..43ed26304954
> > --- /dev/null
> > +++ b/arch/loongarch/lib/copy_user.S
> > @@ -0,0 +1,47 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <asm/asm.h>
> > +#include <asm/asmmacro.h>
> > +#include <asm/export.h>
> > +#include <asm/regdef.h>
> > +
> > +.macro fixup_ex from, to, offset, fix
> > +.if \fix
> > +     .section .fixup, "ax"
> > +\to: addi.d  v0, a2, \offset
> > +     jr      ra
> > +     .previous
> > +.endif
> > +     .section __ex_table, "a"
> > +     PTR     \from\()b, \to\()b
> > +     .previous
> > +.endm
> > +
> > +/*
> > + * unsigned long __copy_user(void *to, const void *from, size_t n)
> > + *
> > + * a0: to
> > + * a1: from
> > + * a2: n
> > + */
> > +SYM_FUNC_START(__copy_user)
> > +     beqz    a2, 3f
> > +
> > +1:   ld.b    t0, a1, 0
> > +2:   st.b    t0, a0, 0
> > +     addi.d  a0, a0, 1
> > +     addi.d  a1, a1, 1
> > +     addi.d  a2, a2, -1
> > +     bgt     a2, zero, 1b
> > +
> > +3:   move    v0, a2
> > +     jr      ra
> > +
> > +     fixup_ex 1, 4, 0, 1
> > +     fixup_ex 2, 4, 0, 0
> > +SYM_FUNC_END(__copy_user)
> > +
> > +EXPORT_SYMBOL(__copy_user)
> > diff --git a/arch/loongarch/lib/delay.c b/arch/loongarch/lib/delay.c
> > new file mode 100644
> > index 000000000000..5d856694fcfe
> > --- /dev/null
> > +++ b/arch/loongarch/lib/delay.c
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> So is this file.
> > + */
> > +#include <linux/delay.h>
> > +#include <linux/export.h>
> > +#include <linux/smp.h>
> > +#include <linux/timex.h>
> > +
> > +#include <asm/compiler.h>
> > +#include <asm/processor.h>
> > +
> > +void __delay(unsigned long cycles)
> > +{
> > +     u64 t0 = get_cycles();
> > +
> > +     while ((unsigned long)(get_cycles() - t0) < cycles)
> > +             cpu_relax();
> > +}
> > +EXPORT_SYMBOL(__delay);
> > +
> > +/*
> > + * Division by multiplication: you don't have to worry about
> > + * loss of precision.
> > + *
> > + * Use only for very small delays ( < 1 msec).       Should probably use a
> > + * lookup table, really, as the multiplications take much too long with
> > + * short delays.  This is a "reasonable" implementation, though (and the
> > + * first constant multiplications gets optimized away if the delay is
> > + * a constant)
> > + */
> > +
> > +void __udelay(unsigned long us)
> > +{
> > +     __delay((us * 0x000010c7ull * HZ * lpj_fine) >> 32);
> > +}
> > +EXPORT_SYMBOL(__udelay);
> > +
> > +void __ndelay(unsigned long ns)
> > +{
> > +     __delay((ns * 0x00000005ull * HZ * lpj_fine) >> 32);
> > +}
> > +EXPORT_SYMBOL(__ndelay);
> > diff --git a/arch/loongarch/lib/dump_tlb.c b/arch/loongarch/lib/dump_tlb.c
> > new file mode 100644
> > index 000000000000..cda2c6bc7f09
> > --- /dev/null
> > +++ b/arch/loongarch/lib/dump_tlb.c
> > @@ -0,0 +1,111 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + *
> > + * Derived from MIPS:
> > + * Copyright (C) 1994, 1995 by Waldorf Electronics, written by Ralf Baechle.
> > + * Copyright (C) 1999 by Silicon Graphics, Inc.
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/mm.h>
> > +
> > +#include <asm/loongarch.h>
> > +#include <asm/page.h>
> > +#include <asm/pgtable.h>
> > +#include <asm/tlb.h>
> > +
> > +void dump_tlb_regs(void)
> > +{
> > +     const int field = 2 * sizeof(unsigned long);
> > +
> > +     pr_info("Index    : %0x\n", read_csr_tlbidx());
> > +     pr_info("PageSize : %0x\n", read_csr_pagesize());
> > +     pr_info("EntryHi  : %0*llx\n", field, read_csr_entryhi());
> > +     pr_info("EntryLo0 : %0*llx\n", field, read_csr_entrylo0());
> > +     pr_info("EntryLo1 : %0*llx\n", field, read_csr_entrylo1());
> > +}
> > +
> > +static void dump_tlb(int first, int last)
> > +{
> > +     unsigned long s_entryhi, entryhi, asid;
> > +     unsigned long long entrylo0, entrylo1, pa;
> > +     unsigned int index;
> > +     unsigned int s_index, s_asid;
> > +     unsigned int pagesize, c0, c1, i;
> > +     unsigned long asidmask = cpu_asid_mask(&current_cpu_data);
> > +     int pwidth = 11;
> > +     int vwidth = 11;
> > +     int asidwidth = DIV_ROUND_UP(ilog2(asidmask) + 1, 4);
> > +
> > +     s_entryhi = read_csr_entryhi();
> > +     s_index = read_csr_tlbidx();
> > +     s_asid = read_csr_asid();
> > +
> > +     for (i = first; i <= last; i++) {
> > +             write_csr_index(i);
> > +             tlb_read();
> > +             pagesize = read_csr_pagesize();
> > +             entryhi  = read_csr_entryhi();
> > +             entrylo0 = read_csr_entrylo0();
> > +             entrylo1 = read_csr_entrylo1();
> > +             index = read_csr_tlbidx();
> > +             asid = read_csr_asid();
> > +
> > +             /* EHINV bit marks entire entry as invalid */
> > +             if (index & CSR_TLBIDX_EHINV)
> > +                     continue;
> > +             /*
> > +              * ASID takes effect in absence of G (global) bit.
> > +              */
> > +             if (!((entrylo0 | entrylo1) & ENTRYLO_G) &&
> > +                 asid != s_asid)
> > +                     continue;
> > +
> > +             /*
> > +              * Only print entries in use
> > +              */
> > +             pr_info("Index: %2d pgsize=%x ", i, (1 << pagesize));
> > +
> > +             c0 = (entrylo0 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
> > +             c1 = (entrylo1 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
> > +
> > +             pr_cont("va=%0*lx asid=%0*lx",
> > +                     vwidth, (entryhi & ~0x1fffUL), asidwidth, asid & asidmask);
> > +
> > +             /* NR/NX are in awkward places, so mask them off separately */
> > +             pa = entrylo0 & ~(ENTRYLO_NR | ENTRYLO_NX);
> > +             pa = pa & PAGE_MASK;
> > +             pr_cont("\n\t[");
> > +             pr_cont("ri=%d xi=%d ",
> > +                     (entrylo0 & ENTRYLO_NR) ? 1 : 0,
> > +                     (entrylo0 & ENTRYLO_NX) ? 1 : 0);
> > +             pr_cont("pa=%0*llx c=%d d=%d v=%d g=%d plv=%lld] [",
> > +                     pwidth, pa, c0,
> > +                     (entrylo0 & ENTRYLO_D) ? 1 : 0,
> > +                     (entrylo0 & ENTRYLO_V) ? 1 : 0,
> > +                     (entrylo0 & ENTRYLO_G) ? 1 : 0,
> > +                     (entrylo0 & ENTRYLO_PLV) >> ENTRYLO_PLV_SHIFT);
> > +             /* NR/NX are in awkward places, so mask them off separately */
> > +             pa = entrylo1 & ~(ENTRYLO_NR | ENTRYLO_NX);
> > +             pa = pa & PAGE_MASK;
> > +             pr_cont("ri=%d xi=%d ",
> > +                     (entrylo1 & ENTRYLO_NR) ? 1 : 0,
> > +                     (entrylo1 & ENTRYLO_NX) ? 1 : 0);
> > +             pr_cont("pa=%0*llx c=%d d=%d v=%d g=%d plv=%lld]\n",
> > +                     pwidth, pa, c1,
> > +                     (entrylo1 & ENTRYLO_D) ? 1 : 0,
> > +                     (entrylo1 & ENTRYLO_V) ? 1 : 0,
> > +                     (entrylo1 & ENTRYLO_G) ? 1 : 0,
> > +                     (entrylo1 & ENTRYLO_PLV) >> ENTRYLO_PLV_SHIFT);
> > +     }
> > +     pr_info("\n");
> > +
> > +     write_csr_entryhi(s_entryhi);
> > +     write_csr_tlbidx(s_index);
> > +     write_csr_asid(s_asid);
> > +}
> > +
> > +void dump_tlb_all(void)
> > +{
> > +     dump_tlb(0, current_cpu_data.tlbsize - 1);
> > +}
>
> Overall LGTM; with the copyright lines amended:
Thanks for your review.

Huacai
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
