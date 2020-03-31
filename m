Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D74199889
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 16:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgCaOa3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Mar 2020 10:30:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731094AbgCaOa2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Mar 2020 10:30:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4B7E5505C180B66729FB;
        Tue, 31 Mar 2020 22:30:03 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 31 Mar 2020 22:29:55 +0800
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
Subject: [RFC PATCH v5 7/8] mm: tlb: Pass struct mmu_gather to flush_tlb_range
Date:   Tue, 31 Mar 2020 22:29:26 +0800
Message-ID: <20200331142927.1237-8-yezhenyu2@huawei.com>
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

A few new fields were added to mmu_gather to make TLB flush smarter for
huge page by telling what level of page table is changed. However, we
can not get these infomations in flush_tlb_range() now.

This patch passes struct mmu_gather to flush_tlb_range interface, and
arm64 and power9 can all benefit from this.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 Documentation/core-api/cachetlb.rst           |  8 +++++--
 arch/alpha/include/asm/tlbflush.h             |  8 +++----
 arch/alpha/kernel/smp.c                       |  3 ++-
 arch/arc/include/asm/tlbflush.h               |  6 ++---
 arch/arc/mm/tlb.c                             |  4 ++--
 arch/arm/include/asm/tlbflush.h               | 12 ++++++----
 arch/arm/kernel/smp_tlb.c                     |  4 ++--
 arch/arm/mach-rpc/ecard.c                     |  8 +++++--
 arch/arm64/crypto/aes-glue.c                  |  1 -
 arch/arm64/include/asm/tlbflush.h             |  5 ++--
 arch/arm64/mm/hugetlbpage.c                   | 10 ++++++--
 arch/csky/include/asm/tlb.h                   |  2 +-
 arch/csky/include/asm/tlbflush.h              |  6 ++---
 arch/csky/mm/tlb.c                            |  4 ++--
 arch/hexagon/include/asm/tlbflush.h           |  2 +-
 arch/hexagon/mm/vm_tlb.c                      |  4 ++--
 arch/ia64/include/asm/tlbflush.h              |  6 +++--
 arch/ia64/mm/tlb.c                            |  5 +++-
 arch/m68k/include/asm/tlbflush.h              | 10 ++++----
 arch/microblaze/include/asm/tlbflush.h        |  5 ++--
 arch/mips/include/asm/hugetlb.h               |  6 ++++-
 arch/mips/include/asm/tlbflush.h              |  9 ++++----
 arch/mips/kernel/smp.c                        |  3 ++-
 arch/nds32/include/asm/tlbflush.h             |  3 ++-
 arch/nios2/include/asm/tlbflush.h             |  9 ++++----
 arch/nios2/mm/tlb.c                           |  8 +++++--
 arch/openrisc/include/asm/tlbflush.h          | 10 ++++----
 arch/openrisc/kernel/smp.c                    |  2 +-
 arch/parisc/include/asm/tlbflush.h            |  2 +-
 arch/parisc/kernel/cache.c                    | 13 ++++++++---
 arch/powerpc/include/asm/book3s/32/tlbflush.h |  4 ++--
 arch/powerpc/include/asm/book3s/64/tlbflush.h |  3 ++-
 arch/powerpc/include/asm/nohash/tlbflush.h    |  7 +++---
 arch/powerpc/mm/book3s32/tlb.c                |  6 ++---
 arch/powerpc/mm/book3s64/radix_tlb.c          |  2 +-
 arch/powerpc/mm/nohash/tlb.c                  |  6 ++---
 arch/riscv/include/asm/tlbflush.h             |  7 +++---
 arch/riscv/mm/tlbflush.c                      |  4 ++--
 arch/s390/include/asm/tlbflush.h              |  5 ++--
 arch/sh/include/asm/tlbflush.h                |  8 +++----
 arch/sh/kernel/smp.c                          |  2 +-
 arch/sparc/include/asm/tlbflush_32.h          |  2 +-
 arch/sparc/include/asm/tlbflush_64.h          |  3 ++-
 arch/sparc/mm/tlb.c                           |  5 +++-
 arch/um/include/asm/tlbflush.h                |  6 ++---
 arch/um/kernel/tlb.c                          |  4 ++--
 arch/unicore32/include/asm/tlbflush.h         |  5 ++--
 arch/x86/include/asm/tlbflush.h               |  4 ++--
 arch/x86/mm/pgtable.c                         | 10 ++++++--
 arch/xtensa/include/asm/tlbflush.h            | 10 ++++----
 arch/xtensa/kernel/smp.c                      |  2 +-
 include/asm-generic/pgtable.h                 |  6 +++--
 include/asm-generic/tlb.h                     |  2 +-
 mm/huge_memory.c                              | 19 ++++++++++++---
 mm/hugetlb.c                                  |  2 +-
 mm/mapping_dirty_helpers.c                    | 23 +++++++++++++------
 mm/migrate.c                                  |  8 +++++--
 mm/mprotect.c                                 |  8 ++++---
 mm/mremap.c                                   | 17 +++++++++++---
 mm/pgtable-generic.c                          |  8 ++++++-
 mm/rmap.c                                     |  6 ++++-
 61 files changed, 247 insertions(+), 135 deletions(-)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index 93cb65d52720..05f9522dca17 100644
--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -50,7 +50,7 @@ changes occur:
 	page table operations such as what happens during
 	fork, and exec.
 
-3) ``void flush_tlb_range(struct vm_area_struct *vma,
+3) ``void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
    unsigned long start, unsigned long end)``
 
 	Here we are flushing a specific range of (user) virtual
@@ -61,6 +61,10 @@ changes occur:
 	running, there will be no entries in the TLB for 'mm' for
 	virtual addresses in the range 'start' to 'end-1'.
 
+	The "tlb" is an opaque type used for passing around any data
+	needed by arch specific code for flush_tlb_range. For example,
+	it can pass the level information of TLBI instructions.
+
 	The "vma" is the backing store being used for the region.
 	Primarily, this is used for munmap() type operations.
 
@@ -111,7 +115,7 @@ the sequence will be in one of the following forms::
 
 	2) flush_cache_range(vma, start, end);
 	   change_range_of_page_tables(mm, start, end);
-	   flush_tlb_range(vma, start, end);
+	   flush_tlb_range(tlb, vma, start, end);
 
 	3) flush_cache_page(vma, addr, pfn);
 	   set_pte(pte_pointer, new_pte_val);
diff --git a/arch/alpha/include/asm/tlbflush.h b/arch/alpha/include/asm/tlbflush.h
index f8b492408f51..7512d817acee 100644
--- a/arch/alpha/include/asm/tlbflush.h
+++ b/arch/alpha/include/asm/tlbflush.h
@@ -128,8 +128,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 /* Flush a specified range of user mapping.  On the Alpha we flush
    the whole user tlb.  */
 static inline void
-flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end)
+flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end)
 {
 	flush_tlb_mm(vma->vm_mm);
 }
@@ -139,8 +139,8 @@ flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *);
 extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
-extern void flush_tlb_range(struct vm_area_struct *, unsigned long,
-			    unsigned long);
+extern void flush_tlb_range(struct mmu_gather *, struct vm_area_struct *,
+			    unsigned long, unsigned long);
 
 #endif /* CONFIG_SMP */
 
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 5f90df30be20..e57c5f5007e0 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -722,7 +722,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 EXPORT_SYMBOL(flush_tlb_page);
 
 void
-flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
+flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end)
 {
 	/* On the Alpha we always flush the whole user tlb.  */
 	flush_tlb_mm(vma->vm_mm);
diff --git a/arch/arc/include/asm/tlbflush.h b/arch/arc/include/asm/tlbflush.h
index 49e4e5b59bb2..92f336840baf 100644
--- a/arch/arc/include/asm/tlbflush.h
+++ b/arch/arc/include/asm/tlbflush.h
@@ -20,7 +20,7 @@ void local_flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 #endif
 
 #ifndef CONFIG_SMP
-#define flush_tlb_range(vma, s, e)	local_flush_tlb_range(vma, s, e)
+#define flush_tlb_range(tlb, vma, s, e)	local_flush_tlb_range(vma, s, e)
 #define flush_tlb_page(vma, page)	local_flush_tlb_page(vma, page)
 #define flush_tlb_kernel_range(s, e)	local_flush_tlb_kernel_range(s, e)
 #define flush_tlb_all()			local_flush_tlb_all()
@@ -29,8 +29,8 @@ void local_flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 #define flush_pmd_tlb_range(tlb, vma, s, e)	local_flush_pmd_tlb_range(vma, s, e)
 #endif
 #else
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-							 unsigned long end);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long page);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 extern void flush_tlb_all(void);
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 10b2a2373dc0..2f85c5a19a40 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -451,8 +451,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_page, &ta, 1);
 }
 
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end)
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
 {
 	struct tlb_args ta = {
 		.ta_vma = vma,
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 24cbfc112dfa..cf52a76f97c1 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -253,10 +253,11 @@ extern struct cpu_tlb_fns cpu_tlb;
  *		space.
  *		- mm	- mm_struct describing address space
  *
- *	flush_tlb_range(mm,start,end)
+ *	flush_tlb_range(tlb, mm, start, end)
  *
  *		Invalidate a range of TLB entries in the specified
  *		address space.
+ *		- tlb	- mmu_gather contains any data needed by tlbi interface
  *		- mm	- mm_struct describing address space
  *		- start - start address (may not be aligned)
  *		- end	- end address (exclusive, may not be aligned)
@@ -609,7 +610,8 @@ static inline void clean_pmd_entry(void *pmd)
 #define flush_tlb_mm		local_flush_tlb_mm
 #define flush_tlb_page		local_flush_tlb_page
 #define flush_tlb_kernel_page	local_flush_tlb_kernel_page
-#define flush_tlb_range		local_flush_tlb_range
+#define flush_tlb_range(tlb, vma, start, end)	\
+	local_flush_tlb_range(vma, start, end)
 #define flush_tlb_kernel_range	local_flush_tlb_kernel_range
 #define flush_bp_all		local_flush_bp_all
 #else
@@ -617,7 +619,8 @@ extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr);
 extern void flush_tlb_kernel_page(unsigned long kaddr);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 extern void flush_bp_all(void);
 #endif
@@ -657,7 +660,8 @@ extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr);
 extern void flush_tlb_kernel_page(unsigned long kaddr);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 extern void flush_bp_all(void);
 #endif	/* __ASSEMBLY__ */
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index d4908b3736d8..7a0437dd3b64 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -217,8 +217,8 @@ void flush_tlb_kernel_page(unsigned long kaddr)
 	broadcast_tlb_a15_erratum();
 }
 
