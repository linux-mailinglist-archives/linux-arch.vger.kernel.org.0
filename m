Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF55D704F34
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjEPNYj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 09:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjEPNYh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 09:24:37 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944363C3A;
        Tue, 16 May 2023 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1684243462; bh=uKBTIEyKFI5FLfb0xUDgLgLShmIFsKgpBJhdrcbHSxI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dS/iADKJuazy5XCXeDHXThViNXOIvfdFGA1wsdWRZrc1Vj7LzgIQyv+zHvT2ecS4c
         5feplLi5HdpNPlrta/E4P7ngywsMEOxlSjRNKmiRrUVyEW86MpB0sSq/BRd7k6jtQN
         6AyS0hLj1ggFps1o2+Cu71SF3UUuxaQqXNSl8BB8=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 0A332600A9;
        Tue, 16 May 2023 21:24:22 +0800 (CST)
Message-ID: <97b57aa9-b3c2-58bc-fa55-804056877d05@xen0n.name>
Date:   Tue, 16 May 2023 21:24:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] LoongArch: Support dbar with different hints
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Jun Yi <yijun@loongson.cn>
References: <20230516124536.535343-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230516124536.535343-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023/5/16 20:45, Huacai Chen wrote:
> Traditionally, LoongArch uses "dbar 0" (full completion barrier) for
> everything. But the full completion barrier is a performance killer, so
> Loongson-3A6000 and newer processors introduce different hints:

"have made finer granularity hints available"

> 
> Bit4: ordering or completion (0: completion, 1: ordering)
> Bit3: barrier for previous read (0: true, 1: false)
> Bit2: barrier for previous write (0: true, 1: false)
> Bit1: barrier for succeeding read (0: true, 1: false)
> Bit0: barrier for succedding write (0: true, 1: false)

"succeeding"

> 
> Hint 0x700: barrier for "read after read" from the same address, which
> is needed by LL-SC loops.

"needed by LL-SC loops on older models"?

> 
> This patch enable various hints for different memory barries, it brings
> performance improvements for Loongson-3A6000 series, and doesn't impact
> Loongson-3A5000 series because they treat all hints as "dbar 0".

"This patch makes use of the various new hints for different kinds of 
memory barriers. It brings performance improvements on Loongson-3A6000 
series, while not affecting the existing models because all variants are 
treated as 'dbar 0' there."

> 
> Signed-off-by: Jun Yi <yijun@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/barrier.h | 130 ++++++++++++---------------
>   arch/loongarch/include/asm/io.h      |   2 +-
>   arch/loongarch/kernel/smp.c          |   2 +-
>   arch/loongarch/mm/tlbex.S            |   6 +-
>   4 files changed, 60 insertions(+), 80 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/barrier.h b/arch/loongarch/include/asm/barrier.h
> index cda977675854..0286ae7e3636 100644
> --- a/arch/loongarch/include/asm/barrier.h
> +++ b/arch/loongarch/include/asm/barrier.h
> @@ -5,27 +5,56 @@
>   #ifndef __ASM_BARRIER_H
>   #define __ASM_BARRIER_H
>   
> -#define __sync()	__asm__ __volatile__("dbar 0" : : : "memory")
> +/*
> + * Hint types:

"Hint encoding" might be more appropriate?

> + *
> + * Bit4: ordering or completion (0: completion, 1: ordering)
> + * Bit3: barrier for previous read (0: true, 1: false)
> + * Bit2: barrier for previous write (0: true, 1: false)
> + * Bit1: barrier for succeeding read (0: true, 1: false)
> + * Bit0: barrier for succedding write (0: true, 1: false)

"succeeding"

> + *
> + * Hint 0x700: barrier for "read after read" from the same address
> + */
> +
> +#define DBAR(hint) __asm__ __volatile__("dbar %0 " : : "I"(hint) : "memory")

Why not __builtin_loongarch_dbar (should be usable with both GCC and 
Clang) or __dbar (in <larchintrin.h>)?

