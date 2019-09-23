Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093FFBB31D
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 13:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfIWLtc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 07:49:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41554 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfIWLtb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 07:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ph1WQsqjHm2MqFAqK+Rq1wUKmhEoeBwxc1DezgR1MvQ=; b=xjOY/yJAxhq3pjMxLi2rMPdo1
        +G+szJYH/C+RE8i4eCh+peXajGrou/54xo/DrAFyJQHEumqz60ByBk8BjnbMQnMwXHFr8m1gmN7X8
        g60ACSYpGBFCKbGMbUczJe1op8OLUaNboInW2OhqIqatD8eLrcJVGmjCsvFw09/AFjZ33E/OvsQy8
        46/AVmIOgZvrmvPoCPMqUBTdb4LZTmGi+J8g2IpreKxNjfIgcrsHCWjQgey+n0iuuuueMxQG24cAp
        9ga4ah4xiGBi0giLBwYxLDU8vB52cOokTqGNZdPweaavVQ7Z2RjpIsH7LMXvbijU/mNKOah3iAjPM
        onquEZ/VA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCMqI-0002oW-EL; Mon, 23 Sep 2019 11:49:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1954301A7A;
        Mon, 23 Sep 2019 13:48:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB7D820C3E177; Mon, 23 Sep 2019 13:49:20 +0200 (CEST)
Date:   Mon, 23 Sep 2019 13:49:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, jgross@suse.com
Subject: Re: [RFC patch 10/15] x86/entry: Move irq tracing to C code
Message-ID: <20190923114920.GF2332@hirez.programming.kicks-ass.net>
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.446771597@linutronix.de>
 <20190923084718.GG2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909231227050.2003@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909231227050.2003@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 23, 2019 at 12:27:47PM +0200, Thomas Gleixner wrote:
> On Mon, 23 Sep 2019, Peter Zijlstra wrote:
> 
> > On Thu, Sep 19, 2019 at 05:03:24PM +0200, Thomas Gleixner wrote:
> > > To prepare for converting the exit to usermode code to the generic version,
> > > move the irqflags tracing into C code.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > ---
> > >  arch/x86/entry/common.c          |   10 ++++++++++
> > >  arch/x86/entry/entry_32.S        |   11 +----------
> > >  arch/x86/entry/entry_64.S        |   10 ++--------
> > >  arch/x86/entry/entry_64_compat.S |   21 ---------------------
> > >  4 files changed, 13 insertions(+), 39 deletions(-)
> > > 
> > > --- a/arch/x86/entry/common.c
> > > +++ b/arch/x86/entry/common.c
> > > @@ -102,6 +102,8 @@ static void exit_to_usermode_loop(struct
> > >  	struct thread_info *ti = current_thread_info();
> > >  	u32 cached_flags;
> > >  
> > > +	trace_hardirqs_off();
> > 
> > Bah.. so this gets called from:
> > 
> >  - C code, with IRQs disabled
> >  - entry_64.S:error_exit
> >  - entry_32.S:resume_userspace
> > 
> > The first obviously doesn't need this annotation, but this patch doesn't
> > remove the TRACE_IRQS_OFF from entry_64.S and only the 32bit case is
> > changed.
> > 
> > Is that entry_64.S case an oversight, or do we need an extensive comment
> > on this one?
> 
> Lemme stare at that again. At some point I probably lost track in that maze.

While walking the kids to school I wondered WTH we need to call
TRACE_IRQS_OFF in the first place. If this is the return from exception
path, interrupts had better be disabled already (in exception enter).

For entry_64.S we have:

  - idtentry_part; which does TRACE_IRQS_OFF at the start and error_exit
    at the end.

  - xen_do_hypervisor_callback, xen_failsafe_callback -- which are
    confusing.

So in the normal case, it appears we can simply do:

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b7c3ea4cb19d..e9cf59ac554e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1368,8 +1368,6 @@ END(error_entry)
 
 ENTRY(error_exit)
 	UNWIND_HINT_REGS
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
 	testb	$3, CS(%rsp)
 	jz	retint_kernel
 	jmp	retint_user

and all should be well. This leaves Xen...

For entry_32.S it looks like nothing uses 'resume_userspace' so that
ENTRY can go away. Which then leaves:

 * ret_from_intr:
  - common_spurious: TRACE_IRQS_OFF
  - common_interrupt: TRACE_IRQS_OFF
  - BUILD_INTERRUPT3: TRACE_IRQS_OFF
  - xen_do_upcall: ...

 * ret_from_exception:
  - xen_failsafe_callback: ...
  - common_exception_read_cr2: TRACE_IRQS_OFF
  - common_exception: TRACE_IRQS_OFF
  - int3: TRACE_IRQS_OFF

Which again suggests:

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index f83ca5aa8b77..7a19e7413a8e 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -825,9 +825,6 @@ END(ret_from_fork)
 	cmpl	$USER_RPL, %eax
 	jb	restore_all_kernel		# not returning to v8086 or userspace
 
-ENTRY(resume_userspace)
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
 	movl	%esp, %eax
 	call	prepare_exit_to_usermode
 	jmp	restore_all

with the notable exception (oh teh pun!) being Xen... _again_.

With these patchlets on, we'd want prepare_exit_to_usermode() to
validate the IRQ state, but AFAICT it _should_ all just 'work' (famous
last words).

Cc Juergen because Xen
