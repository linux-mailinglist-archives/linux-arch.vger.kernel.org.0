Return-Path: <linux-arch+bounces-15105-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5CBC900F4
	for <lists+linux-arch@lfdr.de>; Thu, 27 Nov 2025 20:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEFE14EA99C
	for <lists+linux-arch@lfdr.de>; Thu, 27 Nov 2025 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DFF30DD17;
	Thu, 27 Nov 2025 19:44:27 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6E30C36E;
	Thu, 27 Nov 2025 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764272667; cv=none; b=NxGOxewOEdsiJBn+Z0Jkl5cJgm5geDfZI1pq0x8/cboJKAcVSH+9RVW+iYnXVcoBWLdKKg7qDlbTSVoUePjQRmD4jI2BYMGs2c2Hi6h19rQoTDc7E/yuk0q9i1YEQGFYM+7SbLyua4u4kXSCwrrPblbNoBVAXAaqNb+5vJoDUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764272667; c=relaxed/simple;
	bh=lA8iHieS/RyI/FGVwQCo/SBkimdcMC6BNnakO2bwW+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OU2WaHcpoNPBKZunHccZVTjbiF2eecO7l+FyLCZi8WChcGC8+St8w6NRf6FXReseOkQvB7yXBmYoyOYRnYmstddzH7j7f4UflhozbHMeYYj05LzeG1i2y21QOJbTbipo2EEWtuwmGkeDO5d5m/doX/LFXgvQTKI4/HHCa0T/nNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHRgH0f6NzJ4681;
	Fri, 28 Nov 2025 03:43:23 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 58FFF140119;
	Fri, 28 Nov 2025 03:44:20 +0800 (CST)
Received: from localhost.localdomain (10.123.70.40) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:44:19 +0300
From: Anatoly Stepanov <stepanov.anatoly@huawei.com>
To: <peterz@infradead.org>, <boqun.feng@gmail.com>, <longman@redhat.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <arnd@arndb.de>, <dvhart@infradead.org>,
	<dave@stgolabs.net>, <andrealmeid@igalia.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<guohanjun@huawei.com>, <wangkefeng.wang@huawei.com>,
	<weiyongjun1@huawei.com>, <yusongping@huawei.com>, <leijitang@huawei.com>,
	<artem.kuzin@huawei.com>, <fedorov.nikita@h-partners.com>,
	<kang.sun@huawei.com>, Anatoly Stepanov <stepanov.anatoly@huawei.com>
Subject: [RFC PATCH 1/1] HQspinlock - (NUMA-aware) Hierarchical Queued spinlock
Date: Fri, 28 Nov 2025 11:26:18 +0800
Message-ID: <20251128032618.811617-2-stepanov.anatoly@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128032618.811617-1-stepanov.anatoly@huawei.com>
References: <20251128032618.811617-1-stepanov.anatoly@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

This patch based on Linux kernel vanilla 6.17, contains:

- HQ spinlock implementation, logically divided into hqlock_* files
  (core part, metadata part, etc.)
- Example of HQ-spinlock enabled for fuitex hash-table bucket locks
  (used in memcached testing scenario)
- Example of HQ-spinlock enabled for dentry->lockref spinlock
  (used in Nginx testing scenario)

Co-authored-by: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Co-authored-by: Fedorov Nikita <fedorov.nikita@h-partners.com>
---
 arch/arm64/Kconfig                    |  28 +
 arch/arm64/include/asm/qspinlock.h    |  37 ++
 arch/x86/Kconfig                      |  28 +
 arch/x86/include/asm/qspinlock.h      |  38 +-
 include/asm-generic/qspinlock.h       |  23 +-
 include/asm-generic/qspinlock_types.h |  52 +-
 include/linux/lockref.h               |   2 +-
 include/linux/spinlock.h              |  26 +
 include/linux/spinlock_types.h        |  26 +
 include/linux/spinlock_types_raw.h    |  20 +
 init/main.c                           |   4 +
 kernel/futex/core.c                   |   2 +-
 kernel/locking/hqlock_core.h          | 832 ++++++++++++++++++++++++++
 kernel/locking/hqlock_meta.h          | 477 +++++++++++++++
 kernel/locking/hqlock_proc.h          |  88 +++
 kernel/locking/hqlock_types.h         | 118 ++++
 kernel/locking/qspinlock.c            |  67 ++-
 kernel/locking/qspinlock.h            |   4 +-
 kernel/locking/spinlock_debug.c       |  20 +
 19 files changed, 1862 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/include/asm/qspinlock.h
 create mode 100644 kernel/locking/hqlock_core.h
 create mode 100644 kernel/locking/hqlock_meta.h
 create mode 100644 kernel/locking/hqlock_proc.h
 create mode 100644 kernel/locking/hqlock_types.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc3..1cd4893db 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1565,6 +1565,34 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
 
+config HQSPINLOCKS
+	bool "Numa-aware queued spinlocks"
+	depends on NUMA
+	depends on QUEUED_SPINLOCKS
+	default y
+	help
+	  Introduce NUMA (Non Uniform Memory Access) awareness into
+	  the slow path of kernel's spinlocks.
+
+	  We preallocate 'LOCK_ID_MAX' lock_metadata structures with corresponing per-NUMA queues,
+	  and the first queueing contender finds metadata corresponding to its lock by lock's hash and occupies it.
+	  If the metadata is already occupied, perform fallback to default qspinlock approach.
+	  Upcomming contenders then exchange the tail of per-NUMA queue instead of global tail,
+	  and until threshold is reached, we pass the lock to the condenters from the local queue.
+	  At the global tail we keep NUMA nodes to maintain FIFO on per-node level.
+
+	  That approach helps to reduce cross-numa accesses and thus improve lock's performance
+	  in high-load scenarios on multi-NUMA node machines.
+
+	  Say N, if you want absolute first come first serve fairness.
+
+config HQSPINLOCKS_DEBUG
+	bool "Enable debug output for numa-aware spinlocks"
+	depends on HQSPINLOCKS
+	default n
+	help
+	  This option enables statistics for dynamic metadata allocation for HQspinlock
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SPARSEMEM_ENABLE
diff --git a/arch/arm64/include/asm/qspinlock.h b/arch/arm64/include/asm/qspinlock.h
new file mode 100644
index 000000000..5b8b1ca0f
--- /dev/null
+++ b/arch/arm64/include/asm/qspinlock.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_QSPINLOCK_H
+#define _ASM_ARM64_QSPINLOCK_H
+
+#ifdef CONFIG_HQSPINLOCKS
+
+extern void hq_configure_spin_lock_slowpath(void);
+
+extern void (*hq_queued_spin_lock_slowpath)(struct qspinlock *lock, u32 val);
+extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+#define	queued_spin_unlock queued_spin_unlock
+/**
+ * queued_spin_unlock - release a queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ *
+ * A smp_store_release() on the least-significant byte.
+ */
+static inline void native_queued_spin_unlock(struct qspinlock *lock)
+{
+	smp_store_release(&lock->locked, 0);
+}
+
+static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	hq_queued_spin_lock_slowpath(lock, val);
+}
+
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	native_queued_spin_unlock(lock);
+}
+#endif
+
+#include <asm-generic/qspinlock.h>
+
+#endif /* _ASM_ARM64_QSPINLOCK_H */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 058803012..dfa982cf1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1514,6 +1514,34 @@ config NUMA
 
 	  Otherwise, you should say N.
 
+config HQSPINLOCKS
+	bool "Numa-aware queued spinlocks"
+	depends on NUMA
+	depends on QUEUED_SPINLOCKS
+	default y
+	help
+	  Introduce NUMA (Non Uniform Memory Access) awareness into
+	  the slow path of kernel's spinlocks.
+
+	  We preallocate 'LOCK_ID_MAX' lock_metadata structures with corresponing per-NUMA queues,
+	  and the first queueing contender finds metadata corresponding to its lock by lock's hash and occupies it.
+	  If the metadata is already occupied, perform fallback to default qspinlock approach.
+	  Upcomming contenders then exchange the tail of per-NUMA queue instead of global tail,
+	  and until threshold is reached, we pass the lock to the condenters from the local queue.
+	  At the global tail we keep NUMA nodes to maintain FIFO on per-node level.
+
+	  That approach helps to reduce cross-numa accesses and thus improve lock's performance
+	  in high-load scenarios on multi-NUMA node machines.
+
+	  Say N, if you want absolute first come first serve fairness.
+
+config HQSPINLOCKS_DEBUG
+	bool "Enable debug output for numa-aware spinlocks"
+	depends on HQSPINLOCKS
+	default n
+	help
+	  This option enables statistics for dynamic metadata allocation for HQspinlock
+
 config AMD_NUMA
 	def_bool y
 	prompt "Old style AMD Opteron NUMA detection"
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 68da67df3..ae152fe3e 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -22,7 +22,7 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
 	 */
 	val = GEN_BINARY_RMWcc(LOCK_PREFIX "btsl", lock->val.counter, c,
 			       "I", _Q_PENDING_OFFSET) * _Q_PENDING_VAL;
-	val |= atomic_read(&lock->val) & ~_Q_PENDING_MASK;
+	val |= atomic_read(&lock->val) & ~_Q_PENDING_VAL;
 
 	return val;
 }
@@ -64,6 +64,39 @@ static inline bool vcpu_is_preempted(long cpu)
 }
 #endif
 
+// CONFIG_PARAVIRT_SPINLOCKS
+
+#ifdef CONFIG_HQSPINLOCKS
+extern void hq_configure_spin_lock_slowpath(void);
+
+#ifndef CONFIG_PARAVIRT_SPINLOCKS
+extern void (*hq_queued_spin_lock_slowpath)(struct qspinlock *lock, u32 val);
+extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+#define	queued_spin_unlock queued_spin_unlock
+/**
+ * queued_spin_unlock - release a queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ *
+ * A smp_store_release() on the least-significant byte.
+ */
+static inline void native_queued_spin_unlock(struct qspinlock *lock)
+{
+	smp_store_release(&lock->locked, 0);
+}
+
+static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	hq_queued_spin_lock_slowpath(lock, val);
+}
+
+static inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	native_queued_spin_unlock(lock);
+}
+#endif // !CONFIG_PARAVIRT_SPINLOCKS
+#endif // CONFIG_HQSPINLOCKS
+
 #ifdef CONFIG_PARAVIRT
 /*
  * virt_spin_lock_key - disables by default the virt_spin_lock() hijack.
@@ -101,7 +134,8 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
  __retry:
 	val = atomic_read(&lock->val);
 
-	if (val || !atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)) {
+	if ((val & ~_Q_SERVICE_MASK) ||
+	     !atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL | (val & _Q_SERVICE_MASK))) {
 		cpu_relax();
 		goto __retry;
 	}
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index bf47cca2c..af3ab0286 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -54,7 +54,7 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 	 * Any !0 state indicates it is locked, even if _Q_LOCKED_VAL
 	 * isn't immediately observable.
 	 */
