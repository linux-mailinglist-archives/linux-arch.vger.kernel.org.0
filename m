Return-Path: <linux-arch+bounces-15591-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7873CE7225
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 315EB300163C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E4313261;
	Mon, 29 Dec 2025 14:54:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC230F94D
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767020088; cv=none; b=k9sQVeCskIO+1oL6rF7yoEHYa8/q5B8izdfDvDToT9PHfnQKrttcemAPZnfkJTcmLyi+ruct325MZwtHmV5tB3V4xE7xRJ72ouquU1lTmKAwe5tc4fBfXmS6jwqteDLojkHhd+0U78iinHAc82GQdd0Syzrot73g57vpHmO8dLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767020088; c=relaxed/simple;
	bh=lC6GEfxIGK/35lvrPF2qw5D86rHWEQ6C/lNcw05H+jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkd/3pQTWX/Jyu7oq9H+DcYp/eiqzMaCUs3+NP5uW07PBitC+8sCp5mRpxTRJPyhpMKpnunC8madfUX7qulfn5RjedBXHcSUQ/66DbbZ94INv8TjEgDvLMIJCTF51Ej+FGIAQuZrPTAsUBWqBgDZAO+lb1Gt0dDiXukjevxpHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so5594782b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 06:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767020087; x=1767624887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foHDr6tTVVg2N+oq2ubI3TwM6NJy7Osy+6nFP/DCYQ8=;
        b=bapywwJBheyKstDYqIW9ZV7WzvV2RIHqnbF9wJOOFbMv09mzXkh4M53H2DKkUvygMK
         ZAdWeMIUf+4PXN0aQ93hwpFjHQ77j3bxEh5FYgauW/OJXcgMoSxzMDKyYD3SYe+Bzj/G
         fhJ3Bkh62e8IdjxIC+3J/3RqlqrdbVI5ShdN/09m67s2XQ9plDE24t3Lreibs8dNolGu
         eNWoapFlagiElCCsNRtqcspZ1c50DYlK83L7MOHvYyL+5sf1LtKBmXOjklnW3O7ygbup
         zwelnBi4oTcWqyr8G3hooo0tGCCgUJ/EFE818QwSNC5BHKcNaFiEN2SJhXU/TKX7P+kn
         wzOA==
X-Forwarded-Encrypted: i=1; AJvYcCWpPTLsaop/n4fOhuIUyGFbpnxQPEEb8mnELt6qfCGsbUedU2+vmcdPkzTPFNSsCONuKcGGipqo7le9@vger.kernel.org
X-Gm-Message-State: AOJu0YxLoj6otEIJJrMLUoe1pmzG04w4BRGAHwf8S6SR6eERqwJXhJP/
	HZtczgjXkZC36Ge9hp1wURAWKzo59JY5XauSWNXbC2SzYZgSUJwZiNXz
X-Gm-Gg: AY/fxX5bDFVmvoMBwtJJqSVXhOAzhR5N4o2ev4Ql/xrakCsPYKcqnRyEOCL5B6swLLO
	0v0ra6WRQROCoKvPpM2En4K+1Y0pLoXhetzUlyy6SbK2EDghpFDaNg7isbf4coBaiscH4fulZkH
	ExDb2o7akR4oxpXxQmCIZdY6CB09LTv9XWkAwq4wYkGfd8QNKx3MDg5qogJz6Q6ECmhwjAm0yBH
	70KKS7Z8EMFMvIaHf7ptMNEC+wG8H73iYa4ym6NhPMwbQ4hMP965iwWl1oHDFad+TEZsZtfIffh
	TsM2xOCF3Th04k5sX11zkwkUDf+jov5gFwCm09fW/ZioQH7l+fmEnr0CBoU8yPzO4PKTlRKeng+
	qOIEVU/GLrj9usqvUlbtzmdfwBBfl1Rl+Um/ngHAisYkkk8Xr+ExrUvi2rMxXOw2gX6qbU4E97w
	OBPSaPy+FeHXeFyYq2gcFoBuYZADh5/bY=
X-Google-Smtp-Source: AGHT+IGKVZznmIqdsFJZx8tzz7DJSoz4ei3n/x9I/qNdC+q4k/iJfPtD5Rz6uSZJWfuK81E5v5oz3Q==
X-Received: by 2002:a05:6a21:6da6:b0:35b:9ba2:8cd5 with SMTP id adf61e73a8af0-376a9ccbb8emr26989418637.56.1767020086734;
        Mon, 29 Dec 2025 06:54:46 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbcb6esm31557603a91.9.2025.12.29.06.54.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:54:46 -0800 (PST)
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
Subject: [PATCH v2 1/3] mm/tlb: allow architectures to skip redundant TLB sync IPIs
Date: Mon, 29 Dec 2025 22:52:43 +0800
Message-ID: <20251229145245.85452-2-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251229145245.85452-1-lance.yang@linux.dev>
References: <20251229145245.85452-1-lance.yang@linux.dev>
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


