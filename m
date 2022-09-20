Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566805BDD6E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 08:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiITGiV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 02:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiITGhu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 02:37:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147815F130;
        Mon, 19 Sep 2022 23:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7ADCB81CF0;
        Tue, 20 Sep 2022 06:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB2AC43147;
        Tue, 20 Sep 2022 06:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663655806;
        bh=UasumqK8JDy4QUm3XOKDPKXpUz8MeHWEZlWpEge7SHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IeT0Ow0e2gryqHF+YZVhz5RDYHB+9l7X0sWxU4OdZ7kVADENteCdIKKy8BgnyDs+g
         aX98x7IBRoo21LQ3YvCERTFpt2YhZxQRGozW1cMEJTcr3n7deMKW9gvXgNFaU0LBNK
         VBDFyN+SMs91kM2qpUgFawzOBTibAgIHgio83adRp67LXn+tEB/6HhwWaTne0YsUn+
         SvyNHbYDkZyJr+Xmg0kZ+/H4SNO+/dzpCIPgpOyLWcJmTbJGuzUvKUiUJNGp+yMODB
         4PI/UDtE1UvhtdaoPSIYRk0lpzXhlKwwFHZWBSI06BC7EVePaPZsiJt0bCzZsBBMXu
         Oo/s0hwlUESoQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-127d10b4f19so2826009fac.9;
        Mon, 19 Sep 2022 23:36:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf2nNfH1HpJgQE5HhSBknADMgwP7GCEP7vx4seBqcK8Mape9Are5
        bJyYOvFWASfrkn3Tyo5OF6v1VMVwrtMCEV4VRYM=
X-Google-Smtp-Source: AMsMyM6uHFgQjuLTZDoq4Wi16bBED+ipq/0qPmivsB6oIlMREURn4RpqQ/Co7zUtuew7caXA1KRyrH6dB1OH9wPOjsU=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr1178610oao.112.1663655805409; Mon, 19
 Sep 2022 23:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220918155246.1203293-1-guoren@kernel.org> <20220918155246.1203293-8-guoren@kernel.org>
 <Yyhv4UUXuSfvMOw+@hirez.programming.kicks-ass.net>
In-Reply-To: <Yyhv4UUXuSfvMOw+@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 20 Sep 2022 14:36:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRdkmemEWsDYhVXb8KD0PS6b1VAPu_MfeZ+Rmf2qEGa6Q@mail.gmail.com>
Message-ID: <CAJF2gTRdkmemEWsDYhVXb8KD0PS6b1VAPu_MfeZ+Rmf2qEGa6Q@mail.gmail.com>
Subject: Re: [PATCH V5 07/11] riscv: convert to generic entry
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, linux-arch@vger.kernel.org,
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

On Mon, Sep 19, 2022 at 9:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Sep 18, 2022 at 11:52:42AM -0400, guoren@kernel.org wrote:
>
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
>
> FWIW; on x86 I've classified many of the 'from-kernel' traps as
> NMI-like, since those traps can happen from any context, including with
> IRQs disabled.
The do_trap_break is for ebreak instruction, not NMI. RISC-V NMI has
separate CSR. ref:

This proposal adds support for resumable non-maskable interrupts
(RNMIs) to RISC-V. The extension adds four new CSRs (`mnepc`,
`mncause`, `mnstatus`, and `mnscratch`) to hold the interrupted state,
and a new instruction to resume from the RNMI handler.

>
> The basic shape of the trap handlers looks a little like:
>
>         if (user_mode(regs)) {
If nmi comes from user_mode, why we using
irqenrty_enter/exit_from/to_user_mode instead of
irqentry_nmi_enter/exit?

>                 irqenrty_enter_from_user_mode(regs);
>                 do_user_trap();
>                 irqentry_exit_to_user_mode(regs);
>         } else {
>                 irqentry_state_t state = irqentry_nmi_enter(regs);
>                 do_kernel_trap();
>                 irqentry_nmi_exit(regs, state);
>         }
>
> Not saying you have to match Risc-V in this patch-set, just something to
> consider.
I think the shape of the riscv NMI handler looks a little like this:

asmlinkage __visible __trap_section void do_trap_nmi(struct pt_regs *regs)
{
                 irqentry_state_t state = irqentry_nmi_enter(regs);
                 do_nmi_trap();
                 irqentry_nmi_exit(regs, state);
}

-- 
Best Regards
 Guo Ren
