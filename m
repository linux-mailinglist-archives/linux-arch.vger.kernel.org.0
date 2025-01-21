Return-Path: <linux-arch+bounces-9844-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BDAA185FC
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 21:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC77162A48
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D511F470D;
	Tue, 21 Jan 2025 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sCq8l6Vl"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F151F7075
	for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2025 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737490194; cv=none; b=JRSnZiemY4Vdbv/8CwpWNp37aPYhWgskZbidZ1VBmfVpHkD40YVYYaRQQE46ToYjOIequvWkHHcMOdvqn6wxmQZen/eF/WW1fAtLlcQwa4Aj/pfCyFfeO/A0Iz7Ud38KeauavLQidS5VRCLqtKCRc1h3pHFOLZtFnTPpUU7RM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737490194; c=relaxed/simple;
	bh=fI17I6HuQGCEAlHpVmI6JQkePZVm+cAT2IugwsmNoM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZsr9zWlIfnco8bI30e8m+zQz6dK8kqbNx+11xUpveOrLfsOY4ctoewmiRZhRMnFybangdzRh1dItrdextR8AZpaQ6tdecjNGlq/WFk75XdHUe/RJ1xyTITc6IQc3PROZPMOO9W0CiKkHYkz12g3Hpkd3kXPUW7QA4lBo19cDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sCq8l6Vl; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737490180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7MsGtIYaWKOulbwuqadA1hPhFKScuzlkf6Zojvdyofw=;
	b=sCq8l6VlXiQ+Y9MvDQ05R6I1sl7MwDLsW1PD9fe5Ce5IQITIdW/tjnum91Sc0CC90YVzgx
	T5wrFIEFiywHonrhA82nF6Uro3G9+eEkylPuLA8yEWZp/oKvhevw1/aQ1xwor4viyzSV/W
	ofzOHQXA63oNzUfhj1vEBR/PzqOKl0Y=
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
Subject: [PATCH] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP vmas into free_pgtables()
Date: Tue, 21 Jan 2025 20:09:29 +0000
Message-ID: <20250121200929.188542-1-roman.gushchin@linux.dev>
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
 include/asm-generic/tlb.h | 16 ++++------------
 mm/memory.c               |  7 +++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 709830274b75..411daa96f57a 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -549,22 +549,14 @@ static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *
 
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
index 398c031be9ba..2071415f68dd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -365,6 +365,13 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 {
 	struct unlink_vma_file_batch vb;
 
+	/*
+	 * Ensure we have no stale TLB entries by the time this mapping is
+	 * removed from the rmap.
+	 */
+	if (tlb->vma_pfn && !tlb->fullmm)
+		tlb_flush_mmu(tlb);
+
 	do {
 		unsigned long addr = vma->vm_start;
 		struct vm_area_struct *next;
-- 
2.48.0.rc2.279.g1de40edade-goog


