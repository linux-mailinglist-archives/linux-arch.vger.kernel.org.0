Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54482565354
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 13:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiGDL0S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 07:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiGDL0S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 07:26:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4472101F7;
        Mon,  4 Jul 2022 04:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D753B80EE4;
        Mon,  4 Jul 2022 11:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544E2C341D0;
        Mon,  4 Jul 2022 11:26:09 +0000 (UTC)
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
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V4 3/4] mm/sparse-vmemmap: Generalise vmemmap_populate_hugepages()
Date:   Mon,  4 Jul 2022 19:25:25 +0800
Message-Id: <20220704112526.2492342-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220704112526.2492342-1-chenhuacai@loongson.cn>
References: <20220704112526.2492342-1-chenhuacai@loongson.cn>
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

Generalise vmemmap_populate_hugepages() so ARM64 & X86 & LoongArch can
share its implementation.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/arm64/mm/mmu.c      | 53 ++++++-----------------
 arch/loongarch/mm/init.c | 63 ++++++++-------------------
 arch/x86/mm/init_64.c    | 92 ++++++++++++++--------------------------
 include/linux/mm.h       |  6 +++
 mm/sparse-vmemmap.c      | 54 +++++++++++++++++++++++
 5 files changed, 124 insertions(+), 144 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 626ec32873c6..b080a65c719d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1158,49 +1158,24 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	return vmemmap_populate_basepages(start, end, node, altmap);
 }
 #else	/* !ARM64_KERNEL_USES_PMD_MAPS */
+void __meminit vmemmap_set_pmd(pmd_t *pmdp, void *p, int node,
+			       unsigned long addr, unsigned long next)
+{
+	pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
+}
+
+int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node, unsigned long addr,
+				unsigned long next)
+{
+	vmemmap_verify((pte_t *)pmdp, node, addr, next);
+	return 1;
+}
+
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
-	unsigned long addr = start;
-	unsigned long next;
-	pgd_t *pgdp;
-	p4d_t *p4dp;
-	pud_t *pudp;
-	pmd_t *pmdp;
-
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
-	do {
-		next = pmd_addr_end(addr, end);
-
-		pgdp = vmemmap_pgd_populate(addr, node);
-		if (!pgdp)
-			return -ENOMEM;
-
-		p4dp = vmemmap_p4d_populate(pgdp, addr, node);
-		if (!p4dp)
-			return -ENOMEM;
-
-		pudp = vmemmap_pud_populate(p4dp, addr, node);
-		if (!pudp)
-			return -ENOMEM;
-
-		pmdp = pmd_offset(pudp, addr);
-		if (pmd_none(READ_ONCE(*pmdp))) {
-			void *p = NULL;
-
-			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
-			if (!p) {
-				if (vmemmap_populate_basepages(addr, next, node, altmap))
-					return -ENOMEM;
-				continue;
-			}
-
-			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
-		} else
-			vmemmap_verify((pte_t *)pmdp, node, addr, next);
-	} while (addr = next, addr != end);
-
-	return 0;
+	return vmemmap_populate_hugepages(start, end, node, altmap);
 }
 #endif	/* !ARM64_KERNEL_USES_PMD_MAPS */
 
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 35128229fe46..3190b3cd52d1 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -158,52 +158,25 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
+void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
+			       unsigned long addr, unsigned long next)
 {
-	unsigned long addr = start;
-	unsigned long next;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	for (addr = start; addr < end; addr = next) {
-		next = pmd_addr_end(addr, end);
-
-		pgd = vmemmap_pgd_populate(addr, node);
-		if (!pgd)
-			return -ENOMEM;
-		p4d = vmemmap_p4d_populate(pgd, addr, node);
-		if (!p4d)
-			return -ENOMEM;
-		pud = vmemmap_pud_populate(p4d, addr, node);
-		if (!pud)
-			return -ENOMEM;
-
-		pmd = pmd_offset(pud, addr);
-		if (pmd_none(*pmd)) {
-			void *p = NULL;
-
-			p = vmemmap_alloc_block_buf(PMD_SIZE, node, NULL);
-			if (p) {
-				pmd_t entry;
-
-				entry = pfn_pmd(virt_to_pfn(p), PAGE_KERNEL);
-				pmd_val(entry) |= _PAGE_HUGE | _PAGE_HGLOBAL;
-				set_pmd_at(&init_mm, addr, pmd, entry);
-
-				continue;
-			}
-		} else if (pmd_val(*pmd) & _PAGE_HUGE) {
-			vmemmap_verify((pte_t *)pmd, node, addr, next);
-			continue;
-		}
-		if (vmemmap_populate_basepages(addr, next, node, NULL))
-			return -ENOMEM;
-	}
-
-	return 0;
+	pmd_t entry;
+
+	entry = pfn_pmd(virt_to_pfn(p), PAGE_KERNEL);
+	pmd_val(entry) |= _PAGE_HUGE | _PAGE_HGLOBAL;
+	set_pmd_at(&init_mm, addr, pmd, entry);
+}
+
+int __meminit vmemmap_check_pmd(pmd_t *pmd, int node, unsigned long addr,
+				unsigned long next)
+{
+	int huge = pmd_val(*pmd) & _PAGE_HUGE;
+
+	if (huge)
+		vmemmap_verify((pte_t *)pmd, node, addr, next);
+
+	return huge;
 }
 
 #if CONFIG_PGTABLE_LEVELS == 2
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 39c5246964a9..4911093ee2f3 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1532,72 +1532,44 @@ static long __meminitdata addr_start, addr_end;
 static void __meminitdata *p_start, *p_end;
 static int __meminitdata node_start;
 
