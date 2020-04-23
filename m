Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532EB1B5D11
	for <lists+linux-arch@lfdr.de>; Thu, 23 Apr 2020 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgDWN7r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Apr 2020 09:59:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727841AbgDWN7l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Apr 2020 09:59:41 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D49BB62634215B3FC836;
        Thu, 23 Apr 2020 21:59:31 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 21:59:24 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <maz@kernel.org>, <suzuki.poulose@arm.com>,
        <tglx@linutronix.de>, <yuzhao@google.com>, <Dave.Martin@arm.com>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [PATCH v2 3/6] arm64: Add tlbi_user_level TLB invalidation helper
Date:   Thu, 23 Apr 2020 21:56:53 +0800
Message-ID: <20200423135656.2712-4-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200423135656.2712-1-yezhenyu2@huawei.com>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a level-hinted parameter to __tlbi_user, which only gets used
if ARMv8.4-TTL gets detected.

This patch set the default level value to 0.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlbflush.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 5f9f189bc6d2..892f33235dc7 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -89,6 +89,12 @@
 		__tlbi(op,  arg);					\
 	} while (0)
 
+#define __tlbi_user_level(op, arg, level) do {				\
+	if (arm64_kernel_unmapped_at_el0())				\
+		__tlbi_level(op, (arg | USER_ASID_FLAG), level);	\
+} while (0)
+
+
 /*
  *	TLB Invalidation
  *	================
@@ -190,8 +196,8 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
 	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
 
 	dsb(ishst);
-	__tlbi(vale1is, addr);
-	__tlbi_user(vale1is, addr);
+	__tlbi_level(vale1is, addr, 0);
+	__tlbi_user_level(vale1is, addr, 0);
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
@@ -231,11 +237,11 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	dsb(ishst);
 	for (addr = start; addr < end; addr += stride) {
 		if (last_level) {
-			__tlbi(vale1is, addr);
-			__tlbi_user(vale1is, addr);
+			__tlbi_level(vale1is, addr, 0);
+			__tlbi_user_level(vale1is, addr, 0);
 		} else {
-			__tlbi(vae1is, addr);
-			__tlbi_user(vae1is, addr);
+			__tlbi_level(vae1is, addr, 0);
+			__tlbi_user_level(vae1is, addr, 0);
 		}
 	}
 	dsb(ish);
-- 
2.19.1


