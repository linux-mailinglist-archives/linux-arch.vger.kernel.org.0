Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B359E234F1D
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 03:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgHABPA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 21:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbgHABPA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:15:00 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52FC12245C;
        Sat,  1 Aug 2020 01:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244499;
        bh=TWpobEkUFwXJvKEdpKXErUrWoH8ngSAggu3Jl9MuW5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6Q/jdWiQCZpT0jDmYtqsUzjIUIfZUeCpwOk/DCjVy0Vl10HgWounANL8FTq2Wvfa
         ApoNDiqhiRg12KpmeZrG65cYn7f8xT0gB+U0WpjONKq202xsNdKsvcR444WGUA+AWO
         iPMMoQfZQA7CDyvouGPzBKxpY+gYte7Bbcq2eD9s=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 12/13] csky: Add arch_show_interrupts for IPI interrupts
Date:   Sat,  1 Aug 2020 01:14:12 +0000
Message-Id: <1596244453-98575-13-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Here is the result:

 cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 15:       1348       1299        952       1076  C-SKY SMP Intc  15  IPI Interrupt
 16:       1203       1825       1598       1307  C-SKY SMP Intc  16  csky_mp_timer
 43:        292          0          0          0  C-SKY SMP Intc  43  ttyS0
 57:        106          0          0          0  C-SKY SMP Intc  57  virtio0
IPI0:         0          0          0          0  Empty interrupts
IPI1:        19         41         45         27  Rescheduling interrupts
IPI2:      1330       1259        908       1050  Function call interrupts
IPI3:         0          0          0          0  Irq work interrupts

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/kernel/smp.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 60f2ab1..e7425e6 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -15,6 +15,7 @@
 #include <linux/irq_work.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
+#include <linux/seq_file.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/hotplug.h>
@@ -27,11 +28,6 @@
 #include <abi/fpu.h>
 #endif
 
-struct ipi_data_struct {
-	unsigned long bits ____cacheline_aligned;
-};
-static DEFINE_PER_CPU(struct ipi_data_struct, ipi_data);
-
 enum ipi_message_type {
 	IPI_EMPTY,
 	IPI_RESCHEDULE,
@@ -40,8 +36,16 @@ enum ipi_message_type {
 	IPI_MAX
 };
 
+struct ipi_data_struct {
+	unsigned long bits ____cacheline_aligned;
+	unsigned long stats[IPI_MAX] ____cacheline_aligned;
+};
+static DEFINE_PER_CPU(struct ipi_data_struct, ipi_data);
+
 static irqreturn_t handle_ipi(int irq, void *dev)
 {
+	unsigned long *stats = this_cpu_ptr(&ipi_data)->stats;
+
 	while (true) {
 		unsigned long ops;
 
@@ -49,14 +53,20 @@ static irqreturn_t handle_ipi(int irq, void *dev)
 		if (ops == 0)
 			return IRQ_HANDLED;
 
-		if (ops & (1 << IPI_RESCHEDULE))
+		if (ops & (1 << IPI_RESCHEDULE)) {
+			stats[IPI_RESCHEDULE]++;
 			scheduler_ipi();
+		}
 
-		if (ops & (1 << IPI_CALL_FUNC))
+		if (ops & (1 << IPI_CALL_FUNC)) {
+			stats[IPI_CALL_FUNC]++;
 			generic_smp_call_function_interrupt();
+		}
 
-		if (ops & (1 << IPI_IRQ_WORK))
+		if (ops & (1 << IPI_IRQ_WORK)) {
+			stats[IPI_IRQ_WORK]++;
 			irq_work_run();
+		}
 
 		BUG_ON((ops >> IPI_MAX) != 0);
 	}
@@ -88,6 +98,29 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 	send_arch_ipi(to_whom);
 }
 
+static const char * const ipi_names[] = {
+	[IPI_EMPTY]		= "Empty interrupts",
+	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
+	[IPI_CALL_FUNC]		= "Function call interrupts",
+	[IPI_IRQ_WORK]		= "Irq work interrupts",
+};
+
+int arch_show_interrupts(struct seq_file *p, int prec)
+{
+	unsigned int cpu, i;
+
+	for (i = 0; i < IPI_MAX; i++) {
+		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
+			   prec >= 4 ? " " : "");
+		for_each_online_cpu(cpu)
+			seq_printf(p, "%10lu ",
+				per_cpu_ptr(&ipi_data, cpu)->stats[i]);
+		seq_printf(p, " %s\n", ipi_names[i]);
+	}
+
+	return 0;
+}
+
 void arch_send_call_function_ipi_mask(struct cpumask *mask)
 {
 	send_ipi_message(mask, IPI_CALL_FUNC);
-- 
2.7.4

