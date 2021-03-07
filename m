Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C0B32FE72
	for <lists+linux-arch@lfdr.de>; Sun,  7 Mar 2021 03:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhCGCZl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Mar 2021 21:25:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhCGCZT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Mar 2021 21:25:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8191464FF0;
        Sun,  7 Mar 2021 02:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615083918;
        bh=S6WUpjoSEoqdZcEDlaFPSR66FdKOqh3DN9zUenNHBho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPF9ZLKvsA9TElGF5fM9CASwJMPYicM7Gsq5B4QgSfNW2lWZQi5FbhDUsX5WmGbUx
         KsT8fKazFFUg+grRKSPsjqmn4Y7ydNu73bM7ah6F+rpsh8Lf8X5VYpvFaJO8EmlG8r
         5Yyoi+gPaGvB53Uo9/T1cggH/92ybq71+1DlIpSqcF8121vjW2+OHoPKr4YMQj0bQk
         txRNmTT80i8+hO0DPECc6RTIwu/p79RJJKgCmpn1r+D/ywrsPkwyzALALOB5UiEuc7
         +mvQLNZrJqDNHbRbWqWh/WJKlfMZHkWfpTwNXBksutBIcBl88sxzcvcgdPucDCqJDK
         +TWl4ZDT37L/A==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH 2/2] riscv: Enable generic clockevent broadcast
Date:   Sun,  7 Mar 2021 10:24:46 +0800
Message-Id: <20210307022446.63732-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210307022446.63732-1-guoren@kernel.org>
References: <20210307022446.63732-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

When percpu-timers are stopped by deep power saving mode, we
need system timer help to broadcast IPI_TIMER.

This is first introduced by broken x86 hardware, where the local apic
timer stops in C3 state. But many other architectures(powerpc, mips,
arm, hexagon, openrisc, sh) have supported the infrastructure to
deal with Power Management issues.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/Kconfig      |  2 ++
 arch/riscv/kernel/smp.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 85d626b8ce5e..8637e7344abe 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -28,6 +28,7 @@ config RISCV
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
+	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
@@ -39,6 +40,7 @@ config RISCV
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IOREMAP
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index ea028d9e0d24..8325d33411d8 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/profile.h>
@@ -27,6 +28,7 @@ enum ipi_message_type {
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
+	IPI_TIMER,
 	IPI_MAX
 };
 
@@ -176,6 +178,12 @@ void handle_IPI(struct pt_regs *regs)
 			irq_work_run();
 		}
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+		if (ops & (1 << IPI_TIMER)) {
+			stats[IPI_TIMER]++;
+			tick_receive_broadcast();
+		}
+#endif
 		BUG_ON((ops >> IPI_MAX) != 0);
 
 		/* Order data access and bit testing. */
@@ -192,6 +200,7 @@ static const char * const ipi_names[] = {
 	[IPI_CALL_FUNC]		= "Function call interrupts",
 	[IPI_CPU_STOP]		= "CPU stop interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
+	[IPI_TIMER]		= "Timer broadcast interrupts",
 };
 
 void show_ipi_stats(struct seq_file *p, int prec)
@@ -217,6 +226,13 @@ void arch_send_call_function_single_ipi(int cpu)
 	send_ipi_single(cpu, IPI_CALL_FUNC);
 }
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+void tick_broadcast(const struct cpumask *mask)
+{
+	send_ipi_mask(mask, IPI_TIMER);
+}
+#endif
+
 void smp_send_stop(void)
 {
 	unsigned long timeout;
-- 
2.25.1

