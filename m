Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9761A7976
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 13:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439134AbgDNL30 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 07:29:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2317 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729505AbgDNL3T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 07:29:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 544039E08F019AD4617D;
        Tue, 14 Apr 2020 19:28:57 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Apr 2020 19:28:48 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [RFC PATCH v3 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
Date:   Tue, 14 Apr 2020 19:28:35 +0800
Message-ID: <20200414112835.1121-3-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200414112835.1121-1-yezhenyu2@huawei.com>
References: <20200414112835.1121-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add __TLBI_VADDR_RANGE macro and __flush_tlb_range_directly()
interface.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlb.h      |   7 +-
 arch/arm64/include/asm/tlbflush.h | 114 +++++++++++++++++++++++++++++-
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index b76df828e6b7..3a1816770bd1 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -38,7 +38,12 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 		return;
 	}
 
-	__flush_tlb_range(&vma, tlb->start, tlb->end, stride, last_level);
+	if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE))
+		__flush_tlb_range_directly(&vma, tlb->start, tlb->end,
+					   stride, last_level);
+	else
+		__flush_tlb_range(&vma, tlb->start, tlb->end,
+				  stride, last_level);
 }
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bc3949064725..a482188ea563 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -59,6 +59,44 @@
 		__ta;						\
 	})
 
+/*
+ * This macro creates a properly formatted VA operand for the TLBI RANGE.
+ * The value bit assignments are:
+ *
+ * +----------+------+-------+-------+-------+----------------------+
+ * |   ASID   |  TG  | SCALE |  NUM  |  TTL  |        BADDR         |
+ * +-----------------+-------+-------+-------+----------------------+
+ * |63      48|47  46|45   44|43   39|38   37|36                   0|
+ *
+ * The address range is determined by below formula:
+ * [BADDR, BADDR + (NUM + 1) * 2^(5*SCALE + 1) * PAGESIZE)
+ *
+ */
+#define __TLBI_VADDR_RANGE(addr, asid, tg, scale, num, ttl)	\
+	({							\
+		unsigned long __ta = (addr) >> PAGE_SHIFT;	\
+		__ta &= GENMASK_ULL(36, 0);			\
+		__ta |= (unsigned long)(ttl) << 37;		\
+		__ta |= (unsigned long)(num) << 39;		\
+		__ta |= (unsigned long)(scale) << 44;		\
+		__ta |= (unsigned long)(tg) << 46;		\
+		__ta |= (unsigned long)(asid) << 48;		\
+		__ta;						\
+	})
+
+#define TLB_RANGE_MASK_SHIFT 5
+#define TLB_RANGE_MASK GENMASK_ULL(TLB_RANGE_MASK_SHIFT - 1, 0)
+
+/*
+ * __TG defines translation granule of the system, which is defined by
+ * PAGE_SHIFT.  Used by TTL.
+ *  - 4KB	: 1
+ *  - 16KB	: 2
+ *  - 64KB	: 3
+ */
+#define __TG	((PAGE_SHIFT - 12) / 2 + 1)
+
+
 /*
  *	TLB Invalidation
  *	================
@@ -171,12 +209,83 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 	dsb(ish);
 }
 
+/* The maximum range size of one TLBI-RANGE instruction */
+#define MAX_TLBI_RANGE_SIZE	(1UL << 21)
+
+/*
+ * This interface uses the *rvale1is* instruction to flush TLBs
+ * in [start, end) directly.
+ * This instruction is supported from ARM v8.4.
+ */
+static inline void __flush_tlb_range_directly(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end,
+				unsigned long stride, bool last_level)
+{
+	int num = 0;
+	int scale = 0;
+	unsigned long asid = ASID(vma->vm_mm);
+	unsigned long addr = 0;
+	unsigned long range_size;
+
+	start = round_down(start, stride);
+	end = round_up(end, stride);
+	range_size = (end - start) >> PAGE_SHIFT;
+
+	if (range_size > MAX_TLBI_RANGE_SIZE) {
+		flush_tlb_mm(vma->vm_mm);
+		return;
+	}
+
+	dsb(ishst);
+
+	/*
+	 * The minimum size of TLB RANGE is 2 PAGE;
+	 * Use normal TLB instruction to handle odd PAGEs
+	 */
+	if (range_size % 2 == 1) {
+		addr = __TLBI_VADDR(start, asid);
+		if (last_level) {
+			__tlbi(vale1is, addr);
+			__tlbi_user(vale1is, addr);
+		} else {
+			__tlbi(vae1is, addr);
+			__tlbi_user(vae1is, addr);
+		}
+		start += 1 << PAGE_SHIFT;
+		range_size -= 1;
+	}
+
+	range_size >>= 1;
+	while (range_size > 0) {
+		num = (range_size & TLB_RANGE_MASK) - 1;
+		if (num >= 0) {
+			addr = __TLBI_VADDR_RANGE(start, asid, __TG,
+						  scale, num, 0);
+			if (last_level) {
+				__tlbi(rvale1is, addr);
+				__tlbi_user(rvale1is, addr);
+			} else {
+				__tlbi(rvae1is, addr);
+				__tlbi_user(rvae1is, addr);
+			}
+			start += (num + 1) << (5 * scale + 1) << PAGE_SHIFT;
+		}
+		scale++;
+		range_size >>= TLB_RANGE_MASK_SHIFT;
+	}
+	dsb(ish);
+}
+
 /*
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
  */
 #define MAX_TLBI_OPS	PTRS_PER_PTE
 
+/*
+ * This interface uses the *vae1is* instruction to flush TLBs
+ * in [start, end) one by one.
+ */
 static inline void __flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long start, unsigned long end,
 				     unsigned long stride, bool last_level)
@@ -218,7 +327,10 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 	 * We cannot use leaf-only invalidation here, since we may be invalidating
 	 * table entries as part of collapsing hugepages or moving page tables.
 	 */
-	__flush_tlb_range(vma, start, end, PAGE_SIZE, false);
+	if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE))
+		__flush_tlb_range_directly(vma, start, end, PAGE_SIZE, false);
+	else
+		__flush_tlb_range(vma, start, end, PAGE_SIZE, false);
 }
 
 static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
-- 
2.19.1


