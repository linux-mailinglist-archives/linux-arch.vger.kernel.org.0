Return-Path: <linux-arch+bounces-7033-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694096C567
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 19:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5715F1C20A5F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0A7E563;
	Wed,  4 Sep 2024 17:27:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FCB10A12;
	Wed,  4 Sep 2024 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470822; cv=none; b=RNm1rNsx9xyeXCCTPYI0tZMhW0IAz+c4MxfrUmT1nj2zSMyQIYbz9o7eEGPR2U7H4qQOaOY8rLvX3bdsOpPbBWaCY5y0EJgExG0UkPNfVjGW301Rjy/aSKSRjVfMUsrAjpsVd/GC2VegOzHhSu8u8FOT/fcPsVNwpB3zasNwx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470822; c=relaxed/simple;
	bh=x5UWK4tq3vfEQd6AfQd7ddjKoEFsxO1Siq4LgZPbl8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbX8xk6mQN1IWyod5A3Bb6VtbHjzVY45xStNHN4pwIAtCL/1rvl5rZ1IswrmXneWS4kNzhCDxh+frFSy0ItJxfX/GQ9GgCA2nu9oiZvtX6BJRP04OU/Bejvoo/inHUP7oGoplkz1oBEvxg99cRIfWVOCvD8lghivVVO5bXwyqkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzTv604t4z9sSX;
	Wed,  4 Sep 2024 19:26:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6RUWDAoBkJa; Wed,  4 Sep 2024 19:26:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzTv55sdgz9sSC;
	Wed,  4 Sep 2024 19:26:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AF0A08B77A;
	Wed,  4 Sep 2024 19:26:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Dk3TEmDg0kec; Wed,  4 Sep 2024 19:26:57 +0200 (CEST)
Received: from [192.168.234.246] (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C6F468B778;
	Wed,  4 Sep 2024 19:26:56 +0200 (CEST)
Message-ID: <b899bce8-8704-4288-9f32-bcb2fa0d29a8@csgroup.eu>
Date: Wed, 4 Sep 2024 19:26:56 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] vdso: Modify getrandom to include the correct
 namespace
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
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-10-vincenzo.frascino@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240903151437.1002990-10-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
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
>   lib/vdso/getrandom.c | 22 ++++++++--------------
>   1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> index 938ca539aaa6..9c26b738e4a1 100644
> --- a/lib/vdso/getrandom.c
> +++ b/lib/vdso/getrandom.c
> @@ -3,19 +3,13 @@
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

Now build fails on powerpc because struct vgetrandom_opaque_params is 
unknown.

x86 get it by chance via the following header inclusion chain:

In file included from ./include/linux/random.h:10,
                  from ./include/linux/nodemask.h:98,
                  from ./include/linux/mmzone.h:18,
                  from ./include/linux/gfp.h:7,
                  from ./include/linux/xarray.h:16,
                  from ./include/linux/radix-tree.h:21,
                  from ./include/linux/idr.h:15,
                  from ./include/linux/kernfs.h:12,
                  from ./include/linux/sysfs.h:16,
                  from ./include/linux/kobject.h:20,
                  from ./include/linux/of.h:18,
                  from ./include/linux/clocksource.h:19,
                  from ./include/clocksource/hyperv_timer.h:16,
                  from ./arch/x86/include/asm/vdso/gettimeofday.h:21,
                  from ./include/vdso/datapage.h:164,
                  from 
arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:7,
                  from arch/x86/entry/vdso/vgetrandom.c:7:




> -
> -#undef PAGE_SIZE
> -#undef PAGE_MASK
> -#define PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
> -#define PAGE_MASK (~(PAGE_SIZE - 1))
> +#include <vdso/mman.h>
> +#include <vdso/page.h>
> +#include <vdso/array_size.h>
> +#include <vdso/minmax.h>
>   
>   #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
>   	while (len >= sizeof(type)) {						\
> @@ -68,7 +62,7 @@ static __always_inline ssize_t
>   __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
>   		       unsigned int flags, void *opaque_state, size_t opaque_len)
>   {
> -	ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
> +	ssize_t ret = min_t(size_t, INT_MAX & VDSO_PAGE_MASK /* = MAX_RW_COUNT */, len);
>   	struct vgetrandom_state *state = opaque_state;
>   	size_t batch_len, nblocks, orig_len = len;
>   	bool in_use, have_retried = false;
> @@ -79,15 +73,15 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
>   	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags)) {
>   		struct vgetrandom_opaque_params *params = opaque_state;
>   		params->size_of_opaque_state = sizeof(*state);
> -		params->mmap_prot = PROT_READ | PROT_WRITE;
> -		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
> +		params->mmap_prot = VDSO_MMAP_PROT;
> +		params->mmap_flags = VDSO_MMAP_FLAGS;
>   		for (size_t i = 0; i < ARRAY_SIZE(params->reserved); ++i)
>   			params->reserved[i] = 0;
>   		return 0;
>   	}
>   
>   	/* The state must not straddle a page, since pages can be zeroed at any time. */
> -	if (unlikely(((unsigned long)opaque_state & ~PAGE_MASK) + sizeof(*state) > PAGE_SIZE))
> +	if (unlikely(((unsigned long)opaque_state & ~VDSO_PAGE_MASK) + sizeof(*state) > VDSO_PAGE_SIZE))
>   		return -EFAULT;
>   
>   	/* Handle unexpected flags by falling back to the kernel. */

