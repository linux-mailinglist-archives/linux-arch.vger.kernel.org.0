Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D4409DC5
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 22:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347982AbhIMUGI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 16:06:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:38689 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347850AbhIMUFw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Sep 2021 16:05:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307336375"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="307336375"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643922"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2021 13:04:31 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 07/13] x86/process/64: Add uintr task context switch support
Date:   Mon, 13 Sep 2021 13:01:26 -0700
Message-Id: <20210913200132.3396598-8-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

User interrupt state is saved and restored using xstate supervisor
feature support. This includes the MSR state and the User Interrupt Flag
(UIF) value.

During context switch update the UPID for a uintr task to reflect the
current state of the task; namely whether the task should receive
interrupt notifications and which cpu the task is currently running on.

XSAVES clears the notification vector (UINV) in the MISC MSR to prevent
interrupts from being recognized in the UIRR MSR while the task is being
context switched. The UINV is restored back when the kernel does an
XRSTORS.

However, this conflicts with the kernel's lazy restore optimization
which skips an XRSTORS if the kernel is scheduling the same user task
back and the underlying MSR state hasn't been modified. Special handling
is needed for a uintr task in the context switch path to keep using this
optimization.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/entry-common.h |  4 ++
 arch/x86/include/asm/uintr.h        |  9 ++++
 arch/x86/kernel/fpu/core.c          |  8 +++
 arch/x86/kernel/process_64.c        |  4 ++
 arch/x86/kernel/uintr_core.c        | 75 +++++++++++++++++++++++++++++
 5 files changed, 100 insertions(+)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 14ebd2196569..4e6c4d0912a5 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -8,6 +8,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
 #include <asm/fpu/api.h>
+#include <asm/uintr.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
 static __always_inline void arch_check_user_regs(struct pt_regs *regs)
@@ -57,6 +58,9 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
 		switch_fpu_return();
 
+	if (static_cpu_has(X86_FEATURE_UINTR))
+		switch_uintr_return();
+
 #ifdef CONFIG_COMPAT
 	/*
 	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
diff --git a/arch/x86/include/asm/uintr.h b/arch/x86/include/asm/uintr.h
index 4f35bd8bd4e0..f7ccb67014b8 100644
--- a/arch/x86/include/asm/uintr.h
+++ b/arch/x86/include/asm/uintr.h
@@ -8,6 +8,15 @@ bool uintr_arch_enabled(void);
 int do_uintr_register_handler(u64 handler);
 int do_uintr_unregister_handler(void);
 
+/* TODO: Inline the context switch related functions */
+void switch_uintr_prepare(struct task_struct *prev);
+void switch_uintr_return(void);
+
+#else /* !CONFIG_X86_USER_INTERRUPTS */
+
+static inline void switch_uintr_prepare(struct task_struct *prev) {}
+static inline void switch_uintr_return(void) {}
+
 #endif /* CONFIG_X86_USER_INTERRUPTS */
 
 #endif /* _ASM_X86_UINTR_H */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 7ada7bd03a32..e30588bf7ce9 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -95,6 +95,14 @@ EXPORT_SYMBOL(irq_fpu_usable);
  * over the place.
  *
  * FXSAVE and all XSAVE variants preserve the FPU register state.
+ *
+ * When XSAVES is called with XFEATURE_UINTR enabled it
+ * saves the FPU state and clears the interrupt notification
+ * vector byte of the MISC_MSR [bits 39:32]. This is required
+ * to stop detecting additional User Interrupts after we
+ * have saved the FPU state. Before going back to userspace
+ * we would correct this and only program the byte that was
+ * cleared.
  */
 void save_fpregs_to_fpstate(struct fpu *fpu)
 {
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ec0d836a13b1..62b82137db9c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -53,6 +53,7 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
 #include <asm/resctrl.h>
+#include <asm/uintr.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #ifdef CONFIG_IA32_EMULATION
@@ -565,6 +566,9 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
 		     this_cpu_read(hardirq_stack_inuse));
 
