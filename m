Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B2676D182
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjHBPPl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjHBPOY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD482130;
        Wed,  2 Aug 2023 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7lDn/wtFMDStStfJSFg4JFdBjyCxjqZcRZNsesSoGFY=; b=NEyqsPqSVW9mPGio75eZb8vstz
        BwjATcHvubSU38801ClVjqC6T9M8z6Z/kBkSdqAWHV13QQpXH8yi57P/rvidiDEJBvXS6smJX1bZ4
        kF8RIFwrxaSEtzRUv7tq90xT/8geYsbp7ij1iXYIwDX3yWj8uzV49ELoKS5mA5J5A5wd73YmGijDk
        zQU9GEMSNz5pBP9qsQJ+6nd3nsUeGEwwgduHihDEorD3tL7mg4oytaJ6TBaSzp2DLHtLyJDpxvFFO
        A4pG5s7mmIDvtzDsi8nhMuNuQ015e7dJPivYtELxxm7HSSMvIAqiFQ//Eq+5yJJaZMNhO2FBL4tZk
        3l+xhvhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY8-00Ffim-Fd; Wed, 02 Aug 2023 15:14:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 06/38] mm: Add default definition of set_ptes()
Date:   Wed,  2 Aug 2023 16:13:34 +0100
Message-Id: <20230802151406.3735276-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230802151406.3735276-1-willy@infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Most architectures can just define set_pte() and PFN_PTE_SHIFT to
use this definition.  It's also a handy spot to document the guarantees
provided by the MM.

Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/pgtable.h | 81 ++++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 21 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f34e0f2cb4d8..3fde0d5d1c29 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -182,6 +182,66 @@ static inline int pmd_young(pmd_t pmd)
 }
 #endif
 
+/*
+ * A facility to provide lazy MMU batching.  This allows PTE updates and
+ * page invalidations to be delayed until a call to leave lazy MMU mode
+ * is issued.  Some architectures may benefit from doing this, and it is
+ * beneficial for both shadow and direct mode hypervisors, which may batch
+ * the PTE updates which happen during this window.  Note that using this
+ * interface requires that read hazards be removed from the code.  A read
+ * hazard could result in the direct mode hypervisor case, since the actual
+ * write to the page tables may not yet have taken place, so reads though
+ * a raw PTE pointer after it has been modified are not guaranteed to be
+ * up to date.  This mode can only be entered and left under the protection of
+ * the page table locks for all page tables which may be modified.  In the UP
+ * case, this is required so that preemption is disabled, and in the SMP case,
+ * it must synchronize the delayed page table writes properly on other CPUs.
+ */
+#ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
+#define arch_enter_lazy_mmu_mode()	do {} while (0)
+#define arch_leave_lazy_mmu_mode()	do {} while (0)
+#define arch_flush_lazy_mmu_mode()	do {} while (0)
+#endif
+
+#ifndef set_ptes
+#ifdef PFN_PTE_SHIFT
+/**
+ * set_ptes - Map consecutive pages to a contiguous range of addresses.
+ * @mm: Address space to map the pages into.
+ * @addr: Address to map the first page at.
+ * @ptep: Page table pointer for the first entry.
+ * @pte: Page table entry for the first page.
+ * @nr: Number of pages to map.
+ *
+ * May be overridden by the architecture, or the architecture can define
+ * set_pte() and PFN_PTE_SHIFT.
+ *
+ * Context: The caller holds the page table lock.  The pages all belong
+ * to the same folio.  The PTEs are all in the same PMD.
+ */
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	page_table_check_ptes_set(mm, ptep, pte, nr);
+
+	arch_enter_lazy_mmu_mode();
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
+	}
+	arch_leave_lazy_mmu_mode();
+}
+#ifndef set_pte_at
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
+#endif
+#endif
+#else
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 extern int ptep_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pte_t *ptep,
@@ -1051,27 +1111,6 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 #define pgprot_decrypted(prot)	(prot)
 #endif
 
-/*
- * A facility to provide lazy MMU batching.  This allows PTE updates and
- * page invalidations to be delayed until a call to leave lazy MMU mode
- * is issued.  Some architectures may benefit from doing this, and it is
- * beneficial for both shadow and direct mode hypervisors, which may batch
- * the PTE updates which happen during this window.  Note that using this
- * interface requires that read hazards be removed from the code.  A read
- * hazard could result in the direct mode hypervisor case, since the actual
- * write to the page tables may not yet have taken place, so reads though
- * a raw PTE pointer after it has been modified are not guaranteed to be
- * up to date.  This mode can only be entered and left under the protection of
- * the page table locks for all page tables which may be modified.  In the UP
- * case, this is required so that preemption is disabled, and in the SMP case,
- * it must synchronize the delayed page table writes properly on other CPUs.
- */
-#ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
-#define arch_enter_lazy_mmu_mode()	do {} while (0)
-#define arch_leave_lazy_mmu_mode()	do {} while (0)
-#define arch_flush_lazy_mmu_mode()	do {} while (0)
-#endif
-
 /*
  * A facility to provide batching of the reload of page tables and
  * other process state with the actual context switch code for
-- 
2.40.1

