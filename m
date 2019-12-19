Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0119A1261EB
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2019 13:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLSMTs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Dec 2019 07:19:48 -0500
Received: from foss.arm.com ([217.140.110.172]:37992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbfLSMTr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Dec 2019 07:19:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1341328;
        Thu, 19 Dec 2019 04:19:46 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575023F719;
        Thu, 19 Dec 2019 04:19:44 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, james.morse@arm.com,
        hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com,
        linux@armlinux.org.uk, davem@davemloft.net,
        sparclinux@vger.kernel.org, hch@infradead.org
Subject: [RFC PATCH v3 09/12] x86: smp: use SMP crash-stop common code
Date:   Thu, 19 Dec 2019 12:19:02 +0000
Message-Id: <20191219121905.26905-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219121905.26905-1-cristian.marussi@arm.com>
References: <20191219121905.26905-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make x86 use the SMP common implementation of crash_smp_send_stop() and
its generic logic, by removing the x86 crash_smp_send_stop() definition
and providing the needed arch specific helpers.

Remove also redundant smp_ops.crash_stop_other_cpus(); add shared util
function do_nmi_shootdown_cpus(), which is a generalization of the previous
nmi_shootdown_cpus(), and it is used by architecture backend helper
arch_smp_crash_call().

Modify original crash_nmi_callback() to properly set cpu offline flag
and adding needed memory barriers.

Modify original nmi_shootdown_cpus() to rely on common code logic provided
by generic crash_smp_send_stop(): this was needed because the original
nmi_shootdown_cpus() was used also on the emergency reboot path, employing
a different callback. Reuse the same shootdown_callback mechanism to
properly handle both a crash and an emergency reboot through the same
common code crash path.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Note that in this patch we kept in use the original x86 local handling
of 'crashing_cpu' variable:

	crashing_cpu = safe_smp_processor_id();

Instead, common SMP stop code could have been easily extended to keep and
expose to architectures backends such value using some additional helper
like smp_stop_get_stopping_cpu_id().

This has not been addressed in this series.

v2 --> v3
- conflicts
- simplified _shootdown_nmi_cpus calls
---
 arch/x86/include/asm/reboot.h |  2 ++
 arch/x86/include/asm/smp.h    |  1 -
 arch/x86/kernel/crash.c       | 27 +++-------------
 arch/x86/kernel/reboot.c      | 58 ++++++++++++++++++++++-------------
 arch/x86/kernel/smp.c         |  3 --
 5 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 04c17be9b5fd..bae3ecf84659 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_REBOOT_H
 
 #include <linux/kdebug.h>
+#include <linux/cpumask.h>
 
 struct pt_regs;
 
@@ -28,6 +29,7 @@ void __noreturn machine_real_restart(unsigned int type);
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
 void nmi_panic_self_stop(struct pt_regs *regs);
 void nmi_shootdown_cpus(nmi_shootdown_cb callback);
+void do_nmi_shootdown_cpus(cpumask_t *cpus, nmi_shootdown_cb callback);
 void run_crash_ipi_callback(struct pt_regs *regs);
 
 #endif /* _ASM_X86_REBOOT_H */
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index e937fab6474b..22db383fc2d3 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -49,7 +49,6 @@ struct smp_ops {
 	void (*smp_cpus_done)(unsigned max_cpus);
 
 	void (*stop_other_cpus)(int wait);
-	void (*crash_stop_other_cpus)(void);
 	void (*smp_send_reschedule)(int cpu);
 
 	int (*cpu_up)(unsigned cpu, struct task_struct *tidle);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 00fc55ac7ffa..c311a70bcb76 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -111,34 +111,16 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 	disable_local_APIC();
 }
 
-void kdump_nmi_shootdown_cpus(void)
+void arch_smp_crash_call(cpumask_t *cpus, unsigned int __unused)
 {
-	nmi_shootdown_cpus(kdump_nmi_callback);
-
-	disable_local_APIC();
+	do_nmi_shootdown_cpus(cpus, kdump_nmi_callback);
 }
 
-/* Override the weak function in kernel/panic.c */
-void crash_smp_send_stop(void)
+void arch_smp_cpus_crash_complete(void)
 {
-	static int cpus_stopped;
-
-	if (cpus_stopped)
-		return;
-
-	if (smp_ops.crash_stop_other_cpus)
-		smp_ops.crash_stop_other_cpus();
-	else
-		smp_send_stop();
-
-	cpus_stopped = 1;
+	disable_local_APIC();
 }
 
-#else
-void crash_smp_send_stop(void)
-{
-	/* There are no cpus to shootdown */
-}
 #endif
 
 void native_machine_crash_shutdown(struct pt_regs *regs)
@@ -154,6 +136,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	/* The kernel is broken so disable interrupts */
 	local_irq_disable();
 
+	/* calling into SMP common stop code */
 	crash_smp_send_stop();
 
 	/*
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0cc7c0b106bb..0d1bf44643e9 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -799,7 +799,6 @@ int crashing_cpu = -1;
 
 static nmi_shootdown_cb shootdown_callback;
 
-static atomic_t waiting_for_crash_ipi;
 static int crash_ipi_issued;
 
 static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
@@ -819,7 +818,12 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 
 	shootdown_callback(cpu, regs);
 
-	atomic_dec(&waiting_for_crash_ipi);
+	/* ensure all shootdown writes are visible once cpu is seen offline */
+	smp_wmb();
+	set_cpu_online(cpu, false);
+	/* ensure all writes are globally visible before cpu parks */
+	wmb();
+
 	/* Assume hlt works */
 	halt();
 	for (;;)
@@ -829,23 +833,26 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 }
 
 /*
- * Halt all other CPUs, calling the specified function on each of them
- *
- * This function can be used to halt all other CPUs on crash
- * or emergency reboot time. The function passed as parameter
- * will be called inside a NMI handler on all CPUs.
+ * Halt the specified @cpus, calling the provided @callback on each of them
+ * unless a shootdown_callback was already installed previously: this way
+ * we can handle here also the emergency reboot requests issued via
+ * nmi_shootdown_cpus() and routed via usual common code crash_smp_send_stop()
  */
