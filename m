Return-Path: <linux-arch+bounces-10524-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C093A4ED54
	for <lists+linux-arch@lfdr.de>; Tue,  4 Mar 2025 20:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6713216CE35
	for <lists+linux-arch@lfdr.de>; Tue,  4 Mar 2025 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F618CBE1;
	Tue,  4 Mar 2025 19:29:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417824C069;
	Tue,  4 Mar 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116552; cv=none; b=tkJb5t52ogGNhv4bgG3WWkTP8xtLOXy0pUs8d/D0esTE0wyiDVFCg/urHRQzLsE5En5F4+M51WSRW67NdxC7ToPQCGXoBefs5tYpe3VVy7G6rexztS939ZUKzsDxLGsOdnI60YXyfNsYqA18B1zLRtgAcDALoyyX/zv0jfQWXYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116552; c=relaxed/simple;
	bh=pERybhiyp1zywKYJkrjcMFsvKjvJPlvDpsxi6348ARI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLRCAg/QCc4okN5dX+Kkzh6oCXbpgn4qhSzKqD1I+s8QYdTesNzxKOTY52mPAsZGDZ8Hb/4dztbLFPfGq3MIQbXCnHVLCVKV62cKrKOodVE1HFOHHleqKoiLIZHxelN+QxGb2odrkzBF3XKeYsCr/j5pCehzoW3+2/PKsIHABbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC3FC4CEE5;
	Tue,  4 Mar 2025 19:29:09 +0000 (UTC)
Date: Tue, 4 Mar 2025 19:29:07 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	will@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, memxor@gmail.com,
	zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 3/4] arm64: barrier: Add smp_cond_load_relaxed_timewait()
Message-ID: <Z8dUg5zzclvDpPtZ@arm.com>
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
 <20250203214911.898276-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203214911.898276-4-ankur.a.arora@oracle.com>

On Mon, Feb 03, 2025 at 01:49:10PM -0800, Ankur Arora wrote:
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 1ca947d5c939..25721275a5a2 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -216,6 +216,44 @@ do {									\
>  	(typeof(*ptr))VAL;						\
>  })
>  
> +#define __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
> +					 time_expr_ns, time_limit_ns)	\
> +({									\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		__cmpwait_relaxed(__PTR, VAL);				\
> +		if ((time_expr_ns) >= (time_limit_ns))			\
> +			break;						\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})

Rename this to something like *_evstrm as this doesn't really work
unless we have the event stream. Another one would be *_wfet.

> +
> +/*
> + * For the unlikely case that the event-stream is unavailable,
> + * ward off the possibility of waiting forever by falling back
> + * to the generic spin-wait.
> + */
> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr,			\
> +				       time_expr_ns, time_limit_ns)	\
> +({									\
> +	__unqual_scalar_typeof(*ptr) _val;				\
> +	int __wfe = arch_timer_evtstrm_available();			\

This should be a bool.

> +									\
> +	if (likely(__wfe))						\
> +		_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,	\
> +							time_expr_ns,	\
> +							time_limit_ns);	\
> +	else								\
> +		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
> +							time_expr_ns,	\
> +							time_limit_ns);	\
> +	(typeof(*ptr))_val;						\
> +})

Not sure there's much to say here, this depends on the actual interface
introduced by patch 1. If we make some statements about granularity of
some time_cond_expr check, we'll have to take that into account.

-- 
Catalin

