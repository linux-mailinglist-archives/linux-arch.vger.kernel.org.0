Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0643BD43B
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbhGFMFq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 08:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242220AbhGFMCV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 08:02:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1D6C0612FC
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FQ0Rt4ADicxMRIDuiknM9c5llFRaqB7OnvRwoRZLApA=; b=kNtu5xsz8ixACKTwJKYcp6g3qG
        t1cwa60fjUblWu7/fMF4BLvME3tCPuecIK8vwsqVuwr7JYZ3TuadgdjHmtWr0BGvcgJ/B9YSFXDvC
        buVRKfFeKE1yYQ0M7CX1jFpZ0K8NUT3z4WShadER/2hanOdsmULRxwJ1iOnLbwtZjmLPMRHRuvlBO
        TaabpJDDQUq7cFE/zCqp1dF/BZlsknBJlj7ems00hqTOb31jVH1yTom/NmfQizLrcXiIvb9xgu98Y
        SAPGea5xx5+65jo6T8KSX4+YpdNkgJiDldfigjudozT3iTstZO/dhHMRTEDzjLER0m6ET8u0Jad2L
        PJ9fOehQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0jJH-00BChh-NX; Tue, 06 Jul 2021 11:32:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50C913001DC;
        Tue,  6 Jul 2021 13:32:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 438A3200843AD; Tue,  6 Jul 2021 13:32:15 +0200 (CEST)
Date:   Tue, 6 Jul 2021 13:32:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 17/19] LoongArch: Add multi-processor (SMP) support
Message-ID: <YOQ/P/C7yfgCeKct@hirez.programming.kicks-ass.net>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-18-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706041820.1536502-18-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 06, 2021 at 12:18:18PM +0800, Huacai Chen wrote:
> diff --git a/arch/loongarch/include/asm/barrier.h b/arch/loongarch/include/asm/barrier.h
> index 8ab8d8f15b88..ad09a3b31cba 100644
> --- a/arch/loongarch/include/asm/barrier.h
> +++ b/arch/loongarch/include/asm/barrier.h
> @@ -20,6 +20,19 @@
>  #define mb()		fast_mb()
>  #define iob()		fast_iob()
>  
> +#define __smp_mb()	__asm__ __volatile__("dbar 0" : : : "memory")
> +#define __smp_rmb()	__asm__ __volatile__("dbar 0" : : : "memory")
> +#define __smp_wmb()	__asm__ __volatile__("dbar 0" : : : "memory")

:-(

> +
> +#ifdef CONFIG_SMP
> +#define __WEAK_LLSC_MB		"	dbar 0  \n"
> +#else
> +#define __WEAK_LLSC_MB		"		\n"
> +#endif

Isn't that spelled smp_mb() ?

> +
> +#define __smp_mb__before_atomic()	barrier()
> +#define __smp_mb__after_atomic()	__smp_mb()

Clarification please.

Does this imply LL is sequentially consistent, while SC is not?

> +
>  /**
>   * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
>   * @index: array element index
> @@ -48,6 +61,112 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
>  	return mask;
>  }
>  
> +#define __smp_load_acquire(p)							\
> +({										\
> +	union { typeof(*p) __val; char __c[1]; } __u;				\
> +	unsigned long __tmp = 0;							\
> +	compiletime_assert_atomic_type(*p);					\
> +	switch (sizeof(*p)) {							\
> +	case 1:									\
> +		*(__u8 *)__u.__c = *(volatile __u8 *)p;				\
> +		__smp_mb();							\
> +		break;								\
> +	case 2:									\
> +		*(__u16 *)__u.__c = *(volatile __u16 *)p;			\
> +		__smp_mb();							\
> +		break;								\
> +	case 4:									\
> +		__asm__ __volatile__(						\
> +		"amor.w %[val], %[tmp], %[mem]	\n"				\
> +		: [val] "=&r" (*(__u32 *)__u.__c)				\
> +		: [mem] "ZB" (*(u32 *) p), [tmp] "r" (__tmp)			\
> +		: "memory");							\
> +		break;								\
> +	case 8:									\
> +		__asm__ __volatile__(						\
> +		"amor.d %[val], %[tmp], %[mem]	\n"				\
> +		: [val] "=&r" (*(__u64 *)__u.__c)				\
> +		: [mem] "ZB" (*(u64 *) p), [tmp] "r" (__tmp)			\
> +		: "memory");							\
> +		break;								\
> +	default:								\
> +		barrier();							\
> +		__builtin_memcpy((void *)__u.__c, (const void *)p, sizeof(*p));	\
> +		__smp_mb();							\
> +	}									\
> +	__u.__val;								\
> +})
> +
> +#define __smp_store_release(p, v)						\
> +do {										\
> +	union { typeof(*p) __val; char __c[1]; } __u =				\
> +		{ .__val = (__force typeof(*p)) (v) };				\
> +	unsigned long __tmp;							\
> +	compiletime_assert_atomic_type(*p);					\
> +	switch (sizeof(*p)) {							\
> +	case 1:									\
> +		__smp_mb();							\
> +		*(volatile __u8 *)p = *(__u8 *)__u.__c;				\
> +		break;								\
> +	case 2:									\
> +		__smp_mb();							\
> +		*(volatile __u16 *)p = *(__u16 *)__u.__c;			\
> +		break;								\
> +	case 4:									\
> +		__asm__ __volatile__(						\
> +		"amswap.w %[tmp], %[val], %[mem]	\n"			\
> +		: [mem] "+ZB" (*(u32 *)p), [tmp] "=&r" (__tmp)			\
> +		: [val] "r" (*(__u32 *)__u.__c)					\
> +		: );								\
> +		break;								\
> +	case 8:									\
> +		__asm__ __volatile__(						\
> +		"amswap.d %[tmp], %[val], %[mem]	\n"			\
> +		: [mem] "+ZB" (*(u64 *)p), [tmp] "=&r" (__tmp)			\
> +		: [val] "r" (*(__u64 *)__u.__c)					\
> +		: );								\
> +		break;								\
> +	default:								\
> +		__smp_mb();							\
> +		__builtin_memcpy((void *)p, (const void *)__u.__c, sizeof(*p));	\
> +		barrier();							\
> +	}									\
> +} while (0)

What's the actual ordering of those AMO things?

