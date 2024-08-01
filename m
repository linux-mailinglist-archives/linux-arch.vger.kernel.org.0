Return-Path: <linux-arch+bounces-5829-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802249444D8
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11481C2278A
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FE615853F;
	Thu,  1 Aug 2024 06:53:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F2157478;
	Thu,  1 Aug 2024 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495219; cv=none; b=ZoVxpm6FEJnCW+XlOsXcpUdKlOwZm6jDWGNk1sCfnEWX3JbytizfUI/V8EBhdJ2fRIJUYJOChR8U4LdIaayo73sayOz1bzclCtHdQNIIRgK0uqgpKsAWgBNcAyGsPHboEqK3e+7pfnruyWwIbtNEEtzZdbhxtxQMYNg7CSLThUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495219; c=relaxed/simple;
	bh=mGxq7/zYPAaxkPsIlPF+kaaKpQtqaucgap446oglPX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPdqfUu6/AATpnGmzsnlzs3B+q31V5SJb4ediCRNH2j9+4aFMoA93N29vRflaJL9r7RXrJVCcdOPjkQDD0jrmDJpH3+Xl1HAXhfp9Tkn4FiPyPuGKH8d8/mAE8x0Z6MGM1kolXi+I1IPVP83F6kqzVFZYqltgpRH2+eoUOIBZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4716pNwR013230;
	Thu, 1 Aug 2024 14:51:26 +0800 (GMT-8)
	(envelope-from zhang.renze@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id D379C20071B6;
	Thu,  1 Aug 2024 14:56:11 +0800 (CST)
Received: from localhost.localdomain (10.99.206.12) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Thu, 1 Aug 2024 14:51:27 +0800
From: BiscuitOS Broiler <zhang.renze@h3c.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>
CC: <arnd@arndb.de>, <linux-arch@vger.kernel.org>, <chris@zankel.net>,
        <jcmvbkbc@gmail.com>, <James.Bottomley@HansenPartnership.com>,
        <deller@gmx.de>, <linux-parisc@vger.kernel.org>,
        <tsbogend@alpha.franken.de>, <rdunlap@infradead.org>,
        <bhelgaas@google.com>, <linux-mips@vger.kernel.org>,
        <richard.henderson@linaro.org>, <ink@jurassic.park.msu.ru>,
        <mattst88@gmail.com>, <linux-alpha@vger.kernel.org>,
        <jiaoxupo@h3c.com>, <zhou.haofan@h3c.com>, <zhang.renze@h3c.com>
Subject: [PATCH 1/1] mm: introduce MADV_DEMOTE/MADV_PROMOTE
Date: Thu, 1 Aug 2024 14:50:35 +0800
Message-ID: <20240801065035.15377-2-zhang.renze@h3c.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240801065035.15377-1-zhang.renze@h3c.com>
References: <20240801065035.15377-1-zhang.renze@h3c.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
Content-Transfer-Encoding: quoted-printable
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 4716pNwR013230

In a tiered memory architecture, when a process does not access memory
in the fast nodes for a long time, the kernel will demote the memory
to slower memory through a reclamation mechanism. This frees up the
fast memory for other processes. When the process accesses the demoted
memory again, the tiered memory system will, following certain
policies, promote it back to fast memory. Since memory demotion and
promotion in a tiered memory system do not occur instantly but require
a gradual process, this can severely impact the performance of programs
in high-performance computing scenarios.

This patch introduces new MADV_DEMOTE and MADV_PROMOTE hints to the
madvise syscall. MADV_DEMOTE can mark a range of memory pages as cold
pages and immediately demote them to slow memory. MADV_PROMOTE can mark
a range of memory pages as hot pages and immediately promote them to
fast memory, allowing applications to better balance large memory
capacity with latency.

Signed-off-by: BiscuitOS Broiler <zhang.renze@h3c.com>
---
 arch/alpha/include/uapi/asm/mman.h           |   3 +
 arch/mips/include/uapi/asm/mman.h            |   3 +
 arch/parisc/include/uapi/asm/mman.h          |   3 +
 arch/xtensa/include/uapi/asm/mman.h          |   3 +
 include/uapi/asm-generic/mman-common.h       |   3 +
 mm/internal.h                                |   1 +
 mm/madvise.c                                 | 251 +++++++++++++++++++
 mm/vmscan.c                                  |  57 +++++
 tools/include/uapi/asm-generic/mman-common.h |   3 +
 9 files changed, 327 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/a=
sm/mman.h
index 763929e814e9..98e7609d51ab 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -78,6 +78,9 @@

 #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */

+#define MADV_DEMOTE    26              /* Demote page into slow node */
+#define MADV_PROMOTE   27              /* Promote page into fast node */
+
 /* compatibility flags */
 #define MAP_FILE       0

diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm=
/mman.h
index 9c48d9a21aa0..aae4cd01c20d 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -105,6 +105,9 @@

 #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */

+#define MADV_DEMOTE    26              /* Demote page into slow node */
+#define MADV_PROMOTE   27              /* Promote page into fast node */
+
 /* compatibility flags */
 #define MAP_FILE       0

diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi=
/asm/mman.h
index 68c44f99bc93..8b50ac91d0c9 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -72,6 +72,9 @@

 #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */

+#define MADV_DEMOTE    26              /* Demote page into slow node */
+#define MADV_PROMOTE   27              /* Promote page into fast node */
+
 #define MADV_HWPOISON     100          /* poison a page for testing */
 #define MADV_SOFT_OFFLINE 101          /* soft offline page for testing */

diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi=
/asm/mman.h
index 1ff0c858544f..8f820d4f5901 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -113,6 +113,9 @@

 #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */

+#define MADV_DEMOTE    26              /* Demote page into slow node */
+#define MADV_PROMOTE   27              /* Promote page into fast node */
+
 /* compatibility flags */
 #define MAP_FILE       0

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-gene=
ric/mman-common.h
index 6ce1f1ceb432..52222c2245a8 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,9 @@

 #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */

+#define MADV_DEMOTE    26              /* Demote page into slow node */
+#define MADV_PROMOTE   27              /* Promote page into fast node */
+
 /* compatibility flags */
 #define MAP_FILE       0

diff --git a/mm/internal.h b/mm/internal.h
index 7a3bcc6d95e7..105c2621e335 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1096,6 +1096,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(stru=
ct file *, unsigned long,
 extern void set_pageblock_order(void);
 struct folio *alloc_migrate_folio(struct folio *src, unsigned long private=
);
 unsigned long reclaim_pages(struct list_head *folio_list);
+unsigned long demotion_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
                                            struct list_head *folio_list);
 /* The ALLOC_WMARK bits are used as an index to zone->watermark */
diff --git a/mm/madvise.c b/mm/madvise.c
index 89089d84f8df..9e41936a2dc5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -31,6 +31,9 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
+#include <linux/memory-tiers.h>
+#include <linux/migrate.h>
+#include <linux/sched/numa_balancing.h>

 #include <asm/tlb.h>

@@ -56,6 +59,8 @@ static int madvise_need_mmap_write(int behavior)
        case MADV_DONTNEED_LOCKED:
        case MADV_COLD:
        case MADV_PAGEOUT:
+       case MADV_DEMOTE:
+       case MADV_PROMOTE:
        case MADV_FREE:
        case MADV_POPULATE_READ:
        case MADV_POPULATE_WRITE:
@@ -639,6 +644,242 @@ static long madvise_pageout(struct vm_area_struct *vm=
a,
        return 0;
 }

+static int madvise_demotion_pte_range(pmd_t *pmd,
+                               unsigned long addr, unsigned long end,
+                               struct mm_walk *walk)
+{
+       struct mmu_gather *tlb =3D walk->private;
+       struct vm_area_struct *vma =3D walk->vma;
+       struct mm_struct *mm =3D tlb->mm;
+       pte_t *start_pte, *pte, ptent;
+       struct folio *folio =3D NULL;
+       LIST_HEAD(folio_list);
+       spinlock_t *ptl;
+       int nid;
+
+       if (fatal_signal_pending(current))
+               return -EINTR;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+       if (pmd_trans_huge(*pmd))
+               return 0;
+#endif
+       tlb_change_page_size(tlb, PAGE_SIZE);
+       start_pte =3D pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, &p=
tl);
+       if (!start_pte)
+               return 0;
+       flush_tlb_batched_pending(mm);
+       arch_enter_lazy_mmu_mode();
+       for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
+               ptent =3D ptep_get(pte);
+
+               if (pte_none(ptent))
+                       continue;
+
+               if (!pte_present(ptent))
+                       continue;
+
+               folio =3D vm_normal_folio(vma, addr, ptent);
+               if (!folio || folio_is_zone_device(folio))
+                       continue;
+
+               if (folio_test_large(folio))
+                       continue;
+
+               if (!folio_test_anon(folio))
+                       continue;
+
+               nid =3D folio_nid(folio);
+               if (!node_is_toptier(nid))
+                       continue;
+
+               /* no tiered memory node */
+               if (next_demotion_node(nid) =3D=3D NUMA_NO_NODE)
+                       continue;
+
+               /*
+                * Do not interfere with other mappings of this folio and
+                * non-LRU folio. If we have a large folio at this point, w=
e
+                * know it is fully mapped so if its mapcount is the same a=
s its
+                * number of pages, it must be exclusive.
+                */
+               if (!folio_test_lru(folio) ||
+                   folio_mapcount(folio) !=3D folio_nr_pages(folio))
+                       continue;
+
+               folio_clear_referenced(folio);
+               folio_test_clear_young(folio);
+               if (folio_test_active(folio))
+                       folio_set_workingset(folio);
+               if (folio_isolate_lru(folio)) {
+                       if (folio_test_unevictable(folio))
+                               folio_putback_lru(folio);
+                       else
+                               list_add(&folio->lru, &folio_list);
+               }
+       }
+
+       if (start_pte) {
+               arch_leave_lazy_mmu_mode();
+               pte_unmap_unlock(start_pte, ptl);
+       }
+
+       demotion_pages(&folio_list);
+       cond_resched();
+
+       return 0;
+}
+
+static const struct mm_walk_ops demotion_walk_ops =3D {
+       .pmd_entry =3D madvise_demotion_pte_range,
+       .walk_lock =3D PGWALK_RDLOCK,
+};
+
+static void madvise_demotion_page_range(struct mmu_gather *tlb,
+                            struct vm_area_struct *vma,
+                            unsigned long addr, unsigned long end)
+{
+       tlb_start_vma(tlb, vma);
+       walk_page_range(vma->vm_mm, addr, end, &demotion_walk_ops, tlb);
+       tlb_end_vma(tlb, vma);
+}
+
+static long madvise_demotion(struct vm_area_struct *vma,
+                       struct vm_area_struct **prev,
+                       unsigned long start_addr, unsigned long end_addr)
+{
+       struct mm_struct *mm =3D vma->vm_mm;
+       struct mmu_gather tlb;
+
+       *prev =3D vma;
+       if (!can_madv_lru_vma(vma))
+               return -EINVAL;
+
+       if (!numa_demotion_enabled && !vma_is_anonymous(vma) &&
+                               (vma->vm_flags & VM_MAYSHARE))
+               return 0;
+
+       lru_add_drain();
+       tlb_gather_mmu(&tlb, mm);
+       madvise_demotion_page_range(&tlb, vma, start_addr, end_addr);
+       tlb_finish_mmu(&tlb);
+
+       return 0;
+}
+
+static int madvise_promotion_pte_range(pmd_t *pmd,
+                               unsigned long addr, unsigned long end,
+                               struct mm_walk *walk)
+{
+       struct mmu_gather *tlb =3D walk->private;
+       struct vm_area_struct *vma =3D walk->vma;
+       struct mm_struct *mm =3D tlb->mm;
+       struct folio *folio =3D NULL;
+       LIST_HEAD(folio_list);
+       int nid, target_nid;
+       pte_t *pte, ptent;
+       spinlock_t *ptl;
+
+       if (fatal_signal_pending(current))
+               return -EINTR;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+       if (pmd_trans_huge(*pmd))
+               return 0;
+#endif
+       tlb_change_page_size(tlb, PAGE_SIZE);
+       pte =3D pte_offset_map_nolock(vma->vm_mm, pmd, addr, &ptl);
+       if (!pte)
+               return 0;
+       flush_tlb_batched_pending(mm);
+       arch_enter_lazy_mmu_mode();
+       for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
+               ptent =3D ptep_get(pte);
+
+               if (pte_none(ptent))
+                       continue;
+
+               if (!pte_present(ptent))
+                       continue;
+
+               folio =3D vm_normal_folio(vma, addr, ptent);
+               if (!folio || folio_is_zone_device(folio))
+                       continue;
+
+               if (folio_test_large(folio))
+                       continue;
+
+               if (!folio_test_anon(folio))
+                       continue;
+
+               /* skip page on fast node */
+               nid =3D folio_nid(folio);
+               if (node_is_toptier(nid))
+                       continue;
+
+               if (!folio_test_lru(folio) ||
+                   folio_mapcount(folio) !=3D folio_nr_pages(folio))
+                       continue;
+
+               /* force update folio last access time */
+               folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
+
+               target_nid =3D numa_node_id();
+               if (!should_numa_migrate_memory(current, folio, nid, target=
_nid))
+                       continue;
+
+               /* prepare pormote */
+               if (!folio_isolate_lru(folio))
+                       continue;
+
+               /* promote page directly */
+               migrate_misplaced_folio(folio, vma, target_nid);
+               tlb_remove_tlb_entry(tlb, pte, addr);
+       }
+
+       arch_leave_lazy_mmu_mode();
+       cond_resched();
+
+       return 0;
+}
+
+static const struct mm_walk_ops promotion_walk_ops =3D {
+       .pmd_entry =3D madvise_promotion_pte_range,
+       .walk_lock =3D PGWALK_RDLOCK,
+};
+
+static void madvise_promotion_page_range(struct mmu_gather *tlb,
+                            struct vm_area_struct *vma,
+                            unsigned long addr, unsigned long end)
+{
+       tlb_start_vma(tlb, vma);
+       walk_page_range(vma->vm_mm, addr, end, &promotion_walk_ops, tlb);
+       tlb_end_vma(tlb, vma);
+}
+
+static long madvise_promotion(struct vm_area_struct *vma,
+                       struct vm_area_struct **prev,
+                       unsigned long start_addr, unsigned long end_addr)
+{
+       struct mm_struct *mm =3D vma->vm_mm;
+       struct mmu_gather tlb;
+
+       *prev =3D vma;
+       if (!can_madv_lru_vma(vma))
+               return -EINVAL;
+
+       if (!numa_demotion_enabled && !vma_is_anonymous(vma) &&
+                               (vma->vm_flags & VM_MAYSHARE))
+               return 0;
+
+       lru_add_drain();
+       tlb_gather_mmu(&tlb, mm);
+       madvise_promotion_page_range(&tlb, vma, start_addr, end_addr);
+       tlb_finish_mmu(&tlb);
+
+       return 0;
+}
+
 static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
                                unsigned long end, struct mm_walk *walk)

