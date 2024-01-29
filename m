Return-Path: <linux-arch+bounces-1769-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C9840879
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5891F25FF1
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA08152E1A;
	Mon, 29 Jan 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ad1FhxUp"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51767152DEC
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538795; cv=none; b=RuraH5cWGcZ14k9EA7tUSCmmLiFcPOZM9cdtcOEGmxXL+Docnv84HIkIff6DrOkE5msb6PMATar5A19gY0UkZ5UTnMSUDqONi82itChkPR72lOxn2AePllGG8993iNvBeveHyl6p41ZTxACnpAcQ9FrDxq5+u65WIpwjtl/C4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538795; c=relaxed/simple;
	bh=U8dM1LpnOBkhx1xNjrI5BIJ3/Pd/C2Pgrvzy5iXZrt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAIFsaKF5K5si5+Z/zG47YUaDMDeOov4dBA5jZ9A5I9b/yZclGStItiR0BobEHrp4+hoWnCq2PmNbLVUEM6AJM99nkc30KETgrQx6BWIGE3xna0DqT/Mtp0dkk8o9yI5IdRr1KWHT8DnrwCmN4nJmiFWtwnXZ7L+c3CIuAJXDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ad1FhxUp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706538792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kOcFg6PGNbb+ifN7/MrtgmE3FIL277TBSGnt13KTXI=;
	b=ad1FhxUp5TAvb7lcNA/r2BXiM3Ye7HRNvEDJKnsD0uCrTiQZjctcjLV+Eu84n8JhVT/K1n
	iwvqKUm3AdZmUueoeLJ9OAPziRcd0m+IMw8PrADtzJRCg3Xh0HfqAd8rQgN1Ur7TgnvkD0
	Ca0hBcW1DoVqcc/dzC1r+MGMiDJbSg8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-skzeZ3g1NrqHlItJu1KF5Q-1; Mon,
 29 Jan 2024 09:33:03 -0500
X-MC-Unique: skzeZ3g1NrqHlItJu1KF5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 518D43C025AD;
	Mon, 29 Jan 2024 14:33:02 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC506C3F;
	Mon, 29 Jan 2024 14:32:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: [PATCH v1 7/9] mm/mmu_gather: add __tlb_remove_folio_pages()
Date: Mon, 29 Jan 2024 15:32:19 +0100
Message-ID: <20240129143221.263763-8-david@redhat.com>
In-Reply-To: <20240129143221.263763-1-david@redhat.com>
References: <20240129143221.263763-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Add __tlb_remove_folio_pages(), which will remove multiple consecutive
pages that belong to the same large folio, instead of only a single
page. We'll be using this function when optimizing unmapping/zapping of
large folios that are mapped by PTEs.

We're using the remaining spare bit in an encoded_page to indicate that
the next enoced page in an array contains actually shifted "nr_pages".
Teach swap/freeing code about putting multiple folio references, and
delayed rmap handling to remove page ranges of a folio.

This extension allows for still gathering almost as many small folios
as we used to (-1, because we have to prepare for a possibly bigger next
entry), but still allows for gathering consecutive pages that belong to the
same large folio.

Note that we don't pass the folio pointer, because it is not required for
now. Further, we don't support page_size != PAGE_SIZE, it won't be
required for simple PTE batching.

We have to provide a separate s390 implementation, but it's fairly
straight forward.

Another, more invasive and likely more expensive, approach would be to
use folio+range or a PFN range instead of page+nr_pages. But, we should
do that consistently for the whole mmu_gather. For now, let's keep it
simple and add "nr_pages" only.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/tlb.h | 17 +++++++++++
 include/asm-generic/tlb.h   |  8 +++++
 include/linux/mm_types.h    | 20 ++++++++++++
 mm/mmu_gather.c             | 61 +++++++++++++++++++++++++++++++------
 mm/swap.c                   | 12 ++++++--
 mm/swap_state.c             | 12 ++++++--
 6 files changed, 116 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 48df896d5b79..abfd2bf29e9e 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -26,6 +26,8 @@ void __tlb_remove_table(void *_table);
 static inline void tlb_flush(struct mmu_gather *tlb);
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 		struct page *page, bool delay_rmap, int page_size);
+static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
+		struct page *page, unsigned int nr_pages, bool delay_rmap);
 
 #define tlb_flush tlb_flush
 #define pte_free_tlb pte_free_tlb
@@ -52,6 +54,21 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 	return false;
 }
 
