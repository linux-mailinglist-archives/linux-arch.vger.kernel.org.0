Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3AD13D498
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 07:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgAPGqj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jan 2020 01:46:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726872AbgAPGqi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jan 2020 01:46:38 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00G6j0GG120077;
        Thu, 16 Jan 2020 01:46:22 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhbptej3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 01:46:21 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00G6jjjX031148;
        Thu, 16 Jan 2020 06:46:21 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 2xf758evej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 06:46:21 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00G6kJ2D57999656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 06:46:19 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4FE46E058;
        Thu, 16 Jan 2020 06:46:19 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5404F6E053;
        Thu, 16 Jan 2020 06:46:16 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.45.56])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jan 2020 06:46:16 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org,
        mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v4 9/9] asm-generic/tlb: Provide MMU_GATHER_TABLE_FREE
Date:   Thu, 16 Jan 2020 12:15:31 +0530
Message-Id: <20200116064531.483522-10-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_02:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=906 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=2 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001160055
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

As described in the comment, the correct order for freeing pages is:

 1) unhook page
 2) TLB invalidate page
 3) free page

This order equally applies to page directories.

Currently there are two correct options:

 - use tlb_remove_page(), when all page directores are full pages and
   there are no futher contraints placed by things like software
   walkers (HAVE_FAST_GUP).

 - use MMU_GATHER_RCU_TABLE_FREE and tlb_remove_table() when the
   architecture does not do IPI based TLB invalidate and has
   HAVE_FAST_GUP (or software TLB fill).

This however leaves architectures that don't have page based
directories but don't need RCU in a bind. For those, provide
MMU_GATHER_TABLE_FREE, which provides the independent batching for
directories without the additional RCU freeing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/Kconfig               |   5 ++
 arch/arm/include/asm/tlb.h |   4 --
 include/asm-generic/tlb.h  |  72 +++++++++++-----------
 mm/mmu_gather.c            | 120 +++++++++++++++++++++++++++----------
 4 files changed, 130 insertions(+), 71 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c35668fbf4d4..98de654b79b3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -393,8 +393,12 @@ config HAVE_ARCH_JUMP_LABEL
 config HAVE_ARCH_JUMP_LABEL_RELATIVE
 	bool
 
+config MMU_GATHER_TABLE_FREE
+	bool
+
 config MMU_GATHER_RCU_TABLE_FREE
 	bool
+	select MMU_GATHER_TABLE_FREE
 
 config MMU_GATHER_PAGE_SIZE
 	bool
@@ -404,6 +408,7 @@ config MMU_GATHER_NO_RANGE
 
 config MMU_GATHER_NO_GATHER
 	bool
+	depends on MMU_GATHER_TABLE_FREE
 
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 46a21cee3442..4d4e7b6aabff 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -37,10 +37,6 @@ static inline void __tlb_remove_table(void *_table)
 
 #include <asm-generic/tlb.h>
 
-#ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
-#define tlb_remove_table(tlb, entry) tlb_remove_page(tlb, entry)
-#endif
-
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index ca0fe75b5355..f391f6b500b4 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -56,6 +56,15 @@
  *    Defaults to flushing at tlb_end_vma() to reset the range; helps when
  *    there's large holes between the VMAs.
  *
+ *  - tlb_remove_table()
+ *
+ *    tlb_remove_table() is the basic primitive to free page-table directories
+ *    (__p*_free_tlb()).  In it's most primitive form it is an alias for
+ *    tlb_remove_page() below, for when page directories are pages and have no
+ *    additional constraints.
+ *
+ *    See also MMU_GATHER_TABLE_FREE and MMU_GATHER_RCU_TABLE_FREE.
+ *
  *  - tlb_remove_page() / __tlb_remove_page()
  *  - tlb_remove_page_size() / __tlb_remove_page_size()
  *
@@ -129,17 +138,24 @@
  *  This might be useful if your architecture has size specific TLB
  *  invalidation instructions.
  *
- *  MMU_GATHER_RCU_TABLE_FREE
+ *  MMU_GATHER_TABLE_FREE
  *
  *  This provides tlb_remove_table(), to be used instead of tlb_remove_page()
