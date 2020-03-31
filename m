Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE52F19987B
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 16:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbgCaOaL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Mar 2020 10:30:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12593 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731138AbgCaOaL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Mar 2020 10:30:11 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 38FC7F38AA079AC0D10D;
        Tue, 31 Mar 2020 22:30:03 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 31 Mar 2020 22:29:54 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <maz@kernel.org>, <suzuki.poulose@arm.com>,
        <tglx@linutronix.de>, <yuzhao@google.com>, <Dave.Martin@arm.com>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>, <corbet@lwn.net>, <vgupta@synopsys.com>,
        <tony.luck@intel.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [RFC PATCH v5 6/8] mm: tlb: Pass struct mmu_gather to flush_hugetlb_tlb_range
Date:   Tue, 31 Mar 2020 22:29:25 +0800
Message-ID: <20200331142927.1237-7-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200331142927.1237-1-yezhenyu2@huawei.com>
References: <20200331142927.1237-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Preparations to support for passing struct mmu_gather to
flush_tlb_range.  See in future patches.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/powerpc/include/asm/book3s/64/tlbflush.h |  3 ++-
 mm/hugetlb.c                                  | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 6445d179ac15..968f10ef3d51 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -57,7 +57,8 @@ static inline void flush_pmd_tlb_range(struct mmu_gather *tlb,
 }
 
 #define __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
-static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
+static inline void flush_hugetlb_tlb_range(struct mmu_gather *tlb,
+					   struct vm_area_struct *vma,
 					   unsigned long start,
 					   unsigned long end)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd8737a94bec..f913ce0b4831 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4441,7 +4441,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
  * ARCHes with special requirements for evicting HUGETLB backing TLB entries can
  * implement this.
  */
-#define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+#define flush_hugetlb_tlb_range(tlb, vma, addr, end)	\
+	flush_tlb_range(vma, addr, end)
 #endif
 
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
@@ -4455,6 +4456,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	struct mmu_gather tlb;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -4520,10 +4522,15 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * and that page table be reused and filled with junk.  If we actually
 	 * did unshare a page of pmds, flush the range corresponding to the pud.
 	 */
-	if (shared_pmd)
-		flush_hugetlb_tlb_range(vma, range.start, range.end);
-	else
-		flush_hugetlb_tlb_range(vma, start, end);
+	if (shared_pmd) {
+		tlb_gather_mmu(&tlb, mm, range.start, range.end);
+		flush_hugetlb_tlb_range(&tlb, vma, range.start, range.end);
+		tlb_finish_mmu(&tlb, range.start, range.end);
+	} else {
+		tlb_gather_mmu(&tlb, mm, start, end);
+		flush_hugetlb_tlb_range(&tlb, vma, start, end);
+		tlb_finish_mmu(&tlb, start, end);
+	}
 	/*
 	 * No need to call mmu_notifier_invalidate_range() we are downgrading
 	 * page table protection not changing it to point to a new page.
-- 
2.19.1


