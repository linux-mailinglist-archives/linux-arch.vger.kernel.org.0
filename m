Return-Path: <linux-arch+bounces-15288-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33651CA967E
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 22:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 404E1317A4B1
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 21:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6312673A5;
	Fri,  5 Dec 2025 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4U5cxOU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB823D7C7;
	Fri,  5 Dec 2025 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764970590; cv=none; b=gVj0ywlVWsyAj+vqTIUrAloBU0fhYnAzI9WnpfciN/EZut3Cv/lXWoRb6985NF5V1ttcP30Qfk4VhPG2o0ry+FFXdhJLegq2uOJKyP9siLhWmYlOxrXSW88pk5iUIM7HZ0fuFcPJOJIrHwBSLVfqACd9yDYXW0zNhceOna0ITj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764970590; c=relaxed/simple;
	bh=kNgfCu8DScARte7pqgVTzHHA5wMU8hbyWYtIYZls45Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWs9GAuug5C39e6ReopDMsAiXP1MVXzNz4dXwpeNQ6wEDt6csnpPYOn3UcvtuSr1mWuKFZxr7Tei8jfRH+9cIACtulss7bmmO2Whp0TaIVOyuVMkrKNg8dieZHtzRagrcThR/3BG1qQQcaEH3yNrfyz8s/sjZNTrnRNMDN2r2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4U5cxOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1343C116B1;
	Fri,  5 Dec 2025 21:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764970590;
	bh=kNgfCu8DScARte7pqgVTzHHA5wMU8hbyWYtIYZls45Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4U5cxOU1e65Sz7qWx0+ylexVYCF9cVToplA0MB60stGmd21ZZCTl9AT2/0JbmRVB
	 Ly6bO9W3/P9IyYmUTHfIaYvAaYurSdYLnoQBElcF1n0J2ofd9lcgKXv4P0nj1zE4JS
	 PKsd2HkI9kLatNRLsojUGYW52/cUJhf1525ybitnsqSahVDaO49gk5g9DvV6bAGP/k
	 U9x0mqJPYBZeolUkURZed5r55s3i3s3fT7FCcWegNJbWoXlUStQP7Aa2fue/CCvkHa
	 UjgasrJTB8mf/Rc7r8Szrb6cMw3HxV77LAXIl0PjKFWKOWQvCwWvDOu2daIzf8hgw4
	 cxw0IYb6XegFw==
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Laurence Oberman <loberman@redhat.com>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 4/4] mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather
Date: Fri,  5 Dec 2025 22:35:58 +0100
Message-ID: <20251205213558.2980480-5-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251205213558.2980480-1-david@kernel.org>
References: <20251205213558.2980480-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported, ever since commit 1013af4f585f ("mm/hugetlb: fix
huge_pmd_unshare() vs GUP-fast race") we can end up in some situations
where we perform so many IPI broadcasts when unsharing hugetlb PMD page
tables that it severely regresses some workloads.

In particular, when we fork()+exit(), or when we munmap() a large
area backed by many shared PMD tables, we perform one IPI broadcast per
unshared PMD table.

There are two optimizations to be had:

(1) When we process (unshare) multiple such PMD tables, such as during
    exit(), it is sufficient to send a single IPI broadcast (as long as
    we respect locking rules) instead of one per PMD table.

    Locking prevents that any of these PMD tables could get reuse before
    we drop the lock.

(2) When we are not the last sharer (> 2 users including us), there is
    no need to send the IPI broadcast. The shared PMD tables cannot
    become exclusive (fully unshared) before an IPI will be broadcasted
    by the last sharer.

    Concurrent GUP-fast could walk into a PMD table just before we
    unshared it. It could then succeed in grabbing a page from the
    shared page table even after munmap() etc succeeded (and supressed
    an IPI). But there is not difference compared to GUP-fast just
    sleeping for a while after grabbing the page and re-enabling IRQs.

    Most importantly, GUP-fast will never walk into page tables that are
    no-longer shared, because the last sharer will issue an IPI
    broadcast.

    (if ever required, checking whether the PUD changed in GUP-fast
     after grabbing the page like we do in the PTE case could handle
     this)

So let's rework PMD sharing TLB flushing + IPI sync to use the mmu_gather
infrastructure so we can implement these optimizations and demystify the
code at least a bit. Extend the mmu_gather infrastructure to be able to
deal with our special hugetlb PMD table sharing implementation.

We'll consolidate the handling for (full) unsharing of PMD tables in
tlb_unshare_pmd_ptdesc() and tlb_flush_unshared_tables(), and track
in "struct mmu_gather" whether we had (full) unsharing of PMD tables.

Because locking is very special (concurrent unsharing+reuse must be
prevented), we disallow deferring flushing to tlb_finish_mmu() and instead
require an explicit earlier call to tlb_flush_unshared_tables().

From hugetlb code, we call huge_pmd_unshare_flush() where we make sure
that the expected lock protecting us from concurrent unsharing+reuse is
still held.

Check with a VM_WARN_ON_ONCE() in tlb_finish_mmu() that
tlb_flush_unshared_tables() was properly called earlier.

Document it all properly.

Notes about tlb_remove_table_sync_one() interaction with unsharing:

There are two fairly tricky things:

(1) tlb_remove_table_sync_one() is a NOP on architectures without
    CONFIG_MMU_GATHER_RCU_TABLE_FREE.

    Here, the assumption is that the previous TLB flush would send an
    IPI to all relevant CPUs. Careful: some architectures like x86 only
    send IPIs to all relevant CPUs when tlb->freed_tables is set.

    The relevant architectures should be selecting
    MMU_GATHER_RCU_TABLE_FREE, but x86 might not do that in stable
    kernels and it might have been problematic before this patch.

    Also, the arch flushing behavior (independent of IPIs) is different
    when tlb->freed_tables is set. Do we have to enlighten them to also
    take care of tlb->unshared_tables? So far we didn't care, so
    hopefully we are fine. Of course, we could be setting
    tlb->freed_tables as well, but that might then unnecessarily flush
    too much, because the semantics of tlb->freed_tables are a bit
    fuzzy.

    This patch changes nothing in this regard.

(2) tlb_remove_table_sync_one() is not a NOP on architectures with
    CONFIG_MMU_GATHER_RCU_TABLE_FREE that actually don't need a sync.

    Take x86 as an example: in the common case (!pv, !X86_FEATURE_INVLPGB)
    we still issue IPIs during TLB flushes and don't actually need the
    second tlb_remove_table_sync_one().

    This optimized can be implemented on top of this, by checking e.g., in
    tlb_remove_table_sync_one() whether we really need IPIs. But as
    described in (1), it really must honor tlb->freed_tables then to
    send IPIs to all relevant CPUs.

Further note that the ptdesc_pmd_pts_dec() in huge_pmd_share() is not a
concern, as we are holding the i_mmap_lock the whole time, preventing
concurrent unsharing. That ptdesc_pmd_pts_dec() usage will be removed
separately as a cleanup later.

There are plenty more cleanups to be had, but they have to wait until
this is fixed.

Fixes: 1013af4f585f ("mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race")
Reported-by: Uschakow, Stanislav" <suschako@amazon.de>
Closes: https://lore.kernel.org/all/4d3878531c76479d9f8ca9789dc6485d@amazon.de/
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 include/asm-generic/tlb.h |  69 +++++++++++++++++++++-
 include/linux/hugetlb.h   |  19 +++---
 mm/hugetlb.c              | 121 ++++++++++++++++++++++----------------
 mm/mmu_gather.c           |   6 ++
 mm/mprotect.c             |   2 +-
 mm/rmap.c                 |  25 +++++---
 6 files changed, 173 insertions(+), 69 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 1fff717cae510..324a21f53b644 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -364,6 +364,17 @@ struct mmu_gather {
 	unsigned int		vma_huge : 1;
 	unsigned int		vma_pfn  : 1;
 
+	/*
+	 * Did we unshare (unmap) any shared page tables?
+	 */
+	unsigned int		unshared_tables : 1;
+
+	/*
+	 * Did we unshare any page tables such that they are now exclusive
+	 * and could get reused+modified by the new owner?
+	 */
+	unsigned int		fully_unshared_tables : 1;
+
 	unsigned int		batch_count;
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
@@ -400,6 +411,7 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 	tlb->cleared_pmds = 0;
 	tlb->cleared_puds = 0;
 	tlb->cleared_p4ds = 0;
+	tlb->unshared_tables = 0;
 	/*
 	 * Do not reset mmu_gather::vma_* fields here, we do not
 	 * call into tlb_start_vma() again to set them if there is an
@@ -484,7 +496,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 	 * these bits.
 	 */
 	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
-	      tlb->cleared_puds || tlb->cleared_p4ds))
+	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->unshared_tables))
 		return;
 
 	tlb_flush(tlb);
