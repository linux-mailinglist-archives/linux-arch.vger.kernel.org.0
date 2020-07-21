Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAB227E65
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgGULJs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:09:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37356 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbgGULIt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:08:49 -0400
Message-Id: <20200721110809.325060396@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595329726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mV493mA5Qd7BEsNAO30VUQSrl/64fcbS/4yERsPV3+Q=;
        b=ClRXE7R56vTLHLxBSWjQFHH6zMhES9EzbThKj1SWikD2betU6S1H440WTcsb/aPCq/4T+P
        nHHKRWBRtHVe8If9Hibr87RS8nvJ/YjSHj4ks0LO6miGLbcZG9CzHCo8wwW4kuH9jvrV8O
        jSvr//qkvMdhpaReab5C5roOqhwg+bG7WkBM8Sp6e4hXabr68+iIWgo5tFQgLIBC9IzPTe
        Wm2hCpM+XMYTDUERposODxeTy1Mf/mhVQRrWmjIEsFBymu5GRRbFGwQy6CVxmxuxu3mU/p
        Pq+DZl/taz2V8GLXqCF6Y/tYUD+IGYJqgmuQGAQs2LqlNSVWY6zep5Kn6Rp95g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595329726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=mV493mA5Qd7BEsNAO30VUQSrl/64fcbS/4yERsPV3+Q=;
        b=y/vqopiHpTWymLFkAgSX1EFw7Ft2duXXC0kJN52q3pSrKkQGQ27V65WhtOf/sTZ73KbWjA
        7pfHb3lQZVh9r7Cg==
Date:   Tue, 21 Jul 2020 12:57:16 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [patch V4 10/15] x86/entry: Use generic syscall entry function
References: <20200721105706.030914876@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace the syscall entry work handling with the generic version. Provide
the necessary helper inlines to handle the real architecture specific
parts, e.g. ptrace.

Use a temporary define for idtentry_enter_user which will be cleaned up
seperately.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Drop the seccomp/audit wrappers as they are not longer required (Kees)

V3: Adapt to the noinstr changes
---
 arch/x86/Kconfig                    |    1 
 arch/x86/entry/common.c             |  181 +-----------------------------------
 arch/x86/include/asm/entry-common.h |   32 ++++++
 arch/x86/include/asm/idtentry.h     |    5 
 arch/x86/include/asm/thread_info.h  |    5 
 5 files changed, 45 insertions(+), 179 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -115,6 +115,7 @@ config X86
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_ENTRY
 	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK	if SMP
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -10,13 +10,13 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <linux/entry-common.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/tracehook.h>
 #include <linux/audit.h>
-#include <linux/seccomp.h>
 #include <linux/signal.h>
 #include <linux/export.h>
 #include <linux/context_tracking.h>