-void flush_tlb_range(struct vm_area_struct *vma,
-                     unsigned long start, unsigned long end)
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
 {
 	if (tlb_ops_need_broadcast()) {
 		struct tlb_args ta;
diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 75cfad2cb143..4bad2bdb1755 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -49,6 +49,7 @@
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/mach/irq.h>
+#include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
 #include "ecard.h"
@@ -214,6 +215,7 @@ static DEFINE_MUTEX(ecard_mutex);
 static void ecard_init_pgtables(struct mm_struct *mm)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, VM_EXEC);
+	struct mmu_gather tlb;
 
 	/* We want to set up the page tables for the following mapping:
 	 *  Virtual	Physical
@@ -238,8 +240,10 @@ static void ecard_init_pgtables(struct mm_struct *mm)
 
 	memcpy(dst_pgd, src_pgd, sizeof(pgd_t) * (EASI_SIZE / PGDIR_SIZE));
 
-	flush_tlb_range(&vma, IO_START, IO_START + IO_SIZE);
-	flush_tlb_range(&vma, EASI_START, EASI_START + EASI_SIZE);
+	tlb_gather_mmu(&tlb, mm, 0, -1);
+	flush_tlb_range(&tlb, &vma, IO_START, IO_START + IO_SIZE);
+	flush_tlb_range(&tlb, &vma, EASI_START, EASI_START + EASI_SIZE);
+	tlb_finish_mmu(&tlb, 0, -1);
 }
 
 static int ecard_init_mm(void)
diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index ed5409c6abf4..116da8026154 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/cpufeature.h>
 #include <crypto/xts.h>
-
 #include "aes-ce-setkey.h"
 
 #ifdef USE_V8_CRYPTO_EXTENSIONS
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 892f33235dc7..0b4d75a2270b 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -121,7 +121,7 @@
  *		Invalidate an entire user address space on all CPUs.
  *		The 'mm' argument identifies the ASID to invalidate.
  *
- *	flush_tlb_range(vma, start, end)
+ *	flush_tlb_range(tlb, vma, start, end)
  *		Invalidate the virtual-address range '[start, end)' on all
  *		CPUs for the user address space corresponding to 'vma->mm'.
  *		Note that this operation also invalidates any walk-cache
@@ -247,7 +247,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 	dsb(ish);
 }
 
-static inline void flush_tlb_range(struct vm_area_struct *vma,
+static inline void flush_tlb_range(struct mmu_gather *tlb,
+				   struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
 	/*
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index bbeb6a5a6ba6..50ae5c300f8a 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -141,7 +141,10 @@ static pte_t get_clear_flush(struct mm_struct *mm,
 
 	if (valid) {
 		struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
-		flush_tlb_range(&vma, saddr, addr);
+		struct mmu_gather tlb;
+		tlb_gather_mmu(&tlb, mm, saddr, addr);
+		flush_tlb_range(&tlb, &vma, saddr, addr);
+		tlb_finish_mmu(&tlb, saddr, addr);
 	}
 	return orig_pte;
 }
@@ -162,12 +165,15 @@ static void clear_flush(struct mm_struct *mm,
 			     unsigned long ncontig)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	struct mmu_gather tlb;
 	unsigned long i, saddr = addr;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
 
-	flush_tlb_range(&vma, saddr, addr);
+	tlb_gather_mmu(&tlb, mm, saddr, addr);
+	flush_tlb_range(&tlb, &vma, saddr, addr);
+	tlb_finish_mmu(&tlb, saddr, addr);
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/csky/include/asm/tlb.h b/arch/csky/include/asm/tlb.h
index fdff9b8d70c8..05f756b32e5f 100644
--- a/arch/csky/include/asm/tlb.h
+++ b/arch/csky/include/asm/tlb.h
@@ -15,7 +15,7 @@
 #define tlb_end_vma(tlb, vma) \
 	do { \
 		if (!(tlb)->fullmm) \
-			flush_tlb_range(vma, (vma)->vm_start, (vma)->vm_end); \
+			flush_tlb_range(tlb, vma, (vma)->vm_start, (vma)->vm_end); \
 	}  while (0)
 
 #define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
diff --git a/arch/csky/include/asm/tlbflush.h b/arch/csky/include/asm/tlbflush.h
index 6845b0667703..8f922a693e11 100644
--- a/arch/csky/include/asm/tlbflush.h
+++ b/arch/csky/include/asm/tlbflush.h
@@ -10,14 +10,14 @@
  *  - flush_tlb_all() flushes all processes TLB entries
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB entries
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  */
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long page);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 extern void flush_tlb_one(unsigned long vaddr);
diff --git a/arch/csky/mm/tlb.c b/arch/csky/mm/tlb.c
index eb3ba6c9c927..52e9087c45a7 100644
--- a/arch/csky/mm/tlb.c
+++ b/arch/csky/mm/tlb.c
@@ -44,8 +44,8 @@ do { \
 } while (0)
 #endif
 
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			unsigned long end)
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			unsigned long start, unsigned long end)
 {
 	unsigned long newpid = cpu_asid(vma->vm_mm);
 
diff --git a/arch/hexagon/include/asm/tlbflush.h b/arch/hexagon/include/asm/tlbflush.h
index a7c9ab398cab..837deece2876 100644
--- a/arch/hexagon/include/asm/tlbflush.h
+++ b/arch/hexagon/include/asm/tlbflush.h
@@ -24,7 +24,7 @@
 extern void tlb_flush_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
-extern void flush_tlb_range(struct vm_area_struct *vma,
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 extern void flush_tlb_one(unsigned long);
diff --git a/arch/hexagon/mm/vm_tlb.c b/arch/hexagon/mm/vm_tlb.c
index 53482f2a9ff9..31ab187b4e44 100644
--- a/arch/hexagon/mm/vm_tlb.c
+++ b/arch/hexagon/mm/vm_tlb.c
@@ -22,8 +22,8 @@
  * processors must be induced to flush the copies in their local TLBs,
  * but Hexagon thread-based virtual processors share the same MMU.
  */
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			unsigned long end)
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			unsigned long start, unsigned long end)
 {
 	struct mm_struct *mm = vma->vm_mm;
 
diff --git a/arch/ia64/include/asm/tlbflush.h b/arch/ia64/include/asm/tlbflush.h
index ceac10c4d6e2..b67b5527a7ba 100644
--- a/arch/ia64/include/asm/tlbflush.h
+++ b/arch/ia64/include/asm/tlbflush.h
@@ -92,7 +92,8 @@ flush_tlb_mm (struct mm_struct *mm)
 #endif
 }
 
-extern void flush_tlb_range (struct vm_area_struct *vma, unsigned long start, unsigned long end);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end);
 
 /*
  * Page-granular tlb flush.
@@ -101,7 +102,8 @@ static inline void
 flush_tlb_page (struct vm_area_struct *vma, unsigned long addr)
 {
 #ifdef CONFIG_SMP
-	flush_tlb_range(vma, (addr & PAGE_MASK), (addr & PAGE_MASK) + PAGE_SIZE);
+	flush_tlb_range(NULL, vma, (addr & PAGE_MASK),
+			(addr & PAGE_MASK) + PAGE_SIZE);
 #else
 	if (vma->vm_mm == current->active_mm)
 		ia64_ptcl(addr, (PAGE_SHIFT << 2));
diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
index 72cc568bc841..84b11faaaf0c 100644
--- a/arch/ia64/mm/tlb.c
+++ b/arch/ia64/mm/tlb.c
@@ -347,7 +347,10 @@ __flush_tlb_range (struct vm_area_struct *vma, unsigned long start,
 	ia64_srlz_i();			/* srlz.i implies srlz.d */
 }
 
