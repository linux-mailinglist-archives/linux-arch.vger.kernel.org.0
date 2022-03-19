Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839A94DE89F
	for <lists+linux-arch@lfdr.de>; Sat, 19 Mar 2022 15:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbiCSOkX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Mar 2022 10:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243218AbiCSOkW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Mar 2022 10:40:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D7399EE5;
        Sat, 19 Mar 2022 07:38:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q11so9261633pln.11;
        Sat, 19 Mar 2022 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lwk3GXQj3aaTEFaEqZWHCSwTLGB8rMm7ZzbKyLZdINY=;
        b=jOX1QtZmIhJWIZhJxa56wmwRjlfSAhnDPdYQg5trx+nCp/T593doR1MczwwtrVodEW
         Fx5+DnFKLHc6YmdkARm/KNC3/CpaaiOFImsdAhRCUdKoLpyMXRUwMFsHefGOjhpuJaui
         Ux6m9/uPhfD52o+bSRSoGeVya0FyxnjjLq8as2+Pu6dF/oIINg5dCeWMP6h/Jkc4GF7E
         1ZchzK+MQdqCOSCo7yuhePL1CPuMJG0P00Ig00y74vmTtcLvsbkqWSKOR9E4W6EGL+Xw
         r8BznJnp8tyfUsfgTR9AYBdbFHPVUFsGkRowbR93CoyoQj9ImOCwkIMW1Ni5VcISdqtX
         eJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Lwk3GXQj3aaTEFaEqZWHCSwTLGB8rMm7ZzbKyLZdINY=;
        b=0MvgsWy3GztAgjayyGZVz0u7HxO8tw9zfiRF1K//BoWlVtgsvPkWTQTjl/HknwHCaJ
         nAcjG+x5Z4TCYJH2PPHfkySvKtptktxbxtQRBlbQ/yXkI8pqPH+zuGydB0XsTbdKZubI
         l18yYim4s7x+ojR0jUugdxMw3ItpeYq8RSzyYmxWMcagCp001Vf8RIC5tNzf/WHzPXvQ
         1YfHRKL9HnGg9Rmt5vi394Lb6TeH98tQgPGpC7qYfxj+0gHlUA1MqhfZruW+wxs1g/ry
         EM3hsak5Sa9LW869VwSIYN4KevkpyY3iioj41nv8l+vIMDmIYewf8VM1b0cta1UDOVg2
         /V9A==
X-Gm-Message-State: AOAM533ukmDqqn5o1WV6iLDPFoP5G9Z6C4fdi+WOuyaqPy+MDod9+LQa
        Xw2IEP+65h58iC9t8wsOhyU=
X-Google-Smtp-Source: ABdhPJw/c79MC18OWuhe9SMSeirHoXtlEy3CPgoTY9vQBNnABq8rBzVjVUn7JIU9K+pUyhmJT3KyyQ==
X-Received: by 2002:a17:902:bc86:b0:151:ec83:4a8b with SMTP id bb6-20020a170902bc8600b00151ec834a8bmr4417517plb.69.1647700738000;
        Sat, 19 Mar 2022 07:38:58 -0700 (PDT)
Received: from localhost.localdomain ([50.7.60.25])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090aa00c00b001bc6f1baaaesm14546829pjp.39.2022.03.19.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 07:38:57 -0700 (PDT)
Sender: Huacai Chen <chenhuacai@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
X-Google-Original-From: Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V8 10/22] LoongArch: Add exception/interrupt handling
Date:   Sat, 19 Mar 2022 22:38:05 +0800
Message-Id: <20220319143817.1026708-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220319143817.1026708-1-chenhuacai@loongson.cn>
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds the exception and interrupt handling machanism for
LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/branch.h       |  21 +
 arch/loongarch/include/asm/bug.h          |  23 +
 arch/loongarch/include/asm/entry-common.h |  13 +
 arch/loongarch/include/asm/hardirq.h      |  24 +
 arch/loongarch/include/asm/hw_irq.h       |  17 +
 arch/loongarch/include/asm/irq.h          | 130 ++++
 arch/loongarch/include/asm/irq_regs.h     |  27 +
 arch/loongarch/include/asm/irqflags.h     |  78 +++
 arch/loongarch/include/asm/kdebug.h       |  23 +
 arch/loongarch/include/asm/stackframe.h   | 212 ++++++
 arch/loongarch/include/asm/stacktrace.h   |  74 +++
 arch/loongarch/include/uapi/asm/break.h   |  23 +
 arch/loongarch/kernel/access-helper.h     |  13 +
 arch/loongarch/kernel/genex.S             |  95 +++
 arch/loongarch/kernel/irq.c               | 131 ++++
 arch/loongarch/kernel/traps.c             | 755 ++++++++++++++++++++++
 16 files changed, 1659 insertions(+)
 create mode 100644 arch/loongarch/include/asm/branch.h
 create mode 100644 arch/loongarch/include/asm/bug.h
 create mode 100644 arch/loongarch/include/asm/entry-common.h
 create mode 100644 arch/loongarch/include/asm/hardirq.h
 create mode 100644 arch/loongarch/include/asm/hw_irq.h
 create mode 100644 arch/loongarch/include/asm/irq.h
 create mode 100644 arch/loongarch/include/asm/irq_regs.h
 create mode 100644 arch/loongarch/include/asm/irqflags.h
 create mode 100644 arch/loongarch/include/asm/kdebug.h
 create mode 100644 arch/loongarch/include/asm/stackframe.h
 create mode 100644 arch/loongarch/include/asm/stacktrace.h
 create mode 100644 arch/loongarch/include/uapi/asm/break.h
 create mode 100644 arch/loongarch/kernel/access-helper.h
 create mode 100644 arch/loongarch/kernel/genex.S
 create mode 100644 arch/loongarch/kernel/irq.c
 create mode 100644 arch/loongarch/kernel/traps.c

