Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB5710D04
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 15:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjEYNLq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEYNLp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 09:11:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9CB2;
        Thu, 25 May 2023 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9DEm7cVBdm52kK3UCzMVMzsLM3W+SSD9KxYzTiOP2os=; b=U1iALbTK7rHRU7VruFM7TO2E1Z
        xvRWFPd1doSjCsYDCMHOsTa++oGrg2nEYlCWtLO9dvrCYG9N6QHsuU4eTucS5i/YzLpxsrSFrNYvb
        TnGFukTMiMyFir0UB6XRsXp7+8l811BLakEig4nBp09A0rwnSvgUO8h8Obxd2EIXiNEj99e87oVpR
        wwUrVPb3F/WC52qPGfwBWdAQ/yTLMvMbyc9o7/4SrP+Orf6KuaDzcBvOeSUSIZQtnSs2xNgAfKEGX
        wAZb3MoIN8mFE7OLypmP7Jb+v5G1tAMXpGUnnBN6AvHH0VEO3mjcUXclEe3PAtmDJI25A1jXCr8Et
        CiIKtoYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2Ajx-00CD2j-1K; Thu, 25 May 2023 13:10:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6AAC3001AE;
        Thu, 25 May 2023 15:10:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B530C20A78741; Thu, 25 May 2023 15:10:43 +0200 (CEST)
Date:   Thu, 25 May 2023 15:10:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 08/11] slub: Replace cmpxchg_double()
Message-ID: <20230525131043.GT83892@hirez.programming.kicks-ass.net>
References: <20230515075659.118447996@infradead.org>
 <20230515080554.453785148@infradead.org>
 <20230524093246.GP83892@hirez.programming.kicks-ass.net>
 <20230525102946.GE38236@hirez.programming.kicks-ass.net>
 <292934ce-73fa-4077-9051-2ad909828f4a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <292934ce-73fa-4077-9051-2ad909828f4a@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25, 2023 at 12:52:06PM +0200, Arnd Bergmann wrote:
> On Thu, May 25, 2023, at 12:29, Peter Zijlstra wrote:
> > On Wed, May 24, 2023 at 11:32:47AM +0200, Peter Zijlstra wrote:
> >> On Mon, May 15, 2023 at 09:57:07AM +0200, Peter Zijlstra wrote:
> >
> > This then also means I need to look at this_cpu_cmpxchg128 and
> > this_cpu_cmoxchg64 behaviour when we dont have the CPUID feature.
> >
> > Because current verions seem to assume the instruction is present.
> 
> As far as I could tell when reviewing your series, this_cpu_cmpxchg64()
> is always available on all architectures. Depending on compile-time
> feature detection this would be either a native instruction that
> is guaranteed to work, or the irq-disabled version. On x86, this
> is handled at runtime with alternative_io().
> 
> this_cpu_cmpxchg128() clearly needed the system_has_cmpxchg128()
> check, same as system_has_cmpxchg_double() today.

So, having just dug through all that, on x86:

this_cpu_cmpxchg64() is:

 X86_CMPXCHG64=n -> fallback, irrespective of CX8
 X86_CMPXCHG64=y -> cmpxchg8b
 X86_64          -> cmpxchg


I've changed it to be similar between 32bit and 64bit such that both:

  cmpxchg#b when CX#, otherwise this_cpu_cmpxchg#b_emu


