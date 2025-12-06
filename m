Return-Path: <linux-arch+bounces-15292-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627BCA98DD
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 23:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E173730351B7
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 22:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79E2F39C9;
	Fri,  5 Dec 2025 22:58:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488CB2F12B5;
	Fri,  5 Dec 2025 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975502; cv=none; b=CgKZ9TocHh7ns/rEPsQbVTaWCW4i952CYkXxI8B1aEz4g2cNDqJQdx2Nzdp3YA/ZcVP0J8I40mgYpad612t6K58K5Qh+xo2PB2QvCZrSliAvfYsQrfLmbP3o2mY6Ax/uC16wDVMvxoi71v1pBJTtEg/tE864x1SqfjLDOBEQ8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975502; c=relaxed/simple;
	bh=Oej//3xkb7F0S5mQmhbIpx5d37AVgEDfC/7X7i75vjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7lqCqRJPX7qWG024y3Oz4Fex5xCWunFhp0oAbeaN0fS+45SFdGX3sHZKDT+snfA2vFwBw2La/rV9fGJo3BRNKJd7ZWNczlr7iVZERfuQoBfy+G3vhIdtU5jK8Gcl69HhljWNqBib2QeSw7417pRzowX56pYSmMaDIWGj4LN7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dNRBh0cVCzHnGfG;
	Sat,  6 Dec 2025 06:39:24 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 7894B40569;
	Sat,  6 Dec 2025 06:39:26 +0800 (CST)
Received: from localhost.localdomain (10.123.70.40) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 6 Dec 2025 01:39:25 +0300
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
Subject: [RFC PATCH v2 3/5] kernel: introduce general hq-lock support
Date: Sat, 6 Dec 2025 14:21:04 +0800
Message-ID: <20251206062106.2109014-4-stepanov.anatoly@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251206062106.2109014-1-stepanov.anatoly@huawei.com>
References: <aad84044-a9d3-4806-a966-4770a3634b03@redhat.com>
 <20251206062106.2109014-1-stepanov.anatoly@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

- Kernel config
- Required macros
- PV-locks support
- HQ-lock type/mode masking support in generic code
- Integrate hq-lock into queued spinlock slowpath

Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>

Co-authored-by: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Co-authored-by: Fedorov Nikita <fedorov.nikita@h-partners.com>
---
 arch/arm64/include/asm/qspinlock.h    | 37 +++++++++++++++
 arch/x86/include/asm/qspinlock.h      | 38 +++++++++++++++-
 include/asm-generic/qspinlock.h       | 23 ++++++----
 include/asm-generic/qspinlock_types.h | 54 +++++++++++++++++++---
 include/linux/spinlock.h              | 26 +++++++++++
 include/linux/spinlock_types.h        | 26 +++++++++++
 include/linux/spinlock_types_raw.h    | 20 +++++++++
 init/main.c                           |  4 ++
 kernel/Kconfig.locks                  | 29 ++++++++++++
 kernel/locking/qspinlock.c            | 65 +++++++++++++++++++++++----
 kernel/locking/qspinlock.h            |  4 +-
 kernel/locking/spinlock_debug.c       | 20 +++++++++
 12 files changed, 319 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm64/include/asm/qspinlock.h

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
index 2fd1fb89e..bb8fad876 100644
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
@@ -76,6 +81,26 @@ typedef struct qspinlock {
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
+#define _Q_LOCKTYPE_HQ			(1U << _Q_LOCKTYPE_OFFSET)
+
+#define _Q_LOCK_MODE_OFFSET	(_Q_LOCKTYPE_OFFSET + _Q_LOCKTYPE_BITS)
+#define _Q_LOCK_MODE_BITS	2
+#define _Q_LOCK_MODE_MASK	_Q_SET_MASK(LOCK_MODE)
+#define _Q_LOCK_MODE_QSPINLOCK_VAL	(1U << _Q_LOCK_MODE_OFFSET)
+
+#define _Q_LOCK_TYPE_MODE_MASK	(_Q_LOCKTYPE_MASK | _Q_LOCK_MODE_MASK)
+#endif //CONFIG_HQSPINLOCKS
+
 #define _Q_PENDING_MASK		_Q_SET_MASK(PENDING)
 
 #define _Q_TAIL_IDX_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
@@ -92,4 +117,23 @@ typedef struct qspinlock {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
+#ifdef CONFIG_HQSPINLOCKS
+#define _Q_LOCK_INVALID_TAIL	(_Q_TAIL_IDX_MASK)
+
+#define _Q_SERVICE_MASK		(_Q_LOCKTYPE_MASK | _Q_LOCK_MODE_QSPINLOCK_VAL | _Q_LOCK_INVALID_TAIL)
+#else // CONFIG_HQSPINLOCKS
+#define _Q_SERVICE_MASK		0
+#endif
+
+/*
+ * Initializier
+ */
+#define	__ARCH_SPIN_LOCK_UNLOCKED		{ { .val = ATOMIC_INIT(0) } }
+
+#ifdef CONFIG_HQSPINLOCKS
+#define	__ARCH_SPIN_LOCK_UNLOCKED_HQ	{ { .val = ATOMIC_INIT(_Q_LOCKTYPE_HQ | _Q_LOCK_MODE_QSPINLOCK_VAL) } }
+#else
+#define	__ARCH_SPIN_LOCK_UNLOCKED_HQ	{ { .val = ATOMIC_INIT(0) } }
+#endif
+
 #endif /* __ASM_GENERIC_QSPINLOCK_TYPES_H */
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
index 2dfa35ffe..4a04e648b 100644
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
+	((spinlock_t) __SPIN_LOCK_INITIALIZER_HQ(lockname))
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
index 91cb36b65..815dca784 100644
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
+	((raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER_HQ(lockname))
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
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 4198f0273..c96f3a455 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -243,6 +243,35 @@ config QUEUED_SPINLOCKS
 	def_bool y if ARCH_USE_QUEUED_SPINLOCKS
 	depends on SMP
 
+config HQSPINLOCKS
+	bool "(NUMA-aware) Hierarchical Queued spinlock"
+	depends on NUMA
+	depends on QUEUED_SPINLOCKS
+	depends on NR_CPUS < 16384
+	depends on !CPU_BIG_ENDIAN
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
 config BPF_ARCH_SPINLOCK
 	bool
 
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index af8d122bb..7feab0046 100644
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


