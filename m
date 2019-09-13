Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D05B250D
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2019 20:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390710AbfIMSU7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Sep 2019 14:20:59 -0400
Received: from foss.arm.com ([217.140.110.172]:47930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389336AbfIMSU7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Sep 2019 14:20:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90EF61570;
        Fri, 13 Sep 2019 11:20:58 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 237793F71F;
        Fri, 13 Sep 2019 11:20:56 -0700 (PDT)
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
Subject: [RFC PATCH v2 05/12] arm64: smp: use generic SMP stop common code
Date:   Fri, 13 Sep 2019 19:19:46 +0100
Message-Id: <20190913181953.45748-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913181953.45748-1-cristian.marussi@arm.com>
References: <20190913181953.45748-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make arm64 use the generic SMP-stop logic provided by common code
unified smp_send_stop() function.

arm64 smp_send_stop() logic had a bug in it: it failed to consider the
online status of the calling CPU when evaluating if any stop message
needed to be sent to other CPus at all: this resulted, on a 2-CPUs
system, in the failure to stop all cpus if one paniced while starting
up, leaving such system in an unexpected lively state.

[root@arch ~]# echo 1 > /sys/devices/system/cpu/cpu1/online
[root@arch ~]# [  152.583368] ------------[ cut here ]------------
[  152.583872] kernel BUG at arch/arm64/kernel/cpufeature.c:852!
[  152.584693] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[  152.585228] Modules linked in:
[  152.586040] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.3.0-rc5-00001-gcabd12118c4a-dirty #2
[  152.586218] Hardware name: Foundation-v8A (DT)
[  152.586478] pstate: 000001c5 (nzcv dAIF -PAN -UAO)
[  152.587260] pc : has_cpuid_feature+0x35c/0x360
[  152.587398] lr : verify_local_elf_hwcaps+0x6c/0xf0
[  152.587520] sp : ffff0000118bbf60
[  152.587605] x29: ffff0000118bbf60 x28: 0000000000000000
[  152.587784] x27: 0000000000000000 x26: 0000000000000000
[  152.587882] x25: ffff00001167a010 x24: ffff0000112f59f8
[  152.587992] x23: 0000000000000000 x22: 0000000000000000
[  152.588085] x21: ffff0000112ea018 x20: ffff000010fe5518
[  152.588180] x19: ffff000010ba3f30 x18: 0000000000000036
[  152.588285] x17: 0000000000000000 x16: 0000000000000000
[  152.588380] x15: 0000000000000000 x14: ffff80087a821210
[  152.588481] x13: 0000000000000000 x12: 0000000000000000
[  152.588599] x11: 0000000000000080 x10: 00400032b5503510
[  152.588709] x9 : 0000000000000000 x8 : ffff000010b93204
[  152.588810] x7 : 00000000800001d8 x6 : 0000000000000005
[  152.588910] x5 : 0000000000000000 x4 : 0000000000000000
[  152.589021] x3 : 0000000000000000 x2 : 0000000000008000
[  152.589121] x1 : 0000000000180480 x0 : 0000000000180480
[  152.589379] Call trace:
[  152.589646]  has_cpuid_feature+0x35c/0x360
[  152.589763]  verify_local_elf_hwcaps+0x6c/0xf0
[  152.589858]  check_local_cpu_capabilities+0x88/0x118
[  152.589968]  secondary_start_kernel+0xc4/0x168
[  152.590530] Code: d53801e0 17ffff58 d5380600 17ffff56 (d4210000)
[  152.592215] ---[ end trace 80ea98416149c87e ]---
[  152.592734] Kernel panic - not syncing: Attempted to kill the idle task!
[  152.593173] Kernel Offset: disabled
[  152.593501] CPU features: 0x0004,20c02008
[  152.593678] Memory Limit: none
[  152.594208] ---[ end Kernel panic - not syncing: Attempted to kill the idle
task! ]---
[root@arch ~]# bash: echo: write error: Input/output error
[root@arch ~]#
[root@arch ~]#
[root@arch ~]# echo HELO
HELO

Get rid of such bug, switching arm64 to use the common SMP stop code.

Reported-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- now selecting arch/Kconfig ARCH_USE_COMMON_SMP_STOP
- added attempt_num arch_smp_stop_call() helper
---
 arch/arm64/Kconfig      |  1 +
 arch/arm64/kernel/smp.c | 29 ++++++-----------------------
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3adcec05b1f6..33f88381702b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -67,6 +67,7 @@ config ARM64
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_COMMON_SMP_STOP
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 018a33e01b0e..3e87fdbb9f74 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -953,33 +953,16 @@ void tick_broadcast(const struct cpumask *mask)
 }
 #endif
 
-void smp_send_stop(void)
+void arch_smp_cpus_stop_complete(void)
 {
-	unsigned long timeout;
-
-	if (num_online_cpus() > 1) {
-		cpumask_t mask;
-
-		cpumask_copy(&mask, cpu_online_mask);
-		cpumask_clear_cpu(smp_processor_id(), &mask);
-
-		if (system_state <= SYSTEM_RUNNING)
-			pr_crit("SMP: stopping secondary CPUs\n");
-		smp_cross_call(&mask, IPI_CPU_STOP);
-	}
-
-	/* Wait up to one second for other CPUs to stop */
-	timeout = USEC_PER_SEC;
-	while (num_online_cpus() > 1 && timeout--)
-		udelay(1);
-
-	if (num_online_cpus() > 1)
-		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
-			   cpumask_pr_args(cpu_online_mask));
-
 	sdei_mask_local_cpu();
 }
 
+void arch_smp_stop_call(cpumask_t *cpus, unsigned int __unused)
+{
+	smp_cross_call(cpus, IPI_CPU_STOP);
+}
+
 #ifdef CONFIG_KEXEC_CORE
 void crash_smp_send_stop(void)
 {
-- 
2.17.1

