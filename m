Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB75320BF5A
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jun 2020 09:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgF0H10 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jun 2020 03:27:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27838 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgF0H10 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Jun 2020 03:27:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49v50y2n7Lz9tyWd;
        Sat, 27 Jun 2020 09:26:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pXgL3pLy5jWH; Sat, 27 Jun 2020 09:26:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49v50y1hbJz9tyWZ;
        Sat, 27 Jun 2020 09:26:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F5AE8B772;
        Sat, 27 Jun 2020 09:26:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id A0nwexkhePdw; Sat, 27 Jun 2020 09:26:59 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D7FC8B75B;
        Sat, 27 Jun 2020 09:26:57 +0200 (CEST)
Subject: Re: [PATCH V3 2/4] mm/debug_vm_pgtable: Add tests validating advanced
 arch page table helpers
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
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
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4da41eee-5ce0-2a5e-40eb-4424655b3489@csgroup.eu>
Date:   Sat, 27 Jun 2020 09:26:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592192277-8421-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 15/06/2020 à 05:37, Anshuman Khandual a écrit :
> This adds new tests validating for these following arch advanced page table
> helpers. These tests create and test specific mapping types at various page
> table levels.
> 
> 1. pxxp_set_wrprotect()
> 2. pxxp_get_and_clear()
> 3. pxxp_set_access_flags()
> 4. pxxp_get_and_clear_full()
> 5. pxxp_test_and_clear_young()
> 6. pxx_leaf()
> 7. pxx_set_huge()
> 8. pxx_(clear|mk)_savedwrite()
> 9. huge_pxxp_xxx()
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
> Cc: linux-mm@kvack.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   mm/debug_vm_pgtable.c | 306 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 306 insertions(+)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index ffa163d4c63c..e3f9f8317a98 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -21,6 +21,7 @@
>   #include <linux/module.h>
>   #include <linux/pfn_t.h>
>   #include <linux/printk.h>
> +#include <linux/pgtable.h>
>   #include <linux/random.h>
>   #include <linux/spinlock.h>
>   #include <linux/swap.h>
> @@ -28,6 +29,7 @@
>   #include <linux/start_kernel.h>
>   #include <linux/sched/mm.h>
>   #include <asm/pgalloc.h>
> +#include <asm/tlbflush.h>
>   
>   #define VMFLAGS	(VM_READ|VM_WRITE|VM_EXEC)
>   
> @@ -55,6 +57,54 @@ static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
>   	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
>   }
>   
> +static void __init pte_advanced_tests(struct mm_struct *mm,
> +			struct vm_area_struct *vma, pte_t *ptep,
> +			unsigned long pfn, unsigned long vaddr, pgprot_t prot)

Align args properly.

> +{
> +	pte_t pte = pfn_pte(pfn, prot);
> +
> +	pte = pfn_pte(pfn, prot);
> +	set_pte_at(mm, vaddr, ptep, pte);
> +	ptep_set_wrprotect(mm, vaddr, ptep);
> +	pte = READ_ONCE(*ptep);
> +	WARN_ON(pte_write(pte));
> +
> +	pte = pfn_pte(pfn, prot);
> +	set_pte_at(mm, vaddr, ptep, pte);
> +	ptep_get_and_clear(mm, vaddr, ptep);
> +	pte = READ_ONCE(*ptep);
> +	WARN_ON(!pte_none(pte));
> +
> +	pte = pfn_pte(pfn, prot);
> +	pte = pte_wrprotect(pte);
> +	pte = pte_mkclean(pte);
> +	set_pte_at(mm, vaddr, ptep, pte);
> +	pte = pte_mkwrite(pte);
> +	pte = pte_mkdirty(pte);
> +	ptep_set_access_flags(vma, vaddr, ptep, pte, 1);
> +	pte = READ_ONCE(*ptep);
> +	WARN_ON(!(pte_write(pte) && pte_dirty(pte)));
> +
> +	pte = pfn_pte(pfn, prot);
> +	set_pte_at(mm, vaddr, ptep, pte);
> +	ptep_get_and_clear_full(mm, vaddr, ptep, 1);
> +	pte = READ_ONCE(*ptep);
> +	WARN_ON(!pte_none(pte));
> +
> +	pte = pte_mkyoung(pte);
> +	set_pte_at(mm, vaddr, ptep, pte);
> +	ptep_test_and_clear_young(vma, vaddr, ptep);
> +	pte = READ_ONCE(*ptep);
> +	WARN_ON(pte_young(pte));
> +}
> +
> +static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pte_t pte = pfn_pte(pfn, prot);
> +
> +	WARN_ON(!pte_savedwrite(pte_mk_savedwrite(pte_clear_savedwrite(pte))));
> +	WARN_ON(pte_savedwrite(pte_clear_savedwrite(pte_mk_savedwrite(pte))));
> +}
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
>   {
> @@ -77,6 +127,89 @@ static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
>   	WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
>   }
>   
> +static void __init pmd_advanced_tests(struct mm_struct *mm,
> +		struct vm_area_struct *vma, pmd_t *pmdp,
> +		unsigned long pfn, unsigned long vaddr, pgprot_t prot)

