Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC96BAD0D
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjCOKIA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjCOKHj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:07:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6883C30;
        Wed, 15 Mar 2023 03:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 092FC61CBB;
        Wed, 15 Mar 2023 10:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213D2C433D2;
        Wed, 15 Mar 2023 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678874838;
        bh=bdbwPo52/Ppp+QyPqw237wZWKSnBlkdHlTk0ENeNb/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZyvkiQnDQbYDPMcUjI6+iuVI5RCFEjszOjFF+VhMTt7FVKPxZNMk6gFjMgIjhzN7l
         Zvcn7Oxzf5yWR8BllhU+NahKG1sExq1bpZDhpCzmg9+10tZgFXSkXUEKkUypGNxSfK
         dEdMeA7NCtj3fKbenKhnMTbtULmPax5c2w1stHzzFwcp8UZ2OFsm+W0Z4mHSW00ToH
         awXTUSTyMhRbVZ4J/EyRTdWzpcOiPBg9TnWRVQIRZSO5UysDcAKHNwqxenKJk9g25H
         3F1uFsJcSfZmnfKMSKUJPyEqw4ulY7JutOnSuCgK0Fp6oWVAlI2QklzVaFs0P42CB7
         fzV55O5eLddHQ==
Date:   Wed, 15 Mar 2023 12:07:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 13/36] loongarch: Implement the new page table range
 API
Message-ID: <ZBGYyY2WJa2TfSRD@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-14-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:21AM +0000, Matthew Wilcox (Oracle) wrote:
> Add update_mmu_cache_range() and change _PFN_SHIFT to PFN_PTE_SHIFT.
> It would probably be more efficient to implement __update_tlb() by
> flushing the entire folio instead of calling __update_tlb() N times,
> but I'll leave that for someone who understands the architecture better.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: loongarch@lists.linux.dev

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/loongarch/include/asm/cacheflush.h   |  2 ++
>  arch/loongarch/include/asm/pgtable-bits.h |  4 ++--
>  arch/loongarch/include/asm/pgtable.h      | 28 ++++++++++++-----------
>  arch/loongarch/mm/pgtable.c               |  2 +-
>  arch/loongarch/mm/tlb.c                   |  2 +-
>  5 files changed, 21 insertions(+), 17 deletions(-)
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
> diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
> index 8b98d22a145b..a1eb2e25446b 100644
> --- a/arch/loongarch/include/asm/pgtable-bits.h
> +++ b/arch/loongarch/include/asm/pgtable-bits.h
> @@ -48,12 +48,12 @@
>  #define _PAGE_NO_EXEC		(_ULCAST_(1) << _PAGE_NO_EXEC_SHIFT)
>  #define _PAGE_RPLV		(_ULCAST_(1) << _PAGE_RPLV_SHIFT)
>  #define _CACHE_MASK		(_ULCAST_(3) << _CACHE_SHIFT)
> -#define _PFN_SHIFT		(PAGE_SHIFT - 12 + _PAGE_PFN_SHIFT)
> +#define PFN_PTE_SHIFT		(PAGE_SHIFT - 12 + _PAGE_PFN_SHIFT)
>  
>  #define _PAGE_USER	(PLV_USER << _PAGE_PLV_SHIFT)
>  #define _PAGE_KERN	(PLV_KERN << _PAGE_PLV_SHIFT)
>  
> -#define _PFN_MASK (~((_ULCAST_(1) << (_PFN_SHIFT)) - 1) & \
> +#define _PFN_MASK (~((_ULCAST_(1) << (PFN_PTE_SHIFT)) - 1) & \
>  		  ((_ULCAST_(1) << (_PAGE_PFN_END_SHIFT)) - 1))
>  
>  /*
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index d28fb9dbec59..13aad0003e9a 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -237,9 +237,9 @@ extern pmd_t mk_pmd(struct page *page, pgprot_t prot);
>  extern void set_pmd_at(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp, pmd_t pmd);
>  
>  #define pte_page(x)		pfn_to_page(pte_pfn(x))
> -#define pte_pfn(x)		((unsigned long)(((x).pte & _PFN_MASK) >> _PFN_SHIFT))
> -#define pfn_pte(pfn, prot)	__pte(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
> -#define pfn_pmd(pfn, prot)	__pmd(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
> +#define pte_pfn(x)		((unsigned long)(((x).pte & _PFN_MASK) >> PFN_PTE_SHIFT))
> +#define pfn_pte(pfn, prot)	__pte(((pfn) << PFN_PTE_SHIFT) | pgprot_val(prot))
> +#define pfn_pmd(pfn, prot)	__pmd(((pfn) << PFN_PTE_SHIFT) | pgprot_val(prot))
>  
>  /*
>   * Initialize a new pgd / pud / pmd table with invalid pointers.
> @@ -334,12 +334,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>  	}
>  }
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep, pte_t pteval)
> -{
> -	set_pte(ptep, pteval);
> -}
> -
>  static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>  {
>  	/* Preserve global status for the pair */
> @@ -445,11 +439,19 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  extern void __update_tlb(struct vm_area_struct *vma,
>  			unsigned long address, pte_t *ptep);
>  
> -static inline void update_mmu_cache(struct vm_area_struct *vma,
> -			unsigned long address, pte_t *ptep)
> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
> +		unsigned long address, pte_t *ptep, unsigned int nr)
>  {
> -	__update_tlb(vma, address, ptep);
> +	for (;;) {
> +		__update_tlb(vma, address, ptep);
> +		if (--nr == 0)
> +			break;
> +		address += PAGE_SIZE;
> +		ptep++;
> +	}
>  }
> +#define update_mmu_cache(vma, addr, ptep) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
>  
>  #define __HAVE_ARCH_UPDATE_MMU_TLB
>  #define update_mmu_tlb	update_mmu_cache
> @@ -462,7 +464,7 @@ static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>  
>  static inline unsigned long pmd_pfn(pmd_t pmd)
>  {
> -	return (pmd_val(pmd) & _PFN_MASK) >> _PFN_SHIFT;
> +	return (pmd_val(pmd) & _PFN_MASK) >> PFN_PTE_SHIFT;
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
> index 36a6dc0148ae..1260cf30e3ee 100644
> --- a/arch/loongarch/mm/pgtable.c
> +++ b/arch/loongarch/mm/pgtable.c
> @@ -107,7 +107,7 @@ pmd_t mk_pmd(struct page *page, pgprot_t prot)
>  {
>  	pmd_t pmd;
>  
> -	pmd_val(pmd) = (page_to_pfn(page) << _PFN_SHIFT) | pgprot_val(prot);
> +	pmd_val(pmd) = (page_to_pfn(page) << PFN_PTE_SHIFT) | pgprot_val(prot);
>  
>  	return pmd;
>  }
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index 8bad6b0cff59..73652930b268 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -246,7 +246,7 @@ static void output_pgtable_bits_defines(void)
>  	pr_define("_PAGE_WRITE_SHIFT %d\n", _PAGE_WRITE_SHIFT);
>  	pr_define("_PAGE_NO_READ_SHIFT %d\n", _PAGE_NO_READ_SHIFT);
>  	pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
> -	pr_define("_PFN_SHIFT %d\n", _PFN_SHIFT);
> +	pr_define("PFN_PTE_SHIFT %d\n", PFN_PTE_SHIFT);
>  	pr_debug("\n");
>  }
>  
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.
