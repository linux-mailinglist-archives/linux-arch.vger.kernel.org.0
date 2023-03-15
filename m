Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432966BAD27
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjCOKL3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjCOKLA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:11:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522157D9A;
        Wed, 15 Mar 2023 03:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8D0E61CCE;
        Wed, 15 Mar 2023 10:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88760C433D2;
        Wed, 15 Mar 2023 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678875023;
        bh=t6+L9+5TgsgHD5i71rZ4I1fBe7Dw8QjjaTgllTsJASg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTfI9Axm5wAnGiuKp4LdSxj2zUd4+mexU7PMy/4ZvlZVAgRtgmuiSsKsrmAW/5JQ3
         Nx1+DYd12ijh+vY+2MMUj8nuQgQ5OedPPjhU8pNWewdow+wptVBXcwkFw4Bp4lSpet
         2soyzjifgj7cmNt/GzZpy1UpdUFQVMDzDg++8igWTouxWPqD+LEpYiFyE2Xgb2LCBW
         K42eDy6enK3rwqfFgLk8LIX18zMm2M8KEEACm/dcfJeoqEkQSISLHqOj6ibsLibzP4
         k+UaGeEDysFGEkPgfLQLqMgjLo3PqOdrUooNDmr87ylEWSdVmuLT3ijf8vnE5TGh2S
         CVUBTV2pOGODQ==
Date:   Wed, 15 Mar 2023 12:10:09 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 21/36] riscv: Implement the new page table range API
Message-ID: <ZBGZgfg+Ik+ckQvo@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-22-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:29AM +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> Change the PG_dcache_clean flag from being per-page to per-folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/riscv/include/asm/cacheflush.h | 19 +++++++++----------
>  arch/riscv/include/asm/pgtable.h    | 26 +++++++++++++++++++-------
>  arch/riscv/mm/cacheflush.c          | 11 ++---------
>  3 files changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 03e3b95ae6da..10e5e96f09b5 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -15,20 +15,19 @@ static inline void local_flush_icache_all(void)
>  
>  #define PG_dcache_clean PG_arch_1
>  
> -static inline void flush_dcache_page(struct page *page)
> +static inline void flush_dcache_folio(struct folio *folio)
>  {
> -	/*
> -	 * HugeTLB pages are always fully mapped and only head page will be
> -	 * set PG_dcache_clean (see comments in flush_icache_pte()).
> -	 */
> -	if (PageHuge(page))
> -		page = compound_head(page);
> -
> -	if (test_bit(PG_dcache_clean, &page->flags))
> -		clear_bit(PG_dcache_clean, &page->flags);
> +	if (test_bit(PG_dcache_clean, &folio->flags))
> +		clear_bit(PG_dcache_clean, &folio->flags);
>  }
> +#define flush_dcache_folio flush_dcache_folio
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>  
> +static inline void flush_dcache_page(struct page *page)
> +{
> +	flush_dcache_folio(page_folio(page));
> +}
> +
>  /*
>   * RISC-V doesn't have an instruction to flush parts of the instruction cache,
>   * so instead we just flush the whole thing.
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index b516f3b59616..b077bc8c498c 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -405,8 +405,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  
>  
>  /* Commit new configuration to MMU hardware */
> -static inline void update_mmu_cache(struct vm_area_struct *vma,
> -	unsigned long address, pte_t *ptep)
> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
> +		unsigned long address, pte_t *ptep, unsigned int nr)
>  {
>  	/*
>  	 * The kernel assumes that TLBs don't cache invalid entries, but
> @@ -415,8 +415,11 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  	 * Relying on flush_tlb_fix_spurious_fault would suffice, but
>  	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
>  	 */
> -	local_flush_tlb_page(address);
> +	while (nr--)
> +		local_flush_tlb_page(address + nr * PAGE_SIZE);
>  }
> +#define update_mmu_cache(vma, addr, ptep) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
>  
>  #define __HAVE_ARCH_UPDATE_MMU_TLB
>  #define update_mmu_tlb update_mmu_cache
> @@ -456,12 +459,21 @@ static inline void __set_pte_at(struct mm_struct *mm,
>  	set_pte(ptep, pteval);
>  }
>  
> -static inline void set_pte_at(struct mm_struct *mm,
> -	unsigned long addr, pte_t *ptep, pte_t pteval)
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pteval, unsigned int nr)
>  {
> -	page_table_check_ptes_set(mm, addr, ptep, pteval, 1);
> -	__set_pte_at(mm, addr, ptep, pteval);
> +	page_table_check_ptes_set(mm, addr, ptep, pteval, nr);
> +
> +	for (;;) {
> +		__set_pte_at(mm, addr, ptep, pteval);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		addr += PAGE_SIZE;
> +		pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
> +	}
>  }
> +#define set_ptes set_ptes
>  
>  static inline void pte_clear(struct mm_struct *mm,
>  	unsigned long addr, pte_t *ptep)
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index fcd6145fbead..e36a851e5788 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -81,16 +81,9 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>  #ifdef CONFIG_MMU
>  void flush_icache_pte(pte_t pte)
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
> +	if (!test_bit(PG_dcache_clean, &folio->flags)) {
>  		flush_icache_all();
>  		set_bit(PG_dcache_clean, &page->flags);
>  	}
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Sincerely yours,
Mike.
