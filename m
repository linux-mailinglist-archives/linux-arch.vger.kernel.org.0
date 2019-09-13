Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0E3BB24FB
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2019 20:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389698AbfIMSUt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Sep 2019 14:20:49 -0400
Received: from foss.arm.com ([217.140.110.172]:47832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389336AbfIMSUs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Sep 2019 14:20:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3D401570;
        Fri, 13 Sep 2019 11:20:47 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5644C3F71F;
        Fri, 13 Sep 2019 11:20:45 -0700 (PDT)
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
Subject: [RFC PATCH v2 01/12] smp: add generic SMP-stop support to common code
Date:   Fri, 13 Sep 2019 19:19:42 +0100
Message-Id: <20190913181953.45748-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913181953.45748-1-cristian.marussi@arm.com>
References: <20190913181953.45748-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There was a lot of code duplication across architectures regarding the
SMP stop procedures' logic; moreover some of this duplicated code logic
happened to be similarly faulty across a few architectures: while fixing
such logic, move such generic logic as much as possible inside common
code.

Collect all the common logic related to SMP stop operations into the
common SMP code; any architecture willing to use such centralized logic
can select CONFIG_ARCH_USE_COMMON_STOP=y and provide the related
arch-specific helpers: in such a scenario, those architectures will
transparently start using the common code provided by smp_send_stop()
common function.

On the other side, Architectures not willing to use common code SMP stop
logic will simply leave CONFIG_ARCH_USE_COMMON_STOP undefined and carry
on executing their local arch-specific smp_send_stop() as before.

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- moved related Kconfig to common code inside arch/Kconfig
- introduced additional CONFIG_USE_COMMON_STOP selected by
  CONFIG_ARCH_USE_COMMON_STOP
- introduced helpers to let architectures optionally alter
  the default common code behaviour while waiting for CPUs:
  change timeout or wait for ever. (will be needed by x86)
---
 arch/Kconfig        |  7 +++++
 include/linux/smp.h | 55 +++++++++++++++++++++++++++++++++++++
 kernel/smp.c        | 67 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index a7b57dd42c26..89766e6c0ac8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -166,6 +166,13 @@ config ARCH_USE_BUILTIN_BSWAP
 	 instructions should set this. And it shouldn't hurt to set it
 	 on architectures that don't have such instructions.
 
+config ARCH_USE_COMMON_SMP_STOP
+       def_bool n
+
+config USE_COMMON_SMP_STOP
+       depends on SMP && ARCH_USE_COMMON_SMP_STOP
+       def_bool y
+
 config KRETPROBES
 	def_bool y
 	depends on KPROBES && HAVE_KRETPROBES
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 6fc856c9eda5..381a14bfcd96 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -77,6 +77,61 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd);
  */
 extern void smp_send_stop(void);
 
+#ifdef CONFIG_USE_COMMON_SMP_STOP
+static atomic_t wait_forever;
+static atomic_t wait_timeout = ATOMIC_INIT(USEC_PER_SEC);
+
+/*
+ * An Architecture can optionally decide to use this helper to change the
+ * waiting behaviour of common STOP logic, forcing to wait forever for
+ * all CPUs to be stopped.
+ */
+static inline void smp_stop_set_wait_forever(int wait)
+{
+	atomic_set(&wait_forever, wait);
+	/* ensure wait atomic-op is visible */
+	smp_mb__after_atomic();
+}
+
+/*
+ * An Architecture can optionally decide to use this helper to change the
+ * waiting timeout of common STOP logic. A ZERO timeout means no timeout
+ * at all as long as wait_forever was not previously set.
+ *
+ * Note that wait_forever and timeout must remain individually selectable:
+ * so you can temporarily request wait_forever while keeping the same timeout
+ * settings.
+ */
+static inline void smp_stop_set_wait_timeout_us(unsigned long timeout)
+{
+	atomic_set(&wait_timeout, timeout);
+	/* ensure timeout atomic-op is visible */
+	smp_mb__after_atomic();
+}
+
+/* Retrieve the current wait settings. */
+static inline bool smp_stop_get_wait_timeout_us(unsigned long *timeout)
+{
+	if (timeout)
+		*timeout = atomic_read(&wait_timeout);
+	return atomic_read(&wait_forever);
+}
+
+/*
+ * Any Architecture willing to use STOP common logic implementation
+ * MUST at least provide the arch_smp_stop_call() helper which is in
+ * charge of its own arch-specific CPU-stop mechanism.
+ */
+extern void arch_smp_stop_call(cpumask_t *cpus);
+
+/*
+ * An Architecture CAN also provide the arch_smp_cpus_stop_complete()
+ * dedicated helper, to perform any final arch-specific operation on
+ * the local CPU once the other CPUs have been successfully stopped.
+ */
+void arch_smp_cpus_stop_complete(void);
+#endif
+
 /*
  * sends a 'reschedule' event to another CPU:
  */
