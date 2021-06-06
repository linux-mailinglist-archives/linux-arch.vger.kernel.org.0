Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FB439CE4B
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFFJH1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 05:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230340AbhFFJHY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 05:07:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 459E561420;
        Sun,  6 Jun 2021 09:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622970335;
        bh=HSjK8sb9rNp8fRAH1dUnUoJsw31olmcJ8Vy6Ym+Boxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToFie3H4Ftu8Li8fo8KSiPRR2dPZnYOYsbB3/3iMWbEhu4jX2HNne30ldox9bzZgQ
         phI7JSwoclyv+6K2NVR6/U9VOQuGNVgkF3+jPBjSqv7aXm+EeuYOtP2JgutKKUV1No
         58cEYOzFiRE59XdeqHhCV8ivTlDY1wEnLGeZx9iDz6WF0++8afEUxzCOLZPyHExBKA
         gmbGqvWBLvdlQjPxQ5axvV6wnScCTrJMKqgTC3o7XHnBHmI3HH0COPzCi1fceCtGSl
         LCqxdc2nTX4ewqFS4BPX3MBjDURNBL7dm3AN94b/4vuSZfqkRvbhkmzsVWic0/LqeQ
         AN2oYO9JmiRhA==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH v2 07/11] riscv: cmo: Add dma-noncoherency support
Date:   Sun,  6 Jun 2021 09:04:05 +0000
Message-Id: <1622970249-50770-11-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622970249-50770-1-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

To support DMA device in a non-coherent interconnect SOC system,
we need the below facilities:
 - Changing a virtual memory mapping region attributes from
   cacheable to noncache + strong order which used in DMA
   descriptors.
 - Add noncache + weakorder virtual memory attributes for dma
   mapping.
 - Syncing the cache with memory before DMA start and after DMA
   end with vendor custom CMO instructions.

This patch enables linux kernel generic dma-noncoherency
infrastructure and introduces new sbi_ecall API for dma_sync.

@@ -27,6 +27,7 @@ enum sbi_ext_id {
+       SBI_EXT_DMA = 0xAB150401,

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Wei Fu <wefu@redhat.com>
Cc: Wei Wu <lazyparser@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime@cerno.tech>
---
 arch/riscv/Kconfig               |  5 ++++
 arch/riscv/include/asm/pgtable.h | 26 ++++++++++++++++++++
 arch/riscv/include/asm/sbi.h     | 15 ++++++++++++
 arch/riscv/kernel/sbi.c          | 19 ++++++++++++++
 arch/riscv/mm/Makefile           |  1 +
 arch/riscv/mm/dma-mapping.c      | 53 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 119 insertions(+)
 create mode 100644 arch/riscv/mm/dma-mapping.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 05c4976..817a9bb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -20,6 +20,10 @@ config RISCV
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_WX
+	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_DMA_WRITE_COMBINE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
@@ -43,6 +47,7 @@ config RISCV
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
+	select DMA_DIRECT_REMAP
 	select EDAC_SUPPORT
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 6ddeb49..e1a82b6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -462,6 +462,32 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
 
+#define pgprot_noncached pgprot_noncached
+static inline pgprot_t pgprot_noncached(pgprot_t _prot)
+{
+	unsigned long prot = pgprot_val(_prot);
+
+	prot &= ~_PAGE_DMA_MASK;
+	prot |= _PAGE_DMA_IO;
+
+	return __pgprot(prot);
+}
+
+#define pgprot_writecombine pgprot_writecombine
+static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
+{
+	unsigned long prot = pgprot_val(_prot);
+
+	prot &= ~_PAGE_DMA_MASK;
+	prot |= _PAGE_DMA_WC;
+
+	return __pgprot(prot);
+}
+
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+				     unsigned long size, pgprot_t vma_prot);
+
 /*
  * Encode and decode a swap entry
  *
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 0d42693..133e88a 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -27,6 +27,7 @@ enum sbi_ext_id {
 	SBI_EXT_IPI = 0x735049,
 	SBI_EXT_RFENCE = 0x52464E43,
 	SBI_EXT_HSM = 0x48534D,
+	SBI_EXT_DMA = 0xAB150401,
 };
 
 enum sbi_ext_base_fid {
@@ -63,6 +64,17 @@ enum sbi_ext_hsm_fid {
 	SBI_EXT_HSM_HART_STATUS,
 };
 
+enum sbi_ext_dma_fid {
+	SBI_DMA_SYNC = 0,
+};
+
+enum sbi_dma_sync_data_direction {
+	SBI_DMA_BIDIRECTIONAL = 0,
+	SBI_DMA_TO_DEVICE = 1,
+	SBI_DMA_FROM_DEVICE = 2,
+	SBI_DMA_NONE = 3,
+};
+
 enum sbi_hsm_hart_status {
 	SBI_HSM_HART_STATUS_STARTED = 0,
 	SBI_HSM_HART_STATUS_STOPPED,
@@ -128,6 +140,9 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
 				unsigned long size,
 				unsigned long asid);
 int sbi_probe_extension(int ext);
+void sbi_dma_sync(unsigned long start,
+		  unsigned long size,
+		  enum sbi_dma_sync_data_direction dir);
 
 /* Check if current SBI specification version is 0.1 or not */
 static inline int sbi_spec_is_0_1(void)
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 7402a41..c936019 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -521,6 +521,25 @@ int sbi_probe_extension(int extid)
 }
 EXPORT_SYMBOL(sbi_probe_extension);
 
