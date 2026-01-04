Return-Path: <linux-arch+bounces-15649-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46241CF0BA3
	for <lists+linux-arch@lfdr.de>; Sun, 04 Jan 2026 08:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0D3C30052FC
	for <lists+linux-arch@lfdr.de>; Sun,  4 Jan 2026 07:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6912F6577;
	Sun,  4 Jan 2026 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QCqScVhr"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D42EB845
	for <linux-arch@vger.kernel.org>; Sun,  4 Jan 2026 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767512574; cv=none; b=dN4sM7UzM51p3YhpdJlDy/7qF8SciSd3vL+vQ8N+uNW6KslaLjOCapq/GrIdIIahgOzPpN+gC0Oer1IHZaYfX9TdqhhXna9ywwqskLGMrQHq40EkC3Frf3dka8m58UYWOorFOIox5g+w/+0jRN+K20lgdX4UaTyPhRDTYBuOzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767512574; c=relaxed/simple;
	bh=W3hZIMyMEhqTW2CRdR1k5wgkeeHUCBRQNN7/POqJ2Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffD0240O54bAfehvflFVsSvcC2fRRsiwWfGgCnQsRMSZm8a8AHQvdAgbsmfwef3MmTL3LDdpoEGCCXGjJV+CjaCNNYef0XTYBlC0HWrnfYac//29nNOWfWCaDCDOylC8z1mRNBdKbAC18awZwiYSzZ5jHIyY0LGgu3y6H6JMWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QCqScVhr; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <60b0c7e2-4a04-4542-a95a-00e88a0cf00d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767512559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utODjkP/wfu9AFNdk4nFLPGFEgiTAhS1Gz4GHQGUKAA=;
	b=QCqScVhrgbv5SSfcgpaI2NunlMJdPqLgarwTxYyVzkHckrKcQq7Edeokx/HaT2gBBYmftc
	2Wue/YNw+uJq7mdxzVL9JvISZejAFy2inQUDPfPIHjv5UPE6n1Xx5JIjwlcuyfcJLUgy57
	lrvLQW5Y9cBBrf1OnvIbrS9j3z400jY=
Date: Sun, 4 Jan 2026 15:42:23 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] skip redundant TLB sync IPIs
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org
References: <20251229145245.85452-1-lance.yang@linux.dev>
 <f81b98e5-87c0-4c21-9a75-ad5f9b6af6aa@intel.com>
 <1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org>
 <cea71c01-68e7-4f7f-9931-017109d95ef0@intel.com>
 <fc3c20a9-69a2-41eb-9f22-8df262717348@linux.dev>
 <f920487a-632c-407b-b092-7de87f66f4bb@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <f920487a-632c-407b-b092-7de87f66f4bb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/4 01:06, Dave Hansen wrote:
> On 1/3/26 00:39, Lance Yang wrote:
> ...
>> Maybe we could do that as a follow-up. I'd like to keep things simple
>> for now, so we just add a bool property to skip redundant TLB sync IPIs
>> on systems without INVLPGB support.
> 
> It's not just INVLPGB support. Take a look at hyperv_flush_tlb_multi(),
> for instance. It can eventually land back in native_flush_tlb_multi(),
> but would also "fail" the pv_ops check in all cases.

Thanks for pointing that out!

> 
> It's not that Hyper-V performance is super important, it just that the
> semantics of the chosen approach here are rather complicated.

Yep, got it ;)

> 
>> Then we could add the mm->context (or something similar) tracking later
>> to handle things more precisely.
>>
>> Anyway, I'm open to going straight to the mm->context approach as well
>> and happy to do that instead :D
> 
> I'd really like to see what an mm->context approach looks like before we
> go forward with what is being proposed here.

Actually, I went ahead and tried a simialr approach using tlb_gather to
track IPI sends dynamically/precisely.

Seems simpler than the mm->context approach because:

1) IIUC, mm->context tracking would need proper synchronization (CAS,
handling concurrent flushes, etc.) which adds more complexity :)

