Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A572C544B
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 13:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389604AbgKZM41 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 07:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388892AbgKZM41 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 07:56:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCBEC0613D4;
        Thu, 26 Nov 2020 04:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wzqquq5/8D9FV29EVrzwmTN0u25CnsZPxZTtTznyxuY=; b=kwtYBwhPT/xZPaiK1qJKZ2HGr7
        4quVpggBZGhRHOmciM0yyjUsYzXiVZmu3u3Pk0PSig7f3bnc2DnWNmqGhsEXLpcsUy8MqOLtxFiPq
        yemCSvOVi6L6aCTSF2KLJeKgK0w82yTmoe0CxCovoaDO5mvJy7nZ4nCW8E68MWCxGd2ei90UVJblp
        wjU+bSg380UGlOMpwS3X7MTXxRAqzF6205FfNpCb7yw6bDwdEkNv5ouvbb9HlNrYY5ea2yPOYigEc
        K+PjYbYftBbGrPwt+LbQsB5Y9gsJ1NFNEQ3pDT5Lwhzv5zJAgu57y3r7Y1Puc6/9zMPZ9dv+rxV/k
        q2rhtnRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGog-0003FD-PN; Thu, 26 Nov 2020 12:56:07 +0000
Date:   Thu, 26 Nov 2020 12:56:06 +0000
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
Message-ID: <20201126125606.GR4327@casper.infradead.org>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.164675154@infradead.org>
 <20201126123458.GO4327@casper.infradead.org>
 <20201126124207.GM3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126124207.GM3040@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 26, 2020 at 01:42:07PM +0100, Peter Zijlstra wrote:
> +	pgdp = pgd_offset(mm, addr);
> +	pgd = READ_ONCE(*pgdp);

I forget how x86-32-PAE maps to Linux's PGD/P4D/PUD/PMD scheme, but
according to volume 3, section 4.4.2, PAE paging uses a 64-bit PDE, so
whether a PDE is a PGD or a PMD, we're only reading it with READ_ONCE
rather than the lockless-retry method used by ptep_get_lockless().
So it's potentially racy?  Do we need a pmdp_get_lockless() or
pgdp_get_lockless()?

[...]
> +	pmdp = pmd_offset_lockless(pudp, pud, addr);
> +	pmd = READ_ONCE(*pmdp);
> +	if (!pmd_present(pmd))
>  		return 0;
>  
> +	if (pmd_leaf(pmd))
> +		return pmd_leaf_size(pmd);
>  
