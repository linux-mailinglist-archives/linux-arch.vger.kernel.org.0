Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0FD180E36
	for <lists+linux-arch@lfdr.de>; Wed, 11 Mar 2020 03:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgCKC43 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Mar 2020 22:56:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727506AbgCKC43 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Mar 2020 22:56:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE3F0E0F8BC4C2687253;
        Wed, 11 Mar 2020 10:56:23 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Mar 2020 10:56:16 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <aneesh.kumar@linux.ibm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>
Subject: [RFC PATCH v1 2/3] arm64: tlb: use mm_struct.context.flags to indicate TTL
Date:   Wed, 11 Mar 2020 10:53:08 +0800
Message-ID: <20200311025309.1743-3-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200311025309.1743-1-yezhenyu2@huawei.com>
References: <20200311025309.1743-1-yezhenyu2@huawei.com>
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
table walk. This avoids lots of changes to common-interface.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/mmu.h      | 11 +++++++++++
 arch/arm64/include/asm/tlbflush.h |  8 +++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index e4d862420bb4..7410d2997c2a 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -8,6 +8,10 @@
 #include <asm/cputype.h>
 
 #define MMCF_AARCH32	0x1	/* mm context flag for AArch32 executables */
+#define TLBI_LEVEL_1	0x10	/* mm context flag for the level of ptw */
+#define TLBI_LEVEL_2	0x20
+#define TLBI_LEVEL_3	0x30
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
index 10b12710b7cc..9f02a5383ac3 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -172,7 +172,8 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
 					 unsigned long uaddr)
 {
-	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm), 0);
+	unsigned long ttl = (__TLB_TG << 2) + TLBI_LEVEL(vma->vm_mm);
+	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm), ttl);
 
 	dsb(ishst);
 	__tlbi(vale1is, addr);
@@ -197,6 +198,7 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long stride, bool last_level)
 {
 	unsigned long asid = ASID(vma->vm_mm);
+	unsigned long ttl = (__TLB_TG << 2) + TLBI_LEVEL(vma->vm_mm);
 	unsigned long addr;
 
 	start = round_down(start, stride);
@@ -210,8 +212,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	/* Convert the stride into units of 4k */
 	stride >>= 12;
 
-	start = __TLBI_VADDR(start, asid, 0);
-	end = __TLBI_VADDR(end, asid, 0);
+	start = __TLBI_VADDR(start, asid, ttl);
+	end = __TLBI_VADDR(end, asid, ttl);
 
 	dsb(ishst);
 	for (addr = start; addr < end; addr += stride) {
-- 
2.19.1


