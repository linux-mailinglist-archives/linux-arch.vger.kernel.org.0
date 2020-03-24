Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E721904E2
	for <lists+linux-arch@lfdr.de>; Tue, 24 Mar 2020 06:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgCXFX2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Mar 2020 01:23:28 -0400
Received: from foss.arm.com ([217.140.110.172]:57498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgCXFX2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 01:23:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85BE17FA;
        Mon, 23 Mar 2020 22:23:27 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B1163F7C3;
        Mon, 23 Mar 2020 22:27:24 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     christophe.leroy@c-s.fr,
        Anshuman Khandual <anshuman.khandual@arm.com>,
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
Subject: [PATCH V2 1/3] mm/debug: Add tests validating arch page table helpers for core features
Date:   Tue, 24 Mar 2020 10:52:53 +0530
Message-Id: <1585027375-9997-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
References: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds new tests validating arch page table helpers for these following
core memory features. These tests create and test specific mapping types at
various page table levels.

1. SPECIAL mapping
2. PROTNONE mapping
3. DEVMAP mapping
4. SOFTDIRTY mapping
5. SWAP mapping
6. MIGRATION mapping
7. HUGETLB mapping
8. THP mapping

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
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 291 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 290 insertions(+), 1 deletion(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 98990a515268..15055a8f6478 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -289,6 +289,267 @@ static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
 	WARN_ON(pmd_bad(pmd));
 }
 
+static void __init pte_special_tests(unsigned long pfn, pgprot_t prot)
+{
+	pte_t pte = pfn_pte(pfn, prot);
+
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL))
+		return;
+
+	WARN_ON(!pte_special(pte_mkspecial(pte)));
+}
+
+static void __init pte_protnone_tests(unsigned long pfn, pgprot_t prot)
+{
+	pte_t pte = pfn_pte(pfn, prot);
+
+	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
+		return;
+
+	WARN_ON(!pte_protnone(pte));
+	WARN_ON(!pte_present(pte));
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
+{
+	pmd_t pmd = pfn_pmd(pfn, prot);
+
+	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
+		return;
+
+	WARN_ON(!pmd_protnone(pmd));
+	WARN_ON(!pmd_present(pmd));
+}
+#else
+static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot) { }
+#endif
+
+#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
+static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot)
+{
+	pte_t pte = pfn_pte(pfn, prot);
+
+	WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot)
+{
+	pmd_t pmd = pfn_pmd(pfn, prot);
+
+	WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
+}
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot)
+{
+	pud_t pud = pfn_pud(pfn, prot);
+
+	WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
+}
+#else
+static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+#endif
+#else
+static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+#endif
+#else
+static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot) { }
+#endif
+
+static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+{
+	pte_t pte = pfn_pte(pfn, prot);
+
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY))
+		return;
+
+	WARN_ON(!pte_soft_dirty(pte_mksoft_dirty(pte)));
+	WARN_ON(pte_soft_dirty(pte_clear_soft_dirty(pte)));
+}
+
+static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+{
+	pte_t pte = pfn_pte(pfn, prot);
+
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY))
+		return;
+
+	WARN_ON(!pte_swp_soft_dirty(pte_swp_mksoft_dirty(pte)));
+	WARN_ON(pte_swp_soft_dirty(pte_swp_clear_soft_dirty(pte)));
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+{
+	pmd_t pmd = pfn_pmd(pfn, prot);
+
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY))
+		return;
+
+	WARN_ON(!pmd_soft_dirty(pmd_mksoft_dirty(pmd)));
+	WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
+}
+
+static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+{
+	pmd_t pmd = pfn_pmd(pfn, prot);
+
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY) ||
+		!IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
+		return;
+
+	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
+	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
+}
+#else
+static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
+{
+}
+#endif
+
+static void __init pte_swap_tests(unsigned long pfn, pgprot_t prot)
+{
+	swp_entry_t swp;
+	pte_t pte;
+
+	pte = pfn_pte(pfn, prot);
+	swp = __pte_to_swp_entry(pte);
+	WARN_ON(!pte_same(pte, __swp_entry_to_pte(swp)));
+}
+
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
+{
+	swp_entry_t swp;
+	pmd_t pmd;
+
+	pmd = pfn_pmd(pfn, prot);
+	swp = __pmd_to_swp_entry(pmd);
+	WARN_ON(!pmd_same(pmd, __swp_entry_to_pmd(swp)));
+}
+#else
+static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot) { }
+#endif
+
+static void __init swap_migration_tests(void)
+{
+	struct page *page;
+	swp_entry_t swp;
+
+	if (!IS_ENABLED(CONFIG_MIGRATION))
+		return;
+	/*
+	 * swap_migration_tests() requires a dedicated page as it needs to
+	 * be locked before creating a migration entry from it. Locking the
+	 * page that actually maps kernel text ('start_kernel') can be real
+	 * problematic. Lets allocate a dedicated page explicitly for this
+	 * purpose that will be freed subsequently.
+	 */
+	page = alloc_page(GFP_KERNEL);
+	if (!page) {
+		pr_err("page allocation failed\n");
+		return;
+	}
+
+	/*
+	 * make_migration_entry() expects given page to be
+	 * locked, otherwise it stumbles upon a BUG_ON().
+	 */
+	__SetPageLocked(page);
+	swp = make_migration_entry(page, 1);
+	WARN_ON(!is_migration_entry(swp));
+	WARN_ON(!is_write_migration_entry(swp));
+
+	make_migration_entry_read(&swp);
+	WARN_ON(!is_migration_entry(swp));
+	WARN_ON(is_write_migration_entry(swp));
+
+	swp = make_migration_entry(page, 0);
+	WARN_ON(!is_migration_entry(swp));
+	WARN_ON(is_write_migration_entry(swp));
+	__ClearPageLocked(page);
+	__free_page(page);
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
+{
+	struct page *page;
+	pte_t pte;
+
+	/*
+	 * Accessing the page associated with the pfn is safe here,
+	 * as it was previously derived from a real kernel symbol.
+	 */
+	page = pfn_to_page(pfn);
+	pte = mk_huge_pte(page, prot);
+
+	WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
+	WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte))));
+	WARN_ON(huge_pte_write(huge_pte_wrprotect(huge_pte_mkwrite(pte))));
+
+#ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
+	pte = pfn_pte(pfn, prot);
+
+	WARN_ON(!pte_huge(pte_mkhuge(pte)));
+#endif
+}
+#else
+static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot) { }
+#endif
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
+{
+	pmd_t pmd;
+
+	/*
+	 * pmd_trans_huge() and pmd_present() must return positive
+	 * after MMU invalidation with pmd_mknotpresent().
+	 */
+	pmd = pfn_pmd(pfn, prot);
+	WARN_ON(!pmd_trans_huge(pmd_mkhuge(pmd)));
+
+#ifndef __HAVE_ARCH_PMDP_INVALIDATE
+	WARN_ON(!pmd_trans_huge(pmd_mknotpresent(pmd_mkhuge(pmd))));
+	WARN_ON(!pmd_present(pmd_mknotpresent(pmd_mkhuge(pmd))));
+#endif
+}
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot)
+{
+	pud_t pud;
+
+	/*
+	 * pud_trans_huge() and pud_present() must return positive
+	 * after MMU invalidation with pud_mknotpresent().
+	 */
+	pud = pfn_pud(pfn, prot);
+	WARN_ON(!pud_trans_huge(pud_mkhuge(pud)));
+
+	/*
+	 * pud_mknotpresent() has been dropped for now. Enable back
+	 * these tests when it comes back with a modified pud_present().
+	 *
+	 * WARN_ON(!pud_trans_huge(pud_mknotpresent(pud_mkhuge(pud))));
+	 * WARN_ON(!pud_present(pud_mknotpresent(pud_mkhuge(pud))));
+	 */
+}
+#else
+static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot) { }
+#endif
+#else
+static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot) { }
+static void __init pud_thp_tests(unsigned long pfn, pgprot_t prot) { }
+#endif
+
 static unsigned long __init get_random_vaddr(void)
 {
 	unsigned long random_vaddr, random_pages, total_user_pages;
@@ -310,7 +571,7 @@ void __init debug_vm_pgtable(void)
 	pmd_t *pmdp, *saved_pmdp, pmd;
 	pte_t *ptep;
 	pgtable_t saved_ptep;
-	pgprot_t prot;
+	pgprot_t prot, protnone;
 	phys_addr_t paddr;
 	unsigned long vaddr, pte_aligned, pmd_aligned;
 	unsigned long pud_aligned, p4d_aligned, pgd_aligned;
@@ -325,6 +586,12 @@ void __init debug_vm_pgtable(void)
 		return;
 	}
 
