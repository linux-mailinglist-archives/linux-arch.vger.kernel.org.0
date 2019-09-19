Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B003B7DA7
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403949AbfISPKB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:10:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbfISPKA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:10:00 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy49-0006pg-1u; Thu, 19 Sep 2019 17:09:53 +0200
Message-Id: <20190919150809.860645841@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:28 +0200
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
Subject: [RFC patch 14/15] workpending: Provide infrastructure for work before
 entering a guest
References: <20190919150314.054351477@linutronix.de>
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

Update ARM64 struct kvm_vcpu_stat with a signal_exit member so the generic
code compiles.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm64/include/asm/kvm_host.h |    1 
 include/linux/entry-common.h      |   66 ++++++++++++++++++++++++++++++++++++++
 kernel/entry/common.c             |   44 +++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -409,6 +409,7 @@ struct kvm_vcpu_stat {
 	u64 wfi_exit_stat;
 	u64 mmio_exit_user;
 	u64 mmio_exit_kernel;
+	u64 signal_exits;
 	u64 exits;
 };
 
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -255,4 +255,70 @@ static inline void arch_syscall_exit_tra
 /* Common syscall exit function */
 void syscall_exit_to_usermode(struct pt_regs *regs, long syscall, long retval);
 
+#if IS_ENABLED(CONFIG_KVM)
+
+#include <linux/kvm_host.h>
+
+#ifndef ARCH_EXIT_TO_GUESTMODE_WORK
+# define ARCH_EXIT_TO_GUESTMODE_WORK	(0)
+#endif
+
+#define EXIT_TO_GUESTMODE_WORK						\
+	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_RESUME |	\
+	 ARCH_EXIT_TO_GUESTMODE_WORK)
+
+int core_exit_to_guestmode_work(struct kvm *kvm, struct kvm_vcpu *vcpu,
+				unsigned long ti_work);
+
+/**
+ * arch_exit_to_guestmode - Architecture specific exit to guest mode function
+ * @kvm:	Pointer to the guest instance
+ * @vcpu:	Pointer to current's VCPU data
+ * @ti_work:	Cached TIF flags gathered in exit_to_guestmode()
+ *
+ * Invoked from core_exit_to_guestmode_work(). Can be replaced by
+ * architecture specific code.
+ */
+static inline int arch_exit_to_guestmode(struct kvm *kvm, struct kvm_vcpu *vcpu,
+					 unsigned long ti_work);
+
+#ifndef arch_exit_to_guestmode
+static inline int arch_exit_to_guestmode(struct kvm *kvm, struct kvm_vcpu *vcpu,
+					 unsigned long ti_work)
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
+
+	if (unlikely(ti_work & EXIT_TO_GUESTMODE_WORK))
+		return core_exit_to_guestmode_work(kvm, vcpu, ti_work);
+	return 0;
+}
+
+
+/**
+ * _exit_to_guestmode_work_pending - Check if work is pending which needs to be
+ *				     handled before returning to guest mode
+ */
+static inline bool exit_to_guestmode_work_pending(void)
+{
+	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+
+	return !!(ti_work & EXIT_TO_GUESTMODE_WORK);
+
+}
+#endif /* CONFIG_KVM */
+
 #endif
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -174,3 +174,47 @@ void syscall_exit_to_usermode(struct pt_
 	do_exit_to_usermode(regs);
 #endif
 }
+
+#if IS_ENABLED(CONFIG_KVM)
+int __weak arch_exit_to_guestmode_work(struct kvm *kvm, struct kvm_vcpu *vcpu,
+				       unsigned long ti_work)
+{
+	return 0;
+}
+
+int core_exit_to_guestmode_work(struct kvm *kvm, struct kvm_vcpu *vcpu,
+				unsigned long ti_work)
+{
+	/*
+	 * Before returning to guest mode handle all pending work
+	 */
+	if (ti_work & _TIF_SIGPENDING) {
+		vcpu->run->exit_reason = KVM_EXIT_INTR;
+		vcpu->stat.signal_exits++;
+		return -EINTR;
+	}
+
+	if (ti_work & _TIF_NEED_RESCHED) {
+		srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
+		schedule();
+		vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
+	}
+
+	if (ti_work & _TIF_PATCH_PENDING) {
+		srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
+		klp_update_patch_state(current);
+		vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
+	}
+
+	if (ti_work & _TIF_NOTIFY_RESUME) {
+		srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(NULL);
+		vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
+	}
+
+	/* Any extra architecture specific work */
+	return arch_exit_to_guestmode_work(kvm, vcpu, ti_work);
+}
+EXPORT_SYMBOL_GPL(core_exit_to_guestmode_work);
+#endif


