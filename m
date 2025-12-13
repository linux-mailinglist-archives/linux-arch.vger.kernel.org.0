Return-Path: <linux-arch+bounces-15391-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E9CBA701
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 09:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8606300A9F5
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFC5238171;
	Sat, 13 Dec 2025 08:01:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125BF23BCF5
	for <linux-arch@vger.kernel.org>; Sat, 13 Dec 2025 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765612873; cv=none; b=ghRXwezz0fYjFXhPhGUt99a2ISxeKsRHadPMM6P1FE1mXQabtCpS8pOMtLWIwtDuTDKVr4PAVobAvg5FfZs/s4JHDezwIpsCLekwGwUwFd3fwYJTlkOfSVJiim4ggzOaCYRzO9+qnsa2vlesNiotuciFEDAntPrs68RZxUq3/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765612873; c=relaxed/simple;
	bh=BcvVy/2hQ35U0ulolpe9ekEUJgrhZcDUmd2SZgR1tmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ+41yvXgtOXNKnclnuujThlaJsqT7EY5eZUuuLDDANkeprbt8KXnJM1IDCTqEBO8Y8BbDRY0i7ux7uKZiroUe3gahzGFW1RGunPrGG01OyGZKw2kuw45+YnsjRBzym8+qLvMiuJb8VfDSzQqVFDp2tiu9/KkJ1VJ77Wv/xERaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a081c163b0so8384635ad.0
        for <linux-arch@vger.kernel.org>; Sat, 13 Dec 2025 00:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765612871; x=1766217671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKeRxMOvOPVkMEpeJrhYXUzwhdbko1M2EXmC4O4D0Xg=;
        b=MMdPz4/dsmtz+RzO9H+aSQvZnSMCoBIqwlLBqWUhR08+cEmW80i36G8R2b4tJq153Q
         YjFB+FnC3rMJGm9yxucHFej50191t2u3fBX7gjT5IXxSjbpjUkt+HxzAB+gyDXoCN78Y
         MlJ9o8JD3SdRcq6dvaqyFXvJrJ/6fnl6rh66u+jekON9XzrbChTSiIOuiLafoGgvovU0
         Pm410OxX99X0vd/v9gNRdslVwKCpNeNnNEK1SdEWDxxKoac/jCgJQtQVS9ZdN7n7c59+
         4HdYyE3rS4U2jtwUMkAi2lu8euryxnNsvaV2Xa4zfFj07UYTpX4jDQhbft4ZkoMgLHEm
         ypxg==
X-Forwarded-Encrypted: i=1; AJvYcCVjdEOa1DTYudDoW+HOvKKrsHt6mpt/W3TBdJ739PSvaj7NY4wOTNsGgqHrzEnIskxXLFaL1uaEuubr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41ysX3BNie3FEzXa4vpw2uYxgQ/yzGB5wk4QWPCgyX+q/8Z5f
	WwD1KSXwe9ax7sD6B6rI5rF8AnRZ1Gof1ZzH+u0T95PWJxtZcR7cqiUY
X-Gm-Gg: AY/fxX7GEC0nzUFMERUSuWzAuEfOL8IAOVZKnr+wF4iUGM31oaRPcR8q4nsYmGPk8dx
	IVp5LktUACQ5LsoMOZjyT7YXmqt4yDMplF+Gig97KHYiTHJcAcri8q+0I6mNO+wQ/CarrNgRXzC
	vp7iKfFYWRChby89GAcxotP9M81nXFB36XURu+O6htzXDu5rR123VYfKNmFw6i75OpwgeZ5Hkmf
	PNAQO84IPvXSGgy6p/Vgt6pZzg5UnTA6zSUDc5Tn5Jj17fzUJGxbwQe2z43ijliW3Cd/phOR+f3
	2u7Rewi813oZcVem1wf2lVfhnikdPqCcyRD90GdlYuCD/SH1mXar/9b3VZYO2tgo0FODGF5mQtN
	lOu1i3cmB0gi/WIHnoFJjbZ6rG+GWt2OxYJ9fZY0LeRWXZueTxCA6EQB4VGVPENRej5C8BNiBK2
	Qal9OfGcR5SumcZIQmRuNE2/RJEg==
X-Google-Smtp-Source: AGHT+IF+7XHnXgrhyzygY7I1rYSWeg9b2h4e3tV2K6rz3wu/Ladawz1GxFoLm3IkAXfgeDDX1CPE4w==
X-Received: by 2002:a17:903:8cc:b0:297:f0a8:e84c with SMTP id d9443c01a7336-29f24386514mr51433605ad.52.1765612871142;
        Sat, 13 Dec 2025 00:01:11 -0800 (PST)
Received: from localhost.localdomain ([45.142.165.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f05287fa3sm53149155ad.5.2025.12.13.00.01.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Dec 2025 00:01:10 -0800 (PST)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	shy828301@gmail.com,
	riel@surriel.com,
	jannh@google.com,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH RFC 1/3] mm/tlb: allow architectures to skip redundant TLB sync IPIs
Date: Sat, 13 Dec 2025 16:00:23 +0800
Message-ID: <20251213080038.10917-2-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251213080038.10917-1-lance.yang@linux.dev>
References: <20251213080038.10917-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When unsharing hugetlb PMD page tables, we currently send two IPIs:
one for TLB invalidation, and another to synchronize with concurrent
GUP-fast walkers.

However, if the TLB flush already reaches all CPUs, the second IPI is
redundant. GUP-fast runs with IRQs disabled, so when the TLB flush IPI
completes, any concurrent GUP-fast must have finished.

Add tlb_table_flush_implies_ipi_broadcast() to let architectures indicate
their TLB flush provides full synchronization, enabling the redundant IPI
to be skipped.

The default implementation returns false to maintain current behavior.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/asm-generic/tlb.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 324a21f53b64..3f0add95604f 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -248,6 +248,21 @@ static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
 #define tlb_needs_table_invalidate() (true)
 #endif
 
+/*
+ * Architectures can override if their TLB flush already broadcasts IPIs to all
+ * CPUs when freeing or unsharing page tables.
+ *
+ * Return true only when the flush guarantees:
+ * - IPIs reach all CPUs with potentially stale paging-structure cache entries
+ * - Synchronization with IRQ-disabled code like GUP-fast
+ */
+#ifndef tlb_table_flush_implies_ipi_broadcast
+static inline bool tlb_table_flush_implies_ipi_broadcast(void)
+{
+	return false;
+}
+#endif
+
 void tlb_remove_table_sync_one(void);
 
 #else
@@ -829,12 +844,17 @@ static inline void tlb_flush_unshared_tables(struct mmu_gather *tlb)
 	 * We only perform this when we are the last sharer of a page table,
 	 * as the IPI will reach all CPUs: any GUP-fast.
 	 *
+	 * However, if the TLB flush already synchronized with other CPUs
+	 * (indicated by tlb_table_flush_implies_ipi_broadcast()), we can skip
+	 * the additional IPI.
+	 *
 	 * Note that on configs where tlb_remove_table_sync_one() is a NOP,
 	 * the expectation is that the tlb_flush_mmu_tlbonly() would have issued
 	 * required IPIs already for us.
 	 */
 	if (tlb->fully_unshared_tables) {
-		tlb_remove_table_sync_one();
+		if (!tlb_table_flush_implies_ipi_broadcast())
+			tlb_remove_table_sync_one();
 		tlb->fully_unshared_tables = false;
 	}
 }
-- 
2.49.0


