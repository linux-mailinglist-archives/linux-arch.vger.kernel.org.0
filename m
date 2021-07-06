Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8673BC534
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGFEVS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEVR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:21:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 528126198E;
        Tue,  6 Jul 2021 04:18:36 +0000 (UTC)
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
Subject: [PATCH 06/19] LoongArch: Add exception/interrupt handling
Date:   Tue,  6 Jul 2021 12:18:07 +0800
Message-Id: <20210706041820.1536502-7-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds the exception and interrupt handling machanism for
LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/branch.h     |  21 +
 arch/loongarch/include/asm/break.h      |  10 +
 arch/loongarch/include/asm/bug.h        |  23 +
 arch/loongarch/include/asm/debug.h      |  18 +
 arch/loongarch/include/asm/hardirq.h    |  24 +
 arch/loongarch/include/asm/hw_irq.h     |  17 +
 arch/loongarch/include/asm/irq.h        |  53 ++
 arch/loongarch/include/asm/irq_regs.h   |  27 +
 arch/loongarch/include/asm/irqflags.h   |  52 ++
 arch/loongarch/include/asm/kdebug.h     |  23 +
 arch/loongarch/include/asm/stackframe.h | 240 ++++++++
 arch/loongarch/include/uapi/asm/break.h |  23 +
 arch/loongarch/kernel/access-helper.h   |  13 +
 arch/loongarch/kernel/entry.S           | 151 +++++
 arch/loongarch/kernel/genex.S           | 198 +++++++
 arch/loongarch/kernel/irq.c             |  99 ++++
 arch/loongarch/kernel/traps.c           | 717 ++++++++++++++++++++++++
 arch/loongarch/kernel/unaligned.c       | 461 +++++++++++++++
 18 files changed, 2170 insertions(+)
 create mode 100644 arch/loongarch/include/asm/branch.h
 create mode 100644 arch/loongarch/include/asm/break.h
 create mode 100644 arch/loongarch/include/asm/bug.h
 create mode 100644 arch/loongarch/include/asm/debug.h
 create mode 100644 arch/loongarch/include/asm/hardirq.h
 create mode 100644 arch/loongarch/include/asm/hw_irq.h
 create mode 100644 arch/loongarch/include/asm/irq.h
 create mode 100644 arch/loongarch/include/asm/irq_regs.h
 create mode 100644 arch/loongarch/include/asm/irqflags.h
 create mode 100644 arch/loongarch/include/asm/kdebug.h
 create mode 100644 arch/loongarch/include/asm/stackframe.h
 create mode 100644 arch/loongarch/include/uapi/asm/break.h
 create mode 100644 arch/loongarch/kernel/access-helper.h
 create mode 100644 arch/loongarch/kernel/entry.S
 create mode 100644 arch/loongarch/kernel/genex.S
 create mode 100644 arch/loongarch/kernel/irq.c
 create mode 100644 arch/loongarch/kernel/traps.c
 create mode 100644 arch/loongarch/kernel/unaligned.c

