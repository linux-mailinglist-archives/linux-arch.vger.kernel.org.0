Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51B26BA6BF
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjCOFP2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjCOFPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CA32B9C3;
        Tue, 14 Mar 2023 22:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0st9Mrc59fhc9IMmLMdFdFFlAbLT9wbreqz2AWFYyJ8=; b=Dgag4LmKF0rIz5AIdwp+wqJheo
        CLolCrddE7Bc8qR0iHxu6Ho7H150VijFW/ZxoRKOY6x4pkWnZmiPY0OM2oN5P8H/Fs/MeH4QPtXgk
        ZE9mPbldtrjXnQVG697nsaMbI2wTBcFEO7DWOgSTrwEVysrfAlkiBXRblG53BZqYTrzOgkNvRlNQu
        7OChw55UZHmed+ZDbPSiZJwFD+Q5Q56Hv65kwKcSjZV6jnH7UGJWU4GYt9WxNmwbniA0F2rFm/IEy
        WV9Cu7ZcCxlHNqKM4+Sl7GfbN2anMoSQIpkz59WebhopeUz0ENti95uNjgV9Zi7Gb0vNAl40o1sVl
        koLF9org==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTK-00DYB9-WE; Wed, 15 Mar 2023 05:14:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH v4 06/36] alpha: Implement the new page table range API
Date:   Wed, 15 Mar 2023 05:14:14 +0000
Message-Id: <20230315051444.3229621-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230315051444.3229621-1-willy@infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add PFN_PTE_SHIFT, update_mmu_cache_range() and flush_icache_pages().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/include/asm/cacheflush.h | 10 ++++++++++
 arch/alpha/include/asm/pgtable.h    |  9 +++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

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
index ba43cb841d19..6c24c408b8e9 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -26,7 +26,6 @@ struct vm_area_struct;
  * hook is made available.
  */
 #define set_pte(pteptr, pteval) ((*(pteptr)) = (pteval))
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
 #define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-3))
@@ -189,7 +188,8 @@ extern unsigned long __zero_page(void);
  * and a page entry and page directory to the page they refer to.
  */
 #define page_to_pa(page)	(page_to_pfn(page) << PAGE_SHIFT)
-#define pte_pfn(pte)	(pte_val(pte) >> 32)
+#define PFN_PTE_SHIFT		32
+#define pte_pfn(pte)		(pte_val(pte) >> PFN_PTE_SHIFT)
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 #define mk_pte(page, pgprot)						\
@@ -303,6 +303,11 @@ extern inline void update_mmu_cache(struct vm_area_struct * vma,
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
2.39.2