-	return atomic_read(&lock->val);
+	return atomic_read(&lock->val) & ~_Q_SERVICE_MASK;
 }
 #endif
 
@@ -70,7 +70,7 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
  */
 static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
 {
-	return !lock.val.counter;
+	return !(lock.val.counter & ~_Q_SERVICE_MASK);
 }
 
 /**
@@ -80,8 +80,10 @@ static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
  */
 static __always_inline int queued_spin_is_contended(struct qspinlock *lock)
 {
-	return atomic_read(&lock->val) & ~_Q_LOCKED_MASK;
+	return atomic_read(&lock->val) & ~(_Q_LOCKED_MASK | _Q_SERVICE_MASK);
 }
+
+#ifndef queued_spin_trylock
 /**
  * queued_spin_trylock - try to acquire the queued spinlock
  * @lock : Pointer to queued spinlock structure
@@ -91,11 +93,12 @@ static __always_inline int queued_spin_trylock(struct qspinlock *lock)
 {
 	int val = atomic_read(&lock->val);
 
-	if (unlikely(val))
+	if (unlikely(val & ~_Q_SERVICE_MASK))
 		return 0;
 
-	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
+	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, val | _Q_LOCKED_VAL));
 }
+#endif
 
 extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 
@@ -106,14 +109,16 @@ extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
  */
 static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
-	int val = 0;
+	int val = atomic_read(&lock->val);
 
-	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
-		return;
+	if (likely(!(val & ~_Q_SERVICE_MASK))) {
+		if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, val | _Q_LOCKED_VAL)))
+			return;
+	}
 
 	queued_spin_lock_slowpath(lock, val);
 }
-#endif
+#endif // queued_spin_lock
 
 #ifndef queued_spin_unlock
 /**
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 2fd1fb89e..830751f71 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -27,7 +27,17 @@ typedef struct qspinlock {
 		};
 		struct {
 			u16	locked_pending;
+#ifndef CONFIG_HQSPINLOCKS
 			u16	tail;
+#else
+		union {
+			u16 tail;
+			struct {
+				u8	tail_node;
+				u8	head_node;
+			};
+		};
+#endif
 		};
 #else
 		struct {
@@ -43,11 +53,6 @@ typedef struct qspinlock {
 	};
 } arch_spinlock_t;
 
-/*
- * Initializier
- */
-#define	__ARCH_SPIN_LOCK_UNLOCKED	{ { .val = ATOMIC_INIT(0) } }
-
 /*
  * Bitfields in the atomic value:
  *
@@ -76,6 +81,32 @@ typedef struct qspinlock {
 #else
 #define _Q_PENDING_BITS		1
 #endif
+
+#ifdef CONFIG_HQSPINLOCKS
+/* For locks with HQ-mode we always use single pending bit */
+#define _Q_PENDING_HQLOCK_BITS	 1
+#define _Q_PENDING_HQLOCK_OFFSET (_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
+#define _Q_PENDING_HQLOCK_MASK		_Q_SET_MASK(PENDING_HQLOCK)
+
+#define _Q_LOCKTYPE_OFFSET	(_Q_PENDING_HQLOCK_OFFSET + _Q_PENDING_HQLOCK_BITS)
+#define _Q_LOCKTYPE_BITS	1
+#define _Q_LOCKTYPE_MASK	_Q_SET_MASK(LOCKTYPE)
+#define _Q_LOCKTYPE_VAL			(1U << _Q_LOCKTYPE_OFFSET)
+
+#define _Q_LOCK_MODE_OFFSET	(_Q_LOCKTYPE_OFFSET + _Q_LOCKTYPE_BITS)
+#define _Q_LOCK_MODE_BITS	2
+#define _Q_LOCK_MODE_MASK	_Q_SET_MASK(LOCK_MODE)
+#define _Q_LOCK_MODE_QSPINLOCK_VAL	(1U << _Q_LOCK_MODE_OFFSET)
+
+#define _Q_LOCK_INVALID_TAIL (1 << 31U)
+
+#define _Q_LOCK_TYPE_MODE_MASK	(_Q_LOCKTYPE_MASK | _Q_LOCK_MODE_MASK)
+
+#define _Q_SERVICE_MASK	(_Q_LOCKTYPE_MASK | _Q_LOCK_MODE_QSPINLOCK_VAL | _Q_LOCK_INVALID_TAIL)
+#else // CONFIG_HQSPINLOCKS
+#define _Q_SERVICE_MASK		0
+#endif
+
 #define _Q_PENDING_MASK		_Q_SET_MASK(PENDING)
 
 #define _Q_TAIL_IDX_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
