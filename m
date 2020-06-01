Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066FE1EA642
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jun 2020 16:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgFAOrn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jun 2020 10:47:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgFAOrn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 10:47:43 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 95E84B8E01852B58C409;
        Mon,  1 Jun 2020 22:47:33 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 1 Jun 2020 22:47:23 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [RFC PATCH v4 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
Date:   Mon, 1 Jun 2020 22:47:13 +0800
Message-ID: <20200601144713.2222-3-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200601144713.2222-1-yezhenyu2@huawei.com>
References: <20200601144713.2222-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add __TLBI_VADDR_RANGE macro and rewrite __flush_tlb_range().

In this patch, we only use the TLBI RANGE feature if the stride == PAGE_SIZE,
because when stride > PAGE_SIZE, usually only a small number of pages need
to be flushed and classic tlbi intructions are more effective.

We can also use 'end - start < threshold number' to decide which way
to go, however, different hardware may have different thresholds, so
I'm not sure if this is feasible.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlbflush.h | 98 +++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bc3949064725..818f27c82024 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -50,6 +50,16 @@
 		__tlbi(op, (arg) | USER_ASID_FLAG);				\
 } while (0)
 
+#define __tlbi_last_level(op1, op2, arg, last_level) do {		\
+	if (last_level)	{						\
+		__tlbi(op1, arg);					\
+		__tlbi_user(op1, arg);					\
+	} else {							\
+		__tlbi(op2, arg);					\
+		__tlbi_user(op2, arg);					\
+	}								\
+} while (0)
+
 /* This macro creates a properly formatted VA operand for the TLBI */
 #define __TLBI_VADDR(addr, asid)				\
 	({							\
@@ -59,6 +69,47 @@
 		__ta;						\
 	})
 
+/*
+ * __TG defines translation granule of the system, which is decided by
+ * PAGE_SHIFT.  Used by TTL.
+ *  - 4KB	: 1
+ *  - 16KB	: 2
+ *  - 64KB	: 3
+ */
+#define __TG	((PAGE_SHIFT - 12) / 2 + 1)
+
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
+#define __TLBI_VADDR_RANGE(addr, asid, scale, num, ttl)		\
+	({							\
+		unsigned long __ta = (addr) >> PAGE_SHIFT;	\
+		__ta &= GENMASK_ULL(36, 0);			\
+		__ta |= (unsigned long)(ttl) << 37;		\
+		__ta |= (unsigned long)(num) << 39;		\
+		__ta |= (unsigned long)(scale) << 44;		\
+		__ta |= (unsigned long)(__TG) << 46;		\
+		__ta |= (unsigned long)(asid) << 48;		\
+		__ta;						\
+	})
+
+/* This macro defines the range pages of the TLBI RANGE. */
+#define __TLBI_RANGE_SIZES(num, scale)	((num + 1) << (5 * scale + 1) << PAGE_SHIFT)
+
+#define TLB_RANGE_MASK_SHIFT 5
+#define TLB_RANGE_MASK GENMASK_ULL(TLB_RANGE_MASK_SHIFT - 1, 0)
+
+
 /*
  *	TLB Invalidation
  *	================
@@ -181,32 +232,55 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long start, unsigned long end,
 				     unsigned long stride, bool last_level)
 {
+	int num = 0;
+	int scale = 0;
 	unsigned long asid = ASID(vma->vm_mm);
 	unsigned long addr;
+	unsigned long range_pages;
 
 	start = round_down(start, stride);
 	end = round_up(end, stride);
+	range_pages = (end - start) >> PAGE_SHIFT;
 
 	if ((end - start) >= (MAX_TLBI_OPS * stride)) {
 		flush_tlb_mm(vma->vm_mm);
 		return;
 	}
 
-	/* Convert the stride into units of 4k */
-	stride >>= 12;
+	dsb(ishst);
 
-	start = __TLBI_VADDR(start, asid);
-	end = __TLBI_VADDR(end, asid);
+	/*
+	 * The minimum size of TLB RANGE is 2 pages;
+	 * Use normal TLB instruction to handle odd pages.
+	 * If the stride != PAGE_SIZE, this will never happen.
+	 */
+	if (range_pages % 2 == 1) {
+		addr = __TLBI_VADDR(start, asid);
+		__tlbi_last_level(vale1is, vae1is, addr, last_level);
+		start += 1 << PAGE_SHIFT;
+		range_pages >>= 1;
+	}
 
-	dsb(ishst);
-	for (addr = start; addr < end; addr += stride) {
-		if (last_level) {
-			__tlbi(vale1is, addr);
-			__tlbi_user(vale1is, addr);
-		} else {
-			__tlbi(vae1is, addr);
-			__tlbi_user(vae1is, addr);
+	while (range_pages > 0) {
+		if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
+		    stride == PAGE_SIZE) {
+			num = (range_pages & TLB_RANGE_MASK) - 1;
+			if (num >= 0) {
+				addr = __TLBI_VADDR_RANGE(start, asid, scale,
+							  num, 0);
+				__tlbi_last_level(rvale1is, rvae1is, addr,
+						  last_level);
+				start += __TLBI_RANGE_SIZES(num, scale);
+			}
+			scale++;
+			range_pages >>= TLB_RANGE_MASK_SHIFT;
+			continue;
 		}
+
+		addr = __TLBI_VADDR(start, asid);
+		__tlbi_last_level(vale1is, vae1is, addr, last_level);
+		start += stride;
+		range_pages -= stride >> 12;
 	}
 	dsb(ish);
 }
-- 
2.19.1


