Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0907A5919C9
	for <lists+linux-arch@lfdr.de>; Sat, 13 Aug 2022 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiHMKK2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Aug 2022 06:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbiHMKK1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Aug 2022 06:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC249594;
        Sat, 13 Aug 2022 03:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43D8F60CA4;
        Sat, 13 Aug 2022 10:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1C2C433D7;
        Sat, 13 Aug 2022 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660385425;
        bh=yb/5LXqoZZzmpGNBqhIVKpHwuwqwgIA2gf1bBZJGznY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T4MFOl75LMqEPDWISWvdFNKnGWjGBWDPXGzoIZZk9SjG03XpYPavWrgLeIWyQSWf2
         jehy4oQ9DgxxrrEUQiYsQ3stQ28keaujjWs7vLhFl5aR198BZORUcUqrdUE6cSlwuj
         d3k8ZUlvc5j2VrE4L5IJeq4dC7+C4VlKT2r/maEjiJuaSS3KYzAgzvHV0EEPtXxQPm
         RJZzsOpf3jCZ03SdpcJ5sBoMbiTjIh2kDhbpnBoL+YbmyUA5rpNKufSgAzlMhqJogo
         LRu/ZkmB7c8ufnxJFEES12Ci5nijsLZPyKK6PC300oYcl3BOIknbw9sxPoc8aN3q/N
         Rg8VxpHxagOWA==
Received: by mail-vs1-f46.google.com with SMTP id b124so2982942vsc.9;
        Sat, 13 Aug 2022 03:10:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo2yI3muArrw0HrcHZ6UkKfKmpAyeFokiwfCOyjAejdOwHBfcnwG
        /OhbWDtMLDJ73t9Rl4hsfPy1g8RqOOdRGS2EBWQ=
X-Google-Smtp-Source: AA6agR7+LEMn1J84OUXieECx/ogKyxqW2FxhQeGmUvpommgInAwOZ86WyoSkEUZq/+hgFcgp7t9E32RPMbqHwAAmh0U=
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id
 e13-20020a056102390d00b0038778b9bf9cmr3412044vsu.43.1660385424543; Sat, 13
 Aug 2022 03:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220813085839.58414-1-guoren@kernel.org> <CAJF2gTR61ojv4wmZUxZ_Kv+uKN+FjnKjBrwWL_sFVzH_Fe+W8g@mail.gmail.com>
In-Reply-To: <CAJF2gTR61ojv4wmZUxZ_Kv+uKN+FjnKjBrwWL_sFVzH_Fe+W8g@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 13 Aug 2022 18:10:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5cQFasHe7K9_tk2y_te4w1uJgfMNoMRv3RrL+yZkG20g@mail.gmail.com>
Message-ID: <CAAhV-H5cQFasHe7K9_tk2y_te4w1uJgfMNoMRv3RrL+yZkG20g@mail.gmail.com>
Subject: Re: [PATCH] loongarch: irq: Move to generic_handle_arch_irq
To:     Guo Ren <guoren@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Qing Zhang <zhangqing@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, frederic@kernel.org,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
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

Hi, Ren,

Thank you for your patch, but it seems wrong to me.

Please see c9b12b59e2ea4c3c7cedec7efb071b6 ("s390/entry: fix duplicate
tracking of irq nesting level"). ct_irq_enter() is named
rcu_irq_enter() in older kernels. And irq_enter = rcu_irq_enter +
irq_enter_rcu  (for the latest kernel, irq_enter = ct_irq_enter +
irq_enter_rcu). If we use generic entry, irqentry_enter() has already
call rcu_irq_enter (or ct_irq_enter in the latest kernel), so the arch
code doesn't need to call it again. This has nothing to do with
HAVE_CONTEXT_TRACKING_USER, just avoid duplicated calls to
ct_irq_enter.

Huacai

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
>
