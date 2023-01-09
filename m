Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5C1662F7E
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 19:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjAISuj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 13:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjAISui (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 13:50:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 385AE1AD8C;
        Mon,  9 Jan 2023 10:50:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A63032F4;
        Mon,  9 Jan 2023 10:51:17 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD6333F67D;
        Mon,  9 Jan 2023 10:50:29 -0800 (PST)
Date:   Mon, 9 Jan 2023 18:50:24 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dennis@kernel.org,
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
Message-ID: <Y7xh8Orb2/E2sM7J@FVFF77S0Q05N>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219154119.154045458@infradead.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On Mon, Dec 19, 2022 at 04:35:30PM +0100, Peter Zijlstra wrote:
> For all architectures that currently support cmpxchg_double()
> implement the cmpxchg128() family of functions that is basically the
> same but with a saner interface.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I tried giving this a go, specifically your queue core/wip-u128 branch with
HEAD commit c05419246aa69cd3, but it locked up at boot.

I spotted a couple of problems there which also apply here, noted below with
suggested fixes.

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

These lines clobber %3 and %4, but per below, those are input operands, and so this blows up.

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

I think we can do this simpler and more clearly if we use the u128 operand
directly, with the 'H' modifier to get at the high register of the pair:

| #define __CMPXCHG128(name, mb, rel, cl...)                              \
| static __always_inline u128                                             \
| __ll_sc__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)       \
| {                                                                       \
|         u128 ret;                                                       \
|         unsigned int tmp;                                               \
|                                                                         \
|         asm volatile("// __cmpxchg128" #name "\n"                       \
|         "       prfm    pstl1strm, %[v]\n"                              \
|         "1:     ldxp    %[ret], %H[ret], %[v]\n"                        \
|         "       cmp     %[ret], %[old]\n"                               \
|         "       ccmp    %H[ret], %H[old], #4, ne\n"                     \
|         "       b.ne    2f\n"                                           \
|         "       st" #rel "xp %w[tmp], %[new], %H[new], %[v]\n"          \
|         "       cbnz    %w[tmp], 1b\n"                                  \
|         "       " #mb "\n"                                              \
|         "2:"                                                            \
|         : [ret] "=&r" (ret),                                            \
|           [tmp] "=&r" (tmp),                                            \
|           [v] "+Q" (*ptr)                                               \
|         : [old] "r" (old),                                              \
|           [new] "r" (new)                                               \
|         : "cc" , ##cl);                                                 \
|                                                                         \
|         return ret;                                                     \
| }
| 
| __CMPXCHG128(   ,        ,  )
| __CMPXCHG128(_mb, dmb ish, l, "memory")
| 
| #undef __CMPXCHG128

Note: I've used CMP and CCMP to simplify the equality check, which clobbers the
flags/condition-codes ("cc"), but requires two fewer GPRs. I'm assuming that's
the better tradeoff here.

The existing cmpxchg_double() code clobbers the loaded value as part of
checking whether it was equal, but to be able to preserve the value and be able
to replay the loop (which for hilarious LL/SC reasons *must* be in asm), we
can't do the same here.

I've boot-tested the suggestion with GCC 12.1.0.

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

Spurious whitespace change?

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
> +	  [oldval1] "r" (r.low), [oldval2] "r" (r.high)			\
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

Similarly, I'd suggest:

| #define __CMPXCHG128(name, mb, cl...)                                   \
| static __always_inline u128                                             \
| __lse__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)         \
| {                                                                       \
|         asm volatile(                                                   \
|         __LSE_PREAMBLE                                                  \
|         "       casp" #mb "\t%[old], %H[old], %[new], %H[new], %[v]\n"  \
|         : [old] "+&r" (old),                                            \
|           [v] "+Q" (*(u128 *)ptr)                                       \
|         : [new] "r" (new)                                               \
|         : cl);                                                          \
|                                                                         \
|         return old;                                                     \
| }
| 
| __CMPXCHG128(   ,   )   
| __CMPXCHG128(_mb, al, "memory")
| 
| #undef __CMPXCHG128

Thanks,
Mark.
