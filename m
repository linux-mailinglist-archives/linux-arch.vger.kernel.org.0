Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E50BB362
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 14:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392204AbfIWMKK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 08:10:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41642 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387524AbfIWMKK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 08:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L4tEhimko8J+iZHa8gZGRUaGzlJawq1HCtEyJj3yIJ0=; b=Pr/sDrttJStI+l6HZ3wniDRjR
        zHdj6VlhiyWsNITxYwv4EBg89pl6D0XTNhPtVgZ/wH50Ju9E+NusEzObbKzc2NbzHnXT0GueSgU6+
        lK3FP6Jn+6qkUqC0/MjV0/8RVJRR1XwWSw8xYKXbfplKdLNa7R/0zx8AATwpZGBd2u5mrnrOhg3Iw
        86IBztMyOlJ8YlOFTXotpuahPEotkxT4wBLm9j+CLnMEu5k/FRN+3t/gxHm0JXjN2pEa+NPiwdFfm
        QJJsyn7Cs/E6nyaJDN4ebqHUlTAdkZ6GAnjQsaauwy816kR2cBg/vPbiiA6i32nFthlmeOEpibela
        /7Q3zq1wA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCNAJ-0002wp-5P; Mon, 23 Sep 2019 12:10:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77B13301A7A;
        Mon, 23 Sep 2019 14:09:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7645020D80D79; Mon, 23 Sep 2019 14:10:01 +0200 (CEST)
Date:   Mon, 23 Sep 2019 14:10:01 +0200
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
Message-ID: <20190923121001.GG2332@hirez.programming.kicks-ass.net>
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.446771597@linutronix.de>
 <20190923084718.GG2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909231227050.2003@nanos.tec.linutronix.de>
 <20190923114920.GF2332@hirez.programming.kicks-ass.net>
 <20190923115551.GZ2386@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923115551.GZ2386@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 23, 2019 at 01:55:51PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 23, 2019 at 01:49:20PM +0200, Peter Zijlstra wrote:
> > While walking the kids to school I wondered WTH we need to call
> > TRACE_IRQS_OFF in the first place. If this is the return from exception
> > path, interrupts had better be disabled already (in exception enter).
> > 
> > For entry_64.S we have:
> > 
> >   - idtentry_part; which does TRACE_IRQS_OFF at the start and error_exit
> >     at the end.
> > 
> >   - xen_do_hypervisor_callback, xen_failsafe_callback -- which are
> >     confusing.
> > 
> > So in the normal case, it appears we can simply do:
> > 
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index b7c3ea4cb19d..e9cf59ac554e 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -1368,8 +1368,6 @@ END(error_entry)
> >  
> >  ENTRY(error_exit)
> >  	UNWIND_HINT_REGS
> > -	DISABLE_INTERRUPTS(CLBR_ANY)
> > -	TRACE_IRQS_OFF
> >  	testb	$3, CS(%rsp)
> >  	jz	retint_kernel
> >  	jmp	retint_user
> > 
> > and all should be well. This leaves Xen...
> > 
> > For entry_32.S it looks like nothing uses 'resume_userspace' so that
> > ENTRY can go away. Which then leaves:
> > 
> >  * ret_from_intr:
> >   - common_spurious: TRACE_IRQS_OFF
> >   - common_interrupt: TRACE_IRQS_OFF
> >   - BUILD_INTERRUPT3: TRACE_IRQS_OFF
> >   - xen_do_upcall: ...
> > 
> >  * ret_from_exception:
> >   - xen_failsafe_callback: ...
> >   - common_exception_read_cr2: TRACE_IRQS_OFF
> >   - common_exception: TRACE_IRQS_OFF
> >   - int3: TRACE_IRQS_OFF
> > 
> > Which again suggests:
> > 
> > diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> > index f83ca5aa8b77..7a19e7413a8e 100644
> > --- a/arch/x86/entry/entry_32.S
> > +++ b/arch/x86/entry/entry_32.S
> > @@ -825,9 +825,6 @@ END(ret_from_fork)
> >  	cmpl	$USER_RPL, %eax
> >  	jb	restore_all_kernel		# not returning to v8086 or userspace
> >  
> > -ENTRY(resume_userspace)
> > -	DISABLE_INTERRUPTS(CLBR_ANY)
> > -	TRACE_IRQS_OFF
> >  	movl	%esp, %eax
> >  	call	prepare_exit_to_usermode
> >  	jmp	restore_all
> > 
> > with the notable exception (oh teh pun!) being Xen... _again_.
> > 
> > With these patchlets on, we'd want prepare_exit_to_usermode() to
> > validate the IRQ state, but AFAICT it _should_ all just 'work' (famous
> > last words).
> > 
> > Cc Juergen because Xen
> 
> Arrgh.. faults!! they do local_irq_enable() but never disable them
> again. Arguably those functions should be symmetric and restore IF when
> they muck with it instead of relying on the exit path fixing things up.

