Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B86B2251
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 12:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCILJk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 06:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjCILJM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 06:09:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27FB15CEC3;
        Thu,  9 Mar 2023 03:03:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F26F6C14;
        Thu,  9 Mar 2023 03:03:55 -0800 (PST)
Received: from [10.1.27.175] (C02CF1NRLVDN.cambridge.arm.com [10.1.27.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5173F67D;
        Thu,  9 Mar 2023 03:03:11 -0800 (PST)
Message-ID: <af1a4992-bb4b-bd91-6ff9-0783ef7528ae@arm.com>
Date:   Thu, 9 Mar 2023 11:03:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 08/34] arm64: Implement the new page table range API
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-9-willy@infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230228213738.272178-9-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 28/02/2023 21:37, Matthew Wilcox (Oracle) wrote:
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
> +#define flush_dcache_folio flush_dcache_folio
>  
>  static __always_inline void icache_inval_all_pou(void)
>  {
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 69765dc697af..4d1b79dbff16 100644
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

For systems that support > 48-bit PA, arm64 places high bits [51:48] of the PA
at a low position in the PTE. I think I've convinced myself that this is ok
though, because set_ptes() promises that the range is always within a single PMD
and therefore its guaranteed that we will not have ptes straddling both sides of
the 48 bit boundary for a single call?

Also, its not clear to me if set_ptes() could be called for a range of
not-present ptes? (i.e. clearing the pte-range or swap entries, etc). If so,
then I guess you would only want to increment the address if pte_present(pte)?
I'm guessing that batch-clearing ptes might appear in the near future so might
be sensible to support that now?

Regardless, a comment to make these assumptions clear would be useful.

Thanks,
Ryan


> +	}
>  }
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
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

