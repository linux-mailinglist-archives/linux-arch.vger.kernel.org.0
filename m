Return-Path: <linux-arch+bounces-9869-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE7A1A807
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 17:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FDE3A080E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50942135BB;
	Thu, 23 Jan 2025 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i34gYHvc"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789EF2135B7
	for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2025 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650670; cv=none; b=b+/2V4sQKobh+qu0e0AHK0sCuHyMlZth1QxiTBEBb7Ba+2A5Q0ZFjELprWKNurgusBsWlVlnl0dab2UM2zAUfmBTZBG4ZvKyg9nO4QICXylSRxUrWm9HxWEWX7ybWdy0cHDBHQqBETYOQhAw0/t9wZ4yOqFrO0Ww42eSi4BDeCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650670; c=relaxed/simple;
	bh=T8hxQcKaqI+1aW9/Hkx8SZIfVhHvplvsbDjKt6G3WrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3T8BqI0aX6/AkJrHH79vW0JsePWu4rWi3F0DT2xrXSiadHOmGyI7OdAQ347Q+1kpdQsqaLGQLBRiT61b1ClMRFrGMx1Az6oH1xz6AUqntuglCM9j9hGv7psTXakqTNzB655y11o5NcX4LevkMZM3fxcbEMQMVG/JPhxmhZfldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i34gYHvc; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737650651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tq6WrEXDOwQH8ujhQCQztubvc77Na0hjUaUvAtMBHDU=;
	b=i34gYHvc+biDzphvaZftqRCYQACwkL6IF7oZHQuPzSaq/zmgBKPPeVKIJHdPGBn7IGtgwO
	dVdPIOBZaMoEDLux6kZEK73MrKnOYbDawzd1gmY+SWuCC4dhwqtqP6B+MZhwos81k0RauF
	iGsNS2cR9sDVp6zWaE/ZwBGTx1LFN48=
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
Subject: [PATCH v3] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP vmas into free_pgtables()
Date: Thu, 23 Jan 2025 16:43:58 +0000
Message-ID: <20250123164358.2384447-1-roman.gushchin@linux.dev>
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

---

v3:
  - added initialization of vma_pfn in __tlb_reset_range() (by Hugh D.)

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
 include/asm-generic/tlb.h | 49 ++++++++++++++++++++++++++++-----------
 mm/memory.c               |  7 ++++++
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 709830274b75..cdc95b69b91d 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -380,8 +380,16 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 	tlb->cleared_pmds = 0;
 	tlb->cleared_puds = 0;
 	tlb->cleared_p4ds = 0;
+
+	/*
+	 * vma_pfn can only be set in tlb_start_vma(), so let's
+	 * initialize it here. Also a tlb flush issued by
+	 * tlb_flush_mmu_pfnmap() will cancel the vma_pfn state,
+	 * so that unnecessary subsequent flushes are avoided.
+	 */
+	tlb->vma_pfn = 0;
 	/*
-	 * Do not reset mmu_gather::vma_* fields here, we do not
+	 * Do not reset other mmu_gather::vma_* fields here, we do not
 	 * call into tlb_start_vma() again to set them if there is an
 	 * intermediate flush.
 	 */
@@ -449,7 +457,14 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
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
@@ -466,6 +481,20 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
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
+	if (unlikely(!tlb->fullmm && tlb->vma_pfn))
+		tlb_flush_mmu_tlbonly(tlb);
+}
+
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
@@ -549,22 +578,14 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
 
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


