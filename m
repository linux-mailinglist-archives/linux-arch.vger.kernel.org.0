Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F800689FB3
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 17:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjBCQxQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 11:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjBCQxP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 11:53:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5332768B;
        Fri,  3 Feb 2023 08:53:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CD93C14;
        Fri,  3 Feb 2023 08:53:55 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.90.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF3D43F71E;
        Fri,  3 Feb 2023 08:53:06 -0800 (PST)
Date:   Fri, 3 Feb 2023 16:52:59 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 03/10] arch: Introduce
 arch_{,try_}_cmpxchg128{,_local}()
Message-ID: <Y90763uF/cHqiOYN@FVFF77S0Q05N>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.373335780@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202152655.373335780@infradead.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 03:50:33PM +0100, Peter Zijlstra wrote:
> For all architectures that currently support cmpxchg_double()
> implement the cmpxchg128() family of functions that is basically the
> same but with a saner interface.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

For arm64:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/atomic_ll_sc.h |   41 +++++++++++++++++++++++++
>  arch/arm64/include/asm/atomic_lse.h   |   31 +++++++++++++++++++
>  arch/arm64/include/asm/cmpxchg.h      |   26 ++++++++++++++++
>  arch/s390/include/asm/cmpxchg.h       |   14 ++++++++
>  arch/x86/include/asm/cmpxchg_32.h     |    3 +
>  arch/x86/include/asm/cmpxchg_64.h     |   55 +++++++++++++++++++++++++++++++++-
>  6 files changed, 168 insertions(+), 2 deletions(-)
> 
> --- a/arch/arm64/include/asm/atomic_ll_sc.h
> +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> @@ -326,6 +326,47 @@ __CMPXCHG_DBL(   ,        ,  ,         )
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
> +#define __CMPXCHG128(name, mb, rel, cl...)                             \
> +static __always_inline u128						\
> +__ll_sc__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)	\
> +{									\
> +	union __u128_halves r, o = { .full = (old) },			\
> +			       n = { .full = (new) };			\
> +       unsigned int tmp;                                               \
> +									\
> +	asm volatile("// __cmpxchg128" #name "\n"			\
> +       "       prfm    pstl1strm, %[v]\n"                              \
> +       "1:     ldxp    %[rl], %[rh], %[v]\n"                           \
> +       "       cmp     %[rl], %[ol]\n"                                 \
> +       "       ccmp    %[rh], %[oh], 0, eq\n"                          \
> +       "       b.ne    2f\n"                                           \
> +       "       st" #rel "xp    %w[tmp], %[nl], %[nh], %[v]\n"          \
> +       "       cbnz    %w[tmp], 1b\n"                                  \
> +	"	" #mb "\n"						\
> +	"2:"								\
> +       : [v] "+Q" (*(u128 *)ptr),                                      \
> +         [rl] "=&r" (r.low), [rh] "=&r" (r.high),                      \
> +         [tmp] "=&r" (tmp)                                             \
> +       : [ol] "r" (o.low), [oh] "r" (o.high),                          \
> +         [nl] "r" (n.low), [nh] "r" (n.high)                           \
> +       : "cc", ##cl);                                                  \
> +									\
> +	return r.full;							\
> +}
> +
> +__CMPXCHG128(   ,        ,  )
> +__CMPXCHG128(_mb, dmb ish, l, "memory")
> +
> +#undef __CMPXCHG128
> +
>  #undef K
>  
>  #endif	/* __ASM_ATOMIC_LL_SC_H */
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
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
> +	  [v] "+Q" (*(u128 *)ptr)					\
> +	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
> +	  [oldval1] "r" (o.low), [oldval2] "r" (o.high)			\
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
> +static inline u128 __cmpxchg128##name(volatile u128 *ptr,		\
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
> @@ -201,4 +201,18 @@ static __always_inline int __cmpxchg_dou
>  			 (unsigned long)(n1), (unsigned long)(n2));	\
>  })
>  
> +#define system_has_cmpxchg128()		1
> +
> +static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
> +{
> +	asm volatile(
> +		"	cdsg	%[old],%[new],%[ptr]\n"
> +		: [old] "+d" (old), [ptr] "+QS" (*ptr)
> +		: [new] "d" (new)
> +		: "memory", "cc");
> +	return old;
> +}
> +
> +#define arch_cmpxchg128		arch_cmpxchg128
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
