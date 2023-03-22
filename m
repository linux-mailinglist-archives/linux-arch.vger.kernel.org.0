Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE1E6C4D43
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 15:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCVOQK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 10:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCVOQJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 10:16:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F562618AD;
        Wed, 22 Mar 2023 07:16:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01DB94B3;
        Wed, 22 Mar 2023 07:16:51 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.53.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 396BA3F71E;
        Wed, 22 Mar 2023 07:16:04 -0700 (PDT)
Date:   Wed, 22 Mar 2023 14:16:01 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gor@linux.ibm.com, hca@linux.ibm.com, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robin.murphy@arm.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, will@kernel.org
Subject: Re: [PATCH v2 3/4] arm64: fix __raw_copy_to_user semantics
Message-ID: <ZBsNoftQ4FMvvKtQ@FVFF77S0Q05N>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
 <20230321122514.1743889-4-mark.rutland@arm.com>
 <CAHk-=wjCN93bY_iMUF-msP6+2cCQTssQe4kiW2P1ZBDxf4Rt3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjCN93bY_iMUF-msP6+2cCQTssQe4kiW2P1ZBDxf4Rt3g@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 21, 2023 at 10:50:33AM -0700, Linus Torvalds wrote:
> On Tue, Mar 21, 2023 at 5:25 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > For some combinations of sizes and alignments __{arch,raw}_copy_to_user
> > will copy some bytes between (to + size - N) and (to + size), but will
> > never modify bytes past (to + size).
> >
> > This violates the documentation in <linux/uaccess.h>, which states:
> >
> > > If raw_copy_{to,from}_user(to, from, size) returns N, size - N bytes
> > > starting at to must become equal to the bytes fetched from the
> > > corresponding area starting at from.  All data past to + size - N must
> > > be left unmodified.
> 
> Hmm.
> 
> I'm not 100% sure we couldn't just relax the documentation.

Ok.

> After all, the "exception happens in the middle of a copy" is a
> special case, and generally results in -EFAULT rather than any
> indication of "this is how much data we filled in for user space".
> 
> Now, some operations do *try* to generally give partial results
> (notably "read()") even in the presence of page faults in the middle,
> but I'm not entirely convinced we need to bend over backwards over
> this.

If you think we should relax the documented semantic, I can go do that. If we
actually need the documented semantic in some cases, then something will need
to change.

All I'm really after is "what should the semantic be?" since there's clearly a
disconnect between the documentation and the code. I'm happy to go update
either.

> Put another way: we have lots of situations where we fill in partial
> user butffers and then return EFAULT, so "copy_to_user()" has at no
> point been "atomic" wrt the return value.
> 
> So I in no way hate this patch, and I do think it's a good "QoI fix",
> but if this ends up being painful for some architecture, I get the
> feeling that we could easily just relax the implementation instead.
> 
> We have accepted the whole "return value is not byte-exact" thing
> forever, simply because we have never required user copies to be done
> as byte-at-a-time copies.
> 
> Now, it is undoubtedly true that the buffer we fill in with a user copy must
> 
>  (a) be filled AT LEAST as much as we reported it to be filled in (ie
> user space can expect that there's no uninitialized data in any range
> we claimed to fill)
> 
>  (b) obviously never filled past the buffer size that was given

I agree those are both necessary.

> But if we take an exception in the middle, and write a partial aligned
> word, and don't report that as written (which is what you are fixing),
> I really feel that is a "QoI" thing, not a correctness thing.
>
> I don't think this arm implementation thing has ever hurt anything, in
> other words.
> 
> That said, at some point that quality-of-implementation thing makes
> validation so much easier that maybe it's worth doing just for that
> reason, which is why I think "if it's not too painful, go right ahead"
> is fine.

Fair enough.

Thanks,
Mark.
