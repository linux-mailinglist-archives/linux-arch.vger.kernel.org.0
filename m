Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E652B1EB2
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 16:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgKMPat (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 10:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgKMPas (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 10:30:48 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B045C0613D1;
        Fri, 13 Nov 2020 07:30:32 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 11so9109917qkd.5;
        Fri, 13 Nov 2020 07:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jRN0hd985rUTcBLLds2xuSjiDPNKj9RzyzM/Mhj8NMI=;
        b=iXs3myPmcsn+JNsD9rW6++x0sJAJkwPzx+KYmmbvVzyTs/hkhEQ1EYs8Xt1lD0pvzB
         e27hl/5seZ1H94hzEwZUWXBa0oWKxP2sDCMQxqRsMo0PURLHZ71na6860nyYahaTx5Dm
         OlM1mBCEtlbDt+DXSAzRNsK7RLacWQzIo+S/gKEogR73ySKGoi7G6ugJsYOwKUFEA8z3
         pUDn9c/jAxk/4UAzj0SC4/H4jVGDIIH12mxfFZJ0izijUXVsJ7Khdhhlo9Zvf9K6Z44d
         rpCkVkhY2o1Fb36rtnpIl4+MJ3lrgoRfqm8YlCN3gL/13M+B2YqUScVDiDfGb1pQApMe
         56oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jRN0hd985rUTcBLLds2xuSjiDPNKj9RzyzM/Mhj8NMI=;
        b=FOEQ08PhXkfdzCJDVzRIgVeUZDyJsOvtxHh8RlWXZJJIZP9+gaC6LsQsVTwS3/9sxY
         HZBHG4hlCpDid/KvpH0pyOHZ5ltYJTqzdEHou2FPNRBQUfY2+q5MYQOd81wdd1Ifep7q
         ovrC/XepI/MaZ3tbD1unwerTSMrlQ+inFEfzCjHfXvH9Lm0Vm6AsBzhuEGaaUCcopwDx
         5FQTV6ZwSTcUmG2mIWAHWkyefhq1sUTdis/xarwdPP0tCI2gU4JYxzdD1bXv+doNTxFG
         FReRqDr57z+NrKCWcIQyuGfoEjG+Wbs097G9FHNYTbBWzLOgC4I5h+mQk7VXnMskRJH+
         sBZQ==
X-Gm-Message-State: AOAM531k1y7oDygUL8J2wlguAuls728Q/veNhbM/Lv1Zn1Pz9R6uRrCJ
        3ATHlf03l6lzy1NWmwz4aKE=
X-Google-Smtp-Source: ABdhPJz9IFOBRh+GQN79NayXafDuzKDzSjycL/UYvkBhej4K/KihNofuVRAU1bciSleHPD3TSVWAWA==
X-Received: by 2002:a37:8703:: with SMTP id j3mr2585373qkd.5.1605281426758;
        Fri, 13 Nov 2020 07:30:26 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id f56sm7183778qta.49.2020.11.13.07.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:30:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6E30927C0054;
        Fri, 13 Nov 2020 10:30:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 13 Nov 2020 10:30:23 -0500
X-ME-Sender: <xms:iqauXxD7CorhV411lS0DRxUtpE6dxHigoXSXOJFN3X6Q0IETxaGs8g>
    <xme:iqauX_hh8z5oK2K4ru4sgFyVmrxdb3O4f9Oq-4dgfuVnH8-T7AHkoJLfJWf8JLXrB
    1ur8ykZK4pa-kgU-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvhedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:i6auX8nepc_qc6aTmAu8fkAIGIpWlsIMqp4Gbj785dy_z53wED4SBQ>
    <xmx:i6auX7zd92O6G5taKXavsAbxTXK6Wfn49QS_aWUBy2iYwuFAiwyVHA>
    <xmx:i6auX2QVVO-wK7rbNuV4TsYIeZUK_Igua833D-SW3axbtPcjaIaQGA>
    <xmx:j6auX5ELno9Ne22A8_qAbV0iB2xEN1c1I95ZhrmOYiQ6HGqIZ4RjNJBBVJE>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id B80083064AB5;
        Fri, 13 Nov 2020 10:30:18 -0500 (EST)
Date:   Fri, 13 Nov 2020 23:30:12 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc: rewrite atomics to use ARCH_ATOMIC
Message-ID: <20201113153012.GD286534@boqun-archlinux>
References: <20201111110723.3148665-1-npiggin@gmail.com>
 <20201111110723.3148665-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111110723.3148665-4-npiggin@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nicholas,

On Wed, Nov 11, 2020 at 09:07:23PM +1000, Nicholas Piggin wrote:
> All the cool kids are doing it.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/atomic.h  | 681 ++++++++++-------------------
>  arch/powerpc/include/asm/cmpxchg.h |  62 +--
>  2 files changed, 248 insertions(+), 495 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> index 8a55eb8cc97b..899aa2403ba7 100644
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -11,185 +11,285 @@
>  #include <asm/cmpxchg.h>
>  #include <asm/barrier.h>
>  
> +#define ARCH_ATOMIC
> +
> +#ifndef CONFIG_64BIT
> +#include <asm-generic/atomic64.h>
> +#endif
> +
>  /*
>   * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
>   * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
>   * on the platform without lwsync.
>   */
>  #define __atomic_acquire_fence()					\
> -	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory")
> +	asm volatile(PPC_ACQUIRE_BARRIER "" : : : "memory")
>  
>  #define __atomic_release_fence()					\
> -	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory")
> +	asm volatile(PPC_RELEASE_BARRIER "" : : : "memory")
>  
> -static __inline__ int atomic_read(const atomic_t *v)
> -{
> -	int t;
> +#define __atomic_pre_full_fence		smp_mb
>  
> -	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m"(v->counter));
> +#define __atomic_post_full_fence	smp_mb
>  

Do you need to define __atomic_{pre,post}_full_fence for PPC? IIRC, they
are default smp_mb__{before,atomic}_atomic(), so are smp_mb() defautly
on PPC.

> -	return t;
> +#define arch_atomic_read(v)			__READ_ONCE((v)->counter)
> +#define arch_atomic_set(v, i)			__WRITE_ONCE(((v)->counter), (i))
> +#ifdef CONFIG_64BIT
> +#define ATOMIC64_INIT(i)			{ (i) }
> +#define arch_atomic64_read(v)			__READ_ONCE((v)->counter)
> +#define arch_atomic64_set(v, i)			__WRITE_ONCE(((v)->counter), (i))
> +#endif
> +
[...]
>  
> +#define ATOMIC_FETCH_OP_UNLESS_RELAXED(name, type, dtype, width, asm_op) \
> +static inline int arch_##name##_relaxed(type *v, dtype a, dtype u)	\

I don't think we have atomic_fetch_*_unless_relaxed() at atomic APIs,
ditto for:

	atomic_fetch_add_unless_relaxed()
	atomic_inc_not_zero_relaxed()
	atomic_dec_if_positive_relaxed()

, and we don't have the _acquire() and _release() variants for them
either, and if you don't define their fully-ordered version (e.g.
atomic_inc_not_zero()), atomic-arch-fallback.h will use read and cmpxchg
to implement them, and I think not what we want.

[...]
>  
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_ATOMIC_H_ */
> diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
> index cf091c4c22e5..181f7e8b3281 100644
> --- a/arch/powerpc/include/asm/cmpxchg.h
> +++ b/arch/powerpc/include/asm/cmpxchg.h
> @@ -192,7 +192,7 @@ __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
>       		(unsigned long)_x_, sizeof(*(ptr))); 			     \
>    })
>  
> -#define xchg_relaxed(ptr, x)						\
> +#define arch_xchg_relaxed(ptr, x)					\
>  ({									\
>  	__typeof__(*(ptr)) _x_ = (x);					\
>  	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
> @@ -448,35 +448,7 @@ __cmpxchg_relaxed(void *ptr, unsigned long old, unsigned long new,
>  	return old;
>  }
>  
> -static __always_inline unsigned long
> -__cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
> -		  unsigned int size)
> -{
> -	switch (size) {
> -	case 1:
> -		return __cmpxchg_u8_acquire(ptr, old, new);
> -	case 2:
> -		return __cmpxchg_u16_acquire(ptr, old, new);
> -	case 4:
> -		return __cmpxchg_u32_acquire(ptr, old, new);
> -#ifdef CONFIG_PPC64
> -	case 8:
> -		return __cmpxchg_u64_acquire(ptr, old, new);
> -#endif
> -	}
> -	BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg_acquire");
> -	return old;
> -}
> -#define cmpxchg(ptr, o, n)						 \
> -  ({									 \
> -     __typeof__(*(ptr)) _o_ = (o);					 \
> -     __typeof__(*(ptr)) _n_ = (n);					 \
> -     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
> -				    (unsigned long)_n_, sizeof(*(ptr))); \
> -  })
> -
> -

