Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF8B7E2704
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 01:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404578AbfJWXbp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 19:31:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51335 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbfJWXbp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 19:31:45 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNQ6N-0002li-CP; Thu, 24 Oct 2019 01:31:39 +0200
Date:   Thu, 24 Oct 2019 01:31:38 +0200 (CEST)
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
In-Reply-To: <CALCETrWvnge064VUY3FQKens2Nx8BPNDhUZAXCvF6bD7VJy93A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910240124410.1852@nanos.tec.linutronix.de>
References: <20191023122705.198339581@linutronix.de> <20191023123118.386844979@linutronix.de> <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com> <CALCETrWvnge064VUY3FQKens2Nx8BPNDhUZAXCvF6bD7VJy93A@mail.gmail.com>
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
> On Wed, Oct 23, 2019 at 2:30 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Oct 23, 2019 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Interrupt state tracing can be safely done in C code. The few stack
> > > operations in assembly do not need to be covered.
> > >
> > > Remove the now pointless indirection via .Lsyscall_32_done and jump to
> > > swapgs_restore_regs_and_return_to_usermode directly.
> >
> > This doesn't look right.
> >
> > >  #define SYSCALL_EXIT_WORK_FLAGS                                \
> > > @@ -279,6 +282,9 @@ static void syscall_slow_exit_work(struc
> > >  {
> > >         struct thread_info *ti;
> > >
> > > +       /* User to kernel transition disabled interrupts. */
> > > +       trace_hardirqs_off();
> > > +
> >
> > So you just traced IRQs off, but...
> >
> > >         enter_from_user_mode();
> > >         local_irq_enable();
> >
> > Now they're on and traced on again?
> >
> > I also don't see how your patch handles the fastpath case.
> >
> > How about the attached patch instead?
> 
> Ignore the attached patch.  You have this in your
> do_exit_to_usermode() later in the series.  But I'm still quite
> confused by this patch.

What's confusing you? It basically does:

  ENTRY(syscall/int80)

-	TRACE_IRQS_OFF
	call C-syscall*()
-	TRACE_IRQS_ON/IRET

and

C-syscall*()

+       trace_hardirqs_off()		<- first action
	....
	prepare_exit_to_usermode()	<- last action
	return

and

prepare_exit_to_usermode()
	....
+       trace_hardirqs_on()		<- last action
	return

So this is exactly the same as the ASM today.

The only change is that I made it do unconditionally trace_hardirqs_on()
for consistency reasons.

I tried to split it into bits and pieces, but failed to come up with
something sensible. Let me try again tomorrow.

Thanks,

	tglx
