Return-Path: <linux-arch+bounces-9351-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87F59EB237
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 14:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933D2283C20
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419DA1A9B42;
	Tue, 10 Dec 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf/VLn2I"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4451E515;
	Tue, 10 Dec 2024 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838662; cv=none; b=QgYTyH/ba9TZzFOC4JoGSCOD7/xnswXl9hNm6wZ8Wubc7Y5UeuSW6WFB8skzwkX6ftO9Mjrd9+BG+SZX6jrVnOEac4TeZ2MooY9cvCjtYopd8QwOMu5mrJtLZE+cgHmIcsFjFvLUYRXRPlbxXuOrTxySrGTUlD6MGyO3Q55RND8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838662; c=relaxed/simple;
	bh=ZXg1bGozVdzn4a1tzlvDLtBv4mWbQKIU/XP6jeBIDvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bqz6aH7Fn4JBy3lOvF+4aWs8EHGs+nskYxyR6U2Q23auIDb34LbTuzzllkxnULI1B6HBAbLYEaMtpz6eW4U8xTTF/zmEJt3l2ZgY3kKHsldKXRjPzK8Pggf0rpaZYKF+IpVj6V8bZ8Kt8Pyg/YqTZYXaBGI1OjFrxUVuhVrq09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf/VLn2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C58C4CED6;
	Tue, 10 Dec 2024 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733838661;
	bh=ZXg1bGozVdzn4a1tzlvDLtBv4mWbQKIU/XP6jeBIDvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yf/VLn2IQhrXOEzbHiLZVrJssWuYF5wdEhW0xeWpZnpKA5ogq7bmRblmgPOoIPExb
	 qDmFeAJsOhFmvg0N8uuL+IpFFeLdmUXKNtt3zQNIy5mHNEEXSYHX4BbLa6cxzh7SVM
	 3Fj7X0jnC1pipSs1zsUOkP7Jd5r0jLEEEWudF1d+cH7SQwKvghPYc+4HEjGYEcxLC7
	 TQ2GNtjGAnkN9RNJSFrEprr6Ri7FngS8zf38cVNimyVvSfa/GuCJZ2YleDRGEFoiGQ
	 JUs7rG7AUMKGfPAIDS7ylefYJM5qU+wqsAWuURPi0BwNpx3MyzbEGtmMlYMWeSZ0e0
	 nuu81ImImT/ng==
Date: Tue, 10 Dec 2024 13:50:52 +0000
From: Will Deacon <will@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-pm@vger.kernel.org, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, catalin.marinas@arm.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	pbonzini@redhat.com, vkuznets@redhat.com, rafael@kernel.org,
	daniel.lezcano@linaro.org, peterz@infradead.org, arnd@arndb.de,
	lenb@kernel.org, mark.rutland@arm.com, harisokn@amazon.com,
	mtosatti@redhat.com, sudeep.holla@arm.com, cl@gentwo.org,
	maz@kernel.org, misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
	zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v9 05/15] arm64: barrier: add support for
 smp_cond_relaxed_timeout()
Message-ID: <20241210135052.GB15607@willie-the-truck>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
 <20241107190818.522639-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107190818.522639-6-ankur.a.arora@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Nov 07, 2024 at 11:08:08AM -0800, Ankur Arora wrote:
> Support a waited variant of polling on a conditional variable
> via smp_cond_relaxed_timeout().
> 
> This uses the __cmpwait_relaxed() primitive to do the actual
> waiting, when the wait can be guaranteed to not block forever
> (in case there are no stores to the waited for cacheline.)
> For this we depend on the availability of the event-stream.
> 
> For cases when the event-stream is unavailable, we fallback to
> a spin-waited implementation which is identical to the generic
> variant.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/arm64/include/asm/barrier.h | 54 ++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 1ca947d5c939..ab2515ecd6ca 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -216,6 +216,60 @@ do {									\
>  	(typeof(*ptr))VAL;						\
>  })
>  
> +#define __smp_cond_load_timeout_spin(ptr, cond_expr,			\
> +				     time_expr_ns, time_limit_ns)	\
> +({									\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	unsigned int __count = 0;					\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_relax();						\
> +		if (__count++ < smp_cond_time_check_count)		\
> +			continue;					\
> +		if ((time_expr_ns) >= time_limit_ns)			\
> +			break;						\
> +		__count = 0;						\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})

This is a carbon-copy of the asm-generic timeout implementation. Please
can you avoid duplicating that in the arch code?

Will

