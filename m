Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665BC365A3
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2019 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfFEUk3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jun 2019 16:40:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55670 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEUk3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jun 2019 16:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bdl+GToplZYKFl2/CZwK1ShFFbX2KkgoYa/IQrkAuz4=; b=rjQbWXan+6Rg3IlYBqU+ZkIeqs
        1t9EtuwW9iZ++dFEqThm5G+AubmH6Sp2/HBdaWcip/N6nFIu4mRZGVfCJzVOmCRPb0un9kMjCWEvW
        x8Wd21a9+eUqrO5wN0Nodpu9SAZVA3ViJvHJudrbvifdZyA9aWfKe80I40SxCKiHV+s7Awm/MdwIj
        XbaxEr6DejPaDSoZ5hIamojbNR0fm/0pHtUXyGZgrlI2AiDBuqHRx6n8WWdtAXB4lvpa44tWVTHUF
        L64dGlYH7wjSNLbcMwsL85JtoeTMIGtFFIBKYkKE07assZ8unvum/mVH22z9wpJB8rBmP0XCS2Fux
        HccFHKTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYchZ-0001Du-8j; Wed, 05 Jun 2019 20:40:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DEB6720763536; Wed,  5 Jun 2019 22:40:03 +0200 (CEST)
Date:   Wed, 5 Jun 2019 22:40:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     Waiman Long <longman@redhat.com>, linux@armlinux.org.uk,
        mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com, Rahul Yadav <rahul.x.yadav@oracle.com>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190605204003.GC3402@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
 <C0BC44A5-875C-4BED-A616-D380F6CF25D5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C0BC44A5-875C-4BED-A616-D380F6CF25D5@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 04, 2019 at 07:21:13PM -0400, Alex Kogan wrote:

> Trying to resume this work, I am looking for concrete steps required
> to integrate CNA with the paravirt patching.
> 
> Looking at alternative_instructions(), I wonder if I need to add
> another call, something like apply_numa() similar to apply_paravirt(),
> and do the patch work there.  Or perhaps I should “just" initialize
> the pv_ops structure with the corresponding
> numa_queued_spinlock_slowpath() in paravirt.c?

Yeah, just initialize the pv_ops.lock.* thingies to contain the numa
variant before apply_paravirt() happens.

> Also, the paravirt code is under arch/x86, while CNA is generic (not
> x86-specific).  Do you still want to see CNA-related patching residing
> under arch/x86?
> 
> We still need a config option (something like NUMA_AWARE_SPINLOCKS) to
> enable CNA patching under this config only, correct?

There is the static_call() stuff that could be generic; I posted a new
version of that today (x86 only for now, but IIRC there's arm64 patches
for that around somewhere too).

https://lkml.kernel.org/r/20190605130753.327195108@infradead.org

Which would allow something a little like this:


diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index bd5ac6cc37db..01feaf912bd7 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -63,29 +63,7 @@ static inline bool vcpu_is_preempted(long cpu)
 #endif
 
 #ifdef CONFIG_PARAVIRT
-DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
-
 void native_pv_lock_init(void) __init;
-
-#define virt_spin_lock virt_spin_lock
-static inline bool virt_spin_lock(struct qspinlock *lock)
-{
-	if (!static_branch_likely(&virt_spin_lock_key))
-		return false;
-
-	/*
-	 * On hypervisors without PARAVIRT_SPINLOCKS support we fall
-	 * back to a Test-and-Set spinlock, because fair locks have
-	 * horrible lock 'holder' preemption issues.
-	 */
-
-	do {
-		while (atomic_read(&lock->val) != 0)
-			cpu_relax();
-	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
-
-	return true;
-}
 #else
 static inline void native_pv_lock_init(void)
 {
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5169b8cc35bb..78be9e474e94 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -531,7 +531,7 @@ static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
 {
 	native_smp_prepare_cpus(max_cpus);
 	if (kvm_para_has_hint(KVM_HINTS_REALTIME))
-		static_branch_disable(&virt_spin_lock_key);
+		static_call_update(queued_spin_lock_slowpath, __queued_spin_lock_slowpath);
 }
 
 static void __init kvm_smp_prepare_boot_cpu(void)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 98039d7fb998..ae6d15f84867 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -105,12 +105,10 @@ static unsigned paravirt_patch_jmp(void *insn_buff, const void *target,
 }
 #endif
 
-DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
-
 void __init native_pv_lock_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		static_branch_disable(&virt_spin_lock_key);
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		static_call_update(queued_spin_lock_slowpath, __tas_spin_lock_slowpath);
 }
 
 unsigned paravirt_patch_default(u8 type, void *insn_buff,
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 3776122c87cc..86808127b6e6 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -70,7 +70,7 @@ void xen_init_lock_cpu(int cpu)
 
 	if (!xen_pvspin) {
 		if (cpu == 0)
-			static_branch_disable(&virt_spin_lock_key);
+			static_call_update(queued_spin_lock_slowpath, __queued_spin_lock_slowpath);
 		return;
 	}
 
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index fde943d180e0..8ca4dd9db931 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -65,7 +65,9 @@ static __always_inline int queued_spin_trylock(struct qspinlock *lock)
 	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
 }
 
-extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+DECLARE_STATIC_CALL(queued_spin_lock_slowpath, __queued_spin_lock_slowpath);
 
 /**
  * queued_spin_lock - acquire a queued spinlock
@@ -78,7 +80,7 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
 		return;
 
-	queued_spin_lock_slowpath(lock, val);
+	static_call(queued_spin_lock_slowpath, lock, val);
 }
 
 #ifndef queued_spin_unlock
@@ -95,13 +97,6 @@ static __always_inline void queued_spin_unlock(struct qspinlock *lock)
 }
 #endif
 
-#ifndef virt_spin_lock
-static __always_inline bool virt_spin_lock(struct qspinlock *lock)
-{
-	return false;
-}
-#endif
-
 /*
  * Remapping spinlock architecture specific functions to the corresponding
  * queued spinlock functions.
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 2473f10c6956..0e9e61637d56 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -290,6 +290,20 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
+void __tas_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	/*
+	 * On hypervisors without PARAVIRT_SPINLOCKS support we fall
+	 * back to a Test-and-Set spinlock, because fair locks have
+	 * horrible lock 'holder' preemption issues.
+	 */
+
+	do {
+		while (atomic_read(&lock->val) != 0)
+			cpu_relax();
+	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
+}
+
 /**
  * queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -311,7 +325,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+void __queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	u32 old, tail;
@@ -322,9 +336,6 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (pv_enabled())
 		goto pv_queue;
 
-	if (virt_spin_lock(lock))
-		return;
-
 	/*
 	 * Wait for in-progress pending->locked hand-overs with a bounded
 	 * number of spins so that we guarantee forward progress.
@@ -558,7 +569,9 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 */
 	__this_cpu_dec(qnodes[0].mcs.count);
 }
-EXPORT_SYMBOL(queued_spin_lock_slowpath);
+EXPORT_SYMBOL(__queued_spin_lock_slowpath);
+
+DEFINE_STATIC_CALL(queued_spin_lock_slowpath, __queued_spin_lock_slowpath);
 
 /*
  * Generate the paravirt code for queued_spin_unlock_slowpath().
