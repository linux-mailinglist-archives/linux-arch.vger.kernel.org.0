Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63D57CB59
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jul 2022 15:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiGUNG0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 09:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiGUNGE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 09:06:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5255F6E;
        Thu, 21 Jul 2022 06:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DDA361E6D;
        Thu, 21 Jul 2022 13:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE129C3411E;
        Thu, 21 Jul 2022 13:04:58 +0000 (UTC)
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
Subject: [PATCH V5 1/4] MIPS&LoongArch: Adjust prototypes of p?d_init()
Date:   Thu, 21 Jul 2022 21:04:16 +0800
Message-Id: <20220721130419.1904711-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220721130419.1904711-1-chenhuacai@loongson.cn>
References: <20220721130419.1904711-1-chenhuacai@loongson.cn>
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

We are preparing to add sparse vmemmap support to LoongArch. MIPS and
LoongArch need to call pgd_init()/pud_init()/pmd_init() when populating
page tables, so adjust their prototypes to make generic helpers can call
them.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/pgalloc.h | 13 ++-----------
 arch/loongarch/include/asm/pgtable.h |  8 ++++----
 arch/loongarch/kernel/numa.c         |  4 ++--
 arch/loongarch/mm/pgtable.c          | 23 +++++++++++++----------
 arch/mips/include/asm/pgalloc.h      |  8 ++++----
 arch/mips/include/asm/pgtable-64.h   |  8 ++++----
 arch/mips/kvm/mmu.c                  |  3 +--
 arch/mips/mm/pgtable-32.c            | 10 +++++-----
 arch/mips/mm/pgtable-64.c            | 18 ++++++++++--------
 arch/mips/mm/pgtable.c               |  2 +-
 10 files changed, 46 insertions(+), 51 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index b0a57b25c131..6a492d7aeeec 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -42,15 +42,6 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
 
 extern void pagetable_init(void);
 
-/*
- * Initialize a new pmd table with invalid pointers.
- */
-extern void pmd_init(unsigned long page, unsigned long pagetable);
-
-/*
- * Initialize a new pgd / pmd table with invalid pointers.
- */
-extern void pgd_init(unsigned long page);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 #define __pte_free_tlb(tlb, pte, address)			\
@@ -76,7 +67,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 	}
 
 	pmd = (pmd_t *)page_address(pg);
-	pmd_init((unsigned long)pmd, (unsigned long)invalid_pte_table);
+	pmd_init(pmd);
 	return pmd;
 }
 
@@ -92,7 +83,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 
 	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
 	if (pud)
