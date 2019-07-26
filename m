Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF18E75D16
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2019 04:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfGZCfJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jul 2019 22:35:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42649 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZCfJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jul 2019 22:35:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so23976417pgb.9;
        Thu, 25 Jul 2019 19:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZeIKyljSWmyR9iRQqVHC0PZiu089u4IppZY+5/gE58Q=;
        b=KhApFIyFr7Erp+NvpAwvyljFRNj0Z6bhK9azgVZ+z7hvyTnoQGDhh7mZl5Q3+BmVCV
         ndxQ6tWsnE/sgh1m1rEb+YX1Cc2Fzt6Yb0QRnD6jqX+EWpesO7fFZxqDDBmaOygJJpJg
         isilBv61Lqf2Xh+CwQjhRi607Dau2lLBhODPk4y6lf09qFGgjDT/QEjPSGYW/0IpkjB/
         hybtYLK3dr2yqbwaWTDlHlggedtPHQ4Dd7dHaYFpyCWNbkYmVQ0jqcCkme9qSMZIhr8u
         mSsrF062jGFFkYWGusitBklZSu1cVhmPH91Jhf4FvO4fkeo+oSy4SN9KaouP16q0fsPK
         UgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZeIKyljSWmyR9iRQqVHC0PZiu089u4IppZY+5/gE58Q=;
        b=c+yu5Q6f8ZJ2Q49Ev+lNfbMdb189MWWvl26vppYyGLOsGhVOB3jGXmTU+WskxHngb9
         McjEzRzt85bA+VMChfg7s63psUKWjxmKF7uUmvBloeBKrzlZ+r2zrBOZHYIxx2z1k/u6
         fGctnbDLxXwTo2YvKOBiNftTFvg29MnzIZjKhOKYyEGlzv6/WPDZbneMrCDg9UJOShSf
         FC45lfFf9M1Oco/Rey+5yqJIQUAucZizyHeMoxCS6j7oL1vnM4GBshzau1sP7z6QID6Y
         sLTF0oUaJt0NYcYV1wcAOyxkiOztl/Bfa5oFKgfPrrjaPcXdjWqIXSDZQYNLMTfguRZT
         IhRw==
X-Gm-Message-State: APjAAAWXsGDxkOb8VStF2I6nT9QEtYtv+QIVuXT7R2q/Oz4JKG6hn/T3
        n/Awfk/GuMhFoV+7p5jYmQk=
X-Google-Smtp-Source: APXvYqykX6v+YLWhUeV/Nwry8d8mZHTwnP16dOnbAEEqXJkEARoNpZ7HrZ9YvB+8gs8yGMFuyp28uA==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr96209854pjn.134.1564108508090;
        Thu, 25 Jul 2019 19:35:08 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id l31sm88958450pgm.63.2019.07.25.19.35.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 19:35:07 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>, linux-arch@vger.kernel.org,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Richard Henderson <rth@twiddle.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Zankel <chris@zankel.net>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v7 4/5] mm: introduce MADV_PAGEOUT
Date:   Fri, 26 Jul 2019 11:34:34 +0900
Message-Id: <20190726023435.214162-5-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190726023435.214162-1-minchan@kernel.org>
References: <20190726023435.214162-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a process expects no accesses to a certain memory range
for a long time, it could hint kernel that the pages can be
reclaimed instantly but data should be preserved for future use.
This could reduce workingset eviction so it ends up increasing
performance.

This patch introduces the new MADV_PAGEOUT hint to madvise(2)
syscall. MADV_PAGEOUT can be used by a process to mark a memory
range as not expected to be used for a long time so that kernel
reclaims *any LRU* pages instantly. The hint can help kernel in
deciding which pages to evict proactively.

A note: It doesn't apply SWAP_CLUSTER_MAX LRU page isolation limit
intentionally because it's automatically bounded by PMD size.
If PMD size(e.g., 256) makes some trouble, we could fix it later
by limit it to SWAP_CLUSTER_MAX[1].

- man-page material

MADV_PAGEOUT (since Linux x.x)

Do not expect access in the near future so pages in the specified
regions could be reclaimed instantly regardless of memory pressure.
Thus, access in the range after successful operation could cause
major page fault but never lose the up-to-date contents unlike
MADV_DONTNEED. Pages belonging to a shared mapping are only processed
if a write access is allowed for the calling process.

