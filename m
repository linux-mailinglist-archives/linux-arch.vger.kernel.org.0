Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB231F444
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 04:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhBSDqd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 22:46:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13363 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSDqb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Feb 2021 22:46:31 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DhcrZ1w6Zz7mt5;
        Fri, 19 Feb 2021 11:44:14 +0800 (CST)
Received: from [10.174.177.80] (10.174.177.80) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Feb 2021 11:45:37 +0800
Subject: Re: [PATCH v12 13/14] mm/vmalloc: Hugepage vmalloc mappings
To:     Nicholas Piggin <npiggin@gmail.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
 <20210202110515.3575274-14-npiggin@gmail.com>
From:   Ding Tianhong <dingtianhong@huawei.com>
Message-ID: <e18ef38c-ecef-b15c-29b1-bd4acf0e7fe5@huawei.com>
Date:   Fri, 19 Feb 2021 11:45:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20210202110515.3575274-14-npiggin@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nicholas:

I met some problem for this patch, like this:

kva = vmalloc(3*1024k);

remap_vmalloc_range(xxx, kva, xxx)

It failed because that the check for page_count(page) is null so return, it break the some logic for current modules.
because the new huge page is not valid for composed page.

I think some guys really don't get used to the changes for the vmalloc that the small pages was transparency to the hugepage
when the size is bigger than the PMD_SIZE.

can we think about give a new static huge page to fix it? just like use a a new vmalloc_huge_xxx function to disginguish the current function,
the user could choose to use the transparent hugepage or static hugepage for vmalloc.

Thanks
Ding