-		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
+		pud_init(pud);
 	return pud;
 }
 
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index d9e86cfa53e2..9c811c3f7572 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -243,11 +243,11 @@ extern void set_pmd_at(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp, pm
 #define pfn_pmd(pfn, prot)	__pmd(((pfn) << _PFN_SHIFT) | pgprot_val(prot))
 
 /*
- * Initialize a new pgd / pmd table with invalid pointers.
+ * Initialize a new pgd / pud / pmd table with invalid pointers.
  */
-extern void pgd_init(unsigned long page);
-extern void pud_init(unsigned long page, unsigned long pagetable);
-extern void pmd_init(unsigned long page, unsigned long pagetable);
+extern void pgd_init(void *addr);
+extern void pud_init(void *addr);
+extern void pmd_init(void *addr);
 
 /*
  * Non-present pages:  high 40 bits are offset, next 8 bits type,
diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index a13f92593cfd..eb5d3a4c8a7a 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -78,7 +78,7 @@ void __init pcpu_populate_pte(unsigned long addr)
 		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		pgd_populate(&init_mm, pgd, new);
 #ifndef __PAGETABLE_PUD_FOLDED
-		pud_init((unsigned long)new, (unsigned long)invalid_pmd_table);
+		pud_init(new);
 #endif
 	}
 
@@ -89,7 +89,7 @@ void __init pcpu_populate_pte(unsigned long addr)
 		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		pud_populate(&init_mm, pud, new);
 #ifndef __PAGETABLE_PMD_FOLDED
-		pmd_init((unsigned long)new, (unsigned long)invalid_pte_table);
+		pmd_init(new);
 #endif
 	}
 
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 0569647152e9..e79cc41acac5 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -16,7 +16,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
 	if (ret) {
 		init = pgd_offset(&init_mm, 0UL);
-		pgd_init((unsigned long)ret);
+		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
 		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
 	}
@@ -25,7 +25,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(pgd_alloc);
 
-void pgd_init(unsigned long page)
+void pgd_init(void *addr)
 {
 	unsigned long *p, *end;
 	unsigned long entry;
@@ -38,7 +38,7 @@ void pgd_init(unsigned long page)
 	entry = (unsigned long)invalid_pte_table;
 #endif
 
-	p = (unsigned long *) page;
+	p = (unsigned long *)addr;
 	end = p + PTRS_PER_PGD;
 
 	do {
@@ -56,11 +56,12 @@ void pgd_init(unsigned long page)
 EXPORT_SYMBOL_GPL(pgd_init);
 
 #ifndef __PAGETABLE_PMD_FOLDED
-void pmd_init(unsigned long addr, unsigned long pagetable)
+void pmd_init(void *addr)
 {
 	unsigned long *p, *end;
+	unsigned long pagetable = (unsigned long)invalid_pte_table;
 
-	p = (unsigned long *) addr;
+	p = (unsigned long *)addr;
 	end = p + PTRS_PER_PMD;
 
 	do {
@@ -79,9 +80,10 @@ EXPORT_SYMBOL_GPL(pmd_init);
 #endif
 
 #ifndef __PAGETABLE_PUD_FOLDED
-void pud_init(unsigned long addr, unsigned long pagetable)
+void pud_init(void *addr)
 {
 	unsigned long *p, *end;
+	unsigned long pagetable = (unsigned long)invalid_pmd_table;
 
 	p = (unsigned long *)addr;
 	end = p + PTRS_PER_PUD;
@@ -98,6 +100,7 @@ void pud_init(unsigned long addr, unsigned long pagetable)
 		p[-1] = pagetable;
 	} while (p != end);
 }
+EXPORT_SYMBOL_GPL(pud_init);
 #endif
 
 pmd_t mk_pmd(struct page *page, pgprot_t prot)
@@ -119,12 +122,12 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 void __init pagetable_init(void)
 {
 	/* Initialize the entire pgd.  */
-	pgd_init((unsigned long)swapper_pg_dir);
-	pgd_init((unsigned long)invalid_pg_dir);
+	pgd_init(swapper_pg_dir);
+	pgd_init(invalid_pg_dir);
 #ifndef __PAGETABLE_PUD_FOLDED
-	pud_init((unsigned long)invalid_pud_table, (unsigned long)invalid_pmd_table);
+	pud_init(invalid_pud_table);
 #endif
 #ifndef __PAGETABLE_PMD_FOLDED
-	pmd_init((unsigned long)invalid_pmd_table, (unsigned long)invalid_pte_table);
+	pmd_init(invalid_pmd_table);
 #endif
 }
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 867e9c3db76e..9f7d117c5ebf 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -33,7 +33,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 /*
  * Initialize a new pmd table with invalid pointers.
  */
-extern void pmd_init(unsigned long page, unsigned long pagetable);
+extern void pmd_init(void *addr);
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
@@ -44,9 +44,9 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 #endif
 
 /*
- * Initialize a new pgd / pmd table with invalid pointers.
+ * Initialize a new pgd table with invalid pointers.
  */
-extern void pgd_init(unsigned long page);
+extern void pgd_init(void *addr);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
@@ -77,7 +77,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 	}
 
 	pmd = (pmd_t *)page_address(pg);
-	pmd_init((unsigned long)pmd, (unsigned long)invalid_pte_table);
+	pmd_init(pmd);
 	return pmd;
 }
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 41921acdc9d8..8ac76bbb4b38 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -323,11 +323,11 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 #endif
 
 /*
- * Initialize a new pgd / pmd table with invalid pointers.
+ * Initialize a new pgd / pud / pmd table with invalid pointers.
  */