+void sbi_dma_sync(unsigned long start,
+		  unsigned long size,
+		  enum sbi_dma_sync_data_direction dir)
+{
+#if 0
+	sbi_ecall(SBI_EXT_DMA, SBI_DMA_SYNC, start, size, dir,
+		  0, 0, 0);
+#else
+	/* Just for try, it should be in sbi ecall and will be removed before merged */
+	register unsigned long i asm("a0") = start & ~(L1_CACHE_BYTES - 1);
+
+	for (; i < ALIGN(start + size, L1_CACHE_BYTES); i += L1_CACHE_BYTES)
+		__asm__ __volatile__(".long 0x02b5000b");
+
+	__asm__ __volatile__(".long 0x01b0000b");
+#endif
+}
+EXPORT_SYMBOL(sbi_dma_sync);
+
 static long __sbi_base_ecall(int fid)
 {
 	struct sbiret ret;
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 7ebaef1..ca0ff90 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,6 +13,7 @@ obj-y += extable.o
 obj-$(CONFIG_MMU) += fault.o pageattr.o
 obj-y += cacheflush.o
 obj-y += context.o
+obj-y += dma-mapping.o
 
 ifeq ($(CONFIG_MMU),y)
 obj-$(CONFIG_SMP) += tlbflush.o
diff --git a/arch/riscv/mm/dma-mapping.c b/arch/riscv/mm/dma-mapping.c
new file mode 100644
index 00000000..4afd9dc
--- /dev/null
+++ b/arch/riscv/mm/dma-mapping.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-map-ops.h>
+#include <asm/sbi.h>
+
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	void *ptr = page_address(page);
+
+	memset(ptr, 0, size);
+	sbi_dma_sync(page_to_phys(page), size, SBI_DMA_BIDIRECTIONAL);
+}
+
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		sbi_dma_sync(paddr, size, dir);
+		break;
+	default:
+		BUG();
+	}
+}
+
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		return;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		sbi_dma_sync(paddr, size, dir);
+		break;
+	default:
+		BUG();
+	}
+}
+
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+			      unsigned long size, pgprot_t vma_prot)
+{
+	if (!pfn_valid(pfn))
+		return pgprot_noncached(vma_prot);
+	else if (file->f_flags & O_SYNC)
+		return pgprot_writecombine(vma_prot);
+
+	return vma_prot;
+}
+EXPORT_SYMBOL(phys_mem_access_prot);
-- 
2.7.4

