Return-Path: <linux-arch+bounces-7251-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88797747B
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 00:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DBC1F24052
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 22:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF101C2322;
	Thu, 12 Sep 2024 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er6P7Cmt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A5E1B6543;
	Thu, 12 Sep 2024 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181061; cv=none; b=Gk8KEMQ8zh5xEfFN2uHbATmydzUmicVzOehUYmiQffmNZAGsJGdraPnEEP5k+Mpe1367vJJAZfZcrcNaeaStYW4wFN8NBmj62Yd9JcTcDDGX9Q6zl00eBFJfaVrppl5k/eUaoYJvPzd5onUYwPE+FecgaPQ/muTSm6qBEBFuNko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181061; c=relaxed/simple;
	bh=goeYyUrG6Krx8Gj0ORYB4xMO5kZeCEHqx6/YmoxT6gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AqgJr1P/v4mfrCrd9lmZU490RQjp8kdc2NklbUEyd6+YppOSslYAoBkDtiNCrKCr5h6EvnJTFsAqi/X5LKXKI1boHHiDSJcTnlO0ZLOlTlIaWUdio125/Cqkv1TEjPlQ55UC43nc7sqne6qrerDixbqgaHdUW22TL6DPkxJGiM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er6P7Cmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D008C4CEC3;
	Thu, 12 Sep 2024 22:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726181060;
	bh=goeYyUrG6Krx8Gj0ORYB4xMO5kZeCEHqx6/YmoxT6gg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Er6P7CmtaMwQkLSWqJR2t2yKNQqZAC0TXSiCaJwh7uFA2bWueeiGKgKVrxFkk3yNb
	 CF/xi5XR2JruU5z7kKsJdp8da9MqtWIjQ6JrN8HNQAVOB2X6vA7qGbgvB7DV0kRbDZ
	 B/wz8g3hEWUBPtmx2Y8+vk/eCgXGLS0/+RMv8qPYyXG6IMNpB46Z6ZpgTlicLev09d
	 ADMiKhwwNFH4n3hYtsTdy19hyhyfqxBNQq04eMmWDRwHCgPT3azTSbjQ1JcED+ZtMA
	 QjCCMMdH6cfcce61EYxomOmutWjqc+lp5cKDqayDk0nSLPZVbkSqrJKCcvaLZQ4RPv
	 eI2j4mK+SCmCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE39EEE265;
	Thu, 12 Sep 2024 22:44:20 +0000 (UTC)
From: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>
Date: Thu, 12 Sep 2024 15:44:08 -0700
Subject: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
X-B4-Tracking: v=1; b=H4sIALdu42YC/1XMyw6CMBCF4Vchs7amDARbV76HIQbbocxCii2pF
 8K7W0lcuPxPcr4FIgWmCMdigUCJI/sxR7UrwAzd6EiwzQ0osZaqrESk+8VPM9/4TaJRplaNbsx
 BK8iXKVDPz407t7kHjrMPr01P+F1/kP6HEopSaCttp/AqEfuTo3F++L0PDtp1XT+ubb0MqQAAA
 A==
To: Thomas Gleixner <tglx@linutronix.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-arch@vger.kernel.org, "Christoph Lameter (Ampere)" <cl@gentwo.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726181060; l=10044;
 i=cl@gentwo.org; s=20240811; h=from:subject:message-id;
 bh=twHlnolUF54+RvSDVMLmtR5Su73uVeAgLsYk+Borf6U=;
 b=k97mMGYS69MnG5mKcJfc0vaBxyX3DPC5NQzKmzjEVfhZgRcKce8+kKyiWphbuR864mWRm1iVL
 K8OnoAP0EceDubpE9TYQxzxKuG2bsyvwWcpNjX2WyXW5BcLoi/fUkxr
X-Developer-Key: i=cl@gentwo.org; a=ed25519;
 pk=I7gqGwDi9drzCReFIuf2k9de1FI1BGibsshXI0DIvq8=
X-Endpoint-Received: by B4 Relay for cl@gentwo.org/20240811 with
 auth_id=194
X-Original-From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Reply-To: cl@gentwo.org

From: "Christoph Lameter (Ampere)" <cl@gentwo.org>

Some architectures support load acquire which can save us a memory
barrier and save some cycles.

