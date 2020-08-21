Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AABA24CD52
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 07:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgHUFlA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 01:41:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50681 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgHUFlA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Aug 2020 01:41:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BXr2H3pQFz9vCyR;
        Fri, 21 Aug 2020 07:40:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NBBJ9OMeuyRL; Fri, 21 Aug 2020 07:40:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BXr2H2m2nz9vCyQ;
        Fri, 21 Aug 2020 07:40:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 448BE8B87B;
        Fri, 21 Aug 2020 07:40:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id P7XZ6g2G32t3; Fri, 21 Aug 2020 07:40:08 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D9A78B75F;
        Fri, 21 Aug 2020 07:40:07 +0200 (CEST)
Subject: Re: [PATCH v5 5/8] mm: HUGE_VMAP arch support cleanup
To:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20200821044427.736424-1-npiggin@gmail.com>
 <20200821044427.736424-6-npiggin@gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9b67b892-9482-15dc-0c1e-c5d5a93a3c91@csgroup.eu>
Date:   Fri, 21 Aug 2020 07:40:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821044427.736424-6-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 21/08/2020 à 06:44, Nicholas Piggin a écrit :
> This changes the awkward approach where architectures provide init
> functions to determine which levels they can provide large mappings for,
> to one where the arch is queried for each call.
> 
> This removes code and indirection, and allows constant-folding of dead
> code for unsupported levels.

I think that in order to allow constant-folding of dead code for 
unsupported levels, you must define arch_vmap_xxx_supported() as static 
inline in a .h

If you have them in .c files, you'll get calls to tiny functions that 
will always return false, but will still be called and dead code won't 
be eliminated. And performance wise, that's probably not optimal either.

Christophe


