Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB5895EBF
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 14:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfHTMes (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 08:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729810AbfHTMes (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 08:34:48 -0400
Received: from guoren-Inspiron-7460.lan (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0BB422DBF;
        Tue, 20 Aug 2019 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566304487;
        bh=RHxB0eaZdN0uqIspsq16Xe6cSyoC7w1EMK7IKfrz8iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjB5+3tRE8cPeLFiigUiI/NeNLTxQE/pSJG498PboBjScSPG2c8vHrbBWaavWRfT8
         YhacaTsg95/zF/HX2AX42D77ej8nqbSvQBJMW3GpBLUYFf2F18pMCt6D84eyxiVLWF
         XvY8b3cWDoyFE2CwLJ8PsQ6aSExnL4JzuoQrnJSI=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, douzhk@nationalchip.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 2/3] csky: Fixup defer cache flush for 610
Date:   Tue, 20 Aug 2019 20:34:28 +0800
Message-Id: <1566304469-5601-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566304469-5601-1-git-send-email-guoren@kernel.org>
References: <1566304469-5601-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

We use defer cache flush mechanism to improve the performance of
610, but the implementation is wrong. We fix it up now and update
the mechanism:

 - Zero page needn't be flushed.
 - If page is file mapping & non-touched in user space, defer flush.
 - If page is anon mapping or dirty file mapping, flush immediately.
 - In update_mmu_cache finish the defer flush by flush_dcache_page().

For 610 we need take care the dcache aliasing issue:
 - VIPT cache with 8K-bytes size per way in 4K page granularity.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/cacheflush.c         | 50 +++++++++++++++++++-----------------
 arch/csky/abiv1/inc/abi/cacheflush.h |  4 +--
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
index 10af8b6..fee99fc 100644
--- a/arch/csky/abiv1/cacheflush.c
+++ b/arch/csky/abiv1/cacheflush.c
@@ -11,42 +11,46 @@
 #include <asm/cacheflush.h>
 #include <asm/cachectl.h>
 
+#define PG_dcache_clean		PG_arch_1
+
 void flush_dcache_page(struct page *page)
 {
-	struct address_space *mapping = page_mapping(page);
-	unsigned long addr;
+	struct address_space *mapping;
 
-	if (mapping && !mapping_mapped(mapping)) {
-		set_bit(PG_arch_1, &(page)->flags);
+	if (page == ZERO_PAGE(0))
 		return;
-	}
 
-	/*
-	 * We could delay the flush for the !page_mapping case too.  But that
-	 * case is for exec env/arg pages and those are %99 certainly going to
-	 * get faulted into the tlb (and thus flushed) anyways.
-	 */
-	addr = (unsigned long) page_address(page);
-	dcache_wb_range(addr, addr + PAGE_SIZE);
+	mapping = page_mapping_file(page);
+
+	if (mapping && !page_mapcount(page))
+		clear_bit(PG_dcache_clean, &page->flags);
+	else {
+		dcache_wbinv_all();
+		if (mapping)
+			icache_inv_all();
+		set_bit(PG_dcache_clean, &page->flags);
+	}
 }
+EXPORT_SYMBOL(flush_dcache_page);
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
-		      pte_t *pte)
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
+	pte_t *ptep)
 {
-	unsigned long addr;
+	unsigned long pfn = pte_pfn(*ptep);
 	struct page *page;
-	unsigned long pfn;
 
-	pfn = pte_pfn(*pte);
-	if (unlikely(!pfn_valid(pfn)))
+	if (!pfn_valid(pfn))
 		return;
 
 	page = pfn_to_page(pfn);
-	addr = (unsigned long) page_address(page);
+	if (page == ZERO_PAGE(0))
+		return;
 
-	if (vma->vm_flags & VM_EXEC ||
-	    pages_do_alias(addr, address & PAGE_MASK))
-		cache_wbinv_all();
+	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
+		dcache_wbinv_all();
 
-	clear_bit(PG_arch_1, &(page)->flags);
+	if (page_mapping_file(page)) {
+		if (vma->vm_flags & VM_EXEC)
+			icache_inv_all();
+	}
 }
diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index 5f663ae..fce5604 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -26,8 +26,8 @@ extern void flush_dcache_page(struct page *);
 #define flush_icache_page(vma, page)		cache_wbinv_all()
 #define flush_icache_range(start, end)		cache_wbinv_range(start, end)
 
-#define flush_icache_user_range(vma, pg, adr, len) \
-				cache_wbinv_range(adr, adr + len)
+#define flush_icache_user_range(vma,page,addr,len) \
+	flush_dcache_page(page)
 
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 do { \
-- 
2.7.4

