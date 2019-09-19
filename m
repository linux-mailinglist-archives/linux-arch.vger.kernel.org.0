Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623ACB7DC4
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391058AbfISPKt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:10:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50065 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390941AbfISPJw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:09:52 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy41-0006oE-EB; Thu, 19 Sep 2019 17:09:45 +0200
Message-Id: <20190919150809.041298671@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:20 +0200
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
Subject: [RFC patch 06/15] x86/entry: Use generic syscall exit functionality
References: <20190919150314.054351477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace the x86 variant with the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c             |   44 ------------------------------------
 arch/x86/include/asm/entry-common.h |    2 +
 2 files changed, 3 insertions(+), 43 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -139,55 +139,13 @@ static void exit_to_usermode_loop(struct
 	mds_user_clear_cpu_buffers();
 }
 
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
 /*
  * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
  * state such that we can immediately switch to user mode.
  */
 __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 {
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
+	syscall_exit_to_usermode(regs, regs->orig_ax, regs->ax);
 
 	local_irq_disable();
 	prepare_exit_to_usermode(regs);
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -5,6 +5,8 @@
 #include <linux/seccomp.h>
 #include <linux/audit.h>
 
+#define ARCH_SYSCALL_EXIT_WORK		(_TIF_SINGLESTEP)
+
 static inline long arch_syscall_enter_seccomp(struct pt_regs *regs)
 {
 #ifdef CONFIG_SECCOMP


