Return-Path: <linux-arch+bounces-6562-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640BB95D623
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 21:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975C31C22446
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 19:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D14192B68;
	Fri, 23 Aug 2024 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="FAEXlFLs"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3B192595;
	Fri, 23 Aug 2024 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724441887; cv=none; b=pgmwwPKCGukjVNw/WAR3ryt4yhtWnhxyTttiquCfdBvMIUA8DKFqOcPgtDIWSeqBDxFKRDyXEN84pjPrjPtS9UjqyYDyjZHbKrmb47QXvzpL5JQo4kaj/KObtrCKPaycWe0LRe2WJPbtcZjlG5CBGeIc7JaDsHZmDpsiQDf04UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724441887; c=relaxed/simple;
	bh=4i+qKKvggQ5Z8O0Lc4TxnEKHKLERGGdbZV3Gjf/BCqs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V0Clc/D1CUtuADeXKqP5JAOa1eN7ZQKWfyX8K7nPJ7D4czxRk3cJQitFlTjY3nnVMU2QP109y/osTuC8R8w+ZOwLFyb86TM/rMd2wYY0SwJ0EIy4cxmXd4zJ/VaKViDF4vAVUo8Rn0t1235siAp+cNn8kjFH1z2DNiGkIDHPwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=FAEXlFLs; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1724441885;
	bh=4i+qKKvggQ5Z8O0Lc4TxnEKHKLERGGdbZV3Gjf/BCqs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FAEXlFLsex+v8IS+kdbKBGhzllBlekoCJBcOnjFHTMa3NCEPL7mcevfqIfdmTckxd
	 il07Ja18EcWtZvCoNQwV7ihRhFmeqAf4T7feQunp2U6+pBwZKCWbvoSLLOqqrYTmvE
	 GAFqOte7PKRJ8DdReSmIZAoo8+bODAgXHprk+DRU=
Received: by gentwo.org (Postfix, from userid 1003)
	id 081B040355; Fri, 23 Aug 2024 12:38:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 072E74022C;
	Fri, 23 Aug 2024 12:38:05 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:38:05 -0700 (PDT)
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
Message-ID: <8dcd8772-2c0c-20af-86c4-18f32c07d1e9@gentwo.org>
References: <20240819-seq_optimize-v2-1-9d0da82b022f@gentwo.org> <20240823103205.GA31866@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Aug 2024, Will Deacon wrote:

> > +#ifdef CONFIG_ARCH_HAS_ACQUIRE_RELEASE
> > +#define raw_read_seqcount_begin(s)					\
> > +({									\
> > +	unsigned _seq;							\
> > +									\
> > +	while ((_seq = seqprop_sequence_acquire(s)) & 1)		\
> > +		cpu_relax();						\
>
> It would also be interesting to see whether smp_cond_load_acquire()
> performs any better that this loop in the !RT case.

The hack to do this follows. Kernel boots but no change in cycles. Also
builds a kernel just fine.

Another benchmark may be better. All my synthetic tests do is run the
function calls in a loop in parallel on multiple cpus.

The main effect here may be the reduction of power since the busyloop is
no longer required. I would favor a solution like this. But the patch is
not clean given the need to get rid of the const attribute with a cast.


Index: linux/include/linux/seqlock.h
===================================================================
--- linux.orig/include/linux/seqlock.h
+++ linux/include/linux/seqlock.h
@@ -325,9 +325,9 @@ SEQCOUNT_LOCKNAME(mutex,        struct m
 #define raw_read_seqcount_begin(s)					\
 ({									\
 	unsigned _seq;							\
+	seqcount_t *e = seqprop_ptr((struct seqcount_spinlock *)s);	\
 									\
-	while ((_seq = seqprop_sequence_acquire(s)) & 1)		\
-		cpu_relax();						\
+	_seq = smp_cond_load_acquire(&e->sequence, ((e->sequence & 1) == 0));	\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
 	_seq;								\

