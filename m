Return-Path: <linux-arch+bounces-15586-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F083BCE7108
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E01ED3016DE2
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2DB32AAC5;
	Mon, 29 Dec 2025 14:31:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E83232AACF
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018674; cv=none; b=iO3I0/byvlGbyVvrntWPrc12G5P58oVDa68kQPZXZEt/Qde0+uv/Tr86gmJoawD6g26PiCIGs3vlKTL3+hCSLYhijBRVVw7a1SSe6ms1Y2akvuh1gTSFAX+uCVmLDCUZjh2YMBWASX2fc1nfxU+IY6CTsASyFYmzlVUv1hAC5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018674; c=relaxed/simple;
	bh=m4iHj+AwFx2PCF5x5k1miVOJkb/O+RupWNG1Z8Fowrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oc2onb2rQtkmuUrpITJ5g4uu7ZSUD7iXBLouB2f/PSG0ZUeW9fyryJskbnTpQTpcZ0rDFYBPbxvozkMjY9Nr03nHgMZyQhmAy3nnMa66XcOgP0Y8MKGhgXiFsqMzOw0GWejrooQujOqqJhnXx0Advi82eXDuhN9PGogtTdHrjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso12739824b3a.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 06:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767018672; x=1767623472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZldRDJqtH1ig79a3NbAjYulmXt3x4GlRPqkLpWEwBdc=;
        b=pJXecG8zibIXO5DPEQZoi8JmNV2m6/jEY4PQy4lCg7AgipMWqCJuzU5gvgRGnPsCVT
         daTAfTTgq6c0YhN6K2YpS7PtDMnK7vUVdV/D8zPYr4spFdZge/kKoQoJ5hWGde5htpSl
         KCTswrxpIuSmTOOmShF3flXcZPQ83L90nDic8SfcbW6l79LvNbYIJCES55WcpDkp+wQ6
         2BdINpI7VmSIReg/64fH505lYglf2PlO1VIoDpvWazaf+jkm59a/M9yDA+aTqHPl79hf
         EuF6yatIanFIEarECTB9i/WprbaJM+rihG3jyyO5sDya2LtDd01TItDyu/eYWwsZYFp/
         LM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcXYHHppetAS+JdsGDol+qLdoSCWrzonmDmxjDB/0eRnxkuWg8YbUZaIKZmk93NGKrnJ0qNKA3sk54@vger.kernel.org
X-Gm-Message-State: AOJu0YzBT7ndgY9OX67p+ZWB7Jz2DrpKWwLY37NEkIFkpZvCkls/W8/f
	40eVlzf01nkrN2GmtyDTnb5EZVpxVePPiCmu32GUH9/OgZ462MGUxPMO
X-Gm-Gg: AY/fxX4eVes10YWG35X92H9G4vslHjyj17a9DVQ6RkuLHMHNE1pjFpgQgPe/ib8o1dw
	Wt78UbLQPytjz+d5uCPzdlug5TFiVjLBcDpjfM2SclNtDDj97WhC2ms/9tsfzyP170LQG1PsVnS
	I0G0u1KaZAgDLwisKdr/WJnswmNGf00Gxz9xwXXj2RTHl38eCWCk8Qvjbyse7/g1FeFOD+dYdoJ
	93SVz8cbD+TqtPIqWoe9P3GlWo0bgCxlvWKnEgbLZeoqpXEdWrlMzHlUpoD8kxj1RKR3nfg4dPz
	j63cDNiYMEzUkPkj3hXFRowkhbLaJhlQpY3GOqRH3tlBAnaBXL2O7CdcRmJYzQonKbBU0Q/9d76
	uJl3jY5n9Dtyk5IfSf5w+BU49cuaefnAsmnrJqOif2BHAUFoHIMXsa+i5lM6nNEI38YfYM6CcnJ
	xY9Uav3xNg71Hds4qHnP+d
X-Google-Smtp-Source: AGHT+IFcZGgxztN2EeAun4quNpAXXOKNWX6LSnFOxrijtlTfhRDRGQK0tPKQ/9UZzDdFUSs+EvX5Jw==
X-Received: by 2002:aa7:9a85:0:b0:7f7:5d81:172b with SMTP id d2e1a72fcca58-7ff664807a0mr29842840b3a.42.1767018672206;
        Mon, 29 Dec 2025 06:31:12 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm29705159b3a.32.2025.12.29.06.31.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:31:11 -0800 (PST)
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
Subject: [PATCH RESEND v1 2/3] x86/mm: implement redundant IPI elimination for page table operations
Date: Mon, 29 Dec 2025 22:30:32 +0800
Message-ID: <20251229143038.73315-3-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251229143038.73315-1-lance.yang@linux.dev>
References: <20251229143038.73315-1-lance.yang@linux.dev>
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


