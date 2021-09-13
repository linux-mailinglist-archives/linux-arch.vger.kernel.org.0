Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF33409DCC
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 22:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348022AbhIMUGK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 16:06:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:38692 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347852AbhIMUFx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Sep 2021 16:05:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307336380"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="307336380"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643925"
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
Subject: [RFC PATCH 08/13] x86/process/64: Clean up uintr task fork and exit paths
Date:   Mon, 13 Sep 2021 13:01:27 -0700
Message-Id: <20210913200132.3396598-9-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The user interrupt MSRs and the user interrupt state is task specific.
During task fork and exit clear the task state, clear the MSRs and
dereference the shared resources.

Some of the memory resources like the UPID are referenced in the file
descriptor and could be in use while the uintr_fd is still valid.
Instead of freeing up  the UPID just dereference it.  Eventually when
every user releases the reference the memory resource will be freed up.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/uintr.h |  3 ++
 arch/x86/kernel/fpu/core.c   |  9 ++++++
 arch/x86/kernel/process.c    |  9 ++++++
 arch/x86/kernel/uintr_core.c | 55 ++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/arch/x86/include/asm/uintr.h b/arch/x86/include/asm/uintr.h
index f7ccb67014b8..cef4dd81d40e 100644
--- a/arch/x86/include/asm/uintr.h
+++ b/arch/x86/include/asm/uintr.h
@@ -8,12 +8,15 @@ bool uintr_arch_enabled(void);
 int do_uintr_register_handler(u64 handler);
 int do_uintr_unregister_handler(void);
 
+void uintr_free(struct task_struct *task);
+
 /* TODO: Inline the context switch related functions */
 void switch_uintr_prepare(struct task_struct *prev);
 void switch_uintr_return(void);
 
 #else /* !CONFIG_X86_USER_INTERRUPTS */
 
+static inline void uintr_free(struct task_struct *task) {}
 static inline void switch_uintr_prepare(struct task_struct *prev) {}
 static inline void switch_uintr_return(void) {}
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index e30588bf7ce9..c0a54f7aaa2a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -260,6 +260,7 @@ int fpu_clone(struct task_struct *dst)
 {
 	struct fpu *src_fpu = &current->thread.fpu;
 	struct fpu *dst_fpu = &dst->thread.fpu;
+	struct uintr_state *uintr_state;
 
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
@@ -284,6 +285,14 @@ int fpu_clone(struct task_struct *dst)
 
 	else
 		save_fpregs_to_fpstate(dst_fpu);
+
+	/* UINTR state is not expected to be inherited (in the current design). */
+	if (static_cpu_has(X86_FEATURE_UINTR)) {
+		uintr_state = get_xsave_addr(&dst_fpu->state.xsave, XFEATURE_UINTR);
+		if (uintr_state)
+			memset(uintr_state, 0, sizeof(*uintr_state));
+	}
+
 	fpregs_unlock();
 
 	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..83677f76bd7b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -26,6 +26,7 @@
 #include <linux/elf-randomize.h>
 #include <trace/events/power.h>
 #include <linux/hw_breakpoint.h>
+#include <asm/uintr.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
 #include <linux/uaccess.h>
@@ -87,6 +88,12 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
+
+#ifdef CONFIG_X86_USER_INTERRUPTS
+	/* User Interrupt state is unique for each task */
+	dst->thread.ui_recv = NULL;
+#endif
+
 	return fpu_clone(dst);
 }
 
@@ -103,6 +110,8 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
+	uintr_free(tsk);
+
 	fpu__drop(fpu);
 }
 
diff --git a/arch/x86/kernel/uintr_core.c b/arch/x86/kernel/uintr_core.c
index 7a29888050ad..a2a13f890139 100644
--- a/arch/x86/kernel/uintr_core.c
+++ b/arch/x86/kernel/uintr_core.c
@@ -313,3 +313,58 @@ void switch_uintr_return(void)
 			apic->send_IPI_self(UINTR_NOTIFICATION_VECTOR);
 	}
 }
+
+/*
+ * This should only be called from exit_thread().
+ * exit_thread() can happen in current context when the current thread is
+ * exiting or it can happen for a new thread that is being created.
+ * For new threads is_uintr_receiver() should fail.
+ */
+void uintr_free(struct task_struct *t)
+{
+	struct uintr_receiver *ui_recv;
+	struct fpu *fpu;
+
+	if (!static_cpu_has(X86_FEATURE_UINTR) || !is_uintr_receiver(t))
+		return;
+
+	if (WARN_ON_ONCE(t != current))
+		return;
+
+	fpu = &t->thread.fpu;
+
+	fpregs_lock();
+
+	if (fpregs_state_valid(fpu, smp_processor_id())) {
+		wrmsrl(MSR_IA32_UINTR_MISC, 0ULL);
+		wrmsrl(MSR_IA32_UINTR_PD, 0ULL);
+		wrmsrl(MSR_IA32_UINTR_RR, 0ULL);
+		wrmsrl(MSR_IA32_UINTR_STACKADJUST, 0ULL);
+		wrmsrl(MSR_IA32_UINTR_HANDLER, 0ULL);
+	} else {
+		struct uintr_state *p;
+
+		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_UINTR);
+		if (p) {
+			p->handler = 0;
+			p->uirr = 0;
+			p->upid_addr = 0;
+			p->stack_adjust = 0;
+			p->uinv = 0;
+		}
+	}
+
+	/* Check: Can a thread be context switched while it is exiting? */
+	ui_recv = t->thread.ui_recv;
+
+	/*
+	 * Suppress notifications so that no further interrupts are
+	 * generated based on this UPID.
+	 */
+	set_bit(UPID_SN, (unsigned long *)&ui_recv->upid_ctx->upid->nc.status);
+	put_upid_ref(ui_recv->upid_ctx);
+	kfree(ui_recv);
+	t->thread.ui_recv = NULL;
+
+	fpregs_unlock();
+}
-- 
2.33.0

