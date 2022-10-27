Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89C360F835
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiJ0M4x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 08:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiJ0M4w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 08:56:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD916EA0D;
        Thu, 27 Oct 2022 05:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E280B82630;
        Thu, 27 Oct 2022 12:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B048C433C1;
        Thu, 27 Oct 2022 12:56:41 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V14 3/4] mm/sparse-vmemmap: Generalise vmemmap_populate_hugepages()
Date:   Thu, 27 Oct 2022 20:52:52 +0800
Message-Id: <20221027125253.3458989-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221027125253.3458989-1-chenhuacai@loongson.cn>
References: <20221027125253.3458989-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

Generalise vmemmap_populate_hugepages() so ARM64 & X86 & LoongArch can
share its implementation.

Acked-by: Will Deacon <will@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/arm64/mm/mmu.c      | 55 +++++++-----------------
 arch/loongarch/mm/init.c | 59 +++++++-------------------
 arch/x86/mm/init_64.c    | 92 ++++++++++++++--------------------------
 include/linux/mm.h       |  6 +++
 mm/sparse-vmemmap.c      | 63 +++++++++++++++++++++++++++
 5 files changed, 132 insertions(+), 143 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9a7c38965154..e3822cb0118b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1184,53 +1184,28 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 }
 #endif
 
+void __meminit vmemmap_set_pmd(pmd_t *pmdp, void *p, int node,
+			       unsigned long addr, unsigned long next)
+{
+	pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
+}
+
+int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
+				unsigned long addr, unsigned long next)
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
 
 	if (!ARM64_KERNEL_USES_PMD_MAPS)
 		return vmemmap_populate_basepages(start, end, node, altmap);
-
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
+	else
+		return vmemmap_populate_hugepages(start, end, node, altmap);
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 451d93667bcc..e018aed34586 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -153,52 +153,25 @@ EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-static int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
-						int node, struct vmem_altmap *altmap)
+void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
+			       unsigned long addr, unsigned long next)
 {
-	unsigned long addr = start;
-	unsigned long next;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
+	pmd_t entry;
 
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
+	entry = pfn_pmd(virt_to_pfn(p), PAGE_KERNEL);
+	pmd_val(entry) |= _PAGE_HUGE | _PAGE_HGLOBAL;
+	set_pmd_at(&init_mm, addr, pmd, entry);
+}
+
+int __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
+				unsigned long addr, unsigned long next)
+{
+	int huge = pmd_val(*pmd) & _PAGE_HUGE;
+
+	if (huge)
+		vmemmap_verify((pte_t *)pmd, node, addr, next);
 
-	return 0;
+	return huge;
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end,
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3f040c6e5d13..58febaf569f6 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1533,72 +1533,44 @@ static long __meminitdata addr_start, addr_end;
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
+int __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
+				unsigned long addr, unsigned long next)
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
index 45eb04c43c6b..2eb88b63a0e0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3246,8 +3246,14 @@ struct vmem_altmap;
 void *vmemmap_alloc_block_buf(unsigned long size, int node,
 			      struct vmem_altmap *altmap);
 void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
+void vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
+		     unsigned long addr, unsigned long next);
+int vmemmap_check_pmd(pmd_t *pmd, int node,
+		      unsigned long addr, unsigned long next);
 int vmemmap_populate_basepages(unsigned long start, unsigned long end,
 			       int node, struct vmem_altmap *altmap);
+int vmemmap_populate_hugepages(unsigned long start, unsigned long end,
+			       int node, struct vmem_altmap *altmap);
 int vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap);
 void vmemmap_populate_print_last(void);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 797b30e9050c..c5398a5960d0 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -295,6 +295,69 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 	return vmemmap_populate_range(start, end, node, altmap, NULL);
 }
 
+void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
+				      unsigned long addr, unsigned long next)
+{
+}
+
+int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
+				       unsigned long addr, unsigned long next)
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
+			} else if (altmap) {
+				/*
+				 * No fallback: In any case we care about, the
+				 * altmap should be reasonably sized and aligned
+				 * such that vmemmap_alloc_block_buf() will always
+				 * succeed. For consistency with the PTE case,
+				 * return an error here as failure could indicate
+				 * a configuration issue with the size of the altmap.
+				 */
+				return -ENOMEM;
+			}
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
2.31.1

