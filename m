Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDDB4B7DBC
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391032AbfISPKl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:10:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50078 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390955AbfISPJy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:09:54 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy42-0006oe-Vu; Thu, 19 Sep 2019 17:09:47 +0200
Message-Id: <20190919150809.235562522@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:22 +0200
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
Subject: [RFC patch 08/15] arm64/syscall: Use generic syscall exit
 functionality
References: <20190919150314.054351477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace the syscall exit handling code with the generic version. That gets
rid of the interrupts disabled check for work flags. That's a non-issue
because the flags are checked with READ_ONCE() in the core and not
reevaluated. That's perfectly fine because the interrupts disabled check is
also just a snapshot.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm64/include/asm/entry-common.h |   11 +++++++++
 arch/arm64/kernel/ptrace.c            |   38 ----------------------------------
 arch/arm64/kernel/syscall.c           |   14 ------------
 3 files changed, 12 insertions(+), 51 deletions(-)

--- a/arch/arm64/include/asm/entry-common.h
+++ b/arch/arm64/include/asm/entry-common.h
@@ -29,6 +29,17 @@ static inline __must_check int arch_sysc
 }
 #define arch_syscall_enter_tracehook arch_syscall_enter_tracehook
 
+static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
+{
+	int regno = (is_compat_task() ? 12 : 7);
+	unsigned long reg = regs->regs[regno];
+
+	regs->regs[regno] = PTRACE_SYSCALL_EXIT;
+	tracehook_report_syscall_exit(regs, step);
+	regs->regs[regno] = reg;
+}
+#define arch_syscall_exit_tracehook arch_syscall_exit_tracehook
+
 static inline void arch_syscall_enter_audit(struct pt_regs *regs)
 {
 	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -13,13 +13,11 @@
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
-#include <linux/entry-common.h>
 #include <linux/mm.h>
 #include <linux/nospec.h>
 #include <linux/smp.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
-#include <linux/seccomp.h>
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/signal.h>
@@ -28,7 +26,6 @@
 #include <linux/perf_event.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/regset.h>
-#include <linux/tracehook.h>
 #include <linux/elf.h>
 
 #include <asm/compat.h>
@@ -1779,41 +1776,6 @@ long arch_ptrace(struct task_struct *chi
 	return ptrace_request(child, request, addr, data);
 }
 
-static void tracehook_report_syscall(struct pt_regs *regs,
-				     enum ptrace_syscall_dir dir)
-{
-	int regno;
-	unsigned long saved_reg;
-
-	/*
-	 * A scratch register (ip(r12) on AArch32, x7 on AArch64) is
-	 * used to denote syscall entry/exit:
-	 */
-	regno = (is_compat_task() ? 12 : 7);
-	saved_reg = regs->regs[regno];
-	regs->regs[regno] = dir;
-
-	if (dir == PTRACE_SYSCALL_EXIT)
-		tracehook_report_syscall_exit(regs, 0);
-	else if (tracehook_report_syscall_entry(regs))
-		forget_syscall(regs);
-
-	regs->regs[regno] = saved_reg;
-}
-
-void syscall_trace_exit(struct pt_regs *regs)
-{
-	audit_syscall_exit(regs);
-
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_exit(regs, regs_return_value(regs));
-
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
-
-	rseq_syscall(regs);
-}
-
 /*
  * SPSR_ELx bits which are always architecturally RES0 per ARM DDI 0487D.a.
  * We permit userspace to set SSBS (AArch64 bit 12, AArch32 bit 23) which is
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -54,13 +54,6 @@ static void invoke_syscall(struct pt_reg
 	regs->regs[0] = ret;
 }
 
-static inline bool has_syscall_work(unsigned long flags)
-{
-	return unlikely(flags & _TIF_SYSCALL_WORK);
-}
-
-void syscall_trace_exit(struct pt_regs *regs);
-
 #ifdef CONFIG_ARM64_ERRATUM_1463225
 DECLARE_PER_CPU(int, __in_cortex_a76_erratum_1463225_wa);
 
@@ -106,12 +99,7 @@ static void el0_svc_common(struct pt_reg
 	if (scno != NO_SYSCALL)
 		invoke_syscall(regs, scno, sc_nr, syscall_table);
 
-	local_daif_mask();
-	if (has_syscall_work(current_thread_info()->flags) ||
-	    IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		local_daif_restore(DAIF_PROCCTX);
-		syscall_trace_exit(regs);
-	}
+	syscall_exit_to_usermode(regs, scno, regs_return_value(regs));
 }
 
 static inline void sve_user_discard(void)


