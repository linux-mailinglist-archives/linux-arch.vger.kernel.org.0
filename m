Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6377054F9B9
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiFQO5f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382930AbiFQO5e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 10:57:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E671F620
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 07:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D998B82AD5
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 14:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BE0C3411B;
        Fri, 17 Jun 2022 14:57:25 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Min Zhou <zhoumin@loongson.cn>
Subject: [PATCH] LoongArch: Add sparse memory vmemmap support
Date:   Fri, 17 Jun 2022 22:58:59 +0800
Message-Id: <20220617145859.582176-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
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

Add sparse memory vmemmap support for LoongArch. SPARSEMEM_VMEMMAP
uses a virtually mapped memmap to optimise pfn_to_page and page_to_pfn
operations. This is the most efficient option when sufficient kernel
resources are available.

Signed-off-by: Min Zhou <zhoumin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                 |   1 +
 arch/loongarch/include/asm/pgtable.h   |   5 +-
 arch/loongarch/include/asm/sparsemem.h |   8 ++
 arch/loongarch/mm/init.c               | 184 ++++++++++++++++++++++++-
 4 files changed, 196 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index dc19cf3071ea..55ab84fd70e5 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -422,6 +422,7 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
+	select SPARSEMEM_VMEMMAP_ENABLE
 	help
 	  Say Y to support efficient handling of sparse physical memory,
 	  for architectures which are either NUMA (Non-Uniform Memory Access)
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 5dc84d8f18d6..3b8725fc6693 100644
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
index 7094a68c9b83..9b65deab6f14 100644
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
@@ -157,6 +157,188 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 #endif
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+void __meminit arch_vmemmap_verify(pte_t *pte, int node,
+				unsigned long start, unsigned long end)
+{
+	unsigned long pfn = pte_pfn(*pte);
+	int actual_node = early_pfn_to_nid(pfn);
+
+	if (node_distance(actual_node, node) > LOCAL_DISTANCE)
+		pr_warn("[%lx-%lx] potential offnode page_structs\n",
+			start, end - 1);
+}
+
+void * __meminit arch_vmemmap_alloc_block_zero(unsigned long size, int node)
+{
+	void *p = vmemmap_alloc_block(size, node);
+
+	if (!p)
+		return NULL;
+	memset(p, 0, size);
+
+	return p;
+}
+
+pte_t * __meminit arch_vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node)
+{
+	pte_t *pte = pte_offset_kernel(pmd, addr);
+	if (pte_none(*pte)) {
+		pte_t entry;
+		void *p = arch_vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		if (!p)
+			return NULL;
+		entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
+		set_pte_at(&init_mm, addr, pte, entry);
+	}
+	return pte;
+}
+
+pmd_t * __meminit arch_vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
+{
+	pmd_t *pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd)) {
+		void *p = arch_vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		if (!p)
+			return NULL;
+		pmd_populate_kernel(&init_mm, pmd, p);
+	}
+	return pmd;
+}
+
+pud_t * __meminit arch_vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
+{
+	pud_t *pud = pud_offset(p4d, addr);
+	if (pud_none(*pud)) {
+		void *p = arch_vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		if (!p)
+			return NULL;
+#ifndef __PAGETABLE_PMD_FOLDED
+		pmd_init((unsigned long)p, (unsigned long)invalid_pte_table);
+#endif
+		pud_populate(&init_mm, pud, p);
+	}
+	return pud;
+}
+
+p4d_t * __meminit arch_vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
+{
+	p4d_t *p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d)) {
+		void *p = arch_vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		if (!p)
+			return NULL;
+#ifndef __PAGETABLE_PUD_FOLDED
+		pud_init((unsigned long)p, (unsigned long)invalid_pmd_table);
+#endif
+		p4d_populate(&init_mm, p4d, p);
+	}
+	return p4d;
+}
+
+pgd_t * __meminit arch_vmemmap_pgd_populate(unsigned long addr, int node)
+{
+	pgd_t *pgd = pgd_offset_k(addr);
+	if (pgd_none(*pgd)) {
+		void *p = arch_vmemmap_alloc_block_zero(PAGE_SIZE, node);
+		if (!p)
+			return NULL;
+		pgd_populate(&init_mm, pgd, p);
+	}
+	return pgd;
+}
+
+int __meminit arch_vmemmap_populate_basepages(unsigned long start,
+					 unsigned long end, int node)
+{
+	unsigned long addr = start;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		pgd = arch_vmemmap_pgd_populate(addr, node);
+		if (!pgd)
+			return -ENOMEM;
+		p4d = arch_vmemmap_p4d_populate(pgd, addr, node);
+		if (!p4d)
+			return -ENOMEM;
+		pud = arch_vmemmap_pud_populate(p4d, addr, node);
+		if (!pud)
+			return -ENOMEM;
+		pmd = arch_vmemmap_pmd_populate(pud, addr, node);
+		if (!pmd)
+			return -ENOMEM;
+		pte = arch_vmemmap_pte_populate(pmd, addr, node);
+		if (!pte)
+			return -ENOMEM;
+		arch_vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
+	}
+
+	return 0;
+}
+
+int __meminit arch_vmemmap_populate_hugepages(unsigned long start,
+					 unsigned long end, int node)
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
+		pgd = arch_vmemmap_pgd_populate(addr, node);
+		if (!pgd)
+			return -ENOMEM;
+		p4d = arch_vmemmap_p4d_populate(pgd, addr, node);
+		if (!p4d)
+			return -ENOMEM;
+		pud = arch_vmemmap_pud_populate(p4d, addr, node);
+		if (!pud)
+			return -ENOMEM;
+
+		pmd = pmd_offset(pud, addr);
+		if (pmd_none(*pmd)) {
+			void *p = NULL;
+
+			p = arch_vmemmap_alloc_block_zero(PMD_SIZE, node);
+			if (p) {
+				pmd_t entry;
+
+				entry = pfn_pmd(virt_to_pfn(p), PAGE_KERNEL);
+				entry = pmd_mkhuge(entry);
+				set_pmd_at(&init_mm, addr, pmd, entry);
+
+				continue;
+			}
+		} else if (pmd_huge(*pmd)) {
+			arch_vmemmap_verify((pte_t *)pmd, node, addr, next);
+			continue;
+		}
+		if (arch_vmemmap_populate_basepages(addr, next, node))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
+		struct vmem_altmap *altmap)
+{
+	return arch_vmemmap_populate_hugepages(start, end, node);
+}
+void vmemmap_free(unsigned long start, unsigned long end,
+		struct vmem_altmap *altmap)
+{
+}
+#endif
+
 /*
  * Align swapper_pg_dir in to 64K, allows its address to be loaded
  * with a single LUI instruction in the TLB handlers.  If we used
-- 
2.27.0

