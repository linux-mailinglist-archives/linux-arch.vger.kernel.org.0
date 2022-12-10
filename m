Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E536648FEC
	for <lists+linux-arch@lfdr.de>; Sat, 10 Dec 2022 18:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLJRNZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Dec 2022 12:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiLJRNG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Dec 2022 12:13:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C70913F02;
        Sat, 10 Dec 2022 09:12:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD5A60C75;
        Sat, 10 Dec 2022 17:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E51C433D2;
        Sat, 10 Dec 2022 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670692374;
        bh=l9m3rps/VCz64Ik6S/MTW1s+UeVEyvGvxH2IyL25XOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oc+4tU/3EGth90DHpQfdLhGMNCNP4xXG+RNOTcJ7eQLXMZSiqQuYzHxdA5C4fDSNv
         PJBYHmdGcF9fT4e04SItuN696ShP6SSdOHbbu411b9eBHyg9CKJt3byL+zabja0S7A
         itgCN8bdQ3t1AcZUj5QeiB/P/Hwxa34PIZfIt/6ut221DxWn8ykGJw2kkrZt5539Ra
         M2QJyrdMhQzVSz/ZzTDuPpQ7/hFYXXasb6h136nXZ+ZUJZY//MTObB7Usqf7h0y84e
         /y8esUsCDwA3UIN0qTEkG63h8WrGLN4Qg6k7VFVWTvWjN4zRJvCwe5GR14+q4pydeB
         mffTcfjut8NsQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk,
        bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Subject: [PATCH -next V11 4/7] riscv: entry: Convert to generic entry
Date:   Sat, 10 Dec 2022 12:11:38 -0500
Message-Id: <20221210171141.1120123-5-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221210171141.1120123-1-guoren@kernel.org>
References: <20221210171141.1120123-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch converts riscv to use the generic entry infrastructure from
kernel/entry/*. The generic entry makes maintainers' work easier and
codes more elegant. Here are the changes:

 - More clear entry.S with handle_exception and ret_from_exception
 - Get rid of complex custom signal implementation
 - Move syscall procedure from assembly to C, which is much more
   readable.
 - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
 - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
 - Use the standard preemption code instead of custom

Suggested-by: Huacai Chen <chenhuacai@kernel.org>
Tested-by: Yipeng Zou <zouyipeng@huawei.com>
Tested-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
---
 arch/riscv/Kconfig                    |   1 +
 arch/riscv/include/asm/csr.h          |   1 -
 arch/riscv/include/asm/entry-common.h |   8 +
 arch/riscv/include/asm/ptrace.h       |  10 +-
 arch/riscv/include/asm/stacktrace.h   |   5 +
 arch/riscv/include/asm/syscall.h      |   6 +
 arch/riscv/include/asm/thread_info.h  |  13 +-
 arch/riscv/kernel/entry.S             | 252 ++++----------------------
 arch/riscv/kernel/irq.c               |  15 ++
 arch/riscv/kernel/ptrace.c            |  43 -----
 arch/riscv/kernel/signal.c            |  29 +--
 arch/riscv/kernel/sys_riscv.c         |  31 ++++
 arch/riscv/kernel/traps.c             |  82 +++++++--
 arch/riscv/mm/fault.c                 |  16 +-
 14 files changed, 200 insertions(+), 312 deletions(-)
 create mode 100644 arch/riscv/include/asm/entry-common.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 67ef08d33d3a..8e7510d8ea1f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -58,6 +58,7 @@ config RISCV
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP if MMU
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 0e571f6483d9..7c2b8cdb7b77 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -40,7 +40,6 @@
 #define SR_UXL		_AC(0x300000000, UL) /* XLEN mask for U-mode */
 #define SR_UXL_32	_AC(0x100000000, UL) /* XLEN = 32 for U-mode */
 #define SR_UXL_64	_AC(0x200000000, UL) /* XLEN = 64 for U-mode */
-#define SR_UXL_SHIFT	32
 #endif
 
 /* SATP flags */
diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
new file mode 100644
index 000000000000..1636ac2af28e
--- /dev/null
+++ b/arch/riscv/include/asm/entry-common.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_RISCV_ENTRY_COMMON_H
+#define _ASM_RISCV_ENTRY_COMMON_H
+
+#include <asm/stacktrace.h>
+
+#endif /* _ASM_RISCV_ENTRY_COMMON_H */
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index 6ecd461129d2..b5b0adcc85c1 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -53,6 +53,9 @@ struct pt_regs {
 	unsigned long orig_a0;
 };
 
