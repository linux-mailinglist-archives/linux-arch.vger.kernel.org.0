Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA441B7D97
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390952AbfISPJw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:09:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50057 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732323AbfISPJw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:09:52 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy3y-0006nZ-HC; Thu, 19 Sep 2019 17:09:42 +0200
Message-Id: <20190919150808.724554170@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:17 +0200
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
Subject: [RFC patch 03/15] x86/entry: Use generic syscall entry function
References: <20190919150314.054351477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace the syscall entry work handling with the generic version, Provide
the necessary helper inlines to handle the real architecture specific
parts, e.g. audit and seccomp invocations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig                    |    1 
 arch/x86/entry/common.c             |  108 +++---------------------------------
 arch/x86/include/asm/entry-common.h |   59 +++++++++++++++++++
 arch/x86/include/asm/thread_info.h  |    5 -
 4 files changed, 70 insertions(+), 103 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -110,6 +110,7 @@ config X86
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
@@ -34,7 +34,6 @@
 #include <asm/fpu/api.h>
 #include <asm/nospec-branch.h>
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
 #ifdef CONFIG_CONTEXT_TRACKING
@@ -48,86 +47,6 @@
 static inline void enter_from_user_mode(void) {}
 #endif
 
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
-	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
-		BUG_ON(regs != task_pt_regs(current));
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
 	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY | _TIF_PATCH_PENDING)
@@ -277,13 +196,10 @@ static void syscall_slow_exit_work(struc
 #ifdef CONFIG_X86_64
 __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
-	struct thread_info *ti;
-
 	enter_from_user_mode();
 	local_irq_enable();
-	ti = current_thread_info();
-	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
-		nr = syscall_trace_enter(regs);
+
+	nr = syscall_enter_from_usermode(regs, nr);
 
 	if (likely(nr < NR_syscalls)) {
 		nr = array_index_nospec(nr, NR_syscalls);
@@ -310,22 +226,18 @@ static void syscall_slow_exit_work(struc
  */
 static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 {
-	struct thread_info *ti = current_thread_info();
 	unsigned int nr = (unsigned int)regs->orig_ax;
 
 #ifdef CONFIG_IA32_EMULATION
-	ti->status |= TS_COMPAT;
+	current_thread_info()->status |= TS_COMPAT;
 #endif
 
-	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY) {
-		/*
-		 * Subtlety here: if ptrace pokes something larger than
-		 * 2^32-1 into orig_ax, this truncates it.  This may or
-		 * may not be necessary, but it matches the old asm
-		 * behavior.
-		 */
-		nr = syscall_trace_enter(regs);
-	}
+	/*
+	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
+	 * orig_ax, this truncates it.  This may or may not be necessary,
+	 * but it matches the old asm behavior.
+	 */
+	nr = syscall_enter_from_usermode(regs, nr);
 
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
--- /dev/null
+++ b/arch/x86/include/asm/entry-common.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_X86_ENTRY_COMMON_H
+#define _ASM_X86_ENTRY_COMMON_H
+
+#include <linux/seccomp.h>
+#include <linux/audit.h>
+
+static inline long arch_syscall_enter_seccomp(struct pt_regs *regs)
+{
+#ifdef CONFIG_SECCOMP
+	u32 arch = in_ia32_syscall() ? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
+	struct seccomp_data sd;
+
+	sd.arch = arch;
+	sd.nr = regs->orig_ax;
+	sd.instruction_pointer = regs->ip;
+
+#ifdef CONFIG_X86_64
+	if (arch == AUDIT_ARCH_X86_64) {
+		sd.args[0] = regs->di;
+		sd.args[1] = regs->si;
+		sd.args[2] = regs->dx;
+		sd.args[3] = regs->r10;
+		sd.args[4] = regs->r8;
+		sd.args[5] = regs->r9;
+	} else
+#endif
+	{
+		sd.args[0] = regs->bx;
+		sd.args[1] = regs->cx;
+		sd.args[2] = regs->dx;
+		sd.args[3] = regs->si;
+		sd.args[4] = regs->di;
+		sd.args[5] = regs->bp;
+	}
+
+	return __secure_computing(&sd);
+#else
+	return 0;
+#endif
+}
+#define arch_syscall_enter_seccomp arch_syscall_enter_seccomp
+
+static inline void arch_syscall_enter_audit(struct pt_regs *regs)
+{
+#ifdef CONFIG_X86_64
+	if (in_ia32_syscall()) {
+		audit_syscall_entry(regs->orig_ax, regs->di,
+				    regs->si, regs->dx, regs->r10);
+	} else
+#endif
+	{
+		audit_syscall_entry(regs->orig_ax, regs->bx,
+				    regs->cx, regs->dx, regs->si);
+	}
+}
+#define arch_syscall_enter_audit arch_syscall_enter_audit
+
+#endif
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
 #define _TIF_WORK_CTXSW_BASE						\
 	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|		\


