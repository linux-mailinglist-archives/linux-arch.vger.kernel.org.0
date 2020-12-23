Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08E02E1507
	for <lists+linux-arch@lfdr.de>; Wed, 23 Dec 2020 03:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgLWCrI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Dec 2020 21:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgLWCrH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Dec 2020 21:47:07 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA203C0613D3;
        Tue, 22 Dec 2020 18:46:26 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id w79so13880338qkb.5;
        Tue, 22 Dec 2020 18:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aTJCA29fRUEz9E6QxArbuqAqpHdZixDcoTrfn7uJ+gI=;
        b=vEiy5S47fXYfBkx3BPI2vrMJAfZvgfb76log3s0hlf1RVpKTX2+1Nf4PHugfP4qB+y
         qM1mfvgxs/FUXAvUrE2m8YdNWasTBBRyie5N+cfL9hm+XooJy/RKKFwbJ1/Nw5iPiSqg
         SQFnVJbGPcWQtjPTTVdQO0FsYG0qzfipE4zTMbUV5C1KlfVklV+UiE7O//0Ysqqln4U1
         +q33vi1lvgzPIupwVzBuW8HRm/tbKfqeh6p6oS5kXgfBQ6MT+nHwWQYHfK2DZa5j0rUN
         0orwtySgU3PhWebNP4YyEu2E4XzfvBsBGoLigX4nw2Czv5zk2ZK79BRa5iRnbYnhEsRK
         zVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aTJCA29fRUEz9E6QxArbuqAqpHdZixDcoTrfn7uJ+gI=;
        b=PSzhHa31m7xDUa5Xt169lKF9Xru9A7aDxi8avTe2/+fGLPaI/cth6+7/utaC7PKi8P
         Z/WSHaJPFGOu8fSBDNaYaQS+zEAzFglcHDw8gdjeMzMqrwhSkh751jqZME3IOCcn5gM7
         27sHn2a+kgfTIZ+j+Ftd8b60shOWjHzMaXtqJFpwpOVqbrJkO1ExQRHEmAK4e19CsnlT
         6NMs7mqCpoHMlzvUnq0pupnlWR8T7WEXH60SC1mmN5B+nD5eFVmGfVJ9KeKDHk+bgdMO
         uU/i06HS3/a5v5mVtHScW9mCmRZmpEeBOQbljzKq9DTWDFBVO8ZBdmITRCSK6cS5hXtY
         GNzg==
X-Gm-Message-State: AOAM531J/C7bv9BDdytsvy09artPKy15MGBTw/KxaxuQZy4tNHyZbos/
        DlCL/Dd1K/y7kCPMMx75sL8=
X-Google-Smtp-Source: ABdhPJxKW6eMfx2FcIh5RdAJZxL2nPQDJJmGlzGOdHWHXN+pZFdtdSCpQEaP67NTCW+6s22rmfgGJA==
X-Received: by 2002:a37:994:: with SMTP id 142mr24731734qkj.257.1608691585981;
        Tue, 22 Dec 2020 18:46:25 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id u4sm13293329qtv.49.2020.12.22.18.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 18:46:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2FB8D27C0054;
        Tue, 22 Dec 2020 21:46:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 22 Dec 2020 21:46:24 -0500
X-ME-Sender: <xms:fK_iXy-4fMjmhLFCkXxUbry6TwiQl7MS1nGaWvCYyq6Oo7Eb9vmw-A>
    <xme:fK_iXyvC3j9yhqkArxoiMDP5vHJ6-UD-A9Hym916jKKQ7jP7_lma34jBSt-RX_lfw
    _HipUOzSzZhbTWF9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtiedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:fK_iX4CmT5Xo_dRZKPMSGY5ZKvNmeIYMOxvzfg6h_Y-30f_5gmXWeQ>
    <xmx:fK_iX6dQZOVBcdkZQk5WYJrwx0fLiQb-dLAb9HUU2Gt551EHL7zvxw>
    <xmx:fK_iX3MlZDSEKksyYZzSz3pCsMdELySC_TNi6YkbY2FhVJsg4wIh2g>
    <xmx:gK_iXwgvNTJfnNZRE8SNh0F1GntNgn_679XoiHpXKG4SEs_6T0Gi9s8zato>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 187361080059;
        Tue, 22 Dec 2020 21:46:20 -0500 (EST)
