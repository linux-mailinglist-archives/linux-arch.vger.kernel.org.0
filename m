Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498523BC535
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhGFEV1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEV1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:21:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F288D61973;
        Tue,  6 Jul 2021 04:18:45 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 07/19] LoongArch: Add process management
Date:   Tue,  6 Jul 2021 12:18:08 +0800
Message-Id: <20210706041820.1536502-8-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds process management support for LoongArch, including:
thread info definition, context switch and process tracing.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/idle.h        |   9 +
 arch/loongarch/include/asm/mmu.h         |  16 +
 arch/loongarch/include/asm/mmu_context.h | 174 +++++++++
 arch/loongarch/include/asm/ptrace.h      | 138 +++++++
 arch/loongarch/include/asm/switch_to.h   |  37 ++
 arch/loongarch/include/asm/thread_info.h | 141 +++++++
 arch/loongarch/include/uapi/asm/ptrace.h |  47 +++
 arch/loongarch/kernel/fpu.S              | 298 +++++++++++++++
 arch/loongarch/kernel/idle.c             |  17 +
 arch/loongarch/kernel/process.c          | 267 +++++++++++++
 arch/loongarch/kernel/ptrace.c           | 459 +++++++++++++++++++++++
 arch/loongarch/kernel/switch.S           |  48 +++
 12 files changed, 1651 insertions(+)
 create mode 100644 arch/loongarch/include/asm/idle.h
 create mode 100644 arch/loongarch/include/asm/mmu.h
 create mode 100644 arch/loongarch/include/asm/mmu_context.h
 create mode 100644 arch/loongarch/include/asm/ptrace.h
 create mode 100644 arch/loongarch/include/asm/switch_to.h
 create mode 100644 arch/loongarch/include/asm/thread_info.h
 create mode 100644 arch/loongarch/include/uapi/asm/ptrace.h
 create mode 100644 arch/loongarch/kernel/fpu.S
 create mode 100644 arch/loongarch/kernel/idle.c
 create mode 100644 arch/loongarch/kernel/process.c
 create mode 100644 arch/loongarch/kernel/ptrace.c
 create mode 100644 arch/loongarch/kernel/switch.S