-void nmi_shootdown_cpus(nmi_shootdown_cb callback)
+void do_nmi_shootdown_cpus(cpumask_t *cpus, nmi_shootdown_cb callback)
 {
-	unsigned long msecs;
-	local_irq_disable();
+	if (!shootdown_callback)
+		shootdown_callback = callback;
+
+	if (!cpus) {
+		/* ensure callback in place before calling commmon SMP */
+		wmb();
+		/* call into common SMP to reuse the generic logic */
+		return crash_smp_send_stop();
+	}
 
+	local_irq_disable();
 	/* Make a note of crashing cpu. Will be used in NMI callback. */
 	crashing_cpu = safe_smp_processor_id();
-
-	shootdown_callback = callback;
-
-	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
 	/* Would it be better to replace the trap vector here? */
 	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
 				 NMI_FLAG_FIRST, "crash"))
@@ -855,21 +862,28 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	 * out the NMI
 	 */
 	wmb();
-
-	apic_send_IPI_allbutself(NMI_VECTOR);
+	apic->send_IPI_mask(cpus, NMI_VECTOR);
 
 	/* Kick CPUs looping in NMI context. */
 	WRITE_ONCE(crash_ipi_issued, 1);
 
-	msecs = 1000; /* Wait at most a second for the other cpus to stop */
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
-		mdelay(1);
-		msecs--;
-	}
-
 	/* Leave the nmi callback set */
 }
 
+/*
+ * Halt all other CPUs, calling the specified function on each of them
+ *
+ * This function can be used to halt all other CPUs on crash
+ * or emergency reboot time. The function passed as parameter
+ * will be called inside a NMI handler on all CPUs.
+ *
+ * It relies on crash_smp_send_stop() common code logic to shutdown CPUs.
+ */
+void nmi_shootdown_cpus(nmi_shootdown_cb callback)
+{
+	do_nmi_shootdown_cpus(NULL, callback);
+}
+
 /*
  * Check if the crash dumping IPI got issued and if so, call its callback
  * directly. This function is used when we have already been in NMI handler.
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 7aeb45c512f7..3bd93912898a 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -276,9 +276,6 @@ struct smp_ops smp_ops = {
 	.smp_cpus_done		= native_smp_cpus_done,
 
 	.stop_other_cpus	= native_stop_other_cpus,
-#if defined(CONFIG_KEXEC_CORE)
-	.crash_stop_other_cpus	= kdump_nmi_shootdown_cpus,
-#endif
 	.smp_send_reschedule	= native_smp_send_reschedule,
 
 	.cpu_up			= native_cpu_up,
-- 
2.17.1

