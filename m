Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE01261F6
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2019 13:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLSMTu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Dec 2019 07:19:50 -0500
Received: from foss.arm.com ([217.140.110.172]:38014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfLSMTt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Dec 2019 07:19:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D23631B;
        Thu, 19 Dec 2019 04:19:49 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D60563F719;
        Thu, 19 Dec 2019 04:19:46 -0800 (PST)
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
Subject: [RFC PATCH v3 10/12] arm: smp: use generic SMP stop common code
Date:   Thu, 19 Dec 2019 12:19:03 +0000
Message-Id: <20191219121905.26905-11-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219121905.26905-1-cristian.marussi@arm.com>
References: <20191219121905.26905-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make arm use the generic SMP-stop logic provided by common code
unified smp_send_stop() function.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- conflicts
- added missing barriers
---
 arch/arm/Kconfig      |  1 +
 arch/arm/kernel/smp.c | 22 ++++++----------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba75e3661a41..40f6961c449c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -35,6 +35,7 @@ config ARM
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_USE_COMMON_SMP_STOP
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CLONE_BACKWARDS
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 46e1be9e57a8..f03e9bbf4116 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -598,6 +598,8 @@ static void ipi_cpu_stop(unsigned int cpu)
 	}
 
 	set_cpu_online(cpu, false);
+	/* ensure all writes are globally visible before cpu parks */
+	wmb();
 
 	local_fiq_disable();
 	local_irq_disable();
@@ -705,23 +707,9 @@ void smp_send_reschedule(int cpu)
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
-void smp_send_stop(void)
+void arch_smp_stop_call(cpumask_t *cpus, unsigned int __unused)
 {
-	unsigned long timeout;
-	struct cpumask mask;
-
-	cpumask_copy(&mask, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), &mask);
-	if (!cpumask_empty(&mask))
-		smp_cross_call(&mask, IPI_CPU_STOP);
-
-	/* Wait up to one second for other CPUs to stop */
-	timeout = USEC_PER_SEC;
-	while (num_online_cpus() > 1 && timeout--)
-		udelay(1);
-
-	if (num_online_cpus() > 1)
-		pr_warn("SMP: failed to stop secondary CPUs\n");
+	smp_cross_call(cpus, IPI_CPU_STOP);
 }
 
 /* In case panic() and panic() called at the same time on CPU1 and CPU2,
@@ -735,6 +723,8 @@ void panic_smp_self_stop(void)
 	pr_debug("CPU %u will stop doing anything useful since another CPU has paniced\n",
 	         smp_processor_id());
 	set_cpu_online(smp_processor_id(), false);
+	/* ensure all writes visible before parking */
+	wmb();
 	while (1)
 		cpu_relax();
 }
-- 
2.17.1

