Return-Path: <linux-arch+bounces-2379-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846CD85543F
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 21:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3CF1F2981F
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 20:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7755913F006;
	Wed, 14 Feb 2024 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MW8m0jNQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D691420D3
	for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943523; cv=none; b=V6vigXlBBvYUgItAwXGUQq+zCEgEtzo0kNlDqHAytFW8vc0f3hcx3tFmpT9D54jovjOAQJVk3ogKyNPgFFp0mGvsiWR98KkBOzZMDWU8gCVuiO3HZUlg8LLpKq9kQKFVZhfYpqij8BqT7pxYQ+Ppe7s4xg7WCkLrHVS2PtbkJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943523; c=relaxed/simple;
	bh=NUzLgoVlOyf2LRkuaXGl5RfztDVrEk1Ld5b6CnFv0Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8UV+mTI+l8ulhKRMFiLpR4xUxgLS04sl7IaxAQQX0aY5isG5VQRp29rb6nPiqyKn72mfbjyHmKn0ttVRSCiH9/aB2re1ANhIc+TfaOEZaZZ+xf3owp+kZZyFqIDKx8Qg8JvUbkCuTiSoc6KSoDgBzYx4sIOzE2tz6uCRqGy1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MW8m0jNQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707943520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRS8kYaXs4+JoUa7KvLCUnXcrqNWL6ZvqI66J3j2gDY=;
	b=MW8m0jNQLADKiWSmdR3prrjfz/LppqmF2EViS9ZOlTec74AACIsR3IynyTPOoNSSsInrma
	/R3v524Y6bdT7wICYxAZOn4FiNzRCoF/STPPGIqd5LBUH66qdotqvljfhfV6sspSwUfst2
	m1N/zZ0bx2cc6Vyrh8SUMkf4OFyHxog=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-lVXRetU-PDCixQSdYcx5pA-1; Wed, 14 Feb 2024 15:45:18 -0500
X-MC-Unique: lVXRetU-PDCixQSdYcx5pA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 503D9101A52A;
	Wed, 14 Feb 2024 20:45:17 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.174])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8ECBC1C05E0F;
	Wed, 14 Feb 2024 20:45:13 +0000 (UTC)
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
Subject: [PATCH v3 09/10] mm/mmu_gather: improve cond_resched() handling with large folios and expensive page freeing
Date: Wed, 14 Feb 2024 21:44:34 +0100
Message-ID: <20240214204435.167852-10-david@redhat.com>
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

In tlb_batch_pages_flush(), we can end up freeing up to 512 pages or
now up to 256 folio fragments that span more than one page, before we
conditionally reschedule.

It's a pain that we have to handle cond_resched() in
tlb_batch_pages_flush() manually and cannot simply handle it in
release_pages() -- release_pages() can be called from atomic context.
Well, in a perfect world we wouldn't have to make our code more
complicated at all.

With page poisoning and init_on_free, we might now run into soft lockups
when we free a lot of rather large folio fragments, because page freeing
time then depends on the actual memory size we are freeing instead of on
the number of folios that are involved.

In the absolute (unlikely) worst case, on arm64 with 64k we will be able
to free up to 256 folio fragments that each span 512 MiB: zeroing out 128
GiB does sound like it might take a while. But instead of ignoring this
unlikely case, let's just handle it.

So, let's teach tlb_batch_pages_flush() that there are some
configurations where page freeing is horribly slow, and let's reschedule
more frequently -- similarly like we did for now before we had large folio
fragments in there. Avoid yet another loop over all encoded pages in the
common case by handling that separately.

Note that with page poisoning/zeroing, we might now end up freeing only a
single folio fragment at a time that might exceed the old 512 pages limit:
but if we cannot even free a single MAX_ORDER page on a system without
running into soft lockups, something else is already completely bogus.
Freeing a PMD-mapped THP would similarly cause trouble.

In theory, we might even free 511 order-0 pages + a single MAX_ORDER page,
effectively having to zero out 8703 pages on arm64 with 64k, translating to
~544 MiB of memory: however, if 512 MiB doesn't result in soft lockups,
544 MiB is unlikely to result in soft lockups, so we won't care about
that for the time being.

In the future, we might want to detect if handling cond_resched() is
required at all, and just not do any of that with full preemption enabled.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/mmu_gather.c | 58 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index d175c0f1e2c8..99b3e9408aa0 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -91,18 +91,21 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
 }
 #endif
 
-static void tlb_batch_pages_flush(struct mmu_gather *tlb)
-{
-	struct mmu_gather_batch *batch;
+/*
+ * We might end up freeing a lot of pages. Reschedule on a regular
+ * basis to avoid soft lockups in configurations without full
+ * preemption enabled. The magic number of 512 folios seems to work.
+ */
+#define MAX_NR_FOLIOS_PER_FREE		512
 
-	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
-		struct encoded_page **pages = batch->encoded_pages;
+static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
+{
+	struct encoded_page **pages = batch->encoded_pages;
+	unsigned int nr, nr_pages;
 
-		while (batch->nr) {
-			/*
-			 * limit free batch count when PAGE_SIZE > 4K
-			 */
-			unsigned int nr = min(512U, batch->nr);
+	while (batch->nr) {
+		if (!page_poisoning_enabled_static() && !want_init_on_free()) {
+			nr = min(MAX_NR_FOLIOS_PER_FREE, batch->nr);
 
 			/*
 			 * Make sure we cover page + nr_pages, and don't leave
@@ -111,14 +114,39 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 			if (unlikely(encoded_page_flags(pages[nr - 1]) &
 				     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
 				nr++;
+		} else {
+			/*
+			 * With page poisoning and init_on_free, the time it
+			 * takes to free memory grows proportionally with the
+			 * actual memory size. Therefore, limit based on the
+			 * actual memory size and not the number of involved
+			 * folios.
+			 */
+			for (nr = 0, nr_pages = 0;
+			     nr < batch->nr && nr_pages < MAX_NR_FOLIOS_PER_FREE;
+			     nr++) {
+				if (unlikely(encoded_page_flags(pages[nr]) &
+					     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
+					nr_pages += encoded_nr_pages(pages[++nr]);
+				else
+					nr_pages++;
+			}
+		}
 
-			free_pages_and_swap_cache(pages, nr);
-			pages += nr;
-			batch->nr -= nr;
+		free_pages_and_swap_cache(pages, nr);
+		pages += nr;
+		batch->nr -= nr;
 
-			cond_resched();
-		}
+		cond_resched();
 	}
+}
+
+static void tlb_batch_pages_flush(struct mmu_gather *tlb)
+{
+	struct mmu_gather_batch *batch;
+
+	for (batch = &tlb->local; batch && batch->nr; batch = batch->next)
+		__tlb_batch_free_encoded_pages(batch);
 	tlb->active = &tlb->local;
 }
 
-- 
2.43.0


