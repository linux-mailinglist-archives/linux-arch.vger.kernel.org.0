Return-Path: <linux-arch+bounces-12068-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C6DAC01B2
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 03:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A719E7224
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 01:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A3F17578;
	Thu, 22 May 2025 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YqTARfo3"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2E645
	for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747877342; cv=none; b=huFfTEmNJ8pkndglS0ODjOfXnWic2hElFmk9nM2uetTRuD8ytqwiPxlijGQ0J5syvfNvUIozfUsLKRckSEsFwyxOF/UJDFciRdrjQKnkLrqdfSAfzWqJ2Jha7E4L5Bqx3J/CGaZzHmBCNW3Xq6jbi4n2jykE2HgLcgzjdxtsyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747877342; c=relaxed/simple;
	bh=imufN9xZhtXz5BEkylFw+Rj7idOriYXjL1qHylVxlTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iThOVsWQqEM4p72yqYYNNZQEDzEFpd3k26QBIHDLhLo2rdrl8OL+ZUm3Fes07TxmR3x7DyflWPKd1cxGVwhYZXQMELVWYOrcWf3C8Txkz3q2m3K2fxMUb4dPR8YTo3FkIm3HKPyij4wS5445Eyd/DzDZ1DwJ6SgAskyILyC90P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YqTARfo3; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747877327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k5XWaFEkTOmEzG0hG+Uc4qKwCkxPwVc1cGNHMvpif1U=;
	b=YqTARfo3/oqTAY31J5B2Cv3iCO+b08LJyT1b5RtzYXL07w4I6mSk26ExR4D1s91dzOAJRV
	TLfB8vjHtu8WhKVLZu/SqbU6JRCL5jvvLr2d6iVVX5183qmZefE33xijIXsJ3/Kq/Z9kkq
	EhudGNICNWwkgr7Hp+Wla/yc6eno8HM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jann Horn <jannh@google.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH v6] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP vmas into free_pgtables()
Date: Thu, 22 May 2025 01:28:38 +0000
Message-ID: <20250522012838.163876-1-roman.gushchin@linux.dev>
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
v6:
  - tlb->vma_pfn is initialized in __tlb_gather_mmu() and
  is never cleared (by Jann H)

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
 include/asm-generic/tlb.h | 46 ++++++++++++++++++++++++++++++---------
 mm/memory.c               |  2 ++
 mm/mmu_gather.c           |  1 +
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 88a42973fa47..1fff717cae51 100644
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
@@ -464,7 +469,12 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
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
@@ -547,23 +557,39 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
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
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index db7ba4a725d6..b49cc6385f1f 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -424,6 +424,7 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	tlb->page_size = 0;
 #endif
+	tlb->vma_pfn = 0;
 
 	__tlb_reset_range(tlb);
 	inc_tlb_flush_pending(tlb->mm);
-- 
2.49.0.1143.g0be31eac6b-goog


