Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C8674CF5B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 10:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGJIC3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 04:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGJIC2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 04:02:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B054A6;
        Mon, 10 Jul 2023 01:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=yNHDpzzYjieskAxABdDoEsqYSB5/uS6TUrXGMxgOO98=; b=N99m4nozzqxFHNBeNmFnfuL0Yp
        +A521LWm9TiYTqrAsIYVfa3VHL0b9r5GMrproiVKMHVOP6TE4Cy8w/TftoGRFFiaDE38kqnMcjsDH
        xeUABEteMR+PZlpoHFfw+Qz0DCKQnPO0MK7fC3o85tgPx7g1tthDfgRVNUrjUEFHYVZ6vjXBHamOJ
        cu4xFA/boDgzrKZD8/iF4a0jqsJ1XQdes6nuQLeD7eWIgQeuaGyB7BVs5ACRMjnCrN9/thpPP4JxP
        8bfYNPFbswyKbBnUGgHpYfBUErFA4J839MBBYWAF1b+sPPpl8i7JwdDotUHM+5p+JBnDzLgFVyg/4
        HwAW5SBA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIlqF-000jDT-0v;
        Mon, 10 Jul 2023 08:01:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFEC1300274;
        Mon, 10 Jul 2023 10:01:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6346D29984D29; Mon, 10 Jul 2023 10:01:52 +0200 (CEST)
Date:   Mon, 10 Jul 2023 10:01:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        palmer@dabbelt.com, bjorn@rivosinc.com, daniel.thompson@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
Message-ID: <20230710080152.GA3028865@hirez.programming.kicks-ass.net>
References: <20230702025708.784106-1-guoren@kernel.org>
 <20230704164003.GB83892@hirez.programming.kicks-ass.net>
 <CAJF2gTTc0Gyo=K-0dCW6wu7q=Wq34hgTB69qJ7VSF_KAgKhavA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTTc0Gyo=K-0dCW6wu7q=Wq34hgTB69qJ7VSF_KAgKhavA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 09, 2023 at 10:30:22AM +0800, Guo Ren wrote:
> On Wed, Jul 5, 2023 at 12:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > The irqentry_nmi_enter/exit would force the current context into in_interrupt.
> > > That would trigger the kernel to dead panic, but the kdb still needs "ebreak" to
> > > debug the kernel.
> > >
> > > Move irqentry_nmi_enter/exit to exception_enter/exit could correct handle_break
> > > of the kernel side.
> >
> > This doesn't explain much if anything :/
> >
> > I'm confused (probably because I don't know RISC-V very well), what's
> > EBREAK and how does it happen?
> EBREAK is just an instruction of riscv which would rise breakpoint exception.
> 
> 
> >
> > Specifically, if EBREAK can happen inside an local_irq_disable() region,
> > then the below change is actively wrong. Any exception/interrupt that
> > can happen while local_irq_disable() must be treated like an NMI.
> When the ebreak happend out of local_irq_disable region, but
> __nmi_enter forces handle_break() into in_interupt() state. So how

And why is that a problem? I think I'm missing something fundamental
here...

> about:
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f910dfccbf5d..69f7043a98b9 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -18,6 +18,7 @@
>  #include <linux/irq.h>
>  #include <linux/kexec.h>
>  #include <linux/entry-common.h>
> +#include <linux/context_tracking.h>
> 
>  #include <asm/asm-prototypes.h>
>  #include <asm/bug.h>
> @@ -285,12 +286,18 @@ asmlinkage __visible __trap_section void
> do_trap_break(struct pt_regs *regs)
>                 handle_break(regs);
> 
>                 irqentry_exit_to_user_mode(regs);
> -       } else {
> +       } else if (in_interrupt()){
>                 irqentry_state_t state = irqentry_nmi_enter(regs);
> 
>                 handle_break(regs);
> 
>                 irqentry_nmi_exit(regs, state);
> +       } else {
> +               enum ctx_state prev_state = exception_enter();
> +
> +               handle_break(regs);
> +
> +               exception_exit(prev_state);
>         }
>  }

That's wrong. If you want to make it conditional, you have to look at
!(regs->status & SR_IE) (that's the interrupt enable flag of the
interrupted context, right?)

When you hit an EBREAK when IRQs were disabled, you must be NMI like.

But making it conditional like this makes it really hard to write a
handler though, it basically must assume it will be NMI contetx (because
it can't know) so there is no point in sometimes not doing NMI context.
