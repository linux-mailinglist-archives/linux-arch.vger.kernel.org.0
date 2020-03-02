Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4381765E6
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 22:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCBVYb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 2 Mar 2020 16:24:31 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:51333 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgCBVYb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Mar 2020 16:24:31 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48WY7F6ZCcz9v1hQ;
        Mon,  2 Mar 2020 22:24:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FWWL69vDJFoE; Mon,  2 Mar 2020 22:24:25 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48WY7F59jkz9ttBQ;
        Mon,  2 Mar 2020 22:24:25 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 0B1F9A0F; Mon,  2 Mar 2020 22:24:44 +0100 (CET)
Received: from rop17-1_migr-88-124-70-171.fbx.proxad.net
 (rop17-1_migr-88-124-70-171.fbx.proxad.net [88.124.70.171]) by
 messagerie.si.c-s.fr (Horde Framework) with HTTP; Mon, 02 Mar 2020 22:24:43
 +0100
Date:   Mon, 02 Mar 2020 22:24:43 +0100
Message-ID: <20200302222443.Horde.3Vn7_PzcWbAADKFWloR-kw8@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Borislav Petkov <bp@alien8.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-snps-arc@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm/debug: Add tests validating arch page table helpers
 for core features
References: <1582799637-11786-1-git-send-email-anshuman.khandual@arm.com>
 <2be41c29-500c-50af-f915-1493846ae9e5@c-s.fr>
 <4343eda9-7df2-a13c-0125-cf784c81ce14@arm.com>
In-Reply-To: <4343eda9-7df2-a13c-0125-cf784c81ce14@arm.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Anshuman Khandual <anshuman.khandual@arm.com> a écrit :

