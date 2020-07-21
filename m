Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2FE227E60
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgGULJj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:09:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37466 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgGULIu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:08:50 -0400
Message-Id: <20200721110809.432210708@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595329727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=knIjuzuXKMZdBuilWN5gor4+3netNh/RO6erbf3QO/s=;
        b=14ReWFfOcSAQGIC9yy2ZMws6P4qC52vyWZXDa19pqDiAb7m6+x9iRwCGCFCXbjeEhwJhTH
        YbGXYRrK78x2bbD5vwUPMuBcozqEM/+hXhEauV85g96jh7vY1I00ojLvCP+ITdtrJwq0Kn
        SqGVFtwugLlWyP4yzS0/bt1gvoNyjZYCe2CSKK72WWBicC2VJd7OX+yRia6T+BLXp3QQj3
        moDxzyr0mdAQvBVz8COc3OmSS1Ak2Yvbfo/RD4OhaU/jm3jNRdpQmHyxCrb435omVksWqe
        1PQhqxtbcCBR2yS4+jwggks/EgiFHj93I/Tv8wbdRv9yLqcvEhOgCHwbLRr7Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595329727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=knIjuzuXKMZdBuilWN5gor4+3netNh/RO6erbf3QO/s=;
        b=5ee8YY59x4fNk7jZVlfteaQwHQJqENtB1icJhRI+LerAxMjh67WL9LVIi2+o7A/9JZikRH
        hutA9yti4K0714Cw==
Date:   Tue, 21 Jul 2020 12:57:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [patch V4 11/15] x86/entry: Use generic syscall exit functionality
References: <20200721105706.030914876@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace the x86 variant with the generic version. Provide the relevant
architecture specific helper functions and defines.

Use a temporary define for idtentry_exit_user which will be cleaned up
seperately.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Drop a pointless define
    Adjust to moved TIF_USER_RETURN_NOTIFY handling
    Bring back I/O bitmap handling
---
 arch/x86/entry/common.c             |  221 ------------------------------------
 arch/x86/entry/entry_32.S           |    2 
 arch/x86/entry/entry_64.S           |    2 
 arch/x86/include/asm/entry-common.h |   44 +++++++
 arch/x86/include/asm/idtentry.h     |    3 
 arch/x86/include/asm/signal.h       |    1 
 arch/x86/kernel/signal.c            |    3 
 7 files changed, 54 insertions(+), 222 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -15,15 +15,8 @@
 #include <linux/smp.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
-#include <linux/audit.h>
-#include <linux/signal.h>
 #include <linux/export.h>
-#include <linux/context_tracking.h>
-#include <linux/user-return-notifier.h>
 #include <linux/nospec.h>
-#include <linux/uprobes.h>
-#include <linux/livepatch.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 
@@ -42,191 +35,6 @@
 #include <asm/syscall.h>
 #include <asm/irq_stack.h>
 
