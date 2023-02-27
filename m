Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B36A4C26
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 21:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjB0UVD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 15:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB0UVD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 15:21:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462E11C7F9;
        Mon, 27 Feb 2023 12:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=E2dr+WPpewMczIAEoyECoMJTwHYh5rKSEujDBRqJLXg=; b=aQLtru7wx3Rr1O2V6XdQGckFOV
        FEnrPvzQq6NPqHH+iZb8rzJt0MFOpAWePYj6L8bbRB7GJ/Ss9qB9h9ss6jV1Njq3eYkZQuYkiEmkY
        4shbZlYVaaTpj6vTmOzbst4gBNSVGiERp2sPSTIVVd6AURmtNCNWOgS9uql3L/Qxel+4AFVmviEbR
        1gYgTS37g/3ome8G0h7JOqiz8uVezekbra8rJNsr7NEsvC+b2No2vsuWe9L5/P+hsWiyFuEDsa+GN
        ChcZiykhQk3DB7lzWa/4Dl62d8Jpb/j9xBFckTBK0e6UB0BLoiz8ChAn5sGU1MG/CaKRgt+fYDVJW
        DsO2dlUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWjzU-000NS1-2d; Mon, 27 Feb 2023 20:20:56 +0000
Date:   Mon, 27 Feb 2023 20:20:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 18/30] powerpc: Implement the new page table range API
Message-ID: <Y/0QqO10jK55zHO0@casper.infradead.org>
References: <20230227175741.71216-1-willy@infradead.org>
 <20230227175741.71216-19-willy@infradead.org>
 <ee864b97-90e6-4535-4db3-2659a2250afd@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee864b97-90e6-4535-4db3-2659a2250afd@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 07:45:08PM +0000, Christophe Leroy wrote:
> Hi,
> 
> Le 27/02/2023 à 18:57, Matthew Wilcox (Oracle) a écrit :
> > Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> > Change the PG_arch_1 (aka PG_dcache_dirty) flag from being per-page to
> > per-folio.
> > 
> > I'm unsure about my merging of flush_dcache_icache_hugepage() and
> > flush_dcache_icache_page() into flush_dcache_icache_folio() and subsequent
> > removal of flush_dcache_icache_phys().  Please review.
> 
> Not sure why you want to remove flush_dcache_icache_phys().

Well, I didn't, necessarily.  It's just that when I merged
flush_dcache_icache_hugepage() and flush_dcache_icache_page()
together, it was left with no callers.

> Allthough that's only feasible when address bus is not wider than 32 
> bits and cannot be done on BOOKE as you can't switch off MMU on BOOKE, 
> flush_dcache_icache_phys() allows to flush not mapped pages without 
> having to map them. So it is more efficient.

And it was just never done for the hugepage case?

