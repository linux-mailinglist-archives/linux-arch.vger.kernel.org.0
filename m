Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE7B3BB207
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jul 2021 01:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhGDXNl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Jul 2021 19:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232128AbhGDXML (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 4 Jul 2021 19:12:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1600561964;
        Sun,  4 Jul 2021 23:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625440111;
        bh=7bgMXZ5UggQ6ydlk/LiSDcYSKrvoA5TOzW7eN4u++JA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vMOWieHC6V+w/iRCwaX6gYbuUTLTKEOYG8wD0TSK/SZdHK5hXcm8av20277KXzPwg
         K3w1etKvSp+nwZqMiKm1Y6fJfqeGVm8aDlzlkKs6j5n6xzKkgfiwFx62ddXpUL9bLP
         xQsr4der7lo9GUeZOUnT4oW8qrUhIc4T6wtEK3raBf/UyshU1Q5I9Fqu9sYj37wzkB
         0Wf9c+o7FAypCeN7VlAkoCc9qpm2bn4NuxyVwRbJWjRya5HCEj6yqyiwCan2+5kI73
         E2uBBrv9RZo1toPO6S5mfMI07XWFFNIiExrgJMnwhByvNqOuQL8Dzbfs3+Gts6hcop
         bMSGjRs5Y+L1g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 19/70] sched/core: Initialize the idle task with preemption disabled
Date:   Sun,  4 Jul 2021 19:07:12 -0400
Message-Id: <20210704230804.1490078-19-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210704230804.1490078-1-sashal@kernel.org>
References: <20210704230804.1490078-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

[ Upstream commit f1a0a376ca0c4ef1fc3d24e3e502acbb5b795674 ]

As pointed out by commit

  de9b8f5dcbd9 ("sched: Fix crash trying to dequeue/enqueue the idle thread")

init_idle() can and will be invoked more than once on the same idle
task. At boot time, it is invoked for the boot CPU thread by
sched_init(). Then smp_init() creates the threads for all the secondary
CPUs and invokes init_idle() on them.

As the hotplug machinery brings the secondaries to life, it will issue
calls to idle_thread_get(), which itself invokes init_idle() yet again.
In this case it's invoked twice more per secondary: at _cpu_up(), and at
bringup_cpu().

Given smp_init() already initializes the idle tasks for all *possible*
CPUs, no further initialization should be required. Now, removing
init_idle() from idle_thread_get() exposes some interesting expectations
with regards to the idle task's preempt_count: the secondary startup always
issues a preempt_disable(), requiring some reset of the preempt count to 0
between hot-unplug and hotplug, which is currently served by
idle_thread_get() -> idle_init().

Given the idle task is supposed to have preemption disabled once and never
see it re-enabled, it seems that what we actually want is to initialize its
preempt_count to PREEMPT_DISABLED and leave it there. Do that, and remove
init_idle() from idle_thread_get().

Secondary startups were patched via coccinelle:

  @begone@
  @@

  -preempt_disable();
  ...
  cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210512094636.2958515-1-valentin.schneider@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/kernel/smp.c          | 1 -
 arch/arc/kernel/smp.c            | 1 -
 arch/arm/kernel/smp.c            | 1 -
 arch/arm64/include/asm/preempt.h | 2 +-
 arch/arm64/kernel/smp.c          | 1 -
 arch/csky/kernel/smp.c           | 1 -
 arch/ia64/kernel/smpboot.c       | 1 -
 arch/mips/kernel/smp.c           | 1 -
 arch/openrisc/kernel/smp.c       | 2 --
 arch/parisc/kernel/smp.c         | 1 -
 arch/powerpc/kernel/smp.c        | 1 -
 arch/riscv/kernel/smpboot.c      | 1 -
 arch/s390/include/asm/preempt.h  | 4 ++--
 arch/s390/kernel/smp.c           | 1 -
 arch/sh/kernel/smp.c             | 2 --
 arch/sparc/kernel/smp_32.c       | 1 -
 arch/sparc/kernel/smp_64.c       | 3 ---
 arch/x86/include/asm/preempt.h   | 2 +-
 arch/x86/kernel/smpboot.c        | 1 -
 arch/xtensa/kernel/smp.c         | 1 -
 include/asm-generic/preempt.h    | 2 +-
 init/main.c                      | 6 +-----
 kernel/fork.c                    | 2 +-
 kernel/sched/core.c              | 2 +-
 kernel/smpboot.c                 | 1 -
 25 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index f4dd9f3f3001..4b2575f936d4 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -166,7 +166,6 @@ smp_callin(void)
 	DBGS(("smp_callin: commencing CPU %d current %p active_mm %p\n",
 	      cpuid, current, current->active_mm));
 