@@ -773,6 +785,61 @@ static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
 }
 #endif
 
+#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
+static inline void tlb_unshare_pmd_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt,
+					  unsigned long addr)
+{
+	/*
+	 * The caller must make sure that concurrent unsharing + exclusive
+	 * reuse is impossible until tlb_flush_unshared_tables() was called.
+	 */
+	VM_WARN_ON_ONCE(!ptdesc_pmd_is_shared(pt));
+	ptdesc_pmd_pts_dec(pt);
+
+	/* Clearing a PUD pointing at a PMD table with PMD leaves. */
+	tlb_flush_pmd_range(tlb, addr & PUD_MASK, PUD_SIZE);
+
+	/*
+	 * If the page table is now exclusively owned, we fully unshared
+	 * a page table.
+	 */
+	if (!ptdesc_pmd_is_shared(pt))
+		tlb->fully_unshared_tables = true;
+	tlb->unshared_tables = true;
+}
+
+static inline void tlb_flush_unshared_tables(struct mmu_gather *tlb)
+{
+	/*
+	 * As soon as the caller drops locks to allow for reuse of
+	 * previously-shared tables, these tables could get modified and
+	 * even reused outside of hugetlb context. So flush the TLB now.
+	 *
+	 * Note that we cannot defer the flush to a later point even if we are
+	 * not the last sharer of the page table.
+	 */
+	if (tlb->unshared_tables)
+		tlb_flush_mmu_tlbonly(tlb);
+
+	/*
+	 * Similarly, we must make sure that concurrent GUP-fast will not
+	 * walk previously-shared page tables that are getting modified+reused
+	 * elsewhere. So broadcast an IPI to wait for any concurrent GUP-fast.
+	 *
+	 * We only perform this when we are the last sharer of a page table,
+	 * as the IPI will reach all CPUs: any GUP-fast.
+	 *
+	 * Note that on configs where tlb_remove_table_sync_one() is a NOP,
+	 * the expectation is that the tlb_flush_mmu_tlbonly() would have issued
+	 * required IPIs already for us.
+	 */
+	if (tlb->fully_unshared_tables) {
+		tlb_remove_table_sync_one();
+		tlb->fully_unshared_tables = false;
+	}
+}
+#endif /* CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
+
 #endif /* CONFIG_MMU */
 
 #endif /* _ASM_GENERIC__TLB_H */
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 03c8725efa289..63b248c6bfd47 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -240,8 +240,9 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 unsigned long hugetlb_mask_last_page(struct hstate *h);
-int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
-				unsigned long addr, pte_t *ptep);
+int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep);
+void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
 