-void flush_tlb_range(struct vm_area_struct *vma,
+/* struct mmu_gather *tlb might be NULL in this architecture. See
+ * arch/ia64/include/asm/tlbflush.h: flush_tlb_page().
+ */
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		unsigned long start, unsigned long end)
 {
 	if (unlikely(end - start >= 1024*1024*1024*1024UL
diff --git a/arch/m68k/include/asm/tlbflush.h b/arch/m68k/include/asm/tlbflush.h
index 191e75a6bb24..bad618573ea3 100644
--- a/arch/m68k/include/asm/tlbflush.h
+++ b/arch/m68k/include/asm/tlbflush.h
@@ -92,7 +92,8 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr
 	}
 }
 
-static inline void flush_tlb_range(struct vm_area_struct *vma,
+static inline void flush_tlb_range(struct mmu_gather *tlb,
+				   struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
 	if (vma->vm_mm == current->active_mm)
@@ -189,8 +190,9 @@ static inline void flush_tlb_page (struct vm_area_struct *vma,
 }
 /* Flush a range of pages from TLB. */
 
-static inline void flush_tlb_range (struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end)
+static inline void flush_tlb_range(struct mmu_gather *tlb,
+				    struct vm_area_struct *vma,
+				    unsigned long start, unsigned long end)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned char seg, oldctx;
@@ -263,7 +265,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr
 	BUG();
 }
 
-static inline void flush_tlb_range(struct mm_struct *mm,
+static inline void flush_tlb_range(struct mmu_gather *tlb, struct mm_struct *mm,
 				   unsigned long start, unsigned long end)
 {
 	BUG();
diff --git a/arch/microblaze/include/asm/tlbflush.h b/arch/microblaze/include/asm/tlbflush.h
index 2e1353c2d18d..2c0f8b1a3b0b 100644
--- a/arch/microblaze/include/asm/tlbflush.h
+++ b/arch/microblaze/include/asm/tlbflush.h
@@ -44,7 +44,8 @@ static inline void local_flush_tlb_range(struct vm_area_struct *vma,
 #define flush_tlb_all local_flush_tlb_all
 #define flush_tlb_mm local_flush_tlb_mm
 #define flush_tlb_page local_flush_tlb_page
-#define flush_tlb_range local_flush_tlb_range
+#define flush_tlb_range(tlb, mm, start, end)	\
+	local_flush_tlb_range(mm, start, end)
 
 /*
  * This is called in munmap when we have freed up some page-table
@@ -60,7 +61,7 @@ static inline void flush_tlb_pgtables(struct mm_struct *mm,
 #define flush_tlb_all()				BUG()
 #define flush_tlb_mm(mm)			BUG()
 #define flush_tlb_page(vma, addr)		BUG()
-#define flush_tlb_range(mm, start, end)		BUG()
+#define flush_tlb_range(tlb, mm, start, end)	BUG()
 #define flush_tlb_pgtables(mm, start, end)	BUG()
 #define flush_tlb_kernel_range(start, end)	BUG()
 
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index 425bb6fc3bda..26acebd3a58a 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -10,6 +10,7 @@
 #define __ASM_HUGETLB_H
 
 #include <asm/page.h>
+#include <asm/tlb.h>
 
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr,
@@ -72,12 +73,15 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	int changed = !pte_same(*ptep, pte);
 
 	if (changed) {
+		struct mmu_gather tlb;
 		set_pte_at(vma->vm_mm, addr, ptep, pte);
 		/*
 		 * There could be some standard sized pages in there,
 		 * get them all.
 		 */
-		flush_tlb_range(vma, addr, addr + HPAGE_SIZE);
+		tlb_gather_mmu(&tlb, vma->vm_mm, addr, addr + HPAGE_SIZE);
+		flush_tlb_range(&tlb, vma, addr, addr + HPAGE_SIZE);
+		tlb_finish_mmu(&tlb, addr, addr + HPAGE_SIZE);
 	}
 	return changed;
 }
diff --git a/arch/mips/include/asm/tlbflush.h b/arch/mips/include/asm/tlbflush.h
index 9789e7a32def..ad5ae304f2fa 100644
--- a/arch/mips/include/asm/tlbflush.h
+++ b/arch/mips/include/asm/tlbflush.h
@@ -10,7 +10,7 @@
  *  - flush_tlb_all() flushes all processes TLB entries
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB entries
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  */
 extern void local_flush_tlb_all(void);
@@ -28,8 +28,8 @@ extern void local_flush_tlb_one(unsigned long vaddr);
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long,
-	unsigned long);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long, unsigned long);
 extern void flush_tlb_kernel_range(unsigned long, unsigned long);
 extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
 extern void flush_tlb_one(unsigned long vaddr);
@@ -38,7 +38,8 @@ extern void flush_tlb_one(unsigned long vaddr);
 
 #define flush_tlb_all()			local_flush_tlb_all()
 #define flush_tlb_mm(mm)		drop_mmu_context(mm)
-#define flush_tlb_range(vma, vmaddr, end)	local_flush_tlb_range(vma, vmaddr, end)
+#define flush_tlb_range(tlb, vma, vmaddr, end) \
+	local_flush_tlb_range(vma, vmaddr, end)
 #define flush_tlb_kernel_range(vmaddr,end) \
 	local_flush_tlb_kernel_range(vmaddr, end)
 #define flush_tlb_page(vma, page)	local_flush_tlb_page(vma, page)
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index f510c00bda88..9c3a40d23314 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -563,7 +563,8 @@ static void flush_tlb_range_ipi(void *info)
 	local_flush_tlb_range(fd->vma, fd->addr1, fd->addr2);
 }
 
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long addr;
diff --git a/arch/nds32/include/asm/tlbflush.h b/arch/nds32/include/asm/tlbflush.h
index 97155366ea01..81ba671759f9 100644
--- a/arch/nds32/include/asm/tlbflush.h
+++ b/arch/nds32/include/asm/tlbflush.h
@@ -36,7 +36,8 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
 
 #define flush_tlb_all		local_flush_tlb_all
 #define flush_tlb_mm		local_flush_tlb_mm
-#define flush_tlb_range		local_flush_tlb_range
+#define flush_tlb_range(tlb, vma, start, end) \
+	local_flush_tlb_range(vma, start, end)
 #define flush_tlb_page		local_flush_tlb_page
 #define flush_tlb_kernel_range	local_flush_tlb_kernel_range
 
diff --git a/arch/nios2/include/asm/tlbflush.h b/arch/nios2/include/asm/tlbflush.h
index 362d6da09d02..823ea991b6d7 100644
--- a/arch/nios2/include/asm/tlbflush.h
+++ b/arch/nios2/include/asm/tlbflush.h
@@ -7,13 +7,14 @@
 #define _ASM_NIOS2_TLBFLUSH_H
 
 struct mm_struct;
+struct mmu_gather;
 
 /*
  * TLB flushing:
  *
  *  - flush_tlb_all() flushes all processes TLB entries
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB entries
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, vma, start, end) flushes a range of pages
  *  - flush_tlb_page(vma, address) flushes a page
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  *  - flush_tlb_kernel_page(address) flushes a kernel page
@@ -23,14 +24,14 @@ struct mm_struct;
  */
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long address)
 {
-	flush_tlb_range(vma, address, address + PAGE_SIZE);
+	flush_tlb_range(NULL, vma, tlb_start, tlb_end);
 }
 
 static inline void flush_tlb_kernel_page(unsigned long address)
diff --git a/arch/nios2/mm/tlb.c b/arch/nios2/mm/tlb.c
index 7fea59e53f94..5cb6d9a64082 100644
--- a/arch/nios2/mm/tlb.c
+++ b/arch/nios2/mm/tlb.c
@@ -100,8 +100,12 @@ static void reload_tlb_one_pid(unsigned long addr, unsigned long mmu_pid, pte_t
 	replace_tlb_one_pid(addr, mmu_pid, pte_val(pte));
 }
 
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			unsigned long end)
+/*
+ * struct mmu_gather *tlb might be NULL in this architecture. See
+ * arch/nios2/include/asm/tlbflush.h: flush_tlb_page().
+ */
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			unsigned long start, unsigned long end)
 {
 	unsigned long mmu_pid = get_pid_from_context(&vma->vm_mm->context);
 
diff --git a/arch/openrisc/include/asm/tlbflush.h b/arch/openrisc/include/asm/tlbflush.h
index e9a7f0b35a15..67e8e492d5f0 100644
--- a/arch/openrisc/include/asm/tlbflush.h
+++ b/arch/openrisc/include/asm/tlbflush.h
@@ -27,7 +27,7 @@
  *  - flush_tlb_all() flushes all processes TLBs
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_range(mm, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, mm, start, end) flushes a range of pages
  */
 extern void local_flush_tlb_all(void);
 extern void local_flush_tlb_mm(struct mm_struct *mm);
@@ -41,13 +41,13 @@ extern void local_flush_tlb_range(struct vm_area_struct *vma,
 #define flush_tlb_all	local_flush_tlb_all
 #define flush_tlb_mm	local_flush_tlb_mm
 #define flush_tlb_page	local_flush_tlb_page
-#define flush_tlb_range	local_flush_tlb_range
+#define flush_tlb_range(tlb, vma, start, end)	local_flush_tlb_range(vma, start, end)
 #else
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end);
 #endif
 
 static inline void flush_tlb(void)
@@ -58,7 +58,7 @@ static inline void flush_tlb(void)
 static inline void flush_tlb_kernel_range(unsigned long start,
 					  unsigned long end)
 {
-	flush_tlb_range(NULL, start, end);
+	flush_tlb_range(NULL, NULL, start, end);
 }
 
 #endif /* __ASM_OPENRISC_TLBFLUSH_H */
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 7d518ee8bddc..b22d5afb8daa 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -238,7 +238,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
 }
 
