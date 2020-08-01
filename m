Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B8234F24
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 03:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgHABPU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 21:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgHABO6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:58 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985B120888;
        Sat,  1 Aug 2020 01:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244497;
        bh=fqYp56IXW8clengUMAj/xJCUXNot7xUdIUce+YLKLyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWgQlVgNXoAMYyXfs/ij+lbH1ILjFsHNyeKUX/jCsJ1xij1PUNn3cBynfvw+swr6o
         l/Oluu+rzPxubO8hNF0VgoaS06iZ4j0XhNqjr1mRrFmGkCKm+FsWACXjOVL1aDXB6w
         BAz6JFFiNG2iWQBFruiOETjG/BR7iz2eXSr+Anmg=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 11/13] csky: Add irq_work support
Date:   Sat,  1 Aug 2020 01:14:11 +0000
Message-Id: <1596244453-98575-12-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Running work in hardware interrupt context for csky. Implement:
 - arch_irq_work_raise()
 - arch_irq_work_has_interrupt()

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/asm/irq_work.h | 11 +++++++++++
 arch/csky/kernel/smp.c           | 12 ++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/csky/include/asm/irq_work.h

diff --git a/arch/csky/include/asm/irq_work.h b/arch/csky/include/asm/irq_work.h
new file mode 100644
index 00000000..33aaf39
--- /dev/null
+++ b/arch/csky/include/asm/irq_work.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_IRQ_WORK_H
+#define __ASM_CSKY_IRQ_WORK_H
+
+static inline bool arch_irq_work_has_interrupt(void)
+{
+	return true;
+}
+extern void arch_irq_work_raise(void);
+#endif /* __ASM_CSKY_IRQ_WORK_H */
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 1945fb2..60f2ab1 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/irq.h>
+#include <linux/irq_work.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
@@ -35,6 +36,7 @@ enum ipi_message_type {
 	IPI_EMPTY,
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
+	IPI_IRQ_WORK,
 	IPI_MAX
 };
 
@@ -53,6 +55,9 @@ static irqreturn_t handle_ipi(int irq, void *dev)
 		if (ops & (1 << IPI_CALL_FUNC))
 			generic_smp_call_function_interrupt();
 
+		if (ops & (1 << IPI_IRQ_WORK))
+			irq_work_run();
+
 		BUG_ON((ops >> IPI_MAX) != 0);
 	}
 
@@ -108,6 +113,13 @@ void smp_send_reschedule(int cpu)
 	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	send_ipi_message(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
+}
+#endif
+
 void __init smp_prepare_boot_cpu(void)
 {
 }
-- 
2.7.4

