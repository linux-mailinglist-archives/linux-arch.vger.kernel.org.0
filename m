Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9F36C4F73
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 16:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjCVPas (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 11:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjCVPar (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 11:30:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAD98460BB;
        Wed, 22 Mar 2023 08:30:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EAE24B3;
        Wed, 22 Mar 2023 08:31:29 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.53.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 408FE3F71E;
        Wed, 22 Mar 2023 08:30:42 -0700 (PDT)
Date:   Wed, 22 Mar 2023 15:30:39 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, dave.hansen@linux.intel.com,
        davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        robin.murphy@arm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        will@kernel.org
Subject: Re: [PATCH v2 3/4] arm64: fix __raw_copy_to_user semantics
Message-ID: <ZBsfH6DCVFhrGleS@FVFF77S0Q05N>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
 <20230321122514.1743889-4-mark.rutland@arm.com>
 <ZBsVOu6ygLoGOI5d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsVOu6ygLoGOI5d@arm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 22, 2023 at 02:48:26PM +0000, Catalin Marinas wrote:
> On Tue, Mar 21, 2023 at 12:25:13PM +0000, Mark Rutland wrote:
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
> > 
> > This can be demonstrated through testing, e.g.
> > 
> > |     # test_copy_to_user: EXPECTATION FAILED at lib/usercopy_kunit.c:287
> > | post-destination bytes modified (dst_page[4082]=0x1, offset=4081, size=16, ret=15)
> > | [FAILED] 16 byte copy
> > 
> > This happens because the __arch_copy_to_user() can make unaligned stores
> > to the userspace buffer, and the ARM architecture permits (but does not
> > require) that such unaligned stores write some bytes before raising a
> > fault (per ARM DDI 0487I.a Section B2.2.1 and Section B2.7.1). The
> > extable fixup handlers in __arch_copy_to_user() assume that any faulting
> > store has failed entirely, and so under-report the number of bytes
> > copied when an unaligned store writes some bytes before faulting.
> 
> I find the Arm ARM hard to parse (no surprise here). Do you happen to
> know what the behavior is for the new CPY instructions? I'd very much
> like to use those for uaccess as well eventually but if they have the
> same imp def behaviour, I'd rather relax the documentation and continue
> to live with the current behaviour.

My understanding is that those have to be broken up into a set of smaller
accesses, and so the same applies, with the architectural window for clobbering
being the *entire* range from 'to' to 'to + size'

That said, the description of the forward-only instructions (CPYF*) suggests
those might have to be exact.

In ARM DDI 0487I.a, section C6.2.80 "CPYFPWT, CPYFMWT, CPYFEWT", it says:

> The memory copy performed by these instructions is in the forward direction
> only, so the instructions are suitable for a memory copy only where there is
> no overlap between the source and destination locations, or where the source
> address is greater than the destination address.

That *might* mean in practice that CPYF* instructions can't clobber later bytes
in dst in case they'll later be consumed as src bytes, but it doesn't strictly
say that (and maybe the core would figure out how much potential overlap there
is and tune the copy chunk size).

We could chase our architects on that.

> > The only architecturally guaranteed way to avoid this is to only use
> > aligned stores to write to user memory.	This patch rewrites
> > __arch_copy_to_user() to only access the user buffer with aligned
> > stores, such that the bytes written can always be determined reliably.
> 
> Can we not fall back to byte-at-a-time? There's still a potential race
> if the page becomes read-only for example. Well, probably not worth it
> if we decide to go this route.

I was trying to avoid that shape of race.

I also believe that if we have a misaligned store straddling two pages, and the
first page is faulting, it the store can do a partial write to the 2nd page,
which I suspected is not what we want (though maybe that's beningn, if we're
going to say that clobbering anywhere within the dst buffer is fine).

> Where we may notice some small performance degradation is copy_to_user()
> where the reads from the source end up unaligned due to the destination
> buffer alignment. I doubt that's a common case though and most CPUs can
> probably cope just well with this.

FWIW, I instrumented a kernel build workload, and the significant majority of
the time (IIRC by ~100x), both src and dst happened to be aligned to at least 8
bytes, so even if that were slow its the rare case. I guess that's because any
structures we copy are likely to contain a long or a pointer, and a bunch of
other copies are going to be bulk page copies into buffers which the allocator
has aligned to at least 8 bytes.

Thanks,
Mark.
