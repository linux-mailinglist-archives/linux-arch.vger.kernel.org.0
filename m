Return-Path: <linux-arch+bounces-6563-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A8995D84E
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 23:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE6B1F22563
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 21:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B0194AD9;
	Fri, 23 Aug 2024 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwzsGVYQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Etv/EtDZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E56193064;
	Fri, 23 Aug 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447135; cv=none; b=UqySpBUoShlnUaAtlSoblpdldmgscQRc7Bau6b7o1PIJOe7dL6li7JO6CXpy3IkcAfHPJz928kaUgxn091deiHEipTtZqlFtIK7tgB+s/ixfeD2IOoXVpJblrdoTCKI7fsxa0oHzZ3l8gTMG6VsnFHghEhcc5ylfIBJr/xTxoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447135; c=relaxed/simple;
	bh=VsZQyduwlI0vFv1Db4QIaS1KTScu2zoqyBgsAN/WpRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FRXCzE/EW6B+ncZ9I6LZ7xPPLXUtz9VzmwCr8IwgH1EvO1+Zkx6YcUDdxss8j3WvoicEZP/NuDb6Rgk/z2ez5zrU18ik4S4XpAeynTIaxsQ4by4rS8+CXlDqMQLSKLeTY+EqI9Qw0/3GkK4brgdXfnZBPU0ppe1KxXKoosmJ1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwzsGVYQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Etv/EtDZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724447131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CaUWysiD7XirCK5HuajRc2QEt1BaDWiUbxhTzIekA+0=;
	b=YwzsGVYQ5XR7NRFLfI/nzcORuNypZpfKRXI4fvQ7uFLG4XB8ht8QJ7UubXKqBhgWq/FMW9
	c9IBL1HeA4MpBm8SU+uoAXBUiQLOlIMXj+1vB4TVvZeXevMq0MH8dro8AM8RpQUi6b0gud
	/4DHdiLfStMahn78gc9JpomQI1F5RwCBa1nz9twIlK0IGbkA/gAuRmk5cz198dwJQ/KIbS
	orMR6waO5r5oijY63LSjk+B6nR+zybuR7fjiVbvGpSQTFQZuKkiu3Ce8xBXpVRRm0ygNe2
	gwaArWJN5ilmV9jESC203ZLO5Pj7EO9R/kveZZvqElZ7SqiDpKyoMI5M3cKMPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724447131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CaUWysiD7XirCK5HuajRc2QEt1BaDWiUbxhTzIekA+0=;
	b=Etv/EtDZ4MKLo1zgBOn/jZ4XjhaeeyIfMv4KVDs8i5C1AA011fmqaGilJL6XYVrs7Bl6nV
	Wdy2Y5lHAvWFeoCA==
To: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, "Christoph Lameter (Ampere)" <cl@gentwo.org>
Subject: Re: [PATCH v2] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <20240819-seq_optimize-v2-1-9d0da82b022f@gentwo.org>
References: <20240819-seq_optimize-v2-1-9d0da82b022f@gentwo.org>
Date: Fri, 23 Aug 2024 23:05:30 +0200
Message-ID: <87ttfbeyqt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 19 2024 at 11:30, Christoph Lameter via wrote:
> @@ -293,6 +321,18 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
>   *
>   * Return: count to be passed to read_seqcount_retry()
>   */
> +#ifdef CONFIG_ARCH_HAS_ACQUIRE_RELEASE
> +#define raw_read_seqcount_begin(s)					\
> +({									\
> +	unsigned _seq;							\
> +									\
> +	while ((_seq = seqprop_sequence_acquire(s)) & 1)		\
> +		cpu_relax();						\
> +									\
> +	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
> +	_seq;								\
> +})

So this covers only raw_read_seqcount_begin(), but not
raw_read_seqcount() which has the same smp_rmb() inside.

This all can be done without the extra copies of the counter
accessors. Uncompiled patch below.

It's a little larger than I initialy wanted to do it, but I had to keep
the raw READ_ONCE() for __read_seqcount_begin() to not inflict the
smp_load_acquire() to the only usage site in the dcache code.

The acquire conditional in __seqprop_load_sequence() is optimized out by
the compiler as all of this is macro/__always_inline.

Thanks,

        tglx
---
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -132,6 +132,14 @@ static inline void seqcount_lockdep_read
 #define seqcount_rwlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, rwlock)
 #define seqcount_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, mutex)
 
+static __always_inline unsigned __seqprop_load_sequence(const seqcount_t *s, bool acquire)
+{
+	if (acquire && IS_ENABLED(CONFIG_ARCH_HAS_ACQUIRE_RELEASE))
+		return smp_load_acquire(&s->sequence);
+	else
+		return READ_ONCE(s->sequence);
+}
+
 /*
  * SEQCOUNT_LOCKNAME()	- Instantiate seqcount_LOCKNAME_t and helpers
  * seqprop_LOCKNAME_*()	- Property accessors for seqcount_LOCKNAME_t
@@ -155,9 +163,10 @@ static __always_inline const seqcount_t
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
@@ -170,7 +179,7 @@ static __always_inline unsigned						\
 		 * Re-read the sequence counter since the (possibly	\
 		 * preempted) writer made progress.			\
 		 */							\
-		seq = READ_ONCE(s->seqcount.sequence);			\
+		seq = __seqprop_load_sequence(&s->seqcount, acquire);	\
 	}								\
 									\
 	return seq;							\
@@ -206,9 +215,9 @@ static inline const seqcount_t *__seqpro
 	return s;
 }
 
-static inline unsigned __seqprop_sequence(const seqcount_t *s)
+static inline unsigned __seqprop_sequence(const seqcount_t *s, bool acquire)
 {
-	return READ_ONCE(s->sequence);
+	return __seqprop_load_sequence(s, acquire);
 }
 
 static inline bool __seqprop_preemptible(const seqcount_t *s)
@@ -258,29 +267,23 @@ SEQCOUNT_LOCKNAME(mutex,        struct m
 
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
+	while ((__seq = seqprop_sequence(s, acquire)) & 1)		\
 		cpu_relax();						\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
@@ -288,6 +291,26 @@ SEQCOUNT_LOCKNAME(mutex,        struct m
 })
 
 /**
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
+/**
  * raw_read_seqcount_begin() - begin a seqcount_t read section w/o lockdep
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
@@ -295,9 +318,10 @@ SEQCOUNT_LOCKNAME(mutex,        struct m
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
 
@@ -326,9 +350,10 @@ SEQCOUNT_LOCKNAME(mutex,        struct m
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

