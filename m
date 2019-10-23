Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D37EE1A50
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 14:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391476AbfJWMby (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 08:31:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49153 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391437AbfJWMbq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 08:31:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNFni-000193-7h; Wed, 23 Oct 2019 14:31:42 +0200
Message-Id: <20191023123119.173422855@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 23 Oct 2019 14:27:21 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [patch V2 16/17] kvm/workpending: Provide infrastructure for work
 before entering a guest
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Entering a guest is similar to exiting to user space. Pending work like
handling signals, rescheduling, task work etc. needs to be handled before
that.

Provide generic infrastructure to avoid duplication of the same handling code
all over the place.

The kvm_exit code is split up into a KVM specific part and a generic
builtin core part to avoid multiple exports for the actual work
functions. The exit to guest mode handling is slightly different from the
exit to usermode handling, e.g. vs. rseq, so a separate function is used.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Moved KVM specific functions to kvm (Paolo)
    Added lockdep assert (Andy)
    Dropped live patching from enter guest mode work (Miroslav)
---
 include/linux/entry-common.h |   12 ++++++++
 include/linux/kvm_host.h     |   64 +++++++++++++++++++++++++++++++++++++++++++
 kernel/entry/common.c        |   14 +++++++++
 virt/kvm/Kconfig             |    3 ++
 4 files changed, 93 insertions(+)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -265,4 +265,16 @@ static inline void arch_syscall_exit_tra
 /* Common syscall exit function */
 void syscall_exit_to_usermode(struct pt_regs *regs, long syscall, long retval);
 
+/* KVM exit to guest mode */
+
+void core_exit_to_guestmode_work(unsigned long ti_work);
+
+#ifndef ARCH_EXIT_TO_GUESTMODE_WORK
+# define ARCH_EXIT_TO_GUESTMODE_WORK	(0)
+#endif
+
+#define EXIT_TO_GUESTMODE_WORK						\
+	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_RESUME |	\
+	 ARCH_EXIT_TO_GUESTMODE_WORK)
+
 #endif
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/irqflags.h>
 #include <linux/context_tracking.h>
+#include <linux/entry-common.h>
 #include <linux/irqbypass.h>
 #include <linux/swait.h>
 #include <linux/refcount.h>
@@ -1382,4 +1383,67 @@ static inline int kvm_arch_vcpu_run_pid_
 }
 #endif /* CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE */
 
+/* Exit to guest mode work */
+#ifdef CONFIG_KVM_EXIT_TO_GUEST_WORK
+
+#ifndef arch_exit_to_guestmode_work
+/**
+ * arch_exit_to_guestmode_work - Architecture specific exit to guest mode function
+ * @kvm:	Pointer to the guest instance
+ * @vcpu:	Pointer to current's VCPU data
+ * @ti_work:	Cached TIF flags gathered in exit_to_guestmode()
+ *
+ * Invoked from kvm_exit_to_guestmode_work(). Can be replaced by
+ * architecture specific code.
+ */
+static inline int arch_exit_to_guestmode_work(struct kvm *kvm,
+					      struct kvm_vcpu *vcpu,
+					      unsigned long ti_work)
+{
+	return 0;
+}
+#endif
+
+/**
+ * exit_to_guestmode - Check and handle pending work which needs to be
+ *		       handled before returning to guest mode
+ * @kvm:	Pointer to the guest instance
+ * @vcpu:	Pointer to current's VCPU data
+ *
+ * Returns: 0 or an error code
+ */
+static inline int exit_to_guestmode(struct kvm *kvm, struct kvm_vcpu *vcpu)
+{
+	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	int r = 0;
+
+	if (unlikely(ti_work & EXIT_TO_GUESTMODE_WORK)) {
+		if (ti_work & _TIF_SIGPENDING) {
+			vcpu->run->exit_reason = KVM_EXIT_INTR;
+			vcpu->stat.signal_exits++;
+			return -EINTR;
+		}
+		core_exit_to_guestmode_work(ti_work);
+		r = arch_exit_to_guestmode_work(kvm, vcpu, ti_work);
+	}
+	return r;
+}
+
+/**
+ * _exit_to_guestmode_work_pending - Check if work is pending which needs to be
+ *				     handled before returning to guest mode
+ *
+ * Returns: True if work pending, False otherwise.
+ */
+static inline bool exit_to_guestmode_work_pending(void)
+{
+	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+
+	lockdep_assert_irqs_disabled();
+
+	return !!(ti_work & EXIT_TO_GUESTMODE_WORK);
+
+}
+#endif /* CONFIG_KVM_EXIT_TO_GUEST_WORK */
+
 #endif
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -8,6 +8,20 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+#ifdef CONFIG_KVM_EXIT_TO_GUEST_WORK
+void core_exit_to_guestmode_work(unsigned long ti_work)
+{
+	if (ti_work & _TIF_NEED_RESCHED)
+		schedule();
+
+	if (ti_work & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(NULL);
+	}
+}
+EXPORT_SYMBOL_GPL(core_exit_to_guestmode_work);
+#endif
+
 static unsigned long core_exit_to_usermode_work(struct pt_regs *regs,
 						unsigned long ti_work)
 {
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -60,3 +60,6 @@ config HAVE_KVM_VCPU_RUN_PID_CHANGE
 
 config HAVE_KVM_NO_POLL
        bool
+
+config KVM_EXIT_TO_GUEST_WORK
+       bool


