Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605956A6165
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 22:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjB1ViG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 16:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjB1Vhr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 16:37:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F7334C09;
        Tue, 28 Feb 2023 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yM8cvfNz5jVfR0nEV77nAvQQBtTw5TotKep/NN0+z/U=; b=fqpsebHD5cGcr5m/rhD5tIZunJ
        mu0FGvCDmW7G8UikT9VBw3YmgHxjYCqR85Yjq1SNB5b8LxY4tD1KESaNk/C/MEE9oMcnZSOFKEQQQ
        heyVfhw3U68Rb4yS48Ngvf07xGLDqG7dWbrMMPBcsAAZrefTRiEAHNg/h+eLBtJ/l81xnSWNW2w1e
        6KYkVIOeY8tHmhIMfpicjm1a3EL9JqeKKYbT7N/dAO5THS+vuwuvH9+Z47+qvE3n9mCx6gjBTWE58
        VqdGnnKOt1NRyYe+2+9HLQh9d0ggzJCZ4Bh+7CwzWNiLpqJ7mGYdUigM+boHB29pObhMCXaXBQg2Y
        oCsKxxEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX7fI-0018oy-CB; Tue, 28 Feb 2023 21:37:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 10/34] hexagon: Implement the new page table range API
Date:   Tue, 28 Feb 2023 21:37:13 +0000
Message-Id: <20230228213738.272178-11-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230228213738.272178-1-willy@infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
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

Add set_ptes() and update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Brian Cain <bcain@quicinc.com>
---
 arch/hexagon/include/asm/cacheflush.h |  7 +++++--
 arch/hexagon/include/asm/pgtable.h    | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/include/asm/cacheflush.h b/arch/hexagon/include/asm/cacheflush.h
index 6eff0730e6ef..63ca314ede89 100644
--- a/arch/hexagon/include/asm/cacheflush.h
+++ b/arch/hexagon/include/asm/cacheflush.h
@@ -58,12 +58,15 @@ extern void flush_cache_all_hexagon(void);
  * clean the cache when the PTE is set.
  *
  */
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-					unsigned long address, pte_t *ptep)
+static inline void update_mmu_cache_range(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr)
 {
 	/*  generic_ptrace_pokedata doesn't wind up here, does it?  */
 }
 
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(vma, addr, ptep, 1)
+
 void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		       unsigned long vaddr, void *dst, void *src, int len);
 #define copy_to_user_page copy_to_user_page
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 59393613d086..f58f1d920769 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -346,12 +346,24 @@ static inline int pte_exec(pte_t pte)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
 /*
- * set_pte_at - update page table and do whatever magic may be
+ * set_ptes - update page table and do whatever magic may be
  * necessary to make the underlying hardware/firmware take note.
  *
  * VM may require a virtual instruction to alert the MMU.
  */
-#define set_pte_at(mm, addr, ptep, pte) set_pte(ptep, pte)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pte) += PAGE_SIZE;
+	}
+}
+
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 {
-- 
2.39.1

