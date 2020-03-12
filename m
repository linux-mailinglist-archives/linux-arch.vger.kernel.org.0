Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C49B18279E
	for <lists+linux-arch@lfdr.de>; Thu, 12 Mar 2020 05:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbgCLEKm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Mar 2020 00:10:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbgCLEKj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 00:10:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 999F68A68DD6D196A9F1;
        Thu, 12 Mar 2020 12:10:36 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 12:10:26 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <aneesh.kumar@linux.ibm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
Subject: [RFC PATCH v2 1/3] arm64: tlb: use __tlbi_level replace __tlbi in Stage-1
Date:   Thu, 12 Mar 2020 12:10:16 +0800
Message-ID: <20200312041018.1927-2-yezhenyu2@huawei.com>
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

ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
the level of translation table walk holding the leaf entry for the
address that is being invalidated.

This patch use __tlbi_level replace __tlbi and __tlbi_user in
Stage-1, and set the default value of level to 0.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlbflush.h | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index a3f70778a325..dda693f32099 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -46,11 +46,6 @@
 
 #define __tlbi(op, ...)		__TLBI_N(op, ##__VA_ARGS__, 1, 0)
 
-#define __tlbi_user(op, arg) do {						\
-	if (arm64_kernel_unmapped_at_el0())					\
-		__tlbi(op, (arg) | USER_ASID_FLAG);				\
-} while (0)
-
 /* This macro creates a properly formatted VA operand for the TLBI */
 #define __TLBI_VADDR(addr, asid)				\
 	({							\
@@ -87,6 +82,8 @@
 		}							\
 									\
 		__tlbi(op,  arg);					\
+		if (arm64_kernel_unmapped_at_el0())			\
+			__tlbi(op, (arg) | USER_ASID_FLAG);		\
 	} while(0)
 
 /*
@@ -179,8 +176,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 	unsigned long asid = __TLBI_VADDR(0, ASID(mm));
 
 	dsb(ishst);
-	__tlbi(aside1is, asid);
-	__tlbi_user(aside1is, asid);
+	__tlbi_level(aside1is, asid, 0);
 	dsb(ish);
 }
 
@@ -190,8 +186,7 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
 	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
 
 	dsb(ishst);
-	__tlbi(vale1is, addr);
-	__tlbi_user(vale1is, addr);
+	__tlbi_level(vale1is, addr, 0);
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
@@ -231,11 +226,9 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	dsb(ishst);
 	for (addr = start; addr < end; addr += stride) {
 		if (last_level) {
-			__tlbi(vale1is, addr);
-			__tlbi_user(vale1is, addr);
+			__tlbi_level(vale1is, addr, 0);
 		} else {
-			__tlbi(vae1is, addr);
-			__tlbi_user(vae1is, addr);
+			__tlbi_level(vae1is, addr, 0);
 		}
 	}
 	dsb(ish);
-- 
2.19.1


