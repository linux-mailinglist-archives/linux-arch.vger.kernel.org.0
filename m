Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37750E3E16
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 23:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfJXVYV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 17:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfJXVYV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Oct 2019 17:24:21 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8A321D7E
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2019 21:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571952259;
        bh=7M6g3d23nu+as4txKP7qhtwdggKIeiqbAUCLIQNX5tE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D+Ji1qCqi6wEDbkfRtaHJsGTQoMB0ku3AvlncPFcTTOO+gps42gk8JAMqP6Dxlivh
         GbcD6qM6Ux1ae6fDJULM7ykx3x/P68vMI61pp/B2KVYXsVEvHVHCB3ttK+RmRiwWot
         aTTdsg7B/kRi624k4I9BS04MJMCYUZogTxFq+irk=
Received: by mail-wm1-f45.google.com with SMTP id r141so3954756wme.4
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2019 14:24:19 -0700 (PDT)
X-Gm-Message-State: APjAAAVSscmhoLn5/tiO0fVPWLQSVVCV1eQJS14UQzKulLothbH0m0qq
        nzRaA1mAMmYBxnhtPj63JsQ/l/96YExCHt9Dl+63+A==
X-Google-Smtp-Source: APXvYqx3YbuVjjW90sEqQPfhPCRz3d4DpXfSdJJFWHTpqYg0Brg2oBFw6/G/nbDEGNRgrJMOsQbez2v6JlMOebzuFyY=
X-Received: by 2002:a1c:20d8:: with SMTP id g207mr323194wmg.79.1571952257553;
 Thu, 24 Oct 2019 14:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191023122705.198339581@linutronix.de> <20191023123118.296135499@linutronix.de>
 <20191023220618.qsmog2k5oaagj27v@treble> <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de>
 <CALCETrX+N_cR-HAmQyHxqUo0LPCk4GmqbzizXk-gq9qp00-RdA@mail.gmail.com> <alpine.DEB.2.21.1910242032080.1783@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910242032080.1783@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 24 Oct 2019 14:24:06 -0700
X-Gmail-Original-Message-ID: <CALCETrXyhnMwwOyWQ-FtsNFAsrcG41-pPrAp8Wj2vc0N9JzP-Q@mail.gmail.com>
Message-ID: <CALCETrXyhnMwwOyWQ-FtsNFAsrcG41-pPrAp8Wj2vc0N9JzP-Q@mail.gmail.com>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt disable
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 24, 2019 at 1:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 24 Oct 2019, Andy Lutomirski wrote:
> > On Wed, Oct 23, 2019 at 4:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Wed, 23 Oct 2019, Josh Poimboeuf wrote:
> > > > What happens if somebody accidentally leaves irqs enabled?  How do we
> > > > know you found all the leaks?
> > >
> > > For the DO_ERROR() ones that's trivial:
> > >
> > >  #define DO_ERROR(trapnr, signr, sicode, addr, str, name)                  \
> > >  dotraplinkage void do_##name(struct pt_regs *regs, long error_code)       \
> > >  {                                                                         \
> > >         do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
> > > +       lockdep_assert_irqs_disabled();                                    \
> > >  }
> > >
> > >  DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
> > >
> > > Now for the rest we surely could do:
> > >
> > > dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
> > > {
> > >         __do_bounds(regs, error_code);
> > >         lockdep_assert_irqs_disabled();
> > > }
> > >
> > > and move the existing body into a static function so independent of any
> > > (future) return path there the lockdep assert will be invoked.
> > >
> >
> > If we do this, can we macro-ize it:
> >
> > DEFINE_IDTENTRY_HANDLER(do_bounds)
> > {
> >  ...
> > }
> >
> > If you do this, please don't worry about the weird ones that take cr2
> > as a third argument.  Once your series lands, I will send a follow-up
> > to get rid of it.  It's 2/3 written already.
>
> I spent quite some time digging deeper into this. Finding all corner cases
> which eventually enable interrupts from an exception handler is not as
> trivial as it looked in the first place. Especially the fault handler is a
> nightmare. Also PeterZ's approach of doing
>
>            if (regs->eflags & IF)
>                 local_irq_disable();
>
> is doomed due to sys_iopl(). See below.

I missed something in the discussion.  What breaks?  Can you check
user_mode(regs) too?

