Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C9F3D8E67
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 14:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbhG1M65 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhG1M65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 08:58:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE5C061757
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KFPED4uLrX4kxrii+Hw8umO66jApdL4ZCLjZL+9SzfU=; b=AMRa5UDG/FCnhaKWDY1Mxq9rky
        e7FAyYnHyv11uIwx91Fqu6V8Qd/eM2nBctQcaDO1qxHxZg0aT++/ZpPiv6/ECuGAgrWlmg8MrqN/D
        7udOATnBfF4rK0BKhQgLQ1xIjSZdW87KwIA5E7ej49ssXomESssrq0lY6c5STmE5dWl+ZT9l3TL7n
        BrH1UH8eDggtH8/M1dFuFCDNLSYm/KuH/iXO8eLN3gTghc8SrnF4q/EWwmdzqNolNXgnw4dAByNG8
        V0YfQE65k/or8SNUWQ0RLlhze1ypEqlrfPHLMk79jKpTrmEVWBb1CRT9a2QpiXcGylkI8wofXZHIs
        Va1hjKpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8j8w-003if2-TK; Wed, 28 Jul 2021 12:58:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0BAE330022A;
        Wed, 28 Jul 2021 14:58:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA53D2028E9B0; Wed, 28 Jul 2021 14:58:35 +0200 (CEST)
Date:   Wed, 28 Jul 2021 14:58:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rui Wang <wangrui@loongson.cn>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, hev <r@hev.cc>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
Message-ID: <YQFUe+QsHfBIgQev@hirez.programming.kicks-ass.net>
References: <20210728114822.1243-1-wangrui@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728114822.1243-1-wangrui@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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
> ---

>  include/asm-generic/atomic-instrumented.h | 28 ++++++++++++
>  include/asm-generic/atomic.h              | 29 +++++++++++++
>  include/linux/atomic-arch-fallback.h      | 42 ++++++++++++++++++
>  22 files changed, 588 insertions(+)

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

Urgh.. please start from something like the below and then run:

  scripts/atomic/gen-atomics.sh

The below isn't quite right, because it'll use try_cmpxchg() for
atomic_andnot_or(), which by being a void atomic should be _relaxed. I'm
not entirely sure how to make that happen in a hurry.

---

diff --git a/scripts/atomic/atomics.tbl b/scripts/atomic/atomics.tbl
index fbee2f6190d9..3aaa0caa6b2d 100755
--- a/scripts/atomic/atomics.tbl
+++ b/scripts/atomic/atomics.tbl
@@ -39,3 +39,4 @@ inc_not_zero		b	v
 inc_unless_negative	b	v
 dec_unless_positive	b	v
 dec_if_positive		i	v
+andnot_or		vF	v	i:m	i:o
diff --git a/scripts/atomic/fallbacks/andnot_or b/scripts/atomic/fallbacks/andnot_or
new file mode 100644
index 000000000000..f50e78d6c53a
--- /dev/null
+++ b/scripts/atomic/fallbacks/andnot_or
@@ -0,0 +1,15 @@
+cat <<EOF
+static __always_inline ${ret}
+arch_${atomic}_${pfx}andnot_or${sfx}${order}(${atomic}_t *v, ${int} m, ${int} o)
+{
+	${retstmt}({
+		${int} N, O = atomic_read(v);
+		do {
+			N = O;
+			N &= ~m;
+			N |= o;
+		} while (!arch_${atomic}_try_cmpxchg${order}(v, &O, N));
+		O;
+	});
+}
+EOF
diff --git a/scripts/atomic/fallbacks/fetch_andnot_or b/scripts/atomic/fallbacks/fetch_andnot_or
deleted file mode 100644
index e69de29bb2d1..000000000000