@@ -271,7 +272,7 @@ void hugetlb_vma_unlock_write(struct vm_area_struct *vma);
 int hugetlb_vma_trylock_write(struct vm_area_struct *vma);
 void hugetlb_vma_assert_locked(struct vm_area_struct *vma);
 void hugetlb_vma_lock_release(struct kref *kref);
-long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
@@ -300,13 +301,17 @@ static inline struct address_space *hugetlb_folio_mapping_lock_write(
 	return NULL;
 }
 
-static inline int huge_pmd_unshare(struct mm_struct *mm,
-					struct vm_area_struct *vma,
-					unsigned long addr, pte_t *ptep)
+static inline int huge_pmd_unshare(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	return 0;
 }
 
+static inline void huge_pmd_unshare_flush(struct mmu_gather *tlb,
+		struct vm_area_struct *vma)
+{
+}
+
 static inline void adjust_range_if_pmd_sharing_possible(
 				struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end)
@@ -432,7 +437,7 @@ static inline void move_hugetlb_state(struct folio *old_folio,
 {
 }
 
-static inline long hugetlb_change_protection(
+static inline long hugetlb_change_protection(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned long end, pgprot_t newprot,
 			unsigned long cp_flags)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3c77cdef12a32..3db94693a06fc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5096,8 +5096,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	unsigned long last_addr_mask;
 	pte_t *src_pte, *dst_pte;
 	struct mmu_notifier_range range;
-	bool shared_pmd = false;
+	struct mmu_gather tlb;
 
+	tlb_gather_mmu(&tlb, vma->vm_mm);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, old_addr,
 				old_end);
 	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
@@ -5122,12 +5123,12 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 		if (huge_pte_none(huge_ptep_get(mm, old_addr, src_pte)))
 			continue;
 
-		if (huge_pmd_unshare(mm, vma, old_addr, src_pte)) {
-			shared_pmd = true;
+		if (huge_pmd_unshare(&tlb, vma, old_addr, src_pte)) {
 			old_addr |= last_addr_mask;
 			new_addr |= last_addr_mask;
 			continue;
 		}
+		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
 
 		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
 		if (!dst_pte)
@@ -5136,13 +5137,13 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte, sz);
 	}
 
