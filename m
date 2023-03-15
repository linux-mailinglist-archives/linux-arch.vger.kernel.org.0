Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6D56BAD23
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjCOKKs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjCOKKV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F6C5F535;
        Wed, 15 Mar 2023 03:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 590E961BD2;
        Wed, 15 Mar 2023 10:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510E4C433EF;
        Wed, 15 Mar 2023 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678874999;
        bh=j/F1jTT0xpH0p51trZmdAMJLTWkcUmTaOZtOcHA7nhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwtpHJG8IqvzpPZtOVgQWfVfR+fJYIupM4q63vFGSk7Wr+xLmDxcZpHr9wTEvcjTL
         YkHafSOLwbj5uogQZIPycOatnvtR3w+tENjopSyhyY5j3vZvKlmnqRdIYUlTqkhG3e
         WathY5jN3g+DxiAFbFSscOyxiFX8HszxYKJdQaIMtXOpj1DcxR8eDU7JRdUzh3nYYd
         kXacFahQOjDWurEcixhLUvUyPdJ9cIp6lGs8IKvDdUjV3PGDLGsS0nC5M26e2aFtH0
         yAdbzoxCze8SgVDgA6XPJl9MOdBwd+18P5MwyfV2mwu5lBmwTOWrAPmkaEedNg8qXj
         +FL8enZ9kdvCg==
