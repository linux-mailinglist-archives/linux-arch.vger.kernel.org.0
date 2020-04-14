Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20E71A7C24
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502714AbgDNNOr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 09:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502708AbgDNNOo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 09:14:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E9CC061A0F;
        Tue, 14 Apr 2020 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uQqCBWgeXPC9MRe923rq3Wbeap6XWEEy0ebXrAKkJzU=; b=edMRw8ll88Tb2qmbq9YycGwZPJ
        BfKAAsx2dP0Up2jnYzxtRC2oZHpgLTewpDGQXgnCmeksOcsAevFJxXFWamcSwz/2MDzAoYhx0cSUN
        zNA6uIFvUrl2ulzNQllUJevcnLQHohvn9gpsxxpNUN/hEBA2uIMPVCa5tAZdek+Q2l9DmZnavFcB8
        NFYDyzvmc9GA3pb+uHjQ82tFPUOn3c4QnnKUeQXLaDnWs8QOeSMD0n4lhmwQ2LzVp35D/TrGXVrQG
        vezJNSfXPLHbPKcOZw8ye7Vzfr99/JmcggO2IigkPSlICo5RdsLs0Mua0dcb0fba8ExbtnEDAUitO
        XjO/OmXA==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLOK-0006VK-3Z; Tue, 14 Apr 2020 13:14:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/29] powerpc: remove __ioremap_at and __iounmap_at
Date:   Tue, 14 Apr 2020 15:13:26 +0200
Message-Id: <20200414131348.444715-8-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These helpers are only used for remapping the ISA I/O base.  Replace
the mapping side with a remap_isa_range helper in isa-bridge.c that
hard codes all the known arguments, and just remove __iounmap_at in
favour of open coding it in the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/include/asm/io.h    |  8 -----
 arch/powerpc/kernel/isa-bridge.c | 28 +++++++++++++-----
 arch/powerpc/mm/ioremap_64.c     | 50 --------------------------------
 3 files changed, 21 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 91320985d33f..13f90dd03450 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -699,10 +699,6 @@ static inline void iosync(void)
  *
  * * iounmap undoes such a mapping and can be hooked
  *
- * * __ioremap_at (and the pending __iounmap_at) are low level functions to
- *   create hand-made mappings for use only by the PCI code and cannot
- *   currently be hooked. Must be page aligned.
- *
  * * __ioremap_caller is the same as above but takes an explicit caller
  *   reference rather than using __builtin_return_address(0)
  *