Align args properly

> +{
> +	pmd_t pmd = pfn_pmd(pfn, prot);
> +
> +	if (!has_transparent_hugepage())
> +		return;
> +
> +	/* Align the address wrt HPAGE_PMD_SIZE */
> +	vaddr = (vaddr & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE;
> +
> +	pmd = pfn_pmd(pfn, prot);
> +	set_pmd_at(mm, vaddr, pmdp, pmd);
> +	pmdp_set_wrprotect(mm, vaddr, pmdp);
> +	pmd = READ_ONCE(*pmdp);
> +	WARN_ON(pmd_write(pmd));
> +
> +	pmd = pfn_pmd(pfn, prot);
> +	set_pmd_at(mm, vaddr, pmdp, pmd);
> +	pmdp_huge_get_and_clear(mm, vaddr, pmdp);
> +	pmd = READ_ONCE(*pmdp);
> +	WARN_ON(!pmd_none(pmd));
> +
> +	pmd = pfn_pmd(pfn, prot);
> +	pmd = pmd_wrprotect(pmd);
> +	pmd = pmd_mkclean(pmd);
> +	set_pmd_at(mm, vaddr, pmdp, pmd);
> +	pmd = pmd_mkwrite(pmd);
> +	pmd = pmd_mkdirty(pmd);
> +	pmdp_set_access_flags(vma, vaddr, pmdp, pmd, 1);
> +	pmd = READ_ONCE(*pmdp);
> +	WARN_ON(!(pmd_write(pmd) && pmd_dirty(pmd)));
> +
> +	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
> +	set_pmd_at(mm, vaddr, pmdp, pmd);
> +	pmdp_huge_get_and_clear_full(vma, vaddr, pmdp, 1);
> +	pmd = READ_ONCE(*pmdp);
> +	WARN_ON(!pmd_none(pmd));
> +
> +	pmd = pmd_mkyoung(pmd);
> +	set_pmd_at(mm, vaddr, pmdp, pmd);
> +	pmdp_test_and_clear_young(vma, vaddr, pmdp);
> +	pmd = READ_ONCE(*pmdp);
> +	WARN_ON(pmd_young(pmd));
> +}
> +
> +static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pmd_t pmd = pfn_pmd(pfn, prot);
> +
> +	/*
> +	 * PMD based THP is a leaf entry.
> +	 */
> +	pmd = pmd_mkhuge(pmd);
> +	WARN_ON(!pmd_leaf(pmd));
> +}
> +
> +static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
> +{
> +	pmd_t pmd;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
> +		return;
> +	/*
> +	 * X86 defined pmd_set_huge() verifies that the given
> +	 * PMD is not a populated non-leaf entry.
> +	 */
> +	WRITE_ONCE(*pmdp, __pmd(0));
> +	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
> +	WARN_ON(!pmd_clear_huge(pmdp));
> +	pmd = READ_ONCE(*pmdp);
> +	WARN_ON(!pmd_none(pmd));
> +}
> +
> +static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pmd_t pmd = pfn_pmd(pfn, prot);
> +
> +	WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clear_savedwrite(pmd))));
> +	WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk_savedwrite(pmd))));
> +}
> +
>   #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>   static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot)
>   {
> @@ -100,12 +233,115 @@ static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot)
>   	 */
>   	WARN_ON(!pud_bad(pud_mkhuge(pud)));
>   }
> +
> +static void pud_advanced_tests(struct mm_struct *mm,
> +		struct vm_area_struct *vma, pud_t *pudp,
> +		unsigned long pfn, unsigned long vaddr, pgprot_t prot)