2) With tlb_gather we already have the right context at the right time -
we just pass the tlb pointer through flush_tlb_mm_range() and set a
flag when IPIs are actually sent.

The first one adds a tlb_flush_sent_ipi flag to mmu_gather and wires it
through flush_tlb_mm_range(). When we call flush_tlb_multi(), we set
the flag. Then tlb_gather_remove_table_sync_one() checks it and skips
the IPI if it's set.

---8<---
When unsharing hugetlb PMD page tables, we currently send two IPIs: one
for TLB invalidation, and another to synchronize with concurrent GUP-fast
walkers via tlb_remove_table_sync_one().

However, if the TLB flush already sent IPIs to all CPUs (when freed_tables
or unshared_tables is true), the second IPI is redundant. GUP-fast runs
with IRQs disabled, so when the TLB flush IPI completes, any concurrent
GUP-fast must have finished.

Add a tlb_flush_sent_ipi flag to struct mmu_gather to track whether IPIs
were actually sent.

Introduce tlb_gather_remove_table_sync_one() which checks
tlb_flush_sent_ipi and skips the IPI if redundant.

Suggested-by: David Hildenbrand <david@kernel.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
  arch/x86/include/asm/tlb.h      |  3 ++-
  arch/x86/include/asm/tlbflush.h |  8 ++++----
  arch/x86/kernel/alternative.c   |  2 +-
  arch/x86/kernel/ldt.c           |  2 +-
  arch/x86/mm/tlb.c               |  6 ++++--
  include/asm-generic/tlb.h       | 14 +++++++++-----
  mm/mmu_gather.c                 | 24 ++++++++++++++++++------
  7 files changed, 39 insertions(+), 20 deletions(-)

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
diff --git a/arch/x86/include/asm/tlbflush.h 
b/arch/x86/include/asm/tlbflush.h
index 00daedfefc1b..9524105659c3 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -305,23 +305,23 @@ static inline bool mm_in_asid_transition(struct 
mm_struct *mm) { return false; }
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
  extern void flush_tlb_kernel_range(unsigned long start, unsigned long 
end);

  static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned 
long a)
  {
-	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
+	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false, NULL);
  }

  static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 28518371d8bf..006f3705b616 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2572,7 +2572,7 @@ static void *__text_poke(text_poke_f func, void 
*addr, const void *src, size_t l
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
@@ -374,7 +374,7 @@ static void unmap_ldt_struct(struct mm_struct *mm, 
struct ldt_struct *ldt)
  	}

  	va = (unsigned long)ldt_slot_va(ldt->slot);
-	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, PAGE_SHIFT, false);
+	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, PAGE_SHIFT, 
false, NULL);
  }

  #else /* !CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f5b93e01e347..099f8d61be1a 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1447,8 +1447,8 @@ static void put_flush_tlb_info(void)
  }

  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned int stride_shift,
