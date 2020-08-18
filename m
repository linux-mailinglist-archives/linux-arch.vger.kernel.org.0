Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB722488B1
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHRPHp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 11:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRPHo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 11:07:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C262C061389;
        Tue, 18 Aug 2020 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TYCkUvvfwzERhSHuzl+o/xwRoFEE9UiQMu2LCKTxT2c=; b=rAKScTQoURfEN9R47mu2vwzvW1
        Qr92K5z88B2fMLXzcVaHIjsutHu31n+1t6NktU6dXrpb6qBvKGewRdDEu9YWxyaqPT3MGP2+amFeq
        030HybeiDQAp9K8oNMiWpdSSP2KjuUDNq6z3GwFS1zWlgIdpB/YsfFYankS6FDpHeKTdEQUybqx+Y
        WGyBZ4JzG9qSrcJJ5B1ZsacnV/Rsd2fIh9tQQ/re1f3qLvOpy3/D0PzzsiObpvCEz2QxnrYV91fdU
        rklPsQUsoTct720dBy8ejRuBWjm4jiJMHilAS7Xntlh81xlBZYvhwK858mixM81kNlULt4cBAKwWb
        WxUXdk+w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k83D6-00020t-48; Tue, 18 Aug 2020 15:07:36 +0000
Date:   Tue, 18 Aug 2020 16:07:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Flushing transparent hugepages
Message-ID: <20200818150736.GQ17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If your arch does not support HAVE_ARCH_TRANSPARENT_HUGEPAGE, you can
stop reading now.  Although maybe you're curious about adding support.

$ git grep -w HAVE_ARCH_TRANSPARENT_HUGEPAGE arch
arch/Kconfig:config HAVE_ARCH_TRANSPARENT_HUGEPAGE
arch/arc/Kconfig:config HAVE_ARCH_TRANSPARENT_HUGEPAGE
arch/arm/Kconfig:config HAVE_ARCH_TRANSPARENT_HUGEPAGE
arch/arm64/Kconfig:     select HAVE_ARCH_TRANSPARENT_HUGEPAGE
arch/mips/Kconfig:      select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES
arch/powerpc/platforms/Kconfig.cputype: select HAVE_ARCH_TRANSPARENT_HUGEPAGE
arch/s390/Kconfig:      select HAVE_ARCH_TRANSPARENT_HUGEPAGE
arch/sparc/Kconfig:     select HAVE_ARCH_TRANSPARENT_HUGEPAGE
arch/x86/Kconfig:       select HAVE_ARCH_TRANSPARENT_HUGEPAGE

If your arch does not implement flush_dcache_page(), you can also
stop reading.

$ for i in arc arm arm64 mips powerpc s390 sparc x86; do git grep -l flush_dcache_page arch/$i/include; done
arch/arc/include/asm/cacheflush.h
arch/arm/include/asm/cacheflush.h
arch/arm64/include/asm/cacheflush.h
arch/mips/include/asm/cacheflush.h
arch/powerpc/include/asm/cacheflush.h
arch/sparc/include/asm/cacheflush_32.h
arch/sparc/include/asm/cacheflush_64.h
arch/sparc/include/asm/pgtable_64.h

OK, so we're down to arc, arm, arm64, mips, powerpc & sparc.  Hi!  ;-)

I'm working on adding THP support for filesystems with storage backing
and part of that is expanding the definition of THP to be any order
(ie any power of two of PAGE_SIZE).  Now, shmem already has some calls
to flush_dcache_page() for THPs, for example:

        if (sgp != SGP_WRITE && !PageUptodate(page)) {
                struct page *head = compound_head(page);
                int i;

                for (i = 0; i < compound_nr(head); i++) {
                        clear_highpage(head + i);
                        flush_dcache_page(head + i);
                }
                SetPageUptodate(head);
        }

where you'll be called once for each subpage.  But ... these are error
paths, and I'm sure you all diligently test cache coherency scenarios
of error paths in shmem ... right?

For example, arm64 seems confused in this scenario:

void flush_dcache_page(struct page *page)
{
        if (test_bit(PG_dcache_clean, &page->flags))
                clear_bit(PG_dcache_clean, &page->flags);
}

...

void __sync_icache_dcache(pte_t pte)
{
        struct page *page = pte_page(pte);

        if (!test_and_set_bit(PG_dcache_clean, &page->flags))
                sync_icache_aliases(page_address(page), page_size(page));
}

So arm64 keeps track on a per-page basis which ones have been flushed.
page_size() will return PAGE_SIZE if called on a tail page or regular
page, but will return PAGE_SIZE << compound_order if called on a head
page.  So this will either over-flush, or it's missing the opportunity
to clear the bits on all the subpages which have now been flushed.

PowerPC has special handling of hugetlbfs pages.  Well, that's what
the config option says, but actually it handles THP as well.  If
the config option is enabled.

#ifdef CONFIG_HUGETLB_PAGE
        if (PageCompound(page)) {
                flush_dcache_icache_hugepage(page);
                return;
        }
#endif

By the way, THPs can be mapped askew -- that is, at an offset which
means you can't use a PMD to map a PMD sized page.

Anyway, we don't really have consensus between the various architectures
on how to handle either THPs or hugetlb pages.  It's not contemplated
in Documentation/core-api/cachetlb.rst so there's no real surprise
we've diverged.

What would you _like_ to see?  Would you rather flush_dcache_page()
were called once for each subpage, or would you rather maintain
the page-needs-flushing state once per compound page?  We could also
introduce flush_dcache_thp() if some architectures would prefer it one
way and one the other, although that brings into question what to do
for hugetlbfs pages.

It might not be a bad idea to centralise the handling of all this stuff
somewhere.  Sounds like the kind of thing Arnd would like to do ;-) I'll
settle for getting enough clear feedback about what the various arch
maintainers want that I can write a documentation update for cachetlb.rst.
