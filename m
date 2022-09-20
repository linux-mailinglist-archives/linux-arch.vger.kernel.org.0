Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F00A5BDE0C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 09:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiITHXg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 03:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiITHXf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 03:23:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA165501A0;
        Tue, 20 Sep 2022 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IKJaeDScRrK+JIC8Gbrvn6nNvLhPVYznUfIuOJ7G4Ds=; b=jhPn6HiiENFLg2SFmJ30AuSqoC
        n0UXjZX8nUjjPdJyhdMc3l6m4xaDuHk2DNFEEJBge5OsdKEDKncMdSqmzUhr63k0lWu0hqsOGgkED
        ItaA2kVSLRXIqMPBgNi60QXOnUkIWgXYDQDCRopZO3MX0wNNG8N2zfzAqVV+KrvlbkPGruxgRAOgH
        rvyr6aWBhnZhv7BbcxKvZa8Cwb/G6lb/9b6hsbO3oDm4uhEINaQgRhsr8Lhos76pNowo9NwzsBwHo
        kAaPYLs3ryTqyBUEYz8Gdu/JdYKNf12aWamFnyRf/8IiNLJsmGxa0RpdoYbVI8ld2gW+0cXYXrQlz
        JaNsv+hA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXaq-005LcW-AU; Tue, 20 Sep 2022 07:22:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7061300074;
        Tue, 20 Sep 2022 09:22:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C25E2BAC8466; Tue, 20 Sep 2022 09:22:50 +0200 (CEST)
Date:   Tue, 20 Sep 2022 09:22:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
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
Subject: Re: [PATCH V5 07/11] riscv: convert to generic entry
Message-ID: <YylqSsL6bdhIOMte@hirez.programming.kicks-ass.net>
References: <20220918155246.1203293-1-guoren@kernel.org>
 <20220918155246.1203293-8-guoren@kernel.org>
 <Yyhv4UUXuSfvMOw+@hirez.programming.kicks-ass.net>
 <CAJF2gTRdkmemEWsDYhVXb8KD0PS6b1VAPu_MfeZ+Rmf2qEGa6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRdkmemEWsDYhVXb8KD0PS6b1VAPu_MfeZ+Rmf2qEGa6Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 20, 2022 at 02:36:33PM +0800, Guo Ren wrote:
> On Mon, Sep 19, 2022 at 9:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sun, Sep 18, 2022 at 11:52:42AM -0400, guoren@kernel.org wrote:
> >
> > > @@ -123,18 +126,22 @@ int handle_misaligned_store(struct pt_regs *regs);
> > >
> > >  asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs *regs)
> > >  {
> > > +     irqentry_state_t state = irqentry_enter(regs);
> > >       if (!handle_misaligned_load(regs))
> > >               return;
> > >       do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> > >                     "Oops - load address misaligned");
> > > +     irqentry_exit(regs, state);
> > >  }
> > >
> > >  asmlinkage void __trap_section do_trap_store_misaligned(struct pt_regs *regs)
> > >  {
> > > +     irqentry_state_t state = irqentry_enter(regs);
> > >       if (!handle_misaligned_store(regs))
> > >               return;
> > >       do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> > >                     "Oops - store (or AMO) address misaligned");
> > > +     irqentry_exit(regs, state);
> > >  }
> > >  #endif
> > >  DO_ERROR_INFO(do_trap_store_fault,
> > > @@ -158,6 +165,8 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
> > >
> > >  asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
> > >  {
> > > +     irqentry_state_t state = irqentry_enter(regs);
> > > +
> > >  #ifdef CONFIG_KPROBES
> > >       if (kprobe_single_step_handler(regs))
> > >               return;
> >
> > FWIW; on x86 I've classified many of the 'from-kernel' traps as
> > NMI-like, since those traps can happen from any context, including with
> > IRQs disabled.
> The do_trap_break is for ebreak instruction, not NMI. RISC-V NMI has
> separate CSR. ref:
> 
> This proposal adds support for resumable non-maskable interrupts
> (RNMIs) to RISC-V. The extension adds four new CSRs (`mnepc`,
> `mncause`, `mnstatus`, and `mnscratch`) to hold the interrupted state,
> and a new instruction to resume from the RNMI handler.

Yes, but that's not what I'm saying. I'm saying I've classified
'from-kernel' traps as NMI-like.

Consider:

	raw_spin_lock_irq(&foo);
	...
	<trap>

Then you want the trap to behave as if it were an NMI; that is abide by
the rules of NMI (strictly wait-free code).

So yes, they are not NMI, but they nest just like it, so we want the
handlers to abide by the same rules.

Does that make sense?

> >
> > The basic shape of the trap handlers looks a little like:
> >
> >         if (user_mode(regs)) {
> If nmi comes from user_mode, why we using
> irqenrty_enter/exit_from/to_user_mode instead of
> irqentry_nmi_enter/exit?

s/nmi/trap/ because the 'from-user' trap never nests inside kernel code.

Additionally, many 'from-user' traps want to do 'silly' things like send
signals, which is something that requires scheduling.

They're fundamentally different from 'from-kernel' traps, which per the
above, nest most dangerously.

> >                 irqenrty_enter_from_user_mode(regs);
> >                 do_user_trap();
> >                 irqentry_exit_to_user_mode(regs);
> >         } else {
> >                 irqentry_state_t state = irqentry_nmi_enter(regs);
> >                 do_kernel_trap();
> >                 irqentry_nmi_exit(regs, state);
> >         }
> >
> > Not saying you have to match Risc-V in this patch-set, just something to
> > consider.
> I think the shape of the riscv NMI handler looks a little like this:
> 
> asmlinkage __visible __trap_section void do_trap_nmi(struct pt_regs *regs)
> {
>                  irqentry_state_t state = irqentry_nmi_enter(regs);
>                  do_nmi_trap();
>                  irqentry_nmi_exit(regs, state);
> }

That is correct for the NMI handler; but here I'm specifically talking
about traps, like the unalign trap, break trap etc. Those that can
happen *anywhere* in kernel code and nest most unfortunate.
