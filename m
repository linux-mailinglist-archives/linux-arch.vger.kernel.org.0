Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37C72C5478
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 14:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbgKZNGj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 08:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389840AbgKZNGj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 08:06:39 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248B4C0613D4;
        Thu, 26 Nov 2020 05:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vWy2uVCVHBnrbbz4T9jkHvT2JpJLs0e2xYDM8OJOhBs=; b=Lw6hAfjPDtWO3vimDZtY1m8XyC
        00uoIq50O8sIFFWmkHIPvCzOm9l5Ak0REO4uPn/bffe1rzsVCMbeM3jyrYQNZf6K8oB5NNEtBUtZn
        PQExLFvY1UXCnvO6QhiAyTWvyn3HrOQQz14rnj+qNfezyNty8Yv5NX0piJYgDhWwWzGvxFRyge2UC
        Pmp40Y9h/xGuT8HHJTP4lPeN/8I773CmHi0WWFmfSwm0HbofpDYElV4OtNHOroG1p5qVFDBfnEwBP
        MxuKUj259aaEOTEAIR+i7RQApABVchScWdQWGMqxU0jp/tySoP79afuH5g/GVy+NAkj3TeQlJXYYD
        5kZhH14Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGyb-0007yR-O0; Thu, 26 Nov 2020 13:06:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C1D33059DE;
        Thu, 26 Nov 2020 14:06:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5BAD201E691E; Thu, 26 Nov 2020 14:06:19 +0100 (CET)
Date:   Thu, 26 Nov 2020 14:06:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 3/6] perf/core: Fix arch_perf_get_page_size()
Message-ID: <20201126130619.GI2414@hirez.programming.kicks-ass.net>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.164675154@infradead.org>
 <20201126123458.GO4327@casper.infradead.org>
 <20201126124207.GM3040@hirez.programming.kicks-ass.net>
 <20201126125606.GR4327@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126125606.GR4327@casper.infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 26, 2020 at 12:56:06PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 26, 2020 at 01:42:07PM +0100, Peter Zijlstra wrote:
> > +	pgdp = pgd_offset(mm, addr);
> > +	pgd = READ_ONCE(*pgdp);
> 
> I forget how x86-32-PAE maps to Linux's PGD/P4D/PUD/PMD scheme, but
> according to volume 3, section 4.4.2, PAE paging uses a 64-bit PDE, so
> whether a PDE is a PGD or a PMD, we're only reading it with READ_ONCE
> rather than the lockless-retry method used by ptep_get_lockless().
> So it's potentially racy?  Do we need a pmdp_get_lockless() or
> pgdp_get_lockless()?

Oh gawd... this isn't new here though, right? Current gup_fast also gets
that wrong, if it is in deed wrong.

I suppose it's a race far more likely today, with THP and all, than it
ever was back then.
