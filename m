Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCEA82C77
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2019 09:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfHFHTL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Aug 2019 03:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731807AbfHFHTK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Aug 2019 03:19:10 -0400
Received: from guoren-Inspiron-7460.lan (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62B42070C;
        Tue,  6 Aug 2019 07:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565075949;
        bh=swLdWN/c3YNiNoEDBUnhTuMLT4pIrTC41Pfwb24gXQ8=;
        h=From:To:Cc:Subject:Date:From;
        b=SA9MUzOU7xfygcVSI9BbYgctl/RUzZ359BexoHuidG2VXASkHNfMQbp9N4xUg6mJq
         27ldNV7Dis1ZIrB5bbzjVliUSbgvsoeKgwDSiTUVBI7tUj71rnr8TRnt3h/CuHIzog
         JDzI7VXUOtSeO04GKYVprwYmS7Oo6jWaYe7VYttM=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com,
        zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com,
        zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V2 2/3] csky/dma: Fixup cache_op failed when cross memory ZONEs
Date:   Tue,  6 Aug 2019 15:18:41 +0800
Message-Id: <1565075921-25734-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

If the paddr and size are cross between NORMAL_ZONE and HIGHMEM_ZONE
memory range, cache_op will panic in do_page_fault with bad_area.

Optimize the code to support the range which cross memory ZONEs.

Changes for V2:
 - Revert back to postcore_initcall

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/mm/dma-mapping.c | 71 +++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 45 deletions(-)

diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 80783bb..65f531d 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -20,69 +20,50 @@ static int __init atomic_pool_init(void)
 }
 postcore_initcall(atomic_pool_init);
 
-void arch_dma_prep_coherent(struct page *page, size_t size)
-{
-	if (PageHighMem(page)) {
-		unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-		do {
-			void *ptr = kmap_atomic(page);
-			size_t _size = (size < PAGE_SIZE) ? size : PAGE_SIZE;
-
-			memset(ptr, 0, _size);
-			dma_wbinv_range((unsigned long)ptr,
-					(unsigned long)ptr + _size);
-
-			kunmap_atomic(ptr);
-
-			page++;
-			size -= PAGE_SIZE;
-			count--;
-		} while (count);
-	} else {
-		void *ptr = page_address(page);
-
-		memset(ptr, 0, size);
-		dma_wbinv_range((unsigned long)ptr, (unsigned long)ptr + size);
-	}
-}
-
 static inline void cache_op(phys_addr_t paddr, size_t size,
 			    void (*fn)(unsigned long start, unsigned long end))
 {
-	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
-	unsigned int offset = paddr & ~PAGE_MASK;
-	size_t left = size;
-	unsigned long start;
+	struct page *page    = phys_to_page(paddr);
+	void *start          = __va(page_to_phys(page));
+	unsigned long offset = offset_in_page(paddr);
+	size_t left          = size;
 
 	do {
 		size_t len = left;
 
+		if (offset + len > PAGE_SIZE)
+			len = PAGE_SIZE - offset;
+
 		if (PageHighMem(page)) {
-			void *addr;
+			start = kmap_atomic(page);
 
-			if (offset + len > PAGE_SIZE) {
-				if (offset >= PAGE_SIZE) {
-					page += offset >> PAGE_SHIFT;
-					offset &= ~PAGE_MASK;
-				}
-				len = PAGE_SIZE - offset;
-			}
+			fn((unsigned long)start + offset,
+					(unsigned long)start + offset + len);
 
-			addr = kmap_atomic(page);
-			start = (unsigned long)(addr + offset);
-			fn(start, start + len);
-			kunmap_atomic(addr);
+			kunmap_atomic(start);
 		} else {
-			start = (unsigned long)phys_to_virt(paddr);
-			fn(start, start + size);
+			fn((unsigned long)start + offset,
+					(unsigned long)start + offset + len);
 		}
 		offset = 0;
+
 		page++;
+		start += PAGE_SIZE;
 		left -= len;
 	} while (left);
 }
 
+static void dma_wbinv_set_zero_range(unsigned long start, unsigned long end)
+{
+	memset((void *)start, 0, end - start);
+	dma_wbinv_range(start, end);
+}
+
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	cache_op(page_to_phys(page), size, dma_wbinv_set_zero_range);
+}
+
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 			      size_t size, enum dma_data_direction dir)
 {
-- 
2.7.4

