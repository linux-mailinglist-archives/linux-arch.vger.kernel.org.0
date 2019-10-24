Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0372EE3D9A
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 22:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfJXUxO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 16:53:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33733 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfJXUxO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 16:53:14 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNk6T-0001J9-E7; Thu, 24 Oct 2019 22:53:05 +0200
Date:   Thu, 24 Oct 2019 22:52:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt
 disable
In-Reply-To: <CALCETrX+N_cR-HAmQyHxqUo0LPCk4GmqbzizXk-gq9qp00-RdA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910242032080.1783@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.296135499@linutronix.de> <20191023220618.qsmog2k5oaagj27v@treble> <alpine.DEB.2.21.1910240146200.1852@nanos.tec.linutronix.de>
 <CALCETrX+N_cR-HAmQyHxqUo0LPCk4GmqbzizXk-gq9qp00-RdA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 24 Oct 2019, Andy Lutomirski wrote:
> On Wed, Oct 23, 2019 at 4:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Wed, 23 Oct 2019, Josh Poimboeuf wrote:
> > > What happens if somebody accidentally leaves irqs enabled?  How do we
> > > know you found all the leaks?
> >
> > For the DO_ERROR() ones that's trivial:
> >
> >  #define DO_ERROR(trapnr, signr, sicode, addr, str, name)                  \
> >  dotraplinkage void do_##name(struct pt_regs *regs, long error_code)       \
> >  {                                                                         \
> >         do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
> > +       lockdep_assert_irqs_disabled();                                    \
> >  }
> >
> >  DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
> >
> > Now for the rest we surely could do:
> >
> > dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
> > {
> >         __do_bounds(regs, error_code);
> >         lockdep_assert_irqs_disabled();
> > }
> >
> > and move the existing body into a static function so independent of any
> > (future) return path there the lockdep assert will be invoked.
> >
> 
> If we do this, can we macro-ize it:
> 
> DEFINE_IDTENTRY_HANDLER(do_bounds)
> {
>  ...
> }
>  
> If you do this, please don't worry about the weird ones that take cr2
> as a third argument.  Once your series lands, I will send a follow-up
> to get rid of it.  It's 2/3 written already.

I spent quite some time digging deeper into this. Finding all corner cases
which eventually enable interrupts from an exception handler is not as
trivial as it looked in the first place. Especially the fault handler is a
nightmare. Also PeterZ's approach of doing

	   if (regs->eflags & IF)
	   	local_irq_disable();

is doomed due to sys_iopl(). See below.

I'm tempted to do pretty much the same thing as the syscall rework did
as a first step:

  - Move the actual handler invocation to C

  - Do the irq tracing on entry in C

  - Move irq disable before return to ASM

Peter gave me some half finished patches which pretty much do that by
copying half of the linux/syscalls.h macro maze into the entry code. That's
one possible solution, but TBH it sucks big times.

We have the following variants:

do_divide_error(struct pt_regs *regs, long error_code);
do_debug(struct pt_regs *regs, long error_code);
do_nmi(struct pt_regs *regs, long error_code);
do_int3(struct pt_regs *regs, long error_code);
do_overflow(struct pt_regs *regs, long error_code);
do_bounds(struct pt_regs *regs, long error_code);
do_invalid_op(struct pt_regs *regs, long error_code);
do_device_not_available(struct pt_regs *regs, long error_code);
do_coprocessor_segment_overrun(struct pt_regs *regs, long error_code);
do_invalid_TSS(struct pt_regs *regs, long error_code);
do_segment_not_present(struct pt_regs *regs, long error_code);
do_stack_segment(struct pt_regs *regs, long error_code);
do_general_protection(struct pt_regs *regs, long error_code);
do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
do_coprocessor_error(struct pt_regs *regs, long error_code);
do_alignment_check(struct pt_regs *regs, long error_code);
do_machine_check(struct pt_regs *regs, long error_code);
do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
do_iret_error(struct pt_regs *regs, long error_code);
do_mce(struct pt_regs *regs, long error_code);

do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
do_double_fault(struct pt_regs *regs, long error_code, unsigned long address);
do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);

So if we can remove the third argument then we can spare most of the macro
maze and just have one common function without bells and whistels. The
other option would be to extend all handlers to have three arguments,
i.e. add 'long unused', which is not pretty either.

What's your plan with cr2? Stash it in pt_regs or something else?

Once we have the interesting parts in C then we can revisit the elimination
of the unconditional irq disable because in C it's way simpler to do
diagnostics, but I'm not entirely sure whether it's worth it.

A related issue is the inconsistency of the irq disabled tracing in the
return to user path. As I pointed out in the other mail, the various
syscall implementations do that differently. The exception handlers do it
always conditional, regular interrupts as well. For regular interrupts that
does not make sense as they can by all means never return to an interrupt
disabled context.

The interesting bells and whistels result from sys_iopl(). If user space
has been granted iopl(level = 3) it gains cli/sti priviledges. When the
application has interrupts disabled in userspace:

  - invocation of a syscall

  - any exception (aside of NMI/MCE) which conditionally enables interrupts
    depending on user_mode(regs) and therefor can be preempted and
    schedule

is just undefined behaviour and I personally consider it to be a plain bug.

Just for the record: This results in running a resulting or even completely
unrelated signal handler with interrupts disabled as well.

Whatever we decide it is, leaving it completely inconsistent is not a
solution at all. The options are:

  1)  Always do conditional tracing depending on the user_regs->eflags.IF
      state.

  2)  #1 + warn once when syscalls and exceptions (except NMI/MCE) happen
      and user_regs->eflags.IF is cleared.

  3a) #2 + enforce signal handling to run with interrupts enabled.

  3b) #2 + set regs->eflags.IF. So the state is always correct from the
      kernel POV. Of course that changes existing behaviour, but its
      changing undefined and inconsistent behaviour.
  
  4) Let iopl(level) return -EPERM if level == 3.

     Yeah, I know it's not possible due to regressions (DPKD uses iopl(3)),
     but TBH that'd be the sanest option of all.

     Of course the infinite wisdom of hardware designers tied IN, INS, OUT,
     OUTS and CLI/STI together on IOPL so we cannot even distangle them in
     any way.

     The only way out would be to actually use a full 8K sized I/O bitmap,
     but that's a massive pain as it has to be copied on every context
     switch. 

Really pretty options to chose from ...

Thanks,

	tglx
