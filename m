Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F90719A25
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjFAKvM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 06:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAKvL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 06:51:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AAD9D;
        Thu,  1 Jun 2023 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sqOkmNSuBD7GBtb46itE8ZDvhkHRWIc2NbvPp9qeOiw=; b=KZkC2WT4XQMr05qEkGpBjCv7TG
        Ak6b/9n5dS5ZPNEFM10/VvLJvSS1D5ylwPHzd2DaQkM+piIbsvAz/pGM04U57+k94ayIQeNYv/Zpr
        p75C1W/ZCqWn3ZEDzShydO0ovDBfnP1AqQJwgcDzODs4ufgi5DRaXCvhf1ySS+x4TLywE5eK3nk8v
        3XQKlVIoFYPn55+2ybBmZuzlaHrG7I/QAPJb5OtatUGXyIlhc26higj14zyA/1vT2iclbpfYPL3TA
        Nx806QJ6JOI2IEjvEs6POHy4WF448K4MQtyi2wClcFurUdFMq5GGHx9JYbaGa2fFQNILHK/d8n61V
        wBRZ/4Zw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4fsv-008IFd-Tl; Thu, 01 Jun 2023 10:50:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2E913002F0;
        Thu,  1 Jun 2023 12:50:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96C9A21AA6F9B; Thu,  1 Jun 2023 12:50:21 +0200 (CEST)
Date:   Thu, 1 Jun 2023 12:50:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>,
        Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of
 __SIZEOF_INT128__
Message-ID: <20230601105021.GU4253@hirez.programming.kicks-ass.net>
References: <20230531130833.635651916@infradead.org>
 <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com>
 <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 01, 2023 at 12:32:38PM +0200, Helge Deller wrote:
> On 6/1/23 12:14, Peter Zijlstra wrote:
> > On Wed, May 31, 2023 at 04:21:22PM +0200, Arnd Bergmann wrote:
> > 
> > > It would be nice to have the hack more localized to parisc
> > > and guarded with a CONFIG_GCC_VERSION check so we can kill
> > > it off in the future, once we drop either gcc-10 or parisc
> > > support.
> > 
> > I vote for dropping parisc -- it's the only 64bit arch that doesn't have
> > sane atomics.
> 
> Of course I'm against dropping parisc.

:-)

> > Anyway, the below seems to work -- build tested with GCC-10.1
> 
> I don't think we need to care about gcc-10 on parisc.
> Debian and Gentoo are the only supported distributions, while Debian
> requires gcc-12 to build > 6.x kernels, and I assume Gentoo uses at least
> gcc-12 as well.
> 
> So raising the gcc limit for parisc only (at least temporarily for now)
> should be fine and your workaround below wouldn't be necessary, right?

Correct, if you're willing to set minimum GCC version to 11 for parisc
all is well and this patch can go play in the bit bucket.
