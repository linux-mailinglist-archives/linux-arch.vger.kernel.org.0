Return-Path: <linux-arch+bounces-15666-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B862CF827A
	for <lists+linux-arch@lfdr.de>; Tue, 06 Jan 2026 12:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09B363010528
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jan 2026 11:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985112EFD86;
	Tue,  6 Jan 2026 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RJK4rD9u"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A461322522
	for <linux-arch@vger.kernel.org>; Tue,  6 Jan 2026 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700322; cv=none; b=hYPP5K2d32wyiwBBqUBxkL8cLrS57A7/CpKByC9QO0kQfpO65XOe7pQFQFboLJG0ddCjVAfm/137Ji7/XLh6oF8KDn3AB2Sa8WZkyuvDYxX4Jm6N1WzKU8SvEMKYoq74lusffI9XNRCgmpWjUonwYTNT4Raa7d+ScALEgs8HXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700322; c=relaxed/simple;
	bh=3uE50zhBe9gc4nNAS8O0zcghuzH8rnTg7HpDCKyu5I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyoULiplg6JNRsh6D1L2yv4cxd8nry+jQtGg0LZg0kcup1cz6SPmmI1/zE2amxkqhn1la/uLsC5powXlB7EmCO2gtnCgjU4FNMoXzjmmMb34VNGIGogK5BaIDF0bWk3IGGsklzhEBfi4xS5NSehsBWc9erxa793bOJnfNEg1BBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RJK4rD9u; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767700318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASH9sKA9CqH12pO8t+a39xF1o8l7wjDesRLJzYo7jDg=;
	b=RJK4rD9unB904yjqG7YtH7GMUxlSQosNsESRT1mysjrtG6iWRY3XfoCtx7wfDR1mUmSENh
	K+7ytPQIYIEbfTgBvfJkgXXfFELO3BA5ZjkqVX7i7ZOvSqJwQPquL2YZYJTGL8V/otYdqC
	m1zIidafAOa/1RV1YpAD9A5g+Pv1s04=
From: lance.yang@linux.dev
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shy828301@gmail.com,
	riel@surriel.com,
	jannh@google.com,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ioworker0@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v3 2/2] mm: introduce pmdp_collapse_flush_sync() to skip redundant IPI
Date: Tue,  6 Jan 2026 19:50:53 +0800
Message-ID: <20260106115053.32328-3-lance.yang@linux.dev>
In-Reply-To: <20260106115053.32328-1-lance.yang@linux.dev>
References: <20260106115053.32328-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Lance Yang <lance.yang@linux.dev>

pmdp_collapse_flush() may already send IPIs to flush TLBs, and then
callers send another IPI via tlb_remove_table_sync_one() or
pmdp_get_lockless_sync() to synchronize with concurrent GUP-fast walkers.

However, since GUP-fast runs with IRQs disabled, the TLB flush IPI already
provides the necessary synchronization. We can avoid the redundant second
IPI.

Introduce pmdp_collapse_flush_sync() which combines flush and sync:

- For architectures using the generic pmdp_collapse_flush() implementation
  (e.g., x86): Use mmu_gather to track IPI sends. If the TLB flush sent
  an IPI, tlb_gather_remove_table_sync_one() will skip the redundant one.

- For architectures with custom pmdp_collapse_flush() (s390, riscv,
  powerpc): Fall back to calling pmdp_collapse_flush() followed by
  tlb_remove_table_sync_one(). No behavior change.

Update khugepaged to use pmdp_collapse_flush_sync() instead of separate
flush and sync calls. Remove the now-unused pmdp_get_lockless_sync() macro.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/linux/pgtable.h | 13 +++++++++----
 mm/khugepaged.c         |  9 +++------
 mm/pgtable-generic.c    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index eb8aacba3698..69e290dab450 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -755,7 +755,6 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
 	return pmd;
 }
 #define pmdp_get_lockless pmdp_get_lockless
-#define pmdp_get_lockless_sync() tlb_remove_table_sync_one()
 #endif /* CONFIG_PGTABLE_LEVELS > 2 */
 #endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */
 
@@ -774,9 +773,6 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
 {
 	return pmdp_get(pmdp);
 }
-static inline void pmdp_get_lockless_sync(void)
-{
-}
 #endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -1174,6 +1170,8 @@ static inline void pudp_set_wrprotect(struct mm_struct *mm,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp);
+extern pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma,
+				 unsigned long address, pmd_t *pmdp);
 #else
 static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 					unsigned long address,
@@ -1182,6 +1180,13 @@ static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 	BUILD_BUG();
 	return *pmdp;
 }
+static inline pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma,
+					unsigned long address,
+					pmd_t *pmdp)
+{
+	BUILD_BUG();
+	return *pmdp;
+}
 #define pmdp_collapse_flush pmdp_collapse_flush
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 9f790ec34400..0a98afc85c50 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1177,10 +1177,9 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 	 * Parallel GUP-fast is fine since GUP-fast will back off when
 	 * it detects PMD is changed.
 	 */
-	_pmd = pmdp_collapse_flush(vma, address, pmd);
+	_pmd = pmdp_collapse_flush_sync(vma, address, pmd);
 	spin_unlock(pmd_ptl);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_remove_table_sync_one();
 
 	pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
 	if (pte) {
@@ -1663,8 +1662,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 			}
 		}
 	}
-	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
-	pmdp_get_lockless_sync();
+	pgt_pmd = pmdp_collapse_flush_sync(vma, haddr, pmd);
 	pte_unmap_unlock(start_pte, ptl);
 	if (ptl != pml)
 		spin_unlock(pml);
@@ -1817,8 +1815,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * races against the prior checks.
 		 */
 		if (likely(file_backed_vma_is_retractable(vma))) {
-			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
-			pmdp_get_lockless_sync();
+			pgt_pmd = pmdp_collapse_flush_sync(vma, addr, pmd);
 			success = true;
 		}
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index d3aec7a9926a..be2ee82e6fc4 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -233,6 +233,40 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
 }
+
+pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma, unsigned long address,
+			       pmd_t *pmdp)
+{
+	struct mmu_gather tlb;
+	pmd_t pmd;
+
+	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
+	VM_BUG_ON(pmd_trans_huge(*pmdp));
+
+	tlb_gather_mmu(&tlb, vma->vm_mm);
+	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
+
+	flush_tlb_mm_range(vma->vm_mm, address, address + HPAGE_PMD_SIZE,
+			   PAGE_SHIFT, true, &tlb);
+
+	/*
+	 * Synchronize with GUP-fast. If the flush sent IPIs, skip the
+	 * redundant sync IPI.
+	 */
+	tlb_gather_remove_table_sync_one(&tlb);
+	tlb_finish_mmu(&tlb);
+	return pmd;
+}
+#else
+pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma, unsigned long address,
+			       pmd_t *pmdp)
+{
+	pmd_t pmd;
+
+	pmd = pmdp_collapse_flush(vma, address, pmdp);
+	tlb_remove_table_sync_one();
+	return pmd;
+}
 #endif
 
 /* arch define pte_free_defer in asm/pgalloc.h for its own implementation */
-- 
2.49.0


