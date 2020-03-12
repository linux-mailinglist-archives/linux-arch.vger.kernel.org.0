Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF618279C
	for <lists+linux-arch@lfdr.de>; Thu, 12 Mar 2020 05:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgCLEKj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Mar 2020 00:10:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730931AbgCLEKj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 00:10:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A1E08A37C25A8E4A232F;
        Thu, 12 Mar 2020 12:10:36 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 12:10:28 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <aneesh.kumar@linux.ibm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
Subject: [RFC PATCH v2 3/3] arm64: tlb: add support for TTL in some functions
Date:   Thu, 12 Mar 2020 12:10:18 +0800
Message-ID: <20200312041018.1927-4-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200312041018.1927-1-yezhenyu2@huawei.com>
References: <20200312041018.1927-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add support for TTL in some ARM64-Architecture functions. The
relevant functions are:

	__pte_free_tlb
	__pmd_free_tlb
	__pud_free_tlb
	clear_flush
	get_clear_flush

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlb.h | 3 +++
 arch/arm64/mm/hugetlbpage.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index b76df828e6b7..5ab686e300e9 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -44,6 +44,7 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
+	tlb->mm->context.flags |= S1_PTE_LEVEL;
 	pgtable_pte_page_dtor(pte);
 	tlb_remove_table(tlb, pte);
 }
@@ -53,6 +54,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
 	struct page *page = virt_to_page(pmdp);
+	tlb->mm->context.flags |= S1_PMD_LEVEL;
 
 	pgtable_pmd_page_dtor(page);
 	tlb_remove_table(tlb, page);
@@ -63,6 +65,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
+	tlb->mm->context.flags |= S1_PUD_LEVEL;
 	tlb_remove_table(tlb, virt_to_page(pudp));
 }
 #endif
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index bbeb6a5a6ba6..a69248aa6e1f 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -141,6 +141,7 @@ static pte_t get_clear_flush(struct mm_struct *mm,
 
 	if (valid) {
 		struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+		mm->context.flags |= S1_PTE_LEVEL;
 		flush_tlb_range(&vma, saddr, addr);
 	}
 	return orig_pte;
@@ -163,6 +164,7 @@ static void clear_flush(struct mm_struct *mm,
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
 	unsigned long i, saddr = addr;
+	mm->context.flags |= S1_PTE_LEVEL;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
-- 
2.19.1


