Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1DB2516
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2019 20:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390837AbfIMSVH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Sep 2019 14:21:07 -0400
Received: from foss.arm.com ([217.140.110.172]:47992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390923AbfIMSVH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Sep 2019 14:21:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 935531570;
        Fri, 13 Sep 2019 11:21:06 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25A573F71F;
        Fri, 13 Sep 2019 11:21:04 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/12] x86: smp: use generic SMP stop common code
Date:   Fri, 13 Sep 2019 19:19:49 +0100
Message-Id: <20190913181953.45748-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913181953.45748-1-cristian.marussi@arm.com>
References: <20190913181953.45748-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make x86 use the generic SMP-stop logic provided by common code unified
smp_send_stop() function.

Introduce needed arch_smp_stop_call()/arch_smp_cpus_stop_complete()
helpers that implement the backend architectures specific functionalities
previously provided by native_stop_other_cpus(): common logic is now
delegated to common SMP stop code.

Remove arch-specific smp_send_stop(), and redefine original function
native_stop_other_cpus() to rely instead on the unified common code
version of smp_send_stop(): native_stop_other_cpus() is anyway kept
since it is wired to smp_ops.stop_other_cpus() which get called at
reboot time with particular waiting settings.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Note that in this patch we kept in use the original x86 local handling
of 'stopping_cpu' variable:

	atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id());

Instead, common SMP stop code could have been easily extended to keep and
expose to architectures backends such value using some additional helper
like smp_stop_get_stopping_cpu_id().

This has not been addressed in this series.
---
 arch/x86/Kconfig           |  1 +
 arch/x86/include/asm/smp.h |  5 --
 arch/x86/kernel/smp.c      | 95 ++++++++++++++++----------------------
 3 files changed, 41 insertions(+), 60 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 222855cc0158..0fcee2f03a5b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -92,6 +92,7 @@ config X86
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_COMMON_SMP_STOP
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANT_HUGE_PMD_SHARE
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index e1356a3b8223..5cf590259d68 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -67,11 +67,6 @@ extern void set_cpu_sibling_map(int cpu);
 #ifdef CONFIG_SMP
 extern struct smp_ops smp_ops;
 
-static inline void smp_send_stop(void)
-{
-	smp_ops.stop_other_cpus(0);
-}
-
 static inline void stop_other_cpus(void)
 {
 	smp_ops.stop_other_cpus(1);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 96421f97e75c..0942cae46fee 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -179,78 +179,63 @@ asmlinkage __visible void smp_reboot_interrupt(void)
 	irq_exit();
 }
 
-static void native_stop_other_cpus(int wait)
+void arch_smp_stop_call(cpumask_t *cpus, unsigned int attempt_num)
 {
-	unsigned long flags;
-	unsigned long timeout;
-
 	if (reboot_force)
 		return;
 
-	/*
-	 * Use an own vector here because smp_call_function
-	 * does lots of things not suitable in a panic situation.
-	 */
-
-	/*
-	 * We start by using the REBOOT_VECTOR irq.
-	 * The irq is treated as a sync point to allow critical
-	 * regions of code on other cpus to release their spin locks
-	 * and re-enable irqs.  Jumping straight to an NMI might
-	 * accidentally cause deadlocks with further shutdown/panic
-	 * code.  By syncing, we give the cpus up to one second to
-	 * finish their work before we force them off with the NMI.
-	 */
-	if (num_online_cpus() > 1) {
-		/* did someone beat us here? */
-		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
-			return;
-
-		/* sync above data before sending IRQ */
-		wmb();
-
-		apic->send_IPI_allbutself(REBOOT_VECTOR);
-
+	if (attempt_num == 1) {
 		/*
-		 * Don't wait longer than a second if the caller
-		 * didn't ask us to wait.
+		 * We start by using the REBOOT_VECTOR irq.
+		 * The irq is treated as a sync point to allow critical
+		 * regions of code on other cpus to release their spin locks
+		 * and re-enable irqs.  Jumping straight to an NMI might
+		 * accidentally cause deadlocks with further shutdown/panic
+		 * code.  By syncing, we give the cpus up to one second to
+		 * finish their work before we force them off with the NMI.
 		 */
-		timeout = USEC_PER_SEC;
-		while (num_online_cpus() > 1 && (wait || timeout--))
-			udelay(1);
-	}
-	
-	/* if the REBOOT_VECTOR didn't work, try with the NMI */
-	if ((num_online_cpus() > 1) && (!smp_no_nmi_ipi))  {
-		if (register_nmi_handler(NMI_LOCAL, smp_stop_nmi_callback,
-					 NMI_FLAG_FIRST, "smp_stop"))
-			/* Note: we ignore failures here */
-			/* Hope the REBOOT_IRQ is good enough */
-			goto finish;
+
+		/* Used by NMI handler callback to skip the stopping_cpu. */
+		atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id());
 
 		/* sync above data before sending IRQ */
 		wmb();
-
-		pr_emerg("Shutting down cpus with NMI\n");
-
-		apic->send_IPI_allbutself(NMI_VECTOR);
-
-		/*
-		 * Don't wait longer than a 10 ms if the caller
-		 * didn't ask us to wait.
-		 */
-		timeout = USEC_PER_MSEC * 10;
-		while (num_online_cpus() > 1 && (wait || timeout--))
-			udelay(1);
+		apic->send_IPI_mask(cpus, REBOOT_VECTOR);
+	} else if (attempt_num > 1 && !smp_no_nmi_ipi) {
+		/* if the REBOOT_VECTOR didn't work, try with the NMI */
+
+		/* Don't wait longer than 10 ms when not asked to wait */
+		smp_stop_set_wait_timeout_us(USEC_PER_MSEC * 10);
+
+		/* Note: we ignore failures here */
+		/* Hope the REBOOT_IRQ was good enough */
+		if (!register_nmi_handler(NMI_LOCAL, smp_stop_nmi_callback,
+					  NMI_FLAG_FIRST, "smp_stop")) {
+			/* sync above data before sending IRQ */
+			wmb();
+			pr_emerg("Shutting down cpus with NMI\n");
+			apic->send_IPI_mask(cpus, NMI_VECTOR);
+		}
 	}
+}
+
+void arch_smp_cpus_stop_complete(void)
+{
+	unsigned long flags;
 
-finish:
 	local_irq_save(flags);
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
 	local_irq_restore(flags);
 }
 
+static void native_stop_other_cpus(int wait)
+{
+	smp_stop_set_wait_forever(wait);
+	/* use common SMP stop code */
+	smp_send_stop();
+}
+
 /*
  * Reschedule call back. KVM uses this interrupt to force a cpu out of
  * guest mode
-- 
2.17.1

