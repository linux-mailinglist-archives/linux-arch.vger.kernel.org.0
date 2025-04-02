Return-Path: <linux-arch+bounces-11229-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F48DA794F0
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863AB7A1838
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693411A38E1;
	Wed,  2 Apr 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QK/QZFk6"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70719D8BE
	for <linux-arch@vger.kernel.org>; Wed,  2 Apr 2025 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617837; cv=none; b=MZIpQO9igbE/r2/u7fKQazna4Bx+HKX/CLt/2+z6BpRvIMn+7QQVXtj/X/B8xWgQ51U0Ajj9V/p8jtPvUpwjN0BY+VQKBd0HeHl6fx1fOFSXhxrANTcmAb/6E7sAqNTVDD7hFH1WxUT29AZ9KDqrHUru7tzwsRRNG5iwx2i7Qls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617837; c=relaxed/simple;
	bh=GDdB3Lcf/y1CNlAJSILPH3hK8z6SqjfKoTH8D6/tki0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoOSKi2/ZdkQEhj46Pt7ljemMi5ISUI5Jbq1rylKA7xGoOCkuiXKFLxUZakWkZmPzdI+QeUYSOZnJgo/1u4RVue+A1Cc195mZco77/3YOCw5Vs8CQFBw3Sp67Z/gyGYr2rxT89GSVfyYj1VScEcNy8zPQ67kmwXgDaBdbmSOu1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QK/QZFk6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=TC2yKBXkWKOZQx81epWNSMRYD1pOXcRjkX0E8HuUhGM=; b=QK/QZFk6HxEr6OedWH+SCq4BWC
	bgbgLXIDTvHDcE4mAWxdsZWn78kp4SHX0M3bD7+s8eDNqnKMKO5c8uyStYSObxMBhON2fJz4VKIq+
	fcALIGc2g6KEl/5xhUphfJ31WvZHmEjMUq5tc63OgbSUma9f6rR1pmL2QsgjQO6aV+6omgzNyWHAL
	2aDQBoyu5ArtRlU7mUOijUNjVnLVWAK6jgCyPR/NoLA/e0g/ivZ/8FF1hcEoFShxCV6wZZZYRukBK
	dsCBmO1e3Tu73j6nVneBVMn3Sr/WepqmCco9qUpJX23E3Qn0VNg76LrvLW+Bq/snm2SQyAHzYIpd/
	H8MHXklA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02eF-0000000A0im-3XGI;
	Wed, 02 Apr 2025 18:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 10/11] mm: Add folio_mk_pmd()
Date: Wed,  2 Apr 2025 19:17:04 +0100
Message-ID: <20250402181709.2386022-11-willy@infradead.org>
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

Removes five conversions from folio to page.  Also removes both callers
of mk_pmd() that aren't part of mk_huge_pmd(), getting us a step closer to
removing the confusion between mk_pmd(), mk_huge_pmd() and pmd_mkhuge().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/dax.c           |  3 +--
 include/linux/mm.h | 17 +++++++++++++++++
 mm/huge_memory.c   | 11 +++++------
 mm/khugepaged.c    |  2 +-
 mm/memory.c        |  2 +-
 5 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index af5045b0f476..564e44a31e40 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1421,8 +1421,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		mm_inc_nr_ptes(vma->vm_mm);
 	}
-	pmd_entry = mk_pmd(&zero_folio->page, vmf->vma->vm_page_prot);
-	pmd_entry = pmd_mkhuge(pmd_entry);
+	pmd_entry = folio_mk_pmd(zero_folio, vmf->vma->vm_page_prot);
 	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
 	spin_unlock(ptl);
 	trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d657815305f7..d910b6ffcbed 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2007,7 +2007,24 @@ static inline pte_t folio_mk_pte(struct folio *folio, pgprot_t pgprot)
 {
 	return pfn_pte(folio_pfn(folio), pgprot);
 }
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/**
+ * folio_mk_pmd - Create a PMD for this folio
+ * @folio: The folio to create a PMD for
+ * @pgprot: The page protection bits to use
+ *
+ * Create a page table entry for the first page of this folio.
+ * This is suitable for passing to set_pmd_at().
+ *
+ * Return: A page table entry suitable for mapping this folio.
+ */
+static inline pmd_t folio_mk_pmd(struct folio *folio, pgprot_t pgprot)
+{
+	return pmd_mkhuge(pfn_pmd(folio_pfn(folio), pgprot));
+}
 #endif
+#endif /* CONFIG_MMU */
 
 static inline bool folio_has_pincount(const struct folio *folio)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a47682d1ab7..28c87e0e036f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1203,7 +1203,7 @@ static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
 {
 	pmd_t entry;
 
-	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
+	entry = folio_mk_pmd(folio, vma->vm_page_prot);
 	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
 	folio_add_lru_vma(folio, vma);
@@ -1309,8 +1309,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 		struct folio *zero_folio)
 {
 	pmd_t entry;
-	entry = mk_pmd(&zero_folio->page, vma->vm_page_prot);
-	entry = pmd_mkhuge(entry);
+	entry = folio_mk_pmd(zero_folio, vma->vm_page_prot);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
@@ -2653,12 +2652,12 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		folio_move_anon_rmap(src_folio, dst_vma);
 		src_folio->index = linear_page_index(dst_vma, dst_addr);
 
-		_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
+		_dst_pmd = folio_mk_pmd(src_folio, dst_vma->vm_page_prot);
 		/* Follow mremap() behavior and treat the entry dirty after the move */
 		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
 	} else {
 		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
-		_dst_pmd = mk_huge_pmd(src_page, dst_vma->vm_page_prot);
+		_dst_pmd = folio_mk_pmd(src_folio, dst_vma->vm_page_prot);
 	}
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
@@ -4675,7 +4674,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 	entry = pmd_to_swp_entry(*pvmw->pmd);
 	folio_get(folio);
-	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
+	pmde = folio_mk_pmd(folio, READ_ONCE(vma->vm_page_prot));
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
 	if (is_writable_migration_entry(entry))
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cc945c6ab3bd..b8838ba8207a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1239,7 +1239,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	__folio_mark_uptodate(folio);
 	pgtable = pmd_pgtable(_pmd);
 
-	_pmd = mk_huge_pmd(&folio->page, vma->vm_page_prot);
+	_pmd = folio_mk_pmd(folio, vma->vm_page_prot);
 	_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
 
 	spin_lock(pmd_ptl);
diff --git a/mm/memory.c b/mm/memory.c
index fc4d8152a2e4..e6e7abb83c0b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5188,7 +5188,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 
 	flush_icache_pages(vma, page, HPAGE_PMD_NR);
 
-	entry = mk_huge_pmd(page, vma->vm_page_prot);
+	entry = folio_mk_pmd(folio, vma->vm_page_prot);
 	if (write)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
-- 
2.47.2


