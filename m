Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5783374F27
	for <lists+linux-arch@lfdr.de>; Thu,  6 May 2021 08:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhEFGEy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 May 2021 02:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhEFGEu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 May 2021 02:04:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0432C06174A
        for <linux-arch@vger.kernel.org>; Wed,  5 May 2021 23:03:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m12so3969465pgr.9
        for <linux-arch@vger.kernel.org>; Wed, 05 May 2021 23:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=P8+pEqNS60H+wLeYsAOqE4ed1KdT4dDk5XX4u405m+0=;
        b=Oyh5IQz6izdcvWGOyDC5LRe+YxFdBAw60dU1fG9sfVFGJXFimYldJvFVoLaDc1LOS7
         ZwiJfT7BMF4Rx2GCWpOIKLct0AaCtWUmPwJZe50z22QVgwQRVqvjAaYnPXOtXZSTRr4c
         O+FEREmW/Oh0gGjyUtykGZZ6TFKBi99JaN6OCgb68Rht/hFCrmYqvDFsq7apvFolLqlZ
         MererAnhaC1r5L0ktYde8OhRxcF4nK+hMQ2Z2ma2xx8P1C0BkanfVWDz4oK1LJrIfzVF
         J+Qiz0sknb5TnJzQPURPXnFGH7nKKzopr/DkWG6CWBtoObgsuQ8GZkVg5DFo82YzeKVS
         hzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=P8+pEqNS60H+wLeYsAOqE4ed1KdT4dDk5XX4u405m+0=;
        b=rzCbLEIPnN0Y9ju/LnseuxpLk08X2EU1Hp9JWgZ8ErqM4ILVOJpJB6ZboTjuFOQYJN
         njqyFgU5UenF5ESr/2av7rrh76qL55kY4GTDC1t2zYZLUU6W2wo5wS6h4ljztg50UGpA
         DygXnH17bCyUt2k7Gd4ej9dHJ3/xq+JMiaBammTmHfkuFZ+VulPxFyrwe7Ne7BFrysNs
         Q4jHwkyRjPdxxGGMN5KkyRvs+s6SnGmg4hUoGUFBGw7ilIV+akzXyUQxas4lF4n4+DK6
         +9QNxaQcFTnte6Qx9egur9OgLZD6jp5J2Uvxc9ObxsdJMZmpbVsnVvZT5lsWLzIW9GwR
         LKtA==
X-Gm-Message-State: AOAM531noUpzEDayc8Dvygs+qQp+68HpaZT/5q+nvor/mqAvX5z8Mllj
        ldBMcFJIxpjhuN8MmjNacOOdXw==
X-Google-Smtp-Source: ABdhPJz7LlY5uOxbaLNsNZmYDQ16VrTEBX4B30yW244LBUU9IfYu3UMx3oaCJCgufxYgEzt/nbwToQ==
X-Received: by 2002:a63:6545:: with SMTP id z66mr2738693pgb.292.1620280997624;
        Wed, 05 May 2021 23:03:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k14sm993893pjg.0.2021.05.05.23.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 23:03:16 -0700 (PDT)
