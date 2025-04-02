Return-Path: <linux-arch+bounces-11237-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0FA794F7
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A1A16DD92
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D607D86353;
	Wed,  2 Apr 2025 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YAXCy6X1"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8611CBA
	for <linux-arch@vger.kernel.org>; Wed,  2 Apr 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617858; cv=none; b=Ep+e+5M4zf4pNZc263YENOEtIgfXDAxtQC08F8ozkUN9GB+00Z/YcwugT18cMKlT/Nf5zDM3EpQrH1589qCGSQswDNz/ns88mjFIU+vW5AGnYAxAwVfnvv7gH4AndiLeq3dkyYsXwcH9HJ+u4yvAXK2QxnUqT+AGuTa+gG05+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617858; c=relaxed/simple;
	bh=G32+yIqO0ngYYODi/eiq/n6VoalCD+/p47c43GftsW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSplWcIaU3a2a7/V6aMMJGJYfC0yDPKT4twbfQycbvCOjBlf3ABhQ/u++mUtCHYkANZb4f0wiIfSFF4b8kycCxr7gOjjXHqrfwjm0IhJmr+9fzmIiks0eTdNB0NmyuA+bnpWzZ2IEEcdpJ6stkotQ4Ww4+plPAlAcOB4kMHhQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YAXCy6X1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lziGZfROFPhpObpsaGUZ16kTN/pcfFau1WI7RqoG7Nk=; b=YAXCy6X1G2bFcoaDIZGZDJIjcY
	CayYgL2F+q7RCw52YgbfwYENQP7LaVJJH8DKSUhlxIuWCu7KFD4zqWq7/vuLsTcwYOtWxQKvjJ9t/
	ctqq5kCqm7yurpAKtOyciNlMMgUMPoG1ke2hHdsXtnhTqZD8SExb5iQSk+AduITgbWGe05cFpwNsI
	7SHht3zFfW5/iNKBZtTpMDXMuJD+lVq1hUpZC5OZ6+f1VFrzpVuDvsIKcuEk1APt8W86WqBCQBHVo
	m7PmJMhxuBt+ZF5c0CKHPun/BSBF6eSv1JvFELqmRtI9S7P/9ZiD6vZj3FUQIa/ZC25srHY0l+S6r
	rJ2sR16w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02eF-0000000A0iU-0796;
	Wed, 02 Apr 2025 18:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 01/11] mm: Set the pte dirty if the folio is already dirty
Date: Wed,  2 Apr 2025 19:16:55 +0100
Message-ID: <20250402181709.2386022-2-willy@infradead.org>
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

If the first access to a folio is a read that is then followed by a
write, we can save a page fault.  s390 implemented this in their
mk_pte() in commit abf09bed3cce ("s390/mm: implement software dirty
bits"), but other architectures can also benefit from this.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com> # for s390
---
 arch/s390/include/asm/pgtable.h | 7 +------
 mm/memory.c                     | 2 ++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index f8a6b54986ec..49833002232b 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1450,12 +1450,7 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
 
 static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 {
-	unsigned long physpage = page_to_phys(page);
-	pte_t __pte = mk_pte_phys(physpage, pgprot);
-
-	if (pte_write(__pte) && PageDirty(page))
-		__pte = pte_mkdirty(__pte);
-	return __pte;
+	return mk_pte_phys(page_to_phys(page), pgprot);
 }
 
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
diff --git a/mm/memory.c b/mm/memory.c
index 2d8c265fc7d6..68bcf639a78c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5245,6 +5245,8 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	else if (pte_write(entry) && folio_test_dirty(folio))
+		entry = pte_mkdirty(entry);
 	if (unlikely(vmf_orig_pte_uffd_wp(vmf)))
 		entry = pte_mkuffd_wp(entry);
 	/* copy-on-write page */
-- 
2.47.2