-				bool freed_tables)
+			unsigned long end, unsigned int stride_shift,
+			bool freed_tables, struct mmu_gather *tlb)
  {
  	struct flush_tlb_info *info;
  	int cpu = get_cpu();
@@ -1471,6 +1471,8 @@ void flush_tlb_mm_range(struct mm_struct *mm, 
unsigned long start,
  		info->trim_cpumask = should_trim_cpumask(mm);
  		flush_tlb_multi(mm_cpumask(mm), info);
  		consider_global_asid(mm);
+		if (tlb && freed_tables)
+			tlb->tlb_flush_sent_ipi = true;
  	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
  		lockdep_assert_irqs_enabled();
  		local_irq_disable();
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 4d679d2a206b..0ec35699da99 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -249,6 +249,7 @@ static inline void tlb_remove_table(struct 
mmu_gather *tlb, void *table)
  #define tlb_needs_table_invalidate() (true)
  #endif

+void tlb_gather_remove_table_sync_one(struct mmu_gather *tlb);
  void tlb_remove_table_sync_one(void);

  #else
@@ -257,6 +258,7 @@ void tlb_remove_table_sync_one(void);
  #error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
  #endif

+static inline void tlb_gather_remove_table_sync_one(struct mmu_gather 
*tlb) { }
  static inline void tlb_remove_table_sync_one(void) { }

  #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
@@ -379,6 +381,12 @@ struct mmu_gather {
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
@@ -834,13 +842,9 @@ static inline void tlb_flush_unshared_tables(struct 
mmu_gather *tlb)
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
index 7468ec388455..288c281b2ca4 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -274,8 +274,14 @@ static void tlb_remove_table_smp_sync(void *arg)
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
@@ -286,6 +292,11 @@ void tlb_remove_table_sync_one(void)
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
@@ -337,16 +348,16 @@ static inline void __tlb_remove_table_one(void *table)
  	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
  }
  #else
-static inline void __tlb_remove_table_one(void *table)
+static inline void __tlb_remove_table_one(void *table, struct 
mmu_gather *tlb)
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
@@ -368,7 +379,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void 
*table)
  		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT);
  		if (*batch == NULL) {
  			tlb_table_invalidate(tlb);
-			tlb_remove_table_one(table);
+			tlb_remove_table_one(table, tlb);
  			return;
  		}
  		(*batch)->nr = 0;
@@ -428,6 +439,7 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, 
struct mm_struct *mm,
  	tlb->vma_pfn = 0;

  	tlb->fully_unshared_tables = 0;
+	tlb->tlb_flush_sent_ipi = 0;
  	__tlb_reset_range(tlb);
  	inc_tlb_flush_pending(tlb->mm);
  }
---


The second one optimizes khugepaged by using mmu_gather to track IPI
sends. This makes the approach work across all paths ;)

---8<---
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

Suggested-by: David Hildenbrand <david@kernel.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
  include/linux/pgtable.h | 13 +++++++++----
  mm/khugepaged.c         |  9 +++------
  mm/pgtable-generic.c    | 34 ++++++++++++++++++++++++++++++++++
  3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index eb8aacba3698..b42758197d47 100644
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
@@ -1174,6 +1170,8 @@ static inline void pudp_set_wrprotect(struct 
mm_struct *mm,
  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
  extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
  				 unsigned long address, pmd_t *pmdp);
+extern pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma,
+				      unsigned long address, pmd_t *pmdp);
  #else
  static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
  					unsigned long address,
@@ -1182,6 +1180,13 @@ static inline pmd_t pmdp_collapse_flush(struct 
vm_area_struct *vma,
  	BUILD_BUG();
  	return *pmdp;
  }
+static inline pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma,
+					     unsigned long address,
+					     pmd_t *pmdp)
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
@@ -1177,10 +1177,9 @@ static enum scan_result collapse_huge_page(struct 
mm_struct *mm, unsigned long a
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
@@ -1663,8 +1662,7 @@ static enum scan_result 
try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
  			}
  		}
  	}
-	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
-	pmdp_get_lockless_sync();
+	pgt_pmd = pmdp_collapse_flush_sync(vma, haddr, pmd);
  	pte_unmap_unlock(start_pte, ptl);
  	if (ptl != pml)
  		spin_unlock(pml);
@@ -1817,8 +1815,7 @@ static void retract_page_tables(struct 
address_space *mapping, pgoff_t pgoff)
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
@@ -233,6 +233,40 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct 
*vma, unsigned long address,
  	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
  	return pmd;
  }
+
+pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma, unsigned 
long address,
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
+pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma, unsigned 
long address,
+			       pmd_t *pmdp)
+{
+	pmd_t pmd;
+
+	pmd = pmdp_collapse_flush(vma, address, pmdp);
+	tlb_remove_table_sync_one();
+	return pmd;
+}
  #endif

  /* arch define pte_free_defer in asm/pgalloc.h for its own 
implementation */
---

> 
> Is there some kind of hurry to get this done immediately?

No rush at all - just wanted to explore what works best and keep
things simpler as well ;)

What do you think?

