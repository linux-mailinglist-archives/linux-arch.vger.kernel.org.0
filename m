Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF7D688A06
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 23:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjBBWto (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 17:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjBBWtn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 17:49:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAA023C49
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 14:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gEnCsMGZWtlqcPCyr8s6lM1GgKbz0/ITK1xeZwSWEa4=; b=t7JTR+qpWMq+rzB8YgmIN+TBGT
        ArgbZFW4otUJ3OamJvwPQ4SUQAthL5rSjJN91cARwD3OE56PdmBkCTCvvTh4n8S37TY9ah5SDuFyL
        XKs5rQGIQo3mf+WzGG6ySgdSXSC+WjJlcCkNpcIhXd3yoio4a3BNh8cA9bBCcSE9E05FECAqDlAjd
        6zGvRHJm/WTWRGfFx9NWfLRpquxdLQzbJJKGRUKWcNGHGRgwNzREnevf07Q1Z+SGLo+C4sbE6JyNC
        o2KevTCN+cGISmKSV1qF9MReBoZOO55mGduHqd51c0U23GHQ3oPDD+idE/f1OeNnd7GVadWJiWU7f
        5NUR8SAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNiOg-00DnLD-Nt; Thu, 02 Feb 2023 22:49:38 +0000
Date:   Thu, 2 Feb 2023 22:49:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-arch@vger.kernel.org, Yin Fengwei <fengwei.yin@intel.com>,
        linux-mm@kvack.org
Subject: Re: API for setting multiple PTEs at once
Message-ID: <Y9w+AppNv+i1o/o3@casper.infradead.org>
References: <Y9wnr8SGfGGbi/bk@casper.infradead.org>
 <20230202214858.btrzrcevzxjfk6wg@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202214858.btrzrcevzxjfk6wg@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 03, 2023 at 12:48:58AM +0300, Kirill A. Shutemov wrote:
> On Thu, Feb 02, 2023 at 09:14:23PM +0000, Matthew Wilcox wrote:
> > For those of you not subscribed, linux-mm is currently discussing
> > how best to handle page faults on large folios.  I simply made it work
> > when adding large folio support.  Now Yin Fengwei is working on
> > making it fast.
> > 
> > https://lore.kernel.org/linux-mm/Y9qjn0Y+1ir787nc@casper.infradead.org/
> > is perhaps the best place to start as it pertains to what the
> > architecture will see.
> > 
> > At the bottom of that function, I propose
> > 
> > +       for (i = 0; i < nr; i++) {
> > +               set_pte_at(vma->vm_mm, addr, vmf->pte + i, entry);
> > +               /* no need to invalidate: a not-present page won't be cached */
> > +               update_mmu_cache(vma, addr, vmf->pte + i);
> > +               addr += PAGE_SIZE;
> > +		entry = pte_next(entry);
> > +	}
> > 
> > (or I would have, had I not forgotten that pte_t isn't an integral type)
> > 
> > But I think that some architectures want to mark PTEs specially for
> > "This is part of a contiguous range" -- ARM, perhaps?  So would you like
> > an API like:
> > 
> > 	arch_set_ptes(mm, addr, vmf->pte, entry, nr);
> 
> Maybe just set_ptes(). arch_ doesn't contribute much.

Sure.

> > 	update_mmu_cache_range(vma, addr, vmf->pte, nr);
> > 
> > There are some challenges here.  For example, folios may be mapped
> > askew (ie not naturally aligned).  Another problem is that folios may
> > be unmapped in part (eg mmap(), fault, followed by munmap() of one of
> > the pages in the folio), and I presume you'd need to go and unmark the
> > other PTEs in that case.  So it's not as simple as just checking whether
> > 'addr' and 'nr' are in some way compatible.
> 
> I think the key question is who is responsible for 'nr' being safe. Like
> is it caller or set_ptes() need to check that it belong to the same PTE
> page table, folio, VMA, etc.
> 
> I think it has to be done by caller and set_pte() has to be as simple as
> possible.

Caller guarantees that 'nr' is bounded by all of (vma, PMD table, folio).

We don't currently allocate folios larger than PMD size, but perhaps we
should prepare for that and as part of this same exercise define

	set_pmds(mm, addr, vmf->pmd, entry, nr);

... where 'nr' is the number of PMDs to set, not number of pages.
