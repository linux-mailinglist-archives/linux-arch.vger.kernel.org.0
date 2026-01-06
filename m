Return-Path: <linux-arch+bounces-15668-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9900CF83C4
	for <lists+linux-arch@lfdr.de>; Tue, 06 Jan 2026 13:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A6A3045CCE
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jan 2026 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE62989B7;
	Tue,  6 Jan 2026 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gmzJ7PoB"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EBC1EA7DF
	for <linux-arch@vger.kernel.org>; Tue,  6 Jan 2026 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701005; cv=none; b=AwjbeoOlX2krmxdzndFmqKItb9NWTTSG8CyFdhNseIKCKR0ZZBXyswBKVw4J9a9Gh738s9BnAHpl7IsMewLRs3oglepcXsseY5Cq6KroTif5RnnXdtCd4oNF5t+vB2FqK4orPzfe4IGVjJNZpg2wLymtyaJKOUrJCWt89SPZDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701005; c=relaxed/simple;
	bh=BBmGgd1RvN2fwb6Tg+lSTw8Z9gqvzwSw5EWzn9VMiS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=It/zMI1JVolO6ze9SvLTiV+kY/EQS0BTgWDIvK/QTqOsn8JL8yZb5G+JOo7K2GIXHd4WQX4e/PVuF8+wFh0mJFBG/meSsBdSIodj8PITE4Bio6OjYFW6F2ti9K+1XghT0cdZ4+5ltUGb/LSzRl41TpOCplKBbqbIcprF3/2DVmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gmzJ7PoB; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767700999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCKTGrv+k6ub8F4AW6v/G5VPK3mcKpwM4TC/1V+pwcA=;
	b=gmzJ7PoBteJnyE2cnSIyZ9u0Lg8n89dvnpUQBvK7FYXl4yZkv7IUATWftbvnXb/42YW4Wm
	25xXex6uHm4NMeXeDSF84H7kxwP2B5toHfQPiHA6Ltiv0MMP3ROb+pBhRaF4aRpFu9/v4M
	g+6JjHl/eeWWGN+BjGU62qKI+EYgcck=
From: Lance Yang <lance.yang@linux.dev>
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
Subject: [PATCH RESEND v3 1/2] mm/tlb: skip redundant IPI when TLB flush already synchronized
Date: Tue,  6 Jan 2026 20:03:02 +0800
Message-ID: <20260106120303.38124-2-lance.yang@linux.dev>
In-Reply-To: <20260106120303.38124-1-lance.yang@linux.dev>
References: <20260106120303.38124-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Lance Yang <lance.yang@linux.dev>

When unsharing hugetlb PMD page tables, we currently send two IPIs: one
for TLB invalidation, and another to synchronize with concurrent GUP-fast
walkers via tlb_remove_table_sync_one().

However, if the TLB flush already sent IPIs to all CPUs (when freed_tables
or unshared_tables is true), the second IPI is redundant. GUP-fast runs
with IRQs disabled, so when the TLB flush IPI completes, any concurrent
GUP-fast must have finished.

To avoid the redundant IPI, we add a flag to mmu_gather to track whether
the TLB flush sent IPIs. We pass the mmu_gather pointer through the TLB
flush path via flush_tlb_info, so native_flush_tlb_multi() can set the
flag when it sends IPIs for freed_tables. We also set the flag for
local-only flushes, since disabling IRQs provides the same guarantee.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 arch/x86/include/asm/tlb.h      |  3 ++-
 arch/x86/include/asm/tlbflush.h |  9 +++++----
 arch/x86/kernel/alternative.c   |  2 +-
 arch/x86/kernel/ldt.c           |  2 +-
 arch/x86/mm/tlb.c               | 22 ++++++++++++++++------
 include/asm-generic/tlb.h       | 14 +++++++++-----
 mm/mmu_gather.c                 | 26 +++++++++++++++++++-------
 7 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 866ea78ba156..c5950a92058c 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -20,7 +20,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 		end = tlb->end;
 	}
 
