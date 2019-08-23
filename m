Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0D389AE8C
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393220AbfHWL6r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 07:58:47 -0400
Received: from foss.arm.com ([217.140.110.172]:33010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393528AbfHWL61 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 07:58:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DCC415A2;
        Fri, 23 Aug 2019 04:58:26 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 148283F246;
        Fri, 23 Aug 2019 04:58:24 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dave.martin@arm.com, james.morse@arm.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, takahiro.akashi@linaro.org,
        hidehiro.kawai.ez@hitachi.com
Subject: [RFC PATCH 2/7] smp: unify crash_ and smp_send_stop() logic
Date:   Fri, 23 Aug 2019 12:57:15 +0100
Message-Id: <20190823115720.605-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823115720.605-1-cristian.marussi@arm.com>
References: <20190823115720.605-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

crash_smp_send_stop() logic was fairly similar to smp_send_stop():
a lot of logic and code was duplicated between the two code paths and
across a few different architectures.

Unify this underlying common logic into the existing SMP common stop
code: use a common workhorse function for both paths to perform the
common tasks while taking care to propagate to the underlying
architecture code the intent of the stop operation: a simple stop or
a crash dump stop.

Relocate the __weak crash_smp_send_stop() function from panic.c to smp.c,
since it is the crash dump entry point for the crash stop process and now
calls into this new common logic (only if this latter is enabled by
ARCH_USE_COMMON_SMP_STOP=y).

Introduce a few more helpers so that the architectures willing to use
the common code logic can provide their arch-specific bits to handle
the differences between a stop and a crash stop; architectures can
anyway decide to override as a whole the common logic providing their
own custom solution in crash_smp_send_stop() (as it was before).

Provide also a new common code method to inquiry on the outcome of an
ongoing crash_stop procedure: smp_crash_stop_failed().

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 include/linux/smp.h | 25 +++++++++++++++++++
 kernel/panic.c      | 26 --------------------
 kernel/smp.c        | 58 ++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 80 insertions(+), 29 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 0fea0e6d2339..21c97c175dad 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -91,8 +91,27 @@ extern void arch_smp_stop_call(cpumask_t *cpus);
  * the local CPU once the other CPUs have been successfully stopped.
  */
 void arch_smp_cpus_stop_complete(void);
+
+/*
+ * An Architecture CAN additionally provide the arch_smp_crash_call()
+ * helper which implements the arch-specific crash dump related operations.
+ *
+ * If such arch wants to fully support crash dump, this MUST be provided;
+ * when not provided the crash dump procedure will fallback to behave like
+ * a normal stop. (no saved regs, no arch-specific features disabled)
+ */
+extern void arch_smp_crash_call(cpumask_t *cpus);
+
+/* Helper to query the outcome of an ongoing crash_stop operation */
+bool smp_crash_stop_failed(void);
 #endif
 
+/*
+ * stops all CPUs but the current one propagating to all other CPUs
+ * the information that a crash_kexec is ongoing:
+ */
+void crash_smp_send_stop(void);
+
 /*
  * sends a 'reschedule' event to another CPU:
  */
@@ -156,6 +175,12 @@ static inline int get_boot_cpu_id(void)
 
 static inline void smp_send_stop(void) { }
 
+static inline void crash_smp_send_stop(void) { }
+
+#ifdef CONFIG_ARCH_USE_COMMON_SMP_STOP
+static inline bool smp_crash_stop_failed(void) { }
+#endif
+
 /*
  *	These macros fold the SMP functionality into a single CPU system
  */
diff --git a/kernel/panic.c b/kernel/panic.c
index 057540b6eee9..bc0dbf9c9b75 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -86,32 +86,6 @@ void __weak nmi_panic_self_stop(struct pt_regs *regs)
 	panic_smp_self_stop();
 }
 
-/*
- * Stop other CPUs in panic.  Architecture dependent code may override this
- * with more suitable version.  For example, if the architecture supports
- * crash dump, it should save registers of each stopped CPU and disable
- * per-CPU features such as virtualization extensions.
- */
-void __weak crash_smp_send_stop(void)
-{
-	static int cpus_stopped;
-
-	/*
-	 * This function can be called twice in panic path, but obviously
-	 * we execute this only once.
-	 */
-	if (cpus_stopped)
-		return;
-
-	/*
-	 * Note smp_send_stop is the usual smp shutdown function, which
-	 * unfortunately means it may not be hardened to work in a panic
-	 * situation.
-	 */
-	smp_send_stop();
-	cpus_stopped = 1;
-}
-
 atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 
 /*
diff --git a/kernel/smp.c b/kernel/smp.c
index 700502ee2546..31e981eb9bd8 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -820,6 +820,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 EXPORT_SYMBOL_GPL(smp_call_on_cpu);
 
 #ifdef CONFIG_ARCH_USE_COMMON_SMP_STOP
+
 void __weak arch_smp_cpus_stop_complete(void) { }
 
 static inline bool any_other_cpus_online(cpumask_t *mask,
@@ -831,6 +832,12 @@ static inline bool any_other_cpus_online(cpumask_t *mask,
 	return !cpumask_empty(mask);
 }
 
+void __weak arch_smp_crash_call(cpumask_t *cpus)
+{
+	pr_debug("SMP: Using generic %s() as SMP crash call.\n", __func__);
+	arch_smp_stop_call(cpus);
+}
+
 /*
  * This centralizes the common logic to:
  *
@@ -842,7 +849,7 @@ static inline bool any_other_cpus_online(cpumask_t *mask,
  *  - wait for the stop operation to be completed across all involved CPUs
  *    monitoring the cpu_online_mask
  */
-void smp_send_stop(void)
+static inline void __smp_send_stop_all(bool reason_crash)
 {
 	unsigned int this_cpu_id;
 	cpumask_t mask;
@@ -854,8 +861,11 @@ void smp_send_stop(void)
 
 		if (system_state <= SYSTEM_RUNNING)
 			pr_crit("stopping secondary CPUs\n");
-		arch_smp_stop_call(&mask);
-
+		/* smp and crash arch-backends helpers are kept distinct */
+		if (!reason_crash)
+			arch_smp_stop_call(&mask);
+		else
+			arch_smp_crash_call(&mask);
 		/*
 		 * Wait up to one second for other CPUs to stop.
 		 *
@@ -879,4 +889,46 @@ void smp_send_stop(void)
 	/* Perform final (possibly arch-specific) work on this CPU */
 	arch_smp_cpus_stop_complete();
 }
+
+void smp_send_stop(void)
+{
+	__smp_send_stop_all(false);
+}
+
+bool __weak smp_crash_stop_failed(void)
+{
+	return (num_online_cpus() > cpu_online(smp_processor_id()));
+}
+#endif
+
+/*
+ * Stop other CPUs while passing down the additional information that a
+ * crash_kexec is ongoing: it's up to the architecture implementation
+ * decide what to do.
+ *
+ * For example, Architectures supporting crash dump should provide
+ * specialized support for saving registers and disabling per-CPU features
+ * like virtualization extensions.
+ *
+ * Behaviour in the CONFIG_ARCH_USE_COMMON_SMP_STOP=n case is preserved
+ * as it was before.
+ */
+void __weak crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+
+	/*
+	 * This function can be called twice in panic path, but obviously
+	 * we execute this only once.
+	 */
+	if (cpus_stopped)
+		return;
+
+#ifdef CONFIG_ARCH_USE_COMMON_SMP_STOP
+	__smp_send_stop_all(true);
+#else
+	smp_send_stop();
 #endif
+
+	cpus_stopped = 1;
+}
-- 
2.17.1

