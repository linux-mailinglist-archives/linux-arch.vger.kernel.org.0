Return-Path: <linux-arch+bounces-2376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E99855437
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 21:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FA11F23C23
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 20:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5794C1420AD;
	Wed, 14 Feb 2024 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XL9AVkMF"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207813EFEF
	for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943513; cv=none; b=MIdP5+BjYWNoI0I0jsoelcOau1uoObapcg4AG7DFM5nPPEs/+jgKO4Yb6lsPg866LOxvjga0+TcmrkeLYBDcaeSNn0731H3gZRUl7RejbZ+k8IeSmdUvOzCzD+aLr76NRrDwBOtghHYEoEEdW1yn9pYjovgMlHTpCoXkkc6zawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943513; c=relaxed/simple;
	bh=Ivx6k9RHC7xtfNym2WBe4tYwW7cQHPIIcIfbRJkpcmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQGsYqnpNDpekEoOf1vIzblT1CtuO5ASxYLStNPZhe7nTbulyfKVVYzJ9S9+smow/CSm4xnp2aUXU56gNRIjb4+rkf+Q4iFbWTKsBJq63ccijlXl44XsWLaHQ1AVo7v7Fy8mYXBLzB3jUHzzk5bIWT5bp7nGENE4K0eRYeK7oyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XL9AVkMF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707943510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfteBvWtn9YL0u+ZWWzLkAZQ9TqgPhMIROF4I2AA+84=;
	b=XL9AVkMFdFrbnenNeApdyrOXKTz7/LliTwj7RUzuKuLo7BX13x3dBkhkUadQ42p3AQIvPw
	UGvvWRMftGFJSRqCWX1a1j2fP/lVqZ1OV0Iao+RXlZmgwEnSzT7Z8hTEKUy7H9o4SFQ/0G
	B4uivDfk7FDv95mzRx/DuydpL1hIrZ0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-FFKMi1htPsyeY2_wWYIuqQ-1; Wed,
 14 Feb 2024 15:45:06 -0500
X-MC-Unique: FFKMi1htPsyeY2_wWYIuqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 768353C29A67;
	Wed, 14 Feb 2024 20:45:04 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.174])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C376E1C060B1;
	Wed, 14 Feb 2024 20:45:00 +0000 (UTC)
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
Subject: [PATCH v3 06/10] mm/mmu_gather: define ENCODED_PAGE_FLAG_DELAY_RMAP
Date: Wed, 14 Feb 2024 21:44:31 +0100
Message-ID: <20240214204435.167852-7-david@redhat.com>
In-Reply-To: <20240214204435.167852-1-david@redhat.com>
References: <20240214204435.167852-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Nowadays, encoded pages are only used in mmu_gather handling. Let's
update the documentation, and define ENCODED_PAGE_BIT_DELAY_RMAP. While at
it, rename ENCODE_PAGE_BITS to ENCODED_PAGE_BITS.

If encoded page pointers would ever be used in other context again, we'd
likely want to change the defines to reflect their context (e.g.,
ENCODED_PAGE_FLAG_MMU_GATHER_DELAY_RMAP). For now, let's keep it simple.

This is a preparation for using the remaining spare bit to indicate that
the next item in an array of encoded pages is a "nr_pages" argument and
not an encoded page.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 17 +++++++++++------
 mm/mmu_gather.c          |  5 +++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8b611e13153e..1b89eec0d6df 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -210,8 +210,8 @@ struct page {
  *
  * An 'encoded_page' pointer is a pointer to a regular 'struct page', but
  * with the low bits of the pointer indicating extra context-dependent
- * information. Not super-common, but happens in mmu_gather and mlock
- * handling, and this acts as a type system check on that use.
+ * information. Only used in mmu_gather handling, and this acts as a type
+ * system check on that use.
  *
  * We only really have two guaranteed bits in general, although you could
  * play with 'struct page' alignment (see CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
@@ -220,21 +220,26 @@ struct page {
  * Use the supplied helper functions to endcode/decode the pointer and bits.
  */
 struct encoded_page;
-#define ENCODE_PAGE_BITS 3ul
+
+#define ENCODED_PAGE_BITS			3ul
+
+/* Perform rmap removal after we have flushed the TLB. */
+#define ENCODED_PAGE_BIT_DELAY_RMAP		1ul
+
 static __always_inline struct encoded_page *encode_page(struct page *page, unsigned long flags)
 {
-	BUILD_BUG_ON(flags > ENCODE_PAGE_BITS);
+	BUILD_BUG_ON(flags > ENCODED_PAGE_BITS);
 	return (struct encoded_page *)(flags | (unsigned long)page);
 }
 
 static inline unsigned long encoded_page_flags(struct encoded_page *page)
 {
-	return ENCODE_PAGE_BITS & (unsigned long)page;
+	return ENCODED_PAGE_BITS & (unsigned long)page;
 }
 
 static inline struct page *encoded_page_ptr(struct encoded_page *page)
 {
-	return (struct page *)(~ENCODE_PAGE_BITS & (unsigned long)page);
+	return (struct page *)(~ENCODED_PAGE_BITS & (unsigned long)page);
 }
 
 /*
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index ac733d81b112..6540c99c6758 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -53,7 +53,7 @@ static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_
 	for (int i = 0; i < batch->nr; i++) {
 		struct encoded_page *enc = batch->encoded_pages[i];
 
-		if (encoded_page_flags(enc)) {
+		if (encoded_page_flags(enc) & ENCODED_PAGE_BIT_DELAY_RMAP) {
 			struct page *page = encoded_page_ptr(enc);
 			folio_remove_rmap_pte(page_folio(page), page, vma);
 		}
@@ -119,6 +119,7 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
 bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
 		bool delay_rmap, int page_size)
 {
+	int flags = delay_rmap ? ENCODED_PAGE_BIT_DELAY_RMAP : 0;
 	struct mmu_gather_batch *batch;
 
 	VM_BUG_ON(!tlb->end);
@@ -132,7 +133,7 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
 	 * Add the page and check if we are full. If so
 	 * force a flush.
 	 */
-	batch->encoded_pages[batch->nr++] = encode_page(page, delay_rmap);
+	batch->encoded_pages[batch->nr++] = encode_page(page, flags);
 	if (batch->nr == batch->max) {
 		if (!tlb_next_batch(tlb))
 			return true;
-- 
2.43.0


