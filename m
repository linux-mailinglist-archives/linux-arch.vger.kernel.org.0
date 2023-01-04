Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7475065D189
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 12:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjADLg3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 06:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjADLg2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 06:36:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 032EFAE7B;
        Wed,  4 Jan 2023 03:36:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F7021042;
        Wed,  4 Jan 2023 03:37:08 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24573F587;
        Wed,  4 Jan 2023 03:36:20 -0800 (PST)
Date:   Wed, 4 Jan 2023 11:36:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC][PATCH 05/12] arch: Introduce
 arch_{,try_}_cmpxchg128{,_local}()
Message-ID: <Y7Vksr9OLZeL3qmU@FVFF77S0Q05N>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
 <Y6DEfQXymYVgL3oJ@boqun-archlinux>
 <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
 <Y7QszyTEG2+WiI/C@FVFF77S0Q05N>
 <Y7Q1uexv6DrxCASB@FVFF77S0Q05N>
 <Y7RVkjDC3EjQUCzM@FVFF77S0Q05N>
 <8fea3494-1d1f-4f64-b525-279152cf430b@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fea3494-1d1f-4f64-b525-279152cf430b@app.fastmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 03, 2023 at 05:50:00PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 3, 2023, at 17:19, Mark Rutland wrote:
> > On Tue, Jan 03, 2023 at 02:03:37PM +0000, Mark Rutland wrote:
> >> On Tue, Jan 03, 2023 at 01:25:35PM +0000, Mark Rutland wrote:
> >> > On Tue, Dec 20, 2022 at 12:08:16PM +0100, Peter Zijlstra wrote:
> 
> >> ... makes GCC much happier:
> >
> >> ... I'll go check whether clang is happy with that, and how far back that can
> >> go, otherwise we'll need to blat the high half with a separate constaint that
> >> (ideally) doesn't end up allocating a pointless address register.
> >
> > Hmm... from the commit history it looks like GCC prior to 5.1 might not be
> > happy with that, but that *might* just be if we actually do arithmetic on the
> > value, and we might be ok just using it for memroy effects. I can't currently
> > get such an old GCC to run on my machines so I haven't been able to check.
> 
> gcc-5.1 is the oldest (barely) supported compiler, the minimum was
> last raised from gcc-4.9 in linux-5.15. If only gcc-4.9 and older are
> affected, we're good on mainline but may still want a fix for stable
> kernels.

Yup; I just wanted something that would easily backport to stable, at least as
far as linux-4.9.y (where I couldn't find the minimum GCC version when I looked
yesterday).

> I checked that the cross-compiler binaries from [1] still work, but I noticed
> that this version is missing the native aarch64-to-aarch64 compiler (x86 to
> aarch64 and vice versa are there), and you need to install libmpfr4 [2]
> as a dependency. The newer compilers (6.5.0 and up) don't have these problems.

I was trying the old kernel.org crosstool binaries, but I was either missing a
library (or I have an incompatible version) on my x86_64 host. I'll have
another look today -- thanks for the pointers!

Mark.

>      Arnd
> 
> [1] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/arm64/5.5.0/
> [2] http://ftp.uk.debian.org/debian/pool/main/m/mpfr4/libmpfr4_3.1.5-1_arm64.deb
