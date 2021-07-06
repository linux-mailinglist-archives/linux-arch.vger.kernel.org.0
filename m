Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B493BD68B
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhGFMh0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 08:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbhGFMM2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 08:12:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78520C041B05
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QH2eOdKlEUzaZ9JTroRMLGhonjOCl6tOkXx7tR2+aYc=; b=CL6mBITGgYLe+Ij/jaS90WjMOZ
        vlW3R77Bp3AXRT4iwuc13+XdemMiD1WbHVPvpGipAHuOWoW+29Lrd3Ev/asfbWAlGq7o/bI428RUV
        UUYLXerFKENyQ156e0ka0bGu5+d6K2au436vCI/wSh+cRGeHSgk+45L92ETKi9smx1vFnatNP1EaL
        aZ38uIZ0OB+AX6038xSS5n5E/7mGnZ9fddJbmc/vyF2nX/RDySN5Y280eG3yDsM402jTNDOYl7eV5
        vlIHf2XZlwxc4pX8PVNoH7lLm8bmnYBBwthaqfGD7Chuum+OPR78SqH4+cv733PaiuIrfUKNgOn7R
        DAfXS9Ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0jgy-00F2AG-CD; Tue, 06 Jul 2021 11:56:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4708E300233;
        Tue,  6 Jul 2021 13:56:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BABF2081181C; Tue,  6 Jul 2021 13:56:42 +0200 (CEST)