-	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
+	flush_tlb_mm_range(tlb->mm, start, end, stride_shift,
+			   tlb->freed_tables || tlb->unshared_tables, tlb);
 }
 
 static inline void invlpg(unsigned long addr)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 00daedfefc1b..83c260c88b80 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -220,6 +220,7 @@ struct flush_tlb_info {
 	 *   will be zero.
 	 */
 	struct mm_struct	*mm;
+	struct mmu_gather	*tlb;
 	unsigned long		start;
 	unsigned long		end;
 	u64			new_tlb_gen;
@@ -305,23 +306,23 @@ static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
 #endif
 
 #define flush_tlb_mm(mm)						\
-		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
+		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true, NULL)
 
 #define flush_tlb_range(vma, start, end)				\
 	flush_tlb_mm_range((vma)->vm_mm, start, end,			\
 			   ((vma)->vm_flags & VM_HUGETLB)		\
 				? huge_page_shift(hstate_vma(vma))	\
-				: PAGE_SHIFT, true)
+				: PAGE_SHIFT, true, NULL)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
-				bool freed_tables);
+				bool freed_tables, struct mmu_gather *tlb);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 {
-	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
+	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false, NULL);
 }
 
 static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 28518371d8bf..006f3705b616 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2572,7 +2572,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	 */
 	flush_tlb_mm_range(text_poke_mm, text_poke_mm_addr, text_poke_mm_addr +
 			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
-			   PAGE_SHIFT, false);
+			   PAGE_SHIFT, false, NULL);
 
 	if (func == text_poke_memcpy) {
 		/*
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 0f19ef355f5f..d8494706fec5 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -374,7 +374,7 @@ static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
 	}
 
 	va = (unsigned long)ldt_slot_va(ldt->slot);
-	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, PAGE_SHIFT, false);
+	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, PAGE_SHIFT, false, NULL);
 }
 
 #else /* !CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f5b93e01e347..be45976c0d16 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1374,6 +1374,9 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	else
 		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
 				(void *)info, 1, cpumask);
+
+	if (info->freed_tables && info->tlb)
+		info->tlb->tlb_flush_sent_ipi = true;
 }
 
 void flush_tlb_multi(const struct cpumask *cpumask,
@@ -1403,7 +1406,7 @@ static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
 static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 			unsigned long start, unsigned long end,
 			unsigned int stride_shift, bool freed_tables,
-			u64 new_tlb_gen)
+			u64 new_tlb_gen, struct mmu_gather *tlb)
 {
 	struct flush_tlb_info *info = this_cpu_ptr(&flush_tlb_info);
 
@@ -1433,6 +1436,7 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	info->new_tlb_gen	= new_tlb_gen;
 	info->initiating_cpu	= smp_processor_id();
 	info->trim_cpumask	= 0;
+	info->tlb		= tlb;
 
 	return info;
 }
@@ -1447,8 +1451,8 @@ static void put_flush_tlb_info(void)
 }
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned int stride_shift,
-				bool freed_tables)
+			unsigned long end, unsigned int stride_shift,
+			bool freed_tables, struct mmu_gather *tlb)
 {
 	struct flush_tlb_info *info;
 	int cpu = get_cpu();
@@ -1458,7 +1462,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	new_tlb_gen = inc_mm_tlb_gen(mm);
 
 	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
-				  new_tlb_gen);
+				  new_tlb_gen, tlb);
 
 	/*
 	 * flush_tlb_multi() is not optimized for the common case in which only
@@ -1476,6 +1480,12 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 		local_irq_disable();
 		flush_tlb_func(info);
 		local_irq_enable();
+		/*
+		 * Only current CPU uses this mm, so we can treat this as
+		 * having synchronized with GUP-fast. No sync IPI needed.
+		 */
+		if (tlb && freed_tables)
+			tlb->tlb_flush_sent_ipi = true;
 	}
 
 	put_flush_tlb_info();
@@ -1553,7 +1563,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	guard(preempt)();
 
 	info = get_flush_tlb_info(NULL, start, end, PAGE_SHIFT, false,
-				  TLB_GENERATION_INVALID);
+				  TLB_GENERATION_INVALID, NULL);
 
 	if (info->end == TLB_FLUSH_ALL)
 		kernel_tlb_flush_all(info);
