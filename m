Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A053455A8CB
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jun 2022 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiFYJyi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Jun 2022 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiFYJyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jun 2022 05:54:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2DA32059;
        Sat, 25 Jun 2022 02:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6082260FEA;
        Sat, 25 Jun 2022 09:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A67C3411C;
        Sat, 25 Jun 2022 09:54:28 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Min Zhou <zhoumin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 2/3] LoongArch: Add sparse memory vmemmap support
Date:   Sat, 25 Jun 2022 17:54:58 +0800
Message-Id: <20220625095459.3786827-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220625095459.3786827-1-chenhuacai@loongson.cn>
References: <20220625095459.3786827-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

Add sparse memory vmemmap support for LoongArch. SPARSEMEM_VMEMMAP
uses a virtually mapped memmap to optimise pfn_to_page and page_to_pfn
operations. This is the most efficient option when sufficient kernel
resources are available.

Signed-off-by: Min Zhou <zhoumin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 arch/loongarch/Kconfig                 |  2 +
 arch/loongarch/include/asm/pgtable.h   |  5 +-
 arch/loongarch/include/asm/sparsemem.h |  8 +++
 arch/loongarch/mm/init.c               | 71 +++++++++++++++++++++++++-
 include/linux/mm.h                     |  2 +
 mm/sparse-vmemmap.c                    | 10 ++++
 6 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index dc19cf3071ea..8e56ca28165e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -49,6 +49,7 @@ config LOONGARCH
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
+	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	select ARCH_WANTS_NO_INSTR
 	select BUILDTIME_TABLE_SORT
 	select COMMON_CLK
@@ -422,6 +423,7 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
+	select SPARSEMEM_VMEMMAP_ENABLE
 	help
 	  Say Y to support efficient handling of sparse physical memory,
 	  for architectures which are either NUMA (Non-Uniform Memory Access)
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 9c811c3f7572..b701ec7a0309 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -92,7 +92,10 @@ extern unsigned long zero_page_mask;
 #define VMALLOC_START	MODULES_END
 #define VMALLOC_END	\
 	(vm_map_base +	\
-	 min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE)
+	 min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, (1UL << cpu_vabits)) - PMD_SIZE - VMEMMAP_SIZE)
+
+#define vmemmap		((struct page *)((VMALLOC_END + PMD_SIZE) & PMD_MASK))
+#define VMEMMAP_END	((unsigned long)vmemmap + VMEMMAP_SIZE - 1)
 
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
diff --git a/arch/loongarch/include/asm/sparsemem.h b/arch/loongarch/include/asm/sparsemem.h
index 3d18cdf1b069..a1e440f6bec7 100644
--- a/arch/loongarch/include/asm/sparsemem.h
+++ b/arch/loongarch/include/asm/sparsemem.h
@@ -11,6 +11,14 @@
 #define SECTION_SIZE_BITS	29 /* 2^29 = Largest Huge Page Size */
 #define MAX_PHYSMEM_BITS	48
 
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+#define VMEMMAP_SIZE	0
+#else
+#define VMEMMAP_SIZE	(sizeof(struct page) * (1UL << (cpu_pabits + 1 - PAGE_SHIFT)))
+#endif
+
+#include <linux/mm_types.h>
+
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 7094a68c9b83..35128229fe46 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -22,7 +22,7 @@
 #include <linux/pfn.h>
 #include <linux/hardirq.h>
 #include <linux/gfp.h>
-#include <linux/initrd.h>
+#include <linux/hugetlb.h>
 #include <linux/mmzone.h>
 
 #include <asm/asm-offsets.h>
@@ -157,6 +157,75 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 #endif
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
+					 int node, struct vmem_altmap *altmap)
+{
+	unsigned long addr = start;
+	unsigned long next;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	for (addr = start; addr < end; addr = next) {
+		next = pmd_addr_end(addr, end);
+
+		pgd = vmemmap_pgd_populate(addr, node);
+		if (!pgd)
+			return -ENOMEM;
+		p4d = vmemmap_p4d_populate(pgd, addr, node);
+		if (!p4d)
+			return -ENOMEM;
+		pud = vmemmap_pud_populate(p4d, addr, node);
+		if (!pud)
+			return -ENOMEM;
+
+		pmd = pmd_offset(pud, addr);
+		if (pmd_none(*pmd)) {
+			void *p = NULL;
+
+			p = vmemmap_alloc_block_buf(PMD_SIZE, node, NULL);
+			if (p) {
+				pmd_t entry;
+
+				entry = pfn_pmd(virt_to_pfn(p), PAGE_KERNEL);
+				pmd_val(entry) |= _PAGE_HUGE | _PAGE_HGLOBAL;
+				set_pmd_at(&init_mm, addr, pmd, entry);
+
+				continue;
+			}
+		} else if (pmd_val(*pmd) & _PAGE_HUGE) {
+			vmemmap_verify((pte_t *)pmd, node, addr, next);
+			continue;
+		}
+		if (vmemmap_populate_basepages(addr, next, node, NULL))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+#if CONFIG_PGTABLE_LEVELS == 2
+int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
+		struct vmem_altmap *altmap)
+{
+	return vmemmap_populate_basepages(start, end, node, NULL);
+}
+#else
+int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
+		struct vmem_altmap *altmap)
+{
+	return vmemmap_populate_hugepages(start, end, node, NULL);
+}
+#endif
+
+void vmemmap_free(unsigned long start, unsigned long end,
+		struct vmem_altmap *altmap)
+{
+}
+#endif
+
 /*
  * Align swapper_pg_dir in to 64K, allows its address to be loaded
  * with a single LUI instruction in the TLB handlers.  If we used
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..3472b924a1ea 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3203,6 +3203,8 @@ void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap);
+void pmd_init(void *addr);
+void pud_init(void *addr);
 pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
 p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
 pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index f4fa61dbbee3..33e2a1ceee72 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -587,6 +587,10 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
 	return pmd;
 }
 
+void __weak __meminit pmd_init(void *addr)
+{
+}
+
 pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
 {
 	pud_t *pud = pud_offset(p4d, addr);
@@ -594,11 +598,16 @@ pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
+		pmd_init(p);
 		pud_populate(&init_mm, pud, p);
 	}
 	return pud;
 }
 
+void __weak __meminit pud_init(void *addr)
+{
+}
+
 p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 {
 	p4d_t *p4d = p4d_offset(pgd, addr);
@@ -606,6 +615,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
+		pud_init(p);
 		p4d_populate(&init_mm, p4d, p);
 	}
 	return p4d;
-- 
2.27.0