MADV_PAGEOUT cannot be applied to locked pages, Huge TLB pages, or
VM_PFNMAP pages.

* v6
 * Fix build error kbuildbot reported
   * https://lore.kernel.org/linux-mm/201907251759.zSy10dLW%25lkp@intel.com/

* v4
 * clear young bit regardless of success of page isolation - hannes

* v3
 * man page material modification - mhocko
 * remove using SWAP_CLUSTER_MAX - mhocko

* v2
 * add comment about SWAP_CLUSTER_MAX - mhocko
 * add permission check to prevent sidechannel attack - mhocko
 * add man page stuff - dave

* v1
 * change pte to old and rely on the other's reference - hannes
 * remove page_mapcount to check shared page - mhocko

* RFC v2
 * make reclaim_pages simple via factoring out isolate logic - hannes

* RFCv1
 * rename from MADV_COLD to MADV_PAGEOUT - hannes
 * bail out if process is being killed - Hillf
 * fix reclaim_pages bugs - Hillf

[1] https://lore.kernel.org/lkml/20190710194719.GS29695@dhcp22.suse.cz/

Cc: linux-arch@vger.kernel.org
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Chris Zankel <chris@zankel.net>
Reported-by: kbuild test robot <lkp@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 arch/alpha/include/uapi/asm/mman.h     |   1 +
 arch/mips/include/uapi/asm/mman.h      |   1 +
 arch/parisc/include/uapi/asm/mman.h    |   1 +
 arch/xtensa/include/uapi/asm/mman.h    |   1 +
 include/linux/swap.h                   |   1 +
 include/uapi/asm-generic/mman-common.h |   1 +
 mm/madvise.c                           | 195 +++++++++++++++++++++++++
 mm/vmscan.c                            |  55 +++++++
 8 files changed, 256 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index f3258fbf03d03..a18ec7f638880 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -69,6 +69,7 @@
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
 
 #define MADV_COLD	20		/* deactivate these pages */
+#define MADV_PAGEOUT	21		/* reclaim these pages */
 
 /* compatibility flags */
 #define MAP_FILE	0
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 00ad09fc5eb16..57dc2ac4f8bda 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -96,6 +96,7 @@
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
 
 #define MADV_COLD	20		/* deactivate these pages */
+#define MADV_PAGEOUT	21		/* reclaim these pages */
 
 /* compatibility flags */
 #define MAP_FILE	0
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index eb14e3a7b8f37..6fd8871e4081e 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -49,6 +49,7 @@
 #define MADV_DOFORK	11		/* do inherit across fork */
 
 #define MADV_COLD	20		/* deactivate these pages */
+#define MADV_PAGEOUT	21		/* reclaim these pages */
 
 #define MADV_MERGEABLE   65		/* KSM may merge identical pages */
 #define MADV_UNMERGEABLE 66		/* KSM may not merge identical pages */
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index f926b00ff11f9..e5e6437529475 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -104,6 +104,7 @@
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
 
 #define MADV_COLD	20		/* deactivate these pages */
+#define MADV_PAGEOUT	21		/* reclaim these pages */
 
 /* compatibility flags */
 #define MAP_FILE	0
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0ce997edb8bbc..063c0c1e112bd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -365,6 +365,7 @@ extern int vm_swappiness;
 extern int remove_mapping(struct address_space *mapping, struct page *page);
 extern unsigned long vm_total_pages;
 
+extern unsigned long reclaim_pages(struct list_head *page_list);
 #ifdef CONFIG_NUMA
 extern int node_reclaim_mode;
 extern int sysctl_min_unmapped_ratio;
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 23431faf0eb6e..c160a5354eb62 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -68,6 +68,7 @@
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
 
 #define MADV_COLD	20		/* deactivate these pages */
+#define MADV_PAGEOUT	21		/* reclaim these pages */
 
 /* compatibility flags */
 #define MAP_FILE	0
diff --git a/mm/madvise.c b/mm/madvise.c
index e724bce09d7ca..78aa6802b95ad 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -42,6 +42,7 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_WILLNEED:
 	case MADV_DONTNEED:
 	case MADV_COLD:
+	case MADV_PAGEOUT:
 	case MADV_FREE:
 		return 0;
 	default:
