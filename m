Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63F61D0F89
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbgEMKQ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 06:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729917AbgEMKQ1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 06:16:27 -0400
Received: from localhost.localdomain (unknown [42.120.72.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD425206E5;
        Wed, 13 May 2020 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589364986;
        bh=27cHpY2S9HvHQKwzfTmdO82WmE54hAfTEifN3f8fcqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAzCc+BgZpNJbSKA2RIknSfJkk0aKWvFsUlVWSXaR5zbNZPw0p+nn/RPYHsnOqtYq
         Cf6499HSOKeXhxWHoXUmLmwImOpq6YSbtgIVb4n6sSIxXCUyTIwUQFFOSPITB0Bjhx
         EQALieT9JkwO7nYYFNsbzenDQjxHqYsRI5eUQL8s=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 2/4] csky: Fixup calltrace panic
Date:   Wed, 13 May 2020 18:16:15 +0800
Message-Id: <20200513101617.11588-2-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200513101617.11588-1-guoren@kernel.org>
References: <20200513101617.11588-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The implementation of show_stack will panic with wrong fp:

addr    = *fp++;

because the fp isn't checked properly.

The current implementations of show_stack, wchan and stack_trace
haven't been designed properly, so just deprecate them.

This patch is a reference to riscv's way, all codes are modified from
arm's. The patch is passed with:

 - cat /proc/<pid>/stack
 - cat /proc/<pid>/wchan
 - echo c > /proc/sysrq-trigger

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/Kconfig                   |   2 +
 arch/csky/Makefile                  |   2 +-
 arch/csky/include/asm/ptrace.h      |  10 ++
 arch/csky/include/asm/thread_info.h |   6 +
 arch/csky/kernel/Makefile           |   2 +-
 arch/csky/kernel/dumpstack.c        |  49 --------
 arch/csky/kernel/process.c          |  31 -----
 arch/csky/kernel/stacktrace.c       | 176 ++++++++++++++++++++++------
 8 files changed, 159 insertions(+), 119 deletions(-)
 delete mode 100644 arch/csky/kernel/dumpstack.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 94545d50d40f..bd31ab12f77d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -8,6 +8,7 @@ config CSKY
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
+	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
 	select COMMON_CLK
 	select CLKSRC_MMIO
 	select CSKY_MPINTC if CPU_CK860
@@ -38,6 +39,7 @@ config CSKY
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_COPY_THREAD_TLS
+	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index fb1bbbd91954..37f593a4bf53 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -47,7 +47,7 @@ ifeq ($(CSKYABI),abiv2)
 KBUILD_CFLAGS += -mno-stack-size
 endif
 
-ifdef CONFIG_STACKTRACE
+ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS += -mbacktrace
 endif
 
diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
index aae5aa96cf54..bcfb7070e48d 100644
--- a/arch/csky/include/asm/ptrace.h
+++ b/arch/csky/include/asm/ptrace.h
@@ -58,6 +58,16 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 	return regs->usp;
 }
 
