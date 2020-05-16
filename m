Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475D11D62FA
	for <lists+linux-arch@lfdr.de>; Sat, 16 May 2020 19:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgEPRUk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 May 2020 13:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgEPRUj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 16 May 2020 13:20:39 -0400
Received: from kernel.org (unknown [77.124.237.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B2C2065C;
        Sat, 16 May 2020 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589649636;
        bh=IeA0raojPlenut/DBeELqvxBTfUPBQNLD0csXWioRdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mz+/82TnbME6MlnCBfzsUOaa/kaMz5TR1zUyfpDbt8BKxlL3IqD0HD1zOKZH2cA9f
         WC3ywud25HOyCHsaBpFeqJQpncrNn5YrWhGvhqxyf4aHKZuOoUwKjXyGxPRtjhW4k+
         inpQi8O88x+nVu6LFQ/DYfDFiCHUwS4EqVIbMplE=
Date:   Sat, 16 May 2020 20:20:15 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4 03/14] arm64: add support for folded p4d page tables
Message-ID: <20200516172015.GA1118872@kernel.org>
References: <20200414153455.21744-1-rppt@kernel.org>
 <20200414153455.21744-4-rppt@kernel.org>
 <20200515114012.49f45aa01efb7d8b918bc0f5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515114012.49f45aa01efb7d8b918bc0f5@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 15, 2020 at 11:40:12AM -0700, Andrew Morton wrote:
> On Tue, 14 Apr 2020 18:34:44 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Implement primitives necessary for the 4th level folding, add walks of p4d
> > level where appropriate, replace 5level-fixup.h with pgtable-nop4d.h and
> > remove __ARCH_USE_5LEVEL_HACK.
> 
> This needed some rework due to arm changes in linux-next.  Please check
> my handiwork and test it once I've merged this into linux-next?

Looks ok to me. It passed defconfig and a couple of randconfig builds
and qemu-system-aarch64 boots find with this.

> Rejects were
> 
> --- arch/arm64/include/asm/pgtable.h~arm64-add-support-for-folded-p4d-page-tables
> +++ arch/arm64/include/asm/pgtable.h
> @@ -596,49 +604,50 @@ static inline phys_addr_t pud_page_paddr
>  
>  #define pud_ERROR(pud)		__pud_error(__FILE__, __LINE__, pud_val(pud))
>  
> -#define pgd_none(pgd)		(!pgd_val(pgd))
> -#define pgd_bad(pgd)		(!(pgd_val(pgd) & 2))
> -#define pgd_present(pgd)	(pgd_val(pgd))
> +#define p4d_none(p4d)		(!p4d_val(p4d))
> +#define p4d_bad(p4d)		(!(p4d_val(p4d) & 2))
> +#define p4d_present(p4d)	(p4d_val(p4d))
>  
> -static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
> +static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
>  {
> -	if (in_swapper_pgdir(pgdp)) {
> -		set_swapper_pgd(pgdp, pgd);
> +	if (in_swapper_pgdir(p4dp)) {
> +		set_swapper_pgd((pgd_t *)p4dp, __pgd(p4d_val(p4d)));
>  		return;
>  	}
>  
> -	WRITE_ONCE(*pgdp, pgd);
> +	WRITE_ONCE(*p4dp, p4d);
>  	dsb(ishst);
>  	isb();
>  }
>  
> -static inline void pgd_clear(pgd_t *pgdp)
> +static inline void p4d_clear(p4d_t *p4dp)
>  {
> -	set_pgd(pgdp, __pgd(0));
> +	set_p4d(p4dp, __p4d(0));
>  }
>  
> -static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
> +static inline phys_addr_t p4d_page_paddr(p4d_t p4d)
>  {
> -	return __pgd_to_phys(pgd);
> +	return __p4d_to_phys(p4d);
>  }
>  
>  /* Find an entry in the frst-level page table. */
>  #define pud_index(addr)		(((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
>  
> -#define pud_offset_phys(dir, addr)	(pgd_page_paddr(READ_ONCE(*(dir))) + pud_index(addr) * sizeof(pud_t))
> +#define pud_offset_phys(dir, addr)	(p4d_page_paddr(READ_ONCE(*(dir))) + pud_index(addr) * sizeof(pud_t))
>  #define pud_offset(dir, addr)		((pud_t *)__va(pud_offset_phys((dir), (addr))))
>  
>  #define pud_set_fixmap(addr)		((pud_t *)set_fixmap_offset(FIX_PUD, addr))
> -#define pud_set_fixmap_offset(pgd, addr)	pud_set_fixmap(pud_offset_phys(pgd, addr))
> +#define pud_set_fixmap_offset(p4d, addr)	pud_set_fixmap(pud_offset_phys(p4d, addr))
>  #define pud_clear_fixmap()		clear_fixmap(FIX_PUD)
>  
> -#define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(__pgd_to_phys(pgd)))
> +#define p4d_page(p4d)		pfn_to_page(__phys_to_pfn(__p4d_to_phys(p4d)))
>  
>  /* use ONLY for statically allocated translation tables */
>  #define pud_offset_kimg(dir,addr)	((pud_t *)__phys_to_kimg(pud_offset_phys((dir), (addr))))
>  
>  #else
>  
> +#define p4d_page_paddr(p4d)	({ BUILD_BUG(); 0;})
>  #define pgd_page_paddr(pgd)	({ BUILD_BUG(); 0;})
>  
>  /* Match pud_offset folding in <asm/generic/pgtable-nopud.h> */
> 
> 
> 
> and
> 
> --- arch/arm64/kvm/mmu.c~arm64-add-support-for-folded-p4d-page-tables
> +++ arch/arm64/kvm/mmu.c
> @@ -469,7 +517,7 @@ static void stage2_flush_memslot(struct
>  	do {
>  		next = stage2_pgd_addr_end(kvm, addr, end);
>  		if (!stage2_pgd_none(kvm, *pgd))
> -			stage2_flush_puds(kvm, pgd, addr, next);
> +			stage2_flush_p4ds(kvm, pgd, addr, next);
>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> 
> 
> Result:
> 
> From: Mike Rapoport <rppt@linux.ibm.com>
> Subject: arm64: add support for folded p4d page tables
> 
> Implement primitives necessary for the 4th level folding, add walks of p4d
> level where appropriate, replace 5level-fixup.h with pgtable-nop4d.h and
> remove __ARCH_USE_5LEVEL_HACK.
> 
> Link: http://lkml.kernel.org/r/20200414153455.21744-4-rppt@kernel.org
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: James Morse <james.morse@arm.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/arm64/include/asm/kvm_mmu.h        |   10 -
>  arch/arm64/include/asm/pgalloc.h        |   10 -
>  arch/arm64/include/asm/pgtable-types.h  |    5 
>  arch/arm64/include/asm/pgtable.h        |   37 ++-
>  arch/arm64/include/asm/stage2_pgtable.h |   48 +++--
>  arch/arm64/kernel/hibernate.c           |   44 +++-
>  arch/arm64/kvm/mmu.c                    |  209 ++++++++++++++++++----
>  arch/arm64/mm/fault.c                   |    9 
>  arch/arm64/mm/hugetlbpage.c             |   15 +
>  arch/arm64/mm/kasan_init.c              |   26 ++
>  arch/arm64/mm/mmu.c                     |   52 +++--
>  arch/arm64/mm/pageattr.c                |    7 
>  12 files changed, 368 insertions(+), 104 deletions(-)
> 
> --- a/arch/arm64/include/asm/kvm_mmu.h~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/include/asm/kvm_mmu.h
> @@ -172,8 +172,8 @@ void kvm_clear_hyp_idmap(void);
>  	__pmd(__phys_to_pmd_val(__pa(ptep)) | PMD_TYPE_TABLE)
>  #define kvm_mk_pud(pmdp)					\
>  	__pud(__phys_to_pud_val(__pa(pmdp)) | PMD_TYPE_TABLE)
> -#define kvm_mk_pgd(pudp)					\
> -	__pgd(__phys_to_pgd_val(__pa(pudp)) | PUD_TYPE_TABLE)
> +#define kvm_mk_p4d(pmdp)					\
> +	__p4d(__phys_to_p4d_val(__pa(pmdp)) | PUD_TYPE_TABLE)
>  
>  #define kvm_set_pud(pudp, pud)		set_pud(pudp, pud)
>  
> @@ -299,6 +299,12 @@ static inline bool kvm_s2pud_young(pud_t
>  #define hyp_pud_table_empty(pudp) kvm_page_empty(pudp)
>  #endif
>  
> +#ifdef __PAGETABLE_P4D_FOLDED
> +#define hyp_p4d_table_empty(p4dp) (0)
> +#else
> +#define hyp_p4d_table_empty(p4dp) kvm_page_empty(p4dp)
> +#endif
> +
>  struct kvm;
>  
>  #define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))
> --- a/arch/arm64/include/asm/pgalloc.h~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/include/asm/pgalloc.h
> @@ -73,17 +73,17 @@ static inline void pud_free(struct mm_st
>  	free_page((unsigned long)pudp);
>  }
>  
> -static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pudp, pgdval_t prot)
> +static inline void __p4d_populate(p4d_t *p4dp, phys_addr_t pudp, p4dval_t prot)
>  {
> -	set_pgd(pgdp, __pgd(__phys_to_pgd_val(pudp) | prot));
> +	set_p4d(p4dp, __p4d(__phys_to_p4d_val(pudp) | prot));
>  }
>  
> -static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, pud_t *pudp)
> +static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4dp, pud_t *pudp)
>  {
> -	__pgd_populate(pgdp, __pa(pudp), PUD_TYPE_TABLE);
> +	__p4d_populate(p4dp, __pa(pudp), PUD_TYPE_TABLE);
>  }
>  #else
> -static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pudp, pgdval_t prot)
> +static inline void __p4d_populate(p4d_t *p4dp, phys_addr_t pudp, p4dval_t prot)
>  {
>  	BUILD_BUG();
>  }
> --- a/arch/arm64/include/asm/pgtable.h~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/include/asm/pgtable.h
> @@ -298,6 +298,11 @@ static inline pte_t pgd_pte(pgd_t pgd)
>  	return __pte(pgd_val(pgd));
>  }
>  
> +static inline pte_t p4d_pte(p4d_t p4d)
> +{
> +	return __pte(p4d_val(p4d));
> +}
> +
>  static inline pte_t pud_pte(pud_t pud)
>  {
>  	return __pte(pud_val(pud));
> @@ -401,6 +406,9 @@ static inline pmd_t pmd_mkdevmap(pmd_t p
>  
>  #define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
>  
> +#define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
> +#define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)
> +
>  #define __pgd_to_phys(pgd)	__pte_to_phys(pgd_pte(pgd))
>  #define __phys_to_pgd_val(phys)	__phys_to_pte_val(phys)
>  
> @@ -592,49 +600,50 @@ static inline phys_addr_t pud_page_paddr
>  
>  #define pud_ERROR(pud)		__pud_error(__FILE__, __LINE__, pud_val(pud))
>  
> -#define pgd_none(pgd)		(!pgd_val(pgd))
> -#define pgd_bad(pgd)		(!(pgd_val(pgd) & 2))
> -#define pgd_present(pgd)	(pgd_val(pgd))
> +#define p4d_none(p4d)		(!p4d_val(p4d))
> +#define p4d_bad(p4d)		(!(p4d_val(p4d) & 2))
> +#define p4d_present(p4d)	(p4d_val(p4d))
>  
> -static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
> +static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
>  {
> -	if (in_swapper_pgdir(pgdp)) {
> -		set_swapper_pgd(pgdp, pgd);
> +	if (in_swapper_pgdir(p4dp)) {
> +		set_swapper_pgd((pgd_t *)p4dp, __pgd(p4d_val(p4d)));
>  		return;
>  	}
>  
> -	WRITE_ONCE(*pgdp, pgd);
> +	WRITE_ONCE(*p4dp, p4d);
>  	dsb(ishst);
>  	isb();
>  }
>  
> -static inline void pgd_clear(pgd_t *pgdp)
> +static inline void p4d_clear(p4d_t *p4dp)
>  {
> -	set_pgd(pgdp, __pgd(0));
> +	set_p4d(p4dp, __p4d(0));
>  }
>  
> -static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
> +static inline phys_addr_t p4d_page_paddr(p4d_t p4d)
>  {
> -	return __pgd_to_phys(pgd);
> +	return __p4d_to_phys(p4d);
>  }
>  
>  /* Find an entry in the frst-level page table. */
>  #define pud_index(addr)		(((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
>  
> -#define pud_offset_phys(dir, addr)	(pgd_page_paddr(READ_ONCE(*(dir))) + pud_index(addr) * sizeof(pud_t))
> +#define pud_offset_phys(dir, addr)	(p4d_page_paddr(READ_ONCE(*(dir))) + pud_index(addr) * sizeof(pud_t))
>  #define pud_offset(dir, addr)		((pud_t *)__va(pud_offset_phys((dir), (addr))))
>  
>  #define pud_set_fixmap(addr)		((pud_t *)set_fixmap_offset(FIX_PUD, addr))
> -#define pud_set_fixmap_offset(pgd, addr)	pud_set_fixmap(pud_offset_phys(pgd, addr))
> +#define pud_set_fixmap_offset(p4d, addr)	pud_set_fixmap(pud_offset_phys(p4d, addr))
>  #define pud_clear_fixmap()		clear_fixmap(FIX_PUD)
>  
> -#define pgd_page(pgd)			phys_to_page(__pgd_to_phys(pgd))
> +#define p4d_page(p4d)		pfn_to_page(__phys_to_pfn(__p4d_to_phys(p4d)))
>  
>  /* use ONLY for statically allocated translation tables */
>  #define pud_offset_kimg(dir,addr)	((pud_t *)__phys_to_kimg(pud_offset_phys((dir), (addr))))
>  
>  #else
>  
> +#define p4d_page_paddr(p4d)	({ BUILD_BUG(); 0;})
>  #define pgd_page_paddr(pgd)	({ BUILD_BUG(); 0;})
>  
>  /* Match pud_offset folding in <asm/generic/pgtable-nopud.h> */
> --- a/arch/arm64/include/asm/pgtable-types.h~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/include/asm/pgtable-types.h
> @@ -14,6 +14,7 @@
>  typedef u64 pteval_t;
>  typedef u64 pmdval_t;
>  typedef u64 pudval_t;
> +typedef u64 p4dval_t;
>  typedef u64 pgdval_t;
>  
>  /*
> @@ -44,13 +45,11 @@ typedef struct { pteval_t pgprot; } pgpr
>  #define __pgprot(x)	((pgprot_t) { (x) } )
>  
>  #if CONFIG_PGTABLE_LEVELS == 2
> -#define __ARCH_USE_5LEVEL_HACK
>  #include <asm-generic/pgtable-nopmd.h>
>  #elif CONFIG_PGTABLE_LEVELS == 3
> -#define __ARCH_USE_5LEVEL_HACK
>  #include <asm-generic/pgtable-nopud.h>
>  #elif CONFIG_PGTABLE_LEVELS == 4
> -#include <asm-generic/5level-fixup.h>
> +#include <asm-generic/pgtable-nop4d.h>
>  #endif
>  
>  #endif	/* __ASM_PGTABLE_TYPES_H */
> --- a/arch/arm64/include/asm/stage2_pgtable.h~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/include/asm/stage2_pgtable.h
> @@ -68,41 +68,67 @@ static inline bool kvm_stage2_has_pud(st
>  #define S2_PUD_SIZE			(1UL << S2_PUD_SHIFT)
>  #define S2_PUD_MASK			(~(S2_PUD_SIZE - 1))
>  
> -static inline bool stage2_pgd_none(struct kvm *kvm, pgd_t pgd)
> +#define stage2_pgd_none(kvm, pgd)		pgd_none(pgd)
> +#define stage2_pgd_clear(kvm, pgd)		pgd_clear(pgd)
> +#define stage2_pgd_present(kvm, pgd)		pgd_present(pgd)
> +#define stage2_pgd_populate(kvm, pgd, p4d)	pgd_populate(NULL, pgd, p4d)
> +
> +static inline p4d_t *stage2_p4d_offset(struct kvm *kvm,
> +				       pgd_t *pgd, unsigned long address)
> +{
> +	return p4d_offset(pgd, address);
> +}
> +
> +static inline void stage2_p4d_free(struct kvm *kvm, p4d_t *p4d)
> +{
> +}
> +
> +static inline bool stage2_p4d_table_empty(struct kvm *kvm, p4d_t *p4dp)
> +{
> +	return false;
> +}
> +
> +static inline phys_addr_t stage2_p4d_addr_end(struct kvm *kvm,
> +					      phys_addr_t addr, phys_addr_t end)
> +{
> +	return end;
> +}
> +
> +static inline bool stage2_p4d_none(struct kvm *kvm, p4d_t p4d)
>  {
>  	if (kvm_stage2_has_pud(kvm))
> -		return pgd_none(pgd);
> +		return p4d_none(p4d);
>  	else
>  		return 0;
>  }
>  
> -static inline void stage2_pgd_clear(struct kvm *kvm, pgd_t *pgdp)
> +static inline void stage2_p4d_clear(struct kvm *kvm, p4d_t *p4dp)
>  {
>  	if (kvm_stage2_has_pud(kvm))
> -		pgd_clear(pgdp);
> +		p4d_clear(p4dp);
>  }
>  
> -static inline bool stage2_pgd_present(struct kvm *kvm, pgd_t pgd)
> +static inline bool stage2_p4d_present(struct kvm *kvm, p4d_t p4d)
>  {
>  	if (kvm_stage2_has_pud(kvm))
> -		return pgd_present(pgd);
> +		return p4d_present(p4d);
>  	else
>  		return 1;
>  }
>  
> -static inline void stage2_pgd_populate(struct kvm *kvm, pgd_t *pgd, pud_t *pud)
> +static inline void stage2_p4d_populate(struct kvm *kvm, p4d_t *p4d, pud_t *pud)
>  {
>  	if (kvm_stage2_has_pud(kvm))
> -		pgd_populate(NULL, pgd, pud);
> +		p4d_populate(NULL, p4d, pud);
>  }
>  
>  static inline pud_t *stage2_pud_offset(struct kvm *kvm,
> -				       pgd_t *pgd, unsigned long address)
> +				       p4d_t *p4d, unsigned long address)
>  {
>  	if (kvm_stage2_has_pud(kvm))
> -		return pud_offset(pgd, address);
> +		return pud_offset(p4d, address);
>  	else
> -		return (pud_t *)pgd;
> +		return (pud_t *)p4d;
>  }
>  
>  static inline void stage2_pud_free(struct kvm *kvm, pud_t *pud)
> --- a/arch/arm64/kernel/hibernate.c~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/kernel/hibernate.c
> @@ -184,6 +184,7 @@ static int trans_pgd_map_page(pgd_t *tra
>  		       pgprot_t pgprot)
>  {
>  	pgd_t *pgdp;
> +	p4d_t *p4dp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
>  	pte_t *ptep;
> @@ -196,7 +197,15 @@ static int trans_pgd_map_page(pgd_t *tra
>  		pgd_populate(&init_mm, pgdp, pudp);
>  	}
>  
> -	pudp = pud_offset(pgdp, dst_addr);
> +	p4dp = p4d_offset(pgdp, dst_addr);
> +	if (p4d_none(READ_ONCE(*p4dp))) {
> +		pudp = (void *)get_safe_page(GFP_ATOMIC);
> +		if (!pudp)
> +			return -ENOMEM;
> +		p4d_populate(&init_mm, p4dp, pudp);
> +	}
> +
> +	pudp = pud_offset(p4dp, dst_addr);
>  	if (pud_none(READ_ONCE(*pudp))) {
>  		pmdp = (void *)get_safe_page(GFP_ATOMIC);
>  		if (!pmdp)
> @@ -419,7 +428,7 @@ static int copy_pmd(pud_t *dst_pudp, pud
>  	return 0;
>  }
>  
> -static int copy_pud(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
> +static int copy_pud(p4d_t *dst_p4dp, p4d_t *src_p4dp, unsigned long start,
>  		    unsigned long end)
>  {
>  	pud_t *dst_pudp;
> @@ -427,15 +436,15 @@ static int copy_pud(pgd_t *dst_pgdp, pgd
>  	unsigned long next;
>  	unsigned long addr = start;
>  
> -	if (pgd_none(READ_ONCE(*dst_pgdp))) {
> +	if (p4d_none(READ_ONCE(*dst_p4dp))) {
>  		dst_pudp = (pud_t *)get_safe_page(GFP_ATOMIC);
>  		if (!dst_pudp)
>  			return -ENOMEM;
> -		pgd_populate(&init_mm, dst_pgdp, dst_pudp);
> +		p4d_populate(&init_mm, dst_p4dp, dst_pudp);
>  	}
> -	dst_pudp = pud_offset(dst_pgdp, start);
> +	dst_pudp = pud_offset(dst_p4dp, start);
>  
> -	src_pudp = pud_offset(src_pgdp, start);
> +	src_pudp = pud_offset(src_p4dp, start);
>  	do {
>  		pud_t pud = READ_ONCE(*src_pudp);
>  
> @@ -454,6 +463,27 @@ static int copy_pud(pgd_t *dst_pgdp, pgd
>  	return 0;
>  }
>  
> +static int copy_p4d(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
> +		    unsigned long end)
> +{
> +	p4d_t *dst_p4dp;
> +	p4d_t *src_p4dp;
> +	unsigned long next;
> +	unsigned long addr = start;
> +
> +	dst_p4dp = p4d_offset(dst_pgdp, start);
> +	src_p4dp = p4d_offset(src_pgdp, start);
> +	do {
> +		next = p4d_addr_end(addr, end);
> +		if (p4d_none(READ_ONCE(*src_p4dp)))
> +			continue;
> +		if (copy_pud(dst_p4dp, src_p4dp, addr, next))
> +			return -ENOMEM;
> +	} while (dst_p4dp++, src_p4dp++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
>  static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
>  			    unsigned long end)
>  {
> @@ -466,7 +496,7 @@ static int copy_page_tables(pgd_t *dst_p
>  		next = pgd_addr_end(addr, end);
>  		if (pgd_none(READ_ONCE(*src_pgdp)))
>  			continue;
> -		if (copy_pud(dst_pgdp, src_pgdp, addr, next))
> +		if (copy_p4d(dst_pgdp, src_pgdp, addr, next))
>  			return -ENOMEM;
>  	} while (dst_pgdp++, src_pgdp++, addr = next, addr != end);
>  
> --- a/arch/arm64/kvm/mmu.c~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/kvm/mmu.c
> @@ -158,13 +158,22 @@ static void *mmu_memory_cache_alloc(stru
>  
>  static void clear_stage2_pgd_entry(struct kvm *kvm, pgd_t *pgd, phys_addr_t addr)
>  {
> -	pud_t *pud_table __maybe_unused = stage2_pud_offset(kvm, pgd, 0UL);
> +	p4d_t *p4d_table __maybe_unused = stage2_p4d_offset(kvm, pgd, 0UL);
>  	stage2_pgd_clear(kvm, pgd);
>  	kvm_tlb_flush_vmid_ipa(kvm, addr);
> -	stage2_pud_free(kvm, pud_table);
> +	stage2_p4d_free(kvm, p4d_table);
>  	put_page(virt_to_page(pgd));
>  }
>  
> +static void clear_stage2_p4d_entry(struct kvm *kvm, p4d_t *p4d, phys_addr_t addr)
> +{
> +	pud_t *pud_table __maybe_unused = stage2_pud_offset(kvm, p4d, 0);
> +	stage2_p4d_clear(kvm, p4d);
> +	kvm_tlb_flush_vmid_ipa(kvm, addr);
> +	stage2_pud_free(kvm, pud_table);
> +	put_page(virt_to_page(p4d));
> +}
> +
>  static void clear_stage2_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr)
>  {
>  	pmd_t *pmd_table __maybe_unused = stage2_pmd_offset(kvm, pud, 0);
> @@ -208,12 +217,20 @@ static inline void kvm_pud_populate(pud_
>  	dsb(ishst);
>  }
>  
> -static inline void kvm_pgd_populate(pgd_t *pgdp, pud_t *pudp)
> +static inline void kvm_p4d_populate(p4d_t *p4dp, pud_t *pudp)
>  {
> -	WRITE_ONCE(*pgdp, kvm_mk_pgd(pudp));
> +	WRITE_ONCE(*p4dp, kvm_mk_p4d(pudp));
>  	dsb(ishst);
>  }
>  
> +static inline void kvm_pgd_populate(pgd_t *pgdp, p4d_t *p4dp)
> +{
> +#ifndef __PAGETABLE_P4D_FOLDED
> +	WRITE_ONCE(*pgdp, kvm_mk_pgd(p4dp));
> +	dsb(ishst);
> +#endif
> +}
> +
>  /*
>   * Unmapping vs dcache management:
>   *
> @@ -293,13 +310,13 @@ static void unmap_stage2_pmds(struct kvm
>  		clear_stage2_pud_entry(kvm, pud, start_addr);
>  }
>  
> -static void unmap_stage2_puds(struct kvm *kvm, pgd_t *pgd,
> +static void unmap_stage2_puds(struct kvm *kvm, p4d_t *p4d,
>  		       phys_addr_t addr, phys_addr_t end)
>  {
>  	phys_addr_t next, start_addr = addr;
>  	pud_t *pud, *start_pud;
>  
> -	start_pud = pud = stage2_pud_offset(kvm, pgd, addr);
> +	start_pud = pud = stage2_pud_offset(kvm, p4d, addr);
>  	do {
>  		next = stage2_pud_addr_end(kvm, addr, end);
>  		if (!stage2_pud_none(kvm, *pud)) {
> @@ -317,6 +334,23 @@ static void unmap_stage2_puds(struct kvm
>  	} while (pud++, addr = next, addr != end);
>  
>  	if (stage2_pud_table_empty(kvm, start_pud))
> +		clear_stage2_p4d_entry(kvm, p4d, start_addr);
> +}
> +
> +static void unmap_stage2_p4ds(struct kvm *kvm, pgd_t *pgd,
> +		       phys_addr_t addr, phys_addr_t end)
> +{
> +	phys_addr_t next, start_addr = addr;
> +	p4d_t *p4d, *start_p4d;
> +
> +	start_p4d = p4d = stage2_p4d_offset(kvm, pgd, addr);
> +	do {
> +		next = stage2_p4d_addr_end(kvm, addr, end);
> +		if (!stage2_p4d_none(kvm, *p4d))
> +			unmap_stage2_puds(kvm, p4d, addr, next);
> +	} while (p4d++, addr = next, addr != end);
> +
> +	if (stage2_p4d_table_empty(kvm, start_p4d))
>  		clear_stage2_pgd_entry(kvm, pgd, start_addr);
>  }
>  
> @@ -351,7 +385,7 @@ static void unmap_stage2_range(struct kv
>  			break;
>  		next = stage2_pgd_addr_end(kvm, addr, end);
>  		if (!stage2_pgd_none(kvm, *pgd))
> -			unmap_stage2_puds(kvm, pgd, addr, next);
> +			unmap_stage2_p4ds(kvm, pgd, addr, next);
>  		/*
>  		 * If the range is too large, release the kvm->mmu_lock
>  		 * to prevent starvation and lockup detector warnings.
> @@ -391,13 +425,13 @@ static void stage2_flush_pmds(struct kvm
>  	} while (pmd++, addr = next, addr != end);
>  }
>  
> -static void stage2_flush_puds(struct kvm *kvm, pgd_t *pgd,
> +static void stage2_flush_puds(struct kvm *kvm, p4d_t *p4d,
>  			      phys_addr_t addr, phys_addr_t end)
>  {
>  	pud_t *pud;
>  	phys_addr_t next;
>  
> -	pud = stage2_pud_offset(kvm, pgd, addr);
> +	pud = stage2_pud_offset(kvm, p4d, addr);
>  	do {
>  		next = stage2_pud_addr_end(kvm, addr, end);
>  		if (!stage2_pud_none(kvm, *pud)) {
> @@ -409,6 +443,20 @@ static void stage2_flush_puds(struct kvm
>  	} while (pud++, addr = next, addr != end);
>  }
>  
> +static void stage2_flush_p4ds(struct kvm *kvm, pgd_t *pgd,
> +			      phys_addr_t addr, phys_addr_t end)
> +{
> +	p4d_t *p4d;
> +	phys_addr_t next;
> +
> +	p4d = stage2_p4d_offset(kvm, pgd, addr);
> +	do {
> +		next = stage2_p4d_addr_end(kvm, addr, end);
> +		if (!stage2_p4d_none(kvm, *p4d))
> +			stage2_flush_puds(kvm, p4d, addr, next);
> +	} while (p4d++, addr = next, addr != end);
> +}
> +
>  static void stage2_flush_memslot(struct kvm *kvm,
>  				 struct kvm_memory_slot *memslot)
>  {
> @@ -421,7 +469,7 @@ static void stage2_flush_memslot(struct
>  	do {
>  		next = stage2_pgd_addr_end(kvm, addr, end);
>  		if (!stage2_pgd_none(kvm, *pgd))
> -			stage2_flush_puds(kvm, pgd, addr, next);
> +			stage2_flush_p4ds(kvm, pgd, addr, next);
>  
>  		if (next != end)
>  			cond_resched_lock(&kvm->mmu_lock);
> @@ -454,12 +502,21 @@ static void stage2_flush_vm(struct kvm *
>  
>  static void clear_hyp_pgd_entry(pgd_t *pgd)
>  {
> -	pud_t *pud_table __maybe_unused = pud_offset(pgd, 0UL);
> +	p4d_t *p4d_table __maybe_unused = p4d_offset(pgd, 0UL);
>  	pgd_clear(pgd);
> -	pud_free(NULL, pud_table);
> +	p4d_free(NULL, p4d_table);
>  	put_page(virt_to_page(pgd));
>  }
>  
> +static void clear_hyp_p4d_entry(p4d_t *p4d)
> +{
> +	pud_t *pud_table __maybe_unused = pud_offset(p4d, 0);
> +	VM_BUG_ON(p4d_huge(*p4d));
> +	p4d_clear(p4d);
> +	pud_free(NULL, pud_table);
> +	put_page(virt_to_page(p4d));
> +}
> +
>  static void clear_hyp_pud_entry(pud_t *pud)
>  {
>  	pmd_t *pmd_table __maybe_unused = pmd_offset(pud, 0);
> @@ -511,12 +568,12 @@ static void unmap_hyp_pmds(pud_t *pud, p
>  		clear_hyp_pud_entry(pud);
>  }
>  
> -static void unmap_hyp_puds(pgd_t *pgd, phys_addr_t addr, phys_addr_t end)
> +static void unmap_hyp_puds(p4d_t *p4d, phys_addr_t addr, phys_addr_t end)
>  {
>  	phys_addr_t next;
>  	pud_t *pud, *start_pud;
>  
> -	start_pud = pud = pud_offset(pgd, addr);
> +	start_pud = pud = pud_offset(p4d, addr);
>  	do {
>  		next = pud_addr_end(addr, end);
>  		/* Hyp doesn't use huge puds */
> @@ -525,6 +582,23 @@ static void unmap_hyp_puds(pgd_t *pgd, p
>  	} while (pud++, addr = next, addr != end);
>  
>  	if (hyp_pud_table_empty(start_pud))
> +		clear_hyp_p4d_entry(p4d);
> +}
> +
> +static void unmap_hyp_p4ds(pgd_t *pgd, phys_addr_t addr, phys_addr_t end)
> +{
> +	phys_addr_t next;
> +	p4d_t *p4d, *start_p4d;
> +
> +	start_p4d = p4d = p4d_offset(pgd, addr);
> +	do {
> +		next = p4d_addr_end(addr, end);
> +		/* Hyp doesn't use huge p4ds */
> +		if (!p4d_none(*p4d))
> +			unmap_hyp_puds(p4d, addr, next);
> +	} while (p4d++, addr = next, addr != end);
> +
> +	if (hyp_p4d_table_empty(start_p4d))
>  		clear_hyp_pgd_entry(pgd);
>  }
>  
> @@ -548,7 +622,7 @@ static void __unmap_hyp_range(pgd_t *pgd
>  	do {
>  		next = pgd_addr_end(addr, end);
>  		if (!pgd_none(*pgd))
> -			unmap_hyp_puds(pgd, addr, next);
> +			unmap_hyp_p4ds(pgd, addr, next);
>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> @@ -658,7 +732,7 @@ static int create_hyp_pmd_mappings(pud_t
>  	return 0;
>  }
>  
> -static int create_hyp_pud_mappings(pgd_t *pgd, unsigned long start,
> +static int create_hyp_pud_mappings(p4d_t *p4d, unsigned long start,
>  				   unsigned long end, unsigned long pfn,
>  				   pgprot_t prot)
>  {
> @@ -669,7 +743,7 @@ static int create_hyp_pud_mappings(pgd_t
>  
>  	addr = start;
>  	do {
> -		pud = pud_offset(pgd, addr);
> +		pud = pud_offset(p4d, addr);
>  
>  		if (pud_none_or_clear_bad(pud)) {
>  			pmd = pmd_alloc_one(NULL, addr);
> @@ -691,12 +765,45 @@ static int create_hyp_pud_mappings(pgd_t
>  	return 0;
>  }
>  
> +static int create_hyp_p4d_mappings(pgd_t *pgd, unsigned long start,
> +				   unsigned long end, unsigned long pfn,
> +				   pgprot_t prot)
> +{
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	unsigned long addr, next;
> +	int ret;
> +
> +	addr = start;
> +	do {
> +		p4d = p4d_offset(pgd, addr);
> +
> +		if (p4d_none(*p4d)) {
> +			pud = pud_alloc_one(NULL, addr);
> +			if (!pud) {
> +				kvm_err("Cannot allocate Hyp pud\n");
> +				return -ENOMEM;
> +			}
> +			kvm_p4d_populate(p4d, pud);
> +			get_page(virt_to_page(p4d));
> +		}
> +
> +		next = p4d_addr_end(addr, end);
> +		ret = create_hyp_pud_mappings(p4d, addr, next, pfn, prot);
> +		if (ret)
> +			return ret;
> +		pfn += (next - addr) >> PAGE_SHIFT;
> +	} while (addr = next, addr != end);
> +
> +	return 0;
> +}
> +
>  static int __create_hyp_mappings(pgd_t *pgdp, unsigned long ptrs_per_pgd,
>  				 unsigned long start, unsigned long end,
>  				 unsigned long pfn, pgprot_t prot)
>  {
>  	pgd_t *pgd;
> -	pud_t *pud;
> +	p4d_t *p4d;
>  	unsigned long addr, next;
>  	int err = 0;
>  
> @@ -707,18 +814,18 @@ static int __create_hyp_mappings(pgd_t *
>  		pgd = pgdp + kvm_pgd_index(addr, ptrs_per_pgd);
>  
>  		if (pgd_none(*pgd)) {
> -			pud = pud_alloc_one(NULL, addr);
> -			if (!pud) {
> -				kvm_err("Cannot allocate Hyp pud\n");
> +			p4d = p4d_alloc_one(NULL, addr);
> +			if (!p4d) {
> +				kvm_err("Cannot allocate Hyp p4d\n");
>  				err = -ENOMEM;
>  				goto out;
>  			}
> -			kvm_pgd_populate(pgd, pud);
> +			kvm_pgd_populate(pgd, p4d);
>  			get_page(virt_to_page(pgd));
>  		}
>  
>  		next = pgd_addr_end(addr, end);
> -		err = create_hyp_pud_mappings(pgd, addr, next, pfn, prot);
> +		err = create_hyp_p4d_mappings(pgd, addr, next, pfn, prot);
>  		if (err)
>  			goto out;
>  		pfn += (next - addr) >> PAGE_SHIFT;
> @@ -1015,22 +1122,40 @@ void kvm_free_stage2_pgd(struct kvm *kvm
>  		free_pages_exact(pgd, stage2_pgd_size(kvm));
>  }
>  
> -static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> +static p4d_t *stage2_get_p4d(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>  			     phys_addr_t addr)
>  {
>  	pgd_t *pgd;
> -	pud_t *pud;
> +	p4d_t *p4d;
>  
>  	pgd = kvm->arch.pgd + stage2_pgd_index(kvm, addr);
>  	if (stage2_pgd_none(kvm, *pgd)) {
>  		if (!cache)
>  			return NULL;
> -		pud = mmu_memory_cache_alloc(cache);
> -		stage2_pgd_populate(kvm, pgd, pud);
> +		p4d = mmu_memory_cache_alloc(cache);
> +		stage2_pgd_populate(kvm, pgd, p4d);
>  		get_page(virt_to_page(pgd));
>  	}
>  
> -	return stage2_pud_offset(kvm, pgd, addr);
> +	return stage2_p4d_offset(kvm, pgd, addr);
> +}
> +
> +static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> +			     phys_addr_t addr)
> +{
> +	p4d_t *p4d;
> +	pud_t *pud;
> +
> +	p4d = stage2_get_p4d(kvm, cache, addr);
> +	if (stage2_p4d_none(kvm, *p4d)) {
> +		if (!cache)
> +			return NULL;
> +		pud = mmu_memory_cache_alloc(cache);
> +		stage2_p4d_populate(kvm, p4d, pud);
> +		get_page(virt_to_page(p4d));
> +	}
> +
> +	return stage2_pud_offset(kvm, p4d, addr);
>  }
>  
>  static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> @@ -1423,18 +1548,18 @@ static void stage2_wp_pmds(struct kvm *k
>  }
>  
>  /**
> - * stage2_wp_puds - write protect PGD range
> + * stage2_wp_puds - write protect P4D range
>   * @pgd:	pointer to pgd entry
>   * @addr:	range start address
>   * @end:	range end address
>   */
> -static void  stage2_wp_puds(struct kvm *kvm, pgd_t *pgd,
> +static void  stage2_wp_puds(struct kvm *kvm, p4d_t *p4d,
>  			    phys_addr_t addr, phys_addr_t end)
>  {
>  	pud_t *pud;
>  	phys_addr_t next;
>  
> -	pud = stage2_pud_offset(kvm, pgd, addr);
> +	pud = stage2_pud_offset(kvm, p4d, addr);
>  	do {
>  		next = stage2_pud_addr_end(kvm, addr, end);
>  		if (!stage2_pud_none(kvm, *pud)) {
> @@ -1449,6 +1574,26 @@ static void  stage2_wp_puds(struct kvm *
>  }
>  
>  /**
> + * stage2_wp_p4ds - write protect PGD range
> + * @pgd:	pointer to pgd entry
> + * @addr:	range start address
> + * @end:	range end address
> + */
> +static void  stage2_wp_p4ds(struct kvm *kvm, pgd_t *pgd,
> +			    phys_addr_t addr, phys_addr_t end)
> +{
> +	p4d_t *p4d;
> +	phys_addr_t next;
> +
> +	p4d = stage2_p4d_offset(kvm, pgd, addr);
> +	do {
> +		next = stage2_p4d_addr_end(kvm, addr, end);
> +		if (!stage2_p4d_none(kvm, *p4d))
> +			stage2_wp_puds(kvm, p4d, addr, next);
> +	} while (p4d++, addr = next, addr != end);
> +}
> +
> +/**
>   * stage2_wp_range() - write protect stage2 memory region range
>   * @kvm:	The KVM pointer
>   * @addr:	Start address of range
> @@ -1475,7 +1620,7 @@ static void stage2_wp_range(struct kvm *
>  			break;
>  		next = stage2_pgd_addr_end(kvm, addr, end);
>  		if (stage2_pgd_present(kvm, *pgd))
> -			stage2_wp_puds(kvm, pgd, addr, next);
> +			stage2_wp_p4ds(kvm, pgd, addr, next);
>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> --- a/arch/arm64/mm/fault.c~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/mm/fault.c
> @@ -145,6 +145,7 @@ static void show_pte(unsigned long addr)
>  	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
>  
>  	do {
> +		p4d_t *p4dp, p4d;
>  		pud_t *pudp, pud;
>  		pmd_t *pmdp, pmd;
>  		pte_t *ptep, pte;
> @@ -152,7 +153,13 @@ static void show_pte(unsigned long addr)
>  		if (pgd_none(pgd) || pgd_bad(pgd))
>  			break;
>  
> -		pudp = pud_offset(pgdp, addr);
> +		p4dp = p4d_offset(pgdp, addr);
> +		p4d = READ_ONCE(*p4dp);
> +		pr_cont(", p4d=%016llx", p4d_val(p4d));
> +		if (p4d_none(p4d) || p4d_bad(p4d))
> +			break;
> +
> +		pudp = pud_offset(p4dp, addr);
>  		pud = READ_ONCE(*pudp);
>  		pr_cont(", pud=%016llx", pud_val(pud));
>  		if (pud_none(pud) || pud_bad(pud))
> --- a/arch/arm64/mm/hugetlbpage.c~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/mm/hugetlbpage.c
> @@ -67,11 +67,13 @@ static int find_num_contig(struct mm_str
>  			   pte_t *ptep, size_t *pgsize)
>  {
>  	pgd_t *pgdp = pgd_offset(mm, addr);
> +	p4d_t *p4dp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
>  
>  	*pgsize = PAGE_SIZE;
> -	pudp = pud_offset(pgdp, addr);
> +	p4dp = p4d_offset(pgdp, addr);
> +	pudp = pud_offset(p4dp, addr);
>  	pmdp = pmd_offset(pudp, addr);
>  	if ((pte_t *)pmdp == ptep) {
>  		*pgsize = PMD_SIZE;
> @@ -217,12 +219,14 @@ pte_t *huge_pte_alloc(struct mm_struct *
>  		      unsigned long addr, unsigned long sz)
>  {
>  	pgd_t *pgdp;
> +	p4d_t *p4dp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
>  	pte_t *ptep = NULL;
>  
>  	pgdp = pgd_offset(mm, addr);
> -	pudp = pud_alloc(mm, pgdp, addr);
> +	p4dp = p4d_offset(pgdp, addr);
> +	pudp = pud_alloc(mm, p4dp, addr);
>  	if (!pudp)
>  		return NULL;
>  
> @@ -261,6 +265,7 @@ pte_t *huge_pte_offset(struct mm_struct
>  		       unsigned long addr, unsigned long sz)
>  {
>  	pgd_t *pgdp;
> +	p4d_t *p4dp;
>  	pud_t *pudp, pud;
>  	pmd_t *pmdp, pmd;
>  
> @@ -268,7 +273,11 @@ pte_t *huge_pte_offset(struct mm_struct
>  	if (!pgd_present(READ_ONCE(*pgdp)))
>  		return NULL;
>  
> -	pudp = pud_offset(pgdp, addr);
> +	p4dp = p4d_offset(pgdp, addr);
> +	if (!p4d_present(READ_ONCE(*p4dp)))
> +		return NULL;
> +
> +	pudp = pud_offset(p4dp, addr);
>  	pud = READ_ONCE(*pudp);
>  	if (sz != PUD_SIZE && pud_none(pud))
>  		return NULL;
> --- a/arch/arm64/mm/kasan_init.c~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/mm/kasan_init.c
> @@ -84,17 +84,17 @@ static pmd_t *__init kasan_pmd_offset(pu
>  	return early ? pmd_offset_kimg(pudp, addr) : pmd_offset(pudp, addr);
>  }
>  
> -static pud_t *__init kasan_pud_offset(pgd_t *pgdp, unsigned long addr, int node,
> +static pud_t *__init kasan_pud_offset(p4d_t *p4dp, unsigned long addr, int node,
>  				      bool early)
>  {
> -	if (pgd_none(READ_ONCE(*pgdp))) {
> +	if (p4d_none(READ_ONCE(*p4dp))) {
>  		phys_addr_t pud_phys = early ?
>  				__pa_symbol(kasan_early_shadow_pud)
>  					: kasan_alloc_zeroed_page(node);
> -		__pgd_populate(pgdp, pud_phys, PMD_TYPE_TABLE);
> +		__p4d_populate(p4dp, pud_phys, PMD_TYPE_TABLE);
>  	}
>  
> -	return early ? pud_offset_kimg(pgdp, addr) : pud_offset(pgdp, addr);
> +	return early ? pud_offset_kimg(p4dp, addr) : pud_offset(p4dp, addr);
>  }
>  
>  static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
> @@ -126,11 +126,11 @@ static void __init kasan_pmd_populate(pu
>  	} while (pmdp++, addr = next, addr != end && pmd_none(READ_ONCE(*pmdp)));
>  }
>  
> -static void __init kasan_pud_populate(pgd_t *pgdp, unsigned long addr,
> +static void __init kasan_pud_populate(p4d_t *p4dp, unsigned long addr,
>  				      unsigned long end, int node, bool early)
>  {
>  	unsigned long next;
> -	pud_t *pudp = kasan_pud_offset(pgdp, addr, node, early);
> +	pud_t *pudp = kasan_pud_offset(p4dp, addr, node, early);
>  
>  	do {
>  		next = pud_addr_end(addr, end);
> @@ -138,6 +138,18 @@ static void __init kasan_pud_populate(pg
>  	} while (pudp++, addr = next, addr != end && pud_none(READ_ONCE(*pudp)));
>  }
>  
> +static void __init kasan_p4d_populate(pgd_t *pgdp, unsigned long addr,
> +				      unsigned long end, int node, bool early)
> +{
> +	unsigned long next;
> +	p4d_t *p4dp = p4d_offset(pgdp, addr);
> +
> +	do {
> +		next = p4d_addr_end(addr, end);
> +		kasan_pud_populate(p4dp, addr, next, node, early);
> +	} while (p4dp++, addr = next, addr != end);
> +}
> +
>  static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
>  				      int node, bool early)
>  {
> @@ -147,7 +159,7 @@ static void __init kasan_pgd_populate(un
>  	pgdp = pgd_offset_k(addr);
>  	do {
>  		next = pgd_addr_end(addr, end);
> -		kasan_pud_populate(pgdp, addr, next, node, early);
> +		kasan_p4d_populate(pgdp, addr, next, node, early);
>  	} while (pgdp++, addr = next, addr != end);
>  }
>  
> --- a/arch/arm64/mm/mmu.c~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/mm/mmu.c
> @@ -290,18 +290,19 @@ static void alloc_init_pud(pgd_t *pgdp,
>  {
>  	unsigned long next;
>  	pud_t *pudp;
> -	pgd_t pgd = READ_ONCE(*pgdp);
> +	p4d_t *p4dp = p4d_offset(pgdp, addr);
> +	p4d_t p4d = READ_ONCE(*p4dp);
>  
> -	if (pgd_none(pgd)) {
> +	if (p4d_none(p4d)) {
>  		phys_addr_t pud_phys;
>  		BUG_ON(!pgtable_alloc);
>  		pud_phys = pgtable_alloc(PUD_SHIFT);
> -		__pgd_populate(pgdp, pud_phys, PUD_TYPE_TABLE);
> -		pgd = READ_ONCE(*pgdp);
> +		__p4d_populate(p4dp, pud_phys, PUD_TYPE_TABLE);
> +		p4d = READ_ONCE(*p4dp);
>  	}
> -	BUG_ON(pgd_bad(pgd));
> +	BUG_ON(p4d_bad(p4d));
>  
> -	pudp = pud_set_fixmap_offset(pgdp, addr);
> +	pudp = pud_set_fixmap_offset(p4dp, addr);
>  	do {
>  		pud_t old_pud = READ_ONCE(*pudp);
>  
> @@ -672,6 +673,7 @@ static void __init map_kernel(pgd_t *pgd
>  			READ_ONCE(*pgd_offset_k(FIXADDR_START)));
>  	} else if (CONFIG_PGTABLE_LEVELS > 3) {
>  		pgd_t *bm_pgdp;
> +		p4d_t *bm_p4dp;
>  		pud_t *bm_pudp;
>  		/*
>  		 * The fixmap shares its top level pgd entry with the kernel
> @@ -681,7 +683,8 @@ static void __init map_kernel(pgd_t *pgd
>  		 */
>  		BUG_ON(!IS_ENABLED(CONFIG_ARM64_16K_PAGES));
>  		bm_pgdp = pgd_offset_raw(pgdp, FIXADDR_START);
> -		bm_pudp = pud_set_fixmap_offset(bm_pgdp, FIXADDR_START);
> +		bm_p4dp = p4d_offset(bm_pgdp, FIXADDR_START);
> +		bm_pudp = pud_set_fixmap_offset(bm_p4dp, FIXADDR_START);
>  		pud_populate(&init_mm, bm_pudp, lm_alias(bm_pmd));
>  		pud_clear_fixmap();
>  	} else {
> @@ -715,6 +718,7 @@ void __init paging_init(void)
>  int kern_addr_valid(unsigned long addr)
>  {
>  	pgd_t *pgdp;
> +	p4d_t *p4dp;
>  	pud_t *pudp, pud;
>  	pmd_t *pmdp, pmd;
>  	pte_t *ptep, pte;
> @@ -726,7 +730,11 @@ int kern_addr_valid(unsigned long addr)
>  	if (pgd_none(READ_ONCE(*pgdp)))
>  		return 0;
>  
> -	pudp = pud_offset(pgdp, addr);
> +	p4dp = p4d_offset(pgdp, addr);
> +	if (p4d_none(READ_ONCE(*p4dp)))
> +		return 0;
> +
> +	pudp = pud_offset(p4dp, addr);
>  	pud = READ_ONCE(*pudp);
>  	if (pud_none(pud))
>  		return 0;
> @@ -1069,6 +1077,7 @@ int __meminit vmemmap_populate(unsigned
>  	unsigned long addr = start;
>  	unsigned long next;
>  	pgd_t *pgdp;
> +	p4d_t *p4dp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
>  
> @@ -1079,7 +1088,11 @@ int __meminit vmemmap_populate(unsigned
>  		if (!pgdp)
>  			return -ENOMEM;
>  
> -		pudp = vmemmap_pud_populate(pgdp, addr, node);
> +		p4dp = vmemmap_p4d_populate(pgdp, addr, node);
> +		if (!p4dp)
> +			return -ENOMEM;
> +
> +		pudp = vmemmap_pud_populate(p4dp, addr, node);
>  		if (!pudp)
>  			return -ENOMEM;
>  
> @@ -1114,11 +1127,12 @@ void vmemmap_free(unsigned long start, u
>  static inline pud_t * fixmap_pud(unsigned long addr)
>  {
>  	pgd_t *pgdp = pgd_offset_k(addr);
> -	pgd_t pgd = READ_ONCE(*pgdp);
> +	p4d_t *p4dp = p4d_offset(pgdp, addr);
> +	p4d_t p4d = READ_ONCE(*p4dp);
>  
> -	BUG_ON(pgd_none(pgd) || pgd_bad(pgd));
> +	BUG_ON(p4d_none(p4d) || p4d_bad(p4d));
>  
> -	return pud_offset_kimg(pgdp, addr);
> +	return pud_offset_kimg(p4dp, addr);
>  }
>  
>  static inline pmd_t * fixmap_pmd(unsigned long addr)
> @@ -1144,25 +1158,27 @@ static inline pte_t * fixmap_pte(unsigne
>   */
>  void __init early_fixmap_init(void)
>  {
> -	pgd_t *pgdp, pgd;
> +	pgd_t *pgdp;
> +	p4d_t *p4dp, p4d;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
>  	unsigned long addr = FIXADDR_START;
>  
>  	pgdp = pgd_offset_k(addr);
> -	pgd = READ_ONCE(*pgdp);
> +	p4dp = p4d_offset(pgdp, addr);
> +	p4d = READ_ONCE(*p4dp);
>  	if (CONFIG_PGTABLE_LEVELS > 3 &&
> -	    !(pgd_none(pgd) || pgd_page_paddr(pgd) == __pa_symbol(bm_pud))) {
> +	    !(p4d_none(p4d) || p4d_page_paddr(p4d) == __pa_symbol(bm_pud))) {
>  		/*
>  		 * We only end up here if the kernel mapping and the fixmap
>  		 * share the top level pgd entry, which should only happen on
>  		 * 16k/4 levels configurations.
>  		 */
>  		BUG_ON(!IS_ENABLED(CONFIG_ARM64_16K_PAGES));
> -		pudp = pud_offset_kimg(pgdp, addr);
> +		pudp = pud_offset_kimg(p4dp, addr);
>  	} else {
> -		if (pgd_none(pgd))
> -			__pgd_populate(pgdp, __pa_symbol(bm_pud), PUD_TYPE_TABLE);
> +		if (p4d_none(p4d))
> +			__p4d_populate(p4dp, __pa_symbol(bm_pud), PUD_TYPE_TABLE);
>  		pudp = fixmap_pud(addr);
>  	}
>  	if (pud_none(READ_ONCE(*pudp)))
> --- a/arch/arm64/mm/pageattr.c~arm64-add-support-for-folded-p4d-page-tables
> +++ a/arch/arm64/mm/pageattr.c
> @@ -198,6 +198,7 @@ void __kernel_map_pages(struct page *pag
>  bool kernel_page_present(struct page *page)
>  {
>  	pgd_t *pgdp;
> +	p4d_t *p4dp;
>  	pud_t *pudp, pud;
>  	pmd_t *pmdp, pmd;
>  	pte_t *ptep;
> @@ -210,7 +211,11 @@ bool kernel_page_present(struct page *pa
>  	if (pgd_none(READ_ONCE(*pgdp)))
>  		return false;
>  
> -	pudp = pud_offset(pgdp, addr);
> +	p4dp = p4d_offset(pgdp, addr);
> +	if (p4d_none(READ_ONCE(*p4dp)))
> +		return false;
> +
> +	pudp = pud_offset(p4dp, addr);
>  	pud = READ_ONCE(*pudp);
>  	if (pud_none(pud))
>  		return false;
> _
> 

-- 
Sincerely yours,
Mike.