---
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
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4bb0f8447112..663d44c68f67 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -276,6 +276,7 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
 			NOTIFY_STOP) {
 		cond_local_irq_enable(regs);
 		do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
+		cond_local_irq_disable(regs);
 	}
 }
 
@@ -501,6 +502,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 		die("bounds", regs, error_code);
 	}
 
+	cond_local_irq_disable(regs);
 	return;
 
 exit_trap:
@@ -512,6 +514,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	 * time..
 	 */
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
+	cond_local_irq_disable(regs);
 }
 
 dotraplinkage void
@@ -525,19 +528,19 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
 		if (user_mode(regs) && fixup_umip_exception(regs))
-			return;
+			goto exit_trap;
 	}
 
 	if (v8086_mode(regs)) {
 		local_irq_enable();
 		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
-		return;
+		goto exit_trap;
 	}
 
 	tsk = current;
 	if (!user_mode(regs)) {
 		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
-			return;
+			goto exit_trap;
 
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
@@ -549,12 +552,12 @@ do_general_protection(struct pt_regs *regs, long error_code)
 		 */
 		if (!preemptible() && kprobe_running() &&
 		    kprobe_fault_handler(regs, X86_TRAP_GP))
-			return;
+			goto exit_trap;
 
 		if (notify_die(DIE_GPF, desc, regs, error_code,
 			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
 			die(desc, regs, error_code);
-		return;
+		goto exit_trap;
 	}
 
 	tsk->thread.error_code = error_code;
@@ -563,6 +566,8 @@ do_general_protection(struct pt_regs *regs, long error_code)
 	show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 
 	force_sig(SIGSEGV);
+exit_trap:
+	cond_local_irq_disable(regs);
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
@@ -783,9 +788,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	if (v8086_mode(regs)) {
 		handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code,
 					X86_TRAP_DB);
-		cond_local_irq_disable(regs);
-		debug_stack_usage_dec();
-		goto exit;
+		goto exit_irq;
 	}
 
 	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
@@ -802,6 +805,8 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	si_code = get_si_code(tsk->thread.debugreg6);
 	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
 		send_sigtrap(regs, error_code, si_code);
+
+exit_irq:
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
 
@@ -827,7 +832,7 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 
 	if (!user_mode(regs)) {
 		if (fixup_exception(regs, trapnr, error_code, 0))
-			return;
+			goto exit_trap;
 
 		task->thread.error_code = error_code;
 		task->thread.trap_nr = trapnr;
@@ -835,7 +840,7 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 		if (notify_die(DIE_TRAP, str, regs, error_code,
 					trapnr, SIGFPE) != NOTIFY_STOP)
 			die(str, regs, error_code);
-		return;
+		goto exit_trap;
 	}
 
 	/*
@@ -849,10 +854,12 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 	si_code = fpu__exception_code(fpu, trapnr);
 	/* Retry when we get spurious exceptions: */
 	if (!si_code)
-		return;
+		goto exit_trap;
 
 	force_sig_fault(SIGFPE, si_code,
 			(void __user *)uprobe_get_trap_addr(regs));
+exit_trap:
+	cond_local_irq_disable(regs);
 }
 
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code)
@@ -889,6 +896,8 @@ do_device_not_available(struct pt_regs *regs, long error_code)
 
 		info.regs = regs;
 		math_emulate(&info);
+
+		cond_local_irq_disable(regs);
 		return;
 	}
 #endif
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9ceacd1156db..501cc36a3d6a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1500,10 +1500,13 @@ __do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		return;
 
 	/* Was the fault on kernel-controlled part of the address space? */
-	if (unlikely(fault_in_kernel_space(address)))
+	if (unlikely(fault_in_kernel_space(address))) {
 		do_kern_addr_fault(regs, hw_error_code, address);
-	else
+	} else {
 		do_user_addr_fault(regs, hw_error_code, address);
+		if (regs->flags & X86_EFLAGS_IF)
+			local_irq_disable();
+	}
 }
 NOKPROBE_SYMBOL(__do_page_fault);
 
