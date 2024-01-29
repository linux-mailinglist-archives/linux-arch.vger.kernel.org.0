Return-Path: <linux-arch+bounces-1764-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E68BC840866
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771D4B26ABC
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8A153514;
	Mon, 29 Jan 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JB0BouA5"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543081534E2
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538768; cv=none; b=eBK3iiPtu4knpsCXHEOzt88A+ye7HNX60pFcHE/2cE2R0CjBrcoGrPq1Av35EmhQSdv/L5Luadv3a2N6bnzD1AMZYXj98BDmAXi3yugmcn7mx7cv1TQZbhinghUgOpVMRdlpK232DTxAiu0gXi712QRdFISXmHjAexM/lwODmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538768; c=relaxed/simple;
	bh=ox+eQ1EXoBSzOjUFapo41STtCich4R5P1O+bP48vyb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulqp9Izho/O6Xi2eHVO5uSSXV4r39WWjcMJthVWuC3Ru0F7kKOgQzPL1dFex9qGs1VphB2SbTreMgNvClkgRk/e9VmCTyW70CVaz/RLtGNSLV2uOiKqWeZ7JqgyDTPFFjA+bzk57mrLoaQI9/hJlF9G4l1ihPrPk4CZozMe8D4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JB0BouA5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706538766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNlnKqTU8a/1Fu37QrFx8MEnv7tH60nNAECNkKLkAAs=;
	b=JB0BouA5RePqC5wEC9ROLLM2b+Vti9iePUsGCpaA/klwZIJv/nrCnFk051NGS8LOGg3wZz
	OfdsAcI61882PBGVovaWoXWq3WrcXzb8uCAvtthDFnOFxUbsLahjfhMBMXpwkzP1sSnnyW
	WzstrXwfnqtOrEV1wdaIOL1rJjGL8xI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-unK-9W-5NjSJSLj6qcQ8jg-1; Mon,
 29 Jan 2024 09:32:41 -0500
X-MC-Unique: unK-9W-5NjSJSLj6qcQ8jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 902141C05137;
	Mon, 29 Jan 2024 14:32:37 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 20796AD1;
	Mon, 29 Jan 2024 14:32:32 +0000 (UTC)
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
Subject: [PATCH v1 2/9] mm/memory: handle !page case in zap_present_pte() separately
Date: Mon, 29 Jan 2024 15:32:14 +0100
Message-ID: <20240129143221.263763-3-david@redhat.com>
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

We don't need uptodate accessed/dirty bits, so in theory we could
replace ptep_get_and_clear_full() by an optimized ptep_clear_full()
function. Let's rely on the provided pte.

Further, there is no scenario where we would have to insert uffd-wp
markers when zapping something that is not a normal page (i.e., zeropage).
Add a sanity check to make sure this remains true.

should_zap_folio() no longer has to handle NULL pointers. This change
replaces 2/3 "!page/!folio" checks by a single "!page" one.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 50a6c79c78fc..69502cdc0a7d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1497,10 +1497,6 @@ static inline bool should_zap_folio(struct zap_details *details,
 	if (should_zap_cows(details))
 		return true;
 
-	/* E.g. the caller passes NULL for the case of a zero folio */
-	if (!folio)
-		return true;
-
 	/* Otherwise we should only zap non-anon folios */
 	return !folio_test_anon(folio);
 }
@@ -1543,19 +1539,23 @@ static inline void zap_present_pte(struct mmu_gather *tlb,
 	struct page *page;
 
 	page = vm_normal_page(vma, addr, ptent);
-	if (page)
-		folio = page_folio(page);
+	if (!page) {
+		/* We don't need up-to-date accessed/dirty bits. */
+		ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
+		arch_check_zapped_pte(vma, ptent);
+		tlb_remove_tlb_entry(tlb, pte, addr);
+		VM_WARN_ON_ONCE(userfaultfd_wp(vma));
+		ksm_might_unmap_zero_page(mm, ptent);
+		return;
+	}
 
+	folio = page_folio(page);
 	if (unlikely(!should_zap_folio(details, folio)))
 		return;
 	ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
 	arch_check_zapped_pte(vma, ptent);
 	tlb_remove_tlb_entry(tlb, pte, addr);
 	zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
-	if (unlikely(!page)) {
-		ksm_might_unmap_zero_page(mm, ptent);
-		return;
-	}
 
 	if (!folio_test_anon(folio)) {
 		if (pte_dirty(ptent)) {
-- 
2.43.0