@@ -481,6 +482,197 @@ static long madvise_cold(struct vm_area_struct *vma,
 	return 0;
 }
 
+static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
+				unsigned long end, struct mm_walk *walk)
+{
+	struct mmu_gather *tlb = walk->private;
+	struct mm_struct *mm = tlb->mm;
+	struct vm_area_struct *vma = walk->vma;
+	pte_t *orig_pte, *pte, ptent;
+	spinlock_t *ptl;
+	LIST_HEAD(page_list);
+	struct page *page;
+
+	if (fatal_signal_pending(current))
+		return -EINTR;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (pmd_trans_huge(*pmd)) {
+		pmd_t orig_pmd;
+		unsigned long next = pmd_addr_end(addr, end);
+
+		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
+		ptl = pmd_trans_huge_lock(pmd, vma);
+		if (!ptl)
+			return 0;
+
+		orig_pmd = *pmd;
+		if (is_huge_zero_pmd(orig_pmd))
+			goto huge_unlock;
+
+		if (unlikely(!pmd_present(orig_pmd))) {
+			VM_BUG_ON(thp_migration_supported() &&
+					!is_pmd_migration_entry(orig_pmd));
+			goto huge_unlock;
+		}
+
+		page = pmd_page(orig_pmd);
+		if (next - addr != HPAGE_PMD_SIZE) {
+			int err;
+
+			if (page_mapcount(page) != 1)
+				goto huge_unlock;
+			get_page(page);
+			spin_unlock(ptl);
+			lock_page(page);
+			err = split_huge_page(page);
+			unlock_page(page);
+			put_page(page);
+			if (!err)
+				goto regular_page;
+			return 0;
+		}
+
+		if (pmd_young(orig_pmd)) {
+			pmdp_invalidate(vma, addr, pmd);
+			orig_pmd = pmd_mkold(orig_pmd);
+
+			set_pmd_at(mm, addr, pmd, orig_pmd);
+			tlb_remove_tlb_entry(tlb, pmd, addr);
+		}
+
+		ClearPageReferenced(page);
+		test_and_clear_page_young(page);
+
+		if (!isolate_lru_page(page))
+			list_add(&page->lru, &page_list);
+huge_unlock:
+		spin_unlock(ptl);
+		reclaim_pages(&page_list);
+		return 0;
+	}
+
+	if (pmd_trans_unstable(pmd))
+		return 0;
+regular_page:
+#endif
+	tlb_change_page_size(tlb, PAGE_SIZE);
+	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	flush_tlb_batched_pending(mm);
+	arch_enter_lazy_mmu_mode();
+	for (; addr < end; pte++, addr += PAGE_SIZE) {
+		ptent = *pte;
+		if (!pte_present(ptent))
+			continue;
+
+		page = vm_normal_page(vma, addr, ptent);
+		if (!page)
+			continue;
+
+		/*
+		 * creating a THP page is expensive so split it only if we
+		 * are sure it's worth. Split it if we are only owner.
+		 */
+		if (PageTransCompound(page)) {
+			if (page_mapcount(page) != 1)
+				break;
+			get_page(page);
+			if (!trylock_page(page)) {
+				put_page(page);
+				break;
+			}
+			pte_unmap_unlock(orig_pte, ptl);
+			if (split_huge_page(page)) {
+				unlock_page(page);
+				put_page(page);
+				pte_offset_map_lock(mm, pmd, addr, &ptl);
+				break;
+			}
+			unlock_page(page);
+			put_page(page);
+			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			pte--;
+			addr -= PAGE_SIZE;
+			continue;
+		}
+
+		VM_BUG_ON_PAGE(PageTransCompound(page), page);
+
+		if (pte_young(ptent)) {
+			ptent = ptep_get_and_clear_full(mm, addr, pte,
+							tlb->fullmm);
+			ptent = pte_mkold(ptent);
+			set_pte_at(mm, addr, pte, ptent);
+			tlb_remove_tlb_entry(tlb, pte, addr);
+		}
+		ClearPageReferenced(page);
+		test_and_clear_page_young(page);
+
+		if (!isolate_lru_page(page))
+			list_add(&page->lru, &page_list);
+	}
+
+	arch_leave_lazy_mmu_mode();
+	pte_unmap_unlock(orig_pte, ptl);
+	reclaim_pages(&page_list);
+	cond_resched();
+
+	return 0;
+}
+
+static void madvise_pageout_page_range(struct mmu_gather *tlb,
+			     struct vm_area_struct *vma,
+			     unsigned long addr, unsigned long end)
+{
+	struct mm_walk pageout_walk = {
+		.pmd_entry = madvise_pageout_pte_range,
+		.mm = vma->vm_mm,
+		.private = tlb,
+	};
+
+	tlb_start_vma(tlb, vma);
+	walk_page_range(addr, end, &pageout_walk);
+	tlb_end_vma(tlb, vma);
+}
+
+static inline bool can_do_pageout(struct vm_area_struct *vma)
+{
+	if (vma_is_anonymous(vma))
+		return true;
+	if (!vma->vm_file)
+		return false;
+	/*
+	 * paging out pagecache only for non-anonymous mappings that correspond
+	 * to the files the calling process could (if tried) open for writing;
+	 * otherwise we'd be including shared non-exclusive mappings, which
+	 * opens a side channel.
+	 */
+	return inode_owner_or_capable(file_inode(vma->vm_file)) ||
+		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
+}
+
+static long madvise_pageout(struct vm_area_struct *vma,
+			struct vm_area_struct **prev,
+			unsigned long start_addr, unsigned long end_addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_gather tlb;
+
+	*prev = vma;
+	if (!can_madv_lru_vma(vma))
+		return -EINVAL;
+
+	if (!can_do_pageout(vma))
+		return 0;
+
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
+	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
+	tlb_finish_mmu(&tlb, start_addr, end_addr);
+
+	return 0;
+}
+
 static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 
