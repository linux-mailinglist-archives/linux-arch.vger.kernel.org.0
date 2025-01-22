Return-Path: <linux-arch+bounces-9860-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C2EA19B74
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 00:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AFC188D7C9
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 23:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9601CB51B;
	Wed, 22 Jan 2025 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qduLD1F6"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AA1C3C1A
	for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2025 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737588454; cv=none; b=BxgwxDAGN/a4PK953FcItWXR064HP+dF8UAtsm2HPTWLDF/sTB24JzEBq5LNpJS+g81Fc4hllMLDEaO6cRci9HUP5/qzgMw4nHbO5HpfNMwz23LnBKm76eMHgxCybGMcs191cbTRQpNyn5gj+afgHai1FntdCBTEdwGWxlGHDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737588454; c=relaxed/simple;
	bh=b7PQasaRmXcllvPRUaQY3BCgOWjczHJg/yL1nYWgMRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnHI2cdt1Y65tsY57W5a1cP85lwlmVT3WfOVrutyfhSXfoPsZrcN79e7F3QP4jJh4zAB9c2mEs+/s6WAe5bCS3YJekwWhev/5y10xWNOr5KaSX0ucyg5l20U7+bU8Bp+ICAdChTPHnHi3OCfgpBfvu+mAX9BCb4Qlai0DBhoodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qduLD1F6; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737588443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/gVgCDajiZ5FVHubL9gu4gQZ78OrbIDAjdC1qsGbA80=;
	b=qduLD1F6WnVvqtatJhvmCJmkj/mC+ztYelFTH2KHW8h0JVkwzncD3WUcR5YeCmw9bEXgjt
	YEDtM9zHnABi1Ao/95Q2orkpTyhiDvC5J1j8MWIGBq2Ib4t7c7sIAtCGC7+1w/xN95UooT
	q5wx7vOfb1RU14RWBAPoloMznH/YUdw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	linux-arch@vger.kernel.org
Subject: [PATCH v2] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP vmas into free_pgtables()
Date: Wed, 22 Jan 2025 23:27:16 +0000
Message-ID: <20250122232716.1321171-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
added a forced tlbflush to tlb_vma_end(), which is required to avoid a
race between munmap() and unmap_mapping_range(). However it added some
overhead to other paths where tlb_vma_end() is used, but vmas are not
removed, e.g. madvise(MADV_DONTNEED).

Fix this by moving the tlb flush out of tlb_end_vma() into
free_pgtables(), somewhat similar to the stable version of the
original commit: e.g. stable commit 895428ee124a ("mm: Force TLB flush
for PFNMAP mappings before unlink_file_vma()").

Note, that if tlb->fullmm is set, no flush is required, as the whole
mm is about to be destroyed.

v2:
  - moved vma_pfn flag handling into tlb.h (by Peter Z.)
  - added comments (by Peter Z.)
  - fixed the vma_pfn flag setting (by Hugh D.)

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/asm-generic/tlb.h | 41 ++++++++++++++++++++++++++-------------
 mm/memory.c               |  7 +++++++
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 709830274b75..fbe31f49a5af 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -449,7 +449,14 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
 	 */
 	tlb->vma_huge = is_vm_hugetlb_page(vma);
 	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
-	tlb->vma_pfn  = !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
+
+	/*
+	 * vma_pfn is checked and cleared by tlb_flush_mmu_pfnmap()
+	 * for a set of vma's, so it should be set if at least one vma
+	 * has VM_PFNMAP or VM_MIXEDMAP flags set.
+	 */
+	if (vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))
+		tlb->vma_pfn = 1;
 }
 
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
@@ -466,6 +473,22 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 	__tlb_reset_range(tlb);
 }
 
+static inline void tlb_flush_mmu_pfnmap(struct mmu_gather *tlb)
+{
+	/*
+	 * VM_PFNMAP and VM_MIXEDMAP maps are fragile because the core mm
+	 * doesn't track the page mapcount -- there might not be page-frames
+	 * for these PFNs after all. Force flush TLBs for such ranges to avoid
+	 * munmap() vs unmap_mapping_range() races.
+	 * Ensure we have no stale TLB entries by the time this mapping is
+	 * removed from the rmap.
+	 */
+	if (unlikely(!tlb->fullmm && tlb->vma_pfn)) {
+		tlb_flush_mmu_tlbonly(tlb);
+		tlb->vma_pfn = 0;
+	}
+}
+
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
@@ -549,22 +572,14 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
 
 static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
-	if (tlb->fullmm)
+	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
 		return;
 
 	/*
-	 * VM_PFNMAP is more fragile because the core mm will not track the
-	 * page mapcount -- there might not be page-frames for these PFNs after
-	 * all. Force flush TLBs for such ranges to avoid munmap() vs
-	 * unmap_mapping_range() races.
+	 * Do a TLB flush and reset the range at VMA boundaries; this avoids
+	 * the ranges growing with the unused space between consecutive VMAs.
 	 */
-	if (tlb->vma_pfn || !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
-		/*
-		 * Do a TLB flush and reset the range at VMA boundaries; this avoids
-		 * the ranges growing with the unused space between consecutive VMAs.
-		 */
-		tlb_flush_mmu_tlbonly(tlb);
-	}
+	tlb_flush_mmu_tlbonly(tlb);
 }
 
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 398c031be9ba..c2a9effb2e32 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -365,6 +365,13 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 {
 	struct unlink_vma_file_batch vb;
 
+	/*
+	 * VM_PFNMAP and VM_MIXEDMAP maps require a special handling here:
+	 * force flush TLBs for such ranges to avoid munmap() vs
+	 * unmap_mapping_range() races.
+	 */
+	tlb_flush_mmu_pfnmap(tlb);
+
 	do {
 		unsigned long addr = vma->vm_start;
 		struct vm_area_struct *next;
-- 
2.48.1.262.g85cc9f2d1e-goog


