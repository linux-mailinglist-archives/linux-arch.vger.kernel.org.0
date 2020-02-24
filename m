Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D2C16B07A
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 20:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBXTpP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 14:45:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgBXTpO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 14:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TVVTZgdR5J3wS/RRu7oP97obK9Hl/oCd/+X1DKMJaLs=; b=nYb1+BiiaVSXHD5wyEm3ehtL8y
        VjW03ru0nB0v1U2+kOSh/Q3eiFZf6GfFLy04Rf5Um4ePQxSEq1HIqDp/e9SpK8ppWNOCHD9cbmWjJ
        6ObWJA8ZGCxa3DaAAnCeLdcmdHkv40wzO/DtM7nYQjO8sWFX6aekiAFrALl2zNsr19FJc9Wp5Y/8S
        8ZvQMIvhRJz4tjkni8m7D38GInYEew0m9wBl6A+ReQp9MxVSopUQHhu1C12a6RUfLltijiV8oBP3Y
        bzEU2Q+RE/PK689roGytjB/kdQJEPOJw6BoM/DhPhADUN77t1ZPWJxh2A5QZ+7A/e7V/LKK491HMY
        NmStCd0Q==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6Jew-0006ZH-5u; Mon, 24 Feb 2020 19:44:54 +0000
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
Subject: [PATCH 5/5] openrisc: use the generic in-place uncached DMA allocator
Date:   Mon, 24 Feb 2020 11:44:45 -0800
Message-Id: <20200224194446.690816-6-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224194446.690816-1-hch@lst.de>
References: <20200224194446.690816-1-hch@lst.de>
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
 arch/openrisc/Kconfig      |  2 ++
 arch/openrisc/kernel/dma.c | 55 +++++++-------------------------------
 2 files changed, 12 insertions(+), 45 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 1928e061ff96..7e94fe37cb2f 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -7,6 +7,8 @@
 config OPENRISC
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_DMA_SET_UNCACHED
+	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index adec711ad39d..c152a68811dd 100644
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
@@ -67,62 +65,29 @@ static const struct mm_walk_ops clear_nocache_walk_ops = {
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
+void *arch_dma_set_uncached(void *cpu_addr, size_t size)
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
+	int error;
 
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
+	error = walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
+			NULL);
+	if (error)
+		return ERR_PTR(error);
+	return cpu_addr;
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
 
 void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
-- 
2.24.1