@@ -42,70 +42,8 @@
 #include <asm/syscall.h>
 #include <asm/irq_stack.h>
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-/* Check that the stack and regs on entry from user mode are sane. */
-static noinstr void check_user_regs(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
-		/*
-		 * Make sure that the entry code gave us a sensible EFLAGS
-		 * register.  Native because we want to check the actual CPU
-		 * state, not the interrupt state as imagined by Xen.
-		 */
-		unsigned long flags = native_save_fl();
-		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
-				      X86_EFLAGS_NT));
-
-		/* We think we came from user mode. Make sure pt_regs agrees. */
-		WARN_ON_ONCE(!user_mode(regs));
-
-		/*
-		 * All entries from user mode (except #DF) should be on the
-		 * normal thread stack and should have user pt_regs in the
-		 * correct location.
-		 */
-		WARN_ON_ONCE(!on_thread_stack());
-		WARN_ON_ONCE(regs != task_pt_regs(current));
-	}
-}
-
-#ifdef CONFIG_CONTEXT_TRACKING
-/**
- * enter_from_user_mode - Establish state when coming from user mode
- *
- * Syscall entry disables interrupts, but user mode is traced as interrupts
- * enabled. Also with NO_HZ_FULL RCU might be idle.
- *
- * 1) Tell lockdep that interrupts are disabled
- * 2) Invoke context tracking if enabled to reactivate RCU
- * 3) Trace interrupts off state
- */
-static noinstr void enter_from_user_mode(struct pt_regs *regs)
-{
-	enum ctx_state state = ct_state();
-
-	check_user_regs(regs);
-	lockdep_hardirqs_off(CALLER_ADDR0);
-	user_exit_irqoff();
-
-	instrumentation_begin();
-	CT_WARN_ON(state != CONTEXT_USER);
-	trace_hardirqs_off_finish();
-	instrumentation_end();
-}
-#else
-static __always_inline void enter_from_user_mode(struct pt_regs *regs)
-{
-	check_user_regs(regs);
-	lockdep_hardirqs_off(CALLER_ADDR0);
-	instrumentation_begin();
-	trace_hardirqs_off_finish();
-	instrumentation_end();
-}
-#endif
-
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
@@ -129,83 +67,6 @@ static __always_inline void exit_to_user
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
-{
-#ifdef CONFIG_X86_64
-	if (arch == AUDIT_ARCH_X86_64) {
-		audit_syscall_entry(regs->orig_ax, regs->di,
-				    regs->si, regs->dx, regs->r10);
-	} else
-#endif
-	{
-		audit_syscall_entry(regs->orig_ax, regs->bx,
-				    regs->cx, regs->dx, regs->si);
-	}
-}
-
-/*
- * Returns the syscall nr to run (which should match regs->orig_ax) or -1
- * to skip the syscall.
- */
-static long syscall_trace_enter(struct pt_regs *regs)
-{
-	u32 arch = in_ia32_syscall() ? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
-
-	struct thread_info *ti = current_thread_info();
-	unsigned long ret = 0;
-	u32 work;
-
-	work = READ_ONCE(ti->flags);
-
-	if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
-		ret = tracehook_report_syscall_entry(regs);
-		if (ret || (work & _TIF_SYSCALL_EMU))
-			return -1L;
-	}
-
-#ifdef CONFIG_SECCOMP
-	/*
-	 * Do seccomp after ptrace, to catch any tracer changes.
-	 */
-	if (work & _TIF_SECCOMP) {
-		struct seccomp_data sd;
-
-		sd.arch = arch;
-		sd.nr = regs->orig_ax;
-		sd.instruction_pointer = regs->ip;
-#ifdef CONFIG_X86_64
-		if (arch == AUDIT_ARCH_X86_64) {
-			sd.args[0] = regs->di;
-			sd.args[1] = regs->si;
-			sd.args[2] = regs->dx;
-			sd.args[3] = regs->r10;
-			sd.args[4] = regs->r8;
-			sd.args[5] = regs->r9;
-		} else
-#endif
-		{
-			sd.args[0] = regs->bx;
-			sd.args[1] = regs->cx;
-			sd.args[2] = regs->dx;
-			sd.args[3] = regs->si;
-			sd.args[4] = regs->di;
-			sd.args[5] = regs->bp;
-		}
-
-		ret = __secure_computing(&sd);
-		if (ret == -1)
-			return ret;
-	}
-#endif
-
-	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
-		trace_sys_enter(regs, regs->orig_ax);
-
-	do_audit_syscall_entry(regs, arch);
-
-	return ret ?: regs->orig_ax;
-}
-
 #define EXIT_TO_USERMODE_LOOP_FLAGS				\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
 	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING)
@@ -366,26 +227,10 @@ static void __syscall_return_slowpath(st
 	exit_to_user_mode();
 }
 
-static noinstr long syscall_enter(struct pt_regs *regs, unsigned long nr)
-{
-	struct thread_info *ti;
-
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-
-	local_irq_enable();
-	ti = current_thread_info();
-	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
-		nr = syscall_trace_enter(regs);
-
-	instrumentation_end();
-	return nr;
-}
-
 #ifdef CONFIG_X86_64
 __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