Date:   Wed, 05 May 2021 23:03:16 -0700 (PDT)
X-Google-Original-Date: Wed, 05 May 2021 23:03:13 PDT (-0700)
Subject:     Re: [PATCH v3 2/2] riscv: atomic: Using ARCH_ATOMIC in asm/atomic.h
In-Reply-To: <1619009626-93453-2-git-send-email-guoren@kernel.org>
CC:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        guoren@linux.alibaba.com, peterz@infradead.org, anup@brainfault.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-7181822d-02c1-4ef4-b1be-83c1034d79ba@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 21 Apr 2021 05:53:46 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The linux/atomic-arch-fallback.h has been there for a while, but
> only x86 & arm64 support it. Let's make riscv follow the
> linux/arch/* development trendy and make the codes more readable
> and maintainable.
>
> This patch also cleanup some codes:
>  - Add atomic_andnot_* operation
>  - Using amoswap.w.rl & amoswap.w.aq instructions in xchg
>  - Remove cmpxchg_acquire/release unnecessary optimization

Thanks.  I haven't gotten the time to review this properly yet, but I 
don't really see any issues.  Regardless, it was too late for this merge 
window anyway -- these sorts of things are a bit subtle and require a 
proper look, right at the end of the cycle things are just a bit too 
hectic.

I'll take a look once things calm down a bit, there's still some fixes 
out that I'd like to look at first.

I'm also only getting patch 2, and your lore link points to a different 
patch set.

Thanks!

> Change in v3:
>  - Revert to origin atomic(64)_read/set coding style
>
> Change in v2:
>  - Fixup andnot bug by Peter Zijlstra
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Link: https://lore.kernel.org/linux-riscv/CAK8P3a0FG3cpqBNUP7kXj3713cMUqV1WcEh-vcRnGKM00WXqxw@mail.gmail.com/
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/include/asm/atomic.h  | 216 ++++++++++++++++-----------------------
>  arch/riscv/include/asm/cmpxchg.h | 199 ++----------------------------------
>  2 files changed, 98 insertions(+), 317 deletions(-)
>
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 400a8c8..b825bdb 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -8,13 +8,8 @@
>  #ifndef _ASM_RISCV_ATOMIC_H
>  #define _ASM_RISCV_ATOMIC_H
>
> -#ifdef CONFIG_GENERIC_ATOMIC64
> -# include <asm-generic/atomic64.h>
> -#else
> -# if (__riscv_xlen < 64)
> -#  error "64-bit atomics require XLEN to be at least 64"
> -# endif
> -#endif
> +#include <linux/compiler.h>
> +#include <linux/types.h>
>
>  #include <asm/cmpxchg.h>
>  #include <asm/barrier.h>
> @@ -25,22 +20,22 @@
>  #define __atomic_release_fence()					\
>  	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
>
> -static __always_inline int atomic_read(const atomic_t *v)
> +static __always_inline int arch_atomic_read(const atomic_t *v)
>  {
>  	return READ_ONCE(v->counter);
>  }
> -static __always_inline void atomic_set(atomic_t *v, int i)
> +static __always_inline void arch_atomic_set(atomic_t *v, int i)
>  {
>  	WRITE_ONCE(v->counter, i);
>  }
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
>  #define ATOMIC64_INIT(i) { (i) }
> -static __always_inline s64 atomic64_read(const atomic64_t *v)
> +static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
>  {
>  	return READ_ONCE(v->counter);
>  }
> -static __always_inline void atomic64_set(atomic64_t *v, s64 i)
> +static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
>  {
>  	WRITE_ONCE(v->counter, i);
>  }
> @@ -53,7 +48,7 @@ static __always_inline void atomic64_set(atomic64_t *v, s64 i)
>   */
>  #define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)		\
>  static __always_inline							\
> -void atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)		\
> +void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
>  {									\
>  	__asm__ __volatile__ (						\
>  		"	amo" #asm_op "." #asm_type " zero, %1, %0"	\
> @@ -76,6 +71,12 @@ ATOMIC_OPS(sub, add, -i)
>  ATOMIC_OPS(and, and,  i)
>  ATOMIC_OPS( or,  or,  i)
>  ATOMIC_OPS(xor, xor,  i)
> +ATOMIC_OPS(andnot, and,  ~i)
> +
> +#define arch_atomic_andnot	arch_atomic_andnot
> +#ifndef CONFIG_GENERIC_ATOMIC64
> +#define arch_atomic64_andnot	arch_atomic64_andnot
> +#endif
>
>  #undef ATOMIC_OP
>  #undef ATOMIC_OPS
> @@ -87,7 +88,7 @@ ATOMIC_OPS(xor, xor,  i)
>   */
>  #define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)	\
>  static __always_inline							\
> -c_type atomic##prefix##_fetch_##op##_relaxed(c_type i,			\
> +c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
>  					     atomic##prefix##_t *v)	\
>  {									\
>  	register c_type ret;						\
> @@ -99,7 +100,7 @@ c_type atomic##prefix##_fetch_##op##_relaxed(c_type i,			\
>  	return ret;							\
>  }									\
>  static __always_inline							\
> -c_type atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
> +c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)\
>  {									\
>  	register c_type ret;						\
>  	__asm__ __volatile__ (						\
> @@ -112,15 +113,16 @@ c_type atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
>
>  #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)	\
>  static __always_inline							\
> -c_type atomic##prefix##_##op##_return_relaxed(c_type i,			\
> +c_type arch_atomic##prefix##_##op##_return_relaxed(c_type i,		\
>  					      atomic##prefix##_t *v)	\
>  {									\
> -        return atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;	\
> +        return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;	\
>  }									\
>  static __always_inline							\
> -c_type atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
> +c_type arch_atomic##prefix##_##op##_return(c_type i,			\
> +						atomic##prefix##_t *v)	\
>  {									\
> -        return atomic##prefix##_fetch_##op(i, v) c_op I;		\
> +        return arch_atomic##prefix##_fetch_##op(i, v) c_op I;		\
>  }
>
>  #ifdef CONFIG_GENERIC_ATOMIC64
> @@ -138,26 +140,26 @@ c_type atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
>  ATOMIC_OPS(add, add, +,  i)
>  ATOMIC_OPS(sub, add, +, -i)
>
> -#define atomic_add_return_relaxed	atomic_add_return_relaxed
> -#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
> -#define atomic_add_return		atomic_add_return
> -#define atomic_sub_return		atomic_sub_return
> +#define arch_atomic_add_return_relaxed		arch_atomic_add_return_relaxed
> +#define arch_atomic_sub_return_relaxed		arch_atomic_sub_return_relaxed
> +#define arch_atomic_add_return			arch_atomic_add_return
> +#define arch_atomic_sub_return			arch_atomic_sub_return
>
> -#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
> -#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
> -#define atomic_fetch_add		atomic_fetch_add
> -#define atomic_fetch_sub		atomic_fetch_sub
> +#define arch_atomic_fetch_add_relaxed		arch_atomic_fetch_add_relaxed
> +#define arch_atomic_fetch_sub_relaxed		arch_atomic_fetch_sub_relaxed
> +#define arch_atomic_fetch_add			arch_atomic_fetch_add
> +#define arch_atomic_fetch_sub			arch_atomic_fetch_sub
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
> -#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
> -#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
> -#define atomic64_add_return		atomic64_add_return
> -#define atomic64_sub_return		atomic64_sub_return
> -
> -#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
> -#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
> -#define atomic64_fetch_add		atomic64_fetch_add
> -#define atomic64_fetch_sub		atomic64_fetch_sub
> +#define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
> +#define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
> +#define arch_atomic64_add_return		arch_atomic64_add_return
> +#define arch_atomic64_sub_return		arch_atomic64_sub_return
> +
> +#define arch_atomic64_fetch_add_relaxed		arch_atomic64_fetch_add_relaxed
> +#define arch_atomic64_fetch_sub_relaxed		arch_atomic64_fetch_sub_relaxed
> +#define arch_atomic64_fetch_add			arch_atomic64_fetch_add
> +#define arch_atomic64_fetch_sub			arch_atomic64_fetch_sub
>  #endif
>
>  #undef ATOMIC_OPS
> @@ -172,23 +174,28 @@ ATOMIC_OPS(sub, add, +, -i)
>  #endif
>
>  ATOMIC_OPS(and, and, i)
> +ATOMIC_OPS(andnot, and, ~i)
>  ATOMIC_OPS( or,  or, i)
>  ATOMIC_OPS(xor, xor, i)
>
> -#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
> -#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
> -#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
> -#define atomic_fetch_and		atomic_fetch_and
> -#define atomic_fetch_or			atomic_fetch_or
> -#define atomic_fetch_xor		atomic_fetch_xor
> +#define arch_atomic_fetch_and_relaxed		arch_atomic_fetch_and_relaxed
> +#define arch_atomic_fetch_andnot_relaxed	arch_atomic_fetch_andnot_relaxed
> +#define arch_atomic_fetch_or_relaxed		arch_atomic_fetch_or_relaxed
> +#define arch_atomic_fetch_xor_relaxed		arch_atomic_fetch_xor_relaxed
> +#define arch_atomic_fetch_and			arch_atomic_fetch_and
> +#define arch_atomic_fetch_andnot		arch_atomic_fetch_andnot
> +#define arch_atomic_fetch_or			arch_atomic_fetch_or
> +#define arch_atomic_fetch_xor			arch_atomic_fetch_xor
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
> -#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
> -#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
> -#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
> -#define atomic64_fetch_and		atomic64_fetch_and
> -#define atomic64_fetch_or		atomic64_fetch_or
> -#define atomic64_fetch_xor		atomic64_fetch_xor
> +#define arch_atomic64_fetch_and_relaxed		arch_atomic64_fetch_and_relaxed
> +#define arch_atomic64_fetch_andnot_relaxed	arch_atomic64_fetch_andnot_relaxed
> +#define arch_atomic64_fetch_or_relaxed		arch_atomic64_fetch_or_relaxed
> +#define arch_atomic64_fetch_xor_relaxed		arch_atomic64_fetch_xor_relaxed
> +#define arch_atomic64_fetch_and			arch_atomic64_fetch_and
> +#define arch_atomic64_fetch_andnot		arch_atomic64_fetch_andnot
> +#define arch_atomic64_fetch_or			arch_atomic64_fetch_or
> +#define arch_atomic64_fetch_xor			arch_atomic64_fetch_xor
>  #endif
>
>  #undef ATOMIC_OPS
> @@ -197,7 +204,7 @@ ATOMIC_OPS(xor, xor, i)
>  #undef ATOMIC_OP_RETURN
>
>  /* This is required to provide a full barrier on success. */
> -static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
> +static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  {
>         int prev, rc;
>
> @@ -214,10 +221,10 @@ static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  		: "memory");
>  	return prev;
>  }
> -#define atomic_fetch_add_unless atomic_fetch_add_unless
> +#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
> -static __always_inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
> +static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
>  {
>         s64 prev;
>         long rc;
> @@ -235,82 +242,10 @@ static __always_inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u
>  		: "memory");
>  	return prev;
>  }
> -#define atomic64_fetch_add_unless atomic64_fetch_add_unless
> +#define arch_atomic64_fetch_add_unless		arch_atomic64_fetch_add_unless
>  #endif
>
> -/*
> - * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
> - * {cmp,}xchg and the operations that return, so they need a full barrier.
> - */
> -#define ATOMIC_OP(c_t, prefix, size)					\
> -static __always_inline							\
> -c_t atomic##prefix##_xchg_relaxed(atomic##prefix##_t *v, c_t n)		\
> -{									\
> -	return __xchg_relaxed(&(v->counter), n, size);			\
> -}									\
> -static __always_inline							\
> -c_t atomic##prefix##_xchg_acquire(atomic##prefix##_t *v, c_t n)		\
> -{									\
> -	return __xchg_acquire(&(v->counter), n, size);			\
> -}									\
> -static __always_inline							\
> -c_t atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)		\
> -{									\
> -	return __xchg_release(&(v->counter), n, size);			\
> -}									\
> -static __always_inline							\
> -c_t atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)			\
> -{									\
> -	return __xchg(&(v->counter), n, size);				\
> -}									\
> -static __always_inline							\
> -c_t atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,		\
> -				     c_t o, c_t n)			\
> -{									\
> -	return __cmpxchg_relaxed(&(v->counter), o, n, size);		\
> -}									\
> -static __always_inline							\
> -c_t atomic##prefix##_cmpxchg_acquire(atomic##prefix##_t *v,		\
> -				     c_t o, c_t n)			\
> -{									\
> -	return __cmpxchg_acquire(&(v->counter), o, n, size);		\
> -}									\
> -static __always_inline							\
> -c_t atomic##prefix##_cmpxchg_release(atomic##prefix##_t *v,		\
> -				     c_t o, c_t n)			\
> -{									\
> -	return __cmpxchg_release(&(v->counter), o, n, size);		\
> -}									\
> -static __always_inline							\
> -c_t atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
> -{									\
> -	return __cmpxchg(&(v->counter), o, n, size);			\
> -}
> -
> -#ifdef CONFIG_GENERIC_ATOMIC64
> -#define ATOMIC_OPS()							\
> -	ATOMIC_OP(int,   , 4)
> -#else
> -#define ATOMIC_OPS()							\
> -	ATOMIC_OP(int,   , 4)						\
> -	ATOMIC_OP(s64, 64, 8)
> -#endif
> -
> -ATOMIC_OPS()
> -
> -#define atomic_xchg_relaxed atomic_xchg_relaxed
> -#define atomic_xchg_acquire atomic_xchg_acquire
> -#define atomic_xchg_release atomic_xchg_release
> -#define atomic_xchg atomic_xchg
> -#define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
> -#define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
> -#define atomic_cmpxchg_release atomic_cmpxchg_release
> -#define atomic_cmpxchg atomic_cmpxchg
> -
> -#undef ATOMIC_OPS
> -#undef ATOMIC_OP
> -
> -static __always_inline int atomic_sub_if_positive(atomic_t *v, int offset)
> +static __always_inline int arch_atomic_sub_if_positive(atomic_t *v, int offset)
>  {
>         int prev, rc;
>
> @@ -327,11 +262,11 @@ static __always_inline int atomic_sub_if_positive(atomic_t *v, int offset)
>  		: "memory");
>  	return prev - offset;
>  }
> +#define arch_atomic_dec_if_positive(v)	arch_atomic_sub_if_positive(v, 1)
>
> -#define atomic_dec_if_positive(v)	atomic_sub_if_positive(v, 1)
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
> -static __always_inline s64 atomic64_sub_if_positive(atomic64_t *v, s64 offset)
> +static __always_inline s64 arch_atomic64_sub_if_positive(atomic64_t *v, s64 offset)
>  {
>         s64 prev;
>         long rc;
> @@ -349,8 +284,35 @@ static __always_inline s64 atomic64_sub_if_positive(atomic64_t *v, s64 offset)
>  		: "memory");
>  	return prev - offset;
>  }
> +#define arch_atomic64_dec_if_positive(v)	arch_atomic64_sub_if_positive(v, 1)
> +#endif
> +
> +#define arch_atomic_xchg_relaxed(v, new) \
> +	arch_xchg_relaxed(&((v)->counter), (new))
> +#define arch_atomic_xchg_acquire(v, new) \
> +	arch_xchg_acquire(&((v)->counter), (new))
> +#define arch_atomic_xchg_release(v, new) \
> +	arch_xchg_release(&((v)->counter), (new))
> +#define arch_atomic_xchg(v, new) \
> +	arch_xchg(&((v)->counter), (new))
> +
> +#define arch_atomic_cmpxchg_relaxed(v, old, new) \
> +	arch_cmpxchg_relaxed(&((v)->counter), (old), (new))
> +#define arch_atomic_cmpxchg_acquire(v, old, new) \
> +	arch_cmpxchg_acquire(&((v)->counter), (old), (new))
> +#define arch_atomic_cmpxchg_release(v, old, new) \
> +	arch_cmpxchg_release(&((v)->counter), (old), (new))
> +#define arch_atomic_cmpxchg(v, old, new) \
> +	arch_cmpxchg(&((v)->counter), (old), (new))
>
> -#define atomic64_dec_if_positive(v)	atomic64_sub_if_positive(v, 1)
> +#ifndef CONFIG_GENERIC_ATOMIC64
> +#define arch_atomic64_xchg_relaxed		arch_atomic_xchg_relaxed
> +#define arch_atomic64_xchg			arch_atomic_xchg
> +
> +#define arch_atomic64_cmpxchg_relaxed		arch_atomic_cmpxchg_relaxed
> +#define arch_atomic64_cmpxchg			arch_atomic_cmpxchg
>  #endif
>
> +#define ARCH_ATOMIC
> +
>  #endif /* _ASM_RISCV_ATOMIC_H */
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 262e5bb..16195a6 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -37,7 +37,7 @@
>  	__ret;								\
>  })
>
> -#define xchg_relaxed(ptr, x)						\
> +#define arch_xchg_relaxed(ptr, x)					\
>  ({									\
>  	__typeof__(*(ptr)) _x_ = (x);					\
>  	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
> @@ -52,16 +52,14 @@
>  	switch (size) {							\
>  	case 4:								\
>  		__asm__ __volatile__ (					\
> -			"	amoswap.w %0, %2, %1\n"			\
> -			RISCV_ACQUIRE_BARRIER				\
> +			"	amoswap.w.aq %0, %2, %1\n"		\
>  			: "=r" (__ret), "+A" (*__ptr)			\
>  			: "r" (__new)					\
>  			: "memory");					\
>  		break;							\
>  	case 8:								\
>  		__asm__ __volatile__ (					\
> -			"	amoswap.d %0, %2, %1\n"			\
> -			RISCV_ACQUIRE_BARRIER				\
> +			"	amoswap.d.aq %0, %2, %1\n"		\
>  			: "=r" (__ret), "+A" (*__ptr)			\
>  			: "r" (__new)					\
>  			: "memory");					\
> @@ -72,7 +70,7 @@
>  	__ret;								\
>  })
>
> -#define xchg_acquire(ptr, x)						\
> +#define arch_xchg_acquire(ptr, x)					\
>  ({									\
>  	__typeof__(*(ptr)) _x_ = (x);					\
>  	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
> @@ -87,16 +85,14 @@
>  	switch (size) {							\
>  	case 4:								\
>  		__asm__ __volatile__ (					\
> -			RISCV_RELEASE_BARRIER				\
> -			"	amoswap.w %0, %2, %1\n"			\
> +			"	amoswap.w.rl %0, %2, %1\n"		\
>  			: "=r" (__ret), "+A" (*__ptr)			\
>  			: "r" (__new)					\
>  			: "memory");					\
>  		break;							\
>  	case 8:								\
>  		__asm__ __volatile__ (					\
> -			RISCV_RELEASE_BARRIER				\
> -			"	amoswap.d %0, %2, %1\n"			\
> +			"	amoswap.d.rl %0, %2, %1\n"		\
>  			: "=r" (__ret), "+A" (*__ptr)			\
>  			: "r" (__new)					\
>  			: "memory");					\
> @@ -107,7 +103,7 @@
>  	__ret;								\
>  })
>
> -#define xchg_release(ptr, x)						\
> +#define arch_xchg_release(ptr, x)					\
>  ({									\
>  	__typeof__(*(ptr)) _x_ = (x);					\
>  	(__typeof__(*(ptr))) __xchg_release((ptr),			\
> @@ -140,24 +136,12 @@
>  	__ret;								\
>  })
>
> -#define xchg(ptr, x)							\
> +#define arch_xchg(ptr, x)						\
>  ({									\
>  	__typeof__(*(ptr)) _x_ = (x);					\
>  	(__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));	\
>  })
>
> -#define xchg32(ptr, x)							\
> -({									\
> -	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
> -	xchg((ptr), (x));						\
> -})
> -
> -#define xchg64(ptr, x)							\
> -({									\
> -	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
> -	xchg((ptr), (x));						\
> -})
> -
>  /*
>   * Atomic compare and exchange.  Compare OLD with MEM, if identical,
>   * store NEW in MEM.  Return the initial value in MEM.  Success is
> @@ -199,7 +183,7 @@
>  	__ret;								\
>  })
>
> -#define cmpxchg_relaxed(ptr, o, n)					\
> +#define arch_cmpxchg_relaxed(ptr, o, n)					\
>  ({									\
>  	__typeof__(*(ptr)) _o_ = (o);					\
>  	__typeof__(*(ptr)) _n_ = (n);					\
> @@ -207,169 +191,4 @@
>  					_o_, _n_, sizeof(*(ptr)));	\
>  })
>
> -#define __cmpxchg_acquire(ptr, old, new, size)				\
> -({									\
> -	__typeof__(ptr) __ptr = (ptr);					\
> -	__typeof__(*(ptr)) __old = (old);				\
> -	__typeof__(*(ptr)) __new = (new);				\
> -	__typeof__(*(ptr)) __ret;					\
> -	register unsigned int __rc;					\
> -	switch (size) {							\
> -	case 4:								\
> -		__asm__ __volatile__ (					\
> -			"0:	lr.w %0, %2\n"				\
> -			"	bne  %0, %z3, 1f\n"			\
> -			"	sc.w %1, %z4, %2\n"			\
> -			"	bnez %1, 0b\n"				\
> -			RISCV_ACQUIRE_BARRIER				\
> -			"1:\n"						\
> -			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> -			: "rJ" ((long)__old), "rJ" (__new)		\
> -			: "memory");					\
> -		break;							\
> -	case 8:								\
> -		__asm__ __volatile__ (					\
> -			"0:	lr.d %0, %2\n"				\
> -			"	bne %0, %z3, 1f\n"			\
> -			"	sc.d %1, %z4, %2\n"			\
> -			"	bnez %1, 0b\n"				\
> -			RISCV_ACQUIRE_BARRIER				\
> -			"1:\n"						\
> -			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> -			: "rJ" (__old), "rJ" (__new)			\
> -			: "memory");					\
> -		break;							\
> -	default:							\
> -		BUILD_BUG();						\
> -	}								\
> -	__ret;								\
> -})
> -
> -#define cmpxchg_acquire(ptr, o, n)					\
> -({									\
> -	__typeof__(*(ptr)) _o_ = (o);					\
> -	__typeof__(*(ptr)) _n_ = (n);					\
> -	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
> -					_o_, _n_, sizeof(*(ptr)));	\
> -})
> -
> -#define __cmpxchg_release(ptr, old, new, size)				\
> -({									\
> -	__typeof__(ptr) __ptr = (ptr);					\
> -	__typeof__(*(ptr)) __old = (old);				\
> -	__typeof__(*(ptr)) __new = (new);				\
> -	__typeof__(*(ptr)) __ret;					\
> -	register unsigned int __rc;					\
> -	switch (size) {							\
> -	case 4:								\
> -		__asm__ __volatile__ (					\
> -			RISCV_RELEASE_BARRIER				\
> -			"0:	lr.w %0, %2\n"				\
> -			"	bne  %0, %z3, 1f\n"			\
> -			"	sc.w %1, %z4, %2\n"			\
> -			"	bnez %1, 0b\n"				\
> -			"1:\n"						\
> -			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> -			: "rJ" ((long)__old), "rJ" (__new)		\
> -			: "memory");					\
> -		break;							\
> -	case 8:								\
> -		__asm__ __volatile__ (					\
> -			RISCV_RELEASE_BARRIER				\
> -			"0:	lr.d %0, %2\n"				\
> -			"	bne %0, %z3, 1f\n"			\
> -			"	sc.d %1, %z4, %2\n"			\
> -			"	bnez %1, 0b\n"				\
> -			"1:\n"						\
> -			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> -			: "rJ" (__old), "rJ" (__new)			\
> -			: "memory");					\
> -		break;							\
> -	default:							\
> -		BUILD_BUG();						\
> -	}								\
> -	__ret;								\
> -})
> -
> -#define cmpxchg_release(ptr, o, n)					\
> -({									\
> -	__typeof__(*(ptr)) _o_ = (o);					\
> -	__typeof__(*(ptr)) _n_ = (n);					\
> -	(__typeof__(*(ptr))) __cmpxchg_release((ptr),			\
> -					_o_, _n_, sizeof(*(ptr)));	\
> -})
> -
> -#define __cmpxchg(ptr, old, new, size)					\
> -({									\
> -	__typeof__(ptr) __ptr = (ptr);					\
> -	__typeof__(*(ptr)) __old = (old);				\
> -	__typeof__(*(ptr)) __new = (new);				\
> -	__typeof__(*(ptr)) __ret;					\
> -	register unsigned int __rc;					\
> -	switch (size) {							\
> -	case 4:								\
> -		__asm__ __volatile__ (					\
> -			"0:	lr.w %0, %2\n"				\
> -			"	bne  %0, %z3, 1f\n"			\
> -			"	sc.w.rl %1, %z4, %2\n"			\
> -			"	bnez %1, 0b\n"				\
> -			"	fence rw, rw\n"				\
> -			"1:\n"						\
> -			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> -			: "rJ" ((long)__old), "rJ" (__new)		\
> -			: "memory");					\
> -		break;							\
> -	case 8:								\
> -		__asm__ __volatile__ (					\
> -			"0:	lr.d %0, %2\n"				\
> -			"	bne %0, %z3, 1f\n"			\
> -			"	sc.d.rl %1, %z4, %2\n"			\
> -			"	bnez %1, 0b\n"				\
> -			"	fence rw, rw\n"				\
> -			"1:\n"						\
> -			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
> -			: "rJ" (__old), "rJ" (__new)			\
> -			: "memory");					\
> -		break;							\
> -	default:							\
> -		BUILD_BUG();						\
> -	}								\
> -	__ret;								\
> -})
> -
> -#define cmpxchg(ptr, o, n)						\
> -({									\
> -	__typeof__(*(ptr)) _o_ = (o);					\
> -	__typeof__(*(ptr)) _n_ = (n);					\
> -	(__typeof__(*(ptr))) __cmpxchg((ptr),				\
> -				       _o_, _n_, sizeof(*(ptr)));	\
> -})
> -
> -#define cmpxchg_local(ptr, o, n)					\
> -	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
> -
> -#define cmpxchg32(ptr, o, n)						\
> -({									\
> -	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
> -	cmpxchg((ptr), (o), (n));					\
> -})
> -
> -#define cmpxchg32_local(ptr, o, n)					\
> -({									\
> -	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
> -	cmpxchg_relaxed((ptr), (o), (n))				\
> -})
> -
> -#define cmpxchg64(ptr, o, n)						\
> -({									\
> -	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
> -	cmpxchg((ptr), (o), (n));					\
> -})
> -
> -#define cmpxchg64_local(ptr, o, n)					\
> -({									\
> -	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
> -	cmpxchg_relaxed((ptr), (o), (n));				\
> -})
> -
>  #endif /* _ASM_RISCV_CMPXCHG_H */
