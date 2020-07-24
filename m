Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9A022C61C
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 15:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGXNPE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 09:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGXNPB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 09:15:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8D3C0619D3;
        Fri, 24 Jul 2020 06:15:01 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x9so4414025plr.2;
        Fri, 24 Jul 2020 06:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n61fbqlOypslFR94k6n+lGqidIfEPE+XConlkGlOLco=;
        b=E5/UTDAUnb3ESa5ShjlxYJ0FAndtToI8UfexqXwqO3SmkBFOUl5PVWdOyIOOYyNpVV
         L9SzENVxwDng6Ej6JhVibvdRFYsPmmomHFmFS2znFRwS3UCux5apIi2RDB2yTzbuaYw/
         KJ8gwLGi14j0CIb30YzavIw/1HmaBrzCHKwBz51XB//K3MioDBbVPSidgDcr0lz35G9w
         tQzNzzcpd623VzmG6vXfIzMC2uFxD3Shs+c7dauvv1dDdc+FI3Py0O0BDchmlL5nL/6P
         fTMDYBOZ51qzGqHK2CZOYpJWQwwPVu+eEYrNA7ri7/HNfMpO1LZcYOcK+FX7kTiTZ9aq
         6/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n61fbqlOypslFR94k6n+lGqidIfEPE+XConlkGlOLco=;
        b=qld5hr+RzV0QflARnjhHN0ZP0m1srhu3DQV+YDYn6246E1LWm3RXkA3w8RlS5j9Bqz
         fmd/erVOri89o0/CN2BtdWCppW71QgZVkVDLr18phXpJpZVkR68/Zpw6AD1Cs405/4mr
         Nq794dVOHEvDM7fUW53jV/OFKHJe2yRQKF1SgiCVG+wTFiF8wAO2j6lpVS6/266/iTvZ
         ZWO2r8ph9EGGPDV2z4JRTJyR7KmyIkN0arNYoSWG294SqxnwSt/9uXKr9F7tHGnHKVNa
         DRgJswFWj6Q4y32upEaLCp71S+JN3sfUwmpP4QHGiVwOAAx+BxCKyoHz0gav3DsdLohj
         hEYA==
X-Gm-Message-State: AOAM532/DO9dpQqJynAeDEZkA0JRmioLh+xrg5yxtujjy9joFcd1q5Vl
        SOUJ5XyFhsirfK223T1qQBI=
X-Google-Smtp-Source: ABdhPJyehzfvgGFCs+XkBbrheOMwkmB9hmhwGlUE6rYdtAGc9DxocvZ7G2mQyADyXgm6wrNTNraoOg==
X-Received: by 2002:a17:902:a3cb:: with SMTP id q11mr8177484plb.239.1595596500823;
        Fri, 24 Jul 2020 06:15:00 -0700 (PDT)
Received: from bobo.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id az16sm5871998pjb.7.2020.07.24.06.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:14:59 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v4 4/6] powerpc/pseries: implement paravirt qspinlocks for SPLPAR
Date:   Fri, 24 Jul 2020 23:14:21 +1000
Message-Id: <20200724131423.1362108-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200724131423.1362108-1-npiggin@gmail.com>
References: <20200724131423.1362108-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This implements the generic paravirt qspinlocks using H_PROD and H_CONFER to
kick and wait.

This uses an un-directed yield to any CPU rather than the directed yield to
a pre-empted lock holder that paravirtualised simple spinlocks use, that
requires no kick hcall. This is something that could be investigated and
improved in future.

Performance results can be found in the commit which added queued spinlocks.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/paravirt.h           | 28 ++++++++
 arch/powerpc/include/asm/qspinlock.h          | 66 +++++++++++++++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h |  7 ++
 arch/powerpc/include/asm/spinlock.h           |  4 ++
 arch/powerpc/platforms/pseries/Kconfig        |  9 ++-
 arch/powerpc/platforms/pseries/setup.c        |  4 +-
 include/asm-generic/qspinlock.h               |  2 +
 7 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h

diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
index 339e8533464b..21e5f29ca251 100644
--- a/arch/powerpc/include/asm/paravirt.h
+++ b/arch/powerpc/include/asm/paravirt.h
@@ -28,6 +28,16 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
 {
 	plpar_hcall_norets(H_CONFER, get_hard_smp_processor_id(cpu), yield_count);
 }
+
+static inline void prod_cpu(int cpu)
+{
+	plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
+}
+
+static inline void yield_to_any(void)
+{
+	plpar_hcall_norets(H_CONFER, -1, 0);
+}
 #else
 static inline bool is_shared_processor(void)
 {
@@ -44,6 +54,19 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
 {
 	___bad_yield_to_preempted(); /* This would be a bug */
 }
+
+extern void ___bad_yield_to_any(void);
+static inline void yield_to_any(void)
+{
+	___bad_yield_to_any(); /* This would be a bug */
+}
+
+extern void ___bad_prod_cpu(void);
+static inline void prod_cpu(int cpu)
+{
+	___bad_prod_cpu(); /* This would be a bug */
+}
+
 #endif
 
 #define vcpu_is_preempted vcpu_is_preempted
@@ -56,4 +79,9 @@ static inline bool vcpu_is_preempted(int cpu)
 	return false;
 }
 
