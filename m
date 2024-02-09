Return-Path: <linux-arch+bounces-2163-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A09284FF91
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 23:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93919285622
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 22:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABF3381CF;
	Fri,  9 Feb 2024 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jC/CC3AJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB52E646
	for <linux-arch@vger.kernel.org>; Fri,  9 Feb 2024 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516943; cv=none; b=NtwFbVdHFZ7QNME+Uh3mMpKB60LUi0GCOM93Pa6jB7EUscyqtKwiwxdY4mD/S0mz9YNcReob3ejOpPOEZ2Ca61+DK/MESONm28M05XHDPoekfeH+yDZ0d5adahSPWNZ0e5bZAoCrPcl6LesrfpemMwhp8JdWN7zanL46lTnMlxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516943; c=relaxed/simple;
	bh=X688LQ+8vv1x+HYbDq06JeZc4jgkCPC+TN2xr2DyFa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTdKQELM9crQpQjvzbPto9yVns1imzfNXb5CL5qHL+SNJqsXs9vyOfH0r/Z/4eCcBVrs3b99lQmnaIYtRHW86L2A1sDYRdWWEP5oCWErEJTID0ifXP+BwRxG76CNLF9mBX1ypGKHlMnAnO144ekHqKLCy+fPPfVaUKk6u3BSGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jC/CC3AJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707516940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SyWghWuBP6GkqnhxcyLXYq2ssX4b7HML4Pf9katCZ5k=;
	b=jC/CC3AJwfLHSpn/sM/90eeqJvfLyTwjX9+n3EGMTMHV3pDHRPG/SLP62JYilMPFU7RMeU
	xwpQHhqhDe0w62hT7WIg2HbtNnVW9JXFXIh9nLPOl1Wwh/VK8oXv8dauRlfV34bSWmA7zc
	MC5K1DHzr05Ej185C5hbVZx8KtuQXm4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-umYgGBJnMqW48D3blg8DZg-1; Fri,
 09 Feb 2024 17:15:38 -0500
X-MC-Unique: umYgGBJnMqW48D3blg8DZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED4963812023;
	Fri,  9 Feb 2024 22:15:36 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E569E1C14B04;
	Fri,  9 Feb 2024 22:15:31 +0000 (UTC)
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
Subject: [PATCH v2 04/10] mm/memory: factor out zapping folio pte into zap_present_folio_pte()
Date: Fri,  9 Feb 2024 23:15:03 +0100
Message-ID: <20240209221509.585251-5-david@redhat.com>
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

Let's prepare for further changes by factoring it out into a separate
function.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 53 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7a3ebb6e5909..a3efc4da258a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1528,30 +1528,14 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
 }
 
-static inline void zap_present_pte(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
-		unsigned long addr, struct zap_details *details,
-		int *rss, bool *force_flush, bool *force_break)
+static inline void zap_present_folio_pte(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, struct folio *folio,
+		struct page *page, pte_t *pte, pte_t ptent, unsigned long addr,
+		struct zap_details *details, int *rss, bool *force_flush,
+		bool *force_break)
 {
 	struct mm_struct *mm = tlb->mm;
 	bool delay_rmap = false;
-	struct folio *folio;
-	struct page *page;
-
-	page = vm_normal_page(vma, addr, ptent);
-	if (!page) {
-		/* We don't need up-to-date accessed/dirty bits. */
-		ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
-		arch_check_zapped_pte(vma, ptent);
-		tlb_remove_tlb_entry(tlb, pte, addr);
-		VM_WARN_ON_ONCE(userfaultfd_wp(vma));
-		ksm_might_unmap_zero_page(mm, ptent);
-		return;
-	}
-
-	folio = page_folio(page);
-	if (unlikely(!should_zap_folio(details, folio)))
-		return;
 
 	if (!folio_test_anon(folio)) {
 		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
@@ -1586,6 +1570,33 @@ static inline void zap_present_pte(struct mmu_gather *tlb,
 	}
 }
 
+static inline void zap_present_pte(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
+		unsigned long addr, struct zap_details *details,
+		int *rss, bool *force_flush, bool *force_break)
+{
+	struct mm_struct *mm = tlb->mm;
+	struct folio *folio;
+	struct page *page;
+
+	page = vm_normal_page(vma, addr, ptent);
+	if (!page) {
+		/* We don't need up-to-date accessed/dirty bits. */
+		ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
+		arch_check_zapped_pte(vma, ptent);
+		tlb_remove_tlb_entry(tlb, pte, addr);
+		VM_WARN_ON_ONCE(userfaultfd_wp(vma));
+		ksm_might_unmap_zero_page(mm, ptent);
+		return;
+	}
+
+	folio = page_folio(page);
+	if (unlikely(!should_zap_folio(details, folio)))
+		return;
+	zap_present_folio_pte(tlb, vma, folio, page, pte, ptent, addr, details,
+			      rss, force_flush, force_break);
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
-- 
2.43.0


