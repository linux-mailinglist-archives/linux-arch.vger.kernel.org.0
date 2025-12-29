Return-Path: <linux-arch+bounces-15583-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C181ECE6FAF
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5060300E3C6
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367CE23BD1A;
	Mon, 29 Dec 2025 14:13:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAB31A545
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767017606; cv=none; b=p0VMi4M66Gk2adQYXh1Jlxd3A5nWJEf28ZjwRlaUDiYbHO2lYjz0VEg1ZBSr3El+CuFD2LAZJqcTziepVP9Ynur875MYQ92sk9LM6g7xIosvx6zHGlAZPyElWrHobK3I5DElQ76Br39WhYbylAi/huazISJYPi1xJ+AnHNSUeUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767017606; c=relaxed/simple;
	bh=m4iHj+AwFx2PCF5x5k1miVOJkb/O+RupWNG1Z8Fowrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXAKotRkCh8+TnQYjiRcBAss88V1pN09sieoNpQ6r5+YTEdBYxpoNEbXxSdzvc+ILK5sgvN8q80EByBhj7Rh6SrCkLG0PdDT6z/lDT6/3Gh8ufe5BFsLriJitDd2WBLkkBxTamfzIdqQ7QgeVOAnueWaBqvknp4Zjm30vysyzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso12719618b3a.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 06:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767017603; x=1767622403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZldRDJqtH1ig79a3NbAjYulmXt3x4GlRPqkLpWEwBdc=;
        b=m5f42wyw9bZC5twoFOKYEoby4IaACIyGgurmUhBENa7ZsZS4oHw4N1jsrtvAUoxlH8
         zE5iH4AC9/XfIb609wix1KOwp569zVv+2vGHScT//yQpClZ4K0WMk31aKnFPRJ7TL1hF
         b0KsMOUh4LYk/SZrp4VBDCVur0UiuFY0wAvEw9X+5u8It9rUkLVqm8w9SkxAa0PPCpUW
         YcMHX8zdZIS0a9TNEXNpG/EBLQ/UAzrJfhBnYnlmaOuSlPispRNjkm+bLMQD+PyARdaE
         633GYFUwxDYGz9DyDUA3vWRjLmEkwVwDg8ugRrhHKkNDmhxiJlJDjLeVDwxuI0CpE1wX
         8FCw==
X-Forwarded-Encrypted: i=1; AJvYcCVPggSN0TWgdFOqknfxSq8OYdyfqhnxtjWT5IsoZNfSQpUEJrqNhL/oUQTdmsDPTEZwYMgBNXGIkjQ1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1bO9yZ6LYplBgAd+wvHe/TB9NMLswpSysQdZIjhvfGJVaDBIv
	lBCPCFJw4MVbGUkS82xdPK0PYYKL9oGmVY0oKtyeAHmlUN3PTELQro4b
X-Gm-Gg: AY/fxX6nU9r697tQC0GID/g1foW3rUqB811Rj8PxD6MVqhxqz/bzH6vgUn1zh5Kf9yD
	MarIcYbJdgr32sftB75hfTJCdia4fiwDNAwINGJbb3M7mgOKQGl87kHO8EZ0NOY5M9woAehjqnD
	3qJ3yfzwdw5awf81MGHC+orIK8PtVsoPgjOMv1FZFJ554m+eiR1mR5waLpZ9jaKikyS94FbihCD
	mWPWOmIAmugrxVTjUCbMtc1rLo+KAfCooHy0s3yrA3vawtBQPXdLbTtFiCbMAID9mGgQEUp8gND
	g8xCTQIg8Q3MWr0L/579jIYHyAnSb72U0VqJJzlRPTcOtP05Yc3LPZqSTC9IU23yWTRGHHk047f
	oYm4JUZNheCkrdEh0f3/J/IJ2P7FJs/iq6Xt90GulonB0FSzJflZHC1JtEjnxjClXjCtICutZ1H
	y5eNmZBfmJB/ocOffDXabb
X-Google-Smtp-Source: AGHT+IH9QXaO3feBvaLzy/ByuIkfJ3Ao5dwL4ovexpjF/alBrOC14CnwS3t1wGYhjPm1oFgU/egDBQ==
X-Received: by 2002:a05:6a00:8014:b0:7aa:e5f2:617d with SMTP id d2e1a72fcca58-7ff651c3519mr29469977b3a.30.1767017603556;
        Mon, 29 Dec 2025 06:13:23 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([103.88.46.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93ab3csm29472636b3a.7.2025.12.29.06.13.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 06:13:23 -0800 (PST)
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
Subject: [PATCH v1 2/3] x86/mm: implement redundant IPI elimination for page table operations
Date: Mon, 29 Dec 2025 22:12:44 +0800
Message-ID: <20251229141246.63435-3-lance.yang@linux.dev>
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