@@ -1040,6 +1281,10 @@ static int madvise_vma_behavior(struct vm_area_struc=
t *vma,
                return madvise_cold(vma, prev, start, end);
        case MADV_PAGEOUT:
                return madvise_pageout(vma, prev, start, end);
+       case MADV_DEMOTE:
+               return madvise_demotion(vma, prev, start, end);
+       case MADV_PROMOTE:
+               return madvise_promotion(vma, prev, start, end);
        case MADV_FREE:
        case MADV_DONTNEED:
        case MADV_DONTNEED_LOCKED:
@@ -1179,6 +1424,8 @@ madvise_behavior_valid(int behavior)
        case MADV_FREE:
        case MADV_COLD:
        case MADV_PAGEOUT:
+       case MADV_DEMOTE:
+       case MADV_PROMOTE:
        case MADV_POPULATE_READ:
        case MADV_POPULATE_WRITE:
 #ifdef CONFIG_KSM
@@ -1210,6 +1457,8 @@ static bool process_madvise_behavior_valid(int behavi=
or)
        switch (behavior) {
        case MADV_COLD:
        case MADV_PAGEOUT:
+       case MADV_DEMOTE:
+       case MADV_PROMOTE:
        case MADV_WILLNEED:
        case MADV_COLLAPSE:
                return true;
@@ -1391,6 +1640,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsig=
ned long start,
  *             triggering read faults if required
  *  MADV_POPULATE_WRITE - populate (prefault) page tables writable by
  *             triggering write faults if required
+ *  MADV_DEMOTE  - the application forces pages into slow node.
+ *  MADV_PROMOTE - the application forces pages into fast node.
  *
  * return values:
  *  zero    - success
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c89d0551655e..88d7a1dd05a0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2185,6 +2185,63 @@ unsigned long reclaim_pages(struct list_head *folio_=
list)
        return nr_reclaimed;
 }

+static unsigned int demotion_folio_list(struct list_head *folio_list,
+                                     struct pglist_data *pgdat)
+{
+       struct reclaim_stat dummy_stat;
+       unsigned int nr_demoted;
+       struct folio *folio;
+       struct scan_control sc =3D {
+               .gfp_mask =3D GFP_KERNEL,
+               .may_writepage =3D 1,
+               .may_unmap =3D 1,
+               .may_swap =3D 1,
+               .no_demotion =3D 0,
+       };
+
+       nr_demoted =3D shrink_folio_list(folio_list, pgdat, &sc, &dummy_sta=
t, true);
+       while (!list_empty(folio_list)) {
+               folio =3D lru_to_folio(folio_list);
+               list_del(&folio->lru);
+               folio_putback_lru(folio);
+       }
+
+       return nr_demoted;
+}
+
+unsigned long demotion_pages(struct list_head *folio_list)
+{
+       unsigned int nr_demoted =3D 0;
+       LIST_HEAD(node_folio_list);
+       unsigned int noreclaim_flag;
+       int nid;
+
+       if (list_empty(folio_list))
+               return nr_demoted;
+
+       noreclaim_flag =3D memalloc_noreclaim_save();
+
+       nid =3D folio_nid(lru_to_folio(folio_list));
+       do {
+               struct folio *folio =3D lru_to_folio(folio_list);
+
+               if (nid =3D=3D folio_nid(folio)) {
+                       folio_clear_active(folio);
+                       list_move(&folio->lru, &node_folio_list);
+                       continue;
+               }
+
+               nr_demoted +=3D demotion_folio_list(&node_folio_list, NODE_=
DATA(nid));
+               nid =3D folio_nid(lru_to_folio(folio_list));
+       } while (!list_empty(folio_list));
+
+       nr_demoted +=3D demotion_folio_list(&node_folio_list, NODE_DATA(nid=
));
+
+       memalloc_noreclaim_restore(noreclaim_flag);
+
+       return nr_demoted;
+}
+
 static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_sc=
an,
                                 struct lruvec *lruvec, struct scan_control=
 *sc)
 {
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/u=
api/asm-generic/mman-common.h
index 6ce1f1ceb432..52222c2245a8 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,9 @@

 #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */

+#define MADV_DEMOTE    26              /* Demote page into slow node */
+#define MADV_PROMOTE   27              /* Promote page into fast node */
+
 /* compatibility flags */
 #define MAP_FILE       0

--
2.34.1

---------------------------------------------------------------------------=
----------------------------------------------------------
=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=C2=BB=AA=C8=FD=BC=
=AF=CD=C5=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=CD=
=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6
=B5=C4=B8=F6=C8=CB=BB=F2=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=
=FB=C8=CB=D2=D4=C8=CE=BA=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=
=B2=BB=CF=DE=D3=DA=C8=AB=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=
=B4=D6=C6=A1=A2
=BB=F2=C9=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=
=E7=B9=FB=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=
=BC=B4=B5=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=
=BE=B3=FD=B1=BE
=D3=CA=BC=FE=A3=A1
This e-mail and its attachments contain confidential information from New H=
3C, which is
intended only for the person or entity whose address is listed above. Any u=
se of the
information contained herein in any way (including, but not limited to, tot=
al or partial
disclosure, reproduction, or dissemination) by persons other than the inten=
ded
recipient(s) is prohibited. If you receive this e-mail in error, please not=
ify the sender
by phone or email immediately and delete it!

