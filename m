Return-Path: <linux-arch+bounces-2377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF993855439
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 21:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0BC1F250FA
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 20:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96161420A6;
	Wed, 14 Feb 2024 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJ7ZVP6Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186C51420A7
	for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943514; cv=none; b=a/Hq9ISqGXDX9JfNvCMv0pE9LKYhdXmEM2IW1ebuj+z3iSFCvC5eHGDeN5/KeqFywz0qhtmrVhKmSyha/mh0rGwHZTZaBnIO22Dm69RbRMURSah2Z2LhIGeJV6pAhaPtENDXTibagT5Btd4jfcnOF9PE7QNuCQhX6oqp6dmJxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943514; c=relaxed/simple;
	bh=3PQfbTkS/vd68uh/N1+tvV3UXJ8B0ItANJG44cGwxXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZqB3jfjtiaOZ9dxXaBjYgau0OIBqE4oV2XjqkCmZ3hOK9WDnXzTu8TJjDdSyW92NFIePPwbWhKOgi+neBRfrl1y1JA9bonyUsoNwu2FKFaFtYR1lwdqCdkFFyUsWYXaASVAWA7GdjIHOJpaTKGMANgZUP5v1RI5tpXRUKv3yC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJ7ZVP6Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707943512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4BN9bDZrrapc7Xd1FDfmQmuEZxXG5tNILRPdL9R2lg=;
	b=eJ7ZVP6Y7AETnYns47B1A0BnRFzkI6Sh9ESVYeIJhFN3KAHSRPiFCtidTnkbxpu4FrkqdX
	X1tMaFiUSkVW14JfejpSw7TDNLjJNK44d3G60WPUmPVu1ukOZDGEh0pdfQFNRYiw6lNNqn
	LRkYLUQquNRJjXr3D6SLWsIlTOZ+LPE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-D3IZQFsSNhyFuV3-aH76jg-1; Wed, 14 Feb 2024 15:45:09 -0500
X-MC-Unique: D3IZQFsSNhyFuV3-aH76jg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ACBD811E79;
	Wed, 14 Feb 2024 20:45:08 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.174])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B3DCE1C066A9;
	Wed, 14 Feb 2024 20:45:04 +0000 (UTC)
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
Subject: [PATCH v3 07/10] mm/mmu_gather: add tlb_remove_tlb_entries()
Date: Wed, 14 Feb 2024 21:44:32 +0100
Message-ID: <20240214204435.167852-8-david@redhat.com>
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

Let's add a helper that lets us batch-process multiple consecutive PTEs.

Note that the loop will get optimized out on all architectures except on
powerpc. We have to add an early define of __tlb_remove_tlb_entry() on
ppc to make the compiler happy (and avoid making tlb_remove_tlb_entries() a
macro).

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/include/asm/tlb.h |  2 ++
 include/asm-generic/tlb.h      | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index b3de6102a907..1ca7d4c4b90d 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -19,6 +19,8 @@
 
 #include <linux/pagemap.h>
 
+static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
+					  unsigned long address);
 #define __tlb_remove_tlb_entry	__tlb_remove_tlb_entry
 
 #define tlb_flush tlb_flush
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 2eb7b0d4f5d2..95d60a4f468a 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -608,6 +608,26 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 		__tlb_remove_tlb_entry(tlb, ptep, address);	\
 	} while (0)
 
+/**
+ * tlb_remove_tlb_entries - remember unmapping of multiple consecutive ptes for
+ *			    later tlb invalidation.
+ *
+ * Similar to tlb_remove_tlb_entry(), but remember unmapping of multiple
+ * consecutive ptes instead of only a single one.
+ */
+static inline void tlb_remove_tlb_entries(struct mmu_gather *tlb,
+		pte_t *ptep, unsigned int nr, unsigned long address)
+{
+	tlb_flush_pte_range(tlb, address, PAGE_SIZE * nr);
+	for (;;) {
+		__tlb_remove_tlb_entry(tlb, ptep, address);
+		if (--nr == 0)
+			break;
+		ptep++;
+		address += PAGE_SIZE;
+	}
+}
+
 #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
 	do {							\
 		unsigned long _sz = huge_page_size(h);		\
-- 
2.43.0


