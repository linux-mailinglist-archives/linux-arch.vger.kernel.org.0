Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A4011C939
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 10:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfLLJev (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 04:34:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfLLJev (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 04:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FIbybujq9ezcO6mby4HHjAKoXneF0iLQDALnM0fFVv0=; b=au8lxew6CLtCQVqXTZyNoYQd+
        LFUY1oO1lq2qIsLKgF8YJva8q2GB73etoEtF01Cza4EeDn5eQ3VaySKHPJwmScFjzAzVywUx8eTtk
        kGVzEtbfKbCskw1x6dfey/Zpo5n7VhaEKkXsE8aiQbZQtzcYLBJp0p4SpbW8CcwdOTGF1XtmsnjLB
        obi7cgR5aFCoOtVSik3NOGY+Ku/RD6ZpWqAP07C6Pcd4qQZXQtRX17g2K92fWHBWbtBsdGamPPCCq
        dG1sPBj5YDIzHNAqjdKULVtVUB9dykMsWLdxiJI2bUIbEen5IDbhljWRlKv9wWyIZ+j0nyOnSXz8z
        a3wBz/VBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifKpL-0006af-9Q; Thu, 12 Dec 2019 09:32:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 575DC30602B;
        Thu, 12 Dec 2019 10:30:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A374D2B18D291; Thu, 12 Dec 2019 10:32:05 +0100 (CET)
Date:   Thu, 12 Dec 2019 10:32:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH mk-II 08/17] asm-generic/tlb: Provide MMU_GATHER_TABLE_FREE
Message-ID: <20191212093205.GU2827@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122956.112607298@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211122956.112607298@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


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
---
 arch/Kconfig               |    5 +
 arch/arm/include/asm/tlb.h |    4 -
 include/asm-generic/tlb.h  |   75 +++++++++++++---------------
 mm/mmu_gather.c            |  120 +++++++++++++++++++++++++++++++++------------
 4 files changed, 130 insertions(+), 74 deletions(-)

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
 
 config MMU_GATHER_NO_TABLE_INVALIDATE
 	bool
@@ -408,6 +412,7 @@ config MMU_GATHER_NO_RANGE
 
 config MMU_GATHER_NO_GATHER
 	bool
+	depends on MMU_GATHER_TABLE_FREE
 
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -37,10 +37,6 @@ static inline void __tlb_remove_table(vo
 
 #include <asm-generic/tlb.h>
 
-#ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
-#define tlb_remove_table(tlb, entry) tlb_remove_page(tlb, entry)
-#endif
-
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
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
@@ -129,21 +138,28 @@
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
  *  MMU_GATHER_NO_TABLE_INVALIDATE
  *
- *  This makes MMU_GATHER_RCU_TABLE_FREE avoid calling tlb_flush_mmu_tlbonly() before
- *  freeing the page-table pages. This can be avoided if you use
+ *  This makes MMU_GATHER_RCU_TABLE_FREE avoid calling tlb_flush_mmu_tlbonly()
+ *  before freeing the page-table pages. This can be avoided if you use
  *  MMU_GATHER_RCU_TABLE_FREE and your architecture does _NOT_ use the Linux
  *  page-tables natively.
  *
@@ -162,37 +178,12 @@
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
@@ -202,7 +193,15 @@ struct mmu_table_batch {
 
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
-#endif
+#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
+
+/*
+ * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
+ * page directories and we can use the normal page batching to free them.
+ */
+#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
+
+#endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 /*
@@ -240,7 +239,7 @@ extern bool __tlb_remove_page_size(struc
 struct mmu_gather {
 	struct mm_struct	*mm;
 
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_TABLE_FREE
 	struct mmu_table_batch	*batch;
 #endif
 
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -91,56 +91,106 @@ bool __tlb_remove_page_size(struct mmu_g
 
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
-#ifndef CONFIG_MMU_GATHER_NO_TABLE_INVALIDATE
-	/*
-	 * Invalidate page-table caches used by hardware walkers. Then we still
-	 * need to RCU-sched wait while freeing the pages because software
-	 * walkers can still be in-flight.
-	 */
-	tlb_flush_mmu_tlbonly(tlb);
-#endif
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
+#ifndef CONFIG_MMU_GATHER_NO_TABLE_INVALIDATE
+	/*
+	 * Invalidate page-table caches used by hardware walkers. Then we still
+	 * need to RCU-sched wait while freeing the pages because software
+	 * walkers can still be in-flight.
+	 */
+	tlb_flush_mmu_tlbonly(tlb);
+#endif
+}
+
+static void tlb_remove_table_one(void *table)
+{
+	tlb_remove_table_sync_one();
+	__tlb_remove_table(table);
 }
 
 static void tlb_table_flush(struct mmu_gather *tlb)
@@ -149,7 +199,7 @@ static void tlb_table_flush(struct mmu_g
 
 	if (*batch) {
 		tlb_table_invalidate(tlb);
-		call_rcu(&(*batch)->rcu, tlb_remove_table_rcu);
+		tlb_remove_table_free(*batch);
 		*batch = NULL;
 	}
 }
@@ -173,13 +223,21 @@ void tlb_remove_table(struct mmu_gather
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
@@ -220,9 +278,7 @@ void tlb_gather_mmu(struct mmu_gather *t
 	tlb->batch_count = 0;
 #endif
 
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
-	tlb->batch = NULL;
-#endif
+	tlb_table_init(tlb);
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	tlb->page_size = 0;
 #endif