A typical sequence

	do {
		seq = read_seqcount_begin(&s);
		<something>
	} while (read_seqcount_retry(&s, seq);

requires 13 cycles on ARM64 for an empty loop. Two read memory
barriers are needed. One for each of the seqcount_* functions.

We can replace the first read barrier with a load acquire of
the seqcount which saves us one barrier.

On ARM64 doing so reduces the cycle count from 13 to 8.

This is a general improvement for the ARM64 architecture and not
specific to a certain processor. The cycle count here was
obtained on a Neoverse N1 (Ampere Altra).

We can further optimize handling by using the cond_load_acquire logic
which will give an ARM CPU a chance to enter some power saving mode
while waiting for changes to a cacheline thereby avoiding busy loops
and therefore saving power.

The ARM documentation states that load acquire is more effective
than a load plus barrier. In general that tends to be true on all
compute platforms that support both.

See (as quoted by Linus Torvalds):
   https://developer.arm.com/documentation/102336/0100/Load-Acquire-and-Store-Release-instructions

 "Weaker ordering requirements that are imposed by Load-Acquire and
  Store-Release instructions allow for micro-architectural
  optimizations, which could reduce some of the performance impacts that
  are otherwise imposed by an explicit memory barrier.

  If the ordering requirement is satisfied using either a Load-Acquire
  or Store-Release, then it would be preferable to use these
  instructions instead of a DMB"

The patch benefited significantly from the knowledge of the innards
of the seqlock code by Thomas Gleixner.

Signed-off-by: Christoph Lameter (Ampere) <cl@gentwo.org>
---
V1->V2
- Describe the benefit of load acquire vs barriers
- Explain the CONFIG_ARCH_HAS_ACQUIRE_RELEASE option better
---
Changes in v3:
- Support cond_load_acquire to give the processor a chance to do some
  sort of power down until cacheline changes.
- Better code by Thomas Gleixner
- Link to v2: https://lore.kernel.org/r/20240819-seq_optimize-v2-1-9d0da82b022f@gentwo.org
---
 arch/Kconfig            |  8 +++++
 arch/arm64/Kconfig      |  1 +
 include/linux/seqlock.h | 85 ++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 71 insertions(+), 23 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..3c270f496231 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1600,6 +1600,14 @@ config ARCH_HAS_KERNEL_FPU_SUPPORT
 	  Architectures that select this option can run floating-point code in
 	  the kernel, as described in Documentation/core-api/floating-point.rst.
 
+config ARCH_HAS_ACQUIRE_RELEASE
+	bool
+	help
+	  Setting ARCH_HAS_ACQUIRE_RELEASE indicates that the architecture
+	  supports load acquire and release. Typically these are more effective
+	  than memory barriers. Code will prefer the use of load acquire and
+	  store release over memory barriers if this option is enabled.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..19e34fff145f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -39,6 +39,7 @@ config ARM64
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
+	select ARCH_HAS_ACQUIRE_RELEASE
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index d90d8ee29d81..a3fe9ee8edef 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -23,6 +23,13 @@
 
 #include <asm/processor.h>
 
+#ifdef CONFIG_ARCH_HAS_ACQUIRE_RELEASE
+# define USE_LOAD_ACQUIRE	true
+# define USE_COND_LOAD_ACQUIRE	!IS_ENABLED(CONFIG_PREEMPT_RT)
+#else
+# define USE_LOAD_ACQUIRE	false
+# define USE_COND_LOAD_ACQUIRE	false
+#endif
 /*
  * The seqlock seqcount_t interface does not prescribe a precise sequence of
  * read begin/retry/end. For readers, typically there is a call to
@@ -132,6 +139,17 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 #define seqcount_rwlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, rwlock)
 #define seqcount_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, mutex)
 
+static __always_inline unsigned __seqprop_load_sequence(const seqcount_t *s, bool acquire)
+{
+	if (!acquire || !USE_LOAD_ACQUIRE)
+		return READ_ONCE(s->sequence);
+
+	if (USE_COND_LOAD_ACQUIRE)
+		return smp_cond_load_acquire((unsigned int *)&s->sequence, (s->sequence & 1) == 0);
+
+	return smp_load_acquire(&s->sequence);
+}
+
 /*
  * SEQCOUNT_LOCKNAME()	- Instantiate seqcount_LOCKNAME_t and helpers
  * seqprop_LOCKNAME_*()	- Property accessors for seqcount_LOCKNAME_t
@@ -155,9 +173,10 @@ __seqprop_##lockname##_const_ptr(const seqcount_##lockname##_t *s)	\
 }									\
 									\
 static __always_inline unsigned						\
-__seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
+__seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s,	\
+				bool acquire)				\
 {									\
-	unsigned seq = READ_ONCE(s->seqcount.sequence);			\
+	unsigned seq = __seqprop_load_sequence(&s->seqcount, acquire);	\
 									\
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
 		return seq;						\
@@ -170,7 +189,7 @@ __seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
 		 * Re-read the sequence counter since the (possibly	\
 		 * preempted) writer made progress.			\
 		 */							\
-		seq = READ_ONCE(s->seqcount.sequence);			\
+		seq = __seqprop_load_sequence(&s->seqcount, acquire);	\
 	}								\
 									\
 	return seq;							\
