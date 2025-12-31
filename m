Return-Path: <linux-arch+bounces-15613-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17855CEB251
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 04:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 854D6300A56D
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 03:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361A223DD4;
	Wed, 31 Dec 2025 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VogUHt8q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A91F5437
	for <linux-arch@vger.kernel.org>; Wed, 31 Dec 2025 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767150043; cv=none; b=qn9MdKlYEyhs5GcYoZVjQAsX8XPamvGWKl8jcP3rv1iHLNTMthiaQHvo7z6ihlzKyd+f0FKoO0UdA5rR3DiD/4RY8dwXdU7PWRVWDoG1RMvpWejjc+7t1dF9R2j1LKErq6jqzEorZVN59Jp7bYnKiAyDH2Ae6QjutRffwo18kPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767150043; c=relaxed/simple;
	bh=dHwD+0A9amhmH8NdE47S8FVYcVASPYZHLixjaKOa6oE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SiT5tuSu3NsS8t63R5tzjPUgSDNfDQ7yiz/h7DSQVM80dbLmaO4K8K1d0UPMnHTlojyLfZ/YgxPqWvyfpHdRz+HKlIkgS7+mUPVLjFhnYGYso3DThhzrYq3x2jR+VpF4eNYZQfS9J3E60SZHhP8CjaRXRQXvYOzv20Bnjj4ArmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VogUHt8q; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso1865323566b.2
        for <linux-arch@vger.kernel.org>; Tue, 30 Dec 2025 19:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767150040; x=1767754840; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMZvWbbIBBmy2hVTByTqVU/28wHL8fmh5GRIKAADEPk=;
        b=VogUHt8qE0JG0+ZR+BZdGNgTM0lQ0RbLlihyPCCYyRa6Owo4AXogDmTcf8mEtFZpl0
         gmT/ufgX+s+y07qhWiIieLOWwgJO9dJy+hnLR3R1v7oCU9rzZscMgwvOoydNVvAmD0Mx
         Uh7lcHXn5neVC8qi+hcG/amzx9Lzvq4ydVsfNbFPASHML0VvMSlrebElHAt6ZHtIMHiv
         oUISMCngwToQqQQlQyk51G3y1oPBeBbjOhet6xya4KaC1+c8hrJFvtBBrWFHi4gvpGvp
         cFVzVU7ukzmjwtwMCLBLlEkdEluOTjzhlIKOhjpOj9UUSZoeqx7tSuuByO8T54aN/exT
         TtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767150040; x=1767754840;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MMZvWbbIBBmy2hVTByTqVU/28wHL8fmh5GRIKAADEPk=;
        b=Kub2jdGRTyp2q85yb4J2aiPDYj6YBZzA8Kfp8NTDAWE8mKBN8DxDrADLK/9ShleyBV
         s3vWd/bIA59QWd2Id6zQ6EqaQpjSN4qMftsuv9BM5HGe12MBy8wpawtmCmfi/Hbz5vcg
         vswJL8+0rSm4vh3EgkdP9rKodvfWDDdub9Rc89eFJCXpyQSRA+VfpHwxXXNjYAGgW/CB
         +W90M6RKeRALjyI5WIklhstePKNuxVlr00mdt2pQYS8m7+Hnv/rENck9en5/fwsZpOo+
         4uVfgRJPg67DJ0gue+UvGAFe/E4Ejq3OnGVn4WC9sTx9H729yBEMR3oI9UQ6bSV07rhK
         mnqA==
X-Gm-Message-State: AOJu0YwxIZhwZoiI8vQdAIOM01nEX5r9CN2TQs6I8xUPOGg/WT1VGELM
	RAktBbnmZqzjdJgpbvOXip3JhvcrY6BY/4/1IrbMqGpWc/A4KI7IAmca