-#include <trace/events/syscalls.h>
-
-/**
- * exit_to_user_mode - Fixup state when exiting to user mode
- *
- * Syscall exit enables interrupts, but the kernel state is interrupts
- * disabled when this is invoked. Also tell RCU about it.
- *
- * 1) Trace interrupts on state
- * 2) Invoke context tracking if enabled to adjust RCU state
- * 3) Clear CPU buffers if CPU is affected by MDS and the migitation is on.
- * 4) Tell lockdep that interrupts are enabled
- */
-static __always_inline void exit_to_user_mode(void)
-{
-	instrumentation_begin();
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-	instrumentation_end();
-
-	user_enter_irqoff();
-	mds_user_clear_cpu_buffers();
-	lockdep_hardirqs_on(CALLER_ADDR0);
-}
-
-#define EXIT_TO_USERMODE_LOOP_FLAGS				\
-	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
-	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING)
-
-static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
-{
-	/*
-	 * In order to return to user mode, we need to have IRQs off with
-	 * none of EXIT_TO_USERMODE_LOOP_FLAGS set.  Several of these flags
-	 * can be set at any time on preemptible kernels if we have IRQs on,
-	 * so we need to loop.  Disabling preemption wouldn't help: doing the
-	 * work to clear some of the flags can sleep.
-	 */
-	while (true) {
-		/* We have work to do. */
-		local_irq_enable();
-
-		if (cached_flags & _TIF_NEED_RESCHED)
-			schedule();
-
-		if (cached_flags & _TIF_UPROBE)
-			uprobe_notify_resume(regs);
-
-		if (cached_flags & _TIF_PATCH_PENDING)
-			klp_update_patch_state(current);
-
-		/* deal with pending signal delivery */
-		if (cached_flags & _TIF_SIGPENDING)
-			do_signal(regs);
-
-		if (cached_flags & _TIF_NOTIFY_RESUME) {
-			clear_thread_flag(TIF_NOTIFY_RESUME);
-			tracehook_notify_resume(regs);
-			rseq_handle_notify_resume(NULL, regs);
-		}
-
-		/* Disable IRQs and retry */
-		local_irq_disable();
-
-		cached_flags = READ_ONCE(current_thread_info()->flags);
-
-		if (!(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
-			break;
-	}
-}
-
-static void __prepare_exit_to_usermode(struct pt_regs *regs)
-{
-	struct thread_info *ti = current_thread_info();
-	u32 cached_flags;
-
-	addr_limit_user_check();
-
-	lockdep_assert_irqs_disabled();
-	lockdep_sys_exit();
-
-	cached_flags = READ_ONCE(ti->flags);
-
-	if (unlikely(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
-		exit_to_usermode_loop(regs, cached_flags);
-
-	/* Reload ti->flags; we may have rescheduled above. */
-	cached_flags = READ_ONCE(ti->flags);
-
-	if (cached_flags & _TIF_USER_RETURN_NOTIFY)
-		fire_user_return_notifiers();
-
-	if (unlikely(cached_flags & _TIF_IO_BITMAP))
-		tss_update_io_bitmap();
-
-	fpregs_assert_state_consistent();
-	if (unlikely(cached_flags & _TIF_NEED_FPU_LOAD))
-		switch_fpu_return();
-
-#ifdef CONFIG_COMPAT
-	/*
-	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
-	 * returning to user mode.  We need to clear it *after* signal
-	 * handling, because syscall restart has a fixup for compat
-	 * syscalls.  The fixup is exercised by the ptrace_syscall_32
-	 * selftest.
-	 *
-	 * We also need to clear TS_REGS_POKED_I386: the 32-bit tracer
-	 * special case only applies after poking regs and before the
-	 * very next return to user mode.
-	 */
-	ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);
-#endif
-}
-
-static noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	__prepare_exit_to_usermode(regs);
-	instrumentation_end();
-	exit_to_user_mode();
-}
-
-#define SYSCALL_EXIT_WORK_FLAGS				\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |	\
-	 _TIF_SINGLESTEP | _TIF_SYSCALL_TRACEPOINT)
-
-static void syscall_slow_exit_work(struct pt_regs *regs, u32 cached_flags)
-{
-	bool step;
-
-	audit_syscall_exit(regs);
-
-	if (cached_flags & _TIF_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, regs->ax);
-
-	/*
-	 * If TIF_SYSCALL_EMU is set, we only get here because of
-	 * TIF_SINGLESTEP (i.e. this is PTRACE_SYSEMU_SINGLESTEP).
-	 * We already reported this syscall instruction in
-	 * syscall_trace_enter().
-	 */
-	step = unlikely(
-		(cached_flags & (_TIF_SINGLESTEP | _TIF_SYSCALL_EMU))
-		== _TIF_SINGLESTEP);
-	if (step || cached_flags & _TIF_SYSCALL_TRACE)
-		tracehook_report_syscall_exit(regs, step);
-}
-
-static void __syscall_return_slowpath(struct pt_regs *regs)
-{
-	struct thread_info *ti = current_thread_info();
-	u32 cached_flags = READ_ONCE(ti->flags);
-
-	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
-
-	if (IS_ENABLED(CONFIG_PROVE_LOCKING) &&
-	    WARN(irqs_disabled(), "syscall %ld left IRQs disabled", regs->orig_ax))
-		local_irq_enable();
-
-	rseq_syscall(regs);
-
-	/*
-	 * First do one-time work.  If these work items are enabled, we
-	 * want to run them exactly once per syscall exit with IRQs on.
-	 */
-	if (unlikely(cached_flags & SYSCALL_EXIT_WORK_FLAGS))
-		syscall_slow_exit_work(regs, cached_flags);
-
-	local_irq_disable();
-	__prepare_exit_to_usermode(regs);
-}
-
-/*
- * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
- * state such that we can immediately switch to user mode.
- */
-__visible noinstr void syscall_return_slowpath(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	__syscall_return_slowpath(regs);
-	instrumentation_end();
-	exit_to_user_mode();
-}
-
 #ifdef CONFIG_X86_64
 __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
@@ -245,7 +53,7 @@ static void __syscall_return_slowpath(st
 #endif
 	}
 	instrumentation_end();
-	syscall_return_slowpath(regs);
+	syscall_exit_to_user_mode(regs);
 }
 #endif
 
@@ -284,7 +92,7 @@ static __always_inline void do_syscall_3
 	unsigned int nr = syscall_32_enter(regs);
 
 	do_syscall_32_irqs_on(regs, nr);
-	syscall_return_slowpath(regs);
+	syscall_exit_to_user_mode(regs);
 }
 
 static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
@@ -310,13 +118,13 @@ static noinstr bool __do_fast_syscall_32
 	if (res) {
 		/* User code screwed up. */
 		regs->ax = -EFAULT;
-		syscall_return_slowpath(regs);
+		syscall_exit_to_user_mode(regs);
 		return false;
 	}
 
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
-	syscall_return_slowpath(regs);
+	syscall_exit_to_user_mode(regs);
 	return true;
 }
 
