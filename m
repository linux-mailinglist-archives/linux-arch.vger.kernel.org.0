Return-Path: <linux-arch+bounces-6910-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D089686C9
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 13:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564851C22229
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 11:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5EF1D6DC9;
	Mon,  2 Sep 2024 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0cQML09U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lkIJ4uXa"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD41D6C73;
	Mon,  2 Sep 2024 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278105; cv=none; b=uuE8zD23fRzfOfJKR+GNhw/fWZlevUZwPby/JWgfYn+ttGOU2Ks8ohwyRhliSt20/eQl4t0L7YFpKK555BTjRYFkK5TRK5IwfzmQvwur/lRW0Kb1v2FUGvKTG0Nypi0tUeOl8k2vZILUa4hxKJkKaiMlADFTFEXxvjh2j1n4mdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278105; c=relaxed/simple;
	bh=oBHHMeHiBha/fXabSA6UGxz6iD01FGTyzpDAgaM2OBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fz6FMhSvbyhwJzAROjY1zqImIsk+mBEzDxvCZOhv7fg5TwzVLNWAOG3ZcoSpcxVYNWkochH3gzbh9aYtOd+H3UMuwZebbQlETpi+6sxgA/+9rFJyHeQpYgUnp4ySw+RrQ6tIhyi3W61VyUnbiypq+PEV9rJSK31cNORG+7in0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0cQML09U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lkIJ4uXa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725278102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sEgsc5hfwM3ia/sAR7ebt4TKSr5Pvzs7BQG/4VSVeIk=;
	b=0cQML09UZi5csPnYHKk9/AcDeo9RrboR8toJS2MoJJxZtJjbZQO4er92aqP37pf3tF3KYo
	B7CsiytHbvp5JAwoUmaIFKDOljiwHBgHKsSbpSFyGL77SHKiXzKbc7rIuOBbjjJletV5b5
	+vQAtzPInUxUb96foq9u3SAulT2wCQ3fTM4ktJcOtpBTTJY2KF69ybew7eI9dU8mPwtkjc
	l9h4jNj+5gzVVrr8YA+VUFwl6tCDu5tSbfP71X/5oRYupvqqqBsNyp4SSjpJhTvSMDK/Ov
	VZTUa0/3lgBgYuGrbaZ6GPNdxKy1fsCZ6lWqX8xPEan5Agc2UzhfbDcontaS9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725278102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sEgsc5hfwM3ia/sAR7ebt4TKSr5Pvzs7BQG/4VSVeIk=;
	b=lkIJ4uXaxPac8zjaUxEtoY+WcZYF7rh33Smg10Am/Xgg45lhdJBXhlNLzsejtGadHI4nEz
	TuBxXTEcTfvmpXCA==
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <b0543714-9176-f3a3-1ca9-55bbedf6a0c3@gentwo.org>
References: <20240819-seq_optimize-v2-1-9d0da82b022f@gentwo.org>
 <87ttfbeyqt.ffs@tglx> <b0543714-9176-f3a3-1ca9-55bbedf6a0c3@gentwo.org>
Date: Mon, 02 Sep 2024 13:55:01 +0200
Message-ID: <871q226zje.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 28 2024 at 10:15, Christoph Lameter wrote:
> On Fri, 23 Aug 2024, Thomas Gleixner wrote:
>
>> This all can be done without the extra copies of the counter
>> accessors. Uncompiled patch below.
>
> Great. Thanks. Tried it too initially but could not make it work right.
>
> One thing that we also want is the use of the smp_cond_load_acquire to
> have the cpu power down while waiting for a cacheline change.
>
> The code has several places where loops occur when the last bit is set in
> the seqcount.
>
> We could use smp_cond_load_acquire in load_sequence() but what do we do
> about the loops at the higher level? Also this does not sync with the lock
> checking logic.

Come on. It's not rocket science to figure that out.

Uncompiled delta patch below.

Thanks,

        tglx
---
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
@@ -134,10 +141,13 @@ static inline void seqcount_lockdep_read
 
 static __always_inline unsigned __seqprop_load_sequence(const seqcount_t *s, bool acquire)
 {
-	if (acquire && IS_ENABLED(CONFIG_ARCH_HAS_ACQUIRE_RELEASE))
-		return smp_load_acquire(&s->sequence);
-	else
+	if (!acquire || !USE_LOAD_ACQUIRE)
 		return READ_ONCE(s->sequence);
+
+	if (USE_COND_LOAD_ACQUIRE)
+		return smp_cond_load_acquire(&s->sequence, (s->sequence & 1) == 0);
+
+	return smp_load_acquire(&s->sequence);
 }
 
 /*
@@ -283,8 +293,12 @@ SEQCOUNT_LOCKNAME(mutex,        struct m
 ({									\
 	unsigned __seq;							\
 									\
-	while ((__seq = seqprop_sequence(s, acquire)) & 1)		\
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

