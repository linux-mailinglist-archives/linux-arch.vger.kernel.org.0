Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535831D4FC7
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgEOOAo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726295AbgEOOA2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 10:00:28 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04374C05BD0A;
        Fri, 15 May 2020 07:00:27 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9DEA23E2; Fri, 15 May 2020 16:00:25 +0200 (CEST)
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
Subject: [PATCH v3 3/7] mm/ioremap: Track which page-table levels were modified
Date:   Fri, 15 May 2020 16:00:19 +0200
Message-Id: <20200515140023.25469-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515140023.25469-1-joro@8bytes.org>
References: <20200515140023.25469-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Track at which levels in the page-table entries were modified by
ioremap_page_range(). After the page-table has been modified, use that
information do decide whether the new arch_sync_kernel_mappings()
needs to be called. The iounmap path re-uses vunmap(), which has
already been taken care of.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 lib/ioremap.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/lib/ioremap.c b/lib/ioremap.c
index 3f0e18543de8..ad485f08173b 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -61,13 +61,14 @@ static inline int ioremap_pmd_enabled(void) { return 0; }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
+		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+		pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
 	u64 pfn;
 
 	pfn = phys_addr >> PAGE_SHIFT;
-	pte = pte_alloc_kernel(pmd, addr);
+	pte = pte_alloc_kernel_track(pmd, addr, mask);
 	if (!pte)
 		return -ENOMEM;
 	do {
@@ -75,6 +76,7 @@ static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
 		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+	*mask |= PGTBL_PTE_MODIFIED;
 	return 0;
 }
 
@@ -101,21 +103,24 @@ static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
 }
 
 static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
+		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
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
 
-		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr, prot))
+		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr, prot)) {
+			*mask |= PGTBL_PMD_MODIFIED;
 			continue;
+		}
 
-		if (ioremap_pte_range(pmd, addr, next, phys_addr, prot))
+		if (ioremap_pte_range(pmd, addr, next, phys_addr, prot, mask))
 			return -ENOMEM;
 	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
@@ -144,21 +149,24 @@ static int ioremap_try_huge_pud(pud_t *pud, unsigned long addr,
 }
 
 static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
+		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
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
 
-		if (ioremap_try_huge_pud(pud, addr, next, phys_addr, prot))
+		if (ioremap_try_huge_pud(pud, addr, next, phys_addr, prot)) {
+			*mask |= PGTBL_PUD_MODIFIED;
 			continue;
+		}
 
-		if (ioremap_pmd_range(pud, addr, next, phys_addr, prot))
+		if (ioremap_pmd_range(pud, addr, next, phys_addr, prot, mask))
 			return -ENOMEM;
 	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
@@ -187,21 +195,24 @@ static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
 }
 
 static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
+		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
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
 
-		if (ioremap_try_huge_p4d(p4d, addr, next, phys_addr, prot))
+		if (ioremap_try_huge_p4d(p4d, addr, next, phys_addr, prot)) {
+			*mask |= PGTBL_P4D_MODIFIED;
 			continue;
+		}
 
-		if (ioremap_pud_range(p4d, addr, next, phys_addr, prot))
+		if (ioremap_pud_range(p4d, addr, next, phys_addr, prot, mask))
 			return -ENOMEM;
 	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
@@ -214,6 +225,7 @@ int ioremap_page_range(unsigned long addr,
 	unsigned long start;
 	unsigned long next;
 	int err;
+	pgtbl_mod_mask mask = 0;
 
 	might_sleep();
 	BUG_ON(addr >= end);
@@ -222,13 +234,17 @@ int ioremap_page_range(unsigned long addr,
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = ioremap_p4d_range(pgd, addr, next, phys_addr, prot);
+		err = ioremap_p4d_range(pgd, addr, next, phys_addr, prot,
+					&mask);
 		if (err)
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
 
 	flush_cache_vmap(start, end);
 
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, end);
+
 	return err;
 }
 
-- 
2.17.1

