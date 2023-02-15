Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F6069726C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Feb 2023 01:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjBOAFV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 19:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBOAFU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 19:05:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E172BBB92;
        Tue, 14 Feb 2023 16:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=h2PRVkAtu8fd3a0bg//rUxs9QnW0skvYBe9Qcbzdifk=; b=DIExkwAi2tqpjSpQji7j9ZuyaX
        Ii2DX9beCKO5Ej7eEZrmu/UZfKbavuYWZDTHRdYta5L8QefNsL1a+IYkNgojROgRIdWGhermVt0uB
        VD/9aBb/kv6A2s8MKzfyTFd2TSqs1riYuIuKa/J1bZ2U+XQt5ajncQi65QWMsyFeR14P6w2rxxre+
        VW9TGSzzeW0ve+xm4HaB6VpDKlHXXsYjZLwJM7AHQHDs7gOpk8eFe+I94/TuSt7UWuF2vNjvUM+JF
        TSjby/ePER0UuBe8DcS8eVg7BVR2nMNeq5nFiywKuRvDevMKgU+IttbK33DI4zBgijNgZY5kayMAK
        HdrwpRKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pS5IM-006wkl-Tq; Wed, 15 Feb 2023 00:05:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 12/7] hexagon: Implement the new page table range API
Date:   Wed, 15 Feb 2023 00:04:45 +0000
Message-Id: <20230215000446.1655635-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230215000446.1655635-1-willy@infradead.org>
References: <20230211033948.891959-1-willy@infradead.org>
 <20230215000446.1655635-1-willy@infradead.org>
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