+	if (static_cpu_has(X86_FEATURE_UINTR))
+		switch_uintr_prepare(prev_p);
+
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
 		switch_fpu_prepare(prev_fpu, cpu);
 
diff --git a/arch/x86/kernel/uintr_core.c b/arch/x86/kernel/uintr_core.c
index 2c6042a6840a..7a29888050ad 100644
--- a/arch/x86/kernel/uintr_core.c
+++ b/arch/x86/kernel/uintr_core.c
@@ -238,3 +238,78 @@ int do_uintr_register_handler(u64 handler)
 
 	return 0;
 }
+
+/* Suppress notifications since this task is being context switched out */
+void switch_uintr_prepare(struct task_struct *prev)
+{
+	struct uintr_upid *upid;
+
+	if (is_uintr_receiver(prev)) {
+		upid = prev->thread.ui_recv->upid_ctx->upid;
+		set_bit(UPID_SN, (unsigned long *)&upid->nc.status);
+	}
+}
+
+/*
+ * Do this right before we are going back to userspace after the FPU has been
+ * reloaded i.e. TIF_NEED_FPU_LOAD is clear.
+ * Called from arch_exit_to_user_mode_prepare() with interrupts disabled.
+ */
+void switch_uintr_return(void)
+{
+	struct uintr_upid *upid;
+	u64 misc_msr;
+
+	if (is_uintr_receiver(current)) {
+		/*
+		 * The XSAVES instruction clears the UINTR notification
+		 * vector(UINV) in the UINT_MISC MSR when user context gets
+		 * saved. Before going back to userspace we need to restore the
+		 * notification vector. XRSTORS would automatically restore the
+		 * notification but we can't be sure that XRSTORS will always
+		 * be called when going back to userspace. Also if XSAVES gets
+		 * called twice the UINV stored in the Xstate buffer will be
+		 * overwritten. Threfore, before going back to userspace we
+		 * always check if the UINV is set and reprogram if needed.
+		 *
+		 * Alternatively, we could combine this with
+		 * switch_fpu_return() and program the MSR whenever we are
+		 * skipping the XRSTORS. We need special precaution to make
+		 * sure the UINV value in the XSTATE buffer doesn't get
+		 * overwritten by calling XSAVES twice.
+		 */
+		WARN_ON_ONCE(test_thread_flag(TIF_NEED_FPU_LOAD));
+
+		/* Modify only the relevant bits of the MISC MSR */
+		rdmsrl(MSR_IA32_UINTR_MISC, misc_msr);
+		if (!(misc_msr & GENMASK_ULL(39, 32))) {
+			misc_msr |= (u64)UINTR_NOTIFICATION_VECTOR << 32;
+			wrmsrl(MSR_IA32_UINTR_MISC, misc_msr);
+		}
+
+		/*
+		 * It is necessary to clear the SN bit after we set UINV and
+		 * NDST to avoid incorrect interrupt routing.
+		 */
+		upid = current->thread.ui_recv->upid_ctx->upid;
+		upid->nc.ndst = cpu_to_ndst(smp_processor_id());
+		clear_bit(UPID_SN, (unsigned long *)&upid->nc.status);
+
+		/*
+		 * Interrupts might have accumulated in the UPID while the
+		 * thread was preempted. In this case invoke the hardware
+		 * detection sequence manually by sending a self IPI with UINV.
+		 * Since UINV is set and SN is cleared, any new UINTR
+		 * notifications due to the self IPI or otherwise would result
+		 * in the hardware updating the UIRR directly.
+		 * No real interrupt would be generated as a result of this.
+		 *
+		 * The alternative is to atomically read and clear the UPID and
+		 * program the UIRR. In that case the kernel would need to
+		 * carefully manage the race with the hardware if the UPID gets
+		 * updated after the read.
+		 */
+		if (READ_ONCE(upid->puir))
+			apic->send_IPI_self(UINTR_NOTIFICATION_VECTOR);
+	}
+}
-- 
2.33.0

