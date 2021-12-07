Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D790946BC05
	for <lists+linux-arch@lfdr.de>; Tue,  7 Dec 2021 13:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbhLGNC2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Dec 2021 08:02:28 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47234 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhLGNC1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Dec 2021 08:02:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 16EFBCE1AA3;
        Tue,  7 Dec 2021 12:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA28C341C1;
        Tue,  7 Dec 2021 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638881934;
        bh=7edXiZP4YnKaZZViRmxNtqDdLoJrIhDgeXSXZlVMBS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EC7N7/cebf0+K1HXhRp7WttVrlw+/Zmbtl9Z2jTvqd1BuXe+rnLrpca+1r2f5evtD
         cyW87T+KWjx+c489T7qk2/TRau/ELs9tdVVG5RNIcQNcd7yHBEQvpj8NpZzoXapCvX
         1yNSbOlzAtrygzMA8i8QJj0F+7+RmIIEuC/e4224k7PwMrGgc4gmX5GVX6oneEIqIV
         LvGTJiZmDZwwu2agY9D1LoAldrgV8+KteE7WTANhYCSUnggfYIs/eeB5gZjeihQgPc
         mLk4O531MEYJXH9FQA1w67d9j4ihc3+Vp7RpPvjCcAkxRgEwe5R/5o4NME4qhpQZs6
         4FQ6mY4Ph+63A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Yu Zhao <yuzhao@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/2] [BONUS PATCH] mm: move tlb_flush_pending inline helpers to mm_inline.h
Date:   Tue,  7 Dec 2021 13:55:44 +0100
Message-Id: <20211207125710.2503446-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211207125710.2503446-1-arnd@kernel.org>
References: <20211207125710.2503446-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

linux/mm_types.h should only define structure definitions, to make
it cheap to include elsewhere. The atomic_t helper function definitions
are particularly large, so it's better to move the helpers using those
into the existing linux/mm_inline.h and only include that where needed.

As a follow-up, we may want to go through all the indirect includes
in mm_types.h and reduce them as much as possible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Bonus patch: unlike the previous one, this does not fix an
urgent bug, but rather cleans up the code along the same lines,
preparing for possible follow-up patches
---
 arch/x86/include/asm/pgtable.h |   2 +-
 include/linux/mm.h             |  45 ------------
 include/linux/mm_inline.h      |  86 ++++++++++++++++++++++
 include/linux/mm_types.h       | 129 ++++++++++++---------------------
 mm/ksm.c                       |   1 +
 mm/mapping_dirty_helpers.c     |   1 +
 mm/memory.c                    |   1 +
 mm/mmu_gather.c                |   1 +
 mm/pgtable-generic.c           |   1 +
 9 files changed, 137 insertions(+), 130 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index ae34614b7e8d..d7d287ac1018 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -753,7 +753,7 @@ static inline bool pte_accessible(struct mm_struct *mm, pte_t a)
 		return true;
 
 	if ((pte_flags(a) & _PAGE_PROTNONE) &&
-			mm_tlb_flush_pending(mm))
+			atomic_read(&mm->tlb_flush_pending))
 		return true;
 
 	return false;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 389c44691da9..44d75a8d1b92 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -425,51 +425,6 @@ extern unsigned int kobjsize(const void *objp);
  */
 extern pgprot_t protection_map[16];
 
