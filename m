Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969B0692DFB
	for <lists+linux-arch@lfdr.de>; Sat, 11 Feb 2023 04:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBKDkI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Feb 2023 22:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBKDkG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2023 22:40:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE633A085
        for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2023 19:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vX1YJXK+PcXOZWsWZ/UEYBTWr9HbSfOYWjKMlt98xdk=; b=Z1nfjIAwRo3cDyujGAD4AJQjA0
        Yv90BtvR90Xy4tXm+pzXiH3CDMzSJFZ93Xh23khrcEMXVLWZ9Rs7rnRXZwDmlNtiazi63Pkj0Z2tc
        jvXkfClpimFXCFQI3I8Jbstb+Cj2qSwIKySH8+oqwvdUP6Mam86IFiHrrcviTHj6dagmWJuVIylxy
        JWo33myUaSf+M0Sm/jcR4c9d4iXJB1lkPZH8VU+aVmXGS3OebKaGjhL4YRugg95XtQoA1gIL+oOl9
        vDkK4vEReaMgXlzqeo4x20QEb+ehq0xiD+LioJkuoJ9Jfooe5l8PIBjsBjvxfaSScJX4NsOHpu4HF
        SV9zLBSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQgjv-003k2o-Et; Sat, 11 Feb 2023 03:39:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 5/7] alpha: Implement the new page table range API
Date:   Sat, 11 Feb 2023 03:39:46 +0000
Message-Id: <20230211033948.891959-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230211033948.891959-1-willy@infradead.org>
References: <20230211033948.891959-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add set_ptes(), update_mmu_cache_range() and flush_icache_pages().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/alpha/include/asm/cacheflush.h | 10 ++++++++++
 arch/alpha/include/asm/pgtable.h    | 18 +++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/cacheflush.h b/arch/alpha/include/asm/cacheflush.h
index 9945ff483eaf..3956460e69e2 100644
--- a/arch/alpha/include/asm/cacheflush.h
+++ b/arch/alpha/include/asm/cacheflush.h
@@ -57,6 +57,16 @@ extern void flush_icache_user_page(struct vm_area_struct *vma,
 #define flush_icache_page(vma, page) \
 	flush_icache_user_page((vma), (page), 0, 0)
 
+/*
+ * Both implementations of flush_icache_user_page flush the entire
+ * address space, so one call, no matter how many pages.
+ */
+static inline void flush_icache_pages(struct vm_area_struct *vma,
+		struct page *page, unsigned int nr)
+{
+	flush_icache_user_page(vma, page, 0, 0);
+}
+
 #include <asm-generic/cacheflush.h>
 
 #endif /* _ALPHA_CACHEFLUSH_H */
diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index ba43cb841d19..1e3354e9731b 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -26,7 +26,18 @@ struct vm_area_struct;
  * hook is made available.
  */
 #define set_pte(pteptr, pteval) ((*(pteptr)) = (pteval))
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pte) += 1UL << 32;
+	}
+}
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
 #define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-3))
@@ -303,6 +314,11 @@ extern inline void update_mmu_cache(struct vm_area_struct * vma,
 {
 }
 
+static inline void update_mmu_cache_range(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr)
+{
+}
+
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
  * are !pte_none() && !pte_present().
-- 
2.39.1

