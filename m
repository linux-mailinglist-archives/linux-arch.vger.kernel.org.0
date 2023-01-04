Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C64065D4BB
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 14:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjADNzb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 08:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjADNza (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 08:55:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 517007657;
        Wed,  4 Jan 2023 05:55:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C3741FB;
        Wed,  4 Jan 2023 05:56:10 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 297963F587;
        Wed,  4 Jan 2023 05:55:23 -0800 (PST)
Date:   Wed, 4 Jan 2023 13:55:20 +0000
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
Message-ID: <Y7WFSAcbSsMI/0eh@FVFF77S0Q05N>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
 <Y6DEfQXymYVgL3oJ@boqun-archlinux>
 <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
 <Y7QszyTEG2+WiI/C@FVFF77S0Q05N>
 <Y7Q1uexv6DrxCASB@FVFF77S0Q05N>
 <Y7RVkjDC3EjQUCzM@FVFF77S0Q05N>
 <8fea3494-1d1f-4f64-b525-279152cf430b@app.fastmail.com>
 <Y7Vksr9OLZeL3qmU@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Vksr9OLZeL3qmU@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 04, 2023 at 11:36:18AM +0000, Mark Rutland wrote:
> On Tue, Jan 03, 2023 at 05:50:00PM +0100, Arnd Bergmann wrote:
> > On Tue, Jan 3, 2023, at 17:19, Mark Rutland wrote:
> > > On Tue, Jan 03, 2023 at 02:03:37PM +0000, Mark Rutland wrote:
> > >> On Tue, Jan 03, 2023 at 01:25:35PM +0000, Mark Rutland wrote:
> > >> > On Tue, Dec 20, 2022 at 12:08:16PM +0100, Peter Zijlstra wrote:
> > 
> > >> ... makes GCC much happier:
> > >
> > >> ... I'll go check whether clang is happy with that, and how far back that can
> > >> go, otherwise we'll need to blat the high half with a separate constaint that
> > >> (ideally) doesn't end up allocating a pointless address register.
> > >
> > > Hmm... from the commit history it looks like GCC prior to 5.1 might not be
> > > happy with that, but that *might* just be if we actually do arithmetic on the
> > > value, and we might be ok just using it for memroy effects. I can't currently
> > > get such an old GCC to run on my machines so I haven't been able to check.
> > 
> > gcc-5.1 is the oldest (barely) supported compiler, the minimum was
> > last raised from gcc-4.9 in linux-5.15. If only gcc-4.9 and older are
> > affected, we're good on mainline but may still want a fix for stable
> > kernels.
> 
> Yup; I just wanted something that would easily backport to stable, at least as
> far as linux-4.9.y (where I couldn't find the minimum GCC version when I looked
> yesterday).

I'd missed that we backported commit:

  dca5244d2f5b94f1 ("compiler.h: Raise minimum version of GCC to 5.1 for arm64")

... all the way back to v4.4.y, so we can assume v5.1 even in stable.

The earliest toolchain I could get running was GCC 4.8.5, and that was happy
with the __uint128_t cast for the asm,

Looking back through the history, the reason for the GCC 5.1 check was that
prior to GCC 5.1 GCC would output library calls for arithmetic on 128-bit
types, as noted in commit:

  fb8722735f50cd51 ("arm64: support __int128 on gcc 5+")

... but since we're not doing any actual manipulation of the value, that should
be fine.

I'll go write a commit message and send that out as a fix.

> > I checked that the cross-compiler binaries from [1] still work, but I noticed
> > that this version is missing the native aarch64-to-aarch64 compiler (x86 to
> > aarch64 and vice versa are there), and you need to install libmpfr4 [2]
> > as a dependency. The newer compilers (6.5.0 and up) don't have these problems.
> 
> I was trying the old kernel.org crosstool binaries, but I was either missing a
> library (or I have an incompatible version) on my x86_64 host. I'll have
> another look today -- thanks for the pointers!

It turns out I'd just missed that at some point the prefix used by the
kernel.org cross compilers changed from:

  aarch64-linux-gnu-

to:

  aarch64-linux-

... and I'd become so used to the latter that I was trying to invoke a binary
that didn't exist. With the older prefix I could use the kernel.org GCC 4.8.5
without issue.

Thanks,
Mark.