diff --git a/kernel/smp.c b/kernel/smp.c
index 7dbcb402c2fc..72f99bf13fd0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
+#include <linux/delay.h>
 
 #include "smpboot.h"
 
@@ -817,3 +818,69 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 	return sscs.ret;
 }
 EXPORT_SYMBOL_GPL(smp_call_on_cpu);
+
+#ifdef CONFIG_USE_COMMON_SMP_STOP
+void __weak arch_smp_cpus_stop_complete(void) { }
+
+static inline bool any_other_cpus_online(cpumask_t *mask,
+					 unsigned int this_cpu_id)
+{
+	cpumask_copy(mask, cpu_online_mask);
+	cpumask_clear_cpu(this_cpu_id, mask);
+
+	return !cpumask_empty(mask);
+}
+
+/*
+ * This centralizes the common logic to:
+ *
+ *  - evaluate which CPUs are online and needs to be notified for stop,
+ *    while considering properly the status of the calling CPU
+ *
+ *  - call the arch-specific helpers to request the effective stop
+ *
+ *  - wait for the stop operation to be completed across all involved CPUs
+ *    monitoring the cpu_online_mask
+ */
+void smp_send_stop(void)
+{
+	unsigned int this_cpu_id;
+	cpumask_t mask;
+
+	this_cpu_id = smp_processor_id();
+	if (any_other_cpus_online(&mask, this_cpu_id)) {
+		bool wait;
+		unsigned long timeout;
+		unsigned int this_cpu_online = cpu_online(this_cpu_id);
+
+		if (system_state <= SYSTEM_RUNNING)
+			pr_crit("stopping secondary CPUs\n");
+		arch_smp_stop_call(&mask);
+
+		/*
+		 * Defaults to wait up to one second for other CPUs to stop;
+		 * architectures can modify the default timeout or request
+		 * to wait forever.
+		 *
+		 * Here we rely simply on cpu_online_mask to sync with
+		 * arch-specific stop code without bloating the code with an
+		 * additional atomic_t ad-hoc counter.
+		 *
+		 * As a consequence we'll need proper explicit memory barriers
+		 * in case the other CPUs running the arch-specific stop-code
+		 * would need to commit to memory some data (like saved_regs).
+		 */
+		wait = smp_stop_get_wait_timeout_us(&timeout);
+		while (num_online_cpus() > this_cpu_online &&
+		       (wait || timeout--))
+			udelay(1);
+		/* ensure any stopping-CPUs memory access is made visible */
+		smp_rmb();
+		if (num_online_cpus() > this_cpu_online)
+			pr_warn("failed to stop secondary CPUs %*pbl\n",
+				cpumask_pr_args(cpu_online_mask));
+	}
+	/* Perform final (possibly arch-specific) work on this CPU */
+	arch_smp_cpus_stop_complete();
+}
+#endif
-- 
2.17.1

