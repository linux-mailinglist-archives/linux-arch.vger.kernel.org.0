Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822EB647BF6
	for <lists+linux-arch@lfdr.de>; Fri,  9 Dec 2022 03:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLICHD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 21:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiLICGy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 21:06:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F777A0FB2;
        Thu,  8 Dec 2022 18:06:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5D1A620ED;
        Fri,  9 Dec 2022 02:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5655BC43398;
        Fri,  9 Dec 2022 02:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670551597;
        bh=5QpixbtmNzWooQk3ElYjvEVW/qRgv7IG6Byv+Fza6hc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sv9DLJvRVAr0NLNQO7JLSaxU6jFy3foTYOWUJnEZBkwDsLGIH8ZSF1IJ/L9NQuiPK
         VYO0eXMt9a/MhlVbr4frHHkMfHYBfL7KpaiPmVsEG27K6yzz+z7vNrMueR72aJnsh/
         ASsmlopsmAqemP43YMgGsvdduiHzxfHb9KmT+zQMhS7V1WMJxq+HD6mQjP639w0Ws8
         U3x5SUXd/VqoNH4sGc6rHiT/hHX/OoG7BvWK4IXWdg1UinUFQzEUmhKCUje9DbmvB3
         JDUEPXHLyqIKlg84MRVv1PGe5XL+VJKv36zrc2aU2G505eA93xEn8UHmPiKTctQbdZ
         tGeD3xUH/+4UQ==
Received: by mail-ej1-f54.google.com with SMTP id fc4so8238479ejc.12;
        Thu, 08 Dec 2022 18:06:37 -0800 (PST)
X-Gm-Message-State: ANoB5pmR8hQZ06qXO0IRcWCyXMausUPQX+igZaEBvfG+8yxqqvEv6XNU
        ne4IWVuoLlYnABWKdqH3fv5qPLm7V7JVnhrVozg=
X-Google-Smtp-Source: AA0mqf5gJhnOM9o8qbAYa9mC3Jv/2/bwd5oaEafkiJmsSNYg6KcPO+/xD3U0aU3vRpjBmvWRO0Gk5SwsBu4+/irBfHg=
X-Received: by 2002:a17:906:ee2:b0:78d:3f96:b7aa with SMTP id
 x2-20020a1709060ee200b0078d3f96b7aamr64217621eji.74.1670551595573; Thu, 08
 Dec 2022 18:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20221208025816.138712-1-guoren@kernel.org> <20221208025816.138712-9-guoren@kernel.org>
 <87pmcuw6f5.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87pmcuw6f5.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 9 Dec 2022 10:06:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQzANzhQCWcfEWvTUVQexePBmS2S=doYte9CrFTy5cYcg@mail.gmail.com>
Message-ID: <CAJF2gTQzANzhQCWcfEWvTUVQexePBmS2S=doYte9CrFTy5cYcg@mail.gmail.com>
Subject: Re: [PATCH -next V10 08/10] riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 8, 2022 at 6:12 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> guoren@kernel.org writes:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add independent irq stacks for percpu to prevent kernel stack overflows=
.
> > It is also compatible with VMAP_STACK by implementing
> > arch_alloc_vmap_stack.  Many architectures have supported
> > HAVE_IRQ_EXIT_ON_IRQ_STACK, riscv should follow up.
> >
>
> I still would like to see this as a separate series, and that the
> generic entry series ended with the previous patch. It's already a lot
> of moving pieces in this series. Now add stack changes? Is this really
> required for generic entry support?
Okay, Let the generic entry merge first.

>
> Some comments below.
>
> > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig                   |  8 ++++
> >  arch/riscv/include/asm/thread_info.h |  2 +
> >  arch/riscv/include/asm/vmap_stack.h  | 28 ++++++++++++
> >  arch/riscv/kernel/irq.c              | 66 +++++++++++++++++++++++++++-
> >  4 files changed, 102 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/vmap_stack.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 518e8523d41d..0a9d4bdc0338 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -446,6 +446,14 @@ config FPU
> >
> >         If you don't know what to do here, say Y.
> >
> > +config IRQ_STACKS
> > +     bool "Independent irq stacks" if EXPERT
> > +     default y
> > +     select HAVE_IRQ_EXIT_ON_IRQ_STACK
> > +     help
> > +       Add independent irq stacks for percpu to prevent kernel stack o=
verflows.
> > +       We may save some memory footprint by disabling IRQ_STACKS.
> > +
>
> Other archs uses CONFIG_IRQSTACKS. Let's use that for riscv as well, and
> also use the same Kconfig wording as the other archs.
Okay

