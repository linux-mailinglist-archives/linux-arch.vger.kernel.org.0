Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD4C0E1A60
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 14:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391535AbfJWMcQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 08:32:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49134 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391417AbfJWMbo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 08:31:44 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNFng-00018J-4M; Wed, 23 Oct 2019 14:31:40 +0200
Message-Id: <20191023123118.778776715@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 23 Oct 2019 14:27:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [patch V2 12/17] entry: Provide generic syscall exit function
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Like syscall entry all architectures have similar and pointlessly different
code to handle pending work before returning from a syscall to user space.

Provide a generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/entry-common.h |   31 ++++++++++++++++++++++++
 kernel/entry/common.c        |   55 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -46,6 +46,17 @@
 	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
 	 ARCH_SYSCALL_ENTER_WORK)
 
+/*
+ * TIF flags handled in syscall_exit_to_usermode()
+ */
+#ifndef ARCH_SYSCALL_EXIT_WORK
+# define ARCH_SYSCALL_EXIT_WORK		(0)
+#endif
+
+#define SYSCALL_EXIT_WORK						\
+	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
+	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
+
 /**
  * arch_syscall_enter_tracehook - Wrapper around tracehook_report_syscall_entry()
  * @regs:	Pointer to currents pt_regs
@@ -129,4 +140,24 @@ static inline long syscall_enter_from_us
 	return syscall;
 }
 
+/**
+ * arch_syscall_exit_tracehook - Wrapper around tracehook_report_syscall_exit()
+ *
+ * Defaults to tracehook_report_syscall_exit(). Can be replaced by
+ * architecture specific code.
+ *
+ * Invoked from syscall_exit_to_usermode()
+ */
+static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step);
+
+#ifndef arch_syscall_exit_tracehook
+static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
+{
+	tracehook_report_syscall_exit(regs, step);
+}
+#endif
+
+/* Common syscall exit function */
+void syscall_exit_to_usermode(struct pt_regs *regs, long syscall, long retval);
+
 #endif
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -31,3 +31,58 @@ long core_syscall_enter_from_usermode(st
 
 	return ret ? : syscall;
 }
+
+#ifndef _TIF_SINGLESTEP
+static inline bool report_single_step(unsigned long ti_work)
+{
+	return false;
+}
+#else
+/*
+ * If TIF_SYSCALL_EMU is set, then the only reason to report is when
+ * TIF_SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
+ * instruction has been already reported in syscall_enter_from_usermode().
+ */
+#define SYSEMU_STEP	(_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)
+
+static inline bool report_single_step(unsigned long ti_work)
+{
+	return (ti_work & SYSEMU_STEP) == _TIF_SINGLESTEP;
+}
+#endif
+
+static void syscall_exit_work(struct pt_regs *regs, long retval,
+			      unsigned long ti_work)
+{
+	bool step;
+
+	audit_syscall_exit(regs);
+
+	if (ti_work & _TIF_SYSCALL_TRACEPOINT)
+		trace_sys_exit(regs, retval);
+
+	step = report_single_step(ti_work);
+	if (step || ti_work & _TIF_SYSCALL_TRACE)
+		arch_syscall_exit_tracehook(regs, step);
+}
+
+void syscall_exit_to_usermode(struct pt_regs *regs, long syscall, long retval)
+{
+	unsigned long ti_work;
+
+	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
+
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING) &&
+	    WARN(irqs_disabled(), "syscall %ld left IRQs disabled", syscall))
+		local_irq_enable();
+
+	rseq_syscall(regs);
+
+	/*
+	 * Handle work which needs to run exactly once per syscall exit
+	 * with interrupts enabled.
+	 */
+	ti_work = READ_ONCE(current_thread_info()->flags);
+	if (unlikely(ti_work & SYSCALL_EXIT_WORK))
+		syscall_exit_work(regs, retval, ti_work);
+}


