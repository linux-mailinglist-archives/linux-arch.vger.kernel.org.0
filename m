Return-Path: <linux-arch+bounces-4390-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1AA8C4D15
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 09:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196DC1F21D2A
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 07:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B24E12E75;
	Tue, 14 May 2024 07:32:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5FA12E48;
	Tue, 14 May 2024 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671974; cv=none; b=cHVYIRm6UTl6rHLvA6dAwSyNPZFu2i3DeJzhB7HxTNrM17LExxzV7+WWRfeITGwP0i/7E9acIBkLqDimWdEiiH4efSI0XxOXK8zMPIDfdslVJbv4PzTmV7bMSP9Ocm8upc7AlMZnkYGtJsvwxXUKc3W5LjAW1Gz5SJ+pDo7Go2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671974; c=relaxed/simple;
	bh=nEwTX0iq0hxDEaH0PHgIzKUAcr2jYaPliEDdZ2C90bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUDLz7CloVwHWtTAEWPu6C+DFXwtkKMafQVZQ9Ys7g8T2NxCG+YHRmHa1neD5TdeFejK5EfO9lcrQaSV8TbuXobIe+myjmJl8EQG7Eu4RTZctjBMCjwF4bgMiyd04noXyQ9AvAIjy46paCp6ZKBM9ECl9Uom5zhfsW6zdU8EBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C89C2BD10;
	Tue, 14 May 2024 07:32:51 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add irq_work support via self IPIs
Date: Tue, 14 May 2024 15:32:32 +0800
Message-ID: <20240514073232.3694867-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add irq_work support for LoongArch via self IPIs. This make it possible
to run works in hardware interrupt context, which is a prerequisite for
NOHZ_FULL.

Implement:
 - arch_irq_work_raise()
 - arch_irq_work_has_interrupt()

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/hardirq.h  |  3 ++-
 arch/loongarch/include/asm/irq_work.h | 10 ++++++++++
 arch/loongarch/include/asm/smp.h      |  2 ++
 arch/loongarch/kernel/paravirt.c      |  6 ++++++
 arch/loongarch/kernel/smp.c           | 14 ++++++++++++++
 5 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/include/asm/irq_work.h

diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/include/asm/hardirq.h
index d41138abcf26..1d7feb719515 100644
--- a/arch/loongarch/include/asm/hardirq.h
+++ b/arch/loongarch/include/asm/hardirq.h
@@ -12,11 +12,12 @@
 extern void ack_bad_irq(unsigned int irq);
 #define ack_bad_irq ack_bad_irq
 
-#define NR_IPI	2
+#define NR_IPI	3
 
 enum ipi_msg_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNCTION,
+	IPI_IRQ_WORK,
 };
 
 typedef struct {
diff --git a/arch/loongarch/include/asm/irq_work.h b/arch/loongarch/include/asm/irq_work.h
new file mode 100644
index 000000000000..d63076e9160d
--- /dev/null
+++ b/arch/loongarch/include/asm/irq_work.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LOONGARCH_IRQ_WORK_H
+#define _ASM_LOONGARCH_IRQ_WORK_H
+
+static inline bool arch_irq_work_has_interrupt(void)
+{
+	return IS_ENABLED(CONFIG_SMP);
+}
+
+#endif /* _ASM_LOONGARCH_IRQ_WORK_H */
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 278700cfee88..50db503f44e3 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -69,9 +69,11 @@ extern int __cpu_logical_map[NR_CPUS];
 #define ACTION_BOOT_CPU	0
 #define ACTION_RESCHEDULE	1
 #define ACTION_CALL_FUNCTION	2
+#define ACTION_IRQ_WORK		3
 #define SMP_BOOT_CPU		BIT(ACTION_BOOT_CPU)
 #define SMP_RESCHEDULE		BIT(ACTION_RESCHEDULE)
 #define SMP_CALL_FUNCTION	BIT(ACTION_CALL_FUNCTION)
+#define SMP_IRQ_WORK		BIT(ACTION_IRQ_WORK)
 
 struct secondary_data {
 	unsigned long stack;
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index 1633ed4f692f..4272d2447445 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -2,6 +2,7 @@
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
+#include <linux/irq_work.h>
 #include <linux/jump_label.h>
 #include <linux/kvm_para.h>
 #include <linux/static_call.h>
@@ -97,6 +98,11 @@ static irqreturn_t pv_ipi_interrupt(int irq, void *dev)
 		info->ipi_irqs[IPI_CALL_FUNCTION]++;
 	}
 
+	if (action & SMP_IRQ_WORK) {
+		irq_work_run();
+		info->ipi_irqs[IPI_IRQ_WORK]++;
+	}
+
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 0dfe2388ef41..7366de776f6e 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -13,6 +13,7 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq_work.h>
 #include <linux/profile.h>
 #include <linux/seq_file.h>
 #include <linux/smp.h>
@@ -70,6 +71,7 @@ static DEFINE_PER_CPU(int, cpu_state);
 static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	[IPI_RESCHEDULE] = "Rescheduling interrupts",
 	[IPI_CALL_FUNCTION] = "Function call interrupts",
+	[IPI_IRQ_WORK] = "IRQ work interrupts",
 };
 
 void show_ipi_list(struct seq_file *p, int prec)
@@ -217,6 +219,13 @@ void arch_smp_send_reschedule(int cpu)
 }
 EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
 
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	mp_ops.send_ipi_single(smp_processor_id(), ACTION_IRQ_WORK);
+}
+#endif
+
 static irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
 {
 	unsigned int action;
@@ -234,6 +243,11 @@ static irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
 		per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
 	}
 
+	if (action & SMP_IRQ_WORK) {
+		irq_work_run();
+		per_cpu(irq_stat, cpu).ipi_irqs[IPI_IRQ_WORK]++;
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