> On 02/27/2020 04:59 PM, Christophe Leroy wrote:
>>
>>
>> Le 27/02/2020 à 11:33, Anshuman Khandual a écrit :
>>> This adds new tests validating arch page table helpers for these following
>>> core memory features. These tests create and test specific mapping types at
>>> various page table levels.
>>>
>>> * SPECIAL mapping
>>> * PROTNONE mapping
>>> * DEVMAP mapping
>>> * SOFTDIRTY mapping
>>> * SWAP mapping
>>> * MIGRATION mapping
>>> * HUGETLB mapping
>>> * THP mapping
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>>> Cc: Vineet Gupta <vgupta@synopsys.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>> Cc: linux-snps-arc@lists.infradead.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Cc: linux-s390@vger.kernel.org
>>> Cc: linux-riscv@lists.infradead.org
>>> Cc: x86@kernel.org
>>> Cc: linux-arch@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> Tested on arm64 and x86 platforms without any test failures. But this has
>>> only been built tested on several other platforms. Individual tests need
>>> to be verified on all current enabling platforms for the test i.e s390,
>>> ppc32, arc etc.
>>>
>>> This patch must be applied on v5.6-rc3 after these patches
>>>
>>> 1. https://patchwork.kernel.org/patch/11385057/
>>> 2. https://patchwork.kernel.org/patch/11407715/
>>>
>>> OR
>>>
>>> This patch must be applied on linux-next (next-20200227) after this patch
>>>
>>> 2. https://patchwork.kernel.org/patch/11407715/
>>>
>>>   mm/debug_vm_pgtable.c | 310 +++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 309 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>> index 96dd7d574cef..3fb90d5b604e 100644
>>> --- a/mm/debug_vm_pgtable.c
>>> +++ b/mm/debug_vm_pgtable.c
>>> @@ -41,6 +41,44 @@
>>>    * wrprotect(entry)        = A write protected and not a write entry
>>>    * pxx_bad(entry)        = A mapped and non-table entry
>>>    * pxx_same(entry1, entry2)    = Both entries hold the exact same value
>>> + *
>>> + * Specific feature operations
>>> + *
>>> + * pte_mkspecial(entry)        = Creates a special entry at PTE level
>>> + * pte_special(entry)        = Tests a special entry at PTE level
>>> + *
>>> + * pte_protnone(entry)        = Tests a no access entry at PTE level
>>> + * pmd_protnone(entry)        = Tests a no access entry at PMD level
>>> + *
>>> + * pte_mkdevmap(entry)        = Creates a device entry at PTE level
>>> + * pmd_mkdevmap(entry)        = Creates a device entry at PMD level
>>> + * pud_mkdevmap(entry)        = Creates a device entry at PUD level
>>> + * pte_devmap(entry)        = Tests a device entry at PTE level
>>> + * pmd_devmap(entry)        = Tests a device entry at PMD level
>>> + * pud_devmap(entry)        = Tests a device entry at PUD level
>>> + *
>>> + * pte_mksoft_dirty(entry)    = Creates a soft dirty entry at PTE level
>>> + * pmd_mksoft_dirty(entry)    = Creates a soft dirty entry at PMD level
>>> + * pte_swp_mksoft_dirty(entry)    = Creates a soft dirty swap  
>>> entry at PTE level
>>> + * pmd_swp_mksoft_dirty(entry)    = Creates a soft dirty swap  
>>> entry at PMD level
>>> + * pte_soft_dirty(entry)    = Tests a soft dirty entry at PTE level
>>> + * pmd_soft_dirty(entry)    = Tests a soft dirty entry at PMD level
>>> + * pte_swp_soft_dirty(entry)    = Tests a soft dirty swap entry  
>>> at PTE level
>>> + * pmd_swp_soft_dirty(entry)    = Tests a soft dirty swap entry  
>>> at PMD level
>>> + * pte_clear_soft_dirty(entry)       = Clears a soft dirty entry  
>>> at PTE level
>>> + * pmd_clear_soft_dirty(entry)       = Clears a soft dirty entry  
>>> at PMD level
>>> + * pte_swp_clear_soft_dirty(entry) = Clears a soft dirty swap  
>>> entry at PTE level
>>> + * pmd_swp_clear_soft_dirty(entry) = Clears a soft dirty swap  
>>> entry at PMD level
>>> + *
>>> + * pte_mkhuge(entry)        = Creates a HugeTLB entry at given level
>>> + * pte_huge(entry)        = Tests a HugeTLB entry at given level
>>> + *
>>> + * pmd_trans_huge(entry)    = Tests a trans huge page at PMD level
>>> + * pud_trans_huge(entry)    = Tests a trans huge page at PUD level
>>> + * pmd_present(entry)        = Tests an entry points to memory at  
>>> PMD level
>>> + * pud_present(entry)        = Tests an entry points to memory at  
>>> PUD level
>>> + * pmd_mknotpresent(entry)    = Invalidates an PMD entry for MMU
>>> + * pud_mknotpresent(entry)    = Invalidates an PUD entry for MMU
>>>    */
>>>   #define VMFLAGS    (VM_READ|VM_WRITE|VM_EXEC)
>>>   @@ -287,6 +325,233 @@ static void __init  
>>> pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
>>>       WARN_ON(pmd_bad(pmd));
>>>   }
>>>   +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>>
>> Can we avoid ifdefs unless necessary ?
>>
>> In mm/memory.c I see things like the following, it means  
>> pte_special() always exist and a #ifdef is not necessary.
>
> True, #ifdef here can be dropped here, done.
>
>>
>>     if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
>>         if (likely(!pte_special(pte)))
>>             goto check_pfn;
>>         if (vma->vm_ops && vma->vm_ops->find_special_page)
>>             return vma->vm_ops->find_special_page(vma, addr);
>>         if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>>             return NULL;
>>         if (is_zero_pfn(pfn))
>>             return NULL;
>>         if (pte_devmap(pte))
>>             return NULL;
>>
>>         print_bad_pte(vma, addr, pte, NULL);
>>         return NULL;
>>     }
>>
>>> +static void __init pte_special_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    pte_t pte = pfn_pte(pfn, prot);
>>> +
>>> +    WARN_ON(!pte_special(pte_mkspecial(pte)));
>>> +}
>>> +#else
>>> +static void __init pte_special_tests(unsigned long pfn, pgprot_t prot) { }
>>> +#endif
>>> +
>>> +#ifdef CONFIG_NUMA_BALANCING
>>
>> Same here, this ifdef shouldn't be necessary because in  
>> /include/asm-generic/pgtable.h we have the following, so a if  
>> (IS_ENABLED()) should be enough.
>>
>> #ifndef CONFIG_NUMA_BALANCING
>> /*
>>  * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
>>  * the only case the kernel cares is for NUMA balancing and is only ever set
>>  * when the VMA is accessible. For PROT_NONE VMAs, the PTEs are not marked
>>  * _PAGE_PROTNONE so by by default, implement the helper as "always no". It
>>  * is the responsibility of the caller to distinguish between PROT_NONE
>>  * protections and NUMA hinting fault protections.
>>  */
>> static inline int pte_protnone(pte_t pte)
>> {
>>     return 0;
>> }
>>
>> static inline int pmd_protnone(pmd_t pmd)
>> {
>>     return 0;
>> }
>> #endif /* CONFIG_NUMA_BALANCING */
>
> True,  #ifdef here can be dropped, done. There is something I had missed
> before, pfn_pmd() requires #ifdef CONFIG_TRANSPARENT_HUGEPAGE instead. We
> need a pmd_t here with given prot. We cannot go via pfn_pte() followed by
> pte_pmd(), as the later is platform specific and not available in general.

