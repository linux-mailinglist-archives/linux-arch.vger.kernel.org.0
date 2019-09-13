Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA0B2511
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2019 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390813AbfIMSVD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Sep 2019 14:21:03 -0400
Received: from foss.arm.com ([217.140.110.172]:47950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390802AbfIMSVB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Sep 2019 14:21:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4111B15A2;
        Fri, 13 Sep 2019 11:21:01 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6E753F71F;
        Fri, 13 Sep 2019 11:20:58 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, james.morse@arm.com,
        hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org,
        dave.martin@arm.com, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, x86@kernel.org, dzickus@redhat.com,
        ehabkost@redhat.com, linux@armlinux.org.uk, davem@davemloft.net,
        sparclinux@vger.kernel.org, hch@infradead.org
Subject: [RFC PATCH v2 06/12] arm64: smp: use SMP crash-stop common code
Date:   Fri, 13 Sep 2019 19:19:47 +0100
Message-Id: <20190913181953.45748-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913181953.45748-1-cristian.marussi@arm.com>
References: <20190913181953.45748-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make arm64 use the SMP common implementation of crash_smp_send_stop() and
its generic logic, by removing the arm64 crash_smp_send_stop() definition
and providing the needed arch specific helpers.

Additionally, simplify the arch-specific stop and crash dump ISRs backends
(which are in charge of effectively receiving and interpreting the
stop/crash messages) and unify them as much as possible.

Using the SMP common code, it is no more needed to make use of an atomic_t
counter to make sure that each CPU had time to perform its crash dump
related shutdown-ops before the world ends: simply take care to synchronize
on cpu_online_mask, and add proper explicit memory barriers where needed.

Moreover, remove arm64 specific smp_crash_stop_failed() helper as a whole
and rely on the common code provided homonym function to lookup the state
of an ongoing crash_stop operation.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
v1 --> v2
- added attempt_num param to arch_smp_crash_call()
---
 arch/arm64/include/asm/smp.h |   2 -
 arch/arm64/kernel/smp.c      | 100 +++++++++--------------------------
 2 files changed, 26 insertions(+), 76 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index a0c8a0b65259..d98c409f9225 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -150,8 +150,6 @@ static inline void cpu_panic_kernel(void)
  */
 bool cpus_are_stuck_in_kernel(void);
 
-extern void crash_smp_send_stop(void);
-extern bool smp_crash_stop_failed(void);
 
 #endif /* ifndef __ASSEMBLY__ */
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3e87fdbb9f74..f0cc2bf84aaa 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -825,12 +825,30 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-static void local_cpu_stop(void)
+static void local_cpu_crash_or_stop(struct pt_regs *crash_regs)
 {
-	set_cpu_online(smp_processor_id(), false);
+	unsigned int cpu = smp_processor_id();
 
-	local_daif_mask();
+	if (IS_ENABLED(CONFIG_KEXEC_CORE) && crash_regs) {
+#ifdef CONFIG_KEXEC_CORE
+		/* crash stop requested: save regs before going offline */
+		crash_save_cpu(crash_regs, cpu);
+#endif
+		local_irq_disable();
+	} else {
+		local_daif_mask();
+	}
 	sdei_mask_local_cpu();
+	/* ensure dumped regs are visible once cpu is seen offline */
+	smp_wmb();
+	set_cpu_online(cpu, false);
+	/* ensure all writes are globally visible before cpu parks */
+	wmb();
+#if defined(CONFIG_KEXEC_CORE) && defined(CONFIG_HOTPLUG_CPU)
+	if (cpu_ops[cpu]->cpu_die)
+		cpu_ops[cpu]->cpu_die(cpu);
+#endif
+	/* just in case */
 	cpu_park_loop();
 }
 
@@ -841,31 +859,7 @@ static void local_cpu_stop(void)
  */
 void panic_smp_self_stop(void)
 {
-	local_cpu_stop();
-}
-
-#ifdef CONFIG_KEXEC_CORE
-static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
-#endif
-
-static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
-{
-#ifdef CONFIG_KEXEC_CORE
-	crash_save_cpu(regs, cpu);
-
-	atomic_dec(&waiting_for_crash_ipi);
-
-	local_irq_disable();
-	sdei_mask_local_cpu();
-
-#ifdef CONFIG_HOTPLUG_CPU
-	if (cpu_ops[cpu]->cpu_die)
-		cpu_ops[cpu]->cpu_die(cpu);
-#endif
-
-	/* just in case */
-	cpu_park_loop();
-#endif
+	local_cpu_crash_or_stop(NULL);
 }
 
 /*
@@ -894,14 +888,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	case IPI_CPU_STOP:
 		irq_enter();
-		local_cpu_stop();
+		local_cpu_crash_or_stop(NULL);
 		irq_exit();
 		break;
 
 	case IPI_CPU_CRASH_STOP:
 		if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
 			irq_enter();
-			ipi_cpu_crash_stop(cpu, regs);
+			local_cpu_crash_or_stop(regs);
 
 			unreachable();
 		}
@@ -963,52 +957,10 @@ void arch_smp_stop_call(cpumask_t *cpus, unsigned int __unused)
 	smp_cross_call(cpus, IPI_CPU_STOP);
 }
 
-#ifdef CONFIG_KEXEC_CORE
-void crash_smp_send_stop(void)
+void arch_smp_crash_call(cpumask_t *cpus, unsigned int __unused)
 {
-	static int cpus_stopped;
-	cpumask_t mask;
-	unsigned long timeout;
-
-	/*
-	 * This function can be called twice in panic path, but obviously
-	 * we execute this only once.
-	 */
-	if (cpus_stopped)
-		return;
-
-	cpus_stopped = 1;
-
-	if (num_online_cpus() == 1) {
-		sdei_mask_local_cpu();
-		return;
-	}
-
-	cpumask_copy(&mask, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), &mask);
-
-	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-
-	pr_crit("SMP: stopping secondary CPUs\n");
-	smp_cross_call(&mask, IPI_CPU_CRASH_STOP);
-
-	/* Wait up to one second for other CPUs to stop */
-	timeout = USEC_PER_SEC;
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
-		udelay(1);
-
-	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
-			   cpumask_pr_args(&mask));
-
-	sdei_mask_local_cpu();
-}
-
-bool smp_crash_stop_failed(void)
-{
-	return (atomic_read(&waiting_for_crash_ipi) > 0);
+	smp_cross_call(cpus, IPI_CPU_CRASH_STOP);
 }
-#endif
 
 /*
  * not supported here
-- 
2.17.1