X-Gm-Gg: AY/fxX79B4nfaQTU5dLT92QS8FowIwVssFkOXebW8IuZt32gmIsCHJ5/d5k6UJTUQS7
	br1P1b41qtVxXwJKuC6HyqElHyStFnFYSXPlDRZypyFVvBdJb29yMXVchKYeKawu3Ky0e7phAKP
	T0UL5Z4WR2BQb1QM3dzlaipHdKQl6Wwz74Q7bPmlw6eJK739t7IODnsEm/1sDn3e/v/3XhbkK7H
	oQRUj3OMgjbR6d0/oNDKZZ7XQQwWLGR7ZU2wqGy8Pj4c3/aQITPh4A8cHVyA4i0Wymz+8RkrOgn
	X6X1FjyqLNxh0yAE4R/qmiOsXCxjDAA4Fz08JHrED2H5/8virXY6WW8KMMfbfIuqprqOBym15jI
	tN18EWaop7dWDqj7ry4Fh1eqooCBMk+UF21qBuGlsCC12mtb4PWKolDkmMAx4RgegW/L0nFU59l
	jCyAogF7MX0Q==
X-Google-Smtp-Source: AGHT+IF8S0Qg+GmPFjjVlu2NlHvua7TCiotJg06/+N0u+q+yODVpwkPNVE7It1PwxVV5gykBDT11FQ==
X-Received: by 2002:a17:907:78b:b0:b83:975:f8a5 with SMTP id a640c23a62f3a-b830976511cmr2325146266b.40.1767150039609;
        Tue, 30 Dec 2025 19:00:39 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a6050dsm3865880566b.9.2025.12.30.19.00.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Dec 2025 19:00:39 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: will@kernel.org,
	aneesh.kumar@kernel.org,
	akpm@linux-foundation.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	arnd@arndb.de
Cc: linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: [PATCH] mm/mmu_gather: remove @delay_remap of __tlb_remove_page_size()
Date: Wed, 31 Dec 2025 03:00:26 +0000
Message-Id: <20251231030026.15938-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Functioin __tlb_remove_page_size() is only used in
tlb_remove_page_size() with @delay_remap set to false and it is passed
directly to __tlb_remove_folio_pages_size().

Remove @delay_remap of __tlb_remove_page_size() and call
__tlb_remove_folio_pages_size() with false @delay_remap.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
---
 arch/s390/include/asm/tlb.h | 6 ++----
 include/asm-generic/tlb.h   | 5 ++---
 mm/mmu_gather.c             | 5 ++---
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 1e50f6f1ad9d..0b7b4df94b24 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -24,7 +24,7 @@
 
 static inline void tlb_flush(struct mmu_gather *tlb);
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-		struct page *page, bool delay_rmap, int page_size);
+		struct page *page, int page_size);
 static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
 		struct page *page, unsigned int nr_pages, bool delay_rmap);
 
@@ -46,10 +46,8 @@ static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
  * s390 doesn't delay rmap removal.
  */
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-		struct page *page, bool delay_rmap, int page_size)
+		struct page *page, int page_size)
 {
-	VM_WARN_ON_ONCE(delay_rmap);
-
 	free_folio_and_swap_cache(page_folio(page));
 	return false;
 }
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 4d679d2a206b..3975f7d11553 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -287,8 +287,7 @@ struct mmu_gather_batch {
  */
 #define MAX_GATHER_BATCH_COUNT	(10000UL/MAX_GATHER_BATCH)
 
-extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
-		bool delay_rmap, int page_size);
+extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size);
 bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
 		unsigned int nr_pages, bool delay_rmap);
 
@@ -510,7 +509,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
-	if (__tlb_remove_page_size(tlb, page, false, page_size))
+	if (__tlb_remove_page_size(tlb, page, page_size))
 		tlb_flush_mmu(tlb);
 }
 
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 7468ec388455..2faa23d7f8d4 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -210,10 +210,9 @@ bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
 					     PAGE_SIZE);
 }
 
-bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
-		bool delay_rmap, int page_size)
+bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size)
 {
-	return __tlb_remove_folio_pages_size(tlb, page, 1, delay_rmap, page_size);
+	return __tlb_remove_folio_pages_size(tlb, page, 1, false, page_size);
 }
 
 #endif /* MMU_GATHER_NO_GATHER */
-- 
2.34.1