+#define PTRACE_SYSEMU			0x1f
+#define PTRACE_SYSEMU_SINGLESTEP	0x20
+
 #ifdef CONFIG_64BIT
 #define REG_FMT "%016lx"
 #else
@@ -121,8 +124,6 @@ extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 			   unsigned long frame_pointer);
-int do_syscall_trace_enter(struct pt_regs *regs);
-void do_syscall_trace_exit(struct pt_regs *regs);
 
 /**
  * regs_get_register() - get register value from its offset
@@ -172,6 +173,11 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
 	return 0;
 }
 
+static inline int regs_irqs_disabled(struct pt_regs *regs)
+{
+	return !(regs->status & SR_PIE);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
index 3450c1912afd..f7e8ef2418b9 100644
--- a/arch/riscv/include/asm/stacktrace.h
+++ b/arch/riscv/include/asm/stacktrace.h
@@ -16,4 +16,9 @@ extern void notrace walk_stackframe(struct task_struct *task, struct pt_regs *re
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
 			   const char *loglvl);
 
+static inline bool on_thread_stack(void)
+{
+	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
+}
+
 #endif /* _ASM_RISCV_STACKTRACE_H */
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 384a63b86420..6c573f18030b 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -74,5 +74,11 @@ static inline int syscall_get_arch(struct task_struct *task)
 #endif
 }
 
+static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	return false;
+}
+
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
+asmlinkage void do_sys_ecall_u(struct pt_regs *regs);
 #endif	/* _ASM_RISCV_SYSCALL_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 67322f878e0d..7de4fb96f0b5 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -66,6 +66,7 @@ struct thread_info {
 	long			kernel_sp;	/* Kernel stack pointer */
 	long			user_sp;	/* User stack pointer */
 	int			cpu;
+	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
 };
 
 /*
@@ -88,26 +89,18 @@ struct thread_info {
  * - pending work-to-be-done flags are in lowest half-word
  * - other flags in upper half-word(s)
  */
-#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
 #define TIF_MEMDIE		5	/* is terminating due to OOM killer */
-#define TIF_SYSCALL_TRACEPOINT  6       /* syscall tracepoint instrumentation */
-#define TIF_SYSCALL_AUDIT	7	/* syscall auditing */
-#define TIF_SECCOMP		8	/* syscall secure computing */
 #define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
 #define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
 #define TIF_32BIT		11	/* compat-mode 32bit process */
 
-#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
-#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
-#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 
@@ -115,8 +108,4 @@ struct thread_info {
 	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
 
-#define _TIF_SYSCALL_WORK \
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT | \
-	 _TIF_SECCOMP)
-
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 32b2ddafedb0..b224dfecae40 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -14,11 +14,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/errata_list.h>
 
-#if !IS_ENABLED(CONFIG_PREEMPTION)
-.set resume_kernel, restore_all
-#endif
-
-ENTRY(handle_exception)
+SYM_CODE_START(handle_exception)
 	/*
 	 * If coming from userspace, preserve the user thread pointer and load
 	 * the kernel thread pointer.  If we came from the kernel, the scratch
@@ -106,19 +102,8 @@ _save_context:
 .option norelax
 	la gp, __global_pointer$
 .option pop
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-	call __trace_hardirqs_off
-#endif
-
-#ifdef CONFIG_CONTEXT_TRACKING_USER
-	/* If previous state is in user mode, call user_exit_callable(). */
-	li   a0, SR_PP
-	and a0, s1, a0
-	bnez a0, skip_context_tracking
-	call user_exit_callable
-skip_context_tracking:
-#endif
+	move a0, sp /* pt_regs */
+	la ra, ret_from_exception
 
 	/*
 	 * MSB of cause differentiates between
@@ -126,134 +111,32 @@ skip_context_tracking:
 	 */
 	bge s4, zero, 1f
 
-	la ra, ret_from_exception
-
 	/* Handle interrupts */
-	move a0, sp /* pt_regs */
-	la a1, generic_handle_arch_irq
-	jr a1
+	tail do_riscv_irq
 1:
