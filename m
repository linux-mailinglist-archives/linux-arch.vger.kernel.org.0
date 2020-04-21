Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28651B21B0
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 10:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgDUIbb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 04:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726095AbgDUIba (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 04:31:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EC9C061A0F;
        Tue, 21 Apr 2020 01:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LWzUg11zPqYY9Fyg7jCR9bLyFv2ID8h2iOjcGvqOrvw=; b=KwH4LQpWToP8SgZNDO1nU1fJfJ
        Ow4rb6srdDVVOkgPZm1z14z4Xt1E0rcrhtHFP4EW5kxORBY/nGN4CqS/b7CvTm+Ce/1whwT4Tuj0Q
        XfIPMzrB6K/QfepzKaN3Np5Ok/GD2ierD4Zoha9CLabrOsNlFIxIRblVXswq8ZKWDVU3w/a1nAmM0
        dp51d51+i6nvsxcX4N+uGMQQcKjwM0tPWpUQ079xggPVPR1lX9BqVZeqq9pEkvH9maoDUX7l8NjTG
        XP2H2AinuQUkx0wkbw2gxygya8KIYeH3Tjlpi5jKYd0B/tdqsLsNZ9ubAvTBANg5n3YeZDEKLpbfP
        FwEKgnaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQoIr-0000KX-6O; Tue, 21 Apr 2020 08:30:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22C7A306108;
        Tue, 21 Apr 2020 10:30:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E21502B9EA39A; Tue, 21 Apr 2020 10:30:43 +0200 (CEST)
Date:   Tue, 21 Apr 2020 10:30:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zhenyu Ye <yezhenyu2@huawei.com>, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, maz@kernel.org,
        suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com,
        Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org,
        guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com,
        prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com,
        kuhn.chenqun@huawei.com
Subject: Re: [PATCH v1 6/6] arm64: tlb: Set the TTL field in flush_tlb_range
Message-ID: <20200421083043.GP20730@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-7-yezhenyu2@huawei.com>
 <20200420121055.GF20696@hirez.programming.kicks-ass.net>
 <20200420200616.44c7c7ea@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420200616.44c7c7ea@oasis.local.home>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 20, 2020 at 08:06:16PM -0400, Steven Rostedt wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Apr 03, 2020 at 05:00:48PM +0800, Zhenyu Ye wrote:

> > > +static inline int tlb_get_level(struct mmu_gather *tlb)
> > > +{
> > > +	int sum = tlb->cleared_ptes + tlb->cleared_pmds +
> > > +		  tlb->cleared_puds + tlb->cleared_p4ds;
> > > +
> > > +	if (sum != 1)
> > > +		return 0;
> > > +	else if (tlb->cleared_ptes)
> > > +		return 3;
> > > +	else if (tlb->cleared_pmds)
> > > +		return 2;
> > > +	else if (tlb->cleared_puds)
> > > +		return 1;
> > > +
> > > +	return 0;
> > > +}  
> > 
> > That's some mighty wonky code. Please look at the generated asm.
> 
> Without even looking at the generated asm, if a condition returns,
> there's no reason to add an else for that condition.

Not really the point; he wants to guarantee he only returns >0 when
there's a single bit set. But the thing is, cleared_* is a bitfield, and
I'm afraid that the above will result in some terrible code-gen.

Maybe something like:

	if (tlb->cleared_ptes && !(tlb->cleared_pmds ||
				   tlb->cleared_puds ||
				   tlb->cleared_p4ds))
		return 3;

	if (tlb->cleared_pmds && !(tlb->cleared_ptes ||
				   tlb->cleared_puds ||
				   tlb->cleared_p4ds))
		return 2;

	if (tlb->cleared_puds && !(tlb->cleared_ptes ||
				   tlb->cleared_pmds ||
				   tlb->cleared_p4ds))
		return 1;

	return 0;

Which I admit is far too much typing, but I suspect it generates far
saner code (just a few masks and branches).

But maybe the compiler surprises us, what do I konw.


