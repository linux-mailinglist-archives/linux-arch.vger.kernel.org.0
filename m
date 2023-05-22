Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9D70BE33
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjEVM2m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 08:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjEVM1R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:27:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 590201708;
        Mon, 22 May 2023 05:25:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 683A5168F;
        Mon, 22 May 2023 05:26:07 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCA263F59C;
        Mon, 22 May 2023 05:25:20 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 18/26] locking/atomic: treewide: use raw_atomic*_<op>()
Date:   Mon, 22 May 2023 13:24:21 +0100
Message-Id: <20230522122429.1915021-19-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522122429.1915021-1-mark.rutland@arm.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that we have raw_atomic*_<op>() definitions, there's no need to use
arch_atomic*_<op>() definitions outside of the low-level atomic
definitions.

Move treewide users of arch_atomic*_<op>() over to the equivalent
raw_atomic*_<op>().

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 arch/powerpc/kernel/smp.c              | 12 ++++++------
 arch/x86/kernel/alternative.c          |  4 ++--
 arch/x86/kernel/cpu/mce/core.c         | 16 ++++++++--------
 arch/x86/kernel/nmi.c                  |  2 +-
 arch/x86/kernel/pvclock.c              |  4 ++--
 arch/x86/kvm/x86.c                     |  2 +-
 include/asm-generic/bitops/atomic.h    | 12 ++++++------
 include/asm-generic/bitops/lock.h      |  8 ++++----
 include/linux/context_tracking.h       |  4 ++--
 include/linux/context_tracking_state.h |  2 +-
 include/linux/cpumask.h                |  2 +-
 include/linux/jump_label.h             |  2 +-
 kernel/context_tracking.c              | 12 ++++++------
 kernel/sched/clock.c                   |  2 +-
 14 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 265801a3e94cf..e8965f18686f0 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -417,9 +417,9 @@ noinstr static void nmi_ipi_lock_start(unsigned long *flags)
 {
 	raw_local_irq_save(*flags);
 	hard_irq_disable();
-	while (arch_atomic_cmpxchg(&__nmi_ipi_lock, 0, 1) == 1) {
+	while (raw_atomic_cmpxchg(&__nmi_ipi_lock, 0, 1) == 1) {
 		raw_local_irq_restore(*flags);
-		spin_until_cond(arch_atomic_read(&__nmi_ipi_lock) == 0);
+		spin_until_cond(raw_atomic_read(&__nmi_ipi_lock) == 0);
 		raw_local_irq_save(*flags);
 		hard_irq_disable();
 	}
@@ -427,15 +427,15 @@ noinstr static void nmi_ipi_lock_start(unsigned long *flags)
 
 noinstr static void nmi_ipi_lock(void)
 {
-	while (arch_atomic_cmpxchg(&__nmi_ipi_lock, 0, 1) == 1)
-		spin_until_cond(arch_atomic_read(&__nmi_ipi_lock) == 0);
+	while (raw_atomic_cmpxchg(&__nmi_ipi_lock, 0, 1) == 1)
+		spin_until_cond(raw_atomic_read(&__nmi_ipi_lock) == 0);
 }
 
 noinstr static void nmi_ipi_unlock(void)
 {
 	smp_mb();
-	WARN_ON(arch_atomic_read(&__nmi_ipi_lock) != 1);
-	arch_atomic_set(&__nmi_ipi_lock, 0);
+	WARN_ON(raw_atomic_read(&__nmi_ipi_lock) != 1);
+	raw_atomic_set(&__nmi_ipi_lock, 0);
 }
 
 noinstr static void nmi_ipi_unlock_end(unsigned long *flags)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f615e0cb6d932..18f16e93838fe 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1799,7 +1799,7 @@ struct bp_patching_desc *try_get_desc(void)
 {
 	struct bp_patching_desc *desc = &bp_desc;
 
-	if (!arch_atomic_inc_not_zero(&desc->refs))
+	if (!raw_atomic_inc_not_zero(&desc->refs))
 		return NULL;
 
 	return desc;
@@ -1810,7 +1810,7 @@ static __always_inline void put_desc(void)
 	struct bp_patching_desc *desc = &bp_desc;
 
 	smp_mb__before_atomic();
-	arch_atomic_dec(&desc->refs);
+	raw_atomic_dec(&desc->refs);
 }
 
 static __always_inline void *text_poke_addr(struct text_poke_loc *tp)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2eec60f50057a..ab156e6e71208 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1022,12 +1022,12 @@ static noinstr int mce_start(int *no_way_out)
 	if (!timeout)
 		return ret;
 
-	arch_atomic_add(*no_way_out, &global_nwo);
+	raw_atomic_add(*no_way_out, &global_nwo);
 	/*
 	 * Rely on the implied barrier below, such that global_nwo
 	 * is updated before mce_callin.
 	 */
-	order = arch_atomic_inc_return(&mce_callin);
+	order = raw_atomic_inc_return(&mce_callin);
 	arch_cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
 
 	/* Enable instrumentation around calls to external facilities */
@@ -1036,10 +1036,10 @@ static noinstr int mce_start(int *no_way_out)
 	/*
 	 * Wait for everyone.
 	 */
-	while (arch_atomic_read(&mce_callin) != num_online_cpus()) {
+	while (raw_atomic_read(&mce_callin) != num_online_cpus()) {
 		if (mce_timed_out(&timeout,
 				  "Timeout: Not all CPUs entered broadcast exception handler")) {
-			arch_atomic_set(&global_nwo, 0);
+			raw_atomic_set(&global_nwo, 0);
 			goto out;
 		}
 		ndelay(SPINUNIT);
@@ -1054,7 +1054,7 @@ static noinstr int mce_start(int *no_way_out)
 		/*
 		 * Monarch: Starts executing now, the others wait.
 		 */
-		arch_atomic_set(&mce_executing, 1);
+		raw_atomic_set(&mce_executing, 1);
 	} else {
 		/*
 		 * Subject: Now start the scanning loop one by one in
@@ -1062,10 +1062,10 @@ static noinstr int mce_start(int *no_way_out)
 		 * This way when there are any shared banks it will be
 		 * only seen by one CPU before cleared, avoiding duplicates.
 		 */
-		while (arch_atomic_read(&mce_executing) < order) {
+		while (raw_atomic_read(&mce_executing) < order) {
 			if (mce_timed_out(&timeout,
 					  "Timeout: Subject CPUs unable to finish machine check processing")) {
-				arch_atomic_set(&global_nwo, 0);
+				raw_atomic_set(&global_nwo, 0);
 				goto out;
 			}
 			ndelay(SPINUNIT);
@@ -1075,7 +1075,7 @@ static noinstr int mce_start(int *no_way_out)
 	/*
 	 * Cache the global no_way_out state.
 	 */
-	*no_way_out = arch_atomic_read(&global_nwo);
+	*no_way_out = raw_atomic_read(&global_nwo);
 
 	ret = order;
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 776f4b1e395b5..a0c551846b35f 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -496,7 +496,7 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	 */
 	sev_es_nmi_complete();
 	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU))
-		arch_atomic_long_inc(&nsp->idt_calls);
+		raw_atomic_long_inc(&nsp->idt_calls);
 
 	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id()))
 		return;
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index 56acf53a782ad..b3f81379c2fc0 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -101,11 +101,11 @@ u64 __pvclock_clocksource_read(struct pvclock_vcpu_time_info *src, bool dowd)
 	 * updating at the same time, and one of them could be slightly behind,
 	 * making the assumption that last_value always go forward fail to hold.
 	 */
-	last = arch_atomic64_read(&last_value);
+	last = raw_atomic64_read(&last_value);
 	do {
 		if (ret <= last)
 			return last;
-	} while (!arch_atomic64_try_cmpxchg(&last_value, &last, ret));
+	} while (!raw_atomic64_try_cmpxchg(&last_value, &last, ret));
 
 	return ret;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ceb7c5e9cf9e9..ac6f609068106 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13155,7 +13155,7 @@ EXPORT_SYMBOL_GPL(kvm_arch_end_assignment);
 
 bool noinstr kvm_arch_has_assigned_device(struct kvm *kvm)
 {
-	return arch_atomic_read(&kvm->arch.assigned_device_count);
+	return raw_atomic_read(&kvm->arch.assigned_device_count);
 }
 EXPORT_SYMBOL_GPL(kvm_arch_has_assigned_device);
 
diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
index 71ab4ba9c25d1..e076e079f6b2e 100644
--- a/include/asm-generic/bitops/atomic.h
+++ b/include/asm-generic/bitops/atomic.h
@@ -15,21 +15,21 @@ static __always_inline void
 arch_set_bit(unsigned int nr, volatile unsigned long *p)
 {
 	p += BIT_WORD(nr);
-	arch_atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
+	raw_atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
 static __always_inline void
 arch_clear_bit(unsigned int nr, volatile unsigned long *p)
 {
 	p += BIT_WORD(nr);
-	arch_atomic_long_andnot(BIT_MASK(nr), (atomic_long_t *)p);
+	raw_atomic_long_andnot(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
 static __always_inline void
 arch_change_bit(unsigned int nr, volatile unsigned long *p)
 {
 	p += BIT_WORD(nr);
-	arch_atomic_long_xor(BIT_MASK(nr), (atomic_long_t *)p);
+	raw_atomic_long_xor(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
 static __always_inline int
@@ -39,7 +39,7 @@ arch_test_and_set_bit(unsigned int nr, volatile unsigned long *p)
 	unsigned long mask = BIT_MASK(nr);
 
 	p += BIT_WORD(nr);
-	old = arch_atomic_long_fetch_or(mask, (atomic_long_t *)p);
+	old = raw_atomic_long_fetch_or(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
 
@@ -50,7 +50,7 @@ arch_test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
 	unsigned long mask = BIT_MASK(nr);
 
 	p += BIT_WORD(nr);
-	old = arch_atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
+	old = raw_atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
 
@@ -61,7 +61,7 @@ arch_test_and_change_bit(unsigned int nr, volatile unsigned long *p)
 	unsigned long mask = BIT_MASK(nr);
 
 	p += BIT_WORD(nr);
-	old = arch_atomic_long_fetch_xor(mask, (atomic_long_t *)p);
+	old = raw_atomic_long_fetch_xor(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
 
diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index 630f2f6b95956..40913516e654c 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -25,7 +25,7 @@ arch_test_and_set_bit_lock(unsigned int nr, volatile unsigned long *p)
 	if (READ_ONCE(*p) & mask)
 		return 1;
 
-	old = arch_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
+	old = raw_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
 
@@ -41,7 +41,7 @@ static __always_inline void
 arch_clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
 {
 	p += BIT_WORD(nr);
-	arch_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
+	raw_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
 }
 
 /**
@@ -63,7 +63,7 @@ arch___clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
 	p += BIT_WORD(nr);
 	old = READ_ONCE(*p);
 	old &= ~BIT_MASK(nr);
-	arch_atomic_long_set_release((atomic_long_t *)p, old);
+	raw_atomic_long_set_release((atomic_long_t *)p, old);
 }
 
 /**
@@ -83,7 +83,7 @@ static inline bool arch_clear_bit_unlock_is_negative_byte(unsigned int nr,
 	unsigned long mask = BIT_MASK(nr);
 
 	p += BIT_WORD(nr);
-	old = arch_atomic_long_fetch_andnot_release(mask, (atomic_long_t *)p);
+	old = raw_atomic_long_fetch_andnot_release(mask, (atomic_long_t *)p);
 	return !!(old & BIT(7));
 }
 #define arch_clear_bit_unlock_is_negative_byte arch_clear_bit_unlock_is_negative_byte
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d3cbb6c16babf..6e76b9dba00e7 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -119,7 +119,7 @@ extern void ct_idle_exit(void);
  */
 static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
-	return !(arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & RCU_DYNTICKS_IDX);
+	return !(raw_atomic_read(this_cpu_ptr(&context_tracking.state)) & RCU_DYNTICKS_IDX);
 }
 
 /*
@@ -128,7 +128,7 @@ static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
  */
 static __always_inline unsigned long ct_state_inc(int incby)
 {
-	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.state));
+	return raw_atomic_add_return(incby, this_cpu_ptr(&context_tracking.state));
 }
 
 static __always_inline bool warn_rcu_enter(void)
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index fdd537ea513ff..bbff5f7f88030 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -51,7 +51,7 @@ DECLARE_PER_CPU(struct context_tracking, context_tracking);
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 static __always_inline int __ct_state(void)
 {
-	return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
+	return raw_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
 }
 #endif
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index ca736b05ec7b0..0d2e2a38b92d0 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1071,7 +1071,7 @@ static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
  */
 static __always_inline unsigned int num_online_cpus(void)
 {
-	return arch_atomic_read(&__num_online_cpus);
+	return raw_atomic_read(&__num_online_cpus);
 }
 #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 4e968ebadce60..f0a949b7c9733 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -257,7 +257,7 @@ extern enum jump_label_type jump_label_init_type(struct jump_entry *entry);
 
 static __always_inline int static_key_count(struct static_key *key)
 {
-	return arch_atomic_read(&key->enabled);
+	return raw_atomic_read(&key->enabled);
 }
 
 static __always_inline void jump_label_init(void)
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a09f1c19336ae..6ef0b35fc28c5 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -510,7 +510,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * In this we case we don't care about any concurrency/ordering.
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
-				arch_atomic_set(&ct->state, state);
+				raw_atomic_set(&ct->state, state);
 		} else {
 			/*
 			 * Even if context tracking is disabled on this CPU, because it's outside
@@ -527,7 +527,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
 				/* Tracking for vtime only, no concurrent RCU EQS accounting */
-				arch_atomic_set(&ct->state, state);
+				raw_atomic_set(&ct->state, state);
 			} else {
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
@@ -535,7 +535,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
 				 * ordered.
 				 */
-				arch_atomic_add(state, &ct->state);
+				raw_atomic_add(state, &ct->state);
 			}
 		}
 	}
@@ -630,12 +630,12 @@ void noinstr __ct_user_exit(enum ctx_state state)
 			 * In this we case we don't care about any concurrency/ordering.
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
-				arch_atomic_set(&ct->state, CONTEXT_KERNEL);
+				raw_atomic_set(&ct->state, CONTEXT_KERNEL);
 
 		} else {
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
 				/* Tracking for vtime only, no concurrent RCU EQS accounting */
-				arch_atomic_set(&ct->state, CONTEXT_KERNEL);
+				raw_atomic_set(&ct->state, CONTEXT_KERNEL);
 			} else {
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
@@ -643,7 +643,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
 				 * ordered.
 				 */
-				arch_atomic_sub(state, &ct->state);
+				raw_atomic_sub(state, &ct->state);
 			}
 		}
 	}
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index b5cc2b53464de..71443cff31f0d 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -287,7 +287,7 @@ static __always_inline u64 sched_clock_local(struct sched_clock_data *scd)
 	clock = wrap_max(clock, min_clock);
 	clock = wrap_min(clock, max_clock);
 
-	if (!arch_try_cmpxchg64(&scd->clock, &old_clock, clock))
+	if (!raw_try_cmpxchg64(&scd->clock, &old_clock, clock))
 		goto again;
 
 	return clock;
-- 
2.30.2