Align args properly

> +{
> +	pud_t pud = pfn_pud(pfn, prot);
> +
> +	if (!has_transparent_hugepage())
> +		return;
> +
> +	/* Align the address wrt HPAGE_PUD_SIZE */
> +	vaddr = (vaddr & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE;
> +
> +	set_pud_at(mm, vaddr, pudp, pud);
> +	pudp_set_wrprotect(mm, vaddr, pudp);
> +	pud = READ_ONCE(*pudp);
> +	WARN_ON(pud_write(pud));
> +
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	pud = pfn_pud(pfn, prot);
> +	set_pud_at(mm, vaddr, pudp, pud);
> +	pudp_huge_get_and_clear(mm, vaddr, pudp);
> +	pud = READ_ONCE(*pudp);
> +	WARN_ON(!pud_none(pud));
> +
> +	pud = pfn_pud(pfn, prot);
> +	set_pud_at(mm, vaddr, pudp, pud);
> +	pudp_huge_get_and_clear_full(mm, vaddr, pudp, 1);
> +	pud = READ_ONCE(*pudp);
> +	WARN_ON(!pud_none(pud));
> +#endif /* __PAGETABLE_PMD_FOLDED */
> +	pud = pfn_pud(pfn, prot);
> +	pud = pud_wrprotect(pud);
> +	pud = pud_mkclean(pud);
> +	set_pud_at(mm, vaddr, pudp, pud);
> +	pud = pud_mkwrite(pud);
> +	pud = pud_mkdirty(pud);
> +	pudp_set_access_flags(vma, vaddr, pudp, pud, 1);
> +	pud = READ_ONCE(*pudp);
> +	WARN_ON(!(pud_write(pud) && pud_dirty(pud)));
> +
> +	pud = pud_mkyoung(pud);
> +	set_pud_at(mm, vaddr, pudp, pud);
> +	pudp_test_and_clear_young(vma, vaddr, pudp);
> +	pud = READ_ONCE(*pudp);
> +	WARN_ON(pud_young(pud));
> +}
> +
> +static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
> +{
> +	pud_t pud = pfn_pud(pfn, prot);
> +
> +	/*
> +	 * PUD based THP is a leaf entry.
> +	 */
> +	pud = pud_mkhuge(pud);
> +	WARN_ON(!pud_leaf(pud));
> +}
> +
> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
> +{
> +	pud_t pud;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
> +		return;
> +	/*
> +	 * X86 defined pud_set_huge() verifies that the given
> +	 * PUD is not a populated non-leaf entry.
> +	 */
> +	WRITE_ONCE(*pudp, __pud(0));
> +	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
> +	WARN_ON(!pud_clear_huge(pudp));
> +	pud = READ_ONCE(*pudp);
> +	WARN_ON(!pud_none(pud));
> +}
>   #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>   static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
> +static void pud_advanced_tests(struct mm_struct *mm,
> +		struct vm_area_struct *vma, pud_t *pudp,
> +		unsigned long pfn, unsigned long vaddr, pgprot_t prot)

Align args properly

> +{
> +}
> +static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
> +{
> +}
>   #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>   #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
>   static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot) { }
>   static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_advanced_tests(struct mm_struct *mm,
> +		struct vm_area_struct *vma, pmd_t *pmdp,
> +		unsigned long pfn, unsigned long vaddr, pgprot_t prot)

Align args properly

> +{
> +}
> +static void __init pud_advanced_tests(struct mm_struct *mm,
> +		struct vm_area_struct *vma, pud_t *pudp,
> +		unsigned long pfn, unsigned long vaddr, pgprot_t prot)

Align args properly

