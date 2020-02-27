Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA6BB1715F4
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 12:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgB0LaC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 06:30:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:20844 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbgB0LaC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 06:30:02 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Sr7B6tBLz9tyj6;
        Thu, 27 Feb 2020 12:29:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=sY3j0RR2; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sfhDOp5RFM3X; Thu, 27 Feb 2020 12:29:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Sr7B4647z9tyj5;
        Thu, 27 Feb 2020 12:29:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582802998; bh=cSI6qGFMowtMxdtcFr5RdCkA5PjkZpSoEJInX7gJyOA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sY3j0RR2PBOXScM+F70jPRR5SxVcVDFz0l9cHThPMZEFG4kwr/KMeE6VWEPUahfIn
         stgDHcxIlh/cqkU0a9UVkTMnUuLut2yXP0L0Dm55YwuYS/UqGWC8iW7Anz1GPG/C7N
         /DkcT6MALkhHEAKH1kk8i8jKmlO7tqgL2dHPUsnY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A42DC8B872;
        Thu, 27 Feb 2020 12:29:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rIACHu_5xv6N; Thu, 27 Feb 2020 12:29:59 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C9888B799;
        Thu, 27 Feb 2020 12:29:57 +0100 (CET)
Subject: Re: [PATCH] mm/debug: Add tests validating arch page table helpers
 for core features
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-snps-arc@lists.infradead.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
References: <1582799637-11786-1-git-send-email-anshuman.khandual@arm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2be41c29-500c-50af-f915-1493846ae9e5@c-s.fr>
Date:   Thu, 27 Feb 2020 12:29:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582799637-11786-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 27/02/2020 à 11:33, Anshuman Khandual a écrit :
> This adds new tests validating arch page table helpers for these following
> core memory features. These tests create and test specific mapping types at
> various page table levels.
> 
> * SPECIAL mapping
> * PROTNONE mapping
> * DEVMAP mapping
> * SOFTDIRTY mapping
> * SWAP mapping
> * MIGRATION mapping
> * HUGETLB mapping
> * THP mapping
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: x86@kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Tested on arm64 and x86 platforms without any test failures. But this has
> only been built tested on several other platforms. Individual tests need
> to be verified on all current enabling platforms for the test i.e s390,
> ppc32, arc etc.
> 
> This patch must be applied on v5.6-rc3 after these patches
> 
> 1. https://patchwork.kernel.org/patch/11385057/
> 2. https://patchwork.kernel.org/patch/11407715/
> 
> OR
> 
> This patch must be applied on linux-next (next-20200227) after this patch
> 
> 2. https://patchwork.kernel.org/patch/11407715/
> 
>   mm/debug_vm_pgtable.c | 310 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 309 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 96dd7d574cef..3fb90d5b604e 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -41,6 +41,44 @@
>    * wrprotect(entry)		= A write protected and not a write entry
>    * pxx_bad(entry)		= A mapped and non-table entry
>    * pxx_same(entry1, entry2)	= Both entries hold the exact same value
> + *
> + * Specific feature operations
> + *
> + * pte_mkspecial(entry)		= Creates a special entry at PTE level
> + * pte_special(entry)		= Tests a special entry at PTE level
> + *
> + * pte_protnone(entry)		= Tests a no access entry at PTE level
> + * pmd_protnone(entry)		= Tests a no access entry at PMD level
> + *
> + * pte_mkdevmap(entry)		= Creates a device entry at PTE level
> + * pmd_mkdevmap(entry)		= Creates a device entry at PMD level
> + * pud_mkdevmap(entry)		= Creates a device entry at PUD level
> + * pte_devmap(entry)		= Tests a device entry at PTE level
> + * pmd_devmap(entry)		= Tests a device entry at PMD level
> + * pud_devmap(entry)		= Tests a device entry at PUD level
> + *
> + * pte_mksoft_dirty(entry)	= Creates a soft dirty entry at PTE level
> + * pmd_mksoft_dirty(entry)	= Creates a soft dirty entry at PMD level
> + * pte_swp_mksoft_dirty(entry)	= Creates a soft dirty swap entry at PTE level
> + * pmd_swp_mksoft_dirty(entry)	= Creates a soft dirty swap entry at PMD level
> + * pte_soft_dirty(entry)	= Tests a soft dirty entry at PTE level
> + * pmd_soft_dirty(entry)	= Tests a soft dirty entry at PMD level
> + * pte_swp_soft_dirty(entry)	= Tests a soft dirty swap entry at PTE level
> + * pmd_swp_soft_dirty(entry)	= Tests a soft dirty swap entry at PMD level
> + * pte_clear_soft_dirty(entry)	   = Clears a soft dirty entry at PTE level
> + * pmd_clear_soft_dirty(entry)	   = Clears a soft dirty entry at PMD level
> + * pte_swp_clear_soft_dirty(entry) = Clears a soft dirty swap entry at PTE level
> + * pmd_swp_clear_soft_dirty(entry) = Clears a soft dirty swap entry at PMD level
> + *
> + * pte_mkhuge(entry)		= Creates a HugeTLB entry at given level
> + * pte_huge(entry)		= Tests a HugeTLB entry at given level
> + *
> + * pmd_trans_huge(entry)	= Tests a trans huge page at PMD level
> + * pud_trans_huge(entry)	= Tests a trans huge page at PUD level
> + * pmd_present(entry)		= Tests an entry points to memory at PMD level
> + * pud_present(entry)		= Tests an entry points to memory at PUD level
> + * pmd_mknotpresent(entry)	= Invalidates an PMD entry for MMU
> + * pud_mknotpresent(entry)	= Invalidates an PUD entry for MMU
>    */
>   #define VMFLAGS	(VM_READ|VM_WRITE|VM_EXEC)
>   
> @@ -287,6 +325,233 @@ static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
>   	WARN_ON(pmd_bad(pmd));
>   }
>   
> +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL

