Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D01180E3B
	for <lists+linux-arch@lfdr.de>; Wed, 11 Mar 2020 03:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgCKC4f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Mar 2020 22:56:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11623 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727588AbgCKC43 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Mar 2020 22:56:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E566E10B137EED2D985F;
        Wed, 11 Mar 2020 10:56:23 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Mar 2020 10:56:15 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <aneesh.kumar@linux.ibm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>
Subject: [RFC PATCH v1 1/3] arm64: tlb: add TTL field to __TLBI_ADDR
Date:   Wed, 11 Mar 2020 10:53:07 +0800
Message-ID: <20200311025309.1743-2-yezhenyu2@huawei.com>
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

ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
the level of translation table walk holding the leaf entry for the
address that is being invalidated.

This patch add support for TTL feature and set the default value 0
where __TLBI_ADDR is called.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/cpucaps.h  |  3 ++-
 arch/arm64/include/asm/sysreg.h   |  4 ++++
 arch/arm64/include/asm/tlbflush.h | 33 ++++++++++++++++++++++---------
 arch/arm64/kernel/cpufeature.c    | 10 ++++++++++
 arch/arm64/kernel/sys_compat.c    |  2 +-
 5 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 865e0253fc1e..60f3b090ea9a 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -58,7 +58,8 @@
 #define ARM64_WORKAROUND_SPECULATIVE_AT_NVHE	48
 #define ARM64_HAS_E0PD				49
 #define ARM64_HAS_RNG				50
+#define ARM64_HAS_TLBI_TTL			51
 
-#define ARM64_NCAPS				51
+#define ARM64_NCAPS				52
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index b91570ff9db1..7caa3c9facfe 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -685,6 +685,7 @@
 
 /* id_aa64mmfr2 */
 #define ID_AA64MMFR2_E0PD_SHIFT		60
+#define ID_AA64MMFR2_TTL_SHIFT		48
 #define ID_AA64MMFR2_FWB_SHIFT		40
 #define ID_AA64MMFR2_AT_SHIFT		32
 #define ID_AA64MMFR2_LVA_SHIFT		16
@@ -693,6 +694,9 @@
 #define ID_AA64MMFR2_UAO_SHIFT		4
 #define ID_AA64MMFR2_CNP_SHIFT		0
 
+#define ID_AA64MMFR2_TTL_NI		0x0
+#define ID_AA64MMFR2_TTL_SUPPORTED	0x1
+
 /* id_aa64dfr0 */
 #define ID_AA64DFR0_PMSVER_SHIFT	32
 #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bc3949064725..10b12710b7cc 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -50,15 +50,30 @@
 		__tlbi(op, (arg) | USER_ASID_FLAG);				\
 } while (0)
 
-/* This macro creates a properly formatted VA operand for the TLBI */
-#define __TLBI_VADDR(addr, asid)				\
+/* This macro creates a properly formatted VA operand for the TLBI.
+ * The TTL field is introduced since ARMv8.4. ARMv8.4-TTL provides the TTL
+ * field to indicate the level of translation table walk holding the leaf entry
+ * for the address that is being invalidated.
+ */
+#define __TLBI_VADDR(addr, asid, ttl)				\
 	({							\
 		unsigned long __ta = (addr) >> 12;		\
 		__ta &= GENMASK_ULL(43, 0);			\
+		if (cpus_have_const_cap(ARM64_HAS_TLBI_TTL))	\
+			__ta |= (unsigned long)(ttl) << 44;	\
 		__ta |= (unsigned long)(asid) << 48;		\
 		__ta;						\
 	})
 
+/*
+ * __TLB_TG defines translation granule of the system, which is defined by
+ * PAGE_SHIFT.  Used by TTL.
+ *  - 4KB	: 1
+ *  - 16KB	: 2
+ *  - 64KB	: 3
+ */
+#define __TLB_TG	((PAGE_SHIFT - 12) / 2 + 1)
+
 /*
  *	TLB Invalidation
  *	================
@@ -146,7 +161,7 @@ static inline void flush_tlb_all(void)
 
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
-	unsigned long asid = __TLBI_VADDR(0, ASID(mm));
+	unsigned long asid = __TLBI_VADDR(0, ASID(mm), 0);
 
 	dsb(ishst);
 	__tlbi(aside1is, asid);
@@ -157,7 +172,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
 					 unsigned long uaddr)
 {
-	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
+	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm), 0);
 
 	dsb(ishst);
 	__tlbi(vale1is, addr);
@@ -195,8 +210,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	/* Convert the stride into units of 4k */
 	stride >>= 12;
 
-	start = __TLBI_VADDR(start, asid);
-	end = __TLBI_VADDR(end, asid);
+	start = __TLBI_VADDR(start, asid, 0);
+	end = __TLBI_VADDR(end, asid, 0);
 
 	dsb(ishst);
 	for (addr = start; addr < end; addr += stride) {
@@ -230,8 +245,8 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 		return;
 	}
 
-	start = __TLBI_VADDR(start, 0);
-	end = __TLBI_VADDR(end, 0);
+	start = __TLBI_VADDR(start, 0, 0);
+	end = __TLBI_VADDR(end, 0, 0);
 
 	dsb(ishst);
 	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
@@ -246,7 +261,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
  */
 static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 {
-	unsigned long addr = __TLBI_VADDR(kaddr, 0);
+	unsigned long addr = __TLBI_VADDR(kaddr, 0, 0);
 
 	dsb(ishst);
 	__tlbi(vaae1is, addr);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0b6715625cf6..9a84c59e1482 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1672,6 +1672,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 1,
 	},
 #endif
+	{
+		.desc = "TTL field in TLBI operation",
+		.capability = ARM64_HAS_TLBI_TTL,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64MMFR2_EL1,
+		.field_pos = ID_AA64MMFR2_TTL_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = ID_AA64MMFR2_TTL_SUPPORTED,
+	},
 	{},
 };
 
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index 3c18c2454089..5d1570354d29 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -37,7 +37,7 @@ __do_compat_cache_op(unsigned long start, unsigned long end)
 			 * The workaround requires an inner-shareable tlbi.
 			 * We pick the reserved-ASID to minimise the impact.
 			 */
-			__tlbi(aside1is, __TLBI_VADDR(0, 0));
+			__tlbi(aside1is, __TLBI_VADDR(0, 0, 0));
 			dsb(ish);
 		}
 
-- 
2.19.1