+static inline unsigned long frame_pointer(struct pt_regs *regs)
+{
+	return regs->regs[4];
+}
+static inline void frame_pointer_set(struct pt_regs *regs,
+				     unsigned long val)
+{
+	regs->regs[4] = val;
+}
+
 extern int regs_query_register_offset(const char *name);
 extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 						unsigned int n);
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 5d33fcfd7f2a..d381a5752f0e 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -40,6 +40,12 @@ struct thread_info {
 #define thread_saved_fp(tsk) \
 	((unsigned long)(((struct switch_stack *)(tsk->thread.ksp))->r8))
 
+#define thread_saved_sp(tsk) \
+	((unsigned long)(tsk->thread.ksp))
+
+#define thread_saved_lr(tsk) \
+	((unsigned long)(((struct switch_stack *)(tsk->thread.ksp))->r15))
+
 static inline struct thread_info *current_thread_info(void)
 {
 	unsigned long sp;
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index fd6d9dc8b7f3..37f37c0e934a 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -3,7 +3,7 @@ extra-y := head.o vmlinux.lds
 
 obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o
 obj-y += power.o syscall.o syscall_table.o setup.o
-obj-y += process.o cpu-probe.o ptrace.o dumpstack.o
+obj-y += process.o cpu-probe.o ptrace.o stacktrace.o
 obj-y += probes/
 
 obj-$(CONFIG_MODULES)			+= module.o
diff --git a/arch/csky/kernel/dumpstack.c b/arch/csky/kernel/dumpstack.c
deleted file mode 100644
index d67f9777cfd9..000000000000
--- a/arch/csky/kernel/dumpstack.c
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
-
-#include <linux/ptrace.h>
-
-int kstack_depth_to_print = 48;
-
-void show_trace(unsigned long *stack)
-{
-	unsigned long *stack_end;
-	unsigned long *stack_start;
-	unsigned long *fp;
-	unsigned long addr;
-
-	addr = (unsigned long) stack & THREAD_MASK;
-	stack_start = (unsigned long *) addr;
-	stack_end = (unsigned long *) (addr + THREAD_SIZE);
-
-	fp = stack;
-	pr_info("\nCall Trace:");
-
-	while (fp > stack_start && fp < stack_end) {
-#ifdef CONFIG_STACKTRACE
-		addr	= fp[1];
-		fp	= (unsigned long *) fp[0];
-#else
-		addr	= *fp++;
-#endif
-		if (__kernel_text_address(addr))
-			pr_cont("\n[<%08lx>] %pS", addr, (void *)addr);
-	}
-	pr_cont("\n");
-}
-
-void show_stack(struct task_struct *task, unsigned long *stack)
-{
-	if (!stack) {
-		if (task)
-			stack = (unsigned long *)thread_saved_fp(task);
-		else
-#ifdef CONFIG_STACKTRACE
-			asm volatile("mov %0, r8\n":"=r"(stack)::"memory");
-#else
-			stack = (unsigned long *)&stack;
-#endif
-	}
-
-	show_trace(stack);
-}
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index f7b231ca269a..4ad6db56c3cd 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -98,37 +98,6 @@ int dump_task_regs(struct task_struct *tsk, elf_gregset_t *pr_regs)
 	return 1;
 }
 
-unsigned long get_wchan(struct task_struct *p)
-{
-	unsigned long lr;
-	unsigned long *fp, *stack_start, *stack_end;
-	int count = 0;
-
-	if (!p || p == current || p->state == TASK_RUNNING)
-		return 0;
-
-	stack_start = (unsigned long *)end_of_stack(p);
-	stack_end = (unsigned long *)(task_stack_page(p) + THREAD_SIZE);
-
-	fp = (unsigned long *) thread_saved_fp(p);
-	do {
-		if (fp < stack_start || fp > stack_end)
-			return 0;
-#ifdef CONFIG_STACKTRACE
-		lr = fp[1];
-		fp = (unsigned long *)fp[0];
-#else
-		lr = *fp++;
-#endif
-		if (!in_sched_functions(lr) &&
-		    __kernel_text_address(lr))
-			return lr;
-	} while (count++ < 16);
-
-	return 0;
-}
-EXPORT_SYMBOL(get_wchan);
-
 #ifndef CONFIG_CPU_PM_NONE
 void arch_cpu_idle(void)
 {
diff --git a/arch/csky/kernel/stacktrace.c b/arch/csky/kernel/stacktrace.c
index fec777a643f1..92809e1da723 100644
--- a/arch/csky/kernel/stacktrace.c
+++ b/arch/csky/kernel/stacktrace.c
@@ -1,57 +1,159 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd. */
 
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 #include <linux/ftrace.h>
+#include <linux/ptrace.h>
 
-void save_stack_trace(struct stack_trace *trace)
+#ifdef CONFIG_FRAME_POINTER
+
+struct stackframe {
+	unsigned long fp;
+	unsigned long ra;
+};
+
+void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
+			     bool (*fn)(unsigned long, void *), void *arg)
 {
-	save_stack_trace_tsk(current, trace);
+	unsigned long fp, sp, pc;
+
+	if (regs) {
+		fp = frame_pointer(regs);
+		sp = user_stack_pointer(regs);
+		pc = instruction_pointer(regs);
+	} else if (task == NULL || task == current) {
+		const register unsigned long current_sp __asm__ ("sp");
+		const register unsigned long current_fp __asm__ ("r8");
+		fp = current_fp;
+		sp = current_sp;
+		pc = (unsigned long)walk_stackframe;
+	} else {
+		/* task blocked in __switch_to */
+		fp = thread_saved_fp(task);
+		sp = thread_saved_sp(task);
+		pc = thread_saved_lr(task);
+	}
+
+	for (;;) {
+		unsigned long low, high;
+		struct stackframe *frame;
+
+		if (unlikely(!__kernel_text_address(pc) || fn(pc, arg)))
+			break;
+
+		/* Validate frame pointer */
+		low = sp;
+		high = ALIGN(sp, THREAD_SIZE);
+		if (unlikely(fp < low || fp > high || fp & 0x3))
+			break;
+		/* Unwind stack frame */
+		frame = (struct stackframe *)fp;
+		sp = fp;
+		fp = frame->fp;
+		pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
+					   (unsigned long *)(fp - 8));
+	}
 }