-/**
- * enum fault_flag - Fault flag definitions.
- * @FAULT_FLAG_WRITE: Fault was a write fault.
- * @FAULT_FLAG_MKWRITE: Fault was mkwrite of existing PTE.
- * @FAULT_FLAG_ALLOW_RETRY: Allow to retry the fault if blocked.
- * @FAULT_FLAG_RETRY_NOWAIT: Don't drop mmap_lock and wait when retrying.
- * @FAULT_FLAG_KILLABLE: The fault task is in SIGKILL killable region.
- * @FAULT_FLAG_TRIED: The fault has been tried once.
- * @FAULT_FLAG_USER: The fault originated in userspace.
- * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
- * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
- * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
- *
- * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
- * whether we would allow page faults to retry by specifying these two
- * fault flags correctly.  Currently there can be three legal combinations:
- *
- * (a) ALLOW_RETRY and !TRIED:  this means the page fault allows retry, and
- *                              this is the first try
- *
- * (b) ALLOW_RETRY and TRIED:   this means the page fault allows retry, and
- *                              we've already tried at least once
- *
- * (c) !ALLOW_RETRY and !TRIED: this means the page fault does not allow retry
- *
- * The unlisted combination (!ALLOW_RETRY && TRIED) is illegal and should never
- * be used.  Note that page faults can be allowed to retry for multiple times,
- * in which case we'll have an initial fault with flags (a) then later on
- * continuous faults with flags (b).  We should always try to detect pending
- * signals before a retry to make sure the continuous page faults can still be
- * interrupted if necessary.
- */
-enum fault_flag {
-	FAULT_FLAG_WRITE =		1 << 0,
-	FAULT_FLAG_MKWRITE =		1 << 1,
-	FAULT_FLAG_ALLOW_RETRY =	1 << 2,
-	FAULT_FLAG_RETRY_NOWAIT = 	1 << 3,
-	FAULT_FLAG_KILLABLE =		1 << 4,
-	FAULT_FLAG_TRIED = 		1 << 5,
-	FAULT_FLAG_USER =		1 << 6,
-	FAULT_FLAG_REMOTE =		1 << 7,
-	FAULT_FLAG_INSTRUCTION =	1 << 8,
-	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
-};
-
 /*
  * The default fault flags that should be used by most of the
  * arch-specific page fault handlers.
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 47d96d2647ca..b725839dfe71 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -2,6 +2,7 @@
 #ifndef LINUX_MM_INLINE_H
 #define LINUX_MM_INLINE_H
 
+#include <linux/atomic.h>
 #include <linux/huge_mm.h>
 #include <linux/swap.h>
 #include <linux/string.h>
@@ -185,4 +186,89 @@ static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
 }
 #endif  /* CONFIG_ANON_VMA_NAME */
 
