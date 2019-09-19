Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD84B7DAD
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390966AbfISPJ7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:09:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50100 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403946AbfISPJ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:09:58 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy46-0006p7-3c; Thu, 19 Sep 2019 17:09:50 +0200
Message-Id: <20190919150809.553546825@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:25 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC patch 11/15] x86/entry: Use generic exit to usermode
References: <20190919150314.054351477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace the x86 specific exit to usermode code with the generic
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c             |  111 ------------------------------------
 arch/x86/entry/entry_32.S           |    2 
 arch/x86/entry/entry_64.S           |    2 
 arch/x86/include/asm/entry-common.h |   47 ++++++++++++++-
 arch/x86/include/asm/signal.h       |    1 
 arch/x86/kernel/signal.c            |    2 
 6 files changed, 51 insertions(+), 114 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -15,15 +15,9 @@
 #include <linux/smp.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
-#include <linux/audit.h>
 #include <linux/signal.h>
 #include <linux/export.h>
-#include <linux/context_tracking.h>
-#include <linux/user-return-notifier.h>
 #include <linux/nospec.h>
-#include <linux/uprobes.h>
-#include <linux/livepatch.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 
@@ -47,102 +41,6 @@
 static inline void enter_from_user_mode(void) {}
 #endif
 
-#define EXIT_TO_USERMODE_LOOP_FLAGS				\
-	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
-	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY | _TIF_PATCH_PENDING)
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
-		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
-			fire_user_return_notifiers();
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
-/* Called with IRQs disabled. */
-__visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
-{
-	struct thread_info *ti = current_thread_info();
-	u32 cached_flags;
-
-	trace_hardirqs_off();
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
-
-	user_enter_irqoff();
-
-	mds_user_clear_cpu_buffers();
-
-	trace_hardirqs_on();
-}
-
 /*
  * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
  * state such that we can immediately switch to user mode.
@@ -150,9 +48,6 @@ static void exit_to_usermode_loop(struct
 __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 {
 	syscall_exit_to_usermode(regs, regs->orig_ax, regs->ax);
-
-	local_irq_disable();
-	prepare_exit_to_usermode(regs);
 }
 
 #ifdef CONFIG_X86_64
@@ -177,7 +72,7 @@ static void exit_to_usermode_loop(struct
 #endif
 	}
 
-	syscall_return_slowpath(regs);
+	syscall_exit_to_usermode(regs, regs->orig_ax, regs->ax);
 }
 #endif
 
@@ -221,7 +116,7 @@ static __always_inline void do_syscall_3
 #endif /* CONFIG_IA32_EMULATION */
 	}
 
-	syscall_return_slowpath(regs);
+	syscall_exit_to_usermode(regs, regs->orig_ax, regs->ax);
 }
 
 /* Handles int $0x80 */
@@ -276,7 +171,7 @@ static __always_inline void do_syscall_3
 		/* User code screwed up. */
 		local_irq_disable();
 		regs->ax = -EFAULT;
-		prepare_exit_to_usermode(regs);
+		exit_to_usermode(regs);
 		return 0;	/* Keep it simple: use IRET. */
 	}
 
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -828,7 +828,7 @@ END(ret_from_fork)
 ENTRY(resume_userspace)
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	movl	%esp, %eax
-	call	prepare_exit_to_usermode
+	call	exit_to_usermode
 	jmp	restore_all
 END(ret_from_exception)
 
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -612,7 +612,7 @@ END(common_spurious)
 	/* Interrupt came from user space */
 GLOBAL(retint_user)
 	mov	%rsp,%rdi
-	call	prepare_exit_to_usermode
+	call	exit_to_usermode
 
 GLOBAL(swapgs_restore_regs_and_return_to_usermode)
 #ifdef CONFIG_DEBUG_ENTRY
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -2,11 +2,54 @@
 #ifndef _ASM_X86_ENTRY_COMMON_H
 #define _ASM_X86_ENTRY_COMMON_H
 
-#include <linux/seccomp.h>
-#include <linux/audit.h>
+#include <linux/user-return-notifier.h>
+#include <linux/context_tracking.h>
+
+#include <asm/nospec-branch.h>
+#include <asm/fpu/api.h>
 
 #define ARCH_SYSCALL_EXIT_WORK		(_TIF_SINGLESTEP)
 
+#define ARCH_EXIT_TO_USERMODE_WORK	(_TIF_USER_RETURN_NOTIFY)
+
+#define ARCH_EXIT_TO_USER_FROM_SYSCALL_EXIT
+
+static inline void arch_exit_to_usermode_work(struct pt_regs *regs,
+					      unsigned long ti_work)
+{
+	if (ti_work & _TIF_USER_RETURN_NOTIFY)
+		fire_user_return_notifiers();
+}
+#define arch_exit_to_usermode_work arch_exit_to_usermode_work
+
+static inline void arch_exit_to_usermode(struct pt_regs *regs,
+					 unsigned long ti_work)
+{
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
+
+	user_enter_irqoff();
+
+	mds_user_clear_cpu_buffers();
+}
+#define arch_exit_to_usermode arch_exit_to_usermode
+
 static inline long arch_syscall_enter_seccomp(struct pt_regs *regs)
 {
 #ifdef CONFIG_SECCOMP
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
@@ -808,7 +808,7 @@ static inline unsigned long get_nr_resta
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-void do_signal(struct pt_regs *regs)
+void arch_do_signal(struct pt_regs *regs)
 {
 	struct ksignal ksig;
 


