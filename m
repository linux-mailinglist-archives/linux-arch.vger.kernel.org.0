Return-Path: <linux-arch+bounces-7343-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D01FB97ABDC
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2024 09:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467F41F22CAE
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2024 07:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67E814A4C7;
	Tue, 17 Sep 2024 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbt1g37N"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35E149C7A;
	Tue, 17 Sep 2024 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557172; cv=none; b=ukcsIcUyb5QhxLvmCuapL3TNL4FRtwgaQZ12LXln7/dweM4UZ00vhKml3EkJcvxG4F2nSL0GHEMjTQQ96hPsELe1eoioIB6ZPrxjFe10qjrYSPmxLrZ62kdJ52QyVxnnUkqsgt1ORzSiWUHcr3H+EKe+9I2f3vpZGKkw4YNYW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557172; c=relaxed/simple;
	bh=hgacHKFfwOa5El2HeDetZQZ0AkxJ6nRNh6t/Xie2Pm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeDnxHvVaUreZWWE1UnRRBYJTuxrh3kaVUBVZ6I2Ri4LZMuS2ujfM3P4+UjvdP+hkcgnrrlO+MvVNrjfWVtyqOrP7hMlUSGazYj9FzhliVx2MPCzOau7Lqh8nhvE7nPpSFMSScqCfLwQZYdQ9uw9wTqX1wX6scT6EbC9y4BysnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbt1g37N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264AAC4CEC6;
	Tue, 17 Sep 2024 07:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726557172;
	bh=hgacHKFfwOa5El2HeDetZQZ0AkxJ6nRNh6t/Xie2Pm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbt1g37NEqrGSbdmS1XbUHYbqBqU8BT+ANrGbMK5ko2XPfVxK/AbAsiTK4WCHnX8I
	 slITtFPqjcN3zcvVWRJOU5TY17zyHnNsXcsacXSJB3J7Q5yGt+Xnt9wK6QzAUyTLmS
	 XDt+VDn/DIur7Uh5jwt4Sz/Zg+6/6ZvL3HezmTBfgyc0GEIupf1nr7SvTV7CrWDJWt
	 sOOdSj13f4xKEkb4hYDqMhx8QNDFMNPVM+PvhAUDkXXJILKsxYT6sK9YEldGNQ8blX
	 mjGH9gNVk/2uuFF+sd9UWKqw+oDH2ix6OOK8KhBybNaT5vr6HSYELs5obuU85NCz+m
	 a70eJoZIVHogg==
Date: Tue, 17 Sep 2024 08:12:46 +0100
From: Will Deacon <will@kernel.org>
To: cl@gentwo.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
Message-ID: <20240917071246.GA27290@willie-the-truck>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Christoph,

On Thu, Sep 12, 2024 at 03:44:08PM -0700, Christoph Lameter via B4 Relay wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 975dd22a2dbd..3c270f496231 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1600,6 +1600,14 @@ config ARCH_HAS_KERNEL_FPU_SUPPORT
>  	  Architectures that select this option can run floating-point code in
>  	  the kernel, as described in Documentation/core-api/floating-point.rst.
>  
> +config ARCH_HAS_ACQUIRE_RELEASE
> +	bool
> +	help
> +	  Setting ARCH_HAS_ACQUIRE_RELEASE indicates that the architecture
> +	  supports load acquire and release. Typically these are more effective
> +	  than memory barriers. Code will prefer the use of load acquire and
> +	  store release over memory barriers if this option is enabled.
> +

Unsurprisingly, I'd be in favour of making this unconditional rather than
adding a new Kconfig option. Would that actually hurt any architectures
where we care about the last few shreds of performance?

>  source "kernel/gcov/Kconfig"
>  
>  source "scripts/gcc-plugins/Kconfig"
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a2f8ff354ca6..19e34fff145f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -39,6 +39,7 @@ config ARM64
>  	select ARCH_HAS_PTE_DEVMAP
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_HW_PTE_YOUNG
> +	select ARCH_HAS_ACQUIRE_RELEASE
>  	select ARCH_HAS_SETUP_DMA_OPS
>  	select ARCH_HAS_SET_DIRECT_MAP
>  	select ARCH_HAS_SET_MEMORY
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index d90d8ee29d81..a3fe9ee8edef 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -23,6 +23,13 @@
>  
>  #include <asm/processor.h>
>  
> +#ifdef CONFIG_ARCH_HAS_ACQUIRE_RELEASE
> +# define USE_LOAD_ACQUIRE	true
> +# define USE_COND_LOAD_ACQUIRE	!IS_ENABLED(CONFIG_PREEMPT_RT)
> +#else
> +# define USE_LOAD_ACQUIRE	false
> +# define USE_COND_LOAD_ACQUIRE	false
> +#endif
>  /*
>   * The seqlock seqcount_t interface does not prescribe a precise sequence of
>   * read begin/retry/end. For readers, typically there is a call to
> @@ -132,6 +139,17 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
>  #define seqcount_rwlock_init(s, lock)		seqcount_LOCKNAME_init(s, lock, rwlock)
>  #define seqcount_mutex_init(s, lock)		seqcount_LOCKNAME_init(s, lock, mutex)
>  
> +static __always_inline unsigned __seqprop_load_sequence(const seqcount_t *s, bool acquire)
> +{
> +	if (!acquire || !USE_LOAD_ACQUIRE)
> +		return READ_ONCE(s->sequence);
> +
> +	if (USE_COND_LOAD_ACQUIRE)
> +		return smp_cond_load_acquire((unsigned int *)&s->sequence, (s->sequence & 1) == 0);

This looks wrong to me.

The conditional expression passed to smp_cond_load_acquire() should be
written in terms of 'VAL', otherwise you're introducing an additional
non-atomic access to the sequence counter.

Will