@@ -92,4 +123,15 @@ typedef struct qspinlock {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
+/*
+ * Initializier
+ */
+#define	__ARCH_SPIN_LOCK_UNLOCKED		{ { .val = ATOMIC_INIT(0) } }
+
+#ifdef CONFIG_HQSPINLOCKS
+#define	__ARCH_SPIN_LOCK_UNLOCKED_HQ	{ { .val = ATOMIC_INIT(_Q_LOCKTYPE_VAL | _Q_LOCK_MODE_QSPINLOCK_VAL) } }
+#else
+#define	__ARCH_SPIN_LOCK_UNLOCKED_HQ	{ { .val = ATOMIC_INIT(0) } }
+#endif
+
 #endif /* __ASM_GENERIC_QSPINLOCK_TYPES_H */
diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index 676721ee8..294686604 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -42,7 +42,7 @@ struct lockref {
  */
 static inline void lockref_init(struct lockref *lockref)
 {
-	spin_lock_init(&lockref->lock);
+	spin_lock_init_hq(&lockref->lock);
 	lockref->count = 1;
 }
 
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3561c4a0..d30fe094b 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -100,6 +100,8 @@
 #ifdef CONFIG_DEBUG_SPINLOCK
   extern void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 				   struct lock_class_key *key, short inner);
+  extern void __raw_spin_lock_init_hq(raw_spinlock_t *lock, const char *name,
+				   struct lock_class_key *key, short inner);
 
 # define raw_spin_lock_init(lock)					\
 do {									\
@@ -108,9 +110,19 @@ do {									\
 	__raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN);	\
 } while (0)
 
+# define raw_spin_lock_init_hq(lock)					\
+do {									\
+	static struct lock_class_key __key;				\
+									\
+	__raw_spin_lock_init_hq((lock), #lock, &__key, LD_WAIT_SPIN);	\
+} while (0)
+
 #else
 # define raw_spin_lock_init(lock)				\
 	do { *(lock) = __RAW_SPIN_LOCK_UNLOCKED(lock); } while (0)
+
+# define raw_spin_lock_init_hq(lock)				\
+	do { *(lock) = __RAW_SPIN_LOCK_UNLOCKED_HQ(lock); } while (0)
 #endif
 
 #define raw_spin_is_locked(lock)	arch_spin_is_locked(&(lock)->raw_lock)
@@ -336,6 +348,14 @@ do {								\
 			     #lock, &__key, LD_WAIT_CONFIG);	\
 } while (0)
 
+# define spin_lock_init_hq(lock)					\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	__raw_spin_lock_init_hq(spinlock_check(lock),		\
+			     #lock, &__key, LD_WAIT_CONFIG);	\
+} while (0)
+
 #else
 
 # define spin_lock_init(_lock)			\
@@ -344,6 +364,12 @@ do {						\
 	*(_lock) = __SPIN_LOCK_UNLOCKED(_lock);	\
 } while (0)
 
+# define spin_lock_init_hq(_lock)			\
+do {						\
+	spinlock_check(_lock);			\
+	*(_lock) = __SPIN_LOCK_UNLOCKED_HQ(_lock);	\
+} while (0)
+
 #endif
 
 static __always_inline void spin_lock(spinlock_t *lock)
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 2dfa35ffe..b59755786 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -42,6 +42,29 @@ typedef struct spinlock {
 
 #define DEFINE_SPINLOCK(x)	spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
 
+#ifdef __ARCH_SPIN_LOCK_UNLOCKED_HQ
+#define ___SPIN_LOCK_INITIALIZER_HQ(lockname)	\
+	{					\
+	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED_HQ,	\
+	SPIN_DEBUG_INIT(lockname)		\
+	SPIN_DEP_MAP_INIT(lockname) }
+
+#else
+#define ___SPIN_LOCK_INITIALIZER_HQ(lockname)	\
+	{					\
+	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
+	SPIN_DEBUG_INIT(lockname)		\
+	SPIN_DEP_MAP_INIT(lockname) }
+#endif
+
+#define __SPIN_LOCK_INITIALIZER_HQ(lockname) \
+	{ { .rlock = ___SPIN_LOCK_INITIALIZER_HQ(lockname) } }
+
+#define __SPIN_LOCK_UNLOCKED_HQ(lockname) \
+	(spinlock_t) __SPIN_LOCK_INITIALIZER_HQ(lockname)
+
+#define DEFINE_SPINLOCK_HQ(x) spinlock_t x = __SPIN_LOCK_UNLOCKED_HQ(x)
+
 #else /* !CONFIG_PREEMPT_RT */
 
 /* PREEMPT_RT kernels map spinlock to rt_mutex */
@@ -69,6 +92,9 @@ typedef struct spinlock {
 #define DEFINE_SPINLOCK(name)					\
 	spinlock_t name = __SPIN_LOCK_UNLOCKED(name)
 
+#define DEFINE_SPINLOCK_HQ(name)					\
+	spinlock_t name = __SPIN_LOCK_UNLOCKED(name)
+
 #endif /* CONFIG_PREEMPT_RT */
 
 #include <linux/rwlock_types.h>
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index 91cb36b65..b29fa77bb 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -70,4 +70,24 @@ typedef struct raw_spinlock {
 
 #define DEFINE_RAW_SPINLOCK(x)  raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
 
+#ifdef __ARCH_SPIN_LOCK_UNLOCKED_HQ
+#define __RAW_SPIN_LOCK_INITIALIZER_HQ(lockname)	\
+{						\
+	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED_HQ,	\
+	SPIN_DEBUG_INIT(lockname)		\
+	RAW_SPIN_DEP_MAP_INIT(lockname) }
+
+#else
+#define __RAW_SPIN_LOCK_INITIALIZER_HQ(lockname)	\
+{						\
+	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
+	SPIN_DEBUG_INIT(lockname)		\
+	RAW_SPIN_DEP_MAP_INIT(lockname) }
+#endif
+
+#define __RAW_SPIN_LOCK_UNLOCKED_HQ(lockname)	\
+	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER_HQ(lockname)
+
+#define DEFINE_RAW_SPINLOCK_HQ(x)  raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED_HQ(x)
+
 #endif /* __LINUX_SPINLOCK_TYPES_RAW_H */
diff --git a/init/main.c b/init/main.c
index 5753e9539..3f8dd4cda 100644
--- a/init/main.c
+++ b/init/main.c
@@ -929,6 +929,10 @@ void start_kernel(void)
 	early_numa_node_init();
 	boot_cpu_hotplug_init();
 
+#ifdef CONFIG_HQSPINLOCKS
+	hq_configure_spin_lock_slowpath();
+#endif
+
 	pr_notice("Kernel command line: %s\n", saved_command_line);
 	/* parameters may set static keys */
 	parse_early_param();
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 125804fbb..05c6d1efc 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1521,7 +1521,7 @@ static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
 #endif
 	atomic_set(&fhb->waiters, 0);
 	plist_head_init(&fhb->chain);
-	spin_lock_init(&fhb->lock);
+	spin_lock_init_hq(&fhb->lock);
 }
 
 #define FH_CUSTOM	0x01
diff --git a/kernel/locking/hqlock_core.h b/kernel/locking/hqlock_core.h
new file mode 100644
index 000000000..376da7609
--- /dev/null
+++ b/kernel/locking/hqlock_core.h
@@ -0,0 +1,832 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GEN_HQ_SPINLOCK_SLOWPATH
+#error "Do not include this file!"
+#endif
+
+#include <linux/nodemask.h>
+#include <linux/topology.h>
+#include <linux/sched/clock.h>
+#include <linux/moduleparam.h>
+#include <linux/sched/rt.h>
+#include <linux/random.h>
+#include <linux/mm.h>
+#include <linux/memblock.h>
+#include <linux/sysctl.h>
+#include <linux/types.h>
+#include <linux/percpu.h>
+#include <linux/slab.h>
+#include <linux/panic.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/sprintf.h>
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>
+#include <linux/swab.h>
+#include <linux/hash.h>
+
+#if CONFIG_NR_CPUS >= (1U << 13)
+#warning "You have CONFIG_NR_CPUS >= 8192. If your system really has so many core, turn off CONFIG_HQSPINLOCKS!"
+#endif
+
+/* Contains queues for all possible lock id */
+static struct numa_queue *queue_table[MAX_NUMNODES];
+
+#include "hqlock_types.h"
+#include "hqlock_proc.h"
+
+/* Gets node_id (1..N) */
+static inline struct numa_queue *
+get_queue(u16 lock_id, u8 node_id)
+{
+	return &queue_table[node_id - 1][lock_id];
+}
+
+static inline struct numa_queue *
+get_local_queue(struct numa_qnode *qnode)
+{
+	return get_queue(qnode->lock_id, qnode->numa_node);
+}
+
+static inline void init_queue_link(struct numa_queue *queue)
+{
+	queue->prev_node = 0;
+	queue->next_node = 0;
+}
+
+static inline void init_queue(struct numa_qnode *qnode)
+{
+	struct numa_queue *queue = get_local_queue(qnode);
+
+	queue->head = qnode;
+	queue->handoffs_not_head = 0;
+	init_queue_link(queue);
+}
+
+static void set_next_queue(u16 lock_id, u8 prev_node_id, u8 node_id)
+{
+	struct numa_queue *local_queue = get_queue(lock_id, node_id);
+	struct numa_queue *prev_queue =
+		get_queue(lock_id, prev_node_id);
+
+	WRITE_ONCE(local_queue->prev_node, prev_node_id);
+	/*
+	 * Needs to be guaranteed the following:
+	 * when appending "local_queue", if "prev_queue->next_node" link
+	 * is observed then "local_queue->prev_node" is also observed.
+	 *
+	 * We need this to guarantee correctness of concurrent
+	 * "unlink_node_queue" for the "prev_queue", if "prev_queue" is the first in the list.
+	 * [prev_queue] <-> [local_queue]
+	 *
+	 * In this case "unlink_node_queue" would be setting "local_queue->prev_node = 0", thus
+	 * w/o the smp-barrier, it might race with "set_next_queue", if
+	 * "local_queue->prev_node = prev_node_id" happens afterwards, leading to corrupted list.
+	 */
+	smp_wmb();
+	WRITE_ONCE(prev_queue->next_node, node_id);
+}
+
+static inline struct lock_metadata *get_meta(u16 lock_id);
+
+/**
+ * Put new node's queue into global NUMA-level queue
+ */
+static inline u8 append_node_queue(u16 lock_id, u8 node_id)
+{
+	struct lock_metadata *lock_meta = get_meta(lock_id);
+	u8 prev_node_id = xchg(&lock_meta->tail_node, node_id);
+
+	if (prev_node_id)
+		set_next_queue(lock_id, prev_node_id, node_id);
+	else
+		WRITE_ONCE(lock_meta->head_node, node_id);
+	return prev_node_id;
+}
+
+#include "hqlock_meta.h"
+
+/**
+ * Update tail
+ *
+ * Call proper function depending on lock's mode
+ * until successful queuing
+ */
+static inline u32 hqlock_xchg_tail(struct qspinlock *lock, u32 tail,
+				 struct mcs_spinlock *node, bool *numa_awareness_on)
+{
+	struct numa_qnode *qnode = (struct numa_qnode *)node;
+
+	u16 lock_id;
+	u32 old_tail;
+	u32 next_tail = tail;
+
+	/*
+	 * Key lock's mode switches questions:
+	 * - After init lock is in LOCK_MODE_QSPINLOCK
+	 * - If many contenders have come while lock was in LOCK_MODE_QSPINLOCK,
+	 *   we want this lock to use NUMA awareness next time,
+	 *   so we clean LOCK_MODE_QSPINLOCK, see 'low_contention_try_clear_tail'
+	 * - During next lock's usages we try to go through NUMA-aware path.
+	 *   We can fail here, because we use shared metadata
+	 *   and can have a conflict with another lock, see 'hqlock_meta.h' for details.
+	 *   In this case we fallback to generic qspinlock approach.
+	 *
+	 * In other words, lock can be in 3 mode states:
+	 *
+	 * 1. LOCK_MODE_QSPINLOCK - there was low contention or not at all earlier,
+	 *    or (unlikely) a conflict in metadata
+	 * 2. LOCK_NO_MODE - there was a contention on a lock earlier,
+	 *    now there are no contenders in the queue (we are likely the first)
+	 *    and we need to try using NUMA awareness
+	 * 3. LOCK_MODE_HQLOCK - lock is currently under contention
+	 *    and using NUMA awareness.
+	 */
+
+	/*
+	 * numa_awareness_on == false means we saw LOCK_MODE_QSPINLOCK (1st state)
+	 * before starting slowpath, see 'queued_spin_lock_slowpath'
+	 */
+	if (*numa_awareness_on == false &&
+		try_update_tail_qspinlock_mode(lock, tail, &old_tail, &next_tail))
+		return old_tail;
+
+	/* Calculate the lock_id hash here once */
+	qnode->lock_id = lock_id = hash_ptr(lock, LOCK_ID_BITS);
+
+try_again:
+	/*
+	 * Lock is in state 2 or 3 - go through NUMA-aware path
+	 */
+	if (try_update_tail_hqlock_mode(lock, lock_id, qnode, tail, &next_tail, &old_tail)) {
+		*numa_awareness_on = true;
+		return old_tail;
+	}
+
+	/*
+	 * We have failed (conflict in metadata), now lock is in LOCK_MODE_QSPINLOCK again
+	 */
+	if (try_update_tail_qspinlock_mode(lock, tail, &old_tail, &next_tail)) {
+		*numa_awareness_on = false;
+		return old_tail;
+	}
+
+	/*
+	 * We were slow and clear_tail after high contention has already happened
+	 * (very unlikely situation)
+	 */
+	goto try_again;
+}
+
+static inline void hqlock_clear_pending(struct qspinlock *lock, u32 old_val)
+{
+	WRITE_ONCE(lock->pending, (old_val & _Q_LOCK_TYPE_MODE_MASK) >> _Q_PENDING_OFFSET);
+}
+
+static inline void hqlock_clear_pending_set_locked(struct qspinlock *lock, u32 old_val)
+{
+	WRITE_ONCE(lock->locked_pending,
+			_Q_LOCKED_VAL | (old_val & _Q_LOCK_TYPE_MODE_MASK));
+}
+
+static inline void unlink_node_queue(u16 lock_id,
+					u8 prev_node_id,
+					u8 next_node_id)
+{
+	struct numa_queue *prev_queue =
+		prev_node_id ? get_queue(lock_id, prev_node_id) : NULL;
+	struct numa_queue *next_queue = get_queue(lock_id, next_node_id);
+
+	if (prev_queue)
+		WRITE_ONCE(prev_queue->next_node, next_node_id);
+	/*
+	 * This is guaranteed to be ordered "after" next_node_id observation
+	 * by implicit full-barrier in the caller-code.
+	*/
+	WRITE_ONCE(next_queue->prev_node, prev_node_id);
+}
+
+static inline bool try_clear_queue_tail(struct numa_queue *queue, u32 tail)
+{
+	/*
+	 * We need full ordering here to:
+	 * - ensure all prior operations with global tail and prev_queue
+	 *   are observed before clearing local tail
+	 * - guarantee all subsequent operations
+	 *   with metadata release, unlink etc will be observed after clearing local tail
+	 */
+	return cmpxchg(&queue->tail, tail, 0) == tail;
+}
+
+/*
+ * Determine if we have another local and global contenders.
+ * Try clear local and global tail, understand handoff type we need to perform.
+ * In case we are the last, free lock's metadata
+ */
+static inline bool hqlock_try_clear_tail(struct qspinlock *lock, u32 val,
+				       u32 tail, struct mcs_spinlock *node,
+				       int *p_next_node)
+{
+	bool ret = false;
+	struct numa_qnode *qnode = (void *)node;
+
+	u16 lock_id = qnode->lock_id;
+	u8 local_node = qnode->numa_node;
+	struct numa_queue *queue = get_queue(lock_id, qnode->numa_node);
+
+	struct lock_metadata *lock_meta = get_meta(lock_id);
+
+	u8 prev_node = 0, next_node = 0;
+	u8 node_tail;
+
+	u16 old_val;
+
+	bool lock_tail_updated = false;
+	bool lock_tail_cleared = false;
+
+	/* Do we have *next node* arrived */
+	bool pending_next_node = false;
+
+	tail >>= _Q_TAIL_OFFSET;
+
+	/* Do we have other CPUs in the node queue ? */
+	if (READ_ONCE(queue->tail) != tail) {
+		*p_next_node = HQLOCK_HANDOFF_LOCAL;
+		goto out;
+	}
+
+	/*
+	 * Key observations and actions:
+	 * 1) next queue isn't observed:
+	 *    a) if prev queue is observed, try to unpublish local queue
+	 *    b) if prev queue is not observed, try to clean global tail
+	 *    Anyway, perform these operations before clearing local tail.
+	 *
+	 *    Such trick is essential to safely unlink the local queue,
+	 *    otherwise we could race with upcomming local contenders,
+	 *    which will perform 'append_node_queue' while our unlink is not properly done.
+	 *
+	 * 2) next queue is observed:
+	 *    safely perform 'try_clear_queue_tail' and unlink local node if succeeded.
+	 */
+
+	prev_node = READ_ONCE(queue->prev_node);
+	pending_next_node = READ_ONCE(lock_meta->tail_node) != local_node;
+
+	/*
+	 * Tail case:
+	 * [prev_node] -> [local_node], lock->tail_node == local_node
+	 *
+	 * There're no nodes after us at the moment, try updating the "lock->tail_node"
+	 */
+	if (!pending_next_node && prev_node) {
+		struct numa_queue *prev_queue =
+			get_queue(lock_id, prev_node);
+
+		/* Reset next_node, in case no one will come after */
+		WRITE_ONCE(prev_queue->next_node, 0);
+
+		/*
+		 * release to publish prev_queue->next_node = 0
+		 * and to ensure ordering with 'READ_ONCE(queue->tail) != tail'
+		 */
+		if (cmpxchg_release(&lock_meta->tail_node, local_node, prev_node) == local_node) {
+			lock_tail_updated = true;
+
+			queue->next_node = 0;
+			queue->prev_node = 0;
+			next_node = 0;
+		} else {
+			/* If some node came after the local meanwhile, reset next_node back */
+			WRITE_ONCE(prev_queue->next_node, local_node);
+
+			/* We either observing updated "queue->next" or it equals zero */
+			next_node = READ_ONCE(queue->next_node);
+		}
+	}
+
+	node_tail = READ_ONCE(lock_meta->tail_node);
+
+	/* If nobody else is waiting, try clean global tail */
+	if (node_tail == local_node && !prev_node) {
+		old_val = (((u16)local_node) | (((u16)local_node) << 8));
+		/* release to ensure ordering with 'READ_ONCE(queue->tail) != tail' */
+		lock_tail_cleared = try_cmpxchg_release(&lock_meta->nodes_tail, &old_val, 0);
+	}
+
+	/*
+	 * lock->tail_node was not updated and cleared,
+	 * so we have at least single non-empty node after us
+	 */
+	if (!lock_tail_updated && !lock_tail_cleared) {
+		/*
+		 * If there's a node came before clearing node queue - wait for it to link properly.
+		 * We need this for correct upcoming *unlink*, otherwise the *unlink* might race with parallel set_next_node()
+		 */
+		if (!next_node) {
+			next_node =
+				smp_cond_load_relaxed(&queue->next_node, (VAL));
+		}
+	}
+
+	/* if we're the last one in the queue - clear the queue tail */
+	if (try_clear_queue_tail(queue, tail)) {
+		/*
+		 * "lock_tail_cleared == true"
+		 * It means: we cleared "lock->tail_node" and "lock->head_node".
+		 *
+		 * First new contender will do "global spin" anyway, so no handoff needed
+		 * "ret == true"
+		 */
+		if (lock_tail_cleared) {
+			ret = true;
+
+			/*
+			 * If someone has arrived in the meanwhile,
+			 * don't try to free the metadata.
+			 */
+			old_val = READ_ONCE(lock_meta->nodes_tail);
+			if (!old_val) {
+				/*
+				 * We are probably the last contender,
+				 * so, need to free lock's metadata.
+				 */
+				release_lock_meta(lock, lock_meta, qnode);
+			}
+			goto out;
+		}
+
+		/*
+		 * "lock_tail_updated == true" (implies "lock_tail_cleared == false")
+		 * It means we have at least "prev_node" and unlinked "local node"
+		 *
+		 * As we unlinked "local node", we only need to guarantee correct
+		 * remote handoff, thus we have:
+		 * "ret == false"
+		 * "next_node == HQLOCK_HANDOFF_REMOTE_HEAD"
+		 */
+		if (lock_tail_updated) {
+			*p_next_node = HQLOCK_HANDOFF_REMOTE_HEAD;
+			goto out;
+		}
+
+		/*
+		 * "!lock_tail_cleared && !lock_tail_updated"
+		 * It means we have at least single node after us.
+		 *
+		 * remote handoff and corect "local node" unlink are needed.
+		 *
+		 * "next_node" visibility guarantees that we observe
+		 * correctly additon of "next_node", so the following unlink
+		 * is safe and correct.
+		 *
+		 * "next_node > 0"
+		 * "ret == false"
+		 */
+		unlink_node_queue(lock_id, prev_node, next_node);
+
+		/*
+		 * If at the head - update one.
+		 *
+		 * Another place, where "lock->head_node" is updated is "append_node_queue"
+		 * But we're safe, as that happens only with the first node on empty "node list".
+		 */
+		if (!prev_node)
+			WRITE_ONCE(lock_meta->head_node, next_node);
+
+		*p_next_node = next_node;
+	} else {
+		/*
+		 * local queue has other contenders.
+		 *
+		 * 1) "lock_tail_updated == true":
+		 * It means we have at least "prev_node" and unlinked "local node"
+		 * Also, some new nodes can arrive and link after "prev_node".
+		 * We should just re-add "local node": (prev_node) => ... => (local_node)
+		 * and perform local handoff, as other CPUs from the local node do "mcs spin"
+		 *
+		 * 2) "lock_tail_cleared == true"
+		 * It means we cleared "lock->tail_node" and "lock->head_node".
+		 * We need to re-add "local node" and move "local_queue->head" to the next "mcs-node",
+		 * which is in the progress of linking after the current "mcs-node"
+		 * (that's why we couldn't clear the "local_queue->tail").
+		 *
+		 * Meanwhile other nodes can arrive: (new_node) => (...)
+		 * That "new_node" will spin in "global spin" mode.
+		 * In this case no handoff needed.
+		 *
+		 * 3) "!lock_tail_cleared && !lock_tail_updated"
+		 * It means we had at least one node after us before 'try_clear_queue_tail'
+		 * and only need to perform local handoff
+		 */
+
+		/* Cases 1) and 2) */
+		if (lock_tail_updated || lock_tail_cleared) {
+			u8 prev_node_id;
+
+			init_queue_link(queue);
+			prev_node_id =
+				append_node_queue(lock_id, local_node);
+
+			if (prev_node_id && lock_tail_cleared) {
+				/* Case 2) */
+				ret = true;
+				WRITE_ONCE(queue->head,
+					   (void *) smp_cond_load_relaxed(&node->next, (VAL)));
+				goto out;
+			}
+		}
+
+		/* Cases 1) and 3) */
+		*p_next_node = HQLOCK_HANDOFF_LOCAL;
+		ret = false;
+	}
+out:
+	/*
+	 * Either handoff for current node,
+	 * or remote handoff if the quota is expired
+	 */
+	return ret;
+}
+
+static inline void hqlock_handoff(struct qspinlock *lock,
+					 struct mcs_spinlock *node,
+					 struct mcs_spinlock *next, u32 tail,
+					 int handoff_info);
+
+
+/*
+ * Chech if contention has risen and if we need to set NUMA-aware mode
+ */
+static __always_inline bool determine_contention_qspinlock_mode(struct mcs_spinlock *node)
+{
+	struct numa_qnode *qnode = (void *)node;
+
+	if (qnode->general_handoffs > READ_ONCE(hqlock_general_handoffs_turn_numa))
+		return true;
+	return false;
+}
+
+static __always_inline bool low_contention_try_clear_tail(struct qspinlock *lock,
+					     u32 val,
+					     struct mcs_spinlock *node)
+{
+	u32 update_val = _Q_LOCKED_VAL | _Q_LOCKTYPE_VAL;
+
+	bool high_contention = determine_contention_qspinlock_mode(node);
+
+	/*
+	 * If we have high contention, we set _Q_LOCK_INVALID_TAIL
+	 * to notify upcomming contenders, which have seen QSPINLOCK mode,
+	 * that performing generic 'xchg_tail' is wrong.
+	 *
+	 * We cannot also set HQLOCK mode here,
+	 * because first contender in updated mode
+	 * should check if lock's metadata is free
+	 */
+	if (!high_contention)
+		update_val |= _Q_LOCK_MODE_QSPINLOCK_VAL;
+	else
+		update_val |= _Q_LOCK_INVALID_TAIL;
+
+	return atomic_try_cmpxchg_relaxed(&lock->val, &val, update_val);
+}
+
+static __always_inline void low_contention_mcs_lock_handoff(struct mcs_spinlock *node,
+					       struct mcs_spinlock *next, struct mcs_spinlock *prev)
+{
+	struct numa_qnode *qnode = (void *)node;
+	struct numa_qnode *qnext = (void *)next;
+
+	static u16 max_u16 = (u16)(-1);
+
+	u16 general_handoffs = qnode->general_handoffs;
+
+	if (next != prev && likely(general_handoffs + 1 != max_u16))
+		general_handoffs++;
+
+#ifdef CONFIG_HQSPINLOCKS_DEBUG
+	if (READ_ONCE(max_general_handoffs) < general_handoffs)
+		WRITE_ONCE(max_general_handoffs, general_handoffs);
+#endif
+
+	qnext->general_handoffs = general_handoffs;
+
+#ifdef CONFIG_HQSPINLOCKS_CONTENTION_DETECTION
+	qnext->remote_handoffs = qnode->remote_handoffs;
+	qnext->prev_general_handoffs = qnode->prev_general_handoffs;
+
+	/*
+	 * Show next contender our numa node and assume
+	 * he will update remote_handoffs counter in update_counters_qspinlock by himself
+	 * instead of reading his numa_node and updating remote_handoffs here
+	 * to avoid extra cacheline transferring and help processor optimise several writes here
+	 */
+	qnext->prev_numa_node = qnode->numa_node;
+#endif
+
+	arch_mcs_spin_unlock_contended(&next->locked);
+}
+
+static inline void hqlock_clear_tail_handoff(struct qspinlock *lock, u32 val,
+				    u32 tail,
+				    struct mcs_spinlock *node,
+				    struct mcs_spinlock *next,
+					struct mcs_spinlock *prev,
+					bool is_numa_lock)
+{
+	int handoff_info;
+	struct numa_qnode *qnode = (void *)node;
+
+	/*
+	 * qnode->wrong_fallback_tail means we have queued globally
+	 * in 'try_update_tail_qspinlock_mode' after another contender,
+	 * but lock's mode was not QSPINLOCK in that moment.
+	 *
+	 * First confused contender has restored _Q_LOCK_INVALID_TAIL in global tail
+	 * and set us in his local queue.
+	 */
+	if (is_numa_lock || qnode->wrong_fallback_tail) {
+		/*
+		 * Because of splitting generic tail and NUMA tail we must set locked before clearing tail,
+		 * otherwise double lock is possible
+		 */
+		set_locked(lock);
+
+		if (hqlock_try_clear_tail(lock, val, tail, node, &handoff_info))
+			return;
+
+		hqlock_handoff(lock, node, next, tail, handoff_info);
+	} else {
+		if ((val & _Q_TAIL_MASK) == tail) {
+			if (low_contention_try_clear_tail(lock, val, node))
+				return;
+		}
+
+		set_locked(lock);
+
+		if (!next)
+			next = smp_cond_load_relaxed(&node->next, (VAL));
+
+		low_contention_mcs_lock_handoff(node, next, prev);
+	}
+}
+
+static inline void hqlock_init_node(struct mcs_spinlock *node)
+{
+	struct numa_qnode *qnode = (void *)node;
+
+	qnode->general_handoffs = 0;
+	qnode->numa_node = numa_node_id() + 1;
+	qnode->lock_id = 0;
+	qnode->wrong_fallback_tail = 0;
+}
+
+static inline void reset_handoff_counter(struct numa_qnode *qnode)
+{
+	qnode->general_handoffs = 0;
+}
+
+static inline void handoff_local(struct mcs_spinlock *node,
+					       struct mcs_spinlock *next,
+					       u32 tail)
+{
+	static u16 max_u16 = (u16)(-1);
+
+	struct numa_qnode *qnode = (struct numa_qnode *)node;
+	struct numa_qnode *qnext = (struct numa_qnode *)next;
+
+	u16 general_handoffs = qnode->general_handoffs;
+
+	if (likely(general_handoffs + 1 != max_u16))
+		general_handoffs++;
+
+	qnext->general_handoffs = general_handoffs;
+
+	u16 wrong_fallback_tail = qnode->wrong_fallback_tail;
+
+	if (wrong_fallback_tail != 0 && wrong_fallback_tail != (tail >> _Q_TAIL_OFFSET)) {
+		qnext->numa_node = qnode->numa_node;
+		qnext->wrong_fallback_tail = wrong_fallback_tail;
+		qnext->lock_id = qnode->lock_id;
+	}
+
+	arch_mcs_spin_unlock_contended(&next->locked);
+}
+
+static inline void handoff_remote(struct qspinlock *lock,
+						struct numa_qnode *qnode,
+						u32 tail, int handoff_info)
+{
+	struct numa_queue *next_queue = NULL;
+	struct mcs_spinlock *mcs_head = NULL;
+	struct numa_qnode *qhead = NULL;
+	u16 lock_id = qnode->lock_id;
+
+	struct lock_metadata *lock_meta = get_meta(lock_id);
+	struct numa_queue *queue = get_local_queue(qnode);
+
+	u8 next_node_id;
+	u8 node_head, node_tail;
+
+	node_tail = READ_ONCE(lock_meta->tail_node);
+	node_head = READ_ONCE(lock_meta->head_node);
+
+	/*
+	 * 'handoffs_not_head > 0' means at the head of NUMA-level queue we have a node
+	 * which is heavily loaded and has performed a remote handoff upon reaching the threshold.
+	 *
+	 * Perform handoff to the head instead of next node in the NUMA-level queue,
+	 * if handoffs_not_head >= nr_online_nodes
+	 * (It means other contended nodes have been taking the lock at least once after the head one)
+	 */
+	u16 handoffs_not_head = READ_ONCE(queue->handoffs_not_head);
+
+	if (handoff_info > 0 && (handoffs_not_head < nr_online_nodes)) {
+		next_node_id = handoff_info;
+		if (node_head != qnode->numa_node)
+			handoffs_not_head++;
+	} else {
+		if (!node_head) {
+			/* If we're here - we have defintely other node-contenders, let's wait */
+			next_node_id = smp_cond_load_relaxed(&lock_meta->head_node, (VAL));
+		} else {
+			next_node_id = node_head;
+		}
+
+		handoffs_not_head = 0;
+	}
+
+	next_queue = get_queue(lock_id, next_node_id);
+	WRITE_ONCE(next_queue->handoffs_not_head, handoffs_not_head);
+
+	qhead = READ_ONCE(next_queue->head);
+
+	mcs_head = (void *) qhead;
+
+	/* arch_mcs_spin_unlock_contended implies smp-barrier */
+	arch_mcs_spin_unlock_contended(&mcs_head->locked);
+}
+
+static inline bool has_other_nodes(struct qspinlock *lock,
+				   struct numa_qnode *qnode)
+{
+	struct lock_metadata *lock_meta = get_meta(qnode->lock_id);
+
+	return lock_meta->tail_node != qnode->numa_node;
+}
+
+static inline bool is_node_threshold_reached(struct numa_qnode *qnode)
+{
+	return qnode->general_handoffs > hqlock_fairness_threshold;
+}
+
+static inline void hqlock_handoff(struct qspinlock *lock,
+					 struct mcs_spinlock *node,
+					 struct mcs_spinlock *next, u32 tail,
+					 int handoff_info)
+{
+	struct numa_qnode *qnode = (void *)node;
+	u16 lock_id = qnode->lock_id;
+	struct lock_metadata *lock_meta = get_meta(lock_id);
+	struct numa_queue *queue = get_local_queue(qnode);
+
+	if (handoff_info == HQLOCK_HANDOFF_LOCAL) {
+		if (!next)
+			next = smp_cond_load_relaxed(&node->next, (VAL));
+		WRITE_ONCE(queue->head, (void *) next);
+
+		bool threshold_expired = is_node_threshold_reached(qnode);
+
+		if (!threshold_expired || qnode->wrong_fallback_tail) {
+			handoff_local(node, next, tail);
+			return;
+		}
+
+		u8 queue_next = READ_ONCE(queue->next_node);
+		bool has_others = has_other_nodes(lock, qnode);
+
+		/*
+		 * This check is racy, but it's ok,
+		 * because we fallback to local node in the worst case
+		 * and do not call reset_handoff_counter.
+		 * Next local contender will perform remote handoff
+		 * after next queue is properly linked
+		 */
+		if (has_others) {
+			handoff_info =
+				queue_next > 0 ? queue_next : HQLOCK_HANDOFF_LOCAL;
+		} else {
+			handoff_info = HQLOCK_HANDOFF_REMOTE_HEAD;
+		}
+
+		if (handoff_info == HQLOCK_HANDOFF_LOCAL ||
+			(handoff_info == HQLOCK_HANDOFF_REMOTE_HEAD &&
+				READ_ONCE(lock_meta->head_node) == qnode->numa_node)) {
+			/*
+			 * No other nodes have come yet, so we can clean fairness counter
+			 */
+			if (handoff_info == HQLOCK_HANDOFF_REMOTE_HEAD)
+				reset_handoff_counter(qnode);
+			handoff_local(node, next, tail);
+			return;
+		}
+	}
+
+	handoff_remote(lock, qnode, tail, handoff_info);
+	reset_handoff_counter(qnode);
+}
+
+static void __init hqlock_alloc_global_queues(void)
+{
+	int nid;
+	phys_addr_t phys_addr;
+
+	// meta_pool
+	unsigned long meta_pool_size =
+		sizeof(struct lock_metadata) * LOCK_ID_MAX;
+
+	pr_info("Init HQspinlock dynamic occupied metadata info: size = %lu B\n",
+		meta_pool_size);
+
+	phys_addr = memblock_alloc_range_nid(
+				meta_pool_size, L1_CACHE_BYTES, 0,
+				MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_NODE, false);
+
+	if (!phys_addr)
+		panic("HQspinlock dynamic occupied metadata info: allocation failure.\n");
+
+	meta_pool = phys_to_virt(phys_addr);
+	memset(meta_pool, 0, meta_pool_size);
+
+	for (int i = 0; i < LOCK_ID_MAX; i++)
+		atomic_set(&meta_pool[i].seq_counter, 0);
+
+	/* Total queues size for all buckets */
+	unsigned long queues_size =
+		LOCK_ID_MAX *
+		ALIGN(sizeof(struct numa_queue), L1_CACHE_BYTES);
+
+	pr_info("Init HQspinlock buckets metadata (per-node size = %lu B)\n",
+		queues_size);
+
+	for_each_online_node(nid) {
+		phys_addr = memblock_alloc_range_nid(
+			queues_size, L1_CACHE_BYTES, 0, MEMBLOCK_ALLOC_ACCESSIBLE,
+			nid, true);
+
+		if (!phys_addr)
+			panic("HQspinlock buckets metadata: allocation failure on node %d.\n", nid);
+
+		queue_table[nid] = phys_to_virt(phys_addr);
+		memset(queue_table[nid], 0, queues_size);
+	}
+}
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#define hq_queued_spin_lock_slowpath	pv_ops.lock.queued_spin_lock_slowpath
+#else
+void (*hq_queued_spin_lock_slowpath)(struct qspinlock *lock, u32 val) =
+		native_queued_spin_lock_slowpath;
+EXPORT_SYMBOL(hq_queued_spin_lock_slowpath);
+#endif
+
+static int numa_spinlock_flag;
+
+static int __init numa_spinlock_setup(char *str)
+{
+	if (!strcmp(str, "auto")) {
+		numa_spinlock_flag = 0;
+		return 1;
+	} else if (!strcmp(str, "on")) {
+		numa_spinlock_flag = 1;
+		return 1;
+	} else if (!strcmp(str, "off")) {
+		numa_spinlock_flag = -1;
+		return 1;
+	}
+
+	return 0;
+}
+__setup("numa_spinlock=", numa_spinlock_setup);
+
+void __hq_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+void __init hq_configure_spin_lock_slowpath(void)
+{
+	if (numa_spinlock_flag < 0)
+		return;
+
+	if (numa_spinlock_flag == 0 && (nr_node_ids < 2 ||
+		    hq_queued_spin_lock_slowpath !=
+			native_queued_spin_lock_slowpath)) {
+		if (nr_node_ids >= 2)
+			pr_emerg("HQspinlock: something went wrong while enabling\n");
+		return;
+	}
+
+	numa_spinlock_flag = 1;
+	hq_queued_spin_lock_slowpath = __hq_queued_spin_lock_slowpath;
+	pr_info("Enabling HQspinlock\n");
+	hqlock_alloc_global_queues();
+}
diff --git a/kernel/locking/hqlock_meta.h b/kernel/locking/hqlock_meta.h
new file mode 100644
index 000000000..696d03dce
--- /dev/null
+++ b/kernel/locking/hqlock_meta.h
@@ -0,0 +1,477 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GEN_HQ_SPINLOCK_SLOWPATH
+#error "Do not include this file!"
+#endif
+
+/* Lock metadata pool */
+static struct lock_metadata *meta_pool;
+
+static inline struct lock_metadata *get_meta(u16 lock_id)
+{
+	return &meta_pool[lock_id];
+}
+
+static inline hqlock_mode_t set_lock_mode(struct qspinlock *lock, int __val, u16 lock_id)
+{
+	u32 val = (u32)__val;
+	u32 new_val = 0;
+	u32 lock_mode = encode_lock_mode(lock_id);
+
+	while (!(val & _Q_LOCK_MODE_MASK)) {
+		/*
+		 * We need wait until pending is gone.
+		 * Otherwise, clearing pending can erase a NUMA mode we will set here
+		 */
+		if (val & _Q_PENDING_VAL) {
+			val = atomic_cond_read_relaxed(&lock->val, !(VAL & _Q_PENDING_VAL));
+
+			if (val & _Q_LOCK_MODE_MASK)
+				return LOCK_NO_MODE;
+		}
+
+		/*
+		 * If we are enabling NUMA-awareness, we should keep previous value in lock->tail
+		 * in case of having contenders seen LOCK_MODE_QSPINLOCK and set their tails via xchg_tail
+		 * (They will restore it to _Q_LOCK_INVALID_TAIL later).
+		 * If we are setting LOCK_MODE_QSPINLOCK, remove _Q_LOCK_INVALID_TAIL
+		 */
+		if (lock_id != LOCK_ID_NONE)
+			new_val = val | lock_mode;
+		else
+			new_val = (val & ~_Q_LOCK_INVALID_TAIL) | lock_mode;
+
+		/*
+		 * If we're setting LOCK_MODE_HQLOCK, make sure all "seq_counter"
+		 * updates (per-queue, lock_meta) are observed before lock mode update.
+		 * Paired with smp_rmb() in setup_lock_mode().
+		 */
+		if (lock_id != LOCK_ID_NONE)
+			smp_wmb();
+
+		bool updated = atomic_try_cmpxchg_relaxed(&lock->val, &val, new_val);
+
+		if (updated) {
+			return (lock_id == LOCK_ID_NONE) ?
+				LOCK_MODE_QSPINLOCK : LOCK_MODE_HQLOCK;
+		}
+	}
+
+	return LOCK_NO_MODE;
+}
+
+static inline hqlock_mode_t set_mode_hqlock(struct qspinlock *lock, int val, u16 lock_id)
+{
+	return set_lock_mode(lock, val, lock_id);
+}
+
+static inline hqlock_mode_t set_mode_qspinlock(struct qspinlock *lock, int val)
+{
+	return set_lock_mode(lock, val, LOCK_ID_NONE);
+}
+
+/* Dynamic lock-mode conditions */
+static inline bool is_mode_hqlock(int val)
+{
+	return decode_lock_mode(val) == LOCK_MODE_HQLOCK;
+}
+
+static inline bool is_mode_qspinlock(int val)
+{
+	return decode_lock_mode(val) == LOCK_MODE_QSPINLOCK;
+}
+
+enum meta_status {
+	META_CONFLICT = 0,
+	META_GRABBED,
+	META_SHARED,
+};
+
+static inline enum meta_status grab_lock_meta(struct qspinlock *lock, u32 lock_id, u32 *seq)
+{
+	int nid, seq_counter;
+	struct qspinlock *old = READ_ONCE(meta_pool[lock_id].lock_ptr);
+
+	if (old && old != lock)
+		return META_CONFLICT;
+
+	if (old && old == lock)
+		return META_SHARED;
+
+	old = cmpxchg_acquire(&meta_pool[lock_id].lock_ptr, NULL, lock);
+	if (!old)
+		goto init_meta;
+
+	/* Hash-conflict */
+	if (old != lock)
+		return META_CONFLICT;
+
+	return META_SHARED;
+init_meta:
+	/*
+	 * Update allocations counter and set it to per-NUMA queues
+	 * to prevent upcomming contenders from parking on deallocated queues
+	 */
+	seq_counter = atomic_inc_return_relaxed(&meta_pool[lock_id].seq_counter);
+
+	/* Very unlikely we can overflow */
+	if (unlikely(seq_counter == 0))
+		seq_counter = atomic_inc_return_relaxed(&meta_pool[lock_id].seq_counter);
+
+	for_each_online_node(nid) {
+		struct numa_queue *queue = &queue_table[nid][lock_id];
+		WRITE_ONCE(queue->seq_counter, (u32)seq_counter);
+	}
+
+	*seq = seq_counter;
+#ifdef CONFIG_HQSPINLOCKS_DEBUG
+	int current_used = atomic_inc_return_relaxed(&cur_buckets_in_use);
+
+	if (READ_ONCE(max_buckets_in_use) < current_used)
+		WRITE_ONCE(max_buckets_in_use, current_used);
+#endif
+	return META_GRABBED;
+}
+
+/*
+ * Try to setup current lock mode:
+ *
+ * LOCK_MODE_HQLOCK or fallback to default LOCK_MODE_QSPINLOCK
+ * if there's hash conflict with another lock in the system.
+ *
+ * In general the setup consists of grabbing lock-related metadata and
+ * publishing the mode in the global lock variable.
+ *
+ * For quick meta-lookup the pointer hashing is used.
+ *
+ * To identify "occupied/free" metadata record, we use "meta->lock_ptr"
+ * which is set to corresponding spinlock lock pointer or "NULL".
+ *
+ * The action sequence from initial state is the following:
+ *
+ * "Find lock-meta by hash" => "Occupy lock-meta" => publish "LOCK_MODE_HQLOCK" in
+ * global lock variable.
+ *
+ */
+static inline
+hqlock_mode_t setup_lock_mode(struct qspinlock *lock, u16 lock_id, u32 *meta_seq_counter)
+{
+	hqlock_mode_t mode;
+
+	do {
+		enum meta_status status;
+		int val = atomic_read(&lock->val);
+
+		if (is_mode_hqlock(val)) {
+			struct lock_metadata *lock_meta = get_meta(lock_id);
+			/*
+			 * The lock is currently in LOCK_MODE_HQLOCK, we need to make sure the
+			 * associated metadata isn't used by another lock.
+			 *
+			 * In the meanwhile several situations can occur:
+			 *
+			 * [Case 1] Another lock using the meta (hash-conflict)
+			 *
+			 * If "release + reallocate" of the meta happenned in the meanwhile,
+			 * we're guaranteed to observe lock-mode change in the "lock->val",
+			 * due to the following event ordering:
+			 *
+			 * [release_lock_meta]
+			 *	Clear lock mode in "lock->val", so we wouldn't
+			 *	observe LOCK_MODE_HQLOCK mode.
+			 *	=>
+			 *        [setup_lock_mode]
+			 *	    Update lock->seq_counter
+			 *
+			 * [Case 2] For exact same lock, some contender did "release + reallocate" of the meta
+			 *
+			 * Either We'll get newly set "seq_counter", or in the worst case, we'll get
+			 * outdated "seq_counter" fail in the CAS(queue) in the caller function.
+			 *
+			 * [Case 3] Meta is free, nobody using it
+			 * [Case 4] The lock mode is changed to LOCK_MODE_QSPINLOCK.
+			 */
+			int seq_counter = atomic_read(&lock_meta->seq_counter);
+
+			/*
+			 * "seq_counter" and "lock->val" should be read in program order.
+			 * Otherwise we might observe "seq_counter" updated on-behalf another lock.
+			 * Paired with smp_wmb() in set_lock_mode().
+			 */
+			smp_rmb();
+			val = atomic_read(&lock->val);
+
+			if (is_mode_hqlock(val)) {
+				*meta_seq_counter = (u32)seq_counter;
+				return LOCK_MODE_HQLOCK;
+			}
+			/*
+			 * [else] Here it can be 2 options:
+			 *
+			 * 1. Lock-meta is free, and nobody using it.
+			 *    In this case, we need to try occupying the meta and
+			 *    publish lock-mode LOCK_MODE_HQLOCK again.
+			 *
+			 * 2. Lock mode transitioned to LOCK_MODE_QSPINLOCK mode.
+			 */
+			continue;
+		} else if (is_mode_qspinlock(val)) {
+			return LOCK_MODE_QSPINLOCK;
+		}
+
+		/*
+		 * Trying to get temporary metadata "weak" ownership,
+		 * Three situations might happen:
+		 *
+		 * 1. Metadata isn't used by anyone
+		 *    Just take the ownership.
+		 *
+		 * 2. Metadata is already grabbed by one of the lock contenders.
+		 *
+		 * 3. Hash conflict: metadata is owned by another lock
+		 *    Give up, fallback to LOCK_MODE_QSPINLOCK.
+		 */
+		status = grab_lock_meta(lock, lock_id, meta_seq_counter);
+		if (status == META_SHARED) {
+			/*
+			 * Someone started publishing lock_id for us:
+			 * 1. We can catch the "LOCK_MODE_HQLOCK" mode quickly
+			 * 2. We can loop several times before we'll see "LOCK_MODE_HQLOCK" mode set.
+			 * (lightweight check)
+			 * 3. Another contender might be able to relase lock meta meanwhile.
+			 * Either we catch it in above "seq_counter" check, or we'll grab
+			 * lock meta first and try publishing lock_id.
+			 */
+			continue;
+		}
+
+		/* Setup the lock-mode */
+		if (status == META_GRABBED)
+			mode = set_mode_hqlock(lock, val, lock_id);
+		else if (status == META_CONFLICT)
+			mode = set_mode_qspinlock(lock, val);
+		else
+			BUG_ON(1);
+		/*
+		 * If we grabbed the meta but were unable to publish LOCK_MODE_HQLOCK
+		 * release it, just by resetting the pointer.
+		 */
+		if (status == META_GRABBED && mode != LOCK_MODE_HQLOCK) {
+			smp_store_release(&meta_pool[lock_id].lock_ptr, NULL);
+#ifdef CONFIG_HQSPINLOCKS_DEBUG
+			atomic_dec(&cur_buckets_in_use);
+#endif
+		}
+	} while (mode == LOCK_NO_MODE);
+
+	return mode;
+}
+
+static inline void release_lock_meta(struct qspinlock *lock,
+					struct lock_metadata *meta,
+				     struct numa_qnode *qnode)
+{
+	int nid;
+	bool cleared = false;
+	u32 upd_val = _Q_LOCKTYPE_VAL | _Q_LOCKED_VAL;
+	u16 lock_id = qnode->lock_id;
+	int seq_counter = atomic_read(&meta->seq_counter);
+
+	/*
+	 * Firstly, go across per-NUMA queues and set seq counter to 0,
+	 * it will prevent possible contenders, which haven't even queued locally,
+	 * from using already deoccupied metadata.
+	 *
+	 * We need to perform counter reset with CAS,
+	 * because local contenders (we didn't see them while try_clear_lock_tail and try_clear_queue_tail)
+	 * may have appeared while we were coming that point.
+	 *
+	 * If any CAS is not successful, it means someone has already queued locally,
+	 * in that case we should restore usability of all local queues
+	 * and return seq counter to every per-NUMA queue.
+	 *
+	 * If all CASes are successful, nobody will queue on this metadata's queues,
+	 * and we can free it and allow other locks to use it.
+	 */
+
+	/*
+	 * Before metadata release read every queue tail,
+	 * if we have at least one contender, don't do CASes and leave
+	 * (Reads are much faster and also prefetch local queue's cachelines)
+	 */
+	for_each_online_node(nid) {
+		struct numa_queue *queue = get_queue(lock_id, nid + 1);
+
+		if (READ_ONCE(queue->tail) != 0)
+			return;
+	}
+
+	for_each_online_node(nid) {
+		struct numa_queue *queue = get_queue(lock_id, nid + 1);
+
+		if (cmpxchg_relaxed(&queue->seq_counter_tail, encode_tc(0, seq_counter), 0)
+			!= encode_tc(0, seq_counter))
+			/* Some contender arrived - rollback */
+			goto do_rollback;
+	}
+
+#ifdef CONFIG_HQSPINLOCKS_DEBUG
+	atomic_dec(&cur_buckets_in_use);
+#endif
+	/*
+	 * We need wait until pending is gone.
+	 * Otherwise, clearing pending can erase a mode we will set here
+	 */
+	while (!cleared) {
+		u32 old_lock_val = atomic_cond_read_relaxed(&lock->val, !(VAL & _Q_PENDING_VAL));
+
+		cleared = atomic_try_cmpxchg_relaxed(&lock->val,
+				&old_lock_val, upd_val | (old_lock_val & _Q_TAIL_MASK));
+	}
+
+	/*
+	 * guarantee current seq counter is erased from every local queue
+	 * and lock mode has been updated before another lock can use metadata
+	 */
+	smp_store_release(&meta_pool[qnode->lock_id].lock_ptr, NULL);
+	return;
+
+do_rollback:
+	for_each_online_node(nid) {
+		struct numa_queue *queue = get_queue(lock_id, nid + 1);
+		WRITE_ONCE(queue->seq_counter, seq_counter);
+	}
+}
+
+/*
+ * Call it if we observe LOCK_MODE_QSPINLOCK.
+ *
+ * We can do generic xchg_tail in this case,
+ * if lock's mode has already been changed, we will get _Q_LOCK_INVALID_TAIL.
+ *
+ * If we have such a situation, we perform CAS cycle
+ * to restore _Q_LOCK_INVALID_TAIL or wait until lock's mode is LOCK_MODE_QSPINLOCK.
+ *
+ * All upcomming confused contenders will see valid tail.
+ * We will remember the last one before successful CAS and put its tail in local queue.
+ * During handoff we will notify them about mode change via qnext->wrong_fallback_tail
+ */
+static inline bool try_update_tail_qspinlock_mode(struct qspinlock *lock, u32 tail, u32 *old_tail, u32 *next_tail)
+{
+	/*
+	 * next_tail may be tail or last cpu from previous unsuccessful call
+	 * (highly unlikely, but still)
+	 */
+	u32 xchged_tail = xchg_tail(lock, *next_tail);
+
+	if (likely(xchged_tail != _Q_LOCK_INVALID_TAIL)) {
+		*old_tail = xchged_tail;
+		return true;
+	}
+
+	/*
+	 * If we got _Q_LOCK_INVALID_TAIL, it means lock was not in LOCK_MODE_QSPINLOCK.
+	 * In this case we should restore _Q_LOCK_INVALID_TAIL
+	 * and remember next contenders that got confused.
+	 * Later we will update lock's or local queue's tail to the last contender seen here.
+	 */
+	u32 val = atomic_read(&lock->val);
+
+	bool fixed = false;
+
+	while (!fixed) {
+		if (decode_lock_mode(val) == LOCK_MODE_QSPINLOCK) {
+			*old_tail = 0;
+			return true;
+		}
+
+		/*
+		 * CAS is needed here to catch possible lock mode change
+		 * from LOCK_MODE_HQLOCK to LOCK_MODE_QSPINLOCK in the meanwhile.
+		 * Thus preventing from publishing _Q_LOCK_INVALID_TAIL
+		 * when LOCK_MODE_QSPINLOCK is enabled.
+		 */
+		fixed = atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCK_INVALID_TAIL |
+				(val & (_Q_LOCKED_PENDING_MASK | _Q_LOCK_TYPE_MODE_MASK)));
+	}
+
+	if ((val & _Q_TAIL_MASK) != tail)
+		*next_tail = val & _Q_TAIL_MASK;
+
+	return false;
+}
+
+/*
+ * Call it if we observe LOCK_MODE_HQLOCK or LOCK_NO_MODE in the lock.
+ *
+ * Actions performed:
+ * - Call setup_lock_mode to set or read lock's mode,
+ *   read metadata's sequential counter for valid local queueing
+ * - CAS on union of local tail and meta_seq_counter
+ *   to guarantee metadata usage correctness.
+ *   Repeat from the beginning if fail.
+ * - If we are the first local contender,
+ *   update global tail with our NUMA node
+ */
+static inline bool try_update_tail_hqlock_mode(struct qspinlock *lock, u16 lock_id,
+				struct numa_qnode *qnode, u32 tail, u32 *next_tail, u32 *old_tail)
+{
+	u32 meta_seq_counter;
+	hqlock_mode_t mode;
+
+	struct numa_queue *queue;
+	u64 old_counter_tail;
+	bool updated_queue_tail = false;
+
+re_setup:
+	mode = setup_lock_mode(lock, lock_id, &meta_seq_counter);
+
+	if (mode == LOCK_MODE_QSPINLOCK)
+		return false;
+
+	queue = get_local_queue(qnode);
+
+	/*
+	 * While queueing locally, perform CAS cycle
+	 * on union of tail and meta_seq_counter.
+	 *
+	 * meta_seq_counter is taken from the lock metadata while allocation,
+	 * it's updated every time it's used by a next lock.
+	 * It shows that queue is used correctly
+	 * and metadata hasn't been deoccupied before we queued locally.
+	 */
+	old_counter_tail = READ_ONCE(queue->seq_counter_tail);
+
+	while (!updated_queue_tail &&
+		   decode_tc_counter(old_counter_tail) == meta_seq_counter) {
+		updated_queue_tail =
+			try_cmpxchg_relaxed(&queue->seq_counter_tail, &old_counter_tail,
+				encode_tc((*next_tail) >> _Q_TAIL_OFFSET, meta_seq_counter));
+	}
+
+	/* queue->seq_counter changed */
+	if (!updated_queue_tail)
+		goto re_setup;
+
+	/*
+	 * The condition means we tried to perform generic tail update in try_update_tail_qspinlock_mode,
+	 * but before we did it, lock type was changed.
+	 * Moreover, some contenders have come after us in LOCK_MODE_QSPINLOCK,
+	 * during handoff we must notify them that they are set in LOCK_MODE_HQLOCK in our node's local queue
+	 */
+	if (unlikely(*next_tail != tail))
+		qnode->wrong_fallback_tail = *next_tail >> _Q_TAIL_OFFSET;
+
+	*old_tail = decode_tc_tail(old_counter_tail);
+
+	if (!(*old_tail)) {
+		u8 prev_node_id;
+
+		init_queue(qnode);
+		prev_node_id = append_node_queue(lock_id, qnode->numa_node);
+		*old_tail = prev_node_id ? Q_NEW_NODE_QUEUE : 0;
+	} else {
+		*old_tail <<= _Q_TAIL_OFFSET;
+	}
+
+	return true;
+}
diff --git a/kernel/locking/hqlock_proc.h b/kernel/locking/hqlock_proc.h
new file mode 100644
index 000000000..5e9ed0446
--- /dev/null
+++ b/kernel/locking/hqlock_proc.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GEN_HQ_SPINLOCK_SLOWPATH
+#error "Do not include this file!"
+#endif
+
+#include <linux/sysctl.h>
+
+/*
+ * Local handoffs threshold to maintain global fairness,
+ * perform remote handoff if it's reached
+ */
+unsigned long hqlock_fairness_threshold = 1000;
+
+/*
+ * Minimal amount of handoffs in LOCK_MODE_QSPINLOCK
+ * to enable NUMA-awareness
+ */
+unsigned long hqlock_general_handoffs_turn_numa = 50;
+
+static unsigned long long_zero;
+static unsigned long long_max = LONG_MAX;
+
+static const struct ctl_table hqlock_settings[] = {
+	{
+		.procname		= "hqlock_fairness_threshold",
+		.data			= &hqlock_fairness_threshold,
+		.maxlen			= sizeof(hqlock_fairness_threshold),
+		.mode			= 0644,
+		.proc_handler	= proc_doulongvec_minmax
+	},
+	{
+		.procname		= "hqlock_general_handoffs_turn_numa",
+		.data			= &hqlock_general_handoffs_turn_numa,
+		.maxlen			= sizeof(hqlock_general_handoffs_turn_numa),
+		.mode			= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &long_zero,
+		.extra2		= &long_max,
+	},
+};
+static int __init init_numa_spinlock_sysctl(void)
+{
+	if (!register_sysctl("kernel", hqlock_settings))
+		return -EINVAL;
+	return 0;
+}
+core_initcall(init_numa_spinlock_sysctl);
+
+
+#ifdef CONFIG_HQSPINLOCKS_DEBUG
+static int max_buckets_in_use;
+static int max_general_handoffs;
+static atomic_t cur_buckets_in_use = ATOMIC_INIT(0);
+
+static int print_hqlock_stats(struct seq_file *file, void *v)
+{
+	seq_printf(file, "Max dynamic metada in use after previous print: %d\n",
+		   READ_ONCE(max_buckets_in_use));
+	WRITE_ONCE(max_buckets_in_use, 0);
+
+	seq_printf(file, "Max MCS handoffs after previous print: %d\n",
+		   READ_ONCE(max_general_handoffs));
+	WRITE_ONCE(max_general_handoffs, 0);
+
+	return 0;
+}
+
+
+static int stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, print_hqlock_stats, NULL);
+}
+
+static const struct proc_ops stats_ops = {
+	.proc_open  = stats_open,
+	.proc_read  = seq_read,
+	.proc_lseek = seq_lseek,
+};
+
+static int __init stats_init(void)
+{
+	proc_create("hqlock_stats", 0444, NULL, &stats_ops);
+	return 0;
+}
+
+core_initcall(stats_init);
+
+#endif // HQSPINLOCKS_DEBUG
diff --git a/kernel/locking/hqlock_types.h b/kernel/locking/hqlock_types.h
new file mode 100644
index 000000000..50eda3fde
--- /dev/null
+++ b/kernel/locking/hqlock_types.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GEN_HQ_SPINLOCK_SLOWPATH
+#error "Do not include this file!"
+#endif
+
+#define IRQ_NODE (MAX_NUMNODES + 1)
+#define Q_NEW_NODE_QUEUE 1
+#define LOCK_ID_BITS		(12)
+
+#define LOCK_ID_MAX			(1 << LOCK_ID_BITS)
+#define LOCK_ID_NONE		(LOCK_ID_MAX + 1)
+
+#define _QUEUE_TAIL_MASK (((1ULL << 32) - 1) << 0)
+#define _QUEUE_SEQ_COUNTER_MASK (((1ULL << 32) - 1) << 32)
+
+/*
+ * Output code for handoff-logic:
+ *
+ * ==  0 (HQLOCK_HANDOFF_LOCAL) - has local nodes to handoff
+ *  >  0 - has remote node to handoff, id is visible
+ * == -1 (HQLOCK_HANDOFF_REMOTE_HEAD) - has remote node to handoff,
+ *         id isn't visible yet, will be in the *lock->head_node*
+ */
+enum {
+	HQLOCK_HANDOFF_LOCAL = 0,
+	HQLOCK_HANDOFF_REMOTE_HEAD = -1
+};
+
+typedef enum {
+	LOCK_NO_MODE = 0,
+	LOCK_MODE_QSPINLOCK = 1,
+	LOCK_MODE_HQLOCK = 2,
+} hqlock_mode_t;
+
+struct numa_qnode {
+	struct mcs_spinlock mcs;
+
+	u16 lock_id;
+	u16 wrong_fallback_tail;
+	u16 general_handoffs;
+
+	u8 numa_node;
+};
+
+struct numa_queue {
+	struct numa_qnode *head;
+	union {
+		u64 seq_counter_tail;
+		struct {
+			u32 tail;
+			u32 seq_counter;
+		};
+	};
+
+	u8 next_node;
+	u8 prev_node;
+
+	u16 handoffs_not_head;
+} ____cacheline_aligned;
+
+/**
+ * Lock metadata
+ * "allocated"/"freed" on demand.
+ *
+ * Used to dynamically bind numa_queue to a lock,
+ * maintain FIFO-order for the NUMA-queues.
+ *
+ * seq_counter is needed to distinguish metadata usage
+ * by different locks, preventing local contenders
+ * from queueing in the wrong per-NUMA queue
+ *
+ * @see set_bucket
+ * @see numa_xchg_tail
+ */
+struct lock_metadata {
+	atomic_t seq_counter;
+	struct qspinlock *lock_ptr;
+
+	/* NUMA-queues of contenders ae kept in FIFO order */
+	union {
+		u16 nodes_tail;
+		struct {
+			u8 tail_node;
+			u8 head_node;
+		};
+	};
+};
+
+static inline int decode_lock_mode(u32 lock_val)
+{
+	return (lock_val & _Q_LOCK_MODE_MASK) >> _Q_LOCK_MODE_OFFSET;
+}
+
+static inline u32 encode_lock_mode(u16 lock_id)
+{
+	if (lock_id == LOCK_ID_NONE)
+		return LOCK_MODE_QSPINLOCK << _Q_LOCK_MODE_OFFSET;
+
+	return LOCK_MODE_HQLOCK << _Q_LOCK_MODE_OFFSET;
+}
+
+static inline u64 encode_tc(u32 tail, u32 counter)
+{
+	u64 __tail = (u64)tail;
+	u64 __counter = (u64)counter;
+
+	return __tail | (__counter << 32);
+}
+
+static inline u32 decode_tc_tail(u64 tail_counter)
+{
+	return (u32)(tail_counter & _QUEUE_TAIL_MASK);
+}
+
+static inline u32 decode_tc_counter(u64 tail_counter)
+{
+	return (u32)((tail_counter & _QUEUE_SEQ_COUNTER_MASK) >> 32);
+}
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index af8d122bb..3edf25402 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -11,7 +11,7 @@
  *          Peter Zijlstra <peterz@infradead.org>
  */
 
