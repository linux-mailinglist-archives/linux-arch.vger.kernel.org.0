Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749036A4EF1
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjB0WxG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB0WxF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:53:05 -0500
X-Greylist: delayed 120 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 14:53:02 PST
Received: from cmx-torrgo002.bell.net (mta-tor-001.bell.net [209.71.212.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFDF59FF;
        Mon, 27 Feb 2023 14:53:02 -0800 (PST)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [174.88.80.104]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 63F52EA400BF142C
X-CM-Envelope: MS4xfBjLlk4zjYSEeu3WVaCwa0ihj889TfqQ1k8id6DSyKQuv0pkLGawZ0Wv1EUpzwCd4cja7fZbg4R4/bKu8rRuTMNJ3nYXwr99v/8Dd0xiWuJuPVKXvRgY
 2OagrLXBZU3YOlWKwBAScYUVkBnmrOt8CF2FLyhS3igeicz4gePFF4s6Pz7tX1qlY9Pp6CJoRmdTWw8attHsWjj51QbRW2hICF+bI4NoR+q0kI+RqDayg7Z4
 Q45OehPaWaOjy+cgYtwpu6ybtIyXr/MJPt/VAiqTMlO90EoeZrAIpcZeWpETrFNwkov6jMizeuMwvU7rzsssESbylVXJNOhkA6FYXETTz0XO0bjDXfN18u1n
 gZUQnrNlHzBr8TqYhOyGUgoKnXQDGVu6Xlu8iKN3DcZrKkQLeBuKN5cVWcHc5X16h93HV86TZQrdsFLXJzRBtBfSiTlLOfcjJPX9NGXEGUUZnArGiIbXW/bU
 PymloKnqOFUNmgGQ
X-CM-Analysis: v=2.4 cv=ULS+oATy c=1 sm=1 tr=0 ts=63fd336d
 a=jp24WXWxBM5iMX8AJ3NPbw==:117 a=jp24WXWxBM5iMX8AJ3NPbw==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=bLk-5xynAAAA:8 a=VwQbUJbxAAAA:8
 a=FBHGMhGWAAAA:8 a=s9f9GiaaRdOqZ5pmIrgA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=zSyb8xVVt2t83sZkrLMb:22 a=AjGcO6oz07-iQ99wixmX:22
 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (174.88.80.104) by cmx-torrgo002.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 63F52EA400BF142C; Mon, 27 Feb 2023 17:49:17 -0500
Message-ID: <d97b8a56-89cc-1eb4-1298-7b16079b3b46@bell.net>
Date:   Mon, 27 Feb 2023 17:49:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 17/30] parisc: Implement the new page table range API
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
References: <20230227175741.71216-1-willy@infradead.org>
 <20230227175741.71216-18-willy@infradead.org>
Content-Language: en-US
From:   John David Anglin <dave.anglin@bell.net>
In-Reply-To: <20230227175741.71216-18-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-02-27 12:57 p.m., Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio()
> and flush_icache_pages().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
> from being per-page to per-folio.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> ---
>   arch/parisc/include/asm/cacheflush.h |  14 ++--
>   arch/parisc/include/asm/pgtable.h    |  28 +++++---
>   arch/parisc/kernel/cache.c           | 101 +++++++++++++++++++--------
>   3 files changed, 99 insertions(+), 44 deletions(-)
>
> diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
> index ff07c509e04b..0bf8b69d086b 100644
> --- a/arch/parisc/include/asm/cacheflush.h
> +++ b/arch/parisc/include/asm/cacheflush.h
> @@ -46,16 +46,20 @@ void invalidate_kernel_vmap_range(void *vaddr, int size);
>   #define flush_cache_vmap(start, end)		flush_cache_all()
>   #define flush_cache_vunmap(start, end)		flush_cache_all()
>   
> +void flush_dcache_folio(struct folio *folio);
> +#define flush_dcache_folio flush_dcache_folio
>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> -void flush_dcache_page(struct page *page);
> +static inline void flush_dcache_page(struct page *page)
> +{
> +	flush_dcache_folio(page_folio(page));
> +}
>   
>   #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
>   #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
>   
> -#define flush_icache_page(vma,page)	do { 		\
> -	flush_kernel_dcache_page_addr(page_address(page)); \
> -	flush_kernel_icache_page(page_address(page)); 	\
> -} while (0)
> +void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
> +		unsigned int nr);
> +#define flush_icache_page(vma, page)	flush_icache_pages(vma, page, 1)
>   
>   #define flush_icache_range(s,e)		do { 		\
>   	flush_kernel_dcache_range_asm(s,e); 		\
> diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
> index e2950f5db7c9..78ee9816f423 100644
> --- a/arch/parisc/include/asm/pgtable.h
> +++ b/arch/parisc/include/asm/pgtable.h
> @@ -73,14 +73,7 @@ extern void __update_cache(pte_t pte);
>   		mb();				\
>   	} while(0)
>   
> -#define set_pte_at(mm, addr, pteptr, pteval)	\
> -	do {					\
> -		if (pte_present(pteval) &&	\
> -		    pte_user(pteval))		\
> -			__update_cache(pteval);	\
> -		*(pteptr) = (pteval);		\
> -		purge_tlb_entries(mm, addr);	\
> -	} while (0)
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
>   
>   #endif /* !__ASSEMBLY__ */
>   
> @@ -391,11 +384,28 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>   
>   extern void paging_init (void);
>   
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +	if (pte_present(pte) && pte_user(pte))
> +		__update_cache(pte);
> +	for (;;) {
> +		*ptep = pte;
> +		purge_tlb_entries(mm, addr);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		pte_val(pte) += 1 << PFN_PTE_SHIFT;
> +		addr += PAGE_SIZE;
> +	}
> +}
> +
>   /* Used for deferring calls to flush_dcache_page() */
>   
>   #define PG_dcache_dirty         PG_arch_1
>   
> -#define update_mmu_cache(vms,addr,ptep) __update_cache(*ptep)
> +#define update_mmu_cache_range(vma, addr, ptep, nr) __update_cache(*ptep)
> +#define update_mmu_cache(vma, addr, ptep) __update_cache(*ptep)
>   
>   /*
>    * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
> diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
> index 984d3a1b3828..16057812103b 100644
> --- a/arch/parisc/kernel/cache.c
> +++ b/arch/parisc/kernel/cache.c
> @@ -92,11 +92,11 @@ static inline void flush_data_cache(void)
>   /* Kernel virtual address of pfn.  */
>   #define pfn_va(pfn)	__va(PFN_PHYS(pfn))
>   
> -void
> -__update_cache(pte_t pte)
> +void __update_cache(pte_t pte)
>   {
>   	unsigned long pfn = pte_pfn(pte);
> -	struct page *page;
> +	struct folio *folio;
> +	unsigned int nr;
>   
>   	/* We don't have pte special.  As a result, we can be called with
>   	   an invalid pfn and we don't need to flush the kernel dcache page.
> @@ -104,13 +104,17 @@ __update_cache(pte_t pte)
>   	if (!pfn_valid(pfn))
>   		return;
>   
> -	page = pfn_to_page(pfn);
> -	if (page_mapping_file(page) &&
> -	    test_bit(PG_dcache_dirty, &page->flags)) {
> -		flush_kernel_dcache_page_addr(pfn_va(pfn));
> -		clear_bit(PG_dcache_dirty, &page->flags);
> +	folio = page_folio(pfn_to_page(pfn));
> +	pfn = folio_pfn(folio);
> +	nr = folio_nr_pages(folio);
> +	if (folio_flush_mapping(folio) &&
Shouldn't this call be to folio_mapping()?
> +	    test_bit(PG_dcache_dirty, &folio->flags)) {
> +		while (nr--)
> +			flush_kernel_dcache_page_addr(pfn_va(pfn + nr));
> +		clear_bit(PG_dcache_dirty, &folio->flags);
>   	} else if (parisc_requires_coherency())
> -		flush_kernel_dcache_page_addr(pfn_va(pfn));
> +		while (nr--)
> +			flush_kernel_dcache_page_addr(pfn_va(pfn + nr));
>   }
>   
>   void
> @@ -365,6 +369,20 @@ static void flush_user_cache_page(struct vm_area_struct *vma, unsigned long vmad
>   	preempt_enable();
>   }
>   
> +void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
> +		unsigned int nr)
> +{
> +	void *kaddr = page_address(page);
> +
> +	for (;;) {
> +		flush_kernel_dcache_page_addr(kaddr);
> +		flush_kernel_icache_page(kaddr);
> +		if (--nr == 0)
> +			break;
> +		page += PAGE_SIZE;
> +	}
> +}
> +
>   static inline pte_t *get_ptep(struct mm_struct *mm, unsigned long addr)
>   {
>   	pte_t *ptep = NULL;
> @@ -393,26 +411,30 @@ static inline bool pte_needs_flush(pte_t pte)
>   		== (_PAGE_PRESENT | _PAGE_ACCESSED);
>   }
>   
> -void flush_dcache_page(struct page *page)
> +void flush_dcache_folio(struct folio *folio)
>   {
> -	struct address_space *mapping = page_mapping_file(page);
> -	struct vm_area_struct *mpnt;
> -	unsigned long offset;
> +	struct address_space *mapping = folio_flush_mapping(folio);
Likewise.
> +	struct vm_area_struct *vma;
>   	unsigned long addr, old_addr = 0;
> +	void *kaddr;
>   	unsigned long count = 0;
> +	unsigned long i, nr;
>   	pgoff_t pgoff;
>   
>   	if (mapping && !mapping_mapped(mapping)) {
> -		set_bit(PG_dcache_dirty, &page->flags);
> +		set_bit(PG_dcache_dirty, &folio->flags);
>   		return;
>   	}
>   
> -	flush_kernel_dcache_page_addr(page_address(page));
> +	nr = folio_nr_pages(folio);
> +	kaddr = folio_address(folio);
> +	for (i = 0; i < nr; i++)
> +		flush_kernel_dcache_page_addr(kaddr + i * PAGE_SIZE);
>   
>   	if (!mapping)
>   		return;
>   
> -	pgoff = page->index;
> +	pgoff = folio->index;
>   
>   	/*
>   	 * We have carefully arranged in arch_get_unmapped_area() that
> @@ -422,15 +444,29 @@ void flush_dcache_page(struct page *page)
>   	 * on machines that support equivalent aliasing
>   	 */
>   	flush_dcache_mmap_lock(mapping);
> -	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
> -		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
> -		addr = mpnt->vm_start + offset;
> -		if (parisc_requires_coherency()) {
> -			pte_t *ptep;
> +	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff + nr - 1) {
> +		unsigned long offset = pgoff - vma->vm_pgoff;
> +		unsigned long pfn = folio_pfn(folio);
> +
> +		addr = vma->vm_start;
> +		nr = folio_nr_pages(folio);
> +		if (offset > -nr) {
> +			pfn -= offset;
> +			nr += offset;
> +		} else {
> +			addr += offset * PAGE_SIZE;
> +		}
> +		if (addr + nr * PAGE_SIZE > vma->vm_end)
> +			nr = (vma->vm_end - addr) / PAGE_SIZE;
>   
> -			ptep = get_ptep(mpnt->vm_mm, addr);
> -			if (ptep && pte_needs_flush(*ptep))
> -				flush_user_cache_page(mpnt, addr);
> +		if (parisc_requires_coherency()) {
> +			for (i = 0; i < nr; i++) {
> +				pte_t *ptep = get_ptep(vma->vm_mm,
> +							addr + i * PAGE_SIZE);
> +				if (ptep && pte_needs_flush(*ptep))
> +					flush_user_cache_page(vma,
> +							addr + i * PAGE_SIZE);
> +			}
>   		} else {
>   			/*
>   			 * The TLB is the engine of coherence on parisc:
> @@ -443,27 +479,32 @@ void flush_dcache_page(struct page *page)
>   			 * in (until the user or kernel specifically
>   			 * accesses it, of course)
>   			 */
> -			flush_tlb_page(mpnt, addr);
> +			for (i = 0; i < nr; i++)
> +				flush_tlb_page(vma, addr + i * PAGE_SIZE);
>   			if (old_addr == 0 || (old_addr & (SHM_COLOUR - 1))
>   					!= (addr & (SHM_COLOUR - 1))) {
> -				__flush_cache_page(mpnt, addr, page_to_phys(page));
> +				for (i = 0; i < nr; i++)
> +					__flush_cache_page(vma,
> +						addr + i * PAGE_SIZE,
> +						(pfn + i) * PAGE_SIZE);
>   				/*
>   				 * Software is allowed to have any number
>   				 * of private mappings to a page.
>   				 */
> -				if (!(mpnt->vm_flags & VM_SHARED))
> +				if (!(vma->vm_flags & VM_SHARED))
>   					continue;
>   				if (old_addr)
>   					pr_err("INEQUIVALENT ALIASES 0x%lx and 0x%lx in file %pD\n",
> -						old_addr, addr, mpnt->vm_file);
> -				old_addr = addr;
> +						old_addr, addr, vma->vm_file);
> +				if (nr == folio_nr_pages(folio))
> +					old_addr = addr;
>   			}
>   		}
>   		WARN_ON(++count == 4096);
>   	}
>   	flush_dcache_mmap_unlock(mapping);
>   }
> -EXPORT_SYMBOL(flush_dcache_page);
> +EXPORT_SYMBOL(flush_dcache_folio);
>   
>   /* Defined in arch/parisc/kernel/pacache.S */
>   EXPORT_SYMBOL(flush_kernel_dcache_range_asm);


-- 
John David Anglin  dave.anglin@bell.net