+static inline void init_tlb_flush_pending(struct mm_struct *mm)
+{
+	atomic_set(&mm->tlb_flush_pending, 0);
+}
+
+static inline void inc_tlb_flush_pending(struct mm_struct *mm)
+{
+	atomic_inc(&mm->tlb_flush_pending);
+	/*
+	 * The only time this value is relevant is when there are indeed pages
+	 * to flush. And we'll only flush pages after changing them, which
+	 * requires the PTL.
+	 *
+	 * So the ordering here is:
+	 *
+	 *	atomic_inc(&mm->tlb_flush_pending);
+	 *	spin_lock(&ptl);
+	 *	...
+	 *	set_pte_at();
+	 *	spin_unlock(&ptl);
+	 *
+	 *				spin_lock(&ptl)
+	 *				mm_tlb_flush_pending();
+	 *				....
+	 *				spin_unlock(&ptl);
+	 *
+	 *	flush_tlb_range();
+	 *	atomic_dec(&mm->tlb_flush_pending);
+	 *
+	 * Where the increment if constrained by the PTL unlock, it thus
+	 * ensures that the increment is visible if the PTE modification is
+	 * visible. After all, if there is no PTE modification, nobody cares
+	 * about TLB flushes either.
+	 *
+	 * This very much relies on users (mm_tlb_flush_pending() and
+	 * mm_tlb_flush_nested()) only caring about _specific_ PTEs (and
+	 * therefore specific PTLs), because with SPLIT_PTE_PTLOCKS and RCpc
+	 * locks (PPC) the unlock of one doesn't order against the lock of
+	 * another PTL.
+	 *
+	 * The decrement is ordered by the flush_tlb_range(), such that
+	 * mm_tlb_flush_pending() will not return false unless all flushes have
+	 * completed.
+	 */
+}
+
+static inline void dec_tlb_flush_pending(struct mm_struct *mm)
+{
+	/*
+	 * See inc_tlb_flush_pending().
+	 *
+	 * This cannot be smp_mb__before_atomic() because smp_mb() simply does
+	 * not order against TLB invalidate completion, which is what we need.
+	 *
+	 * Therefore we must rely on tlb_flush_*() to guarantee order.
+	 */
+	atomic_dec(&mm->tlb_flush_pending);
+}
+
+static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
+{
+	/*
+	 * Must be called after having acquired the PTL; orders against that
+	 * PTLs release and therefore ensures that if we observe the modified
+	 * PTE we must also observe the increment from inc_tlb_flush_pending().
+	 *
+	 * That is, it only guarantees to return true if there is a flush
+	 * pending for _this_ PTL.
+	 */
+	return atomic_read(&mm->tlb_flush_pending);
+}
+
+static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
+{
+	/*
+	 * Similar to mm_tlb_flush_pending(), we must have acquired the PTL
+	 * for which there is a TLB flush pending in order to guarantee
+	 * we've seen both that PTE modification and the increment.
+	 *
+	 * (no requirement on actually still holding the PTL, that is irrelevant)
+	 */
+	return atomic_read(&mm->tlb_flush_pending) > 1;
+}
+
+
 #endif
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 555f51de1fe0..3764c1b51b02 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -692,90 +692,6 @@ extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
-static inline void init_tlb_flush_pending(struct mm_struct *mm)
-{
-	atomic_set(&mm->tlb_flush_pending, 0);
-}
-
-static inline void inc_tlb_flush_pending(struct mm_struct *mm)
-{
-	atomic_inc(&mm->tlb_flush_pending);
-	/*
-	 * The only time this value is relevant is when there are indeed pages
-	 * to flush. And we'll only flush pages after changing them, which
-	 * requires the PTL.
-	 *
-	 * So the ordering here is:
-	 *
-	 *	atomic_inc(&mm->tlb_flush_pending);
-	 *	spin_lock(&ptl);
-	 *	...
-	 *	set_pte_at();
-	 *	spin_unlock(&ptl);
-	 *
-	 *				spin_lock(&ptl)
-	 *				mm_tlb_flush_pending();
-	 *				....
-	 *				spin_unlock(&ptl);
-	 *
-	 *	flush_tlb_range();
-	 *	atomic_dec(&mm->tlb_flush_pending);
-	 *
-	 * Where the increment if constrained by the PTL unlock, it thus
-	 * ensures that the increment is visible if the PTE modification is
-	 * visible. After all, if there is no PTE modification, nobody cares
-	 * about TLB flushes either.
-	 *
-	 * This very much relies on users (mm_tlb_flush_pending() and
-	 * mm_tlb_flush_nested()) only caring about _specific_ PTEs (and
-	 * therefore specific PTLs), because with SPLIT_PTE_PTLOCKS and RCpc
-	 * locks (PPC) the unlock of one doesn't order against the lock of
-	 * another PTL.
-	 *
-	 * The decrement is ordered by the flush_tlb_range(), such that
-	 * mm_tlb_flush_pending() will not return false unless all flushes have
-	 * completed.
-	 */
-}
-
-static inline void dec_tlb_flush_pending(struct mm_struct *mm)
-{
-	/*
-	 * See inc_tlb_flush_pending().
-	 *
-	 * This cannot be smp_mb__before_atomic() because smp_mb() simply does
-	 * not order against TLB invalidate completion, which is what we need.
-	 *
-	 * Therefore we must rely on tlb_flush_*() to guarantee order.
-	 */
-	atomic_dec(&mm->tlb_flush_pending);
-}
-
-static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
-{
-	/*
-	 * Must be called after having acquired the PTL; orders against that
-	 * PTLs release and therefore ensures that if we observe the modified
-	 * PTE we must also observe the increment from inc_tlb_flush_pending().
-	 *
-	 * That is, it only guarantees to return true if there is a flush
-	 * pending for _this_ PTL.
-	 */
-	return atomic_read(&mm->tlb_flush_pending);
-}
-
-static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
-{
-	/*
-	 * Similar to mm_tlb_flush_pending(), we must have acquired the PTL
-	 * for which there is a TLB flush pending in order to guarantee
-	 * we've seen both that PTE modification and the increment.
-	 *
-	 * (no requirement on actually still holding the PTL, that is irrelevant)
-	 */
-	return atomic_read(&mm->tlb_flush_pending) > 1;
-}
-
 struct vm_fault;
 
 /**
@@ -890,4 +806,49 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;
 
+/**
+ * enum fault_flag - Fault flag definitions.
+ * @FAULT_FLAG_WRITE: Fault was a write fault.
+ * @FAULT_FLAG_MKWRITE: Fault was mkwrite of existing PTE.
+ * @FAULT_FLAG_ALLOW_RETRY: Allow to retry the fault if blocked.
+ * @FAULT_FLAG_RETRY_NOWAIT: Don't drop mmap_lock and wait when retrying.
+ * @FAULT_FLAG_KILLABLE: The fault task is in SIGKILL killable region.
+ * @FAULT_FLAG_TRIED: The fault has been tried once.
+ * @FAULT_FLAG_USER: The fault originated in userspace.
+ * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
+ * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
+ * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ *
+ * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
+ * whether we would allow page faults to retry by specifying these two
+ * fault flags correctly.  Currently there can be three legal combinations:
+ *
+ * (a) ALLOW_RETRY and !TRIED:  this means the page fault allows retry, and
+ *                              this is the first try
+ *
+ * (b) ALLOW_RETRY and TRIED:   this means the page fault allows retry, and
+ *                              we've already tried at least once
+ *
+ * (c) !ALLOW_RETRY and !TRIED: this means the page fault does not allow retry
+ *
+ * The unlisted combination (!ALLOW_RETRY && TRIED) is illegal and should never
+ * be used.  Note that page faults can be allowed to retry for multiple times,
+ * in which case we'll have an initial fault with flags (a) then later on
+ * continuous faults with flags (b).  We should always try to detect pending
+ * signals before a retry to make sure the continuous page faults can still be
+ * interrupted if necessary.
+ */
+enum fault_flag {
+	FAULT_FLAG_WRITE =		1 << 0,
+	FAULT_FLAG_MKWRITE =		1 << 1,
+	FAULT_FLAG_ALLOW_RETRY =	1 << 2,
+	FAULT_FLAG_RETRY_NOWAIT = 	1 << 3,
+	FAULT_FLAG_KILLABLE =		1 << 4,
+	FAULT_FLAG_TRIED = 		1 << 5,
+	FAULT_FLAG_USER =		1 << 6,
+	FAULT_FLAG_REMOTE =		1 << 7,
+	FAULT_FLAG_INSTRUCTION =	1 << 8,
+	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
+};
+
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/mm/ksm.c b/mm/ksm.c
index 4ce462dd31a4..c20bd4d9a0d9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -15,6 +15,7 @@
 
 #include <linux/errno.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/fs.h>
 #include <linux/mman.h>
 #include <linux/sched.h>
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index ea734f248fce..1b0ab8fcfd8b 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -3,6 +3,7 @@
 #include <linux/hugetlb.h>
 #include <linux/bitops.h>
 #include <linux/mmu_notifier.h>
+#include <linux/mm_inline.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
diff --git a/mm/memory.c b/mm/memory.c
index ced3274c3deb..674b3751965f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -41,6 +41,7 @@
 
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/numa_balancing.h>
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 1b9837419bf9..afb7185ffdc4 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/mmdebug.h>
 #include <linux/mm_types.h>
+#include <linux/mm_inline.h>
 #include <linux/pagemap.h>
 #include <linux/rcupdate.h>
 #include <linux/smp.h>
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 4e640baf9794..6523fda274e5 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -10,6 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/mm_inline.h>
 #include <asm/tlb.h>
 
 /*
-- 
2.29.2

