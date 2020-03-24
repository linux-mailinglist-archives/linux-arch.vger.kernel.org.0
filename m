Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65551911C4
	for <lists+linux-arch@lfdr.de>; Tue, 24 Mar 2020 14:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgCXNqW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Mar 2020 09:46:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727510AbgCXNqV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 09:46:21 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5E93463BE1D35BF784D7;
        Tue, 24 Mar 2020 21:46:11 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Mar 2020 21:46:03 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <peterz@infradead.org>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <maz@kernel.org>, <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
Subject: [RFC PATCH v4 3/6] arm64: Add level-hinted TLB invalidation helper to tlbi_user
Date:   Tue, 24 Mar 2020 21:45:31 +0800
Message-ID: <20200324134534.1570-4-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200324134534.1570-1-yezhenyu2@huawei.com>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
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

ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
the level of translation table walk holding the leaf entry for the
address that is being invalidated.

This patch set the default level value to 0.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/tlbflush.h | 42 ++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index a3f70778a325..d141c080e494 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -89,6 +89,36 @@
 		__tlbi(op,  arg);					\
 	} while(0)
 
+#define __tlbi_user_level(op, addr, level)				\
+	do {								\
+		u64 arg = addr;						\
+									\
+		if (!arm64_kernel_unmapped_at_el0())			\
+			break;						\
+									\
+		if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&	\
+		    level) {						\
+			u64 ttl = level;				\
+									\
+			switch (PAGE_SIZE) {				\
+			case SZ_4K:					\
+				ttl |= 1 << 2;				\
+				break;					\
+			case SZ_16K:					\
+				ttl |= 2 << 2;				\
+				break;					\
+			case SZ_64K:					\
+				ttl |= 3 << 2;				\
+				break;					\
+			}						\
+									\
+			arg &= ~TLBI_TTL_MASK;				\
+			arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);		\
+		}							\
+									\
+		__tlbi(op,  (arg) | USER_ASID_FLAG);			\
+	} while (0)
+
 /*
  *	TLB Invalidation
  *	================
@@ -190,8 +220,8 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
 	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
 
 	dsb(ishst);
-	__tlbi(vale1is, addr);
-	__tlbi_user(vale1is, addr);
+	__tlbi_level(vale1is, addr, 0);
+	__tlbi_user_level(vale1is, addr, 0);
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
@@ -231,11 +261,11 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
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