- *  for page directores (__p*_free_tlb()). This provides separate freeing of
- *  the page-table pages themselves in a semi-RCU fashion (see comment below).
- *  Useful if your architecture doesn't use IPIs for remote TLB invalidates
- *  and therefore doesn't naturally serialize with software page-table walkers.
+ *  for page directores (__p*_free_tlb()).
+ *
+ *  Useful if your architecture has non-page page directories.
  *
  *  When used, an architecture is expected to provide __tlb_remove_table()
  *  which does the actual freeing of these pages.
  *
+ *  MMU_GATHER_RCU_TABLE_FREE
+ *
+ *  Like MMU_GATHER_TABLE_FREE, and adds semi-RCU semantics to the free (see
+ *  comment below).
+ *
+ *  Useful if your architecture doesn't use IPIs for remote TLB invalidates
+ *  and therefore doesn't naturally serialize with software page-table walkers.
+ *
  *  MMU_GATHER_NO_RANGE
  *
  *  Use this if your architecture lacks an efficient flush_tlb_range().
@@ -155,37 +171,12 @@
  *  various ptep_get_and_clear() functions.
  */
 
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
-/*
- * Semi RCU freeing of the page directories.
- *
- * This is needed by some architectures to implement software pagetable walkers.
- *
- * gup_fast() and other software pagetable walkers do a lockless page-table
- * walk and therefore needs some synchronization with the freeing of the page
- * directories. The chosen means to accomplish that is by disabling IRQs over
- * the walk.
- *
- * Architectures that use IPIs to flush TLBs will then automagically DTRT,
- * since we unlink the page, flush TLBs, free the page. Since the disabling of
- * IRQs delays the completion of the TLB flush we can never observe an already
- * freed page.
- *
- * Architectures that do not have this (PPC) need to delay the freeing by some
- * other means, this is that means.
- *
- * What we do is batch the freed directory pages (tables) and RCU free them.
- * We use the sched RCU variant, as that guarantees that IRQ/preempt disabling
- * holds off grace periods.
- *
- * However, in order to batch these pages we need to allocate storage, this
- * allocation is deep inside the MM code and can thus easily fail on memory
- * pressure. To guarantee progress we fall back to single table freeing, see
- * the implementation of tlb_remove_table_one().
- *
- */
+#ifdef CONFIG_MMU_GATHER_TABLE_FREE
+
 struct mmu_table_batch {
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	struct rcu_head		rcu;
+#endif
 	unsigned int		nr;
 	void			*tables[0];
 };