diff --git a/arch/loongarch/include/asm/idle.h b/arch/loongarch/include/asm/idle.h
new file mode 100644
index 000000000000..f7f2b7dbf958
--- /dev/null
+++ b/arch/loongarch/include/asm/idle.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_IDLE_H
+#define __ASM_IDLE_H
+
+#include <linux/linkage.h>
+
+extern asmlinkage void __arch_cpu_idle(void);
+
+#endif /* __ASM_IDLE_H  */
diff --git a/arch/loongarch/include/asm/mmu.h b/arch/loongarch/include/asm/mmu.h
new file mode 100644
index 000000000000..11f63fb0159b
--- /dev/null
+++ b/arch/loongarch/include/asm/mmu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_MMU_H
+#define __ASM_MMU_H
+
+#include <linux/atomic.h>
+#include <linux/spinlock.h>
+
+typedef struct {
+	u64 asid[NR_CPUS];
+	void *vdso;
+} mm_context_t;
+
+#endif /* __ASM_MMU_H */
diff --git a/arch/loongarch/include/asm/mmu_context.h b/arch/loongarch/include/asm/mmu_context.h
new file mode 100644
index 000000000000..71fd2890a34e
--- /dev/null
+++ b/arch/loongarch/include/asm/mmu_context.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Switch a MMU context.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_MMU_CONTEXT_H
+#define _ASM_MMU_CONTEXT_H
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/mm_types.h>
+#include <linux/smp.h>
+#include <linux/slab.h>
+
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+#include <asm-generic/mm_hooks.h>
+
+#define TLBMISS_HANDLER_SETUP()					\
+	do {							\
+		csr_writeq((unsigned long)invalid_pg_dir, LOONGARCH_CSR_PGDL);	   \
+		csr_writeq((unsigned long)smp_processor_id(), LOONGARCH_CSR_TMID); \
+	} while (0)
+
+/*
+ *  All unused by hardware upper bits will be considered
+ *  as a software asid extension.
+ */
+static inline u64 asid_version_mask(unsigned int cpu)
+{
+	unsigned long asid_mask = cpu_asid_mask(&cpu_data[cpu]);
+
+	return ~(u64)(asid_mask | (asid_mask - 1));
+}
+
+static inline u64 asid_first_version(unsigned int cpu)
+{
+	return ~asid_version_mask(cpu) + 1;
+}
+
+#define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
+#define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
+#define cpu_asid(cpu, mm)	(cpu_context((cpu), (mm)) & cpu_asid_mask(&cpu_data[cpu]))
+
+static inline int asid_valid(struct mm_struct *mm, unsigned int cpu)
+{
+	if ((cpu_context(cpu, mm) ^ asid_cache(cpu)) & asid_version_mask(cpu))
+		return 0;
+
+	return 1;
+}
+
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+{
+}
+
+/* Normal, classic get_new_mmu_context */
+static inline void
+get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
+{
+	u64 asid = asid_cache(cpu);
+
+	if (!((++asid) & cpu_asid_mask(&cpu_data[cpu])))
+		local_flush_tlb_all();	/* start new asid cycle */
+
+	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
+}
+
+/*
+ * Initialize the context related info for a new mm_struct
+ * instance.
+ */
+static inline int
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	int i;
+
+	for_each_possible_cpu(i)
+		cpu_context(i, mm) = 0;
+
+	return 0;
+}
+
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+			     struct task_struct *tsk)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	/* Check if our ASID is of an older version and thus invalid */
+	if (asid_valid(next, cpu) == 0)
+		get_new_mmu_context(next, cpu);
+	write_csr_asid(cpu_asid(cpu, next));
+	if (next != &init_mm)
+		csr_writeq((unsigned long)next->pgd, LOONGARCH_CSR_PGDL);
+	else
+		csr_writeq((unsigned long)invalid_pg_dir, LOONGARCH_CSR_PGDL);
+
+	/*
+	 * Mark current->active_mm as not "active" anymore.
+	 * We don't want to mislead possible IPI tlb flush routines.
+	 */
+	cpumask_set_cpu(cpu, mm_cpumask(next));
+
+	local_irq_restore(flags);
+}
+
+/*
+ * Destroy context related info for an mm_struct that is about
+ * to be put to rest.
+ */
+static inline void destroy_context(struct mm_struct *mm)
+{
+}
+
+/*
+ * After we have set current->mm to a new value, this activates
+ * the context for the new mm so we see the new mappings.
+ */
+static inline void
+activate_mm(struct mm_struct *prev, struct mm_struct *next)
+{
+	unsigned long flags;
+	unsigned int cpu = smp_processor_id();
+
+	local_irq_save(flags);
+
+	/* Unconditionally get a new ASID.  */
+	get_new_mmu_context(next, cpu);
+
+	write_csr_asid(cpu_asid(cpu, next));
+	csr_writeq((unsigned long)next->pgd, LOONGARCH_CSR_PGDL);
+
+	/* mark mmu ownership change */
+	cpumask_set_cpu(cpu, mm_cpumask(next));
+
+	local_irq_restore(flags);
+}
+
+#define deactivate_mm(tsk, mm)	do { } while (0)
+
+/*
+ * If mm is currently active, we can't really drop it.
+ * Instead, we will get a new one for it.
+ */
+static inline void
+drop_mmu_context(struct mm_struct *mm, unsigned int cpu)
+{
+	int asid;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	asid = read_csr_asid() & cpu_asid_mask(&current_cpu_data);
+
+	if (asid == cpu_asid(cpu, mm)) {
+		if (!current->mm || (current->mm == mm)) {
+			get_new_mmu_context(mm, cpu);
+			write_csr_asid(cpu_asid(cpu, mm));
+			goto out;
+		}
+	}
+
+	/* Will get a new context next time */
+	cpu_context(cpu, mm) = 0;
+	cpumask_clear_cpu(cpu, mm_cpumask(mm));
+out:
+	local_irq_restore(flags);
+}
+
+#endif /* _ASM_MMU_CONTEXT_H */
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
new file mode 100644
index 000000000000..8bd8c747b060
--- /dev/null
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_PTRACE_H
+#define _ASM_PTRACE_H
+
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <asm/page.h>
+#include <asm/thread_info.h>
+#include <uapi/asm/ptrace.h>
+
+static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+{
+	return regs->regs[3];
+}
+
+/*
+ * Don't use asm-generic/ptrace.h it defines FP accessors that don't make
+ * sense on LoongArch.  We rather want an error if they get invoked.
+ */
+
+static inline void instruction_pointer_set(struct pt_regs *regs, unsigned long val)
+{
+	regs->csr_epc = val;
+}
+
+/* Query offset/name of register from its name/offset */
+extern int regs_query_register_offset(const char *name);
+#define MAX_REG_OFFSET (offsetof(struct pt_regs, __last))
+
+/**
+ * regs_get_register() - get register value from its offset
+ * @regs:       pt_regs from which register value is gotten.
+ * @offset:     offset number of the register.
+ *
+ * regs_get_register returns the value of a register. The @offset is the
+ * offset of the register in struct pt_regs address which specified by @regs.
+ * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
+ */
+static inline unsigned long regs_get_register(struct pt_regs *regs, unsigned int offset)
+{
+	if (unlikely(offset > MAX_REG_OFFSET))
+		return 0;
+
+	return *(unsigned long *)((unsigned long)regs + offset);
+}
+
+/**
+ * regs_within_kernel_stack() - check the address in the stack
+ * @regs:       pt_regs which contains kernel stack pointer.
+ * @addr:       address which is checked.
+ *
+ * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
+ * If @addr is within the kernel stack, it returns true. If not, returns false.
+ */
+static inline int regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
+{
+	return ((addr & ~(THREAD_SIZE - 1))  ==
+		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
+}
+
+/**
+ * regs_get_kernel_stack_nth() - get Nth entry of the stack
+ * @regs:       pt_regs which contains kernel stack pointer.
+ * @n:          stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * this returns 0.
+ */
+static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
+{
+	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
+
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return *addr;
+	else
+		return 0;
+}
+
+struct task_struct;
+
+/*
+ * Does the process account for user or for system time?
+ */
+#define user_mode(regs) (((regs)->csr_prmd & PLV_MASK) == PLV_USER)
+
+static inline int is_syscall_success(struct pt_regs *regs)
+{
+	return !regs->regs[7];
+}
+
+static inline long regs_return_value(struct pt_regs *regs)
+{
+	if (is_syscall_success(regs) || !user_mode(regs))
+		return regs->regs[4];
+	else
+		return -regs->regs[4];
+}
+
+#define instruction_pointer(regs) ((regs)->csr_epc)
+#define profile_pc(regs) instruction_pointer(regs)
+
+extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall);
+extern asmlinkage void syscall_trace_leave(struct pt_regs *regs);
+
+extern void die(const char *, struct pt_regs *) __noreturn;
+
+static inline void die_if_kernel(const char *str, struct pt_regs *regs)
+{
+	if (unlikely(!user_mode(regs)))
+		die(str, regs);
+}
+
+#define current_pt_regs()						\
+({									\
+	unsigned long sp = (unsigned long)__builtin_frame_address(0);	\
+	(struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 - 32) - 1;	\
+})
+
+/* Helpers for working with the user stack pointer */
+
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return regs->regs[3];
+}
+
+static inline void user_stack_pointer_set(struct pt_regs *regs,
+	unsigned long val)
+{
+	regs->regs[3] = val;
+}
+
+#endif /* _ASM_PTRACE_H */
diff --git a/arch/loongarch/include/asm/switch_to.h b/arch/loongarch/include/asm/switch_to.h
new file mode 100644
index 000000000000..43fa9d8fc192
--- /dev/null
+++ b/arch/loongarch/include/asm/switch_to.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_SWITCH_TO_H
+#define _ASM_SWITCH_TO_H
+
+#include <asm/cpu-features.h>
+#include <asm/fpu.h>
+
+struct task_struct;
+
+/**
+ * resume - resume execution of a task
+ * @prev:	The task previously executed.
+ * @next:	The task to begin executing.
+ * @next_ti:	task_thread_info(next).
+ *
+ * This function is used whilst scheduling to save the context of prev & load
+ * the context of next. Returns prev.
+ */
+extern asmlinkage struct task_struct *resume(struct task_struct *prev,
+		struct task_struct *next, struct thread_info *next_ti);
+
+/*
+ * For newly created kernel threads switch_to() will return to
+ * ret_from_kernel_thread, newly created user threads to ret_from_fork.
+ * That is, everything following resume() will be skipped for new threads.
+ * So everything that matters to new threads should be placed before resume().
+ */
+#define switch_to(prev, next, last)					\
+do {									\
+	lose_fpu_inatomic(1, prev);					\
+	(last) = resume(prev, next, task_thread_info(next));		\
+} while (0)
+
+#endif /* _ASM_SWITCH_TO_H */
diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
new file mode 100644
index 000000000000..0accd02e2a81
--- /dev/null
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * thread_info.h: LoongArch low-level thread information
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef _ASM_THREAD_INFO_H
+#define _ASM_THREAD_INFO_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+#include <asm/processor.h>
+
+/*
+ * low level task data that entry.S needs immediate access to
+ * - this struct should fit entirely inside of one cache line
+ * - this struct shares the supervisor stack pages
+ * - if the contents of this structure are changed, the assembly constants
+ *   must also be changed
+ */
+struct thread_info {
+	struct task_struct	*task;		/* main task structure */
+	unsigned long		flags;		/* low level flags */
+	unsigned long		tp_value;	/* thread pointer */
+	__u32			cpu;		/* current CPU */
+	int			preempt_count;	/* 0 => preemptible, <0 => BUG */
+	struct pt_regs		*regs;
+	long			syscall;	/* syscall number */
+};
+
+/*
+ * macros/functions for gaining access to the thread information structure
+ */
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.task		= &tsk,			\
+	.flags		= _TIF_FIXADE,		\
+	.cpu		= 0,			\
+	.preempt_count	= INIT_PREEMPT_COUNT,	\
+}
+
+/* How to get the thread information struct from C. */
+register struct thread_info *__current_thread_info __asm__("$r2");
+
+static inline struct thread_info *current_thread_info(void)
+{
+	return __current_thread_info;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+/* thread information allocation */
+#if defined(CONFIG_PAGE_SIZE_4KB) && defined(CONFIG_32BIT)
+#define THREAD_SIZE_ORDER (1)
+#endif
+#if defined(CONFIG_PAGE_SIZE_4KB) && defined(CONFIG_64BIT)
+#define THREAD_SIZE_ORDER (2)
+#endif
+#ifdef CONFIG_PAGE_SIZE_16KB
+#define THREAD_SIZE_ORDER (0)
+#endif
+#ifdef CONFIG_PAGE_SIZE_64KB
+#define THREAD_SIZE_ORDER (0)
+#endif
+
+#define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
+#define THREAD_MASK (THREAD_SIZE - 1UL)
+
+#define STACK_WARN	(THREAD_SIZE / 8)
+
+/*
+ * thread information flags
+ * - these are process state flags that various assembly files may need to
+ *   access
+ * - pending work-to-be-done flags are in LSW
+ * - other flags in MSW
+ */
+#define TIF_SIGPENDING		1	/* signal pending */
+#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
+#define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
+#define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
+#define TIF_RESTORE_SIGMASK	5	/* restore signal mask in do_signal() */
+#define TIF_NOHZ		6	/* in adaptive nohz mode */
+#define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
+#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
+#define TIF_SYSCALL_TRACEPOINT	9	/* syscall tracepoint instrumentation */
+#define TIF_SECCOMP		10	/* secure computing */
+#define TIF_UPROBE		11	/* breakpointed or singlestepping */
+#define TIF_USEDFPU		12	/* FPU was used by this task this quantum (SMP) */
+#define TIF_USEDSIMD		13	/* SIMD has been used this quantum */
+#define TIF_MEMDIE		14	/* is terminating due to OOM killer */
+#define TIF_FIXADE		15	/* Fix address errors in software */
+#define TIF_LOGADE		16	/* Log address errors to syslog */
+#define TIF_32BIT_REGS		17	/* 32-bit general purpose registers */
+#define TIF_32BIT_ADDR		18	/* 32-bit address space */
+#define TIF_LOAD_WATCH		19	/* If set, load watch registers */
+#define TIF_LSX_CTX_LIVE	20	/* LSX context must be preserved */
+#define TIF_LASX_CTX_LIVE	21	/* LASX context must be preserved */
+
+#define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
+#define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
+#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
+#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
+#define _TIF_NOHZ		(1<<TIF_NOHZ)
+#define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
+#define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
+#define _TIF_SECCOMP		(1<<TIF_SECCOMP)
+#define _TIF_UPROBE		(1<<TIF_UPROBE)
+#define _TIF_USEDFPU		(1<<TIF_USEDFPU)
+#define _TIF_USEDSIMD		(1<<TIF_USEDSIMD)
+#define _TIF_FIXADE		(1<<TIF_FIXADE)
+#define _TIF_LOGADE		(1<<TIF_LOGADE)
+#define _TIF_32BIT_REGS		(1<<TIF_32BIT_REGS)
+#define _TIF_32BIT_ADDR		(1<<TIF_32BIT_ADDR)
+#define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)
+#define _TIF_LSX_CTX_LIVE	(1<<TIF_LSX_CTX_LIVE)
+#define _TIF_LASX_CTX_LIVE	(1<<TIF_LASX_CTX_LIVE)
+
+#define _TIF_WORK_SYSCALL_ENTRY	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
+				 _TIF_SYSCALL_AUDIT | \
+				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP)
+
+/* work to do in syscall_trace_leave() */
+#define _TIF_WORK_SYSCALL_EXIT	(_TIF_NOHZ | _TIF_SYSCALL_TRACE |	\
+				 _TIF_SYSCALL_AUDIT | _TIF_SYSCALL_TRACEPOINT)
+
+/* work to do on interrupt/exception return */
+#define _TIF_WORK_MASK		\
+	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_NOTIFY_RESUME |	\
+	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
+/* work to do on any return to u-space */
+#define _TIF_ALLWORK_MASK	(_TIF_NOHZ | _TIF_WORK_MASK |		\
+				 _TIF_WORK_SYSCALL_EXIT |		\
+				 _TIF_SYSCALL_TRACEPOINT)
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_THREAD_INFO_H */
diff --git a/arch/loongarch/include/uapi/asm/ptrace.h b/arch/loongarch/include/uapi/asm/ptrace.h
new file mode 100644
index 000000000000..0d3f29f3cc83
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/ptrace.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _UAPI_ASM_PTRACE_H
+#define _UAPI_ASM_PTRACE_H
+
+#include <linux/types.h>
+
+#ifndef __KERNEL__
+#include <stdint.h>
+#endif
+
+/* For PTRACE_{POKE,PEEK}USR. 0 - 31 are GPRs, 32 is PC, 33 is BADVADDR. */
+#define GPR_BASE	0
+#define GPR_NUM		32
+#define GPR_END		(GPR_BASE + GPR_NUM - 1)
+#define PC		(GPR_END + 1)
+#define BADVADDR	(GPR_END + 2)
+
+/*
+ * This struct defines the way the registers are stored on the stack during a
+ * system call/exception.
+ *
+ * If you add a register here, also add it to regoffset_table[] in
+ * arch/loongarch/kernel/ptrace.c.
+ */
+struct pt_regs {
+	/* Saved main processor registers. */
+	unsigned long regs[32];
+
+	/* Saved special registers. */
+	unsigned long csr_crmd;
+	unsigned long csr_prmd;
+	unsigned long csr_euen;
+	unsigned long csr_ecfg;
+	unsigned long csr_estat;
+	unsigned long csr_epc;
+	unsigned long csr_badvaddr;
+	unsigned long orig_a0;
+	unsigned long __last[0];
+} __aligned(8);
+
+#endif /* _UAPI_ASM_PTRACE_H */
diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
new file mode 100644
index 000000000000..0a67f1f02712
--- /dev/null
+++ b/arch/loongarch/kernel/fpu.S
@@ -0,0 +1,298 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Lu Zeng <zenglu@loongson.cn>
+ *         Pei Huang <huangpei@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/errno.h>
+#include <asm/export.h>
+#include <asm/fpregdef.h>
+#include <asm/loongarchregs.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+
+#undef v0
+#undef v1
+
+#define FPU_SREG_WIDTH	32
+#define SC_FPR0  0
+#define SC_FPR1  (SC_FPR0  + FPU_SREG_WIDTH)
+#define SC_FPR2  (SC_FPR1  + FPU_SREG_WIDTH)
+#define SC_FPR3  (SC_FPR2  + FPU_SREG_WIDTH)
+#define SC_FPR4  (SC_FPR3  + FPU_SREG_WIDTH)
+#define SC_FPR5  (SC_FPR4  + FPU_SREG_WIDTH)
+#define SC_FPR6  (SC_FPR5  + FPU_SREG_WIDTH)
+#define SC_FPR7  (SC_FPR6  + FPU_SREG_WIDTH)
+#define SC_FPR8  (SC_FPR7  + FPU_SREG_WIDTH)
+#define SC_FPR9  (SC_FPR8  + FPU_SREG_WIDTH)
+#define SC_FPR10 (SC_FPR9  + FPU_SREG_WIDTH)
+#define SC_FPR11 (SC_FPR10 + FPU_SREG_WIDTH)
+#define SC_FPR12 (SC_FPR11 + FPU_SREG_WIDTH)
+#define SC_FPR13 (SC_FPR12 + FPU_SREG_WIDTH)
+#define SC_FPR14 (SC_FPR13 + FPU_SREG_WIDTH)
+#define SC_FPR15 (SC_FPR14 + FPU_SREG_WIDTH)
+#define SC_FPR16 (SC_FPR15 + FPU_SREG_WIDTH)
+#define SC_FPR17 (SC_FPR16 + FPU_SREG_WIDTH)
+#define SC_FPR18 (SC_FPR17 + FPU_SREG_WIDTH)
+#define SC_FPR19 (SC_FPR18 + FPU_SREG_WIDTH)
+#define SC_FPR20 (SC_FPR19 + FPU_SREG_WIDTH)
+#define SC_FPR21 (SC_FPR20 + FPU_SREG_WIDTH)
+#define SC_FPR22 (SC_FPR21 + FPU_SREG_WIDTH)
+#define SC_FPR23 (SC_FPR22 + FPU_SREG_WIDTH)
+#define SC_FPR24 (SC_FPR23 + FPU_SREG_WIDTH)
+#define SC_FPR25 (SC_FPR24 + FPU_SREG_WIDTH)
+#define SC_FPR26 (SC_FPR25 + FPU_SREG_WIDTH)
+#define SC_FPR27 (SC_FPR26 + FPU_SREG_WIDTH)
+#define SC_FPR28 (SC_FPR27 + FPU_SREG_WIDTH)
+#define SC_FPR29 (SC_FPR28 + FPU_SREG_WIDTH)
+#define SC_FPR30 (SC_FPR29 + FPU_SREG_WIDTH)
+#define SC_FPR31 (SC_FPR30 + FPU_SREG_WIDTH)
+
+/* preprocessor replaces the fp in ".set fp=64" with $30 otherwise */
+#undef fp
+
+	.macro	EX insn, reg, src, offs
+.ex\@:	\insn	\reg, \src, \offs
+	.section __ex_table,"a"
+	PTR	.ex\@, fault
+	.previous
+	.endm
+
+	.macro sc_save_fp base
+	EX	fst.d $f0,  \base, SC_FPR0
+	EX	fst.d $f1,  \base, SC_FPR1
+	EX	fst.d $f2,  \base, SC_FPR2
+	EX	fst.d $f3,  \base, SC_FPR3
+	EX	fst.d $f4,  \base, SC_FPR4
+	EX	fst.d $f5,  \base, SC_FPR5
+	EX	fst.d $f6,  \base, SC_FPR6
+	EX	fst.d $f7,  \base, SC_FPR7
+	EX	fst.d $f8,  \base, SC_FPR8
+	EX	fst.d $f9,  \base, SC_FPR9
+	EX	fst.d $f10, \base, SC_FPR10
+	EX	fst.d $f11, \base, SC_FPR11
+	EX	fst.d $f12, \base, SC_FPR12
+	EX	fst.d $f13, \base, SC_FPR13
+	EX	fst.d $f14, \base, SC_FPR14
+	EX	fst.d $f15, \base, SC_FPR15
+	EX	fst.d $f16, \base, SC_FPR16
+	EX	fst.d $f17, \base, SC_FPR17
+	EX	fst.d $f18, \base, SC_FPR18
+	EX	fst.d $f19, \base, SC_FPR19
+	EX	fst.d $f20, \base, SC_FPR20
+	EX	fst.d $f21, \base, SC_FPR21
+	EX	fst.d $f22, \base, SC_FPR22
+	EX	fst.d $f23, \base, SC_FPR23
+	EX	fst.d $f24, \base, SC_FPR24
+	EX	fst.d $f25, \base, SC_FPR25
+	EX	fst.d $f26, \base, SC_FPR26
+	EX	fst.d $f27, \base, SC_FPR27
+	EX	fst.d $f28, \base, SC_FPR28
+	EX	fst.d $f29, \base, SC_FPR29
+	EX	fst.d $f30, \base, SC_FPR30
+	EX	fst.d $f31, \base, SC_FPR31
+	.endm
+
+	.macro sc_restore_fp base
+	EX	fld.d $f0,  \base, SC_FPR0
+	EX	fld.d $f1,  \base, SC_FPR1
+	EX	fld.d $f2,  \base, SC_FPR2
+	EX	fld.d $f3,  \base, SC_FPR3
+	EX	fld.d $f4,  \base, SC_FPR4
+	EX	fld.d $f5,  \base, SC_FPR5
+	EX	fld.d $f6,  \base, SC_FPR6
+	EX	fld.d $f7,  \base, SC_FPR7
+	EX	fld.d $f8,  \base, SC_FPR8
+	EX	fld.d $f9,  \base, SC_FPR9
+	EX	fld.d $f10, \base, SC_FPR10
+	EX	fld.d $f11, \base, SC_FPR11
+	EX	fld.d $f12, \base, SC_FPR12
+	EX	fld.d $f13, \base, SC_FPR13
+	EX	fld.d $f14, \base, SC_FPR14
+	EX	fld.d $f15, \base, SC_FPR15
+	EX	fld.d $f16, \base, SC_FPR16
+	EX	fld.d $f17, \base, SC_FPR17
+	EX	fld.d $f18, \base, SC_FPR18
+	EX	fld.d $f19, \base, SC_FPR19
+	EX	fld.d $f20, \base, SC_FPR20
+	EX	fld.d $f21, \base, SC_FPR21
+	EX	fld.d $f22, \base, SC_FPR22
+	EX	fld.d $f23, \base, SC_FPR23
+	EX	fld.d $f24, \base, SC_FPR24
+	EX	fld.d $f25, \base, SC_FPR25
+	EX	fld.d $f26, \base, SC_FPR26
+	EX	fld.d $f27, \base, SC_FPR27
+	EX	fld.d $f28, \base, SC_FPR28
+	EX	fld.d $f29, \base, SC_FPR29
+	EX	fld.d $f30, \base, SC_FPR30
+	EX	fld.d $f31, \base, SC_FPR31
+	.endm
+
+	.macro sc_save_fcc base, tmp0, tmp1
+	movcf2gr	\tmp0, $fcc0
+	move	\tmp1, \tmp0
+	movcf2gr	\tmp0, $fcc1
+	bstrins.d	\tmp1, \tmp0, 15, 8
+	movcf2gr	\tmp0, $fcc2
+	bstrins.d	\tmp1, \tmp0, 23, 16
+	movcf2gr	\tmp0, $fcc3
+	bstrins.d	\tmp1, \tmp0, 31, 24
+	movcf2gr	\tmp0, $fcc4
+	bstrins.d	\tmp1, \tmp0, 39, 32
+	movcf2gr	\tmp0, $fcc5
+	bstrins.d	\tmp1, \tmp0, 47, 40
+	movcf2gr	\tmp0, $fcc6
+	bstrins.d	\tmp1, \tmp0, 55, 48
+	movcf2gr	\tmp0, $fcc7
+	bstrins.d	\tmp1, \tmp0, 63, 56
+	EX	st.d \tmp1, \base, 0
+	.endm
+
+	.macro sc_restore_fcc base, tmp0, tmp1
+	EX	ld.d \tmp0, \base, 0
+	bstrpick.d	\tmp1, \tmp0, 7, 0
+	movgr2cf	$fcc0, \tmp1
+	bstrpick.d	\tmp1, \tmp0, 15, 8
+	movgr2cf	$fcc1, \tmp1
+	bstrpick.d	\tmp1, \tmp0, 23, 16
+	movgr2cf	$fcc2, \tmp1
+	bstrpick.d	\tmp1, \tmp0, 31, 24
+	movgr2cf	$fcc3, \tmp1
+	bstrpick.d	\tmp1, \tmp0, 39, 32
+	movgr2cf	$fcc4, \tmp1
+	bstrpick.d	\tmp1, \tmp0, 47, 40
+	movgr2cf	$fcc5, \tmp1
+	bstrpick.d	\tmp1, \tmp0, 55, 48
+	movgr2cf	$fcc6, \tmp1
+	bstrpick.d	\tmp1, \tmp0, 63, 56
+	movgr2cf	$fcc7, \tmp1
+	.endm
+
+	.macro sc_save_fcsr base, tmp0
+	movfcsr2gr	\tmp0, fcsr0
+	EX	st.w \tmp0, \base, 0
+	.endm
+
+	.macro sc_restore_fcsr base, tmp0
+	EX	ld.w \tmp0, \base, 0
+	movgr2fcsr	fcsr0, \tmp0
+	.endm
+
+	.macro sc_save_vcsr base, tmp0
+	movfcsr2gr	\tmp0, vcsr16
+	EX	st.w \tmp0, \base, 0
+	.endm
+
+	.macro sc_restore_vcsr base, tmp0
+	EX	ld.w \tmp0, \base, 0
+	movgr2fcsr	vcsr16, \tmp0
+	.endm
+
+/*
+ * Save a thread's fp context.
+ */
+SYM_FUNC_START(_save_fp)
+	fpu_save_double a0 t1			# clobbers t1
+	fpu_save_csr	a0 t1
+	fpu_save_cc	a0 t1 t2		# clobbers t1, t2
+	jirl zero, ra, 0
+SYM_FUNC_END(_save_fp)
+EXPORT_SYMBOL(_save_fp)
+
+/*
+ * Restore a thread's fp context.
+ */
+SYM_FUNC_START(_restore_fp)
+	fpu_restore_double a0 t1		# clobbers t1
+	fpu_restore_csr	a0 t1
+	fpu_restore_cc	a0 t1 t2		# clobbers t1, t2
+	jirl zero, ra, 0
+SYM_FUNC_END(_restore_fp)
+
+/*
+ * Load the FPU with signalling NANS.  This bit pattern we're using has
+ * the property that no matter whether considered as single or as double
+ * precision represents signaling NANS.
+ *
+ * The value to initialize fcsr0 to comes in $a0.
+ */
+
+SYM_FUNC_START(_init_fpu)
+	csrrd	t0, LOONGARCH_CSR_EUEN
+	li.w	t1, CSR_EUEN_FPEN
+	or	t0, t0, t1
+	csrwr	t0, LOONGARCH_CSR_EUEN
+
+	movgr2fcsr	fcsr0, a0
+
+	li.w	t1, -1				# SNaN
+
+	movgr2fr.d	$f0, t1
+	movgr2fr.d	$f1, t1
+	movgr2fr.d	$f2, t1
+	movgr2fr.d	$f3, t1
+	movgr2fr.d	$f4, t1
+	movgr2fr.d	$f5, t1
+	movgr2fr.d	$f6, t1
+	movgr2fr.d	$f7, t1
+	movgr2fr.d	$f8, t1
+	movgr2fr.d	$f9, t1
+	movgr2fr.d	$f10, t1
+	movgr2fr.d	$f11, t1
+	movgr2fr.d	$f12, t1
+	movgr2fr.d	$f13, t1
+	movgr2fr.d	$f14, t1
+	movgr2fr.d	$f15, t1
+	movgr2fr.d	$f16, t1
+	movgr2fr.d	$f17, t1
+	movgr2fr.d	$f18, t1
+	movgr2fr.d	$f19, t1
+	movgr2fr.d	$f20, t1
+	movgr2fr.d	$f21, t1
+	movgr2fr.d	$f22, t1
+	movgr2fr.d	$f23, t1
+	movgr2fr.d	$f24, t1
+	movgr2fr.d	$f25, t1
+	movgr2fr.d	$f26, t1
+	movgr2fr.d	$f27, t1
+	movgr2fr.d	$f28, t1
+	movgr2fr.d	$f29, t1
+	movgr2fr.d	$f30, t1
+	movgr2fr.d	$f31, t1
+
+	jirl zero, ra, 0
+SYM_FUNC_END(_init_fpu)
+
+/*
+ * a0: fpregs
+ * a1: fcc
+ * a2: fcsr
+ */
+SYM_FUNC_START(_save_fp_context)
+	sc_save_fp a0
+	sc_save_fcc a1 t1 t2
+	sc_save_fcsr a2 t1
+	li.w	a0, 0					# success
+	jirl zero, ra, 0
+SYM_FUNC_END(_save_fp_context)
+
+/*
+ * a0: fpregs
+ * a1: fcc
+ * a2: fcsr
+ */
+SYM_FUNC_START(_restore_fp_context)
+	sc_restore_fp a0
+	sc_restore_fcc a1 t1 t2
+	sc_restore_fcsr a2 t1
+	li.w	a0, 0					# success
+	jirl zero, ra, 0
+SYM_FUNC_END(_restore_fp_context)
+
+	.type	fault, @function
+fault:	li.w	a0, -EFAULT				# failure
+	jirl zero, ra, 0
diff --git a/arch/loongarch/kernel/idle.c b/arch/loongarch/kernel/idle.c
new file mode 100644
index 000000000000..f85b64b8b1f7
--- /dev/null
+++ b/arch/loongarch/kernel/idle.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LoongArch idle loop support.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/cpu.h>
+#include <linux/export.h>
+#include <linux/irqflags.h>
+#include <asm/cpu.h>
+#include <asm/idle.h>
+
+void arch_cpu_idle(void)
+{
+	local_irq_enable();
+	__arch_cpu_idle();
+}
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
new file mode 100644
index 000000000000..214528503b8b
--- /dev/null
+++ b/arch/loongarch/kernel/process.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/task.h>
+#include <linux/sched/task_stack.h>
+#include <linux/tick.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/export.h>
+#include <linux/ptrace.h>
+#include <linux/mman.h>
+#include <linux/personality.h>
+#include <linux/sys.h>
+#include <linux/init.h>
+#include <linux/completion.h>
+#include <linux/kallsyms.h>
+#include <linux/random.h>
+#include <linux/prctl.h>
+#include <linux/nmi.h>
+#include <linux/cpu.h>
+
+#include <asm/abi.h>
+#include <asm/asm.h>
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+#include <asm/fpu.h>
+#include <asm/irq.h>
+#include <asm/pgtable.h>
+#include <asm/loongarchregs.h>
+#include <asm/processor.h>
+#include <asm/reg.h>
+#include <asm/io.h>
+#include <asm/elf.h>
+#include <asm/inst.h>
+#include <asm/irq_regs.h>
+
+/*
+ * Idle related variables and functions
+ */
+
+unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
+EXPORT_SYMBOL(boot_option_idle_override);
+
+#ifdef CONFIG_HOTPLUG_CPU
+void arch_cpu_idle_dead(void)
+{
+	play_dead();
+}
+#endif
+
+asmlinkage void ret_from_fork(void);
+asmlinkage void ret_from_kernel_thread(void);
+
+void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
+{
+	unsigned long crmd;
+	unsigned long prmd;
+	unsigned long euen;
+
+	/* New thread loses kernel privileges. */
+	crmd = regs->csr_crmd & ~(PLV_MASK);
+	crmd |= PLV_USER;
+	regs->csr_crmd = crmd;
+
+	prmd = regs->csr_prmd & ~(PLV_MASK);
+	prmd |= PLV_USER;
+	regs->csr_prmd = prmd;
+
+	euen = regs->csr_euen & ~(CSR_EUEN_FPEN);
+	regs->csr_euen = euen;
+	lose_fpu(0);
+
+	clear_thread_flag(TIF_LSX_CTX_LIVE);
+	clear_thread_flag(TIF_LASX_CTX_LIVE);
+	clear_used_math();
+	regs->csr_epc = pc;
+	regs->regs[3] = sp;
+}
+
+void exit_thread(struct task_struct *tsk)
+{
+}
+
+int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
+{
+	/*
+	 * Save any process state which is live in hardware registers to the
+	 * parent context prior to duplication. This prevents the new child
+	 * state becoming stale if the parent is preempted before copy_thread()
+	 * gets a chance to save the parent's live hardware registers to the
+	 * child context.
+	 */
+	preempt_disable();
+
+	if (is_fpu_owner())
+		save_fp(current);
+
+	preempt_enable();
+
+	if (used_math())
+		memcpy(dst, src, sizeof(struct task_struct));
+	else
+		memcpy(dst, src, offsetof(struct task_struct, thread.fpu.fpr));
+
+	return 0;
+}
+
+/*
+ * Copy architecture-specific thread state
+ */
+int copy_thread(unsigned long clone_flags, unsigned long usp,
+	unsigned long kthread_arg, struct task_struct *p, unsigned long tls)
+{
+	unsigned long childksp;
+	struct pt_regs *childregs, *regs = current_pt_regs();
+
+	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
+
+	/* set up new TSS. */
+	childregs = (struct pt_regs *) childksp - 1;
+	/*  Put the stack after the struct pt_regs.  */
+	childksp = (unsigned long) childregs;
+	p->thread.csr_euen = 0;
+	p->thread.csr_crmd = csr_readl(LOONGARCH_CSR_CRMD);
+	p->thread.csr_prmd = csr_readl(LOONGARCH_CSR_PRMD);
+	p->thread.csr_ecfg = csr_readl(LOONGARCH_CSR_ECFG);
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		/* kernel thread */
+		unsigned long csr_crmd = p->thread.csr_crmd;
+		unsigned long csr_euen = p->thread.csr_euen;
+		unsigned long csr_prmd = p->thread.csr_prmd;
+		unsigned long csr_ecfg = p->thread.csr_ecfg;
+
+		memset(childregs, 0, sizeof(struct pt_regs));
+		p->thread.reg23 = usp; /* fn */
+		p->thread.reg24 = kthread_arg;
+		p->thread.reg03 = childksp;
+		p->thread.reg01 = (unsigned long) ret_from_kernel_thread;
+		childregs->csr_euen = csr_euen;
+		childregs->csr_prmd = csr_prmd;
+		childregs->csr_ecfg = csr_ecfg;
+		childregs->csr_crmd = csr_crmd;
+		return 0;
+	}
+
+	/* user thread */
+	*childregs = *regs;
+	childregs->regs[7] = 0; /* Clear error flag */
+	childregs->regs[4] = 0; /* Child gets zero as return value */
+	if (usp)
+		childregs->regs[3] = usp;
+
+	p->thread.reg03 = (unsigned long) childregs;
+	p->thread.reg01 = (unsigned long) ret_from_fork;
+
+	/*
+	 * New tasks lose permission to use the fpu. This accelerates context
+	 * switching for most programs since they don't use the fpu.
+	 */
+	childregs->csr_euen = 0;
+
+	clear_tsk_thread_flag(p, TIF_USEDFPU);
+	clear_tsk_thread_flag(p, TIF_USEDSIMD);
+	clear_tsk_thread_flag(p, TIF_LSX_CTX_LIVE);
+	clear_tsk_thread_flag(p, TIF_LASX_CTX_LIVE);
+
+	if (clone_flags & CLONE_SETTLS)
+		childregs->regs[2] = tls;
+
+	return 0;
+}
+
+unsigned long get_wchan(struct task_struct *task)
+{
+	return 0;
+}
+
+unsigned long stack_top(void)
+{
+	unsigned long top = TASK_SIZE & PAGE_MASK;
+
+	/* Space for the VDSO & data page */
+	top -= PAGE_ALIGN(current->thread.abi->vdso->size);
+	top -= PAGE_SIZE;
+
+	/* Space to randomize the VDSO base */
+	if (current->flags & PF_RANDOMIZE)
+		top -= VDSO_RANDOMIZE_SIZE;
+
+	return top;
+}
+
+/*
+ * Don't forget that the stack pointer must be aligned on a 8 bytes
+ * boundary for 32-bits ABI and 16 bytes for 64-bits ABI.
+ */
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+		sp -= get_random_int() & ~PAGE_MASK;
+
+	return sp & ALMASK;
+}
+
+static DEFINE_PER_CPU(call_single_data_t, backtrace_csd);
+static struct cpumask backtrace_csd_busy;
+
+static void handle_backtrace(void *info)
+{
+	nmi_cpu_backtrace(get_irq_regs());
+	cpumask_clear_cpu(smp_processor_id(), &backtrace_csd_busy);
+}
+
+static void raise_backtrace(cpumask_t *mask)
+{
+	call_single_data_t *csd;
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		/*
+		 * If we previously sent an IPI to the target CPU & it hasn't
+		 * cleared its bit in the busy cpumask then it didn't handle
+		 * our previous IPI & it's not safe for us to reuse the
+		 * call_single_data_t.
+		 */
+		if (cpumask_test_and_set_cpu(cpu, &backtrace_csd_busy)) {
+			pr_warn("Unable to send backtrace IPI to CPU%u - perhaps it hung?\n",
+				cpu);
+			continue;
+		}
+
+		csd = &per_cpu(backtrace_csd, cpu);
+		csd->func = handle_backtrace;
+		smp_call_function_single_async(cpu, csd);
+	}
+}
+
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace);
+}
+
+#ifdef CONFIG_64BIT
+void loongarch_dump_regs64(u64 *uregs, const struct pt_regs *regs)
+{
+	unsigned int i;
+
+	for (i = LOONGARCH64_EF_R1; i <= LOONGARCH64_EF_R31; i++) {
+		uregs[i] = regs->regs[i - LOONGARCH64_EF_R0];
+	}
+
+	uregs[LOONGARCH64_EF_CSR_EPC] = regs->csr_epc;
+	uregs[LOONGARCH64_EF_CSR_BADVADDR] = regs->csr_badvaddr;
+	uregs[LOONGARCH64_EF_CSR_CRMD] = regs->csr_crmd;
+	uregs[LOONGARCH64_EF_CSR_PRMD] = regs->csr_prmd;
+	uregs[LOONGARCH64_EF_CSR_EUEN] = regs->csr_euen;
+	uregs[LOONGARCH64_EF_CSR_ECFG] = regs->csr_ecfg;
+	uregs[LOONGARCH64_EF_CSR_ESTAT] = regs->csr_estat;
+}
+#endif /* CONFIG_64BIT */
diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
new file mode 100644
index 000000000000..fa0def6a67cd
--- /dev/null
+++ b/arch/loongarch/kernel/ptrace.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/compiler.h>
+#include <linux/context_tracking.h>
+#include <linux/elf.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/ptrace.h>
+#include <linux/regset.h>
+#include <linux/smp.h>
+#include <linux/security.h>
+#include <linux/stddef.h>
+#include <linux/tracehook.h>
+#include <linux/audit.h>
+#include <linux/seccomp.h>
+#include <linux/ftrace.h>
+
+#include <asm/byteorder.h>
+#include <asm/cpu.h>
+#include <asm/cpu-info.h>
+#include <asm/fpu.h>
+#include <asm/loongarchregs.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/syscall.h>
+#include <linux/uaccess.h>
+#include <asm/bootinfo.h>
+#include <asm/reg.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
+static void init_fp_ctx(struct task_struct *target)
+{
+	/* The target already has context */
+	if (tsk_used_math(target))
+		return;
+
+	/* Begin with data registers set to all 1s... */
+	memset(&target->thread.fpu.fpr, ~0, sizeof(target->thread.fpu.fpr));
+	set_stopped_child_used_math(target);
+}
+
+/*
+ * Called by kernel/ptrace.c when detaching..
+ *
+ * Make sure single step bits etc are not set.
+ */
+void ptrace_disable(struct task_struct *child)
+{
+	/* Don't load the watchpoint registers for the ex-child. */
+	clear_tsk_thread_flag(child, TIF_LOAD_WATCH);
+}
+
+/* regset get/set implementations */
+
+static int gpr_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   struct membuf to)
+{
+	int r;
+	struct pt_regs *regs = task_pt_regs(target);
+
+	r = membuf_write(&to, &regs->regs, sizeof(u64) * GPR_NUM);
+	r = membuf_write(&to, &regs->csr_epc, sizeof(u64));
+	r = membuf_write(&to, &regs->csr_badvaddr, sizeof(u64));
+
+	return r;
+}
+
+static int gpr_set(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	int err;
+	int epc_start = sizeof(u64) * GPR_NUM;
+	int badvaddr_start = epc_start + sizeof(u64);
+	struct pt_regs *regs = task_pt_regs(target);
+
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &regs->regs,
+				 0, epc_start);
+	err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &regs->csr_epc,
+				 epc_start, epc_start + sizeof(u64));
+	err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &regs->csr_badvaddr,
+				 badvaddr_start, badvaddr_start + sizeof(u64));
+
+	return err;
+}
+
+
+/*
+ * Get the general floating-point registers.
+ */
+static int gfpr_get(struct task_struct *target, struct membuf *to)
+{
+	return membuf_write(to, &target->thread.fpu, sizeof(elf_fpreg_t) * NUM_FPU_REGS);
+}
+
+static int gfpr_get_simd(struct task_struct *target, struct membuf *to)
+{
+	int i, r;
+	u64 fpr_val;
+
+	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
+		r = membuf_write(to, &fpr_val, sizeof(elf_fpreg_t));
+	}
+
+	return r;
+}
+
+/*
+ * Choose the appropriate helper for general registers, and then copy
+ * the FCC and FCSR registers separately.
+ */
+static int fpr_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   struct membuf to)
+{
+	int r;
+
+	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
+		r = gfpr_get(target, &to);
+	else
+		r = gfpr_get_simd(target, &to);
+
+	r = membuf_write(&to, &target->thread.fpu.fcc, sizeof(target->thread.fpu.fcc));
+	r = membuf_write(&to, &target->thread.fpu.fcsr, sizeof(target->thread.fpu.fcsr));
+
+	return r;
+}
+
+static int gfpr_set(struct task_struct *target,
+		    unsigned int *pos, unsigned int *count,
+		    const void **kbuf, const void __user **ubuf)
+{
+	return user_regset_copyin(pos, count, kbuf, ubuf,
+				  &target->thread.fpu,
+				  0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
+}
+
+static int gfpr_set_simd(struct task_struct *target,
+		       unsigned int *pos, unsigned int *count,
+		       const void **kbuf, const void __user **ubuf)
+{
+	int i, err;
+	u64 fpr_val;
+
+	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
+	for (i = 0; i < NUM_FPU_REGS && *count > 0; i++) {
+		err = user_regset_copyin(pos, count, kbuf, ubuf,
+					 &fpr_val, i * sizeof(elf_fpreg_t),
+					 (i + 1) * sizeof(elf_fpreg_t));
+		if (err)
+			return err;
+		set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
+	}
+
+	return 0;
+}
+
+/*
+ * Choose the appropriate helper for general registers, and then copy
+ * the FCC register separately.
+ */
+static int fpr_set(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	const int fcc_start = NUM_FPU_REGS * sizeof(elf_fpreg_t);
+	const int fcc_end = fcc_start + sizeof(u64);
+	int err;
+
+	BUG_ON(count % sizeof(elf_fpreg_t));
+	if (pos + count > sizeof(elf_fpregset_t))
+		return -EIO;
+
+	init_fp_ctx(target);
+
+	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
+		err = gfpr_set(target, &pos, &count, &kbuf, &ubuf);
+	else
+		err = gfpr_set_simd(target, &pos, &count, &kbuf, &ubuf);
+	if (err)
+		return err;
+
+	if (count > 0)
+		err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					  &target->thread.fpu.fcc,
+					  fcc_start, fcc_end);
+
+	return err;
+}
+
+static int cfg_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   struct membuf to)
+{
+	int i, r;
+	u32 cfg_val;
+
+	i = 0;
+	while (to.left > 0) {
+		cfg_val = read_cpucfg(i++);
+		r = membuf_write(&to, &cfg_val, sizeof(u32));
+	}
+
+	return r;
+}
+
+/*
+ * CFG registers are read-only.
+ */
+static int cfg_set(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	return 0;
+}
+
+struct pt_regs_offset {
+	const char *name;
+	int offset;
+};
+
+#define REG_OFFSET_NAME(n, r) {.name = #n, .offset = offsetof(struct pt_regs, r)}
+#define REG_OFFSET_END {.name = NULL, .offset = 0}
+
+static const struct pt_regs_offset regoffset_table[] = {
+	REG_OFFSET_NAME(r0, regs[0]),
+	REG_OFFSET_NAME(r1, regs[1]),
+	REG_OFFSET_NAME(r2, regs[2]),
+	REG_OFFSET_NAME(r3, regs[3]),
+	REG_OFFSET_NAME(r4, regs[4]),
+	REG_OFFSET_NAME(r5, regs[5]),
+	REG_OFFSET_NAME(r6, regs[6]),
+	REG_OFFSET_NAME(r7, regs[7]),
+	REG_OFFSET_NAME(r8, regs[8]),
+	REG_OFFSET_NAME(r9, regs[9]),
+	REG_OFFSET_NAME(r10, regs[10]),
+	REG_OFFSET_NAME(r11, regs[11]),
+	REG_OFFSET_NAME(r12, regs[12]),
+	REG_OFFSET_NAME(r13, regs[13]),
+	REG_OFFSET_NAME(r14, regs[14]),
+	REG_OFFSET_NAME(r15, regs[15]),
+	REG_OFFSET_NAME(r16, regs[16]),
+	REG_OFFSET_NAME(r17, regs[17]),
+	REG_OFFSET_NAME(r18, regs[18]),
+	REG_OFFSET_NAME(r19, regs[19]),
+	REG_OFFSET_NAME(r20, regs[20]),
+	REG_OFFSET_NAME(r21, regs[21]),
+	REG_OFFSET_NAME(r22, regs[22]),
+	REG_OFFSET_NAME(r23, regs[23]),
+	REG_OFFSET_NAME(r24, regs[24]),
+	REG_OFFSET_NAME(r25, regs[25]),
+	REG_OFFSET_NAME(r26, regs[26]),
+	REG_OFFSET_NAME(r27, regs[27]),
+	REG_OFFSET_NAME(r28, regs[28]),
+	REG_OFFSET_NAME(r29, regs[29]),
+	REG_OFFSET_NAME(r30, regs[30]),
+	REG_OFFSET_NAME(r31, regs[31]),
+	REG_OFFSET_NAME(csr_crmd, csr_crmd),
+	REG_OFFSET_NAME(csr_prmd, csr_prmd),
+	REG_OFFSET_NAME(csr_euen, csr_euen),
+	REG_OFFSET_NAME(csr_ecfg, csr_ecfg),
+	REG_OFFSET_NAME(csr_estat, csr_estat),
+	REG_OFFSET_NAME(csr_epc, csr_epc),
+	REG_OFFSET_NAME(csr_badvaddr, csr_badvaddr),
+	REG_OFFSET_END,
+};
+
+/**
+ * regs_query_register_offset() - query register offset from its name
+ * @name:       the name of a register
+ *
+ * regs_query_register_offset() returns the offset of a register in struct
+ * pt_regs from its name. If the name is invalid, this returns -EINVAL;
+ */
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_offset *roff;
+
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return roff->offset;
+	return -EINVAL;
+}
+
+enum loongarch_regset {
+	REGSET_GPR,
+	REGSET_FPR,
+	REGSET_CPUCFG,
+};
+
+static const struct user_regset loongarch64_regsets[] = {
+	[REGSET_GPR] = {
+		.core_note_type	= NT_PRSTATUS,
+		.n		= ELF_NGREG,
+		.size		= sizeof(elf_greg_t),
+		.align		= sizeof(elf_greg_t),
+		.regset_get	= gpr_get,
+		.set		= gpr_set,
+	},
+	[REGSET_FPR] = {
+		.core_note_type	= NT_PRFPREG,
+		.n		= ELF_NFPREG,
+		.size		= sizeof(elf_fpreg_t),
+		.align		= sizeof(elf_fpreg_t),
+		.regset_get	= fpr_get,
+		.set		= fpr_set,
+	},
+	[REGSET_CPUCFG] = {
+		.core_note_type	= NT_LOONGARCH_CPUCFG,
+		.n		= 64,
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.regset_get	= cfg_get,
+		.set		= cfg_set,
+	},
+};
+
+static const struct user_regset_view user_loongarch64_view = {
+	.name		= "loongarch64",
+	.e_machine	= ELF_ARCH,
+	.regsets	= loongarch64_regsets,
+	.n		= ARRAY_SIZE(loongarch64_regsets),
+};
+
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &user_loongarch64_view;
+}
+
+static inline int read_user(struct task_struct *target, unsigned long addr,
+			    unsigned long __user *data)
+{
+	unsigned long tmp = 0;
+
+	switch (addr) {
+	case 0 ... 31:
+		tmp = task_pt_regs(target)->regs[addr];
+		break;
+	case PC:
+		tmp = task_pt_regs(target)->csr_epc;
+		break;
+	case BADVADDR:
+		tmp = task_pt_regs(target)->csr_badvaddr;
+		break;
+	default:
+		return -EIO;
+	}
+
+	return put_user(tmp, data);
+}
+
+static inline int write_user(struct task_struct *target, unsigned long addr,
+			    unsigned long data)
+{
+	switch (addr) {
+	case 0 ... 31:
+		task_pt_regs(target)->regs[addr] = data;
+		break;
+	case PC:
+		task_pt_regs(target)->csr_epc = data;
+		break;
+	case BADVADDR:
+		task_pt_regs(target)->csr_badvaddr = data;
+		break;
+	default:
+		return -EIO;
+	}
+
+	return 0;
+}
+
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
+{
+	int ret;
+	unsigned long __user *datap = (void __user *) data;
+
+	switch (request) {
+	case PTRACE_PEEKUSR:
+		ret = read_user(child, addr, datap);
+		break;
+
+	case PTRACE_POKEUSR:
+		ret = write_user(child, addr, data);
+		break;
+
+	default:
+		ret = ptrace_request(child, request, addr, data);
+		break;
+	}
+
+	return ret;
+}
+
+asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
+{
+	user_exit();
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		if (tracehook_report_syscall_entry(regs))
+			syscall_set_nr(current, regs, -1);
+
+#ifdef CONFIG_SECCOMP
+	if (secure_computing() == -1)
+		return -1;
+#endif
+
+	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
+		trace_sys_enter(regs, syscall);
+
+	audit_syscall_entry(syscall, regs->regs[4], regs->regs[5],
+			    regs->regs[6], regs->regs[7]);
+
+	/* set errno for negative syscall number. */
+	if (syscall < 0)
+		syscall_set_return_value(current, regs, -ENOSYS, 0);
+	return syscall;
+}
+
+asmlinkage void syscall_trace_leave(struct pt_regs *regs)
+{
+	/*
+	 * We may come here right after calling schedule_user()
+	 * or do_notify_resume(), in which case we can be in RCU
+	 * user mode.
+	 */
+	user_exit();
+
+	audit_syscall_exit(regs);
+
+	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
+		trace_sys_exit(regs, regs_return_value(regs));
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall_exit(regs, 0);
+
+	user_enter();
+}
diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
new file mode 100644
index 000000000000..0955d9938044
--- /dev/null
+++ b/arch/loongarch/kernel/switch.S
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <asm/asm.h>
+#include <asm/loongarchregs.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/thread_info.h>
+
+#include <asm/asmmacro.h>
+
+/*
+ * task_struct *resume(task_struct *prev, task_struct *next,
+ *		       struct thread_info *next_ti)
+ */
+	.align	5
+SYM_FUNC_START(resume)
+	csrrd	t1, LOONGARCH_CSR_PRMD
+	stptr.d	t1, a0, THREAD_CSRPRMD
+	csrrd	t1, LOONGARCH_CSR_CRMD
+	stptr.d	t1, a0, THREAD_CSRCRMD
+	csrrd	t1, LOONGARCH_CSR_ECFG
+	stptr.d	t1, a0, THREAD_CSRECFG
+	csrrd	t1, LOONGARCH_CSR_EUEN
+	stptr.d	t1, a0, THREAD_CSREUEN
+	cpu_save_nonscratch a0
+	stptr.d	ra, a0, THREAD_REG01
+
+	/*
+	 * The order of restoring the registers takes care of the race
+	 * updating $28, $29 and kernelsp without disabling ints.
+	 */
+	move	tp, a2
+	cpu_restore_nonscratch a1
+
+	li.w	t0, _THREAD_SIZE - 32
+	PTR_ADDU	t0, t0, tp
+	set_saved_sp	t0, t1, t2
+
+	ldptr.d	t1, a1, THREAD_CSRPRMD
+	csrwr	t1, LOONGARCH_CSR_PRMD
+	ldptr.d	t1, a1, THREAD_CSREUEN
+	csrwr	t1, LOONGARCH_CSR_EUEN
+
+	jr	ra
+SYM_FUNC_END(resume)
-- 
2.27.0

