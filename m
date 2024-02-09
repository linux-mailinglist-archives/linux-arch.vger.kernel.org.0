Return-Path: <linux-arch+bounces-2168-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4507D84FFA3
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 23:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95AE1B2A1EB
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 22:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7E93770C;
	Fri,  9 Feb 2024 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWGv6VNe"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F139FCE
	for <linux-arch@vger.kernel.org>; Fri,  9 Feb 2024 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516970; cv=none; b=iMh34OmW1Lz7AuoxwugLUjPiGfAQJ88MeD9QY2VNgkp/xLLzV68vspwhu84fxNH972ztMWZxdMfOuiJfQC9J2q8sSqe+ydl602Y71D+hswuaTz9FqyosFXfDpdnGukDOj1DLSk9l7T8p1GUJ46Qtr/tL6Rgni8+QrfQXM9qW/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516970; c=relaxed/simple;
	bh=/5mbH+9wsrYjqsJ0BTPMr7p8fqUtmFZU4UxswK+eIVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgyIcb1oKN8hraQ7+PFIJddBLZlw5RMnUqi9C8mnGvvFNHWDYBOu3H2JSM/AVnPFk62rqwE9Z1rZsBRWtAood1q+A2lVgx27BF7GimVCFuSXZbd1xdC72p/DwrmYEKtPnZOeNLA8uxvo8WGkCd6yHmCIPDLAmzkGDsqf07daixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWGv6VNe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707516967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8W53GW4ZEWC3PprgXE/ukTwzuRzol5bFe9xhF3bvjg=;
	b=KWGv6VNe1qwKYZH4ouyIx8BCMeZLXRyOykz6QqhP0wfZQMc+viANG4NiaffJ4rzf89cIuZ
	H+329RWgRMBLtGTaLUfoyJBO32j8tsO+dhtUhHHFJ0/+yvBaaiZWB4zazEw3M7FPOrFMY5
	rkEzMCT+e3U4H9eR3RYO0RDaCrf1R7w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-t2V2UsG2PJSAXQJ2V6pbnw-1; Fri, 09 Feb 2024 17:16:04 -0500
X-MC-Unique: t2V2UsG2PJSAXQJ2V6pbnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE704837230;
	Fri,  9 Feb 2024 22:16:02 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E26B01C14B04;
	Fri,  9 Feb 2024 22:15:56 +0000 (UTC)
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
Subject: [PATCH v2 09/10] mm/mmu_gather: improve cond_resched() handling with large folios and expensive page freeing
Date: Fri,  9 Feb 2024 23:15:08 +0100
Message-ID: <20240209221509.585251-10-david@redhat.com>
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

It's a pain that we have to handle cond_resched() in
tlb_batch_pages_flush() manually and cannot simply handle it in
release_pages() -- release_pages() can be called from atomic context.
Well, in a perfect world we wouldn't have to make our code more at all.

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
fragments in there. Note that we might end up freeing only a single folio
fragment at a time that might exceed the old 512 pages limit: but if we
cannot even free a single MAX_ORDER page on a system without running into
soft lockups, something else is already completely bogus.

In the future, we might want to detect if handling cond_resched() is
required at all, and just not do any of that with full preemption enabled.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/mmu_gather.c | 50 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index d175c0f1e2c8..2774044b5790 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -91,18 +91,19 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
 }
 #endif
 
-static void tlb_batch_pages_flush(struct mmu_gather *tlb)
+static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
 {
-	struct mmu_gather_batch *batch;
-
-	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
-		struct encoded_page **pages = batch->encoded_pages;
+	struct encoded_page **pages = batch->encoded_pages;
+	unsigned int nr, nr_pages;
 
+	/*
+	 * We might end up freeing a lot of pages. Reschedule on a regular
+	 * basis to avoid soft lockups in configurations without full
+	 * preemption enabled. The magic number of 512 folios seems to work.
+	 */
+	if (!page_poisoning_enabled_static() && !want_init_on_free()) {
 		while (batch->nr) {
-			/*
-			 * limit free batch count when PAGE_SIZE > 4K
-			 */
-			unsigned int nr = min(512U, batch->nr);
+			nr = min(512, batch->nr);
 
 			/*
 			 * Make sure we cover page + nr_pages, and don't leave
@@ -119,6 +120,37 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 			cond_resched();
 		}
 	}
+
+	/*
+	 * With page poisoning and init_on_free, the time it takes to free
+	 * memory grows proportionally with the actual memory size. Therefore,
+	 * limit based on the actual memory size and not the number of involved
+	 * folios.
+	 */
+	while (batch->nr) {
+		for (nr = 0, nr_pages = 0;
+		     nr < batch->nr && nr_pages < 512; nr++) {
+			if (unlikely(encoded_page_flags(pages[nr]) &
+				     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
+				nr_pages += encoded_nr_pages(pages[++nr]);
+			else
+				nr_pages++;
+		}
+
+		free_pages_and_swap_cache(pages, nr);
+		pages += nr;
+		batch->nr -= nr;
+
+		cond_resched();
+	}
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


