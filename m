Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86916482F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBSPPH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:15:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52018 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgBSPOh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VXuCT2dBZGniVtapCiemYO17xuPhyGiOgDlXBctdf04=; b=aM+wSG6CzT0jQaGPoatHPc1X9/
        FrQMZGBE8QlD/HQ8D8xuYKbFpeO17LyUASznpcTPYXca/OAMmWrKfQAf/3+30w2QRVBq6NwYRE0B2
        jZjZfOCcglSPuVLFTZ4zQwGLwzo3z84Z1wBDCbdQCj1mDX9Sz7hS4qByR/nOL1HZuYXwU750v0Gqn
        CSbLelCQT+IxafAqMzdkWOcbPBpjQX+Hk65zz+DlY2xspPonExgwjcqsE/u54naIyZnL8cVy1m//4
        AumcA/q/+m2EHI0mgAkPaeNv6tzc02XEIxdTlQzElf2h9Gx45x/AYZoyDPBQRPTyeV3NPFHeSUrJP
        SFRLT2Qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R38-0007fK-R0; Wed, 19 Feb 2020 15:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27EA0304D2C;
        Wed, 19 Feb 2020 16:12:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6F0002997CED4; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150744.547288232@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v3 03/22] x86: Replace ist_enter() with nmi_enter()