>
> >  endmenu # "Platform type"
> >
> >  menu "Kernel features"
> > diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/=
asm/thread_info.h
> > index 7de4fb96f0b5..043da8ccc7e6 100644
> > --- a/arch/riscv/include/asm/thread_info.h
> > +++ b/arch/riscv/include/asm/thread_info.h
> > @@ -40,6 +40,8 @@
> >  #define OVERFLOW_STACK_SIZE     SZ_4K
> >  #define SHADOW_OVERFLOW_STACK_SIZE (1024)
> >
> > +#define IRQ_STACK_SIZE               THREAD_SIZE
> > +
> >  #ifndef __ASSEMBLY__
> >
> >  extern long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE / sizeof(long)];
> > diff --git a/arch/riscv/include/asm/vmap_stack.h b/arch/riscv/include/a=
sm/vmap_stack.h
> > new file mode 100644
> > index 000000000000..3fbf481abf4f
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/vmap_stack.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +// Copied from arch/arm64/include/asm/vmap_stack.h.
> > +#ifndef _ASM_RISCV_VMAP_STACK_H
> > +#define _ASM_RISCV_VMAP_STACK_H
> > +
> > +#include <linux/bug.h>
> > +#include <linux/gfp.h>
> > +#include <linux/kconfig.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/pgtable.h>
> > +#include <asm/thread_info.h>
> > +
> > +/*
> > + * To ensure that VMAP'd stack overflow detection works correctly, all=
 VMAP'd
> > + * stacks need to have the same alignment.
> > + */
> > +static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, =
int node)
> > +{
> > +     void *p;
> > +
> > +     BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
> > +
> > +     p =3D __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, no=
de,
> > +                     __builtin_return_address(0));
> > +     return kasan_reset_tag(p);
> > +}
> > +
> > +#endif /* _ASM_RISCV_VMAP_STACK_H */
> > diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> > index 24c2e1bd756a..5d77f692b198 100644
> > --- a/arch/riscv/kernel/irq.c
> > +++ b/arch/riscv/kernel/irq.c
> > @@ -10,6 +10,37 @@
> >  #include <linux/irqchip.h>
> >  #include <linux/seq_file.h>
> >  #include <asm/smp.h>
> > +#include <asm/vmap_stack.h>
> > +
> > +#ifdef CONFIG_IRQ_STACKS
> > +static DEFINE_PER_CPU(ulong *, irq_stack_ptr);
> > +
> > +#ifdef CONFIG_VMAP_STACK
> > +static void init_irq_stacks(void)
> > +{
> > +     int cpu;
> > +     ulong *p;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             p =3D arch_alloc_vmap_stack(IRQ_STACK_SIZE, cpu_to_node(c=
pu));
> > +             per_cpu(irq_stack_ptr, cpu) =3D p;
> > +     }
> > +}
> > +#else
> > +/* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE ali=
gned. */
> > +DEFINE_PER_CPU_ALIGNED(ulong [IRQ_STACK_SIZE/sizeof(ulong)], irq_stack=
);
> > +
> > +static void init_irq_stacks(void)
> > +{
> > +     int cpu;
> > +
> > +     for_each_possible_cpu(cpu)
> > +             per_cpu(irq_stack_ptr, cpu) =3D per_cpu(irq_stack, cpu);
> > +}
> > +#endif /* CONFIG_VMAP_STACK */
> > +#else
> > +static void init_irq_stacks(void) {}
> > +#endif /* CONFIG_IRQ_STACKS */
> >
> >  int arch_show_interrupts(struct seq_file *p, int prec)
> >  {
> > @@ -19,21 +50,52 @@ int arch_show_interrupts(struct seq_file *p, int pr=
ec)
> >
> >  void __init init_IRQ(void)
> >  {
> > +     init_irq_stacks();
> >       irqchip_init();
> >       if (!handle_arch_irq)
> >               panic("No interrupt controller found.");
> >  }
> >
> > -asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs)
> > +static void noinstr handle_riscv_irq(struct pt_regs *regs)
> >  {
> >       struct pt_regs *old_regs;
> > -     irqentry_state_t state =3D irqentry_enter(regs);
> >
> >       irq_enter_rcu();
> >       old_regs =3D set_irq_regs(regs);
> >       handle_arch_irq(regs);
> >       set_irq_regs(old_regs);
> >       irq_exit_rcu();
> > +}
> > +
> > +asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs)
> > +{
> > +     irqentry_state_t state =3D irqentry_enter(regs);
> > +#ifdef CONFIG_IRQ_STACKS
> > +     if (on_thread_stack()) {
> > +             ulong *sp =3D per_cpu(irq_stack_ptr, smp_processor_id())
> > +                                     + IRQ_STACK_SIZE/sizeof(ulong);
> > +             __asm__ __volatile(
> > +             "addi   sp, sp, -"RISCV_SZPTR  "\n"
> > +             REG_S"  ra, (sp)                \n"
> > +             "addi   sp, sp, -"RISCV_SZPTR  "\n"
> > +             REG_S"  s0, (sp)                \n"
> > +             "addi   s0, sp, 2*"RISCV_SZPTR "\n"
> > +             "move   sp, %[sp]               \n"
> > +             "move   a0, %[regs]             \n"
> > +             "call   handle_riscv_irq        \n"
> > +             "addi   sp, s0, -2*"RISCV_SZPTR"\n"
> > +             REG_L"  s0, (sp)                \n"
> > +             "addi   sp, sp, "RISCV_SZPTR   "\n"
> > +             REG_L"  ra, (sp)                \n"
> > +             "addi   sp, sp, "RISCV_SZPTR   "\n"
> > +             :
> > +             : [sp] "r" (sp), [regs] "r" (regs)
> > +             : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
> > +               "t0", "t1", "t2", "t3", "t4", "t5", "t6",
> > +               "memory");
>
> This whole assembly thing will be C&P in later commits. Can we please do
> something like x86 does here (call_on_stack --
> arch/x86/include/asm/irq_stack.h), which will hurt our eyes a bit less,
> and make it more maintainable?
Okay.

>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
