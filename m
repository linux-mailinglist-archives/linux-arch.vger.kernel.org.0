Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE187163F0
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjE3OZd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 10:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjE3OYo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 10:24:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B2D1B8;
        Tue, 30 May 2023 07:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NWEmuGkLTCUa79jBEH3/UxEeJ1XI0nknDfWdtfSsgPs=; b=Ct+KeY0bR7Fd2pFV938dRGSXTb
        +T51wSDRsfKeMuSei4YQEsU4Xi76eoiaYVk/lttEnZJBJ2NUxa0nAwt21F7XjN8xiXMXaKvYxsPjv
        1JwrujAB4owDEhg+CCV3cNBdBGPbJO1CWCIJ3zo7ADAp/AyyICHpHTcJDGSsXcUaQJ2nQQY3rFLU9
        SCt5AhrjoGTUAJR4EssZvVmoJZxXtj67WW2fm46MJfmTOgqrwkt1CaD0nt4+OU3de5LcfLLr02uIQ
        paqW6ykLF99/+KF3EKEe2ruu40MWJIAj+6KGzGVrsLeK2a2sThWNiV/lisP1NFlavwALCeW8DS4eD
        ytHa5ABQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q40FD-006M99-Vy; Tue, 30 May 2023 14:22:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4605300233;
        Tue, 30 May 2023 16:22:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A11CD2414735F; Tue, 30 May 2023 16:22:32 +0200 (CEST)
Date:   Tue, 30 May 2023 16:22:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     corbet@lwn.net, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
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
        linux-crypto@vger.kernel.org, sfr@canb.auug.org.au,
        mpe@ellerman.id.au, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v3 08/11] slub: Replace cmpxchg_double()
Message-ID: <20230530142232.GA200270@hirez.programming.kicks-ass.net>
References: <20230515075659.118447996@infradead.org>
 <20230515080554.453785148@infradead.org>
 <20230524093246.GP83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524093246.GP83892@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 24, 2023 at 11:32:47AM +0200, Peter Zijlstra wrote:
> On Mon, May 15, 2023 at 09:57:07AM +0200, Peter Zijlstra wrote:
> 
> > @@ -3008,6 +3029,22 @@ static inline bool pfmemalloc_match(stru
> >  }
> >  
> >  #ifndef CONFIG_SLUB_TINY
> > +static inline bool
> > +__update_cpu_freelist_fast(struct kmem_cache *s,
> > +			   void *freelist_old, void *freelist_new,
> > +			   unsigned long tid)
> > +{
> > +#ifdef system_has_freelist_aba
> > +	freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
> > +	freelist_aba_t new = { .freelist = freelist_new, .counter = next_tid(tid) };
> > +
> > +	return this_cpu_cmpxchg_freelist(s->cpu_slab->freelist_tid.full,
> > +					 old.full, new.full) == old.full;
> > +#else
> > +	return false;
> > +#endif
> > +}
> > +
> >  /*
> >   * Check the slab->freelist and either transfer the freelist to the
> >   * per cpu freelist or deactivate the slab.
> > @@ -3359,11 +3396,7 @@ static __always_inline void *__slab_allo
> >  		 * against code executing on this cpu *not* from access by
> >  		 * other cpus.
> >  		 */
> > -		if (unlikely(!this_cpu_cmpxchg_double(
> > -				s->cpu_slab->freelist, s->cpu_slab->tid,
> > -				object, tid,
> > -				next_object, next_tid(tid)))) {
> > -
> > +		if (unlikely(!__update_cpu_freelist_fast(s, object, next_object, tid))) {
> >  			note_cmpxchg_failure("slab_alloc", s, tid);
> >  			goto redo;
> >  		}
> > @@ -3736,11 +3769,7 @@ static __always_inline void do_slab_free
> >  
> >  		set_freepointer(s, tail_obj, freelist);
> >  
> > -		if (unlikely(!this_cpu_cmpxchg_double(
> > -				s->cpu_slab->freelist, s->cpu_slab->tid,
> > -				freelist, tid,
> > -				head, next_tid(tid)))) {
> > -
> > +		if (unlikely(!__update_cpu_freelist_fast(s, freelist, head, tid))) {
> >  			note_cmpxchg_failure("slab_free", s, tid);
> >  			goto redo;
> >  		}
> 
> This isn't right; the this_cpu_cmpxchg_double() was unconditional and
> relied on the local_irq_save() fallback when no native cmpxchg128 is
> present.

This means this_cpu_cmpxchg128 is expected to be present on all 64bit
archs, except Mark just found out that HPPA doens't support __int128
until gcc-11.

(I've been building using gcc-12.2)

And because the cmpxchg128 fallback relies on '==' we can't trivally
fudge that with a struct type either :/ Now, afaict it all magically
works if I use:

#ifdef __SIZEOF_INT128__
typedef __s128 s128
typedef __u128 u128
#else
#if defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
typedef long double u128;
#endif
#endif

but that is *super* gross.

The alternative is raising the minimum GCC for PARISC to gcc-11..

Yet another alternative is using a struct type and an equality function,
just for this.

Anybody?
