Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6311D653A4E
	for <lists+linux-arch@lfdr.de>; Thu, 22 Dec 2022 02:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLVBZs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 20:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiLVBZr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 20:25:47 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B601022;
        Wed, 21 Dec 2022 17:25:45 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id a17so345362qvt.9;
        Wed, 21 Dec 2022 17:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SjxE/kmdtcXqhgloBP4CmAlPwzNLVF1sSk4Q1Ar3K0=;
        b=paWiXvp0dQsJsqWrO4Gy0X1iAanI6fktRVeGa7V7CZt9vRMzDRH8/gxua/f90yB8y6
         unLhrb+lg5Hd6uDFRyMBnrkCaKezH/bBAACpDD1IYyUkPzKW26e7CAVKuBaItLErkSX/
         dyxXvsYw6c+aCHh3eOuBNk3IrYRw0NCC063nPGNYeX8aknUvVRF4P9f5hRCDffGWpDKf
         wVAzaIsNrXyQovjYH6VD7Fj662ByrlFjBzmQrl/MsNGwvm5LVIWIwsvGvmI+c8puxJcI
         gPiaK4hfti2cZFVyNnCskkuGXdYnm8yKdSnPnlS6rIcQYK8cBBnhFgH1ryk8MGUUDQtd
         +ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SjxE/kmdtcXqhgloBP4CmAlPwzNLVF1sSk4Q1Ar3K0=;
        b=xxvJnkb2S7oJEES5aGXvTjn6ahr6LU9NHKk/SZEvvqAfYYSHoc3rN1ZgRhzqQzb6yP
         S+EXs6oaz+y/88zGCQ1mTlo3p1YFMNXHmfUE2f8fgxlQqEqucYXJIrgLjC/FkYnkzEFo
         PCEz3fCp3+0j4zw35tJGhe8nKzk4tGv05nQgLKnXkM+hx25/tH64a63BG+Mt1EnLBqQa
         Mlbblz8HJr0+5jC2nCnRFN59rbZbDImGHATNEofjCIpq5gybuQayZlSba3TgCp9FsMVX
         kWe91vrRIb0dDrguU7/sZgurRL/ABEituxiZwFYZnweM7dnipY/qMbVSpb5PJ8AuOlwm
         iaKA==
X-Gm-Message-State: AFqh2kpp+wW+MyKEcgztPk2Ii9wjzry/N0Bs9gUNI8HxZFtf5Ldvj/44
        tQf5EQC+krMmvpzjF1sW/Mo=
X-Google-Smtp-Source: AMrXdXvMtuRFFkZgbjz5/EL3muFQk2UMmzjVgG8U2gJR+0GYGfSP/lIPrJ8tSNM9q+2+piTMAYuW0g==
X-Received: by 2002:a05:6214:3507:b0:4c7:7370:3c07 with SMTP id nk7-20020a056214350700b004c773703c07mr25344451qvb.13.1671672344864;
        Wed, 21 Dec 2022 17:25:44 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n17-20020a05620a223100b006fc40dafaa2sm11255394qkh.8.2022.12.21.17.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 17:25:44 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6558C27C0054;
        Wed, 21 Dec 2022 20:25:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Dec 2022 20:25:43 -0500
X-ME-Sender: <xms:FrKjY7ybWlKcpq44pOkbAwaH4Cqfv2iW2HoWaPUHjVVmFLTk1ztyVw>
    <xme:FrKjYzRTxVlPMN2sDmpzSwuNXvK6k_KuAIZZmGlrAHq9Kz8chIwLTJCVL9SVzptbx
    IYc-_MYWd9YjiOH-g>
