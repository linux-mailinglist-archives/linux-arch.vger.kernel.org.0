Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8572AF253
	for <lists+linux-arch@lfdr.de>; Wed, 11 Nov 2020 14:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgKKNjN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Nov 2020 08:39:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:29173 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgKKNjJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Nov 2020 08:39:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CWQmz64Hlz9v0WV;
        Wed, 11 Nov 2020 14:38:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rgWXIRRS6MyN; Wed, 11 Nov 2020 14:38:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CWQmz4Q3wz9v0WT;
        Wed, 11 Nov 2020 14:38:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DF488B771;
        Wed, 11 Nov 2020 14:39:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HS34pxkfMAg0; Wed, 11 Nov 2020 14:39:00 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 447658B75F;
        Wed, 11 Nov 2020 14:39:00 +0100 (CET)
Subject: Re: [PATCH 1/3] asm-generic/atomic64: Add support for ARCH_ATOMIC
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20201111110723.3148665-1-npiggin@gmail.com>
 <20201111110723.3148665-2-npiggin@gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <3086114c-8af6-3863-0cbf-5d3956fcda95@csgroup.eu>
Date:   Wed, 11 Nov 2020 14:39:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201111110723.3148665-2-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

Le 11/11/2020 à 12:07, Nicholas Piggin a écrit :
> This passes atomic64 selftest on ppc32 on qemu (uniprocessor only)
> both before and after powerpc is converted to use ARCH_ATOMIC.

Can you explain what this change does and why it is needed ?

