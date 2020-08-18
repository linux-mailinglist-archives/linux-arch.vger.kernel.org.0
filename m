Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A96248B1F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHRQI3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 12:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgHRQIY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Aug 2020 12:08:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828A3207D3;
        Tue, 18 Aug 2020 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597766904;
        bh=0XDiFtoCzEGx2zRl6dr6v/7GtRSHYOaTcxUyoIADvEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqiPJIVx7P1uKny20654FpTQ1dYQDn2N/LYxgmIJfdgyKpNsD3aY2gjM4XLa0YPMo
         EI8QqOK433KMw0XDi1/BZ2Bj+z7UslW4eJYBYSkfJ0RbYxl2t+S9qWJMCAcu53o7OY
         +6MDIROG5nLysgpO550aaHXqu7TGh1kjzeMo/3vg=
Date:   Tue, 18 Aug 2020 17:08:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Flushing transparent hugepages
Message-ID: <20200818160815.GA16191@willie-the-truck>
References: <20200818150736.GQ17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818150736.GQ17456@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 18, 2020 at 04:07:36PM +0100, Matthew Wilcox wrote:
> For example, arm64 seems confused in this scenario:
> 
> void flush_dcache_page(struct page *page)
> {
>         if (test_bit(PG_dcache_clean, &page->flags))
>                 clear_bit(PG_dcache_clean, &page->flags);
> }
> 
> ...
> 
> void __sync_icache_dcache(pte_t pte)
> {
>         struct page *page = pte_page(pte);
> 
>         if (!test_and_set_bit(PG_dcache_clean, &page->flags))
>                 sync_icache_aliases(page_address(page), page_size(page));
> }
> 
> So arm64 keeps track on a per-page basis which ones have been flushed.
> page_size() will return PAGE_SIZE if called on a tail page or regular
> page, but will return PAGE_SIZE << compound_order if called on a head
> page.  So this will either over-flush, or it's missing the opportunity
> to clear the bits on all the subpages which have now been flushed.

Hmm, that seems to go all the way back to 2014 as the result of a bug fix
in 923b8f5044da ("arm64: mm: Make icache synchronisation logic huge page
aware") which has a Reported-by Mark and a CC stable, suggesting something
_was_ going wrong at the time :/ Was there a point where the tail pages
could end up with PG_arch_1 uncleared on allocation?

> What would you _like_ to see?  Would you rather flush_dcache_page()
> were called once for each subpage, or would you rather maintain
> the page-needs-flushing state once per compound page?  We could also
> introduce flush_dcache_thp() if some architectures would prefer it one
> way and one the other, although that brings into question what to do
> for hugetlbfs pages.

For arm64, we'd like to see PG_arch_1 preserved during huge page splitting
[1], but there was a worry that it might break x86 and s390. It's also not
clear to me that we can change __sync_icache_dcache() as it's called when
we're installing the entry in the page-table, so why would it be called
again for the tail pages?

Will

[1] https://lore.kernel.org/linux-arch/20200703153718.16973-8-catalin.marinas@arm.com/
