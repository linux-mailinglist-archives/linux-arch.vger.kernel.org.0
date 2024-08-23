Return-Path: <linux-arch+bounces-6560-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CB095D4BE
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 19:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863D71C2187C
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BD2190486;
	Fri, 23 Aug 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="ScH8nQAc"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51A18DF81;
	Fri, 23 Aug 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435781; cv=none; b=clfuhas4Flf9kpfwuOIDR8/T5lcr4FZayx0ck3T9jFqHQYt4mlNXg4ltO2qNaH6tN6tXz1JkrIM3TiXj5ZWwCMx+uwprxH23OvrzJxwd87dieI0WLsqKAaRWBM97caE8Rm/4JP7yWOvgZkIiwE9orxYOmvEFYpI30h/aOQLEuEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435781; c=relaxed/simple;
	bh=YYeueXGuTx296I5j6wRoxr6YLB75COxvbxo4WqfFdKA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lhT7UdyroQBTVbeXqPwM8oG9fesWVMng2RhkAS9YG+RdTv08OUtzcHTJjMyUbw7ububtPSniLPXtPIhePm0vZtb+34VwZGsYWWgzMJIb5Qo5Z/S44mscqgQQVSXE98XHtm65hHWNzmJ3ozWpwd7ngmk+Jk2UVD8qaTmZNDtJbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=ScH8nQAc; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1724435772;
	bh=YYeueXGuTx296I5j6wRoxr6YLB75COxvbxo4WqfFdKA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ScH8nQAc+J8FXZz9gUQDA42IJImEnBoU4YakJx1NjB105SrTBVfwDPDu1Z7VuhfY9
	 WPNltnyUi+/7r7XwOfKfIApZVz8GPclKfRVzLNj9pntdhvLwR9PEkrD/5nmcjKe4iB
	 hG2TPNC+QGeGUDkdmt2uxa0S7h0gLL0daAEZ/DFQ=
Received: by gentwo.org (Postfix, from userid 1003)
	id E716F40355; Fri, 23 Aug 2024 10:56:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id E59CB4022C;
	Fri, 23 Aug 2024 10:56:12 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:56:12 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Will Deacon <will@kernel.org>
cc: Catalin Marinas <catalin.marinas@arm.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <20240823103205.GA31866@willie-the-truck>
Message-ID: <6427b071-40de-cad5-d1e5-e45f84ae837a@gentwo.org>
References: <20240819-seq_optimize-v2-1-9d0da82b022f@gentwo.org> <20240823103205.GA31866@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Aug 2024, Will Deacon wrote:

> On Mon, Aug 19, 2024 at 11:30:15AM -0700, Christoph Lameter via B4 Relay wrote:
> > +static __always_inline unsigned						\
> > +__seqprop_##lockname##_sequence_acquire(const seqcount_##lockname##_t *s) \
> > +{									\
> > +	unsigned seq = smp_load_acquire(&s->seqcount.sequence);		\
> > +									\
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
> > +		return seq;						\
> > +									\
> > +	if (preemptible && unlikely(seq & 1)) {				\
> > +		__SEQ_LOCK(lockbase##_lock(s->lock));			\
> > +		__SEQ_LOCK(lockbase##_unlock(s->lock));			\
> > +									\
> > +		/*							\
> > +		 * Re-read the sequence counter since the (possibly	\
> > +		 * preempted) writer made progress.			\
> > +		 */							\
> > +		seq = smp_load_acquire(&s->seqcount.sequence);		\
>
> We could probably do even better with LDAPR here, as that should be
> sufficient for this. It's a can of worms though, as it's not implemented
> on all CPUs and relaxing smp_load_acquire() might introduce subtle
> breakage in places where it's used to build other types of lock. Maybe
> you can hack something to see if there's any performance left behind
> without it?

I added the following patch. Kernel booted fine. No change in the cycles
of read_seq()

LDAPR
---------------------------
Test					Single	2 CPU	4 CPU	8 CPU	16 CPU	32 CPU	64 CPU	ALL
write seq			:	13	98	385	764	1551	3043	6259	11922
read seq			:	8	8	8	8	8	8	9	10
rw seq				:	8	101	247	300	467	742	1384	2101

LDA
---------------------------
Test                                     Single  2 CPU   4 CPU   8 CPU   16 CPU  32 CPU  64 CPU  ALL
write seq                        :       13      90      343     785     1533    3032    6315    11073
read seq                         :       8       8       8       8       8       8       9       11
rw seq                           :       8       79      227     313     423     755     1313    2220





Index: linux/arch/arm64/include/asm/barrier.h
===================================================================
--- linux.orig/arch/arm64/include/asm/barrier.h
+++ linux/arch/arm64/include/asm/barrier.h
@@ -167,22 +167,22 @@ do {									\
 	kasan_check_read(__p, sizeof(*p));				\
 	switch (sizeof(*p)) {						\
 	case 1:								\
-		asm volatile ("ldarb %w0, %1"				\
+		asm volatile (".arch_extension rcpc\nldaprb %w0, %1"	\
 			: "=r" (*(__u8 *)__u.__c)			\
 			: "Q" (*__p) : "memory");			\
 		break;							\
 	case 2:								\
-		asm volatile ("ldarh %w0, %1"				\
+		asm volatile (".arch_extension rcpc\nldaprh %w0, %1"				\
 			: "=r" (*(__u16 *)__u.__c)			\
 			: "Q" (*__p) : "memory");			\
 		break;							\
 	case 4:								\
-		asm volatile ("ldar %w0, %1"				\
+		asm volatile (".arch_extension rcpc\nldapr %w0, %1"				\
 			: "=r" (*(__u32 *)__u.__c)			\
 			: "Q" (*__p) : "memory");			\
 		break;							\
 	case 8:								\
-		asm volatile ("ldar %0, %1"				\
+		asm volatile (".arch_extension rcpc\nldapr %0, %1"				\
 			: "=r" (*(__u64 *)__u.__c)			\
 			: "Q" (*__p) : "memory");			\
 		break;							\