Date:   Wed, 23 Dec 2020 10:45:47 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] powerpc: rewrite atomics to use ARCH_ATOMIC
Message-ID: <X+KvWzrkV+3pxnz2@boqun-archlinux>
References: <20201111110723.3148665-1-npiggin@gmail.com>
 <20201111110723.3148665-4-npiggin@gmail.com>
 <20201113153012.GD286534@boqun-archlinux>
 <1608608903.7wgw6zmbi8.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608608903.7wgw6zmbi8.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 22, 2020 at 01:52:50PM +1000, Nicholas Piggin wrote:
> Excerpts from Boqun Feng's message of November 14, 2020 1:30 am:
> > Hi Nicholas,
> > 
> > On Wed, Nov 11, 2020 at 09:07:23PM +1000, Nicholas Piggin wrote:
> >> All the cool kids are doing it.
> >> 
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>  arch/powerpc/include/asm/atomic.h  | 681 ++++++++++-------------------
> >>  arch/powerpc/include/asm/cmpxchg.h |  62 +--
> >>  2 files changed, 248 insertions(+), 495 deletions(-)
> >> 
> >> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> >> index 8a55eb8cc97b..899aa2403ba7 100644
> >> --- a/arch/powerpc/include/asm/atomic.h
> >> +++ b/arch/powerpc/include/asm/atomic.h
> >> @@ -11,185 +11,285 @@
> >>  #include <asm/cmpxchg.h>
> >>  #include <asm/barrier.h>
> >>  
> >> +#define ARCH_ATOMIC
> >> +
> >> +#ifndef CONFIG_64BIT
> >> +#include <asm-generic/atomic64.h>
> >> +#endif
> >> +
> >>  /*
> >>   * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
> >>   * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
> >>   * on the platform without lwsync.
> >>   */
> >>  #define __atomic_acquire_fence()					\
> >> -	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory")
> >> +	asm volatile(PPC_ACQUIRE_BARRIER "" : : : "memory")
> >>  
> >>  #define __atomic_release_fence()					\
> >> -	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory")
> >> +	asm volatile(PPC_RELEASE_BARRIER "" : : : "memory")
> >>  
> >> -static __inline__ int atomic_read(const atomic_t *v)
> >> -{
> >> -	int t;
> >> +#define __atomic_pre_full_fence		smp_mb
> >>  
> >> -	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m"(v->counter));
> >> +#define __atomic_post_full_fence	smp_mb
> >>  
> 
> Thanks for the review.
> 
> > Do you need to define __atomic_{pre,post}_full_fence for PPC? IIRC, they
> > are default smp_mb__{before,atomic}_atomic(), so are smp_mb() defautly
> > on PPC.
> 
> Okay I didn't realise that's not required.
> 
> >> -	return t;
> >> +#define arch_atomic_read(v)			__READ_ONCE((v)->counter)
> >> +#define arch_atomic_set(v, i)			__WRITE_ONCE(((v)->counter), (i))
> >> +#ifdef CONFIG_64BIT
> >> +#define ATOMIC64_INIT(i)			{ (i) }
> >> +#define arch_atomic64_read(v)			__READ_ONCE((v)->counter)
> >> +#define arch_atomic64_set(v, i)			__WRITE_ONCE(((v)->counter), (i))
> >> +#endif
> >> +
> > [...]
> >>  
> >> +#define ATOMIC_FETCH_OP_UNLESS_RELAXED(name, type, dtype, width, asm_op) \
> >> +static inline int arch_##name##_relaxed(type *v, dtype a, dtype u)	\
> > 
> > I don't think we have atomic_fetch_*_unless_relaxed() at atomic APIs,
> > ditto for:
> > 
> > 	atomic_fetch_add_unless_relaxed()
> > 	atomic_inc_not_zero_relaxed()
> > 	atomic_dec_if_positive_relaxed()
> > 
> > , and we don't have the _acquire() and _release() variants for them
> > either, and if you don't define their fully-ordered version (e.g.
> > atomic_inc_not_zero()), atomic-arch-fallback.h will use read and cmpxchg
> > to implement them, and I think not what we want.
> 
> Okay. How can those be added? The atoimc generation is pretty 
> complicated.
> 