-void flush_tlb_range(struct vm_area_struct *vma,
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		     unsigned long start, unsigned long end)
 {
 	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
diff --git a/arch/parisc/include/asm/tlbflush.h b/arch/parisc/include/asm/tlbflush.h
index c5ded01d45be..a46d27e7b9b0 100644
--- a/arch/parisc/include/asm/tlbflush.h
+++ b/arch/parisc/include/asm/tlbflush.h
@@ -16,7 +16,7 @@ extern void flush_tlb_all_local(void *);
 int __flush_tlb_range(unsigned long sid,
 	unsigned long start, unsigned long end);
 
-#define flush_tlb_range(vma, start, end) \
+#define flush_tlb_range(tlb, vma, start, end) \
 	__flush_tlb_range((vma)->vm_mm->context, start, end)
 
 #define flush_tlb_kernel_range(start, end) \
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 1eedfecc5137..341eeff566c9 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -22,6 +22,7 @@
 #include <asm/pdc.h>
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
+#include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -563,11 +564,14 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
 
 	if (mm->context == mfsp(3)) {
+		struct mmu_gather tlb;
 		for (vma = mm->mmap; vma; vma = vma->vm_next) {
 			flush_user_dcache_range_asm(vma->vm_start, vma->vm_end);
 			if (vma->vm_flags & VM_EXEC)
 				flush_user_icache_range_asm(vma->vm_start, vma->vm_end);
-			flush_tlb_range(vma, vma->vm_start, vma->vm_end);
+			tlb_gather_mmu(&tlb, mm, vma->vm_start, vma->vm_end);
+			flush_tlb_range(&tlb, vma, vma->vm_start, vma->vm_end);
+			tlb_finish_mmu(&tlb, vma->vm_start, vma->vm_end);
 		}
 		return;
 	}
@@ -600,11 +604,13 @@ void flush_cache_range(struct vm_area_struct *vma,
 {
 	pgd_t *pgd;
 	unsigned long addr;
+	struct mmu_gather tlb;
 
+	tlb_gather_mmu(&tlb, vma->vm_mm, start, end);
 	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
 	    end - start >= parisc_cache_flush_threshold) {
 		if (vma->vm_mm->context)
-			flush_tlb_range(vma, start, end);
+			flush_tlb_range(&tlb, vma, start, end);
 		flush_cache_all();
 		return;
 	}
@@ -613,9 +619,10 @@ void flush_cache_range(struct vm_area_struct *vma,
 		flush_user_dcache_range_asm(start, end);
 		if (vma->vm_flags & VM_EXEC)
 			flush_user_icache_range_asm(start, end);
-		flush_tlb_range(vma, start, end);
+		flush_tlb_range(&tlb, vma, start, end);
 		return;
 	}
+	tlb_finish_mmu(&tlb, start, end);
 
 	pgd = vma->vm_mm->pgd;
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index 068085b709fb..79790529fc7c 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -9,8 +9,8 @@
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 extern void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 static inline void local_flush_tlb_page(struct vm_area_struct *vma,
 					unsigned long vmaddr)
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 968f10ef3d51..b2af60c9a5ca 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -67,7 +67,8 @@ static inline void flush_hugetlb_tlb_range(struct mmu_gather *tlb,
 	return hash__flush_tlb_range(vma, start, end);
 }
 
-static inline void flush_tlb_range(struct vm_area_struct *vma,
+static inline void flush_tlb_range(struct mmu_gather *tlb,
+				   struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
 	if (radix_enabled())
diff --git a/arch/powerpc/include/asm/nohash/tlbflush.h b/arch/powerpc/include/asm/nohash/tlbflush.h
index b1d8fec29169..471ce66d32c2 100644
--- a/arch/powerpc/include/asm/nohash/tlbflush.h
+++ b/arch/powerpc/include/asm/nohash/tlbflush.h
@@ -11,7 +11,7 @@
  *                           the local processor
  *  - local_flush_tlb_page(vma, vmaddr) flushes one page on the local processor
  *  - flush_tlb_page_nohash(vma, vmaddr) flushes one page if SW loaded TLB
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  *
  */
@@ -26,11 +26,12 @@
 
 struct vm_area_struct;
 struct mm_struct;
+struct mmu_gather;
 
 #define MMU_NO_CONTEXT      	((unsigned int)-1)
 
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 extern void local_flush_tlb_mm(struct mm_struct *mm);
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index 2fcd321040ff..96dbdcffc140 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -63,7 +63,7 @@ void tlb_flush(struct mmu_gather *tlb)
  *
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes kernel pages
  *
  * since the hardware hash table functions as an extension of the
@@ -156,8 +156,8 @@ EXPORT_SYMBOL(flush_tlb_page);
  * and check _PAGE_HASHPTE bit; if it is set, find and destroy
  * the corresponding HPTE.
  */
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end)
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
 {
 	flush_range(vma->vm_mm, start, end);
 }
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 03f43c924e00..78ea6e4192d1 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -557,7 +557,7 @@ static inline void _tlbiel_va_range_multicast(struct mm_struct *mm,
  *
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes kernel pages
  *
  *  - local_* variants of page and mm only apply to the current
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index 696f568253a0..1fd5c837630e 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -181,7 +181,7 @@ EXPORT_PER_CPU_SYMBOL(next_tlbcam_idx);
  *
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes kernel pages
  *
  *  - local_* variants of page and mm only apply to the current
@@ -379,8 +379,8 @@ EXPORT_SYMBOL(flush_tlb_kernel_range);
  * some implementation can stack multiple tlbivax before a tlbsync but
  * for now, we keep it that way
  */
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end)
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
 
 {
 	if (end - start == PAGE_SIZE && !(start & ~PAGE_MASK))
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 394cfbccdcd9..d1ede9c434ec 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -30,14 +30,15 @@ static inline void local_flush_tlb_page(unsigned long addr)
 void flush_tlb_all(void);
 void flush_tlb_mm(struct mm_struct *mm);
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end);
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end);
 #else /* CONFIG_SMP && CONFIG_MMU */
 
 #define flush_tlb_all() local_flush_tlb_all()
 #define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
 
-static inline void flush_tlb_range(struct vm_area_struct *vma,
+static inline void flush_tlb_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma,
 		unsigned long start, unsigned long end)
 {
 	local_flush_tlb_all();
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 720b443c4528..4c679f942b14 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -49,8 +49,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
 }
 
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end)
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
 {
 	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
 }
diff --git a/arch/s390/include/asm/tlbflush.h b/arch/s390/include/asm/tlbflush.h
index 82703e03f35d..c9d372bbbb3e 100644
--- a/arch/s390/include/asm/tlbflush.h
+++ b/arch/s390/include/asm/tlbflush.h
@@ -99,7 +99,7 @@ static inline void __tlb_flush_mm_lazy(struct mm_struct * mm)
  *  flush_tlb_all() - flushes all processes TLBs
  *  flush_tlb_mm(mm) - flushes the specified mm context TLB's
  *  flush_tlb_page(vma, vmaddr) - flushes one page
- *  flush_tlb_range(vma, start, end) - flushes a range of pages
+ *  flush_tlb_range(tlb, vma, start, end) - flushes a range of pages
  *  flush_tlb_kernel_range(start, end) - flushes a range of kernel pages
  */
 
@@ -120,7 +120,8 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 	__tlb_flush_mm_lazy(mm);
 }
 