Date:   Wed, 15 Mar 2023 12:09:47 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 20/36] powerpc: Implement the new page table range API
Message-ID: <ZBGZa08KX3pIuAXt@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-21-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:28AM +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> Change the PG_arch_1 (aka PG_dcache_dirty) flag from being per-page to
> per-folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/powerpc/include/asm/book3s/pgtable.h | 10 +----
>  arch/powerpc/include/asm/cacheflush.h     | 14 +++++--
>  arch/powerpc/include/asm/kvm_ppc.h        | 10 ++---
>  arch/powerpc/include/asm/nohash/pgtable.h | 13 ++----
>  arch/powerpc/include/asm/pgtable.h        |  6 +++
>  arch/powerpc/mm/book3s64/hash_utils.c     | 11 ++---
>  arch/powerpc/mm/cacheflush.c              | 40 ++++++------------
>  arch/powerpc/mm/nohash/e500_hugetlbpage.c |  3 +-
>  arch/powerpc/mm/pgtable.c                 | 51 +++++++++++++----------
>  9 files changed, 77 insertions(+), 81 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
> index d18b748ea3ae..c2ef811505b0 100644
> --- a/arch/powerpc/include/asm/book3s/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/pgtable.h
> @@ -9,13 +9,6 @@
>  #endif
>  
>  #ifndef __ASSEMBLY__
> -/* Insert a PTE, top-level function is out of line. It uses an inline
> - * low level function in the respective pgtable-* files
> - */
> -extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> -		       pte_t pte);
> -
> -
>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>  extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>  				 pte_t *ptep, pte_t entry, int dirty);
> @@ -36,7 +29,8 @@ void __update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t
>   * corresponding HPTE into the hash table ahead of time, instead of
>   * waiting for the inevitable extra hash-table miss exception.
>   */
> -static inline void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
> +		unsigned long address, pte_t *ptep, unsigned int nr)
>  {
>  	if (IS_ENABLED(CONFIG_PPC32) && !mmu_has_feature(MMU_FTR_HPTE_TABLE))
>  		return;
> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
> index 7564dd4fd12b..ef7d2de33b89 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -35,13 +35,19 @@ static inline void flush_cache_vmap(unsigned long start, unsigned long end)
>   * It just marks the page as not i-cache clean.  We do the i-cache
>   * flush later when the page is given to a user process, if necessary.
>   */
> -static inline void flush_dcache_page(struct page *page)
> +static inline void flush_dcache_folio(struct folio *folio)
>  {
>  	if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
>  		return;
>  	/* avoid an atomic op if possible */
> -	if (test_bit(PG_dcache_clean, &page->flags))
> -		clear_bit(PG_dcache_clean, &page->flags);
> +	if (test_bit(PG_dcache_clean, &folio->flags))
> +		clear_bit(PG_dcache_clean, &folio->flags);
> +}
> +#define flush_dcache_folio flush_dcache_folio
> +
> +static inline void flush_dcache_page(struct page *page)
> +{
> +	flush_dcache_folio(page_folio(page));
>  }
>  
>  void flush_icache_range(unsigned long start, unsigned long stop);
> @@ -51,7 +57,7 @@ void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
>  		unsigned long addr, int len);
>  #define flush_icache_user_page flush_icache_user_page
>  
> -void flush_dcache_icache_page(struct page *page);
> +void flush_dcache_icache_folio(struct folio *folio);
>  
>  /**
>   * flush_dcache_range(): Write any modified data cache blocks out to memory and
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 6bef23d6d0e3..e91dd8e88bb7 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -868,7 +868,7 @@ void kvmppc_init_lpid(unsigned long nr_lpids);
>  
>  static inline void kvmppc_mmu_flush_icache(kvm_pfn_t pfn)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  	/*
>  	 * We can only access pages that the kernel maps
>  	 * as memory. Bail out for unmapped ones.
> @@ -877,10 +877,10 @@ static inline void kvmppc_mmu_flush_icache(kvm_pfn_t pfn)
>  		return;
>  
>  	/* Clear i-cache for new pages */
> -	page = pfn_to_page(pfn);
> -	if (!test_bit(PG_dcache_clean, &page->flags)) {
> -		flush_dcache_icache_page(page);
> -		set_bit(PG_dcache_clean, &page->flags);
> +	folio = page_folio(pfn_to_page(pfn));
> +	if (!test_bit(PG_dcache_clean, &folio->flags)) {
> +		flush_dcache_icache_folio(folio);
> +		set_bit(PG_dcache_clean, &folio->flags);
>  	}
>  }
>  
> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
> index a6caaaab6f92..69a7dd47a9f0 100644
> --- a/arch/powerpc/include/asm/nohash/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
> @@ -166,12 +166,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  	return __pte(pte_val(pte) & ~_PAGE_SWP_EXCLUSIVE);
>  }
>  
> -/* Insert a PTE, top-level function is out of line. It uses an inline
> - * low level function in the respective pgtable-* files
> - */
> -extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> -		       pte_t pte);
> -
>  /* This low level function performs the actual PTE insertion
>   * Setting the PTE depends on the MMU type and other factors. It's
>   * an horrible mess that I'm not going to try to clean up now but
> @@ -282,10 +276,11 @@ static inline int pud_huge(pud_t pud)
>   * for the page which has just been mapped in.
>   */
>  #if defined(CONFIG_PPC_E500) && defined(CONFIG_HUGETLB_PAGE)
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep);
> +void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
> +		pte_t *ptep, unsigned int nr);
>  #else
> -static inline
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep) {}
> +static inline void update_mmu_cache(struct vm_area_struct *vma,
> +		unsigned long address, pte_t *ptep, unsigned int nr) {}
>  #endif
>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 9972626ddaf6..656ecf2b10cd 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -41,6 +41,12 @@ struct mm_struct;
>  
>  #ifndef __ASSEMBLY__
>  
> +void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> +		pte_t pte, unsigned int nr);
> +#define set_ptes set_ptes
> +#define update_mmu_cache(vma, addr, ptep) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
> +
>  #ifndef MAX_PTRS_PER_PGD
>  #define MAX_PTRS_PER_PGD PTRS_PER_PGD
>  #endif
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> index fedffe3ae136..ad2afa08e62e 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -1307,18 +1307,19 @@ void hash__early_init_mmu_secondary(void)
>   */
>  unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  
>  	if (!pfn_valid(pte_pfn(pte)))
>  		return pp;
>  
> -	page = pte_page(pte);
> +	folio = page_folio(pte_page(pte));
>  
>  	/* page is dirty */
> -	if (!test_bit(PG_dcache_clean, &page->flags) && !PageReserved(page)) {
> +	if (!test_bit(PG_dcache_clean, &folio->flags) &&
> +	    !folio_test_reserved(folio)) {
>  		if (trap == INTERRUPT_INST_STORAGE) {
> -			flush_dcache_icache_page(page);
> -			set_bit(PG_dcache_clean, &page->flags);
> +			flush_dcache_icache_folio(folio);
> +			set_bit(PG_dcache_clean, &folio->flags);
>  		} else
>  			pp |= HPTE_R_N;
>  	}
> diff --git a/arch/powerpc/mm/cacheflush.c b/arch/powerpc/mm/cacheflush.c
> index 0e9b4879c0f9..8760d2223abe 100644
> --- a/arch/powerpc/mm/cacheflush.c
> +++ b/arch/powerpc/mm/cacheflush.c
> @@ -148,44 +148,30 @@ static void __flush_dcache_icache(void *p)
>  	invalidate_icache_range(addr, addr + PAGE_SIZE);
>  }
>  
> -static void flush_dcache_icache_hugepage(struct page *page)
> +void flush_dcache_icache_folio(struct folio *folio)
>  {
> -	int i;
> -	int nr = compound_nr(page);
> +	unsigned int i, nr = folio_nr_pages(folio);
>  
> -	if (!PageHighMem(page)) {
> +	if (flush_coherent_icache())
> +		return;
> +
> +	if (!folio_test_highmem(folio)) {
> +		void *addr = folio_address(folio);
>  		for (i = 0; i < nr; i++)
> -			__flush_dcache_icache(lowmem_page_address(page + i));
> -	} else {
> +			__flush_dcache_icache(addr + i * PAGE_SIZE);
> +	} else if (IS_ENABLED(CONFIG_BOOKE) || sizeof(phys_addr_t) > sizeof(void *)) {
>  		for (i = 0; i < nr; i++) {
> -			void *start = kmap_local_page(page + i);
> +			void *start = kmap_local_folio(folio, i * PAGE_SIZE);
>  
>  			__flush_dcache_icache(start);
>  			kunmap_local(start);
>  		}
> -	}
> -}
> -
> -void flush_dcache_icache_page(struct page *page)
> -{
> -	if (flush_coherent_icache())
> -		return;
> -
> -	if (PageCompound(page))
> -		return flush_dcache_icache_hugepage(page);
> -
> -	if (!PageHighMem(page)) {
> -		__flush_dcache_icache(lowmem_page_address(page));
> -	} else if (IS_ENABLED(CONFIG_BOOKE) || sizeof(phys_addr_t) > sizeof(void *)) {
> -		void *start = kmap_local_page(page);
> -
> -		__flush_dcache_icache(start);
> -		kunmap_local(start);
>  	} else {
> -		flush_dcache_icache_phys(page_to_phys(page));
> +		unsigned long pfn = folio_pfn(folio);
> +		for (i = 0; i < nr; i++)
> +			flush_dcache_icache_phys((pfn + i) * PAGE_SIZE);
>  	}
>  }
> -EXPORT_SYMBOL(flush_dcache_icache_page);
>  
>  void clear_user_page(void *page, unsigned long vaddr, struct page *pg)
>  {
> diff --git a/arch/powerpc/mm/nohash/e500_hugetlbpage.c b/arch/powerpc/mm/nohash/e500_hugetlbpage.c
> index 58c8d9849cb1..f3cb91107a47 100644
> --- a/arch/powerpc/mm/nohash/e500_hugetlbpage.c
> +++ b/arch/powerpc/mm/nohash/e500_hugetlbpage.c
> @@ -178,7 +178,8 @@ book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea, pte_t pte)
>   *
>   * This must always be called with the pte lock held.
>   */
> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
> +void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
> +		pte_t *ptep, unsigned int nr)
>  {
>  	if (is_vm_hugetlb_page(vma))
>  		book3e_hugetlb_preload(vma, address, *ptep);
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index cb2dcdb18f8e..b3c7b874a7a2 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -58,7 +58,7 @@ static inline int pte_looks_normal(pte_t pte)
>  	return 0;
>  }
>  
> -static struct page *maybe_pte_to_page(pte_t pte)
> +static struct folio *maybe_pte_to_folio(pte_t pte)
>  {
>  	unsigned long pfn = pte_pfn(pte);
>  	struct page *page;
> @@ -68,7 +68,7 @@ static struct page *maybe_pte_to_page(pte_t pte)
>  	page = pfn_to_page(pfn);
>  	if (PageReserved(page))
>  		return NULL;
> -	return page;
> +	return page_folio(page);
>  }
>  
>  #ifdef CONFIG_PPC_BOOK3S
> @@ -84,12 +84,12 @@ static pte_t set_pte_filter_hash(pte_t pte)
>  	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
>  	if (pte_looks_normal(pte) && !(cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
>  				       cpu_has_feature(CPU_FTR_NOEXECUTE))) {
> -		struct page *pg = maybe_pte_to_page(pte);
> -		if (!pg)
> +		struct folio *folio = maybe_pte_to_folio(pte);
> +		if (!folio)
>  			return pte;
> -		if (!test_bit(PG_dcache_clean, &pg->flags)) {
> -			flush_dcache_icache_page(pg);
> -			set_bit(PG_dcache_clean, &pg->flags);
> +		if (!test_bit(PG_dcache_clean, &folio->flags)) {
> +			flush_dcache_icache_folio(folio);
> +			set_bit(PG_dcache_clean, &folio->flags);
>  		}
>  	}
>  	return pte;
> @@ -107,7 +107,7 @@ static pte_t set_pte_filter_hash(pte_t pte) { return pte; }
>   */
>  static inline pte_t set_pte_filter(pte_t pte)
>  {
> -	struct page *pg;
> +	struct folio *folio;
>  
>  	if (radix_enabled())
>  		return pte;
> @@ -120,18 +120,18 @@ static inline pte_t set_pte_filter(pte_t pte)
>  		return pte;
>  
>  	/* If you set _PAGE_EXEC on weird pages you're on your own */
> -	pg = maybe_pte_to_page(pte);
> -	if (unlikely(!pg))
> +	folio = maybe_pte_to_folio(pte);
> +	if (unlikely(!folio))
>  		return pte;
>  
>  	/* If the page clean, we move on */
> -	if (test_bit(PG_dcache_clean, &pg->flags))
> +	if (test_bit(PG_dcache_clean, &folio->flags))
>  		return pte;
>  
>  	/* If it's an exec fault, we flush the cache and make it clean */
>  	if (is_exec_fault()) {
> -		flush_dcache_icache_page(pg);
> -		set_bit(PG_dcache_clean, &pg->flags);
> +		flush_dcache_icache_folio(folio);
> +		set_bit(PG_dcache_clean, &folio->flags);
>  		return pte;
>  	}
>  
> @@ -142,7 +142,7 @@ static inline pte_t set_pte_filter(pte_t pte)
>  static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
>  				     int dirty)
>  {
> -	struct page *pg;
> +	struct folio *folio;
>  
>  	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64))
>  		return pte;
> @@ -168,17 +168,17 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
>  #endif /* CONFIG_DEBUG_VM */
>  
>  	/* If you set _PAGE_EXEC on weird pages you're on your own */
> -	pg = maybe_pte_to_page(pte);
> -	if (unlikely(!pg))
> +	folio = maybe_pte_to_folio(pte);
> +	if (unlikely(!folio))
>  		goto bail;
>  
>  	/* If the page is already clean, we move on */
> -	if (test_bit(PG_dcache_clean, &pg->flags))
> +	if (test_bit(PG_dcache_clean, &folio->flags))
>  		goto bail;
>  
>  	/* Clean the page and set PG_dcache_clean */
> -	flush_dcache_icache_page(pg);
> -	set_bit(PG_dcache_clean, &pg->flags);
> +	flush_dcache_icache_folio(folio);
> +	set_bit(PG_dcache_clean, &folio->flags);
>  
>   bail:
>  	return pte_mkexec(pte);
> @@ -187,8 +187,8 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
>  /*
>   * set_pte stores a linux PTE into the linux page table.
>   */
> -void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> -		pte_t pte)
> +void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> +		pte_t pte, unsigned int nr)
>  {
>  	/*
>  	 * Make sure hardware valid bit is not set. We don't do
> @@ -203,7 +203,14 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>  	pte = set_pte_filter(pte);
>  
>  	/* Perform the setting of the PTE */
> -	__set_pte_at(mm, addr, ptep, pte, 0);
> +	for (;;) {
> +		__set_pte_at(mm, addr, ptep, pte, 0);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		pte = __pte(pte_val(pte) + PAGE_SIZE);
> +		addr += PAGE_SIZE;
> +	}
>  }
>  
>  void unmap_kernel_page(unsigned long va)
> -- 
> 2.39.2
> 
> 

-- 
Sincerely yours,
Mike.
