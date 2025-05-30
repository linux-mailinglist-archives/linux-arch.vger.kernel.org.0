Return-Path: <linux-arch+bounces-12154-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD09CAC8FBA
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 15:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60759A472B0
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423E230BEF;
	Fri, 30 May 2025 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="LZuKJciB"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3147221284;
	Fri, 30 May 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748610027; cv=none; b=RnPSJVSYx9UyOrqEg18O3xD/bnNdRiSopkYDH58qH3xlbQfvWFhkMTIo2fFQvbm+6OCPSPefyar/DIfYboizure6nlc0HpIH1owhxshCIgZCaF2DRurfe8+2UKFdAoqbmQjbpQn6lGtmvQFBUqulYlMtjd9AukShiXs692ltEXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748610027; c=relaxed/simple;
	bh=T+OEmxv4J0qEHrsrXNoMzpOdzkKba5AgMllsp9lYsx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mctsQ5GAlP4LSzETRkbyi7J0+BqSx9NYQnnWk1aee5VLH0aWOa4sGRu807TtonU1npOXGh4IuMK5pVrKT0QEjpgKIK/ta4T57CRFb7zUA+3VmiEaqaeV3WsMYQcoovtq5Sq8LDzCxLHZ6oTxogZ1TcI4K+8zArHMWb8YJ7SfRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=LZuKJciB; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bihCPqd3yys+0oVI42gyEllVUwau8wuXsXIWD+Mom+Q=; b=LZuKJciBbgPV0UAKtKR86du7NZ
	9dv05cnZKyx0LPaEry2mw1v+bhNPEVyZCrjeC1we/g2oF720rDkPxaIDHt3rfQXJKxe7L/6Yyi9BG
	BNpyYAVgZWAjqgl7gx1x8wzvXKl/9URkOfJiLgCnuStCGiUrazWSOfAuYz4+MUwiFQJyaB0NTkpG+
	zvObqby4OKSUSFBG86mGGSv7qNQrhk44IjH3HRBxGIjKAWRLWQBOBmHXzEtJ1vElaY1jKs4CySPxV
	TaTc6m1uanD6dJlBty2XFn8aJ2bj0BFBrhBzR7NoL1/3t8kz79VnMV5h+ndC583aN1+9T2Ks9/DKD
	qfw5TbMA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uKzLD-009mtO-2A;
	Fri, 30 May 2025 21:00:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 May 2025 21:00:07 +0800
Date: Fri, 30 May 2025 21:00:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@gmail.com>,
	linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: Add sched.h inclusion in simd.h
Message-ID: <aDmr1xaMlcYU9xYx@gondor.apana.org.au>
References: <20250530041658.909576-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530041658.909576-1-chenhuacai@loongson.cn>

On Fri, May 30, 2025 at 12:16:58PM +0800, Huacai Chen wrote:
> Commit 7ba8df47810f073 ("asm-generic: Make simd.h more resilient")
> causes a build error for PREEMPT_RT kernels:
> 
>   CC      lib/crypto/sha256.o
> In file included from ./include/asm-generic/simd.h:6,
>                  from ./arch/loongarch/include/generated/asm/simd.h:1,
>                  from ./include/crypto/internal/simd.h:9,
>                  from ./include/crypto/internal/sha2.h:6,
>                  from lib/crypto/sha256.c:15:
> ./include/asm-generic/simd.h: In function 'may_use_simd':
> ./include/linux/preempt.h:111:34: error: 'current' undeclared (first use in this function)
>   111 | # define softirq_count()        (current->softirq_disable_cnt & SOFTIRQ_MASK)
>       |                                  ^~~~~~~
> ./include/linux/preempt.h:112:82: note: in expansion of macro 'softirq_count'
>   112 | # define irq_count()            ((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | softirq_count())
>       |                                                                                  ^~~~~~~~~~~~~
> ./include/linux/preempt.h:143:34: note: in expansion of macro 'irq_count'
>   143 | #define in_interrupt()          (irq_count())
>       |                                  ^~~~~~~~~
> ./include/asm-generic/simd.h:18:17: note: in expansion of macro 'in_interrupt'
>    18 |         return !in_interrupt();
>       |                 ^~~~~~~~~~~~
> 
> So add sched.h inclusion in simd.h to fix it.
> 
> Fixes: 7ba8df47810f073 ("asm-generic: Make simd.h more resilient")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  include/asm-generic/simd.h | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

