Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFE041EB5E
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 13:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353726AbhJALHR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 07:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353687AbhJALHQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 07:07:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4574CC06177B;
        Fri,  1 Oct 2021 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kqf+SxOZxysQrD9yVCK3XWKIZqTOrvElMEJcFnO6Sdw=; b=NH+urkeLlLDHqorPL0dmYhRVBy
        zI+yi/vuaSwngNiiOU/5Dik2rse2sbDHHh6HkPYiELiaqynxSH3jFRlj+Xc+NqvEbg1NgDlwL3nCz
        +XQu0BaMnkaW2tBqx1tM/OH6Yi1xGG5pwCdgMzT5Mnz4/9VmszvpHvMM/sBLnM+/XrCI++buEZvI9
        NVIjWFOCkg6+/43jzNJm4+nqTebqP+M7NdzlL2sSw71krMHqHE1Rs1e/msnc0z9z+WyGYoJokJgVt
        VidlCZ2FqNX8m6mUrF8A/sI7VxEkB+1hrpuJqqCv9RtIkcG4WSxBnYckFzndFWi3dIFGR9PCqYJrr
        W1Ufy2Wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWGK7-00DnCk-J1; Fri, 01 Oct 2021 11:03:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73DD7300299;
        Fri,  1 Oct 2021 13:03:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B1B726717AC7; Fri,  1 Oct 2021 13:03:26 +0200 (CEST)
Date:   Fri, 1 Oct 2021 13:03:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V4 16/22] LoongArch: Add misc common routines
Message-ID: <YVbq/kAZQimL3Vpc@hirez.programming.kicks-ass.net>
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-17-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927064300.624279-17-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 27, 2021 at 02:42:53PM +0800, Huacai Chen wrote:
>  arch/loongarch/include/asm/cmpxchg.h     | 137 ++++++++++++
>  arch/loongarch/kernel/cmpxchg.c          | 107 ++++++++++

This really should have gone into the atomics/locking patch.

> diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
> new file mode 100644
> index 000000000000..13ee1b62dc12
> --- /dev/null
> +++ b/arch/loongarch/include/asm/cmpxchg.h
> @@ -0,0 +1,137 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_CMPXCHG_H
> +#define __ASM_CMPXCHG_H
> +
> +#include <linux/bug.h>
> +#include <asm/barrier.h>
> +#include <asm/compiler.h>
> +
> +#define __xchg_asm(amswap_db, m, val)		\
> +({						\
> +		__typeof(val) __ret;		\
> +						\
> +		__asm__ __volatile__ (		\
> +		" "amswap_db" %1, %z2, %0 \n"	\
> +		: "+ZB" (*m), "=&r" (__ret)	\
> +		: "Jr" (val)			\
> +		: "memory");			\
> +						\
> +		__ret;				\
> +})
> +
> +extern unsigned long __xchg_small(volatile void *ptr, unsigned long x,
> +				  unsigned int size);
> +
> +static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
> +				   int size)
> +{
> +	switch (size) {
> +	case 1:
> +	case 2:
> +		return __xchg_small(ptr, x, size);
> +
> +	case 4:
> +		return __xchg_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
> +
> +	case 8:
> +		return __xchg_asm("amswap_db.d", (volatile u64 *)ptr, (u64)x);
> +
> +	default:
> +		BUILD_BUG();
> +	}
> +
> +	return 0;
> +}
> +
> +#define arch_xchg(ptr, x)						\
> +({									\
> +	__typeof__(*(ptr)) __res;					\
> +									\
> +	__res = (__typeof__(*(ptr)))					\
> +		__xchg((ptr), (unsigned long)(x), sizeof(*(ptr)));	\
> +									\
> +	__res;								\
> +})
> +
> +#define __cmpxchg_asm(ld, st, m, old, new)				\
> +({									\
> +	__typeof(old) __ret;						\
> +									\
> +	__asm__ __volatile__(						\
> +	"1:	" ld "	%0, %2		# __cmpxchg_asm \n"		\
> +	"	bne	%0, %z3, 2f			\n"		\
> +	"	or	$t0, %z4, $zero			\n"		\
> +	"	" st "	$t0, %1				\n"		\
> +	"	beq	$zero, $t0, 1b			\n"		\
> +	"2:						\n"		\
> +	: "=&r" (__ret), "=ZB"(*m)					\
> +	: "ZB"(*m), "Jr" (old), "Jr" (new)				\
> +	: "t0", "memory");						\
> +									\
> +	__ret;								\
> +})
> +
> +extern unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
> +				     unsigned long new, unsigned int size);
> +
> +static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> +				      unsigned long new, unsigned int size)
> +{
> +	switch (size) {
> +	case 1:
> +	case 2:
> +		return __cmpxchg_small(ptr, old, new, size);
> +
> +	case 4:
> +		return __cmpxchg_asm("ll.w", "sc.w", (volatile u32 *)ptr,
> +				     (u32)old, new);
> +
> +	case 8:
> +		return __cmpxchg_asm("ll.d", "sc.d", (volatile u64 *)ptr,
> +				     (u64)old, new);
> +
> +	default:
> +		BUILD_BUG();
> +	}
> +
> +	return 0;
> +}
> +
> +#define arch_cmpxchg_local(ptr, old, new)				\
> +	((__typeof__(*(ptr)))						\
> +		__cmpxchg((ptr),					\
> +			  (unsigned long)(__typeof__(*(ptr)))(old),	\
> +			  (unsigned long)(__typeof__(*(ptr)))(new),	\
> +			  sizeof(*(ptr))))
> +
> +#define arch_cmpxchg(ptr, old, new)					\
> +({									\
> +	__typeof__(*(ptr)) __res;					\
> +									\
> +	__res = arch_cmpxchg_local((ptr), (old), (new));		\
> +									\
> +	__res;								\
> +})
> +
> +#ifdef CONFIG_64BIT
> +#define arch_cmpxchg64_local(ptr, o, n)					\
> +  ({									\
> +	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
> +	arch_cmpxchg_local((ptr), (o), (n));				\
> +  })
> +
> +#define arch_cmpxchg64(ptr, o, n)					\
> +  ({									\
> +	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
> +	arch_cmpxchg((ptr), (o), (n));					\
> +  })
> +#else
> +#include <asm-generic/cmpxchg-local.h>
> +#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
> +#define arch_cmpxchg64(ptr, o, n) arch_cmpxchg64_local((ptr), (o), (n))
> +#endif
> +
> +#endif /* __ASM_CMPXCHG_H */

