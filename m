Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA85651F6E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Dec 2022 12:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiLTLJW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 06:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiLTLJV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 06:09:21 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425AB12766;
        Tue, 20 Dec 2022 03:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WnDr2T6Lz6o8EGXfFOLVGTm1EwVLYgoHb8GLpQHXt1M=; b=IagLEV2UTnOH/1oiatZU2t3fd9
        wIPIif+7ieQr0xntpK0GaWRRyiwDimnm1M6YG2G9sgsXB6FHTn576bYXZ2XsZQu0X8SVskwk0RdED
        sUugD1rIZDNEonT+Wrqt9z6gKuYGTXksjAvjtBZde5JzbCpvKPzWPD1B3Cr1mg/gBpkJd++WwKlHn
        CyrczxUMFGQp9teEMndrfFHW1fsEnOaw7HKW7iIuwSjcBQVnSoFpre5ReinrnsDbQ5HAqkui68Umh
        mhCAarnFYTE260WL9Igxo03K9hMfZoyNoHum8h5NGIXp5g8yzrlrLDnscp3XKQ468GvNz5tPnXOvK
        5BahRGCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1p7aTs-00Cy6n-0d;
        Tue, 20 Dec 2022 11:08:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E507F300023;
        Tue, 20 Dec 2022 12:08:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 767AE201D1375; Tue, 20 Dec 2022 12:08:16 +0100 (CET)
Date:   Tue, 20 Dec 2022 12:08:16 +0100
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
Message-ID: <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
 <Y6DEfQXymYVgL3oJ@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6DEfQXymYVgL3oJ@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 12:07:25PM -0800, Boqun Feng wrote:
> On Mon, Dec 19, 2022 at 04:35:30PM +0100, Peter Zijlstra wrote:
> > For all architectures that currently support cmpxchg_double()
> > implement the cmpxchg128() family of functions that is basically the
> > same but with a saner interface.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/arm64/include/asm/atomic_ll_sc.h |   38 +++++++++++++++++++++++
> >  arch/arm64/include/asm/atomic_lse.h   |   33 +++++++++++++++++++-
> >  arch/arm64/include/asm/cmpxchg.h      |   26 ++++++++++++++++
> >  arch/s390/include/asm/cmpxchg.h       |   33 ++++++++++++++++++++
> >  arch/x86/include/asm/cmpxchg_32.h     |    3 +
> >  arch/x86/include/asm/cmpxchg_64.h     |   55 +++++++++++++++++++++++++++++++++-
> >  6 files changed, 185 insertions(+), 3 deletions(-)
> > 
> > --- a/arch/arm64/include/asm/atomic_ll_sc.h
> > +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> > @@ -326,6 +326,44 @@ __CMPXCHG_DBL(   ,        ,  ,         )
> >  __CMPXCHG_DBL(_mb, dmb ish, l, "memory")
> >  
> >  #undef __CMPXCHG_DBL
> > +
> > +union __u128_halves {
> > +	u128 full;
> > +	struct {
> > +		u64 low, high;
> > +	};
> > +};
> > +
> > +#define __CMPXCHG128(name, mb, rel, cl)					\
> > +static __always_inline u128						\
> > +__ll_sc__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)	\
> > +{									\
> > +	union __u128_halves r, o = { .full = (old) },			\
> > +			       n = { .full = (new) };			\
> > +									\
> > +	asm volatile("// __cmpxchg128" #name "\n"			\
> > +	"	prfm	pstl1strm, %2\n"				\
> > +	"1:	ldxp	%0, %1, %2\n"					\
> > +	"	eor	%3, %0, %3\n"					\
> > +	"	eor	%4, %1, %4\n"					\
> > +	"	orr	%3, %4, %3\n"					\
> > +	"	cbnz	%3, 2f\n"					\
> > +	"	st" #rel "xp	%w3, %5, %6, %2\n"			\
> > +	"	cbnz	%w3, 1b\n"					\
> > +	"	" #mb "\n"						\
> > +	"2:"								\
> > +	: "=&r" (r.low), "=&r" (r.high), "+Q" (*(unsigned long *)ptr)	\
> 
> I wonder whether we should use "(*(u128 *)ptr)" instead of "(*(unsigned
> long *) ptr)"? Because compilers may think only 64bit value pointed by
> "ptr" gets modified, and they are allowed to do "useful" optimization.

In this I've copied the existing cmpxchg_double() code; I'll have to let
the arch folks speak here, I've no clue.
