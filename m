Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E543D8D8E
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 14:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhG1MPM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 08:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhG1MPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 08:15:12 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D185EC061757
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 05:15:09 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id 10so2396111ill.10
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wq+44rMyw+nm1QI5OooqBcOgYMNbu/1V3K1tab5r+xs=;
        b=WGQlrUOYClPE93J+WQkD3G+pgTggX4+1JxwVK/7eaKwbx8u8iov99A3iC7VbzFAcdp
         rTPfX0hQexdKnIZDSx6yNCQHcZN5gscFDG0D3g8olDwLjzugEg9RFGbxyCeg4qvFM5VB
         n/1gy0zixWSUNoMSfET4wefnb1i/yFmGWZ12qLxzXB4x9hrkosay+p8mE7U9ILAatfMO
         YMyMgr7EuihL7+DH0xowkTIMZdOmjwPNmmSO4tuWm6REMFAgx/yZDIabsjMXZ3ipvYUc
         wt9faOKl7gnjYx8tcC06FpXAJuFjI1Zr3btecwcikfNGtHzwxXhcvGZ6FnH+6kWZjVdG
         9RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wq+44rMyw+nm1QI5OooqBcOgYMNbu/1V3K1tab5r+xs=;
        b=o7Hi3q1dcacHLrZVh2dCjy/HwtTKW3dplVWbnB53AyI360PKUEsOqwQlcQ3aVv5SLi
         pQ4qIcYtDXJNfy/ArxFq6H56G5o/AEy957KzE7wlpgzVr1CZIi5qm88yqsHP2SucOOhu
         yP2gyz23dsvhqd5CHjXUMaaE7cCPDvTgsPRE5K1I3JHHiljC4CXB9SZwWBoAyUi1RuGu
         mmdo4U9o35vDpQMJzFkjYTwGRSK3bnypdpPk+Kyou7N3vzLWH3tX+ucDNKNkXBe4XhTz
         0SKSDMPtnlXDy8cI3fjMpJH4AkB9W5HqByiMgT4gaE88QkC3HAcNEui4VkQoEkDIe/4p
         Bbhw==
X-Gm-Message-State: AOAM533kquHlFqO/JYkcHZb2o6s7ohCnNMWvwhs6Xwur7ZUJ7XYUjYyU
        ADJ39exuorN6wB03Ifo+cXI=
X-Google-Smtp-Source: ABdhPJzDUlc0Qk2uSfVJIg0bAHVU1WjSmejgSqmJAtcwhKZTl+khA/U4HUJX6xwu7f/ieHiwjoFQMw==
X-Received: by 2002:a92:c5c5:: with SMTP id s5mr19322618ilt.271.1627474509171;
        Wed, 28 Jul 2021 05:15:09 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 204sm4884004ioc.50.2021.07.28.05.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:15:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A94BF27C0054;
        Wed, 28 Jul 2021 08:15:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 28 Jul 2021 08:15:07 -0400
X-ME-Sender: <xms:SUoBYZSssQP1G6BhB_S2qGUtG5JfMTfnl_F8voaOVvZz2GdNUUCtKg>
    <xme:SUoBYSyPGewNswARel2UZVdi3sJgyNpZAk5cQgbN2ZaD4qnCJ_2sQ1P1npyFveUiI
    tbxZrGuj9C48_YHJA>
X-ME-Received: <xmr:SUoBYe3Vc5lLINmpz5x0ltFA0RIB-eiyiT6gA1ZI2kgCi__lsKJuJpygA6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeelgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:SUoBYRBw5Gk0Jg8oYAJF42EMoeKzjrOFklPIFbZiziT4_VmWphciGA>
    <xmx:SUoBYSjb9b1vvQXpCGCTkOjh1_wQtDQDARhWp_qx511ffN3xOcyR4A>
    <xmx:SUoBYVrcWv6vf7WzRtml3NjVSyZmHn3yrS6_SiaRbFZG5tt7ca8eTw>
    <xmx:S0oBYTbm2bDeI4XHp6EkLNaYtN1aVpxVj28cgzaiDwYy9yPEVeelNoSSitY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jul 2021 08:15:04 -0400 (EDT)
Date:   Wed, 28 Jul 2021 20:14:45 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Rui Wang <wangrui@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, hev <r@hev.cc>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
Message-ID: <YQFKNcyHHWph8SjO@boqun-archlinux>
References: <20210728114822.1243-1-wangrui@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728114822.1243-1-wangrui@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Thanks for the patchset. Seems that your git send-email command doesn't
add the "In-Reply-to" tag for patch #2 to #5, so they are not threaded
to patch #1. Not a big deal, but archives or email clients use that
information to organize emails. You may want to check the command. Also,
note that you can always use "--dry-run" option to preview the headers
of your patchset ("--dry-run" won't do the actual send).

On Wed, Jul 28, 2021 at 07:48:22PM +0800, Rui Wang wrote:
> From: wangrui <wangrui@loongson.cn>
> 
> This patch introduce a new atomic primitive 'and_or', It may be have three
> types of implemeations:
> 
>  * The generic implementation is based on arch_cmpxchg.
>  * The hardware supports atomic 'and_or' of single instruction.
>  * The hardware supports LL/SC style atomic operations:
> 
>    1:  ll  v1, mem
>        and t1, v1, arg1
>        or  t1, t1, arg2
>        sc  t1, mem
>        beq t1, 0, 1b
> 
> Now that all the architectures have implemented it.
> 
> Signed-by-off: Rui Wang <wangrui@loongson.cn>
> Signed-by-off: hev <r@hev.cc>

First, this should be "Signed-off-by" ;-) Second, is the second
"Signed-off-by" a mistake?

I will look into this for a review, in the meanwhile, but please add
some tests in lib/atomic64_test.c, not only it will do the test at
runtime, also it will generate asm code which helps people to review.

Regards,
Boqun