-	preempt_disable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index 52906d314537..db0e104d6835 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -189,7 +189,6 @@ void start_kernel_secondary(void)
 	pr_info("## CPU%u LIVE ##: Executing Code...\n", cpu);
 
 	local_irq_enable();
-	preempt_disable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 48099c6e1e4a..8aa7fa949c23 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -432,7 +432,6 @@ asmlinkage void secondary_start_kernel(void)
 #endif
 	pr_debug("CPU%u: Booted secondary processor\n", cpu);
 
-	preempt_disable();
 	trace_hardirqs_off();
 
 	/*
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 80e946b2abee..e83f0982b99c 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -23,7 +23,7 @@ static inline void preempt_count_set(u64 pc)
 } while (0)
 
 #define init_idle_preempt_count(p, cpu) do { \
-	task_thread_info(p)->preempt_count = PREEMPT_ENABLED; \
+	task_thread_info(p)->preempt_count = PREEMPT_DISABLED; \
 } while (0)
 
 static inline void set_preempt_need_resched(void)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 18e9727d3f64..feee5a3cd128 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -223,7 +223,6 @@ asmlinkage notrace void secondary_start_kernel(void)
 		init_gic_priority_masking();
 
 	rcu_cpu_starting(cpu);
-	preempt_disable();
 	trace_hardirqs_off();
 
 	/*
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 041d0de6a1b6..1a8d7eaf1ff7 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -282,7 +282,6 @@ void csky_start_secondary(void)
 	pr_info("CPU%u Online: %s...\n", cpu, __func__);
 
 	local_irq_enable();
-	preempt_disable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
diff --git a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
index 093040f7e626..0cad990385c0 100644
--- a/arch/ia64/kernel/smpboot.c
+++ b/arch/ia64/kernel/smpboot.c
@@ -440,7 +440,6 @@ start_secondary (void *unused)
 #endif
 	efi_map_pal_code();
 	cpu_init();
-	preempt_disable();
 	smp_callin();
 
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 48d84d5fcc36..ff25926c5458 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -348,7 +348,6 @@ asmlinkage void start_secondary(void)
 	 */
 
 	calibrate_delay();
-	preempt_disable();
 	cpu = smp_processor_id();
 	cpu_data[cpu].udelay_val = loops_per_jiffy;
 
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 29c82ef2e207..e4dad76066ae 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -134,8 +134,6 @@ asmlinkage __init void secondary_start_kernel(void)
 	set_cpu_online(cpu, true);
 
 	local_irq_enable();
-
-	preempt_disable();
 	/*
 	 * OK, it's off to the idle thread for us
 	 */
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 10227f667c8a..1405b603b91b 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -302,7 +302,6 @@ void __init smp_callin(unsigned long pdce_proc)
 #endif
 
 	smp_cpu_init(slave_id);
-	preempt_disable();
 
 	flush_cache_all_local(); /* start with known state */
 	flush_tlb_all_local(NULL);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index db7ac77bea3a..0760230be56f 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1426,7 +1426,6 @@ void start_secondary(void *unused)
 	smp_store_cpu_info(cpu);
 	set_dec(tb_ticks_per_jiffy);
 	rcu_cpu_starting(cpu);
-	preempt_disable();
 	cpu_callin_map[cpu] = 1;
 
 	if (smp_ops->setup_cpu)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 96167d55ed98..0b04e0eae3ab 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -166,7 +166,6 @@ asmlinkage __visible void smp_callin(void)
 	 * Disable preemption before enabling interrupts, so we don't try to
 	 * schedule a CPU that hasn't actually started yet.
 	 */
-	preempt_disable();
 	local_irq_enable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index 6ede29907fbf..e38480eb58fa 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -32,7 +32,7 @@ static inline void preempt_count_set(int pc)
 #define init_task_preempt_count(p)	do { } while (0)
 
 #define init_idle_preempt_count(p, cpu)	do { \
-	S390_lowcore.preempt_count = PREEMPT_ENABLED; \
+	S390_lowcore.preempt_count = PREEMPT_DISABLED; \
 } while (0)
 
 static inline void set_preempt_need_resched(void)
@@ -91,7 +91,7 @@ static inline void preempt_count_set(int pc)
 #define init_task_preempt_count(p)	do { } while (0)
 
 #define init_idle_preempt_count(p, cpu)	do { \