@@ -729,10 +725,6 @@ void __iomem *do_ioremap(phys_addr_t pa, phys_addr_t offset, unsigned long size,
 extern void __iomem *__ioremap_caller(phys_addr_t, unsigned long size,
 				      pgprot_t prot, void *caller);
 
-extern void __iomem * __ioremap_at(phys_addr_t pa, void *ea,
-				   unsigned long size, pgprot_t prot);
-extern void __iounmap_at(void *ea, unsigned long size);
-
 /*
  * When CONFIG_PPC_INDIRECT_PIO is set, we use the generic iomap implementation
  * which needs some additional definitions here. They basically allow PIO
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index 773671b512df..2257d24e6a26 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
+#include <linux/vmalloc.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -38,6 +39,22 @@ EXPORT_SYMBOL_GPL(isa_bridge_pcidev);
 #define ISA_SPACE_MASK 0x1
 #define ISA_SPACE_IO 0x1
 
+static void remap_isa_base(phys_addr_t pa, unsigned long size)
+{
+	WARN_ON_ONCE(ISA_IO_BASE & ~PAGE_MASK);
+	WARN_ON_ONCE(pa & ~PAGE_MASK);
+	WARN_ON_ONCE(size & ~PAGE_MASK);
+
+	if (slab_is_available()) {
+		if (ioremap_page_range(ISA_IO_BASE, ISA_IO_BASE + size, pa,
+				pgprot_noncached(PAGE_KERNEL)))
+			unmap_kernel_range(ISA_IO_BASE, size);
+	} else {
+		early_ioremap_range(ISA_IO_BASE, pa, size,
+				pgprot_noncached(PAGE_KERNEL));
+	}
+}
+
 static void pci_process_ISA_OF_ranges(struct device_node *isa_node,
 				      unsigned long phb_io_base_phys)
 {
@@ -105,15 +122,13 @@ static void pci_process_ISA_OF_ranges(struct device_node *isa_node,
 	if (size > 0x10000)
 		size = 0x10000;
 
-	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
-		     size, pgprot_noncached(PAGE_KERNEL));
+	remap_isa_base(phb_io_base_phys, size);
 	return;
 
 inval_range:
 	printk(KERN_ERR "no ISA IO ranges or unexpected isa range, "
 	       "mapping 64k\n");
-	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
-		     0x10000, pgprot_noncached(PAGE_KERNEL));
+	remap_isa_base(phb_io_base_phys, 0x10000);
 }
 
 
@@ -248,8 +263,7 @@ void __init isa_bridge_init_non_pci(struct device_node *np)
 	 * and map it
 	 */
 	isa_io_base = ISA_IO_BASE;
-	__ioremap_at(pbase, (void *)ISA_IO_BASE,
-		     size, pgprot_noncached(PAGE_KERNEL));
+	remap_isa_base(pbase, size);
 
 	pr_debug("ISA: Non-PCI bridge is %pOF\n", np);
 }
@@ -297,7 +311,7 @@ static void isa_bridge_remove(void)
 	isa_bridge_pcidev = NULL;
 
 	/* Unmap the ISA area */
-	__iounmap_at((void *)ISA_IO_BASE, 0x10000);
+	unmap_kernel_range(ISA_IO_BASE, 0x10000);
 }
 
 /**
diff --git a/arch/powerpc/mm/ioremap_64.c b/arch/powerpc/mm/ioremap_64.c
index 50a99d9684f7..ba5cbb0d66bd 100644
--- a/arch/powerpc/mm/ioremap_64.c
+++ b/arch/powerpc/mm/ioremap_64.c
@@ -4,56 +4,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
-/**
- * Low level function to establish the page tables for an IO mapping
- */
-void __iomem *__ioremap_at(phys_addr_t pa, void *ea, unsigned long size, pgprot_t prot)
-{
-	int ret;
-	unsigned long va = (unsigned long)ea;
-
-	/* We don't support the 4K PFN hack with ioremap */
-	if (pgprot_val(prot) & H_PAGE_4K_PFN)
-		return NULL;
-
-	if ((ea + size) >= (void *)IOREMAP_END) {
-		pr_warn("Outside the supported range\n");
-		return NULL;
-	}
-
-	WARN_ON(pa & ~PAGE_MASK);
-	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
-	WARN_ON(size & ~PAGE_MASK);
-
-	if (slab_is_available()) {
-		ret = ioremap_page_range(va, va + size, pa, prot);
-		if (ret)
-			unmap_kernel_range(va, size);
-	} else {
-		ret = early_ioremap_range(va, pa, size, prot);
-	}
-
-	if (ret)
-		return NULL;
-
-	return (void __iomem *)ea;
-}
-EXPORT_SYMBOL(__ioremap_at);
-
-/**
- * Low level function to tear down the page tables for an IO mapping. This is
- * used for mappings that are manipulated manually, like partial unmapping of
- * PCI IOs or ISA space.
- */
-void __iounmap_at(void *ea, unsigned long size)
-{
-	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
-	WARN_ON(size & ~PAGE_MASK);
-
-	unmap_kernel_range((unsigned long)ea, size);
-}
-EXPORT_SYMBOL(__iounmap_at);
-
 void __iomem *__ioremap_caller(phys_addr_t addr, unsigned long size,
 			       pgprot_t prot, void *caller)
 {
-- 
2.25.1

