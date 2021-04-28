Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09C736DD5A
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbhD1QrB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 12:47:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30179 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241162AbhD1QrA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 12:47:00 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FVkzT4m2Dz9tcc;
        Wed, 28 Apr 2021 18:46:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4U65XGU88BaS; Wed, 28 Apr 2021 18:46:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FVkzT3pV5z9tcV;
        Wed, 28 Apr 2021 18:46:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6985C8B837;
        Wed, 28 Apr 2021 18:46:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1Av2VT33WRBs; Wed, 28 Apr 2021 18:46:13 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E9A9D8B831;
        Wed, 28 Apr 2021 18:46:12 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CA0F76428C; Wed, 28 Apr 2021 16:46:12 +0000 (UTC)
Message-Id: <e111d0d90231ae63e4b89da8efa87cde31daeeee.1619628001.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1619628001.git.christophe.leroy@csgroup.eu>
References: <cover.1619628001.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 2/4] mm/hugetlb: Change parameters of
 arch_make_huge_pte()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 28 Apr 2021 16:46:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

At the time being, arch_make_huge_pte() has the following prototype:

	pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
				 struct page *page, int writable);

vma is used to get the pages shift or size.
vma is also used on Sparc to get vm_flags.
page is not used.
writable is not used.

In order to use this function without a vma, and replace vma by shift
and flags. Also remove the used parameters.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/arm64/include/asm/hugetlb.h                 | 3 +--
 arch/arm64/mm/hugetlbpage.c                      | 5 ++---
 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h | 5 ++---
 arch/sparc/include/asm/pgtable_64.h              | 3 +--
 arch/sparc/mm/hugetlbpage.c                      | 6 ++----
 include/linux/hugetlb.h                          | 4 ++--
 mm/hugetlb.c                                     | 6 ++++--
 mm/migrate.c                                     | 4 +++-
 8 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 5abf91e3494c..1242f71937f8 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -23,8 +23,7 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 }
 #define arch_clear_hugepage_flags arch_clear_hugepage_flags
 
-extern pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
-				struct page *page, int writable);
+pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
 #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
 extern void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 58987a98e179..23505fc35324 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -339,10 +339,9 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	return NULL;
 }
 
-pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
-			 struct page *page, int writable)
+pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 {
-	size_t pagesize = huge_page_size(hstate_vma(vma));
+	size_t pagesize = 1UL << shift;
 
 	if (pagesize == CONT_PTE_SIZE) {
 		entry = pte_mkcont(entry);
diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
index 39be9aea86db..64b6c608eca4 100644
--- a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
@@ -66,10 +66,9 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 }
 
 #ifdef CONFIG_PPC_4K_PAGES
-static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
-				       struct page *page, int writable)
+static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 {
-	size_t size = huge_page_size(hstate_vma(vma));
+	size_t size = 1UL << shift;
 
 	if (size == SZ_16K)
 		return __pte(pte_val(entry) & ~_PAGE_HUGE);
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 550d3904de65..2cd80a0a9795 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -377,8 +377,7 @@ static inline pgprot_t pgprot_noncached(pgprot_t prot)
 #define pgprot_noncached pgprot_noncached
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-extern pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
-				struct page *page, int writable);
+pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
 static inline unsigned long __pte_default_huge_mask(void)
 {
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 04d8790f6c32..0f49fada2093 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -177,10 +177,8 @@ static pte_t hugepage_shift_to_tte(pte_t entry, unsigned int shift)
 		return sun4u_hugepage_shift_to_tte(entry, shift);
 }
 
-pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
-			 struct page *page, int writeable)
+pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 {
-	unsigned int shift = huge_page_shift(hstate_vma(vma));
 	pte_t pte;
 
 	pte = hugepage_shift_to_tte(entry, shift);
@@ -188,7 +186,7 @@ pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 #ifdef CONFIG_SPARC64
 	/* If this vma has ADI enabled on it, turn on TTE.mcd
 	 */
-	if (vma->vm_flags & VM_SPARC_ADI)
+	if (flags & VM_SPARC_ADI)
 		return pte_mkmcd(pte);
 	else
 		return pte_mknotmcd(pte);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b92f25ccef58..24f47981c166 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -710,8 +710,8 @@ static inline void arch_clear_hugepage_flags(struct page *page) { }
 #endif
 
 #ifndef arch_make_huge_pte
-static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
-				       struct page *page, int writable)
+static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
+				       vm_flags_t flags)
 {
 	return entry;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3db405dea3dc..396285b16dd8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3856,6 +3856,7 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
 				int writable)
 {
 	pte_t entry;
+	unsigned int shift = huge_page_shift(hstate_vma(vma));
 
 	if (writable) {
 		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
@@ -3866,7 +3867,7 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
 	}
 	entry = pte_mkyoung(entry);
 	entry = pte_mkhuge(entry);
-	entry = arch_make_huge_pte(entry, vma, page, writable);
+	entry = arch_make_huge_pte(entry, shift, vma->vm_flags);
 
 	return entry;
 }
@@ -5250,10 +5251,11 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		}
 		if (!huge_pte_none(pte)) {
 			pte_t old_pte;
+			unsigned int shift = huge_page_shift(hstate_vma(vma));
 
 			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
 			pte = pte_mkhuge(huge_pte_modify(old_pte, newprot));
-			pte = arch_make_huge_pte(pte, vma, NULL, 0);
+			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
 		}
diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..49ee64cd2ff3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -226,8 +226,10 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (PageHuge(new)) {
+			unsigned int shift = huge_page_shift(hstate_vma(vma));
+
 			pte = pte_mkhuge(pte);
-			pte = arch_make_huge_pte(pte, vma, new, 0);
+			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 			if (PageAnon(new))
 				hugepage_add_anon_rmap(new, vma, pvmw.address);
-- 
2.25.0

