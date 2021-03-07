Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B570832FE74
	for <lists+linux-arch@lfdr.de>; Sun,  7 Mar 2021 03:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhCGCZl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Mar 2021 21:25:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhCGCZK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Mar 2021 21:25:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2295F65056;
        Sun,  7 Mar 2021 02:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615083910;
        bh=WhlbkUebwc1GJfXvE/1rpEg/Mf21MpRw1uus7X8kdhM=;
        h=From:To:Cc:Subject:Date:From;
        b=P/PmwbHZ6rBXncMvOhHWf1UeeMdm+EzqFTqXWkT46ndkYAfO1qnLQxRFvfotu3sJY
         Kh5z/TnOtYx6WabQsMWEtpP5NJtcFjN9r9dSYGTnJTR8TziqKn0M45t2L73ISLmSSw
         8DJVqyWu6l4pssJWUlB2uAn4XSept9KW85JTvRzM0joP4Aal2p2RvdOI+Bx2koToGu
         Jkew5iPqShZCoORlTR9AwEYJqPKBz23lIfW6nDs7TrTkx/sL/jfKTIhJjam+DJJb1B
         6a7qVm1pZEvrAU51xaXZoFodiLSwNiuf5JDqNfxfjo10vqlIz7G5Mx70WXjz4D6Hve
         5Wtbn7puahsJQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] csky: Enable generic clockevent broadcast
Date:   Sun,  7 Mar 2021 10:24:45 +0800
Message-Id: <20210307022446.63732-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

When percpu-timers are stopped by deep power saving mode, we need
system timer help to broadcast IPI_TIMER.

This is first introduced by broken x86 hardware, where the local apic
timer stops in C3 state. But many other architectures(powerpc, mips,
arm, hexagon, openrisc, sh) have supported the infrastructure to
deal with Power Management issues.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/csky/Kconfig      |  2 ++
 arch/csky/kernel/smp.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 34e91224adc3..4328511ac050 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -6,6 +6,7 @@ config CSKY
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
@@ -19,6 +20,7 @@ config CSKY
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
 	select DW_APB_TIMER_OF
+	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_IOREMAP
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 0f9f5eef9338..76d38d84da70 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -8,6 +8,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/clockchips.h>
 #include <linux/percpu.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -32,6 +33,7 @@ enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_IRQ_WORK,
+	IPI_TIMER,
 	IPI_MAX
 };
 
@@ -67,6 +69,13 @@ static irqreturn_t handle_ipi(int irq, void *dev)
 			irq_work_run();
 		}
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+		if (ops & (1 << IPI_TIMER)) {
+			stats[IPI_TIMER]++;
+			tick_receive_broadcast();
+		}
+#endif
+
 		BUG_ON((ops >> IPI_MAX) != 0);
 	}
 
@@ -102,6 +111,7 @@ static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
 	[IPI_IRQ_WORK]		= "Irq work interrupts",
+	[IPI_TIMER]		= "Timer broadcast interrupts",
 };
 
 int arch_show_interrupts(struct seq_file *p, int prec)
@@ -130,6 +140,13 @@ void arch_send_call_function_single_ipi(int cpu)
 	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
 }
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+void tick_broadcast(const struct cpumask *mask)
+{
+	send_ipi_message(mask, IPI_TIMER);
+}
+#endif
+
 static void ipi_stop(void *unused)
 {
 	while (1);
-- 
2.25.1

