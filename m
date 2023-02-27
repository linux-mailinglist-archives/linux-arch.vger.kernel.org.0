Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C2E6A48EB
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 18:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjB0R6R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 12:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjB0R6K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 12:58:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23B92449C;
        Mon, 27 Feb 2023 09:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hq3kISoFqRozP9bJJptL5dM/gm/mC87Ff3e3oJGmMC0=; b=cbxS9VK9MYXMYT01A3bZZGFF2W
        B+5ggsaBa3ENEQKMM98W0IbxREG8/YKxl4Oa1VjlFjSJTABMyP++zzgiAqIP/AE9Nsnq451nC3o2X
        x68Zw0mxe34XSOukJOKU/oroID010FCbGAg1rD9zoj/qyVCbA1ENaXUooQYhIpD2NOpWq3OZzo8ro
        drqDLU+3QpES4i6hCkkQln/Li6B7vidBoDv1yOabITrqNfD+4mtnF3U1ESzfeuHk+eBYhNtbf1LoX
        O8T/CtmQum8hNP5OJ77LkEmnpAAB4hUefV6hsby8pFNfFokt6C/lOLjr0WLWIOjwBpPOKd8TL4ShZ
        JWSKxPVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWhkv-000IYJ-Sz; Mon, 27 Feb 2023 17:57:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH v2 22/30] sparc32: Implement the new page table range API
Date:   Mon, 27 Feb 2023 17:57:33 +0000
Message-Id: <20230227175741.71216-23-willy@infradead.org>
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

Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio() and
flush_icache_pages().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/cacheflush_32.h |  9 +++++++--
 arch/sparc/include/asm/pgtable_32.h    | 15 ++++++++++++++-
 arch/sparc/mm/init_32.c                | 13 +++++++++++--
 3 files changed, 32 insertions(+), 5 deletions(-)

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
index d4330e3c57a6..47ae55ea1837 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -101,7 +101,19 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 	srmmu_swap((unsigned long *)ptep, pte_val(pteval));
 }
 
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
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
 
 static inline int srmmu_device_memory(unsigned long x)
 {
@@ -318,6 +330,7 @@ void mmu_info(struct seq_file *m);
 #define FAULT_CODE_USER     0x4
 
 #define update_mmu_cache(vma, address, ptep) do { } while (0)
+#define update_mmu_cache_range(vma, address, ptep, nr) do { } while (0)
 
 void srmmu_mapiorange(unsigned int bus, unsigned long xpa,
                       unsigned long xva, unsigned int len);
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
2.39.1

