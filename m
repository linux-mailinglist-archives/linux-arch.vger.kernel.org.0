Return-Path: <linux-arch+bounces-11235-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC80A794F3
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2C73A83EB
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E271C84C0;
	Wed,  2 Apr 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KLXmh9XL"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8071A38E1
	for <linux-arch@vger.kernel.org>; Wed,  2 Apr 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617849; cv=none; b=AZheGznJFXKwiclge1BTeS2LCrx/CQ17AgdlNuJxuAdyRv8ta2S7VljEoqMqY5tbEb7RWb54QA9Ia/Ts5P2Wq3WuiIafmIzpK8BMUrJkl6skuAxntcN1ylHOn+c2+AvnvMdxL46MI9BVAK3ofke/lMO3mxrybjDM4S4NWU0n+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617849; c=relaxed/simple;
	bh=wSuSCveIchsQxCorYfnfV70Or1PgfjwAaMoEJML0DhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEFfce2a0GLraH7uqrdjYBfFvaMBerD0ShyMC92AeLFDrh4qMZ9A0FpoiiiKSTUABroiD+U8LNhlYMACi+G7tAfdb36LkyxzAevn8sZRi/oUOY17vvecycyAxILv9UNW3Ycv/SJwEIg2dgjD9VvzJiAbJjBmNFPThOE3PIiH0Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KLXmh9XL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YUZaMbW4I7OXHp12rW2s26jw5pZRBiflAQO7xH+epdQ=; b=KLXmh9XLowoSpHwZ9zM4XJydIz
	TqWk5i77jSlCFxWbMVP41th0m7mltbbAIhyscjEcZ2rqKCIEuoMRoD8m+tkh+GNG9gDl8rWlkOZkP
	fJKzIOFKoDy/lc/b2zPnyKxlgkgynJROldGu/GnUwxMQC1WFVqZaJlZssQ/5IhiixPJWsYVjXY6Lh
	iyp0jtqktkLNuxr/NRsw1lQda/qG6kWQ495VsU3nd+AJoAD5ypvjFgJm47HQeJFCQCKwnv0D/c3Mx
	DMSfkFCF4wKXPSKifK0Q0DRnMg3cMaeKkoAqLdt4f6wurG5VoJc5sbOu5ynI+5BSeypDTnkuW9GD+
	Mt8qEIRg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02eF-0000000A0ii-2im4;
	Wed, 02 Apr 2025 18:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 08/11] hugetlb: Simplify make_huge_pte()
Date: Wed,  2 Apr 2025 19:17:02 +0100
Message-ID: <20250402181709.2386022-9-willy@infradead.org>
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

mk_huge_pte() is a bad API.  Despite its name, it creates a normal
PTE which is later transformed into a huge PTE by arch_make_huge_pte().
So replace the page argument with a folio argument and call folio_mk_pte()
instead.  Then, because we now know this is a regular PTE rather than a
huge one, use pte_mkdirty() instead of huge_pte_mkdirty() (and similar
functions).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/hugetlb.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6fccfe6d046c..df185f10bc9e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5441,18 +5441,16 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.pagesize = hugetlb_vm_op_pagesize,
 };
 
-static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
+static pte_t make_huge_pte(struct vm_area_struct *vma, struct folio *folio,
 		bool try_mkwrite)
 {
-	pte_t entry;
+	pte_t entry = folio_mk_pte(folio, vma->vm_page_prot);
 	unsigned int shift = huge_page_shift(hstate_vma(vma));
 
 	if (try_mkwrite && (vma->vm_flags & VM_WRITE)) {
-		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
-					 vma->vm_page_prot)));
+		entry = pte_mkwrite_novma(pte_mkdirty(entry));
 	} else {
-		entry = huge_pte_wrprotect(mk_huge_pte(page,
-					   vma->vm_page_prot));
+		entry = pte_wrprotect(entry);
 	}
 	entry = pte_mkyoung(entry);
 	entry = arch_make_huge_pte(entry, shift, vma->vm_flags);
@@ -5507,7 +5505,7 @@ static void
 hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
 		      struct folio *new_folio, pte_t old, unsigned long sz)
 {
-	pte_t newpte = make_huge_pte(vma, &new_folio->page, true);
+	pte_t newpte = make_huge_pte(vma, new_folio, true);
 
 	__folio_mark_uptodate(new_folio);
 	hugetlb_add_new_anon_rmap(new_folio, vma, addr);
@@ -6257,7 +6255,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	spin_lock(vmf->ptl);
 	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
 	if (likely(vmf->pte && pte_same(huge_ptep_get(mm, vmf->address, vmf->pte), pte))) {
-		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
+		pte_t newpte = make_huge_pte(vma, new_folio, !unshare);
 
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, vmf->address, vmf->pte);
@@ -6537,7 +6535,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		hugetlb_add_new_anon_rmap(folio, vma, vmf->address);
 	else
 		hugetlb_add_file_rmap(folio);
-	new_pte = make_huge_pte(vma, &folio->page, vma->vm_flags & VM_SHARED);
+	new_pte = make_huge_pte(vma, folio, vma->vm_flags & VM_SHARED);
 	/*
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
@@ -7022,7 +7020,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
 	 * with wp flag set, don't set pte write bit.
 	 */
-	_dst_pte = make_huge_pte(dst_vma, &folio->page,
+	_dst_pte = make_huge_pte(dst_vma, folio,
 				 !wp_enabled && !(is_continue && !vm_shared));
 	/*
 	 * Always mark UFFDIO_COPY page dirty; note that this may not be
-- 
2.47.2


