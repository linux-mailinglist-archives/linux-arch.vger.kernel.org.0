Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6E123418
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2019 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfLQSB5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Dec 2019 13:01:57 -0500
Received: from foss.arm.com ([217.140.110.172]:44004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfLQSB4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 13:01:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BF2E30E;
        Tue, 17 Dec 2019 10:01:56 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70A7B3F67D;
        Tue, 17 Dec 2019 10:01:54 -0800 (PST)
Date:   Tue, 17 Dec 2019 18:01:52 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 13/22] arm64: mte: Handle synchronous and asynchronous
 tag check faults
Message-ID: <20191217180152.GO5624@arrakis.emea.arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-14-catalin.marinas@arm.com>
 <CAMn1gO6RDrpkO6hygTUuXbsE5XTD+FEsZKpo5cqgg+nQWfBVKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO6RDrpkO6hygTUuXbsE5XTD+FEsZKpo5cqgg+nQWfBVKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 13, 2019 at 05:43:15PM -0800, Peter Collingbourne wrote:
> On Wed, Dec 11, 2019 at 10:44 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > index dd2cdc0d5be2..41fae64af82a 100644
> > --- a/arch/arm64/kernel/signal.c
> > +++ b/arch/arm64/kernel/signal.c
> > @@ -730,6 +730,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
> >         regs->regs[29] = (unsigned long)&user->next_frame->fp;
> >         regs->pc = (unsigned long)ka->sa.sa_handler;
> >
> > +       /* TCO (Tag Check Override) always cleared for signal handlers */
> > +       regs->pstate &= ~PSR_TCO_BIT;
> > +
> >         if (ka->sa.sa_flags & SA_RESTORER)
> >                 sigtramp = ka->sa.sa_restorer;
> >         else
> > @@ -921,6 +924,11 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
> >                         if (thread_flags & _TIF_UPROBE)
> >                                 uprobe_notify_resume(regs);
> >
> > +                       if (thread_flags & _TIF_MTE_ASYNC_FAULT) {
> > +                               clear_thread_flag(TIF_MTE_ASYNC_FAULT);
> > +                               force_signal_inject(SIGSEGV, SEGV_MTEAERR, 0);
> 
> In the case where the kernel is entered due to a syscall, this will
> inject a signal, but only after servicing the syscall. This means
> that, for example, if the syscall is exit(), the async tag check
> failure will be silently ignored. I can reproduce the problem with the
> program below:
[...]
> This patch fixes the problem for me:
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 9a9d98a443fc..d0c8918dee00 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -94,6 +94,8 @@ static void el0_svc_common(struct pt_regs *regs, int
> scno, int sc_nr,
>                            const syscall_fn_t syscall_table[])
>  {
>         unsigned long flags = current_thread_info()->flags;
> +       if (flags & _TIF_MTE_ASYNC_FAULT)
> +               return;

It needs a bit of thinking. This one wouldn't work if you want to handle
the signal and resume since it would skip the SVC instruction. We'd need
at least to do a regs->pc -= 4 and probably move it further down in this
function.

-- 
Catalin
