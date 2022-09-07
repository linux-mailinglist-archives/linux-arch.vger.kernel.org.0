Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B645AF948
	for <lists+linux-arch@lfdr.de>; Wed,  7 Sep 2022 02:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiIGA7k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 20:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiIGA7j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 20:59:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810B1FD04;
        Tue,  6 Sep 2022 17:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E3B0B81AD5;
        Wed,  7 Sep 2022 00:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F2BC4314A;
        Wed,  7 Sep 2022 00:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662512373;
        bh=rRDkYK9iWCXx4wEvEXjdFzrW7V+WU51QfVdxnQR/Up4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cnrRuv/BitCXdq86pumAdk9NrkLBO6C5804p7tNfD3ydvcRYjgKf/u2lJtuHyL4LB
         7ZmMNoQHTqpsyhqKEYW03c8YLCXXnD408gR/u+93zLkCFVS8ptB5c9wrE+Smuzqcxn
         yUKsb5//1YpnFQJSbjxvoUlVMMH6FxEvjZGoHiAOoMFh27tG1zbW51W+Ud7bfAtaOd
         znSf1k98U8FiecoSJaScPrUnTi+LfmLWevi411VPc2nv6wENP8u3EUJvwG9FHagc6H
         JOrgXafNtKL/Cq1hZE/GkSwVdvFODfDCH9ixAaQ07jV16V2Wt/Yh4Q3Tp5jSqEXJX4
         8ipWS734KvUbA==
Received: by mail-ot1-f43.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so9236644oth.8;
        Tue, 06 Sep 2022 17:59:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo3IQZ0kdGcpxUlM2BNQMrUX8/uGHd42VQn0CHwA4ZhQST0aggJR
        qCJw1E0FB1Q2h/aNWEuazoOpRTyyR+Z1QUuWrew=
X-Google-Smtp-Source: AA6agR4T+5pUb7afC0nbWNUE6t9rpyPvgc4usas9mXHv8gHcqGmB5W7iv8rmSa98jv8Ovc8tvPLbDXQ/sXx4rvotOG8=
X-Received: by 2002:a05:6830:3482:b0:638:92b7:f09b with SMTP id
 c2-20020a056830348200b0063892b7f09bmr497235otu.140.1662512372833; Tue, 06 Sep
 2022 17:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220906035423.634617-1-guoren@kernel.org> <20220906035423.634617-5-guoren@kernel.org>
 <YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net>
In-Reply-To: <YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Sep 2022 08:59:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTqVc_CvxT+t4D2Z1Gy_r_nrbdgAGcELFm9tgjOaCyJYg@mail.gmail.com>
Message-ID: <CAJF2gTTqVc_CvxT+t4D2Z1Gy_r_nrbdgAGcELFm9tgjOaCyJYg@mail.gmail.com>
Subject: Re: [PATCH V3 4/7] riscv: convert to generic entry
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, bigeasy@linutronix.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 6, 2022 at 5:20 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Sep 05, 2022 at 11:54:20PM -0400, guoren@kernel.org wrote:
>
> > +asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs)
> > +{
> > +     struct pt_regs *old_regs;
> > +     irqentry_state_t state = irqentry_enter(regs);
> > +
> > +     irq_enter_rcu();
> > +     old_regs = set_irq_regs(regs);
> > +     handle_arch_irq(regs);
> > +     set_irq_regs(old_regs);
> > +     irq_exit_rcu();
> > +
> > +     irqentry_exit(regs, state);
> > +}
>
> The above is right in that everything that calls irqentry_enter() should
> be noinstr; however all the below instances get it wrong:
>
> >  #define DO_ERROR_INFO(name, signo, code, str)                                \
> >  asmlinkage __visible __trap_section void name(struct pt_regs *regs)  \
> >  {                                                                    \
> > +     irqentry_state_t state = irqentry_enter(regs);                  \
> >       do_trap_error(regs, signo, code, regs->epc, "Oops - " str);     \
> > +     irqentry_exit(regs, state);                                     \
> >  }
> >
> >  DO_ERROR_INFO(do_trap_unknown,
> > @@ -123,18 +126,22 @@ int handle_misaligned_store(struct pt_regs *regs);
> >
> >  asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs *regs)
> >  {
> > +     irqentry_state_t state = irqentry_enter(regs);
> >       if (!handle_misaligned_load(regs))
> >               return;
> >       do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> >                     "Oops - load address misaligned");
> > +     irqentry_exit(regs, state);
> >  }
> >
> >  asmlinkage void __trap_section do_trap_store_misaligned(struct pt_regs *regs)
> >  {
> > +     irqentry_state_t state = irqentry_enter(regs);
> >       if (!handle_misaligned_store(regs))
> >               return;
> >       do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> >                     "Oops - store (or AMO) address misaligned");
> > +     irqentry_exit(regs, state);
> >  }
> >  #endif
> >  DO_ERROR_INFO(do_trap_store_fault,
> > @@ -158,6 +165,8 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
> >
> >  asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
> >  {
> > +     irqentry_state_t state = irqentry_enter(regs);
> > +
> >  #ifdef CONFIG_KPROBES
> >       if (kprobe_single_step_handler(regs))
> >               return;
> > @@ -185,6 +194,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
> >               regs->epc += get_break_insn_length(regs->epc);
> >       else
> >               die(regs, "Kernel BUG");
> > +
> > +     irqentry_exit(regs, state);
> >  }
> >  NOKPROBE_SYMBOL(do_trap_break);
>
> > +asmlinkage void do_page_fault(struct pt_regs *regs)
> > +{
> > +     irqentry_state_t state = irqentry_enter(regs);
> > +
> > +     __do_page_fault(regs);
> > +
> > +     irqentry_exit(regs, state);
> > +}
> >  NOKPROBE_SYMBOL(do_page_fault);
>
> Without noinstr the compiler is free to insert instrumentation (think
> all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
> yet ready to run this early in the entry path, for instance it could
> rely on RCU which isn't on yet, or expect lockdep state.
I'll add a patch to fix it in the next version. Thx for pointing it out.

>
>


-- 
Best Regards
 Guo Ren
