Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2C170700
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 19:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBZSFy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 13:05:54 -0500
Received: from foss.arm.com ([217.140.110.172]:40176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbgBZSFy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 13:05:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 081814B2;
        Wed, 26 Feb 2020 10:05:53 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9332A3F881;
        Wed, 26 Feb 2020 10:05:51 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 10/19] arm64: mte: Handle synchronous and asynchronous tag check faults
Date:   Wed, 26 Feb 2020 18:05:17 +0000
Message-Id: <20200226180526.3272848-11-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226180526.3272848-1-catalin.marinas@arm.com>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

The Memory Tagging Extension has two modes of notifying a tag check
fault at EL0, configurable through the SCTLR_EL1.TCF0 field:

1. Synchronous raising of a Data Abort exception with DFSC 17.
2. Asynchronous setting of a cumulative bit in TFSRE0_EL1.

Add the exception handler for the synchronous exception and handling of
the asynchronous TFSRE0_EL1.TF0 bit setting via a new TIF flag in
do_notify_resume().

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Notes:
    v2:
    - Clear PSTATE.TCO on exception entry (automatically set by the hardware).
    - On syscall entry, for asynchronous tag check faults from user space,
      generate the signal early via syscall restarting.
    - Before context switch, save any potential async tag check fault
      generated by the kernel to the TIF flag (this follows an architecture
      update where the uaccess routines use the TCF0 mode).
    - Moved the flush_mte_state() and mte_thread_switch() function to a new
      mte.c file.

 arch/arm64/include/asm/mte.h         | 14 +++++++++++
 arch/arm64/include/asm/thread_info.h |  4 ++-
 arch/arm64/kernel/Makefile           |  1 +
 arch/arm64/kernel/entry.S            | 27 ++++++++++++++++++++
 arch/arm64/kernel/mte.c              | 37 ++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c          |  3 +++
 arch/arm64/kernel/signal.c           |  8 ++++++
 arch/arm64/kernel/syscall.c          | 10 ++++++++
 arch/arm64/mm/fault.c                |  9 ++++++-
 9 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kernel/mte.c

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 64e814273659..0d7f7ca07ee6 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -4,8 +4,22 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/sched.h>
+
 /* Memory Tagging API */
 int mte_memcmp_pages(const void *page1_addr, const void *page2_addr);
 
+#ifdef CONFIG_ARM64_MTE
+void flush_mte_state(void);
+void mte_thread_switch(struct task_struct *next);
+#else
+static inline void flush_mte_state(void)
+{
+}
+static inline void mte_thread_switch(struct task_struct *next)
+{
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_MTE_H  */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index f0cec4160136..f759a0215a71 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -63,6 +63,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
+#define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
 #define TIF_NOHZ		7
 #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
@@ -93,10 +94,11 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 #define _TIF_SVE		(1 << TIF_SVE)
+#define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-				 _TIF_UPROBE | _TIF_FSCHECK)
+				 _TIF_UPROBE | _TIF_FSCHECK | _TIF_MTE_ASYNC_FAULT)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index fc6488660f64..d4a378bc0a60 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
+obj-$(CONFIG_ARM64_MTE)			+= mte.o
 
 obj-y					+= vdso/ probes/
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 9461d812ae27..9338b340e869 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -144,6 +144,22 @@ alternative_cb_end
 #endif
 	.endm
 