-#ifndef _GEN_PV_LOCK_SLOWPATH
+#if !defined(_GEN_PV_LOCK_SLOWPATH) && !defined(_GEN_HQ_SPINLOCK_SLOWPATH)
 
 #include <linux/smp.h>
 #include <linux/bug.h>
@@ -100,7 +100,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 #define pv_kick_node		__pv_kick_node
 #define pv_wait_head_or_lock	__pv_wait_head_or_lock
 
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) || defined(CONFIG_HQSPINLOCKS)
 #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
 #endif
 
@@ -133,6 +133,11 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	u32 old, tail;
 	int idx;
 
+#if defined(_GEN_HQ_SPINLOCK_SLOWPATH) && !defined(_GEN_PV_LOCK_SLOWPATH)
+	bool is_numa_lock = val & _Q_LOCKTYPE_MASK;
+	bool numa_awareness_on = is_numa_lock && !(val & _Q_LOCK_MODE_QSPINLOCK_VAL);
+#endif
+
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
 	if (pv_enabled())
@@ -147,16 +152,16 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *
 	 * 0,1,0 -> 0,0,1
 	 */
-	if (val == _Q_PENDING_VAL) {
+	if ((val & ~_Q_SERVICE_MASK) == _Q_PENDING_VAL) {
 		int cnt = _Q_PENDING_LOOPS;
 		val = atomic_cond_read_relaxed(&lock->val,
-					       (VAL != _Q_PENDING_VAL) || !cnt--);
+						((VAL & ~_Q_SERVICE_MASK) != _Q_PENDING_VAL) || !cnt--);
 	}
 
 	/*
 	 * If we observe any contention; queue.
 	 */