X-ME-Received: <xmr:FrKjY1V9FUXq8MaFkbXJRNye_y8BAcJU4d7A_yY1Bc2VhyyXTsmWVgWBKK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeelgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:FrKjY1gnAD621Usc2FOoJR6PUWSCEidlappQmTUWR-OVmUscPmKXRQ>
    <xmx:FrKjY9CUzVqX9GTuJs5q2bsA-XiEU7qMUz5KQi8chq3E6W20y4XgfA>
    <xmx:FrKjY-LY4W06F5Ptm5bBI1gQVEXvV2ZdF2ffcU1D2ui_Hh6OwJjslw>
    <xmx:F7KjY7hkS6nQ7kWeHID3WVuJSiM7SEq8DM7L8NGDOUy-_f5jxtz1UJkjP-M>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Dec 2022 20:25:42 -0500 (EST)
Date:   Wed, 21 Dec 2022 17:25:20 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 05/12] arch: Introduce
 arch_{,try_}_cmpxchg128{,_local}()
Message-ID: <Y6OyAL2epKPHj+tr@boqun-archlinux>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219154119.154045458@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 04:35:30PM +0100, Peter Zijlstra wrote:
> For all architectures that currently support cmpxchg_double()
> implement the cmpxchg128() family of functions that is basically the
> same but with a saner interface.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/atomic_ll_sc.h |   38 +++++++++++++++++++++++
>  arch/arm64/include/asm/atomic_lse.h   |   33 +++++++++++++++++++-
>  arch/arm64/include/asm/cmpxchg.h      |   26 ++++++++++++++++
>  arch/s390/include/asm/cmpxchg.h       |   33 ++++++++++++++++++++
>  arch/x86/include/asm/cmpxchg_32.h     |    3 +
>  arch/x86/include/asm/cmpxchg_64.h     |   55 +++++++++++++++++++++++++++++++++-
>  6 files changed, 185 insertions(+), 3 deletions(-)
> 
> --- a/arch/arm64/include/asm/atomic_ll_sc.h
> +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> @@ -326,6 +326,44 @@ __CMPXCHG_DBL(   ,        ,  ,         )
>  __CMPXCHG_DBL(_mb, dmb ish, l, "memory")
>  
>  #undef __CMPXCHG_DBL
> +
> +union __u128_halves {
> +	u128 full;
> +	struct {
> +		u64 low, high;
> +	};
> +};
> +
> +#define __CMPXCHG128(name, mb, rel, cl)					\
> +static __always_inline u128						\
> +__ll_sc__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)	\
> +{									\
> +	union __u128_halves r, o = { .full = (old) },			\
> +			       n = { .full = (new) };			\
> +									\
> +	asm volatile("// __cmpxchg128" #name "\n"			\
> +	"	prfm	pstl1strm, %2\n"				\
> +	"1:	ldxp	%0, %1, %2\n"					\
> +	"	eor	%3, %0, %3\n"					\
> +	"	eor	%4, %1, %4\n"					\
> +	"	orr	%3, %4, %3\n"					\
> +	"	cbnz	%3, 2f\n"					\
> +	"	st" #rel "xp	%w3, %5, %6, %2\n"			\
> +	"	cbnz	%w3, 1b\n"					\
> +	"	" #mb "\n"						\
> +	"2:"								\
> +	: "=&r" (r.low), "=&r" (r.high), "+Q" (*(unsigned long *)ptr)	\
> +	: "r" (o.low), "r" (o.high), "r" (n.low), "r" (n.high)		\
> +	: cl);								\
> +									\
> +	return r.full;							\
> +}
> +
> +__CMPXCHG128(   ,        ,  ,         )
> +__CMPXCHG128(_mb, dmb ish, l, "memory")
> +
> +#undef __CMPXCHG128
> +
>  #undef K
>  
>  #endif	/* __ASM_ATOMIC_LL_SC_H */
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -151,7 +151,7 @@ __lse_atomic64_fetch_##op##name(s64 i, a
>  	"	" #asm_op #mb "	%[i], %[old], %[v]"			\
>  	: [v] "+Q" (v->counter),					\
>  	  [old] "=r" (old)						\
> -	: [i] "r" (i) 							\
> +	: [i] "r" (i)							\
>  	: cl);								\
>  									\
>  	return old;							\
> @@ -324,4 +324,35 @@ __CMPXCHG_DBL(_mb, al, "memory")
>  
>  #undef __CMPXCHG_DBL
>  
> +#define __CMPXCHG128(name, mb, cl...)					\
> +static __always_inline u128						\
> +__lse__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)		\
> +{									\
> +	union __u128_halves r, o = { .full = (old) },			\
> +			       n = { .full = (new) };			\
> +	register unsigned long x0 asm ("x0") = o.low;			\
> +	register unsigned long x1 asm ("x1") = o.high;			\
> +	register unsigned long x2 asm ("x2") = n.low;			\
> +	register unsigned long x3 asm ("x3") = n.high;			\
> +	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
> +									\
> +	asm volatile(							\
> +	__LSE_PREAMBLE							\
> +	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
> +	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
> +	  [v] "+Q" (*(unsigned long *)ptr)				\
> +	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\

Issue #1: the line below can be removed, otherwise..

> +	  [oldval1] "r" (r.low), [oldval2] "r" (r.high)			\

warning:

	./arch/arm64/include/asm/atomic_lse.h: In function '__lse__cmpxchg128_mb':
	./arch/arm64/include/asm/atomic_lse.h:309:27: warning: 'r.<U97b8>.low' is used uninitialized [-Wuninitialized]
	  309 |           [oldval1] "r" (r.low), [oldval2] "r" (r.high)


> +	: cl);								\
> +									\
> +	r.low = x0; r.high = x1;					\
> +									\
> +	return r.full;							\
> +}
> +
> +__CMPXCHG128(   ,   )
> +__CMPXCHG128(_mb, al, "memory")
> +
> +#undef __CMPXCHG128
> +
>  #endif	/* __ASM_ATOMIC_LSE_H */
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -147,6 +147,19 @@ __CMPXCHG_DBL(_mb)
>  
>  #undef __CMPXCHG_DBL
>  
> +#define __CMPXCHG128(name)						\
> +static inline long __cmpxchg128##name(volatile u128 *ptr,		\