@@ -195,6 +186,17 @@ struct mmu_table_batch {
 
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
+#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
+
+/*
+ * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
+ * page directories and we can use the normal page batching to free them.
+ */
+#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
+
+#endif /* CONFIG_MMU_GATHER_TABLE_FREE */
+
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 /*
  * This allows an architecture that does not use the linux page-tables for
  * hardware to skip the TLBI when freeing page tables.
@@ -248,7 +250,7 @@ extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
 struct mmu_gather {
 	struct mm_struct	*mm;
 
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_TABLE_FREE
 	struct mmu_table_batch	*batch;
 #endif
 
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index a28c74328085..a3538cb2bcbe 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -91,56 +91,106 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 
 #endif /* MMU_GATHER_NO_GATHER */
 
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_TABLE_FREE
 
-/*
- * See the comment near struct mmu_table_batch.
- */
+static void __tlb_remove_table_free(struct mmu_table_batch *batch)
+{
+	int i;
+
+	for (i = 0; i < batch->nr; i++)
+		__tlb_remove_table(batch->tables[i]);
+
+	free_page((unsigned long)batch);
+}
+
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 
 /*
- * If we want tlb_remove_table() to imply TLB invalidates.
+ * Semi RCU freeing of the page directories.
+ *
+ * This is needed by some architectures to implement software pagetable walkers.
+ *
+ * gup_fast() and other software pagetable walkers do a lockless page-table
+ * walk and therefore needs some synchronization with the freeing of the page
+ * directories. The chosen means to accomplish that is by disabling IRQs over
+ * the walk.
+ *
+ * Architectures that use IPIs to flush TLBs will then automagically DTRT,
+ * since we unlink the page, flush TLBs, free the page. Since the disabling of
+ * IRQs delays the completion of the TLB flush we can never observe an already
+ * freed page.
+ *
+ * Architectures that do not have this (PPC) need to delay the freeing by some
+ * other means, this is that means.
+ *
+ * What we do is batch the freed directory pages (tables) and RCU free them.
+ * We use the sched RCU variant, as that guarantees that IRQ/preempt disabling
+ * holds off grace periods.
+ *
+ * However, in order to batch these pages we need to allocate storage, this
+ * allocation is deep inside the MM code and can thus easily fail on memory
+ * pressure. To guarantee progress we fall back to single table freeing, see
+ * the implementation of tlb_remove_table_one().
+ *
  */
-static inline void tlb_table_invalidate(struct mmu_gather *tlb)
-{
-	if (tlb_needs_table_invalidate()) {
-		/*
-		 * Invalidate page-table caches used by hardware walkers. Then
-		 * we still need to RCU-sched wait while freeing the pages
-		 * because software walkers can still be in-flight.
-		 */
-		tlb_flush_mmu_tlbonly(tlb);
-	}
-}
 
 static void tlb_remove_table_smp_sync(void *arg)
 {
 	/* Simply deliver the interrupt */
 }
 
-static void tlb_remove_table_one(void *table)
+static void tlb_remove_table_sync_one(void)
 {
 	/*
 	 * This isn't an RCU grace period and hence the page-tables cannot be
 	 * assumed to be actually RCU-freed.
 	 *
 	 * It is however sufficient for software page-table walkers that rely on
-	 * IRQ disabling. See the comment near struct mmu_table_batch.
+	 * IRQ disabling.
 	 */
 	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
-	__tlb_remove_table(table);
 }
 
 static void tlb_remove_table_rcu(struct rcu_head *head)
 {
-	struct mmu_table_batch *batch;
-	int i;
+	__tlb_remove_table_free(container_of(head, struct mmu_table_batch, rcu));
+}
 
-	batch = container_of(head, struct mmu_table_batch, rcu);
+static void tlb_remove_table_free(struct mmu_table_batch *batch)
+{
+	call_rcu(&batch->rcu, tlb_remove_table_rcu);
+}
 
-	for (i = 0; i < batch->nr; i++)
-		__tlb_remove_table(batch->tables[i]);
+#else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
-	free_page((unsigned long)batch);
+static void tlb_remove_table_sync_one(void) { }
+
+static void tlb_remove_table_free(struct mmu_table_batch *batch)
+{
+	__tlb_remove_table_free(batch);
+}
+
+#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
+
+/*
+ * If we want tlb_remove_table() to imply TLB invalidates.
+ */
+static inline void tlb_table_invalidate(struct mmu_gather *tlb)
+{
+	if (tlb_needs_table_invalidate()) {
+		/*
+		 * Invalidate page-table caches used by hardware walkers. Then
+		 * we still need to RCU-sched wait while freeing the pages
+		 * because software walkers can still be in-flight.
+		 */
+		tlb_flush_mmu_tlbonly(tlb);
+	}
+}
+
+static void tlb_remove_table_one(void *table)
+{
+	tlb_remove_table_sync_one();
+	__tlb_remove_table(table);
 }
 
 static void tlb_table_flush(struct mmu_gather *tlb)
@@ -149,7 +199,7 @@ static void tlb_table_flush(struct mmu_gather *tlb)
 
 	if (*batch) {
 		tlb_table_invalidate(tlb);
-		call_rcu(&(*batch)->rcu, tlb_remove_table_rcu);
+		tlb_remove_table_free(*batch);
 		*batch = NULL;
 	}
 }
@@ -173,13 +223,21 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
 		tlb_table_flush(tlb);
 }
 
-#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
+static inline void tlb_table_init(struct mmu_gather *tlb)
+{
+	tlb->batch = NULL;
+}
+
+#else /* !CONFIG_MMU_GATHER_TABLE_FREE */
+
+static inline void tlb_table_flush(struct mmu_gather *tlb) { }
+static inline void tlb_table_init(struct mmu_gather *tlb) { }
+
+#endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
 static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb_table_flush(tlb);
-#endif
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb_batch_pages_flush(tlb);
 #endif
@@ -220,9 +278,7 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	tlb->batch_count = 0;
 #endif
 
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
-	tlb->batch = NULL;
-#endif
+	tlb_table_init(tlb);
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	tlb->page_size = 0;
 #endif
-- 
2.24.1

