Return-Path: <linux-arch+bounces-11231-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60AA794EF
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8BA3AE774
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA791D86E8;
	Wed,  2 Apr 2025 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gV1P+IhD"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD571C84AF
	for <linux-arch@vger.kernel.org>; Wed,  2 Apr 2025 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617838; cv=none; b=kkZ4m7sm63gIl3ZzyNawuP+s+6FRUOeaj4xqcqBIZZ5gMJxPNXr4SLj2P+GYvLZWgUR5K4M8fpXG0YhtXZg8wt0vadguHBxf9ORBD2qw/JR+TRKlxCqZFSLCDR0LycbuciBBsoHeWO/1qxiYIehrBDSQWrP9MWk0Y8+eqvUUmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617838; c=relaxed/simple;
	bh=8fISVc44GhvQRFNUdarY1lMJHlAGl4AoxaVy0GP2dZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrfVqHAfT+MfHTeE1UFOcA2ktC3fKlqlCP2IbGecJqE+wE8gaMEvmu51in3h+wvecYYb7KSI/Eo9TQ/5bigjz6Fcyer2D6xAfk3Lg6lHUkw+nABS4BHKHhQpa38xy2c6KeSQ0/XLuIuk3cq52HXqK3cubVueEtcxE3MmNKsPnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gV1P+IhD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fS2PMscCelr2p4rUSdgC+67eZkZlHh1lrlPj3wtKD4Y=; b=gV1P+IhD2igi0rHiwQrOnFJAlD
	HQI7TMULlDe+cOeNwXlzjBIrYxSgl8Ahf4iVCacLjQtPUC+laBFiP99Uy1cGixasDU4yNFKwza+wh
	1laD6OxYm2S0o6s3QTlUpKjyNptwqnWzbM3MeSzbyq9apucpNAjnVRb9lxDgncSpOe7eUvHMyeGGn
	xAcMPm1wYCIFDXtQQ863eOwMnw9xXzYw8kyrxaOcIYf3cIodu+8Tj8MtVnqF5H9VdXBhIwiloIf/k
	FNUEv2aywTqovWVVs+A92m/pTwBUe6nI5vGXc47EkjGJi0EnhodNE/T6qUZ2BMSOCDlkibczJkVBN
	+OFiKRnw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02eF-0000000A0iw-3wUe;
	Wed, 02 Apr 2025 18:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 11/11] arch: Remove mk_pmd()
Date: Wed,  2 Apr 2025 19:17:05 +0100
Message-ID: <20250402181709.2386022-12-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402181709.2386022-1-willy@infradead.org>
References: <20250402181709.2386022-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are now no callers of mk_huge_pmd() and mk_pmd().  Remove them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/arc/include/asm/hugepage.h              |  2 --
 arch/arc/include/asm/pgtable-levels.h        |  1 -
 arch/arm/include/asm/pgtable-3level.h        |  1 -
 arch/arm64/include/asm/pgtable.h             |  1 -
 arch/loongarch/include/asm/pgtable.h         |  1 -
 arch/loongarch/mm/pgtable.c                  |  9 ---------
 arch/mips/include/asm/pgtable.h              |  3 ---
 arch/mips/mm/pgtable-32.c                    | 10 ----------
 arch/mips/mm/pgtable-64.c                    |  9 ---------
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 -
 arch/powerpc/mm/book3s64/pgtable.c           |  5 -----
 arch/riscv/include/asm/pgtable-64.h          |  2 --
 arch/s390/include/asm/pgtable.h              |  1 -
 arch/sparc/include/asm/pgtable_64.h          |  1 -
 arch/x86/include/asm/pgtable.h               |  2 --
 include/linux/huge_mm.h                      |  2 --
 16 files changed, 51 deletions(-)

diff --git a/arch/arc/include/asm/hugepage.h b/arch/arc/include/asm/hugepage.h
index 8a2441670a8f..7765dc105d54 100644
--- a/arch/arc/include/asm/hugepage.h
+++ b/arch/arc/include/asm/hugepage.h
@@ -40,8 +40,6 @@ static inline pmd_t pte_pmd(pte_t pte)
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 
-#define mk_pmd(page, prot)	pte_pmd(mk_pte(page, prot))
-
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) & _PAGE_HW_SZ)
 
 #define pfn_pmd(pfn, prot)	(__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot)))
diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
index 55dbd2719e35..d1ce4b0f1071 100644
--- a/arch/arc/include/asm/pgtable-levels.h
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -142,7 +142,6 @@
 
 #define pmd_pfn(pmd)		((pmd_val(pmd) & PMD_MASK) >> PAGE_SHIFT)
 #define pfn_pmd(pfn,prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
-#define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
 #endif
 
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index fa5939eb9864..7b71a3d414b7 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -209,7 +209,6 @@ PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 
 #define pmd_pfn(pmd)		(((pmd_val(pmd) & PMD_MASK) & PHYS_MASK) >> PAGE_SHIFT)
 #define pfn_pmd(pfn,prot)	(__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
