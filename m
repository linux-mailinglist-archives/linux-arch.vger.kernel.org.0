Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F068126208
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2019 13:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLSMUO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Dec 2019 07:20:14 -0500
Received: from foss.arm.com ([217.140.110.172]:37866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfLSMTe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Dec 2019 07:19:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D84F31B;
        Thu, 19 Dec 2019 04:19:34 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2FBD3F719;
        Thu, 19 Dec 2019 04:19:31 -0800 (PST)
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
Subject: [RFC PATCH v3 04/12] smp: address races of starting CPUs while stopping
Date:   Thu, 19 Dec 2019 12:18:57 +0000
Message-Id: <20191219121905.26905-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219121905.26905-1-cristian.marussi@arm.com>
References: <20191219121905.26905-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add to SMP stop common code a best-effort retry logic, re-issuing a stop
request when any CPU is detected to be still online after the first
stop request cycle has completed.

While retrying provide to architectures' helpers an 'attempt' argument
so that, after a possible first failed attempt, they can autonomously
decide to adopt different approaches in subsequent retries.

Address the case in which some CPUs could still be starting up when the
stop process is initiated, remaining so undetected and coming fully online
only after the SMP stop procedure was already started: such officially
still offline CPUs would be missed by an ongoing stop procedure.

Being a best effort approach, though, it is not always guaranteed to be
able to stop any CPU that happened to finally come online after the whole
SMP stop retry cycle has completed.
(i.e. the race-window is reduced but not eliminated)

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- reviewed max_retries get/set helpers to avoid header global static
v1 --> v2
- added attempt_num param to arch helpers, to let arch implementation
  know if a retry is ongoing because some CPU failed to stop.
  (some arch like x86 attempts the retry with different means like NMI)
- added some helpers to let archs decide on the number of retries

---
A more deterministic approach has been also attempted in order to catch
any concurrently starting CPUs at the very last moment and make them
kill themselves by:

- adding a new set_cpus_stopping() in cpumask.h used to set a
  __cpus_stopping atomic internal flag

- modifying set_cpu_online() to check on __cpus_stopping only when
  coming online, and force the offending CPU to kill itself in that case

Anyway it has proved tricky and complex (beside faulty) to implement the
above 'kill-myself' phase in a reliable way while remaining architecture
agnostic and still distingushing properly regular stops from crash kexec.

So given that the main idea underlying this patch series was instead of
simplifying and unifying code and the residual races not caught by the
best-effort logic seemed not very likely, this more deterministic approach
has been dropped in favour of the best effort retry logic.

Moreover, the current retry logic will be anyway needed to support some
architectures, like x86, that prefer to use different CPU's stopping
methods in subsequent retries.
---
 include/linux/smp.h | 11 +++++++++--
 kernel/smp.c        | 34 +++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 42be03ac1c0c..247c78434a3d 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -78,6 +78,7 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 extern void smp_send_stop(void);
 
 #ifdef CONFIG_USE_COMMON_SMP_STOP
+
 /*
  * An Architecture can optionally use this helper to change the default
  * waiting behaviour of common STOP logic.
@@ -101,12 +102,18 @@ void smp_stop_set_wait_timeout_us(unsigned long timeout);
  */
 bool smp_stop_get_wait_settings(unsigned long *timeout);
 
+/* Change common SMP STOP logic maximum retries */
+void smp_stop_set_max_retries(unsigned int max_retries);
+
+/* Get currently set maximum retries attempt */
+unsigned int smp_stop_get_max_retries(void);
+
 /*
  * Any Architecture willing to use STOP common logic implementation
  * MUST at least provide the arch_smp_stop_call() helper which implements
  * the arch-specific CPU-stop mechanism.
  */
-extern void arch_smp_stop_call(cpumask_t *cpus);
+extern void arch_smp_stop_call(cpumask_t *cpus, unsigned int attempt_num);
 
 /*
  * An Architecture CAN also provide the arch_smp_cpus_stop_complete()
@@ -132,7 +139,7 @@ void arch_smp_cpus_crash_complete(void);
  * when not provided the crash dump procedure will fallback to behave like
  * a normal stop. (no saved regs, no arch-specific features disabled)
  */
-extern void arch_smp_crash_call(cpumask_t *cpus);
+extern void arch_smp_crash_call(cpumask_t *cpus, unsigned int attempt_num);
 
 /* Helper to query the outcome of an ongoing crash_stop operation */
 bool smp_crash_stop_failed(void);
diff --git a/kernel/smp.c b/kernel/smp.c
index 29eb6eff2063..46a307d2351e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -823,6 +823,9 @@ EXPORT_SYMBOL_GPL(smp_call_on_cpu);
 static atomic_t smp_stop_wait_forever;
 static atomic_t smp_stop_wait_timeout = ATOMIC_INIT(USEC_PER_SEC);
 
+#define	DEFAULT_MAX_STOP_RETRIES	2
+static atomic_t max_stop_retries = ATOMIC_INIT(DEFAULT_MAX_STOP_RETRIES);
+
 void smp_stop_set_wait_forever(bool wait_forever)
 {
 	atomic_set(&smp_stop_wait_forever, wait_forever);
@@ -844,6 +847,18 @@ bool smp_stop_get_wait_settings(unsigned long *timeout)
 	return atomic_read(&smp_stop_wait_forever);
 }
 
+void smp_stop_set_max_retries(unsigned int max_retries)
+{
+	atomic_set(&max_stop_retries, max_retries);
+	/* ensure retries atomics are visible */
+	smp_mb__after_atomic();
+}
+
+unsigned int smp_stop_get_max_retries(void)
+{
+	return atomic_read(&max_stop_retries);
+}
+
 void __weak arch_smp_cpu_park(void)
 {
 	while (1)
@@ -866,10 +881,10 @@ static inline bool any_other_cpus_online(cpumask_t *mask,
 	return !cpumask_empty(mask);
 }
 
-void __weak arch_smp_crash_call(cpumask_t *cpus)
+void __weak arch_smp_crash_call(cpumask_t *cpus, unsigned int attempt_num)
 {
 	pr_debug("SMP: Using generic %s() as SMP crash call.\n", __func__);
-	arch_smp_stop_call(cpus);
+	arch_smp_stop_call(cpus, attempt_num);
 }
 
 #define	REASON_STOP	1
@@ -888,10 +903,10 @@ void __weak arch_smp_crash_call(cpumask_t *cpus)
  */
 static void __smp_send_stop_all(bool crash)
 {
-	unsigned int this_cpu_id;
 	cpumask_t mask;
 	static atomic_t stopping;
 	int was_stopping;
+	unsigned int this_cpu_id, max_retries, attempt = 0;
 
 	this_cpu_id = smp_processor_id();
 	/* make sure that concurrent stop requests are handled properly */
@@ -922,7 +937,9 @@ static void __smp_send_stop_all(bool crash)
 			arch_smp_cpu_park();
 		}
 	}
-	if (any_other_cpus_online(&mask, this_cpu_id)) {
+	max_retries = smp_stop_get_max_retries();
+	while (++attempt <= max_retries &&
+	       any_other_cpus_online(&mask, this_cpu_id)) {
 		bool wait_forever;
 		unsigned long timeout;
 		unsigned int this_cpu_online = cpu_online(this_cpu_id);
@@ -931,9 +948,9 @@ static void __smp_send_stop_all(bool crash)
 			pr_crit("stopping secondary CPUs\n");
 		/* smp and crash arch-backends helpers are kept distinct */
 		if (!crash)
-			arch_smp_stop_call(&mask);
+			arch_smp_stop_call(&mask, attempt);
 		else
-			arch_smp_crash_call(&mask);
+			arch_smp_crash_call(&mask, attempt);
 		/*
 		 * Defaults to wait up to one second for other CPUs to stop;
 		 * architectures can modify the default timeout or request
@@ -953,9 +970,12 @@ static void __smp_send_stop_all(bool crash)
 			udelay(1);
 		/* ensure any stopping-CPUs memory access is made visible */
 		smp_rmb();
-		if (num_online_cpus() > this_cpu_online)
+		if (num_online_cpus() > this_cpu_online) {
 			pr_warn("failed to stop secondary CPUs %*pbl\n",
 				cpumask_pr_args(cpu_online_mask));
+			if (attempt < max_retries)
+				pr_warn("Retrying SMP stop call...\n");
+		}
 	}
 	/* Perform final (possibly arch-specific) work on this CPU */
 	if (!crash)
-- 
2.17.1