-static int __meminit vmemmap_populate_hugepages(unsigned long start,
-		unsigned long end, int node, struct vmem_altmap *altmap)
+void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
+			       unsigned long addr, unsigned long next)
 {
-	unsigned long addr;
-	unsigned long next;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	for (addr = start; addr < end; addr = next) {
-		next = pmd_addr_end(addr, end);
-
-		pgd = vmemmap_pgd_populate(addr, node);
-		if (!pgd)
-			return -ENOMEM;
-
-		p4d = vmemmap_p4d_populate(pgd, addr, node);
-		if (!p4d)
-			return -ENOMEM;
-
-		pud = vmemmap_pud_populate(p4d, addr, node);
-		if (!pud)
-			return -ENOMEM;
-
-		pmd = pmd_offset(pud, addr);
-		if (pmd_none(*pmd)) {
-			void *p;
-
-			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
-			if (p) {
-				pte_t entry;
-
-				entry = pfn_pte(__pa(p) >> PAGE_SHIFT,
-						PAGE_KERNEL_LARGE);
-				set_pmd(pmd, __pmd(pte_val(entry)));
+	pte_t entry;
+
+	entry = pfn_pte(__pa(p) >> PAGE_SHIFT,
+			PAGE_KERNEL_LARGE);
+	set_pmd(pmd, __pmd(pte_val(entry)));
+
+	/* check to see if we have contiguous blocks */
+	if (p_end != p || node_start != node) {
+		if (p_start)
+			pr_debug(" [%lx-%lx] PMD -> [%p-%p] on node %d\n",
+				addr_start, addr_end-1, p_start, p_end-1, node_start);
+		addr_start = addr;
+		node_start = node;
+		p_start = p;
+	}
 
-				/* check to see if we have contiguous blocks */
-				if (p_end != p || node_start != node) {
-					if (p_start)
-						pr_debug(" [%lx-%lx] PMD -> [%p-%p] on node %d\n",
-						       addr_start, addr_end-1, p_start, p_end-1, node_start);
-					addr_start = addr;
-					node_start = node;
-					p_start = p;
-				}
+	addr_end = addr + PMD_SIZE;
+	p_end = p + PMD_SIZE;
 
-				addr_end = addr + PMD_SIZE;
-				p_end = p + PMD_SIZE;
+	if (!IS_ALIGNED(addr, PMD_SIZE) ||
+		!IS_ALIGNED(next, PMD_SIZE))
+		vmemmap_use_new_sub_pmd(addr, next);
+}
 
-				if (!IS_ALIGNED(addr, PMD_SIZE) ||
-				    !IS_ALIGNED(next, PMD_SIZE))
-					vmemmap_use_new_sub_pmd(addr, next);
+int __meminit vmemmap_check_pmd(pmd_t *pmd, int node, unsigned long addr,
+				unsigned long next)
+{
+	int large = pmd_large(*pmd);
 
-				continue;
-			} else if (altmap)
-				return -ENOMEM; /* no fallback */
-		} else if (pmd_large(*pmd)) {
-			vmemmap_verify((pte_t *)pmd, node, addr, next);
-			vmemmap_use_sub_pmd(addr, next);
-			continue;
-		}
-		if (vmemmap_populate_basepages(addr, next, node, NULL))
-			return -ENOMEM;
+	if (pmd_large(*pmd)) {
+		vmemmap_verify((pte_t *)pmd, node, addr, next);
+		vmemmap_use_sub_pmd(addr, next);
 	}
-	return 0;
+
+	return large;
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f6ed6bc0a65f..894d59e1ffd6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3216,8 +3216,14 @@ struct vmem_altmap;
 void *vmemmap_alloc_block_buf(unsigned long size, int node,
 			      struct vmem_altmap *altmap);
 void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
+void vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
+		     unsigned long addr, unsigned long next);
+int vmemmap_check_pmd(pmd_t *pmd, int node, unsigned long addr,
+		      unsigned long next);
 int vmemmap_populate_basepages(unsigned long start, unsigned long end,
 			       int node, struct vmem_altmap *altmap);
+int vmemmap_populate_hugepages(unsigned long start, unsigned long end,
+			       int node, struct vmem_altmap *altmap);
 int vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap);
 void vmemmap_populate_print_last(void);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 33e2a1ceee72..6f2e40bb695d 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -686,6 +686,60 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 	return vmemmap_populate_range(start, end, node, altmap, NULL);
 }
 
+void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
+				      unsigned long addr, unsigned long next)
+{
+}
+
+int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node, unsigned long addr,
+				       unsigned long next)
+{
+	return 0;
+}
+
+int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
+					 int node, struct vmem_altmap *altmap)
+{
+	unsigned long addr;
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
+
+		p4d = vmemmap_p4d_populate(pgd, addr, node);
+		if (!p4d)
+			return -ENOMEM;
+
+		pud = vmemmap_pud_populate(p4d, addr, node);
+		if (!pud)
+			return -ENOMEM;
+
+		pmd = pmd_offset(pud, addr);
+		if (pmd_none(READ_ONCE(*pmd))) {
+			void *p;
+
+			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
+			if (p) {
+				vmemmap_set_pmd(pmd, p, node, addr, next);
+				continue;
+			} else if (altmap)
+				return -ENOMEM; /* no fallback */
+		} else if (vmemmap_check_pmd(pmd, node, addr, next))
+			continue;
+		if (vmemmap_populate_basepages(addr, next, node, altmap))
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 /*
  * For compound pages bigger than section size (e.g. x86 1G compound
  * pages with 2M subsection size) fill the rest of sections as tail
-- 
2.27.0

