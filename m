Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A522A233
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 00:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbgGVWOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 18:14:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52552 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbgGVWLb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 18:11:31 -0400
Message-Id: <20200722220519.833296398@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595455888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ME3PQX9GdECA9ZkinQ9fWUsF86JfwUKma+CTqWqs8dk=;
        b=QgPc+0Q0VolEURIJFJACNOdu81SudG+nQuJndN8u8219Ja5hT+wlo3AsxGnP6DPqaxrIh8
        +l6Fd4bOollLnlo0y5ZNLGjtd7d07XsqbWDCK/zAzrwhKiGUZTVLMfKyupp0nZzrThgOtm
        2Pjrb/rXlN55aMp7kwMK4TIUeLHf986dWbaSphlhWQcE/u5BYrOD/buV8wiENS57JpXEu+
        1u4+oktD31/Vz9uaBuY3VqnejfclrUbFLgvb7/3V9saA5uyV4NtmZOv4rD7AEgo9Um2XBf
        clzUIw7shhYqZLQpZi8k9/6s2B8jnsKTqHDUL885PbBLl1NjzPzMujlM4ksS8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595455888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ME3PQX9GdECA9ZkinQ9fWUsF86JfwUKma+CTqWqs8dk=;
        b=hDmQ4DHFaWNevNckooSbFM8TJSIzb0+v4rem/nNDzOweVJtD74V5apIVUlkLhWunIbVUKd
        5y3OgesCl+kJjMBg==
Date:   Wed, 22 Jul 2020 23:59:59 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V5 05/15] entry: Provide infrastructure for work before
 transitioning to guest mode
References: <20200722215954.464281930@linutronix.de>
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

The transfer to guest mode handling is different from the exit to usermode
handling, e.g. vs. rseq and live patching, so a separate function is used.

The initial list of work items handled is:

    TIF_SIGPENDING, TIF_NEED_RESCHED, TIF_NOTIFY_RESUME

Architecture specific TIF flags can be added via defines in the
architecture specific include files.

The calling convention is also different from the syscall/interrupt entry
functions as KVM invokes this from the outer vcpu_run() loop with
interrupts and preemption enabled. To prevent missing a pending work item
it invokes a check for pending TIF work from interrupt disabled code right
before transitioning to guest mode. The lockdep, RCU and tracing state
handling is also done directly around the switch to and from guest mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: Rename exit -> xfer (Sean)

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
+/* Transfer to guest mode work */
+#ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
+
+#ifndef ARCH_XFER_TO_GUEST_MODE_WORK
+# define ARCH_XFER_TO_GUEST_MODE_WORK	(0)
+#endif
+
+#define XFER_TO_GUEST_MODE_WORK					\
+	(_TIF_NEED_RESCHED | _TIF_SIGPENDING |			\
+	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
+
+struct kvm_vcpu;
+
+/**
+ * arch_xfer_to_guest_mode_work - Architecture specific xfer to guest mode
+ *				  work function.
+ * @vcpu:	Pointer to current's VCPU data
+ * @ti_work:	Cached TIF flags gathered in xfer_to_guest_mode()
+ *
+ * Invoked from xfer_to_guest_mode_work(). Defaults to NOOP. Can be
+ * replaced by architecture specific code.
+ */
+static inline int arch_xfer_to_guest_mode_work(struct kvm_vcpu *vcpu,
+					      unsigned long ti_work);
+
+#ifndef arch_xfer_to_guest_mode_work
+static inline int arch_xfer_to_guest_mode_work(struct kvm_vcpu *vcpu,
+					       unsigned long ti_work)
+{
+	return 0;
+}
+#endif
+
+/**
+ * xfer_to_guest_mode - Check and handle pending work which needs to be
+ *			handled before returning to guest mode
+ * @vcpu:	Pointer to current's VCPU data
+ *
+ * Returns: 0 or an error code
+ */
+int xfer_to_guest_mode(struct kvm_vcpu *vcpu);
+
+/**
+ * __xfer_to_guest_mode_work_pending - Check if work is pending
+ *
+ * Returns: True if work pending, False otherwise.
+ *
+ * Bare variant of xfer_to_guest_mode_work_pending(). Can be called from
+ * interrupt enabled code for racy quick checks with care.
+ */
+static inline bool __xfer_to_guest_mode_work_pending(void)
+{
+	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+
+	return !!(ti_work & XFER_TO_GUEST_MODE_WORK);
+}
+
+/**
+ * xfer_to_guest_mode_work_pending - Check if work is pending which needs to be
+ *				     handled before returning to guest mode
+ *
+ * Returns: True if work pending, False otherwise.
+ *
+ * Has to be invoked with interrupts disabled before the transition to
+ * guest mode.
+ */
+static inline bool xfer_to_guest_mode_work_pending(void)
+{
+	lockdep_assert_irqs_disabled();
+	return __xfer_to_guest_mode_work_pending();
+}
+#endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
+
+#endif
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1439,4 +1439,12 @@ int kvm_vm_create_worker_thread(struct k
 				uintptr_t data, const char *name,
 				struct task_struct **thread_ptr);
 
+#ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
+static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
+{
+	vcpu->run->exit_reason = KVM_EXIT_INTR;
+	vcpu->stat.signal_exits++;
+}
+#endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
+
 #endif
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -9,4 +9,5 @@ KCOV_INSTRUMENT := n
 CFLAGS_REMOVE_common.o	 = -fstack-protector -fstack-protector-strong
 CFLAGS_common.o		+= -fno-stack-protector
 
-obj-$(CONFIG_GENERIC_ENTRY) += common.o
+obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o
+obj-$(CONFIG_KVM_XFER_TO_GUEST_WORK)	+= kvm.o
--- /dev/null
+++ b/kernel/entry/kvm.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/entry-kvm.h>
+#include <linux/kvm_host.h>
+
+static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
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
+		ret = arch_xfer_to_guest_mode_work(vcpu, ti_work);
+		if (ret)
+			return ret;
+
+		ti_work = READ_ONCE(current_thread_info()->flags);
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+	return 0;
+}
+
+int xfer_to_guest_mode(struct kvm_vcpu *vcpu)
+{
+	unsigned long ti_work;
+
+	/*
+	 * This is invoked from the outer guest loop with interrupts and
+	 * preemption enabled.
+	 *
+	 * KVM invokes xfer_to_guest_mode_work_pending() with interrupts
+	 * disabled in the inner loop before going into guest mode. No need
+	 * to disable interrupts here.
+	 */
+	ti_work = READ_ONCE(current_thread_info()->flags);
+	if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
+		return 0;
+
+	return xfer_to_guest_mode_work(vcpu, ti_work);
+}
+EXPORT_SYMBOL_GPL(xfer_to_guest_mode);
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -60,3 +60,6 @@ config HAVE_KVM_VCPU_RUN_PID_CHANGE
 
 config HAVE_KVM_NO_POLL
        bool
+
+config KVM_XFER_TO_GUEST_WORK
+       bool

