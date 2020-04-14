Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC00B1A7F7F
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389714AbgDNOUX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389553AbgDNOUR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 10:20:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F77FC061A0C;
        Tue, 14 Apr 2020 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=EYElTyl0BVEuRZ/YZRIannaVxf8JX5ztw8CmNN6o67Y=; b=k+JvPfJhqpx47HmkCwXxr89xM+
        QyEgEaoxNBUTi8nN9/LWRxUHDwtUVhOo0YNyDJ5W6ei8rlBqmf525cLWD6KlLovGZg2abMLOSLsgC
        U8wk4m1tAXieGZyNr7Aa3+0vMExYQ7HvVRy/YckMT6FP7pWrU6cfoQLCwlyqQ8uaDQdRqKnYkRF85
        yQRnqEDKov4IQy+woIW66pkgx5WElp0Iqco0DozCF8IxXsxc8UanwYLiVg5+G2RGgAlOH8X2w+1TF
        7pxsmEI4fCJ4Q8lBBtsqArFRH/jddmGFkpD7092oVyFzilyURxd1GphdGrt2GGHGW+Ljlk6PVVYT3
        iSr755EQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOMQA-0000bu-TE; Tue, 14 Apr 2020 14:20:14 +0000
Date:   Tue, 14 Apr 2020 07:20:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <20200414142014.GO21484@bombadil.infradead.org>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
 <20200413134106.GN21484@bombadil.infradead.org>
 <36616218-1d3a-b18a-8fb8-4fc9eff22780@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36616218-1d3a-b18a-8fb8-4fc9eff22780@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 14, 2020 at 02:28:35PM +0200, Christophe Leroy wrote:
> Le 13/04/2020 à 15:41, Matthew Wilcox a écrit :
> > On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
> > > +static int vmap_pages_range_noflush(unsigned long start, unsigned long end,
> > > +				    pgprot_t prot, struct page **pages,
> > > +				    unsigned int page_shift)
> > > +{
> > > +	if (page_shift == PAGE_SIZE) {
> > 
> > ... I think you meant 'page_shift == PAGE_SHIFT'
> > 
> > Overall I like this series, although it's a bit biased towards CPUs
> > which have page sizes which match PMD/PUD sizes.  It doesn't offer the
> > possibility of using 64kB page sizes on ARM, for example.  But it's a
> > step in the right direction.
> 
> I was going to ask more or less the same question, I would have liked to use
> 512kB hugepages on powerpc 8xx.
> 
> Even the 8M hugepages (still on the 8xx), can they be used as well, taking
> into account that two PGD entries have to point to the same 8M page ?
> 
> I sent out a series which tends to make the management of 512k and 8M pages
> closer to what Linux expects, in order to use them inside kernel, for Linear
> mappings and Kasan mappings for the moment. See
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=164620
> It would be nice if we could amplify it a use it for ioremaps and vmallocs
> as well.

I haven't been looking at vmalloc at all; I've been looking at the page
cache.  See:
https://lore.kernel.org/linux-mm/20200212041845.25879-1-willy@infradead.org/

Once we have large pages in the page cache, I want to sort out the API
for asking the CPU to insert a TLB entry.  Right now, we use set_pte_at(),
set_pmd_at() and set_pud_at().  I'm thinking something along the lines of:

vm_fault_t vmf_set_page_at(struct vm_fault *vmf, struct page *page);

and the architecture can insert whatever PTEs and/or TLB entries it
likes based on compound_order(page) -- if, say, it's a 1MB page, it might
choose to insert 2 * 512kB entries, or just the upper or lower 512kB entry
(depending which half of the 1MB page the address sits in).

