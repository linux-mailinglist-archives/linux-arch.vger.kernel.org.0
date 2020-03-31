Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797C619987A
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 16:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgCaOaJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Mar 2020 10:30:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12589 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730896AbgCaOaH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Mar 2020 10:30:07 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2AAA3FA5DC822BD68937;
        Tue, 31 Mar 2020 22:29:58 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 31 Mar 2020 22:29:52 +0800
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
Subject: [RFC PATCH v5 5/8] mm: tlb: Pass struct mmu_gather to flush_pud_tlb_range
Date:   Tue, 31 Mar 2020 22:29:24 +0800
Message-ID: <20200331142927.1237-6-yezhenyu2@huawei.com>
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
 include/asm-generic/pgtable.h | 4 ++--
 mm/pgtable-generic.c          | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 32d4661e5a56..1c67a744877e 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1161,10 +1161,10 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
  * e.g. see arch/arc: flush_pmd_tlb_range
  */
 #define flush_pmd_tlb_range(tlb, vma, addr, end)	flush_tlb_range(vma, addr, end)
-#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
+#define flush_pud_tlb_range(tlb, vma, addr, end)	flush_tlb_range(vma, addr, end)
 #else
 #define flush_pmd_tlb_range(tlb, vma, addr, end)	BUILD_BUG()
-#define flush_pud_tlb_range(vma, addr, end)	BUILD_BUG()
+#define flush_pud_tlb_range(tlb, vma, addr, end)	BUILD_BUG()
 #endif
 #endif
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 96c9cf77bfb5..9ab9d8f698ea 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -166,11 +166,17 @@ pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 			    pud_t *pudp)
 {
 	pud_t pud;
+	struct mmu_gather tlb;
+	unsigned long tlb_start = address;
+	unsigned long tlb_end = address + HPAGE_PUD_SIZE;
 
 	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
 	VM_BUG_ON(!pud_trans_huge(*pudp) && !pud_devmap(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, address, pudp);
-	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+	tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
+	tlb.cleared_puds = 1;
+	flush_pud_tlb_range(&tlb, vma, tlb_start, tlb_end);
+	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
 	return pud;
 }
 #endif
-- 
2.19.1


