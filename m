Return-Path: <linux-arch+bounces-1765-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3726840869
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEA8288D96
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76A015351C;
	Mon, 29 Jan 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJh2Shmx"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4F152E00
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538769; cv=none; b=J0m6Ay19HUDt4W8743xKmHcXiseI7lT4VcVasReZxihpkRYO5+JG//MEv/WudqU9d+eYP2KbwWIQO7NTMmcQBvELqTcP77FTlWFb7yIkYJzCC/V3/2Cnl+TimN4lgiPEV5hHOl4almH190PdHZ3vvDrfDDibhhIfikY1HGb9Fhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538769; c=relaxed/simple;
	bh=uJmPGUDLFyZe0bZqwcbaHzJkmT/1nN67hPwrqw3D1Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPDxugFTuM4JJg39jcx3tXldi+njbE502sZBAbL6EMpVSRSZNShJ6EPEh7ZvyD4/r+dme9eSpI/9khq9WY2jKdNKUZFXkwdvxFQI0qEosv9SWPjKnwacIOhcgD0s9cnjuOlyMkNh02uggFUVhEgGkNz/hKV74XWpKbOFQoZMM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJh2Shmx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706538767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkSqLVnz5/2y8MLWUf6UFgTHMoYCjTvN5uvEMNfOCyQ=;
	b=OJh2Shmx2U8Ejx2Oqr5Eihdzs/VG8dln4YzNP7+gzND90vUObDov0FJzfZ9A2AhE+l3UJ7
	WHG+g4xow3Zmw3txXhCXrvkH5KamXCyjjjbnQhdY9p4WXM5CtI4HSzMaIqGE4boYu7pl9b
	HfSQ/DahZCiPklyWTH9v9vtMi9h5qZM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-tQCqrTzqPz-8PYoPDfxKqg-1; Mon, 29 Jan 2024 09:32:44 -0500
X-MC-Unique: tQCqrTzqPz-8PYoPDfxKqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BAC885A599;
	Mon, 29 Jan 2024 14:32:42 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CCEB7AD1;
	Mon, 29 Jan 2024 14:32:37 +0000 (UTC)
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
Subject: [PATCH v1 3/9] mm/memory: further separate anon and pagecache folio handling in zap_present_pte()
Date: Mon, 29 Jan 2024 15:32:15 +0100
Message-ID: <20240129143221.263763-4-david@redhat.com>
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

We don't need up-to-date accessed-dirty information for anon folios and can
simply work with the ptent we already have. Also, we know the RSS counter
we want to update.

We can safely move arch_check_zapped_pte() + tlb_remove_tlb_entry() +
zap_install_uffd_wp_if_needed() after updating the folio and RSS.

While at it, only call zap_install_uffd_wp_if_needed() if there is even
any chance that pte_install_uffd_wp_if_needed() would do *something*.
That is, just don't bother if uffd-wp does not apply.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 69502cdc0a7d..20bc13ab8db2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1552,12 +1552,9 @@ static inline void zap_present_pte(struct mmu_gather *tlb,
 	folio = page_folio(page);
 	if (unlikely(!should_zap_folio(details, folio)))
 		return;
-	ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
-	arch_check_zapped_pte(vma, ptent);
-	tlb_remove_tlb_entry(tlb, pte, addr);
-	zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
 
 	if (!folio_test_anon(folio)) {
+		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
 		if (pte_dirty(ptent)) {
 			folio_mark_dirty(folio);
 			if (tlb_delay_rmap(tlb)) {
@@ -1567,8 +1564,17 @@ static inline void zap_present_pte(struct mmu_gather *tlb,
 		}
 		if (pte_young(ptent) && likely(vma_has_recency(vma)))
 			folio_mark_accessed(folio);
+		rss[mm_counter(folio)]--;
+	} else {
+		/* We don't need up-to-date accessed/dirty bits. */
+		ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
+		rss[MM_ANONPAGES]--;
 	}
-	rss[mm_counter(folio)]--;
+	arch_check_zapped_pte(vma, ptent);
+	tlb_remove_tlb_entry(tlb, pte, addr);
+	if (unlikely(userfaultfd_pte_wp(vma, ptent)))
+		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
+
 	if (!delay_rmap) {
 		folio_remove_rmap_pte(folio, page, vma);
 		if (unlikely(page_mapcount(page) < 0))
-- 
2.43.0