-	/*
-	 * Exceptions run with interrupts enabled or disabled depending on the
-	 * state of SR_PIE in m/sstatus.
-	 */
-	andi t0, s1, SR_PIE
-	beqz t0, 1f
-	/* kprobes, entered via ebreak, must have interrupts disabled. */
-	li t0, EXC_BREAKPOINT
-	beq s4, t0, 1f
-#ifdef CONFIG_TRACE_IRQFLAGS
-	call __trace_hardirqs_on
-#endif
-	csrs CSR_STATUS, SR_IE
-
-1:
-	la ra, ret_from_exception
-	/* Handle syscalls */
-	li t0, EXC_SYSCALL
-	beq s4, t0, handle_syscall
-
 	/* Handle other exceptions */
 	slli t0, s4, RISCV_LGPTR
 	la t1, excp_vect_table
 	la t2, excp_vect_table_end
-	move a0, sp /* pt_regs */
 	add t0, t1, t0
 	/* Check if exception code lies within bounds */
-	bgeu t0, t2, 1f
+	bgeu t0, t2, 2f
 	REG_L t0, 0(t0)
 	jr t0
-1:
-	tail do_trap_unknown
-
-handle_syscall:
-#ifdef CONFIG_RISCV_M_MODE
-	/*
-	 * When running is M-Mode (no MMU config), MPIE does not get set.
-	 * As a result, we need to force enable interrupts here because
-	 * handle_exception did not do set SR_IE as it always sees SR_PIE
-	 * being cleared.
-	 */
-	csrs CSR_STATUS, SR_IE
-#endif
-#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING_USER)
-	/* Recover a0 - a7 for system calls */
-	REG_L a0, PT_A0(sp)
-	REG_L a1, PT_A1(sp)
-	REG_L a2, PT_A2(sp)
-	REG_L a3, PT_A3(sp)
-	REG_L a4, PT_A4(sp)
-	REG_L a5, PT_A5(sp)
-	REG_L a6, PT_A6(sp)
-	REG_L a7, PT_A7(sp)
-#endif
-	 /* save the initial A0 value (needed in signal handlers) */
-	REG_S a0, PT_ORIG_A0(sp)
-	/*
-	 * Advance SEPC to avoid executing the original
-	 * scall instruction on sret
-	 */
-	addi s2, s2, 0x4
-	REG_S s2, PT_EPC(sp)
-	/* Trace syscalls, but only if requested by the user. */
-	REG_L t0, TASK_TI_FLAGS(tp)
-	andi t0, t0, _TIF_SYSCALL_WORK
-	bnez t0, handle_syscall_trace_enter
-check_syscall_nr:
-	/* Check to make sure we don't jump to a bogus syscall number. */
-	li t0, __NR_syscalls
-	la s0, sys_ni_syscall
-	/*
-	 * Syscall number held in a7.
-	 * If syscall number is above allowed value, redirect to ni_syscall.
-	 */
-	bgeu a7, t0, 3f
-#ifdef CONFIG_COMPAT
-	REG_L s0, PT_STATUS(sp)
-	srli s0, s0, SR_UXL_SHIFT
-	andi s0, s0, (SR_UXL >> SR_UXL_SHIFT)
-	li t0, (SR_UXL_32 >> SR_UXL_SHIFT)
-	sub t0, s0, t0
-	bnez t0, 1f
-
-	/* Call compat_syscall */
-	la s0, compat_sys_call_table
-	j 2f
-1:
-#endif
-	/* Call syscall */
-	la s0, sys_call_table
 2:
-	slli t0, a7, RISCV_LGPTR
-	add s0, s0, t0
-	REG_L s0, 0(s0)
-3:
-	jalr s0
-
-ret_from_syscall:
-	/* Set user a0 to kernel a0 */
-	REG_S a0, PT_A0(sp)
-	/*
-	 * We didn't execute the actual syscall.
-	 * Seccomp already set return value for the current task pt_regs.
-	 * (If it was configured with SECCOMP_RET_ERRNO/TRACE)
-	 */
-ret_from_syscall_rejected:
-#ifdef CONFIG_DEBUG_RSEQ
-	move a0, sp
-	call rseq_syscall
-#endif
-	/* Trace syscalls, but only if requested by the user. */
-	REG_L t0, TASK_TI_FLAGS(tp)
-	andi t0, t0, _TIF_SYSCALL_WORK
-	bnez t0, handle_syscall_trace_exit
+	tail do_trap_unknown
+SYM_CODE_END(handle_exception)
 