+static inline bool pv_is_native_spin_unlock(void)
+{
+     return !is_shared_processor();
+}
+
 #endif /* _ASM_POWERPC_PARAVIRT_H */
diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index c49e33e24edd..f5066f00a08c 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -3,9 +3,47 @@
 #define _ASM_POWERPC_QSPINLOCK_H
 
 #include <asm-generic/qspinlock_types.h>
+#include <asm/paravirt.h>
 
 #define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __pv_queued_spin_unlock(struct qspinlock *lock);
+
+static __always_inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	if (!is_shared_processor())
+		native_queued_spin_lock_slowpath(lock, val);
+	else
+		__pv_queued_spin_lock_slowpath(lock, val);
+}
+
+#define queued_spin_unlock queued_spin_unlock
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	if (!is_shared_processor())
+		smp_store_release(&lock->locked, 0);
+	else
+		__pv_queued_spin_unlock(lock);
+}
+
+#else
+extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+#endif
+
+static __always_inline void queued_spin_lock(struct qspinlock *lock)
+{
+	u32 val = 0;
+
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
+		return;
+
+	queued_spin_lock_slowpath(lock, val);
+}
+#define queued_spin_lock queued_spin_lock
+
 #define smp_mb__after_spinlock()   smp_mb()
 
 static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
@@ -20,6 +58,34 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 }
 #define queued_spin_is_locked queued_spin_is_locked
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#define SPIN_THRESHOLD (1<<15) /* not tuned */
+
+static __always_inline void pv_wait(u8 *ptr, u8 val)
+{
+	if (*ptr != val)
+		return;
+	yield_to_any();
+	/*
+	 * We could pass in a CPU here if waiting in the queue and yield to
+	 * the previous CPU in the queue.
+	 */
+}
+
+static __always_inline void pv_kick(int cpu)
+{
+	prod_cpu(cpu);
+}
+
+extern void __pv_init_lock_hash(void);
+
+static inline void pv_spinlocks_init(void)
+{
+	__pv_init_lock_hash();
+}
+
+#endif
+
 #include <asm-generic/qspinlock.h>
 
 #endif /* _ASM_POWERPC_QSPINLOCK_H */
diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerpc/include/asm/qspinlock_paravirt.h
new file mode 100644
index 000000000000..6b60e7736a47
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock_paravirt.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ASM_POWERPC_QSPINLOCK_PARAVIRT_H
+#define _ASM_POWERPC_QSPINLOCK_PARAVIRT_H
+
+EXPORT_SYMBOL(__pv_queued_spin_unlock);
+
+#endif /* _ASM_POWERPC_QSPINLOCK_PARAVIRT_H */
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 434615f1d761..6ec72282888d 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -10,5 +10,9 @@
 #include <asm/simple_spinlock.h>
 #endif
 
+#ifndef CONFIG_PARAVIRT_SPINLOCKS
+static inline void pv_spinlocks_init(void) { }
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 24c18362e5ea..5e037df2a3a1 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -25,15 +25,22 @@ config PPC_PSERIES
 	select SWIOTLB
 	default y
 
+config PARAVIRT_SPINLOCKS
+	bool
+
 config PPC_SPLPAR
-	depends on PPC_PSERIES
 	bool "Support for shared-processor logical partitions"
+	depends on PPC_PSERIES
+	select PARAVIRT_SPINLOCKS if PPC_QUEUED_SPINLOCKS
+	default y
 	help
 	  Enabling this option will make the kernel run more efficiently
 	  on logically-partitioned pSeries systems which use shared
 	  processors, that is, which share physical processors between
 	  two or more partitions.
 
+	  Say Y if you are unsure.
+
 config DTL
 	bool "Dispatch Trace Log"
 	depends on PPC_SPLPAR && DEBUG_FS
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 2db8469e475f..fa847d1f9d54 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -771,8 +771,10 @@ static void __init pSeries_setup_arch(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		vpa_init(boot_cpuid);
 
-		if (lppaca_shared_proc(get_lppaca()))
+		if (lppaca_shared_proc(get_lppaca())) {
 			static_branch_enable(&shared_processor);
+			pv_spinlocks_init();
+		}
 
 		ppc_md.power_save = pseries_lpar_idle;
 		ppc_md.enable_pmcs = pseries_lpar_enable_pmcs;
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index fb0a814d4395..38ca14e79a86 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -69,6 +69,7 @@ static __always_inline int queued_spin_trylock(struct qspinlock *lock)
 
 extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 
+#ifndef queued_spin_lock
 /**
  * queued_spin_lock - acquire a queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -82,6 +83,7 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 
 	queued_spin_lock_slowpath(lock, val);
 }
+#endif
 
 #ifndef queued_spin_unlock
 /**
-- 
2.23.0