Date:   Tue, 6 Jul 2021 13:56:42 +0200
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
Message-ID: <YORE+uqJzu3sL3Tf@hirez.programming.kicks-ass.net>
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
> diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
> index ea5979872485..ea3c3e7808dc 100644
> --- a/arch/loongarch/include/asm/percpu.h
> +++ b/arch/loongarch/include/asm/percpu.h
> @@ -5,6 +5,8 @@
>  #ifndef __ASM_PERCPU_H
>  #define __ASM_PERCPU_H
>  
> +#include <asm/cmpxchg.h>
> +
>  /* Use r21 for fast access */
>  register unsigned long __my_cpu_offset __asm__("$r21");
>  
> @@ -15,6 +17,181 @@ static inline void set_my_cpu_offset(unsigned long off)
>  }
>  #define __my_cpu_offset __my_cpu_offset
>  
> +#define PERCPU_OP(op, asm_op, c_op)					\
> +static inline unsigned long __percpu_##op(void *ptr,			\
> +			unsigned long val, int size)			\
> +{									\
> +	unsigned long ret;						\
> +									\
> +	switch (size) {							\
> +	case 4:								\
> +		__asm__ __volatile__(					\
> +		"am"#asm_op".w"	" %[ret], %[val], %[ptr]	\n"		\
> +		: [ret] "=&r" (ret), [ptr] "+ZB"(*(u32 *)ptr)		\
> +		: [val] "r" (val));					\
> +		break;							\
> +	case 8:								\
> +		__asm__ __volatile__(					\
> +		"am"#asm_op".d" " %[ret], %[val], %[ptr]	\n"		\
> +		: [ret] "=&r" (ret), [ptr] "+ZB"(*(u64 *)ptr)		\
> +		: [val] "r" (val));					\
> +		break;							\
> +	default:							\
> +		ret = 0;						\
> +		BUILD_BUG();						\
> +	}								\
> +									\
> +	return ret c_op val;						\
> +}
> +
> +PERCPU_OP(add, add, +)
> +PERCPU_OP(and, and, &)
> +PERCPU_OP(or, or, |)
> +#undef PERCPU_OP
> +
> +static inline unsigned long __percpu_read(void *ptr, int size)
> +{
> +	unsigned long ret;
> +
> +	switch (size) {
> +	case 1:
> +		ret = READ_ONCE(*(u8 *)ptr);
> +		break;
> +	case 2:
> +		ret = READ_ONCE(*(u16 *)ptr);
> +		break;
> +	case 4:
> +		ret = READ_ONCE(*(u32 *)ptr);
> +		break;
> +	case 8:
> +		ret = READ_ONCE(*(u64 *)ptr);
> +		break;
> +	default:
> +		ret = 0;
> +		BUILD_BUG();
> +	}
> +
> +	return ret;
> +}
> +
> +static inline void __percpu_write(void *ptr, unsigned long val, int size)
> +{
> +	switch (size) {
> +	case 1:
> +		WRITE_ONCE(*(u8 *)ptr, (u8)val);
> +		break;
> +	case 2:
> +		WRITE_ONCE(*(u16 *)ptr, (u16)val);
> +		break;
> +	case 4:
> +		WRITE_ONCE(*(u32 *)ptr, (u32)val);
> +		break;
> +	case 8:
> +		WRITE_ONCE(*(u64 *)ptr, (u64)val);
> +		break;
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +
> +static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
> +						int size)
> +{
> +	switch (size) {
> +	case 1:
> +	case 2:
> +		return __xchg_small((volatile void *)ptr, val, size);
> +
> +	case 4:
> +		return __xchg_asm("amswap.w", (volatile u32 *)ptr, (u32)val);
> +
> +	case 8:
> +		if (!IS_ENABLED(CONFIG_64BIT))
> +			return __xchg_called_with_bad_pointer();
> +
> +		return __xchg_asm("amswap.d", (volatile u64 *)ptr, (u64)val);
> +
> +	default:
> +		return __xchg_called_with_bad_pointer();
> +	}
> +}
> +
> +/* this_cpu_cmpxchg */
> +#define _protect_cmpxchg_local(pcp, o, n)			\
> +({								\
> +	typeof(*raw_cpu_ptr(&(pcp))) __ret;			\
> +	__ret = cmpxchg_local(raw_cpu_ptr(&(pcp)), o, n);	\
> +	__ret;							\
> +})
> +
> +#define this_cpu_cmpxchg_1(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> +#define this_cpu_cmpxchg_2(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> +#define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> +#define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> +
> +#define _percpu_read(pcp)						\
> +({									\
> +	typeof(pcp) __retval;						\
> +	__retval = (typeof(pcp))__percpu_read(raw_cpu_ptr(&(pcp)),	\
> +					      sizeof(pcp));		\
> +	__retval;							\
> +})
> +
> +#define _percpu_write(pcp, val)						\
> +do {									\
> +	__percpu_write(raw_cpu_ptr(&(pcp)), (unsigned long)(val),	\
> +				sizeof(pcp));				\
> +} while (0)								\
> +
> +#define _pcp_protect(operation, pcp, val)			\
> +({								\
> +	typeof(pcp) __retval;					\
> +	__retval = (typeof(pcp))operation(raw_cpu_ptr(&(pcp)),	\
> +					  (val), sizeof(pcp));	\
> +	__retval;						\
> +})
> +
> +#define _percpu_add(pcp, val) \
> +	_pcp_protect(__percpu_add, pcp, val)
> +
> +#define _percpu_add_return(pcp, val) _percpu_add(pcp, val)
> +
> +#define _percpu_and(pcp, val) \
> +	_pcp_protect(__percpu_and, pcp, val)
> +
> +#define _percpu_or(pcp, val) \
> +	_pcp_protect(__percpu_or, pcp, val)
> +
> +#define _percpu_xchg(pcp, val) ((typeof(pcp)) \
> +	_pcp_protect(__percpu_xchg, pcp, (unsigned long)(val)))
> +
> +#define this_cpu_add_4(pcp, val) _percpu_add(pcp, val)
> +#define this_cpu_add_8(pcp, val) _percpu_add(pcp, val)
> +
> +#define this_cpu_add_return_4(pcp, val) _percpu_add_return(pcp, val)
> +#define this_cpu_add_return_8(pcp, val) _percpu_add_return(pcp, val)
> +
> +#define this_cpu_and_4(pcp, val) _percpu_and(pcp, val)
> +#define this_cpu_and_8(pcp, val) _percpu_and(pcp, val)
> +
> +#define this_cpu_or_4(pcp, val) _percpu_or(pcp, val)
> +#define this_cpu_or_8(pcp, val) _percpu_or(pcp, val)
> +
> +#define this_cpu_read_1(pcp) _percpu_read(pcp)
> +#define this_cpu_read_2(pcp) _percpu_read(pcp)
> +#define this_cpu_read_4(pcp) _percpu_read(pcp)
> +#define this_cpu_read_8(pcp) _percpu_read(pcp)
> +
> +#define this_cpu_write_1(pcp, val) _percpu_write(pcp, val)
> +#define this_cpu_write_2(pcp, val) _percpu_write(pcp, val)
> +#define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
> +#define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
> +
> +#define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
> +#define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)
> +#define this_cpu_xchg_4(pcp, val) _percpu_xchg(pcp, val)
> +#define this_cpu_xchg_8(pcp, val) _percpu_xchg(pcp, val)
> +
>  #include <asm-generic/percpu.h>
>  
>  #endif /* __ASM_PERCPU_H */

Sadness :-( You could've extended your LL/SC instructions to have an
extra address register like PowerPC does. Then per-cpu can be done like:

1:	ll.w	%1, %2, r21
	...
	sc.w	%1, %2, r21
	bne	$zero, %1, 1b

Also AFAICT there is no NMI on this thing (even though you select
HAVE_NMI, I've not found any actual NMI code). So what is the
performance of CSR_CRMD_IE toggles vs using AMOs ?