+/*
+ * The ret_from_exception must be called with interrupt disabled. Here is the
+ * caller list:
+ *  - handle_exception
+ *  - ret_from_fork
+ *  - ret_from_kernel_thread
+ */
 SYM_CODE_START_NOALIGN(ret_from_exception)
 	REG_L s0, PT_STATUS(sp)
-	csrc CSR_STATUS, SR_IE
-#ifdef CONFIG_TRACE_IRQFLAGS
-	call __trace_hardirqs_off
-#endif
+
 #ifdef CONFIG_RISCV_M_MODE
 	/* the MPP value is too large to be used as an immediate arg for addi */
 	li t0, SR_MPP
@@ -261,17 +144,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 #else
 	andi s0, s0, SR_SPP
 #endif
-	bnez s0, resume_kernel
-SYM_CODE_END(ret_from_exception)
-
-	/* Interrupts must be disabled here so flags are checked atomically */
-	REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
-	andi s1, s0, _TIF_WORK_MASK
-	bnez s1, resume_userspace_slow
-resume_userspace:
-#ifdef CONFIG_CONTEXT_TRACKING_USER
-	call user_enter_callable
-#endif
+	bnez s0, 1f
 
 	/* Save unwound kernel stack pointer in thread_info */
 	addi s0, sp, PT_SIZE_ON_STACK
@@ -282,19 +155,7 @@ resume_userspace:
 	 * structures again.
 	 */
 	csrw CSR_SCRATCH, tp
-
-restore_all:
-#ifdef CONFIG_TRACE_IRQFLAGS
-	REG_L s1, PT_STATUS(sp)
-	andi t0, s1, SR_PIE
-	beqz t0, 1f
-	call __trace_hardirqs_on
-	j 2f
 1:
-	call __trace_hardirqs_off
-2:
-#endif
-	REG_L a0, PT_STATUS(sp)
 	/*
 	 * The current load reservation is effectively part of the processor's
 	 * state, in the sense that load reservations cannot be shared between
@@ -315,9 +176,11 @@ restore_all:
 	REG_L  a2, PT_EPC(sp)
 	REG_SC x0, a2, PT_EPC(sp)
 
-	csrw CSR_STATUS, a0
 	csrw CSR_EPC, a2
 
+	REG_L a0, PT_STATUS(sp)
+	csrw CSR_STATUS, a0
+
 	REG_L x1,  PT_RA(sp)
 	REG_L x3,  PT_GP(sp)
 	REG_L x4,  PT_TP(sp)
@@ -356,47 +219,10 @@ restore_all:
 #else
 	sret
 #endif
-
-#if IS_ENABLED(CONFIG_PREEMPTION)
-resume_kernel:
-	REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
-	bnez s0, restore_all
-	REG_L s0, TASK_TI_FLAGS(tp)
-	andi s0, s0, _TIF_NEED_RESCHED
-	beqz s0, restore_all
-	call preempt_schedule_irq
-	j restore_all
-#endif
-
-resume_userspace_slow:
-	/* Enter slow path for supplementary processing */
-	move a0, sp /* pt_regs */
-	move a1, s0 /* current_thread_info->flags */
-	call do_work_pending
-	j resume_userspace
-
-/* Slow paths for ptrace. */
-handle_syscall_trace_enter:
-	move a0, sp
-	call do_syscall_trace_enter
-	move t0, a0
-	REG_L a0, PT_A0(sp)
-	REG_L a1, PT_A1(sp)
-	REG_L a2, PT_A2(sp)
-	REG_L a3, PT_A3(sp)
-	REG_L a4, PT_A4(sp)
-	REG_L a5, PT_A5(sp)
-	REG_L a6, PT_A6(sp)
-	REG_L a7, PT_A7(sp)
-	bnez t0, ret_from_syscall_rejected
-	j check_syscall_nr
-handle_syscall_trace_exit:
-	move a0, sp
-	call do_syscall_trace_exit
-	j ret_from_exception
+SYM_CODE_END(ret_from_exception)
 
 #ifdef CONFIG_VMAP_STACK
