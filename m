Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431D26CA5FE
	for <lists+linux-arch@lfdr.de>; Mon, 27 Mar 2023 15:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjC0NdK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Mar 2023 09:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjC0NdJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2023 09:33:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C71268B;
        Mon, 27 Mar 2023 06:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 434E4B81038;
        Mon, 27 Mar 2023 13:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A48BC4339E;
        Mon, 27 Mar 2023 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679923985;
        bh=I2nC4RvrI3XPmmchXfIbX9tkGi9QcppowdjfP5n6HKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rvN4TbP3P41UabfoZduu5VujQxmn3s5MCDlwFPHGjHfRKUm6ZtrjBNhM6ZH/OjzSM
         qPWGpP9/0h2WsebqSy0ZZpA7Dj0F7Q5V4JCpEUFnhYLcXgcFvYML+rpduMj/CL4WBh
         QBSARR67Rr2c5pSCOwQFCuRIRW14OHF8Wm+t5+GrmM7Hq06Cct4XQPxpr84uFHBgC0
         NMCo3BJaTJ5IYtwshXKeLofd71XNQCvU3vyQG57fVM/MNWY1jxgYcbdTQupNPa5Vbm
         cQHN/mxSpxUMIbRNM04vDttP7tT5sygci9gfgxYUOqsdC6HmLVsiYEZHR/dnj75oZq
         FqGZg4Z4YrfFg==
Received: by mail-ed1-f47.google.com with SMTP id b20so36366951edd.1;
        Mon, 27 Mar 2023 06:33:04 -0700 (PDT)
X-Gm-Message-State: AAQBX9cVRSOyFyyxSmjjYEmJNt2BYvCBCOZQ77DV56viQgcK/8vBIL6E
        7mr62JOP+ppTN5zqny63pG82fiScHxhxPfz/vv8=
X-Google-Smtp-Source: AKy350ZI7DmaR3+YGbP/NXYZhn7km7KIid6qvRQlw0MFKgLBu59N2QBPhw3hOGGid8N91ENewfUMIFA1hkMms2hAc5c=
X-Received: by 2002:a17:906:2303:b0:930:310:abf1 with SMTP id
 l3-20020a170906230300b009300310abf1mr5900219eja.5.1679923983279; Mon, 27 Mar
 2023 06:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230324071239.151677-1-guoren@kernel.org> <20230324071239.151677-2-guoren@kernel.org>
 <f170c68c-4975-4f71-ac50-979483cb5848@spud>
In-Reply-To: <f170c68c-4975-4f71-ac50-979483cb5848@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 27 Mar 2023 21:32:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSwt1XkC=kisOAf0_aHmi6E6ty-EV0eSA110E1DzvWc2Q@mail.gmail.com>
Message-ID: <CAJF2gTSwt1XkC=kisOAf0_aHmi6E6ty-EV0eSA110E1DzvWc2Q@mail.gmail.com>
Subject: Re: [PATCH -next V11 1/3] riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 27, 2023 at 7:30=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Fri, Mar 24, 2023 at 03:12:37AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add independent irq stacks for percpu to prevent kernel stack overflows=
.
> > It is also compatible with VMAP_STACK by implementing
> > arch_alloc_vmap_stack.  Many architectures have supported
> > HAVE_IRQ_EXIT_ON_IRQ_STACK, riscv should follow up.
> >
> > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
>
> > --- a/arch/riscv/kernel/irq.c
> > +++ b/arch/riscv/kernel/irq.c
> > @@ -9,6 +9,37 @@
> >  #include <linux/irqchip.h>
> >  #include <linux/seq_file.h>
> >  #include <asm/smp.h>
> > +#include <asm/vmap_stack.h>
> > +
> > +#ifdef CONFIG_IRQ_STACKS
> > +DEFINE_PER_CPU(ulong *, irq_stack_ptr);
>
> btw, sparse is complaining about this variable:
> ../arch/riscv/kernel/irq.c:15:1: warning: symbol '__pcpu_scope_irq_stack_=
ptr' was not declared. Should it be static?
I declared it in traps.c, maybe I should put it in the vmap_stack.h.

>
> I'm not immediately sure why that is the case, but should be
> reproducible with gcc-12 allmodconfig.
>
> Thanks,
> Conor.
>
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
> > @@ -18,6 +49,7 @@ int arch_show_interrupts(struct seq_file *p, int prec=
)
> >
> >  void __init init_IRQ(void)
> >  {
> > +     init_irq_stacks();
> >       irqchip_init();
> >       if (!handle_arch_irq)
> >               panic("No interrupt controller found.");
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 1f4e37be7eb3..b69933ab6bf8 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -305,16 +305,50 @@ asmlinkage __visible noinstr void do_page_fault(s=
truct pt_regs *regs)
> >  }
> >  #endif
> >
> > -asmlinkage __visible noinstr void do_irq(struct pt_regs *regs)
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
> > +#ifdef CONFIG_IRQ_STACKS
> > +DECLARE_PER_CPU(ulong *, irq_stack_ptr);
> > +#endif
I declared it here.

> > +
> > +asmlinkage void noinstr do_irq(struct pt_regs *regs)
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
> > +     } else
> > +#endif
> > +             handle_riscv_irq(regs);
> >
> >       irqentry_exit(regs, state);
> >  }
> > --
> > 2.36.1
> >
> >



--=20
Best Regards
 Guo Ren