> > @@ -148,17 +103,20 @@ static void __flush_dcache_icache(void *p)
> >   	invalidate_icache_range(addr, addr + PAGE_SIZE);
> >   }
> >   
> > -static void flush_dcache_icache_hugepage(struct page *page)
> > +void flush_dcache_icache_folio(struct folio *folio)
> >   {
> > -	int i;
> > -	int nr = compound_nr(page);
> > +	unsigned int i, nr = folio_nr_pages(folio);
> >   
> > -	if (!PageHighMem(page)) {
> > +	if (flush_coherent_icache())
> > +		return;
> > +
> > +	if (!folio_test_highmem(folio)) {
> > +		void *addr = folio_address(folio);
> >   		for (i = 0; i < nr; i++)
> > -			__flush_dcache_icache(lowmem_page_address(page + i));
> > +			__flush_dcache_icache(addr + i * PAGE_SIZE);
> >   	} else {
> >   		for (i = 0; i < nr; i++) {
> > -			void *start = kmap_local_page(page + i);
> > +			void *start = kmap_local_folio(folio, i * PAGE_SIZE);
> >   
> >   			__flush_dcache_icache(start);
> >   			kunmap_local(start);

So you'd like this to be:

	} else if (IS_ENABLED(CONFIG_BOOKE) || sizeof(phys_addr_t) > sizeof(void *)) {
		for (i = 0; i < nr; i++) {
			 void *start = kmap_local_folio(folio, i * PAGE_SIZE);
			 __flush_dcache_icache(start);
			 kunmap_local(start);
		}
	} else {
		unsigned long pfn = folio_pfn(folio);
		for (i = 0; i < nr; i++)
			flush_dcache_icache_phys((pfn + i) * PAGE_SIZE;
	}

(or maybe you'd prefer a flush_dcache_icache_pfn() that doesn't need to
worry about PAGE_MASK).

> > @@ -166,27 +124,6 @@ static void flush_dcache_icache_hugepage(struct page *page)
> >   	}
> >   }
> >   
> > -void flush_dcache_icache_page(struct page *page)
> > -{
> > -	if (flush_coherent_icache())
> > -		return;
> > -
> > -	if (PageCompound(page))
> > -		return flush_dcache_icache_hugepage(page);
> > -
> > -	if (!PageHighMem(page)) {
> > -		__flush_dcache_icache(lowmem_page_address(page));
> > -	} else if (IS_ENABLED(CONFIG_BOOKE) || sizeof(phys_addr_t) > sizeof(void *)) {
> > -		void *start = kmap_local_page(page);
> > -
> > -		__flush_dcache_icache(start);
> > -		kunmap_local(start);
> > -	} else {
> > -		flush_dcache_icache_phys(page_to_phys(page));
> > -	}
> > -}
> > -EXPORT_SYMBOL(flush_dcache_icache_page);
> > -
> >   void clear_user_page(void *page, unsigned long vaddr, struct page *pg)
> >   {
> >   	clear_page(page);
> > diff --git a/arch/powerpc/mm/nohash/e500_hugetlbpage.c b/arch/powerpc/mm/nohash/e500_hugetlbpage.c
> > index 58c8d9849cb1..f3cb91107a47 100644
> > --- a/arch/powerpc/mm/nohash/e500_hugetlbpage.c
> > +++ b/arch/powerpc/mm/nohash/e500_hugetlbpage.c
> > @@ -178,7 +178,8 @@ book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea, pte_t pte)
> >    *
> >    * This must always be called with the pte lock held.
> >    */
> > -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
> > +void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
> > +		pte_t *ptep, unsigned int nr)
> >   {
> >   	if (is_vm_hugetlb_page(vma))
> >   		book3e_hugetlb_preload(vma, address, *ptep);
> > diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> > index cb2dcdb18f8e..b3c7b874a7a2 100644
> > --- a/arch/powerpc/mm/pgtable.c
> > +++ b/arch/powerpc/mm/pgtable.c
> > @@ -58,7 +58,7 @@ static inline int pte_looks_normal(pte_t pte)
> >   	return 0;
> >   }
> >   
> > -static struct page *maybe_pte_to_page(pte_t pte)
> > +static struct folio *maybe_pte_to_folio(pte_t pte)
> >   {
> >   	unsigned long pfn = pte_pfn(pte);
> >   	struct page *page;
> > @@ -68,7 +68,7 @@ static struct page *maybe_pte_to_page(pte_t pte)
> >   	page = pfn_to_page(pfn);
> >   	if (PageReserved(page))
> >   		return NULL;
> > -	return page;
> > +	return page_folio(page);
> >   }
> >   
> >   #ifdef CONFIG_PPC_BOOK3S
> > @@ -84,12 +84,12 @@ static pte_t set_pte_filter_hash(pte_t pte)
> >   	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
> >   	if (pte_looks_normal(pte) && !(cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
> >   				       cpu_has_feature(CPU_FTR_NOEXECUTE))) {
> > -		struct page *pg = maybe_pte_to_page(pte);
> > -		if (!pg)
> > +		struct folio *folio = maybe_pte_to_folio(pte);
> > +		if (!folio)
> >   			return pte;
> > -		if (!test_bit(PG_dcache_clean, &pg->flags)) {
> > -			flush_dcache_icache_page(pg);
> > -			set_bit(PG_dcache_clean, &pg->flags);
> > +		if (!test_bit(PG_dcache_clean, &folio->flags)) {
> > +			flush_dcache_icache_folio(folio);
> > +			set_bit(PG_dcache_clean, &folio->flags);
> >   		}
> >   	}
> >   	return pte;
> > @@ -107,7 +107,7 @@ static pte_t set_pte_filter_hash(pte_t pte) { return pte; }
> >    */
> >   static inline pte_t set_pte_filter(pte_t pte)
> >   {
> > -	struct page *pg;
> > +	struct folio *folio;
> >   
> >   	if (radix_enabled())
> >   		return pte;
> > @@ -120,18 +120,18 @@ static inline pte_t set_pte_filter(pte_t pte)
> >   		return pte;
> >   
> >   	/* If you set _PAGE_EXEC on weird pages you're on your own */
> > -	pg = maybe_pte_to_page(pte);
> > -	if (unlikely(!pg))
> > +	folio = maybe_pte_to_folio(pte);
> > +	if (unlikely(!folio))
> >   		return pte;
> >   
> >   	/* If the page clean, we move on */
> > -	if (test_bit(PG_dcache_clean, &pg->flags))
> > +	if (test_bit(PG_dcache_clean, &folio->flags))
> >   		return pte;
> >   
> >   	/* If it's an exec fault, we flush the cache and make it clean */
> >   	if (is_exec_fault()) {
> > -		flush_dcache_icache_page(pg);
> > -		set_bit(PG_dcache_clean, &pg->flags);
> > +		flush_dcache_icache_folio(folio);
> > +		set_bit(PG_dcache_clean, &folio->flags);
> >   		return pte;
> >   	}
> >   
> > @@ -142,7 +142,7 @@ static inline pte_t set_pte_filter(pte_t pte)
> >   static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
> >   				     int dirty)
> >   {
> > -	struct page *pg;
> > +	struct folio *folio;
> >   
> >   	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64))
> >   		return pte;
> > @@ -168,17 +168,17 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
> >   #endif /* CONFIG_DEBUG_VM */
> >   
> >   	/* If you set _PAGE_EXEC on weird pages you're on your own */
> > -	pg = maybe_pte_to_page(pte);
> > -	if (unlikely(!pg))
> > +	folio = maybe_pte_to_folio(pte);
> > +	if (unlikely(!folio))
> >   		goto bail;
> >   
> >   	/* If the page is already clean, we move on */
> > -	if (test_bit(PG_dcache_clean, &pg->flags))
> > +	if (test_bit(PG_dcache_clean, &folio->flags))
> >   		goto bail;
> >   
> >   	/* Clean the page and set PG_dcache_clean */
> > -	flush_dcache_icache_page(pg);
> > -	set_bit(PG_dcache_clean, &pg->flags);
> > +	flush_dcache_icache_folio(folio);
> > +	set_bit(PG_dcache_clean, &folio->flags);
> >   
> >    bail:
> >   	return pte_mkexec(pte);
> > @@ -187,8 +187,8 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
> >   /*
> >    * set_pte stores a linux PTE into the linux page table.
> >    */
> > -void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> > -		pte_t pte)
> > +void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> > +		pte_t pte, unsigned int nr)
> >   {
> >   	/*
> >   	 * Make sure hardware valid bit is not set. We don't do
> > @@ -203,7 +203,14 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> >   	pte = set_pte_filter(pte);
> >   
> >   	/* Perform the setting of the PTE */
> > -	__set_pte_at(mm, addr, ptep, pte, 0);
> > +	for (;;) {
> > +		__set_pte_at(mm, addr, ptep, pte, 0);
> > +		if (--nr == 0)
> > +			break;
> > +		ptep++;
> > +		pte = __pte(pte_val(pte) + PAGE_SIZE);
> > +		addr += PAGE_SIZE;
> > +	}
> >   }
> >   
> >   void unmap_kernel_page(unsigned long va)
