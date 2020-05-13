Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6691D192A
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 17:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbgEMPVp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732196AbgEMPVo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 11:21:44 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E63DC061A0E;
        Wed, 13 May 2020 08:21:44 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C40DF642; Wed, 13 May 2020 17:21:40 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, joro@8bytes.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 1/7] mm: Add functions to track page directory modifications
Date:   Wed, 13 May 2020 17:21:31 +0200
Message-Id: <20200513152137.32426-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513152137.32426-1-joro@8bytes.org>
References: <20200513152137.32426-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Add page-table allocation functions which will keep track of changed
directory entries. They are needed for new PGD, P4D, PUD, and PMD
entries and will be used in vmalloc and ioremap code to decide whether
any changes in the kernel mappings need to be synchronized between
page-tables in the system.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/asm-generic/5level-fixup.h |  5 ++--
 include/asm-generic/pgtable.h      | 23 +++++++++++++++
 include/linux/mm.h                 | 46 ++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index 4c74b1c1d13b..58046ddc08d0 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -17,8 +17,9 @@
 	((unlikely(pgd_none(*(p4d))) && __pud_alloc(mm, p4d, address)) ? \
 		NULL : pud_offset(p4d, address))
 
-#define p4d_alloc(mm, pgd, address)	(pgd)
-#define p4d_offset(pgd, start)		(pgd)
+#define p4d_alloc(mm, pgd, address)		(pgd)
+#define p4d_alloc_track(mm, pgd, address, mask)	(pgd)
+#define p4d_offset(pgd, start)			(pgd)
 
 #ifndef __ASSEMBLY__
 static inline int p4d_none(p4d_t p4d)
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 329b8c8ca703..bf1418ae91a2 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1209,6 +1209,29 @@ static inline bool arch_has_pfn_modify_check(void)
 # define PAGE_KERNEL_EXEC PAGE_KERNEL
 #endif
 
+/*
+ * Page Table Modification bits for pgtbl_mod_mask.
+ *
+ * These are used by the p?d_alloc_track*() set of functions an in the generic
+ * vmalloc/ioremap code to track at which page-table levels entries have been
+ * modified. Based on that the code can better decide when vmalloc and ioremap
+ * mapping changes need to be synchronized to other page-tables in the system.
+ */
+#define		__PGTBL_PGD_MODIFIED	0
+#define		__PGTBL_P4D_MODIFIED	1
+#define		__PGTBL_PUD_MODIFIED	2
+#define		__PGTBL_PMD_MODIFIED	3
+#define		__PGTBL_PTE_MODIFIED	4
+
+#define		PGTBL_PGD_MODIFIED	BIT(__PGTBL_PGD_MODIFIED)
+#define		PGTBL_P4D_MODIFIED	BIT(__PGTBL_P4D_MODIFIED)
+#define		PGTBL_PUD_MODIFIED	BIT(__PGTBL_PUD_MODIFIED)
+#define		PGTBL_PMD_MODIFIED	BIT(__PGTBL_PMD_MODIFIED)
+#define		PGTBL_PTE_MODIFIED	BIT(__PGTBL_PTE_MODIFIED)
+
+/* Page-Table Modification Mask */
+typedef unsigned int pgtbl_mod_mask;
+
 #endif /* !__ASSEMBLY__ */
 
 #ifndef io_remap_pfn_range
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..022fe682af9e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2078,13 +2078,54 @@ static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
 	return (unlikely(p4d_none(*p4d)) && __pud_alloc(mm, p4d, address)) ?
 		NULL : pud_offset(p4d, address);
 }
+
+static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
+				     unsigned long address,
+				     pgtbl_mod_mask *mod_mask)
+
+{
+	if (unlikely(pgd_none(*pgd))) {
+		if (__p4d_alloc(mm, pgd, address))
+			return NULL;
+		*mod_mask |= PGTBL_PGD_MODIFIED;
+	}
+
+	return p4d_offset(pgd, address);
+}
+
 #endif /* !__ARCH_HAS_5LEVEL_HACK */
 
+static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
+				     unsigned long address,
+				     pgtbl_mod_mask *mod_mask)
+{
+	if (unlikely(p4d_none(*p4d))) {
+		if (__pud_alloc(mm, p4d, address))
+			return NULL;
+		*mod_mask |= PGTBL_P4D_MODIFIED;
+	}
+
+	return pud_offset(p4d, address);
+}
+
 static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
 	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
 		NULL: pmd_offset(pud, address);
 }
+
+static inline pmd_t *pmd_alloc_track(struct mm_struct *mm, pud_t *pud,
+				     unsigned long address,
+				     pgtbl_mod_mask *mod_mask)
+{
+	if (unlikely(pud_none(*pud))) {
+		if (__pmd_alloc(mm, pud, address))
+			return NULL;
+		*mod_mask |= PGTBL_PUD_MODIFIED;
+	}
+
+	return pmd_offset(pud, address);
+}
 #endif /* CONFIG_MMU */
 
 #if USE_SPLIT_PTE_PTLOCKS
@@ -2200,6 +2241,11 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
 		NULL: pte_offset_kernel(pmd, address))
 
+#define pte_alloc_kernel_track(pmd, address, mask)			\
+	((unlikely(pmd_none(*(pmd))) &&					\
+	  (__pte_alloc_kernel(pmd) || ({*(mask)|=PGTBL_PMD_MODIFIED;0;})))?\
+		NULL: pte_offset_kernel(pmd, address))
+
 #if USE_SPLIT_PMD_PTLOCKS
 
 static struct page *pmd_to_page(pmd_t *pmd)
-- 
2.17.1