-static inline void flush_tlb_range(struct vm_area_struct *vma,
+static inline void flush_tlb_range(struct mmu_gather *tlb,
+				   struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
 	__tlb_flush_mm_lazy(vma->vm_mm);
diff --git a/arch/sh/include/asm/tlbflush.h b/arch/sh/include/asm/tlbflush.h
index 8f180cd3bcd6..bfaf0e9677c2 100644
--- a/arch/sh/include/asm/tlbflush.h
+++ b/arch/sh/include/asm/tlbflush.h
@@ -8,7 +8,7 @@
  *  - flush_tlb_all() flushes all processes TLBs
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  */
 extern void local_flush_tlb_all(void);
@@ -28,8 +28,8 @@ extern void __flush_tlb_global(void);
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long page);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 extern void flush_tlb_one(unsigned long asid, unsigned long page);
@@ -41,7 +41,7 @@ extern void flush_tlb_one(unsigned long asid, unsigned long page);
 #define flush_tlb_page(vma, page)	local_flush_tlb_page(vma, page)
 #define flush_tlb_one(asid, page)	local_flush_tlb_one(asid, page)
 
-#define flush_tlb_range(vma, start, end)	\
+#define flush_tlb_range(tlb, vma, start, end)	\
 	local_flush_tlb_range(vma, start, end)
 
 #define flush_tlb_kernel_range(start, end)	\
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 372acdc9033e..8bee178f6882 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -387,7 +387,7 @@ static void flush_tlb_range_ipi(void *info)
 	local_flush_tlb_range(fd->vma, fd->addr1, fd->addr2);
 }
 
-void flush_tlb_range(struct vm_area_struct *vma,
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		     unsigned long start, unsigned long end)
 {
 	struct mm_struct *mm = vma->vm_mm;
diff --git a/arch/sparc/include/asm/tlbflush_32.h b/arch/sparc/include/asm/tlbflush_32.h
index 470531991a08..231f705cd314 100644
--- a/arch/sparc/include/asm/tlbflush_32.h
+++ b/arch/sparc/include/asm/tlbflush_32.h
@@ -8,7 +8,7 @@
 	sparc32_cachetlb_ops->tlb_all()
 #define flush_tlb_mm(mm) \
 	sparc32_cachetlb_ops->tlb_mm(mm)
-#define flush_tlb_range(vma, start, end) \
+#define flush_tlb_range(tlb, vma, start, end) \
 	sparc32_cachetlb_ops->tlb_range(vma, start, end)
 #define flush_tlb_page(vma, addr) \
 	sparc32_cachetlb_ops->tlb_page(vma, addr)
diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
index 8b8cdaa69272..c371f46c71e8 100644
--- a/arch/sparc/include/asm/tlbflush_64.h
+++ b/arch/sparc/include/asm/tlbflush_64.h
@@ -32,7 +32,8 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 {
 }
 
-static inline void flush_tlb_range(struct vm_area_struct *vma,
+static inline void flush_tlb_range(struct mmu_gather *tlb,
+				   struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
 }
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 3d72d2deb13b..9bb1fd1c2668 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -245,10 +245,13 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
 	pmd_t old, entry;
+	struct mmu_gather tlb;
 
 	entry = __pmd(pmd_val(*pmdp) & ~_PAGE_VALID);
 	old = pmdp_establish(vma, address, pmdp, entry);
-	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	tlb_gather_mmu(&tlb, vma->vm_mm, address, address + HPAGE_PMD_SIZE);
+	flush_tlb_range(&tlb, vma, address, address + HPAGE_PMD_SIZE);
+	tlb_finish_mmu(&tlb, address, address + HPAGE_PMD_SIZE);
 
 	/*
 	 * set_pmd_at() will not be called in a way to decrement
diff --git a/arch/um/include/asm/tlbflush.h b/arch/um/include/asm/tlbflush.h
index a5bda890390d..e41a03181aa8 100644
--- a/arch/um/include/asm/tlbflush.h
+++ b/arch/um/include/asm/tlbflush.h
@@ -16,13 +16,13 @@
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
  *  - flush_tlb_kernel_vm() flushes the kernel vm area
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, vma, start, end) flushes a range of pages
  */
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, 
-			    unsigned long end);
+extern void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long address);
 extern void flush_tlb_kernel_vm(void);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 80a358c6d652..5aa1b8100f73 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -574,8 +574,8 @@ static void fix_range(struct mm_struct *mm, unsigned long start_addr,
 	fix_range_common(mm, start_addr, end_addr, force);
 }
 
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end)
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
 {
 	if (vma->vm_mm == NULL)
 		flush_tlb_kernel_range_common(start, end);
diff --git a/arch/unicore32/include/asm/tlbflush.h b/arch/unicore32/include/asm/tlbflush.h
index 1cf18ef55515..69ea6c3079e7 100644
--- a/arch/unicore32/include/asm/tlbflush.h
+++ b/arch/unicore32/include/asm/tlbflush.h
@@ -38,7 +38,7 @@ extern void __cpu_flush_kern_tlb_range(unsigned long, unsigned long);
  *		space.
  *		- mm	- mm_struct describing address space
  *
- *	flush_tlb_range(mm,start,end)
+ *	flush_tlb_range(tlb,mm,start,end)
  *
  *		Invalidate a range of TLB entries in the specified
  *		address space.
@@ -173,7 +173,8 @@ static inline void clean_pmd_entry(pmd_t *pmd)
 #define flush_tlb_mm		local_flush_tlb_mm
 #define flush_tlb_page		local_flush_tlb_page
 #define flush_tlb_kernel_page	local_flush_tlb_kernel_page
-#define flush_tlb_range		local_flush_tlb_range
+#define flush_tlb_range(tlb, vma, start, end)	\
+	local_flush_tlb_range(vma, start, end)
 #define flush_tlb_kernel_range	local_flush_tlb_kernel_range
 
 /*
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 6f66d841262d..217e37da8271 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -531,7 +531,7 @@ static inline void __flush_tlb_one_kernel(unsigned long addr)
  *  - flush_tlb_all() flushes all processes TLBs
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  *  - flush_tlb_others(cpumask, info) flushes TLBs on other cpus
  *
@@ -568,7 +568,7 @@ struct flush_tlb_info {
 #define flush_tlb_mm(mm)						\
 		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
 
-#define flush_tlb_range(vma, start, end)				\
+#define flush_tlb_range(tlb, vma, start, end)				\
 	flush_tlb_mm_range((vma)->vm_mm, start, end,			\
 			   ((vma)->vm_flags & VM_HUGETLB)		\
 				? huge_page_shift(hstate_vma(vma))	\
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7bd2c3a52297..7ff38507086c 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -596,8 +596,14 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
 	young = pmdp_test_and_clear_young(vma, address, pmdp);
-	if (young)
-		flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	if (young) {
+		struct mmu_gather tlb;
+		unsigned long tlb_start = address;
+		unsigned long tlb_end = address + HPAGE_PMD_SIZE;
+		tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
+		flush_tlb_range(&tlb, vma, tlb_start, tlb_end);
+		tlb_finish_mmu(&tlb, tlb_start, tlb_end);
+	}
 
 	return young;
 }
diff --git a/arch/xtensa/include/asm/tlbflush.h b/arch/xtensa/include/asm/tlbflush.h
index 856e2da2e397..613127ebabfb 100644
--- a/arch/xtensa/include/asm/tlbflush.h
+++ b/arch/xtensa/include/asm/tlbflush.h
@@ -27,7 +27,7 @@
  *  - flush_tlb_all() flushes all processes TLB entries
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB entries
  *  - flush_tlb_page(mm, vmaddr) flushes a single page
- *  - flush_tlb_range(mm, start, end) flushes a range of pages
+ *  - flush_tlb_range(tlb, mm, start, end) flushes a range of pages
  */
 
 void local_flush_tlb_all(void);
@@ -43,8 +43,8 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end);
 void flush_tlb_all(void);
 void flush_tlb_mm(struct mm_struct *);
 void flush_tlb_page(struct vm_area_struct *, unsigned long);
