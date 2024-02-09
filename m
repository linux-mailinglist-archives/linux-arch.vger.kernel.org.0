Return-Path: <linux-arch+bounces-2160-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF4284FF87
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 23:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E542128803D
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 22:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A92D36AEF;
	Fri,  9 Feb 2024 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCgkftxZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733F364A0
	for <linux-arch@vger.kernel.org>; Fri,  9 Feb 2024 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516930; cv=none; b=FeQN+ZgJEBG4p5i3EVDNt3U1iAtSMzD4jkkzKhL6ObP/UzIyIJn5HNsU/HIXSeuK+aEIxjIw1N2pojXnR7ol4PYONp5Mb+IG8geJbK3lH3xh8IBFYNYvjR+OA+n1LANjfoe2kXTIxM9b+g5ltxsQkw/hb52EP0wUPE/3TdBJpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516930; c=relaxed/simple;
	bh=TnUCOm2JT+0JTJyQU5SkjDNAWwULzDd20SY3FqhSdfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXZx72BGEPwkz+4Z7erVFWqhbH5OHiugvCrCH4TN4eWzmsgKL2sTBTMGxckfWQfw9VsmwUT0iTgiRlM8iTV1eTu6Mn9sKszKBMw0Tf8kMpjKRjbNpqySsyVVbkWfi8ovKVQnE6WKpuUQ7ioYuRLvKyAGldGMucWo2JenNO78Ubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCgkftxZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707516927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUXSwV0Ba8onVJaRwxmEJ/5t7CtvdY0dXq3jtt3HQ88=;
	b=FCgkftxZEazm6vAr44EDSYiwEMLKuKWJDgqOyPfiDc+VSdCSBdRjXdnACq+/fqATyDgLF4
	NDResOTmqFisob8PtoNkxCMgu08fqcTvCyM+Qh4t2uJPTrSScp3HBEyveDDr00ybvc8BLx
	3UVqnEoDMTJacMlDGtqS2AgwSOjrUg8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-CTYzAu7yOQSNMpmHOZXTyA-1; Fri, 09 Feb 2024 17:15:21 -0500
X-MC-Unique: CTYzAu7yOQSNMpmHOZXTyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85BC185A589;
	Fri,  9 Feb 2024 22:15:20 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 74DCF1C14B04;
	Fri,  9 Feb 2024 22:15:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Subject: [PATCH v2 01/10] mm/memory: factor out zapping of present pte into zap_present_pte()
Date: Fri,  9 Feb 2024 23:15:00 +0100
Message-ID: <20240209221509.585251-2-david@redhat.com>
In-Reply-To: <20240209221509.585251-1-david@redhat.com>
References: <20240209221509.585251-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Let's prepare for further changes by factoring out processing of present
PTEs.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 94 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7c3ca41a7610..5b0dc33133a6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1532,13 +1532,61 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
 }
 
+static inline void zap_present_pte(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
+		unsigned long addr, struct zap_details *details,
+		int *rss, bool *force_flush, bool *force_break)
+{
+	struct mm_struct *mm = tlb->mm;
+	struct folio *folio = NULL;
+	bool delay_rmap = false;
+	struct page *page;
+
+	page = vm_normal_page(vma, addr, ptent);
+	if (page)
+		folio = page_folio(page);
+
+	if (unlikely(!should_zap_folio(details, folio)))
+		return;
+	ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
+	arch_check_zapped_pte(vma, ptent);
+	tlb_remove_tlb_entry(tlb, pte, addr);
+	zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
+	if (unlikely(!page)) {
+		ksm_might_unmap_zero_page(mm, ptent);
+		return;
+	}
+
+	if (!folio_test_anon(folio)) {
+		if (pte_dirty(ptent)) {
+			folio_mark_dirty(folio);
+			if (tlb_delay_rmap(tlb)) {
+				delay_rmap = true;
+				*force_flush = true;
+			}
+		}
+		if (pte_young(ptent) && likely(vma_has_recency(vma)))
+			folio_mark_accessed(folio);
+	}
+	rss[mm_counter(folio)]--;
+	if (!delay_rmap) {
+		folio_remove_rmap_pte(folio, page, vma);
+		if (unlikely(page_mapcount(page) < 0))
+			print_bad_pte(vma, addr, ptent, page);
+	}
+	if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
+		*force_flush = true;
+		*force_break = true;
+	}
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
+	bool force_flush = false, force_break = false;
 	struct mm_struct *mm = tlb->mm;
-	int force_flush = 0;
 	int rss[NR_MM_COUNTERS];
 	spinlock_t *ptl;
 	pte_t *start_pte;
@@ -1555,7 +1603,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	arch_enter_lazy_mmu_mode();
 	do {
 		pte_t ptent = ptep_get(pte);
-		struct folio *folio = NULL;
+		struct folio *folio;
 		struct page *page;
 
 		if (pte_none(ptent))
@@ -1565,45 +1613,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			break;
 
 		if (pte_present(ptent)) {
-			unsigned int delay_rmap;
-
-			page = vm_normal_page(vma, addr, ptent);
-			if (page)
-				folio = page_folio(page);
-
-			if (unlikely(!should_zap_folio(details, folio)))
-				continue;
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
-			arch_check_zapped_pte(vma, ptent);
-			tlb_remove_tlb_entry(tlb, pte, addr);
-			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
-						      ptent);
-			if (unlikely(!page)) {
-				ksm_might_unmap_zero_page(mm, ptent);
-				continue;
-			}
-
-			delay_rmap = 0;
-			if (!folio_test_anon(folio)) {
-				if (pte_dirty(ptent)) {
-					folio_mark_dirty(folio);
-					if (tlb_delay_rmap(tlb)) {
-						delay_rmap = 1;
-						force_flush = 1;
-					}
-				}
-				if (pte_young(ptent) && likely(vma_has_recency(vma)))
-					folio_mark_accessed(folio);
-			}
-			rss[mm_counter(folio)]--;
-			if (!delay_rmap) {
-				folio_remove_rmap_pte(folio, page, vma);
-				if (unlikely(page_mapcount(page) < 0))
-					print_bad_pte(vma, addr, ptent, page);
-			}
-			if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
-				force_flush = 1;
+			zap_present_pte(tlb, vma, pte, ptent, addr, details,
+					rss, &force_flush, &force_break);
+			if (unlikely(force_break)) {
 				addr += PAGE_SIZE;
 				break;
 			}
-- 
2.43.0


