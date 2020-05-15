Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0381D5A7F
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 22:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgEOUBo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 16:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgEOUBo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 16:01:44 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AED420727;
        Fri, 15 May 2020 20:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589572903;
        bh=hrb0NjlAGs243jz20skr4JyPcHlHUFR+OdxSllgZnYM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VnImy+mbJ7aCP3ALfPDqJ1xZma70fF5k5/smHK7ELq1um0M3nRPni8+qpkYQkoiB8
         6EnEoZa2bty30wH7st+xf1j918NgjMe7piFPa6D+RZFvXRGM70OdLTsm8yebYnCPrw
         qhX76ha6l4t06mZAxe3rljHXmXNEAhvuAKP5TZ0w=
Date:   Fri, 15 May 2020 13:01:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/7] mm/vmalloc: Track which page-table levels were
 modified
Message-Id: <20200515130142.4ca90ee590e9d8ab88497676@linux-foundation.org>
In-Reply-To: <20200515140023.25469-3-joro@8bytes.org>
References: <20200515140023.25469-1-joro@8bytes.org>
        <20200515140023.25469-3-joro@8bytes.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 15 May 2020 16:00:18 +0200 Joerg Roedel <joro@8bytes.org> wrote:

> Track at which levels in the page-table entries were modified by
> vmap/vunmap. After the page-table has been modified, use that
> information do decide whether the new arch_sync_kernel_mappings()
> needs to be called.

Lots of collisions here with Christoph's "decruft the vmalloc API" series
(http://lkml.kernel.org/r/20200414131348.444715-1-hch@lst.de).

I attempted to fix things up.

unmap_kernel_range_noflush() needed to be redone.

map_kernel_range_noflush() might need the arch_sync_kernel_mappings() call?


From: Joerg Roedel <jroedel@suse.de>
Subject: mm/vmalloc: Track which page-table levels were modified

Track at which levels in the page-table entries were modified by
vmap/vunmap.  After the page-table has been modified, use that information
do decide whether the new arch_sync_kernel_mappings() needs to be called.

Link: http://lkml.kernel.org/r/20200515140023.25469-3-joro@8bytes.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/vmalloc.h |   16 ++++++
 mm/vmalloc.c            |   91 +++++++++++++++++++++++++++-----------
 2 files changed, 81 insertions(+), 26 deletions(-)

--- a/include/linux/vmalloc.h~mm-vmalloc-track-which-page-table-levels-were-modified
+++ a/include/linux/vmalloc.h
@@ -134,6 +134,22 @@ void vmalloc_sync_mappings(void);
 void vmalloc_sync_unmappings(void);
 
 /*
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
+/*
  *	Lowlevel-APIs (not for driver use!)
  */
 
--- a/mm/vmalloc.c~mm-vmalloc-track-which-page-table-levels-were-modified
+++ a/mm/vmalloc.c
@@ -69,7 +69,8 @@ static void free_work(struct work_struct
 
 /*** Page table manipulation functions ***/
 
-static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end)
+static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+			     pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
 
@@ -78,59 +79,81 @@ static void vunmap_pte_range(pmd_t *pmd,
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
 
 /**
  * unmap_kernel_range_noflush - unmap kernel VM area
- * @addr: start of the VM area to unmap
+ * @start: start of the VM area to unmap
  * @size: size of the VM area to unmap
  *
  * Unmap PFN_UP(@size) pages at @addr.  The VM area @addr and @size specify
@@ -141,24 +164,33 @@ static void vunmap_p4d_range(pgd_t *pgd,
  * for calling flush_cache_vunmap() on to-be-mapped areas before calling this
  * function and flush_tlb_kernel_range() after.
  */
-void unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
+void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
 {
-	unsigned long end = addr + size;
+	unsigned long end = start + size;
 	unsigned long next;
 	pgd_t *pgd;
+	unsigned long addr = start;
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
 
@@ -167,7 +199,7 @@ static int vmap_pte_range(pmd_t *pmd, un
 	 * callers keep track of where we're up to.
 	 */
 
-	pte = pte_alloc_kernel(pmd, addr);
+	pte = pte_alloc_kernel_track(pmd, addr, mask);
 	if (!pte)
 		return -ENOMEM;
 	do {
@@ -180,55 +212,59 @@ static int vmap_pte_range(pmd_t *pmd, un
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
@@ -260,12 +296,15 @@ int map_kernel_range_noflush(unsigned lo
 	pgd_t *pgd;
 	int err = 0;
 	int nr = 0;
+	pgtbl_mod_mask mask = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = vmap_p4d_range(pgd, addr, next, prot, pages, &nr);
+		if (pgd_bad(*pgd))
+			mask |= PGTBL_PGD_MODIFIED;
+		err = vmap_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
 			return err;
 	} while (pgd++, addr = next, addr != end);
_

