Return-Path: <linux-arch+bounces-6721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5947B962E64
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 19:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD11C21816
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7848E19F470;
	Wed, 28 Aug 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="c7PC2lWR"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7D14600F;
	Wed, 28 Aug 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865881; cv=none; b=tyOfuawXFDGjLcvfQTD7XfqyTgRRZnveaFKoDqsRmzRUkcQyZ6VYeORdADDFIewv3DmcsX948MBC5EF3ugBNsgFjG4/bWFYHbwnLE0xLKRs0V3qUFVSgJsITSl5FZEs2+yqIF7FPqeQMuAOFErc8XOaVxdr8NODY7mkFTiZ/mBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865881; c=relaxed/simple;
	bh=nSvT5YRDGKjvsPRngtDmL2GgKvhYz22L9LD9LQewmAI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aZxVSZZ98NlLb4tSSjjfK5hTraZSi5yiUtfVbu2IGvq+uK7begzdn2SokDqsi8lTdwUGfoO/3G7pUAXPx9R9emxYSvOg/bhwo35Ru3Gf6XDS4R32dnAiWHnlnYoPxLRqYTgGyUaEyjmsm0LmKInfpq5GkXck4lh9oVL9i7yei3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=c7PC2lWR; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1724865333;
	bh=nSvT5YRDGKjvsPRngtDmL2GgKvhYz22L9LD9LQewmAI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=c7PC2lWRLJXBkhAPKDJmiYcEyzVK87P+5QEVOGpaROKk+wM6c2mJNQXH/JzuCm0hR
	 vRn7wtleBZLuZFfNL5A/aJpXbZ2le4E8wtypD6laLXduYkBPpEdFPWkSSdygb121VD
	 FhGeFb+FDR9SMj3j9B2KViReeqZ2NQxONUOX5+Tg=
Received: by gentwo.org (Postfix, from userid 1003)
	id E3CA0404BB; Wed, 28 Aug 2024 10:15:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id E2B08404BA;
	Wed, 28 Aug 2024 10:15:33 -0700 (PDT)
Date: Wed, 28 Aug 2024 10:15:33 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <87ttfbeyqt.ffs@tglx>
Message-ID: <b0543714-9176-f3a3-1ca9-55bbedf6a0c3@gentwo.org>
References: <20240819-seq_optimize-v2-1-9d0da82b022f@gentwo.org> <87ttfbeyqt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Aug 2024, Thomas Gleixner wrote:

> This all can be done without the extra copies of the counter
> accessors. Uncompiled patch below.

Great. Thanks. Tried it too initially but could not make it work right.

One thing that we also want is the use of the smp_cond_load_acquire to
have the cpu power down while waiting for a cacheline change.

The code has several places where loops occur when the last bit is set in
the seqcount.

We could use smp_cond_load_acquire in load_sequence() but what do we do
about the loops at the higher level? Also this does not sync with the lock
checking logic.


diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 68b3af8bd6c6..4442a97ffe9a 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -135,7 +135,7 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 static __always_inline unsigned __seqprop_load_sequence(const seqcount_t *s, bool acquire)
 {
 	if (acquire && IS_ENABLED(CONFIG_ARCH_HAS_ACQUIRE_RELEASE))
-		return smp_load_acquire(&s->sequence);
+		return smp_cond_load_acquire(&s->sequence, (s->sequence & 1) == 0);
 	else
 		return READ_ONCE(s->sequence);
 }


