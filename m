Return-Path: <linux-arch+bounces-6554-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FCC95CA7C
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 12:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854511C21452
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2024 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBB71448D9;
	Fri, 23 Aug 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKDVzr3+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD2364AB;
	Fri, 23 Aug 2024 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409137; cv=none; b=MRqZVTzO3Q1zu17WNp0uZQvl1z2OoplDX0lraQSHuF0oyM1eh82wkdl8FSulFAywcKlRrFnfcQDu1uAnaf4qvtb9mcJ0tctdIxoVS3/EKBrVIKRuGVURc2evYrMTNOfIekuLq/OS+MSMuTCL0kayigYj7tn8bfccWQCzjKx9y8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409137; c=relaxed/simple;
	bh=+TdwiAS6oo7wWEadkXTiyzSakrmyZjhYan1C9YRRgug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJA9wkFeYFGMoyGEZTGAQWKCS498qR8I2hARonLYqJRP4tu14iXcVXlhPPnW8HmGk3ArT/RAEfAKU7uZ2OgLGuhvSKSRltq+eytQMZtjnCN77HRGzFnW1KWpclf6/ZkRNTm+9wwHvl9o59qYQ7p1jrrjmxW7//MhRAaubKf+uH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKDVzr3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE55CC32786;
	Fri, 23 Aug 2024 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724409136;
	bh=+TdwiAS6oo7wWEadkXTiyzSakrmyZjhYan1C9YRRgug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKDVzr3+xoQNHI1mEkBcxBhyyOjdbFC9sKLrM+TZP/aFgP/3h02VE7a8TG8C25T0O
	 C4+SoHQrL+QYhUY32G6Gv2wIfSoHgNmGvWVASTJjK0eAquCXLBZhJQGGzthVRXPmx6
	 zPBFRuonuzbw9QzRFWEihMk0eUjmNXul4TZdgYP+C+lw+9y9txCC4JUVNowFYLnf8U
	 e52r03GztBcGl5KJ+abU00lsCAm1y3/K/rJNbXBf4mOcJwYIu65S0dkzcHcX/ssMFT
	 pZmjHmudm7kgVGyu4klnLXCRVu5voSRvVgRqoAjkpqcN7GSfFAE/ubg3T8VARSLcax
	 kHTyDe+XDdMTQ==
Date: Fri, 23 Aug 2024 11:32:11 +0100
From: Will Deacon <will@kernel.org>
To: cl@gentwo.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] Avoid memory barrier in read_seqcount() through load
 acquire
Message-ID: <20240823103205.GA31866@willie-the-truck>
References: <20240819-seq_optimize-v2-1-9d0da82b022f@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-seq_optimize-v2-1-9d0da82b022f@gentwo.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 19, 2024 at 11:30:15AM -0700, Christoph Lameter via B4 Relay wrote:
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index d90d8ee29d81..353fcf32b800 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -176,6 +176,28 @@ __seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
>  	return seq;							\
>  }									\
>  									\
> +static __always_inline unsigned						\
> +__seqprop_##lockname##_sequence_acquire(const seqcount_##lockname##_t *s) \
> +{									\
> +	unsigned seq = smp_load_acquire(&s->seqcount.sequence);		\
> +									\
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
> +		return seq;						\
> +									\
> +	if (preemptible && unlikely(seq & 1)) {				\
> +		__SEQ_LOCK(lockbase##_lock(s->lock));			\
> +		__SEQ_LOCK(lockbase##_unlock(s->lock));			\
> +									\
> +		/*							\
> +		 * Re-read the sequence counter since the (possibly	\
> +		 * preempted) writer made progress.			\
> +		 */							\
> +		seq = smp_load_acquire(&s->seqcount.sequence);		\

We could probably do even better with LDAPR here, as that should be
sufficient for this. It's a can of worms though, as it's not implemented
on all CPUs and relaxing smp_load_acquire() might introduce subtle
breakage in places where it's used to build other types of lock. Maybe
you can hack something to see if there's any performance left behind
without it?

> +	}								\
> +									\
> +	return seq;							\
> +}									\
> +									\
>  static __always_inline bool						\
>  __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
>  {									\
> @@ -211,6 +233,11 @@ static inline unsigned __seqprop_sequence(const seqcount_t *s)
>  	return READ_ONCE(s->sequence);
>  }
>  
> +static inline unsigned __seqprop_sequence_acquire(const seqcount_t *s)
> +{
> +	return smp_load_acquire(&s->sequence);
> +}
> +
>  static inline bool __seqprop_preemptible(const seqcount_t *s)
>  {
>  	return false;
> @@ -259,6 +286,7 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
>  #define seqprop_ptr(s)			__seqprop(s, ptr)(s)
>  #define seqprop_const_ptr(s)		__seqprop(s, const_ptr)(s)
>  #define seqprop_sequence(s)		__seqprop(s, sequence)(s)
> +#define seqprop_sequence_acquire(s)	__seqprop(s, sequence_acquire)(s)
>  #define seqprop_preemptible(s)		__seqprop(s, preemptible)(s)
>  #define seqprop_assert(s)		__seqprop(s, assert)(s)
>  
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

It would also be interesting to see whether smp_cond_load_acquire()
performs any better that this loop in the !RT case.

Both things to look at separately though, so:

Acked-by: Will Deacon <will@kernel.org>

I assume this will go via -tip.

Will

