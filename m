Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4F7A414C
	for <lists+linux-arch@lfdr.de>; Mon, 18 Sep 2023 08:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjIRGdh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Sep 2023 02:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbjIRGdZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2023 02:33:25 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDC71B9;
        Sun, 17 Sep 2023 23:31:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VsH48PF_1695018713;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VsH48PF_1695018713)
          by smtp.aliyun-inc.com;
          Mon, 18 Sep 2023 14:31:54 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     will@kernel.org, aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        chenhuacai@kernel.org, tsbogend@alpha.franken.de,
        dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, arnd@arndb.de, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org
Subject: [PATCH] mm: add statistics for PUD level pagetable
Date:   Mon, 18 Sep 2023 14:31:42 +0800
Message-Id: <876c71c03a7e69c17722a690e3225a4f7b172fb2.1695017383.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Recently, we found that cross-die access to pagetable pages on ARM64
machines can cause performance fluctuations in our business. Currently,
there are no PMU events available to track this situation on our ARM64
machines, so an accurate pagetable accounting can help to analyze this
issue, but now the PUD level pagetable accounting is missed.

So introducing pagetable_pud_ctor/dtor() to help to get an accurate
PUD pagetable accounting, as well as converting the architectures with
using generic PUD pagatable allocation to add corresponding PUD pagetable
accounting. Moreover this patch will also mark the PUD level pagetable
with PG_table flag, which will help to do sanity validation in unpoison_memory().

On my testing machine, I can see more pagetables statistics after the patch
with page-types tool:

Before patch:
        flags           page-count      MB  symbolic-flags                     long-symbolic-flags
0x0000000004000000           27326      106  __________________________g_________________       pgtable
After patch:
0x0000000004000000           27541      107  __________________________g_________________       pgtable

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/arm64/include/asm/tlb.h         |  5 ++++-
 arch/loongarch/include/asm/pgalloc.h |  1 +
 arch/mips/include/asm/pgalloc.h      |  1 +
 arch/x86/mm/pgtable.c                |  3 +++
 include/asm-generic/pgalloc.h        |  7 ++++++-
 include/linux/mm.h                   | 16 ++++++++++++++++
 6 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 2c29239d05c3..846c563689a8 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -96,7 +96,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
-	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pudp));
+	struct ptdesc *ptdesc = virt_to_ptdesc(pudp);
+
+	pagetable_pud_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
 
diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index 79470f0b4f1d..4e2d6b7ca2ee 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -84,6 +84,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 
 	if (!ptdesc)
 		return NULL;
+	pagetable_pud_ctor(ptdesc);
 	pud = ptdesc_address(ptdesc);
 
 	pud_init(pud);
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 40e40a7eb94a..f4440edcd8fe 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -95,6 +95,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 
 	if (!ptdesc)
 		return NULL;
+	pagetable_pud_ctor(ptdesc);
 	pud = ptdesc_address(ptdesc);
 
 	pud_init(pud);
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 9deadf517f14..0cbc1b8e8e3d 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -76,6 +76,9 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
+
+	pagetable_pud_dtor(ptdesc);
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index c75d4a753849..879e5f8aa5e9 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -169,6 +169,8 @@ static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 	ptdesc = pagetable_alloc(gfp, 0);
 	if (!ptdesc)
 		return NULL;
+
+	pagetable_pud_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 
@@ -190,8 +192,11 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 
 static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
+
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	pagetable_free(virt_to_ptdesc(pud));
+	pagetable_pud_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PUD_FREE
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 12335de50140..2232bfebb88a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3049,6 +3049,22 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 	return ptl;
 }
 
+static inline void pagetable_pud_ctor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+}
+
+static inline void pagetable_pud_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.39.3