+static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
+		struct page *page, unsigned int nr_pages, bool delay_rmap)
+{
+	struct encoded_page *encoded_pages[] = {
+		encode_page(page, ENCODED_PAGE_BIT_NR_PAGES),
+		encode_nr_pages(nr_pages),
+	};
+
+	VM_WARN_ON_ONCE(delay_rmap);
+	VM_WARN_ON_ONCE(page_folio(page) != page_folio(page + nr_pages - 1));
+
+	free_pages_and_swap_cache(encoded_pages, ARRAY_SIZE(encoded_pages));
+	return false;
+}
+
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	__tlb_flush_mm_lazy(tlb->mm);
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 2eb7b0d4f5d2..428c3f93addc 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -69,6 +69,7 @@
  *
  *  - tlb_remove_page() / __tlb_remove_page()
  *  - tlb_remove_page_size() / __tlb_remove_page_size()
+ *  - __tlb_remove_folio_pages()
  *
  *    __tlb_remove_page_size() is the basic primitive that queues a page for
  *    freeing. __tlb_remove_page() assumes PAGE_SIZE. Both will return a
@@ -78,6 +79,11 @@
  *    tlb_remove_page() and tlb_remove_page_size() imply the call to
  *    tlb_flush_mmu() when required and has no return value.
  *
+ *    __tlb_remove_folio_pages() is similar to __tlb_remove_page(), however,
+ *    instead of removing a single page, remove the given number of consecutive
+ *    pages that are all part of the same (large) folio: just like calling
+ *    __tlb_remove_page() on each page individually.
+ *
  *  - tlb_change_page_size()
  *
  *    call before __tlb_remove_page*() to set the current page-size; implies a
@@ -262,6 +268,8 @@ struct mmu_gather_batch {
 
 extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
 		bool delay_rmap, int page_size);
+bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
+		unsigned int nr_pages, bool delay_rmap);
 
 #ifdef CONFIG_SMP
 /*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1b89eec0d6df..198662b7a39a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -226,6 +226,15 @@ struct encoded_page;
 /* Perform rmap removal after we have flushed the TLB. */
 #define ENCODED_PAGE_BIT_DELAY_RMAP		1ul
 
+/*
+ * The next item in an encoded_page array is the "nr_pages" argument, specifying
+ * the number of consecutive pages starting from this page, that all belong to
+ * the same folio. For example, "nr_pages" corresponds to the number of folio
+ * references that must be dropped. If this bit is not set, "nr_pages" is
+ * implicitly 1.
+ */
+#define ENCODED_PAGE_BIT_NR_PAGES		2ul
+
 static __always_inline struct encoded_page *encode_page(struct page *page, unsigned long flags)
 {
 	BUILD_BUG_ON(flags > ENCODED_PAGE_BITS);
@@ -242,6 +251,17 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
 	return (struct page *)(~ENCODED_PAGE_BITS & (unsigned long)page);
 }
 
+static __always_inline struct encoded_page *encode_nr_pages(unsigned long nr)
+{
+	VM_WARN_ON_ONCE((nr << 2) >> 2 != nr);
+	return (struct encoded_page *)(nr << 2);
+}
+
+static __always_inline unsigned long encoded_nr_pages(struct encoded_page *page)
+{
+	return ((unsigned long)page) >> 2;
+}
+
 /*
  * A swap entry has to fit into a "unsigned long", as the entry is hidden
  * in the "index" field of the swapper address space.
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 6540c99c6758..dba1973dfe25 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -50,12 +50,21 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 #ifdef CONFIG_SMP
 static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_struct *vma)
 {
+	struct encoded_page **pages = batch->encoded_pages;
+
 	for (int i = 0; i < batch->nr; i++) {
-		struct encoded_page *enc = batch->encoded_pages[i];
+		struct encoded_page *enc = pages[i];
 
 		if (encoded_page_flags(enc) & ENCODED_PAGE_BIT_DELAY_RMAP) {
 			struct page *page = encoded_page_ptr(enc);
-			folio_remove_rmap_pte(page_folio(page), page, vma);
+			unsigned int nr_pages = 1;
+
+			if (unlikely(encoded_page_flags(enc) &
+				     ENCODED_PAGE_BIT_NR_PAGES))
+				nr_pages = encoded_nr_pages(pages[++i]);
+
+			folio_remove_rmap_ptes(page_folio(page), page, nr_pages,
+					       vma);
 		}
 	}
 }
@@ -89,18 +98,26 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
 		struct encoded_page **pages = batch->encoded_pages;
 
-		do {
+		while (batch->nr) {
 			/*
 			 * limit free batch count when PAGE_SIZE > 4K
 			 */
 			unsigned int nr = min(512U, batch->nr);
 
+			/*
+			 * Make sure we cover page + nr_pages, and don't leave
+			 * nr_pages behind when capping the number of entries.
+			 */
+			if (unlikely(encoded_page_flags(pages[nr - 1]) &
+				     ENCODED_PAGE_BIT_NR_PAGES))
+				nr++;
+
 			free_pages_and_swap_cache(pages, nr);
 			pages += nr;
 			batch->nr -= nr;
 
 			cond_resched();
