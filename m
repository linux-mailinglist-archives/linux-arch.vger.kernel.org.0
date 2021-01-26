Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60FE3046B8
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 19:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbhAZRUt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 12:20:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11590 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbhAZGKb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2021 01:10:31 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPx9Y07cczMQ80;
        Tue, 26 Jan 2021 14:08:01 +0800 (CST)
Received: from [10.174.177.80] (10.174.177.80) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 26 Jan 2021 14:07:54 +0800
Subject: Re: [PATCH v11 05/13] mm: HUGE_VMAP arch support cleanup
To:     Nicholas Piggin <npiggin@gmail.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20210126044510.2491820-1-npiggin@gmail.com>
 <20210126044510.2491820-6-npiggin@gmail.com>
From:   Ding Tianhong <dingtianhong@huawei.com>
Message-ID: <4dd92193-a5d8-545a-6503-d3db25ceb6e1@huawei.com>
Date:   Tue, 26 Jan 2021 14:07:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20210126044510.2491820-6-npiggin@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reviewed-by: Ding Tianhong <dingtianhong@huawei.com>

On 2021/1/26 12:45, Nicholas Piggin wrote:
> This changes the awkward approach where architectures provide init
> functions to determine which levels they can provide large mappings for,
> to one where the arch is queried for each call.
> 
> This removes code and indirection, and allows constant-folding of dead
> code for unsupported levels.
> 
> This also adds a prot argument to the arch query. This is unused
> currently but could help with some architectures (e.g., some powerpc
> processors can't map uncacheable memory with large pages).
> 
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com> [arm64]
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/arm64/include/asm/vmalloc.h         |  8 ++
>  arch/arm64/mm/mmu.c                      | 10 +--
>  arch/powerpc/include/asm/vmalloc.h       |  8 ++
>  arch/powerpc/mm/book3s64/radix_pgtable.c |  8 +-
>  arch/x86/include/asm/vmalloc.h           |  7 ++
>  arch/x86/mm/ioremap.c                    | 12 +--
>  include/linux/io.h                       |  9 ---
>  include/linux/vmalloc.h                  |  6 ++
>  init/main.c                              |  1 -
>  mm/ioremap.c                             | 94 ++++++++++--------------
>  10 files changed, 85 insertions(+), 78 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index 2ca708ab9b20..597b40405319 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -1,4 +1,12 @@
>  #ifndef _ASM_ARM64_VMALLOC_H
>  #define _ASM_ARM64_VMALLOC_H
>  
> +#include <asm/page.h>
> +
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +bool arch_vmap_p4d_supported(pgprot_t prot);
> +bool arch_vmap_pud_supported(pgprot_t prot);
> +bool arch_vmap_pmd_supported(pgprot_t prot);
> +#endif
> +
>  #endif /* _ASM_ARM64_VMALLOC_H */
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ae0c3d023824..1613d290cbd1 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1313,12 +1313,12 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>  	return dt_virt;
>  }
>  
> -int __init arch_ioremap_p4d_supported(void)
> +bool arch_vmap_p4d_supported(pgprot_t prot)
>  {
> -	return 0;
> +	return false;
>  }
>  
> -int __init arch_ioremap_pud_supported(void)
> +bool arch_vmap_pud_supported(pgprot_t prot)
>  {
>  	/*
>  	 * Only 4k granule supports level 1 block mappings.
> @@ -1328,9 +1328,9 @@ int __init arch_ioremap_pud_supported(void)
>  	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>  }
>  
> -int __init arch_ioremap_pmd_supported(void)
> +bool arch_vmap_pmd_supported(pgprot_t prot)
>  {
> -	/* See arch_ioremap_pud_supported() */
> +	/* See arch_vmap_pud_supported() */
>  	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>  }
>  
> diff --git a/arch/powerpc/include/asm/vmalloc.h b/arch/powerpc/include/asm/vmalloc.h
> index b992dfaaa161..105abb73f075 100644
> --- a/arch/powerpc/include/asm/vmalloc.h
> +++ b/arch/powerpc/include/asm/vmalloc.h
> @@ -1,4 +1,12 @@
>  #ifndef _ASM_POWERPC_VMALLOC_H
>  #define _ASM_POWERPC_VMALLOC_H
>  
> +#include <asm/page.h>
> +
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +bool arch_vmap_p4d_supported(pgprot_t prot);
> +bool arch_vmap_pud_supported(pgprot_t prot);
> +bool arch_vmap_pmd_supported(pgprot_t prot);
> +#endif
> +
>  #endif /* _ASM_POWERPC_VMALLOC_H */
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index 98f0b243c1ab..743807fc210f 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -1082,13 +1082,13 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
>  	set_pte_at(mm, addr, ptep, pte);
>  }
>  
> -int __init arch_ioremap_pud_supported(void)
> +bool arch_vmap_pud_supported(pgprot_t prot)
>  {
>  	/* HPT does not cope with large pages in the vmalloc area */
>  	return radix_enabled();
>  }
>  
> -int __init arch_ioremap_pmd_supported(void)
> +bool arch_vmap_pmd_supported(pgprot_t prot)
>  {
>  	return radix_enabled();
>  }
> @@ -1182,7 +1182,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>  	return 1;
>  }
>  
> -int __init arch_ioremap_p4d_supported(void)
> +bool arch_vmap_p4d_supported(pgprot_t prot)
>  {
> -	return 0;
> +	return false;
>  }
> diff --git a/arch/x86/include/asm/vmalloc.h b/arch/x86/include/asm/vmalloc.h
> index 29837740b520..094ea2b565f3 100644
> --- a/arch/x86/include/asm/vmalloc.h
> +++ b/arch/x86/include/asm/vmalloc.h
> @@ -1,6 +1,13 @@
>  #ifndef _ASM_X86_VMALLOC_H
>  #define _ASM_X86_VMALLOC_H
>  
> +#include <asm/page.h>
>  #include <asm/pgtable_areas.h>
>  
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +bool arch_vmap_p4d_supported(pgprot_t prot);
> +bool arch_vmap_pud_supported(pgprot_t prot);
> +bool arch_vmap_pmd_supported(pgprot_t prot);
> +#endif
> +
>  #endif /* _ASM_X86_VMALLOC_H */
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 9e5ccc56f8e0..fbaf0c447986 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -481,24 +481,26 @@ void iounmap(volatile void __iomem *addr)
>  }
>  EXPORT_SYMBOL(iounmap);
>  
> -int __init arch_ioremap_p4d_supported(void)
> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> +bool arch_vmap_p4d_supported(pgprot_t prot)
>  {
> -	return 0;
> +	return false;
>  }
>  
> -int __init arch_ioremap_pud_supported(void)
> +bool arch_vmap_pud_supported(pgprot_t prot)
>  {
>  #ifdef CONFIG_X86_64
>  	return boot_cpu_has(X86_FEATURE_GBPAGES);
>  #else
> -	return 0;
> +	return false;
>  #endif
>  }
>  
> -int __init arch_ioremap_pmd_supported(void)
> +bool arch_vmap_pmd_supported(pgprot_t prot)
>  {
>  	return boot_cpu_has(X86_FEATURE_PSE);
>  }
> +#endif
>  
>  /*
>   * Convert a physical pointer to a virtual kernel pointer for /dev/mem
> diff --git a/include/linux/io.h b/include/linux/io.h
> index 8394c56babc2..f1effd4d7a3c 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -31,15 +31,6 @@ static inline int ioremap_page_range(unsigned long addr, unsigned long end,
>  }
>  #endif
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
>  /*
>   * Managed iomap interface
>   */
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 80c0181c411d..00bd62bd701e 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -83,6 +83,12 @@ struct vmap_area {
>  	};
>  };
>  
> +#ifndef CONFIG_HAVE_ARCH_HUGE_VMAP
> +static inline bool arch_vmap_p4d_supported(pgprot_t prot) { return false; }
> +static inline bool arch_vmap_pud_supported(pgprot_t prot) { return false; }
> +static inline bool arch_vmap_pmd_supported(pgprot_t prot) { return false; }
> +#endif
> +
>  /*
>   *	Highlevel APIs for driver use
>   */
> diff --git a/init/main.c b/init/main.c
> index c68d784376ca..bf9389e5b2e4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -834,7 +834,6 @@ static void __init mm_init(void)
>  	pgtable_init();
>  	debug_objects_mem_init();
>  	vmalloc_init();
> -	ioremap_huge_init();
>  	/* Should be run before the first non-init thread is created */
>  	init_espfix_bsp();
>  	/* Should be run after espfix64 is set up. */
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 3f4d36f9745a..3264d0203785 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -16,49 +16,16 @@
>  #include "pgalloc-track.h"
>  
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -static int __read_mostly ioremap_p4d_capable;
> -static int __read_mostly ioremap_pud_capable;
> -static int __read_mostly ioremap_pmd_capable;
> -static int __read_mostly ioremap_huge_disabled;
> +static bool __ro_after_init iomap_max_page_shift = PAGE_SHIFT;
>  
>  static int __init set_nohugeiomap(char *str)
>  {
> -	ioremap_huge_disabled = 1;
> +	iomap_max_page_shift = P4D_SHIFT;
>  	return 0;
>  }
>  early_param("nohugeiomap", set_nohugeiomap);
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
> +static const bool iomap_max_page_shift = PAGE_SHIFT;
>  #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
>  
>  static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> @@ -82,9 +49,13 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  }
>  
>  static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot)
> +			phys_addr_t phys_addr, pgprot_t prot,
> +			unsigned int max_page_shift)
>  {
> -	if (!ioremap_pmd_enabled())
> +	if (max_page_shift < PMD_SHIFT)
> +		return 0;
> +
> +	if (!arch_vmap_pmd_supported(prot))
>  		return 0;
>  
>  	if ((end - addr) != PMD_SIZE)
> @@ -104,7 +75,7 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
>  
>  static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  			phys_addr_t phys_addr, pgprot_t prot,
> -			pgtbl_mod_mask *mask)
> +			unsigned int max_page_shift, pgtbl_mod_mask *mask)
>  {
>  	pmd_t *pmd;
>  	unsigned long next;
> @@ -115,7 +86,8 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  	do {
>  		next = pmd_addr_end(addr, end);
>  
> -		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot)) {
> +		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot,
> +					max_page_shift)) {
>  			*mask |= PGTBL_PMD_MODIFIED;
>  			continue;
>  		}
> @@ -127,9 +99,13 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  }
>  
>  static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot)
> +			phys_addr_t phys_addr, pgprot_t prot,
> +			unsigned int max_page_shift)
>  {
> -	if (!ioremap_pud_enabled())
> +	if (max_page_shift < PUD_SHIFT)
> +		return 0;
> +
> +	if (!arch_vmap_pud_supported(prot))
>  		return 0;
>  
>  	if ((end - addr) != PUD_SIZE)
> @@ -149,7 +125,7 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
>  
>  static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>  			phys_addr_t phys_addr, pgprot_t prot,
> -			pgtbl_mod_mask *mask)
> +			unsigned int max_page_shift, pgtbl_mod_mask *mask)
>  {
>  	pud_t *pud;
>  	unsigned long next;
> @@ -160,21 +136,27 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>  	do {
>  		next = pud_addr_end(addr, end);
>  
> -		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot)) {
> +		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot,
> +					max_page_shift)) {
>  			*mask |= PGTBL_PUD_MODIFIED;
>  			continue;
>  		}
>  
> -		if (vmap_pmd_range(pud, addr, next, phys_addr, prot, mask))
> +		if (vmap_pmd_range(pud, addr, next, phys_addr, prot,
> +					max_page_shift, mask))
>  			return -ENOMEM;
>  	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
>  	return 0;
>  }
>  
>  static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot)
> +			phys_addr_t phys_addr, pgprot_t prot,
> +			unsigned int max_page_shift)
>  {
> -	if (!ioremap_p4d_enabled())
> +	if (max_page_shift < P4D_SHIFT)
> +		return 0;
> +
> +	if (!arch_vmap_p4d_supported(prot))
>  		return 0;
>  
>  	if ((end - addr) != P4D_SIZE)
> @@ -194,7 +176,7 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
>  
>  static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>  			phys_addr_t phys_addr, pgprot_t prot,
> -			pgtbl_mod_mask *mask)
> +			unsigned int max_page_shift, pgtbl_mod_mask *mask)
>  {
>  	p4d_t *p4d;
>  	unsigned long next;
> @@ -205,19 +187,22 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>  	do {
>  		next = p4d_addr_end(addr, end);
>  
> -		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot)) {
> +		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot,
> +					max_page_shift)) {
>  			*mask |= PGTBL_P4D_MODIFIED;
>  			continue;
>  		}
>  
> -		if (vmap_pud_range(p4d, addr, next, phys_addr, prot, mask))
> +		if (vmap_pud_range(p4d, addr, next, phys_addr, prot,
> +					max_page_shift, mask))
>  			return -ENOMEM;
>  	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
>  	return 0;
>  }
>  
>  static int vmap_range(unsigned long addr, unsigned long end,
> -			phys_addr_t phys_addr, pgprot_t prot)
> +			phys_addr_t phys_addr, pgprot_t prot,
> +			unsigned int max_page_shift)
>  {
>  	pgd_t *pgd;
>  	unsigned long start;
> @@ -232,7 +217,8 @@ static int vmap_range(unsigned long addr, unsigned long end,
>  	pgd = pgd_offset_k(addr);
>  	do {
>  		next = pgd_addr_end(addr, end);
> -		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot, &mask);
> +		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot,
> +					max_page_shift, &mask);
>  		if (err)
>  			break;
>  	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
> @@ -248,7 +234,7 @@ static int vmap_range(unsigned long addr, unsigned long end,
>  int ioremap_page_range(unsigned long addr,
>  		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
>  {
> -	return vmap_range(addr, end, phys_addr, prot);
> +	return vmap_range(addr, end, phys_addr, prot, iomap_max_page_shift);
>  }
>  
>  #ifdef CONFIG_GENERIC_IOREMAP
> 

