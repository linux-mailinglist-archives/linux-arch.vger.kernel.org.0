Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67427647C01
	for <lists+linux-arch@lfdr.de>; Fri,  9 Dec 2022 03:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLICKG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 21:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLICKF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 21:10:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710A464EC;
        Thu,  8 Dec 2022 18:10:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB2762119;
        Fri,  9 Dec 2022 02:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A56FC433B4;
        Fri,  9 Dec 2022 02:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670551803;
        bh=Ia3V72Uk7M4KXmgjLjEt+8wDzqEqpUXfSTB4GcRrC0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D9c2U83ObEmD3eWcNvD9nAYLfsSKLqytAljVRtOqFbLravBvSJh76EWTTYjb3xbSD
         2A4mfWTkFJNHkKEdXkdov4ZXzkq570D2LIl/2YhhUcSE4rD1XDeasAAKlzr/ZYw1Ms
         xcNjmDJrnGmdrsHMbKmlTLOfbQ2f8sbDDAzgnC+lLRFMAg9q+wEEKnQfci5bK2vsg1
         ZvB04ge3qN5XyTZQK/KH1t8Me+SZH6fp734MAeqIM7ifIrRxL2oh2/iAc5/uwEqqxo
         eyLLaRIp3GCjx0Us81ZS2VOuIL1z+/NYvrQvY/751t73Pj36ZAZ4CODEzak6BIjFOf
         8MrjDP+tfFSxg==
Received: by mail-ej1-f50.google.com with SMTP id b2so8289676eja.7;
        Thu, 08 Dec 2022 18:10:03 -0800 (PST)
X-Gm-Message-State: ANoB5plaHusUJ9tYxSSQVf4kgrgIZao4wlaSHA5LDRUajYjr920HvBOU
        Gxqiue0zCAsOeTOuI1vejvvh+RZHwX5MUkyzFSY=
X-Google-Smtp-Source: AA0mqf7vJJcYsX9o1C4cJqIT0SLKDAkYd+pPh2biTTTXnkbzmntY1yMQBnusQEQqyuAYUACSW7hpi16d7JAo34sLwQg=
X-Received: by 2002:a17:906:8309:b0:7c0:dab0:d722 with SMTP id
 j9-20020a170906830900b007c0dab0d722mr17095382ejx.353.1670551801415; Thu, 08
 Dec 2022 18:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20221208025816.138712-1-guoren@kernel.org> <20221208025816.138712-10-guoren@kernel.org>
 <87o7sew6ey.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87o7sew6ey.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 9 Dec 2022 10:09:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT1YNubBG_RMzwsWVXk0X0nwQvTM2r5NjRvVN+1x1RHMw@mail.gmail.com>
Message-ID: <CAJF2gTT1YNubBG_RMzwsWVXk0X0nwQvTM2r5NjRvVN+1x1RHMw@mail.gmail.com>
Subject: Re: [PATCH -next V10 09/10] riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK
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
> > Add the HAVE_SOFTIRQ_ON_OWN_STACK feature for the IRQ_STACKS config. Th=
e
> > irq and softirq use the same independent irq_stack of percpu by time
> > division multiplexing.
> >
> > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig      |  7 ++++---
> >  arch/riscv/kernel/irq.c | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 37 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0a9d4bdc0338..bd4c4ae4cdc9 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -447,12 +447,13 @@ config FPU
> >         If you don't know what to do here, say Y.
> >
> >  config IRQ_STACKS
> > -     bool "Independent irq stacks" if EXPERT
> > +     bool "Independent irq & softirq stacks" if EXPERT
> >       default y
> >       select HAVE_IRQ_EXIT_ON_IRQ_STACK
> > +     select HAVE_SOFTIRQ_ON_OWN_STACK
>
> HAVE_IRQ_EXIT_ON_IRQ_STACK is used by softirq.c Shouldn't that be
> selected introduced in this patch, instead of the previous one?
This patch depends on the previous one. And the previous one could
work separately.

>
> >       help
> > -       Add independent irq stacks for percpu to prevent kernel stack o=
verflows.
> > -       We may save some memory footprint by disabling IRQ_STACKS.
> > +       Add independent irq & softirq stacks for percpu to prevent kern=
el stack
> > +       overflows. We may save some memory footprint by disabling IRQ_S=
TACKS.
>
> Same comment from previous patch. Please use the same wording/config as
> other archs.
>
> >  endmenu # "Platform type"
> >
> > diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> > index 5d77f692b198..a6406da34937 100644
> > --- a/arch/riscv/kernel/irq.c
> > +++ b/arch/riscv/kernel/irq.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/seq_file.h>
> >  #include <asm/smp.h>
> >  #include <asm/vmap_stack.h>
> > +#include <asm/softirq_stack.h>
> >
> >  #ifdef CONFIG_IRQ_STACKS
> >  static DEFINE_PER_CPU(ulong *, irq_stack_ptr);
> > @@ -38,6 +39,38 @@ static void init_irq_stacks(void)
> >               per_cpu(irq_stack_ptr, cpu) =3D per_cpu(irq_stack, cpu);
> >  }
> >  #endif /* CONFIG_VMAP_STACK */
> > +
> > +#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
> > +void do_softirq_own_stack(void)
> > +{
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
> > +             "call   __do_softirq            \n"
> > +             "addi   sp, s0, -2*"RISCV_SZPTR"\n"
> > +             REG_L"  s0, (sp)                \n"
> > +             "addi   sp, sp, "RISCV_SZPTR   "\n"
> > +             REG_L"  ra, (sp)                \n"
> > +             "addi   sp, sp, "RISCV_SZPTR   "\n"
> > +             :
> > +             : [sp] "r" (sp)
> > +             : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
> > +               "t0", "t1", "t2", "t3", "t4", "t5", "t6",
> > +               "memory");
>
> Same as previous patch. Please avoid C&P and have a look at how
> call_on_stack is done on x86.
Okay.

>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