@@ -1733,7 +1743,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	int cpu = get_cpu();
 
 	info = get_flush_tlb_info(NULL, 0, TLB_FLUSH_ALL, 0, false,
-				  TLB_GENERATION_INVALID);
+				  TLB_GENERATION_INVALID, NULL);
 	/*
 	 * flush_tlb_multi() is not optimized for the common case in which only
 	 * a local TLB flush is needed. Optimize this use-case by calling
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 3975f7d11553..cbbe008590ee 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -249,6 +249,7 @@ static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
 #define tlb_needs_table_invalidate() (true)
 #endif
 
+void tlb_gather_remove_table_sync_one(struct mmu_gather *tlb);
 void tlb_remove_table_sync_one(void);
 
 #else
@@ -257,6 +258,7 @@ void tlb_remove_table_sync_one(void);
 #error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
 #endif
 
+static inline void tlb_gather_remove_table_sync_one(struct mmu_gather *tlb) { }
 static inline void tlb_remove_table_sync_one(void) { }
 
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
@@ -378,6 +380,12 @@ struct mmu_gather {
 	 */
 	unsigned int		fully_unshared_tables : 1;
 
+	/*
+	 * Did the TLB flush for freed/unshared tables send IPIs to all CPUs?
+	 * If true, we can skip the redundant IPI in tlb_remove_table_sync_one().
+	 */
+	unsigned int		tlb_flush_sent_ipi : 1;
+
 	unsigned int		batch_count;
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
@@ -833,13 +841,9 @@ static inline void tlb_flush_unshared_tables(struct mmu_gather *tlb)
 	 *
 	 * We only perform this when we are the last sharer of a page table,
 	 * as the IPI will reach all CPUs: any GUP-fast.
-	 *
-	 * Note that on configs where tlb_remove_table_sync_one() is a NOP,
-	 * the expectation is that the tlb_flush_mmu_tlbonly() would have issued
-	 * required IPIs already for us.
 	 */
 	if (tlb->fully_unshared_tables) {
-		tlb_remove_table_sync_one();
+		tlb_gather_remove_table_sync_one(tlb);
 		tlb->fully_unshared_tables = false;
 	}
 }
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 2faa23d7f8d4..da36de52b281 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -273,8 +273,14 @@ static void tlb_remove_table_smp_sync(void *arg)
 	/* Simply deliver the interrupt */
 }
 
-void tlb_remove_table_sync_one(void)
+void tlb_gather_remove_table_sync_one(struct mmu_gather *tlb)
 {
+	/* Skip the IPI if the TLB flush already synchronized with other CPUs */
+	if (tlb && tlb->tlb_flush_sent_ipi) {
+		tlb->tlb_flush_sent_ipi = false;
+		return;
+	}
+
 	/*
 	 * This isn't an RCU grace period and hence the page-tables cannot be
 	 * assumed to be actually RCU-freed.
@@ -285,6 +291,11 @@ void tlb_remove_table_sync_one(void)
 	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
 }
 
+void tlb_remove_table_sync_one(void)
+{
+	tlb_gather_remove_table_sync_one(NULL);
+}
+
 static void tlb_remove_table_rcu(struct rcu_head *head)
 {
 	__tlb_remove_table_free(container_of(head, struct mmu_table_batch, rcu));
@@ -328,7 +339,7 @@ static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
 	__tlb_remove_table(ptdesc);
 }
 
-static inline void __tlb_remove_table_one(void *table)
+static inline void __tlb_remove_table_one(void *table, struct mmu_gather *tlb)
 {
 	struct ptdesc *ptdesc;
 
@@ -336,16 +347,16 @@ static inline void __tlb_remove_table_one(void *table)
 	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
 }
 #else
-static inline void __tlb_remove_table_one(void *table)
+static inline void __tlb_remove_table_one(void *table, struct mmu_gather *tlb)
 {
-	tlb_remove_table_sync_one();
+	tlb_gather_remove_table_sync_one(tlb);
 	__tlb_remove_table(table);
 }
 #endif /* CONFIG_PT_RECLAIM */
 
-static void tlb_remove_table_one(void *table)
+static void tlb_remove_table_one(void *table, struct mmu_gather *tlb)
 {
-	__tlb_remove_table_one(table);
+	__tlb_remove_table_one(table, tlb);
 }
 
 static void tlb_table_flush(struct mmu_gather *tlb)
@@ -367,7 +378,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
 		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT);
 		if (*batch == NULL) {
 			tlb_table_invalidate(tlb);
-			tlb_remove_table_one(table);
+			tlb_remove_table_one(table, tlb);
 			return;
 		}
 		(*batch)->nr = 0;
@@ -427,6 +438,7 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	tlb->vma_pfn = 0;
 
 	tlb->fully_unshared_tables = 0;
+	tlb->tlb_flush_sent_ipi = 0;
 	__tlb_reset_range(tlb);
 	inc_tlb_flush_pending(tlb->mm);
 }
-- 
2.49.0