-void flush_tlb_range(struct vm_area_struct *, unsigned long,
-		unsigned long);
+void flush_tlb_range(struct mmu_gather *, struct vm_area_struct *,
+		unsigned long, unsigned long);
 void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 #else /* !CONFIG_SMP */
@@ -52,8 +52,8 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 #define flush_tlb_all()			   local_flush_tlb_all()
 #define flush_tlb_mm(mm)		   local_flush_tlb_mm(mm)
 #define flush_tlb_page(vma, page)	   local_flush_tlb_page(vma, page)
-#define flush_tlb_range(vma, vmaddr, end)  local_flush_tlb_range(vma, vmaddr, \
-								 end)
+#define flush_tlb_range(tlb, vma, vmaddr, end)	\
+	local_flush_tlb_range(vma, vmaddr, end)
 #define flush_tlb_kernel_range(start, end) local_flush_tlb_kernel_range(start, \
 									end)
 
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 83b244ce61ee..6fec29ea865a 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -509,7 +509,7 @@ static void ipi_flush_tlb_range(void *arg)
 	local_flush_tlb_range(fd->vma, fd->addr1, fd->addr2);
 }
 
-void flush_tlb_range(struct vm_area_struct *vma,
+void flush_tlb_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		     unsigned long start, unsigned long end)
 {
 	struct flush_data fd = {
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 1c67a744877e..884be388fe38 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1160,8 +1160,10 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
  * invalidate the entire TLB which is not desitable.
  * e.g. see arch/arc: flush_pmd_tlb_range
  */
-#define flush_pmd_tlb_range(tlb, vma, addr, end)	flush_tlb_range(vma, addr, end)
-#define flush_pud_tlb_range(tlb, vma, addr, end)	flush_tlb_range(vma, addr, end)
+#define flush_pmd_tlb_range(tlb, vma, addr, end)	\
+	flush_tlb_range(tlb, vma, addr, end)
+#define flush_pud_tlb_range(tlb, vma, addr, end)	\
+	flush_tlb_range(tlb, vma, addr, end)
 #else
 #define flush_pmd_tlb_range(tlb, vma, addr, end)	BUILD_BUG()
 #define flush_pud_tlb_range(tlb, vma, addr, end)	BUILD_BUG()
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index f391f6b500b4..1aa1ff9f72a2 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -380,7 +380,7 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 				    (tlb->vma_huge ? VM_HUGETLB : 0),
 		};
 
-		flush_tlb_range(&vma, tlb->start, tlb->end);
+		flush_tlb_range(tlb, &vma, tlb->start, tlb->end);
 	}
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 24ad53b4dfc0..5f1d29c409df 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1646,7 +1646,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	 * mapping or not. Hence use the tlb range variant
 	 */
 	if (mm_tlb_flush_pending(vma->vm_mm)) {
-		flush_tlb_range(vma, haddr, haddr + HPAGE_PMD_SIZE);
+		struct mmu_gather tlb;
+		unsigned long tlb_start = haddr;
+		unsigned long tlb_end = haddr + HPAGE_PMD_SIZE;
+		tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
+		tlb.cleared_pmds = 1;
+		flush_tlb_range(&tlb, vma, tlb_start, tlb_end);
+		tlb_finish_mmu(&tlb, tlb_start, tlb_end);
 		/*
 		 * change_huge_pmd() released the pmd lock before
 		 * invalidating the secondary MMUs sharing the primary
@@ -1917,8 +1923,15 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		}
 		pmd = move_soft_dirty_pmd(pmd);
 		set_pmd_at(mm, new_addr, new_pmd, pmd);
-		if (force_flush)
-			flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
+		if (force_flush) {
+			struct mmu_gather tlb;
+			unsigned long tlb_start = old_addr;
+			unsigned long tlb_end = old_addr + PMD_SIZE;
+			tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
+			tlb.cleared_pmds = 1;
+			flush_tlb_range(&tlb, vma, tlb_start, tlb_end);
+			tlb_finish_mmu(&tlb, tlb_start, tlb_end);
+		}
 		if (new_ptl != old_ptl)
 			spin_unlock(new_ptl);
 		spin_unlock(old_ptl);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f913ce0b4831..f4a2c9a9e478 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4442,7 +4442,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
  * implement this.
  */
 #define flush_hugetlb_tlb_range(tlb, vma, addr, end)	\
-	flush_tlb_range(vma, addr, end)
+	flush_tlb_range(tlb, vma, addr, end)
 #endif
 
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 71070dda9643..6b9df57b6301 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -175,13 +175,22 @@ static int wp_clean_pre_vma(unsigned long start, unsigned long end,
 static void wp_clean_post_vma(struct mm_walk *walk)
 {
 	struct wp_walk *wpwalk = walk->private;
-
-	if (mm_tlb_flush_nested(walk->mm))
-		flush_tlb_range(walk->vma, wpwalk->range.start,
-				wpwalk->range.end);
-	else if (wpwalk->tlbflush_end > wpwalk->tlbflush_start)
-		flush_tlb_range(walk->vma, wpwalk->tlbflush_start,
-				wpwalk->tlbflush_end);
+	struct mmu_gather tlb;
+	unsigned long tlb_start, tlb_end;
+
+	if (mm_tlb_flush_nested(walk->mm)) {
+		tlb_start = wpwalk->range.start;
+		tlb_end = wpwalk->range.end;
+		tlb_gather_mmu(&tlb, walk->mm, tlb_start, tlb_end);
+		flush_tlb_range(&tlb, walk->vma, tlb_start, tlb_end);
+		tlb_finish_mmu(&tlb, tlb_start, tlb_end);
+	} else if (wpwalk->tlbflush_end > wpwalk->tlbflush_start) {
+		tlb_start = wpwalk->tlbflush_start;
+		tlb_end = wpwalk->tlbflush_end;
+		tlb_gather_mmu(&tlb, walk->mm, tlb_start, tlb_end);
+		flush_tlb_range(&tlb, walk->vma, tlb_start, tlb_end);
+		tlb_finish_mmu(&tlb, tlb_start, tlb_end);
+	}
 
 	mmu_notifier_invalidate_range_end(&wpwalk->range);
 	dec_tlb_flush_pending(walk->mm);
diff --git a/mm/migrate.c b/mm/migrate.c
index b1092876e537..7f62b16ef36b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2340,8 +2340,12 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	pte_unmap_unlock(ptep - 1, ptl);
 
 	/* Only flush the TLB if we actually modified any entries */
-	if (unmapped)
-		flush_tlb_range(walk->vma, start, end);
+	if (unmapped) {
+		struct mmu_gather tlb;
+		tlb_gather_mmu(&tlb, mm, start, end);
+		flush_tlb_range(&tlb, walk->vma, start, end);
+		tlb_finish_mmu(&tlb, start, end);
+	}
 
 	return 0;
 }
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 311c0dadf71c..1e79254776b4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -31,6 +31,7 @@
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
+#include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
 #include "internal.h"
@@ -303,6 +304,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 		int dirty_accountable, int prot_numa)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_gather tlb;
 	pgd_t *pgd;
 	unsigned long next;
 	unsigned long start = addr;
@@ -311,7 +313,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
-	inc_tlb_flush_pending(mm);
+	tlb_gather_mmu(&tlb, mm, start, end);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
@@ -322,8 +324,8 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 
 	/* Only flush the TLB if we actually modified any entries: */
 	if (pages)
-		flush_tlb_range(vma, start, end);
-	dec_tlb_flush_pending(mm);
+		flush_tlb_range(&tlb, vma, start, end);
+	tlb_finish_mmu(&tlb, start, end);
 
 	return pages;
 }
