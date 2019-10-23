Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FD2E1A7C
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389999AbfJWMdG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 08:33:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49096 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389772AbfJWMbl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 08:31:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNFnc-00017I-Ug; Wed, 23 Oct 2019 14:31:37 +0200
Message-Id: <20191023123118.084086112@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 23 Oct 2019 14:27:10 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [patch V2 05/17] x86/traps: Make interrupt enable/disable symmetric
 in C code
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Traps enable interrupts conditionally but rely on the ASM return code to
disable them again. That results in redundant interrupt disable and trace
calls.

Make the trap handlers disable interrupts before returning to avoid that,
which allows simplification of the ASM entry code.

Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/traps.c |   32 +++++++++++++++++++++-----------
 arch/x86/mm/fault.c     |    7 +++++--
 2 files changed, 26 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -276,6 +276,7 @@ static void do_error_trap(struct pt_regs
 			NOTIFY_STOP) {
 		cond_local_irq_enable(regs);
 		do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
+		cond_local_irq_disable(regs);
 	}
 }
 
@@ -501,6 +502,7 @@ dotraplinkage void do_bounds(struct pt_r
 		die("bounds", regs, error_code);
 	}
 
+	cond_local_irq_disable(regs);
 	return;
 
 exit_trap:
@@ -512,6 +514,7 @@ dotraplinkage void do_bounds(struct pt_r
 	 * time..
 	 */
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
+	cond_local_irq_disable(regs);
 }
 
 dotraplinkage void
@@ -525,19 +528,19 @@ do_general_protection(struct pt_regs *re
 
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
@@ -549,12 +552,12 @@ do_general_protection(struct pt_regs *re
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
@@ -563,6 +566,8 @@ do_general_protection(struct pt_regs *re
 	show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 
 	force_sig(SIGSEGV);
+exit_trap:
+	cond_local_irq_disable(regs);
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
@@ -783,9 +788,7 @@ dotraplinkage void do_debug(struct pt_re
 	if (v8086_mode(regs)) {
 		handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code,
 					X86_TRAP_DB);
-		cond_local_irq_disable(regs);
-		debug_stack_usage_dec();
-		goto exit;
+		goto exit_irq;
 	}
 
 	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
@@ -802,6 +805,8 @@ dotraplinkage void do_debug(struct pt_re
 	si_code = get_si_code(tsk->thread.debugreg6);
 	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
 		send_sigtrap(regs, error_code, si_code);
+
+exit_irq:
 	cond_local_irq_disable(regs);
 	debug_stack_usage_dec();
 
@@ -827,7 +832,7 @@ static void math_error(struct pt_regs *r
 
 	if (!user_mode(regs)) {
 		if (fixup_exception(regs, trapnr, error_code, 0))
-			return;
+			goto exit_trap;
 
 		task->thread.error_code = error_code;
 		task->thread.trap_nr = trapnr;
@@ -835,7 +840,7 @@ static void math_error(struct pt_regs *r
 		if (notify_die(DIE_TRAP, str, regs, error_code,
 					trapnr, SIGFPE) != NOTIFY_STOP)
 			die(str, regs, error_code);
-		return;
+		goto exit_trap;
 	}
 
 	/*
@@ -849,10 +854,12 @@ static void math_error(struct pt_regs *r
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
@@ -888,6 +895,8 @@ do_device_not_available(struct pt_regs *
 
 		info.regs = regs;
 		math_emulate(&info);
+
+		cond_local_irq_disable(regs);
 		return;
 	}
 #endif
@@ -918,6 +927,7 @@ dotraplinkage void do_iret_error(struct
 		do_trap(X86_TRAP_IRET, SIGILL, "iret exception", regs, error_code,
 			ILL_BADSTK, (void __user *)NULL);
 	}
+	local_irq_disable();
 }
 #endif
 
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1500,10 +1500,13 @@ static noinline void
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
 