As many things require CONFIG_TRANSPARENT_HUGEPAGE,  maybe it would be  
worth creating an additional C file with the related functions and  
build it conditionnaly to CONFIG_TRANSPARENT_HUGEPAGE

Christophe

>
>>
>>> +static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    pte_t pte = pfn_pte(pfn, prot);
>>> +
>>> +    WARN_ON(!pte_protnone(pte));
>>> +    WARN_ON(!pte_present(pte));
>>> +}
>>> +
>>> +static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    pmd_t pmd = pfn_pmd(pfn, prot);
>>> +
>>> +    WARN_ON(!pmd_protnone(pmd));
>>> +    WARN_ON(!pmd_present(pmd));
>>> +}
>>> +#else
>>> +static void __init pte_protnone_tests(unsigned long pfn, pgprot_t  
>>> prot) { }
>>> +static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t  
>>> prot) { }
>>> +#endif
>>> +
>>> +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
>>
>> Same here, in include/linux/mm.h we have:
>>
>> #ifndef CONFIG_ARCH_HAS_PTE_DEVMAP
>> static inline int pte_devmap(pte_t pte)
>> {
>>     return 0;
>> }
>> #endif
>>
>>
>>> +static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    pte_t pte = pfn_pte(pfn, prot);
>>> +
>>> +    WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
>>> +}
>>> +
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>
>> Same. In inlude/asm-generic/pgtables.h you have:
>>
>> #if !defined(CONFIG_ARCH_HAS_PTE_DEVMAP) ||  
>> !defined(CONFIG_TRANSPARENT_HUGEPAGE)
>> static inline int pmd_devmap(pmd_t pmd)
>> {
>>     return 0;
>> }
>> static inline int pud_devmap(pud_t pud)
>> {
>>     return 0;
>> }
>> static inline int pgd_devmap(pgd_t pgd)
>> {
>>     return 0;
>> }
>> #endif
>>
>>> +static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    pmd_t pmd = pfn_pmd(pfn, prot);
>>> +
>>> +    WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
>>> +}
>>> +
>>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>
>> Same, see above
>
> Even though pxx_devmap() fallback definitions are present, pxx_mkdevmap()
> ones are still missing. We will have to add them first as a pre-requisite
> patch (which might not be popular without any non-debug use case) in order
> to drop these #ifdefs here.
>
>>
>>> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    pud_t pud = pfn_pud(pfn, prot);
>>> +
>>> +    WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
>>> +}
>>> +#else
>>> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
>>> +#endif
>>> +#else
>>> +static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
>>> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
>>> +#endif
>>> +#else
>>> +static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot) { }
>>> +static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
>>> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
>>> +#endif
>>> +
>>> +#ifdef CONFIG_MEM_SOFT_DIRTY
>>
>> Same, they always exist, see include/asm-generic/pgtable.h
>
> Yeah, this can be dropped. Though will have to again add TRANSPARENT_HUGEPAGE
> to protect pfn_pmd() as explained before.
>
>>
>>> +static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    pte_t pte = pfn_pte(pfn, prot);
>>> +
>>> +    WARN_ON(!pte_soft_dirty(pte_mksoft_dirty(pte)));
>>> +    WARN_ON(pte_soft_dirty(pte_clear_soft_dirty(pte)));
>>> +}
>>> +
>>> +static void __init pte_swap_soft_dirty_tests(unsigned long pfn,  
>>> pgprot_t prot)
>>> +{
>>> +    pte_t pte = pfn_pte(pfn, prot);
>>> +
>>> +    WARN_ON(!pte_swp_soft_dirty(pte_swp_mksoft_dirty(pte)));
>>> +    WARN_ON(pte_swp_soft_dirty(pte_swp_clear_soft_dirty(pte)));
>>> +}
>>> +
>>> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>
>> Same
>
> True, #ifdef here can be dropped, done.
>
>>
>>> +static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    pmd_t pmd = pfn_pmd(pfn, prot);
>>> +
>>> +    WARN_ON(!pmd_soft_dirty(pmd_mksoft_dirty(pmd)));
>>> +    WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
>>> +}
>>> +
>>> +static void __init pmd_swap_soft_dirty_tests(unsigned long pfn,  
>>> pgprot_t prot)
>>> +{
>>> +    pmd_t pmd = pfn_pmd(pfn, prot);
>>> +
>>> +    WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
>>> +    WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
>>> +}
>>> +#else
>>> +static void __init pmd_soft_dirty_tests(unsigned long pfn,  
>>> pgprot_t prot) { }
>>> +static void __init pmd_swap_soft_dirty_tests(unsigned long pfn,  
>>> pgprot_t prot)
>>> +{
>>> +}
>>> +#endif
>>> +#else
>>> +static void __init pte_soft_dirty_tests(unsigned long pfn,  
>>> pgprot_t prot) { }
>>> +static void __init pmd_soft_dirty_tests(unsigned long pfn,  
>>> pgprot_t prot) { }
>>> +static void __init pte_swap_soft_dirty_tests(unsigned long pfn,  
>>> pgprot_t prot)
>>> +{
>>> +}
>>> +static void __init pmd_swap_soft_dirty_tests(unsigned long pfn,  
>>> pgprot_t prot)
>>> +{
>>> +}
>>> +#endif
>>> +
>>> +static void __init pte_swap_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    swp_entry_t swp;
>>> +    pte_t pte;
>>> +
>>> +    pte = pfn_pte(pfn, prot);
>>> +    swp = __pte_to_swp_entry(pte);
>>> +    WARN_ON(!pte_same(pte, __swp_entry_to_pte(swp)));
>>> +}
>>> +
>>> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>> +static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    swp_entry_t swp;
>>> +    pmd_t pmd;
>>> +
>>> +    pmd = pfn_pmd(pfn, prot);
>>> +    swp = __pmd_to_swp_entry(pmd);
>>> +    WARN_ON(!pmd_same(pmd, __swp_entry_to_pmd(swp)));
>>> +}
>>> +#else
>>> +static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot) { }
>>> +#endif
>>> +
>>> +#ifdef CONFIG_MIGRATION
>>
>> Same. See include/linux/swapops.h
>
> True, #ifdef here can be dropped, done. Though will have to again add
> back TRANSPARENT_HUGEPAGE to protect pfn_pmd() as explained before.
>
>>
>>> +static void __init swap_migration_tests(struct page *page)
>>> +{
>>> +    swp_entry_t swp;
>>> +
>>> +    /*
>>> +     * make_migration_entry() expects given page to be
>>> +     * locked, otherwise it stumbles upon a BUG_ON().
>>> +     */
>>> +    __SetPageLocked(page);
>>> +    swp = make_migration_entry(page, 1);
>>> +    WARN_ON(!is_migration_entry(swp));
>>> +    WARN_ON(!is_write_migration_entry(swp));
>>> +
>>> +    make_migration_entry_read(&swp);
>>> +    WARN_ON(!is_migration_entry(swp));
>>> +    WARN_ON(is_write_migration_entry(swp));
>>> +
>>> +    swp = make_migration_entry(page, 0);
>>> +    WARN_ON(!is_migration_entry(swp));
>>> +    WARN_ON(is_write_migration_entry(swp));
>>> +    __ClearPageLocked(page);
>>> +}
>>> +#else
>>> +static void __init swap_migration_tests(struct page *page) { }
>>> +#endif
>>> +
>>> +#ifdef CONFIG_HUGETLB_PAGE
>>> +static void __init hugetlb_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +#ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
>>> +    pte_t pte = pfn_pte(pfn, prot);
>>> +
>>> +    WARN_ON(!pte_huge(pte_mkhuge(pte)));
>>
>> We also need tests on hugepd stuff
>
> Sure, but lets discuss this on the other thread.
>
>>
>>> +#endif
>>> +}
>>> +#else
>>> +static void __init hugetlb_tests(unsigned long pfn, pgprot_t prot) { }
>>> +#endif
>>> +
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>
>> Same, see include/asm-generic/pgtable.h
>
> This is required to protect pxx_mknotpresent() which does not have a
> fall back and pfn_pmd()/pfn_pud() helpers have similar situation as
> well.
>
>>
>>> +static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    pmd_t pmd;
>>> +
>>> +    /*
>>> +     * pmd_trans_huge() and pmd_present() must return negative
>>> +     * after MMU invalidation with pmd_mknotpresent().
>>> +     */
>>> +    pmd = pfn_pmd(pfn, prot);
>>> +    WARN_ON(!pmd_trans_huge(pmd_mkhuge(pmd)));
>>> +
>>> +    /*
>>> +     * Though platform specific test exclusions are not ideal,
>>> +     * in this case S390 does not define pmd_mknotpresent()
>>> +     * which should be tested on other platforms enabling THP.
>>> +     */
>>> +#ifndef CONFIG_S390
>>> +    WARN_ON(pmd_trans_huge(pmd_mknotpresent(pmd)));
>>> +    WARN_ON(pmd_present(pmd_mknotpresent(pmd)));
>>> +#endif
>>
>> Can we add a stub on S390 instead ?
>
> Actually we dont have to. pmd_mknotpresent() is required for platforms
> that do not have __HAVE_ARCH_PMDP_INVALIDATE. Hence can wrap this code
> with !__HAVE_ARCH_PMDP_INVALIDATE to prevent build failures on such
> platforms like s390.
>
>>
>>> +}
>>> +
>>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>
>> Same ?
>
> The problem is, neither pud_mknotpresent() nor pfn_pud() have a generic
> fallback definition. So will have to keep this #ifdef.
>
>>
>>> +static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    pud_t pud;
>>> +
>>> +    /*
>>> +     * pud_trans_huge() and pud_present() must return negative
>>> +     * after MMU invalidation with pud_mknotpresent().
>>> +     */
>>> +    pud = pfn_pud(pfn, prot);
>>> +    WARN_ON(!pud_trans_huge(pud_mkhuge(pud)));
>>> +    WARN_ON(pud_trans_huge(pud_mknotpresent(pud)));
>>> +    WARN_ON(pud_present(pud_mknotpresent(pud)));
>>> +}
>>> +#else
>>> +static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot) { }
>>> +#endif
>>> +#else
>>> +static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot) { }
>>> +static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot) { }
>>> +#endif
>>> +
>>>   static unsigned long __init get_random_vaddr(void)
>>>   {
>>>       unsigned long random_vaddr, random_pages, total_user_pages;
>>> @@ -302,13 +567,14 @@ static unsigned long __init get_random_vaddr(void)
>>>   void __init debug_vm_pgtable(void)
>>>   {
>>>       struct mm_struct *mm;
>>> +    struct page *page;
>>>       pgd_t *pgdp;
>>>       p4d_t *p4dp, *saved_p4dp;
>>>       pud_t *pudp, *saved_pudp;
>>>       pmd_t *pmdp, *saved_pmdp, pmd;
>>>       pte_t *ptep;
>>>       pgtable_t saved_ptep;
>>> -    pgprot_t prot;
>>> +    pgprot_t prot, protnone;
>>>       phys_addr_t paddr;
>>>       unsigned long vaddr, pte_aligned, pmd_aligned;
>>>       unsigned long pud_aligned, p4d_aligned, pgd_aligned;
>>> @@ -322,6 +588,25 @@ void __init debug_vm_pgtable(void)
>>>           return;
>>>       }
>>>   +    /*
>>> +     * swap_migration_tests() requires a dedicated page as it needs to
>>> +     * be locked before creating a migration entry from it. Locking the
>>> +     * page that actually maps kernel text ('start_kernel') can be real
>>> +     * problematic. Lets allocate a dedicated page explicitly for this
>>> +     * purpose that will be freed later.
>>> +     */
>>> +    page = alloc_page(GFP_KERNEL);
>>
>> Can we do the page allocation and freeing in swap_migration_tests()  
>> instead ?
>
> Although all the resources used in the helpers have been allocated  
> in the main
> function itself before being passed down and later freed. But may be just an
> exception could be made for swap_migration_tests() function as the allocated
> page is being exclusively used here. Later on if we need this page for some
> other future tests, then will have to move it back to debug_vm_pgtable().


