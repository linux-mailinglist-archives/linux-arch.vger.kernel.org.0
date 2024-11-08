Return-Path: <linux-arch+bounces-8917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D689C1417
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 03:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730091C20EAB
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 02:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7A5DF49;
	Fri,  8 Nov 2024 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="Xs5VoxTz"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21B3D6D;
	Fri,  8 Nov 2024 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033208; cv=none; b=cKMvqMqT+u0aRI3poo6CRY8sLWvvK+KOff0cMmbiO/LlLGKmC6UNFq37g+LRMwrdE4SWwTdqPuzQaaPe5TXEgWHVYED3AK/Avuf1svPPIhw7OxSPOzIcDPnaUD7xg3WPQxRI7u7psqzuZn8BxJA0jQXsT8obD16EVViK84wcm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033208; c=relaxed/simple;
	bh=Od4ZbTbr3sZbXAyDeOXmtGglhQppl3hPFpw6ndci1Y4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f8tDcpiQbkOcjExqyK3bSSWdXDNluKEbL2ui/m3kItrs1Igp84FZh2LaraBCoHO7O/QDAbr/7dyiaxdacXu5tbdn/14t3zsyi4Kxsls0BuqdtDln56xJ4R1BZZzh1O3IkWe1KT1VG9aismgNUi8mdICZcZxcZgm+PWenAsZOS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=Xs5VoxTz; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1731033206;
	bh=Od4ZbTbr3sZbXAyDeOXmtGglhQppl3hPFpw6ndci1Y4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Xs5VoxTzsh+wgWcpPl81Hpsr2ta0KGRlNHZ6jJDMaqFKLUa9cTvb31WWRaKcSYlSL
	 IUvpxmAKmSe5/cgxdJNWUuY7gMcw4rSXDQYb2LzTFk+mP+LacgWYBK3COQZGi7gUmg
	 D14SO6OoHvTAjK/WsHCgMpICGdFP3s5qCXoavkTQ=
Received: by gentwo.org (Postfix, from userid 1003)
	id 7BBBA4027B; Thu,  7 Nov 2024 18:33:26 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7A009400CA;
	Thu,  7 Nov 2024 18:33:26 -0800 (PST)
Date: Thu, 7 Nov 2024 18:33:26 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
    tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
    dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    pbonzini@redhat.com, vkuznets@redhat.com, rafael@kernel.org, 
    daniel.lezcano@linaro.org, peterz@infradead.org, arnd@arndb.de, 
    lenb@kernel.org, mark.rutland@arm.com, harisokn@amazon.com, 
    mtosatti@redhat.com, sudeep.holla@arm.com, maz@kernel.org, 
    misono.tomohiro@fujitsu.com, maobibo@loongson.cn, zhenglifeng1@huawei.com, 
    joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
    konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/15] asm-generic: add barrier
 smp_cond_load_relaxed_timeout()
In-Reply-To: <20241107190818.522639-2-ankur.a.arora@oracle.com>
Message-ID: <9cecd8a5-82e5-69ef-502b-45219a45006b@gentwo.org>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com> <20241107190818.522639-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 7 Nov 2024, Ankur Arora wrote:

> +#ifndef smp_cond_time_check_count
> +/*
> + * Limit how often smp_cond_load_relaxed_timeout() evaluates time_expr_ns.
> + * This helps reduce the number of instructions executed while spin-waiting.
> + */
> +#define smp_cond_time_check_count	200
> +#endif

I dont like these loops that execute differently depending on the
hardware. Can we use cycles and ns instead to have defined periods of
time? Later patches establish the infrastructure to convert cycles to
nanoseconds and microseconds. Use that?

> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr_ns,	\
> +				      time_limit_ns) ({			\
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

Calling the clock retrieval function repeatedly should be fine and is
typically done in user space as well as in kernel space for functions that
need to wait short time periods.