References: <20200219144724.800607165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A few exceptions (like #DB and #BP) can happen at any location in the
code, this then means that tracers should treat events from these
exceptions as NMI-like. We could be holding locks with interrupts
disabled for instance.

Similarly, #MC is an actual NMI-like exception.

All of them use ist_enter() which only concerns itself with RCU, but
does not do any of the other setup that NMI's need. This means things
like:

	printk()
	  raw_spin_lock(&logbuf_lock);
	  <#DB/#BP/#MC>
	     printk()
	       raw_spin_lock(&logbuf_lock);

are entirely possible.

So replace ist_enter() with nmi_enter(). Also observe that any
nmi_enter() caller must be both notrace and NOKPROBE.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/traps.h      |    3 --
 arch/x86/kernel/cpu/mce/core.c    |   15 +++++-----
 arch/x86/kernel/cpu/mce/p5.c      |    7 ++--
 arch/x86/kernel/cpu/mce/winchip.c |    7 ++--
 arch/x86/kernel/traps.c           |   57 +++++---------------------------------
 5 files changed, 24 insertions(+), 65 deletions(-)

--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -121,9 +121,6 @@ void smp_spurious_interrupt(struct pt_re
 void smp_error_interrupt(struct pt_regs *regs);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
-extern void ist_enter(struct pt_regs *regs);
-extern void ist_exit(struct pt_regs *regs);
-
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
 				      struct pt_regs *regs,
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1220,7 +1220,7 @@ static void mce_kill_me_maybe(struct cal
  * MCE broadcast. However some CPUs might be broken beyond repair,
  * so be always careful when synchronizing with others.
  */
-void do_machine_check(struct pt_regs *regs, long error_code)
+notrace void do_machine_check(struct pt_regs *regs, long error_code)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
@@ -1254,10 +1254,10 @@ void do_machine_check(struct pt_regs *re
 	 */
 	int lmce = 1;
 
-	if (__mc_check_crashing_cpu(cpu))
-		return;
+	nmi_enter();
 
-	ist_enter(regs);
+	if (__mc_check_crashing_cpu(cpu))
+		goto out;
 
 	this_cpu_inc(mce_exception_count);
 
@@ -1346,7 +1346,7 @@ void do_machine_check(struct pt_regs *re
 	sync_core();
 
 	if (worst != MCE_AR_SEVERITY && !kill_it)
-		goto out_ist;
+		goto out;
 
 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
@@ -1362,10 +1362,11 @@ void do_machine_check(struct pt_regs *re
 			mce_panic("Failed kernel mode recovery", &m, msg);
 	}
 
-out_ist:
-	ist_exit(regs);
+out:
+	nmi_exit();
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
+NOKPROBE_SYMBOL(do_machine_check);
 
 #ifndef CONFIG_MEMORY_FAILURE
 int memory_failure(unsigned long pfn, int flags)
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -20,11 +20,11 @@
 int mce_p5_enabled __read_mostly;
 
 /* Machine check handler for Pentium class Intel CPUs: */
-static void pentium_machine_check(struct pt_regs *regs, long error_code)
+static notrace void pentium_machine_check(struct pt_regs *regs, long error_code)
 {
 	u32 loaddr, hi, lotype;
 
-	ist_enter(regs);
+	nmi_enter();
 
 	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
 	rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);
@@ -39,8 +39,9 @@ static void pentium_machine_check(struct
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
-	ist_exit(regs);
+	nmi_exit();
 }
+NOKPROBE_SYMBOL(pentium_machine_check);
 
 /* Set up machine check reporting for processors with Intel style MCE: */
 void intel_p5_mcheck_init(struct cpuinfo_x86 *c)
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -16,15 +16,16 @@
 #include "internal.h"
 
 /* Machine check handler for WinChip C6: */
-static void winchip_machine_check(struct pt_regs *regs, long error_code)
+static notrace void winchip_machine_check(struct pt_regs *regs, long error_code)
 {
-	ist_enter(regs);
+	nmi_enter();
 
 	pr_emerg("CPU0: Machine Check Exception.\n");
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
-	ist_exit(regs);
+	nmi_exit();
 }
+NOKPROBE_SYMBOL(winchip_machine_check);
 
 /* Set up machine check reporting on the Winchip C6 series */
 void winchip_mcheck_init(struct cpuinfo_x86 *c)
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -81,41 +81,6 @@ static inline void cond_local_irq_disabl
 		local_irq_disable();
 }
 
-/*
- * In IST context, we explicitly disable preemption.  This serves two
- * purposes: it makes it much less likely that we would accidentally
- * schedule in IST context and it will force a warning if we somehow
- * manage to schedule by accident.
- */
-void ist_enter(struct pt_regs *regs)
-{
-	if (user_mode(regs)) {
-		RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
-	} else {
-		/*
-		 * We might have interrupted pretty much anything.  In
-		 * fact, if we're a machine check, we can even interrupt
-		 * NMI processing.  We don't want in_nmi() to return true,
-		 * but we need to notify RCU.
-		 */
-		rcu_nmi_enter();
-	}
-
-	preempt_disable();
-
-	/* This code is a bit fragile.  Test it. */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "ist_enter didn't work");
-}
-NOKPROBE_SYMBOL(ist_enter);
-
-void ist_exit(struct pt_regs *regs)
-{
-	preempt_enable_no_resched();
-
-	if (!user_mode(regs))
-		rcu_nmi_exit();
-}
-
 int is_valid_bugaddr(unsigned long addr)
 {
 	unsigned short ud;
@@ -306,7 +271,7 @@ dotraplinkage void do_double_fault(struc
 	 * The net result is that our #GP handler will think that we
 	 * entered from usermode with the bad user context.
 	 *
-	 * No need for ist_enter here because we don't use RCU.
+	 * No need for nmi_enter() here because we don't use RCU.
 	 */
 	if (((long)regs->sp >> P4D_SHIFT) == ESPFIX_PGD_ENTRY &&
 		regs->cs == __KERNEL_CS &&
@@ -341,7 +306,7 @@ dotraplinkage void do_double_fault(struc
 	}
 #endif
 
-	ist_enter(regs);
+	nmi_enter();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
 	tsk->thread.error_code = error_code;
@@ -393,6 +358,7 @@ dotraplinkage void do_double_fault(struc
 	die("double fault", regs, error_code);
 	panic("Machine halted.");
 }
+NOKPROBE_SYMBOL(do_double_fault)
 #endif
 
 dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
@@ -534,14 +500,7 @@ dotraplinkage void notrace do_int3(struc
 	if (poke_int3_handler(regs))
 		return;
 
-	/*
-	 * Use ist_enter despite the fact that we don't use an IST stack.
-	 * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
-	 * mode or even during context tracking state changes.
-	 *
-	 * This means that we can't schedule.  That's okay.
-	 */
-	ist_enter(regs);
+	nmi_enter();
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
@@ -563,7 +522,7 @@ dotraplinkage void notrace do_int3(struc
 	cond_local_irq_disable(regs);
 
 exit:
-	ist_exit(regs);
+	nmi_exit();
 }
 NOKPROBE_SYMBOL(do_int3);
 
@@ -660,14 +619,14 @@ static bool is_sysenter_singlestep(struc
  *
  * May run on IST stack.
  */
-dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
+dotraplinkage notrace void do_debug(struct pt_regs *regs, long error_code)
 {
 	struct task_struct *tsk = current;
 	int user_icebp = 0;
 	unsigned long dr6;
 	int si_code;
 
-	ist_enter(regs);
+	nmi_enter();
 
 	get_debugreg(dr6, 6);
 	/*
@@ -760,7 +719,7 @@ dotraplinkage void do_debug(struct pt_re
 	debug_stack_usage_dec();
 
 exit:
-	ist_exit(regs);
+	nmi_exit();
 }
 NOKPROBE_SYMBOL(do_debug);
 