Yeah, I know ;-) I think you can just implement and define fully-ordered
verions:

	arch_atomic_fetch_*_unless()
	arch_atomic_inc_not_zero()
	arch_atomic_dec_if_postive()

, that should work.

Rules of atomic generation, IIRC:

1.	If you define _relaxed, _acquire, _release or fully-ordered
	version, atomic generation will use that version

2.	If you define _relaxed, atomic generation will use that and
	barriers to generate _acquire, _release and fully-ordered
	versions, unless they are already defined (as Rule #1 says)

3.	If you don't define _relaxed, but define the fully-ordered
	version, atomic generation will use the fully-ordered version
	and use it as _relaxed variants and generate the rest using Rule
	#2.

> > [...]
> >>  
> >>  #endif /* __KERNEL__ */
> >>  #endif /* _ASM_POWERPC_ATOMIC_H_ */
> >> diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
> >> index cf091c4c22e5..181f7e8b3281 100644
> >> --- a/arch/powerpc/include/asm/cmpxchg.h
> >> +++ b/arch/powerpc/include/asm/cmpxchg.h
> >> @@ -192,7 +192,7 @@ __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
> >>       		(unsigned long)_x_, sizeof(*(ptr))); 			     \
> >>    })
> >>  
> >> -#define xchg_relaxed(ptr, x)						\
> >> +#define arch_xchg_relaxed(ptr, x)					\
> >>  ({									\
> >>  	__typeof__(*(ptr)) _x_ = (x);					\
> >>  	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
> >> @@ -448,35 +448,7 @@ __cmpxchg_relaxed(void *ptr, unsigned long old, unsigned long new,
> >>  	return old;
> >>  }
> >>  
> >> -static __always_inline unsigned long
> >> -__cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
> >> -		  unsigned int size)
> >> -{
> >> -	switch (size) {
> >> -	case 1:
> >> -		return __cmpxchg_u8_acquire(ptr, old, new);
> >> -	case 2:
> >> -		return __cmpxchg_u16_acquire(ptr, old, new);
> >> -	case 4:
> >> -		return __cmpxchg_u32_acquire(ptr, old, new);
> >> -#ifdef CONFIG_PPC64
> >> -	case 8:
> >> -		return __cmpxchg_u64_acquire(ptr, old, new);
> >> -#endif
> >> -	}
> >> -	BUILD_BUG_ON_MSG(1, "Unsupported size for __cmpxchg_acquire");
> >> -	return old;
> >> -}
> >> -#define cmpxchg(ptr, o, n)						 \
> >> -  ({									 \
> >> -     __typeof__(*(ptr)) _o_ = (o);					 \
> >> -     __typeof__(*(ptr)) _n_ = (n);					 \
> >> -     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
> >> -				    (unsigned long)_n_, sizeof(*(ptr))); \
> >> -  })
> >> -
> >> -
> > 
> > If you remove {atomic_}_cmpxchg_{,_acquire}() and use the version
> > provided by atomic-arch-fallback.h, then a fail cmpxchg or
> > cmpxchg_acquire() will still result into a full barrier or a acquire
> > barrier after the RMW operation, the barrier is not necessary and
> > probably this is not what we want?
> 
> Why is that done? That seems like a very subtle difference. Shouldn't
> the fallback version skip the barrier?
> 

The fallback version is something like:

	smp_mb__before_atomic();
	cmpxchg_relaxed();
	smp_mb__after_atomic();

, so there will be a full barrier on PPC after the cmpxchg no matter
whether the cmpxchg succeed or not. And the fallback version cannot skip
the barrier, because there is no way the fallback version tells whether
the cmpxchg_relaxed() succeed or not. So in my previous version of PPC
atomic variants support, I defined cmpxchg_acquire() in asm header
instead of using atomic generation.

That said, now I think about this, maybe we can implement the fallback
version as:

	smp_mb__before_atomic();
	ret = cmpxchg_relaxed(ptr, old, new);
	if (old == ret)
		smp_mb__after_atomic();

, in this way, the fallback version can handle the barrier skipping
better.

Regards,
Boqun

> Thanks,
> Nick
