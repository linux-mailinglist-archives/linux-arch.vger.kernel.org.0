Return-Path: <linux-arch+bounces-9926-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAFFA1DCF6
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 20:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA243A495F
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 19:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C291917D6;
	Mon, 27 Jan 2025 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NM7kH1sr"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E88190052
	for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2025 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738007617; cv=none; b=I4n9kHkai53VQDrmp6FaO+J2SlIkhVV2t5guWuiOIYchMd3Tk6jwSpUlqOl7xn6q7G3FqxNM/aTFdlMAXCdeNNpslo46ueW1SrAGzjckLu5sG6WZHFHcS37djxfhDRLqwl1OkiYYPYMYf0JWdh+Qo5SK6TzSnorJGsYAYywfGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738007617; c=relaxed/simple;
	bh=nqnISomD/j61bQat1/AeepObcUfncv3ETHk5z0QUqBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhKzFJyhy47/Ft67JWdZEtLwFidjjUFbpVLQ7TjIawBVA04tMwd3YrPW5J8KtL4rI00xkwdVwORVQfaSkbVBrKiA3FrUDySCeDm+XlMvUNdDwZjEndJXG5ayKxLtd//6jYKLe6QgI+j7xmrSw3BH23iGvOOdMWXvfKnrhAIMEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NM7kH1sr; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738007612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nnkGNTLvskPKX+krc93edAVPeknd45rshqikoa8lHn8=;
	b=NM7kH1srmRC0B+tepoX5im3jW2S5lwyzfg758+BMaz1YAFAkNNcYth3KzC8HKS4gkXvBie
	llSsflYW+S9Hhvdnag0ml7w2S30g63kqz4L7nUaVTgDbCFf2orRTm3vPMzSbL3TY6Cq12f
	g0AcwLNaxn6ME9Zo7kYZ+6sq+3HZArI=
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
Subject: [PATCH v4] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP vmas into free_pgtables()
Date: Mon, 27 Jan 2025 19:53:21 +0000
Message-ID: <20250127195321.35779-1-roman.gushchin@linux.dev>
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
index e402aef79c93..dd673ec59893 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -58,6 +58,11 @@
  *    Defaults to flushing at tlb_end_vma() to reset the range; helps when
  *    there's large holes between the VMAs.
  *
+ *  - tlb_free_vma()
+ *
+ *    tlb_free_vma() marks the start of unlinking the vma and freeing
+ *    page-tables.
+ *
  *  - tlb_remove_table()
  *
  *    tlb_remove_table() is the basic primitive to free page-table directories
@@ -400,7 +405,10 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 	 * Do not reset mmu_gather::vma_* fields here, we do not
 	 * call into tlb_start_vma() again to set them if there is an
 	 * intermediate flush.
+	 *
+	 * Except for vma_pfn, that only cares if there's pending TLBI.
 	 */
+	tlb->vma_pfn = 0;
 }
 
 #ifdef CONFIG_MMU_GATHER_NO_RANGE
@@ -465,7 +473,12 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
 	 */
 	tlb->vma_huge = is_vm_hugetlb_page(vma);
 	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
-	tlb->vma_pfn  = !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
+
+	/*
+	 * Track if there's at least one VM_PFNMAP/VM_MIXEDMAP vma
+	 * in the tracked range, see tlb_free_vma().
+	 */
+	tlb->vma_pfn |= !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
 }
 
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
@@ -564,23 +577,39 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
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
+static inline void tlb_free_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
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
+	if ((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) && tlb->vma_pfn)
 		tlb_flush_mmu_tlbonly(tlb);
-	}
 }
 
 /*
diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d54..4ea5e286c68f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -378,6 +378,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		if (unlikely(xa_is_zero(next)))
 			next = NULL;
 
+		tlb_free_vma(tlb, vma);
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
 		 * pgtables
@@ -403,6 +404,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 				next = mas_find(mas, ceiling - 1);
 				if (unlikely(xa_is_zero(next)))
 					next = NULL;
+				tlb_free_vma(tlb, vma);
 				if (mm_wr_locked)
 					vma_start_write(vma);
 				unlink_anon_vmas(vma);
-- 
2.48.1.262.g85cc9f2d1e-goog


