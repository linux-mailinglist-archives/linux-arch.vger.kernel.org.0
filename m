Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2161827A0
	for <lists+linux-arch@lfdr.de>; Thu, 12 Mar 2020 05:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgCLEKp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Mar 2020 00:10:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbgCLEKj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 00:10:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A9DD3C064D0E03BC613E;
        Thu, 12 Mar 2020 12:10:36 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 12:10:27 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <aneesh.kumar@linux.ibm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
Subject: [RFC PATCH v2 2/3] arm64: tlb: use mm_struct.context.flags to indicate TTL value
Date:   Thu, 12 Mar 2020 12:10:17 +0800
Message-ID: <20200312041018.1927-3-yezhenyu2@huawei.com>
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

Use Architecture-specific MM context to indicate the level of page
table walk.  This avoids lots of changes to common-interface.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/mmu.h      | 11 +++++++++++
 arch/arm64/include/asm/tlbflush.h |  6 +++---
 arch/arm64/kernel/process.c       |  2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index e4d862420bb4..f86a38ab3632 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -8,6 +8,10 @@
 #include <asm/cputype.h>
 
 #define MMCF_AARCH32	0x1	/* mm context flag for AArch32 executables */
+#define S1_PUD_LEVEL	0x10	/* mm context flag for the level of ptw */
+#define S1_PMD_LEVEL	0x20
+#define S1_PTE_LEVEL	0x30
+
 #define USER_ASID_BIT	48
 #define USER_ASID_FLAG	(UL(1) << USER_ASID_BIT)
 #define TTBR_ASID_MASK	(UL(0xffff) << 48)
@@ -19,6 +23,10 @@
 typedef struct {
 	atomic64_t	id;
 	void		*vdso;
+	/*
+	 * flags[3:0]: AArch32 executables
+	 * flags[7:4]: the level of page table walk
+	 */
 	unsigned long	flags;
 } mm_context_t;
 
@@ -29,6 +37,9 @@ typedef struct {
  */
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
+/* This macro is only used by TLBI TTL */
+#define TLBI_LEVEL(mm)	((mm)->context.flags >> 4 & 0xf)
+
 extern bool arm64_use_ng_mappings;
 
 static inline bool arm64_kernel_unmapped_at_el0(void)
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index dda693f32099..312b9edb281b 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -186,7 +186,7 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
 	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
 
 	dsb(ishst);
-	__tlbi_level(vale1is, addr, 0);
+	__tlbi_level(vale1is, addr, TLBI_LEVEL(vma->vm_mm));
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
@@ -226,9 +226,9 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	dsb(ishst);
 	for (addr = start; addr < end; addr += stride) {
 		if (last_level) {
-			__tlbi_level(vale1is, addr, 0);
+			__tlbi_level(vale1is, addr, TLBI_LEVEL(vma->vm_mm));
 		} else {
-			__tlbi_level(vae1is, addr, 0);
+			__tlbi_level(vae1is, addr, TLBI_LEVEL(vma->vm_mm));
 		}
 	}
 	dsb(ish);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index bbb0f0c145f6..bf835755d9ed 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -562,7 +562,7 @@ unsigned long arch_align_stack(unsigned long sp)
  */
 void arch_setup_new_exec(void)
 {
-	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
+	current->mm->context.flags |= is_compat_task() ? MMCF_AARCH32 : 0;
 
 	ptrauth_thread_init_user(current);
 }
-- 
2.19.1


