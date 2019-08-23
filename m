Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1593F9AE84
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 13:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbfHWL6b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 07:58:31 -0400
Received: from foss.arm.com ([217.140.110.172]:33044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394054AbfHWL6b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 07:58:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37C0415AB;
        Fri, 23 Aug 2019 04:58:30 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DEAC3F246;
        Fri, 23 Aug 2019 04:58:28 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dave.martin@arm.com, james.morse@arm.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, takahiro.akashi@linaro.org,
        hidehiro.kawai.ez@hitachi.com
Subject: [RFC PATCH 4/7] smp: address races of starting CPUs while stopping
Date:   Fri, 23 Aug 2019 12:57:17 +0100
Message-Id: <20190823115720.605-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823115720.605-1-cristian.marussi@arm.com>
References: <20190823115720.605-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add to SMP stop common code a best-effort retry logic, re-issuing a stop
request when any CPU is detected to be still online after the first
stop request cycle has completed.

Address the case in which some CPUs could be still starting up when the
stop process is started, remaining so undetected and coming fully online
only after the SMP stop procedure was already started: such officially
still offline CPUs would be missed by an ongoing stop procedure.
(not considering here the special case of stuck CPUs)

Using here a best effort approach, though, it is not anyway guaranteed
to be able to stop any CPU that happened to finally come online after
the whole SMP stop retry cycle has completed.
(i.e. the race-window is reduced but not eliminated)

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
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
---
 kernel/smp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index ea8a1cc0ec3e..10d3120494f2 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -847,6 +847,8 @@ void __weak arch_smp_crash_call(cpumask_t *cpus)
 #define	REASON_STOP	1
 #define	REASON_CRASH	2
 
+#define	MAX_STOP_RETRIES	2
+
 /*
  * This centralizes the common logic to:
  *
@@ -860,7 +862,7 @@ void __weak arch_smp_crash_call(cpumask_t *cpus)
  */
 static inline void __smp_send_stop_all(bool reason_crash)
 {
-	unsigned int this_cpu_id;
+	unsigned int this_cpu_id, retries = MAX_STOP_RETRIES;
 	cpumask_t mask;
 	static atomic_t stopping;
 	int was_reason;
@@ -894,7 +896,7 @@ static inline void __smp_send_stop_all(bool reason_crash)
 			arch_smp_cpu_park();
 		}
 	}
-	if (any_other_cpus_online(&mask, this_cpu_id)) {
+	while (retries-- && any_other_cpus_online(&mask, this_cpu_id)) {
 		unsigned long timeout;
 		unsigned int this_cpu_online = cpu_online(this_cpu_id);
 
@@ -921,9 +923,12 @@ static inline void __smp_send_stop_all(bool reason_crash)
 			udelay(1);
 		/* ensure any stopping-CPUs memory access is made visible */
 		smp_rmb();
-		if (num_online_cpus() > this_cpu_online)
+		if (num_online_cpus() > this_cpu_online) {
 			pr_warn("failed to stop secondary CPUs %*pbl\n",
 				cpumask_pr_args(cpu_online_mask));
+			if (retries)
+				pr_warn("Retrying SMP stop call...\n");
+		}
 	}
 	/* Perform final (possibly arch-specific) work on this CPU */
 	arch_smp_cpus_stop_complete();
-- 
2.17.1

