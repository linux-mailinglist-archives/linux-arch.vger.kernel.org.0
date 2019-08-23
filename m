Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD799AE80
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 13:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393527AbfHWL60 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 07:58:26 -0400
Received: from foss.arm.com ([217.140.110.172]:32992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389426AbfHWL6Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 07:58:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D37C81570;
        Fri, 23 Aug 2019 04:58:24 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49F0F3F246;
        Fri, 23 Aug 2019 04:58:23 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dave.martin@arm.com, james.morse@arm.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, takahiro.akashi@linaro.org,
        hidehiro.kawai.ez@hitachi.com
Subject: [RFC PATCH 1/7] smp: add generic SMP-stop support to common code
Date:   Fri, 23 Aug 2019 12:57:14 +0100
Message-Id: <20190823115720.605-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823115720.605-1-cristian.marussi@arm.com>
References: <20190823115720.605-1-cristian.marussi@arm.com>
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
 include/linux/smp.h | 16 ++++++++++++
 kernel/smp.c        | 63 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 6fc856c9eda5..0fea0e6d2339 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -77,6 +77,22 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd);
  */
 extern void smp_send_stop(void);
 
+#ifdef CONFIG_ARCH_USE_COMMON_SMP_STOP
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
index 7dbcb402c2fc..700502ee2546 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
+#include <linux/delay.h>
 
 #include "smpboot.h"
 
@@ -817,3 +818,65 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 	return sscs.ret;
 }
 EXPORT_SYMBOL_GPL(smp_call_on_cpu);
+
+#ifdef CONFIG_ARCH_USE_COMMON_SMP_STOP
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
+		unsigned long timeout;
+		unsigned int this_cpu_online = cpu_online(this_cpu_id);
+
+		if (system_state <= SYSTEM_RUNNING)
+			pr_crit("stopping secondary CPUs\n");
+		arch_smp_stop_call(&mask);
+
+		/*
+		 * Wait up to one second for other CPUs to stop.
+		 *
+		 * Here we rely simply on cpu_online_mask to sync with
+		 * arch-specific stop code without bloating the code with an
+		 * additional atomic_t ad-hoc counter.
+		 *
+		 * As a consequence we'll need proper explicit memory barriers
+		 * in case the other CPUs running the arch-specific stop-code
+		 * would need to commit to memory some data (like saved_regs).
+		 */
+		timeout = USEC_PER_SEC;
+		while (num_online_cpus() > this_cpu_online && timeout--)
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