-EXPORT_SYMBOL_GPL(save_stack_trace);
 
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+#else /* !CONFIG_FRAME_POINTER */
+
+static void notrace walk_stackframe(struct task_struct *task,
+	struct pt_regs *regs, bool (*fn)(unsigned long, void *), void *arg)
 {
-	unsigned long *fp, *stack_start, *stack_end;
-	unsigned long addr;
-	int skip = trace->skip;
-	int savesched;
-	int graph_idx = 0;
+	unsigned long sp, pc;
+	unsigned long *ksp;
 
-	if (tsk == current) {
-		asm volatile("mov %0, r8\n":"=r"(fp));
-		savesched = 1;
+	if (regs) {
+		sp = user_stack_pointer(regs);
+		pc = instruction_pointer(regs);
+	} else if (task == NULL || task == current) {
+		const register unsigned long current_sp __asm__ ("sp");
+		sp = current_sp;
+		pc = (unsigned long)walk_stackframe;
 	} else {
-		fp = (unsigned long *)thread_saved_fp(tsk);
-		savesched = 0;
+		/* task blocked in __switch_to */
+		sp = thread_saved_sp(task);
+		pc = thread_saved_lr(task);
 	}
 
-	addr = (unsigned long) fp & THREAD_MASK;
-	stack_start = (unsigned long *) addr;
-	stack_end = (unsigned long *) (addr + THREAD_SIZE);
-
-	while (fp > stack_start && fp < stack_end) {
-		unsigned long lpp, fpp;
+	if (unlikely(sp & 0x3))
+		return;
 
-		fpp = fp[0];
-		lpp = fp[1];
-		if (!__kernel_text_address(lpp))
+	ksp = (unsigned long *)sp;
+	while (!kstack_end(ksp)) {
+		if (__kernel_text_address(pc) && unlikely(fn(pc, arg)))
 			break;
-		else
-			lpp = ftrace_graph_ret_addr(tsk, &graph_idx, lpp, NULL);
-
-		if (savesched || !in_sched_functions(lpp)) {
-			if (skip) {
-				skip--;
-			} else {
-				trace->entries[trace->nr_entries++] = lpp;
-				if (trace->nr_entries >= trace->max_entries)
-					break;
-			}
-		}
-		fp = (unsigned long *)fpp;
+		pc = (*ksp++) - 0x4;
 	}
 }
+#endif /* CONFIG_FRAME_POINTER */
+
+static bool print_trace_address(unsigned long pc, void *arg)
+{
+	print_ip_sym(pc);
+	return false;
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	pr_cont("Call Trace:\n");
+	walk_stackframe(task, NULL, print_trace_address, NULL);
+}
+
+static bool save_wchan(unsigned long pc, void *arg)
+{
+	if (!in_sched_functions(pc)) {
+		unsigned long *p = arg;
+		*p = pc;
+		return true;
+	}
+	return false;
+}
+
+unsigned long get_wchan(struct task_struct *task)
+{
+	unsigned long pc = 0;
+
+	if (likely(task && task != current && task->state != TASK_RUNNING))
+		walk_stackframe(task, NULL, save_wchan, &pc);
+	return pc;
+}
+
+#ifdef CONFIG_STACKTRACE
+static bool __save_trace(unsigned long pc, void *arg, bool nosched)
+{
+	struct stack_trace *trace = arg;
+
+	if (unlikely(nosched && in_sched_functions(pc)))
+		return false;
+	if (unlikely(trace->skip > 0)) {
+		trace->skip--;
+		return false;
+	}
+
+	trace->entries[trace->nr_entries++] = pc;
+	return (trace->nr_entries >= trace->max_entries);
+}
+
+static bool save_trace(unsigned long pc, void *arg)
+{
+	return __save_trace(pc, arg, false);
+}
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ */
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	walk_stackframe(tsk, NULL, save_trace, trace);
+}
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
+
+void save_stack_trace(struct stack_trace *trace)
+{
+	save_stack_trace_tsk(NULL, trace);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace);
+
+#endif /* CONFIG_STACKTRACE */
-- 
2.17.0

