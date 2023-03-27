Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1F96CA0F5
	for <lists+linux-arch@lfdr.de>; Mon, 27 Mar 2023 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjC0KMG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Mar 2023 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjC0KL5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2023 06:11:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDFE5BBE;
        Mon, 27 Mar 2023 03:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EDD3B81057;
        Mon, 27 Mar 2023 10:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840B3C433EF;
        Mon, 27 Mar 2023 10:11:43 +0000 (UTC)
Date:   Mon, 27 Mar 2023 11:11:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Mark Rutland' <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v2 1/4] lib: test copy_{to,from}_user()
Message-ID: <ZCFr3I36Te2D0ZuQ@arm.com>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
 <20230321122514.1743889-2-mark.rutland@arm.com>
 <ZBnk3O0QLs6+8KNN@arm.com>
 <ZBsLGTYjKoUTLrva@FVFF77S0Q05N>
 <f4d24e8024e84ec5a20ab17b6c2d7f60@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4d24e8024e84ec5a20ab17b6c2d7f60@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 23, 2023 at 10:16:12PM +0000, David Laight wrote:
> From: Mark Rutland
> > Sent: 22 March 2023 14:05
> ....
> > > IIUC, in such tests you only vary the destination offset. Our copy
> > > routines in general try to align the source and leave the destination
> > > unaligned for performance. It would be interesting to add some variation
> > > on the source offset as well to spot potential issues with that part of
> > > the memcpy routines.
> > 
> > I have that on my TODO list; I had intended to drop that into the
> > usercopy_params. The only problem is that the cross product of size,
> > src_offset, and dst_offset gets quite large.
> 
> I thought that is was better to align the writes and do misaligned reads.

We inherited the memcpy/memset routines from the optimised cortex
strings library (fine-tuned by the toolchain people for various Arm
microarchitectures). For some CPUs with less aggressive prefetching it's
probably marginally faster to align the reads instead of writes (as
multiple unaligned writes are usually combined in the write buffer
somewhere).

Also, IIRC for some small copies (less than 16 bytes), our routines
don't bother with any alignment at all.

> Although maybe copy_to/from_user() would be best aligning the user address
> (to avoid page faults part way through a misaligned access).

In theory only copy_to_user() needs the write aligned if we want strict
guarantees of what was written. For copy_from_user() we can work around
by falling back to a byte read.

> OTOH, on x86, is it even worth bothering at all.
> I have measured a performance drop for misaligned reads, but it
> was less than 1 clock per cache line in a test that was doing
> 2 misaligned reads in at least some of the clock cycles.
> I think the memory read path can do two AVX reads each clock.
> So doing two misaligned 64bit reads isn't stressing it.

I think that's what Mark found as well in his testing, though I'm sure
one can build a very specific benchmark that shows a small degradation.

-- 
Catalin
