Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5CB74DFA6
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjGJUpO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjGJUo6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422971BB;
        Mon, 10 Jul 2023 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ACu0coWtToHgVmiLGofuGFdkSZdUJPASY/IVnZUUiqI=; b=KQOV3xnxHjVz1lKBWRN/GFYNE1
        GTBdXlh6aD0aeos173WgoFubkYCHUodGZDmayFlE9FTXCLuhz5xIE+AadrazVBmXfKT39tbNfgOw2
        K0iRfSZnxTkWs/5gE9dfpnjaeyyhaWQ54RdmXki7k6/fHGo7TvY2BI+m+rMPm9kpT6ET/U9ve5HvC
        kigmCWilg4GNeA6mHkAZu+vCFDNFdVxEPrfAjlY70cViC7O6jSSM5hCzEcYZMOvfO8aZ7LjRdXxo8
        1+HNso/FGePI0Jwzvi2mfP0b60fd1N7ZvvDiphtMsH5/Byk3Ia3ED0/XU4GFchyjsgBz4v9l4J535
        pnYQNKyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjU-00EuqN-3M; Mon, 10 Jul 2023 20:43:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH v5 25/38] sparc32: Implement the new page table range API
Date:   Mon, 10 Jul 2023 21:43:26 +0100
Message-Id: <20230710204339.3554919-26-willy@infradead.org>
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

Add PFN_PTE_SHIFT, update_mmu_cache_range(), flush_dcache_folio() and
flush_icache_pages().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/cacheflush_32.h |  9 +++++++--
 arch/sparc/include/asm/pgtable_32.h    |  8 ++++----
 arch/sparc/mm/init_32.c                | 13 +++++++++++--
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index adb6991d0455..8dba35d63328 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -16,6 +16,7 @@
 	sparc32_cachetlb_ops->cache_page(vma, addr)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma, pg)		do { } while (0)
+#define flush_icache_pages(vma, pg, nr)		do { } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 	do {							\
@@ -35,11 +36,15 @@
 #define flush_page_for_dma(addr) \
 	sparc32_cachetlb_ops->page_for_dma(addr)
 
-struct page;
 void sparc_flush_page_to_ram(struct page *page);
+void sparc_flush_folio_to_ram(struct folio *folio);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-#define flush_dcache_page(page)			sparc_flush_page_to_ram(page)
+#define flush_dcache_folio(folio)		sparc_flush_folio_to_ram(folio)
+static inline void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
+}
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index d4330e3c57a6..315d316614ca 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -101,8 +101,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	srmmu_swap((unsigned long *)ptep, pte_val(pteval));
 }
 
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-
 static inline int srmmu_device_memory(unsigned long x)
 {
 	return ((x & 0xF0000000) != 0);
@@ -256,6 +254,7 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return __pte(pte_val(pte) | SRMMU_REF);
 }
 
+#define PFN_PTE_SHIFT			(PAGE_SHIFT - 4)
 #define pfn_pte(pfn, prot)		mk_pte(pfn_to_page(pfn), prot)
 
 static inline unsigned long pte_pfn(pte_t pte)
@@ -268,7 +267,7 @@ static inline unsigned long pte_pfn(pte_t pte)
 		 */
 		return ~0UL;
 	}
-	return (pte_val(pte) & SRMMU_PTE_PMASK) >> (PAGE_SHIFT-4);
+	return (pte_val(pte) & SRMMU_PTE_PMASK) >> PFN_PTE_SHIFT;
 }
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
@@ -318,6 +317,7 @@ void mmu_info(struct seq_file *m);
 #define FAULT_CODE_USER     0x4
 
 #define update_mmu_cache(vma, address, ptep) do { } while (0)
+#define update_mmu_cache_range(vmf, vma, address, ptep, nr) do { } while (0)
 
 void srmmu_mapiorange(unsigned int bus, unsigned long xpa,
                       unsigned long xva, unsigned int len);
@@ -422,7 +422,7 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 ({									  \
 	int __changed = !pte_same(*(__ptep), __entry);			  \
 	if (__changed) {						  \
-		set_pte_at((__vma)->vm_mm, (__address), __ptep, __entry); \
+		set_pte(__ptep, __entry);				  \
 		flush_tlb_page(__vma, __address);			  \
 	}								  \
 	__changed;							  \
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 9c0ea457bdf0..d96a14ffceeb 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -297,11 +297,20 @@ void sparc_flush_page_to_ram(struct page *page)
 {
 	unsigned long vaddr = (unsigned long)page_address(page);
 
-	if (vaddr)
-		__flush_page_to_ram(vaddr);
+	__flush_page_to_ram(vaddr);
 }
 EXPORT_SYMBOL(sparc_flush_page_to_ram);
 
+void sparc_flush_folio_to_ram(struct folio *folio)
+{
+	unsigned long vaddr = (unsigned long)folio_address(folio);
+	unsigned int i, nr = folio_nr_pages(folio);
+
+	for (i = 0; i < nr; i++)
+		__flush_page_to_ram(vaddr + i * PAGE_SIZE);
+}
+EXPORT_SYMBOL(sparc_flush_folio_to_ram);
+
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READONLY,
-- 
2.39.2