Can we avoid ifdefs unless necessary ?

In mm/memory.c I see things like the following, it means pte_special() 
always exist and a #ifdef is not necessary.

	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
		if (likely(!pte_special(pte)))
			goto check_pfn;
		if (vma->vm_ops && vma->vm_ops->find_special_page)
			return vma->vm_ops->find_special_page(vma, addr);
		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
			return NULL;
		if (is_zero_pfn(pfn))
			return NULL;
		if (pte_devmap(pte))
			return NULL;

		print_bad_pte(vma, addr, pte, NULL);
		return NULL;
	}

> +static void __init pte_special_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pte_t pte = pfn_pte(pfn, prot);
> +
> +	WARN_ON(!pte_special(pte_mkspecial(pte)));
> +}
> +#else
> +static void __init pte_special_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif
> +
> +#ifdef CONFIG_NUMA_BALANCING

Same here, this ifdef shouldn't be necessary because in 
/include/asm-generic/pgtable.h we have the following, so a if 
(IS_ENABLED()) should be enough.

#ifndef CONFIG_NUMA_BALANCING
/*
  * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
  * the only case the kernel cares is for NUMA balancing and is only 
ever set
  * when the VMA is accessible. For PROT_NONE VMAs, the PTEs are not marked
  * _PAGE_PROTNONE so by by default, implement the helper as "always no". It
  * is the responsibility of the caller to distinguish between PROT_NONE
  * protections and NUMA hinting fault protections.
  */
static inline int pte_protnone(pte_t pte)
{
	return 0;
}

static inline int pmd_protnone(pmd_t pmd)
{
	return 0;
}
#endif /* CONFIG_NUMA_BALANCING */

> +static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pte_t pte = pfn_pte(pfn, prot);
> +
> +	WARN_ON(!pte_protnone(pte));
> +	WARN_ON(!pte_present(pte));
> +}
> +
> +static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pmd_t pmd = pfn_pmd(pfn, prot);
> +
> +	WARN_ON(!pmd_protnone(pmd));
> +	WARN_ON(!pmd_present(pmd));
> +}
> +#else
> +static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif
> +
> +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP

Same here, in include/linux/mm.h we have:

#ifndef CONFIG_ARCH_HAS_PTE_DEVMAP
static inline int pte_devmap(pte_t pte)
{
	return 0;
}
#endif


> +static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pte_t pte = pfn_pte(pfn, prot);
> +
> +	WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE

Same. In inlude/asm-generic/pgtables.h you have:

#if !defined(CONFIG_ARCH_HAS_PTE_DEVMAP) || 
!defined(CONFIG_TRANSPARENT_HUGEPAGE)
static inline int pmd_devmap(pmd_t pmd)
{
	return 0;
}
static inline int pud_devmap(pud_t pud)
{
	return 0;
}
static inline int pgd_devmap(pgd_t pgd)
{
	return 0;
}
#endif

