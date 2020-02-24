Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58A016B077
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 20:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBXTpN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 14:45:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgBXTpM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 14:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6vbrJb1PTxUBmfNUmWMaC9IunHM3NVjcATW2sN+r4hs=; b=EhnoAKGWRXjYku+s4TutBL35qf
        IZBFdQBmO4pyH8ycFxMo5+hdCjNO89mxYaEAQhUI604JD4UleyJ1mkSWFd2A8rK9y42cjZFeP7fqI
        LQ9Rab084Uzyknp8Xt0a7BzHFC/JLuz/0nTh6gNxmUAtRsXExrD6vF4vqsD4yx4BYGRfpGd9mNmQv
        cdmtSuusulJ9P1FC3atUHajNpzqMaMEUOdH7OdbHf0+b2BrTmh9IvCuy7zlKv/nLFyOHNRAF1eqTi
        LW358irqbh5baSuYh1Ux9WAhn/i+bVxlJKjPLhCWmXSsXptImnCCo18YRLakBthTOd0C7XcfxRxxj
        lkvAdDyA==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6Jev-0006Xj-34; Mon, 24 Feb 2020 19:44:53 +0000
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
Subject: [PATCH 4/5] dma-direct: provide a arch_dma_clear_uncached hook
Date:   Mon, 24 Feb 2020 11:44:44 -0800
Message-Id: <20200224194446.690816-5-hch@lst.de>
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

This allows the arch code to reset the page tables to cached access when
freeing a dma coherent allocation that was set to uncached using
arch_dma_set_uncached.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig                    | 7 +++++++
 include/linux/dma-noncoherent.h | 1 +
 kernel/dma/direct.c             | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 090cfe0c82a7..c26302f90c96 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -255,6 +255,13 @@ config ARCH_HAS_SET_DIRECT_MAP
 config ARCH_HAS_DMA_SET_UNCACHED
 	bool
 
+#
+# Select if the architectures provides the arch_dma_clear_uncached symbol
+# to undo an in-place page table remap for uncached access.
+#
+config ARCH_HAS_DMA_CLEAR_UNCACHED
+	bool
+
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
 	bool
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 1a4039506673..b59f1b6be3e9 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -109,5 +109,6 @@ static inline void arch_dma_prep_coherent(struct page *page, size_t size)
 #endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
 
 void *arch_dma_set_uncached(void *addr, size_t size);
+void arch_dma_clear_uncached(void *addr, size_t size);
 
 #endif /* _LINUX_DMA_NONCOHERENT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f01a8191fd59..a8560052a915 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -219,6 +219,8 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
 		vunmap(cpu_addr);
+	else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
+		arch_dma_clear_uncached(cpu_addr, size);
 
 	dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
 }
-- 
2.24.1

