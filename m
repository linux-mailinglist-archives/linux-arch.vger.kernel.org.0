Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEC0213523
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgGCHfz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 03:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCHfy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jul 2020 03:35:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA1C08C5C1;
        Fri,  3 Jul 2020 00:35:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc15so4754258pjb.0;
        Fri, 03 Jul 2020 00:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yjpRPYAkGJfnlgR11q94BNR4c/kQenbGX77BKWJOAs=;
        b=vb2pex0RuQq8dj/z/9e240VJxjYMvhin/amY2uJzTlAAc4mvDuqIVuyL9HS+Ric01J
         scVOq0qJOONOPe/IRxuJNDhfa5drHQkLRYe+eNlZGcXplA1AZsAATibfhjGtMFu0qaW4
         yQtUZmmCKITGTPFeO6v7baS6SordS4ULXZSv61STN645xmMNzWf9XWe/4zTC0KhDHPvB
         EQsQLpxhgAQBxtYkw3WxhkSujg3gTIHXQeGpDLEDZWAswf2hlt+hzxzLDGDWNXbe1KP1
         F2CnAhVPobOPkEYq3QXad/leLPqMqoY7OXQl4T7KcaYhY8k//cciqoHUgun7nxHhm1Ov
         kfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yjpRPYAkGJfnlgR11q94BNR4c/kQenbGX77BKWJOAs=;
        b=aAt3K/i5HXT57BoOkcD9DpUf/U9F6vWUurEUZw2XU9dN3dA4cWXzfARYtwU+YyHxbr
         qamCzwwZsPxf8e2dYYtYUXfTNukFkbhMvWDNCXcbsKZ636bDem8kqvNd7gqO+e1XLR71
         RYFWkRmaE4C/Eyc9WQr30TpgitWDet6jXd5247ZsFY7A9f7w1b5JWq6BRK+Vc9kS1d9H
         30yLXaH3b8VS+I/f16Cj/xT3Mch71ClrkwBTIoHZNGl2InAFAmZFBIZCVRa690S7d1uG
         OmthwvPo7f9A8pin3qLSnLttTEKTzWGc5kDrXZNFWkS3SZaemz4+cQ8szJEXM/kA8Gzd
         kMkw==
X-Gm-Message-State: AOAM5315sou/uFruGXxJri7RsHEd0oRC8cPl6jLTo7OgeJO7SZFPmzG2
        NDrpwfXMpQF0LQj6dFMz/ao=
X-Google-Smtp-Source: ABdhPJynqEze7gaZ21hI2+hKykLI894gPGyNg2YKJFfauO66Us+bkfhTLKYKBJCi3O6wv7v1MFpJ5Q==
X-Received: by 2002:a17:90a:ea83:: with SMTP id h3mr25730448pjz.176.1593761754166;
        Fri, 03 Jul 2020 00:35:54 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id y7sm10218499pgk.93.2020.07.03.00.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 00:35:53 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 5/6] powerpc/pseries: implement paravirt qspinlocks for SPLPAR
Date:   Fri,  3 Jul 2020 17:35:15 +1000
Message-Id: <20200703073516.1354108-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200703073516.1354108-1-npiggin@gmail.com>
References: <20200703073516.1354108-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/paravirt.h           | 28 ++++++++++
 arch/powerpc/include/asm/qspinlock.h          | 55 +++++++++++++++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h |  5 ++
 arch/powerpc/platforms/pseries/Kconfig        |  5 ++
 arch/powerpc/platforms/pseries/setup.c        |  6 +-
 include/asm-generic/qspinlock.h               |  2 +
 6 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h

diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
index 7a8546660a63..f2d51f929cf5 100644
--- a/arch/powerpc/include/asm/paravirt.h
+++ b/arch/powerpc/include/asm/paravirt.h
@@ -29,6 +29,16 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
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
@@ -45,6 +55,19 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
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
@@ -57,5 +80,10 @@ static inline bool vcpu_is_preempted(int cpu)
 	return false;
 }
 
+static inline bool pv_is_native_spin_unlock(void)
+{
+     return !is_shared_processor();
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_PARAVIRT_H */
diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index c49e33e24edd..0960a0de2467 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -3,9 +3,36 @@
 #define _ASM_POWERPC_QSPINLOCK_H
 
 #include <asm-generic/qspinlock_types.h>
+#include <asm/paravirt.h>
 
 #define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+static __always_inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	if (!is_shared_processor())
+		native_queued_spin_lock_slowpath(lock, val);
+	else
+		__pv_queued_spin_lock_slowpath(lock, val);
+}
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
@@ -20,6 +47,34 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
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
index 000000000000..6dbdb8a4f84f
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock_paravirt.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_QSPINLOCK_PARAVIRT_H
+#define __ASM_QSPINLOCK_PARAVIRT_H
+
+#endif /* __ASM_QSPINLOCK_PARAVIRT_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 24c18362e5ea..756e727b383f 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -25,9 +25,14 @@ config PPC_PSERIES
 	select SWIOTLB
 	default y
 
+config PARAVIRT_SPINLOCKS
+	bool
+	default n
+
 config PPC_SPLPAR
 	depends on PPC_PSERIES
 	bool "Support for shared-processor logical partitions"
+	select PARAVIRT_SPINLOCKS if PPC_QUEUED_SPINLOCKS
 	help
 	  Enabling this option will make the kernel run more efficiently
 	  on logically-partitioned pSeries systems which use shared
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 2db8469e475f..747a203d9453 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -771,8 +771,12 @@ static void __init pSeries_setup_arch(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		vpa_init(boot_cpuid);
 
-		if (lppaca_shared_proc(get_lppaca()))
+		if (lppaca_shared_proc(get_lppaca())) {
 			static_branch_enable(&shared_processor);
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+			pv_spinlocks_init();
+#endif
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

