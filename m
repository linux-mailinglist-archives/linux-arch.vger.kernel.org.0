Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43A225D66A
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 12:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgIDKfy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 06:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbgIDKbL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Sep 2020 06:31:11 -0400
Received: from localhost.localdomain (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 788AF20C56;
        Fri,  4 Sep 2020 10:30:45 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 06/29] arm64: mte: Handle synchronous and asynchronous tag check faults
Date:   Fri,  4 Sep 2020 11:30:06 +0100
Message-Id: <20200904103029.32083-7-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200904103029.32083-1-catalin.marinas@arm.com>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
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

On a tag check failure in user-space, whether synchronous or
asynchronous, a SIGSEGV will be raised on the faulting thread.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v8:
    - print_pstate() shows the status of the TCO bit.
    
    v6:
    - Fix sparse warning on the 0 used as pointer.
    
    v4:
    - Use send_signal_fault() instead of fault_signal_inject() for
      asynchronous tag check faults as execution can continue even if this
      signal is masked.
    - Add DSB ISH prior to writing TFSRE0_EL1 in the clear_mte_async_tcf
      macro.
    - Move clear_mte_async_tcf just after returning to user since
      do_notify_resume() may still cause async tag faults via do_signal().
    
    v3:
    - Asynchronous tag check faults during the uaccess routines in the
      kernel are ignored.
    - Fix check_mte_async_tcf calling site as it expects the first argument
      to be the thread flags.
    - Move the mte_thread_switch() definition and call to a later patch as
      this became empty with the removal of async uaccess checking.
    - Add dsb() and clearing of TFSRE0_EL1 in flush_mte_state(), in case
      execve() triggered a asynchronous tag check fault.
    - Clear TIF_MTE_ASYNC_FAULT in arch_dup_task_struct() so that the child
      does not inherit any pending tag fault in the parent.
    
    v2:
    - Clear PSTATE.TCO on exception entry (automatically set by the hardware).
    - On syscall entry, for asynchronous tag check faults from user space,
      generate the signal early via syscall restarting.
    - Before context switch, save any potential async tag check fault
      generated by the kernel to the TIF flag (this follows an architecture
      update where the uaccess routines use the TCF0 mode).
    - Moved the flush_mte_state() and mte_thread_switch() function to a new
      mte.c file.

 arch/arm64/include/asm/mte.h         | 23 +++++++++++++++++
 arch/arm64/include/asm/thread_info.h |  4 ++-
 arch/arm64/kernel/Makefile           |  1 +
 arch/arm64/kernel/entry.S            | 37 ++++++++++++++++++++++++++++
 arch/arm64/kernel/mte.c              | 21 ++++++++++++++++
 arch/arm64/kernel/process.c          |  8 +++++-
 arch/arm64/kernel/signal.c           |  9 +++++++
 arch/arm64/kernel/syscall.c          | 10 ++++++++
 arch/arm64/mm/fault.c                |  9 ++++++-
 9 files changed, 119 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/mte.h
 create mode 100644 arch/arm64/kernel/mte.c

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
new file mode 100644
index 000000000000..a0bf310da74b
--- /dev/null
+++ b/arch/arm64/include/asm/mte.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_MTE_H
+#define __ASM_MTE_H
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_ARM64_MTE
+
+void flush_mte_state(void);
+
+#else
+
+static inline void flush_mte_state(void)
+{
+}
+
+#endif
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_MTE_H  */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 5e784e16ee89..1fbab854a51b 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -67,6 +67,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
+#define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
 #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