+	/* Check for MTE asynchronous tag check faults */
+	.macro check_mte_async_tcf, flgs, tmp
+#ifdef CONFIG_ARM64_MTE
+alternative_if_not ARM64_MTE
+	b	1f
+alternative_else_nop_endif
+	mrs_s	\tmp, SYS_TFSRE0_EL1
+	tbz	\tmp, #SYS_TFSR_EL1_TF0_SHIFT, 1f
+	/* Asynchronous TCF occurred at EL0, set the TI flag */
+	orr	\flgs, \flgs, #_TIF_MTE_ASYNC_FAULT
+	str	\flgs, [tsk, #TSK_TI_FLAGS]
+	msr_s	SYS_TFSRE0_EL1, xzr
+1:
+#endif
+	.endm
+
 	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
@@ -175,6 +191,8 @@ alternative_cb_end
 	ldr	x19, [tsk, #TSK_TI_FLAGS]
 	disable_step_tsk x19, x20
 
+	/* Check for asynchronous tag check faults in user space */
+	check_mte_async_tcf x19, x22
 	apply_ssbd 1, x22, x23
 
 	.else
@@ -242,6 +260,13 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	str	x20, [sp, #S_PMR_SAVE]
 alternative_else_nop_endif
 
+	/* Re-enable tag checking (TCO set on exception entry) */
+#ifdef CONFIG_ARM64_MTE
+alternative_if ARM64_MTE
+	SET_PSTATE_TCO(0)
+alternative_else_nop_endif
+#endif
+
 	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
@@ -738,6 +763,8 @@ work_pending:
  */
 ret_to_user:
 	disable_daif
+	/* Check for asynchronous tag check faults in the uaccess routines */
+	check_mte_async_tcf x1, x2
 	gic_prio_kentry_setup tmp=x3
 	ldr	x1, [tsk, #TSK_TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
new file mode 100644
index 000000000000..0c2c900fa01c
--- /dev/null
+++ b/arch/arm64/kernel/mte.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+
+#include <linux/thread_info.h>
+
+#include <asm/cpufeature.h>
+#include <asm/mte.h>
+#include <asm/sysreg.h>
+
+void flush_mte_state(void)
+{
+	if (!system_supports_mte())
+		return;
+
+	/* clear any pending asynchronous tag fault */
+	clear_thread_flag(TIF_MTE_ASYNC_FAULT);
+}
+
+void mte_thread_switch(struct task_struct *next)
+{
+	u64 tfsr;
+
+	if (!system_supports_mte())
+		return;
+
+	/*
+	 * Check for asynchronous tag check faults from the uaccess routines
+	 * before switching to the next thread.
+	 */
+	tfsr = read_sysreg_s(SYS_TFSRE0_EL1);
+	if (tfsr & SYS_TFSR_EL1_TF0) {
+		set_thread_flag(TIF_MTE_ASYNC_FAULT);
+		write_sysreg_s(0, SYS_TFSRE0_EL1);
+	}
+}
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index bbb0f0c145f6..1b732150f51a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -50,6 +50,7 @@
 #include <asm/exec.h>
 #include <asm/fpsimd.h>
 #include <asm/mmu_context.h>
+#include <asm/mte.h>
 #include <asm/processor.h>
 #include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
@@ -323,6 +324,7 @@ void flush_thread(void)
 	tls_thread_flush();
 	flush_ptrace_hw_breakpoint(current);
 	flush_tagged_addr_state();
+	flush_mte_state();
 }
 
 void release_thread(struct task_struct *dead_task)
@@ -507,6 +509,7 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	uao_thread_switch(next);
 	ptrauth_thread_switch(next);
 	ssbs_thread_switch(next);
+	mte_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 339882db5a91..e377d77c065e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -732,6 +732,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->regs[29] = (unsigned long)&user->next_frame->fp;
 	regs->pc = (unsigned long)ka->sa.sa_handler;
 
+	/* TCO (Tag Check Override) always cleared for signal handlers */
+	regs->pstate &= ~PSR_TCO_BIT;
+
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
 	else
@@ -923,6 +926,11 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);
 
+			if (thread_flags & _TIF_MTE_ASYNC_FAULT) {
+				clear_thread_flag(TIF_MTE_ASYNC_FAULT);
+				force_signal_inject(SIGSEGV, SEGV_MTEAERR, 0);
+			}
+
 			if (thread_flags & _TIF_SIGPENDING)
 				do_signal(regs);
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index a12c0c88d345..db25f5d6a07c 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -102,6 +102,16 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	local_daif_restore(DAIF_PROCCTX);
 	user_exit();
 
+	if (system_supports_mte() && (flags & _TIF_MTE_ASYNC_FAULT)) {
+		/*
+		 * Process the asynchronous tag check fault before the actual
+		 * syscall. do_notify_resume() will send a signal to userspace
+		 * before the syscall is restarted.
+		 */
+		regs->regs[0] = -ERESTARTNOINTR;
+		return;
+	}
+
 	if (has_syscall_work(flags)) {
 		/* set default errno for user-issued syscall(-1) */
 		if (scno == NO_SYSCALL)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 85566d32958f..cf2bf625ab92 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -660,6 +660,13 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	return 0;
 }
 
+static int do_tag_check_fault(unsigned long addr, unsigned int esr,
+			      struct pt_regs *regs)
+{
+	do_bad_area(addr, esr, regs);
+	return 0;
+}
+
 static const struct fault_info fault_info[] = {
 	{ do_bad,		SIGKILL, SI_KERNEL,	"ttbr address size fault"	},
 	{ do_bad,		SIGKILL, SI_KERNEL,	"level 1 address size fault"	},
@@ -678,7 +685,7 @@ static const struct fault_info fault_info[] = {
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
 	{ do_sea,		SIGBUS,  BUS_OBJERR,	"synchronous external abort"	},
-	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 17"			},
+	{ do_tag_check_fault,	SIGSEGV, SEGV_MTESERR,	"synchronous tag check fault"	},
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 18"			},
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 19"			},
 	{ do_sea,		SIGKILL, SI_KERNEL,	"level 0 (translation table walk)"	},