-	S390_lowcore.preempt_count = PREEMPT_ENABLED; \
+	S390_lowcore.preempt_count = PREEMPT_DISABLED; \
 } while (0)
 
 static inline void set_preempt_need_resched(void)
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 791bc373418b..7db5460553b7 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -863,7 +863,6 @@ static void smp_init_secondary(void)
 	set_cpu_flag(CIF_ASCE_SECONDARY);
 	cpu_init();
 	rcu_cpu_starting(cpu);
-	preempt_disable();
 	init_cpu_timer();
 	vtime_init();
 	pfault_init();
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 372acdc9033e..65924d9ec245 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -186,8 +186,6 @@ asmlinkage void start_secondary(void)
 
 	per_cpu_trap_init();
 
-	preempt_disable();
-
 	notify_cpu_starting(cpu);
 
 	local_irq_enable();
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 50c127ab46d5..22b148e5a5f8 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -348,7 +348,6 @@ static void sparc_start_secondary(void *arg)
 	 */
 	arch_cpu_pre_starting(arg);
 
-	preempt_disable();
 	cpu = smp_processor_id();
 
 	notify_cpu_starting(cpu);
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e38d8bf454e8..ae5faa1d989d 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -138,9 +138,6 @@ void smp_callin(void)
 
 	set_cpu_online(cpuid, true);
 
-	/* idle thread is expected to have preempt disabled */
-	preempt_disable();
-
 	local_irq_enable();
 
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 69485ca13665..a334dd0d7c42 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -43,7 +43,7 @@ static __always_inline void preempt_count_set(int pc)
 #define init_task_preempt_count(p) do { } while (0)
 
 #define init_idle_preempt_count(p, cpu) do { \
-	per_cpu(__preempt_count, (cpu)) = PREEMPT_ENABLED; \
+	per_cpu(__preempt_count, (cpu)) = PREEMPT_DISABLED; \
 } while (0)
 
 /*
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 582387fc939f..8baff500914e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -230,7 +230,6 @@ static void notrace start_secondary(void *unused)
 	cpu_init_exception_handling();
 	cpu_init();
 	x86_cpuinit.early_percpu_clock_init();
-	preempt_disable();
 	smp_callin();
 
 	enable_start_cpu0 = 0;
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index cd85a7a2722b..1254da07ead1 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -145,7 +145,6 @@ void secondary_start_kernel(void)
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
 	enter_lazy_tlb(mm, current);
 
-	preempt_disable();
 	trace_hardirqs_off();
 
 	calibrate_delay();
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index d683f5e6d791..b4d43a4af5f7 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -29,7 +29,7 @@ static __always_inline void preempt_count_set(int pc)
 } while (0)
 
 #define init_idle_preempt_count(p, cpu) do { \
-	task_thread_info(p)->preempt_count = PREEMPT_ENABLED; \
+	task_thread_info(p)->preempt_count = PREEMPT_DISABLED; \
 } while (0)
 
 static __always_inline void set_preempt_need_resched(void)
diff --git a/init/main.c b/init/main.c
index b4449544390c..dd26a42e80a8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -914,11 +914,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	 * time - but meanwhile we still have a functioning scheduler.
 	 */
 	sched_init();
-	/*
-	 * Disable preemption - early bootup scheduling is extremely
-	 * fragile until we cpu_idle() for the first time.
-	 */
-	preempt_disable();
+
 	if (WARN(!irqs_disabled(),
 		 "Interrupts were enabled *very* early, fixing it\n"))
 		local_irq_disable();
diff --git a/kernel/fork.c b/kernel/fork.c
index 281addb694df..096945ef49ad 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2392,7 +2392,7 @@ static inline void init_idle_pids(struct task_struct *idle)
 	}
 }
 
-struct task_struct *fork_idle(int cpu)
+struct task_struct * __init fork_idle(int cpu)
 {
 	struct task_struct *task;
 	struct kernel_clone_args args = {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 57b236251884..bd3fa14fda1f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6512,7 +6512,7 @@ void show_state_filter(unsigned long state_filter)
  * NOTE: this function does not set the idle thread's NEED_RESCHED
  * flag, to make booting more robust.
  */
-void init_idle(struct task_struct *idle, int cpu)
+void __init init_idle(struct task_struct *idle, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index f25208e8df83..e4163042c4d6 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -33,7 +33,6 @@ struct task_struct *idle_thread_get(unsigned int cpu)
 
 	if (!tsk)
 		return ERR_PTR(-ENOMEM);
-	init_idle(tsk, cpu);
 	return tsk;
 }
 
-- 
2.30.2