@@ -96,10 +97,11 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
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
index a561cbb91d4d..5fb9b728459b 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_SHADOW_CALL_STACK)		+= scs.o
+obj-$(CONFIG_ARM64_MTE)			+= mte.o
 
 obj-y					+= vdso/ probes/
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 55af8b504b65..ff34461524d4 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -149,6 +149,32 @@ alternative_cb_end
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
+	/* Asynchronous TCF occurred for TTBR0 access, set the TI flag */
+	orr	\flgs, \flgs, #_TIF_MTE_ASYNC_FAULT
+	str	\flgs, [tsk, #TSK_TI_FLAGS]
+	msr_s	SYS_TFSRE0_EL1, xzr
+1:
+#endif
+	.endm
+
+	/* Clear the MTE asynchronous tag check faults */
+	.macro clear_mte_async_tcf
+#ifdef CONFIG_ARM64_MTE
+alternative_if ARM64_MTE
+	dsb	ish
+	msr_s	SYS_TFSRE0_EL1, xzr
+alternative_else_nop_endif
+#endif
+	.endm
+
 	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
@@ -182,6 +208,8 @@ alternative_cb_end
 	ldr	x19, [tsk, #TSK_TI_FLAGS]
 	disable_step_tsk x19, x20
 
+	/* Check for asynchronous tag check faults in user space */
+	check_mte_async_tcf x19, x22
 	apply_ssbd 1, x22, x23
 
 	ptrauth_keys_install_kernel tsk, x20, x22, x23
@@ -233,6 +261,13 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
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
@@ -744,6 +779,8 @@ SYM_CODE_START_LOCAL(ret_to_user)
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
 finish_ret_to_user:
+	/* Ignore asynchronous tag check faults in the uaccess routines */
+	clear_mte_async_tcf
 	enable_step_tsk x1, x2
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
new file mode 100644
index 000000000000..032016823957
--- /dev/null
+++ b/arch/arm64/kernel/mte.c
@@ -0,0 +1,21 @@
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
+	dsb(ish);
+	write_sysreg_s(0, SYS_TFSRE0_EL1);
+	clear_thread_flag(TIF_MTE_ASYNC_FAULT);
+}
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f1804496b935..a49028efab68 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -52,6 +52,7 @@
 #include <asm/exec.h>
 #include <asm/fpsimd.h>
 #include <asm/mmu_context.h>
+#include <asm/mte.h>
 #include <asm/processor.h>
 #include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
@@ -239,7 +240,7 @@ static void print_pstate(struct pt_regs *regs)
 		const char *btype_str = btypes[(pstate & PSR_BTYPE_MASK) >>
 					       PSR_BTYPE_SHIFT];
 
-		printk("pstate: %08llx (%c%c%c%c %c%c%c%c %cPAN %cUAO BTYPE=%s)\n",
+		printk("pstate: %08llx (%c%c%c%c %c%c%c%c %cPAN %cUAO %cTCO BTYPE=%s)\n",
 			pstate,
 			pstate & PSR_N_BIT ? 'N' : 'n',
 			pstate & PSR_Z_BIT ? 'Z' : 'z',
@@ -251,6 +252,7 @@ static void print_pstate(struct pt_regs *regs)
 			pstate & PSR_F_BIT ? 'F' : 'f',
 			pstate & PSR_PAN_BIT ? '+' : '-',
 			pstate & PSR_UAO_BIT ? '+' : '-',
+			pstate & PSR_TCO_BIT ? '+' : '-',
 			btype_str);
 	}
 }
@@ -336,6 +338,7 @@ void flush_thread(void)
 	tls_thread_flush();
 	flush_ptrace_hw_breakpoint(current);
 	flush_tagged_addr_state();
+	flush_mte_state();
 }
 
 void release_thread(struct task_struct *dead_task)
@@ -368,6 +371,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	dst->thread.sve_state = NULL;
 	clear_tsk_thread_flag(dst, TIF_SVE);
 
+	/* clear any pending asynchronous tag fault raised by the parent */
+	clear_tsk_thread_flag(dst, TIF_MTE_ASYNC_FAULT);
+
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 3b4f31f35e45..b27e87572ce3 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -748,6 +748,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		regs->pstate |= PSR_BTYPE_C;
 	}
 
+	/* TCO (Tag Check Override) always cleared for signal handlers */
+	regs->pstate &= ~PSR_TCO_BIT;
+
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
 	else
@@ -932,6 +935,12 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);
 
+			if (thread_flags & _TIF_MTE_ASYNC_FAULT) {
+				clear_thread_flag(TIF_MTE_ASYNC_FAULT);
+				send_sig_fault(SIGSEGV, SEGV_MTEAERR,
+					       (void __user *)NULL, current);
+			}
+
 			if (thread_flags & _TIF_SIGPENDING)
 				do_signal(regs);
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 5f0c04863d2c..e4c0dadf0d92 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -123,6 +123,16 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
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
 		/*
 		 * The de-facto standard way to skip a system call using ptrace
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f07333e86c2f..a3bd189602df 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -641,6 +641,13 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
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
@@ -659,7 +666,7 @@ static const struct fault_info fault_info[] = {
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
 	{ do_sea,		SIGBUS,  BUS_OBJERR,	"synchronous external abort"	},
-	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 17"			},
+	{ do_tag_check_fault,	SIGSEGV, SEGV_MTESERR,	"synchronous tag check fault"	},
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 18"			},
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 19"			},
 	{ do_sea,		SIGKILL, SI_KERNEL,	"level 0 (translation table walk)"	},
