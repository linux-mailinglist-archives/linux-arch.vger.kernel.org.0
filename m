Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE56C4E79
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 15:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCVOud (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCVOuL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 10:50:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D74B65C6F;
        Wed, 22 Mar 2023 07:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBB20B81CE4;
        Wed, 22 Mar 2023 14:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94351C4339B;
        Wed, 22 Mar 2023 14:48:29 +0000 (UTC)
Date:   Wed, 22 Mar 2023 14:48:26 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, dave.hansen@linux.intel.com,
        davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        robin.murphy@arm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        will@kernel.org
Subject: Re: [PATCH v2 3/4] arm64: fix __raw_copy_to_user semantics
Message-ID: <ZBsVOu6ygLoGOI5d@arm.com>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
 <20230321122514.1743889-4-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321122514.1743889-4-mark.rutland@arm.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 21, 2023 at 12:25:13PM +0000, Mark Rutland wrote:
> For some combinations of sizes and alignments __{arch,raw}_copy_to_user
> will copy some bytes between (to + size - N) and (to + size), but will
> never modify bytes past (to + size).
> 
> This violates the documentation in <linux/uaccess.h>, which states:
> 
> > If raw_copy_{to,from}_user(to, from, size) returns N, size - N bytes
> > starting at to must become equal to the bytes fetched from the
> > corresponding area starting at from.  All data past to + size - N must
> > be left unmodified.
> 
> This can be demonstrated through testing, e.g.
> 
> |     # test_copy_to_user: EXPECTATION FAILED at lib/usercopy_kunit.c:287
> | post-destination bytes modified (dst_page[4082]=0x1, offset=4081, size=16, ret=15)
> | [FAILED] 16 byte copy
> 
> This happens because the __arch_copy_to_user() can make unaligned stores
> to the userspace buffer, and the ARM architecture permits (but does not
> require) that such unaligned stores write some bytes before raising a
> fault (per ARM DDI 0487I.a Section B2.2.1 and Section B2.7.1). The
> extable fixup handlers in __arch_copy_to_user() assume that any faulting
> store has failed entirely, and so under-report the number of bytes
> copied when an unaligned store writes some bytes before faulting.

I find the Arm ARM hard to parse (no surprise here). Do you happen to
know what the behavior is for the new CPY instructions? I'd very much
like to use those for uaccess as well eventually but if they have the
same imp def behaviour, I'd rather relax the documentation and continue
to live with the current behaviour.

> The only architecturally guaranteed way to avoid this is to only use
> aligned stores to write to user memory.	This patch rewrites
> __arch_copy_to_user() to only access the user buffer with aligned
> stores, such that the bytes written can always be determined reliably.

Can we not fall back to byte-at-a-time? There's still a potential race
if the page becomes read-only for example. Well, probably not worth it
if we decide to go this route.

Where we may notice some small performance degradation is copy_to_user()
where the reads from the source end up unaligned due to the destination
buffer alignment. I doubt that's a common case though and most CPUs can
probably cope just well with this.

-- 
Catalin