diff --git a/arch/loongarch/include/asm/branch.h b/arch/loongarch/include/asm/branch.h
new file mode 100644
index 000000000000..79121306625d
--- /dev/null
+++ b/arch/loongarch/include/asm/branch.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_BRANCH_H
+#define _ASM_BRANCH_H
+
+#include <asm/ptrace.h>
+
+static inline unsigned long exception_epc(struct pt_regs *regs)
+{
+	return regs->csr_epc;
+}
+
+static inline int compute_return_epc(struct pt_regs *regs)
+{
+	regs->csr_epc += 4;
+	return 0;
+}
+
+#endif /* _ASM_BRANCH_H */
diff --git a/arch/loongarch/include/asm/break.h b/arch/loongarch/include/asm/break.h
new file mode 100644
index 000000000000..109d0c85c582
--- /dev/null
+++ b/arch/loongarch/include/asm/break.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_BREAK_H
+#define __ASM_BREAK_H
+
+#include <uapi/asm/break.h>
+
+#endif /* __ASM_BREAK_H */
diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
new file mode 100644
index 000000000000..bda49108a76d
--- /dev/null
+++ b/arch/loongarch/include/asm/bug.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_BUG_H
+#define __ASM_BUG_H
+
+#include <linux/compiler.h>
+
+#ifdef CONFIG_BUG
+
+#include <asm/break.h>
+
+static inline void __noreturn BUG(void)
+{
+	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));
+	unreachable();
+}
+
+#define HAVE_ARCH_BUG
+
+#endif
+
+#include <asm-generic/bug.h>
+
+#endif /* __ASM_BUG_H */
diff --git a/arch/loongarch/include/asm/debug.h b/arch/loongarch/include/asm/debug.h
new file mode 100644
index 000000000000..426d5564304e
--- /dev/null
+++ b/arch/loongarch/include/asm/debug.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef __LOONGARCH_ASM_DEBUG_H__
+#define __LOONGARCH_ASM_DEBUG_H__
+
+#include <linux/dcache.h>
+
+/*
+ * loongarch_debugfs_dir corresponds to the "loongarch" directory at the top
+ * level of the DebugFS hierarchy. LoongArch-specific DebugFS entries should
+ * be placed beneath this directory.
+ */
+extern struct dentry *loongarch_debugfs_dir;
+
+#endif /* __LOONGARCH_ASM_DEBUG_H__ */
diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/include/asm/hardirq.h
new file mode 100644
index 000000000000..ccde14a45f67
--- /dev/null
+++ b/arch/loongarch/include/asm/hardirq.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_HARDIRQ_H
+#define _ASM_HARDIRQ_H
+
+#include <linux/cache.h>
+#include <linux/threads.h>
+#include <linux/irq.h>
+
+extern void ack_bad_irq(unsigned int irq);
+#define ack_bad_irq ack_bad_irq
+
+#define NR_IPI	2
+
+typedef struct {
+	unsigned int ipi_irqs[NR_IPI];
+	unsigned int __softirq_pending;
+} ____cacheline_aligned irq_cpustat_t;
+
+DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
+
+#endif /* _ASM_HARDIRQ_H */
diff --git a/arch/loongarch/include/asm/hw_irq.h b/arch/loongarch/include/asm/hw_irq.h
new file mode 100644
index 000000000000..53cccd8e02a0
--- /dev/null
+++ b/arch/loongarch/include/asm/hw_irq.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_HW_IRQ_H
+#define __ASM_HW_IRQ_H
+
+#include <linux/atomic.h>
+
+extern atomic_t irq_err_count;
+
+/*
+ * interrupt-retrigger: NOP for now. This may not be appropriate for all
+ * machines, we'll see ...
+ */
+
+#endif /* __ASM_HW_IRQ_H */
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
new file mode 100644
index 000000000000..01822ca77065
--- /dev/null
+++ b/arch/loongarch/include/asm/irq.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_IRQ_H
+#define _ASM_IRQ_H
+
+#include <linux/irqdomain.h>
+#include <irq.h>
+#include <asm-generic/irq.h>
+
+#define IRQ_STACK_SIZE			THREAD_SIZE
+#define IRQ_STACK_START			(IRQ_STACK_SIZE - 16)
+
+DECLARE_PER_CPU(unsigned long, irq_stack);
+
+/*
+ * The highest address on the IRQ stack contains a dummy frame put down in
+ * genex.S (except_vec_vi_handler) which is structured as follows:
+ *
+ *   top ------------
+ *       | task sp  | <- irq_stack[cpu] + IRQ_STACK_START
+ *       ------------
+ *       |          | <- First frame of IRQ context
+ *       ------------
+ *
+ * task sp holds a copy of the task stack pointer where the struct pt_regs
+ * from exception entry can be found.
+ */
+
+static inline bool on_irq_stack(int cpu, unsigned long sp)
+{
+	unsigned long low = per_cpu(irq_stack, cpu);
+	unsigned long high = low + IRQ_STACK_SIZE;
+
+	return (low <= sp && sp <= high);
+}
+
+struct irq_data;
+struct device_node;
+
+void arch_init_irq(void);
+void do_IRQ(unsigned int irq);
+void spurious_interrupt(void);
+int loongarch_cpu_irq_init(struct device_node *of_node, struct device_node *parent);
+
+#define NR_IRQS_LEGACY 16
+
+void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
+					bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+
+#endif /* _ASM_IRQ_H */
diff --git a/arch/loongarch/include/asm/irq_regs.h b/arch/loongarch/include/asm/irq_regs.h
new file mode 100644
index 000000000000..359a5bc4eb6b
--- /dev/null
+++ b/arch/loongarch/include/asm/irq_regs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_IRQ_REGS_H
+#define __ASM_IRQ_REGS_H
+
+#define ARCH_HAS_OWN_IRQ_REGS
+
+#include <linux/thread_info.h>
+
+static inline struct pt_regs *get_irq_regs(void)
+{
+	return current_thread_info()->regs;
+}
+
+static inline struct pt_regs *set_irq_regs(struct pt_regs *new_regs)
+{
+	struct pt_regs *old_regs;
+
+	old_regs = get_irq_regs();
+	current_thread_info()->regs = new_regs;
+
+	return old_regs;
+}
+
+#endif /* __ASM_IRQ_REGS_H */
diff --git a/arch/loongarch/include/asm/irqflags.h b/arch/loongarch/include/asm/irqflags.h
new file mode 100644
index 000000000000..7364fb66f217
--- /dev/null
+++ b/arch/loongarch/include/asm/irqflags.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_IRQFLAGS_H
+#define _ASM_IRQFLAGS_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/compiler.h>
+#include <linux/stringify.h>
+#include <asm/compiler.h>
+#include <asm/loongarchregs.h>
+
+static inline void arch_local_irq_enable(void)
+{
+	csr_xchgl(CSR_CRMD_IE, CSR_CRMD_IE, LOONGARCH_CSR_CRMD);
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	csr_xchgl(0, CSR_CRMD_IE, LOONGARCH_CSR_CRMD);
+}
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	return csr_xchgl(0, CSR_CRMD_IE, LOONGARCH_CSR_CRMD);
+}
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	csr_xchgl(flags, CSR_CRMD_IE, LOONGARCH_CSR_CRMD);
+}
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	return csr_readl(LOONGARCH_CSR_CRMD);
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & CSR_CRMD_IE);
+}
+
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+#endif /* #ifndef __ASSEMBLY__ */
+
+#endif /* _ASM_IRQFLAGS_H */
diff --git a/arch/loongarch/include/asm/kdebug.h b/arch/loongarch/include/asm/kdebug.h
new file mode 100644
index 000000000000..beb1d9484e4e
--- /dev/null
+++ b/arch/loongarch/include/asm/kdebug.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_LOONGARCH_KDEBUG_H
+#define _ASM_LOONGARCH_KDEBUG_H
+
+#include <linux/notifier.h>
+
+enum die_val {
+	DIE_OOPS = 1,
+	DIE_RI,
+	DIE_FP,
+	DIE_SIMD,
+	DIE_TRAP,
+	DIE_PAGE_FAULT,
+	DIE_BREAK,
+	DIE_SSTEPBP,
+	DIE_UPROBE,
+	DIE_UPROBE_XOL,
+};
+
+#endif /* _ASM_LOONGARCH_KDEBUG_H */
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
new file mode 100644
index 000000000000..bf0a0ad263b1
--- /dev/null
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -0,0 +1,240 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_STACKFRAME_H
+#define _ASM_STACKFRAME_H
+
+#include <linux/threads.h>
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/asm-offsets.h>
+#include <asm/loongarchregs.h>
+#include <asm/thread_info.h>
+
+/* Make the addition of cfi info a little easier. */
+	.macro cfi_rel_offset reg offset=0 docfi=0
+	.if \docfi
+	.cfi_rel_offset \reg, \offset
+	.endif
+	.endm
+
+	.macro cfi_st reg offset=0 docfi=0
+	cfi_rel_offset \reg, \offset, \docfi
+	LONG_S	\reg, sp, \offset
+	.endm
+
+	.macro cfi_restore reg offset=0 docfi=0
+	.if \docfi
+	.cfi_restore \reg
+	.endif
+	.endm
+
+	.macro cfi_ld reg offset=0 docfi=0
+	LONG_L	\reg, sp, \offset
+	cfi_restore \reg \offset \docfi
+	.endm
+
+	.macro BACKUP_T0T1
+	csrwr	t0, EXCEPTION_KS0
+	csrwr	t1, EXCEPTION_KS1
+	.endm
+
+	.macro RELOAD_T0T1
+	csrrd   t0, EXCEPTION_KS0
+	csrrd   t1, EXCEPTION_KS1
+	.endm
+
+	.macro	SAVE_TEMP docfi=0 reload=1
+	.if \reload
+	RELOAD_T0T1
+	.endif
+	cfi_st	t0, PT_R12, \docfi
+	cfi_st	t1, PT_R13, \docfi
+	cfi_st	t2, PT_R14, \docfi
+	cfi_st	t3, PT_R15, \docfi
+	cfi_st	t4, PT_R16, \docfi
+	cfi_st	t5, PT_R17, \docfi
+	cfi_st	t6, PT_R18, \docfi
+	cfi_st	t7, PT_R19, \docfi
+	cfi_st	t8, PT_R20, \docfi
+	.endm
+
+	.macro	SAVE_STATIC docfi=0
+	cfi_st	s0, PT_R23, \docfi
+	cfi_st	s1, PT_R24, \docfi
+	cfi_st	s2, PT_R25, \docfi
+	cfi_st	s3, PT_R26, \docfi
+	cfi_st	s4, PT_R27, \docfi
+	cfi_st	s5, PT_R28, \docfi
+	cfi_st	s6, PT_R29, \docfi
+	cfi_st	s7, PT_R30, \docfi
+	cfi_st	s8, PT_R31, \docfi
+	.endm
+
+/*
+ * get_saved_sp returns the SP for the current CPU by looking in the
+ * kernelsp array for it.  If tosp is set, it stores the current sp in
+ * t0 and loads the new value in sp.  If not, it clobbers t0 and
+ * stores the new value in t1, leaving sp unaffected.
+ */
+	.macro	get_saved_sp docfi=0 tosp=0
+	la.abs	t1, kernelsp
+	.if \tosp
+	move	t0, sp
+	.if \docfi
+	.cfi_register sp, t0
+	.endif
+	LONG_L	sp, t1, 0
+	.else
+	LONG_L	t1, t1, 0
+	.endif
+	.endm
+
+	.macro	set_saved_sp stackp temp temp2
+	la.abs	\temp, kernelsp
+	LONG_S	\stackp, \temp, 0
+	.endm
+
+	.macro	SAVE_SOME docfi=0
+	csrrd	t1, LOONGARCH_CSR_PRMD
+	andi	t1, t1, 0x3	/* extract pplv bit */
+	move	t0, sp
+	beqz	t1, 8f
+	/* Called from user mode, new stack. */
+	get_saved_sp docfi=\docfi tosp=1
+8:
+	PTR_ADDIU sp, sp, -PT_SIZE
+	.if \docfi
+	.cfi_def_cfa sp, 0
+	.endif
+	cfi_st	t0, PT_R3, \docfi
+	cfi_rel_offset  sp, PT_R3, \docfi
+	LONG_S	zero, sp, PT_R0
+	csrrd	t0, LOONGARCH_CSR_PRMD
+	LONG_S	t0, sp, PT_PRMD
+	csrrd	t0, LOONGARCH_CSR_CRMD
+	LONG_S	t0, sp, PT_CRMD
+	csrrd	t0, LOONGARCH_CSR_ECFG
+	LONG_S	t0, sp, PT_ECFG
+	csrrd	t0, LOONGARCH_CSR_EUEN
+	LONG_S  t0, sp, PT_EUEN
+	cfi_st	ra, PT_R1, \docfi
+	cfi_st	a0, PT_R4, \docfi
+	cfi_st	a1, PT_R5, \docfi
+	cfi_st	a2, PT_R6, \docfi
+	cfi_st	a3, PT_R7, \docfi
+	cfi_st	a4, PT_R8, \docfi
+	cfi_st	a5, PT_R9, \docfi
+	cfi_st	a6, PT_R10, \docfi
+	cfi_st	a7, PT_R11, \docfi
+	csrrd	ra, LOONGARCH_CSR_EPC
+	LONG_S	ra, sp, PT_EPC
+	.if \docfi
+	.cfi_rel_offset ra, PT_EPC
+	.endif
+	cfi_st	tp, PT_R2, \docfi
+	cfi_st	fp, PT_R22, \docfi
+
+	/* Set thread_info if we're coming from user mode */
+	csrrd	t0, LOONGARCH_CSR_PRMD
+	andi	t0, t0, 0x3	/* extract pplv bit */
+	beqz	t0, 9f
+
+	li.d	tp, ~_THREAD_MASK
+	and	tp, tp, sp
+	cfi_st  x0, PT_R21, \docfi
+9:
+	.endm
+
+	.macro	SAVE_ALL docfi=0
+	SAVE_SOME \docfi
+	SAVE_TEMP \docfi
+	SAVE_STATIC \docfi
+	.endm
+
+	.macro	RESTORE_TEMP docfi=0
+	cfi_ld	t0, PT_R12, \docfi
+	cfi_ld	t1, PT_R13, \docfi
+	cfi_ld	t2, PT_R14, \docfi
+	cfi_ld	t3, PT_R15, \docfi
+	cfi_ld	t4, PT_R16, \docfi
+	cfi_ld	t5, PT_R17, \docfi
+	cfi_ld	t6, PT_R18, \docfi
+	cfi_ld	t7, PT_R19, \docfi
+	cfi_ld	t8, PT_R20, \docfi
+	.endm
+
+	.macro	RESTORE_STATIC docfi=0
+	cfi_ld	s0, PT_R23, \docfi
+	cfi_ld	s1, PT_R24, \docfi
+	cfi_ld	s2, PT_R25, \docfi
+	cfi_ld	s3, PT_R26, \docfi
+	cfi_ld	s4, PT_R27, \docfi
+	cfi_ld	s5, PT_R28, \docfi
+	cfi_ld	s6, PT_R29, \docfi
+	cfi_ld	s7, PT_R30, \docfi
+	cfi_ld	s8, PT_R31, \docfi
+	.endm
+
+	.macro	RESTORE_SOME docfi=0
+	/* LoongArch clear IE and PLV */
+	LONG_L	v0, sp, PT_PRMD
+	csrwr	v0, LOONGARCH_CSR_PRMD
+	LONG_L	v0, sp, PT_EPC
+	csrwr	v0, LOONGARCH_CSR_EPC
+	andi    v0, v0, 0x3	/* extract pplv bit */
+	beqz    v0, 8f
+	cfi_ld  x0, PT_R21, \docfi
+8:
+	cfi_ld	ra, PT_R1, \docfi
+	cfi_ld	a0, PT_R4, \docfi
+	cfi_ld	a1, PT_R5, \docfi
+	cfi_ld	a2, PT_R6, \docfi
+	cfi_ld	a3, PT_R7, \docfi
+	cfi_ld	a4, PT_R8, \docfi
+	cfi_ld	a5, PT_R9, \docfi
+	cfi_ld	a6, PT_R10, \docfi
+	cfi_ld	a7, PT_R11, \docfi
+	cfi_ld	tp, PT_R2, \docfi
+	cfi_ld	fp, PT_R22, \docfi
+	.endm
+
+	.macro	RESTORE_SP docfi=0
+	cfi_ld	sp, PT_R3, \docfi
+	.endm
+
+	.macro	RESTORE_SP_AND_RET docfi=0
+	RESTORE_SP \docfi
+	ertn
+	.endm
+
+	.macro	RESTORE_ALL docfi=0
+	RESTORE_TEMP \docfi
+	RESTORE_STATIC \docfi
+	RESTORE_SOME \docfi
+	RESTORE_SP \docfi
+	.endm
+
+/* Move to kernel mode and disable interrupts. */
+	.macro	CLI
+	li.w	t0, 0x7
+	csrxchg	zero, t0, LOONGARCH_CSR_CRMD
+	csrrd	x0, PERCPU_BASE_KS
+	.endm
+
+/* Move to kernel mode and enable interrupts. */
+	.macro	STI
+	li.w	t0, 0x7
+	li.w	t1, (1 << 2)
+	csrxchg	t1, t0, LOONGARCH_CSR_CRMD
+	csrrd	x0, PERCPU_BASE_KS
+	.endm
+
+/* Just move to kernel mode and leave interrupts as they are. */
+	.macro	KMODE
+	csrrd	x0, PERCPU_BASE_KS
+	.endm
+
+#endif /* _ASM_STACKFRAME_H */
diff --git a/arch/loongarch/include/uapi/asm/break.h b/arch/loongarch/include/uapi/asm/break.h
new file mode 100644
index 000000000000..96e8dba56cc3
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/break.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __UAPI_ASM_BREAK_H
+#define __UAPI_ASM_BREAK_H
+
+#define BRK_DEFAULT		0	/* Used as default */
+#define BRK_BUG			1	/* Used by BUG() */
+#define BRK_KDB			2	/* Used in KDB_ENTER() */
+#define BRK_MATHEMU		3	/* Used by FPU emulator */
+#define BRK_USERBP		4	/* User bp (used by debuggers) */
+#define BRK_SSTEPBP		5	/* User bp (used by debuggers) */
+#define BRK_OVERFLOW		6	/* Overflow check */
+#define BRK_DIVZERO		7	/* Divide by zero check */
+#define BRK_RANGE		8	/* Range error check */
+#define BRK_MULOVFL		9	/* Multiply overflow */
+#define BRK_KPROBE_BP		10	/* Kprobe break */
+#define BRK_KPROBE_SSTEPBP	11	/* Kprobe single step break */
+#define BRK_UPROBE_BP		12	/* See <asm/uprobes.h> */
+#define BRK_UPROBE_XOLBP	13	/* See <asm/uprobes.h> */
+
+#endif /* __UAPI_ASM_BREAK_H */
diff --git a/arch/loongarch/kernel/access-helper.h b/arch/loongarch/kernel/access-helper.h
new file mode 100644
index 000000000000..4a35ca81bd08
--- /dev/null
+++ b/arch/loongarch/kernel/access-helper.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/uaccess.h>
+
+static inline int __get_inst(u32 *i, u32 *p, bool user)
+{
+	return user ? get_user(*i, (u32 __user *)p) : get_kernel_nofault(*i, p);
+}
+
+static inline int __get_addr(unsigned long *a, unsigned long *p, bool user)
+{
+	return user ? get_user(*a, (unsigned long __user *)p) : get_kernel_nofault(*a, p);
+}
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
new file mode 100644
index 000000000000..caf56491c63e
--- /dev/null
+++ b/arch/loongarch/kernel/entry.S
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/compiler.h>
+#include <asm/irqflags.h>
+#include <asm/regdef.h>
+#include <asm/loongarchregs.h>
+#include <asm/stackframe.h>
+#include <asm/thread_info.h>
+
+#ifndef CONFIG_PREEMPTION
+#define resume_kernel	restore_all
+#else
+#define __ret_from_irq	ret_from_exception
+#endif
+
+	.text
+	.align	5
+#ifndef CONFIG_PREEMPTION
+SYM_CODE_START(ret_from_exception)
+	local_irq_disable			# preempt stop
+	b	__ret_from_irq
+SYM_CODE_END(ret_from_exception)
+#endif
+SYM_CODE_START(ret_from_irq)
+	LONG_S	s0, tp, TI_REGS
+	b	__ret_from_irq
+SYM_CODE_END(ret_from_irq)
+
+SYM_CODE_START(__ret_from_irq)
+/*
+ * We can be coming here from a syscall done in the kernel space,
+ * e.g. a failed kernel_execve().
+ */
+resume_userspace_check:
+	LONG_L  t0, sp, PT_PRMD # returning to kernel mode?
+	andi    t0, t0, PLV_MASK
+	beqz	t0, resume_kernel
+
+resume_userspace:
+	local_irq_disable		# make sure we dont miss an
+					# interrupt setting need_resched
+					# between sampling and return
+	LONG_L	a2, tp, TI_FLAGS	# current->work
+	andi	t0, a2, _TIF_WORK_MASK	# (ignoring syscall_trace)
+	bnez	t0, work_pending
+	b	restore_all
+SYM_CODE_END(__ret_from_irq)
+
+#ifdef CONFIG_PREEMPTION
+resume_kernel:
+	local_irq_disable
+	ld.w	t0, tp, TI_PRE_COUNT
+	bnez	t0, restore_all
+need_resched:
+	LONG_L	t0, tp, TI_FLAGS
+	andi	t1, t0, _TIF_NEED_RESCHED
+	beqz	t1, restore_all
+
+	LONG_L  t0, sp, PT_PRMD		# Interrupts off?
+	andi	t0, t0, CSR_PRMD_PIE
+	beqz	t0, restore_all
+	bl	preempt_schedule_irq
+	b	need_resched
+#endif
+
+SYM_CODE_START(ret_from_kernel_thread)
+	bl	schedule_tail		# a0 = struct task_struct *prev
+	move	a0, s1
+	jirl	ra, s0, 0
+	b	syscall_exit
+SYM_CODE_END(ret_from_kernel_thread)
+
+SYM_CODE_START(ret_from_fork)
+	bl	schedule_tail		# a0 = struct task_struct *prev
+	b	syscall_exit
+SYM_CODE_END(ret_from_fork)
+
+SYM_CODE_START(syscall_exit)
+#ifdef CONFIG_DEBUG_RSEQ
+	move	a0, sp
+	bl	rseq_syscall
+#endif
+	local_irq_disable		# make sure need_resched and
+					# signals dont change between
+					# sampling and return
+	LONG_L	a2, tp, TI_FLAGS	# current->work
+	li.w	t0, _TIF_ALLWORK_MASK
+	and	t0, a2, t0
+	bnez	t0, syscall_exit_work
+
+restore_all:				# restore full frame
+	RESTORE_TEMP
+	RESTORE_STATIC
+restore_partial:		# restore partial frame
+	RESTORE_SOME
+	RESTORE_SP_AND_RET
+
+work_pending:
+	andi	t0, a2, _TIF_NEED_RESCHED # a2 is preloaded with TI_FLAGS
+	beqz	t0, work_notifysig
+work_resched:
+	bl	schedule
+
+	local_irq_disable		# make sure need_resched and
+					# signals dont change between
+					# sampling and return
+	LONG_L	a2, tp, TI_FLAGS
+	andi	t0, a2, _TIF_WORK_MASK	# is there any work to be done
+					# other than syscall tracing?
+	beqz	t0, restore_all
+	andi	t0, a2, _TIF_NEED_RESCHED
+	bnez	t0, work_resched
+
+work_notifysig:				# deal with pending signals and
+					# notify-resume requests
+	move	a0, sp
+	li.w	a1, 0
+	bl	do_notify_resume	# a2 already loaded
+	b	resume_userspace_check
+SYM_CODE_END(syscall_exit)
+
+SYM_CODE_START(syscall_exit_partial)
+#ifdef CONFIG_DEBUG_RSEQ
+	move	a0, sp
+	bl	rseq_syscall
+#endif
+	local_irq_disable		# make sure need_resched doesn't
+					# change between and return
+	LONG_L	a2, tp, TI_FLAGS	# current->work
+	li.w	t0, _TIF_ALLWORK_MASK
+	and	t0, t0, a2
+	beqz	t0, restore_partial
+	SAVE_STATIC
+syscall_exit_work:
+	LONG_L	t0, sp, PT_PRMD			# returning to kernel mode?
+	andi	t0, t0, PLV_MASK
+	beqz	t0, resume_kernel
+	li.w	t0, _TIF_WORK_SYSCALL_EXIT
+	and	t0, t0, a2			# a2 is preloaded with TI_FLAGS
+	beqz	t0, work_pending	# trace bit set?
+	local_irq_enable		# could let syscall_trace_leave()
+					# call schedule() instead
+	move	a0, sp
+	bl	syscall_trace_leave
+	b	resume_userspace
+SYM_CODE_END(syscall_exit_partial)
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
new file mode 100644
index 000000000000..7f146339e552
--- /dev/null
+++ b/arch/loongarch/kernel/genex.S
@@ -0,0 +1,198 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/init.h>
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/cacheops.h>
+#include <asm/irqflags.h>
+#include <asm/regdef.h>
+#include <asm/fpregdef.h>
+#include <asm/loongarchregs.h>
+#include <asm/stackframe.h>
+#include <asm/thread_info.h>
+
+	.align	5	/* 32 byte rollback region */
+SYM_FUNC_START(__arch_cpu_idle)
+	/* start of rollback region */
+	LONG_L	t0, tp, TI_FLAGS
+	nop
+	andi	t0, t0, _TIF_NEED_RESCHED
+	bnez	t0, 1f
+	nop
+	nop
+	nop
+	idle	0
+	/* end of rollback region */
+1:
+	jirl	zero, ra, 0
+SYM_FUNC_END(__arch_cpu_idle)
+
+SYM_FUNC_START(except_vec_cex)
+	b	cache_parity_error
+	nop
+SYM_FUNC_END(except_vec_cex)
+
+	.macro	__build_clear_none
+	.endm
+
+	.macro	__build_clear_sti
+	STI
+	.endm
+
+	.macro	__build_clear_cli
+	CLI
+	.endm
+
+	.macro	__build_clear_fpe
+	movfcsr2gr	a1, fcsr0
+	CLI
+	.endm
+
+	.macro	__build_clear_ade
+	csrrd	t0, LOONGARCH_CSR_BADV
+	PTR_S	t0, sp, PT_BVADDR
+	KMODE
+	.endm
+
+	.macro	__build_clear_ale
+	csrrd	t0, LOONGARCH_CSR_BADV
+	PTR_S	t0, sp, PT_BVADDR
+	KMODE
+	.endm
+
+	.macro	__BUILD_silent exception
+	.endm
+
+	.macro	__BUILD_verbose nexception
+	LONG_L	a1, sp, PT_EPC
+	ASM_PRINT("Got \nexception at %016lx\012")
+	.endm
+
+	.macro	__BUILD_HANDLER exception handler clear verbose ext
+	.align	5
+	SYM_FUNC_START(handle_\exception)
+	BACKUP_T0T1
+	SAVE_ALL
+	SYM_INNER_LABEL(handle_\exception\ext, SYM_L_GLOBAL)
+	__build_clear_\clear
+	__BUILD_\verbose \exception
+	move	a0, sp
+	la.abs	t0, do_\handler
+	jirl    ra, t0, 0
+	la.abs	t0, ret_from_exception
+	jirl    zero, t0, 0
+	SYM_FUNC_END(handle_\exception)
+	.endm
+
+	.macro	BUILD_HANDLER exception handler clear verbose
+	__BUILD_HANDLER \exception \handler \clear \verbose _int
+	.endm
+
+	BUILD_HANDLER ade ade ade silent
+	BUILD_HANDLER ale ale ale silent
+	BUILD_HANDLER bp bp sti silent
+	BUILD_HANDLER ri ri sti silent
+	BUILD_HANDLER fpu fpu sti silent
+	BUILD_HANDLER fpe fpe fpe silent
+	BUILD_HANDLER lsx lsx sti silent
+	BUILD_HANDLER lasx lasx sti silent
+	BUILD_HANDLER lbt lbt sti silent
+	BUILD_HANDLER watch watch cli silent
+	BUILD_HANDLER reserved reserved sti verbose	/* others */
+
+SYM_FUNC_START(handle_syscall)
+	la.abs	t0, handle_sys
+	jirl    zero, t0, 0
+SYM_FUNC_END(handle_syscall)
+
+/*
+ * Common Vectored Interrupt
+ * Complete the register saves and invoke the do_vi() handler
+ */
+SYM_FUNC_START(except_vec_vi_handler)
+	la	t1, __arch_cpu_idle
+	LONG_L  t0, sp, PT_EPC
+	/* 32 byte rollback region */
+	ori	t0, t0, 0x1f
+	xori	t0, t0, 0x1f
+	bne	t0, t1, 1f
+	LONG_S  t0, sp, PT_EPC
+1:	SAVE_TEMP
+	SAVE_STATIC
+	CLI
+
+	LONG_L		s0, tp, TI_REGS
+	LONG_S		sp, tp, TI_REGS
+
+	move		s1, sp /* Preserve sp */
+
+	/* Get IRQ stack for this CPU */
+	la		t1, irq_stack
+	LONG_ADDU	t1, t1, x0
+	LONG_L		t0, t1, 0
+
+	/* Check if already on IRQ stack */
+	PTR_LI		t1, ~(_THREAD_SIZE-1)
+	and		t1, t1, sp
+	beq		t0, t1, 2f
+
+	/* Switch to IRQ stack */
+	li.w		t1, _IRQ_STACK_START
+	PTR_ADDU	sp, t0, t1
+
+	/* Save task's sp on IRQ stack so that unwinding can follow it */
+	LONG_S		s1, sp, 0
+2:	la		t0, do_vi
+	jirl		ra, t0, 0
+
+	move		sp, s1 /* Restore sp */
+	la		t0, ret_from_irq
+	jirl    	zero, t0, 0
+SYM_FUNC_END(except_vec_vi_handler)
+
+	.macro	BUILD_VI_HANDLER num
+	.align	5
+SYM_FUNC_START(handle_vi_\num)
+	BACKUP_T0T1
+	SAVE_SOME
+	addi.d	v0, zero, \num
+	la.abs	v1, except_vec_vi_handler
+	jirl	zero, v1, 0
+SYM_FUNC_END(handle_vi_\num)
+	.endm
+
+	BUILD_VI_HANDLER 0
+	BUILD_VI_HANDLER 1
+	BUILD_VI_HANDLER 2
+	BUILD_VI_HANDLER 3
+	BUILD_VI_HANDLER 4
+	BUILD_VI_HANDLER 5
+	BUILD_VI_HANDLER 6
+	BUILD_VI_HANDLER 7
+	BUILD_VI_HANDLER 8
+	BUILD_VI_HANDLER 9
+	BUILD_VI_HANDLER 10
+	BUILD_VI_HANDLER 11
+	BUILD_VI_HANDLER 12
+	BUILD_VI_HANDLER 13
+
+	.align	3
+SYM_DATA_START(vi_table)
+	PTR	handle_vi_0
+	PTR	handle_vi_1
+	PTR	handle_vi_2
+	PTR	handle_vi_3
+	PTR	handle_vi_4
+	PTR	handle_vi_5
+	PTR	handle_vi_6
+	PTR	handle_vi_7
+	PTR	handle_vi_8
+	PTR	handle_vi_9
+	PTR	handle_vi_10
+	PTR	handle_vi_11
+	PTR	handle_vi_12
+	PTR	handle_vi_13
+SYM_DATA_END(vi_table)
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
new file mode 100644
index 000000000000..e0912976ef31
--- /dev/null
+++ b/arch/loongarch/kernel/irq.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/proc_fs.h>
+#include <linux/mm.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/kallsyms.h>
+#include <linux/kgdb.h>
+#include <linux/ftrace.h>
+
+#include <linux/atomic.h>
+#include <linux/uaccess.h>
+
+DEFINE_PER_CPU(unsigned long, irq_stack);
+
+/*
+ * 'what should we do if we get a hw irq event on an illegal vector'.
+ * each architecture has to answer this themselves.
+ */
+void ack_bad_irq(unsigned int irq)
+{
+	pr_warn("Unexpected IRQ # %d\n", irq);
+}
+
+atomic_t irq_err_count;
+
+int arch_show_interrupts(struct seq_file *p, int prec)
+{
+	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
+	return 0;
+}
+
+asmlinkage void spurious_interrupt(void)
+{
+	atomic_inc(&irq_err_count);
+}
+
+void __init init_IRQ(void)
+{
+	int i;
+	unsigned int order = get_order(IRQ_STACK_SIZE);
+
+	for (i = 0; i < NR_IRQS; i++)
+		irq_set_noprobe(i);
+
+	arch_init_irq();
+
+	for_each_possible_cpu(i) {
+		void *s = (void *)__get_free_pages(GFP_KERNEL, order);
+
+		per_cpu(irq_stack, i) = (unsigned long)s;
+		pr_debug("CPU%d IRQ stack at 0x%lx - 0x%lx\n", i,
+			per_cpu(irq_stack, i), per_cpu(irq_stack, i) + IRQ_STACK_SIZE);
+	}
+}
+
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
+static inline void check_stack_overflow(void)
+{
+	unsigned long sp;
+
+	__asm__ __volatile__("move %0, $sp" : "=r" (sp));
+	sp &= THREAD_MASK;
+
+	/*
+	 * Check for stack overflow: is there less than STACK_WARN free?
+	 * STACK_WARN is defined as 1/8 of THREAD_SIZE by default.
+	 */
+	if (unlikely(sp < (sizeof(struct thread_info) + STACK_WARN))) {
+		pr_warn("do_IRQ: stack overflow: %ld\n",
+			sp - sizeof(struct thread_info));
+		dump_stack();
+	}
+}
+#else
+static inline void check_stack_overflow(void) {}
+#endif
+
+
+/*
+ * do_IRQ handles all normal device IRQ's (the special
+ * SMP cross-CPU interrupts have their own specific
+ * handlers).
+ */
+void __irq_entry do_IRQ(unsigned int irq)
+{
+	irq_enter();
+	check_stack_overflow();
+	generic_handle_irq(irq);
+	irq_exit();
+}
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
new file mode 100644
index 000000000000..d180eacaaefa
--- /dev/null
+++ b/arch/loongarch/kernel/traps.c
@@ -0,0 +1,717 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/context_tracking.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/extable.h>
+#include <linux/mm.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/debug.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/kallsyms.h>
+#include <linux/memblock.h>
+#include <linux/interrupt.h>
+#include <linux/ptrace.h>
+#include <linux/kgdb.h>
+#include <linux/kdebug.h>
+#include <linux/kprobes.h>
+#include <linux/notifier.h>
+#include <linux/kdb.h>
+#include <linux/irq.h>
+#include <linux/perf_event.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/branch.h>
+#include <asm/break.h>
+#include <asm/cpu.h>
+#include <asm/fpu.h>
+#include <asm/loongarchregs.h>
+#include <asm/pgtable.h>
+#include <asm/ptrace.h>
+#include <asm/sections.h>
+#include <asm/siginfo.h>
+#include <asm/tlb.h>
+#include <asm/mmu_context.h>
+#include <asm/types.h>
+
+#include "access-helper.h"
+
+extern asmlinkage void handle_ade(void);
+extern asmlinkage void handle_ale(void);
+extern asmlinkage void handle_sys(void);
+extern asmlinkage void handle_syscall(void);
+extern asmlinkage void handle_bp(void);
+extern asmlinkage void handle_ri(void);
+extern asmlinkage void handle_fpu(void);
+extern asmlinkage void handle_fpe(void);
+extern asmlinkage void handle_lbt(void);
+extern asmlinkage void handle_lsx(void);
+extern asmlinkage void handle_lasx(void);
+extern asmlinkage void handle_reserved(void);
+extern asmlinkage void handle_watch(void);
+
+extern void *vi_table[];
+static vi_handler_t ip_handlers[EXCCODE_INT_NUM];
+
+static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
+			   const char *loglvl)
+{
+	unsigned long addr;
+	unsigned long *sp = (unsigned long *)(regs->regs[3] & ~3);
+
+	printk("%sCall Trace:", loglvl);
+#ifdef CONFIG_KALLSYMS
+	printk("%s\n", loglvl);
+#endif
+	while (!kstack_end(sp)) {
+		unsigned long __user *p =
+			(unsigned long __user *)(unsigned long)sp++;
+		if (__get_user(addr, p)) {
+			printk("%s (Bad stack address)", loglvl);
+			break;
+		}
+		if (__kernel_text_address(addr))
+			print_ip_sym(loglvl, addr);
+	}
+	printk("%s\n", loglvl);
+}
+
+static void show_stacktrace(struct task_struct *task,
+	const struct pt_regs *regs, const char *loglvl, bool user)
+{
+	int i;
+	const int field = 2 * sizeof(unsigned long);
+	unsigned long stackdata;
+	unsigned long *sp = (unsigned long *)regs->regs[3];
+
+	printk("%sStack :", loglvl);
+	i = 0;
+	while ((unsigned long) sp & (PAGE_SIZE - 1)) {
+		if (i && ((i % (64 / field)) == 0)) {
+			pr_cont("\n");
+			printk("%s       ", loglvl);
+		}
+		if (i > 39) {
+			pr_cont(" ...");
+			break;
+		}
+
+		if (__get_addr(&stackdata, sp++, user)) {
+			pr_cont(" (Bad stack address)");
+			break;
+		}
+
+		pr_cont(" %0*lx", field, stackdata);
+		i++;
+	}
+	pr_cont("\n");
+	show_backtrace(task, regs, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
+{
+	struct pt_regs regs;
+
+	regs.csr_crmd = 0;
+	if (sp) {
+		regs.regs[3] = (unsigned long)sp;
+		regs.regs[1] = 0;
+		regs.csr_epc = 0;
+	} else {
+		if (task && task != current) {
+			regs.regs[3] = task->thread.reg03;
+			regs.regs[1] = 0;
+			regs.csr_epc = task->thread.reg01;
+		} else {
+			memset(&regs, 0, sizeof(regs));
+		}
+	}
+
+	show_stacktrace(task, &regs, loglvl, false);
+}
+
+static void show_code(void *pc, bool user)
+{
+	long i;
+	unsigned int insn;
+
+	printk("Code:");
+
+	for(i = -3 ; i < 6 ; i++) {
+		if (__get_inst(&insn, pc + i, user)) {
+			pr_cont(" (Bad address in epc)\n");
+			break;
+		}
+		pr_cont("%c%08x%c", (i?' ':'<'), insn, (i?' ':'>'));
+	}
+	pr_cont("\n");
+}
+
+static void __show_regs(const struct pt_regs *regs)
+{
+	const int field = 2 * sizeof(unsigned long);
+	unsigned int excsubcode;
+	unsigned int exccode;
+	int i;
+
+	show_regs_print_info(KERN_DEFAULT);
+
+	/*
+	 * Saved main processor registers
+	 */
+	for (i = 0; i < 32; ) {
+		if ((i % 4) == 0)
+			printk("$%2d   :", i);
+		pr_cont(" %0*lx", field, regs->regs[i]);
+
+		i++;
+		if ((i % 4) == 0)
+			pr_cont("\n");
+	}
+
+	/*
+	 * Saved csr registers
+	 */
+	printk("epc   : %0*lx %pS\n", field, regs->csr_epc,
+	       (void *) regs->csr_epc);
+	printk("ra    : %0*lx %pS\n", field, regs->regs[1],
+	       (void *) regs->regs[1]);
+
+	printk("CSR crmd: %08lx	", regs->csr_crmd);
+	printk("CSR prmd: %08lx	", regs->csr_prmd);
+	printk("CSR ecfg: %08lx	", regs->csr_ecfg);
+	printk("CSR estat: %08lx	", regs->csr_estat);
+	printk("CSR euen: %08lx	", regs->csr_euen);
+
+	pr_cont("\n");
+
+	exccode = ((regs->csr_estat) & CSR_ESTAT_EXC) >> CSR_ESTAT_EXC_SHIFT;
+	excsubcode = ((regs->csr_estat) & CSR_ESTAT_ESUBCODE) >> CSR_ESTAT_ESUBCODE_SHIFT;
+	printk("ExcCode : %x (SubCode %x)\n", exccode, excsubcode);
+
+	if (exccode >= EXCCODE_TLBL && exccode <= EXCCODE_ALE)
+		printk("BadVA : %0*lx\n", field, regs->csr_badvaddr);
+
+	printk("PrId  : %08x (%s)\n", read_cpucfg(LOONGARCH_CPUCFG0),
+	       cpu_family_string());
+}
+
+void show_regs(struct pt_regs *regs)
+{
+	__show_regs((struct pt_regs *)regs);
+	dump_stack();
+}
+
+void show_registers(struct pt_regs *regs)
+{
+	__show_regs(regs);
+	print_modules();
+	printk("Process %s (pid: %d, threadinfo=%p, task=%p)\n",
+	       current->comm, current->pid, current_thread_info(), current);
+
+	show_stacktrace(current, regs, KERN_DEFAULT, user_mode(regs));
+	show_code((void *)regs->csr_epc, user_mode(regs));
+	printk("\n");
+}
+
+static DEFINE_RAW_SPINLOCK(die_lock);
+
+void __noreturn die(const char *str, struct pt_regs *regs)
+{
+	static int die_counter;
+	int sig = SIGSEGV;
+
+	oops_enter();
+
+	if (notify_die(DIE_OOPS, str, regs, 0, current->thread.trap_nr,
+		       SIGSEGV) == NOTIFY_STOP)
+		sig = 0;
+
+	console_verbose();
+	raw_spin_lock_irq(&die_lock);
+	bust_spinlocks(1);
+
+	printk("%s[#%d]:\n", str, ++die_counter);
+	show_registers(regs);
+	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
+	raw_spin_unlock_irq(&die_lock);
+
+	oops_exit();
+
+	if (in_interrupt())
+		panic("Fatal exception in interrupt");
+
+	if (panic_on_oops)
+		panic("Fatal exception");
+
+	do_exit(sig);
+}
+
+static inline void setup_vint_size(unsigned int size)
+{
+	unsigned int vs;
+
+	vs = ilog2(size/4);
+
+	if (vs == 0 || vs > 7)
+		panic("vint_size %d Not support yet", vs);
+
+	csr_xchgl(vs<<CSR_ECFG_VS_SHIFT, CSR_ECFG_VS, LOONGARCH_CSR_ECFG);
+}
+
+/*
+ * Send SIGFPE according to FCSR Cause bits, which must have already
+ * been masked against Enable bits.  This is impotant as Inexact can
+ * happen together with Overflow or Underflow, and `ptrace' can set
+ * any bits.
+ */
+void force_fcsr_sig(unsigned long fcsr, void __user *fault_addr,
+		     struct task_struct *tsk)
+{
+	int si_code = FPE_FLTUNK;
+
+	if (fcsr & FPU_CSR_INV_X)
+		si_code = FPE_FLTINV;
+	else if (fcsr & FPU_CSR_DIV_X)
+		si_code = FPE_FLTDIV;
+	else if (fcsr & FPU_CSR_OVF_X)
+		si_code = FPE_FLTOVF;
+	else if (fcsr & FPU_CSR_UDF_X)
+		si_code = FPE_FLTUND;
+	else if (fcsr & FPU_CSR_INE_X)
+		si_code = FPE_FLTRES;
+
+	force_sig_fault(SIGFPE, si_code, fault_addr);
+}
+
+int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcsr)
+{
+	int si_code;
+	struct vm_area_struct *vma;
+
+	switch (sig) {
+	case 0:
+		return 0;
+
+	case SIGFPE:
+		force_fcsr_sig(fcsr, fault_addr, current);
+		return 1;
+
+	case SIGBUS:
+		force_sig_fault(SIGBUS, BUS_ADRERR, fault_addr);
+		return 1;
+
+	case SIGSEGV:
+		mmap_read_lock(current->mm);
+		vma = find_vma(current->mm, (unsigned long)fault_addr);
+		if (vma && (vma->vm_start <= (unsigned long)fault_addr))
+			si_code = SEGV_ACCERR;
+		else
+			si_code = SEGV_MAPERR;
+		mmap_read_unlock(current->mm);
+		force_sig_fault(SIGSEGV, si_code, fault_addr);
+		return 1;
+
+	default:
+		force_sig(sig);
+		return 1;
+	}
+}
+
+/*
+ * Delayed fp exceptions when doing a lazy ctx switch
+ */
+asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcsr)
+{
+	enum ctx_state prev_state;
+	void __user *fault_addr;
+	int sig;
+
+	prev_state = exception_enter();
+	if (notify_die(DIE_FP, "FP exception", regs, 0, current->thread.trap_nr,
+		       SIGFPE) == NOTIFY_STOP)
+		goto out;
+
+	/* Clear FCSR.Cause before enabling interrupts */
+	write_fcsr(LOONGARCH_FCSR0, fcsr & ~mask_fcsr_x(fcsr));
+	local_irq_enable();
+
+	die_if_kernel("FP exception in kernel code", regs);
+
+	sig = SIGFPE;
+	fault_addr = (void __user *) regs->csr_epc;
+
+	/* Send a signal if required.  */
+	process_fpemu_return(sig, fault_addr, fcsr);
+
+out:
+	exception_exit(prev_state);
+}
+
+asmlinkage void do_bp(struct pt_regs *regs)
+{
+	bool user = user_mode(regs);
+	unsigned int opcode, bcode;
+	unsigned long epc = exception_epc(regs);
+	enum ctx_state prev_state;
+
+	prev_state = exception_enter();
+	current->thread.trap_nr = read_csr_excode();
+	if (__get_inst(&opcode, (u32 *)epc, user))
+		goto out_sigsegv;
+
+	bcode = (opcode & 0x7fff);
+
+	/*
+	 * notify the kprobe handlers, if instruction is likely to
+	 * pertain to them.
+	 */
+	switch (bcode) {
+	case BRK_KPROBE_BP:
+		if (notify_die(DIE_BREAK, "Kprobe", regs, bcode,
+			       current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
+			goto out;
+		else
+			break;
+	case BRK_KPROBE_SSTEPBP:
+		if (notify_die(DIE_SSTEPBP, "Kprobe_SingleStep", regs, bcode,
+			       current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
+			goto out;
+		else
+			break;
+	case BRK_UPROBE_BP:
+		if (notify_die(DIE_UPROBE, "Uprobe", regs, bcode,
+			       current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
+			goto out;
+		else
+			break;
+	case BRK_UPROBE_XOLBP:
+		if (notify_die(DIE_UPROBE_XOL, "Uprobe_XOL", regs, bcode,
+			       current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
+			goto out;
+		else
+			break;
+	default:
+		if (notify_die(DIE_TRAP, "Break", regs, bcode,
+			       current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
+			goto out;
+		else
+			break;
+	}
+
+	switch (bcode) {
+	case BRK_BUG:
+		die_if_kernel("Kernel bug detected", regs);
+		force_sig(SIGTRAP);
+		break;
+	case BRK_DIVZERO:
+		die_if_kernel("Break instruction in kernel code", regs);
+		force_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)regs->csr_epc);
+		break;
+	case BRK_OVERFLOW:
+		die_if_kernel("Break instruction in kernel code", regs);
+		force_sig_fault(SIGFPE, FPE_INTOVF, (void __user *)regs->csr_epc);
+		break;
+	default:
+		die_if_kernel("Break instruction in kernel code", regs);
+		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->csr_epc);
+		break;
+	}
+
+out:
+	exception_exit(prev_state);
+	return;
+
+out_sigsegv:
+	force_sig(SIGSEGV);
+	goto out;
+}
+
+asmlinkage void do_watch(struct pt_regs *regs)
+{
+}
+
+asmlinkage void do_ri(struct pt_regs *regs)
+{
+	unsigned int __user *epc = (unsigned int __user *)exception_epc(regs);
+	unsigned long old_epc = regs->csr_epc;
+	unsigned long old_ra = regs->regs[1];
+	enum ctx_state prev_state;
+	unsigned int opcode = 0;
+	int status = -1;
+
+	prev_state = exception_enter();
+	current->thread.trap_nr = read_csr_excode();
+
+	if (notify_die(DIE_RI, "RI Fault", regs, 0, current->thread.trap_nr,
+		       SIGILL) == NOTIFY_STOP)
+		goto out;
+
+	die_if_kernel("Reserved instruction in kernel code", regs);
+
+	if (unlikely(compute_return_epc(regs) < 0))
+		goto out;
+
+	if (unlikely(get_user(opcode, epc) < 0))
+		status = SIGSEGV;
+
+	if (status < 0)
+		status = SIGILL;
+
+	if (unlikely(status > 0)) {
+		regs->csr_epc = old_epc;		/* Undo skip-over.  */
+		regs->regs[1] = old_ra;
+		force_sig(status);
+	}
+
+out:
+	exception_exit(prev_state);
+}
+
+static void init_restore_fp(void)
+{
+	if (!used_math()) {
+		/* First time FP context user. */
+		init_fpu();
+	} else {
+		/* This task has formerly used the FP context */
+		if (!is_fpu_owner())
+			own_fpu_inatomic(1);
+	}
+
+	BUG_ON(!is_fp_enabled());
+}
+
+asmlinkage void do_fpu(struct pt_regs *regs)
+{
+	enum ctx_state prev_state;
+
+	prev_state = exception_enter();
+
+	die_if_kernel("do_fpu invoked from kernel context!", regs);
+
+	preempt_disable();
+	init_restore_fp();
+	preempt_enable();
+
+	exception_exit(prev_state);
+}
+
+asmlinkage void do_lsx(struct pt_regs *regs)
+{
+}
+
+asmlinkage void do_lasx(struct pt_regs *regs)
+{
+}
+
+asmlinkage void do_lbt(struct pt_regs *regs)
+{
+}
+
+asmlinkage void do_reserved(struct pt_regs *regs)
+{
+	/*
+	 * Game over - no way to handle this if it ever occurs.	 Most probably
+	 * caused by a new unknown cpu type or after another deadly
+	 * hard/software error.
+	 */
+	show_regs(regs);
+	panic("Caught reserved exception %u - should not happen.", read_csr_excode());
+}
+
+asmlinkage void cache_parity_error(void)
+{
+	const int field = 2 * sizeof(unsigned long);
+	unsigned int reg_val;
+
+	/* For the moment, report the problem and hang. */
+	pr_err("Cache error exception:\n");
+	pr_err("csr_merrepc == %0*llx\n", field, csr_readq(LOONGARCH_CSR_MERREPC));
+	reg_val = csr_readl(LOONGARCH_CSR_MERRCTL);
+	pr_err("csr_merrctl == %08x\n", reg_val);
+
+	pr_err("Decoded c0_cacheerr: %s cache fault in %s reference.\n",
+	       reg_val & (1<<30) ? "secondary" : "primary",
+	       reg_val & (1<<31) ? "data" : "insn");
+	if (((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_LOONGSON)) {
+		pr_err("Error bits: %s%s%s%s%s%s%s%s\n",
+			reg_val & (1<<29) ? "ED " : "",
+			reg_val & (1<<28) ? "ET " : "",
+			reg_val & (1<<27) ? "ES " : "",
+			reg_val & (1<<26) ? "EE " : "",
+			reg_val & (1<<25) ? "EB " : "",
+			reg_val & (1<<24) ? "EI " : "",
+			reg_val & (1<<23) ? "E1 " : "",
+			reg_val & (1<<22) ? "E0 " : "");
+	} else {
+		pr_err("Error bits: %s%s%s%s%s%s%s\n",
+			reg_val & (1<<29) ? "ED " : "",
+			reg_val & (1<<28) ? "ET " : "",
+			reg_val & (1<<26) ? "EE " : "",
+			reg_val & (1<<25) ? "EB " : "",
+			reg_val & (1<<24) ? "EI " : "",
+			reg_val & (1<<23) ? "E1 " : "",
+			reg_val & (1<<22) ? "E0 " : "");
+	}
+	pr_err("IDX: 0x%08x\n", reg_val & ((1<<22)-1));
+
+	panic("Can't handle the cache error!");
+}
+
+unsigned long eentry;
+EXPORT_SYMBOL_GPL(eentry);
+unsigned long tlbrentry;
+EXPORT_SYMBOL_GPL(tlbrentry);
+unsigned long exception_handlers[32];
+static unsigned int vec_size = 0x200;
+
+void do_vi(int irq)
+{
+	vi_handler_t action;
+
+	action = ip_handlers[irq];
+	if (action)
+		action(irq);
+	else
+		pr_err("vi handler[%d] is not installed\n", irq);
+}
+
+void set_vi_handler(int n, vi_handler_t addr)
+{
+	if ((n < EXCCODE_INT_START) || (n >= EXCCODE_INT_END)) {
+		pr_err("Set invalid vector handler[%d]\n", n);
+		return;
+	}
+
+	ip_handlers[n - EXCCODE_INT_START] = addr;
+}
+
+extern void tlb_init(void);
+extern void cache_error_setup(void);
+
+static void configure_exception_vector(void)
+{
+	csr_writeq(eentry, LOONGARCH_CSR_EENTRY);
+	csr_writeq(eentry, LOONGARCH_CSR_MERRENTRY);
+	csr_writeq(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
+}
+
+void __init boot_cpu_trap_init(void)
+{
+	unsigned long size = (64 + 14) * vec_size;
+
+	memblock_set_bottom_up(true);
+	eentry = (unsigned long)memblock_alloc(size, 1 << fls(size));
+	tlbrentry = (unsigned long)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+	memblock_set_bottom_up(false);
+
+	setup_vint_size(vec_size);
+	configure_exception_vector();
+
+	if (!cpu_data[0].asid_cache)
+		cpu_data[0].asid_cache = asid_first_version(0);
+
+	mmgrab(&init_mm);
+	current->active_mm = &init_mm;
+	BUG_ON(current->mm);
+	enter_lazy_tlb(&init_mm, current);
+
+	tlb_init();
+	TLBMISS_HANDLER_SETUP();
+}
+
+void nonboot_cpu_trap_init(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	cpu_cache_init();
+
+	setup_vint_size(vec_size);
+
+	configure_exception_vector();
+
+	if (!cpu_data[cpu].asid_cache)
+		cpu_data[cpu].asid_cache = asid_first_version(cpu);
+
+	mmgrab(&init_mm);
+	current->active_mm = &init_mm;
+	BUG_ON(current->mm);
+	enter_lazy_tlb(&init_mm, current);
+
+	tlb_init();
+	TLBMISS_HANDLER_SETUP();
+}
+
+/* Install CPU exception handler */
+void set_handler(unsigned long offset, void *addr, unsigned long size)
+{
+	memcpy((void *)(eentry + offset), addr, size);
+	local_flush_icache_range(eentry + offset, eentry + offset + size);
+}
+
+static const char panic_null_cerr[] =
+	"Trying to set NULL cache error exception handler\n";
+
+/*
+ * Install uncached CPU exception handler.
+ * This is suitable only for the cache error exception which is the only
+ * exception handler that is being run uncached.
+ */
+void set_merr_handler(unsigned long offset, void *addr, unsigned long size)
+{
+	unsigned long uncached_eentry = TO_UNCAC(__pa(eentry));
+
+	if (!addr)
+		panic(panic_null_cerr);
+
+	memcpy((void *)(uncached_eentry + offset), addr, size);
+}
+
+void __init trap_init(void)
+{
+	long i;
+	void *vec_start;
+
+	/* Initialise exception handlers */
+	for (i = 0; i < 64; i++)
+		set_handler(i * vec_size, handle_reserved, vec_size);
+
+	/* Set interrupt vector handler */
+	for (i = EXCCODE_INT_START; i < EXCCODE_INT_END; i++) {
+		vec_start = vi_table[i - EXCCODE_INT_START];
+		set_handler(i * vec_size, vec_start, vec_size);
+	}
+
+	set_handler(EXCCODE_TLBL * vec_size, handle_tlb_load, vec_size);
+	set_handler(EXCCODE_TLBS * vec_size, handle_tlb_store, vec_size);
+	set_handler(EXCCODE_TLBI * vec_size, handle_tlb_load, vec_size);
+	set_handler(EXCCODE_TLBM * vec_size, handle_tlb_modify, vec_size);
+	set_handler(EXCCODE_TLBRI * vec_size, handle_tlb_rixi, vec_size);
+	set_handler(EXCCODE_TLBXI * vec_size, handle_tlb_rixi, vec_size);
+	set_handler(EXCCODE_ADE * vec_size, handle_ade, vec_size);
+	set_handler(EXCCODE_ALE * vec_size, handle_ale, vec_size);
+	set_handler(EXCCODE_SYS * vec_size, handle_syscall, vec_size);
+	set_handler(EXCCODE_BP * vec_size, handle_bp, vec_size);
+	set_handler(EXCCODE_INE * vec_size, handle_ri, vec_size);
+	set_handler(EXCCODE_IPE * vec_size, handle_ri, vec_size);
+	set_handler(EXCCODE_FPDIS * vec_size, handle_fpu, vec_size);
+	set_handler(EXCCODE_LSXDIS * vec_size, handle_lsx, vec_size);
+	set_handler(EXCCODE_LASXDIS * vec_size, handle_lasx, vec_size);
+	set_handler(EXCCODE_FPE * vec_size, handle_fpe, vec_size);
+	set_handler(EXCCODE_BTDIS * vec_size, handle_lbt, vec_size);
+	set_handler(EXCCODE_WATCH * vec_size, handle_watch, vec_size);
+
+	cache_error_setup();
+
+	local_flush_icache_range(eentry, eentry + 0x400);
+}
diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/unaligned.c
new file mode 100644
index 000000000000..d66e453297da
--- /dev/null
+++ b/arch/loongarch/kernel/unaligned.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Handle unaligned accesses by emulation.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/context_tracking.h>
+#include <linux/mm.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/debugfs.h>
+#include <linux/perf_event.h>
+
+#include <asm/asm.h>
+#include <asm/branch.h>
+#include <asm/byteorder.h>
+#include <asm/debug.h>
+#include <asm/fpu.h>
+#include <asm/inst.h>
+
+#include "access-helper.h"
+
+enum {
+	UNALIGNED_ACTION_QUIET,
+	UNALIGNED_ACTION_SIGNAL,
+	UNALIGNED_ACTION_SHOW,
+};
+#ifdef CONFIG_DEBUG_FS
+static u32 unaligned_instructions;
+static u32 unaligned_action;
+#else
+#define unaligned_action UNALIGNED_ACTION_QUIET
+#endif
+extern void show_registers(struct pt_regs *regs);
+
+static inline void write_fpr(unsigned int fd, unsigned long value)
+{
+#define WRITE_FPR(fd, value)		\
+{					\
+	__asm__ __volatile__(		\
+	"movgr2fr.d $f%1, %0\n\t"	\
+	:: "r"(value), "i"(fd));	\
+}
+
+	switch (fd) {
+	case 0:
+		WRITE_FPR(0, value);
+		break;
+	case 1:
+		WRITE_FPR(1, value);
+		break;
+	case 2:
+		WRITE_FPR(2, value);
+		break;
+	case 3:
+		WRITE_FPR(3, value);
+		break;
+	case 4:
+		WRITE_FPR(4, value);
+		break;
+	case 5:
+		WRITE_FPR(5, value);
+		break;
+	case 6:
+		WRITE_FPR(6, value);
+		break;
+	case 7:
+		WRITE_FPR(7, value);
+		break;
+	case 8:
+		WRITE_FPR(8, value);
+		break;
+	case 9:
+		WRITE_FPR(9, value);
+		break;
+	case 10:
+		WRITE_FPR(10, value);
+		break;
+	case 11:
+		WRITE_FPR(11, value);
+		break;
+	case 12:
+		WRITE_FPR(12, value);
+		break;
+	case 13:
+		WRITE_FPR(13, value);
+		break;
+	case 14:
+		WRITE_FPR(14, value);
+		break;
+	case 15:
+		WRITE_FPR(15, value);
+		break;
+	case 16:
+		WRITE_FPR(16, value);
+		break;
+	case 17:
+		WRITE_FPR(17, value);
+		break;
+	case 18:
+		WRITE_FPR(18, value);
+		break;
+	case 19:
+		WRITE_FPR(19, value);
+		break;
+	case 20:
+		WRITE_FPR(20, value);
+		break;
+	case 21:
+		WRITE_FPR(21, value);
+		break;
+	case 22:
+		WRITE_FPR(22, value);
+		break;
+	case 23:
+		WRITE_FPR(23, value);
+		break;
+	case 24:
+		WRITE_FPR(24, value);
+		break;
+	case 25:
+		WRITE_FPR(25, value);
+		break;
+	case 26:
+		WRITE_FPR(26, value);
+		break;
+	case 27:
+		WRITE_FPR(27, value);
+		break;
+	case 28:
+		WRITE_FPR(28, value);
+		break;
+	case 29:
+		WRITE_FPR(29, value);
+		break;
+	case 30:
+		WRITE_FPR(30, value);
+		break;
+	case 31:
+		WRITE_FPR(31, value);
+		break;
+	default:
+		panic("unexpected fd '%d'", fd);
+	}
+#undef WRITE_FPR
+}
+
+static inline unsigned long read_fpr(unsigned int fd)
+{
+#define READ_FPR(fd, __value)		\
+{					\
+	__asm__ __volatile__(		\
+	"movfr2gr.d\t%0, $f%1\n\t"	\
+	: "=r"(__value) : "i"(fd));	\
+}
+
+	unsigned long __value;
+
+	switch (fd) {
+	case 0:
+		READ_FPR(0, __value);
+		break;
+	case 1:
+		READ_FPR(1, __value);
+		break;
+	case 2:
+		READ_FPR(2, __value);
+		break;
+	case 3:
+		READ_FPR(3, __value);
+		break;
+	case 4:
+		READ_FPR(4, __value);
+		break;
+	case 5:
+		READ_FPR(5, __value);
+		break;
+	case 6:
+		READ_FPR(6, __value);
+		break;
+	case 7:
+		READ_FPR(7, __value);
+		break;
+	case 8:
+		READ_FPR(8, __value);
+		break;
+	case 9:
+		READ_FPR(9, __value);
+		break;
+	case 10:
+		READ_FPR(10, __value);
+		break;
+	case 11:
+		READ_FPR(11, __value);
+		break;
+	case 12:
+		READ_FPR(12, __value);
+		break;
+	case 13:
+		READ_FPR(13, __value);
+		break;
+	case 14:
+		READ_FPR(14, __value);
+		break;
+	case 15:
+		READ_FPR(15, __value);
+		break;
+	case 16:
+		READ_FPR(16, __value);
+		break;
+	case 17:
+		READ_FPR(17, __value);
+		break;
+	case 18:
+		READ_FPR(18, __value);
+		break;
+	case 19:
+		READ_FPR(19, __value);
+		break;
+	case 20:
+		READ_FPR(20, __value);
+		break;
+	case 21:
+		READ_FPR(21, __value);
+		break;
+	case 22:
+		READ_FPR(22, __value);
+		break;
+	case 23:
+		READ_FPR(23, __value);
+		break;
+	case 24:
+		READ_FPR(24, __value);
+		break;
+	case 25:
+		READ_FPR(25, __value);
+		break;
+	case 26:
+		READ_FPR(26, __value);
+		break;
+	case 27:
+		READ_FPR(27, __value);
+		break;
+	case 28:
+		READ_FPR(28, __value);
+		break;
+	case 29:
+		READ_FPR(29, __value);
+		break;
+	case 30:
+		READ_FPR(30, __value);
+		break;
+	case 31:
+		READ_FPR(31, __value);
+		break;
+	default:
+		panic("unexpected fd '%d'", fd);
+	}
+#undef READ_FPR
+	return __value;
+}
+
+static void emulate_load_store_insn(struct pt_regs *regs, void __user *addr, unsigned int *pc)
+{
+	bool user = user_mode(regs);
+	unsigned int res;
+	unsigned long value;
+	unsigned long origpc;
+	unsigned long origra;
+	union loongarch_instruction insn;
+
+	origpc = (unsigned long)pc;
+	origra = regs->regs[1];
+
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, 0);
+
+	/*
+	 * This load never faults.
+	 */
+	__get_inst(&insn.word, pc, user);
+	if (user && !access_ok(addr, 8))
+		goto sigbus;
+
+	if (insn.reg2i12_format.opcode == ldd_op ||
+		insn.reg2i14_format.opcode == ldptrd_op ||
+		insn.reg3_format.opcode == ldxd_op) {
+		LoadDW(addr, value, res);
+		if (res)
+			goto fault;
+		regs->regs[insn.reg2i12_format.rd] = value;
+	} else if (insn.reg2i12_format.opcode == ldw_op ||
+		insn.reg2i14_format.opcode == ldptrw_op ||
+		insn.reg3_format.opcode == ldxw_op) {
+		LoadW(addr, value, res);
+		if (res)
+			goto fault;
+		regs->regs[insn.reg2i12_format.rd] = value;
+	} else if (insn.reg2i12_format.opcode == ldwu_op ||
+		insn.reg3_format.opcode == ldxwu_op) {
+		LoadWU(addr, value, res);
+		if (res)
+			goto fault;
+		regs->regs[insn.reg2i12_format.rd] = value;
+	} else if (insn.reg2i12_format.opcode == ldh_op ||
+		insn.reg3_format.opcode == ldxh_op) {
+		LoadHW(addr, value, res);
+		if (res)
+			goto fault;
+		regs->regs[insn.reg2i12_format.rd] = value;
+	} else if (insn.reg2i12_format.opcode == ldhu_op ||
+		insn.reg3_format.opcode == ldxhu_op) {
+		LoadHWU(addr, value, res);
+		if (res)
+			goto fault;
+		regs->regs[insn.reg2i12_format.rd] = value;
+	} else if (insn.reg2i12_format.opcode == std_op ||
+		insn.reg2i14_format.opcode == stptrd_op ||
+		insn.reg3_format.opcode == stxd_op) {
+		value = regs->regs[insn.reg2i12_format.rd];
+		StoreDW(addr, value, res);
+		if (res)
+			goto fault;
+	} else if (insn.reg2i12_format.opcode == stw_op ||
+		insn.reg2i14_format.opcode == stptrw_op ||
+		insn.reg3_format.opcode == stxw_op) {
+		value = regs->regs[insn.reg2i12_format.rd];
+		StoreW(addr, value, res);
+		if (res)
+			goto fault;
+	} else if (insn.reg2i12_format.opcode == sth_op ||
+		insn.reg3_format.opcode == stxh_op) {
+		value = regs->regs[insn.reg2i12_format.rd];
+		StoreHW(addr, value, res);
+		if (res)
+			goto fault;
+	} else if (insn.reg2i12_format.opcode == fldd_op ||
+		insn.reg3_format.opcode == fldxd_op) {
+		LoadDW(addr, value, res);
+		if (res)
+			goto fault;
+		write_fpr(insn.reg2i12_format.rd, value);
+	} else if (insn.reg2i12_format.opcode == flds_op ||
+		insn.reg3_format.opcode == fldxs_op) {
+		LoadW(addr, value, res);
+		if (res)
+			goto fault;
+		write_fpr(insn.reg2i12_format.rd, value);
+	} else if (insn.reg2i12_format.opcode == fstd_op ||
+		insn.reg3_format.opcode == fstxd_op) {
+		value = read_fpr(insn.reg2i12_format.rd);
+		StoreDW(addr, value, res);
+		if (res)
+			goto fault;
+	} else if (insn.reg2i12_format.opcode == fsts_op ||
+		insn.reg3_format.opcode == fstxs_op) {
+		value = read_fpr(insn.reg2i12_format.rd);
+		StoreW(addr, value, res);
+		if (res)
+			goto fault;
+	} else
+		goto sigbus;
+
+
+#ifdef CONFIG_DEBUG_FS
+	unaligned_instructions++;
+#endif
+
+	compute_return_epc(regs);
+	return;
+
+fault:
+	/* roll back jump/branch */
+	regs->csr_epc = origpc;
+	regs->regs[1] = origra;
+	/* Did we have an exception handler installed? */
+	if (fixup_exception(regs))
+		return;
+
+	die_if_kernel("Unhandled kernel unaligned access", regs);
+	force_sig(SIGSEGV);
+
+	return;
+
+sigbus:
+	die_if_kernel("Unhandled kernel unaligned access", regs);
+	force_sig(SIGBUS);
+
+	return;
+}
+
+asmlinkage void do_ade(struct pt_regs *regs)
+{
+	enum ctx_state prev_state;
+
+	prev_state = exception_enter();
+
+	if (unaligned_action == UNALIGNED_ACTION_SHOW)
+		show_registers(regs);
+
+	die_if_kernel("Kernel ade access", regs);
+	force_sig(SIGBUS);
+
+	/*
+	 * On return from the signal handler we should advance the epc
+	 */
+	exception_exit(prev_state);
+}
+
+asmlinkage void do_ale(struct pt_regs *regs)
+{
+	unsigned int *pc;
+	enum ctx_state prev_state;
+
+	prev_state = exception_enter();
+	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS,
+			1, regs, regs->csr_badvaddr);
+	/*
+	 * Did we catch a fault trying to load an instruction?
+	 */
+	if (regs->csr_badvaddr == regs->csr_epc)
+		goto sigbus;
+
+	if (user_mode(regs) && !test_thread_flag(TIF_FIXADE))
+		goto sigbus;
+	if (unaligned_action == UNALIGNED_ACTION_SIGNAL)
+		goto sigbus;
+
+	/*
+	 * Do branch emulation only if we didn't forward the exception.
+	 * This is all so but ugly ...
+	 */
+
+	if (unaligned_action == UNALIGNED_ACTION_SHOW)
+		show_registers(regs);
+	pc = (unsigned int *)exception_epc(regs);
+
+	emulate_load_store_insn(regs, (void __user *)regs->csr_badvaddr, pc);
+
+	return;
+
+sigbus:
+	die_if_kernel("Kernel unaligned instruction access", regs);
+	force_sig(SIGBUS);
+
+	/*
+	 * On return from the signal handler we should advance the epc
+	 */
+	exception_exit(prev_state);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int __init debugfs_unaligned(void)
+{
+	debugfs_create_u32("unaligned_instructions", S_IRUGO,
+			       loongarch_debugfs_dir, &unaligned_instructions);
+	debugfs_create_u32("unaligned_action", S_IRUGO | S_IWUSR,
+			       loongarch_debugfs_dir, &unaligned_action);
+	return 0;
+}
+arch_initcall(debugfs_unaligned);
+#endif
-- 
2.27.0

