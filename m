Return-Path: <linux-arch+bounces-2162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583DB84FF8F
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 23:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90BE1F243D9
	for <lists+linux-arch@lfdr.de>; Fri,  9 Feb 2024 22:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A513338DD2;
	Fri,  9 Feb 2024 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI/Ei4xA"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3A383A4
	for <linux-arch@vger.kernel.org>; Fri,  9 Feb 2024 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516941; cv=none; b=iyeOL08cdFNh8LiUnxgD2sPUEFwmUhHPzXNvQylHkAcZkIbz9BtjO3xiVbVLyx3BlP88qoktbsL3ciNozDjBhJ6N2zbgBFrxBbYJGFl5v2OGqQAA9i/IiXCxili0v94fRo4h2yMbRl4+FGeQRgDKzqqiVXHoxGM7ez6I3QZe1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516941; c=relaxed/simple;
	bh=gJjdcDN9SIZ57EMSsnxvz4s6wGh9ngGev4G0JhDn5Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ju3DFPsKF0U+cTBcW9tH2XiNced3R+nEq+BQSW5ZOZxzmDvVYMYqrZpJxIZS92K2LK2kdci55pw7RoTGAOu41faSCqwGfORXXv7w5FeeVOZhz6a9jWKFaBCtB8w7ZxrzKCT1cvX8u1PVtbhQPK86VWEAuxRlUNT6FI/PUPC66fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hI/Ei4xA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707516938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/Ux9HRgPwmdR3zuVPtEfBlFP5wVpYCc/8Whwmc2o7c=;
	b=hI/Ei4xAVpyYn8mhUYC5rM1c7hI4uYG7LhttViGd7GsWYUa6NhzOoA8ejhKI9W0FvGaRAi
	qNQjmszsLZNgzDIu0dfk5clQm4AJGkJbI2ViOYeMmg2FzlCfvwvACT2Ym5xwdXBeP7/YRX
	zIBOEwiS9A9cqg8ibfeazvq8A+MOPXM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-ojxWH6gHP7CoaMSJUSv5fA-1; Fri, 09 Feb 2024 17:15:32 -0500
X-MC-Unique: ojxWH6gHP7CoaMSJUSv5fA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85BE9185A780;
	Fri,  9 Feb 2024 22:15:31 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 512C21C14B04;
	Fri,  9 Feb 2024 22:15:27 +0000 (UTC)
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
Subject: [PATCH v2 03/10] mm/memory: further separate anon and pagecache folio handling in zap_present_pte()
Date: Fri,  9 Feb 2024 23:15:02 +0100
Message-ID: <20240209221509.585251-4-david@redhat.com>
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

We don't need up-to-date accessed-dirty information for anon folios and can
simply work with the ptent we already have. Also, we know the RSS counter
we want to update.

We can safely move arch_check_zapped_pte() + tlb_remove_tlb_entry() +
zap_install_uffd_wp_if_needed() after updating the folio and RSS.

While at it, only call zap_install_uffd_wp_if_needed() if there is even
any chance that pte_install_uffd_wp_if_needed() would do *something*.
That is, just don't bother if uffd-wp does not apply.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4da6923709b2..7a3ebb6e5909 100644
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


