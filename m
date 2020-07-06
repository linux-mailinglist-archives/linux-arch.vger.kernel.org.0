Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966622150A0
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 02:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgGFAts (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jul 2020 20:49:48 -0400
Received: from foss.arm.com ([217.140.110.172]:43440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgGFAtr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Jul 2020 20:49:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A62C30E;
        Sun,  5 Jul 2020 17:49:46 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.84.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3CDAA3F718;
        Sun,  5 Jul 2020 17:49:36 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
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
Subject: [PATCH V4 3/4] mm/debug_vm_pgtable: Add debug prints for individual tests
Date:   Mon,  6 Jul 2020 06:18:35 +0530
Message-Id: <1593996516-7186-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593996516-7186-1-git-send-email-anshuman.khandual@arm.com>
References: <1593996516-7186-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds debug print information that enlists all tests getting executed
on a given platform. With dynamic debug enabled, the following information
will be splashed during boot. For compactness purpose, dropped both time
stamp and prefix (i.e debug_vm_pgtable) from this sample output.

[debug_vm_pgtable      ]: Validating architecture page table helpers
[pte_basic_tests       ]: Validating PTE basic
[pmd_basic_tests       ]: Validating PMD basic
[p4d_basic_tests       ]: Validating P4D basic
[pgd_basic_tests       ]: Validating PGD basic
[pte_clear_tests       ]: Validating PTE clear
[pmd_clear_tests       ]: Validating PMD clear
[pte_advanced_tests    ]: Validating PTE advanced
[pmd_advanced_tests    ]: Validating PMD advanced
[hugetlb_advanced_tests]: Validating HugeTLB advanced
[pmd_leaf_tests        ]: Validating PMD leaf
[pmd_huge_tests        ]: Validating PMD huge
[pte_savedwrite_tests  ]: Validating PTE saved write
[pmd_savedwrite_tests  ]: Validating PMD saved write
[pmd_populate_tests    ]: Validating PMD populate
[pte_special_tests     ]: Validating PTE special
[pte_protnone_tests    ]: Validating PTE protnone
[pmd_protnone_tests    ]: Validating PMD protnone
[pte_devmap_tests      ]: Validating PTE devmap
[pmd_devmap_tests      ]: Validating PMD devmap
[pte_swap_tests        ]: Validating PTE swap
[swap_migration_tests  ]: Validating swap migration
[hugetlb_basic_tests   ]: Validating HugeTLB basic
[pmd_thp_tests         ]: Validating PMD based THP

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Tested-by: Vineet Gupta <vgupta@synopsys.com>	#arc
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index dc72825f94a4..a9ae8cb7e832 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -8,7 +8,7 @@
  *
  * Author: Anshuman Khandual <anshuman.khandual@arm.com>
  */
-#define pr_fmt(fmt) "debug_vm_pgtable: %s: " fmt, __func__
+#define pr_fmt(fmt) "debug_vm_pgtable: [%-25s]: " fmt, __func__
 
 #include <linux/gfp.h>
 #include <linux/highmem.h>
@@ -48,6 +48,7 @@ static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
 {
 	pte_t pte = pfn_pte(pfn, prot);
 
+	pr_debug("Validating PTE basic\n");
 	WARN_ON(!pte_same(pte, pte));
 	WARN_ON(!pte_young(pte_mkyoung(pte_mkold(pte))));
 	WARN_ON(!pte_dirty(pte_mkdirty(pte_mkclean(pte))));
@@ -64,6 +65,7 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
 {
 	pte_t pte = pfn_pte(pfn, prot);
 
+	pr_debug("Validating PTE advanced\n");
 	pte = pfn_pte(pfn, prot);
 	set_pte_at(mm, vaddr, ptep, pte);
 	ptep_set_wrprotect(mm, vaddr, ptep);
@@ -103,6 +105,7 @@ static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 {
 	pte_t pte = pfn_pte(pfn, prot);
 
+	pr_debug("Validating PTE saved write\n");
 	WARN_ON(!pte_savedwrite(pte_mk_savedwrite(pte_clear_savedwrite(pte))));
 	WARN_ON(pte_savedwrite(pte_clear_savedwrite(pte_mk_savedwrite(pte))));
 }
@@ -114,6 +117,7 @@ static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
 	if (!has_transparent_hugepage())
 		return;
 
+	pr_debug("Validating PMD basic\n");
 	WARN_ON(!pmd_same(pmd, pmd));
 	WARN_ON(!pmd_young(pmd_mkyoung(pmd_mkold(pmd))));
 	WARN_ON(!pmd_dirty(pmd_mkdirty(pmd_mkclean(pmd))));
@@ -138,6 +142,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
 	if (!has_transparent_hugepage())
 		return;
 
+	pr_debug("Validating PMD advanced\n");
 	/* Align the address wrt HPAGE_PMD_SIZE */
 	vaddr = (vaddr & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE;
 
@@ -180,6 +185,7 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
 {
 	pmd_t pmd = pfn_pmd(pfn, prot);
 
+	pr_debug("Validating PMD leaf\n");
 	/*
 	 * PMD based THP is a leaf entry.
 	 */
@@ -193,6 +199,8 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
 
 	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
 		return;
+
+	pr_debug("Validating PMD huge\n");
 	/*
 	 * X86 defined pmd_set_huge() verifies that the given
 	 * PMD is not a populated non-leaf entry.
@@ -208,6 +216,7 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 {
 	pmd_t pmd = pfn_pmd(pfn, prot);
 
+	pr_debug("Validating PMD saved write\n");
 	WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clear_savedwrite(pmd))));
 	WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk_savedwrite(pmd))));
 }
@@ -220,6 +229,7 @@ static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot)
 	if (!has_transparent_hugepage())
 		return;
 
+	pr_debug("Validating PUD basic\n");
 	WARN_ON(!pud_same(pud, pud));
 	WARN_ON(!pud_young(pud_mkyoung(pud_mkold(pud))));
 	WARN_ON(!pud_write(pud_mkwrite(pud_wrprotect(pud))));
@@ -246,6 +256,7 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
 	if (!has_transparent_hugepage())
 		return;
 
+	pr_debug("Validating PUD advanced\n");
 	/* Align the address wrt HPAGE_PUD_SIZE */
 	vaddr = (vaddr & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE;
 
@@ -288,6 +299,7 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
 {
 	pud_t pud = pfn_pud(pfn, prot);
 
+	pr_debug("Validating PUD leaf\n");
 	/*
 	 * PUD based THP is a leaf entry.
 	 */
@@ -301,6 +313,8 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
 
 	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
 		return;
+
+	pr_debug("Validating PUD huge\n");
 	/*
 	 * X86 defined pud_set_huge() verifies that the given
 	 * PUD is not a populated non-leaf entry.
@@ -354,6 +368,7 @@ static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
 {
 	p4d_t p4d;
 
+	pr_debug("Validating P4D basic\n");
 	memset(&p4d, RANDOM_NZVALUE, sizeof(p4d_t));
 	WARN_ON(!p4d_same(p4d, p4d));
 }
@@ -362,6 +377,7 @@ static void __init pgd_basic_tests(unsigned long pfn, pgprot_t prot)
 {
 	pgd_t pgd;
 
+	pr_debug("Validating PGD basic\n");
 	memset(&pgd, RANDOM_NZVALUE, sizeof(pgd_t));
 	WARN_ON(!pgd_same(pgd, pgd));
 }
@@ -374,6 +390,7 @@ static void __init pud_clear_tests(struct mm_struct *mm, pud_t *pudp)
 	if (mm_pmd_folded(mm))
 		return;
 
+	pr_debug("Validating PUD clear\n");
 	pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
 	WRITE_ONCE(*pudp, pud);
 	pud_clear(pudp);
@@ -388,6 +405,8 @@ static void __init pud_populate_tests(struct mm_struct *mm, pud_t *pudp,
 
 	if (mm_pmd_folded(mm))
 		return;
+
+	pr_debug("Validating PUD populate\n");
 	/*
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as pud_bad().
@@ -414,6 +433,7 @@ static void __init p4d_clear_tests(struct mm_struct *mm, p4d_t *p4dp)
 	if (mm_pud_folded(mm))
 		return;
 
+	pr_debug("Validating P4D clear\n");
 	p4d = __p4d(p4d_val(p4d) | RANDOM_ORVALUE);
 	WRITE_ONCE(*p4dp, p4d);
 	p4d_clear(p4dp);
@@ -429,6 +449,7 @@ static void __init p4d_populate_tests(struct mm_struct *mm, p4d_t *p4dp,
 	if (mm_pud_folded(mm))
 		return;
 
+	pr_debug("Validating P4D populate\n");
 	/*
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as p4d_bad().
@@ -447,6 +468,7 @@ static void __init pgd_clear_tests(struct mm_struct *mm, pgd_t *pgdp)
 	if (mm_p4d_folded(mm))
 		return;
 
+	pr_debug("Validating PGD clear\n");
 	pgd = __pgd(pgd_val(pgd) | RANDOM_ORVALUE);
 	WRITE_ONCE(*pgdp, pgd);
 	pgd_clear(pgdp);
@@ -462,6 +484,7 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
 	if (mm_p4d_folded(mm))
 		return;
 
+	pr_debug("Validating PGD populate\n");
 	/*
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as pgd_bad().
@@ -490,6 +513,7 @@ static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
 {
 	pte_t pte = ptep_get(ptep);
 
+	pr_debug("Validating PTE clear\n");
 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
 	set_pte_at(mm, vaddr, ptep, pte);
 	barrier();
@@ -502,6 +526,7 @@ static void __init pmd_clear_tests(struct mm_struct *mm, pmd_t *pmdp)
 {
 	pmd_t pmd = READ_ONCE(*pmdp);
 
+	pr_debug("Validating PMD clear\n");
 	pmd = __pmd(pmd_val(pmd) | RANDOM_ORVALUE);
 	WRITE_ONCE(*pmdp, pmd);
 	pmd_clear(pmdp);
@@ -514,6 +539,7 @@ static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
 {
 	pmd_t pmd;
 
+	pr_debug("Validating PMD populate\n");
 	/*
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as pmd_bad().
@@ -531,6 +557,7 @@ static void __init pte_special_tests(unsigned long pfn, pgprot_t prot)
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL))
 		return;
 
+	pr_debug("Validating PTE special\n");
 	WARN_ON(!pte_special(pte_mkspecial(pte)));
 }
 
@@ -541,6 +568,7 @@ static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
 	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
 		return;
 
+	pr_debug("Validating PTE protnone\n");
 	WARN_ON(!pte_protnone(pte));
 	WARN_ON(!pte_present(pte));
 }
@@ -553,6 +581,7 @@ static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
 	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
 		return;
 
+	pr_debug("Validating PMD protnone\n");
 	WARN_ON(!pmd_protnone(pmd));
 	WARN_ON(!pmd_present(pmd));
 }
@@ -565,6 +594,7 @@ static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot)
 {
 	pte_t pte = pfn_pte(pfn, prot);
 
+	pr_debug("Validating PTE devmap\n");
 	WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
 }
 
@@ -573,6 +603,7 @@ static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
 {
 	pmd_t pmd = pfn_pmd(pfn, prot);
 
+	pr_debug("Validating PMD devmap\n");
 	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
 }
 
@@ -581,6 +612,7 @@ static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
 {
 	pud_t pud = pfn_pud(pfn, prot);
 
+	pr_debug("Validating PUD devmap\n");
 	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
 }
 #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
@@ -603,6 +635,7 @@ static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
 
+	pr_debug("Validating PTE soft dirty\n");
 	WARN_ON(!pte_soft_dirty(pte_mksoft_dirty(pte)));
 	WARN_ON(pte_soft_dirty(pte_clear_soft_dirty(pte)));
 }
@@ -614,6 +647,7 @@ static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
 
+	pr_debug("Validating PTE swap soft dirty\n");
 	WARN_ON(!pte_swp_soft_dirty(pte_swp_mksoft_dirty(pte)));
 	WARN_ON(pte_swp_soft_dirty(pte_swp_clear_soft_dirty(pte)));
 }
@@ -626,6 +660,7 @@ static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
 
+	pr_debug("Validating PMD soft dirty\n");
 	WARN_ON(!pmd_soft_dirty(pmd_mksoft_dirty(pmd)));
 	WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
 }
@@ -638,6 +673,7 @@ static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 		!IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
 		return;
 
+	pr_debug("Validating PMD swap soft dirty\n");
 	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
 	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
 }
@@ -653,6 +689,7 @@ static void __init pte_swap_tests(unsigned long pfn, pgprot_t prot)
 	swp_entry_t swp;
 	pte_t pte;
 
+	pr_debug("Validating PTE swap\n");
 	pte = pfn_pte(pfn, prot);
 	swp = __pte_to_swp_entry(pte);
 	pte = __swp_entry_to_pte(swp);
@@ -665,6 +702,7 @@ static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
 	swp_entry_t swp;
 	pmd_t pmd;
 
+	pr_debug("Validating PMD swap\n");
 	pmd = pfn_pmd(pfn, prot);
 	swp = __pmd_to_swp_entry(pmd);
 	pmd = __swp_entry_to_pmd(swp);
@@ -681,6 +719,8 @@ static void __init swap_migration_tests(void)
 
 	if (!IS_ENABLED(CONFIG_MIGRATION))
 		return;
+
+	pr_debug("Validating swap migration\n");
 	/*
 	 * swap_migration_tests() requires a dedicated page as it needs to
 	 * be locked before creating a migration entry from it. Locking the
@@ -720,6 +760,7 @@ static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
 	struct page *page;
 	pte_t pte;
 
+	pr_debug("Validating HugeTLB basic\n");
 	/*
 	 * Accessing the page associated with the pfn is safe here,
 	 * as it was previously derived from a real kernel symbol.
@@ -747,6 +788,7 @@ static void __init hugetlb_advanced_tests(struct mm_struct *mm,
 	pte_t pte = ptep_get(ptep);
 	unsigned long paddr = (__pfn_to_phys(pfn) | RANDOM_ORVALUE) & PMD_MASK;
 
+	pr_debug("Validating HugeTLB advanced\n");
 	pte = pte_mkhuge(mk_pte(pfn_to_page(PHYS_PFN(paddr)), prot));
 	set_huge_pte_at(mm, vaddr, ptep, pte);
 	barrier();
@@ -797,6 +839,7 @@ static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
 	if (!has_transparent_hugepage())
 		return;
 
+	pr_debug("Validating PMD based THP\n");
 	/*
 	 * pmd_trans_huge() and pmd_present() must return positive after
 	 * MMU invalidation with pmd_mkinvalid(). This behavior is an
@@ -825,6 +868,7 @@ static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
 	if (!has_transparent_hugepage())
 		return;
 
+	pr_debug("Validating PUD based THP\n");
 	pud = pfn_pud(pfn, prot);
 	WARN_ON(!pud_trans_huge(pud_mkhuge(pud)));
 
-- 
2.20.1