> +static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pmd_t pmd = pfn_pmd(pfn, prot);
> +
> +	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
> +}
> +
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD

Same, see above

> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pud_t pud = pfn_pud(pfn, prot);
> +
> +	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
> +}
> +#else
> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif
> +#else
> +static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif
> +#else
> +static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif
> +
> +#ifdef CONFIG_MEM_SOFT_DIRTY

Same, they always exist, see include/asm-generic/pgtable.h

> +static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pte_t pte = pfn_pte(pfn, prot);
> +
> +	WARN_ON(!pte_soft_dirty(pte_mksoft_dirty(pte)));
> +	WARN_ON(pte_soft_dirty(pte_clear_soft_dirty(pte)));
> +}
> +
> +static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pte_t pte = pfn_pte(pfn, prot);
> +
> +	WARN_ON(!pte_swp_soft_dirty(pte_swp_mksoft_dirty(pte)));
> +	WARN_ON(pte_swp_soft_dirty(pte_swp_clear_soft_dirty(pte)));
> +}
> +
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION

Same

> +static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pmd_t pmd = pfn_pmd(pfn, prot);
> +
> +	WARN_ON(!pmd_soft_dirty(pmd_mksoft_dirty(pmd)));
> +	WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
> +}
> +
> +static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pmd_t pmd = pfn_pmd(pfn, prot);
> +
> +	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
> +	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
> +}
> +#else
> +static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> +{
> +}
> +#endif
> +#else
> +static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> +{
> +}
> +static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
> +{
> +}
> +#endif
> +
> +static void __init pte_swap_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	swp_entry_t swp;
> +	pte_t pte;
> +
> +	pte = pfn_pte(pfn, prot);
> +	swp = __pte_to_swp_entry(pte);
> +	WARN_ON(!pte_same(pte, __swp_entry_to_pte(swp)));
> +}
> +
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	swp_entry_t swp;
> +	pmd_t pmd;
> +
> +	pmd = pfn_pmd(pfn, prot);
> +	swp = __pmd_to_swp_entry(pmd);
> +	WARN_ON(!pmd_same(pmd, __swp_entry_to_pmd(swp)));
> +}
> +#else
> +static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif
> +
> +#ifdef CONFIG_MIGRATION

Same. See include/linux/swapops.h

> +static void __init swap_migration_tests(struct page *page)
> +{
> +	swp_entry_t swp;
> +
> +	/*
> +	 * make_migration_entry() expects given page to be
> +	 * locked, otherwise it stumbles upon a BUG_ON().
> +	 */
> +	__SetPageLocked(page);
> +	swp = make_migration_entry(page, 1);
> +	WARN_ON(!is_migration_entry(swp));
> +	WARN_ON(!is_write_migration_entry(swp));
> +
> +	make_migration_entry_read(&swp);
> +	WARN_ON(!is_migration_entry(swp));
> +	WARN_ON(is_write_migration_entry(swp));
> +
> +	swp = make_migration_entry(page, 0);
> +	WARN_ON(!is_migration_entry(swp));
> +	WARN_ON(is_write_migration_entry(swp));
> +	__ClearPageLocked(page);
> +}
> +#else
> +static void __init swap_migration_tests(struct page *page) { }
> +#endif
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +static void __init hugetlb_tests(unsigned long pfn, pgprot_t prot)
> +{
> +#ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
> +	pte_t pte = pfn_pte(pfn, prot);
> +
> +	WARN_ON(!pte_huge(pte_mkhuge(pte)));

We also need tests on hugepd stuff

> +#endif
> +}
> +#else
> +static void __init hugetlb_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE

Same, see include/asm-generic/pgtable.h

> +static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pmd_t pmd;
> +
> +	/*
> +	 * pmd_trans_huge() and pmd_present() must return negative
> +	 * after MMU invalidation with pmd_mknotpresent().
> +	 */
> +	pmd = pfn_pmd(pfn, prot);
> +	WARN_ON(!pmd_trans_huge(pmd_mkhuge(pmd)));
> +
> +	/*
> +	 * Though platform specific test exclusions are not ideal,
> +	 * in this case S390 does not define pmd_mknotpresent()
> +	 * which should be tested on other platforms enabling THP.
> +	 */
> +#ifndef CONFIG_S390
> +	WARN_ON(pmd_trans_huge(pmd_mknotpresent(pmd)));
> +	WARN_ON(pmd_present(pmd_mknotpresent(pmd)));
> +#endif

