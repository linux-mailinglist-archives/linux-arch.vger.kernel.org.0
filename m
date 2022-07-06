Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C2C56825B
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jul 2022 11:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiGFI7s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jul 2022 04:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiGFI7n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jul 2022 04:59:43 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E044619C2C;
        Wed,  6 Jul 2022 01:59:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0VIXd7l-_1657097967;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VIXd7l-_1657097967)
          by smtp.aliyun-inc.com;
          Wed, 06 Jul 2022 16:59:29 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, willy@infradead.org, will@kernel.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        chenhuacai@kernel.org, kernel@xen0n.name,
        tsbogend@alpha.franken.de, dave.hansen@linux.intel.com,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, arnd@arndb.de, guoren@kernel.org,
        monstr@monstr.eu, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        baolin.wang@linux.alibaba.com, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: Add kernel PTE level pagetable pages account
Date:   Wed,  6 Jul 2022 16:59:17 +0800
Message-Id: <398ead25695e530f766849be5edafaf62c1c864d.1657096412.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now the kernel PTE level ptes are always protected by mm->page_table_lock
instead of split pagetable lock, so the kernel PTE level pagetable pages
are not accounted. Especially the vmalloc()/vmap() can consume lots of
kernel pagetable, so to get an accurate pagetable accounting, calling new
helpers page_{set,clear}_pgtable() when allocating or freeing a kernel
PTE level pagetable page.

Meanwhile converting architectures to use corresponding generic PTE pagetable
allocation and freeing functions.

Note this patch only adds accounting to the page tables allocated after boot.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
---
 arch/csky/include/asm/pgalloc.h |  2 +-
 arch/microblaze/mm/pgtable.c    |  2 +-
 arch/openrisc/mm/ioremap.c      |  2 +-
 arch/x86/mm/pgtable.c           |  2 +-
 include/asm-generic/pgalloc.h   | 14 ++++++++++++--
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index 7d57e5d..56f8d25 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -29,7 +29,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	pte_t *pte;
 	unsigned long i;
 
-	pte = (pte_t *) __get_free_page(GFP_KERNEL);
+	pte = __pte_alloc_one_kernel(mm);
 	if (!pte)
 		return NULL;
 
diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
index 9f73265..e96dd1b 100644
--- a/arch/microblaze/mm/pgtable.c
+++ b/arch/microblaze/mm/pgtable.c
@@ -245,7 +245,7 @@ unsigned long iopa(unsigned long addr)
 __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
 	if (mem_init_done)
-		return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		return __pte_alloc_one_kernel(mm);
 	else
 		return memblock_alloc_try_nid(PAGE_SIZE, PAGE_SIZE,
 					      MEMBLOCK_LOW_LIMIT,
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index daae13a..3453acc 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -118,7 +118,7 @@ pte_t __ref *pte_alloc_one_kernel(struct mm_struct *mm)
 	pte_t *pte;
 
 	if (likely(mem_init_done)) {
-		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
+		pte = __pte_alloc_one_kernel(mm);
 	} else {
 		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		if (!pte)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ea39670..20f3076 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -858,7 +858,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 	/* INVLPG to clear all paging-structure caches */
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
 
-	free_page((unsigned long)pte);
+	pte_free_kernel(NULL, pte);
 
 	return 1;
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 8ce8d7c..cd8420f 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -18,7 +18,14 @@
  */
 static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
+	struct page *page;
+	gfp_t gfp = GFP_PGTABLE_KERNEL;
+
+	page = alloc_pages(gfp, 0);
+	if (!page)
+		return NULL;
+	page_set_pgtable(page);
+	return (pte_t *)page_address(page);
 }
 
 #ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
@@ -41,7 +48,10 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
  */
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long)pte);
+	struct page *page = virt_to_page(pte);
+
+	page_clear_pgtable(page);
+	__free_page(page);
 }
 
 /**
-- 
1.8.3.1