-handle_kernel_stack_overflow:
+SYM_CODE_START_LOCAL(handle_kernel_stack_overflow)
 	la sp, shadow_stack
 	addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
 
@@ -492,23 +318,25 @@ restore_caller_reg:
 	REG_S s5, PT_TP(sp)
 	move a0, sp
 	tail handle_bad_stack
+SYM_CODE_END(handle_kernel_stack_overflow)
 #endif
 
-END(handle_exception)
-
-ENTRY(ret_from_fork)
+SYM_CODE_START(ret_from_fork)
+	call schedule_tail
+	move a0, sp /* pt_regs */
 	la ra, ret_from_exception
-	tail schedule_tail
-ENDPROC(ret_from_fork)
+	tail syscall_exit_to_user_mode
+SYM_CODE_END(ret_from_fork)
 
-ENTRY(ret_from_kernel_thread)
+SYM_CODE_START(ret_from_kernel_thread)
 	call schedule_tail
 	/* Call fn(arg) */
-	la ra, ret_from_exception
 	move a0, s1
-	jr s0
-ENDPROC(ret_from_kernel_thread)
-
+	jalr s0
+	move a0, sp /* pt_regs */
+	la ra, ret_from_exception
+	tail syscall_exit_to_user_mode
+SYM_CODE_END(ret_from_kernel_thread)
 
 /*
  * Integer register context switch
@@ -520,7 +348,7 @@ ENDPROC(ret_from_kernel_thread)
  * The value of a0 and a1 must be preserved by this function, as that's how
  * arguments are passed to schedule_tail.
  */
-ENTRY(__switch_to)
+SYM_FUNC_START(__switch_to)
 	/* Save context into prev->thread */
 	li    a4,  TASK_THREAD_RA
 	add   a3, a0, a4
@@ -557,7 +385,7 @@ ENTRY(__switch_to)
 	/* The offset of thread_info in task_struct is zero. */
 	move tp, a1
 	ret
-ENDPROC(__switch_to)
+SYM_FUNC_END(__switch_to)
 
 #ifndef CONFIG_MMU
 #define do_page_fault do_trap_unknown
@@ -566,7 +394,7 @@ ENDPROC(__switch_to)
 	.section ".rodata"
 	.align LGREG
 	/* Exception vector table */
-ENTRY(excp_vect_table)
+SYM_CODE_START(excp_vect_table)
 	RISCV_PTR do_trap_insn_misaligned
 	ALT_INSN_FAULT(RISCV_PTR do_trap_insn_fault)
 	RISCV_PTR do_trap_insn_illegal
@@ -575,7 +403,7 @@ ENTRY(excp_vect_table)
 	RISCV_PTR do_trap_load_fault
 	RISCV_PTR do_trap_store_misaligned
 	RISCV_PTR do_trap_store_fault
-	RISCV_PTR do_trap_ecall_u /* system call, gets intercepted */
+	RISCV_PTR do_sys_ecall_u /* system call */
 	RISCV_PTR do_trap_ecall_s
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_trap_ecall_m
@@ -585,11 +413,11 @@ ENTRY(excp_vect_table)
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_page_fault   /* store page fault */
 excp_vect_table_end:
-END(excp_vect_table)
+SYM_CODE_END(excp_vect_table)
 
 #ifndef CONFIG_MMU
-ENTRY(__user_rt_sigreturn)
+SYM_CODE_START(__user_rt_sigreturn)
 	li a7, __NR_rt_sigreturn
 	scall
-END(__user_rt_sigreturn)
+SYM_CODE_END(__user_rt_sigreturn)
 #endif
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7207fa08d78f..24c2e1bd756a 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018 Christoph Hellwig
  */
 
+#include <linux/entry-common.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/seq_file.h>
@@ -22,3 +23,17 @@ void __init init_IRQ(void)
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
 }