+	/*
+	 * __P000 (or even __S000) will help create page table entries with
+	 * PROT_NONE permission as required for pxx_protnone_tests().
+	 */
+	protnone = __P000;
+
 	/*
 	 * PFN for mapping at PTE level is determined from a standard kernel
 	 * text symbol. But pfns for higher page table levels are derived by
@@ -380,6 +647,28 @@ void __init debug_vm_pgtable(void)
 	p4d_populate_tests(mm, p4dp, saved_pudp);
 	pgd_populate_tests(mm, pgdp, saved_p4dp);
 
+	pte_special_tests(pte_aligned, prot);
+	pte_protnone_tests(pte_aligned, protnone);
+	pmd_protnone_tests(pmd_aligned, protnone);
+
+	pte_devmap_tests(pte_aligned, prot);
+	pmd_devmap_tests(pmd_aligned, prot);
+	pud_devmap_tests(pud_aligned, prot);
+
+	pte_soft_dirty_tests(pte_aligned, prot);
+	pmd_soft_dirty_tests(pmd_aligned, prot);
+	pte_swap_soft_dirty_tests(pte_aligned, prot);
+	pmd_swap_soft_dirty_tests(pmd_aligned, prot);
+
+	pte_swap_tests(pte_aligned, prot);
+	pmd_swap_tests(pmd_aligned, prot);
+
+	swap_migration_tests();
+	hugetlb_basic_tests(pte_aligned, prot);
+
+	pmd_thp_tests(pmd_aligned, prot);
+	pud_thp_tests(pud_aligned, prot);
+
 	p4d_free(mm, saved_p4dp);
 	pud_free(mm, saved_pudp);
 	pmd_free(mm, saved_pmdp);
-- 
2.20.1