@@ -206,9 +225,9 @@ static inline const seqcount_t *__seqprop_const_ptr(const seqcount_t *s)
 	return s;
 }
 
-static inline unsigned __seqprop_sequence(const seqcount_t *s)
+static inline unsigned __seqprop_sequence(const seqcount_t *s, bool acquire)
 {
-	return READ_ONCE(s->sequence);
+	return __seqprop_load_sequence(s, acquire);
 }
 
 static inline bool __seqprop_preemptible(const seqcount_t *s)
@@ -258,35 +277,53 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 
 #define seqprop_ptr(s)			__seqprop(s, ptr)(s)
 #define seqprop_const_ptr(s)		__seqprop(s, const_ptr)(s)
-#define seqprop_sequence(s)		__seqprop(s, sequence)(s)
+#define seqprop_sequence(s, a)		__seqprop(s, sequence)(s, a)
 #define seqprop_preemptible(s)		__seqprop(s, preemptible)(s)
 #define seqprop_assert(s)		__seqprop(s, assert)(s)
 
 /**
- * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
- *
- * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
- * barrier. Callers should ensure that smp_rmb() or equivalent ordering is
- * provided before actually loading any of the variables that are to be
- * protected in this critical section.
- *
- * Use carefully, only in critical code, and comment how the barrier is
- * provided.
+ * read_seqcount_begin_cond_acquire() - begin a seqcount_t read section
+ * @s:	     Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ * @acquire: If true, the read of the sequence count uses smp_load_acquire()
+ *	     if the architecure provides and enabled it.
  *
  * Return: count to be passed to read_seqcount_retry()
  */
-#define __read_seqcount_begin(s)					\
+#define read_seqcount_begin_cond_acquire(s, acquire)			\
 ({									\
 	unsigned __seq;							\
 									\
-	while ((__seq = seqprop_sequence(s)) & 1)			\
-		cpu_relax();						\
+	if (acquire && USE_COND_LOAD_ACQUIRE) {				\
+		__seq = seqprop_sequence(s, acquire);			\
+	} else {							\
+		while ((__seq = seqprop_sequence(s, acquire)) & 1)	\
+			cpu_relax();					\
+	}								\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
 	__seq;								\
 })
 
+/**
+ * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
+ * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ *
+ * __read_seqcount_begin is like read_seqcount_begin, but it neither
+ * provides a smp_rmb() barrier nor does it use smp_load_acquire() on
+ * architectures which provide it.
+ *
+ * Callers should ensure that smp_rmb() or equivalent ordering is provided
+ * before actually loading any of the variables that are to be protected in
+ * this critical section.
+ *
+ * Use carefully, only in critical code, and comment how the barrier is
+ * provided.
+ *
+ * Return: count to be passed to read_seqcount_retry()
+ */
+#define __read_seqcount_begin(s)					\
+	read_seqcount_begin_cond_acquire(s, false)
+
 /**
  * raw_read_seqcount_begin() - begin a seqcount_t read section w/o lockdep
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
@@ -295,9 +332,10 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
  */
 #define raw_read_seqcount_begin(s)					\
 ({									\
-	unsigned _seq = __read_seqcount_begin(s);			\
+	unsigned _seq = read_seqcount_begin_cond_acquire(s, true);	\
 									\
-	smp_rmb();							\
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_ACQUIRE_RELEASE))		\
+		smp_rmb();						\
 	_seq;								\
 })
 
@@ -326,9 +364,10 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
  */
 #define raw_read_seqcount(s)						\
 ({									\
-	unsigned __seq = seqprop_sequence(s);				\
+	unsigned __seq = seqprop_sequence(s, true);			\
 									\
-	smp_rmb();							\
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_ACQUIRE_RELEASE))		\
+		smp_rmb();						\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
 	__seq;								\
 })

---
base-commit: 77f587896757708780a7e8792efe62939f25a5ab
change-id: 20240813-seq_optimize-68c48696c798

Best regards,
-- 
Christoph Lameter <cl@gentwo.org>