>
> I'm tempted to do pretty much the same thing as the syscall rework did
> as a first step:
>
>   - Move the actual handler invocation to C
>
>   - Do the irq tracing on entry in C
>
>   - Move irq disable before return to ASM
>
> Peter gave me some half finished patches which pretty much do that by
> copying half of the linux/syscalls.h macro maze into the entry code. That's
> one possible solution, but TBH it sucks big times.
>
> We have the following variants:
>
> do_divide_error(struct pt_regs *regs, long error_code);
> do_debug(struct pt_regs *regs, long error_code);
> do_nmi(struct pt_regs *regs, long error_code);
> do_int3(struct pt_regs *regs, long error_code);
> do_overflow(struct pt_regs *regs, long error_code);
> do_bounds(struct pt_regs *regs, long error_code);
> do_invalid_op(struct pt_regs *regs, long error_code);
> do_device_not_available(struct pt_regs *regs, long error_code);
> do_coprocessor_segment_overrun(struct pt_regs *regs, long error_code);
> do_invalid_TSS(struct pt_regs *regs, long error_code);
> do_segment_not_present(struct pt_regs *regs, long error_code);
> do_stack_segment(struct pt_regs *regs, long error_code);
> do_general_protection(struct pt_regs *regs, long error_code);
> do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
> do_coprocessor_error(struct pt_regs *regs, long error_code);
> do_alignment_check(struct pt_regs *regs, long error_code);
> do_machine_check(struct pt_regs *regs, long error_code);
> do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
> do_iret_error(struct pt_regs *regs, long error_code);
> do_mce(struct pt_regs *regs, long error_code);
>
> do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
> do_double_fault(struct pt_regs *regs, long error_code, unsigned long address);
> do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
>
> So if we can remove the third argument then we can spare most of the macro
> maze and just have one common function without bells and whistels. The
> other option would be to extend all handlers to have three arguments,
> i.e. add 'long unused', which is not pretty either.
>
> What's your plan with cr2? Stash it in pt_regs or something else?

Just read it from CR2.  I added a new idtentry macro arg called
"entry_work", and setting it to 0 causes the enter_from_user_mode to
be skipped.  Then C code calls enter_from_user_mode() after reading
CR2 (and DR7).  WIP code is here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/idtentry

The idea is that, if everything is converted, then we get rid of the
entry_work=1 case, which is easier if there's a macro.

So my suggestion is to use a macro for the 2-arg version and open-code
all the 3-arg cases.  Then, when the dust settles, we get rid of the
third arg and they can use the macro.

>
> The interesting bells and whistels result from sys_iopl(). If user space
> has been granted iopl(level = 3) it gains cli/sti priviledges. When the
> application has interrupts disabled in userspace:
>
>   - invocation of a syscall
>
>   - any exception (aside of NMI/MCE) which conditionally enables interrupts
>     depending on user_mode(regs) and therefor can be preempted and
>     schedule
>
> is just undefined behaviour and I personally consider it to be a plain bug.
>
> Just for the record: This results in running a resulting or even completely
> unrelated signal handler with interrupts disabled as well.

I am seriously tempted to say that the solution is to remove iopl(),
at least on 64-bit kernels.  Doing STI in user mode is BS :)

Otherwise we need to give it semantics, no?  I personally have no
actual problem with the fact that an NMI can cause scheduling to
happen.  Big fscking deal.

>
> Whatever we decide it is, leaving it completely inconsistent is not a
> solution at all. The options are:
>
>   1)  Always do conditional tracing depending on the user_regs->eflags.IF
>       state.

I'm okay with always tracing like user mode means IRQs on or doing it
"correctly".  I consider the former to be simpler and therefore quite
possibly better.

>
>   2)  #1 + warn once when syscalls and exceptions (except NMI/MCE) happen
>       and user_regs->eflags.IF is cleared.
>
>   3a) #2 + enforce signal handling to run with interrupts enabled.
>
>   3b) #2 + set regs->eflags.IF. So the state is always correct from the
>       kernel POV. Of course that changes existing behaviour, but its
>       changing undefined and inconsistent behaviour.
>
>   4) Let iopl(level) return -EPERM if level == 3.
>
>      Yeah, I know it's not possible due to regressions (DPKD uses iopl(3)),
>      but TBH that'd be the sanest option of all.
>
>      Of course the infinite wisdom of hardware designers tied IN, INS, OUT,
>      OUTS and CLI/STI together on IOPL so we cannot even distangle them in
>      any way.

>
>      The only way out would be to actually use a full 8K sized I/O bitmap,
>      but that's a massive pain as it has to be copied on every context
>      switch.

Hmm.  This actually doesn't seem that bad.  We already have a TIF_
flag to optimize this.  So basically iopl() would effectively become
ioperm(everything on).