-	if (shared_pmd)
-		flush_hugetlb_tlb_range(vma, range.start, range.end);
-	else
-		flush_hugetlb_tlb_range(vma, old_end - len, old_end);
+	tlb_flush_mmu_tlbonly(&tlb);
+	huge_pmd_unshare_flush(&tlb, vma);
+
 	mmu_notifier_invalidate_range_end(&range);
 	i_mmap_unlock_write(mapping);
 	hugetlb_vma_unlock_write(vma);
+	tlb_finish_mmu(&tlb);
 
 	return len + old_addr - old_end;
 }
@@ -5161,7 +5162,6 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	unsigned long sz = huge_page_size(h);
 	bool adjust_reservation;
 	unsigned long last_addr_mask;
-	bool force_flush = false;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(start & ~huge_page_mask(h));
@@ -5184,10 +5184,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		}
 
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, address, ptep)) {
+		if (huge_pmd_unshare(tlb, vma, address, ptep)) {
 			spin_unlock(ptl);
-			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
-			force_flush = true;
 			address |= last_addr_mask;
 			continue;
 		}
@@ -5303,14 +5301,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 	tlb_end_vma(tlb, vma);
 
-	/*
-	 * There is nothing protecting a previously-shared page table that we
-	 * unshared through huge_pmd_unshare() from getting freed after we
-	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
-	 * succeeded, flush the range corresponding to the pud.
-	 */
-	if (force_flush)
-		tlb_flush_mmu_tlbonly(tlb);
+	huge_pmd_unshare_flush(tlb, vma);
 }
 
 void __hugetlb_zap_begin(struct vm_area_struct *vma,
@@ -6399,7 +6390,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 }
 #endif /* CONFIG_USERFAULTFD */
 
-long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		unsigned long address, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
@@ -6409,7 +6400,6 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
 	long pages = 0, psize = huge_page_size(h);
