Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24FE9B2521
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2019 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391258AbfIMSVP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Sep 2019 14:21:15 -0400
Received: from foss.arm.com ([217.140.110.172]:48062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389857AbfIMSVP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Sep 2019 14:21:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 955F115A2;
        Fri, 13 Sep 2019 11:21:14 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 281FD3F71F;
        Fri, 13 Sep 2019 11:21:12 -0700 (PDT)
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
Subject: [RFC PATCH v2 11/12] arm: smp: use SMP crash-stop common code
Date:   Fri, 13 Sep 2019 19:19:52 +0100
Message-Id: <20190913181953.45748-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913181953.45748-1-cristian.marussi@arm.com>
References: <20190913181953.45748-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make arm use the SMP common implementation of crash_smp_send_stop() and
its generic logic, by removing the arm crash_smp_send_stop() definition
and providing the needed arch specific helpers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 arch/arm/kernel/machine_kexec.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 76300f3813e8..d53973cae362 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -29,8 +29,6 @@ extern unsigned long kexec_indirection_page;
 extern unsigned long kexec_mach_type;
 extern unsigned long kexec_boot_atags;
 
-static atomic_t waiting_for_crash_ipi;
-
 /*
  * Provide a dummy crash_notes definition while crash dump arrives to arm.
  * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
@@ -89,34 +87,21 @@ void machine_crash_nonpanic_core(void *unused)
 	crash_save_cpu(&regs, smp_processor_id());
 	flush_cache_all();
 
+	/* ensure saved regs writes are visible before going offline */
+	smp_wmb();
 	set_cpu_online(smp_processor_id(), false);
-	atomic_dec(&waiting_for_crash_ipi);
 
+	/* ensure all writes visible before parking */
+	wmb();
 	while (1) {
 		cpu_relax();
 		wfe();
 	}
 }
 
-void crash_smp_send_stop(void)
+void arch_smp_crash_call(cpumask_t *cpus, unsigned int __unused)
 {
-	static int cpus_stopped;
-	unsigned long msecs;
-
-	if (cpus_stopped)
-		return;
-
-	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	smp_call_function(machine_crash_nonpanic_core, NULL, false);
-	msecs = 1000; /* Wait at most a second for the other cpus to stop */
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
-		mdelay(1);
-		msecs--;
-	}
-	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warn("Non-crashing CPUs did not react to IPI\n");
-
-	cpus_stopped = 1;
+	smp_call_function_many(cpus, machine_crash_nonpanic_core, NULL, false);
 }
 
 static void machine_kexec_mask_interrupts(void)
-- 
2.17.1

