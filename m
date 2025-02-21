Return-Path: <linux-arch+bounces-10302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0902A3F74E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 15:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0712B424889
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9EC1D5CC5;
	Fri, 21 Feb 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="do8QZX4a"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D92205AB0
	for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148271; cv=none; b=k8XSyA6gZWDRLkXT44mJcSvnuw4DW+hIfQNGDzfU+jNGC1pdMFZyuyHIb+z25+Hzbj9+XJXu17f59knWzeKIAt4ABIGX5wFh4rbeLdsDPu7EhrH4pqXhGJjo1E715GUFmoXAaMWmhtROJottWPgKd+wEgCCezR6IxBi47uHUaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148271; c=relaxed/simple;
	bh=/xLkrXDpzQq1b8J0UHBB30Kf8cnbpZ4ByhF1IA7iL3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb6gaBuwvTZOA2zCHo+pZaxZbtLz/fzWkFx1cbDDwjq39iFQK2ShJNsHDO0uopCiSPV+RAKDDRDlHB8XlP4Dg0vX0JzBDWzLaH2B3HvUeFUo9WF5at1ocOeAyZOCw1/0wkI5MtxEQRHGEd7Jvs3Hs5ZzrCPFY/CwNYRGBtTb7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=do8QZX4a; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=mYKH1mAPTthfanIoFuvHz+2lH48g9yQX03xmi/lqQUA=; b=do8QZX4arlEWPAGiob61UoBcdk
	T6Nd16b+mpzNz3tL2cU8kKEmo2Ke5Rpa3VvT6MnbtrO9RfCzvvKLN4dpjpL3kp9HXKwKi7q4Ygz4E
	ceyHI5rm025PE7K2mtW0C2B5Jzjgpe/mClhqw1fH/fwKh5KbYt+gCe/WQPRPNczxnvEKtrnz5G+g1
	PYuaUFIJG3Dm1bwT4XNzlods6TQPnYc6zxZGdnsaPjLDUYEPb8XkySD6/3YNG/vddHKLGYwA9VhGj
	CTxsuSdTXxmXfoW6szE8kkQtTwREATtplq2ajNmhdlqoYIVm+pHwWUCEFLjJBqAc9a/hy35b0H+di
	MmKZKFPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlU3W-0000000DzWY-2lbR;
	Fri, 21 Feb 2025 14:31:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH 3/4] mm: Add folio_mk_pmd()
Date: Fri, 21 Feb 2025 14:31:00 +0000
Message-ID: <20250221143104.3334444-4-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221143104.3334444-1-willy@infradead.org>
References: <20250221143104.3334444-1-willy@infradead.org>
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
index 21b47402b3dc..22efc6c44539 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1237,8 +1237,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
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
index b1e311bae6b7..5c883c619fa4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1936,7 +1936,24 @@ static inline pte_t folio_mk_pte(struct folio *folio, pgprot_t pgprot)
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
 
 /**
  * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3d3ebdc002d5..95ed5dd9622b 100644
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
@@ -1311,8 +1311,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 	pmd_t entry;
 	if (!pmd_none(*pmd))
 		return;
-	entry = mk_pmd(&zero_folio->page, vma->vm_page_prot);
-	entry = pmd_mkhuge(entry);
+	entry = folio_mk_pmd(zero_folio, vma->vm_page_prot);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
@@ -2570,12 +2569,12 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
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
 
@@ -4306,7 +4305,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 	entry = pmd_to_swp_entry(*pvmw->pmd);
 	folio_get(folio);
-	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
+	pmde = folio_mk_pmd(folio, READ_ONCE(vma->vm_page_prot));
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
 	if (is_writable_migration_entry(entry))
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5f0be134141e..4f85597a7f64 100644
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
index ea5a58db76dd..6d1a1185c34c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5078,7 +5078,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 
 	flush_icache_pages(vma, page, HPAGE_PMD_NR);
 
-	entry = mk_huge_pmd(page, vma->vm_page_prot);
+	entry = folio_mk_pmd(folio, vma->vm_page_prot);
 	if (write)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
-- 
2.47.2