On 2021/2/2 19:05, Nicholas Piggin wrote:
> Support huge page vmalloc mappings. Config option HAVE_ARCH_HUGE_VMALLOC
> enables support on architectures that define HAVE_ARCH_HUGE_VMAP and
> supports PMD sized vmap mappings.
> 
> vmalloc will attempt to allocate PMD-sized pages if allocating PMD size
> or larger, and fall back to small pages if that was unsuccessful.
> 
> Architectures must ensure that any arch specific vmalloc allocations
> that require PAGE_SIZE mappings (e.g., module allocations vs strict
> module rwx) use the VM_NOHUGE flag to inhibit larger mappings.
> 
> This can result in more internal fragmentation and memory overhead for a
> given allocation, an option nohugevmalloc is added to disable at boot.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/Kconfig            |  11 ++
>  include/linux/vmalloc.h |  21 ++++
>  mm/page_alloc.c         |   5 +-
>  mm/vmalloc.c            | 215 +++++++++++++++++++++++++++++++---------
>  4 files changed, 205 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 24862d15f3a3..eef170e0c9b8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -724,6 +724,17 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>  config HAVE_ARCH_HUGE_VMAP
>  	bool
>  
> +#
> +#  Archs that select this would be capable of PMD-sized vmaps (i.e.,
> +#  arch_vmap_pmd_supported() returns true), and they must make no assumptions
> +#  that vmalloc memory is mapped with PAGE_SIZE ptes. The VM_NO_HUGE_VMAP flag
> +#  can be used to prohibit arch-specific allocations from using hugepages to
> +#  help with this (e.g., modules may require it).
> +#
> +config HAVE_ARCH_HUGE_VMALLOC
> +	depends on HAVE_ARCH_HUGE_VMAP
> +	bool
> +
>  config ARCH_WANT_HUGE_PMD_SHARE
>  	bool
>  
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 99ea72d547dc..93270adf5db5 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -25,6 +25,7 @@ struct notifier_block;		/* in notifier.h */
>  #define VM_NO_GUARD		0x00000040      /* don't add guard page */
>  #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
>  #define VM_MAP_PUT_PAGES	0x00000100	/* put pages and free array in vfree */
> +#define VM_NO_HUGE_VMAP		0x00000200	/* force PAGE_SIZE pte mapping */
>  
>  /*
>   * VM_KASAN is used slighly differently depending on CONFIG_KASAN_VMALLOC.
> @@ -59,6 +60,9 @@ struct vm_struct {
>  	unsigned long		size;
>  	unsigned long		flags;
>  	struct page		**pages;
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
> +	unsigned int		page_order;
> +#endif
>  	unsigned int		nr_pages;
>  	phys_addr_t		phys_addr;
>  	const void		*caller;
> @@ -193,6 +197,22 @@ void free_vm_area(struct vm_struct *area);
>  extern struct vm_struct *remove_vm_area(const void *addr);
>  extern struct vm_struct *find_vm_area(const void *addr);
>  
> +static inline bool is_vm_area_hugepages(const void *addr)
> +{
> +	/*
> +	 * This may not 100% tell if the area is mapped with > PAGE_SIZE
> +	 * page table entries, if for some reason the architecture indicates
> +	 * larger sizes are available but decides not to use them, nothing
> +	 * prevents that. This only indicates the size of the physical page
> +	 * allocated in the vmalloc layer.
> +	 */
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
> +	return find_vm_area(addr)->page_order > 0;
> +#else
> +	return false;
> +#endif
> +}
> +
>  #ifdef CONFIG_MMU
>  int vmap_range(unsigned long addr, unsigned long end,
>  			phys_addr_t phys_addr, pgprot_t prot,
> @@ -210,6 +230,7 @@ static inline void set_vm_flush_reset_perms(void *addr)
>  	if (vm)
>  		vm->flags |= VM_FLUSH_RESET_PERMS;
>  }
> +
>  #else
>  static inline int
>  map_kernel_range_noflush(unsigned long start, unsigned long size,
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 519a60d5b6f7..1116ce45744b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -72,6 +72,7 @@
>  #include <linux/padata.h>
>  #include <linux/khugepaged.h>
>  #include <linux/buffer_head.h>
> +#include <linux/vmalloc.h>
>  
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
> @@ -8240,6 +8241,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>  	void *table = NULL;
>  	gfp_t gfp_flags;
>  	bool virt;
> +	bool huge;
>  
>  	/* allow the kernel cmdline to have a say */
>  	if (!numentries) {
> @@ -8307,6 +8309,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>  		} else if (get_order(size) >= MAX_ORDER || hashdist) {
>  			table = __vmalloc(size, gfp_flags);
>  			virt = true;
> +			huge = is_vm_area_hugepages(table);
>  		} else {
>  			/*
>  			 * If bucketsize is not a power-of-two, we may free
> @@ -8323,7 +8326,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>  
>  	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
>  		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
> -		virt ? "vmalloc" : "linear");
> +		virt ? (huge ? "vmalloc hugepage" : "vmalloc") : "linear");
>  
>  	if (_hash_shift)
>  		*_hash_shift = log2qty;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 47ab4338cfff..e9a28de04182 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -42,6 +42,19 @@
>  #include "internal.h"
>  #include "pgalloc-track.h"
>  
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
> +static bool __ro_after_init vmap_allow_huge = true;
> +
> +static int __init set_nohugevmalloc(char *str)
> +{
> +	vmap_allow_huge = false;
> +	return 0;
> +}
> +early_param("nohugevmalloc", set_nohugevmalloc);
> +#else /* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
> +static const bool vmap_allow_huge = false;
> +#endif	/* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
> +
>  bool is_vmalloc_addr(const void *x)
>  {
>  	unsigned long addr = (unsigned long)x;
> @@ -483,31 +496,12 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
>  	return 0;
>  }
>  
> -/**
> - * map_kernel_range_noflush - map kernel VM area with the specified pages
> - * @addr: start of the VM area to map
> - * @size: size of the VM area to map
> - * @prot: page protection flags to use
> - * @pages: pages to map
> - *
> - * Map PFN_UP(@size) pages at @addr.  The VM area @addr and @size specify should
> - * have been allocated using get_vm_area() and its friends.
> - *
> - * NOTE:
> - * This function does NOT do any cache flushing.  The caller is responsible for
> - * calling flush_cache_vmap() on to-be-mapped areas before calling this
> - * function.
> - *
> - * RETURNS:
> - * 0 on success, -errno on failure.
> - */
> -int map_kernel_range_noflush(unsigned long addr, unsigned long size,
> -			     pgprot_t prot, struct page **pages)
> +static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
> +		pgprot_t prot, struct page **pages)
>  {
>  	unsigned long start = addr;
> -	unsigned long end = addr + size;
> -	unsigned long next;
>  	pgd_t *pgd;
> +	unsigned long next;
>  	int err = 0;
>  	int nr = 0;
>  	pgtbl_mod_mask mask = 0;
> @@ -529,6 +523,66 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
>  	return 0;
>  }
>  
> +static int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> +		pgprot_t prot, struct page **pages, unsigned int page_shift)
> +{
> +	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
> +
> +	WARN_ON(page_shift < PAGE_SHIFT);
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> +			page_shift == PAGE_SHIFT)
> +		return vmap_small_pages_range_noflush(addr, end, prot, pages);
> +
> +	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
> +		int err;
> +
> +		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
> +					__pa(page_address(pages[i])), prot,
> +					page_shift);
> +		if (err)
> +			return err;
> +
> +		addr += 1UL << page_shift;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vmap_pages_range(unsigned long addr, unsigned long end,
> +		pgprot_t prot, struct page **pages, unsigned int page_shift)
> +{
> +	int err;
> +
> +	err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
> +	flush_cache_vmap(addr, end);
> +	return err;
> +}
> +
> +/**
> + * map_kernel_range_noflush - map kernel VM area with the specified pages
> + * @addr: start of the VM area to map
> + * @size: size of the VM area to map
> + * @prot: page protection flags to use
> + * @pages: pages to map
> + *
> + * Map PFN_UP(@size) pages at @addr.  The VM area @addr and @size specify should
> + * have been allocated using get_vm_area() and its friends.
> + *
> + * NOTE:
> + * This function does NOT do any cache flushing.  The caller is responsible for
> + * calling flush_cache_vmap() on to-be-mapped areas before calling this
> + * function.
> + *
> + * RETURNS:
> + * 0 on success, -errno on failure.
> + */
> +int map_kernel_range_noflush(unsigned long addr, unsigned long size,
> +			     pgprot_t prot, struct page **pages)
> +{
> +	return vmap_pages_range_noflush(addr, addr + size, prot, pages, PAGE_SHIFT);
> +}
> +
>  int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,
>  		struct page **pages)
>  {
> @@ -2112,6 +2166,24 @@ EXPORT_SYMBOL(vm_map_ram);
>  
>  static struct vm_struct *vmlist __initdata;
>  
> +static inline unsigned int vm_area_page_order(struct vm_struct *vm)
> +{
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
> +	return vm->page_order;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static inline void set_vm_area_page_order(struct vm_struct *vm, unsigned int order)
> +{
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
> +	vm->page_order = order;
> +#else
> +	BUG_ON(order != 0);
> +#endif
> +}
> +
>  /**
>   * vm_area_add_early - add vmap area early during boot
>   * @vm: vm_struct to add
> @@ -2422,6 +2494,7 @@ static inline void set_area_direct_map(const struct vm_struct *area,
>  {
>  	int i;
>  
> +	/* HUGE_VMALLOC passes small pages to set_direct_map */
>  	for (i = 0; i < area->nr_pages; i++)
>  		if (page_address(area->pages[i]))
>  			set_direct_map(area->pages[i]);
> @@ -2431,6 +2504,7 @@ static inline void set_area_direct_map(const struct vm_struct *area,
>  static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
>  {
>  	unsigned long start = ULONG_MAX, end = 0;
> +	unsigned int page_order = vm_area_page_order(area);
>  	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
>  	int flush_dmap = 0;
>  	int i;
> @@ -2455,11 +2529,14 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
>  	 * map. Find the start and end range of the direct mappings to make sure
>  	 * the vm_unmap_aliases() flush includes the direct map.
>  	 */
> -	for (i = 0; i < area->nr_pages; i++) {
> +	for (i = 0; i < area->nr_pages; i += 1U << page_order) {
>  		unsigned long addr = (unsigned long)page_address(area->pages[i]);
>  		if (addr) {
> +			unsigned long page_size;
> +
> +			page_size = PAGE_SIZE << page_order;
>  			start = min(addr, start);
> -			end = max(addr + PAGE_SIZE, end);
> +			end = max(addr + page_size, end);
>  			flush_dmap = 1;
>  		}
>  	}
> @@ -2500,13 +2577,14 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  	vm_remove_mappings(area, deallocate_pages);
>  
>  	if (deallocate_pages) {
> +		unsigned int page_order = vm_area_page_order(area);
>  		int i;
>  
> -		for (i = 0; i < area->nr_pages; i++) {
> +		for (i = 0; i < area->nr_pages; i += 1U << page_order) {
>  			struct page *page = area->pages[i];
>  
>  			BUG_ON(!page);
> -			__free_pages(page, 0);
> +			__free_pages(page, page_order);
>  		}
>  		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
>  
> @@ -2697,15 +2775,19 @@ EXPORT_SYMBOL_GPL(vmap_pfn);
>  #endif /* CONFIG_VMAP_PFN */
>  
>  static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> -				 pgprot_t prot, int node)
> +				 pgprot_t prot, unsigned int page_shift,
> +				 int node)
>  {
>  	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
> -	unsigned int nr_pages = get_vm_area_size(area) >> PAGE_SHIFT;
> +	unsigned long addr = (unsigned long)area->addr;
> +	unsigned long size = get_vm_area_size(area);
>  	unsigned long array_size;
> -	unsigned int i;
> +	unsigned int nr_small_pages = size >> PAGE_SHIFT;
> +	unsigned int page_order;
>  	struct page **pages;
> +	unsigned int i;
>  
> -	array_size = (unsigned long)nr_pages * sizeof(struct page *);
> +	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
>  	gfp_mask |= __GFP_NOWARN;
>  	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
>  		gfp_mask |= __GFP_HIGHMEM;
> @@ -2724,30 +2806,37 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	}
>  
>  	area->pages = pages;
> -	area->nr_pages = nr_pages;
> +	area->nr_pages = nr_small_pages;
> +	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
>  
> -	for (i = 0; i < area->nr_pages; i++) {
> -		struct page *page;
> +	page_order = vm_area_page_order(area);
>  
> -		if (node == NUMA_NO_NODE)
> -			page = alloc_page(gfp_mask);
> -		else
> -			page = alloc_pages_node(node, gfp_mask, 0);
> +	/*
> +	 * Careful, we allocate and map page_order pages, but tracking is done
> +	 * per PAGE_SIZE page so as to keep the vm_struct APIs independent of
> +	 * the physical/mapped size.
> +	 */
> +	for (i = 0; i < area->nr_pages; i += 1U << page_order) {
> +		struct page *page;
> +		int p;
>  
> +		page = alloc_pages_node(node, gfp_mask, page_order);
>  		if (unlikely(!page)) {
>  			/* Successfully allocated i pages, free them in __vfree() */
>  			area->nr_pages = i;
>  			atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
>  			goto fail;
>  		}
> -		area->pages[i] = page;
> +
> +		for (p = 0; p < (1U << page_order); p++)
> +			area->pages[i + p] = page + p;
> +
>  		if (gfpflags_allow_blocking(gfp_mask))
>  			cond_resched();
>  	}
>  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
>  
> -	if (map_kernel_range((unsigned long)area->addr, get_vm_area_size(area),
> -			prot, pages) < 0)
> +	if (vmap_pages_range(addr, addr + size, prot, pages, page_shift) < 0)
>  		goto fail;
>  
>  	return area->addr;
> @@ -2755,7 +2844,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  fail:
>  	warn_alloc(gfp_mask, NULL,
>  			  "vmalloc: allocation failure, allocated %ld of %ld bytes",
> -			  (area->nr_pages*PAGE_SIZE), area->size);
> +			  (area->nr_pages*PAGE_SIZE), size);
>  	__vfree(area->addr);
>  	return NULL;
>  }
> @@ -2786,19 +2875,43 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	struct vm_struct *area;
>  	void *addr;
>  	unsigned long real_size = size;
> +	unsigned long real_align = align;
> +	unsigned int shift = PAGE_SHIFT;
>  
> -	size = PAGE_ALIGN(size);
>  	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
>  		goto fail;
>  
> -	area = __get_vm_area_node(real_size, align, VM_ALLOC | VM_UNINITIALIZED |
> +	if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP) &&
> +			arch_vmap_pmd_supported(prot)) {
> +		unsigned long size_per_node;
> +
> +		/*
> +		 * Try huge pages. Only try for PAGE_KERNEL allocations,
> +		 * others like modules don't yet expect huge pages in
> +		 * their allocations due to apply_to_page_range not
> +		 * supporting them.
> +		 */
> +
> +		size_per_node = size;
> +		if (node == NUMA_NO_NODE)
> +			size_per_node /= num_online_nodes();
> +		if (size_per_node >= PMD_SIZE) {
> +			shift = PMD_SHIFT;
> +			align = max(real_align, 1UL << shift);
> +			size = ALIGN(real_size, 1UL << shift);
> +		}
> +	}
> +
> +again:
> +	size = PAGE_ALIGN(size);
> +	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
>  				vm_flags, start, end, node, gfp_mask, caller);
>  	if (!area)
>  		goto fail;
>  
> -	addr = __vmalloc_area_node(area, gfp_mask, prot, node);
> +	addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
>  	if (!addr)
> -		return NULL;
> +		goto fail;
>  
>  	/*
>  	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
> @@ -2812,8 +2925,18 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	return addr;
>  
>  fail:
> -	warn_alloc(gfp_mask, NULL,
> +	if (shift > PAGE_SHIFT) {
> +		shift = PAGE_SHIFT;
> +		align = real_align;
> +		size = real_size;
> +		goto again;
> +	}
> +
> +	if (!area) {
> +		/* Warn for area allocation, page allocations already warn */
> +		warn_alloc(gfp_mask, NULL,
>  			  "vmalloc: allocation failure: %lu bytes", real_size);
> +	}
>  	return NULL;
>  }
>  
> 