-	nr = syscall_enter(regs, nr);
+	nr = syscall_enter_from_user_mode(regs, nr);
 
 	instrumentation_begin();
 	if (likely(nr < NR_syscalls)) {
@@ -407,6 +252,8 @@ static noinstr long syscall_enter(struct
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
 {
+	unsigned int nr = (unsigned int)regs->orig_ax;
+
 	if (IS_ENABLED(CONFIG_IA32_EMULATION))
 		current_thread_info()->status |= TS_COMPAT;
 	/*
@@ -414,7 +261,7 @@ static __always_inline unsigned int sysc
 	 * orig_ax, the unsigned int return value truncates it.  This may
 	 * or may not be necessary, but it matches the old asm behavior.
 	 */
-	return syscall_enter(regs, (unsigned int)regs->orig_ax);
+	return (unsigned int)syscall_enter_from_user_mode(regs, nr);
 }
 
 /*
@@ -568,7 +415,7 @@ SYSCALL_DEFINE0(ni_syscall)
  * solves the problem of kernel mode pagefaults which can schedule, which
  * is not possible after invoking rcu_irq_enter() without undoing it.
  *
- * For user mode entries enter_from_user_mode() must be invoked to
+ * For user mode entries irqentry_enter_from_user_mode() must be invoked to
  * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
  * would not be possible.
  *
@@ -584,7 +431,7 @@ idtentry_state_t noinstr idtentry_enter(
 	};
 
 	if (user_mode(regs)) {
-		enter_from_user_mode(regs);
+		irqentry_enter_from_user_mode(regs);
 		return ret;
 	}
 
@@ -615,7 +462,7 @@ idtentry_state_t noinstr idtentry_enter(
 		/*
 		 * If RCU is not watching then the same careful
 		 * sequence vs. lockdep and tracing is required
-		 * as in enter_from_user_mode().
+		 * as in irqentry_enter_from_user_mode().
 		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
@@ -709,18 +556,6 @@ void noinstr idtentry_exit(struct pt_reg
 }
 
 /**
- * idtentry_enter_user - Handle state tracking on idtentry from user mode
- * @regs:	Pointer to pt_regs of interrupted context
- *
- * Invokes enter_from_user_mode() to establish the proper context for
- * NOHZ_FULL. Otherwise scheduling on exit would not be possible.
- */
-void noinstr idtentry_enter_user(struct pt_regs *regs)
-{
-	enter_from_user_mode(regs);
-}
-
-/**
  * idtentry_exit_user - Handle return from exception to user mode
  * @regs:	Pointer to pt_regs (exception entry regs)
  *
--- /dev/null
+++ b/arch/x86/include/asm/entry-common.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_X86_ENTRY_COMMON_H
+#define _ASM_X86_ENTRY_COMMON_H
+
+/* Check that the stack and regs on entry from user mode are sane. */
+static __always_inline void arch_check_user_regs(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
+		/*
+		 * Make sure that the entry code gave us a sensible EFLAGS
+		 * register.  Native because we want to check the actual CPU
+		 * state, not the interrupt state as imagined by Xen.
+		 */
+		unsigned long flags = native_save_fl();
+		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
+				      X86_EFLAGS_NT));
+
+		/* We think we came from user mode. Make sure pt_regs agrees. */
+		WARN_ON_ONCE(!user_mode(regs));
+
+		/*
+		 * All entries from user mode (except #DF) should be on the
+		 * normal thread stack and should have user pt_regs in the
+		 * correct location.
+		 */
+		WARN_ON_ONCE(!on_thread_stack());
+		WARN_ON_ONCE(regs != task_pt_regs(current));
+	}
+}
+#define arch_check_user_regs arch_check_user_regs
+
+#endif
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -6,11 +6,14 @@
 #include <asm/trapnr.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/entry-common.h>
 #include <linux/hardirq.h>
 
 #include <asm/irq_stack.h>
 
-void idtentry_enter_user(struct pt_regs *regs);
+/* Temporary define */
+#define idtentry_enter_user	irqentry_enter_from_user_mode
+
 void idtentry_exit_user(struct pt_regs *regs);
 
 typedef struct idtentry_state {
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -133,11 +133,6 @@ struct thread_info {
 #define _TIF_X32		(1 << TIF_X32)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 
-/* Work to do before invoking the actual syscall. */
-#define _TIF_WORK_SYSCALL_ENTRY	\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU | _TIF_SYSCALL_AUDIT |	\
-	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT)
-
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
 	(_TIF_NOCPUID | _TIF_NOTSC | _TIF_BLOCKSTEP |		\

