Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405E61E0EC5
	for <lists+linux-arch@lfdr.de>; Mon, 25 May 2020 14:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390631AbgEYMxt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 08:53:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390624AbgEYMxh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 May 2020 08:53:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 440D8F4D63F11ACEF441;
        Mon, 25 May 2020 20:53:32 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 25 May 2020 20:53:23 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <catalin.marinas@arm.com>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <akpm@linux-foundation.org>,
        <npiggin@gmail.com>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <maz@kernel.org>, <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [PATCH v3 5/6] mm: tlb: Provide flush_*_tlb_range wrappers
Date:   Mon, 25 May 2020 20:52:59 +0800
Message-ID: <20200525125300.794-6-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200525125300.794-1-yezhenyu2@huawei.com>
References: <20200525125300.794-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch provides flush_{pte|pmd|pud|p4d}_tlb_range() in generic
code, which are expressed through the mmu_gather APIs.  These
interface set tlb->cleared_* and finally call tlb_flush(), so we
can do the tlb invalidation according to the information in
struct mmu_gather.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 include/asm-generic/pgtable.h | 12 ++++++++++--
 mm/pgtable-generic.c          | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 329b8c8ca703..8c92122ded9b 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1161,11 +1161,19 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
  * invalidate the entire TLB which is not desitable.
  * e.g. see arch/arc: flush_pmd_tlb_range
  */
-#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
-#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+extern void flush_pte_tlb_range(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end);
+extern void flush_pmd_tlb_range(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end);
+extern void flush_pud_tlb_range(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end);
+extern void flush_p4d_tlb_range(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end);
 #else
+#define flush_pte_tlb_range(vma, addr, end)	BUILD_BUG()
 #define flush_pmd_tlb_range(vma, addr, end)	BUILD_BUG()
 #define flush_pud_tlb_range(vma, addr, end)	BUILD_BUG()
+#define flush_p4d_tlb_range(vma, addr, end)	BUILD_BUG()
 #endif
 #endif
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 3d7c01e76efc..3eff199d3507 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -101,6 +101,28 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
+#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
+
+#define FLUSH_Pxx_TLB_RANGE(_pxx)					\
+void flush_##_pxx##_tlb_range(struct vm_area_struct *vma,		\
+			      unsigned long addr, unsigned long end)	\
+{									\
+		struct mmu_gather tlb;					\
+									\
+		tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);		\
+		tlb_start_vma(&tlb, vma);				\
+		tlb_flush_##_pxx##_range(&tlb, addr, end - addr);	\
+		tlb_end_vma(&tlb, vma);					\
+		tlb_finish_mmu(&tlb, addr, end);			\
+}
+
+FLUSH_Pxx_TLB_RANGE(pte)
+FLUSH_Pxx_TLB_RANGE(pmd)
+FLUSH_Pxx_TLB_RANGE(pud)
+FLUSH_Pxx_TLB_RANGE(p4d)
+
+#endif /* __HAVE_ARCH_FLUSH_PMD_TLB_RANGE */
+
 #ifndef __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 int pmdp_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pmd_t *pmdp,
-- 
2.19.1