-	if (val & ~_Q_LOCKED_MASK)
+	if (val & ~(_Q_LOCKED_MASK | _Q_SERVICE_MASK))
 		goto queue;
 
 	/*
@@ -173,11 +178,15 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
 	 * on @next to become !NULL.
 	 */
-	if (unlikely(val & ~_Q_LOCKED_MASK)) {
-
+	if (unlikely(val & ~(_Q_LOCKED_MASK | _Q_SERVICE_MASK))) {
 		/* Undo PENDING if we set it. */
-		if (!(val & _Q_PENDING_MASK))
+		if (!(val & _Q_PENDING_VAL)) {
+#if defined(_GEN_HQ_SPINLOCK_SLOWPATH) && !defined(_GEN_PV_LOCK_SLOWPATH)
+			hqlock_clear_pending(lock, val);
+#else
 			clear_pending(lock);
+#endif
+		}
 
 		goto queue;
 	}
@@ -194,14 +203,18 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * barriers.
 	 */
 	if (val & _Q_LOCKED_MASK)
-		smp_cond_load_acquire(&lock->locked, !VAL);
+		smp_cond_load_acquire(&lock->locked_pending, !(VAL & _Q_LOCKED_MASK));
 
 	/*
 	 * take ownership and clear the pending bit.
 	 *
 	 * 0,1,0 -> 0,0,1
 	 */
+#if defined(_GEN_HQ_SPINLOCK_SLOWPATH) && !defined(_GEN_PV_LOCK_SLOWPATH)
+	hqlock_clear_pending_set_locked(lock, val);
+#else
 	clear_pending_set_locked(lock);
+#endif
 	lockevent_inc(lock_pending);
 	return;
 
@@ -274,7 +287,17 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *
 	 * p,*,* -> n,*,*
 	 */
+#if defined(_GEN_HQ_SPINLOCK_SLOWPATH) && !defined(_GEN_PV_LOCK_SLOWPATH)
+	if (is_numa_lock)
+		old = hqlock_xchg_tail(lock, tail, node, &numa_awareness_on);
+	else
+		old = xchg_tail(lock, tail);
+
+	if (numa_awareness_on && old == Q_NEW_NODE_QUEUE)
+		goto mcs_spin;
+#else
 	old = xchg_tail(lock, tail);
+#endif
 	next = NULL;
 
 	/*
@@ -288,6 +311,9 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		WRITE_ONCE(prev->next, node);
 
 		pv_wait_node(node, prev);
+#if defined(_GEN_HQ_SPINLOCK_SLOWPATH) && !defined(_GEN_PV_LOCK_SLOWPATH)
+mcs_spin:
+#endif
 		arch_mcs_spin_lock_contended(&node->locked);
 
 		/*
@@ -349,6 +375,12 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 *       above wait condition, therefore any concurrent setting of
 	 *       PENDING will make the uncontended transition fail.
 	 */
+#if defined(_GEN_HQ_SPINLOCK_SLOWPATH) && !defined(_GEN_PV_LOCK_SLOWPATH)
+	if (is_numa_lock) {
+		hqlock_clear_tail_handoff(lock, val, tail, node, next, prev, numa_awareness_on);
+		goto release;
+	}
+#endif
 	if ((val & _Q_TAIL_MASK) == tail) {
 		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
 			goto release; /* No contention */
@@ -380,6 +412,21 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
+/* Generate the code for NUMA-aware qspinlock (HQspinlock) */
+#if !defined(_GEN_HQ_SPINLOCK_SLOWPATH) && defined(CONFIG_HQSPINLOCKS)
+#define _GEN_HQ_SPINLOCK_SLOWPATH
+
+#undef pv_init_node
+#define pv_init_node		hqlock_init_node
+
+#undef  queued_spin_lock_slowpath
+#include "hqlock_core.h"
+#define queued_spin_lock_slowpath	__hq_queued_spin_lock_slowpath
+
+#include "qspinlock.c"
+
+#endif
+
 /*
  * Generate the paravirt code for queued_spin_unlock_slowpath().
  */
@@ -407,4 +454,4 @@ static __init int parse_nopvspin(char *arg)
 	return 0;
 }
 early_param("nopvspin", parse_nopvspin);
-#endif
+#endif
\ No newline at end of file
diff --git a/kernel/locking/qspinlock.h b/kernel/locking/qspinlock.h
index d69958a84..9933e0e66 100644
--- a/kernel/locking/qspinlock.h
+++ b/kernel/locking/qspinlock.h
@@ -39,7 +39,7 @@
  */
 struct qnode {
 	struct mcs_spinlock mcs;
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) || defined(CONFIG_HQSPINLOCKS)
 	long reserved[2];
 #endif
 };
@@ -74,7 +74,7 @@ struct mcs_spinlock *grab_mcs_node(struct mcs_spinlock *base, int idx)
 	return &((struct qnode *)base + idx)->mcs;
 }
 
-#define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
+#define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_VAL)
 
 #if _Q_PENDING_BITS == 8
 /**
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 87b03d2e4..5abfd96de 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -30,6 +30,26 @@ void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 	lock->owner_cpu = -1;
 }
 
+void __raw_spin_lock_init_hq(raw_spinlock_t *lock, const char *name,
+			  struct lock_class_key *key, short inner)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/*
+	 * Make sure we are not reinitializing a held lock:
+	 */
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lockdep_init_map_wait(&lock->dep_map, name, key, 0, inner);
+#endif
+#ifdef __ARCH_SPIN_LOCK_UNLOCKED_HQ
+	lock->raw_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED_HQ;
+#else
+	lock->raw_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+#endif
+	lock->magic = SPINLOCK_MAGIC;
+	lock->owner = SPINLOCK_OWNER_INIT;
+	lock->owner_cpu = -1;
+}
+
 EXPORT_SYMBOL(__raw_spin_lock_init);
 
 #ifndef CONFIG_PREEMPT_RT
-- 
2.34.1