diff --git a/arch/loongarch/include/asm/branch.h b/arch/loongarch/include/asm/branch.h
new file mode 100644
index 000000000000..3f33c89f35b4
--- /dev/null
+++ b/arch/loongarch/include/asm/branch.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_BRANCH_H
+#define _ASM_BRANCH_H
+
+#include <asm/ptrace.h>
+
+static inline unsigned long exception_era(struct pt_regs *regs)
+{
+	return regs->csr_era;
+}
+
+static inline int compute_return_era(struct pt_regs *regs)
+{
+	regs->csr_era += 4;
+	return 0;
+}
+
+#endif /* _ASM_BRANCH_H */
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
diff --git a/arch/loongarch/include/asm/entry-common.h b/arch/loongarch/include/asm/entry-common.h
new file mode 100644
index 000000000000..0fe2a098ded9
--- /dev/null
+++ b/arch/loongarch/include/asm/entry-common.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_LOONGARCH_ENTRY_COMMON_H
+#define ARCH_LOONGARCH_ENTRY_COMMON_H
+
+#include <linux/sched.h>
+#include <linux/processor.h>
+
+static inline bool on_thread_stack(void)
+{
+	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
+}
+
+#endif
diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/include/asm/hardirq.h
new file mode 100644
index 000000000000..d32f83938880
--- /dev/null
+++ b/arch/loongarch/include/asm/hardirq.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
index 000000000000..af4f4e8fbd85
--- /dev/null
+++ b/arch/loongarch/include/asm/hw_irq.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
index 000000000000..cd95d0d4e10f
--- /dev/null
+++ b/arch/loongarch/include/asm/irq.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_IRQ_H
+#define _ASM_IRQ_H
+
+#include <linux/irqdomain.h>
+#include <linux/irqreturn.h>
+
+#define IRQ_STACK_SIZE			THREAD_SIZE
+#define IRQ_STACK_START			(IRQ_STACK_SIZE - 16)
+
+DECLARE_PER_CPU(unsigned long, irq_stack);
+
+/*
+ * The highest address on the IRQ stack contains a dummy frame which is
+ * structured as follows:
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
+int get_ipi_irq(void);
+int get_pmc_irq(void);
+int get_timer_irq(void);
+void spurious_interrupt(void);
+
+#define NR_IRQS_LEGACY 16
+
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+void arch_trigger_cpumask_backtrace(const struct cpumask *mask, bool exclude_self);
+
+#define MAX_IO_PICS 2
+#define NR_IRQS	(64 + (256 * MAX_IO_PICS))
+
+#define CORES_PER_EIO_NODE	4
+
+#define LOONGSON_CPU_UART0_VEC		10 /* CPU UART0 */
+#define LOONGSON_CPU_THSENS_VEC		14 /* CPU Thsens */
+#define LOONGSON_CPU_HT0_VEC		16 /* CPU HT0 irq vector base number */
+#define LOONGSON_CPU_HT1_VEC		24 /* CPU HT1 irq vector base number */
+
+/* IRQ number definitions */
+#define LOONGSON_LPC_IRQ_BASE		0
+#define LOONGSON_LPC_LAST_IRQ		(LOONGSON_LPC_IRQ_BASE + 15)
+
+#define LOONGSON_CPU_IRQ_BASE		16
+#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 14)
+
+#define LOONGSON_PCH_IRQ_BASE		64
+#define LOONGSON_PCH_ACPI_IRQ		(LOONGSON_PCH_IRQ_BASE + 47)
+#define LOONGSON_PCH_LAST_IRQ		(LOONGSON_PCH_IRQ_BASE + 64 - 1)
+
+#define LOONGSON_MSI_IRQ_BASE		(LOONGSON_PCH_IRQ_BASE + 64)
+#define LOONGSON_MSI_LAST_IRQ		(LOONGSON_PCH_IRQ_BASE + 256 - 1)
+
+#define GSI_MIN_LPC_IRQ		LOONGSON_LPC_IRQ_BASE
+#define GSI_MAX_LPC_IRQ		(LOONGSON_LPC_IRQ_BASE + 16 - 1)
+#define GSI_MIN_CPU_IRQ		LOONGSON_CPU_IRQ_BASE
+#define GSI_MAX_CPU_IRQ		(LOONGSON_CPU_IRQ_BASE + 48 - 1)
+#define GSI_MIN_PCH_IRQ		LOONGSON_PCH_IRQ_BASE
+#define GSI_MAX_PCH_IRQ		(LOONGSON_PCH_IRQ_BASE + 256 - 1)
+
+extern int find_pch_pic(u32 gsi);
+extern int eiointc_get_node(int id);
+
+static inline void eiointc_enable(void)
+{
+	uint64_t misc;
+
+	misc = iocsr_readq(LOONGARCH_IOCSR_MISC_FUNC);
+	misc |= IOCSR_MISC_FUNC_EXT_IOI_EN;
+	iocsr_writeq(misc, LOONGARCH_IOCSR_MISC_FUNC);
+}
+
+struct acpi_madt_lio_pic;
+struct acpi_madt_eio_pic;
+struct acpi_madt_ht_pic;
+struct acpi_madt_bio_pic;
+struct acpi_madt_msi_pic;
+struct acpi_madt_lpc_pic;
+
+struct irq_domain *loongarch_cpu_irq_init(void);
+
+struct irq_domain *liointc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_lio_pic *acpi_liointc);
+struct irq_domain *eiointc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_eio_pic *acpi_eiointc);
+
+struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_ht_pic *acpi_htvec);
+struct irq_domain *pch_lpc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_lpc_pic *acpi_pchlpc);
+struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi);
+struct irq_domain *pch_pic_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_bio_pic *acpi_pchpic);
+
+extern struct acpi_madt_lio_pic *acpi_liointc;
+extern struct acpi_madt_eio_pic *acpi_eiointc[MAX_IO_PICS];
+
+extern struct acpi_madt_ht_pic *acpi_htintc;
+extern struct acpi_madt_lpc_pic *acpi_pchlpc;
+extern struct acpi_madt_msi_pic *acpi_pchmsi[MAX_IO_PICS];
+extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
+
+extern struct irq_domain *cpu_domain;
+extern struct irq_domain *liointc_domain;
+extern struct irq_domain *pch_lpc_domain;
+extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
+extern struct irq_domain *pch_pic_domain[MAX_IO_PICS];
+
+#include <asm-generic/irq.h>
+
+#endif /* _ASM_IRQ_H */
diff --git a/arch/loongarch/include/asm/irq_regs.h b/arch/loongarch/include/asm/irq_regs.h
new file mode 100644
index 000000000000..3d62d815bf6b
--- /dev/null
+++ b/arch/loongarch/include/asm/irq_regs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
index 000000000000..52121cd791fe
--- /dev/null
+++ b/arch/loongarch/include/asm/irqflags.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_IRQFLAGS_H
+#define _ASM_IRQFLAGS_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/compiler.h>
+#include <linux/stringify.h>
+#include <asm/compiler.h>
+#include <asm/loongarch.h>
+
+static inline void arch_local_irq_enable(void)
+{
+	u32 flags = CSR_CRMD_IE;
+	__asm__ __volatile__(
+		"csrxchg %[val], %[mask], %[reg]\n\t"
+		: [val] "+r" (flags)
+		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: "memory");
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	u32 flags = 0;
+	__asm__ __volatile__(
+		"csrxchg %[val], %[mask], %[reg]\n\t"
+		: [val] "+r" (flags)
+		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: "memory");
+}
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	u32 flags = 0;
+	__asm__ __volatile__(
+		"csrxchg %[val], %[mask], %[reg]\n\t"
+		: [val] "+r" (flags)
+		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: "memory");
+	return flags;
+}
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	__asm__ __volatile__(
+		"csrxchg %[val], %[mask], %[reg]\n\t"
+		: [val] "+r" (flags)
+		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: "memory");
+}
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	u32 flags;
+	__asm__ __volatile__(
+		"csrrd %[val], %[reg]\n\t"
+		: [val] "=r" (flags)
+		: [reg] "i" (LOONGARCH_CSR_CRMD)
+		: "memory");
+	return flags;
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
index 000000000000..d721b4b82fae
--- /dev/null
+++ b/arch/loongarch/include/asm/kdebug.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
index 000000000000..fed198fbd51d
--- /dev/null
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_STACKFRAME_H
+#define _ASM_STACKFRAME_H
+
+#include <linux/threads.h>
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/asm-offsets.h>
+#include <asm/loongarch.h>
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
+	.macro	SAVE_TEMP docfi=0
+	RELOAD_T0T1
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
+ * kernelsp array for it. It stores the current sp in t0 and loads the
+ * new value in sp.
+ */
+	.macro	get_saved_sp docfi=0
+	la.abs	t1, kernelsp
+	move	t0, sp
+	.if \docfi
+	.cfi_register sp, t0
+	.endif
+	LONG_L	sp, t1, 0
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
+	get_saved_sp docfi=\docfi
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
+	csrrd	t0, LOONGARCH_CSR_EUEN
+	LONG_S  t0, sp, PT_EUEN
+	csrrd	t0, LOONGARCH_CSR_ECFG
+	LONG_S	t0, sp, PT_ECFG
+	csrrd	t0, LOONGARCH_CSR_ESTAT
+	PTR_S	t0, sp, PT_ESTAT
+	cfi_st	ra, PT_R1, \docfi
+	cfi_st	a0, PT_R4, \docfi
+	cfi_st	a1, PT_R5, \docfi
+	cfi_st	a2, PT_R6, \docfi
+	cfi_st	a3, PT_R7, \docfi
+	cfi_st	a4, PT_R8, \docfi
+	cfi_st	a5, PT_R9, \docfi
+	cfi_st	a6, PT_R10, \docfi
+	cfi_st	a7, PT_R11, \docfi
+	csrrd	ra, LOONGARCH_CSR_ERA
+	LONG_S	ra, sp, PT_ERA
+	.if \docfi
+	.cfi_rel_offset ra, PT_ERA
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
+	cfi_st  u0, PT_R21, \docfi
+	csrrd	u0, PERCPU_BASE_KS
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
+	LONG_L	a0, sp, PT_PRMD
+	andi    a0, a0, 0x3	/* extract pplv bit */
+	beqz    a0, 8f
+	cfi_ld  u0, PT_R21, \docfi
+8:
+	LONG_L	a0, sp, PT_ERA
+	csrwr	a0, LOONGARCH_CSR_ERA
+	LONG_L	a0, sp, PT_PRMD
+	csrwr	a0, LOONGARCH_CSR_PRMD
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
+	.macro	RESTORE_SP_AND_RET docfi=0
+	cfi_ld	sp, PT_R3, \docfi
+	ertn
+	.endm
+
+	.macro	RESTORE_ALL_AND_RET docfi=0
+	RESTORE_STATIC \docfi
+	RESTORE_TEMP \docfi
+	RESTORE_SOME \docfi
+	RESTORE_SP_AND_RET \docfi
+	.endm
+
+#endif /* _ASM_STACKFRAME_H */
diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/include/asm/stacktrace.h
new file mode 100644
index 000000000000..26483e396ad1
--- /dev/null
+++ b/arch/loongarch/include/asm/stacktrace.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_STACKTRACE_H
+#define _ASM_STACKTRACE_H
+
+#include <asm/asm.h>
+#include <asm/ptrace.h>
+#include <asm/loongarch.h>
+#include <linux/stringify.h>
+
+#define STR_LONG_L    __stringify(LONG_L)
+#define STR_LONG_S    __stringify(LONG_S)
+#define STR_LONGSIZE  __stringify(LONGSIZE)
+
+#define STORE_ONE_REG(r) \
+    STR_LONG_S   " $r" __stringify(r)", %1, "STR_LONGSIZE"*"__stringify(r)"\n\t"
+
+#define CSRRD_ONE_REG(reg) \
+    __stringify(csrrd) " %0, "__stringify(reg)"\n\t"
+
+static __always_inline void prepare_frametrace(struct pt_regs *regs)
+{
+	__asm__ __volatile__(
+		/* Save $r1 */
+		STORE_ONE_REG(1)
+		/* Use $r1 to save PC */
+		"pcaddi	$r1, 0\n\t"
+		STR_LONG_S " $r1, %0\n\t"
+		/* Restore $r1 */
+		STR_LONG_L " $r1, %1, "STR_LONGSIZE"\n\t"
+		STORE_ONE_REG(2)
+		STORE_ONE_REG(3)
+		STORE_ONE_REG(4)
+		STORE_ONE_REG(5)
+		STORE_ONE_REG(6)
+		STORE_ONE_REG(7)
+		STORE_ONE_REG(8)
+		STORE_ONE_REG(9)
+		STORE_ONE_REG(10)
+		STORE_ONE_REG(11)
+		STORE_ONE_REG(12)
+		STORE_ONE_REG(13)
+		STORE_ONE_REG(14)
+		STORE_ONE_REG(15)
+		STORE_ONE_REG(16)
+		STORE_ONE_REG(17)
+		STORE_ONE_REG(18)
+		STORE_ONE_REG(19)
+		STORE_ONE_REG(20)
+		STORE_ONE_REG(21)
+		STORE_ONE_REG(22)
+		STORE_ONE_REG(23)
+		STORE_ONE_REG(24)
+		STORE_ONE_REG(25)
+		STORE_ONE_REG(26)
+		STORE_ONE_REG(27)
+		STORE_ONE_REG(28)
+		STORE_ONE_REG(29)
+		STORE_ONE_REG(30)
+		STORE_ONE_REG(31)
+		: "=m" (regs->csr_era)
+		: "r" (regs->regs)
+		: "memory");
+	__asm__ __volatile__(CSRRD_ONE_REG(LOONGARCH_CSR_BADV) : "=r" (regs->csr_badvaddr));
+	__asm__ __volatile__(CSRRD_ONE_REG(LOONGARCH_CSR_CRMD) : "=r" (regs->csr_crmd));
+	__asm__ __volatile__(CSRRD_ONE_REG(LOONGARCH_CSR_PRMD) : "=r" (regs->csr_prmd));
+	__asm__ __volatile__(CSRRD_ONE_REG(LOONGARCH_CSR_EUEN) : "=r" (regs->csr_euen));
+	__asm__ __volatile__(CSRRD_ONE_REG(LOONGARCH_CSR_ECFG) : "=r" (regs->csr_ecfg));
+	__asm__ __volatile__(CSRRD_ONE_REG(LOONGARCH_CSR_ESTAT) : "=r" (regs->csr_estat));
+}
+
+#endif /* _ASM_STACKTRACE_H */
diff --git a/arch/loongarch/include/uapi/asm/break.h b/arch/loongarch/include/uapi/asm/break.h
new file mode 100644
index 000000000000..bb9b82ba59f2
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/break.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
new file mode 100644
index 000000000000..93496852b3cc
--- /dev/null
+++ b/arch/loongarch/kernel/genex.S
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ *
+ * Derived from MIPS:
+ * Copyright (C) 1994 - 2000, 2001, 2003 Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2002, 2007  Maciej W. Rozycki
+ * Copyright (C) 2001, 2012 MIPS Technologies, Inc.  All rights reserved.
+ */
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/loongarch.h>
+#include <asm/regdef.h>
+#include <asm/fpregdef.h>
+#include <asm/stackframe.h>
+#include <asm/thread_info.h>
+
+	.align	5
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
+1:	jirl	zero, ra, 0
+SYM_FUNC_END(__arch_cpu_idle)
+
+SYM_FUNC_START(handle_vint)
+	BACKUP_T0T1
+	SAVE_ALL
+	la.abs	t1, __arch_cpu_idle
+	LONG_L  t0, sp, PT_ERA
+	/* 32 byte rollback region */
+	ori	t0, t0, 0x1f
+	xori	t0, t0, 0x1f
+	bne	t0, t1, 1f
+	LONG_S  t0, sp, PT_ERA
+1:	move	a0, sp
+	move	a1, sp
+	la.abs	t0, do_vint
+	jirl    ra, t0, 0
+	RESTORE_ALL_AND_RET
+SYM_FUNC_END(handle_vint)
+
+SYM_FUNC_START(except_vec_cex)
+	b	cache_parity_error
+SYM_FUNC_END(except_vec_cex)
+
+	.macro	build_prep_badv
+	csrrd	t0, LOONGARCH_CSR_BADV
+	PTR_S	t0, sp, PT_BVADDR
+	.endm
+
+	.macro	build_prep_fcsr
+	movfcsr2gr	a1, fcsr0
+	.endm
+
+	.macro	build_prep_none
+	.endm
+
+	.macro	BUILD_HANDLER exception handler prep
+	.align	5
+	SYM_FUNC_START(handle_\exception)
+	BACKUP_T0T1
+	SAVE_ALL
+	build_prep_\prep
+	move	a0, sp
+	la.abs	t0, do_\handler
+	jirl    ra, t0, 0
+	RESTORE_ALL_AND_RET
+	SYM_FUNC_END(handle_\exception)
+	.endm
+
+	BUILD_HANDLER ade ade badv
+	BUILD_HANDLER ale ale badv
+	BUILD_HANDLER bp bp none
+	BUILD_HANDLER fpe fpe fcsr
+	BUILD_HANDLER fpu fpu none
+	BUILD_HANDLER lsx lsx none
+	BUILD_HANDLER lasx lasx none
+	BUILD_HANDLER lbt lbt none
+	BUILD_HANDLER ri ri none
+	BUILD_HANDLER watch watch none
+	BUILD_HANDLER reserved reserved none	/* others */
+
+SYM_FUNC_START(handle_sys)
+	la.abs	t0, handle_syscall
+	jirl    zero, t0, 0
+SYM_FUNC_END(handle_sys)
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
new file mode 100644
index 000000000000..48032ffd9331
--- /dev/null
+++ b/arch/loongarch/kernel/irq.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/atomic.h>
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
+#include <linux/uaccess.h>
+
+#include <asm/irq.h>
+#include <asm/loongson.h>
+#include <asm/setup.h>
+
+DEFINE_PER_CPU(unsigned long, irq_stack);
+
+struct acpi_madt_lio_pic *acpi_liointc;
+struct acpi_madt_eio_pic *acpi_eiointc[MAX_IO_PICS];
+
+struct acpi_madt_ht_pic *acpi_htintc;
+struct acpi_madt_lpc_pic *acpi_pchlpc;
+struct acpi_madt_msi_pic *acpi_pchmsi[MAX_IO_PICS];
+struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
+
+struct irq_domain *cpu_domain;
+struct irq_domain *liointc_domain;
+struct irq_domain *pch_lpc_domain;
+struct irq_domain *pch_msi_domain[MAX_IO_PICS];
+struct irq_domain *pch_pic_domain[MAX_IO_PICS];
+
+int find_pch_pic(u32 gsi)
+{
+	int i, start, end;
+
+	/* Find the PCH_PIC that manages this GSI. */
+	for (i = 0; i < loongson_sysconf.nr_io_pics; i++) {
+		struct acpi_madt_bio_pic *irq_cfg = acpi_pchpic[i];
+
+		start = irq_cfg->gsi_base;
+		end   = irq_cfg->gsi_base + irq_cfg->size;
+		if (gsi >= start && gsi < end)
+			return i;
+	}
+
+	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
+	return -1;
+}
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
+asmlinkage void spurious_interrupt(void)
+{
+	atomic_inc(&irq_err_count);
+}
+
+int arch_show_interrupts(struct seq_file *p, int prec)
+{
+	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
+	return 0;
+}
+
+void __init setup_IRQ(void)
+{
+	int i;
+	struct irq_domain *parent_domain;
+
+	if (!acpi_eiointc[0])
+		cpu_data[0].options &= ~LOONGARCH_CPU_EXTIOI;
+
+	cpu_domain = loongarch_cpu_irq_init();
+	liointc_domain = liointc_acpi_init(cpu_domain, acpi_liointc);
+
+	if (cpu_has_extioi) {
+		pr_info("Using EIOINTC interrupt mode\n");
+		for (i = 0; i < loongson_sysconf.nr_io_pics; i++) {
+			parent_domain = eiointc_acpi_init(cpu_domain, acpi_eiointc[i]);
+			pch_pic_domain[i] = pch_pic_acpi_init(parent_domain, acpi_pchpic[i]);
+			pch_msi_domain[i] = pch_msi_acpi_init(parent_domain, acpi_pchmsi[i]);
+		}
+	} else {
+		pr_info("Using HTVECINTC interrupt mode\n");
+		parent_domain = htvec_acpi_init(liointc_domain, acpi_htintc);
+		pch_pic_domain[0] = pch_pic_acpi_init(parent_domain, acpi_pchpic[0]);
+		pch_msi_domain[0] = pch_msi_acpi_init(parent_domain, acpi_pchmsi[0]);
+	}
+
+	irq_set_default_host(pch_pic_domain[0]);
+	pch_lpc_domain = pch_lpc_acpi_init(pch_pic_domain[0], acpi_pchlpc);
+}
+
+void __init init_IRQ(void)
+{
+	int i;
+	unsigned int order = get_order(IRQ_STACK_SIZE);
+
+	clear_csr_ecfg(ECFG0_IM);
+	clear_csr_estat(ESTATF_IP);
+
+	setup_IRQ();
+
+	for (i = 0; i < NR_IRQS; i++)
+		irq_set_noprobe(i);
+
+	for_each_possible_cpu(i) {
+		void *s = (void *)__get_free_pages(GFP_KERNEL, order);
+
+		per_cpu(irq_stack, i) = (unsigned long)s;
+		pr_debug("CPU%d IRQ stack at 0x%lx - 0x%lx\n", i,
+			per_cpu(irq_stack, i), per_cpu(irq_stack, i) + IRQ_STACK_SIZE);
+	}
+
+	set_csr_ecfg(ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 | ECFGF_IPI | ECFGF_PMC);
+}
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
new file mode 100644
index 000000000000..c850174c7985
--- /dev/null
+++ b/arch/loongarch/kernel/traps.c
@@ -0,0 +1,755 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/context_tracking.h>
+#include <linux/entry-common.h>
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
+#include <linux/irq.h>
+#include <linux/perf_event.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/branch.h>
+#include <asm/break.h>
+#include <asm/cpu.h>
+#include <asm/fpu.h>
+#include <asm/loongarch.h>
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/ptrace.h>
+#include <asm/sections.h>
+#include <asm/siginfo.h>
+#include <asm/stacktrace.h>
+#include <asm/tlb.h>
+#include <asm/types.h>
+
+#include "access-helper.h"
+
+extern asmlinkage void handle_ade(void);
+extern asmlinkage void handle_ale(void);
+extern asmlinkage void handle_sys(void);
+extern asmlinkage void handle_bp(void);
+extern asmlinkage void handle_ri(void);
+extern asmlinkage void handle_fpu(void);
+extern asmlinkage void handle_fpe(void);
+extern asmlinkage void handle_lbt(void);
+extern asmlinkage void handle_lsx(void);
+extern asmlinkage void handle_lasx(void);
+extern asmlinkage void handle_reserved(void);
+extern asmlinkage void handle_watch(void);
+extern asmlinkage void handle_vint(void);
+
+static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
+			   const char *loglvl, bool user)
+{
+	unsigned long addr;
+	unsigned long *sp = (unsigned long *)(regs->regs[3] & ~3);
+
+	printk("%sCall Trace:", loglvl);
+#ifdef CONFIG_KALLSYMS
+	printk("%s\n", loglvl);
+#endif
+	while (!kstack_end(sp)) {
+		if (__get_addr(&addr, sp++, user)) {
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
+	show_backtrace(task, regs, loglvl, user);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
+{
+	struct pt_regs regs;
+
+	regs.csr_crmd = 0;
+	if (sp) {
+		regs.csr_era = 0;
+		regs.regs[1] = 0;
+		regs.regs[3] = (unsigned long)sp;
+	} else {
+		if (!task || task == current)
+			prepare_frametrace(&regs);
+		else {
+			regs.csr_era = task->thread.reg01;
+			regs.regs[1] = 0;
+			regs.regs[3] = task->thread.reg03;
+			regs.regs[22] = task->thread.reg22;
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
+			pr_cont(" (Bad address in era)\n");
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
+	printk("era   : %0*lx %pS\n", field, regs->csr_era,
+	       (void *) regs->csr_era);
+	printk("ra    : %0*lx %pS\n", field, regs->regs[1],
+	       (void *) regs->regs[1]);
+
+	printk("CSR crmd: %08lx	", regs->csr_crmd);
+	printk("CSR prmd: %08lx	", regs->csr_prmd);
+	printk("CSR euen: %08lx	", regs->csr_euen);
+	printk("CSR ecfg: %08lx	", regs->csr_ecfg);
+	printk("CSR estat: %08lx	", regs->csr_estat);
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
+	show_code((void *)regs->csr_era, user_mode(regs));
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
+	make_task_dead(sig);
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
+		if (vma_lookup(current->mm, (unsigned long)fault_addr))
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
+asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)
+{
+	int sig;
+	void __user *fault_addr;
+	irqentry_state_t state = irqentry_enter(regs);
+
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
+	fault_addr = (void __user *) regs->csr_era;
+
+	/* Send a signal if required.  */
+	process_fpemu_return(sig, fault_addr, fcsr);
+
+out:
+	local_irq_disable();
+	irqentry_exit(regs, state);
+}
+
+asmlinkage void noinstr do_ade(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	die_if_kernel("Kernel ade access", regs);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)regs->csr_badvaddr);
+
+	irqentry_exit(regs, state);
+}
+
+asmlinkage void noinstr do_ale(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	die_if_kernel("Kernel ale access", regs);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)regs->csr_badvaddr);
+
+	irqentry_exit(regs, state);
+}
+
+asmlinkage void noinstr do_bp(struct pt_regs *regs)
+{
+	bool user = user_mode(regs);
+	unsigned int opcode, bcode;
+	unsigned long era = exception_era(regs);
+	irqentry_state_t state = irqentry_enter(regs);
+
+	local_irq_enable();
+	current->thread.trap_nr = read_csr_excode();
+	if (__get_inst(&opcode, (u32 *)era, user))
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
+		force_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)regs->csr_era);
+		break;
+	case BRK_OVERFLOW:
+		die_if_kernel("Break instruction in kernel code", regs);
+		force_sig_fault(SIGFPE, FPE_INTOVF, (void __user *)regs->csr_era);
+		break;
+	default:
+		die_if_kernel("Break instruction in kernel code", regs);
+		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->csr_era);
+		break;
+	}
+
+out:
+	local_irq_disable();
+	irqentry_exit(regs, state);
+	return;
+
+out_sigsegv:
+	force_sig(SIGSEGV);
+	goto out;
+}
+
+asmlinkage void noinstr do_watch(struct pt_regs *regs)
+{
+	pr_warn("Hardware watch point handler not implemented!\n");
+}
+
+asmlinkage void noinstr do_ri(struct pt_regs *regs)
+{
+	int status = -1;
+	unsigned int opcode = 0;
+	unsigned int __user *era = (unsigned int __user *)exception_era(regs);
+	unsigned long old_era = regs->csr_era;
+	unsigned long old_ra = regs->regs[1];
+	irqentry_state_t state = irqentry_enter(regs);
+
+	local_irq_enable();
+	current->thread.trap_nr = read_csr_excode();
+
+	if (notify_die(DIE_RI, "RI Fault", regs, 0, current->thread.trap_nr,
+		       SIGILL) == NOTIFY_STOP)
+		goto out;
+
+	die_if_kernel("Reserved instruction in kernel code", regs);
+
+	if (unlikely(compute_return_era(regs) < 0))
+		goto out;
+
+	if (unlikely(get_user(opcode, era) < 0)) {
+		status = SIGSEGV;
+		current->thread.error_code = 1;
+	}
+
+	if (status < 0)
+		status = SIGILL;
+
+	if (unlikely(status > 0)) {
+		regs->csr_era = old_era;		/* Undo skip-over.  */
+		regs->regs[1] = old_ra;
+		force_sig(status);
+	}
+
+out:
+	local_irq_disable();
+	irqentry_exit(regs, state);
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
+asmlinkage void noinstr do_fpu(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	local_irq_enable();
+	die_if_kernel("do_fpu invoked from kernel context!", regs);
+
+	preempt_disable();
+	init_restore_fp();
+	preempt_enable();
+
+	local_irq_disable();
+	irqentry_exit(regs, state);
+}
+
+asmlinkage void noinstr do_lsx(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	local_irq_enable();
+	force_sig(SIGILL);
+	local_irq_disable();
+
+	irqentry_exit(regs, state);
+}
+
+asmlinkage void noinstr do_lasx(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	local_irq_enable();
+	force_sig(SIGILL);
+	local_irq_disable();
+
+	irqentry_exit(regs, state);
+}
+
+asmlinkage void noinstr do_lbt(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	local_irq_enable();
+	force_sig(SIGILL);
+	local_irq_disable();
+
+	irqentry_exit(regs, state);
+}
+
+asmlinkage void noinstr do_reserved(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	/*
+	 * Game over - no way to handle this if it ever occurs.	 Most probably
+	 * caused by a new unknown cpu type or after another deadly
+	 * hard/software error.
+	 */
+	local_irq_enable();
+	show_regs(regs);
+	panic("Caught reserved exception %u - should not happen.", read_csr_excode());
+	local_irq_disable();
+
+	irqentry_exit(regs, state);
+}
+
+asmlinkage void cache_parity_error(void)
+{
+	const int field = 2 * sizeof(unsigned long);
+	unsigned int reg_val;
+
+	/* For the moment, report the problem and hang. */
+	pr_err("Cache error exception:\n");
+	pr_err("csr_merrera == %0*llx\n", field, csr_readq(LOONGARCH_CSR_MERRERA));
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
+asmlinkage void noinstr handle_loongarch_irq(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+
+	irq_enter_rcu();
+	old_regs = set_irq_regs(regs);
+	handle_arch_irq(regs);
+	set_irq_regs(old_regs);
+	irq_exit_rcu();
+}
+
+asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
+{
+	register int cpu;
+	register unsigned long stack;
+	irqentry_state_t state = irqentry_enter(regs);
+
+	cpu = smp_processor_id();
+
+	if (on_irq_stack(cpu, sp))
+		handle_loongarch_irq(regs);
+	else {
+		stack = per_cpu(irq_stack, cpu) + IRQ_STACK_START;
+
+		/* Save task's sp on IRQ stack for unwinding */
+		*(unsigned long *)stack = sp;
+
+		__asm__ __volatile__(
+		"move	$s0, $sp		\n" /* Preserve sp */
+		"move	$sp, %[stk]		\n" /* Switch stack */
+		"move	$a0, %[regs]		\n"
+		"bl	handle_loongarch_irq	\n"
+		"move	$sp, $s0		\n" /* Restore sp */
+		: /* No outputs */
+		: [stk] "r" (stack), [regs] "r" (regs)
+		: "$a0", "$a1", "$a2", "$a3", "$a4", "$a5", "$a6", "$a7", "$s0",
+		  "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8",
+		  "memory");
+	}
+
+	irqentry_exit(regs, state);
+}
+
+extern void tlb_init(void);
+extern void cache_error_setup(void);
+
+unsigned long eentry;
+EXPORT_SYMBOL_GPL(eentry);
+unsigned long tlbrentry;
+EXPORT_SYMBOL_GPL(tlbrentry);
+
+long exception_handlers[VECSIZE * 128 / sizeof(long)] __aligned(SZ_64K);
+
+static void configure_exception_vector(void)
+{
+	eentry    = (unsigned long)exception_handlers;
+	tlbrentry = (unsigned long)exception_handlers + 80*VECSIZE;
+
+	csr_writeq(eentry, LOONGARCH_CSR_EENTRY);
+	csr_writeq(eentry, LOONGARCH_CSR_MERRENTRY);
+	csr_writeq(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
+}
+
+void per_cpu_trap_init(int cpu)
+{
+	unsigned int i;
+
+	setup_vint_size(VECSIZE);
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
+	/* Initialise exception handlers */
+	if (cpu == 0)
+		for (i = 0; i < 64; i++)
+			set_handler(i * VECSIZE, handle_reserved, VECSIZE);
+
+	tlb_init();
+	cpu_cache_init();
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
+
+	/* Set interrupt vector handler */
+	for (i = EXCCODE_INT_START; i < EXCCODE_INT_END; i++)
+		set_handler(i * VECSIZE, handle_vint, VECSIZE);
+
+	set_handler(EXCCODE_ADE * VECSIZE, handle_ade, VECSIZE);
+	set_handler(EXCCODE_ALE * VECSIZE, handle_ale, VECSIZE);
+	set_handler(EXCCODE_SYS * VECSIZE, handle_sys, VECSIZE);
+	set_handler(EXCCODE_BP * VECSIZE, handle_bp, VECSIZE);
+	set_handler(EXCCODE_INE * VECSIZE, handle_ri, VECSIZE);
+	set_handler(EXCCODE_IPE * VECSIZE, handle_ri, VECSIZE);
+	set_handler(EXCCODE_FPDIS * VECSIZE, handle_fpu, VECSIZE);
+	set_handler(EXCCODE_LSXDIS * VECSIZE, handle_lsx, VECSIZE);
+	set_handler(EXCCODE_LASXDIS * VECSIZE, handle_lasx, VECSIZE);
+	set_handler(EXCCODE_FPE * VECSIZE, handle_fpe, VECSIZE);
+	set_handler(EXCCODE_BTDIS * VECSIZE, handle_lbt, VECSIZE);
+	set_handler(EXCCODE_WATCH * VECSIZE, handle_watch, VECSIZE);
+
+	cache_error_setup();
+
+	local_flush_icache_range(eentry, eentry + 0x400);
+}
-- 
2.27.0