Issue #2: this should be

static inline u128 __cmpxchg128##name(..)

because cmpxchg* needs to return the old value.

Regards,
Boqun

> +				      u128 old, u128 new)		\
> +{									\
> +	return __lse_ll_sc_body(_cmpxchg128##name,			\
> +				ptr, old, new);				\
> +}
> +
> +__CMPXCHG128(   )
> +__CMPXCHG128(_mb)
> +
> +#undef __CMPXCHG128
> +
>  #define __CMPXCHG_GEN(sfx)						\
>  static __always_inline unsigned long __cmpxchg##sfx(volatile void *ptr,	\
>  					   unsigned long old,		\
> @@ -229,6 +242,19 @@ __CMPXCHG_GEN(_mb)
>  	__ret;									\
>  })
>  
> +/* cmpxchg128 */
> +#define system_has_cmpxchg128()		1
> +
> +#define arch_cmpxchg128(ptr, o, n)						\
> +({										\
> +	__cmpxchg128_mb((ptr), (o), (n));					\
> +})
> +
> +#define arch_cmpxchg128_local(ptr, o, n)					\
> +({										\
> +	__cmpxchg128((ptr), (o), (n));						\
> +})
> +
>  #define __CMPWAIT_CASE(w, sfx, sz)					\
>  static inline void __cmpwait_case_##sz(volatile void *ptr,		\
>  				       unsigned long val)		\
> --- a/arch/s390/include/asm/cmpxchg.h
> +++ b/arch/s390/include/asm/cmpxchg.h
> @@ -201,4 +201,37 @@ static __always_inline int __cmpxchg_dou
>  			 (unsigned long)(n1), (unsigned long)(n2));	\
>  })
>  
> +#define system_has_cmpxchg128()		1
> +
> +static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
> +{
> +	asm volatile(
> +		"	cdsg	%[old],%[new],%[ptr]\n"
> +		: [old] "+&d" (old)
> +		: [new] "d" (new),
> +		  [ptr] "QS" (*(unsigned long *)ptr)
> +		: "memory", "cc");
> +	return old;
> +}
> +
> +static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *oldp, u128 new)
> +{
> +	u128 old = *oldp;
> +	int cc;
> +
> +	asm volatile(
> +		"	cdsg	%[old],%[new],%[ptr]\n"
> +		"	ipm	%[cc]\n"
> +		"	srl	%[cc],28\n"
> +		: [cc] "=&d" (cc), [old] "+&d" (old)
> +		: [new] "d" (new),
> +		  [ptr] "QS" (*(unsigned long *)ptr)
> +		: "memory", "cc");
> +
> +	if (unlikely(!cc))
> +		*oldp = old;
> +
> +	return likely(cc);
> +}
> +
>  #endif /* __ASM_CMPXCHG_H */
> --- a/arch/x86/include/asm/cmpxchg_32.h
> +++ b/arch/x86/include/asm/cmpxchg_32.h
> @@ -103,6 +103,7 @@ static inline bool __try_cmpxchg64(volat
>  
>  #endif
>  
> -#define system_has_cmpxchg_double() boot_cpu_has(X86_FEATURE_CX8)
> +#define system_has_cmpxchg_double()	boot_cpu_has(X86_FEATURE_CX8)
> +#define system_has_cmpxchg64()		boot_cpu_has(X86_FEATURE_CX8)
>  
>  #endif /* _ASM_X86_CMPXCHG_32_H */
> --- a/arch/x86/include/asm/cmpxchg_64.h
> +++ b/arch/x86/include/asm/cmpxchg_64.h
> @@ -20,6 +20,59 @@
>  	arch_try_cmpxchg((ptr), (po), (n));				\
>  })
>  
> -#define system_has_cmpxchg_double() boot_cpu_has(X86_FEATURE_CX16)
> +union __u128_halves {
> +	u128 full;
> +	struct {
> +		u64 low, high;
> +	};
> +};
> +
> +static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
> +{
> +	union __u128_halves o = { .full = old, }, n = { .full = new, };
> +
> +	asm volatile(LOCK_PREFIX "cmpxchg16b %[ptr]"
> +		     : [ptr] "+m" (*ptr),
> +		       "+a" (o.low), "+d" (o.high)
> +		     : "b" (n.low), "c" (n.high)
> +		     : "memory");
> +
> +	return o.full;
> +}
> +
> +static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, u128 new)
> +{
> +	union __u128_halves o = { .full = old, }, n = { .full = new, };
> +
> +	asm volatile("cmpxchg16b %[ptr]"
> +		     : [ptr] "+m" (*ptr),
> +		       "+a" (o.low), "+d" (o.high)
> +		     : "b" (n.low), "c" (n.high)
> +		     : "memory");
> +
> +	return o.full;
> +}
> +
> +static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *old, u128 new)
> +{
> +	union __u128_halves o = { .full = *old, }, n = { .full = new, };
> +	bool ret;
> +
> +	asm volatile(LOCK_PREFIX "cmpxchg16b %[ptr]"
> +		     CC_SET(e)
> +		     : CC_OUT(e) (ret),
> +		       [ptr] "+m" (*ptr),
> +		       "+a" (o.low), "+d" (o.high)
> +		     : "b" (n.low), "c" (n.high)
> +		     : "memory");
> +
> +	if (unlikely(!ret))
> +		*old = o.full;
> +
> +	return likely(ret);
> +}
> +
> +#define system_has_cmpxchg_double()	boot_cpu_has(X86_FEATURE_CX16)
> +#define system_has_cmpxchg128()		boot_cpu_has(X86_FEATURE_CX16)
>  
>  #endif /* _ASM_X86_CMPXCHG_64_H */
> 
> 
