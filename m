Return-Path: <linux-arch+bounces-15582-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD938CE6FA9
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7EFB30084FC
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B994A23BD1A;
	Mon, 29 Dec 2025 14:13:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A717C211
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767017596; cv=none; b=pWqlKs0DgF+u4GKD+ihQk/nbGqTg9UxggJjqoqc3DQkJrvqyE/Ngff9UgkD4ushNwG4BqA9jepfL8BNdMlqap8UPeBrTCz5rTuOkmmSOZ6yaPJLs9UP08a2o2CZywKFt55NKE6U4cpgCCs/apvhYhs9sj/V8TBf6eP27CxxgeM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767017596; c=relaxed/simple;
	bh=lC6GEfxIGK/35lvrPF2qw5D86rHWEQ6C/lNcw05H+jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFqxjq8X1Ju4Ujq6U/OlFFLeLEOXV9Xw7+J/7sh1UfhJg7adxvajMwGMZihdyfwxwtfgjQQJg7Q3KrTzQHnUUJc0azt+JlqEQA3oZ9oD3RaDjQY5qtbiIMTgslJ5btol0gHt+3qgS3fed8zgm2x2su8MHeOQcFAmuYqsPKPZmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8035e31d834so6508589b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 06:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767017594; x=1767622394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foHDr6tTVVg2N+oq2ubI3TwM6NJy7Osy+6nFP/DCYQ8=;
        b=eVna3fCTS99oe7/mgJktWKo6ovJzh66mH/IqH2J2ei2LdR0SPMyB/QHr09gvSxHhJa
         qR2HBxXq/rPAAVINE8a0caY7298k2r60st/L3jlCqFR3dV+5FEDKSnu10k5Bj0ID8XhO
         /c+93p9NnB1V+BL9JZtehC1VAYvWTYoPcHTdSXM0v1c9wzHTVXF+agpBh4NRBLBZwr3F
         cJNMgbSLZGtcMMcWM4sVJbQepikfGzX/AWyTqOhH5e+FwkGAQNnva7x/aU9AKn4J4BWe
         DDzz/WFV+HDgb6ZHifMstgALwVDAtlA4YfieRsOxxuEUytrybgwMRVr1G8xOJ1W/j34M
         TelA==
X-Forwarded-Encrypted: i=1; AJvYcCXa+JAfkaizodLnxJyEmKz2HvDZCY2W81j+TueeLOj1km53FUhDF+Z0d5wY0H8YSolQ+mzrz+t6Pa1f@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDRKAEJOkzOf7go0qxnRB+IwipJiguzoEVdlTOvof0re7m2li
	ujKUkS/qhCdEApOIRvAw6LJCDfpebotUr0VMSqMmPtUjlNgmor4GfRMa
X-Gm-Gg: AY/fxX6+ygnzYNLb0rpD47TLLyKDgBPwud2tIZVGPRSEvH+RGnqVvQ3qZ8dLFdtZo3p
	ViFwQVhhnjQWOuCAxMVmbi3ClyCZ5GAE8AhrNIwDva4O9ekZJ/A682li6oOtqsbwRsacnZhBjL1
	BWF16lQFICVx5/8PGuyuxDgQ2Ei1oa0gIW2D+TmziWGhHNUFduxCnEx01zhWpyHF06vScG6n95M
	INspnd779FwpATaFPzqnroQekCPcNOe5OuOhX8Med0tjVnkOUvZqxjOlm+Mc0XRnFrKSQQgD6D+
	FlnfrAENfd608VoPvR91bSejEacwbEewQVLgoBiJPS7qZKIgex3FBWYvnNShyg2i+R1LNDbAsFH
	3wuWRRwnQF3R10dn8AWf1UvDVx/BRfLQfVEBE+UHNMugiQgk9Ro9MMlhDD0qv45vcrUg25/7tTH
	UXZlqoikV9hzdPehxE5PZ/
X-Google-Smtp-Source: AGHT+IHjQ5rl02KKPHQhO2WlxDrubU3tUX+Dp23WgXVCA057aOMTV2/+jAKILyQh7BNfdVe+rKUfAQ==
X-Received: by 2002:a05:6a21:328a:b0:366:14ac:e1dd with SMTP id adf61e73a8af0-376aaff9943mr29756512637.67.1767017594482;
        Mon, 29 Dec 2025 06:13:14 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93ab3csm29472636b3a.7.2025.12.29.06.13.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:13:14 -0800 (PST)
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
Subject: [PATCH v1 1/3] mm/tlb: allow architectures to skip redundant TLB sync IPIs
Date: Mon, 29 Dec 2025 22:12:43 +0800
Message-ID: <20251229141246.63435-2-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251229141246.63435-1-lance.yang@linux.dev>
References: <20251229141246.63435-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When unsharing hugetlb PMD page tables, we currently send two IPIs: one
for TLB invalidation, and another to synchronize with concurrent GUP-fast
walkers.

However, if the TLB flush already reaches all CPUs, the second IPI is
redundant. GUP-fast runs with IRQs disabled, so when the TLB flush IPI
completes, any concurrent GUP-fast must have finished.

Add tlb_table_flush_implies_ipi_broadcast() to let architectures indicate
their TLB flush provides full synchronization, enabling the redundant IPI
to be skipped.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/asm-generic/tlb.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 4d679d2a206b..e8d99b5e831f 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -261,6 +261,20 @@ static inline void tlb_remove_table_sync_one(void) { }
 
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
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
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 /*
-- 
2.49.0


