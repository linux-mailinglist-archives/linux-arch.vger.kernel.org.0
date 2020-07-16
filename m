Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95A4222C4F
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 21:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgGPTvn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 15:51:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgGPTut (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 15:50:49 -0400
Message-Id: <20200716185424.333483453@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594929047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=cVfEZjCkZ09pfI7rdgjG1e1cGx1sdhzZcD6Ss8C4u0s=;
        b=BsjSosrG6lDuFfdSA5EsCpYDWAdLPFWZUjJWhGeBTBI0J9cz+ikMAh+QAaGt6ZKhP+LWNy
        ZZf+8DeBEr0gwiTfNZgRK1KXxHfKJxad6Hn5XQ6jXOr4EkKS0ynn5pIiDczZrzUmaiG6Ql
        iwM3bk6VhwTPzhNmjqIwlqeZBoy8aWq+mNZ5c0LkIW4xBG9b/RAU+XgnnKMkxiKd+Gb1gr
        MgXJyqZsVaXXrP0oJo/ylFeWA0OxzQW+Q0pOSaOVZC3iyiTq+PjXwwgbFOKIfQQtQiFoKG
        WFzfCpK1H0uIYnVVxqqXdtxJHskHXMCbznZT8hE4JCQYjAS/0MoYSze+cfbNgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594929047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=cVfEZjCkZ09pfI7rdgjG1e1cGx1sdhzZcD6Ss8C4u0s=;
        b=4SFXnmuW1BXxVDyX3AzEip+0B7keM+Rk1Nf/n8Xa7NlJDry9eQ8p9zsoPd+R98sFRurG7N
        c7ldYCBFCmLCYRCg==
Date:   Thu, 16 Jul 2020 20:22:12 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [patch V3 04/13] entry: Provide infrastructure for work before
 exiting to guest mode
References: <20200716182208.180916541@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Entering a guest is similar to exiting to user space. Pending work like
handling signals, rescheduling, task work etc. needs to be handled before
that.

Provide generic infrastructure to avoid duplication of the same handling
code all over the place.

The exit to guest mode handling is different from the exit to usermode
handling, e.g. vs. rseq and live patching, so a separate function is used.

The initial list of work items handled is:

    TIF_SIGPENDING, TIF_NEED_RESCHED, TIF_NOTIFY_RESUME

Architecture specific TIF flags can be added via defines in the
architecture specific include files.

The calling convention is also different from the syscall/interrupt entry
functions as KVM invokes this from the outer vcpu_run() loop with
interrupts and preemption disabled. To prevent missing a pending work item
it invokes a check for pending TIF work from interrupt disabled code right
before exiting to guest mode. The lockdep, RCU and tracing state handling
is also done directly around the switch to and from guest mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
---
V3: Reworked and simplified version adopted to recent X86 and KVM changes
    
V2: Moved KVM specific functions to kvm (Paolo)
    Added lockdep assert (Andy)
    Dropped live patching from enter guest mode work (Miroslav)
---
 include/linux/entry-kvm.h |   80 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h  |    8 ++++
 kernel/entry/Makefile     |    3 +
 kernel/entry/kvm.c        |   51 +++++++++++++++++++++++++++++
 virt/kvm/Kconfig          |    3 +
 5 files changed, 144 insertions(+), 1 deletion(-)

--- /dev/null
+++ b/include/linux/entry-kvm.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_ENTRYKVM_H
+#define __LINUX_ENTRYKVM_H
+
+#include <linux/entry-common.h>
+
+/* Exit to guest mode work */
+#ifdef CONFIG_KVM_EXIT_TO_GUEST_WORK
+
+#ifndef ARCH_EXIT_TO_GUEST_MODE_WORK
+# define ARCH_EXIT_TO_GUEST_MODE_WORK	(0)
+#endif
+
+#define EXIT_TO_GUEST_MODE_WORK					\
+	(_TIF_NEED_RESCHED | _TIF_SIGPENDING |			\
+	 _TIF_NOTIFY_RESUME | ARCH_EXIT_TO_GUEST_MODE_WORK)
+
+struct kvm_vcpu;
+
+/**
+ * arch_exit_to_guest_mode_work - Architecture specific exit to guest mode
+ *				  work function.
+ * @vcpu:	Pointer to current's VCPU data
+ * @ti_work:	Cached TIF flags gathered in exit_to_guest_mode()
+ *
+ * Invoked from exit_to_guest_mode_work(). Defaults to NOOP. Can be
+ * replaced by architecture specific code.
+ */
+static inline int arch_exit_to_guest_mode_work(struct kvm_vcpu *vcpu,
+					      unsigned long ti_work);
+
+#ifndef arch_exit_to_guest_mode_work
+static inline int arch_exit_to_guest_mode_work(struct kvm_vcpu *vcpu,
+					       unsigned long ti_work)
+{
+	return 0;
+}
+#endif
+
+/**
+ * exit_to_guest_mode - Check and handle pending work which needs to be
+ *			handled before returning to guest mode
+ * @vcpu:	Pointer to current's VCPU data
+ *
+ * Returns: 0 or an error code
+ */
+int exit_to_guest_mode(struct kvm_vcpu *vcpu);
+
+/**
+ * __exit_to_guest_mode_work_pending - Check if work is pending
+ *
+ * Returns: True if work pending, False otherwise.
+ *
+ * Bare variant of exit_to_guest_mode_work_pending(). Can be called from
+ * interrupt enabled code for racy quick checks with care.
+ */
+static inline bool __exit_to_guest_mode_work_pending(void)
+{
+	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+
+	return !!(ti_work & EXIT_TO_GUEST_MODE_WORK);
+}
+
+/**
+ * exit_to_guest_mode_work_pending - Check if work is pending which needs to be
+ *				     handled before returning to guest mode
+ *
+ * Returns: True if work pending, False otherwise.
+ *
+ * Has to be invoked with interrupts disabled before the transition to
+ * guest mode.
+ */
+static inline bool exit_to_guest_mode_work_pending(void)
+{
+	lockdep_assert_irqs_disabled();
+	return __exit_to_guest_mode_work_pending();
+}
+#endif /* CONFIG_KVM_EXIT_TO_GUEST_WORK */
+
+#endif
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1439,4 +1439,12 @@ int kvm_vm_create_worker_thread(struct k
 				uintptr_t data, const char *name,
 				struct task_struct **thread_ptr);
 
+#ifdef CONFIG_KVM_EXIT_TO_GUEST_WORK
+static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
+{
+	vcpu->run->exit_reason = KVM_EXIT_INTR;
+	vcpu->stat.signal_exits++;
+}
+#endif /* CONFIG_KVM_EXIT_TO_GUEST_WORK */
+
 #endif
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_GENERIC_ENTRY) += common.o
+obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o
+obj-$(CONFIG_KVM_EXIT_TO_GUEST_WORK)	+= kvm.o
--- /dev/null
+++ b/kernel/entry/kvm.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/entry-kvm.h>
+#include <linux/kvm_host.h>
+
+static int exit_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
+{
+	do {
+		int ret;
+
+		if (ti_work & _TIF_SIGPENDING) {
+			kvm_handle_signal_exit(vcpu);
+			return -EINTR;
+		}
+
+		if (ti_work & _TIF_NEED_RESCHED)
+			schedule();
+
+		if (ti_work & _TIF_NOTIFY_RESUME) {
+			clear_thread_flag(TIF_NOTIFY_RESUME);
+			tracehook_notify_resume(NULL);
+		}
+
+		ret = arch_exit_to_guest_mode_work(vcpu, ti_work);
+		if (ret)
+			return ret;
+
+		ti_work = READ_ONCE(current_thread_info()->flags);
+	} while (ti_work & EXIT_TO_GUEST_MODE_WORK || need_resched());
+	return 0;
+}
+
+int exit_to_guest_mode(struct kvm_vcpu *vcpu)
+{
+	unsigned long ti_work;
+
+	/*
+	 * This is invoked from the outer guest loop with interrupts and
+	 * preemption enabled.
+	 *
+	 * KVM invokes exit_to_guest_mode_work_pending() with interrupts
+	 * disabled in the inner loop before going into guest mode. No need
+	 * to disable interrupts here.
+	 */
+	ti_work = READ_ONCE(current_thread_info()->flags);
+	if (!(ti_work & EXIT_TO_GUEST_MODE_WORK))
+		return 0;
+
+	return exit_to_guest_mode_work(vcpu, ti_work);
+}
+EXPORT_SYMBOL_GPL(exit_to_guest_mode);
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -60,3 +60,6 @@ config HAVE_KVM_VCPU_RUN_PID_CHANGE
 
 config HAVE_KVM_NO_POLL
        bool
+
+config KVM_EXIT_TO_GUEST_WORK
+       bool

