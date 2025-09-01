Return-Path: <linux-arch+bounces-13345-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CC0B3E188
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24B93BED18
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D3D31A048;
	Mon,  1 Sep 2025 11:28:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06031A041;
	Mon,  1 Sep 2025 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726134; cv=none; b=El8Dj9GT0wlhrTP1BIxkyj++HeocPTGHj7APHhnjbjhn0iBpxl0pI+nHdkQwIZbMHbJNDlN0SjvPXHQHCmauvmfVIdsaaLfafEiv7wdKb5p6OHRmCtRDtGyNMog0G9+JHRDkY3r/a/a6Xj2nq0gcshQl2tGGZfcfamJZ08a/dvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726134; c=relaxed/simple;
	bh=rmV1Vk9JgSlx7RoGBA6BnI4BlWWKUxuRTbLf2TMQnFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOncs3jOgcvI/W6ceiWzgeWXkgqcfrI4XnHTcmSVoyNtmDxK85BeilF513XNymj8j0UnrcN790pRLknqFiS3BqyW/9vO5id07/DtwztREsCndFpOopIsVvqb7EEK2qfFSmXA9SkQjZqo1h0CNA3zVPNjBwZwCRqXeF5hEuGTXbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0166C4CEF4;
	Mon,  1 Sep 2025 11:28:50 +0000 (UTC)
Date: Mon, 1 Sep 2025 12:28:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, will@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v4 5/5] rqspinlock: use smp_cond_load_acquire_timewait()
Message-ID: <aLWDcJiZWD7g8-4S@arm.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <20250829080735.3598416-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829080735.3598416-6-ankur.a.arora@oracle.com>

On Fri, Aug 29, 2025 at 01:07:35AM -0700, Ankur Arora wrote:
> diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
> index a385603436e9..ce8feadeb9a9 100644
> --- a/arch/arm64/include/asm/rqspinlock.h
> +++ b/arch/arm64/include/asm/rqspinlock.h
> @@ -3,6 +3,9 @@
>  #define _ASM_RQSPINLOCK_H
>  
>  #include <asm/barrier.h>
> +
> +#define res_smp_cond_load_acquire_waiting() arch_timer_evtstrm_available()

More on this below, I don't think we should define it.

> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 5ab354d55d82..8de1395422e8 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -82,6 +82,7 @@ struct rqspinlock_timeout {
>  	u64 duration;
>  	u64 cur;
>  	u16 spin;
> +	u8  wait;
>  };
>  
>  #define RES_TIMEOUT_VAL	2
> @@ -241,26 +242,20 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
>  }
>  
>  /*
> - * Do not amortize with spins when res_smp_cond_load_acquire is defined,
> - * as the macro does internal amortization for us.
> + * Only amortize with spins when we don't have a waiting implementation.
>   */
> -#ifndef res_smp_cond_load_acquire
>  #define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
>  	({                                                            \
> -		if (!(ts).spin++)                                     \
> +		if ((ts).wait || !(ts).spin++)		      \
>  			(ret) = check_timeout((lock), (mask), &(ts)); \
>  		(ret);                                                \
>  	})
> -#else
> -#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
> -	({ (ret) = check_timeout((lock), (mask), &(ts)); })
> -#endif

IIUC, RES_CHECK_TIMEOUT in the current res_smp_cond_load_acquire() usage
doesn't amortise the spins, as the comment suggests, but rather the
calls to check_timeout(). This is fine, it matches the behaviour of
smp_cond_load_relaxed_timewait() you introduced in the first patch. The
only difference is the number of spins - 200 (matching poll_idle) vs 64K
above. Does 200 work for the above?

>  /*
>   * Initialize the 'spin' member.
>   * Set spin member to 0 to trigger AA/ABBA checks immediately.
>   */
> -#define RES_INIT_TIMEOUT(ts) ({ (ts).spin = 0; })
> +#define RES_INIT_TIMEOUT(ts) ({ (ts).spin = 0; (ts).wait = res_smp_cond_load_acquire_waiting(); })

First of all, I don't really like the smp_cond_load_acquire_waiting(),
that's an implementation detail of smp_cond_load_*_timewait() that
shouldn't leak outside. But more importantly, RES_CHECK_TIMEOUT() is
also used outside the smp_cond_load_acquire_timewait() condition. The
(ts).wait check only makes sense when used together with the WFE
waiting.

I would leave RES_CHECK_TIMEOUT() as is for the stand-alone cases and
just use check_timeout() in the smp_cond_load_acquire_timewait()
scenarios. I would also drop the res_smp_cond_load_acquire() macro since
you now defined smp_cond_load_acquire_timewait() generically and can be
used directly.

-- 
Catalin

