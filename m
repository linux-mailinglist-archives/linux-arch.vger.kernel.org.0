Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EC86A2E33
	for <lists+linux-arch@lfdr.de>; Sun, 26 Feb 2023 05:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBZEfC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Feb 2023 23:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZEfB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Feb 2023 23:35:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141AFD50B
        for <linux-arch@vger.kernel.org>; Sat, 25 Feb 2023 20:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X8M9E7W4vhhexRDdiY+AZtRYDqU5sVbi9HJ0Sf8DosE=; b=Q3st/CHLLYuQrE4naelSIeVH3O
        FziGceHthnLibdMkKQlbydBHm1+DtkqII2Bx4TUZgyguUF5K5p8rdFWcVigYGuBpV/zxjOyAxhT0a
        0jG4I+jsj6Zg/Ie1jJLQj8whYkE4jDK7skZLWhqudKfjEgdU9TgBqCLiYgB3tDZU1VZvCCZwmyZA1
        wurvmlgKd901321WpbsuXe7aFScJT632mUoohCg2JU0pHqMvkLcl6v9ljT78ug/xSZpDIqNjuFPRQ
        wTgxEzaUE5H3K6h/kUEL3oRuNNfZyoV8TjsOgpqPKk7iS2CLiltoi0J0R/yrDQ6iUYCy/e3nfT1iz
        6dcthOWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pW8kA-00GdoJ-Dv; Sun, 26 Feb 2023 04:34:38 +0000
Date:   Sun, 26 Feb 2023 04:34:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 13/7] loongson: Implement the new page table range API
Message-ID: <Y/rhXjWLexvt5sPO@casper.infradead.org>
References: <20230211033948.891959-1-willy@infradead.org>
 <20230215000446.1655635-1-willy@infradead.org>
 <20230215000446.1655635-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215000446.1655635-5-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 15, 2023 at 12:04:46AM +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes() and update_mmu_cache_range().
> 
> THIS PATCH IS INCOMPLETE.  I DO NOT KNOW WHAT TO DO IN __update_tlb()

Help?  This is the only remaining architecture to fix; I have all the
others converted now.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/loongarch/include/asm/cacheflush.h |  2 ++
>  arch/loongarch/include/asm/pgtable.h    | 30 ++++++++++++++++---------
>  arch/loongarch/mm/tlb.c                 |  4 +++-
>  3 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
> index 0681788eb474..7907eb42bfbd 100644
> --- a/arch/loongarch/include/asm/cacheflush.h
> +++ b/arch/loongarch/include/asm/cacheflush.h
> @@ -47,8 +47,10 @@ void local_flush_icache_range(unsigned long start, unsigned long end);
>  #define flush_cache_vmap(start, end)			do { } while (0)
>  #define flush_cache_vunmap(start, end)			do { } while (0)
>  #define flush_icache_page(vma, page)			do { } while (0)
> +#define flush_icache_pages(vma, page)			do { } while (0)
>  #define flush_icache_user_page(vma, page, addr, len)	do { } while (0)
>  #define flush_dcache_page(page)				do { } while (0)
> +#define flush_dcache_folio(folio)			do { } while (0)
>  #define flush_dcache_mmap_lock(mapping)			do { } while (0)
>  #define flush_dcache_mmap_unlock(mapping)		do { } while (0)
>  
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index d28fb9dbec59..0f5fa7c40c52 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -334,12 +334,20 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>  	}
>  }
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep, pte_t pteval)
> -{
> -	set_pte(ptep, pteval);
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +	for (;;) {
> +		set_pte(ptep, pte);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		pte_val(pte) += 1 << _PFN_SHIFT;
> +	}
>  }
>  
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
> +
>  static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>  {
>  	/* Preserve global status for the pair */
> @@ -442,14 +450,16 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  		     (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
>  }
>  
> -extern void __update_tlb(struct vm_area_struct *vma,
> -			unsigned long address, pte_t *ptep);
> +extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
> +		pte_t *ptep, unsigned int nr);
>  
> -static inline void update_mmu_cache(struct vm_area_struct *vma,
> -			unsigned long address, pte_t *ptep)
> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
> +		unsigned long address, pte_t *ptep, unsigned int nr)
>  {
> -	__update_tlb(vma, address, ptep);
> +	__update_tlb(vma, address, ptep, nr);
>  }
> +#define update_mmu_cache(vma, addr, ptep) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
>  
>  #define __HAVE_ARCH_UPDATE_MMU_TLB
>  #define update_mmu_tlb	update_mmu_cache
> @@ -457,7 +467,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>  			unsigned long address, pmd_t *pmdp)
>  {
> -	__update_tlb(vma, address, (pte_t *)pmdp);
> +	__update_tlb(vma, address, (pte_t *)pmdp, 1);
>  }
>  
>  static inline unsigned long pmd_pfn(pmd_t pmd)
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index 8bad6b0cff59..ac0b19dbd1dc 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -162,7 +162,8 @@ static void __update_hugetlb(struct vm_area_struct *vma, unsigned long address,
>  #endif
>  }
>  
> -void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
> +void __update_tlb(struct vm_area_struct *vma, unsigned long address,
> +		pte_t *ptep, unsigned int nr)
>  {
>  	int idx;
>  	unsigned long flags;
> @@ -187,6 +188,7 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep
>  	write_csr_entryhi(address);
>  	tlb_probe();
>  	idx = read_csr_tlbidx();
> +// I have no idea what to do here
>  	write_csr_pagesize(PS_DEFAULT_SIZE);
>  	write_csr_entrylo0(pte_val(*ptep++));
>  	write_csr_entrylo1(pte_val(*ptep));
> -- 
> 2.39.1
> 
