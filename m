Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7F352779B
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiEONAe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 09:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiEONAc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 09:00:32 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDCA3A739;
        Sun, 15 May 2022 06:00:31 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id d22so12929116vsf.2;
        Sun, 15 May 2022 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSy7SVOOPjjL89AySe1SBO4eK6rYNR97e0xo4siY6g8=;
        b=XDfXWkOkHaAg5Kjx3xnIrf/r5WNAOtlYWieUtdjKEm0WohQRp1nygYBYXIcbMsNJVk
         Eg/9776ovUlyTc3O6PnFnY2GSqUnWHh64a+e12PD6xHI59jdGEho2V0+aqqxBka+hObw
         XeUQsQOVo55F+ay166wF9pFZFybzZEyRUvvGVaGKfsN1wB5C/hiJw5d08zGfOR6P4y8E
         fKDScyqyUzGOvrOzOYa7ifQWGVfdQnCtZlF1vE5WFwwHGDlzSXWxRtlOBQeKHgeVhvBm
         k2EZYY/InVo0EoqnPC1e2SamonwS7w+mKOXdvX/FNsqeJ/Sqclio5lMydoib+u33wnLk
         KXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSy7SVOOPjjL89AySe1SBO4eK6rYNR97e0xo4siY6g8=;
        b=Ku7mHrlND0G4WMva067lI8lkWOL5CF3Zz377+UykyEaTmiL2Laq+XnWpciY39I+o8D
         x8XRRiYH5ztosiAVMennDCxcJsM7OQpWTRSlGhno8/tBQGm/SCYzp9rMqWyRhoIljCu5
         O3fg2xKAgawdoTUKu71QfNbATysUp2eTC1z8e4IaGgZVEMFKDV7+4+2OMOw58s04UMFC
         DrUhDWb77juZ9NuuwL9U5uU1xXdFtlyDBa+5jisgz4JASDJN8eSU3FtMs1KOJAnTcPd2
         qIYJ1HwWqysm053RbEIhnFhg2EIrK/y9covzfEJM5HNbQtNXJAwQoiwQZFMiyikZ4Jsm
         koyA==
X-Gm-Message-State: AOAM533dLqeb8u76G7PPBQp5Md0kLmoYllaM7urD6e4T2hO0BPnVcqXi
        Tw+BfRaWYqoWDZTKLiEOxHWW3XoU7t0yxVkLTnk=
X-Google-Smtp-Source: ABdhPJyEuGdilnSA6H4tu1wV6WwFa+yha0yrLwqayW/WR1OFwPoq26CeaAvOnGc3jes8yBPIcTAVkMT7XoPpv3/h+aw=
X-Received: by 2002:a67:ea4f:0:b0:328:1db4:d85c with SMTP id
 r15-20020a67ea4f000000b003281db4d85cmr4544293vso.20.1652619630427; Sun, 15
 May 2022 06:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-11-chenhuacai@loongson.cn> <3982e7e7-f98e-8d8b-f13b-2bfa10a69b95@xen0n.name>
In-Reply-To: <3982e7e7-f98e-8d8b-f13b-2bfa10a69b95@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 21:00:19 +0800
Message-ID: <CAAhV-H4FDk42Ci_PMjn5BSaaUy-X8aVHWMEOj5_np8K8peTd0w@mail.gmail.com>
Subject: Re: [PATCH V10 10/22] LoongArch: Add exception/interrupt handling
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

