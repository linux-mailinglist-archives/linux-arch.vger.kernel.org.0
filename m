Return-Path: <linux-arch+bounces-1767-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF4C840872
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371CA28757E
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136C3153BFC;
	Mon, 29 Jan 2024 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+PA+umE"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5CD152E05
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538780; cv=none; b=k1Y+lSKUOunuGRHwBIADc+AV/EXVjMF/ZwQL/trTT+f/YNAQGiZPVdGlX8d0n7xpGJVQkM+Vz/CYrM9FoAdNx1ojvaXbyOv2dp+ScGXvRaaEZ8Hvxsw7/aHSfFRnnTgpEXSPGLlA8/VtHveLazLxZO1gCwDHjmMQzL53+8ySW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538780; c=relaxed/simple;
	bh=v2LHXe4M1/jpGFAoHOpD/tUoB3keJAoacIpB/KTVpWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4vkrPB19EBu9Ml0CefRXl7uDtu6w1Jd5Mji8Hf6p9YVBfLHHCVyjDlFsu8X4AxqO1vxlwYYQD/pah7XXfFHTmj+dD4dQrmxfU0kqas8ZHuw1oUl0PcPPwxLOf8wnZKqDz0kfbEVafd+C5ijSqNMnoRjkP+6jcFYja6Tz25+M9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+PA+umE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706538777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRXeU82IBxy/RcnY5wfdvSjzmzqpCs6vJAdTnhTQH90=;
	b=c+PA+umEQ0io6cQs8bUNPCLewWhJgqHDyp1HBixYUV6MqU951mji0KEZQ2SV3EB437JE5b
	mlROA+WH4pWFEeH4a0a2GixCIkF2Zuj69PtWCyiRwlHxMb5AoEfzWBfF1LUWiFKBecrlnN
	FN2+DVkVOjuDELWNH3xHeBvrGhu1VkA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-RcYHT5HwMdeLqdQ1EEIoXA-1; Mon,
 29 Jan 2024 09:32:53 -0500
X-MC-Unique: RcYHT5HwMdeLqdQ1EEIoXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61CE93C13AA2;
	Mon, 29 Jan 2024 14:32:52 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5AF0AD1;
	Mon, 29 Jan 2024 14:32:47 +0000 (UTC)
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
Subject: [PATCH v1 5/9] mm/mmu_gather: pass "delay_rmap" instead of encoded page to __tlb_remove_page_size()
Date: Mon, 29 Jan 2024 15:32:17 +0100
Message-ID: <20240129143221.263763-6-david@redhat.com>
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

We have two bits available in the encoded page pointer to store
additional information. Currently, we use one bit to request delay of the
rmap removal until after a TLB flush.

We want to make use of the remaining bit internally for batching of
multiple pages of the same folio, specifying that the next encoded page
pointer in an array is actually "nr_pages". So pass page + delay_rmap flag
instead of an encoded page, to handle the encoding internally.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/tlb.h | 13 ++++++-------
 include/asm-generic/tlb.h   | 12 ++++++------
 mm/mmu_gather.c             |  7 ++++---
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index d1455a601adc..48df896d5b79 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -25,8 +25,7 @@
 void __tlb_remove_table(void *_table);
 static inline void tlb_flush(struct mmu_gather *tlb);
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-					  struct encoded_page *page,
-					  int page_size);
+		struct page *page, bool delay_rmap, int page_size);
 
 #define tlb_flush tlb_flush
 #define pte_free_tlb pte_free_tlb
@@ -42,14 +41,14 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
  * tlb_ptep_clear_flush. In both flush modes the tlb for a page cache page
  * has already been freed, so just do free_page_and_swap_cache.
  *
- * s390 doesn't delay rmap removal, so there is nothing encoded in
- * the page pointer.
+ * s390 doesn't delay rmap removal.
  */
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-					  struct encoded_page *page,
-					  int page_size)
+		struct page *page, bool delay_rmap, int page_size)
 {
-	free_page_and_swap_cache(encoded_page_ptr(page));
+	VM_WARN_ON_ONCE(delay_rmap);
+
+	free_page_and_swap_cache(page);
 	return false;
 }
 
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 129a3a759976..2eb7b0d4f5d2 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -260,9 +260,8 @@ struct mmu_gather_batch {
  */
 #define MAX_GATHER_BATCH_COUNT	(10000UL/MAX_GATHER_BATCH)
 
-extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
-				   struct encoded_page *page,
-				   int page_size);
+extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
+		bool delay_rmap, int page_size);
 
 #ifdef CONFIG_SMP
 /*
@@ -462,13 +461,14 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
-	if (__tlb_remove_page_size(tlb, encode_page(page, 0), page_size))
+	if (__tlb_remove_page_size(tlb, page, false, page_size))
 		tlb_flush_mmu(tlb);
 }
 
-static __always_inline bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page, unsigned int flags)
+static __always_inline bool __tlb_remove_page(struct mmu_gather *tlb,
+		struct page *page, bool delay_rmap)
 {
-	return __tlb_remove_page_size(tlb, encode_page(page, flags), PAGE_SIZE);
+	return __tlb_remove_page_size(tlb, page, delay_rmap, PAGE_SIZE);
 }
 
 /* tlb_remove_page
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 604ddf08affe..ac733d81b112 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -116,7 +116,8 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
 	tlb->local.next = NULL;
 }
 
-bool __tlb_remove_page_size(struct mmu_gather *tlb, struct encoded_page *page, int page_size)
+bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
+		bool delay_rmap, int page_size)
 {
 	struct mmu_gather_batch *batch;
 
@@ -131,13 +132,13 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct encoded_page *page, i
 	 * Add the page and check if we are full. If so
 	 * force a flush.
 	 */
-	batch->encoded_pages[batch->nr++] = page;
+	batch->encoded_pages[batch->nr++] = encode_page(page, delay_rmap);
 	if (batch->nr == batch->max) {
 		if (!tlb_next_batch(tlb))
 			return true;
 		batch = tlb->active;
 	}
-	VM_BUG_ON_PAGE(batch->nr > batch->max, encoded_page_ptr(page));
+	VM_BUG_ON_PAGE(batch->nr > batch->max, page);
 
 	return false;
 }
-- 
2.43.0


