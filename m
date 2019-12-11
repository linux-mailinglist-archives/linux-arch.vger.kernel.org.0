Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B2711BBF0
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 19:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfLKSlA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 13:41:00 -0500
Received: from foss.arm.com ([217.140.110.172]:43162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbfLKSlA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:41:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 508DC1476;
        Wed, 11 Dec 2019 10:40:59 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC1E33F6CF;
        Wed, 11 Dec 2019 10:40:57 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 13/22] arm64: mte: Handle synchronous and asynchronous tag check faults
Date:   Wed, 11 Dec 2019 18:40:18 +0000
Message-Id: <20191211184027.20130-14-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
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
 arch/arm64/include/asm/thread_info.h |  4 +++-
 arch/arm64/kernel/entry.S            | 17 +++++++++++++++++
 arch/arm64/kernel/process.c          |  7 +++++++
 arch/arm64/kernel/signal.c           |  8 ++++++++
 arch/arm64/mm/fault.c                |  9 ++++++++-
 5 files changed, 43 insertions(+), 2 deletions(-)

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
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7c6a0a41676f..c221a539e61d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -144,6 +144,22 @@ alternative_cb_end
 #endif
 	.endm
 
+	// Check for MTE asynchronous tag check faults
+	.macro check_mte_async_tcf, flgs, tmp
+#ifdef CONFIG_ARM64_MTE
+alternative_if_not ARM64_MTE
+	b	1f
+alternative_else_nop_endif
+	mrs_s	\tmp, SYS_TFSRE0_EL1
+	tbz	\tmp, #SYS_TFSR_EL1_TF0_SHIFT, 1f
+	// Asynchronous TCF occurred at EL0, set the TI flag
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
@@ -171,6 +187,7 @@ alternative_cb_end
 	ldr	x19, [tsk, #TSK_TI_FLAGS]	// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
 
+	check_mte_async_tcf x19, x22
 	apply_ssbd 1, x22, x23
 
 	.else
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 71f788cd2b18..dd98d539894e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -317,12 +317,19 @@ static void flush_tagged_addr_state(void)
 		clear_thread_flag(TIF_TAGGED_ADDR);
 }
 
+static void flush_mte_state(void)
+{
+	if (system_supports_mte())
+		clear_thread_flag(TIF_MTE_ASYNC_FAULT);
+}
+
 void flush_thread(void)
 {
 	fpsimd_flush_thread();
 	tls_thread_flush();
 	flush_ptrace_hw_breakpoint(current);
 	flush_tagged_addr_state();
+	flush_mte_state();
 }
 
 void release_thread(struct task_struct *dead_task)
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index dd2cdc0d5be2..41fae64af82a 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -730,6 +730,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->regs[29] = (unsigned long)&user->next_frame->fp;
 	regs->pc = (unsigned long)ka->sa.sa_handler;
 
+	/* TCO (Tag Check Override) always cleared for signal handlers */
+	regs->pstate &= ~PSR_TCO_BIT;
+
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
 	else
@@ -921,6 +924,11 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);
 
+			if (thread_flags & _TIF_MTE_ASYNC_FAULT) {
+				clear_thread_flag(TIF_MTE_ASYNC_FAULT);
+				force_signal_inject(SIGSEGV, SEGV_MTEAERR, 0);
+			}
+
 			if (thread_flags & _TIF_SIGPENDING)
 				do_signal(regs);
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 077b02a2d4d3..ef3bfa2bf2b1 100644
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
