Return-Path: <linux-arch+bounces-15592-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BECE722E
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A27B30204A3
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D4632A3F9;
	Mon, 29 Dec 2025 14:55:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82D329E72
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767020100; cv=none; b=fUgLpkXINUh/rMs6F9xr00BxQQHYlbQSco0g8QGnCpAbCWY//t7wa0DFR/RjYm97Ce7NyLm6FX9HOKMXAx7eIQ8cyjkNDLdyPjJCieT50pPgSQH3subxVmZYXfrTBcK+EPcXUHnQrXRbF1uiI2JcG7bXo5ZLCdIsHMqSGxlN8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767020100; c=relaxed/simple;
	bh=m4iHj+AwFx2PCF5x5k1miVOJkb/O+RupWNG1Z8Fowrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZX4u28dTBhQe8K6l4tUk71/tkQDv9oR/6PtphjH8DwQmnd4J72+TnyZxH0LppeSXHxotfCxI/x4TNQ3cgGHaUWp1YfkrOF+Y1Z3RVP06S2LRp36OfIkSpXGsVs8YyA0+7BpWaOyqGJFJ96r1Yb01izEfPZ7JHV1kdIjO/J5cKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso10637990b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 06:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767020096; x=1767624896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZldRDJqtH1ig79a3NbAjYulmXt3x4GlRPqkLpWEwBdc=;
        b=GNwt56JkmD7LME74lnCr5HqZ1gS09RB52Qd/AGFY012eCIuG+FCrvZY4ant+MFIbp0
         jHROtZG9EMMm/2U/3eQFh42Z8U3+UKUT9hXbidW8Gth0GbaxsjgVCu701VAZZ14PO0h5
         wFlt/84zSbtMXA3xlMImI0uUTdr+l3zlFW1GCI91j5K/TKNM6rToJ8sQaz8uO3z/4bx6
         yD7SDKeosQGkPqPxSD83tQHlVAVtkii7SvrsgMQfM8w7GZzgth5frD07xiMknrkoVq+N
         u3VHjm7q87IvAg7VX+/hUgYA42VYejctwND3DCP9HO0hacXFbILmEEQGOyJc5nwybbad
         +A2A==
X-Forwarded-Encrypted: i=1; AJvYcCWzTRnX+kPZ/oqOrr4jxEF4w4CkswzLsr/F1K4diOmr61SPhA5njlYmHD5Q5zOtJzAqZYKHggF1Baxg@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfzULx11476IiyeFV4YGkN0i7+gQ7jEs9fIWr5O1cdr7NEQ9M
	PVOKPSqBCXE4MUXp+DQrwU0nuiXGWhqJdeG994t6SeV98w5QUv7CjViq
X-Gm-Gg: AY/fxX6BZTyhhfdWktoak9qcKrW5J8aYMEKrgylDpXqC4udArukwz9xxaYdYbuXtG3i
	FdsfsnnEDUCtkiwxT/AIr0o9F+sSuumn4p1GWekSWQISxcnc1AIdmISOEB/a29Y3R9i3HTKHt3C
	xmstIrfNA2JjlVpaaTiXPzc9fR9A3gvxtg+CS4FPRtBZVDNn5ZpXUIErq9hE5nYVm//Si0MKWPS
	JCqhZimM1OHD66YFgxtWAZ6v2dwXpZKxhUBZ0w6IYLOm9Fdj6q7u1qw6iyQ26oH0vCamP71uVCC
	lDfSaLFkkHXXvrwdQm9IZ/LxrkfCIzhEftVMLu8Rdw5UZe7nJ0UHkAyPjtxwIs5FePZ2m/PCEKj
	6O13ZMDADI4aBJlYBDzYFaDWzng10MfmC2tcOJlXtK/2Yy3H7wlEezWajf/PWAIeClAblCxxJr+
	RfKfuXaTK64h/xNj63BbD8
