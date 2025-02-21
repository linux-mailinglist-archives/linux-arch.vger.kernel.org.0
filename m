Return-Path: <linux-arch+bounces-10299-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FB1A3F74D
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 15:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A69117D198
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045A20E00E;
	Fri, 21 Feb 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZnB1aSDQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D219D087
	for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148270; cv=none; b=qy1+9D8hSq+342hjOsJDlxU/ggsfGEGJ8TPU2m1mhFeSfHfF7YDjNbMT7O9YXKOebt9H5BcPdazF6v4GvDO7N8CJ91dOwiic3Prhmi4+jfHrZqoyVvRp0UFa92sAWxhC8LQPchR0KwmMm5eEMQMSWZ7EWsljhTKtmVSwoWnLHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148270; c=relaxed/simple;
	bh=XS9Ot52Wb0ekDXlveOsLsujpNIeYuXsxix4C3jnbvlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/cMxE6PYWIZlfr8jtQ5basuRdl8ZFydFvsW9a5qzFYlykrdkSg8hMqxkSH9HeIdF3It2M7X7CaQApIw+efJ5W5l/V3oTJaq0gPXcGU4zFIizgRgKXao2OroYNuGkiJP1USz/FCRk/j2OCTzYxaQHzZXddVKFYfrc4Z1qW69IZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZnB1aSDQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XKMSbfhgd9tyFb22pi+cXpiXpj+uKvA7iB0i1tzsnfw=; b=ZnB1aSDQ7lz9CwkFOiiDt/UFUh
	R0pN0AEcQbpca6QBXLKdttBqBpfCfyajGkqEuSClG51pfLqWl1mPDDkPytPV7eyU/TCZFdKO97Lc6
	Ia3INzlHnxepnsXLkACLa13yE/7rwD8MbUezUpM4+HpAMY+mq/TN9pF0UPRNDM51VZ9jtMYjFn44U
	ciG5G+70OMqSc1WgYOLhvgCdXEMk2Nj7IZwK4D6LiIz5tURNX7eTgsR5zjhEsjwUA26OBJKePLj93
	u84M0JUdUneIcVK6wwDtJTUUIvIomybhaIejLQNKpJc9rbdhpTm/g7Qlovtzdw1rZxNREtmfv8FCr
	IFRXJryg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlU3W-0000000DzWJ-1dVm;
	Fri, 21 Feb 2025 14:31:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH 1/4] hugetlb: Simplify make_huge_pte()
Date: Fri, 21 Feb 2025 14:30:58 +0000
Message-ID: <20250221143104.3334444-2-willy@infradead.org>
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
index 163190e89ea1..1ea42dd01012 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5162,18 +5162,16 @@ const struct vm_operations_struct hugetlb_vm_ops = {
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
@@ -5228,7 +5226,7 @@ static void
 hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
 		      struct folio *new_folio, pte_t old, unsigned long sz)
 {
-	pte_t newpte = make_huge_pte(vma, &new_folio->page, true);
+	pte_t newpte = make_huge_pte(vma, new_folio, true);
 
 	__folio_mark_uptodate(new_folio);
 	hugetlb_add_new_anon_rmap(new_folio, vma, addr);
@@ -5978,7 +5976,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	spin_lock(vmf->ptl);
 	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
 	if (likely(vmf->pte && pte_same(huge_ptep_get(mm, vmf->address, vmf->pte), pte))) {
-		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
+		pte_t newpte = make_huge_pte(vma, new_folio, !unshare);
 
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, vmf->address, vmf->pte);
@@ -6258,7 +6256,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		hugetlb_add_new_anon_rmap(folio, vma, vmf->address);
 	else
 		hugetlb_add_file_rmap(folio);
-	new_pte = make_huge_pte(vma, &folio->page, vma->vm_flags & VM_SHARED);
+	new_pte = make_huge_pte(vma, folio, vma->vm_flags & VM_SHARED);
 	/*
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
@@ -6743,7 +6741,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
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


