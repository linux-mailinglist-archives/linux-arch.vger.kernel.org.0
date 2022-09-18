Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C395BBEBB
	for <lists+linux-arch@lfdr.de>; Sun, 18 Sep 2022 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIRPnE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Sep 2022 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIRPnD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2022 11:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB79D1260E;
        Sun, 18 Sep 2022 08:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 460086158A;
        Sun, 18 Sep 2022 15:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEEFC43140;
        Sun, 18 Sep 2022 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663515781;
        bh=Gty9P/czjefiuXZWB6LKKbrVJ4pdX99Qh35Mhu5P2qA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q3ylBQ4ZTUPBdoowu1NWx51ytODTvOrSORtk9GPi/t0doqlwzlbbIzs+mHb8bY7tf
         FSjruNFXHpTyrmVQkfdkmXaISDCwpkAV4oL9dJbNE9thdL2FyDZOkXq9hummvN8SYt
         jrxZBFJcON8cA66lCLveVCWVQ8OQ+bryVp1BCsYso5Lufqq/+znAETI3cgrLoI1fbr
         iYPIzpsf4guezT4ZlbnRtlq/t3+y/IyQD/1++QNfQ0EzDLIzU8BDvjiWGv1pv4r87A
         a5aPJYYS7qk2oyNoHxt/FGRts34rPrb1EKdUQDeNx7GD13m+v+lNcLppfMLFaDIeGI
         vCbHeCel+1n1g==
Received: by mail-ot1-f43.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so12877804otu.7;
        Sun, 18 Sep 2022 08:43:01 -0700 (PDT)
X-Gm-Message-State: ACrzQf0eyYq83B9zd31tnkGOCAqlMRtvfMoHpBdkBdjwDq2Q00a6wS9z
        JtDjGPTiEe3dcRQppRvIUVxthg67XMknKpW5KEw=
X-Google-Smtp-Source: AMsMyM5VAQ8ulT0AN374moEVw3KR2QDbOFFbovmSHIi5Y57iHCk8N98mtwLJp4t/Svt/yiOl1PVI33PYLN0tL7q0y1Y=
X-Received: by 2002:a05:6830:1213:b0:65a:9a2:daf3 with SMTP id
 r19-20020a056830121300b0065a09a2daf3mr730850otp.308.1663515780520; Sun, 18
 Sep 2022 08:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-8-guoren@kernel.org>
 <YxoR5Fv6hOkzMSTg@linutronix.de>
In-Reply-To: <YxoR5Fv6hOkzMSTg@linutronix.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 18 Sep 2022 23:42:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSV9HQ+6A1kh48_MjWir7mtfE7+9P9--s-aqPpt9cb7sw@mail.gmail.com>
Message-ID: <CAJF2gTSV9HQ+6A1kh48_MjWir7mtfE7+9P9--s-aqPpt9cb7sw@mail.gmail.com>
Subject: Re: [PATCH V4 7/8] riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 9, 2022 at 12:01 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-09-07 22:25:05 [-0400], guoren@kernel.org wrote:
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
> > @@ -38,6 +39,21 @@ static void init_irq_stacks(void)
> >               per_cpu(irq_stack_ptr, cpu) = per_cpu(irq_stack, cpu);
> >  }
> >  #endif /* CONFIG_VMAP_STACK */
> > +
> > +#ifndef CONFIG_PREEMPT_RT
>
> Could you please replace it with
>         #ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
Thx, I would.

>
> instead? See
>         https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=8cbb2b50ee2dcb082675237eaaa48fe8479f8aa5
>
> > +static void do_riscv_softirq(struct pt_regs *regs)
> > +{
> > +     __do_softirq();
> > +}
> > +
> > +void do_softirq_own_stack(void)
> > +{
> > +     ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id());
> > +
> > +     call_on_stack(NULL, sp, do_riscv_softirq, 0);
> > +}
> > +#endif /* CONFIG_PREEMPT_RT */
> > +
> >  #else
> >  static void init_irq_stacks(void) {}
> >  #endif /* CONFIG_IRQ_STACKS */
>
> Sebastian



-- 
Best Regards
 Guo Ren
