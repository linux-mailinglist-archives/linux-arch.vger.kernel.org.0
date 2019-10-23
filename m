Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E40FE1A5A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 14:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391448AbfJWMbq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 08:31:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49149 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391431AbfJWMbp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 08:31:45 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNFnh-00018l-5u; Wed, 23 Oct 2019 14:31:41 +0200
Message-Id: <20191023123118.978254388@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 23 Oct 2019 14:27:19 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [patch V2 14/17] entry: Provide generic exit to usermode functionality
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Provide a generic facility to handle the exit to usermode work. That's
aimed to replace the pointlessly different copies in each architecture.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Move lockdep and address limit check right to the end of the return
    sequence. (PeterZ)
---
 include/linux/entry-common.h |  105 +++++++++++++++++++++++++++++++++++++++++++
 kernel/entry/common.c        |   82 +++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -34,6 +34,30 @@
 # define _TIF_AUDIT			(0)
 #endif
 
+#ifndef _TIF_UPROBE
+# define _TIF_UPROBE			(0)
+#endif
+
+#ifndef _TIF_PATCH_PENDING
+# define _TIF_PATCH_PENDING		(0)
+#endif
+
+#ifndef _TIF_NOTIFY_RESUME
+# define _TIF_NOTIFY_RESUME		(0)
+#endif
+
+/*
+ * TIF flags handled in exit_to_usermode()
+ */
+#ifndef ARCH_EXIT_TO_USERMODE_WORK
+# define ARCH_EXIT_TO_USERMODE_WORK	(0)
+#endif
+
+#define EXIT_TO_USERMODE_WORK						\
+	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
+	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING |			\
+	 ARCH_EXIT_TO_USERMODE_WORK)
+
 /*
  * TIF flags handled in syscall_enter_from_usermode()
  */
@@ -58,6 +82,87 @@
 	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
 
 /**
+ * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Defaults to local_irq_enable(). Can be supplied by architecture specific
+ * code.
+ */
+static inline void local_irq_enable_exit_to_user(unsigned long ti_work);
+
+#ifndef local_irq_enable_exit_to_user
+static inline void local_irq_enable_exit_to_user(unsigned long ti_work)
+{
+	local_irq_enable();
+}
+#endif
+
+/**
+ * local_irq_disable_exit_to_user - Exit to user variant of local_irq_disable()
+ *
+ * Defaults to local_irq_disable(). Can be supplied by architecture specific
+ * code.
+ */
+static inline void local_irq_disable_exit_to_user(void);
+
+#ifndef local_irq_disable_exit_to_user
+static inline void local_irq_disable_exit_to_user(void)
+{
+	local_irq_disable();
+}
+#endif
+
+/**
+ * arch_exit_to_usermode_work - Architecture specific TIF work for
+ *				exit to user mode.
+ * @regs:	Pointer to currents pt_regs
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Invoked from exit_to_usermode() with interrupt disabled
+ *
+ * Defaults to NOOP. Can be supplied by architecture specific code.
+ */
+static inline void arch_exit_to_usermode_work(struct pt_regs *regs,
+					      unsigned long ti_work);
+
+#ifndef arch_exit_to_usermode_work
+static inline void arch_exit_to_usermode_work(struct pt_regs *regs,
+					      unsigned long ti_work)
+{
+}
+#endif
+
+/**
+ * arch_exit_to_usermode - Architecture specific preparation for
+ *			   exit to user mode.
+ * @regs:	Pointer to currents pt_regs
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Invoked from exit_to_usermode() with interrupt disabled as the last
+ * function before return.
+ */
+static inline void arch_exit_to_usermode(struct pt_regs *regs,
+					 unsigned long ti_work);
+
+#ifndef arch_exit_to_usermode
+static inline void arch_exit_to_usermode(struct pt_regs *regs,
+					 unsigned long ti_work)
+{
+}
+#endif
+
+/* Common exit to usermode function to handle TIF work */
+asmlinkage __visible void exit_to_usermode(struct pt_regs *regs);
+
+/**
+ * arch_do_signal -  Architecture specific signal delivery function
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked from exit_to_usermode()
+ */
+void arch_do_signal(struct pt_regs *regs);
+
+/**
  * arch_syscall_enter_tracehook - Wrapper around tracehook_report_syscall_entry()
  * @regs:	Pointer to currents pt_regs
  *
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -2,10 +2,86 @@
 
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
+#include <linux/livepatch.h>
+#include <linux/uprobes.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+static unsigned long core_exit_to_usermode_work(struct pt_regs *regs,
+						unsigned long ti_work)
+{
+	/*
+	 * Before returning to user space ensure that all pending work
+	 * items have been completed.
+	 */
+	while (ti_work & EXIT_TO_USERMODE_WORK) {
+
+		local_irq_enable_exit_to_user(ti_work);
+
+		if (ti_work & _TIF_NEED_RESCHED)
+			schedule();
+
+		if (ti_work & _TIF_UPROBE)
+			uprobe_notify_resume(regs);
+
+		if (ti_work & _TIF_PATCH_PENDING)
+			klp_update_patch_state(current);
+
+		if (ti_work & _TIF_SIGPENDING)
+			arch_do_signal(regs);
+
+		if (ti_work & _TIF_NOTIFY_RESUME) {
+			clear_thread_flag(TIF_NOTIFY_RESUME);
+			tracehook_notify_resume(regs);
+			rseq_handle_notify_resume(NULL, regs);
+		}
+
+		/* Architecture specific TIF work */
+		arch_exit_to_usermode_work(regs, ti_work);
+
+		/*
+		 * Disable interrupts and reevaluate the work flags as they
+		 * might have changed while interrupts and preemption was
+		 * enabled above.
+		 */
+		local_irq_disable_exit_to_user();
+		ti_work = READ_ONCE(current_thread_info()->flags);
+	}
+	return ti_work;
+}
+
+static void do_exit_to_usermode(struct pt_regs *regs)
+{
+	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+
+	if (unlikely(ti_work & EXIT_TO_USERMODE_WORK))
+		ti_work = core_exit_to_usermode_work(regs, ti_work);
+
+	arch_exit_to_usermode(regs, ti_work);
+
+	/* Ensure no locks are held and the address limit is intact */
+	lockdep_sys_exit();
+	addr_limit_user_check();
+
+	/* Return to userspace right after this which turns on interrupts */
+	trace_hardirqs_on();
+}
+
+/**
+ * exit_to_usermode - Check and handle pending work which needs to be
+ *		      handled before returning to user mode
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Called and returns with interrupts disabled
+ */
+asmlinkage __visible void exit_to_usermode(struct pt_regs *regs)
+{
+	trace_hardirqs_off();
+	lockdep_assert_irqs_disabled();
+	do_exit_to_usermode(regs);
+}
+
 long core_syscall_enter_from_usermode(struct pt_regs *regs, long syscall)
 {
 	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
@@ -85,4 +161,10 @@ void syscall_exit_to_usermode(struct pt_
 	ti_work = READ_ONCE(current_thread_info()->flags);
 	if (unlikely(ti_work & SYSCALL_EXIT_WORK))
 		syscall_exit_work(regs, retval, ti_work);
+
+	/*
+	 * Disable interrupts and handle the regular exit to user mode work
+	 */
+	local_irq_disable_exit_to_user();
+	do_exit_to_usermode(regs);
 }