-		} while (batch->nr);
+		}
 	}
 	tlb->active = &tlb->local;
 }
@@ -116,8 +133,9 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
 	tlb->local.next = NULL;
 }
 
-bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
-		bool delay_rmap, int page_size)
+static bool __tlb_remove_folio_pages_size(struct mmu_gather *tlb,
+		struct page *page, unsigned int nr_pages, bool delay_rmap,
+		int page_size)
 {
 	int flags = delay_rmap ? ENCODED_PAGE_BIT_DELAY_RMAP : 0;
 	struct mmu_gather_batch *batch;
@@ -126,6 +144,8 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
 
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	VM_WARN_ON(tlb->page_size != page_size);
+	VM_WARN_ON_ONCE(nr_pages != 1 && page_size != PAGE_SIZE);
+	VM_WARN_ON_ONCE(page_folio(page) != page_folio(page + nr_pages - 1));
 #endif
 
 	batch = tlb->active;
@@ -133,17 +153,40 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
 	 * Add the page and check if we are full. If so
 	 * force a flush.
 	 */
-	batch->encoded_pages[batch->nr++] = encode_page(page, flags);
-	if (batch->nr == batch->max) {
+	if (likely(nr_pages == 1)) {
+		batch->encoded_pages[batch->nr++] = encode_page(page, flags);
+	} else {
+		flags |= ENCODED_PAGE_BIT_NR_PAGES;
+		batch->encoded_pages[batch->nr++] = encode_page(page, flags);
+		batch->encoded_pages[batch->nr++] = encode_nr_pages(nr_pages);
+	}
+	/*
+	 * Make sure that we can always add another "page" + "nr_pages",
+	 * requiring two entries instead of only a single one.
+	 */
+	if (batch->nr >= batch->max - 1) {
 		if (!tlb_next_batch(tlb))
 			return true;
 		batch = tlb->active;
 	}
-	VM_BUG_ON_PAGE(batch->nr > batch->max, page);
+	VM_BUG_ON_PAGE(batch->nr > batch->max - 1, page);
 
 	return false;
 }
 
+bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
+		unsigned int nr_pages, bool delay_rmap)
+{
+	return __tlb_remove_folio_pages_size(tlb, page, nr_pages, delay_rmap,
+					     PAGE_SIZE);
+}
+
+bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
+		bool delay_rmap, int page_size)
+{
+	return __tlb_remove_folio_pages_size(tlb, page, 1, delay_rmap, page_size);
+}
+
 #endif /* MMU_GATHER_NO_GATHER */
 
 #ifdef CONFIG_MMU_GATHER_TABLE_FREE
diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..2a217520b80b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -967,11 +967,17 @@ void release_pages(release_pages_arg arg, int nr)
 	unsigned int lock_batch;
 
 	for (i = 0; i < nr; i++) {
+		unsigned int nr_refs = 1;
 		struct folio *folio;
 
 		/* Turn any of the argument types into a folio */
 		folio = page_folio(encoded_page_ptr(encoded[i]));
 
+		/* Is our next entry actually "nr_pages" -> "nr_refs" ? */
+		if (unlikely(encoded_page_flags(encoded[i]) &
+			     ENCODED_PAGE_BIT_NR_PAGES))
+			nr_refs = encoded_nr_pages(encoded[++i]);
+
 		/*
 		 * Make sure the IRQ-safe lock-holding time does not get
 		 * excessive with a continuous string of pages from the
@@ -990,14 +996,14 @@ void release_pages(release_pages_arg arg, int nr)
 				unlock_page_lruvec_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
-			if (put_devmap_managed_page(&folio->page))
+			if (put_devmap_managed_page_refs(&folio->page, nr_refs))
 				continue;
-			if (folio_put_testzero(folio))
+			if (folio_ref_sub_and_test(folio, nr_refs))
 				free_zone_device_page(&folio->page);
 			continue;
 		}
 
-		if (!folio_put_testzero(folio))
+		if (!folio_ref_sub_and_test(folio, nr_refs))
 			continue;
 
 		if (folio_test_large(folio)) {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index e671266ad772..ae0c0f1f51bd 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -311,8 +311,16 @@ void free_page_and_swap_cache(struct page *page)
 void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
 {
 	lru_add_drain();
-	for (int i = 0; i < nr; i++)
-		free_swap_cache(encoded_page_ptr(pages[i]));
+	for (int i = 0; i < nr; i++) {
+		struct page *page = encoded_page_ptr(pages[i]);
+
+		/* Skip over "nr_pages". Only call it once for the folio. */
+		if (unlikely(encoded_page_flags(pages[i]) &
+			     ENCODED_PAGE_BIT_NR_PAGES))
+			i++;
+
+		free_swap_cache(page);
+	}
 	release_pages(pages, nr);
 }
 
-- 
2.43.0


