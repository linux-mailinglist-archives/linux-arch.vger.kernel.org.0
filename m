Return-Path: <linux-arch+bounces-11230-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B25A794F2
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92371892DA4
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D3B1AAE2E;
	Wed,  2 Apr 2025 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="awmYQ8yE"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA51D79A0
	for <linux-arch@vger.kernel.org>; Wed,  2 Apr 2025 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617838; cv=none; b=nWZsY2Pcbl3wR8iP00RePaEcAmUDYOpofI1ZhPZG9lTAv16E6lOFKlbsRQ9yQLoVNOGk5pwaxKIn0n5hi8ift59eXYM0tD+OsFIRfDU1rJ+qSGVxxY3BLgFRysH2tCa9eMWIOflFNXax8JJr5+SLOieBGgOPNwin9w0E8UamKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617838; c=relaxed/simple;
	bh=KDzj05wvq00EInNuTTP10ot6S3YWAx6aOUSk1sCD7RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPMVZy/uq6yilBe9dqWiIBx5/prVhshf+NIAK4oy7byeUYSgQs5zvR6K7P4/uKnIkBZYbfxq9w8EoQst+nEj451bbXsqhqAaXC/41mOCD63fS8TVvN44kUB4Hoz1sCaY6rkV216dsUnqffHVtsnMja1J6GP9dnD8RfFxroSFV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=awmYQ8yE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qTiP2D3OrGMsSaRwxahGkUod//8qVelF/nv7EzuQ3uQ=; b=awmYQ8yEmw1Xbw+DXL1UpX4cf4
	7g2FBet0xAZTYuMgfxIQPDUKNDEnYG1OojGXMU8dzq8v0Dm3Xg3bIZxZ8jUMHjYuLKpJaXjCPWDNj
	+P50tTxGfQW8TlF4INZKosrHKKdTKnkDF68CNIfsChqxVOgk92zVkt8mqJGO8NGK/rUmK8+TUCIhb
	E75NdS4YZUF7WIpVdxcrszpVRkKB+DuwbeD1pFngn1Pvl8oYcCadm7nkua9ReUvkYbuR3kNolwx1W
	dj13ssBLhJrGdpSmvHqvjztT1dip9P2Iv/lTxyo8Evgs/vo05MpzggO07vRbTvtVJBZIVCnwoKpwm
	g8QuymMA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02eF-0000000A0ig-2MTV;
	Wed, 02 Apr 2025 18:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 07/11] mm: Add folio_mk_pte()
Date: Wed,  2 Apr 2025 19:17:01 +0100
Message-ID: <20250402181709.2386022-8-willy@infradead.org>
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

Removes a cast from folio to page in four callers of mk_pte().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 15 +++++++++++++++
 mm/memory.c        |  6 +++---
 mm/userfaultfd.c   |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5dc097b5d646..d657815305f7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1992,6 +1992,21 @@ static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
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
 
 static inline bool folio_has_pincount(const struct folio *folio)
diff --git a/mm/memory.c b/mm/memory.c
index 68bcf639a78c..fc4d8152a2e4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -929,7 +929,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	rss[MM_ANONPAGES]++;
 
 	/* All done, just insert the new page copy in the child */
-	pte = mk_pte(&new_folio->page, dst_vma->vm_page_prot);
+	pte = folio_mk_pte(new_folio, dst_vma->vm_page_prot);
 	pte = maybe_mkwrite(pte_mkdirty(pte), dst_vma);
 	if (userfaultfd_pte_wp(dst_vma, ptep_get(src_pte)))
 		/* Uffd-wp needs to be delivered to dest pte as well */
@@ -3523,7 +3523,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			inc_mm_counter(mm, MM_ANONPAGES);
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
-		entry = mk_pte(&new_folio->page, vma->vm_page_prot);
+		entry = folio_mk_pte(new_folio, vma->vm_page_prot);
 		entry = pte_sw_mkyoung(entry);
 		if (unlikely(unshare)) {
 			if (pte_soft_dirty(vmf->orig_pte))
@@ -5013,7 +5013,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	 */
 	__folio_mark_uptodate(folio);
 
-	entry = mk_pte(&folio->page, vma->vm_page_prot);
+	entry = folio_mk_pte(folio, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry), vma);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index fbf2cf62ab9f..3d77c8254228 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1063,7 +1063,7 @@ static int move_present_pte(struct mm_struct *mm,
 	folio_move_anon_rmap(src_folio, dst_vma);
 	src_folio->index = linear_page_index(dst_vma, dst_addr);
 
-	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
+	orig_dst_pte = folio_mk_pte(src_folio, dst_vma->vm_page_prot);
 	/* Follow mremap() behavior and treat the entry dirty after the move */
 	orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
 
-- 
2.47.2