> diff --git a/arch/loongarch/kernel/cmpxchg.c b/arch/loongarch/kernel/cmpxchg.c
> new file mode 100644
> index 000000000000..81bb9d01a3b5
> --- /dev/null
> +++ b/arch/loongarch/kernel/cmpxchg.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + *
> + * Derived from MIPS:
> + * Copyright (C) 2017 Imagination Technologies
> + * Author: Paul Burton <paul.burton@mips.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <asm/cmpxchg.h>
> +
> +unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
> +{
> +	u32 old32, mask, temp;
> +	volatile u32 *ptr32;
> +	unsigned int shift;
> +
> +	/* Check that ptr is naturally aligned */
> +	WARN_ON((unsigned long)ptr & (size - 1));
> +
> +	/* Mask value to the correct size. */
> +	mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
> +	val &= mask;
> +
> +	/*
> +	 * Calculate a shift & mask that correspond to the value we wish to
> +	 * exchange within the naturally aligned 4 byte integerthat includes
> +	 * it.
> +	 */
> +	shift = (unsigned long)ptr & 0x3;
> +	shift *= BITS_PER_BYTE;
> +	mask <<= shift;
> +
> +	/*
> +	 * Calculate a pointer to the naturally aligned 4 byte integer that
> +	 * includes our byte of interest, and load its value.
> +	 */
> +	ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
> +
> +	asm volatile (
> +	"1:	ll.w		%0, %3		\n"
> +	"	and		%1, %0, %4	\n"
> +	"	or		%1, %1, %5	\n"
> +	"	sc.w		%1, %2		\n"
> +	"	beqz		%1, 1b		\n"
> +	: "=&r" (old32), "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*ptr32)
> +	: GCC_OFF_SMALL_ASM() (*ptr32), "Jr" (~mask), "Jr" (val << shift)
> +	: "memory");
> +
> +	return (old32 & mask) >> shift;
> +}
> +
> +unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
> +			      unsigned long new, unsigned int size)
> +{
> +	u32 mask, old32, new32, load32, load;
> +	volatile u32 *ptr32;
> +	unsigned int shift;
> +
> +	/* Check that ptr is naturally aligned */
> +	WARN_ON((unsigned long)ptr & (size - 1));
> +
> +	/* Mask inputs to the correct size. */
> +	mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
> +	old &= mask;
> +	new &= mask;
> +
> +	/*
> +	 * Calculate a shift & mask that correspond to the value we wish to
> +	 * compare & exchange within the naturally aligned 4 byte integer
> +	 * that includes it.
> +	 */
> +	shift = (unsigned long)ptr & 0x3;
> +	shift *= BITS_PER_BYTE;
> +	mask <<= shift;
> +
> +	/*
> +	 * Calculate a pointer to the naturally aligned 4 byte integer that
> +	 * includes our byte of interest, and load its value.
> +	 */
> +	ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
> +	load32 = *ptr32;
> +
> +	while (true) {
> +		/*
> +		 * Ensure the byte we want to exchange matches the expected
> +		 * old value, and if not then bail.
> +		 */
> +		load = (load32 & mask) >> shift;
> +		if (load != old)
> +			return load;
> +
> +		/*
> +		 * Calculate the old & new values of the naturally aligned
> +		 * 4 byte integer that include the byte we want to exchange.
> +		 * Attempt to exchange the old value for the new value, and
> +		 * return if we succeed.
> +		 */
> +		old32 = (load32 & ~mask) | (old << shift);
> +		new32 = (load32 & ~mask) | (new << shift);
> +		load32 = arch_cmpxchg(ptr32, old32, new32);
> +		if (load32 == old32)
> +			return old;
> +	}

This is absolutely terrible, that really wants to be a single ll/sc
loop.

> +}
