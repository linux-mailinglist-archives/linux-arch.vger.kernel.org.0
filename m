Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43BB7DC8
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390945AbfISPJv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:09:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50051 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732001AbfISPJv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:09:51 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy3z-0006nq-86; Thu, 19 Sep 2019 17:09:43 +0200
Message-Id: <20190919150808.830764150@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:18 +0200
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
Subject: [RFC patch 04/15] arm64/entry: Use generic syscall entry function
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
 arch/arm64/Kconfig                    |    1 
 arch/arm64/include/asm/entry-common.h |   39 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ptrace.c            |   29 -------------------------
 arch/arm64/kernel/syscall.c           |   15 +++++--------
 4 files changed, 47 insertions(+), 37 deletions(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -99,6 +99,7 @@ config ARM64
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_ENTRY
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
--- /dev/null
+++ b/arch/arm64/include/asm/entry-common.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017 ARM Ltd.
+ */
+#ifndef __ASM_ENTRY_COMMON_H
+#define __ASM_ENTRY_COMMON_H
+
+enum ptrace_syscall_dir {
+	PTRACE_SYSCALL_ENTER = 0,
+	PTRACE_SYSCALL_EXIT,
+};
+
+/*
+ * A scratch register (ip(r12) on AArch32, x7 on AArch64) is
+ * used to denote syscall entry/exit for the tracehooks
+ */
+static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs)
+{
+	int regno = (is_compat_task() ? 12 : 7);
+	unsigned long reg = regs->regs[regno];
+	long ret;
+
+	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
+	ret = tracehook_report_syscall_entry(regs);
+	if (ret)
+		forget_syscall(regs);
+	regs->regs[regno] = reg;
+	return ret;
+}
+#define arch_syscall_enter_tracehook arch_syscall_enter_tracehook
+
+static inline void arch_syscall_enter_audit(struct pt_regs *regs)
+{
+	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
+			    regs->regs[2], regs->regs[3]);
+}
+#define arch_syscall_enter_audit arch_syscall_enter_audit
+
+#endif
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
+#include <linux/entry-common.h>
 #include <linux/mm.h>
 #include <linux/nospec.h>
 #include <linux/smp.h>
@@ -41,7 +42,6 @@
 #include <asm/traps.h>
 #include <asm/system_misc.h>
 
-#define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
 struct pt_regs_offset {
@@ -1779,11 +1779,6 @@ long arch_ptrace(struct task_struct *chi
 	return ptrace_request(child, request, addr, data);
 }
 
-enum ptrace_syscall_dir {
-	PTRACE_SYSCALL_ENTER = 0,
-	PTRACE_SYSCALL_EXIT,
-};
-
 static void tracehook_report_syscall(struct pt_regs *regs,
 				     enum ptrace_syscall_dir dir)
 {
@@ -1806,28 +1801,6 @@ static void tracehook_report_syscall(str
 	regs->regs[regno] = saved_reg;
 }
 
-int syscall_trace_enter(struct pt_regs *regs)
-{
-	if (test_thread_flag(TIF_SYSCALL_TRACE) ||
-		test_thread_flag(TIF_SYSCALL_EMU)) {
-		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
-		if (!in_syscall(regs) || test_thread_flag(TIF_SYSCALL_EMU))
-			return -1;
-	}
-
-	/* Do the secure computing after ptrace; failures should be fast. */
-	if (secure_computing(NULL) == -1)
-		return -1;
-
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_enter(regs, regs->syscallno);
-
-	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
-			    regs->regs[2], regs->regs[3]);
-
-	return regs->syscallno;
-}
-
 void syscall_trace_exit(struct pt_regs *regs)
 {
 	audit_syscall_exit(regs);
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/compiler.h>
+#include <linux/entry-common.h>
 #include <linux/context_tracking.h>
 #include <linux/errno.h>
 #include <linux/nospec.h>
@@ -58,7 +59,6 @@ static inline bool has_syscall_work(unsi
 	return unlikely(flags & _TIF_SYSCALL_WORK);
 }
 
-int syscall_trace_enter(struct pt_regs *regs);
 void syscall_trace_exit(struct pt_regs *regs);
 
 #ifdef CONFIG_ARM64_ERRATUM_1463225
@@ -97,19 +97,16 @@ static void el0_svc_common(struct pt_reg
 
 	regs->orig_x0 = regs->regs[0];
 	regs->syscallno = scno;
+	/* Set default error number */
+	regs->regs[0] = -ENOSYS;
 
 	cortex_a76_erratum_1463225_svc_handler();
 	local_daif_restore(DAIF_PROCCTX);
 	user_exit();
 
-	if (has_syscall_work(flags)) {
-		/* set default errno for user-issued syscall(-1) */
-		if (scno == NO_SYSCALL)
-			regs->regs[0] = -ENOSYS;
-		scno = syscall_trace_enter(regs);
-		if (scno == NO_SYSCALL)
-			goto trace_exit;
-	}
+	scno = syscall_enter_from_usermode(regs, scno);
+	if (scno == NO_SYSCALL)
+		goto trace_exit;
 
 	invoke_syscall(regs, scno, sc_nr, syscall_table);
 


