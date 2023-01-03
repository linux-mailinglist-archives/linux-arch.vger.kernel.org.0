Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D543265C3BA
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjACQTq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 11:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjACQTo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 11:19:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB03110566;
        Tue,  3 Jan 2023 08:19:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F23A51516;
        Tue,  3 Jan 2023 08:20:23 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D57E3F71A;
        Tue,  3 Jan 2023 08:19:36 -0800 (PST)
Date:   Tue, 3 Jan 2023 16:19:30 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, torvalds@linux-foundation.org,
        corbet@lwn.net, will@kernel.org, catalin.marinas@arm.com,
        dennis@kernel.org, tj@kernel.org, cl@linux.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        joro@8bytes.org, suravee.suthikulpanit@amd.com,
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
Message-ID: <Y7RVkjDC3EjQUCzM@FVFF77S0Q05N>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
 <Y6DEfQXymYVgL3oJ@boqun-archlinux>
 <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
 <Y7QszyTEG2+WiI/C@FVFF77S0Q05N>
 <Y7Q1uexv6DrxCASB@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Q1uexv6DrxCASB@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 03, 2023 at 02:03:37PM +0000, Mark Rutland wrote:
> On Tue, Jan 03, 2023 at 01:25:35PM +0000, Mark Rutland wrote:
> > On Tue, Dec 20, 2022 at 12:08:16PM +0100, Peter Zijlstra wrote:
> > > On Mon, Dec 19, 2022 at 12:07:25PM -0800, Boqun Feng wrote:
> > > > On Mon, Dec 19, 2022 at 04:35:30PM +0100, Peter Zijlstra wrote:
> > > > > For all architectures that currently support cmpxchg_double()
> > > > > implement the cmpxchg128() family of functions that is basically the
> > > > > same but with a saner interface.
> > > > > 
> > > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > ---
> > > > >  arch/arm64/include/asm/atomic_ll_sc.h |   38 +++++++++++++++++++++++
> > > > >  arch/arm64/include/asm/atomic_lse.h   |   33 +++++++++++++++++++-
> > > > >  arch/arm64/include/asm/cmpxchg.h      |   26 ++++++++++++++++
> > > > >  arch/s390/include/asm/cmpxchg.h       |   33 ++++++++++++++++++++
> > > > >  arch/x86/include/asm/cmpxchg_32.h     |    3 +
> > > > >  arch/x86/include/asm/cmpxchg_64.h     |   55 +++++++++++++++++++++++++++++++++-
> > > > >  6 files changed, 185 insertions(+), 3 deletions(-)
> > > > > 
> > > > > --- a/arch/arm64/include/asm/atomic_ll_sc.h
> > > > > +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> > > > > @@ -326,6 +326,44 @@ __CMPXCHG_DBL(   ,        ,  ,         )
> > > > >  __CMPXCHG_DBL(_mb, dmb ish, l, "memory")
> > > > >  
> > > > >  #undef __CMPXCHG_DBL
> > > > > +
> > > > > +union __u128_halves {
> > > > > +	u128 full;
> > > > > +	struct {
> > > > > +		u64 low, high;
> > > > > +	};
> > > > > +};
> > > > > +
> > > > > +#define __CMPXCHG128(name, mb, rel, cl)					\
> > > > > +static __always_inline u128						\
> > > > > +__ll_sc__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)	\
> > > > > +{									\
> > > > > +	union __u128_halves r, o = { .full = (old) },			\
> > > > > +			       n = { .full = (new) };			\
> > > > > +									\
> > > > > +	asm volatile("// __cmpxchg128" #name "\n"			\
> > > > > +	"	prfm	pstl1strm, %2\n"				\
> > > > > +	"1:	ldxp	%0, %1, %2\n"					\
> > > > > +	"	eor	%3, %0, %3\n"					\
> > > > > +	"	eor	%4, %1, %4\n"					\
> > > > > +	"	orr	%3, %4, %3\n"					\
> > > > > +	"	cbnz	%3, 2f\n"					\
> > > > > +	"	st" #rel "xp	%w3, %5, %6, %2\n"			\
> > > > > +	"	cbnz	%w3, 1b\n"					\
> > > > > +	"	" #mb "\n"						\
> > > > > +	"2:"								\
> > > > > +	: "=&r" (r.low), "=&r" (r.high), "+Q" (*(unsigned long *)ptr)	\
> > > > 
> > > > I wonder whether we should use "(*(u128 *)ptr)" instead of "(*(unsigned
> > > > long *) ptr)"? Because compilers may think only 64bit value pointed by
> > > > "ptr" gets modified, and they are allowed to do "useful" optimization.
> > > 
> > > In this I've copied the existing cmpxchg_double() code; I'll have to let
> > > the arch folks speak here, I've no clue.
> > 
> > We definitely need to ensure the compiler sees we poke the whole thing, or it
> > can get this horribly wrong, so that is a latent bug.
> > 
> > See commit:
> > 
> >   fee960bed5e857eb ("arm64: xchg: hazard against entire exchange variable")
> > 
> > ... for examples of GCC being clever, where I overlooked the *_double() cases.

> Using __uint128_t instead, e.g.
> 
> diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
> index 0890e4f568fb7..cbb3d961123b1 100644
> --- a/arch/arm64/include/asm/atomic_ll_sc.h
> +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> @@ -315,7 +315,7 @@ __ll_sc__cmpxchg_double##name(unsigned long old1,                   \
>         "       cbnz    %w0, 1b\n"                                      \
>         "       " #mb "\n"                                              \
>         "2:"                                                            \
> -       : "=&r" (tmp), "=&r" (ret), "+Q" (*(unsigned long *)ptr)        \
> +       : "=&r" (tmp), "=&r" (ret), "+Q" (*(__uint128_t *)ptr)          \
>         : "r" (old1), "r" (old2), "r" (new1), "r" (new2)                \
>         : cl);                                                          \
>                                                                         \
> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index 52075e93de6c0..a94d6dacc0292 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -311,7 +311,7 @@ __lse__cmpxchg_double##name(unsigned long old1,                             \
>         "       eor     %[old2], %[old2], %[oldval2]\n"                 \
>         "       orr     %[old1], %[old1], %[old2]"                      \
>         : [old1] "+&r" (x0), [old2] "+&r" (x1),                         \
> -         [v] "+Q" (*(unsigned long *)ptr)                              \
> +         [v] "+Q" (*(__uint128_t *)ptr)                                \
>         : [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),             \
>           [oldval1] "r" (oldval1), [oldval2] "r" (oldval2)              \
>         : cl);                                                          \
> 
> ... makes GCC much happier:

> ... I'll go check whether clang is happy with that, and how far back that can
> go, otherwise we'll need to blat the high half with a separate constaint that
> (ideally) doesn't end up allocating a pointless address register.

Hmm... from the commit history it looks like GCC prior to 5.1 might not be
happy with that, but that *might* just be if we actually do arithmetic on the
value, and we might be ok just using it for memroy effects. I can't currently
get such an old GCC to run on my machines so I haven't been able to check.

I'll dig into this a bit more tomorrow, but it looks like the options (for a
backport-suitable fix) will be:

(a) use a __uint128_t input+output, as above, if we're lucky

(b) introduce a second 64-bit input+output for the high half (likely a "+o")

(c) use a full memory clobber for ancient compilers.

Mark.