If you remove {atomic_}_cmpxchg_{,_acquire}() and use the version
provided by atomic-arch-fallback.h, then a fail cmpxchg or
cmpxchg_acquire() will still result into a full barrier or a acquire
barrier after the RMW operation, the barrier is not necessary and
probably this is not what we want?

Regards,
Boqun

> -#define cmpxchg_local(ptr, o, n)					 \
> +#define arch_cmpxchg_local(ptr, o, n)					 \
>    ({									 \
>       __typeof__(*(ptr)) _o_ = (o);					 \
>       __typeof__(*(ptr)) _n_ = (n);					 \
> @@ -484,7 +456,7 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
>  				    (unsigned long)_n_, sizeof(*(ptr))); \
>    })
>  
> -#define cmpxchg_relaxed(ptr, o, n)					\
> +#define arch_cmpxchg_relaxed(ptr, o, n)					\
>  ({									\
>  	__typeof__(*(ptr)) _o_ = (o);					\
>  	__typeof__(*(ptr)) _n_ = (n);					\
> @@ -493,38 +465,20 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
>  			sizeof(*(ptr)));				\
>  })
>  
> -#define cmpxchg_acquire(ptr, o, n)					\
> -({									\
> -	__typeof__(*(ptr)) _o_ = (o);					\
> -	__typeof__(*(ptr)) _n_ = (n);					\
> -	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
> -			(unsigned long)_o_, (unsigned long)_n_,		\
> -			sizeof(*(ptr)));				\
> -})
>  #ifdef CONFIG_PPC64
> -#define cmpxchg64(ptr, o, n)						\
> -  ({									\
> -	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
> -	cmpxchg((ptr), (o), (n));					\
> -  })
> -#define cmpxchg64_local(ptr, o, n)					\
> +#define arch_cmpxchg64_local(ptr, o, n)					\
>    ({									\
>  	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
> -	cmpxchg_local((ptr), (o), (n));					\
> +	arch_cmpxchg_local((ptr), (o), (n));				\
>    })
> -#define cmpxchg64_relaxed(ptr, o, n)					\
> -({									\
> -	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
> -	cmpxchg_relaxed((ptr), (o), (n));				\
> -})
> -#define cmpxchg64_acquire(ptr, o, n)					\
> +#define arch_cmpxchg64_relaxed(ptr, o, n)				\
>  ({									\
>  	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
> -	cmpxchg_acquire((ptr), (o), (n));				\
> +	arch_cmpxchg_relaxed((ptr), (o), (n));				\
>  })
>  #else
>  #include <asm-generic/cmpxchg-local.h>
> -#define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
> +#define arch_cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
>  #endif
>  
>  #endif /* __KERNEL__ */
> -- 
> 2.23.0
> 
