Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14C565969F
	for <lists+linux-arch@lfdr.de>; Fri, 30 Dec 2022 10:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiL3JRH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Dec 2022 04:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiL3JRF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Dec 2022 04:17:05 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94D612AD6;
        Fri, 30 Dec 2022 01:17:03 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pBBUj-00CILa-7B; Fri, 30 Dec 2022 17:16:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Dec 2022 17:16:05 +0800
Date:   Fri, 30 Dec 2022 17:16:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
        corbet@lwn.net, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] crypto: x86/ghash - add comment and fix broken link
Message-ID: <Y66sVbBVtYu8Jll5@gondor.apana.org.au>
References: <20221220054042.188537-1-ebiggers@kernel.org>
 <20221220054042.188537-4-ebiggers@kernel.org>
 <Y6GJzD9PLKj+Ocr2@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6GJzD9PLKj+Ocr2@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 20, 2022 at 11:09:16AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 19, 2022 at 09:40:42PM -0800, Eric Biggers wrote:
>
> > - * http://software.intel.com/en-us/articles/carry-less-multiplication-and-its-usage-for-computing-the-gcm-mode/
> > + * https://www.intel.com/content/dam/develop/external/us/en/documents/clmul-wp-rev-2-02-2014-04-20.pdf
> 
> Since these things have a habbit if changing, we tend to prefer to host
> a copy on kernel.org somewhere (used to be bugzilla, but perhaps there's
> a better places these days).

Alternatively just save a copy at web.archive.org when you submit
the patch and use that link.  In fact it seems that the original
link is still available via web.archive.org (sans pictures).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
