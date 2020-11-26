Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0B2C554B
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 14:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390033AbgKZN2R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 08:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390030AbgKZN2R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 08:28:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D60C0613D4;
        Thu, 26 Nov 2020 05:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ari7OxjV4+Br2gS6ab2HYMH0icZaForhuiN0IThPPRE=; b=ZNRZ5ap4VyQbiLbNa1RUTGJwN5
        pR0gi5S50T2EEZPWjQfdgNR9UuBWj6ykPj8qNUMYU04BN4J3JnYaSre8Ic/lx0nh12yVbfwwof/rC
        gKhkpYICZMheAiORuQvHe3xlNt6r91V6ChC4GqnN/na/SmgBQJpV0HkiUubvvG6DcaFmvvQRy0bOz
        HbeaIHCFEzSbmLUOutek9CKHtdSPJ+pmvNZs1wNKu/0fQgwRQGRp7vaTdQU5r0PVNpbB76liiLBrI
        ozNke1HR4/CGq0eiV6ZLqwDlRnU04p26lsTwI08fJvp8rAfTT4b8e5ozvpD+KhRdgnFemuuBGHwaY
        gbS2ukCg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiHJL-0005zK-E4; Thu, 26 Nov 2020 13:27:47 +0000
Date:   Thu, 26 Nov 2020 13:27:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20201126132747.GS4327@casper.infradead.org>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.164675154@infradead.org>
 <20201126123458.GO4327@casper.infradead.org>
 <20201126124207.GM3040@hirez.programming.kicks-ass.net>
 <20201126125606.GR4327@casper.infradead.org>
 <20201126130619.GI2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130619.GI2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 26, 2020 at 02:06:19PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 26, 2020 at 12:56:06PM +0000, Matthew Wilcox wrote:
> > On Thu, Nov 26, 2020 at 01:42:07PM +0100, Peter Zijlstra wrote:
> > > +	pgdp = pgd_offset(mm, addr);
> > > +	pgd = READ_ONCE(*pgdp);
> > 
> > I forget how x86-32-PAE maps to Linux's PGD/P4D/PUD/PMD scheme, but
> > according to volume 3, section 4.4.2, PAE paging uses a 64-bit PDE, so
> > whether a PDE is a PGD or a PMD, we're only reading it with READ_ONCE
> > rather than the lockless-retry method used by ptep_get_lockless().
> > So it's potentially racy?  Do we need a pmdp_get_lockless() or
> > pgdp_get_lockless()?
> 
> Oh gawd... this isn't new here though, right? Current gup_fast also gets
> that wrong, if it is in deed wrong.
> 
> I suppose it's a race far more likely today, with THP and all, than it
> ever was back then.

Right, it's not new.  I wouldn't block this patchset for that fix.
Just want to get the problem on your radar ;-)  I just never reviewed
the gup fast codepath before, and this jumped out at me.