Christophe

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/asm-generic/atomic64.h | 70 +++++++++++++++++++++++++++-------
>   lib/atomic64.c                 | 36 ++++++++---------
>   2 files changed, 75 insertions(+), 31 deletions(-)
> 
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> index 370f01d4450f..2b1ecb591bb9 100644
> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -15,19 +15,17 @@ typedef struct {
>   
>   #define ATOMIC64_INIT(i)	{ (i) }
>   
> -extern s64 atomic64_read(const atomic64_t *v);
> -extern void atomic64_set(atomic64_t *v, s64 i);
> -
> -#define atomic64_set_release(v, i)	atomic64_set((v), (i))
> +extern s64 __atomic64_read(const atomic64_t *v);
> +extern void __atomic64_set(atomic64_t *v, s64 i);
>   
>   #define ATOMIC64_OP(op)							\
> -extern void	 atomic64_##op(s64 a, atomic64_t *v);
> +extern void	 __atomic64_##op(s64 a, atomic64_t *v);
>   
>   #define ATOMIC64_OP_RETURN(op)						\
> -extern s64 atomic64_##op##_return(s64 a, atomic64_t *v);
> +extern s64 __atomic64_##op##_return(s64 a, atomic64_t *v);
>   
>   #define ATOMIC64_FETCH_OP(op)						\
> -extern s64 atomic64_fetch_##op(s64 a, atomic64_t *v);
> +extern s64 __atomic64_fetch_##op(s64 a, atomic64_t *v);
>   
>   #define ATOMIC64_OPS(op)	ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op) ATOMIC64_FETCH_OP(op)
>   
> @@ -46,11 +44,57 @@ ATOMIC64_OPS(xor)
>   #undef ATOMIC64_OP_RETURN
>   #undef ATOMIC64_OP
>   
> -extern s64 atomic64_dec_if_positive(atomic64_t *v);
> -#define atomic64_dec_if_positive atomic64_dec_if_positive
> -extern s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
> -extern s64 atomic64_xchg(atomic64_t *v, s64 new);
> -extern s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
> -#define atomic64_fetch_add_unless atomic64_fetch_add_unless
> +extern s64 __atomic64_dec_if_positive(atomic64_t *v);
> +extern s64 __atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
> +extern s64 __atomic64_xchg(atomic64_t *v, s64 new);
> +extern s64 __atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
> +
> +#ifdef ARCH_ATOMIC
> +#define arch_atomic64_read __atomic64_read
> +#define arch_atomic64_set __atomic64_set
> +#define arch_atomic64_add __atomic64_add
> +#define arch_atomic64_add_return __atomic64_add_return
> +#define arch_atomic64_fetch_add __atomic64_fetch_add
> +#define arch_atomic64_sub __atomic64_sub
> +#define arch_atomic64_sub_return __atomic64_sub_return
> +#define arch_atomic64_fetch_sub __atomic64_fetch_sub
> +#define arch_atomic64_and __atomic64_and
> +#define arch_atomic64_and_return __atomic64_and_return
> +#define arch_atomic64_fetch_and __atomic64_fetch_and
> +#define arch_atomic64_or __atomic64_or
> +#define arch_atomic64_or_return __atomic64_or_return
> +#define arch_atomic64_fetch_or __atomic64_fetch_or
> +#define arch_atomic64_xor __atomic64_xor
> +#define arch_atomic64_xor_return __atomic64_xor_return
> +#define arch_atomic64_fetch_xor __atomic64_fetch_xor
> +#define arch_atomic64_xchg __atomic64_xchg
> +#define arch_atomic64_cmpxchg __atomic64_cmpxchg
> +#define arch_atomic64_set_release(v, i)	__atomic64_set((v), (i))
> +#define arch_atomic64_dec_if_positive __atomic64_dec_if_positive
> +#define arch_atomic64_fetch_add_unless __atomic64_fetch_add_unless
> +#else
> +#define atomic64_read __atomic64_read
> +#define atomic64_set __atomic64_set
> +#define atomic64_add __atomic64_add
> +#define atomic64_add_return __atomic64_add_return
> +#define atomic64_fetch_add __atomic64_fetch_add
> +#define atomic64_sub __atomic64_sub
> +#define atomic64_sub_return __atomic64_sub_return
> +#define atomic64_fetch_sub __atomic64_fetch_sub
> +#define atomic64_and __atomic64_and
> +#define atomic64_and_return __atomic64_and_return
> +#define atomic64_fetch_and __atomic64_fetch_and
> +#define atomic64_or __atomic64_or
> +#define atomic64_or_return __atomic64_or_return
> +#define atomic64_fetch_or __atomic64_fetch_or
> +#define atomic64_xor __atomic64_xor
> +#define atomic64_xor_return __atomic64_xor_return
> +#define atomic64_fetch_xor __atomic64_fetch_xor
> +#define atomic64_xchg __atomic64_xchg
> +#define atomic64_cmpxchg __atomic64_cmpxchg
> +#define atomic64_set_release(v, i)	__atomic64_set((v), (i))
> +#define atomic64_dec_if_positive __atomic64_dec_if_positive
> +#define atomic64_fetch_add_unless __atomic64_fetch_add_unless
> +#endif
>   
>   #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
> diff --git a/lib/atomic64.c b/lib/atomic64.c
> index e98c85a99787..05aba5e3268f 100644
> --- a/lib/atomic64.c
> +++ b/lib/atomic64.c
> @@ -42,7 +42,7 @@ static inline raw_spinlock_t *lock_addr(const atomic64_t *v)
>   	return &atomic64_lock[addr & (NR_LOCKS - 1)].lock;
>   }
>   
> -s64 atomic64_read(const atomic64_t *v)
> +s64 __atomic64_read(const atomic64_t *v)
>   {
>   	unsigned long flags;
>   	raw_spinlock_t *lock = lock_addr(v);
> @@ -53,9 +53,9 @@ s64 atomic64_read(const atomic64_t *v)
>   	raw_spin_unlock_irqrestore(lock, flags);
>   	return val;
>   }
> -EXPORT_SYMBOL(atomic64_read);
> +EXPORT_SYMBOL(__atomic64_read);
>   
> -void atomic64_set(atomic64_t *v, s64 i)
> +void __atomic64_set(atomic64_t *v, s64 i)
>   {
>   	unsigned long flags;
>   	raw_spinlock_t *lock = lock_addr(v);
> @@ -64,10 +64,10 @@ void atomic64_set(atomic64_t *v, s64 i)
>   	v->counter = i;
>   	raw_spin_unlock_irqrestore(lock, flags);
>   }
> -EXPORT_SYMBOL(atomic64_set);
> +EXPORT_SYMBOL(__atomic64_set);
>   
>   #define ATOMIC64_OP(op, c_op)						\
> -void atomic64_##op(s64 a, atomic64_t *v)				\
> +void __atomic64_##op(s64 a, atomic64_t *v)				\
>   {									\
>   	unsigned long flags;						\
>   	raw_spinlock_t *lock = lock_addr(v);				\
> @@ -76,10 +76,10 @@ void atomic64_##op(s64 a, atomic64_t *v)				\
>   	v->counter c_op a;						\
>   	raw_spin_unlock_irqrestore(lock, flags);			\
>   }									\
> -EXPORT_SYMBOL(atomic64_##op);
> +EXPORT_SYMBOL(__atomic64_##op);
>   
>   #define ATOMIC64_OP_RETURN(op, c_op)					\
> -s64 atomic64_##op##_return(s64 a, atomic64_t *v)			\
> +s64 __atomic64_##op##_return(s64 a, atomic64_t *v)			\
>   {									\
>   	unsigned long flags;						\
>   	raw_spinlock_t *lock = lock_addr(v);				\
> @@ -90,10 +90,10 @@ s64 atomic64_##op##_return(s64 a, atomic64_t *v)			\
>   	raw_spin_unlock_irqrestore(lock, flags);			\
>   	return val;							\
>   }									\
> -EXPORT_SYMBOL(atomic64_##op##_return);
> +EXPORT_SYMBOL(__atomic64_##op##_return);
>   
>   #define ATOMIC64_FETCH_OP(op, c_op)					\
> -s64 atomic64_fetch_##op(s64 a, atomic64_t *v)				\
> +s64 __atomic64_fetch_##op(s64 a, atomic64_t *v)				\
>   {									\
>   	unsigned long flags;						\
>   	raw_spinlock_t *lock = lock_addr(v);				\
> @@ -105,7 +105,7 @@ s64 atomic64_fetch_##op(s64 a, atomic64_t *v)				\
>   	raw_spin_unlock_irqrestore(lock, flags);			\
>   	return val;							\
>   }									\
> -EXPORT_SYMBOL(atomic64_fetch_##op);
> +EXPORT_SYMBOL(__atomic64_fetch_##op);
>   
>   #define ATOMIC64_OPS(op, c_op)						\
>   	ATOMIC64_OP(op, c_op)						\
> @@ -130,7 +130,7 @@ ATOMIC64_OPS(xor, ^=)
>   #undef ATOMIC64_OP_RETURN
>   #undef ATOMIC64_OP
>   
> -s64 atomic64_dec_if_positive(atomic64_t *v)
> +s64 __atomic64_dec_if_positive(atomic64_t *v)
>   {
>   	unsigned long flags;
>   	raw_spinlock_t *lock = lock_addr(v);
> @@ -143,9 +143,9 @@ s64 atomic64_dec_if_positive(atomic64_t *v)
>   	raw_spin_unlock_irqrestore(lock, flags);
>   	return val;
>   }
> -EXPORT_SYMBOL(atomic64_dec_if_positive);
> +EXPORT_SYMBOL(__atomic64_dec_if_positive);
>   
> -s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
> +s64 __atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
>   {
>   	unsigned long flags;
>   	raw_spinlock_t *lock = lock_addr(v);
> @@ -158,9 +158,9 @@ s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
>   	raw_spin_unlock_irqrestore(lock, flags);
>   	return val;
>   }
> -EXPORT_SYMBOL(atomic64_cmpxchg);
> +EXPORT_SYMBOL(__atomic64_cmpxchg);
>   
> -s64 atomic64_xchg(atomic64_t *v, s64 new)
> +s64 __atomic64_xchg(atomic64_t *v, s64 new)
>   {
>   	unsigned long flags;
>   	raw_spinlock_t *lock = lock_addr(v);
> @@ -172,9 +172,9 @@ s64 atomic64_xchg(atomic64_t *v, s64 new)
>   	raw_spin_unlock_irqrestore(lock, flags);
>   	return val;
>   }
> -EXPORT_SYMBOL(atomic64_xchg);
> +EXPORT_SYMBOL(__atomic64_xchg);
>   
> -s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
> +s64 __atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
>   {
>   	unsigned long flags;
>   	raw_spinlock_t *lock = lock_addr(v);
> @@ -188,4 +188,4 @@ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
>   
>   	return val;
>   }
> -EXPORT_SYMBOL(atomic64_fetch_add_unless);
> +EXPORT_SYMBOL(__atomic64_fetch_add_unless);
> 
