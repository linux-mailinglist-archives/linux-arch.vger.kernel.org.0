Return-Path: <linux-arch+bounces-6337-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4AF957346
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29D9284280
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79951187859;
	Mon, 19 Aug 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CisaNtag"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5229E136663;
	Mon, 19 Aug 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092224; cv=none; b=JHNqjpNteN+2tXb69LxOnsdu+cJXqeZwGzBBvtN8lCWZmNAMK7Fag8dSB7/+xFYMqkuXVLNCdeLgjuwGiUwIam20GBGYCOoRvqAQC0FjVsvfmlArP/Gy43B5SPVUJHWBaCkroma1dpR02SF5JFfhZ5uVMgADpHiXHz5eoK8bcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092224; c=relaxed/simple;
	bh=tSCee26JGqJNW5fxQxtynl0HcRSR8D1JgiXpOYtmgQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XKP6lv81rlzx+YNEv96DWko9s4B9YnKeuqiZuwAjqBInJSeA4xuwTsvOkgD+TGGObhgYlIZnvFBRipPQVzIvDaR6YegvvYNhAqQ4nnohPbsdRDhNdRoqd7GQ4QqlSkrO8ElBVJ/G5bq5BhtpITUDR7A+OemwzdHTDFLHwVhqVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CisaNtag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D269CC4AF0C;
	Mon, 19 Aug 2024 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724092223;
	bh=tSCee26JGqJNW5fxQxtynl0HcRSR8D1JgiXpOYtmgQE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CisaNtagHd7kzmJV3mDWmcmMsgFTgfs+tmHl8P4hdEaoMPYBULdPAkWsHEZYWMEda
	 Iakc6ZACdJudRxVuGArYNN4cP1ELKOjvPYuQpa3AQTl2Z/jp1APCMx0qGvV4yr+QNV
	 4hgKfLp8qglnaLCaoKW1PLTGGzKvQWg8Mlb9g49F6nQKNzrFfIXCgNATvK/0gVlatK
	 dkrIfUS7tNHWCesy3AI2AzQy7a/Hyr2hfFnbNHe0hWOqkI7vBjg8cG6yHzQ5PkGfRY
	 BM6i40sEcVBpG1JH+s4rC50exOg4TLN9m9RVHw0eIEqMtf20BBy5/3T6Tr8VlztScE
	 0+85NVFrK3c1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD985C52D7C;
	Mon, 19 Aug 2024 18:30:23 +0000 (UTC)
From: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>
Date: Mon, 19 Aug 2024 11:30:15 -0700
Subject: [PATCH v2] Avoid memory barrier in read_seqcount() through load
 acquire
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-seq_optimize-v2-1-9d0da82b022f@gentwo.org>
X-B4-Tracking: v=1; b=H4sIADaPw2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDC0Nj3eLUwvj8gpLM3MyqVF0zi2QTCzNLs2RzSwsloJaCotS0zAqwcdG
 xtbUA0UUVFF4AAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
 Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-arch@vger.kernel.org, "Christoph Lameter (Ampere)" <cl@gentwo.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724092223; l=5831;
 i=cl@gentwo.org; s=20240811; h=from:subject:message-id;
 bh=33u86Z1NtTj5I1hzjsT/8J5bCWwIeort9/FFXzrHRO8=;
 b=xjoqKpuJtKmVY/p7XqcrNDj6VvwsP/litDEErvD8DiwRs7UAnTdP/zYFWneATI5cWwAHPBQAe
 ONJwSIhLrBvD2MOb674/6mx5xNjsJr7TwjTFsCE/PjBfuy4IL4vKzRA
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

Signed-off-by: Christoph Lameter (Ampere) <cl@gentwo.org>
---
V1->V2
- Describe the benefit of load acquire vs barriers
- Explain the CONFIG_ARCH_HAS_ACQUIRE_RELEASE option better
---
 arch/Kconfig            |  8 ++++++++
 arch/arm64/Kconfig      |  1 +
 include/linux/seqlock.h | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

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
index d90d8ee29d81..353fcf32b800 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -176,6 +176,28 @@ __seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
 	return seq;							\
 }									\
 									\
+static __always_inline unsigned						\
+__seqprop_##lockname##_sequence_acquire(const seqcount_##lockname##_t *s) \
+{									\
+	unsigned seq = smp_load_acquire(&s->seqcount.sequence);		\
+									\
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
+		return seq;						\
+									\
+	if (preemptible && unlikely(seq & 1)) {				\
+		__SEQ_LOCK(lockbase##_lock(s->lock));			\
+		__SEQ_LOCK(lockbase##_unlock(s->lock));			\
+									\
+		/*							\
+		 * Re-read the sequence counter since the (possibly	\
+		 * preempted) writer made progress.			\
+		 */							\
+		seq = smp_load_acquire(&s->seqcount.sequence);		\
+	}								\
+									\
+	return seq;							\
+}									\
+									\
 static __always_inline bool						\
 __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
 {									\
@@ -211,6 +233,11 @@ static inline unsigned __seqprop_sequence(const seqcount_t *s)
 	return READ_ONCE(s->sequence);
 }
 
+static inline unsigned __seqprop_sequence_acquire(const seqcount_t *s)
+{
+	return smp_load_acquire(&s->sequence);
+}
+
 static inline bool __seqprop_preemptible(const seqcount_t *s)
 {
 	return false;
@@ -259,6 +286,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 #define seqprop_ptr(s)			__seqprop(s, ptr)(s)
 #define seqprop_const_ptr(s)		__seqprop(s, const_ptr)(s)
 #define seqprop_sequence(s)		__seqprop(s, sequence)(s)
+#define seqprop_sequence_acquire(s)	__seqprop(s, sequence_acquire)(s)
 #define seqprop_preemptible(s)		__seqprop(s, preemptible)(s)
 #define seqprop_assert(s)		__seqprop(s, assert)(s)
 
@@ -293,6 +321,18 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
  *
  * Return: count to be passed to read_seqcount_retry()
  */
+#ifdef CONFIG_ARCH_HAS_ACQUIRE_RELEASE
+#define raw_read_seqcount_begin(s)					\
+({									\
+	unsigned _seq;							\
+									\
+	while ((_seq = seqprop_sequence_acquire(s)) & 1)		\
+		cpu_relax();						\
+									\
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
+	_seq;								\
+})
+#else
 #define raw_read_seqcount_begin(s)					\
 ({									\
 	unsigned _seq = __read_seqcount_begin(s);			\
@@ -300,6 +340,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
 	smp_rmb();							\
 	_seq;								\
 })
+#endif
 
 /**
  * read_seqcount_begin() - begin a seqcount_t read critical section

---
base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
change-id: 20240813-seq_optimize-68c48696c798

Best regards,
-- 
Christoph Lameter <cl@gentwo.org>



