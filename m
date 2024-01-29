Return-Path: <linux-arch+bounces-1768-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5C4840875
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F0E1F23F42
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BD2154421;
	Mon, 29 Jan 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DM6pZeq4"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893B152E10
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538786; cv=none; b=QYE/X+yDHQfaJYrY6ur95xZ6d/BU4jhp191t1okWzB4TlHH3v19EFSCIFvU5AWMUB5eh0DeZNySlxWUEq0QHCsQJvyqVheUi0TFuwq7d5mGSMge3FdmD1MXwQa/lXlXieQPVXWO74RPi2dGbmb7erkklsCfGKbvqwDrO1v1BU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538786; c=relaxed/simple;
	bh=SFBh0jlYhQ4i0GImjfc/SgW5aNf3hVaKskoDHZxMjYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJLS4tnDzjiwzXxQcpl3pFb9HkRpdD5Fw8S7cjTvuGNXU6EU7U4XIQOrFlFVM5jHI55Bk4wIQvSNaRFQMQbMgkCTIeaKtJwTDSnFbIBzwdd4VIIEncVGYJ35RdNTmvuw5mYvk+qfjtphmvNCSc2ZTTCt7WhlcQWs2Sb4kVMSvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DM6pZeq4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706538783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNf9J4fpCfYM4JsYJaH2xcr0nS1jv7jO8GYZWdUDb4k=;
	b=DM6pZeq4ge7oQvggcpLdBJIIO6GHCDJCdbCGf4H5sByIka12OW2JXgDZJ6IOx10amgTC94
	aUGfJSrcMMmGI1OOidDg7JJFv4p+VZ+UxKJ4GO1NEyUHFeBUi8y6UfqaBIAQQqtZqiMeo/
	7ykXnEQV4k1Oa1zpkoW95wUPt2qFEMU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-7zFZXTSTNpira0N1ASkqtg-1; Mon, 29 Jan 2024 09:32:58 -0500
X-MC-Unique: 7zFZXTSTNpira0N1ASkqtg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55A0B185A781;
	Mon, 29 Jan 2024 14:32:57 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C0D15AD1;
	Mon, 29 Jan 2024 14:32:52 +0000 (UTC)
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
Subject: [PATCH v1 6/9] mm/mmu_gather: define ENCODED_PAGE_FLAG_DELAY_RMAP
Date: Mon, 29 Jan 2024 15:32:18 +0100
Message-ID: <20240129143221.263763-7-david@redhat.com>
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

Nowadays, encoded pages are only used in mmu_gather handling. Let's
update the documentation, and define ENCODED_PAGE_BIT_DELAY_RMAP. While at
it, rename ENCODE_PAGE_BITS to ENCODED_PAGE_BITS.

If encoded page pointers would ever be used in other context again, we'd
likely want to change the defines to reflect their context (e.g.,
ENCODED_PAGE_FLAG_MMU_GATHER_DELAY_RMAP). For now, let's keep it simple.

This is a preparation for using the remaining spare bit to indicate that
the next item in an array of encoded pages is a "nr_pages" argument and
not an encoded page.

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


