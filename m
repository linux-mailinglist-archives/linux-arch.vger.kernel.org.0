Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1EF20D304
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 21:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgF2Sy7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:54:59 -0400
Received: from foss.arm.com ([217.140.110.172]:36804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbgF2Sy5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Jun 2020 14:54:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9498131B;
        Mon, 29 Jun 2020 01:15:58 -0700 (PDT)
Received: from [10.163.83.176] (unknown [10.163.83.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CA863F71E;
        Mon, 29 Jun 2020 01:15:47 -0700 (PDT)
Subject: Re: [PATCH V3 2/4] mm/debug_vm_pgtable: Add tests validating advanced
 arch page table helpers
To:     Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org
Cc:     ziy@nvidia.com, gerald.schaefer@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
 <1592192277-8421-3-git-send-email-anshuman.khandual@arm.com>
 <4da41eee-5ce0-2a5e-40eb-4424655b3489@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1a6138ca-40b0-5076-2f09-4ce6b7ee8d36@arm.com>
Date:   Mon, 29 Jun 2020 13:45:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4da41eee-5ce0-2a5e-40eb-4424655b3489@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 06/27/2020 12:56 PM, Christophe Leroy wrote:
> 
> 
> Le 15/06/2020 à 05:37, Anshuman Khandual a écrit :
>> This adds new tests validating for these following arch advanced page table
>> helpers. These tests create and test specific mapping types at various page
>> table levels.
>>
>> 1. pxxp_set_wrprotect()
>> 2. pxxp_get_and_clear()
>> 3. pxxp_set_access_flags()
>> 4. pxxp_get_and_clear_full()
>> 5. pxxp_test_and_clear_young()
>> 6. pxx_leaf()
>> 7. pxx_set_huge()
>> 8. pxx_(clear|mk)_savedwrite()
>> 9. huge_pxxp_xxx()
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: linux-snps-arc@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-s390@vger.kernel.org
>> Cc: linux-riscv@lists.infradead.org
>> Cc: x86@kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   mm/debug_vm_pgtable.c | 306 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 306 insertions(+)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index ffa163d4c63c..e3f9f8317a98 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/module.h>
>>   #include <linux/pfn_t.h>
>>   #include <linux/printk.h>
>> +#include <linux/pgtable.h>
>>   #include <linux/random.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/swap.h>
>> @@ -28,6 +29,7 @@
>>   #include <linux/start_kernel.h>
>>   #include <linux/sched/mm.h>
>>   #include <asm/pgalloc.h>
>> +#include <asm/tlbflush.h>
>>     #define VMFLAGS    (VM_READ|VM_WRITE|VM_EXEC)
>>   @@ -55,6 +57,54 @@ static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
>>       WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
>>   }
>>   +static void __init pte_advanced_tests(struct mm_struct *mm,
>> +            struct vm_area_struct *vma, pte_t *ptep,
>> +            unsigned long pfn, unsigned long vaddr, pgprot_t prot)
> 
> Align args properly.
> 
>> +{
>> +    pte_t pte = pfn_pte(pfn, prot);
>> +
>> +    pte = pfn_pte(pfn, prot);
>> +    set_pte_at(mm, vaddr, ptep, pte);
>> +    ptep_set_wrprotect(mm, vaddr, ptep);
>> +    pte = READ_ONCE(*ptep);
>> +    WARN_ON(pte_write(pte));
>> +
>> +    pte = pfn_pte(pfn, prot);
>> +    set_pte_at(mm, vaddr, ptep, pte);
>> +    ptep_get_and_clear(mm, vaddr, ptep);
>> +    pte = READ_ONCE(*ptep);
>> +    WARN_ON(!pte_none(pte));
>> +
>> +    pte = pfn_pte(pfn, prot);
>> +    pte = pte_wrprotect(pte);
>> +    pte = pte_mkclean(pte);
>> +    set_pte_at(mm, vaddr, ptep, pte);
>> +    pte = pte_mkwrite(pte);
>> +    pte = pte_mkdirty(pte);
>> +    ptep_set_access_flags(vma, vaddr, ptep, pte, 1);
>> +    pte = READ_ONCE(*ptep);
>> +    WARN_ON(!(pte_write(pte) && pte_dirty(pte)));
>> +
>> +    pte = pfn_pte(pfn, prot);
>> +    set_pte_at(mm, vaddr, ptep, pte);
>> +    ptep_get_and_clear_full(mm, vaddr, ptep, 1);
>> +    pte = READ_ONCE(*ptep);
>> +    WARN_ON(!pte_none(pte));
>> +
>> +    pte = pte_mkyoung(pte);
>> +    set_pte_at(mm, vaddr, ptep, pte);
>> +    ptep_test_and_clear_young(vma, vaddr, ptep);
>> +    pte = READ_ONCE(*ptep);
>> +    WARN_ON(pte_young(pte));
>> +}
>> +
>> +static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>> +{
>> +    pte_t pte = pfn_pte(pfn, prot);
>> +
>> +    WARN_ON(!pte_savedwrite(pte_mk_savedwrite(pte_clear_savedwrite(pte))));
>> +    WARN_ON(pte_savedwrite(pte_clear_savedwrite(pte_mk_savedwrite(pte))));
>> +}
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
>>   {
>> @@ -77,6 +127,89 @@ static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
>>       WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
>>   }
>>   +static void __init pmd_advanced_tests(struct mm_struct *mm,
>> +        struct vm_area_struct *vma, pmd_t *pmdp,
>> +        unsigned long pfn, unsigned long vaddr, pgprot_t prot)
> 
> Align args properly
> 
>> +{
>> +    pmd_t pmd = pfn_pmd(pfn, prot);
>> +
>> +    if (!has_transparent_hugepage())
>> +        return;
>> +
>> +    /* Align the address wrt HPAGE_PMD_SIZE */
>> +    vaddr = (vaddr & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE;
>> +
>> +    pmd = pfn_pmd(pfn, prot);
>> +    set_pmd_at(mm, vaddr, pmdp, pmd);
>> +    pmdp_set_wrprotect(mm, vaddr, pmdp);
>> +    pmd = READ_ONCE(*pmdp);
>> +    WARN_ON(pmd_write(pmd));
>> +
>> +    pmd = pfn_pmd(pfn, prot);
>> +    set_pmd_at(mm, vaddr, pmdp, pmd);
>> +    pmdp_huge_get_and_clear(mm, vaddr, pmdp);
>> +    pmd = READ_ONCE(*pmdp);
>> +    WARN_ON(!pmd_none(pmd));
>> +
>> +    pmd = pfn_pmd(pfn, prot);
>> +    pmd = pmd_wrprotect(pmd);
>> +    pmd = pmd_mkclean(pmd);
>> +    set_pmd_at(mm, vaddr, pmdp, pmd);
>> +    pmd = pmd_mkwrite(pmd);
>> +    pmd = pmd_mkdirty(pmd);
>> +    pmdp_set_access_flags(vma, vaddr, pmdp, pmd, 1);
>> +    pmd = READ_ONCE(*pmdp);
>> +    WARN_ON(!(pmd_write(pmd) && pmd_dirty(pmd)));
>> +
>> +    pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>> +    set_pmd_at(mm, vaddr, pmdp, pmd);
>> +    pmdp_huge_get_and_clear_full(vma, vaddr, pmdp, 1);
>> +    pmd = READ_ONCE(*pmdp);
>> +    WARN_ON(!pmd_none(pmd));
>> +
>> +    pmd = pmd_mkyoung(pmd);
>> +    set_pmd_at(mm, vaddr, pmdp, pmd);
>> +    pmdp_test_and_clear_young(vma, vaddr, pmdp);
>> +    pmd = READ_ONCE(*pmdp);
>> +    WARN_ON(pmd_young(pmd));
>> +}
>> +
>> +static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
>> +{
>> +    pmd_t pmd = pfn_pmd(pfn, prot);
>> +
>> +    /*
>> +     * PMD based THP is a leaf entry.
>> +     */
>> +    pmd = pmd_mkhuge(pmd);
>> +    WARN_ON(!pmd_leaf(pmd));
>> +}
>> +
>> +static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>> +{
>> +    pmd_t pmd;
>> +
>> +    if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
>> +        return;
>> +    /*
>> +     * X86 defined pmd_set_huge() verifies that the given
>> +     * PMD is not a populated non-leaf entry.
>> +     */
>> +    WRITE_ONCE(*pmdp, __pmd(0));
>> +    WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
>> +    WARN_ON(!pmd_clear_huge(pmdp));
>> +    pmd = READ_ONCE(*pmdp);
>> +    WARN_ON(!pmd_none(pmd));
>> +}
>> +
>> +static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>> +{
>> +    pmd_t pmd = pfn_pmd(pfn, prot);
>> +
>> +    WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clear_savedwrite(pmd))));
>> +    WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk_savedwrite(pmd))));
>> +}
>> +
>>   #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>   static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot)
>>   {
>> @@ -100,12 +233,115 @@ static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot)
>>        */
>>       WARN_ON(!pud_bad(pud_mkhuge(pud)));
>>   }
>> +
>> +static void pud_advanced_tests(struct mm_struct *mm,
>> +        struct vm_area_struct *vma, pud_t *pudp,
>> +        unsigned long pfn, unsigned long vaddr, pgprot_t prot)
> 
> Align args properly
> 
>> +{
>> +    pud_t pud = pfn_pud(pfn, prot);
>> +
>> +    if (!has_transparent_hugepage())
>> +        return;
>> +
>> +    /* Align the address wrt HPAGE_PUD_SIZE */
>> +    vaddr = (vaddr & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE;
>> +
>> +    set_pud_at(mm, vaddr, pudp, pud);
>> +    pudp_set_wrprotect(mm, vaddr, pudp);
>> +    pud = READ_ONCE(*pudp);
>> +    WARN_ON(pud_write(pud));
>> +
>> +#ifndef __PAGETABLE_PMD_FOLDED
>> +    pud = pfn_pud(pfn, prot);
>> +    set_pud_at(mm, vaddr, pudp, pud);
>> +    pudp_huge_get_and_clear(mm, vaddr, pudp);
>> +    pud = READ_ONCE(*pudp);
>> +    WARN_ON(!pud_none(pud));
>> +
>> +    pud = pfn_pud(pfn, prot);
>> +    set_pud_at(mm, vaddr, pudp, pud);
>> +    pudp_huge_get_and_clear_full(mm, vaddr, pudp, 1);
>> +    pud = READ_ONCE(*pudp);
>> +    WARN_ON(!pud_none(pud));
>> +#endif /* __PAGETABLE_PMD_FOLDED */
>> +    pud = pfn_pud(pfn, prot);
>> +    pud = pud_wrprotect(pud);
>> +    pud = pud_mkclean(pud);
>> +    set_pud_at(mm, vaddr, pudp, pud);
>> +    pud = pud_mkwrite(pud);
>> +    pud = pud_mkdirty(pud);
>> +    pudp_set_access_flags(vma, vaddr, pudp, pud, 1);
>> +    pud = READ_ONCE(*pudp);
>> +    WARN_ON(!(pud_write(pud) && pud_dirty(pud)));
>> +
>> +    pud = pud_mkyoung(pud);
>> +    set_pud_at(mm, vaddr, pudp, pud);
>> +    pudp_test_and_clear_young(vma, vaddr, pudp);
>> +    pud = READ_ONCE(*pudp);
>> +    WARN_ON(pud_young(pud));
>> +}
>> +
>> +static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
>> +{
>> +    pud_t pud = pfn_pud(pfn, prot);
>> +
>> +    /*
>> +     * PUD based THP is a leaf entry.
>> +     */
>> +    pud = pud_mkhuge(pud);
>> +    WARN_ON(!pud_leaf(pud));
>> +}
>> +
>> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>> +{
>> +    pud_t pud;
>> +
>> +    if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
>> +        return;
>> +    /*
>> +     * X86 defined pud_set_huge() verifies that the given
>> +     * PUD is not a populated non-leaf entry.
>> +     */
>> +    WRITE_ONCE(*pudp, __pud(0));
>> +    WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
>> +    WARN_ON(!pud_clear_huge(pudp));
>> +    pud = READ_ONCE(*pudp);
>> +    WARN_ON(!pud_none(pud));
>> +}
>>   #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>>   static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
>> +static void pud_advanced_tests(struct mm_struct *mm,
>> +        struct vm_area_struct *vma, pud_t *pudp,
>> +        unsigned long pfn, unsigned long vaddr, pgprot_t prot)
> 
> Align args properly
> 
>> +{
>> +}
>> +static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
>> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>> +{
>> +}
>>   #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>>   #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
>>   static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot) { }
>>   static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
>> +static void __init pmd_advanced_tests(struct mm_struct *mm,
>> +        struct vm_area_struct *vma, pmd_t *pmdp,
>> +        unsigned long pfn, unsigned long vaddr, pgprot_t prot)
> 
> Align args properly
> 
>> +{
>> +}
>> +static void __init pud_advanced_tests(struct mm_struct *mm,
>> +        struct vm_area_struct *vma, pud_t *pudp,
>> +        unsigned long pfn, unsigned long vaddr, pgprot_t prot)
> 
> Align args properly
> 

Sure, will fix the arguments alignment in the above mentioned places.
