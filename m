Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93E36A96CE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 12:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCCL4y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 06:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCCL4y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 06:56:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1711D5D880;
        Fri,  3 Mar 2023 03:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BD61617B4;
        Fri,  3 Mar 2023 11:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD28C433D2;
        Fri,  3 Mar 2023 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677844609;
        bh=dOgzlBLPlOS+XYasJ+6eJlX1/dEnbvS4fGafOnUfsz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AByWUKAVZiITmU8Swud8hn6PhHc/swNFS21og02GUGdjC864s3RfOkwOWi7mGhwka
         Vn9nDg/PAA8PQIUcLRHMVxBI3OL0Zh6j14sIHjGlVQythjKtVeybJ6CCVDNXEMqrPF
         FQL3GpKM/skJJ6kzb1OcBAhc+uZtoPnUomEfbw9xW7NaKze7EXuT1qxXiRxYcJ8Sxj
         gNEoXpKSYaZL8N+HE3rOTlYQZAfPDzf/tcZKFcDrl9Fzr9u1cgMCf5AgAlrr8Sb8eA
         H02/TD16cAijVy2/josMh83yvCBoiSqW7/Yw30d+S/50Aphl/Ni5YlNAjuCfahxOo6
         LrK18vjSTHW7Q==
Date:   Fri, 3 Mar 2023 13:56:36 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v3 11/34] ia64: Implement the new page table range API
Message-ID: <ZAHgdEzqWk4Peyjh@kernel.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228213738.272178-12-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 28, 2023 at 09:37:14PM +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> Change the PG_arch_1 (aka PG_dcache_clean) flag from being per-page to
> per-folio, which makes arch_dma_mark_clean() and mark_clean() a little
> more exciting.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: linux-ia64@vger.kernel.org
> ---
>  arch/ia64/hp/common/sba_iommu.c    | 26 +++++++++++++++-----------
>  arch/ia64/include/asm/cacheflush.h | 14 ++++++++++----
>  arch/ia64/include/asm/pgtable.h    | 14 +++++++++++++-
>  arch/ia64/mm/init.c                | 29 +++++++++++++++++++----------
>  4 files changed, 57 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
> index 8ad6946521d8..48d475f10003 100644
> --- a/arch/ia64/hp/common/sba_iommu.c
> +++ b/arch/ia64/hp/common/sba_iommu.c
> @@ -798,22 +798,26 @@ sba_io_pdir_entry(u64 *pdir_ptr, unsigned long vba)
>  #endif
>  
>  #ifdef ENABLE_MARK_CLEAN
> -/**
> +/*
>   * Since DMA is i-cache coherent, any (complete) pages that were written via
>   * DMA can be marked as "clean" so that lazy_mmu_prot_update() doesn't have to
>   * flush them when they get mapped into an executable vm-area.
>   */
> -static void
> -mark_clean (void *addr, size_t size)
> +static void mark_clean(void *addr, size_t size)
>  {
> -	unsigned long pg_addr, end;
> -
> -	pg_addr = PAGE_ALIGN((unsigned long) addr);
> -	end = (unsigned long) addr + size;
> -	while (pg_addr + PAGE_SIZE <= end) {
> -		struct page *page = virt_to_page((void *)pg_addr);
> -		set_bit(PG_arch_1, &page->flags);
> -		pg_addr += PAGE_SIZE;
> +	struct folio *folio = virt_to_folio(addr);
> +	ssize_t left = size;
> +	size_t offset = offset_in_folio(folio, addr);
> +
> +	if (offset) {
> +		left -= folio_size(folio) - offset;
> +		folio = folio_next(folio);
> +	}
> +
> +	while (left >= folio_size(folio)) {
> +		set_bit(PG_arch_1, &folio->flags);
> +		left -= folio_size(folio);
> +		folio = folio_next(folio);
>  	}
>  }
>  #endif
> diff --git a/arch/ia64/include/asm/cacheflush.h b/arch/ia64/include/asm/cacheflush.h
> index 708c0fa5d975..eac493fa9e0d 100644
> --- a/arch/ia64/include/asm/cacheflush.h
> +++ b/arch/ia64/include/asm/cacheflush.h
> @@ -13,10 +13,16 @@
>  #include <asm/page.h>
>  
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> -#define flush_dcache_page(page)			\
> -do {						\
> -	clear_bit(PG_arch_1, &(page)->flags);	\
> -} while (0)
> +static inline void flush_dcache_folio(struct folio *folio)
> +{
> +	clear_bit(PG_arch_1, &folio->flags);
> +}
> +#define flush_dcache_folio flush_dcache_folio
> +
> +static inline void flush_dcache_page(struct page *page)
> +{
> +	flush_dcache_folio(page_folio(page));
> +}
>  
>  extern void flush_icache_range(unsigned long start, unsigned long end);
>  #define flush_icache_range flush_icache_range
> diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
> index 21c97e31a28a..0c2be4ea664b 100644
> --- a/arch/ia64/include/asm/pgtable.h
> +++ b/arch/ia64/include/asm/pgtable.h
> @@ -303,7 +303,18 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>  	*ptep = pteval;
>  }
>  
> -#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +	for (;;) {
> +		set_pte(ptep, pte);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		pte_val(pte) += PAGE_SIZE;
> +	}
> +}
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, add, ptep, pte, 1)
>  
>  /*
>   * Make page protection values cacheable, uncacheable, or write-
> @@ -396,6 +407,7 @@ pte_same (pte_t a, pte_t b)
>  	return pte_val(a) == pte_val(b);
>  }
>  
> +#define update_mmu_cache_range(vma, address, ptep, nr) do { } while (0)
>  #define update_mmu_cache(vma, address, ptep) do { } while (0)
>  
>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index 7f5353e28516..12aef25944aa 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -50,30 +50,39 @@ void
>  __ia64_sync_icache_dcache (pte_t pte)
>  {
>  	unsigned long addr;
> -	struct page *page;
> +	struct folio *folio;
>  
> -	page = pte_page(pte);
> -	addr = (unsigned long) page_address(page);
> +	folio = page_folio(pte_page(pte));
> +	addr = (unsigned long)folio_address(folio);
>  
> -	if (test_bit(PG_arch_1, &page->flags))
> +	if (test_bit(PG_arch_1, &folio->flags))
>  		return;				/* i-cache is already coherent with d-cache */
>  
> -	flush_icache_range(addr, addr + page_size(page));
> -	set_bit(PG_arch_1, &page->flags);	/* mark page as clean */
> +	flush_icache_range(addr, addr + folio_size(folio));
> +	set_bit(PG_arch_1, &folio->flags);	/* mark page as clean */
>  }
>  
>  /*
> - * Since DMA is i-cache coherent, any (complete) pages that were written via
> + * Since DMA is i-cache coherent, any (complete) folios that were written via
>   * DMA can be marked as "clean" so that lazy_mmu_prot_update() doesn't have to
>   * flush them when they get mapped into an executable vm-area.
>   */
>  void arch_dma_mark_clean(phys_addr_t paddr, size_t size)
>  {
> -	unsigned long pfn = PHYS_PFN(paddr);
> +	struct folio *folio = page_folio(phys_to_page(paddr));
> +	ssize_t left = size;
> +	size_t offset = offset_in_folio(folio, paddr);

Build of defconfig failed miserably for me without this:

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 12aef25944aa..0775e7870257 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -69,7 +69,8 @@ __ia64_sync_icache_dcache (pte_t pte)
  */
 void arch_dma_mark_clean(phys_addr_t paddr, size_t size)
 {
-	struct folio *folio = page_folio(phys_to_page(paddr));
+	unsigned long pfn = __phys_to_pfn(paddr);
+	struct folio *folio = page_folio(pfn_to_page(pfn));
 	ssize_t left = size;
 	size_t offset = offset_in_folio(folio, paddr);
 

>  
> -	do {
> +	if (offset) {
> +		left -= folio_size(folio) - offset;
> +		folio = folio_next(folio);
> +	}
> +
> +	while (left >= (ssize_t)folio_size(folio)) {
>  		set_bit(PG_arch_1, &pfn_to_page(pfn)->flags);
> -	} while (++pfn <= PHYS_PFN(paddr + size - 1));
> +		left -= folio_size(folio);
> +		folio = folio_next(folio);
> +	}
>  }
>  
>  inline void
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
