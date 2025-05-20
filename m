Return-Path: <linux-arch+bounces-12040-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E63ABE647
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 23:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CC24C136E
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 21:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51475136351;
	Tue, 20 May 2025 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AHflEly1"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094B182BC
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777833; cv=none; b=bl2fbPS35NrW/U9g+6AbuGeKNGba3u3WbS8hv0kXsvhWmZspsvAgAy2aO/cRBXgRoo6Eg8s0pAtxcqzPmyqAC+APVEiy7Hg+EJEHuEzQO5E//2bUuFRbKnkbZlipNErTzM01YNk9TrilRF7xDpJ8cRSjIqOVtPd59x4Q2OY8rvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777833; c=relaxed/simple;
	bh=E1i9fAUYuBEMsutoidvXvBRODjCHeqshmmDJiKpX3YI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXbJuYqTNKvX3o9kCPt8JJWYvVYGb2PctxwhiLl/6kKcM1dTn2rk3xjOfnWM9du/KijRSyF5r1/9EmOw8VEWR8cZD5SUg9neS0hFHhZhC229Zsa1IqWRD4UYq4q9lbNufuoBAt7bbuz+fD4eHL2Pv1bWxromARFkSvi4+l1nHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AHflEly1; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747777818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vhRek88RxGtXFL5GQiII5xcktGcNXGmD9RuiUnq2K54=;
	b=AHflEly14n0X34gfVPvWZPWcEPssOk7pSxD1eGi4aIIFMZ66LMqftlPyti+BMBaFBiI31C
	QL1kq3z9A5xbG3oJ0uZydTXV0Vj7HYI6GtQXTBQCIw3MVC0/eChQ5p+mfEUqMJHHIWuBmY
	2xXSkJaVDmkihKQTr5EkFwwsat/0ceE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jann Horn <jannh@google.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	linux-arch@vger.kernel.org
Subject: [PATCH v5] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP vmas into free_pgtables()
Date: Tue, 20 May 2025 21:48:13 +0000
Message-ID: <20250520214813.3946964-1-roman.gushchin@linux.dev>
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

Fix this by moving the tlb flush out of tlb_end_vma() into new
tlb_flush_vmas() called from free_pgtables(), somewhat similar to the
stable version of the original commit:
commit 895428ee124a ("mm: Force TLB flush for PFNMAP mappings before
unlink_file_vma()").

Note, that if tlb->fullmm is set, no flush is required, as the whole
mm is about to be destroyed.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org

---
v5:
  - tlb_free_vma() -> tlb_free_vmas() to avoid extra checks

v4:
  - naming/comments update (by Peter Z.)
  - check vma->vma->vm_flags in tlb_free_vma() (by Peter Z.)

v3:
  - added initialization of vma_pfn in __tlb_reset_range() (by Hugh D.)

v2:
  - moved vma_pfn flag handling into tlb.h (by Peter Z.)
  - added comments (by Peter Z.)
  - fixed the vma_pfn flag setting (by Hugh D.)
---
 include/asm-generic/tlb.h | 49 +++++++++++++++++++++++++++++++--------
 mm/memory.c               |  2 ++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 88a42973fa47..8a8b9535a930 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -58,6 +58,11 @@
  *    Defaults to flushing at tlb_end_vma() to reset the range; helps when
  *    there's large holes between the VMAs.
  *
+ *  - tlb_free_vmas()
+ *
+ *    tlb_free_vmas() marks the start of unlinking of one or more vmas
+ *    and freeing page-tables.
+ *
  *  - tlb_remove_table()
  *
  *    tlb_remove_table() is the basic primitive to free page-table directories
@@ -399,7 +404,10 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 	 * Do not reset mmu_gather::vma_* fields here, we do not
 	 * call into tlb_start_vma() again to set them if there is an
 	 * intermediate flush.
+	 *
+	 * Except for vma_pfn, that only cares if there's pending TLBI.
 	 */
+	tlb->vma_pfn = 0;
 }
 
 #ifdef CONFIG_MMU_GATHER_NO_RANGE
@@ -464,7 +472,12 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
 	 */
 	tlb->vma_huge = is_vm_hugetlb_page(vma);
 	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
-	tlb->vma_pfn  = !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
+
+	/*
+	 * Track if there's at least one VM_PFNMAP/VM_MIXEDMAP vma
+	 * in the tracked range, see tlb_free_vmas().
+	 */
+	tlb->vma_pfn |= !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
 }
 
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
@@ -547,23 +560,39 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
 }
 
 static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
+	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
+		return;
+
+	/*
+	 * Do a TLB flush and reset the range at VMA boundaries; this avoids
+	 * the ranges growing with the unused space between consecutive VMAs,
+	 * but also the mmu_gather::vma_* flags from tlb_start_vma() rely on
+	 * this.
+	 */
+	tlb_flush_mmu_tlbonly(tlb);
+}
+
+static inline void tlb_free_vmas(struct mmu_gather *tlb)
 {
 	if (tlb->fullmm)
 		return;
 
 	/*
 	 * VM_PFNMAP is more fragile because the core mm will not track the
-	 * page mapcount -- there might not be page-frames for these PFNs after
-	 * all. Force flush TLBs for such ranges to avoid munmap() vs
-	 * unmap_mapping_range() races.
+	 * page mapcount -- there might not be page-frames for these PFNs
+	 * after all.
+	 *
+	 * Specifically() there is a race between munmap() and
+	 * unmap_mapping_range(), where munmap() will unlink the VMA, such
+	 * that unmap_mapping_range() will no longer observe the VMA and
+	 * no-op, without observing the TLBI, returning prematurely.
+	 *
+	 * So if we're about to unlink such a VMA, and we have pending
+	 * TLBI for such a vma, flush things now.
 	 */
-	if (tlb->vma_pfn || !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
-		/*
-		 * Do a TLB flush and reset the range at VMA boundaries; this avoids
-		 * the ranges growing with the unused space between consecutive VMAs.
-		 */
+	if (tlb->vma_pfn)
 		tlb_flush_mmu_tlbonly(tlb);
-	}
 }
 
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 5cb48f262ab0..6b71a66cc4fe 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -358,6 +358,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 {
 	struct unlink_vma_file_batch vb;
 
+	tlb_free_vmas(tlb);
+
 	do {
 		unsigned long addr = vma->vm_start;
 		struct vm_area_struct *next;
-- 
2.49.0.1112.g889b7c5bd8-goog


