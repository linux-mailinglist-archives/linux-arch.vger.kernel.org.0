Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D333663F38
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 12:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjAJL1k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 06:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjAJL1i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 06:27:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57464482B9;
        Tue, 10 Jan 2023 03:27:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 064784B3;
        Tue, 10 Jan 2023 03:28:19 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.46.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE6AE3F587;
        Tue, 10 Jan 2023 03:27:30 -0800 (PST)
Date:   Tue, 10 Jan 2023 11:27:28 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 08/12] s390: Replace cmpxchg_double() with
 cmpxchg128()
Message-ID: <Y71LoCIl+IFdy9D8@FVFF77S0Q05N>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.352918965@infradead.org>
 <Y70SWXHDmOc3RhMd@osiris>
 <Y70it59wuvsnKJK1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y70it59wuvsnKJK1@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 10, 2023 at 09:32:55AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 10, 2023 at 08:23:05AM +0100, Heiko Carstens wrote:
> 
> > So, Alexander Gordeev reported that this code was already prior to your
> > changes potentially broken with respect to missing READ_ONCE() within the
> > cmpxchg_double() loops.
> 
> Unless there's an early exit, that shouldn't matter. If you managed to
> read garbage the cmpxchg itself will simply fail and the loop retries.

I don't think that's true; without READ_ONCE() the compiler could (but is
very unlikely to) read multiple times, and that could cause problems.

For example:

| 	prev = *ptr;
| 
| 	do {
| 		new = some_function_of(prev);
| 		old = cmpxchg(ptr, prev, new);
| 	} while (old != prev);

Could effectively become:

| 	prev1 = *ptr;
|	prev2 = *ptr;
|
| 	do {
| 		new = some_function_of(prev1)
| 		old = cmpxchg(ptr, prev2, new);
| 	} while (old != prev2);

... which would effectively udpate from a stale value, throwing away prev2.
That and the two generated reads could be in either order.

So I do think it's warranted to use READ_ONCE() for the prev value feeding into
a cmpxchg operation, even if that's only for the "once" part rather than lack
of tearing.

Thanks,
Mark.