On Sun, May 15, 2022 at 5:07 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi,
>
> On 5/14/22 16:03, Huacai Chen wrote:
> > Add the exception and interrupt handling machanism for basic LoongArch
> > support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/branch.h       |  21 +
> >   arch/loongarch/include/asm/bug.h          |  23 +
> >   arch/loongarch/include/asm/entry-common.h |  13 +
> >   arch/loongarch/include/asm/hardirq.h      |  24 +
> >   arch/loongarch/include/asm/hw_irq.h       |  17 +
> >   arch/loongarch/include/asm/irq.h          | 130 ++++
> >   arch/loongarch/include/asm/irq_regs.h     |  27 +
> >   arch/loongarch/include/asm/irqflags.h     |  78 +++
> >   arch/loongarch/include/asm/kdebug.h       |  23 +
> >   arch/loongarch/include/asm/stackframe.h   | 212 ++++++
> >   arch/loongarch/include/asm/stacktrace.h   |  74 +++
> >   arch/loongarch/include/uapi/asm/break.h   |  23 +
> >   arch/loongarch/kernel/access-helper.h     |  13 +
> >   arch/loongarch/kernel/genex.S             |  95 +++
> >   arch/loongarch/kernel/irq.c               | 131 ++++
> >   arch/loongarch/kernel/traps.c             | 755 ++++++++++++++++++++++
> >   16 files changed, 1659 insertions(+)
> >   create mode 100644 arch/loongarch/include/asm/branch.h
> >   create mode 100644 arch/loongarch/include/asm/bug.h
> >   create mode 100644 arch/loongarch/include/asm/entry-common.h
> >   create mode 100644 arch/loongarch/include/asm/hardirq.h
> >   create mode 100644 arch/loongarch/include/asm/hw_irq.h
> >   create mode 100644 arch/loongarch/include/asm/irq.h
> >   create mode 100644 arch/loongarch/include/asm/irq_regs.h
> >   create mode 100644 arch/loongarch/include/asm/irqflags.h
> >   create mode 100644 arch/loongarch/include/asm/kdebug.h
> >   create mode 100644 arch/loongarch/include/asm/stackframe.h
> >   create mode 100644 arch/loongarch/include/asm/stacktrace.h
> >   create mode 100644 arch/loongarch/include/uapi/asm/break.h
> >   create mode 100644 arch/loongarch/kernel/access-helper.h
> >   create mode 100644 arch/loongarch/kernel/genex.S
> >   create mode 100644 arch/loongarch/kernel/irq.c
> >   create mode 100644 arch/loongarch/kernel/traps.c
> This patch mostly looks good, except...
> > (snip)
> >
> > +asmlinkage void cache_parity_error(void)
> > +{
> > +     const int field = 2 * sizeof(unsigned long);
> > +     unsigned int reg_val;
> > +
> > +     /* For the moment, report the problem and hang. */
> > +     pr_err("Cache error exception:\n");
> > +     pr_err("csr_merrera == %0*llx\n", field, csr_readq(LOONGARCH_CSR_MERRERA));
> > +     reg_val = csr_readl(LOONGARCH_CSR_MERRCTL);
> > +     pr_err("csr_merrctl == %08x\n", reg_val);
> > +
> > +     pr_err("Decoded c0_cacheerr: %s cache fault in %s reference.\n",
> > +            reg_val & (1<<30) ? "secondary" : "primary",
> > +            reg_val & (1<<31) ? "data" : "insn");
> > +     if (((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_LOONGSON)) {
> > +             pr_err("Error bits: %s%s%s%s%s%s%s%s\n",
> > +                     reg_val & (1<<29) ? "ED " : "",
> > +                     reg_val & (1<<28) ? "ET " : "",
> > +                     reg_val & (1<<27) ? "ES " : "",
> > +                     reg_val & (1<<26) ? "EE " : "",
> > +                     reg_val & (1<<25) ? "EB " : "",
> > +                     reg_val & (1<<24) ? "EI " : "",
> > +                     reg_val & (1<<23) ? "E1 " : "",
> > +                     reg_val & (1<<22) ? "E0 " : "");
> > +     } else {
> > +             pr_err("Error bits: %s%s%s%s%s%s%s\n",
> > +                     reg_val & (1<<29) ? "ED " : "",
> > +                     reg_val & (1<<28) ? "ET " : "",
> > +                     reg_val & (1<<26) ? "EE " : "",
> > +                     reg_val & (1<<25) ? "EB " : "",
> > +                     reg_val & (1<<24) ? "EI " : "",
> > +                     reg_val & (1<<23) ? "E1 " : "",
> > +                     reg_val & (1<<22) ? "E0 " : "");
> > +     }
> > +     pr_err("IDX: 0x%08x\n", reg_val & ((1<<22)-1));
> > +
> > +     panic("Can't handle the cache error!");
> > +}
>
> ... this function. This implementation is completely wrong, as it's the
> same logic on MIPS, but LoongArch's MERRCTL CSR is not arranged in the
> same way. There are no individual error bits, for example.
>
> You can simply replace this with a direct panic for now, for correctness.
Thank you very much, this is my fault.

Huacai
>
> With this fixed:
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