-#define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
 /* No hardware dirty/accessed bits -- generic_pmdp_establish() fits */
 #define pmdp_establish generic_pmdp_establish
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 53832ec0561f..379fcc6a1295 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -609,7 +609,6 @@ static inline pmd_t pmd_mkspecial(pmd_t pmd)
 #define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)
 #define pmd_pfn(pmd)		((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT)
 #define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
-#define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
 #define pud_young(pud)		pte_young(pud_pte(pud))
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 9ba3a4ebcd98..a3f17914dbab 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -255,7 +255,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 #define pmd_page_vaddr(pmd)	pmd_val(pmd)
 
-extern pmd_t mk_pmd(struct page *page, pgprot_t prot);
 extern void set_pmd_at(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp, pmd_t pmd);
 
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 22a94bb3e6e8..352d9b2e02ab 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -135,15 +135,6 @@ void kernel_pte_init(void *addr)
 	} while (p != end);
 }
 
-pmd_t mk_pmd(struct page *page, pgprot_t prot)
-{
-	pmd_t pmd;
-
-	pmd_val(pmd) = (page_to_pfn(page) << PFN_PTE_SHIFT) | pgprot_val(prot);
-
-	return pmd;
-}
-
 void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		pmd_t *pmdp, pmd_t pmd)
 {
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index d69cfa5a8ac6..4852b005a72d 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -713,9 +713,6 @@ static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
 
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
-/* Extern to avoid header file madness */
-extern pmd_t mk_pmd(struct page *page, pgprot_t prot);
-
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
 	pmd_val(pmd) = (pmd_val(pmd) & (_PAGE_CHG_MASK | _PAGE_HUGE)) |
diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index 84dd5136d53a..e2cf2166d5cb 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -31,16 +31,6 @@ void pgd_init(void *addr)
 }
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
-pmd_t mk_pmd(struct page *page, pgprot_t prot)
-{
-	pmd_t pmd;
-
-	pmd_val(pmd) = (page_to_pfn(page) << PFN_PTE_SHIFT) | pgprot_val(prot);
-
-	return pmd;
-}
-
-
 void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		pmd_t *pmdp, pmd_t pmd)
 {
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index 1e544827dea9..b24f865de357 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -90,15 +90,6 @@ void pud_init(void *addr)
 #endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-pmd_t mk_pmd(struct page *page, pgprot_t prot)
-{
-	pmd_t pmd;
-
-	pmd_val(pmd) = (page_to_pfn(page) << PFN_PTE_SHIFT) | pgprot_val(prot);
-
-	return pmd;
-}
-
 void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		pmd_t *pmdp, pmd_t pmd)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 6d98e6f08d4d..6ed93e290c2f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1096,7 +1096,6 @@ static inline bool pmd_access_permitted(pmd_t pmd, bool write)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
 extern pud_t pfn_pud(unsigned long pfn, pgprot_t pgprot);
-extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
 extern pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot);
 extern pud_t pud_modify(pud_t pud, pgprot_t newprot);
 extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index c0c45d033cba..2c88532ed7fb 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -270,11 +270,6 @@ pud_t pfn_pud(unsigned long pfn, pgprot_t pgprot)
 	return __pud_mkhuge(pud_set_protbits(__pud(pudv), pgprot));
 }
 
-pmd_t mk_pmd(struct page *page, pgprot_t pgprot)
-{
-	return pfn_pmd(page_to_pfn(page), pgprot);
-}
-
 pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
 	unsigned long pmdv;
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 0897dd99ab8d..188fadc1c21f 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -262,8 +262,6 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 	return __page_val_to_pfn(pmd_val(pmd));
 }
 
-#define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
-
 #define pmd_ERROR(e) \
 	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
 
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 3ef5d2198480..1c661ac62ce8 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1869,7 +1869,6 @@ static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 #define pmdp_collapse_flush pmdp_collapse_flush
 
 #define pfn_pmd(pfn, pgprot)	mk_pmd_phys(((pfn) << PAGE_SHIFT), (pgprot))
-#define mk_pmd(page, pgprot)	pfn_pmd(page_to_pfn(page), (pgprot))
 
 static inline int pmd_trans_huge(pmd_t pmd)
 {
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index d9c903576084..4af03e3c161b 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -233,7 +233,6 @@ static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 
 	return __pmd(pte_val(pte));
 }
-#define mk_pmd(page, pgprot)	pfn_pmd(page_to_pfn(page), (pgprot))
 #endif
 
 /* This one can be done with two shifts.  */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2ce98b547a25..3f59d7a16010 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1347,8 +1347,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 
 #define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (0)
 
-#define mk_pmd(page, pgprot)   pfn_pmd(page_to_pfn(page), (pgprot))
-
 #define  __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 extern int pmdp_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp,
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e893d546a49f..f190998b2ebd 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -495,8 +495,6 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
 void mm_put_huge_zero_folio(struct mm_struct *mm);
 
-#define mk_huge_pmd(page, prot) pmd_mkhuge(mk_pmd(page, prot))
-
 static inline bool thp_migration_supported(void)
 {
 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
-- 
2.47.2