diff --git a/mm/mremap.c b/mm/mremap.c
index af363063ea23..28cfe2f820ea 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -26,6 +26,7 @@
 #include <linux/userfaultfd_k.h>
 
 #include <asm/cacheflush.h>
+#include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
 #include "internal.h"
@@ -181,8 +182,14 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	}
 
 	arch_leave_lazy_mmu_mode();
-	if (force_flush)
-		flush_tlb_range(vma, old_end - len, old_end);
+	if (force_flush) {
+		struct mmu_gather tlb;
+		tlb_gather_mmu(&tlb, mm, old_end - len, old_end);
+		tlb.cleared_ptes = 1;
+		flush_tlb_range(&tlb, vma, old_end - len, old_end);
+		tlb_finish_mmu(&tlb, old_end - len, old_end);
+	}
+
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	pte_unmap(new_pte - 1);
@@ -198,6 +205,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 {
 	spinlock_t *old_ptl, *new_ptl;
 	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_gather tlb;
 	pmd_t pmd;
 
 	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
@@ -228,7 +236,10 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 
 	/* Set the new pmd */
 	set_pmd_at(mm, new_addr, new_pmd, pmd);
-	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
+	tlb_gather_mmu(&tlb, mm, old_addr, old_addr + PMD_SIZE);
+	tlb.cleared_pmds = 1;
+	flush_tlb_range(&tlb, vma, old_addr, old_addr + PMD_SIZE);
+	tlb_finish_mmu(&tlb, old_addr, old_addr + PMD_SIZE);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 9ab9d8f698ea..ef3ac1752033 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -240,13 +240,19 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 	 * use the same function.
 	 */
 	pmd_t pmd;
+	struct mmu_gather tlb;
+	unsigned long tlb_start = address;
+	unsigned long tlb_end = address + HPAGE_PMD_SIZE;
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(pmd_trans_huge(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
 
 	/* collapse entails shooting down ptes not pmd */
-	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	tlb_gather_mmu(&tlb, vma->vm_mm, tlb_start, tlb_end);
+	tlb.cleared_ptes = 1;
+	flush_tlb_range(&tlb, vma, tlb_start, tlb_end);
+	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
 	return pmd;
 }
 #endif
diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..72133bfb1c07 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -67,6 +67,7 @@
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
 
+#include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
 #include <trace/events/tlb.h>
@@ -1377,6 +1378,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	bool ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)arg;
+	struct mmu_gather tlb;
 
 	/* munlock has nothing to gain from examining un-locked vmas */
 	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
@@ -1462,7 +1464,9 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				 * already adjusted above to cover this range.
 				 */
 				flush_cache_range(vma, range.start, range.end);
-				flush_tlb_range(vma, range.start, range.end);
+				tlb_gather_mmu(&tlb, mm, range.start, range.end);
+				flush_tlb_range(&tlb, vma, range.start, range.end);
+				tlb_finish_mmu(&tlb, range.start, range.end);
 				mmu_notifier_invalidate_range(mm, range.start,
 							      range.end);
 
-- 
2.19.1