@@ -524,7 +332,7 @@ void noinstr idtentry_exit(struct pt_reg
 
 	/* Check whether this returns to user mode */
 	if (user_mode(regs)) {
-		prepare_exit_to_usermode(regs);
+		irqentry_exit_to_user_mode(regs);
 	} else if (regs->flags & X86_EFLAGS_IF) {
 		/*
 		 * If RCU was not watching on entry this needs to be done
@@ -555,25 +363,6 @@ void noinstr idtentry_exit(struct pt_reg
 	}
 }
 
-/**
- * idtentry_exit_user - Handle return from exception to user mode
- * @regs:	Pointer to pt_regs (exception entry regs)
- *
- * Runs the necessary preemption and work checks and returns to the caller
- * with interrupts disabled and no further work pending.
- *
- * This is the last action before returning to the low level ASM code which
- * just needs to return to the appropriate context.
- *
- * Counterpart to idtentry_enter_user().
- */
-void noinstr idtentry_exit_user(struct pt_regs *regs)
-{
-	lockdep_assert_irqs_disabled();
-
-	prepare_exit_to_usermode(regs);
-}
-
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -846,7 +846,7 @@ SYM_CODE_START(ret_from_fork)
 2:
 	/* When we fork, we trace the syscall return in the child, too. */
 	movl    %esp, %eax
-	call    syscall_return_slowpath
+	call    syscall_exit_to_user_mode
 	jmp     .Lsyscall_32_done
 
 	/* kernel thread */
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -283,7 +283,7 @@ SYM_CODE_START(ret_from_fork)
 2:
 	UNWIND_HINT_REGS
 	movq	%rsp, %rdi
-	call	syscall_return_slowpath	/* returns with IRQs disabled */
+	call	syscall_exit_to_user_mode	/* returns with IRQs disabled */
 	jmp	swapgs_restore_regs_and_return_to_usermode
 
 1:
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -2,6 +2,12 @@
 #ifndef _ASM_X86_ENTRY_COMMON_H
 #define _ASM_X86_ENTRY_COMMON_H
 
+#include <linux/user-return-notifier.h>
+
+#include <asm/nospec-branch.h>
+#include <asm/io_bitmap.h>
+#include <asm/fpu/api.h>
+
 /* Check that the stack and regs on entry from user mode are sane. */
 static __always_inline void arch_check_user_regs(struct pt_regs *regs)
 {
@@ -29,4 +35,42 @@ static __always_inline void arch_check_u
 }
 #define arch_check_user_regs arch_check_user_regs
 
+#define ARCH_SYSCALL_EXIT_WORK		(_TIF_SINGLESTEP)
+
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+	if (ti_work & _TIF_USER_RETURN_NOTIFY)
+		fire_user_return_notifiers();
+
+	if (unlikely(ti_work & _TIF_IO_BITMAP))
+		tss_update_io_bitmap();
+
+	fpregs_assert_state_consistent();
+	if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
+		switch_fpu_return();
+
+#ifdef CONFIG_COMPAT
+	/*
+	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
+	 * returning to user mode.  We need to clear it *after* signal
+	 * handling, because syscall restart has a fixup for compat
+	 * syscalls.  The fixup is exercised by the ptrace_syscall_32
+	 * selftest.
+	 *
+	 * We also need to clear TS_REGS_POKED_I386: the 32-bit tracer
+	 * special case only applies after poking regs and before the
+	 * very next return to user mode.
+	 */
+	current_thread_info()->status &= ~(TS_COMPAT | TS_I386_REGS_POKED);
+#endif
+}
+#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
+
+static __always_inline void arch_exit_to_user_mode(void)
+{
+	mds_user_clear_cpu_buffers();
+}
+#define arch_exit_to_user_mode arch_exit_to_user_mode
+
 #endif
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -13,8 +13,7 @@
 
 /* Temporary define */
 #define idtentry_enter_user	irqentry_enter_from_user_mode
-
-void idtentry_exit_user(struct pt_regs *regs);
+#define idtentry_exit_user	irqentry_exit_to_user_mode
 
 typedef struct idtentry_state {
 	bool exit_rcu;
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -35,7 +35,6 @@ typedef sigset_t compat_sigset_t;
 #endif /* __ASSEMBLY__ */
 #include <uapi/asm/signal.h>
 #ifndef __ASSEMBLY__
-extern void do_signal(struct pt_regs *regs);
 
 #define __ARCH_HAS_SA_RESTORER
 
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/user-return-notifier.h>
 #include <linux/uprobes.h>
 #include <linux/context_tracking.h>
+#include <linux/entry-common.h>
 #include <linux/syscalls.h>
 
 #include <asm/processor.h>
@@ -803,7 +804,7 @@ static inline unsigned long get_nr_resta
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-void do_signal(struct pt_regs *regs)
+void arch_do_signal(struct pt_regs *regs)
 {
 	struct ksignal ksig;
 

