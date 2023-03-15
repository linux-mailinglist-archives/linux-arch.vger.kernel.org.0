Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485716BAC90
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 10:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjCOJut (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 05:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjCOJuO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 05:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC9305E2;
        Wed, 15 Mar 2023 02:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED47C61C36;
        Wed, 15 Mar 2023 09:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726B6C4339C;
        Wed, 15 Mar 2023 09:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678873768;
        bh=905lAPt08QRFR8FR2phEdH/qr4W7W6RJu2a1XAXvmfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVA4bpKb7d2JG/KjhM8G/2/iPPdIAuE33rZ8yiPVZXPBVehBvfAeQFqDTgH9WobjD
         Ss9Ca7uAZL+f6RZvebjoxsozRItTQb0nx1PZzlPwfgqPWkZrwwJcJuPnnvKDRCcweR
         a+QoyiQHknBUjuaxV5v5n1UjMGvl51GmqDsO/j/Ow8n4/0dF8XerHrkcS7yUx9lS2B
         acP+z4IYMHF8Dvix/Mk8pOK8eLZMQuUxoSs2m26pHjbyoI6/whwfJxSAbbnbSYqRr3
         3+rmJXmyU8wKMtxT8DdJdNSRCLTlF0EFofWuJh/ndpNOi1G34B6W15OItFlMsxONde
         jWG+49VqKLV2Q==
Date:   Wed, 15 Mar 2023 11:49:15 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 09/36] arm64: Implement the new page table range API
Message-ID: <ZBGUm4UCLa+URkc3@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-10-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:17AM +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> Change the PG_dcache_clean flag from being per-page to per-folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

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
> -- 
> 2.39.2
> 
> 

-- 
Sincerely yours,
Mike.
