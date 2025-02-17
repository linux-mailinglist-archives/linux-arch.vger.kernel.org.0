Return-Path: <linux-arch+bounces-10160-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77BDA38C10
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 20:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0741887D61
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 19:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2201C236A8B;
	Mon, 17 Feb 2025 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="StCMnrt6"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B72376E6;
	Mon, 17 Feb 2025 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819324; cv=none; b=J6G8aN+uVSbpOG6A1joqA6UTT3m6+2/6V58mutKBVTRuVsnCT+ihTW4KOGxUIKcPLY3j8+1Jn1/wBdKhA5/AU//2wU6I6ye9kymjqWVa4vG+if8YlmgJBBpF8vhNfbsURG0vucVGKAy75ielAWmkbN0V5WOQSuBUb8a5bQlbdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819324; c=relaxed/simple;
	bh=Pog03rmX9bMIOhA22fmIVxnX76K9JHTko7Y7/e2Puno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iePCSYL/mDUgyVX6L9uxaul52VgnvX7MO0sfrI2EMKcIyMKTHpQ1RoLaQhCaWceVZa+xuGiEtyxE81ZFE/FcDKQHamUtSf6zRgGtlihrXqSRURms9zuiSE+lkGhmocPnph/W4bcf3Dab14LmoG+q7MKMyVf4x30g0/F2M+u9WLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=StCMnrt6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OumVES33M5Q6KKLjsks+HzN6mA4d4PgrDi4hyJXhstQ=; b=StCMnrt6vOSAYjFMqqQquk050o
	hn1znvvg9gYx0AwLbFVElug1d1bW6SEWC5H6dYMk8J4C7mg0KKFEgL/HFVJvoA99AQ/0JSkSUErr2
	TtcqV5Ev5F8iW4alNv2SNQPl6S01DglwDe5jooRarQpgbJ/l/ZVAqSfnmiymy+RfLGQx4SSUgETnn
	TzhasKCnq5rTeSL7GLZAICQkeu663hIrRckIbtwLo9icbmZqKxQSO+kiWs4EGAl7Z15/lwEfa3F4Y
	L5EvDNIT5UdATOp5oZB+3Y/6WYY/Q5HETXGUent6CVnm3bZ/1K5o8X6f6yqK63/mHxlPMryWUmXdG
	kBG41KUw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tv-00000001pBk-19SY;
	Mon, 17 Feb 2025 19:08:39 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 7/7] mm: Add folio_mk_pte()
Date: Mon, 17 Feb 2025 19:08:34 +0000
Message-ID: <20250217190836.435039-8-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217190836.435039-1-willy@infradead.org>
References: <20250217190836.435039-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes a cast from folio to page in four callers of mk_pte().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 15 +++++++++++++++
 mm/memory.c        |  6 +++---
 mm/userfaultfd.c   |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 62dccde9c561..b1e311bae6b7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1921,6 +1921,21 @@ static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 {
 	return pfn_pte(page_to_pfn(page), pgprot);
 }
+
+/**
+ * folio_mk_pte - Create a PTE for this folio
+ * @folio: The folio to create a PTE for
+ * @pgprot: The page protection bits to use
+ *
+ * Create a page table entry for the first page of this folio.
+ * This is suitable for passing to set_ptes().
+ *
+ * Return: A page table entry suitable for mapping this folio.
+ */
+static inline pte_t folio_mk_pte(struct folio *folio, pgprot_t pgprot)
+{
+	return pfn_pte(folio_pfn(folio), pgprot);
+}
 #endif
 
 /**
diff --git a/mm/memory.c b/mm/memory.c
index 4330560eee55..72411a6d696f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -936,7 +936,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	rss[MM_ANONPAGES]++;
 
 	/* All done, just insert the new page copy in the child */
-	pte = mk_pte(&new_folio->page, dst_vma->vm_page_prot);
+	pte = folio_mk_pte(new_folio, dst_vma->vm_page_prot);
 	pte = maybe_mkwrite(pte_mkdirty(pte), dst_vma);
 	if (userfaultfd_pte_wp(dst_vma, ptep_get(src_pte)))
 		/* Uffd-wp needs to be delivered to dest pte as well */
@@ -3480,7 +3480,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			inc_mm_counter(mm, MM_ANONPAGES);
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
-		entry = mk_pte(&new_folio->page, vma->vm_page_prot);
+		entry = folio_mk_pte(new_folio, vma->vm_page_prot);
 		entry = pte_sw_mkyoung(entry);
 		if (unlikely(unshare)) {
 			if (pte_soft_dirty(vmf->orig_pte))
@@ -4892,7 +4892,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	 */
 	__folio_mark_uptodate(folio);
 
-	entry = mk_pte(&folio->page, vma->vm_page_prot);
+	entry = folio_mk_pte(folio, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry), vma);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index af3dfc3633db..507a9e3caec7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1066,7 +1066,7 @@ static int move_present_pte(struct mm_struct *mm,
 	folio_move_anon_rmap(src_folio, dst_vma);
 	src_folio->index = linear_page_index(dst_vma, dst_addr);
 
-	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
+	orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
 	/* Follow mremap() behavior and treat the entry dirty after the move */
 	orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
 
-- 
2.47.2