> 
> This also adds a prot argument to the arch query. This is unused
> currently but could help with some architectures (e.g., some powerpc
> processors can't map uncacheable memory with large pages).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/arm64/mm/mmu.c                      | 12 +--
>   arch/powerpc/mm/book3s64/radix_pgtable.c | 10 ++-
>   arch/x86/mm/ioremap.c                    | 12 +--
>   include/linux/io.h                       |  9 ---
>   include/linux/vmalloc.h                  | 10 +++
>   init/main.c                              |  1 -
>   mm/ioremap.c                             | 96 +++++++++++-------------
>   7 files changed, 73 insertions(+), 77 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 75df62fea1b6..bbb3ccf6a7ce 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1304,12 +1304,13 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>   	return dt_virt;
>   }
>   
> -int __init arch_ioremap_p4d_supported(void)
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +bool arch_vmap_p4d_supported(pgprot_t prot)
>   {
> -	return 0;
> +	return false;
>   }
>   
> -int __init arch_ioremap_pud_supported(void)
> +bool arch_vmap_pud_supported(pgprot_t prot)
>   {
>   	/*
>   	 * Only 4k granule supports level 1 block mappings.
> @@ -1319,11 +1320,12 @@ int __init arch_ioremap_pud_supported(void)
>   	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>   }
>   
> -int __init arch_ioremap_pmd_supported(void)
> +bool arch_vmap_pmd_supported(pgprot_t prot)
>   {
> -	/* See arch_ioremap_pud_supported() */
> +	/* See arch_vmap_pud_supported() */
>   	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>   }
> +#endif
>   
>   int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>   {
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index ae823bba29f2..7d3a620c5adf 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -1182,13 +1182,14 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
>   	set_pte_at(mm, addr, ptep, pte);
>   }
>   
> -int __init arch_ioremap_pud_supported(void)
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +bool arch_vmap_pud_supported(pgprot_t prot)
>   {
>   	/* HPT does not cope with large pages in the vmalloc area */
>   	return radix_enabled();
>   }
>   
> -int __init arch_ioremap_pmd_supported(void)
> +bool arch_vmap_pmd_supported(pgprot_t prot)
>   {
>   	return radix_enabled();
>   }
> @@ -1197,6 +1198,7 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
>   {
>   	return 0;
>   }
> +#endif
>   
>   int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>   {
> @@ -1282,7 +1284,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>   	return 1;
>   }
>   
> -int __init arch_ioremap_p4d_supported(void)
> +bool arch_vmap_p4d_supported(pgprot_t prot)
>   {
> -	return 0;
> +	return false;
>   }
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 84d85dbd1dad..5b8b495ab4ed 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -481,24 +481,26 @@ void iounmap(volatile void __iomem *addr)
>   }
>   EXPORT_SYMBOL(iounmap);
>   
> -int __init arch_ioremap_p4d_supported(void)
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +bool arch_vmap_p4d_supported(pgprot_t prot)
>   {
> -	return 0;
> +	return false;
>   }
>   
> -int __init arch_ioremap_pud_supported(void)
> +bool arch_vmap_pud_supported(pgprot_t prot)
>   {
>   #ifdef CONFIG_X86_64
>   	return boot_cpu_has(X86_FEATURE_GBPAGES);
>   #else
> -	return 0;
> +	return false;
>   #endif
>   }
>   
> -int __init arch_ioremap_pmd_supported(void)
> +bool arch_vmap_pmd_supported(pgprot_t prot)
>   {
>   	return boot_cpu_has(X86_FEATURE_PSE);
>   }
> +#endif
>   
>   /*
>    * Convert a physical pointer to a virtual kernel pointer for /dev/mem
> diff --git a/include/linux/io.h b/include/linux/io.h
> index 8394c56babc2..f1effd4d7a3c 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -31,15 +31,6 @@ static inline int ioremap_page_range(unsigned long addr, unsigned long end,
>   }
>   #endif
>   
> -#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -void __init ioremap_huge_init(void);
> -int arch_ioremap_p4d_supported(void);
> -int arch_ioremap_pud_supported(void);
> -int arch_ioremap_pmd_supported(void);
> -#else
> -static inline void ioremap_huge_init(void) { }
> -#endif
> -
>   /*
>    * Managed iomap interface
>    */
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 0221f852a7e1..787d77ad7536 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -84,6 +84,16 @@ struct vmap_area {
>   	};
>   };
>   
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +bool arch_vmap_p4d_supported(pgprot_t prot);
> +bool arch_vmap_pud_supported(pgprot_t prot);
> +bool arch_vmap_pmd_supported(pgprot_t prot);
> +#else
> +static inline bool arch_vmap_p4d_supported(pgprot_t prot) { return false; }
> +static inline bool arch_vmap_pud_supported(pgprot_t prot) { return false; }
> +static inline bool arch_vmap_pmd_supported(pgprot_t prot) { return false; }
> +#endif
> +
>   /*
>    *	Highlevel APIs for driver use
>    */
> diff --git a/init/main.c b/init/main.c
> index ae78fb68d231..1c89aa127b8f 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -820,7 +820,6 @@ static void __init mm_init(void)
>   	pgtable_init();
>   	debug_objects_mem_init();
>   	vmalloc_init();
> -	ioremap_huge_init();
>   	/* Should be run before the first non-init thread is created */
>   	init_espfix_bsp();
>   	/* Should be run after espfix64 is set up. */
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 6016ae3227ad..b0032dbadaf7 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -16,49 +16,16 @@
>   #include "pgalloc-track.h"
>   
>   #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -static int __read_mostly ioremap_p4d_capable;
> -static int __read_mostly ioremap_pud_capable;
> -static int __read_mostly ioremap_pmd_capable;
> -static int __read_mostly ioremap_huge_disabled;
> +static bool __ro_after_init iomap_allow_huge = true;
>   
>   static int __init set_nohugeiomap(char *str)
>   {
> -	ioremap_huge_disabled = 1;
> +	iomap_allow_huge = false;
>   	return 0;
>   }
>   early_param("nohugeiomap", set_nohugeiomap);
> -
> -void __init ioremap_huge_init(void)
> -{
> -	if (!ioremap_huge_disabled) {
> -		if (arch_ioremap_p4d_supported())
> -			ioremap_p4d_capable = 1;
> -		if (arch_ioremap_pud_supported())
> -			ioremap_pud_capable = 1;
> -		if (arch_ioremap_pmd_supported())
> -			ioremap_pmd_capable = 1;
> -	}
> -}
> -
> -static inline int ioremap_p4d_enabled(void)
> -{
> -	return ioremap_p4d_capable;
> -}
> -
> -static inline int ioremap_pud_enabled(void)
> -{
> -	return ioremap_pud_capable;
> -}
> -
> -static inline int ioremap_pmd_enabled(void)
> -{
> -	return ioremap_pmd_capable;
> -}
> -
> -#else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
> -static inline int ioremap_p4d_enabled(void) { return 0; }
> -static inline int ioremap_pud_enabled(void) { return 0; }
> -static inline int ioremap_pmd_enabled(void) { return 0; }
> +#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> +static const bool iomap_allow_huge = false;
>   #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
>   
>   static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> @@ -81,9 +48,12 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>   }
>   
>   static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot)
> +			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
>   {
> -	if (!ioremap_pmd_enabled())
> +	if (max_page_shift < PMD_SHIFT)
> +		return 0;
> +
> +	if (!arch_vmap_pmd_supported(prot))
>   		return 0;
>   
>   	if ((end - addr) != PMD_SIZE)
> @@ -102,7 +72,8 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
>   }
>   
>   static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
> +			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
> +			pgtbl_mod_mask *mask)
>   {
>   	pmd_t *pmd;
>   	unsigned long next;
> @@ -113,7 +84,7 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>   	do {
>   		next = pmd_addr_end(addr, end);
>   
> -		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot)) {
> +		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot, max_page_shift)) {
>   			*mask |= PGTBL_PMD_MODIFIED;
>   			continue;
>   		}
> @@ -125,9 +96,12 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>   }
>   
>   static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot)
> +			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
>   {
> -	if (!ioremap_pud_enabled())
> +	if (max_page_shift < PUD_SHIFT)
> +		return 0;
> +
> +	if (!arch_vmap_pud_supported(prot))
>   		return 0;
>   
>   	if ((end - addr) != PUD_SIZE)
> @@ -146,7 +120,8 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
>   }
>   
>   static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
> +			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
> +			pgtbl_mod_mask *mask)
>   {
>   	pud_t *pud;
>   	unsigned long next;
> @@ -157,21 +132,24 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>   	do {
>   		next = pud_addr_end(addr, end);
>   
> -		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot)) {
> +		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot, max_page_shift)) {
>   			*mask |= PGTBL_PUD_MODIFIED;
>   			continue;
>   		}
>   
> -		if (vmap_pmd_range(pud, addr, next, phys_addr, prot, mask))
> +		if (vmap_pmd_range(pud, addr, next, phys_addr, prot, max_page_shift, mask))
>   			return -ENOMEM;
>   	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
>   	return 0;
>   }
>   
>   static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot)
> +			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift)
>   {
> -	if (!ioremap_p4d_enabled())
> +	if (max_page_shift < P4D_SHIFT)
> +		return 0;
> +
> +	if (!arch_vmap_p4d_supported(prot))
>   		return 0;
>   
>   	if ((end - addr) != P4D_SIZE)
> @@ -190,7 +168,8 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
>   }
>   
>   static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
> +			phys_addr_t phys_addr, pgprot_t prot, unsigned int max_page_shift,
> +			pgtbl_mod_mask *mask)
>   {
>   	p4d_t *p4d;
>   	unsigned long next;
> @@ -201,18 +180,19 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>   	do {
>   		next = p4d_addr_end(addr, end);
>   
> -		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot)) {
> +		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot, max_page_shift)) {
>   			*mask |= PGTBL_P4D_MODIFIED;
>   			continue;
>   		}
>   
> -		if (vmap_pud_range(p4d, addr, next, phys_addr, prot, mask))
> +		if (vmap_pud_range(p4d, addr, next, phys_addr, prot, max_page_shift, mask))
>   			return -ENOMEM;
>   	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
>   	return 0;
>   }
>   
> -int ioremap_page_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
> +static int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
> +			unsigned int max_page_shift)
>   {
>   	pgd_t *pgd;
>   	unsigned long start;
> @@ -227,7 +207,7 @@ int ioremap_page_range(unsigned long addr, unsigned long end, phys_addr_t phys_a
>   	pgd = pgd_offset_k(addr);
>   	do {
>   		next = pgd_addr_end(addr, end);
> -		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot, &mask);
> +		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot, max_page_shift, &mask);
>   		if (err)
>   			break;
>   	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
> @@ -240,6 +220,16 @@ int ioremap_page_range(unsigned long addr, unsigned long end, phys_addr_t phys_a
>   	return err;
>   }
>   
> +int ioremap_page_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
> +{
> +	unsigned int max_page_shift = PAGE_SHIFT;
> +
> +	if (iomap_allow_huge)
> +		max_page_shift = P4D_SHIFT;
> +
> +	return vmap_range(addr, end, phys_addr, prot, max_page_shift);
> +}
> +
>   #ifdef CONFIG_GENERIC_IOREMAP
>   void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
>   {
> 