@@ -871,6 +1063,8 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		return madvise_willneed(vma, prev, start, end);
 	case MADV_COLD:
 		return madvise_cold(vma, prev, start, end);
+	case MADV_PAGEOUT:
+		return madvise_pageout(vma, prev, start, end);
 	case MADV_FREE:
 	case MADV_DONTNEED:
 		return madvise_dontneed_free(vma, prev, start, end, behavior);
@@ -893,6 +1087,7 @@ madvise_behavior_valid(int behavior)
 	case MADV_DONTNEED:
 	case MADV_FREE:
 	case MADV_COLD:
+	case MADV_PAGEOUT:
 #ifdef CONFIG_KSM
 	case MADV_MERGEABLE:
 	case MADV_UNMERGEABLE:
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d1d7163c281de..47aa2158cfac2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2158,6 +2158,61 @@ static void shrink_active_list(unsigned long nr_to_scan,
 			nr_deactivate, nr_rotated, sc->priority, file);
 }
 
+unsigned long reclaim_pages(struct list_head *page_list)
+{
+	int nid = -1;
+	unsigned long nr_reclaimed = 0;
+	LIST_HEAD(node_page_list);
+	struct reclaim_stat dummy_stat;
+	struct page *page;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+		.priority = DEF_PRIORITY,
+		.may_writepage = 1,
+		.may_unmap = 1,
+		.may_swap = 1,
+	};
+
+	while (!list_empty(page_list)) {
+		page = lru_to_page(page_list);
+		if (nid == -1) {
+			nid = page_to_nid(page);
+			INIT_LIST_HEAD(&node_page_list);
+		}
+
+		if (nid == page_to_nid(page)) {
+			list_move(&page->lru, &node_page_list);
+			continue;
+		}
+
+		nr_reclaimed += shrink_page_list(&node_page_list,
+						NODE_DATA(nid),
+						&sc, 0,
+						&dummy_stat, false);
+		while (!list_empty(&node_page_list)) {
+			page = lru_to_page(&node_page_list);
+			list_del(&page->lru);
+			putback_lru_page(page);
+		}
+
+		nid = -1;
+	}
+
+	if (!list_empty(&node_page_list)) {
+		nr_reclaimed += shrink_page_list(&node_page_list,
+						NODE_DATA(nid),
+						&sc, 0,
+						&dummy_stat, false);
+		while (!list_empty(&node_page_list)) {
+			page = lru_to_page(&node_page_list);
+			list_del(&page->lru);
+			putback_lru_page(page);
+		}
+	}
+
+	return nr_reclaimed;
+}
+
 /*
  * The inactive anon list should be small enough that the VM never has
  * to do too much work.
-- 
2.22.0.709.g102302147b-goog

