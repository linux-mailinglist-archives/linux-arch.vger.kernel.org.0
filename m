Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379EF65C167
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 15:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbjACOEJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 09:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbjACOEF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 09:04:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3B3510B6C;
        Tue,  3 Jan 2023 06:03:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B1831595;
        Tue,  3 Jan 2023 06:04:39 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9306B3F587;
        Tue,  3 Jan 2023 06:03:51 -0800 (PST)
Date:   Tue, 3 Jan 2023 14:03:37 +0000
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
Message-ID: <Y7Q1uexv6DrxCASB@FVFF77S0Q05N>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
 <Y6DEfQXymYVgL3oJ@boqun-archlinux>
 <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
 <Y7QszyTEG2+WiI/C@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7QszyTEG2+WiI/C@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 03, 2023 at 01:25:35PM +0000, Mark Rutland wrote:
> On Tue, Dec 20, 2022 at 12:08:16PM +0100, Peter Zijlstra wrote:
> > On Mon, Dec 19, 2022 at 12:07:25PM -0800, Boqun Feng wrote:
> > > On Mon, Dec 19, 2022 at 04:35:30PM +0100, Peter Zijlstra wrote:
> > > > For all architectures that currently support cmpxchg_double()
> > > > implement the cmpxchg128() family of functions that is basically the
> > > > same but with a saner interface.
> > > > 
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > ---
> > > >  arch/arm64/include/asm/atomic_ll_sc.h |   38 +++++++++++++++++++++++
> > > >  arch/arm64/include/asm/atomic_lse.h   |   33 +++++++++++++++++++-
> > > >  arch/arm64/include/asm/cmpxchg.h      |   26 ++++++++++++++++
> > > >  arch/s390/include/asm/cmpxchg.h       |   33 ++++++++++++++++++++
> > > >  arch/x86/include/asm/cmpxchg_32.h     |    3 +
> > > >  arch/x86/include/asm/cmpxchg_64.h     |   55 +++++++++++++++++++++++++++++++++-
> > > >  6 files changed, 185 insertions(+), 3 deletions(-)
> > > > 
> > > > --- a/arch/arm64/include/asm/atomic_ll_sc.h
> > > > +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> > > > @@ -326,6 +326,44 @@ __CMPXCHG_DBL(   ,        ,  ,         )
> > > >  __CMPXCHG_DBL(_mb, dmb ish, l, "memory")
> > > >  
> > > >  #undef __CMPXCHG_DBL
> > > > +
> > > > +union __u128_halves {
> > > > +	u128 full;
> > > > +	struct {
> > > > +		u64 low, high;
> > > > +	};
> > > > +};
> > > > +
> > > > +#define __CMPXCHG128(name, mb, rel, cl)					\
> > > > +static __always_inline u128						\
> > > > +__ll_sc__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)	\
> > > > +{									\
> > > > +	union __u128_halves r, o = { .full = (old) },			\
> > > > +			       n = { .full = (new) };			\
> > > > +									\
> > > > +	asm volatile("// __cmpxchg128" #name "\n"			\
> > > > +	"	prfm	pstl1strm, %2\n"				\
> > > > +	"1:	ldxp	%0, %1, %2\n"					\
> > > > +	"	eor	%3, %0, %3\n"					\
> > > > +	"	eor	%4, %1, %4\n"					\
> > > > +	"	orr	%3, %4, %3\n"					\
> > > > +	"	cbnz	%3, 2f\n"					\
> > > > +	"	st" #rel "xp	%w3, %5, %6, %2\n"			\
> > > > +	"	cbnz	%w3, 1b\n"					\
> > > > +	"	" #mb "\n"						\
> > > > +	"2:"								\
> > > > +	: "=&r" (r.low), "=&r" (r.high), "+Q" (*(unsigned long *)ptr)	\
> > > 
> > > I wonder whether we should use "(*(u128 *)ptr)" instead of "(*(unsigned
> > > long *) ptr)"? Because compilers may think only 64bit value pointed by
> > > "ptr" gets modified, and they are allowed to do "useful" optimization.
> > 
> > In this I've copied the existing cmpxchg_double() code; I'll have to let
> > the arch folks speak here, I've no clue.
> 
> We definitely need to ensure the compiler sees we poke the whole thing, or it
> can get this horribly wrong, so that is a latent bug.
> 
> See commit:
> 
>   fee960bed5e857eb ("arm64: xchg: hazard against entire exchange variable")
> 
> ... for examples of GCC being clever, where I overlooked the *_double() cases.

Ugh; with GCC 12.1.0, arm64 defconfig, and the following:

| struct big {
|         u64 lo, hi;
| } __aligned(128);
| 
| unsigned long foo(struct big *b)
| {
|         u64 hi_old, hi_new;
| 
|         hi_old = b->hi;
| 
|         cmpxchg_double_local(&b->lo, &b->hi, 0x12, 0x34, 0x56, 0x78);
| 
|         hi_new = b->hi;
| 
|         return hi_old ^ hi_new;
| }

GCC clearly figures out the high half isn't modified, and constant folds hi_old
^ hi_new down to zero, regardless of whether we use LL/SC or LSE:

<foo>:
   0:   d503233f        paciasp
   4:   aa0003e4        mov     x4, x0
   8:   1400000e        b       40 <foo+0x40>
   c:   d2800240        mov     x0, #0x12                       // #18
  10:   d2800681        mov     x1, #0x34                       // #52
  14:   aa0003e5        mov     x5, x0
  18:   aa0103e6        mov     x6, x1
  1c:   d2800ac2        mov     x2, #0x56                       // #86
  20:   d2800f03        mov     x3, #0x78                       // #120
  24:   48207c82        casp    x0, x1, x2, x3, [x4]
  28:   ca050000        eor     x0, x0, x5
  2c:   ca060021        eor     x1, x1, x6
  30:   aa010000        orr     x0, x0, x1
  34:   d2800000        mov     x0, #0x0                        // #0    <--- BANG
  38:   d50323bf        autiasp
  3c:   d65f03c0        ret
  40:   d2800240        mov     x0, #0x12                       // #18
  44:   d2800681        mov     x1, #0x34                       // #52
  48:   d2800ac2        mov     x2, #0x56                       // #86
  4c:   d2800f03        mov     x3, #0x78                       // #120
  50:   f9800091        prfm    pstl1strm, [x4]
  54:   c87f1885        ldxp    x5, x6, [x4]
  58:   ca0000a5        eor     x5, x5, x0
  5c:   ca0100c6        eor     x6, x6, x1
  60:   aa0600a6        orr     x6, x5, x6
  64:   b5000066        cbnz    x6, 70 <foo+0x70>
  68:   c8250c82        stxp    w5, x2, x3, [x4]
  6c:   35ffff45        cbnz    w5, 54 <foo+0x54>
  70:   d2800000        mov     x0, #0x0                        // #0     <--- BANG
  74:   d50323bf        autiasp
  78:   d65f03c0        ret
  7c:   d503201f        nop

... so we *definitely* need to fix that.

Using __uint128_t instead, e.g.

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index 0890e4f568fb7..cbb3d961123b1 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -315,7 +315,7 @@ __ll_sc__cmpxchg_double##name(unsigned long old1,                   \
        "       cbnz    %w0, 1b\n"                                      \
        "       " #mb "\n"                                              \
        "2:"                                                            \
-       : "=&r" (tmp), "=&r" (ret), "+Q" (*(unsigned long *)ptr)        \
+       : "=&r" (tmp), "=&r" (ret), "+Q" (*(__uint128_t *)ptr)          \
        : "r" (old1), "r" (old2), "r" (new1), "r" (new2)                \
        : cl);                                                          \
                                                                        \
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 52075e93de6c0..a94d6dacc0292 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -311,7 +311,7 @@ __lse__cmpxchg_double##name(unsigned long old1,                             \
        "       eor     %[old2], %[old2], %[oldval2]\n"                 \
        "       orr     %[old1], %[old1], %[old2]"                      \
        : [old1] "+&r" (x0), [old2] "+&r" (x1),                         \
-         [v] "+Q" (*(unsigned long *)ptr)                              \
+         [v] "+Q" (*(__uint128_t *)ptr)                                \
        : [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),             \
          [oldval1] "r" (oldval1), [oldval2] "r" (oldval2)              \
        : cl);                                                          \

... makes GCC much happier:

<foo>:
   0:   f9400407        ldr     x7, [x0, #8]
   4:   d503233f        paciasp
   8:   aa0003e4        mov     x4, x0
   c:   1400000f        b       48 <foo+0x48>
  10:   d2800240        mov     x0, #0x12                       // #18
  14:   d2800681        mov     x1, #0x34                       // #52
  18:   aa0003e5        mov     x5, x0
  1c:   aa0103e6        mov     x6, x1
  20:   d2800ac2        mov     x2, #0x56                       // #86
  24:   d2800f03        mov     x3, #0x78                       // #120
  28:   48207c82        casp    x0, x1, x2, x3, [x4]
  2c:   ca050000        eor     x0, x0, x5
  30:   ca060021        eor     x1, x1, x6
  34:   aa010000        orr     x0, x0, x1
  38:   f9400480        ldr     x0, [x4, #8]
  3c:   d50323bf        autiasp
  40:   ca0000e0        eor     x0, x7, x0
  44:   d65f03c0        ret
  48:   d2800240        mov     x0, #0x12                       // #18
  4c:   d2800681        mov     x1, #0x34                       // #52
  50:   d2800ac2        mov     x2, #0x56                       // #86
  54:   d2800f03        mov     x3, #0x78                       // #120
  58:   f9800091        prfm    pstl1strm, [x4]
  5c:   c87f1885        ldxp    x5, x6, [x4]
  60:   ca0000a5        eor     x5, x5, x0
  64:   ca0100c6        eor     x6, x6, x1
  68:   aa0600a6        orr     x6, x5, x6
  6c:   b5000066        cbnz    x6, 78 <foo+0x78>
  70:   c8250c82        stxp    w5, x2, x3, [x4]
  74:   35ffff45        cbnz    w5, 5c <foo+0x5c>
  78:   f9400480        ldr     x0, [x4, #8]
  7c:   d50323bf        autiasp
  80:   ca0000e0        eor     x0, x7, x0
  84:   d65f03c0        ret
  88:   d503201f        nop
  8c:   d503201f        nop

... I'll go check whether clang is happy with that, and how far back that can
go, otherwise we'll need to blat the high half with a separate constaint that
(ideally) doesn't end up allocating a pointless address register.

Mark.