> ---
>  arch/alpha/include/asm/atomic.h           | 27 ++++++++++++
>  arch/arc/include/asm/atomic.h             | 52 +++++++++++++++++++++++
>  arch/arm/include/asm/atomic.h             | 44 +++++++++++++++++++
>  arch/arm64/include/asm/atomic.h           | 16 +++++++
>  arch/arm64/include/asm/atomic_ll_sc.h     | 33 ++++++++++++++
>  arch/hexagon/include/asm/atomic.h         | 24 +++++++++++
>  arch/ia64/include/asm/atomic.h            | 18 ++++++++
>  arch/m68k/include/asm/atomic.h            | 36 ++++++++++++++++
>  arch/mips/include/asm/atomic.h            | 41 ++++++++++++++++++
>  arch/openrisc/include/asm/atomic.h        | 22 ++++++++++
>  arch/parisc/include/asm/atomic.h          | 20 +++++++++
>  arch/powerpc/include/asm/atomic.h         | 26 ++++++++++++
>  arch/riscv/include/asm/atomic.h           | 25 +++++++++++
>  arch/s390/include/asm/atomic.h            |  2 +
>  arch/s390/include/asm/atomic_ops.h        | 25 +++++++++++
>  arch/sparc/include/asm/atomic_32.h        |  2 +
>  arch/sparc/lib/atomic32.c                 | 17 ++++++++
>  arch/x86/include/asm/atomic.h             | 10 +++++
>  arch/xtensa/include/asm/atomic.h          | 49 +++++++++++++++++++++
>  include/asm-generic/atomic-instrumented.h | 28 ++++++++++++
>  include/asm-generic/atomic.h              | 29 +++++++++++++
>  include/linux/atomic-arch-fallback.h      | 42 ++++++++++++++++++
>  22 files changed, 588 insertions(+)
> 
> diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
> index f2861a43a61e..deb05ac292b8 100644
> --- a/arch/alpha/include/asm/atomic.h
> +++ b/arch/alpha/include/asm/atomic.h
> @@ -91,6 +91,25 @@ static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
>  	return result;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, asm_op1, asm_op2)					\
> +static inline int arch_atomic_fetch_##op##_relaxed(int i, int j, atomic_t *v)	\
> +{									\
> +	long temp, result;						\
> +	__asm__ __volatile__(						\
> +	"1:	ldl_l %2,%1\n"						\
> +	"	" #asm_op1 " %2,%3,%0\n"				\
> +	"	" #asm_op2 " %0,%4,%0\n"				\
> +	"	stl_c %0,%1\n"						\
> +	"	beq %0,2f\n"						\
> +	".subsection 2\n"						\
> +	"2:	br 1b\n"						\
> +	".previous"							\
> +	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
> +	:"Ir" (i), "Ir" (j), "m" (v->counter) : "memory");		\
> +	smp_mb();							\
> +	return result;							\
> +}
> +
>  #define ATOMIC64_OP(op, asm_op)						\
>  static __inline__ void arch_atomic64_##op(s64 i, atomic64_t * v)	\
>  {									\
> @@ -182,10 +201,17 @@ ATOMIC_OPS(andnot, bic)
>  ATOMIC_OPS(or, bis)
>  ATOMIC_OPS(xor, xor)
>  
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(op, asm_op1, asm_op2)			\
> +	ATOMIC_FETCH_OP2(op, asm_op1, asm_op2)			\
> +
> +ATOMIC_OPS(and_or, and, bis)
> +
>  #define arch_atomic_fetch_and_relaxed		arch_atomic_fetch_and_relaxed
>  #define arch_atomic_fetch_andnot_relaxed	arch_atomic_fetch_andnot_relaxed
>  #define arch_atomic_fetch_or_relaxed		arch_atomic_fetch_or_relaxed
>  #define arch_atomic_fetch_xor_relaxed		arch_atomic_fetch_xor_relaxed
> +#define arch_atomic_fetch_and_or_relaxed	arch_atomic_fetch_and_or_relaxed
>  
>  #define arch_atomic64_fetch_and_relaxed		arch_atomic64_fetch_and_relaxed
>  #define arch_atomic64_fetch_andnot_relaxed	arch_atomic64_fetch_andnot_relaxed
> @@ -197,6 +223,7 @@ ATOMIC_OPS(xor, xor)
>  #undef ATOMIC64_OP_RETURN
>  #undef ATOMIC64_OP
>  #undef ATOMIC_FETCH_OP
> +#undef ATOMIC_FETCH_OP2
>  #undef ATOMIC_OP_RETURN
>  #undef ATOMIC_OP
>  
> diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
> index 7a36d79b5b2f..1aa9e0f396d7 100644
> --- a/arch/arc/include/asm/atomic.h
> +++ b/arch/arc/include/asm/atomic.h
> @@ -89,6 +89,35 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
>  	return orig;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2, asm_op1, asm_op2)		\
> +static inline int arch_atomic_fetch_##op(int i, int j, atomic_t *v)	\
> +{									\
> +	unsigned int val, orig;						\
> +									\
> +	/*								\
> +	 * Explicit full memory barrier needed before/after as		\
> +	 * LLOCK/SCOND themselves don't provide any such semantics	\
> +	 */								\
> +	smp_mb();							\
> +									\
> +	__asm__ __volatile__(						\
> +	"1:	llock   %[orig], [%[ctr]]		\n"		\
> +	"	" #asm_op1 " %[val], %[orig], %[i]	\n"		\
> +	"	" #asm_op2 " %[val], %[val], %[j]	\n"		\
> +	"	scond   %[val], [%[ctr]]		\n"		\
> +	"	bnz     1b				\n"		\
> +	: [val]	"=&r"	(val),						\
> +	  [orig] "=&r" (orig)						\
> +	: [ctr]	"r"	(&v->counter),					\
> +	  [i]	"ir"	(i),						\
> +	  [j]	"ir"	(j),						\
> +	: "cc");							\
> +									\
> +	smp_mb();							\
> +									\
> +	return orig;							\
> +}
> +
>  #else	/* !CONFIG_ARC_HAS_LLSC */
>  
>  #ifndef CONFIG_SMP
> @@ -170,6 +199,23 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
>  	return orig;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2, asm_op1, asm_op2)		\
> +static inline int arch_atomic_fetch_##op(int i, int j, atomic_t *v)	\
> +{									\
> +	unsigned long flags;						\
> +	unsigned long orig;						\
> +									\
> +	/*								\
> +	 * spin lock/unlock provides the needed smp_mb() before/after	\
> +	 */								\
> +	atomic_ops_lock(flags);						\
> +	orig = v->counter;						\
> +	v->counter = (orig c_op1 i) c_op2 j;				\
> +	atomic_ops_unlock(flags);					\
> +									\
> +	return orig;							\
> +}
> +
>  #endif /* !CONFIG_ARC_HAS_LLSC */
>  
>  #define ATOMIC_OPS(op, c_op, asm_op)					\
> @@ -190,6 +236,12 @@ ATOMIC_OPS(andnot, &= ~, bic)
>  ATOMIC_OPS(or, |=, or)
>  ATOMIC_OPS(xor, ^=, xor)
>  
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(op, c_op1, c_op2, asm_op1, asm_op2)			\
> +	ATOMIC_FETCH_OP2(op, c_op1, c_op2, asm_op1, asm_op2)
> +
> +ATOMIC_OPS(and_or, &, |, and, or)
> +
>  #define arch_atomic_andnot		arch_atomic_andnot
>  #define arch_atomic_fetch_andnot	arch_atomic_fetch_andnot
>  
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index db8512d9a918..faddbc183ced 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -93,6 +93,28 @@ static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
>  	return result;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2, asm_op1, asm_op2)			\
> +static inline int arch_atomic_fetch_##op##_relaxed(int i, int j, atomic_t *v)	\
> +{									\
> +	unsigned long tmp;						\
> +	int result, val;						\
> +									\
> +	prefetchw(&v->counter);						\
> +									\
> +	__asm__ __volatile__("@ atomic_fetch_" #op "\n"			\
> +"1:	ldrex	%0, [%4]\n"						\
> +"	" #asm_op1 "	%1, %0, %5\n"					\
> +"	" #asm_op2 "	%1, %1, %6\n"					\
> +"	strex	%2, %1, [%4]\n"						\
> +"	teq	%2, #0\n"						\
> +"	bne	1b"							\
> +	: "=&r" (result), "=&r" (val), "=&r" (tmp), "+Qo" (v->counter)	\
> +	: "r" (&v->counter), "Ir" (i), "Ir" (j)				\
> +	: "cc");							\
> +									\
> +	return result;							\
> +}
> +
>  #define arch_atomic_add_return_relaxed		arch_atomic_add_return_relaxed
>  #define arch_atomic_sub_return_relaxed		arch_atomic_sub_return_relaxed
>  #define arch_atomic_fetch_add_relaxed		arch_atomic_fetch_add_relaxed
> @@ -102,6 +124,7 @@ static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
>  #define arch_atomic_fetch_andnot_relaxed	arch_atomic_fetch_andnot_relaxed
>  #define arch_atomic_fetch_or_relaxed		arch_atomic_fetch_or_relaxed
>  #define arch_atomic_fetch_xor_relaxed		arch_atomic_fetch_xor_relaxed
> +#define arch_atomic_fetch_and_or_relaxed	arch_atomic_fetch_and_or_relaxed
>  
>  static inline int arch_atomic_cmpxchg_relaxed(atomic_t *ptr, int old, int new)
>  {
> @@ -197,6 +220,20 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
>  	return val;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2, asm_op1, asm_op2)		\
> +static inline int arch_atomic_fetch_##op(int i, int j, atomic_t *v)	\
> +{									\
> +	unsigned long flags;						\
> +	int val;							\
> +									\
> +	raw_local_irq_save(flags);					\
> +	val = v->counter;						\
> +	v->counter = (val c_op1 i) c_op2 j;				\
> +	raw_local_irq_restore(flags);					\
> +									\
> +	return val;							\
> +}
> +
>  static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
>  {
>  	int ret;
> @@ -235,8 +272,15 @@ ATOMIC_OPS(andnot, &= ~, bic)
>  ATOMIC_OPS(or,  |=, orr)
>  ATOMIC_OPS(xor, ^=, eor)
>  
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(op, c_op1, c_op2, asm_op1, asm_op2)		\
> +	ATOMIC_FETCH_OP2(op, c_op1, c_op2, asm_op1, asm_op2)
> +
> +ATOMIC_OPS(and_or, &, |, and, orr)
> +
>  #undef ATOMIC_OPS
>  #undef ATOMIC_FETCH_OP
> +#undef ATOMIC_FETCH_OP2
>  #undef ATOMIC_OP_RETURN
>  #undef ATOMIC_OP
>  
> diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
> index c9979273d389..3f1cdd3e2ef9 100644
> --- a/arch/arm64/include/asm/atomic.h
> +++ b/arch/arm64/include/asm/atomic.h
> @@ -43,6 +43,12 @@ static __always_inline int arch_##op##name(int i, atomic_t *v)		\
>  	ATOMIC_FETCH_OP(_release, op)					\
>  	ATOMIC_FETCH_OP(        , op)
>  
> +#define ATOMIC_FETCH_OP2(name, op)					\
> +static __always_inline int arch_##op##name(int i, int j, atomic_t *v)	\
> +{									\
> +	return __ll_sc_##op##name(i, j, v);				\
> +}
> +
>  ATOMIC_FETCH_OPS(atomic_fetch_andnot)
>  ATOMIC_FETCH_OPS(atomic_fetch_or)
>  ATOMIC_FETCH_OPS(atomic_fetch_xor)
> @@ -52,7 +58,17 @@ ATOMIC_FETCH_OPS(atomic_fetch_sub)
>  ATOMIC_FETCH_OPS(atomic_add_return)
>  ATOMIC_FETCH_OPS(atomic_sub_return)
>  
> +#undef ATOMIC_FETCH_OPS
> +#define ATOMIC_FETCH_OPS(op)						\
> +	ATOMIC_FETCH_OP2(_relaxed, op)					\
> +	ATOMIC_FETCH_OP2(_acquire, op)					\
> +	ATOMIC_FETCH_OP2(_release, op)					\
> +	ATOMIC_FETCH_OP2(        , op)
> +
> +ATOMIC_FETCH_OPS(atomic_fetch_and_or)
> +
>  #undef ATOMIC_FETCH_OP
> +#undef ATOMIC_FETCH_OP2
>  #undef ATOMIC_FETCH_OPS
>  
>  #define ATOMIC64_OP(op)							\
> diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
> index 13869b76b58c..90289c536ed6 100644
> --- a/arch/arm64/include/asm/atomic_ll_sc.h
> +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> @@ -97,6 +97,29 @@ __ll_sc_atomic_fetch_##op##name(int i, atomic_t *v)			\
>  	return result;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(name, mb, acq, rel, cl, op, asm_op1, asm_op2, cstr) \
> +static inline int							\
> +__ll_sc_atomic_fetch_##op##name(int i, int j, atomic_t *v)		\
> +{									\
> +	unsigned long tmp;						\
> +	int val, result;						\
> +									\
> +	asm volatile("// atomic_fetch_" #op #name "\n"			\
> +	__LL_SC_FALLBACK(						\
> +"	prfm	pstl1strm, %3\n"					\
> +"1:	ld" #acq "xr	%w0, %3\n"					\
> +"	" #asm_op1 "	%w1, %w0, %w4\n"				\
> +"	" #asm_op2 "	%w1, %w1, %w5\n"				\
> +"	st" #rel "xr	%w2, %w1, %3\n"					\
> +"	cbnz	%w2, 1b\n"						\
> +"	" #mb )								\
> +	: "=&r" (result), "=&r" (val), "=&r" (tmp), "+Q" (v->counter)	\
> +	: __stringify(cstr) "r" (i), __stringify(cstr) "r" (j)		\
> +	: cl);								\
> +									\
> +	return result;							\
> +}
> +
>  #define ATOMIC_OPS(...)							\
>  	ATOMIC_OP(__VA_ARGS__)						\
>  	ATOMIC_OP_RETURN(        , dmb ish,  , l, "memory", __VA_ARGS__)\
> @@ -129,8 +152,18 @@ ATOMIC_OPS(xor, eor, K)
>   */
>  ATOMIC_OPS(andnot, bic, )
>  
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(...)							\
> +	ATOMIC_FETCH_OP2 (        , dmb ish,  , l, "memory", __VA_ARGS__)\
> +	ATOMIC_FETCH_OP2 (_relaxed,        ,  ,  ,         , __VA_ARGS__)\
> +	ATOMIC_FETCH_OP2 (_acquire,        , a,  , "memory", __VA_ARGS__)\
> +	ATOMIC_FETCH_OP2 (_release,        ,  , l, "memory", __VA_ARGS__)
> +
> +ATOMIC_OPS(and_or, and, orr, K)
> +
>  #undef ATOMIC_OPS
>  #undef ATOMIC_FETCH_OP
> +#undef ATOMIC_FETCH_OP2
>  #undef ATOMIC_OP_RETURN
>  #undef ATOMIC_OP
>  
> diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
> index 6e94f8d04146..d944e210085a 100644
> --- a/arch/hexagon/include/asm/atomic.h
> +++ b/arch/hexagon/include/asm/atomic.h
> @@ -130,6 +130,24 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
>  	return output;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op1, op2)					\
> +static inline int arch_atomic_fetch_##op1##_##op2(int i, int j, atomic_t *v)\
> +{									\
> +	int output, val;						\
> +									\
> +	__asm__ __volatile__ (						\
> +		"1:	%0 = memw_locked(%2);\n"			\
> +		"	%1 = "#op1 "(%0,%3);\n"				\
> +		"	%1 = "#op2 "(%1,%4);\n"				\
> +		"	memw_locked(%2,P3)=%1;\n"			\
> +		"	if (!P3) jump 1b;\n"				\
> +		: "=&r" (output), "=&r" (val)				\
> +		: "r" (&v->counter), "r" (i), "r" (j)			\
> +		: "memory", "p3"					\
> +	);								\
> +	return output;							\
> +}
> +
>  #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(op)
>  
>  ATOMIC_OPS(add)
> @@ -142,8 +160,14 @@ ATOMIC_OPS(and)
>  ATOMIC_OPS(or)
>  ATOMIC_OPS(xor)
>  
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(op1, op2) ATOMIC_FETCH_OP2(op1, op2)
> +
> +ATOMIC_OPS(and, or)
> +
>  #undef ATOMIC_OPS
>  #undef ATOMIC_FETCH_OP
> +#undef ATOMIC_FETCH_OP2
>  #undef ATOMIC_OP_RETURN
>  #undef ATOMIC_OP
>  
> diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
> index 266c429b9137..6190108dcd53 100644
> --- a/arch/ia64/include/asm/atomic.h
> +++ b/arch/ia64/include/asm/atomic.h
> @@ -57,6 +57,21 @@ ia64_atomic_fetch_##op (int i, atomic_t *v)				\
>  	return old;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2)				\
> +static __inline__ int							\
> +ia64_atomic_fetch_##op (int i, int j, atomic_t *v)			\
> +{									\
> +	__s32 old, new;							\
> +	CMPXCHG_BUGCHECK_DECL						\
> +									\
> +	do {								\
> +		CMPXCHG_BUGCHECK(v);					\
> +		old = arch_atomic_read(v);				\
> +		new = (old c_op1 i) c_op2 j;				\
> +	} while (ia64_cmpxchg(acq, v, old, new, sizeof(atomic_t)) != old); \
> +	return old;							\
> +}
> +
>  #define ATOMIC_OPS(op, c_op)						\
>  	ATOMIC_OP(op, c_op)						\
>  	ATOMIC_FETCH_OP(op, c_op)
> @@ -109,6 +124,7 @@ ATOMIC_OPS(sub, -)
>  ATOMIC_FETCH_OP(and, &)
>  ATOMIC_FETCH_OP(or, |)
>  ATOMIC_FETCH_OP(xor, ^)
> +ATOMIC_FETCH_OP2(and_or, &, |)
>  
>  #define arch_atomic_and(i,v)	(void)ia64_atomic_fetch_and(i,v)
>  #define arch_atomic_or(i,v)	(void)ia64_atomic_fetch_or(i,v)
> @@ -117,9 +133,11 @@ ATOMIC_FETCH_OP(xor, ^)
>  #define arch_atomic_fetch_and(i,v)	ia64_atomic_fetch_and(i,v)
>  #define arch_atomic_fetch_or(i,v)	ia64_atomic_fetch_or(i,v)
>  #define arch_atomic_fetch_xor(i,v)	ia64_atomic_fetch_xor(i,v)
> +#define arch_atomic_fetch_and_or(i,j,v)	ia64_atomic_fetch_and_or(i,j,v)
>  
>  #undef ATOMIC_OPS
>  #undef ATOMIC_FETCH_OP
> +#undef ATOMIC_FETCH_OP2
>  #undef ATOMIC_OP
>  
>  #define ATOMIC64_OP(op, c_op)						\
> diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
> index 8637bf8a2f65..480ecb6534a3 100644
> --- a/arch/m68k/include/asm/atomic.h
> +++ b/arch/m68k/include/asm/atomic.h
> @@ -67,6 +67,22 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
>  	return tmp;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2, asm_op1, asm_op2)		\
> +static inline int arch_atomic_fetch_##op(int i, int j, atomic_t *v)	\
> +{									\
> +	int t, tmp;							\
> +									\
> +	__asm__ __volatile__(						\
> +			"1:	movel %2,%1\n"				\
> +			"	" #asm_op1 "l %3,%1\n"			\
> +			"	" #asm_op2 "l %4,%1\n"			\
> +			"	casl %2,%1,%0\n"			\
> +			"	jne 1b"					\
> +			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
> +			: "g" (i), "g" (j), "2" (arch_atomic_read(v)));	\
> +	return tmp;							\
> +}
> +
>  #else
>  
>  #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
> @@ -96,6 +112,20 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t * v)		\
>  	return t;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2, asm_op1, asm_op2)		\
> +static inline int arch_atomic_fetch_##op(int i, int j, atomic_t * v)	\
> +{									\
> +	unsigned long flags;						\
> +	int t;								\
> +									\
> +	local_irq_save(flags);						\
> +	t = v->counter;							\
> +	v->counter = (t c_op1 i) c_op2 j;				\
> +	local_irq_restore(flags);					\
> +									\
> +	return t;							\
> +}
> +
>  #endif /* CONFIG_RMW_INSNS */
>  
>  #define ATOMIC_OPS(op, c_op, asm_op)					\
> @@ -115,6 +145,12 @@ ATOMIC_OPS(and, &=, and)
>  ATOMIC_OPS(or, |=, or)
>  ATOMIC_OPS(xor, ^=, eor)
>  
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(op, c_op1, c_op2, asm_op1, asm_op2)			\
> +	ATOMIC_FETCH_OP2(op, c_op1, c_op2, asm_op1, asm_op2)
> +
> +ATOMIC_OPS(and_or, &, |, and, or)
> +
>  #undef ATOMIC_OPS
>  #undef ATOMIC_FETCH_OP
>  #undef ATOMIC_OP_RETURN
> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
> index 95e1f7f3597f..84319b1ab9b6 100644
> --- a/arch/mips/include/asm/atomic.h
> +++ b/arch/mips/include/asm/atomic.h
> @@ -147,6 +147,39 @@ arch_##pfx##_fetch_##op##_relaxed(type i, pfx##_t * v)			\
>  	return result;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(pfx, op, type, c_op1, c_op2, asm_op1, asm_op2, ll, sc)\
> +static __inline__ type							\
> +arch_##pfx##_fetch_##op##_relaxed(type i, type j, pfx##_t * v)		\
> +{									\
> +	int temp, result;						\
> +									\
> +	if (!kernel_uses_llsc) {					\
> +		unsigned long flags;					\
> +									\
> +		raw_local_irq_save(flags);				\
> +		result = v->counter;					\
> +		v->counter = (result c_op1 i) c_op2 j;			\
> +		raw_local_irq_restore(flags);				\
> +		return result;						\
> +	}								\
> +									\
> +	__asm__ __volatile__(						\
> +	"	.set	push					\n"	\
> +	"	.set	" MIPS_ISA_LEVEL "			\n"	\
> +	"	" __SYNC(full, loongson3_war) "			\n"	\
> +	"1:	" #ll "	%0, %2		# " #pfx "_fetch_" #op "\n"	\
> +	"	" #asm_op1 " %1, %0, %3				\n"	\
> +	"	" #asm_op2 " %1, %1, %4				\n"	\
> +	"	" #sc "	%1, %2					\n"	\
> +	"\t" __SC_BEQZ "%1, 1b					\n"	\
> +	"	.set	pop					\n"	\
> +	: "=&r" (result), "=&r" (temp),					\
> +	  "+" GCC_OFF_SMALL_ASM() (v->counter)				\
> +	: "Ir" (i), "Ir" (j) : __LLSC_CLOBBER);				\
> +									\
> +	return result;							\
> +}
> +
>  #undef ATOMIC_OPS
>  #define ATOMIC_OPS(pfx, op, type, c_op, asm_op, ll, sc)			\
>  	ATOMIC_OP(pfx, op, type, c_op, asm_op, ll, sc)			\
> @@ -179,9 +212,16 @@ ATOMIC_OPS(atomic, and, int, &=, and, ll, sc)
>  ATOMIC_OPS(atomic, or, int, |=, or, ll, sc)
>  ATOMIC_OPS(atomic, xor, int, ^=, xor, ll, sc)
>  
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(pfx, op, type, c_op1, c_op2, asm_op1, asm_op2, ll, sc)	\
> +	ATOMIC_FETCH_OP2(pfx, op, type, c_op1, c_op2, asm_op1, asm_op2, ll, sc)
> +
> +ATOMIC_OPS(atomic, and_or, int, &, |, and, or, ll, sc)
> +
>  #define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
>  #define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
>  #define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
> +#define arch_atomic_fetch_and_or_relaxed	arch_atomic_fetch_and_or_relaxed
>  
>  #ifdef CONFIG_64BIT
>  ATOMIC_OPS(atomic64, and, s64, &=, and, lld, scd)
> @@ -194,6 +234,7 @@ ATOMIC_OPS(atomic64, xor, s64, ^=, xor, lld, scd)
>  
>  #undef ATOMIC_OPS
>  #undef ATOMIC_FETCH_OP
> +#undef ATOMIC_FETCH_OP2
>  #undef ATOMIC_OP_RETURN
>  #undef ATOMIC_OP
>  
> diff --git a/arch/openrisc/include/asm/atomic.h b/arch/openrisc/include/asm/atomic.h
> index 326167e4783a..04598ef16977 100644
> --- a/arch/openrisc/include/asm/atomic.h
> +++ b/arch/openrisc/include/asm/atomic.h
> @@ -66,6 +66,25 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
>  	return old;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op1, op2)					\
> +static inline int arch_atomic_fetch_##op1##_##op2(int i, int j, atomic_t *v)	\
> +{									\
> +	int tmp, old;							\
> +									\
> +	__asm__ __volatile__(						\
> +		"1:	l.lwa	%0,0(%2)	\n"			\
> +		"	l." #op1 " %1,%0,%3	\n"			\
> +		"	l." #op2 " %1,%1,%4	\n"			\
> +		"	l.swa	0(%2),%1	\n"			\
> +		"	l.bnf	1b		\n"			\
> +		"	 l.nop			\n"			\
> +		: "=&r"(old), "=&r"(tmp)				\
> +		: "r"(&v->counter), "r"(i), "r"(j)			\
> +		: "cc", "memory");					\
> +									\
> +	return old;							\
> +}
> +
>  ATOMIC_OP_RETURN(add)
>  ATOMIC_OP_RETURN(sub)
>  
> @@ -74,6 +93,7 @@ ATOMIC_FETCH_OP(sub)
>  ATOMIC_FETCH_OP(and)
>  ATOMIC_FETCH_OP(or)
>  ATOMIC_FETCH_OP(xor)
> +ATOMIC_FETCH_OP2(and, or)
>  
>  ATOMIC_OP(add)
>  ATOMIC_OP(sub)
> @@ -82,6 +102,7 @@ ATOMIC_OP(or)
>  ATOMIC_OP(xor)
>  
>  #undef ATOMIC_FETCH_OP
> +#undef ATOMIC_FETCH_OP2
>  #undef ATOMIC_OP_RETURN
>  #undef ATOMIC_OP
>  
> @@ -92,6 +113,7 @@ ATOMIC_OP(xor)
>  #define arch_atomic_fetch_and	arch_atomic_fetch_and
>  #define arch_atomic_fetch_or	arch_atomic_fetch_or
>  #define arch_atomic_fetch_xor	arch_atomic_fetch_xor
> +#define arch_atomic_fetch_and_or	arch_atomic_fetch_and_or
>  #define arch_atomic_add		arch_atomic_add
>  #define arch_atomic_sub		arch_atomic_sub
>  #define arch_atomic_and		arch_atomic_and
> diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
> index dd5a299ada69..59b9685ed2b1 100644
> --- a/arch/parisc/include/asm/atomic.h
> +++ b/arch/parisc/include/asm/atomic.h
> @@ -114,6 +114,20 @@ static __inline__ int arch_atomic_fetch_##op(int i, atomic_t *v)	\
>  	return ret;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2)				\
> +static __inline__ int arch_atomic_fetch_##op(int i, int j, atomic_t *v)\
> +{									\
> +	unsigned long flags;						\
> +	int ret;							\
> +									\
> +	_atomic_spin_lock_irqsave(v, flags);				\
> +	ret = v->counter;						\
> +	v->counter = (ret c_op1 i) c_op2 j;				\
> +	_atomic_spin_unlock_irqrestore(v, flags);			\
> +									\
> +	return ret;							\
> +}
> +
>  #define ATOMIC_OPS(op, c_op)						\
>  	ATOMIC_OP(op, c_op)						\
>  	ATOMIC_OP_RETURN(op, c_op)					\
> @@ -131,6 +145,12 @@ ATOMIC_OPS(and, &=)
>  ATOMIC_OPS(or, |=)
>  ATOMIC_OPS(xor, ^=)
>  
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(op, c_op1, c_op2)					\
> +	ATOMIC_FETCH_OP2(op, c_op1, c_op2)
> +
> +ATOMIC_OPS(and_or, &, |)
> +
>  #undef ATOMIC_OPS
>  #undef ATOMIC_FETCH_OP
>  #undef ATOMIC_OP_RETURN
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> index a1732a79e92a..c2e966ab4b81 100644
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -86,6 +86,24 @@ static inline int arch_atomic_fetch_##op##_relaxed(int a, atomic_t *v)	\
>  	return res;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2_RELAXED(op, asm_op1, asm_op2)			\
> +static inline int arch_atomic_fetch_##op##_relaxed(int a, int b, atomic_t *v)\
> +{									\
> +	int res, t;							\
> +									\
> +	__asm__ __volatile__(						\
> +"1:	lwarx	%0,0,%5		# atomic_fetch_" #op "_relaxed\n"	\
> +	#asm_op1 " %1,%3,%0\n"						\
> +	#asm_op2 " %1,%4,%1\n"						\
> +"	stwcx.	%1,0,%5\n"						\
> +"	bne-	1b\n"							\
> +	: "=&r" (res), "=&r" (t), "+m" (v->counter)			\
> +	: "r" (a), "r" (b), "r" (&v->counter)				\
> +	: "cc");							\
> +									\
> +	return res;							\
> +}
> +
>  #define ATOMIC_OPS(op, asm_op)						\
>  	ATOMIC_OP(op, asm_op)						\
>  	ATOMIC_OP_RETURN_RELAXED(op, asm_op)				\
> @@ -109,12 +127,20 @@ ATOMIC_OPS(and, and)
>  ATOMIC_OPS(or, or)
>  ATOMIC_OPS(xor, xor)
>  
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(op, asm_op1, asm_op2)			\
> +	ATOMIC_FETCH_OP2_RELAXED(op, asm_op1, asm_op2)
> +
> +ATOMIC_OPS(and_or, and, or)
> +
>  #define arch_atomic_fetch_and_relaxed arch_atomic_fetch_and_relaxed
>  #define arch_atomic_fetch_or_relaxed  arch_atomic_fetch_or_relaxed
>  #define arch_atomic_fetch_xor_relaxed arch_atomic_fetch_xor_relaxed
> +#define arch_atomic_fetch_and_or_relaxed arch_atomic_fetch_and_or_relaxed
>  
>  #undef ATOMIC_OPS
>  #undef ATOMIC_FETCH_OP_RELAXED
> +#undef ATOMIC_FETCH_OP2_RELAXED
>  #undef ATOMIC_OP_RETURN_RELAXED
>  #undef ATOMIC_OP
>  
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index ac9bdf4fc404..572ca0ae2e76 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -110,6 +110,24 @@ c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
>  	return ret;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, asm_op1, asm_op2, asm_type, c_type, prefix)	\
> +static __always_inline								\
> +c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,	c_type j,	\
> +					     atomic##prefix##_t *v)	\
> +{									\
> +	register c_type ret, tmp;					\
> +	__asm__ __volatile__ (						\
> +		"0:	lr." #asm_type " %0,  %2\n"			\
> +		"	" #asm_op1 "%1, %0, %3\n"			\
> +		"	" #asm_op2 "%1, %1, %4\n"			\
> +		"	sc." #asm_type " %1, %1, %2\n"			\
> +		"	bnez     %1, 0b\n"				\
> +		: "=r" (ret), "=&r" (tmp), "+A" (v->counter)		\
> +		: "r" (i), "r" (j)					\
> +		: "memory");						\
> +	return ret;							\
> +}
> +
>  #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)	\
>  static __always_inline							\
>  c_type arch_atomic##prefix##_##op##_return_relaxed(c_type i,		\
> @@ -175,9 +193,15 @@ ATOMIC_OPS(and, and, i)
>  ATOMIC_OPS( or,  or, i)
>  ATOMIC_OPS(xor, xor, i)
>  
> +#define ATOMIC_OPS(op, asm_op1, asm_op2, I)			\
> +        ATOMIC_FETCH_OP2(op, asm_op1, asm_op2, I, w, int,)
> +
> +ATOMIC_OPS(and_or, and, or, w)
> +
>  #define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
>  #define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
>  #define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
> +#define arch_atomic_fetch_and_or_relaxed	arch_atomic_fetch_and_or_relaxed
>  #define arch_atomic_fetch_and		arch_atomic_fetch_and
>  #define arch_atomic_fetch_or		arch_atomic_fetch_or
>  #define arch_atomic_fetch_xor		arch_atomic_fetch_xor
> @@ -194,6 +218,7 @@ ATOMIC_OPS(xor, xor, i)
>  #undef ATOMIC_OPS
>  
>  #undef ATOMIC_FETCH_OP
> +#undef ATOMIC_FETCH_OP2
>  #undef ATOMIC_OP_RETURN
>  
>  /* This is required to provide a full barrier on success. */
> diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
> index 7138d189cc42..abebd658c1fa 100644
> --- a/arch/s390/include/asm/atomic.h
> +++ b/arch/s390/include/asm/atomic.h
> @@ -62,6 +62,7 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
>  ATOMIC_OPS(and)
>  ATOMIC_OPS(or)
>  ATOMIC_OPS(xor)
> +ATOMIC_OPS(and_or)
>  
>  #undef ATOMIC_OPS
>  
> @@ -71,6 +72,7 @@ ATOMIC_OPS(xor)
>  #define arch_atomic_fetch_and		arch_atomic_fetch_and
>  #define arch_atomic_fetch_or		arch_atomic_fetch_or
>  #define arch_atomic_fetch_xor		arch_atomic_fetch_xor
> +#define arch_atomic_fetch_and_or	arch_atomic_fetch_and_or
>  
>  #define arch_atomic_xchg(v, new)	(arch_xchg(&((v)->counter), new))
>  
> diff --git a/arch/s390/include/asm/atomic_ops.h b/arch/s390/include/asm/atomic_ops.h
> index 50510e08b893..d396f2e2eb9a 100644
> --- a/arch/s390/include/asm/atomic_ops.h
> +++ b/arch/s390/include/asm/atomic_ops.h
> @@ -154,6 +154,31 @@ __ATOMIC64_OPS(__atomic64_xor, "xgr")
>  
>  #endif /* CONFIG_HAVE_MARCH_Z196_FEATURES */
>  
> +#define __ATOMIC_OP2(op_name, op1, op2)				\
> +static inline int op_name(int i, int j, int *ptr)			\
> +{									\
> +	int old, new;							\
> +									\
> +	asm volatile(							\
> +		"0:	lr	%[new],%[old]\n"			\
> +		op1 "	%[new],%[i]\n"					\
> +		op2 "	%[new],%[j]\n"					\
> +		"	cs	%[old],%[new],%[ptr]\n"			\
> +		"	jl	0b"					\
> +		: [old] "=d" (old), [new] "=&d" (new), [ptr] "+Q" (*ptr)\
> +		: [i] "d" (i), [j] "d" (j), "0" (*ptr) : "cc", "memory");\
> +	return old;							\
> +}
> +
> +#define __ATOMIC_OPS(op_name, op1_string, op2_string)			\
> +	__ATOMIC_OP2(op_name, op1_string, op2_string)			\
> +	__ATOMIC_OP2(op_name##_barrier, op1_string, op2_string)
> +
> +__ATOMIC_OPS(__atomic_and_or, "ngr", "ogr")
> +
> +#undef __ATOMIC_OPS
> +#undef __ATOMIC_OP2
> +
>  static inline int __atomic_cmpxchg(int *ptr, int old, int new)
>  {
>  	asm volatile(
> diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
> index d775daa83d12..d062b20eb64c 100644
> --- a/arch/sparc/include/asm/atomic_32.h
> +++ b/arch/sparc/include/asm/atomic_32.h
> @@ -23,6 +23,7 @@ int arch_atomic_fetch_add(int, atomic_t *);
>  int arch_atomic_fetch_and(int, atomic_t *);
>  int arch_atomic_fetch_or(int, atomic_t *);
>  int arch_atomic_fetch_xor(int, atomic_t *);
> +int arch_atomic_fetch_and_or(int, int, atomic_t *);
>  int arch_atomic_cmpxchg(atomic_t *, int, int);
>  int arch_atomic_xchg(atomic_t *, int);
>  int arch_atomic_fetch_add_unless(atomic_t *, int, int);
> @@ -40,6 +41,7 @@ void arch_atomic_set(atomic_t *, int);
>  #define arch_atomic_and(i, v)	((void)arch_atomic_fetch_and((i), (v)))
>  #define arch_atomic_or(i, v)	((void)arch_atomic_fetch_or((i), (v)))
>  #define arch_atomic_xor(i, v)	((void)arch_atomic_fetch_xor((i), (v)))
> +#define arch_atomic_and_or(i, j, v)	((void)arch_atomic_fetch_and_or((i), (j), (v)))
>  
>  #define arch_atomic_sub_return(i, v)	(arch_atomic_add_return(-(int)(i), (v)))
>  #define arch_atomic_fetch_sub(i, v)	(arch_atomic_fetch_add (-(int)(i), (v)))
> diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
> index 8b81d0f00c97..aefb6d91985e 100644
> --- a/arch/sparc/lib/atomic32.c
> +++ b/arch/sparc/lib/atomic32.c
> @@ -43,6 +43,21 @@ int arch_atomic_fetch_##op(int i, atomic_t *v)				\
>  }									\
>  EXPORT_SYMBOL(arch_atomic_fetch_##op);
>  
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2)				\
> +int arch_atomic_fetch_##op(int i, int j, atomic_t *v)			\
> +{									\
> +	int ret;							\
> +	unsigned long flags;						\
> +	spin_lock_irqsave(ATOMIC_HASH(v), flags);			\
> +									\
> +	ret = v->counter;						\
> +	v->counter = (ret c_op1 i) c_op2 j;				\
> +									\
> +	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
> +	return ret;							\
> +}									\
> +EXPORT_SYMBOL(arch_atomic_fetch_##op);
> +
>  #define ATOMIC_OP_RETURN(op, c_op)					\
>  int arch_atomic_##op##_return(int i, atomic_t *v)			\
>  {									\
> @@ -63,8 +78,10 @@ ATOMIC_FETCH_OP(add, +=)
>  ATOMIC_FETCH_OP(and, &=)
>  ATOMIC_FETCH_OP(or, |=)
>  ATOMIC_FETCH_OP(xor, ^=)
> +ATOMIC_FETCH_OP2(and_or, &, |)
>  
>  #undef ATOMIC_FETCH_OP
> +#undef ATOMIC_FETCH_OP2
>  #undef ATOMIC_OP_RETURN
>  
>  int arch_atomic_xchg(atomic_t *v, int new)
> diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
> index 5e754e895767..145dce45d02a 100644
> --- a/arch/x86/include/asm/atomic.h
> +++ b/arch/x86/include/asm/atomic.h
> @@ -263,6 +263,16 @@ static __always_inline int arch_atomic_fetch_xor(int i, atomic_t *v)
>  }
>  #define arch_atomic_fetch_xor arch_atomic_fetch_xor
>  
> +static __always_inline int arch_atomic_fetch_and_or(int i, int j, atomic_t *v)
> +{
> +	int val = arch_atomic_read(v);
> +
> +	do { } while (!arch_atomic_try_cmpxchg(v, &val, (val & i) | j));
> +
> +	return val;
> +}
> +#define arch_atomic_fetch_and_or arch_atomic_fetch_and_or
> +
>  #ifdef CONFIG_X86_32
>  # include <asm/atomic64_32.h>
>  #else
> diff --git a/arch/xtensa/include/asm/atomic.h b/arch/xtensa/include/asm/atomic.h
> index 4361fe4247e3..6b043cf74df2 100644
> --- a/arch/xtensa/include/asm/atomic.h
> +++ b/arch/xtensa/include/asm/atomic.h
> @@ -177,6 +177,28 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t * v)		\
>  	return result;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op1, op2)					\
> +static inline int arch_atomic_fetch_##op1##_##op2(int i, int j, atomic_t * v)\
> +{									\
> +	unsigned long tmp;						\
> +	int result;							\
> +									\
> +	__asm__ __volatile__(						\
> +			"1:     l32i    %[tmp], %[mem]\n"		\
> +			"       wsr     %[tmp], scompare1\n"		\
> +			"       " #op1 " %[result], %[tmp], %[i]\n"	\
> +			"       " #op2 " %[result], %[result], %[j]\n"	\
> +			"       s32c1i  %[result], %[mem]\n"		\
> +			"       bne     %[result], %[tmp], 1b\n"	\
> +			: [result] "=&a" (result), [tmp] "=&a" (tmp),	\
> +			  [mem] "+m" (*v)				\
> +			: [i] "a" (i), [j] "a" (j)			\
> +			: "memory"					\
> +			);						\
> +									\
> +	return result;							\
> +}
> +
>  #else /* XCHAL_HAVE_S32C1I */
>  
>  #define ATOMIC_OP(op)							\
> @@ -238,6 +260,28 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t * v)		\
>  	return vval;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op1, op2)					\
> +static inline int arch_atomic_fetch_##op1##_##op2(int i, int j, atomic_t * v)\
> +{									\
> +	unsigned int tmp, vval;						\
> +									\
> +	__asm__ __volatile__(						\
> +			"       rsil    a15,"__stringify(TOPLEVEL)"\n"	\
> +			"       l32i    %[result], %[mem]\n"		\
> +			"       " #op1 " %[tmp], %[result], %[i]\n"	\
> +			"       " #op2 " %[tmp], %[tmp], %[j]\n"	\
> +			"       s32i    %[tmp], %[mem]\n"		\
> +			"       wsr     a15, ps\n"			\
> +			"       rsync\n"				\
> +			: [result] "=&a" (vval), [tmp] "=&a" (tmp),	\
> +			  [mem] "+m" (*v)				\
> +			: [i] "a" (i), [j] "a" (j)			\
> +			: "a15", "memory"				\
> +			);						\
> +									\
> +	return vval;							\
> +}
> +
>  #endif /* XCHAL_HAVE_S32C1I */
>  
>  #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op) ATOMIC_OP_RETURN(op)
> @@ -252,6 +296,11 @@ ATOMIC_OPS(and)
>  ATOMIC_OPS(or)
>  ATOMIC_OPS(xor)
>  
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(op1, op2) ATOMIC_FETCH_OP2(op1, op2)
> +
> +ATOMIC_OPS(and, or)
> +
>  #undef ATOMIC_OPS
>  #undef ATOMIC_FETCH_OP
>  #undef ATOMIC_OP_RETURN
> diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
> index bc45af52c93b..231a8386ac80 100644
> --- a/include/asm-generic/atomic-instrumented.h
> +++ b/include/asm-generic/atomic-instrumented.h
> @@ -441,6 +441,34 @@ atomic_fetch_xor_relaxed(int i, atomic_t *v)
>  	return arch_atomic_fetch_xor_relaxed(i, v);
>  }
>  
> +static __always_inline int
> +atomic_fetch_and_or(int i, int j, atomic_t *v)
> +{
> +	instrument_atomic_read_write(v, sizeof(*v));
> +	return arch_atomic_fetch_and_or(i, j, v);
> +}
> +
> +static __always_inline int
> +atomic_fetch_and_or_acquire(int i, int j, atomic_t *v)
> +{
> +	instrument_atomic_read_write(v, sizeof(*v));
> +	return arch_atomic_fetch_and_or_acquire(i, j, v);
> +}
> +
> +static __always_inline int
> +atomic_fetch_and_or_release(int i, int j, atomic_t *v)
> +{
> +	instrument_atomic_read_write(v, sizeof(*v));
> +	return arch_atomic_fetch_and_or_release(i, j, v);
> +}
> +
> +static __always_inline int
> +atomic_fetch_and_or_relaxed(int i, int j, atomic_t *v)
> +{
> +	instrument_atomic_read_write(v, sizeof(*v));
> +	return arch_atomic_fetch_and_or_relaxed(i, j, v);
> +}
> +
>  static __always_inline int
>  atomic_xchg(atomic_t *v, int i)
>  {
> diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
> index 04b8be9f1a77..474e8cd8e58d 100644
> --- a/include/asm-generic/atomic.h
> +++ b/include/asm-generic/atomic.h
> @@ -50,6 +50,18 @@ static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
>  	return c;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2)				\
> +static inline int generic_atomic_fetch_##op(int i, int j, atomic_t *v)	\
> +{									\
> +	int c, old;							\
> +									\
> +	c = v->counter;							\
> +	while ((old = arch_cmpxchg(&v->counter, c, (c c_op1 i) c_op2 j)) != c)	\
> +		c = old;						\
> +									\
> +	return c;							\
> +}
> +
>  #else
>  
>  #include <linux/irqflags.h>
> @@ -91,6 +103,20 @@ static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
>  	return ret;							\
>  }
>  
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2)				\
> +static inline int generic_atomic_fetch_##op(int i, int j, atomic_t *v)	\
> +{									\
> +	unsigned long flags;						\
> +	int ret;							\
> +									\
> +	raw_local_irq_save(flags);					\
> +	ret = v->counter;						\
> +	v->counter = (v->counter c_op1 i) c_op2 j;			\
> +	raw_local_irq_restore(flags);					\
> +									\
> +	return ret;							\
> +}
> +
>  #endif /* CONFIG_SMP */
>  
>  ATOMIC_OP_RETURN(add, +)
> @@ -101,6 +127,7 @@ ATOMIC_FETCH_OP(sub, -)
>  ATOMIC_FETCH_OP(and, &)
>  ATOMIC_FETCH_OP(or, |)
>  ATOMIC_FETCH_OP(xor, ^)
> +ATOMIC_FETCH_OP2(and_or, &, |)
>  
>  ATOMIC_OP(add, +)
>  ATOMIC_OP(sub, -)
> @@ -109,6 +136,7 @@ ATOMIC_OP(or, |)
>  ATOMIC_OP(xor, ^)
>  
>  #undef ATOMIC_FETCH_OP
> +#undef ATOMIC_FETCH_OP2
>  #undef ATOMIC_OP_RETURN
>  #undef ATOMIC_OP
>  
> @@ -120,6 +148,7 @@ ATOMIC_OP(xor, ^)
>  #define arch_atomic_fetch_and			generic_atomic_fetch_and
>  #define arch_atomic_fetch_or			generic_atomic_fetch_or
>  #define arch_atomic_fetch_xor			generic_atomic_fetch_xor
> +#define arch_atomic_fetch_and_or		generic_atomic_fetch_and_or
>  
>  #define arch_atomic_add				generic_atomic_add
>  #define arch_atomic_sub				generic_atomic_sub
> diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic-arch-fallback.h
> index a3dba31df01e..92043a8d5b79 100644
> --- a/include/linux/atomic-arch-fallback.h
> +++ b/include/linux/atomic-arch-fallback.h
> @@ -891,6 +891,48 @@ arch_atomic_fetch_xor(int i, atomic_t *v)
>  
>  #endif /* arch_atomic_fetch_xor_relaxed */
>  
> +#ifndef arch_atomic_fetch_and_or_relaxed
> +#define arch_atomic_fetch_and_or_acquire arch_atomic_fetch_and_or
> +#define arch_atomic_fetch_and_or_release arch_atomic_fetch_and_or
> +#define arch_atomic_fetch_and_or_relaxed arch_atomic_fetch_and_or
> +#else /* arch_atomic_fetch_and_or_relaxed */
> +
> +#ifndef arch_atomic_fetch_and_or_acquire
> +static __always_inline int
> +arch_atomic_fetch_and_or_acquire(int i, int j, atomic_t *v)
> +{
> +	int ret = arch_atomic_fetch_and_or_relaxed(i, j, v);
> +	__atomic_acquire_fence();
> +	return ret;
> +}
> +#define arch_atomic_fetch_and_or_acquire arch_atomic_fetch_and_or_acquire
> +#endif
> +
> +#ifndef arch_atomic_fetch_and_or_release
> +static __always_inline int
> +arch_atomic_fetch_and_or_release(int i, int j, atomic_t *v)
> +{
> +	__atomic_release_fence();
> +	return arch_atomic_fetch_and_or_relaxed(i, j, v);
> +}
> +#define arch_atomic_fetch_and_or_release arch_atomic_fetch_and_or_release
> +#endif
> +
> +#ifndef arch_atomic_fetch_and_or
> +static __always_inline int
> +arch_atomic_fetch_and_or(int i, int j, atomic_t *v)
> +{
> +	int ret;
> +	__atomic_pre_full_fence();
> +	ret = arch_atomic_fetch_and_or_relaxed(i, j, v);
> +	__atomic_post_full_fence();
> +	return ret;
> +}
> +#define arch_atomic_fetch_and_or arch_atomic_fetch_and_or
> +#endif
> +
> +#endif /* arch_atomic_fetch_and_or_relaxed */
> +
>  #ifndef arch_atomic_xchg_relaxed
>  #define arch_atomic_xchg_acquire arch_atomic_xchg
>  #define arch_atomic_xchg_release arch_atomic_xchg
> -- 
> 2.32.0
> 