-	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -6452,7 +6442,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			}
 		}
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, address, ptep)) {
+		if (huge_pmd_unshare(tlb, vma, address, ptep)) {
 			/*
 			 * When uffd-wp is enabled on the vma, unshare
 			 * shouldn't happen at all.  Warn about it if it
@@ -6461,7 +6451,6 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
 			pages++;
 			spin_unlock(ptl);
-			shared_pmd = true;
 			address |= last_addr_mask;
 			continue;
 		}
@@ -6522,22 +6511,16 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
+			tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		}
 
 next:
 		spin_unlock(ptl);
 		cond_resched();
 	}
-	/*
-	 * There is nothing protecting a previously-shared page table that we
-	 * unshared through huge_pmd_unshare() from getting freed after we
-	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
-	 * succeeded, flush the range corresponding to the pud.
-	 */
-	if (shared_pmd)
-		flush_hugetlb_tlb_range(vma, range.start, range.end);
-	else
-		flush_hugetlb_tlb_range(vma, start, end);
+
+	tlb_flush_mmu_tlbonly(tlb);
+	huge_pmd_unshare_flush(tlb, vma);
 	/*
 	 * No need to call mmu_notifier_arch_invalidate_secondary_tlbs() we are
 	 * downgrading page table protection not changing it to point to a new
@@ -6904,18 +6887,27 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	return pte;
 }
 
-/*
- * unmap huge page backed by shared pte.
+/**
+ * huge_pmd_unshare - Unmap a pmd table if it is shared by multiple users
+ * @tlb: the current mmu_gather.
+ * @vma: the vma covering the pmd table.
+ * @addr: the address we are trying to unshare.
+ * @ptep: pointer into the (pmd) page table.
+ *
+ * Called with the page table lock held, the i_mmap_rwsem held in write mode
+ * and the hugetlb vma lock held in write mode.
  *
- * Called with page table lock held.
+ * Note: The caller must call huge_pmd_unshare_flush() before dropping the
+ * i_mmap_rwsem.
  *
- * returns: 1 successfully unmapped a shared pte page
- *	    0 the underlying pte page is not shared, or it is the last user
+ * Returns: 1 if it was a shared PMD table and it got unmapped, or 0 if it
+ *	    was not a shared PMD table.
  */
-int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
-					unsigned long addr, pte_t *ptep)
+int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep)
 {
 	unsigned long sz = huge_page_size(hstate_vma(vma));
+	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd = pgd_offset(mm, addr);
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	pud_t *pud = pud_offset(p4d, addr);
@@ -6927,18 +6919,36 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
 	hugetlb_vma_assert_locked(vma);
 	pud_clear(pud);
-	/*
-	 * Once our caller drops the rmap lock, some other process might be
-	 * using this page table as a normal, non-hugetlb page table.
-	 * Wait for pending gup_fast() in other threads to finish before letting
-	 * that happen.
-	 */
-	tlb_remove_table_sync_one();
-	ptdesc_pmd_pts_dec(virt_to_ptdesc(ptep));
+
+	tlb_unshare_pmd_ptdesc(tlb, virt_to_ptdesc(ptep), addr);
+
 	mm_dec_nr_pmds(mm);
 	return 1;
 }
 
+/*
+ * huge_pmd_unshare_flush - Complete a sequence of huge_pmd_unshare() calls
+ * @tlb: the current mmu_gather.
+ * @vma: the vma covering the pmd table.
+ *
+ * Perform necessary TLB flushes or IPI broadcasts to synchronize PMD table
+ * unsharing with concurrent page table walkers (TLB, GUP-fast, etc.).
+ *
+ * This function must be called after a sequence of huge_pmd_unshare()
+ * calls while still holding the i_mmap_rwsem.
+ */
+void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
+	/*
+	 * We must synchronize page table unsharing such that nobody will
+	 * try reusing a previously-shared page table while it might still
+	 * be in use by previous sharers (TLB, GUP_fast).
+	 */
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+
+	tlb_flush_unshared_tables(tlb);
+}
+
 #else /* !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
 
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -6947,12 +6957,16 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	return NULL;
 }
 
-int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
-				unsigned long addr, pte_t *ptep)
+int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep)
 {
 	return 0;
 }
 
