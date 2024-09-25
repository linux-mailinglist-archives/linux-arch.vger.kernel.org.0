Return-Path: <linux-arch+bounces-7397-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA18985369
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 09:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A492C1F21ED7
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 07:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB6C155300;
	Wed, 25 Sep 2024 07:09:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA68132103;
	Wed, 25 Sep 2024 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248144; cv=none; b=YPek7LcFzmhhu9rJo1tGpuY6peNZ7VMZthNT1CjBsnwM40iqrS7CKjk8TxNiDMUkn2nB1OSHFA7SSZV2jC7G9wAED+SxAD9SOIJOC5cBpn3FS34v04NfTvxZR4rNWAyBLOhLS+iTX/sPuoMMU8km2a/dkAUkh0pPJQngM7QDbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248144; c=relaxed/simple;
	bh=1VRMxsV1T0yeplH6qQsbT5SNdj7O1rTqbm5gQDChpfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AI6Dv+71Nsq1HvamJ8C46x4aTLSCbuFuBmYjASDgKTQyXjdF5KQXr9MIjFn8P4dZsP3znrzii+Cqy6jTRR3vuVBeGHpeQ35xketMvBzbaw3rDGR326w4kuByJnSQ7wCrwTPEY4kX7qcRV83GinyT9a4YbPL+KgB+DnqQKjdPLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XD7BP385Pz9sSt;
	Wed, 25 Sep 2024 09:09:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ofayadwilK7M; Wed, 25 Sep 2024 09:09:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XD7BP28JFz9sSp;
	Wed, 25 Sep 2024 09:09:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 355CF8B76E;
	Wed, 25 Sep 2024 09:09:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id zc9XJ1vndXU7; Wed, 25 Sep 2024 09:09:01 +0200 (CEST)
Received: from [192.168.232.90] (PO27091.IDSI0.si.c-s.fr [192.168.232.90])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F6388B763;
	Wed, 25 Sep 2024 09:09:00 +0200 (CEST)
Message-ID: <7c3bfb87-40e8-45ef-86a7-53f02053d9b3@csgroup.eu>
Date: Wed, 25 Sep 2024 09:09:00 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] vdso: Modify getrandom to include the correct
 namespace.
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-9-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240923141943.133551-9-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/09/2024 à 16:19, Vincenzo Frascino a écrit :
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
> 
> Modify getrandom to take advantage of the refactoring done in the
> previous patches and to include only the vdso/ namespace.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   include/vdso/datapage.h |  1 +
>   lib/vdso/getrandom.c    | 22 +++++++++++-----------
>   2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index b7d6c71f20c1..127f0c51bf01 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -5,6 +5,7 @@
>   #ifndef __ASSEMBLY__
>   
>   #include <linux/compiler.h>
> +#include <linux/build_bug.h>

What in this datapage.h requires this build_bug header ?

>   #include <uapi/linux/time.h>
>   #include <uapi/linux/types.h>
>   #include <uapi/asm-generic/errno-base.h>
> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> index 938ca539aaa6..e15d3cf768c9 100644
> --- a/lib/vdso/getrandom.c
> +++ b/lib/vdso/getrandom.c
> @@ -3,19 +3,19 @@
>    * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>    */
>   
> -#include <linux/array_size.h>
> -#include <linux/minmax.h>
>   #include <vdso/datapage.h>
>   #include <vdso/getrandom.h>
>   #include <vdso/unaligned.h>
> -#include <asm/vdso/getrandom.h>
> -#include <uapi/linux/mman.h>
> -#include <uapi/linux/random.h>
> +#include <vdso/mman.h>

This change is not needed, asm/vdso/getrandom.h is in VDSO namespace, 
and the other two are UAPI headers which must be safe to include in VDSO 
code as VDSO code in userland code.

> +#include <vdso/page.h>
>   
> -#undef PAGE_SIZE
> -#undef PAGE_MASK
> -#define PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
> -#define PAGE_MASK (~(PAGE_SIZE - 1))
> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(x)	(sizeof(x) / sizeof(*x))
> +#endif
> +
> +#ifndef min_t
> +#define min_t(type,a,b)	((type)(a) < (type)(b) ? (type)(a) : (type)(b))
> +#endif

Would be better to force undefine/redefine ARRAY_SIZE and min_t instead 
of defining them only when they don't exist already.

>   
>   #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
>   	while (len >= sizeof(type)) {						\
> @@ -79,8 +79,8 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
>   	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags)) {
>   		struct vgetrandom_opaque_params *params = opaque_state;
>   		params->size_of_opaque_state = sizeof(*state);
> -		params->mmap_prot = PROT_READ | PROT_WRITE;
> -		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
> +		params->mmap_prot = VDSO_MMAP_PROT;
> +		params->mmap_flags = VDSO_MMAP_FLAGS;

At the time being the flags and prot are the same for all architectures, 
there is no point in introducing VDSO_MMAP_PROT and VDSO_MMAP_FLAGS. 
Maybe one day that may be needed, but until that day nothing should be 
changed, unless you already have in mind and describe an architecture 
that will need that.

Christophe

>   		for (size_t i = 0; i < ARRAY_SIZE(params->reserved); ++i)
>   			params->reserved[i] = 0;
>   		return 0;