> +
> +#define crwrw		0b00000
> +#define cr_r_		0b00101
> +#define c_w_w		0b01010
>   
> -#define fast_wmb()	__sync()
> -#define fast_rmb()	__sync()
> -#define fast_mb()	__sync()
> -#define fast_iob()	__sync()
> -#define wbflush()	__sync()
> +#define orwrw		0b10000
> +#define or_r_		0b10101
> +#define o_w_w		0b11010
>   
> -#define wmb()		fast_wmb()
> -#define rmb()		fast_rmb()
> -#define mb()		fast_mb()
> -#define iob()		fast_iob()
> +#define orw_w		0b10010
> +#define or_rw		0b10100
>   
> -#define __smp_mb()	__asm__ __volatile__("dbar 0" : : : "memory")
> -#define __smp_rmb()	__asm__ __volatile__("dbar 0" : : : "memory")
> -#define __smp_wmb()	__asm__ __volatile__("dbar 0" : : : "memory")
> +#define c_sync()	DBAR(crwrw)
> +#define c_rsync()	DBAR(cr_r_)
> +#define c_wsync()	DBAR(c_w_w)
> +
> +#define o_sync()	DBAR(orwrw)
> +#define o_rsync()	DBAR(or_r_)
> +#define o_wsync()	DBAR(o_w_w)
> +
> +#define ldacq_mb()	DBAR(or_rw)
> +#define strel_mb()	DBAR(orw_w)
> +
> +#define mb()		c_sync()
> +#define rmb()		c_rsync()
> +#define wmb()		c_wsync()
> +#define iob()		c_sync()
> +#define wbflush()	c_sync()
> +
> +#define __smp_mb()	o_sync()
> +#define __smp_rmb()	o_rsync()
> +#define __smp_wmb()	o_wsync()
>   
>   #ifdef CONFIG_SMP
> -#define __WEAK_LLSC_MB		"	dbar 0  \n"
> +#define __WEAK_LLSC_MB		"	dbar 0x700	\n"
>   #else
> -#define __WEAK_LLSC_MB		"		\n"
> +#define __WEAK_LLSC_MB		"			\n"
>   #endif
>   
>   #define __smp_mb__before_atomic()	barrier()
> @@ -59,68 +88,19 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
>   	return mask;
>   }
>   
> -#define __smp_load_acquire(p)							\
> -({										\
> -	union { typeof(*p) __val; char __c[1]; } __u;				\
> -	unsigned long __tmp = 0;							\
> -	compiletime_assert_atomic_type(*p);					\
> -	switch (sizeof(*p)) {							\
> -	case 1:									\
> -		*(__u8 *)__u.__c = *(volatile __u8 *)p;				\
> -		__smp_mb();							\
> -		break;								\
> -	case 2:									\
> -		*(__u16 *)__u.__c = *(volatile __u16 *)p;			\
> -		__smp_mb();							\
> -		break;								\
> -	case 4:									\
> -		__asm__ __volatile__(						\
> -		"amor_db.w %[val], %[tmp], %[mem]	\n"				\
> -		: [val] "=&r" (*(__u32 *)__u.__c)				\
> -		: [mem] "ZB" (*(u32 *) p), [tmp] "r" (__tmp)			\
> -		: "memory");							\
> -		break;								\
> -	case 8:									\
> -		__asm__ __volatile__(						\
> -		"amor_db.d %[val], %[tmp], %[mem]	\n"				\
> -		: [val] "=&r" (*(__u64 *)__u.__c)				\
> -		: [mem] "ZB" (*(u64 *) p), [tmp] "r" (__tmp)			\
> -		: "memory");							\
> -		break;								\
> -	}									\
> -	(typeof(*p))__u.__val;								\
> +#define __smp_load_acquire(p)				\
> +({							\
> +	typeof(*p) ___p1 = READ_ONCE(*p);		\
> +	compiletime_assert_atomic_type(*p);		\
> +	ldacq_mb();					\
> +	___p1;						\
>   })
>   
> -#define __smp_store_release(p, v)						\
> -do {										\
> -	union { typeof(*p) __val; char __c[1]; } __u =				\
> -		{ .__val = (__force typeof(*p)) (v) };				\
> -	unsigned long __tmp;							\
> -	compiletime_assert_atomic_type(*p);					\
> -	switch (sizeof(*p)) {							\
> -	case 1:									\
> -		__smp_mb();							\
> -		*(volatile __u8 *)p = *(__u8 *)__u.__c;				\
> -		break;								\
> -	case 2:									\
> -		__smp_mb();							\
> -		*(volatile __u16 *)p = *(__u16 *)__u.__c;			\
> -		break;								\
> -	case 4:									\
> -		__asm__ __volatile__(						\
> -		"amswap_db.w %[tmp], %[val], %[mem]	\n"			\
> -		: [mem] "+ZB" (*(u32 *)p), [tmp] "=&r" (__tmp)			\
> -		: [val] "r" (*(__u32 *)__u.__c)					\
> -		: );								\
> -		break;								\
> -	case 8:									\
> -		__asm__ __volatile__(						\
> -		"amswap_db.d %[tmp], %[val], %[mem]	\n"			\
> -		: [mem] "+ZB" (*(u64 *)p), [tmp] "=&r" (__tmp)			\
> -		: [val] "r" (*(__u64 *)__u.__c)					\
> -		: );								\
> -		break;								\
> -	}									\
> +#define __smp_store_release(p, v)			\
> +do {							\
> +	compiletime_assert_atomic_type(*p);		\
> +	strel_mb();					\
> +	WRITE_ONCE(*p, v);				\
>   } while (0)
>   
>   #define __smp_store_mb(p, v)							\
> diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
> index 545e2708fbf7..1c9410220040 100644
> --- a/arch/loongarch/include/asm/io.h
> +++ b/arch/loongarch/include/asm/io.h
> @@ -62,7 +62,7 @@ extern pgprot_t pgprot_wc;
>   #define ioremap_cache(offset, size)	\
>   	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))
>   
> -#define mmiowb() asm volatile ("dbar 0" ::: "memory")
> +#define mmiowb() wmb()
>   
>   /*
>    * String version of I/O memory access operations.
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index ed167e244cda..8daa97148c8e 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -118,7 +118,7 @@ static u32 ipi_read_clear(int cpu)
>   	action = iocsr_read32(LOONGARCH_IOCSR_IPI_STATUS);
>   	/* Clear the ipi register to clear the interrupt */
>   	iocsr_write32(action, LOONGARCH_IOCSR_IPI_CLEAR);
> -	smp_mb();
> +	wbflush();
>   
>   	return action;
>   }
> diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
> index 244e2f5aeee5..240ced55586e 100644
> --- a/arch/loongarch/mm/tlbex.S
> +++ b/arch/loongarch/mm/tlbex.S
> @@ -184,7 +184,7 @@ tlb_huge_update_load:
>   	ertn
>   
>   nopage_tlb_load:
> -	dbar		0
> +	dbar		0x700
>   	csrrd		ra, EXCEPTION_KS2
>   	la_abs		t0, tlb_do_page_fault_0
>   	jr		t0
> @@ -333,7 +333,7 @@ tlb_huge_update_store:
>   	ertn
>   
>   nopage_tlb_store:
> -	dbar		0
> +	dbar		0x700
>   	csrrd		ra, EXCEPTION_KS2
>   	la_abs		t0, tlb_do_page_fault_1
>   	jr		t0
> @@ -480,7 +480,7 @@ tlb_huge_update_modify:
>   	ertn
>   
>   nopage_tlb_modify:
> -	dbar		0
> +	dbar		0x700
>   	csrrd		ra, EXCEPTION_KS2
>   	la_abs		t0, tlb_do_page_fault_1
>   	jr		t0

Due to not having the manuals, I cannot review any further, but I can at 
least see that semantics on older models should be reasonably conserved, 
and the new bits seem reasonable. Nice cleanups anyway, and thanks to 
all of you for listening to community voices!

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

