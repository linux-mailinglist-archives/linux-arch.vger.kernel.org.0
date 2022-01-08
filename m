Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF44A488499
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiAHQoe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiAHQob (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:44:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83394C061401
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 08:44:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AAD760DE4
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 16:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB21C36AE0;
        Sat,  8 Jan 2022 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660270;
        bh=pgtinwacUtnBeJrky/D8oYhqQ9FWRPsgYNyqIlGtAfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6CfzbD6d8c3+LBQbBZ9SOvugdwriXJbrBmrj+CT88nV8D2tiCbMznJTXpviUKJ3o
         eKvuobEEx8o/V4L+TppMNaNt1pQW6X+LgeZZIsvgUaKb7xVQdOK5/niGFP4AXBtCga
         cfc6TkgRb3efnluBFPjcEXZzjSvLEJKBCTAFYwNRpmkf3VR2+ew9sdZhaqszswH1ZC
         wQB3zJbsLNS/NCVmnllHpBLH4xpKNsVB2P16kvJMzXDUUeJUt68ZgpGN+nZ1Cbhyrj
         Yl8w1ol3618Gwx+MTJVTZxodFBavlpjI7uNZpw61vp1LzzFv/oa6ZWHq4HqzOQ3rCk
         8OMKx8WOaVHaQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86@kernel.org,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 12/23] Rework "sched/core: Fix illegal RCU from offline CPUs"
Date:   Sat,  8 Jan 2022 08:43:57 -0800
Message-Id: <bbe374507b9938f303f8a1e40116b7629f3e06b5.1641659630.git.luto@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This reworks commit bf2c59fce4074e55d622089b34be3a6bc95484fb.  The problem
solved by that commit was that mmdrop() after cpuhp_report_idle_dead() is
an illegal use of RCU, so, with that commit applied, mmdrop() of the last
lazy mm on an offlined CPU was done by the BSP.

With the upcoming reworking of lazy mm references, retaining that design
would involve the cpu hotplug code poking into internal scheduler details.

Rework the fix.  Add a helper unlazy_mm_irqs_off() to fully switch a CPU to
init_mm, releasing any previous lazy active_mm, and do this before
cpuhp_report_idle_dead().