-extern void pgd_init(unsigned long page);
-extern void pud_init(unsigned long page, unsigned long pagetable);
-extern void pmd_init(unsigned long page, unsigned long pagetable);
+extern void pgd_init(void *addr);
+extern void pud_init(void *addr);
+extern void pmd_init(void *addr);
 
 /*
  * Non-present pages:  high 40 bits are offset, next 8 bits type,
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 1bfd1b501d82..cb10a92ad3ae 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -122,8 +122,7 @@ static pte_t *kvm_mips_walk_pgd(pgd_t *pgd, struct kvm_mmu_memory_cache *cache,
 		if (!cache)
 			return NULL;
 		new_pmd = kvm_mmu_memory_cache_alloc(cache);
-		pmd_init((unsigned long)new_pmd,
-			 (unsigned long)invalid_pte_table);
+		pmd_init(new_pmd);
 		pud_populate(NULL, pud, new_pmd);
 	}
 	pmd = pmd_offset(pud, addr);
diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index 61891af25019..88819a21d97e 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -13,9 +13,9 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
-void pgd_init(unsigned long page)
+void pgd_init(void *addr)
 {
-	unsigned long *p = (unsigned long *) page;
+	unsigned long *p = (unsigned long *)addr;
 	int i;
 
 	for (i = 0; i < USER_PTRS_PER_PGD; i+=8) {
@@ -61,9 +61,9 @@ void __init pagetable_init(void)
 #endif
 
 	/* Initialize the entire pgd.  */
-	pgd_init((unsigned long)swapper_pg_dir);
-	pgd_init((unsigned long)swapper_pg_dir
-		 + sizeof(pgd_t) * USER_PTRS_PER_PGD);
+	pgd_init(swapper_pg_dir);
+	pgd_init((void *)((unsigned long)swapper_pg_dir
+		 + sizeof(pgd_t) * USER_PTRS_PER_PGD));
 
 	pgd_base = swapper_pg_dir;
 
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index 7536f7804c44..b4386a0e2ef8 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -13,7 +13,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
-void pgd_init(unsigned long page)
+void pgd_init(void *addr)
 {
 	unsigned long *p, *end;
 	unsigned long entry;
@@ -26,7 +26,7 @@ void pgd_init(unsigned long page)
 	entry = (unsigned long)invalid_pte_table;
 #endif
 
-	p = (unsigned long *) page;
+	p = (unsigned long *) addr;
 	end = p + PTRS_PER_PGD;
 
 	do {
@@ -43,11 +43,12 @@ void pgd_init(unsigned long page)
 }
 
 #ifndef __PAGETABLE_PMD_FOLDED
-void pmd_init(unsigned long addr, unsigned long pagetable)
+void pmd_init(void *addr)
 {
 	unsigned long *p, *end;
+	unsigned long pagetable = (unsigned long)invalid_pte_table;
 
-	p = (unsigned long *) addr;
+	p = (unsigned long *)addr;
 	end = p + PTRS_PER_PMD;
 
 	do {
@@ -66,9 +67,10 @@ EXPORT_SYMBOL_GPL(pmd_init);
 #endif
 
 #ifndef __PAGETABLE_PUD_FOLDED
-void pud_init(unsigned long addr, unsigned long pagetable)
+void pud_init(void *addr)
 {
 	unsigned long *p, *end;
+	unsigned long pagetable = (unsigned long)invalid_pmd_table;
 
 	p = (unsigned long *)addr;
 	end = p + PTRS_PER_PUD;
@@ -108,12 +110,12 @@ void __init pagetable_init(void)
 	pgd_t *pgd_base;
 
 	/* Initialize the entire pgd.  */
-	pgd_init((unsigned long)swapper_pg_dir);
+	pgd_init(swapper_pg_dir);
 #ifndef __PAGETABLE_PUD_FOLDED
-	pud_init((unsigned long)invalid_pud_table, (unsigned long)invalid_pmd_table);
+	pud_init(invalid_pud_table);
 #endif
 #ifndef __PAGETABLE_PMD_FOLDED
-	pmd_init((unsigned long)invalid_pmd_table, (unsigned long)invalid_pte_table);
+	pmd_init(invalid_pmd_table);
 #endif
 	pgd_base = swapper_pg_dir;
 	/*
diff --git a/arch/mips/mm/pgtable.c b/arch/mips/mm/pgtable.c
index 05560b042d82..98e5e880927a 100644
--- a/arch/mips/mm/pgtable.c
+++ b/arch/mips/mm/pgtable.c
@@ -15,7 +15,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
 	if (ret) {
 		init = pgd_offset(&init_mm, 0UL);
-		pgd_init((unsigned long)ret);
+		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
 		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
 	}
-- 
2.31.1

