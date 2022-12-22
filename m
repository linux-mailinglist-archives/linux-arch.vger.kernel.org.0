Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4983D65418E
	for <lists+linux-arch@lfdr.de>; Thu, 22 Dec 2022 14:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiLVNR2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Dec 2022 08:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiLVNR1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Dec 2022 08:17:27 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA72B247;
        Thu, 22 Dec 2022 05:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2XcHZF1PZLR2wIWpbwHYxjPC+APViKRD8vA3VUxcIvg=; b=KCXj9vIla9OYqKdFn9cR8kvNM7
        aFCQeC8riSg8V400TR89vezYQDYLiis4eNRLNs8TpTaXaw65hlSoAk1r6vPtZd+exgqLf0ix1mWk/
        7mD3VAmxpBkRslmasRJRs+fKtYpKnU1ADefum9T6WSCkywkO5VAsLjiapOTmMfHm3hWA+ZnPwbN/x
        w/QRGrx3Tff9U3N5qrWzRNVImBPIIWUH62fHNh4gOn/lh1uA85Bq4VekD+WTPjngLVS9jAhxdeZUl
        IsMAPZLgwBX86nVypWOAboNnZASXp2L/Ju1gXccS53q3KAKJFdUiOmNk/uvedjpjQbE+kHWV+JJwu
        O+7WKnuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p8LR1-00Dq0t-2q;
        Thu, 22 Dec 2022 13:16:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4E3C30006D;
        Thu, 22 Dec 2022 14:16:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D8FC2CEAF0FB; Thu, 22 Dec 2022 14:16:28 +0100 (CET)
Date:   Thu, 22 Dec 2022 14:16:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
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
Message-ID: <Y6RYrHV3PK+FwW2p@hirez.programming.kicks-ass.net>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
 <Y6OyAL2epKPHj+tr@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6OyAL2epKPHj+tr@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 21, 2022 at 05:25:20PM -0800, Boqun Feng wrote:

> > +#define __CMPXCHG128(name, mb, cl...)					\
> > +static __always_inline u128						\
> > +__lse__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)		\
> > +{									\
> > +	union __u128_halves r, o = { .full = (old) },			\
> > +			       n = { .full = (new) };			\
> > +	register unsigned long x0 asm ("x0") = o.low;			\
> > +	register unsigned long x1 asm ("x1") = o.high;			\
> > +	register unsigned long x2 asm ("x2") = n.low;			\
> > +	register unsigned long x3 asm ("x3") = n.high;			\
> > +	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
> > +									\
> > +	asm volatile(							\
> > +	__LSE_PREAMBLE							\
> > +	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
> > +	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
> > +	  [v] "+Q" (*(unsigned long *)ptr)				\
> > +	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
> 
> Issue #1: the line below can be removed, otherwise..
> 
> > +	  [oldval1] "r" (r.low), [oldval2] "r" (r.high)			\
> 
> warning:
> 
> 	./arch/arm64/include/asm/atomic_lse.h: In function '__lse__cmpxchg128_mb':
> 	./arch/arm64/include/asm/atomic_lse.h:309:27: warning: 'r.<U97b8>.low' is used uninitialized [-Wuninitialized]
> 	  309 |           [oldval1] "r" (r.low), [oldval2] "r" (r.high)
> 
> 
> > +	: cl);								\
> > +									\
> > +	r.low = x0; r.high = x1;					\
> > +									\
> > +	return r.full;							\
> > +}
> > +
> > +__CMPXCHG128(   ,   )
> > +__CMPXCHG128(_mb, al, "memory")
> > +
> > +#undef __CMPXCHG128
> > +
> >  #endif	/* __ASM_ATOMIC_LSE_H */
> > --- a/arch/arm64/include/asm/cmpxchg.h
> > +++ b/arch/arm64/include/asm/cmpxchg.h
> > @@ -147,6 +147,19 @@ __CMPXCHG_DBL(_mb)
> >  
> >  #undef __CMPXCHG_DBL
> >  
> > +#define __CMPXCHG128(name)						\
> > +static inline long __cmpxchg128##name(volatile u128 *ptr,		\
> 
> Issue #2: this should be
> 
> static inline u128 __cmpxchg128##name(..)
> 
> because cmpxchg* needs to return the old value.

Duh.. fixed both. Pushed out to queue/core/wip-u128. I'll probably
continue all this in two weeks (yay xmas break!).
