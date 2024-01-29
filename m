Return-Path: <linux-arch+bounces-1770-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0046C84087A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E3D1F22BEA
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 14:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164261534F6;
	Mon, 29 Jan 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDZ+/Huh"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDCD152E04
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538796; cv=none; b=PcXTJJADWGzOP7Jl5R+St0xniet/KAqib5IbGC7P58cA3VNKOM73GHPW2UXC4ovml61dr5aFjgxLgHW+vHFvSBPn8saKNj9TizfxKyTiKCjI55P36viopA0ZlwcUd7ZTIsAhoJzOSJTjqi//8A9nfUMuc9BbLjlfLIAZeVzkTTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538796; c=relaxed/simple;
	bh=zw6RATGgPG5UGfHtEP8dnEvhsSimfAqvKLqzhVagRpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCU9Re/yfLEbKBEHiFEzgKTw+8/DIwgJwIBuPCvRCB3QmZZQsvnAtc00PakCogz4K6iliDaZOz1QF0QJ0P3ilp4HFEQ2NSSIP9ChyKb59bZkT7fNivVyo0szhsxO3qKETnoTzl7PUI2O0OHRMBuGmI4RWZEyPODr4raUYGB/5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDZ+/Huh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706538793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hD+wJlVoYoeun3CtWSKYM8LYSFldaYp0TLUcFe85aZ0=;
	b=PDZ+/Huh2Gj/pLEk/cXmNkmBv985dlvJMaJ6FMoCE+93t3jHcfHUchurVZeKgeusHm4rbP
	XSVxKJo7Y1FGUWwEr7m6cRVT1jhWoZRinPW8+hEFge6VxHNXdkMz6cdwP9lo7+1Kwrs6hP
	SDjMZ30IRFlQ0NHlVaxuO+axnw2knSk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-0ZkSAIR7N62aRzlXnFbltw-1; Mon,
 29 Jan 2024 09:33:09 -0500
X-MC-Unique: 0ZkSAIR7N62aRzlXnFbltw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88CF43C13A9D;
	Mon, 29 Jan 2024 14:33:07 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1D40AD1;
	Mon, 29 Jan 2024 14:33:02 +0000 (UTC)
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
Subject: [PATCH v1 8/9] mm/mmu_gather: add tlb_remove_tlb_entries()
Date: Mon, 29 Jan 2024 15:32:20 +0100
Message-ID: <20240129143221.263763-9-david@redhat.com>
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

Let's add a helper that lets us batch-process multiple consecutive PTEs.

Note that the loop will get optimized out on all architectures except on
powerpc. We have to add an early define of __tlb_remove_tlb_entry() on
ppc to make the compiler happy (and avoid making tlb_remove_tlb_entries() a
macro).

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
index 428c3f93addc..bd00dd238b79 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -616,6 +616,26 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
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