+
+asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+	irqentry_state_t state = irqentry_enter(regs);
+
+	irq_enter_rcu();
+	old_regs = set_irq_regs(regs);
+	handle_arch_irq(regs);
+	set_irq_regs(old_regs);
+	irq_exit_rcu();
+
+	irqentry_exit(regs, state);
+}
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 44f4b1ca315d..23c48b14a0e7 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -19,9 +19,6 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/syscalls.h>
-
 enum riscv_regset {
 	REGSET_X,
 #ifdef CONFIG_FPU
@@ -228,46 +225,6 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-/*
- * Allows PTRACE_SYSCALL to work.  These are called from entry.S in
- * {handle,ret_from}_syscall.
- */
-__visible int do_syscall_trace_enter(struct pt_regs *regs)
-{
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		if (ptrace_report_syscall_entry(regs))
-			return -1;
-
-	/*
-	 * Do the secure computing after ptrace; failures should be fast.
-	 * If this fails we might have return value in a0 from seccomp
-	 * (via SECCOMP_RET_ERRNO/TRACE).
-	 */
-	if (secure_computing() == -1)
-		return -1;
-
-#ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_enter(regs, syscall_get_nr(current, regs));
-#endif
-
-	audit_syscall_entry(regs->a7, regs->a0, regs->a1, regs->a2, regs->a3);
-	return 0;
-}
-
-__visible void do_syscall_trace_exit(struct pt_regs *regs)
-{
-	audit_syscall_exit(regs);
-
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		ptrace_report_syscall_exit(regs, 0);
-
-#ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_exit(regs, regs_return_value(regs));
-#endif
-}
-
 #ifdef CONFIG_COMPAT
 static int compat_riscv_gpr_get(struct task_struct *target,
 				const struct user_regset *regset,
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index bfb2afa4135f..2e365084417e 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -12,6 +12,7 @@
 #include <linux/syscalls.h>
 #include <linux/resume_user_mode.h>
 #include <linux/linkage.h>
+#include <linux/entry-common.h>
 
 #include <asm/ucontext.h>
 #include <asm/vdso.h>
@@ -274,7 +275,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	signal_setup_done(ret, ksig, 0);
 }
 
-static void do_signal(struct pt_regs *regs)
+void arch_do_signal_or_restart(struct pt_regs *regs)
 {
 	struct ksignal ksig;
 
@@ -311,29 +312,3 @@ static void do_signal(struct pt_regs *regs)
 	 */
 	restore_saved_sigmask();
 }
-
-/*
- * Handle any pending work on the resume-to-userspace path, as indicated by
- * _TIF_WORK_MASK. Entered from assembly with IRQs off.
- */
-asmlinkage __visible void do_work_pending(struct pt_regs *regs,
-					  unsigned long thread_info_flags)
-{
-	do {
-		if (thread_info_flags & _TIF_NEED_RESCHED) {
-			schedule();
-		} else {
-			local_irq_enable();
-			if (thread_info_flags & _TIF_UPROBE)
-				uprobe_notify_resume(regs);
-			/* Handle pending signal delivery */
-			if (thread_info_flags & (_TIF_SIGPENDING |
-						 _TIF_NOTIFY_SIGNAL))
-				do_signal(regs);
-			if (thread_info_flags & _TIF_NOTIFY_RESUME)
-				resume_user_mode_work(regs);
-		}
-		local_irq_disable();
-		thread_info_flags = read_thread_flags();
-	} while (thread_info_flags & _TIF_WORK_MASK);
-}
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 5d3f2fbeb33c..72689f845b26 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -5,8 +5,10 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/entry-common.h>
 #include <linux/syscalls.h>
 #include <asm/unistd.h>
+#include <asm/syscall.h>
 #include <asm/cacheflush.h>
 #include <asm-generic/mman-common.h>
 
@@ -69,3 +71,32 @@ SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start, uintptr_t, end,
 
 	return 0;
 }
+
+typedef long (*syscall_t)(ulong, ulong, ulong, ulong, ulong, ulong, ulong);
+
+asmlinkage void do_sys_ecall_u(struct pt_regs *regs)
+{
+	syscall_t syscall;
+	ulong nr = regs->a7;
+
+	regs->epc += 4;
+	regs->orig_a0 = regs->a0;
+
+	nr = syscall_enter_from_user_mode(regs, nr);
+
+	if (nr < NR_syscalls) {
+#ifdef CONFIG_COMPAT
+		if ((regs->status & SR_UXL) == SR_UXL_32)
+			syscall = compat_sys_call_table[nr];
+		else
+#endif
+			syscall = sys_call_table[nr];
+
+		regs->a0 = syscall(regs->orig_a0, regs->a1, regs->a2,
+				   regs->a3, regs->a4, regs->a5, regs->a6);
+	} else {
+		regs->a0 = -ENOSYS;
+	}
+
+	syscall_exit_to_user_mode(regs);
+}
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f7fa973558bc..6d1e14350264 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
+#include <linux/entry-common.h>
 
 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
