Return-Path: <linux-arch+bounces-3820-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B508AAF29
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 15:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E69AFB21E1C
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC886643;
	Fri, 19 Apr 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk5mT5I7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7206986640;
	Fri, 19 Apr 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532670; cv=none; b=MDmvL97NJDHentJpbeNweluCYbCIKBwDB2u2dUGu4DQbZIqK1r3YKkjGhbXUW0aojmISoXOXY1+699TplOnuXmHUo4tG+juNRSzh4xh6lyHa5rb+eld8bphrCtc3WJvyMEKLkh0NXqLNvDl15jOm4ha0516+V2wM4qG8wr1r7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532670; c=relaxed/simple;
	bh=P3USWEZSPy10m4QVgX4E7XO5g3Xx+Ubf4LMQr2KdyCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uev0AvUeS28dknOmkRo6mvl0v2gYkyLvV5BxQ7zBGRAobRD/WT3sWSgU/5Jh+GXEhOc65W3ZIhe+Xhv5KuAE9uiIlSj1N+rM0eHVGGjiIJwstwrfV+LBeyScecYgb3hd5G4UFpZkjeiM7+GuonunZQrLfuxSfq20D3WYLFw93+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk5mT5I7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C79C072AA;
	Fri, 19 Apr 2024 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713532669;
	bh=P3USWEZSPy10m4QVgX4E7XO5g3Xx+Ubf4LMQr2KdyCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kk5mT5I7gsbHbYbsEWHu9NNp+2wXKQavfy5cllFObb5io4ETLYs1kvPmh/s4KHS4G
	 qQ5Y8p2yVQU9b1iRl6GgjWZTsXflEnzvm6iBOmEi8hnjT5vvoU5J+O5+kpj4WbFI0w
	 q8R8QfrLr3LHtcbPo8hV7/kBqryNZ7L6FBHFgX+rPjDj9CLZLhDNQbFncSrvnjHGdP
	 K4wTX/u7ecsJQjfCd2lf4hf1PVGFRl7Tk0Mc5ImI7AGLl+uUi2iUWc75/YS1AAZxt1
	 3MF2iBePRNKEbtWQqPNbn0MduFQ2Y7OvGTMB6MXL4oTLmIIDxCdR3lYu3XZTxqfIHP
	 3HFaJYYyS94Vw==
Date: Fri, 19 Apr 2024 14:17:44 +0100
From: Will Deacon <will@kernel.org>
To: Rohan McLure <rmclure@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	arnd@arndb.de, gautam@linux.ibm.com
Subject: Re: [PATCH] asm-generic/mmiowb: Mark accesses to fix KCSAN warnings
Message-ID: <20240419131744.GB3148@willie-the-truck>
References: <20240404043855.640578-2-rmclure@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404043855.640578-2-rmclure@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Apr 04, 2024 at 03:38:53PM +1100, Rohan McLure wrote:
> Prior to this patch, data races are detectable by KCSAN of the following
> forms:
> 
> [1] Asynchronous calls to mmiowb_set_pending() from an interrupt context
>     or otherwise outside of a critical section
> [2] Interrupted critical sections, where the interrupt will itself
>     acquire a lock
> 
> In case [1], calling context does not need an mmiowb() call to be
> issued, otherwise it would do so itself. Such calls to
> mmiowb_set_pending() are either idempotent or no-ops.
> 
> In case [2], irrespective of when the interrupt occurs, the interrupt
> will acquire and release its locks prior to its return, nesting_count
> will continue balanced. In the worst case, the interrupted critical
> section during a mmiowb_spin_unlock() call observes an mmiowb to be
> pending and afterward is interrupted, leading to an extraneous call to
> mmiowb(). This data race is clearly innocuous.
> 
> Resolve KCSAN warnings of type [1] by means of READ_ONCE, WRITE_ONCE.
> As increments and decrements to nesting_count are balanced by interrupt
> contexts, resolve type [2] warnings by simply revoking instrumentation,
> with data_race() rather than READ_ONCE() and WRITE_ONCE(), the memory
> consistency semantics of plain-accesses will still lead to correct
> behaviour.
> 
> Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Previously discussed here:
> https://lore.kernel.org/linuxppc-dev/20230510033117.1395895-4-rmclure@linux.ibm.com/
> But pushed back due to affecting other architectures. Reissuing, to
> linuxppc-dev, as it does not enact a functional change.
> ---
>  include/asm-generic/mmiowb.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
> index 5698fca3bf56..f8c7c8a84e9e 100644
> --- a/include/asm-generic/mmiowb.h
> +++ b/include/asm-generic/mmiowb.h
> @@ -37,25 +37,28 @@ static inline void mmiowb_set_pending(void)
>  	struct mmiowb_state *ms = __mmiowb_state();
>  
>  	if (likely(ms->nesting_count))
> -		ms->mmiowb_pending = ms->nesting_count;
> +		WRITE_ONCE(ms->mmiowb_pending, ms->nesting_count);
>  }
>  
>  static inline void mmiowb_spin_lock(void)
>  {
>  	struct mmiowb_state *ms = __mmiowb_state();
> -	ms->nesting_count++;
> +
> +	/* Increment need not be atomic. Nestedness is balanced over interrupts. */
> +	data_race(ms->nesting_count++);
>  }
>  
>  static inline void mmiowb_spin_unlock(void)
>  {
>  	struct mmiowb_state *ms = __mmiowb_state();
> +	u16 pending = READ_ONCE(ms->mmiowb_pending);
>  
> -	if (unlikely(ms->mmiowb_pending)) {
> -		ms->mmiowb_pending = 0;
> +	WRITE_ONCE(ms->mmiowb_pending, 0);

Why are you changing this store to be unconditional?

Will

