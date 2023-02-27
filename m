Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47BE6A48F1
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 18:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjB0R6S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 12:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjB0R6K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 12:58:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C69241D9;
        Mon, 27 Feb 2023 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Nqz7AKc3hPtY/ZHqOcsiEiY49KCNRExEKCVBLCnS/x4=; b=jhpNHFRRyHy/TpBPFwxYsEg8wh
        cAfbO9iPyvMMMxJLy9gFVnY64izGm0jMDIyMcKZ2uw2PGuZ2q4Vhzg0zHntzp8duThNZeQAS1EzIj
        szvUcBMcnPMwi4bKX0LG5dbY91B1UvdO92qBeIFHka3WECGGXsJTlDEI0kcCLKxrJnGnUOahjHtum
        I0/W48if3Ic2/DQkq4kUN9GQAW0dcN2bsoqvQZUwsWeDY0a33VLnDzWnTu4piJ6pqrf9OxglH7ep7
        ERTtDf75judvHo0eNzidtpBMDJ4qO42dkIzfOmIgLUPlai6YSxZnNPHkfegT7ihWcgpZtN+ehHm11
        Epy/Hc+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWhkv-000IXh-3a; Mon, 27 Feb 2023 17:57:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH v2 16/30] openrisc: Implement the new page table range API
Date:   Mon, 27 Feb 2023 17:57:27 +0000
Message-Id: <20230227175741.71216-17-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230227175741.71216-1-willy@infradead.org>
References: <20230227175741.71216-1-willy@infradead.org>
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

Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
Change the PG_arch_1 (aka PG_dcache_dirty) flag from being per-page
to per-folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org
---
 arch/openrisc/include/asm/cacheflush.h |  8 +++++++-
 arch/openrisc/include/asm/pgtable.h    | 27 +++++++++++++++++++++-----
 arch/openrisc/mm/cache.c               | 12 ++++++++----
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/arch/openrisc/include/asm/cacheflush.h b/arch/openrisc/include/asm/cacheflush.h
index eeac40d4a854..984c331ff5f4 100644
--- a/arch/openrisc/include/asm/cacheflush.h
+++ b/arch/openrisc/include/asm/cacheflush.h
@@ -56,10 +56,16 @@ static inline void sync_icache_dcache(struct page *page)
  */
 #define PG_dc_clean                  PG_arch_1
 
+static inline void flush_dcache_folio(struct folio *folio)
+{
+	clear_bit(PG_dc_clean, &folio->flags);
+}
+#define flush_dcache_folio flush_dcache_folio
+
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 static inline void flush_dcache_page(struct page *page)
 {
-	clear_bit(PG_dc_clean, &page->flags);
+	flush_dcache_folio(page_folio(page));
 }
 
 #define flush_icache_user_page(vma, page, addr, len)	\
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 3eb9b9555d0d..1a7077150d7b 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -46,7 +46,21 @@ extern void paging_init(void);
  * hook is made available.
  */
 #define set_pte(pteptr, pteval) ((*(pteptr)) = (pteval))
-#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
+
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
+
 /*
  * (pmds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
@@ -379,13 +393,16 @@ static inline void update_tlb(struct vm_area_struct *vma,
 extern void update_cache(struct vm_area_struct *vma,
 	unsigned long address, pte_t *pte);
 
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-	unsigned long address, pte_t *pte)
+static inline void update_mmu_cache_range(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr)
 {
-	update_tlb(vma, address, pte);
-	update_cache(vma, address, pte);
+	update_tlb(vma, address, ptep);
+	update_cache(vma, address, ptep);
 }
 
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(vma, addr, ptep, 1)
+
 /* __PHX__ FIXME, SWAP, this probably doesn't work */
 
 /*
diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index 534a52ec5e66..eb43b73f3855 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -43,15 +43,19 @@ void update_cache(struct vm_area_struct *vma, unsigned long address,
 	pte_t *pte)
 {
 	unsigned long pfn = pte_val(*pte) >> PAGE_SHIFT;
-	struct page *page = pfn_to_page(pfn);
-	int dirty = !test_and_set_bit(PG_dc_clean, &page->flags);
+	struct folio *folio = page_folio(pfn_to_page(pfn));
+	int dirty = !test_and_set_bit(PG_dc_clean, &folio->flags);
 
 	/*
 	 * Since icaches do not snoop for updated data on OpenRISC, we
 	 * must write back and invalidate any dirty pages manually. We
 	 * can skip data pages, since they will not end up in icaches.
 	 */
-	if ((vma->vm_flags & VM_EXEC) && dirty)
-		sync_icache_dcache(page);
+	if ((vma->vm_flags & VM_EXEC) && dirty) {
+		unsigned int nr = folio_nr_pages(folio);
+
+		while (nr--)
+			sync_icache_dcache(folio_page(folio, nr));
+	}
 }
 
-- 
2.39.1