X-Google-Smtp-Source: AGHT+IEgAkno5Gh1oJSDww9XUzjPOXWz4twHLH5pNZW8aq25hrJps84zND6cTLDC5XmLsL+UKP9xOw==
X-Received: by 2002:a05:6a20:2588:b0:366:14af:9bbf with SMTP id adf61e73a8af0-376ab2e77c7mr30792916637.73.1767020095708;
        Mon, 29 Dec 2025 06:54:55 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbcb6esm31557603a91.9.2025.12.29.06.54.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:54:55 -0800 (PST)
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
Subject: [PATCH v2 2/3] x86/mm: implement redundant IPI elimination for page table operations
Date: Mon, 29 Dec 2025 22:52:44 +0800
Message-ID: <20251229145245.85452-3-lance.yang@linux.dev>
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

Add a callback function flush_tlb_multi_implies_ipi_broadcast to pv_mmu_ops
to explicitly track whether flush_tlb_multi IPIs provide sufficient
synchronization for GUP-fast when freeing or unsharing page tables.

Pass both freed_tables and unshared_tables to flush_tlb_mm_range() to
ensure lazy-TLB CPUs receive IPIs and flush their paging-structure caches:
	flush_tlb_mm_range(..., freed_tables || unshared_tables);

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 arch/x86/include/asm/paravirt_types.h |  6 ++++++
 arch/x86/include/asm/tlb.h            | 19 ++++++++++++++++++-
 arch/x86/kernel/paravirt.c            | 10 ++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 3502939415ad..a5bd0983da1f 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -133,6 +133,12 @@ struct pv_mmu_ops {
 	void (*flush_tlb_multi)(const struct cpumask *cpus,
 				const struct flush_tlb_info *info);
 
+	/*
+	 * Indicates whether flush_tlb_multi IPIs provide sufficient
+	 * synchronization for GUP-fast when freeing or unsharing page tables.
+	 */
+	bool (*flush_tlb_multi_implies_ipi_broadcast)(void);
+
 	/* Hook for intercepting the destruction of an mm_struct. */
 	void (*exit_mmap)(struct mm_struct *mm);
 	void (*notify_page_enc_status_changed)(unsigned long pfn, int npages, bool enc);
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 866ea78ba156..3a7cdfdcea8e 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -5,10 +5,26 @@
 #define tlb_flush tlb_flush
 static inline void tlb_flush(struct mmu_gather *tlb);
 
+#define tlb_table_flush_implies_ipi_broadcast tlb_table_flush_implies_ipi_broadcast
+static inline bool tlb_table_flush_implies_ipi_broadcast(void);
+
 #include <asm-generic/tlb.h>
 #include <linux/kernel.h>
 #include <vdso/bits.h>
 #include <vdso/page.h>
+#include <asm/paravirt.h>
+
+static inline bool tlb_table_flush_implies_ipi_broadcast(void)
+{
+#ifdef CONFIG_PARAVIRT
+	if (pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast)
+		return pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast();
+
+	return false;
+#else
+	return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
+#endif
+}
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
@@ -20,7 +36,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 		end = tlb->end;
 	}
 
-	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
+	flush_tlb_mm_range(tlb->mm, start, end, stride_shift,
+			   tlb->freed_tables || tlb->unshared_tables);
 }
 
 static inline void invlpg(unsigned long addr)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ab3e172dcc69..4eaa44800b39 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -60,6 +60,15 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
 
+static bool native_flush_tlb_multi_implies_ipi_broadcast(void)
+{
+	/* Paravirt may use hypercalls that don't send real IPIs. */
+	if (pv_ops.mmu.flush_tlb_multi != native_flush_tlb_multi)
+		return false;
+
+	return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
+}
+
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
@@ -173,6 +182,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
+	.mmu.flush_tlb_multi_implies_ipi_broadcast = native_flush_tlb_multi_implies_ipi_broadcast,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
-- 
2.49.0