@@ -99,10 +100,19 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #else
 #define __trap_section noinstr
 #endif
-#define DO_ERROR_INFO(name, signo, code, str)				\
-asmlinkage __visible __trap_section void name(struct pt_regs *regs)	\
-{									\
-	do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
+#define DO_ERROR_INFO(name, signo, code, str)					\
+asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
+{										\
+	if (user_mode(regs)) {							\
+		irqentry_enter_from_user_mode(regs);				\
+		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
+		irqentry_exit_to_user_mode(regs);				\
+	} else {								\
+		irqentry_state_t irq_state = irqentry_nmi_enter(regs);		\
+		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
+		irqentry_nmi_exit(regs, irq_state);				\
+	}									\
+	WARN_ON_ONCE(!irqs_disabled());						\
 }
 
 DO_ERROR_INFO(do_trap_unknown,
@@ -126,18 +136,46 @@ int handle_misaligned_store(struct pt_regs *regs);
 
 asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs *regs)
 {
-	if (!handle_misaligned_load(regs))
-		return;
-	do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-		      "Oops - load address misaligned");
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+
+		if (handle_misaligned_load(regs))
+			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
+			      "Oops - load address misaligned");
+
+		irqentry_exit_to_user_mode(regs);
+	} else {
+		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
+
+		if (handle_misaligned_load(regs))
+			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
+			      "Oops - load address misaligned");
+
+		irqentry_nmi_exit(regs, irq_state);
+	}
+	WARN_ON_ONCE(!irqs_disabled());
 }
 
 asmlinkage void __trap_section do_trap_store_misaligned(struct pt_regs *regs)
 {
-	if (!handle_misaligned_store(regs))
-		return;
-	do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-		      "Oops - store (or AMO) address misaligned");
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+
+		if (handle_misaligned_store(regs))
+			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
+				"Oops - store (or AMO) address misaligned");
+
+		irqentry_exit_to_user_mode(regs);
+	} else {
+		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
+
+		if (handle_misaligned_store(regs))
+			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
+				"Oops - store (or AMO) address misaligned");
+
+		irqentry_nmi_exit(regs, irq_state);
+	}
+	WARN_ON_ONCE(!irqs_disabled());
 }
 #endif
 DO_ERROR_INFO(do_trap_store_fault,
@@ -159,7 +197,7 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 	return GET_INSN_LENGTH(insn);
 }
 
-asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
+static void __do_trap_break(struct pt_regs *regs)
 {
 #ifdef CONFIG_KPROBES
 	if (kprobe_single_step_handler(regs))
@@ -189,6 +227,24 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 	else
 		die(regs, "Kernel BUG");
 }
+
+asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+
+		__do_trap_break(regs);
+
+		irqentry_exit_to_user_mode(regs);
+	} else {
+		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
+
+		__do_trap_break(regs);
+
+		irqentry_nmi_exit(regs, irq_state);
+	}
+	WARN_ON_ONCE(!irqs_disabled());
+}
 NOKPROBE_SYMBOL(do_trap_break);
 
 #ifdef CONFIG_GENERIC_BUG
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index b26f68eac61c..5cbea6c55a59 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -15,6 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/kprobes.h>
 #include <linux/kfence.h>
+#include <linux/entry-common.h>
 
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
@@ -204,7 +205,7 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
  * This routine handles page faults.  It determines the address and the
  * problem, and then passes it off to one of the appropriate routines.
  */
-asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
+static void __do_page_fault(struct pt_regs *regs)
 {
 	struct task_struct *tsk;
 	struct vm_area_struct *vma;
@@ -251,7 +252,7 @@ asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
 	}
 #endif
 	/* Enable interrupts if they were enabled in the parent context. */
-	if (likely(regs->status & SR_PIE))
+	if (!regs_irqs_disabled(regs))
 		local_irq_enable();
 
 	/*
@@ -351,4 +352,15 @@ asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
 	}
 	return;
 }
+
+asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	__do_page_fault(regs);
+
+	local_irq_disable();
+
+	irqentry_exit(regs, state);
+}
 NOKPROBE_SYMBOL(do_page_fault);
-- 
2.36.1