Can we add a stub on S390 instead ?

> +}
> +
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD

Same ?

> +static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pud_t pud;
> +
> +	/*
> +	 * pud_trans_huge() and pud_present() must return negative
> +	 * after MMU invalidation with pud_mknotpresent().
> +	 */
> +	pud = pfn_pud(pfn, prot);
> +	WARN_ON(!pud_trans_huge(pud_mkhuge(pud)));
> +	WARN_ON(pud_trans_huge(pud_mknotpresent(pud)));
> +	WARN_ON(pud_present(pud_mknotpresent(pud)));
> +}
> +#else
> +static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif
> +#else
> +static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot) { }
> +#endif
> +
>   static unsigned long __init get_random_vaddr(void)
>   {
>   	unsigned long random_vaddr, random_pages, total_user_pages;
> @@ -302,13 +567,14 @@ static unsigned long __init get_random_vaddr(void)
>   void __init debug_vm_pgtable(void)
>   {
>   	struct mm_struct *mm;
> +	struct page *page;
>   	pgd_t *pgdp;
>   	p4d_t *p4dp, *saved_p4dp;
>   	pud_t *pudp, *saved_pudp;
>   	pmd_t *pmdp, *saved_pmdp, pmd;
>   	pte_t *ptep;
>   	pgtable_t saved_ptep;
> -	pgprot_t prot;
> +	pgprot_t prot, protnone;
>   	phys_addr_t paddr;
>   	unsigned long vaddr, pte_aligned, pmd_aligned;
>   	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
> @@ -322,6 +588,25 @@ void __init debug_vm_pgtable(void)
>   		return;
>   	}
>   
> +	/*
> +	 * swap_migration_tests() requires a dedicated page as it needs to
> +	 * be locked before creating a migration entry from it. Locking the
> +	 * page that actually maps kernel text ('start_kernel') can be real
> +	 * problematic. Lets allocate a dedicated page explicitly for this
> +	 * purpose that will be freed later.
> +	 */
> +	page = alloc_page(GFP_KERNEL);

Can we do the page allocation and freeing in swap_migration_tests() 
instead ?


> +	if (!page) {
> +		pr_err("page allocation failed\n");
> +		return;
> +	}
> +
> +	/*
> +	 * __P000 (or even __S000) will help create page table entries with
> +	 * PROT_NONE permission as required for pxx_protnone_tests().
> +	 */
> +	protnone = __P000;
> +
>   	/*
>   	 * PFN for mapping at PTE level is determined from a standard kernel
>   	 * text symbol. But pfns for higher page table levels are derived by
> @@ -377,11 +662,34 @@ void __init debug_vm_pgtable(void)
>   	p4d_populate_tests(mm, p4dp, saved_pudp);
>   	pgd_populate_tests(mm, pgdp, saved_p4dp);
>   
> +	pte_special_tests(pte_aligned, prot);
> +	pte_protnone_tests(pte_aligned, protnone);
> +	pmd_protnone_tests(pmd_aligned, protnone);
> +
> +	pte_devmap_tests(pte_aligned, prot);
> +	pmd_devmap_tests(pmd_aligned, prot);
> +	pud_devmap_tests(pud_aligned, prot);
> +
> +	pte_soft_dirty_tests(pte_aligned, prot);
> +	pmd_soft_dirty_tests(pmd_aligned, prot);
> +	pte_swap_soft_dirty_tests(pte_aligned, prot);
> +	pmd_swap_soft_dirty_tests(pmd_aligned, prot);
> +
> +	pte_swap_tests(pte_aligned, prot);
> +	pmd_swap_tests(pmd_aligned, prot);
> +
> +	swap_migration_tests(page);
> +	hugetlb_tests(pte_aligned, prot);
> +
> +	pmd_thp_tests(pmd_aligned, prot);
> +	pud_thp_tests(pud_aligned, prot);
> +
>   	p4d_free(mm, saved_p4dp);
>   	pud_free(mm, saved_pudp);
>   	pmd_free(mm, saved_pmdp);
>   	pte_free(mm, saved_ptep);
>   
> +	__free_page(page);
>   	mm_dec_nr_puds(mm);
>   	mm_dec_nr_pmds(mm);
>   	mm_dec_nr_ptes(mm);
> 

Christophe
