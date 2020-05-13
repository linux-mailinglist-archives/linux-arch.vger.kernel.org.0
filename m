Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23A01D192C
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbgEMPVp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbgEMPVo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 11:21:44 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05818C061A0C;
        Wed, 13 May 2020 08:21:44 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EF577695; Wed, 13 May 2020 17:21:40 +0200 (CEST)
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
Subject: [PATCH v2 2/7] mm/vmalloc: Track which page-table levels were modified
Date:   Wed, 13 May 2020 17:21:32 +0200
Message-Id: <20200513152137.32426-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513152137.32426-1-joro@8bytes.org>
References: <20200513152137.32426-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Track at which levels in the page-table entries were modified by
vmap/vunmap. After the page-table has been modified, use that
information do decide whether the new arch_sync_kernel_mappings()
needs to be called.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/vmalloc.h | 16 ++++++++
 mm/vmalloc.c            | 88 ++++++++++++++++++++++++++++++-----------
 2 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index a95d3cc74d79..c80bdb8a6b55 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -144,6 +144,22 @@ extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 void vmalloc_sync_mappings(void);
 void vmalloc_sync_unmappings(void);
 
+/*
+ * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
+ * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
+ * needs to be called.
+ */
+#ifndef ARCH_PAGE_TABLE_SYNC_MASK
+#define ARCH_PAGE_TABLE_SYNC_MASK 0
+#endif
+
+/*
+ * There is no default implementation for arch_sync_kernel_mappings(). It is
+ * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
+ * is 0.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
+
 /*
  *	Lowlevel-APIs (not for driver use!)
  */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9a8227afa073..184f5a556cf7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -69,7 +69,8 @@ static void free_work(struct work_struct *w)
 
 /*** Page table manipulation functions ***/
 
-static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end)
+static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+			     pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
 
@@ -78,73 +79,104 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end)
 		pte_t ptent = ptep_get_and_clear(&init_mm, addr, pte);
 		WARN_ON(!pte_none(ptent) && !pte_present(ptent));
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+	*mask |= PGTBL_PTE_MODIFIED;
 }
 
-static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end)
+static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
+			     pgtbl_mod_mask *mask)
 {
 	pmd_t *pmd;
 	unsigned long next;
+	int cleared;
 
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (pmd_clear_huge(pmd))
+
+		cleared = pmd_clear_huge(pmd);
+		if (cleared || pmd_bad(*pmd))
+			*mask |= PGTBL_PMD_MODIFIED;
+
+		if (cleared)
 			continue;
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		vunmap_pte_range(pmd, addr, next);
+		vunmap_pte_range(pmd, addr, next, mask);
 	} while (pmd++, addr = next, addr != end);
 }
 
-static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end)
+static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
+			     pgtbl_mod_mask *mask)
 {
 	pud_t *pud;
 	unsigned long next;
+	int cleared;
 
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_clear_huge(pud))
+
+		cleared = pud_clear_huge(pud);
+		if (cleared || pud_bad(*pud))
+			*mask |= PGTBL_PUD_MODIFIED;
+
+		if (cleared)
 			continue;
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		vunmap_pmd_range(pud, addr, next);
+		vunmap_pmd_range(pud, addr, next, mask);
 	} while (pud++, addr = next, addr != end);
 }
 
-static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end)
+static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
+			     pgtbl_mod_mask *mask)
 {
 	p4d_t *p4d;
 	unsigned long next;
+	int cleared;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
 		next = p4d_addr_end(addr, end);
-		if (p4d_clear_huge(p4d))
+
+		cleared = p4d_clear_huge(p4d);
+		if (cleared || p4d_bad(*p4d))
+			*mask |= PGTBL_P4D_MODIFIED;
+
+		if (cleared)
 			continue;
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		vunmap_pud_range(p4d, addr, next);
+		vunmap_pud_range(p4d, addr, next, mask);
 	} while (p4d++, addr = next, addr != end);
 }
 
-static void vunmap_page_range(unsigned long addr, unsigned long end)
+static void vunmap_page_range(unsigned long start, unsigned long end)
 {
 	pgd_t *pgd;
+	unsigned long addr = start;
 	unsigned long next;
+	pgtbl_mod_mask mask = 0;
 
 	BUG_ON(addr >= end);
+	start = addr;
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
+		if (pgd_bad(*pgd))
+			mask |= PGTBL_PGD_MODIFIED;
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		vunmap_p4d_range(pgd, addr, next);
+		vunmap_p4d_range(pgd, addr, next, &mask);
 	} while (pgd++, addr = next, addr != end);
+
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, end);
 }
 
 static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr)
+		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
+		pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
 
@@ -153,7 +185,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 	 * callers keep track of where we're up to.
 	 */
 
-	pte = pte_alloc_kernel(pmd, addr);
+	pte = pte_alloc_kernel_track(pmd, addr, mask);
 	if (!pte)
 		return -ENOMEM;
 	do {
@@ -166,55 +198,59 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
 		(*nr)++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+	*mask |= PGTBL_PTE_MODIFIED;
 	return 0;
 }
 
 static int vmap_pmd_range(pud_t *pud, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr)
+		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
+		pgtbl_mod_mask *mask)
 {
 	pmd_t *pmd;
 	unsigned long next;
 
-	pmd = pmd_alloc(&init_mm, pud, addr);
+	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
 	if (!pmd)
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (vmap_pte_range(pmd, addr, next, prot, pages, nr))
+		if (vmap_pte_range(pmd, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
 static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr)
+		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
+		pgtbl_mod_mask *mask)
 {
 	pud_t *pud;
 	unsigned long next;
 
-	pud = pud_alloc(&init_mm, p4d, addr);
+	pud = pud_alloc_track(&init_mm, p4d, addr, mask);
 	if (!pud)
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (vmap_pmd_range(pud, addr, next, prot, pages, nr))
+		if (vmap_pmd_range(pud, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
 static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr)
+		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
+		pgtbl_mod_mask *mask)
 {
 	p4d_t *p4d;
 	unsigned long next;
 
-	p4d = p4d_alloc(&init_mm, pgd, addr);
+	p4d = p4d_alloc_track(&init_mm, pgd, addr, mask);
 	if (!p4d)
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pud_range(p4d, addr, next, prot, pages, nr))
+		if (vmap_pud_range(p4d, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
@@ -234,16 +270,20 @@ static int vmap_page_range_noflush(unsigned long start, unsigned long end,
 	unsigned long addr = start;
 	int err = 0;
 	int nr = 0;
+	pgtbl_mod_mask mask = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = vmap_p4d_range(pgd, addr, next, prot, pages, &nr);
+		err = vmap_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
 			return err;
 	} while (pgd++, addr = next, addr != end);
 
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, end);
+
 	return nr;
 }
 
-- 
2.17.1