+void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
+}
+
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end)
 {
@@ -7219,6 +7233,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 	unsigned long sz = huge_page_size(h);
 	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_notifier_range range;
+	struct mmu_gather tlb;
 	unsigned long address;
 	spinlock_t *ptl;
 	pte_t *ptep;
@@ -7229,6 +7244,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 	if (start >= end)
 		return;
 
+	tlb_gather_mmu(&tlb, mm);
 	flush_cache_range(vma, start, end);
 	/*
 	 * No need to call adjust_range_if_pmd_sharing_possible(), because
@@ -7248,10 +7264,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
-		huge_pmd_unshare(mm, vma, address, ptep);
+		huge_pmd_unshare(&tlb, vma, address, ptep);
 		spin_unlock(ptl);
 	}
-	flush_hugetlb_tlb_range(vma, start, end);
+	huge_pmd_unshare_flush(&tlb, vma);
 	if (take_locks) {
 		i_mmap_unlock_write(vma->vm_file->f_mapping);
 		hugetlb_vma_unlock_write(vma);
@@ -7261,6 +7277,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 	 * Documentation/mm/mmu_notifier.rst.
 	 */
 	mmu_notifier_invalidate_range_end(&range);
+	tlb_finish_mmu(&tlb);
 }
 
 /*
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 247e3f9db6c7a..822a790127375 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -468,6 +468,12 @@ void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm)
  */
 void tlb_finish_mmu(struct mmu_gather *tlb)
 {
+	/*
+	 * We expect an earlier huge_pmd_unshare_flush() call to sort this out,
+	 * due to complicated locking requirements with page table unsharing.
+	 */
+	VM_WARN_ON_ONCE(tlb->fully_unshared_tables);
+
 	/*
 	 * If there are parallel threads are doing PTE changes on same range
 	 * under non-exclusive lock (e.g., mmap_lock read-side) but defer TLB
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 283889e4f1cec..5c330e817129e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -652,7 +652,7 @@ long change_protection(struct mmu_gather *tlb,
 #endif
 
 	if (is_vm_hugetlb_page(vma))
-		pages = hugetlb_change_protection(vma, start, end, newprot,
+		pages = hugetlb_change_protection(tlb, vma, start, end, newprot,
 						  cp_flags);
 	else
 		pages = change_protection_range(tlb, vma, start, end, newprot,
diff --git a/mm/rmap.c b/mm/rmap.c
index 748f48727a162..d6799afe11147 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -76,7 +76,7 @@
 #include <linux/mm_inline.h>
 #include <linux/oom.h>
 
-#include <asm/tlbflush.h>
+#include <asm/tlb.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/migrate.h>
@@ -2008,13 +2008,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * if unsuccessful.
 			 */
 			if (!anon) {
+				struct mmu_gather tlb;
+
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
 				if (!hugetlb_vma_trylock_write(vma))
 					goto walk_abort;
-				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
+
+				tlb_gather_mmu(&tlb, mm);
+				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
 					hugetlb_vma_unlock_write(vma);
-					flush_tlb_range(vma,
-						range.start, range.end);
+					huge_pmd_unshare_flush(&tlb, vma);
+					tlb_finish_mmu(&tlb);
 					/*
 					 * The PMD table was unmapped,
 					 * consequently unmapping the folio.
@@ -2022,6 +2026,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					goto walk_done;
 				}
 				hugetlb_vma_unlock_write(vma);
+				tlb_finish_mmu(&tlb);
 			}
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 			if (pte_dirty(pteval))
@@ -2398,17 +2403,20 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * fail if unsuccessful.
 			 */
 			if (!anon) {
+				struct mmu_gather tlb;
+
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
 				if (!hugetlb_vma_trylock_write(vma)) {
 					page_vma_mapped_walk_done(&pvmw);
 					ret = false;
 					break;
 				}
-				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
-					hugetlb_vma_unlock_write(vma);
-					flush_tlb_range(vma,
-						range.start, range.end);
 
+				tlb_gather_mmu(&tlb, mm);
+				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
+					hugetlb_vma_unlock_write(vma);
+					huge_pmd_unshare_flush(&tlb, vma);
+					tlb_finish_mmu(&tlb);
 					/*
 					 * The PMD table was unmapped,
 					 * consequently unmapping the folio.
@@ -2417,6 +2425,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 					break;
 				}
 				hugetlb_vma_unlock_write(vma);
+				tlb_finish_mmu(&tlb);
 			}
 			/* Nuke the hugetlb page table entry */
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
-- 
2.52.0


