Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91D48F35DB
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2019 18:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfKGRk4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Nov 2019 12:40:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbfKGRkz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Nov 2019 12:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AcNJdWRFj0IiWBDJa9CJHpHPvlD1qpX53iQGww529G4=; b=VEE70/AbA2+/80RtKkwS8hzNgH
        0f/3J/BsSZ3aRwyDlxRdwuqsD5FF94BN++erCt7XDF1X8q3AHRFysxrvZJAJhD0rv9iTWKFDaAnWX
        1h1fQcVVwUS5gunbzqZ42JZjy8bCD5HrwTxW7vVMAKYX4DgJY5BpSx70Mo3j1MWwbyfi6qFMl091I
        RCm1pVnatmrIM+Q9KcbWp06hZjW9Ype5zpwVgWHyvDSxAzox7uiqAAwpt275DOYQsfbUTh2k5fO17
        cpKC7oNOXiKaF8wHv31ngSy4RUryhOiq8SEhUwfZbxncwQXtQ17K3mnBSxVzVf6aAjWr7AUHq9iyU
        Reb5jevQ==;
Received: from [2001:4bb8:184:e48:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSllz-0002ON-Cw; Thu, 07 Nov 2019 17:40:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] openrisc: use the generic in-place uncached DMA allocator
Date:   Thu,  7 Nov 2019 18:40:35 +0100
Message-Id: <20191107174035.13783-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107174035.13783-1-hch@lst.de>
References: <20191107174035.13783-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Switch openrisc to use the dma-direct allocator and just provide the
hooks for setting memory uncached or cached.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/Kconfig      |  1 +
 arch/openrisc/kernel/dma.c | 51 +++++---------------------------------
 2 files changed, 7 insertions(+), 45 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index bf326f0edd2f..72469d2d2866 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -7,6 +7,7 @@
 config OPENRISC
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 4d5b8bd1d795..9a5b10164b08 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -11,8 +11,6 @@
  * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
  *
  * DMA mapping callbacks...
- * As alloc_coherent is the only DMA callback being used currently, that's
- * the only thing implemented properly.  The rest need looking into...
  */
 
 #include <linux/dma-noncoherent.h>
@@ -67,62 +65,25 @@ static const struct mm_walk_ops clear_nocache_walk_ops = {
 	.pte_entry		= page_clear_nocache,
 };
 
-/*
- * Alloc "coherent" memory, which for OpenRISC means simply uncached.
- *
- * This function effectively just calls __get_free_pages, sets the
- * cache-inhibit bit on those pages, and makes sure that the pages are
- * flushed out of the cache before they are used.
- *
- * If the NON_CONSISTENT attribute is set, then this function just
- * returns "normal", cachable memory.
- *
- * There are additional flags WEAK_ORDERING and WRITE_COMBINE to take
- * into consideration here, too.  All current known implementations of
- * the OR1K support only strongly ordered memory accesses, so that flag
- * is being ignored for now; uncached but write-combined memory is a
- * missing feature of the OR1K.
- */
-void *
-arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
+int arch_dma_set_uncached(void *cpu_addr, size_t size)
 {
-	unsigned long va;
-	void *page;
-
-	page = alloc_pages_exact(size, gfp | __GFP_ZERO);
-	if (!page)
-		return NULL;
-
-	/* This gives us the real physical address of the first page. */
-	*dma_handle = __pa(page);
-
-	va = (unsigned long)page;
+	unsigned long va = (unsigned long)cpu_addr;
 
 	/*
 	 * We need to iterate through the pages, clearing the dcache for
 	 * them and setting the cache-inhibit bit.
 	 */
-	if (walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
-			NULL)) {
-		free_pages_exact(page, size);
-		return NULL;
-	}
-
-	return (void *)va;
+	return walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
+			NULL);
 }
 
-void
-arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
+void arch_dma_clear_uncached(void *cpu_addr, size_t size)
 {
-	unsigned long va = (unsigned long)vaddr;
+	unsigned long va = (unsigned long)cpu_addr;
 
 	/* walk_page_range shouldn't be able to fail here */
 	WARN_ON(walk_page_range(&init_mm, va, va + size,
 			&clear_nocache_walk_ops, NULL));
-
-	free_pages_exact(vaddr, size);
 }
 
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t addr, size_t size,
-- 
2.20.1

