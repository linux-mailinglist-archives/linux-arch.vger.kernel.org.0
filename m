Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B175A74DFA3
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjGJUpL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGJUo5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6E19C;
        Mon, 10 Jul 2023 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LkNLbBSWedZKYyPfN1pGuZQo5tC7Q714M9YkIGeohI8=; b=LstrdFs9UlKVnGLIEf/uAPHDQu
        pOcMiPmZPEJbQXp8d+wByOWnPshMUaJOCjYNfNldJhUqffupXq2qr8ZW2cIEmvQSvBMZBk4WZTWwx
        D+h9KKwgOJoSQv5oq9816YjDOxDh8LKWQTqQLYLMInOiJTbUxKGZjexoGn7JzrNc1CLeVnITSE7n7
        jz4V7oRq0/Gll+bVW0g0QVkL+PoDSNhsfLO9kWfztiTTfuVf7WndNMFG5cpOgSme0XkSl0Xiox2R5
        bU0RGm7kycVY3av7mjwaL0GDR6eAER8KIgTNLG4IrpJTHfaEWOCIWBqgqOZHA39mj7MRaicZpYCdR
        TEEB/kQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjT-00Eupe-BF; Mon, 10 Jul 2023 20:43:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH v5 19/38] openrisc: Implement the new page table range API
Date:   Mon, 10 Jul 2023 21:43:20 +0100
Message-Id: <20230710204339.3554919-20-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710204339.3554919-1-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add PFN_PTE_SHIFT, update_mmu_cache_range() and flush_dcache_folio().
Change the PG_arch_1 (aka PG_dcache_dirty) flag from being per-page
to per-folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org
---
 arch/openrisc/include/asm/cacheflush.h |  8 +++++++-
 arch/openrisc/include/asm/pgtable.h    | 15 ++++++++++-----
 arch/openrisc/mm/cache.c               | 12 ++++++++----
 3 files changed, 25 insertions(+), 10 deletions(-)

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
index 3eb9b9555d0d..7bdf1bb0d177 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -46,7 +46,7 @@ extern void paging_init(void);
  * hook is made available.
  */
 #define set_pte(pteptr, pteval) ((*(pteptr)) = (pteval))
-#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
+
 /*
  * (pmds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
@@ -357,6 +357,7 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define __pmd_offset(address) \
 	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 
+#define PFN_PTE_SHIFT		PAGE_SHIFT
 #define pte_pfn(x)		((unsigned long)(((x).pte)) >> PAGE_SHIFT)
 #define pfn_pte(pfn, prot)  __pte((((pfn) << PAGE_SHIFT)) | pgprot_val(prot))
 
@@ -379,13 +380,17 @@ static inline void update_tlb(struct vm_area_struct *vma,
 extern void update_cache(struct vm_area_struct *vma,
 	unsigned long address, pte_t *pte);
 
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-	unsigned long address, pte_t *pte)
+static inline void update_mmu_cache_range(struct vm_fault *vmf,
+		struct vm_area_struct *vma, unsigned long address,
+		pte_t *ptep, unsigned int nr)
 {
-	update_tlb(vma, address, pte);
-	update_cache(vma, address, pte);
+	update_tlb(vma, address, ptep);
+	update_cache(vma, address, ptep);
 }
 
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
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
2.39.2

