Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99145919D1
	for <lists+linux-arch@lfdr.de>; Sat, 13 Aug 2022 12:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiHMKV6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Aug 2022 06:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMKV4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Aug 2022 06:21:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9EC13E13;
        Sat, 13 Aug 2022 03:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C8760CEC;
        Sat, 13 Aug 2022 10:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D1FC43142;
        Sat, 13 Aug 2022 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660386114;
        bh=8Mk3RJjjnai4xEyfOPqUx8aeaeCw+jfczPmniW6YVEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G2FcdVmTNxJw6HPn+2yTz+T90K8KtXGHsZGeDviC8yFLrUw+IGuamj5h7xCzHsJwg
         zzLNjxrJowYoRF+0R+uHW02CsNgO9oMwLNGnHvTJbOurmtkPvxgb2pzo8UR3HVqRy1
         lWSIAbLlycpiC2Mm1PA6tOS+e5LExZVUhpZEkjFLacLqTK5HFtTTDb1eClfx/kLxjE
         /YY3P31U4f9l+MJkDfT6ww1MUT6r0lGXFXHHPcYlfG5zJ0chENsTPXG3FSxdoN+AnK
         NDGzWUPCI4N1MR+IG1r67qP43J6ZX2dcrnNPehAiH2s86VanCeAvnYBOSsriC2lz7W
         nQ1c+7Zea1/ow==
Received: by mail-oo1-f47.google.com with SMTP id z23-20020a4ad1b7000000b0044931ffdcafso546086oor.4;
        Sat, 13 Aug 2022 03:21:54 -0700 (PDT)
X-Gm-Message-State: ACgBeo1LxwppvwlKOOlCOnn5qxPCFIQTpNG1vksK1VACLXHmnPlvx/Ct
        ESWmQ3MrOmbjysHzKAfOLhJ2mB6B5TdtSm9b46I=
X-Google-Smtp-Source: AA6agR7DUluguBPJMq34KI5ruUq1/ZCwetUZsAXeP9n6UFtG2hCguSEVgMQvRB7a937yJ4+SvWPauygFkFWYNNnhVdQ=
X-Received: by 2002:a4a:3c7:0:b0:440:aef9:639d with SMTP id
 190-20020a4a03c7000000b00440aef9639dmr2403950ooi.48.1660386113546; Sat, 13
 Aug 2022 03:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220813085839.58414-1-guoren@kernel.org> <CAJF2gTR61ojv4wmZUxZ_Kv+uKN+FjnKjBrwWL_sFVzH_Fe+W8g@mail.gmail.com>
In-Reply-To: <CAJF2gTR61ojv4wmZUxZ_Kv+uKN+FjnKjBrwWL_sFVzH_Fe+W8g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 13 Aug 2022 18:21:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT5n=YdNVHfgr3JqW_pyNJ+4-5uw0i9AMT0DLU2CzBjtg@mail.gmail.com>
Message-ID: <CAJF2gTT5n=YdNVHfgr3JqW_pyNJ+4-5uw0i9AMT0DLU2CzBjtg@mail.gmail.com>
Subject: Re: [PATCH] loongarch: irq: Move to generic_handle_arch_irq
To:     chenhuacai@kernel.org, kernel@xen0n.name, zhangqing@loongson.cn,
        arnd@arndb.de, linux-arch@vger.kernel.org, mark.rutland@arm.com,
        frederic@kernel.org
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        jiaxun.yang@flygoat.com, yangtiezhu@loongson.cn,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sorry for the noise, loongarch selects GENERIC_ENTRY, and it has
called irqentry_enter(). So calling generic_handle_arch_irq would
cause duplicate ct_irq_enter calling.

All abandoned, and I would have a look at generic_handle_arch_irq.

On Sat, Aug 13, 2022 at 5:06 PM Guo Ren <guoren@kernel.org> wrote:
>
> Abandon this patch because of the wrong commit log. Please see
> "[RESEND PATCH] loongarch: irq: Move to generic_handle_arch_irq".
>
> On Sat, Aug 13, 2022 at 4:58 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > No reason to keep custom handle_loongarch_irq, and move to the generic
> > one. No reason to keep custom handle_loongarch_irq, and move to the
> > generic one. The patch also the fixup HAVE_CONTEXT_TRACKING_USER
> > feature, because handle_loongarch_irq missed ct_irq_enter/exit.
> >
> > Fixes: 0603839b18f4 ("LoongArch: Add exception/interrupt handling")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/loongarch/kernel/traps.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> > index aa1c95aaf595..06211640ba1f 100644
> > --- a/arch/loongarch/kernel/traps.c
> > +++ b/arch/loongarch/kernel/traps.c
> > @@ -588,17 +588,6 @@ asmlinkage void cache_parity_error(void)
> >         panic("Can't handle the cache error!");
> >  }
> >
> > -asmlinkage void noinstr handle_loongarch_irq(struct pt_regs *regs)
> > -{
> > -       struct pt_regs *old_regs;
> > -
> > -       irq_enter_rcu();
> > -       old_regs = set_irq_regs(regs);
> > -       handle_arch_irq(regs);
> > -       set_irq_regs(old_regs);
> > -       irq_exit_rcu();
> > -}
> > -
> >  asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
> >  {
> >         register int cpu;
> > @@ -608,7 +597,7 @@ asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
> >         cpu = smp_processor_id();
> >
> >         if (on_irq_stack(cpu, sp))
> > -               handle_loongarch_irq(regs);
> > +               generic_handle_arch_irq(regs);
> >         else {
> >                 stack = per_cpu(irq_stack, cpu) + IRQ_STACK_START;
> >
> > @@ -619,7 +608,7 @@ asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
> >                 "move   $s0, $sp                \n" /* Preserve sp */
> >                 "move   $sp, %[stk]             \n" /* Switch stack */
> >                 "move   $a0, %[regs]            \n"
> > -               "bl     handle_loongarch_irq    \n"
> > +               "bl     generic_handle_arch_irq \n"
> >                 "move   $sp, $s0                \n" /* Restore sp */
> >                 : /* No outputs */
> >                 : [stk] "r" (stack), [regs] "r" (regs)
> > --
> > 2.36.1
> >
>
>
> --
> Best Regards
>  Guo Ren



-- 
Best Regards
 Guo Ren
