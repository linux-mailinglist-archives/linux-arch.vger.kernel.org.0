Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA59710355
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 05:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjEYDfo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 23:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEYDfn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 23:35:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38453E2;
        Wed, 24 May 2023 20:35:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFBED1042;
        Wed, 24 May 2023 20:36:25 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A8D3F762;
        Wed, 24 May 2023 20:35:38 -0700 (PDT)
Message-ID: <592942c0-00dc-0317-0411-f9e17870fb11@arm.com>
Date:   Thu, 25 May 2023 09:05:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 09/36] arm64: Implement the new page table range API
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-10-willy@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230315051444.3229621-10-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/15/23 10:44, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> Change the PG_dcache_clean flag from being per-page to per-folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/include/asm/cacheflush.h |  4 +++-
>  arch/arm64/include/asm/pgtable.h    | 25 ++++++++++++++------
>  arch/arm64/mm/flush.c               | 36 +++++++++++------------------
>  3 files changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 37185e978aeb..d115451ed263 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -114,7 +114,7 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
>  #define copy_to_user_page copy_to_user_page
>  
>  /*
> - * flush_dcache_page is used when the kernel has written to the page
> + * flush_dcache_folio is used when the kernel has written to the page
>   * cache page at virtual address page->virtual.
>   *
>   * If this page isn't mapped (ie, page_mapping == NULL), or it might
> @@ -127,6 +127,8 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
>   */
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>  extern void flush_dcache_page(struct page *);
> +void flush_dcache_folio(struct folio *);

This is giving a checkpatch.pl warning

WARNING: function definition argument 'struct folio *' should also have an identifier name
#36: FILE: arch/arm64/include/asm/cacheflush.h:130:
+void flush_dcache_folio(struct folio *);

total: 0 errors, 1 warnings, 111 lines checked

> +#define flush_dcache_folio flush_dcache_folio
>  
>  static __always_inline void icache_inval_all_pou(void)
>  {
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9428748f4691..6fd012663a01 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -355,12 +355,21 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	set_pte(ptep, pte);
>  }
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep, pte_t pte)
> -{
> -	page_table_check_ptes_set(mm, addr, ptep, pte, 1);
> -	return __set_pte_at(mm, addr, ptep, pte);
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +			      pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
> +
> +	for (;;) {
> +		__set_pte_at(mm, addr, ptep, pte);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		addr += PAGE_SIZE;
> +		pte_val(pte) += PAGE_SIZE;
> +	}
>  }
> +#define set_ptes set_ptes
>  
>  /*
>   * Huge pte definitions.
> @@ -1059,8 +1068,8 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>  /*
>   * On AArch64, the cache coherency is handled via the set_pte_at() function.
>   */
> -static inline void update_mmu_cache(struct vm_area_struct *vma,
> -				    unsigned long addr, pte_t *ptep)
> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep, unsigned int nr)
>  {
>  	/*
>  	 * We don't do anything here, so there's a very small chance of
> @@ -1069,6 +1078,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  	 */
>  }
>  
> +#define update_mmu_cache(vma, addr, ptep) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
>  #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
>  
>  #ifdef CONFIG_ARM64_PA_BITS_52
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index 5f9379b3c8c8..deb781af0a3a 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -50,20 +50,13 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
>  
>  void __sync_icache_dcache(pte_t pte)
>  {
> -	struct page *page = pte_page(pte);
> +	struct folio *folio = page_folio(pte_page(pte));
>  
> -	/*
> -	 * HugeTLB pages are always fully mapped, so only setting head page's
> -	 * PG_dcache_clean flag is enough.
> -	 */
> -	if (PageHuge(page))
> -		page = compound_head(page);
> -
> -	if (!test_bit(PG_dcache_clean, &page->flags)) {
> -		sync_icache_aliases((unsigned long)page_address(page),
> -				    (unsigned long)page_address(page) +
> -					    page_size(page));
> -		set_bit(PG_dcache_clean, &page->flags);
> +	if (!test_bit(PG_dcache_clean, &folio->flags)) {
> +		sync_icache_aliases((unsigned long)folio_address(folio),
> +				    (unsigned long)folio_address(folio) +
> +					    folio_size(folio));
> +		set_bit(PG_dcache_clean, &folio->flags);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(__sync_icache_dcache);
> @@ -73,17 +66,16 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
>   * it as dirty for later flushing when mapped in user space (if executable,
>   * see __sync_icache_dcache).
>   */
> -void flush_dcache_page(struct page *page)
> +void flush_dcache_folio(struct folio *folio)
>  {
> -	/*
> -	 * HugeTLB pages are always fully mapped and only head page will be
> -	 * set PG_dcache_clean (see comments in __sync_icache_dcache()).
> -	 */
> -	if (PageHuge(page))
> -		page = compound_head(page);
> +	if (test_bit(PG_dcache_clean, &folio->flags))
> +		clear_bit(PG_dcache_clean, &folio->flags);
> +}
> +EXPORT_SYMBOL(flush_dcache_folio);
>  
> -	if (test_bit(PG_dcache_clean, &page->flags))
> -		clear_bit(PG_dcache_clean, &page->flags);
> +void flush_dcache_page(struct page *page)
> +{
> +	flush_dcache_folio(page_folio(page));
>  }
>  EXPORT_SYMBOL(flush_dcache_page);
>

Otherwise LGTM.
