Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B9376D14D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjHBPOa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbjHBPOT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640A82D77;
        Wed,  2 Aug 2023 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wBzUOAudwvibgR05xcILaDI1lHt6uM+gLVFXP8bsuc0=; b=Ha9s/sKNhdfeybdIYofHo+zqU+
        ot8ZgcRg0OXHpTfLXK7qTZ+NFCab/7cCF/cAPpEv7EwGg0NVhtKlv8fxjnbEEnrV9RHLiHvYRTLVx
        sKmKQRJX6gkR36XaRIHbh6MMjX8PV5CP8uci9/fOC0QF8+vUc8adPFYjIwD4ccpBFnRTaxDRL0lY2
        25G6tjp5LzEW8RBGuX20uqsI2hpOBlD0vRBc4n70B5Iqq/RJnjpiIstoVFEDu5/MUkD0ghh+fDtGi
        KdyynwzxrxNTdwR79IRw0WeUOQ0RWGwgXQrNVErQWXyR3bFnYu0BtiALQ5p2J4wGQ6keaOBySlAsV
        2x50BKdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY9-00FfjV-D6; Wed, 02 Aug 2023 15:14:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: [PATCH v6 14/38] loongarch: Implement the new page table range API
Date:   Wed,  2 Aug 2023 16:13:42 +0100
Message-Id: <20230802151406.3735276-15-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230802151406.3735276-1-willy@infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add update_mmu_cache_range() and change _PFN_SHIFT to PFN_PTE_SHIFT.
It would probably be more efficient to implement __update_tlb() by
flushing the entire folio instead of calling __update_tlb() N times,
but I'll leave that for someone who understands the architecture better.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
---
 arch/loongarch/include/asm/cacheflush.h   |  1 +
 arch/loongarch/include/asm/pgtable-bits.h |  4 +--
 arch/loongarch/include/asm/pgtable.h      | 33 ++++++++++++-----------
 arch/loongarch/mm/pgtable.c               |  2 +-
 arch/loongarch/mm/tlb.c                   |  2 +-
 5 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
index 0681788eb474..88a44da50a3b 100644
--- a/arch/loongarch/include/asm/cacheflush.h
+++ b/arch/loongarch/include/asm/cacheflush.h
@@ -47,6 +47,7 @@ void local_flush_icache_range(unsigned long start, unsigned long end);
 #define flush_cache_vmap(start, end)			do { } while (0)
 #define flush_cache_vunmap(start, end)			do { } while (0)
 #define flush_icache_page(vma, page)			do { } while (0)
+#define flush_icache_pages(vma, page)			do { } while (0)
 #define flush_icache_user_page(vma, page, addr, len)	do { } while (0)
 #define flush_dcache_page(page)				do { } while (0)
 #define flush_dcache_mmap_lock(mapping)			do { } while (0)
diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index de46a6b1e9f1..35348d4c4209 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -50,12 +50,12 @@
 #define _PAGE_NO_EXEC		(_ULCAST_(1) << _PAGE_NO_EXEC_SHIFT)
 #define _PAGE_RPLV		(_ULCAST_(1) << _PAGE_RPLV_SHIFT)
 #define _CACHE_MASK		(_ULCAST_(3) << _CACHE_SHIFT)
-#define _PFN_SHIFT		(PAGE_SHIFT - 12 + _PAGE_PFN_SHIFT)
+#define PFN_PTE_SHIFT		(PAGE_SHIFT - 12 + _PAGE_PFN_SHIFT)
 
 #define _PAGE_USER	(PLV_USER << _PAGE_PLV_SHIFT)
 #define _PAGE_KERN	(PLV_KERN << _PAGE_PLV_SHIFT)
 
-#define _PFN_MASK (~((_ULCAST_(1) << (_PFN_SHIFT)) - 1) & \
+#define _PFN_MASK (~((_ULCAST_(1) << (PFN_PTE_SHIFT)) - 1) & \
 		  ((_ULCAST_(1) << (_PAGE_PFN_END_SHIFT)) - 1))
 
 /*
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 38afeb7dd58b..e7cf25e452c0 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -237,9 +237,9 @@ extern pmd_t mk_pmd(struct page *page, pgprot_t prot);
 extern void set_pmd_at(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp, pmd_t pmd);
 
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
-#define pte_pfn(x)		((unsigned long)(((x).pte & _PFN_MASK) >> _PFN_SHIFT))
-#define pfn_pte(pfn, prot)	__pte(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
-#define pfn_pmd(pfn, prot)	__pmd(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
+#define pte_pfn(x)		((unsigned long)(((x).pte & _PFN_MASK) >> PFN_PTE_SHIFT))
+#define pfn_pte(pfn, prot)	__pte(((pfn) << PFN_PTE_SHIFT) | pgprot_val(prot))
+#define pfn_pmd(pfn, prot)	__pmd(((pfn) << PFN_PTE_SHIFT) | pgprot_val(prot))
 
 /*
  * Initialize a new pgd / pud / pmd table with invalid pointers.
@@ -334,19 +334,13 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	}
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pteval)
-{
-	set_pte(ptep, pteval);
-}
-
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	/* Preserve global status for the pair */
 	if (pte_val(*ptep_buddy(ptep)) & _PAGE_GLOBAL)
-		set_pte_at(mm, addr, ptep, __pte(_PAGE_GLOBAL));
+		set_pte(ptep, __pte(_PAGE_GLOBAL));
 	else
-		set_pte_at(mm, addr, ptep, __pte(0));
+		set_pte(ptep, __pte(0));
 }
 
 #define PGD_T_LOG2	(__builtin_ffs(sizeof(pgd_t)) - 1)
@@ -445,11 +439,20 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 extern void __update_tlb(struct vm_area_struct *vma,
 			unsigned long address, pte_t *ptep);
 
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-			unsigned long address, pte_t *ptep)
+static inline void update_mmu_cache_range(struct vm_fault *vmf,
+		struct vm_area_struct *vma, unsigned long address,
+		pte_t *ptep, unsigned int nr)
 {
-	__update_tlb(vma, address, ptep);
+	for (;;) {
+		__update_tlb(vma, address, ptep);
+		if (--nr == 0)
+			break;
+		address += PAGE_SIZE;
+		ptep++;
+	}
 }
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
 #define __HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb	update_mmu_cache
@@ -462,7 +465,7 @@ static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
-	return (pmd_val(pmd) & _PFN_MASK) >> _PFN_SHIFT;
+	return (pmd_val(pmd) & _PFN_MASK) >> PFN_PTE_SHIFT;
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 36a6dc0148ae..1260cf30e3ee 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -107,7 +107,7 @@ pmd_t mk_pmd(struct page *page, pgprot_t prot)
 {
 	pmd_t pmd;
 
-	pmd_val(pmd) = (page_to_pfn(page) << _PFN_SHIFT) | pgprot_val(prot);
+	pmd_val(pmd) = (page_to_pfn(page) << PFN_PTE_SHIFT) | pgprot_val(prot);
 
 	return pmd;
 }
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index 00bb563e3c89..eb8572e201ea 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -252,7 +252,7 @@ static void output_pgtable_bits_defines(void)
 	pr_define("_PAGE_WRITE_SHIFT %d\n", _PAGE_WRITE_SHIFT);
 	pr_define("_PAGE_NO_READ_SHIFT %d\n", _PAGE_NO_READ_SHIFT);
 	pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
-	pr_define("_PFN_SHIFT %d\n", _PFN_SHIFT);
+	pr_define("PFN_PTE_SHIFT %d\n", PFN_PTE_SHIFT);
 	pr_debug("\n");
 }
 
-- 
2.40.1