> +{
> +}
> +static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
> +{
> +}
> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
> +{
> +}
> +static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot) { }
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>   
>   static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
> @@ -495,8 +731,56 @@ static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
>   	WARN_ON(!pte_huge(pte_mkhuge(pte)));
>   #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>   }
> +
> +static void __init hugetlb_advanced_tests(struct mm_struct *mm,
> +					  struct vm_area_struct *vma,
> +					  pte_t *ptep, unsigned long pfn,
> +					  unsigned long vaddr, pgprot_t prot)
> +{
> +	struct page *page = pfn_to_page(pfn);
> +	pte_t pte = READ_ONCE(*ptep);
> +	unsigned long paddr = (__pfn_to_phys(pfn) | RANDOM_ORVALUE) & PMD_MASK;
> +
> +	pte = pte_mkhuge(mk_pte(pfn_to_page(PHYS_PFN(paddr)), prot));
> +	set_huge_pte_at(mm, vaddr, ptep, pte);
> +	barrier();
> +	WARN_ON(!pte_same(pte, huge_ptep_get(ptep)));
> +	huge_pte_clear(mm, vaddr, ptep, PMD_SIZE);
> +	pte = huge_ptep_get(ptep);
> +	WARN_ON(!huge_pte_none(pte));
> +
> +	pte = mk_huge_pte(page, prot);
> +	set_huge_pte_at(mm, vaddr, ptep, pte);
> +	barrier();
> +	huge_ptep_set_wrprotect(mm, vaddr, ptep);
> +	pte = huge_ptep_get(ptep);
> +	WARN_ON(huge_pte_write(pte));
> +
> +	pte = mk_huge_pte(page, prot);
> +	set_huge_pte_at(mm, vaddr, ptep, pte);
> +	barrier();
> +	huge_ptep_get_and_clear(mm, vaddr, ptep);
> +	pte = huge_ptep_get(ptep);
> +	WARN_ON(!huge_pte_none(pte));
> +
> +	pte = mk_huge_pte(page, prot);
> +	pte = huge_pte_wrprotect(pte);
> +	set_huge_pte_at(mm, vaddr, ptep, pte);
> +	barrier();
> +	pte = huge_pte_mkwrite(pte);
> +	pte = huge_pte_mkdirty(pte);
> +	huge_ptep_set_access_flags(vma, vaddr, ptep, pte, 1);
> +	pte = huge_ptep_get(ptep);
> +	WARN_ON(!(huge_pte_write(pte) && huge_pte_dirty(pte)));
> +}
>   #else  /* !CONFIG_HUGETLB_PAGE */
>   static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot) { }
> +static void __init hugetlb_advanced_tests(struct mm_struct *mm,
> +					  struct vm_area_struct *vma,
> +					  pte_t *ptep, unsigned long pfn,
> +					  unsigned long vaddr, pgprot_t prot)
> +{
> +}
>   #endif /* CONFIG_HUGETLB_PAGE */
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -568,6 +852,7 @@ static unsigned long __init get_random_vaddr(void)
>   
>   static int __init debug_vm_pgtable(void)
>   {
> +	struct vm_area_struct *vma;
>   	struct mm_struct *mm;
>   	pgd_t *pgdp;
>   	p4d_t *p4dp, *saved_p4dp;
> @@ -596,6 +881,12 @@ static int __init debug_vm_pgtable(void)
>   	 */
>   	protnone = __P000;
>   
> +	vma = vm_area_alloc(mm);
> +	if (!vma) {
> +		pr_err("vma allocation failed\n");
> +		return 1;
> +	}
> +
>   	/*
>   	 * PFN for mapping at PTE level is determined from a standard kernel
>   	 * text symbol. But pfns for higher page table levels are derived by
> @@ -644,6 +935,20 @@ static int __init debug_vm_pgtable(void)
>   	p4d_clear_tests(mm, p4dp);
>   	pgd_clear_tests(mm, pgdp);
>   
> +	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
> +	pmd_advanced_tests(mm, vma, pmdp, pmd_aligned, vaddr, prot);
> +	pud_advanced_tests(mm, vma, pudp, pud_aligned, vaddr, prot);
> +	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
> +
> +	pmd_leaf_tests(pmd_aligned, prot);
> +	pud_leaf_tests(pud_aligned, prot);
> +
> +	pmd_huge_tests(pmdp, pmd_aligned, prot);
> +	pud_huge_tests(pudp, pud_aligned, prot);
> +
> +	pte_savedwrite_tests(pte_aligned, prot);
> +	pmd_savedwrite_tests(pmd_aligned, prot);
> +
>   	pte_unmap_unlock(ptep, ptl);
>   
>   	pmd_populate_tests(mm, pmdp, saved_ptep);
> @@ -678,6 +983,7 @@ static int __init debug_vm_pgtable(void)
>   	pmd_free(mm, saved_pmdp);
>   	pte_free(mm, saved_ptep);
>   
> +	vm_area_free(vma);
>   	mm_dec_nr_puds(mm);
>   	mm_dec_nr_pmds(mm);
>   	mm_dec_nr_ptes(mm);
> 

Christophe
