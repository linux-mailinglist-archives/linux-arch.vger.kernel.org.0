Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DC96BAD32
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjCOKM2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjCOKMA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC9472018;
        Wed, 15 Mar 2023 03:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 882A561CD3;
        Wed, 15 Mar 2023 10:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4955C433EF;
        Wed, 15 Mar 2023 10:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678875094;
        bh=2YGepKnUPthEHs7BQ3Q+GQKbEKurUEPs7Ce+pm8dnSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bi4WlO+P3WmbfFnHs3sAxtbjF+f9YngYjr6v4pXaWK9RWakpxCbwRcTOpzkhoa4Wg
         j1ypCrLwRfVf6xfDBFZ507BCzqNSJkeb/n/z+yyyFMKVbJYRl5rwhhAvjfdBV90GAB
         6/6VFINYnVs90LOu+8AE/1lyqs6ON1wpU95b0S4Cy+El5lmlIVouaSicrJRA+HR/bf
         sNj06iDNDmSJfpEsOEQ6rBOl6tCUA4sjMsFjrRSUAFuGvOvmFynFAT8gc7abFuw7kq
         nqViw81tQ94e5w0JBezD/KNYw4hahde/BS8kvvpw5/lOnxBcKukgiOLw1+iEGbyVci
         aYgevpUdgY3bQ==
Date:   Wed, 15 Mar 2023 12:11:21 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 24/36] sparc32: Implement the new page table range API
Message-ID: <ZBGZyYOE3CXFwwbZ@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-25-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:32AM +0000, Matthew Wilcox (Oracle) wrote:
> Add PFN_PTE_SHIFT, update_mmu_cache_range(), flush_dcache_folio() and
> flush_icache_pages().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/sparc/include/asm/cacheflush_32.h |  9 +++++++--
>  arch/sparc/include/asm/pgtable_32.h    |  8 ++++----
>  arch/sparc/mm/init_32.c                | 13 +++++++++++--
>  3 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
> index adb6991d0455..8dba35d63328 100644
> --- a/arch/sparc/include/asm/cacheflush_32.h
> +++ b/arch/sparc/include/asm/cacheflush_32.h
> @@ -16,6 +16,7 @@
>  	sparc32_cachetlb_ops->cache_page(vma, addr)
>  #define flush_icache_range(start, end)		do { } while (0)
>  #define flush_icache_page(vma, pg)		do { } while (0)
> +#define flush_icache_pages(vma, pg, nr)		do { } while (0)
>  
>  #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
>  	do {							\
> @@ -35,11 +36,15 @@
>  #define flush_page_for_dma(addr) \
>  	sparc32_cachetlb_ops->page_for_dma(addr)
>  
> -struct page;
>  void sparc_flush_page_to_ram(struct page *page);
> +void sparc_flush_folio_to_ram(struct folio *folio);
>  
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> -#define flush_dcache_page(page)			sparc_flush_page_to_ram(page)
> +#define flush_dcache_folio(folio)		sparc_flush_folio_to_ram(folio)
> +static inline void flush_dcache_page(struct page *page)
> +{
> +	flush_dcache_folio(page_folio(page));
> +}
>  #define flush_dcache_mmap_lock(mapping)		do { } while (0)
>  #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
>  
> diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
> index d4330e3c57a6..7514611d14d3 100644
> --- a/arch/sparc/include/asm/pgtable_32.h
> +++ b/arch/sparc/include/asm/pgtable_32.h
> @@ -101,8 +101,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>  	srmmu_swap((unsigned long *)ptep, pte_val(pteval));
>  }
>  
> -#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
> -
>  static inline int srmmu_device_memory(unsigned long x)
>  {
>  	return ((x & 0xF0000000) != 0);
> @@ -256,6 +254,7 @@ static inline pte_t pte_mkyoung(pte_t pte)
>  	return __pte(pte_val(pte) | SRMMU_REF);
>  }
>  
> +#define PFN_PTE_SHIFT			(PAGE_SHIFT - 4)
>  #define pfn_pte(pfn, prot)		mk_pte(pfn_to_page(pfn), prot)
>  
>  static inline unsigned long pte_pfn(pte_t pte)
> @@ -268,7 +267,7 @@ static inline unsigned long pte_pfn(pte_t pte)
>  		 */
>  		return ~0UL;
>  	}
> -	return (pte_val(pte) & SRMMU_PTE_PMASK) >> (PAGE_SHIFT-4);
> +	return (pte_val(pte) & SRMMU_PTE_PMASK) >> PFN_PTE_SHIFT;
>  }
>  
>  #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
> @@ -318,6 +317,7 @@ void mmu_info(struct seq_file *m);
>  #define FAULT_CODE_USER     0x4
>  
>  #define update_mmu_cache(vma, address, ptep) do { } while (0)
> +#define update_mmu_cache_range(vma, address, ptep, nr) do { } while (0)
>  
>  void srmmu_mapiorange(unsigned int bus, unsigned long xpa,
>                        unsigned long xva, unsigned int len);
> @@ -422,7 +422,7 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
>  ({									  \
>  	int __changed = !pte_same(*(__ptep), __entry);			  \
>  	if (__changed) {						  \
> -		set_pte_at((__vma)->vm_mm, (__address), __ptep, __entry); \
> +		set_pte(__ptep, __entry);				  \
>  		flush_tlb_page(__vma, __address);			  \
>  	}								  \
>  	__changed;							  \
> diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> index 9c0ea457bdf0..d96a14ffceeb 100644
> --- a/arch/sparc/mm/init_32.c
> +++ b/arch/sparc/mm/init_32.c
> @@ -297,11 +297,20 @@ void sparc_flush_page_to_ram(struct page *page)
>  {
>  	unsigned long vaddr = (unsigned long)page_address(page);
>  
> -	if (vaddr)
> -		__flush_page_to_ram(vaddr);
> +	__flush_page_to_ram(vaddr);
>  }
>  EXPORT_SYMBOL(sparc_flush_page_to_ram);
>  
> +void sparc_flush_folio_to_ram(struct folio *folio)
> +{
> +	unsigned long vaddr = (unsigned long)folio_address(folio);
> +	unsigned int i, nr = folio_nr_pages(folio);
> +
> +	for (i = 0; i < nr; i++)
> +		__flush_page_to_ram(vaddr + i * PAGE_SIZE);
> +}
> +EXPORT_SYMBOL(sparc_flush_folio_to_ram);
> +
>  static const pgprot_t protection_map[16] = {
>  	[VM_NONE]					= PAGE_NONE,
>  	[VM_READ]					= PAGE_READONLY,
> -- 
> 2.39.2
> 
> 

-- 
Sincerely yours,
Mike.