Note that the actual refcounting of init_mm is inconsistent both before and
after this patch.  Most (all?) arches mmgrab(&init_mm) when booting an AP
and set current->active_mm = &init_mm on that AP.  This is consistent with
the current ->active_mm refcounting rules, but archtectures don't do a
corresponding mmdrop() when a CPU goes offine.  The result is that each
offline/online cycle leaks one init_mm reference.  This seems fairly
harmless.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/arm/kernel/smp.c                        |  2 -
 arch/arm64/kernel/smp.c                      |  2 -
 arch/csky/kernel/smp.c                       |  2 -
 arch/ia64/kernel/process.c                   |  1 -
 arch/mips/cavium-octeon/smp.c                |  1 -
 arch/mips/kernel/smp-bmips.c                 |  2 -
 arch/mips/kernel/smp-cps.c                   |  1 -
 arch/mips/loongson64/smp.c                   |  2 -
 arch/powerpc/platforms/85xx/smp.c            |  2 -
 arch/powerpc/platforms/powermac/smp.c        |  2 -
 arch/powerpc/platforms/powernv/smp.c         |  1 -
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  2 -
 arch/powerpc/platforms/pseries/pmem.c        |  1 -
 arch/riscv/kernel/cpu-hotplug.c              |  2 -
 arch/s390/kernel/smp.c                       |  1 -
 arch/sh/kernel/smp.c                         |  1 -
 arch/sparc/kernel/smp_64.c                   |  2 -
 arch/x86/kernel/smpboot.c                    |  2 -
 arch/xtensa/kernel/smp.c                     |  1 -
 include/linux/sched/hotplug.h                |  6 ---
 kernel/cpu.c                                 | 18 +-------
 kernel/sched/core.c                          | 43 +++++++++++---------
 kernel/sched/idle.c                          |  1 +
 kernel/sched/sched.h                         |  1 +
 24 files changed, 27 insertions(+), 72 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 842427ff2b3c..19863ad2f852 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -323,8 +323,6 @@ void arch_cpu_idle_dead(void)
 {
 	unsigned int cpu = smp_processor_id();
 
-	idle_task_exit();
-
 	local_irq_disable();
 
 	/*
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6f6ff072acbd..4b38fb42543f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -366,8 +366,6 @@ void cpu_die(void)
 	unsigned int cpu = smp_processor_id();
 	const struct cpu_operations *ops = get_cpu_ops(cpu);
 
-	idle_task_exit();
-
 	local_daif_mask();
 
 	/* Tell __cpu_die() that this CPU is now safe to dispose of */
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index e2993539af8e..4b17c3b8fcba 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -309,8 +309,6 @@ void __cpu_die(unsigned int cpu)
 
 void arch_cpu_idle_dead(void)
 {
-	idle_task_exit();
-
 	cpu_report_death();
 
 	while (!secondary_stack)
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index e56d63f4abf9..ddb13db7ff7e 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -209,7 +209,6 @@ static inline void play_dead(void)
 
 	max_xtp();
 	local_irq_disable();
-	idle_task_exit();
 	ia64_jump_to_sal(&sal_boot_rendez_state[this_cpu]);
 	/*
 	 * The above is a point of no-return, the processor is
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 89954f5f87fb..7130ec7e9b61 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -343,7 +343,6 @@ void play_dead(void)
 {
 	int cpu = cpu_number_map(cvmx_get_core_num());
 
-	idle_task_exit();
 	octeon_processor_boot = 0xff;
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
 
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index b6ef5f7312cf..bd1e650dd176 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -388,8 +388,6 @@ static void bmips_cpu_die(unsigned int cpu)
 
 void __ref play_dead(void)
 {
-	idle_task_exit();
-
 	/* flush data cache */
 	_dma_cache_wback_inv(0, ~0);
 
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index bcd6a944b839..23221fcee423 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -472,7 +472,6 @@ void play_dead(void)
 	unsigned int cpu;
 
 	local_irq_disable();
-	idle_task_exit();
 	cpu = smp_processor_id();
 	cpu_death = CPU_DEATH_POWER;
 
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 09ebe84a17fe..a1fe59f354d1 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -788,8 +788,6 @@ void play_dead(void)
 	unsigned int cpu = smp_processor_id();
 	void (*play_dead_at_ckseg1)(int *);
 
-	idle_task_exit();
-
 	prid_imp = read_c0_prid() & PRID_IMP_MASK;
 	prid_rev = read_c0_prid() & PRID_REV_MASK;
 
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index c6df294054fe..9de9e1fcc87a 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -121,8 +121,6 @@ static void smp_85xx_cpu_offline_self(void)
 	/* mask all irqs to prevent cpu wakeup */
 	qoriq_pm_ops->irq_mask(cpu);
 
-	idle_task_exit();
-
 	mtspr(SPRN_TCR, 0);
 	mtspr(SPRN_TSR, mfspr(SPRN_TSR));
 
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 3256a316e884..69d2bdd8246d 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -924,7 +924,6 @@ static void pmac_cpu_offline_self(void)
 	int cpu = smp_processor_id();
 
 	local_irq_disable();
-	idle_task_exit();
 	pr_debug("CPU%d offline\n", cpu);
 	generic_set_cpu_dead(cpu);
 	smp_wmb();
@@ -939,7 +938,6 @@ static void pmac_cpu_offline_self(void)
 	int cpu = smp_processor_id();
 
 	local_irq_disable();
-	idle_task_exit();
 
 	/*
 	 * turn off as much as possible, we'll be
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index cbb67813cd5d..cba21d053dae 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -169,7 +169,6 @@ static void pnv_cpu_offline_self(void)
 
 	/* Standard hot unplug procedure */
 
-	idle_task_exit();
 	cpu = smp_processor_id();
 	DBG("CPU%d offline\n", cpu);
 	generic_set_cpu_dead(cpu);
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index d646c22e94ab..c11ccd038866 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/sched.h>	/* for idle_task_exit */
 #include <linux/sched/hotplug.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
@@ -63,7 +62,6 @@ static void pseries_cpu_offline_self(void)
 	unsigned int hwcpu = hard_smp_processor_id();
 
 	local_irq_disable();
-	idle_task_exit();
 	if (xive_enabled())
 		xive_teardown_cpu();
 	else
diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
index 439ac72c2470..5280fcd5b37d 100644
--- a/arch/powerpc/platforms/pseries/pmem.c
+++ b/arch/powerpc/platforms/pseries/pmem.c
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/sched.h>	/* for idle_task_exit */
 #include <linux/sched/hotplug.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index df84e0c13db1..6cced2d79f07 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -77,8 +77,6 @@ void __cpu_die(unsigned int cpu)
  */
 void cpu_stop(void)
 {
-	idle_task_exit();
-
 	(void)cpu_report_death();
 
 	cpu_ops[smp_processor_id()]->cpu_stop();
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 1a04e5bdf655..328930549803 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -987,7 +987,6 @@ void __cpu_die(unsigned int cpu)
 
 void __noreturn cpu_die(void)
 {
-	idle_task_exit();
 	__bpon();
 	pcpu_sigp_retry(pcpu_devices + smp_processor_id(), SIGP_STOP, 0);
 	for (;;) ;
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 65924d9ec245..cbd14604a736 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -106,7 +106,6 @@ int native_cpu_disable(unsigned int cpu)
 
 void play_dead_common(void)
 {
-	idle_task_exit();
 	irq_ctx_exit(raw_smp_processor_id());
 	mb();
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 0224d8f19ed6..450dc9513ff0 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1301,8 +1301,6 @@ void cpu_play_dead(void)
 	int cpu = smp_processor_id();
 	unsigned long pstate;
 
-	idle_task_exit();
-
 	if (tlb_type == hypervisor) {
 		struct trap_per_cpu *tb = &trap_block[cpu];
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 85f6e242b6b4..a57a709f2c35 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1656,8 +1656,6 @@ void native_cpu_die(unsigned int cpu)
 
 void play_dead_common(void)
 {
-	idle_task_exit();
-
 	/* Ack it */
 	(void)cpu_report_death();
 
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 1254da07ead1..fb011807d041 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -329,7 +329,6 @@ void arch_cpu_idle_dead(void)
  */
 void __ref cpu_die(void)
 {
-	idle_task_exit();
 	local_irq_disable();
 	__asm__ __volatile__(
 			"	movi	a2, cpu_restart\n"
diff --git a/include/linux/sched/hotplug.h b/include/linux/sched/hotplug.h
index 412cdaba33eb..18fa3e63123e 100644
--- a/include/linux/sched/hotplug.h
+++ b/include/linux/sched/hotplug.h
@@ -18,10 +18,4 @@ extern int sched_cpu_dying(unsigned int cpu);
 # define sched_cpu_dying	NULL
 #endif
 
-#ifdef CONFIG_HOTPLUG_CPU
-extern void idle_task_exit(void);
-#else
-static inline void idle_task_exit(void) {}
-#endif
-
 #endif /* _LINUX_SCHED_HOTPLUG_H */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index be16816bb87c..709e2a7583ad 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3,7 +3,6 @@
  *
  * This code is licenced under the GPL.
  */
-#include <linux/sched/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/smp.h>
 #include <linux/init.h>
@@ -605,21 +604,6 @@ static int bringup_cpu(unsigned int cpu)
 	return bringup_wait_for_ap(cpu);
 }
 
-static int finish_cpu(unsigned int cpu)
-{
-	struct task_struct *idle = idle_thread_get(cpu);
-	struct mm_struct *mm = idle->active_mm;
-
-	/*
-	 * idle_task_exit() will have switched to &init_mm, now
-	 * clean up any remaining active_mm state.
-	 */
-	if (mm != &init_mm)
-		idle->active_mm = &init_mm;
-	mmdrop(mm);
-	return 0;
-}
-
 /*
  * Hotplug state machine related functions
  */
@@ -1699,7 +1683,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_BRINGUP_CPU] = {
 		.name			= "cpu:bringup",
 		.startup.single		= bringup_cpu,
-		.teardown.single	= finish_cpu,
+		.teardown.single	= NULL,
 		.cant_stop		= true,
 	},
 	/* Final state before CPU kills itself */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index acd52a7d1349..32275b4ff141 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8678,6 +8678,30 @@ void __init init_idle(struct task_struct *idle, int cpu)
 #endif
 }
 
+/*
+ * Drops current->active_mm and switches current->active_mm to &init_mm.
+ * Caller must have IRQs off and must have current->mm == NULL (i.e. must
+ * be in a kernel thread).
+ */
+void unlazy_mm_irqs_off(void)
+{
+	struct mm_struct *mm = current->active_mm;
+
+	lockdep_assert_irqs_disabled();
+
+	if (WARN_ON_ONCE(current->mm))
+		return;
+
+	if (mm == &init_mm)
+		return;
+
+	switch_mm_irqs_off(mm, &init_mm, current);
+	mmgrab(&init_mm);
+	current->active_mm = &init_mm;
+	finish_arch_post_lock_switch();
+	mmdrop(mm);
+}
+
 #ifdef CONFIG_SMP
 
 int cpuset_cpumask_can_shrink(const struct cpumask *cur,
@@ -8771,25 +8795,6 @@ void sched_setnuma(struct task_struct *p, int nid)
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_HOTPLUG_CPU
-/*
- * Ensure that the idle task is using init_mm right before its CPU goes
- * offline.
- */
-void idle_task_exit(void)
-{
-	struct mm_struct *mm = current->active_mm;
-
-	BUG_ON(cpu_online(smp_processor_id()));
-	BUG_ON(current != this_rq()->idle);
-
-	if (mm != &init_mm) {
-		switch_mm(mm, &init_mm, current);
-		finish_arch_post_lock_switch();
-	}
-
-	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
-}
-
 static int __balance_push_cpu_stop(void *arg)
 {
 	struct task_struct *p = arg;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d17b0a5ce6ac..af6a98e7a8d1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -285,6 +285,7 @@ static void do_idle(void)
 		local_irq_disable();
 
 		if (cpu_is_offline(cpu)) {
+			unlazy_mm_irqs_off();
 			tick_nohz_idle_stop_tick();
 			cpuhp_report_idle_dead();
 			arch_cpu_idle_dead();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3d3e5793e117..b496a9ee9aec 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3064,3 +3064,4 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
+extern void unlazy_mm_irqs_off(void);
-- 
2.33.1

