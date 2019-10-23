Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D1E26E9
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 01:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408014AbfJWXQP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 19:16:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51296 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfJWXQP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 19:16:15 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNPrM-0002cM-M8; Thu, 24 Oct 2019 01:16:08 +0200
Date:   Thu, 24 Oct 2019 01:16:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 08/17] x86/entry: Move syscall irq tracing to C code
In-Reply-To: <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910240037570.1852@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.386844979@linutronix.de> <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com>
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

On Wed, 23 Oct 2019, Andy Lutomirski wrote:

> On Wed, Oct 23, 2019 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Interrupt state tracing can be safely done in C code. The few stack
> > operations in assembly do not need to be covered.
> >
> > Remove the now pointless indirection via .Lsyscall_32_done and jump to
> > swapgs_restore_regs_and_return_to_usermode directly.
> 
> This doesn't look right.
> 
> >  #define SYSCALL_EXIT_WORK_FLAGS                                \
> > @@ -279,6 +282,9 @@ static void syscall_slow_exit_work(struc
> >  {
> >         struct thread_info *ti;
> >
> > +       /* User to kernel transition disabled interrupts. */
> > +       trace_hardirqs_off();
> > +
> 
> So you just traced IRQs off, but...
> 
> >         enter_from_user_mode();
> >         local_irq_enable();
> 
> Now they're on and traced on again?

Yes, because that's what actually happens.

usermode
 syscall		<- Disables interrupts, but tracing thinks they are on
   entry_SYSCALL_64
   ....
   call do_syscall_64

     trace_hardirqs_off() <- So before calling anything else, we have to tell
			     the tracer that interrupts are on, which we did
			     so far in the ASM code between entry_SYSCALL_64
			     and 'call do_syscall_64'. I'm merily lifting this
			     to C-code.

     enter_from_user_mode()
     local_irq_enable()
 
> I also don't see how your patch handles the fastpath case.

Hmm?

All syscalls return through:

    syscall_return_slowpath()
        local_irq_disable()
	prepare_exit_to_usermode()
	  user_enter_irqoff()
	  mds_user_clear_cpu_buffers()
	  trace_hardirqs_on()

What am I missing?
 
> How about the attached patch instead?

      	    	^^^^^^ Groan.

>
>  	user_enter_irqoff();
>  
> +	/*
> +	 * The actual return to usermode will almost certainly turn IRQs on.
> +	 * Trace it here to simplify the asm code.

Why would we return to user from a syscall or interrupt with interrupts
traced as disabled? Also the existing ASM is inconsistent vs. that:

ENTRY(entry_SYSENTER_32)        TRACE_IRQS_ON

ENTRY(entry_INT80_32)		TRACE_IRQS_IRET

ENTRY(entry_SYSCALL_64)		TRACE_IRQS_IRET

ENTRY(ret_from_fork)		TRACE_IRQS_ON

GLOBAL(retint_user)		TRACE_IRQS_IRETQ

ENTRY(entry_SYSCALL_compat)	TRACE_IRQS_ON

ENTRY(entry_INT80_compat)	TRACE_IRQS_ON

> +	 */
> +	if (likely(regs->flags & X86_EFLAGS_IF))
> +		trace_hardirqs_on();

My variant does this unconditionally and after
mds_user_clear_cpu_buffers().

> 	mds_user_clear_cpu_buffers();
> }
 
And your ASM changes keep still all the TRACE_IRQS_OFF invocations in the
various syscall entry pathes, which is what I removed and put as the first
thing into the C functions.

Confused.

Thanks,

	tglx
