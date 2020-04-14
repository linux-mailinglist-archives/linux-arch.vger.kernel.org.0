Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C131A7E83
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502704AbgDNNOm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502699AbgDNNOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 09:14:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B602AC061A0C;
        Tue, 14 Apr 2020 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=El3K7mGKX6B9o1n3n8/uSzRNv+M9pQhI906vP4nRJj0=; b=TknBV49y24E5J7xFzadKo5kjo5
        H8QYGdmubIg2vBwe4mYro12NwuYp1KZTwMSErFsx1s9TwfxWwFDRWSyYmrajo1Y/8Dd7olymaZiKB
        OUeMc4IYdXC9zX9BTcv/N9q3I31wh3TlIc98iy/C6FIEx45kob0iaVmoDToA6yCmEag/F5zzdsuW3
        ZFo+awA/3wTJWtGY2E0rKHXogHWWApzIqlcsjjb6Awp4NUqZi+Hx1hc/D0P1cAD7SDlvPd8K2icXI
        wl+6z7yHRJpbpDdPSvQSP4Id+GQVwc5XlDPmgap8nH2NdGYXZ9fDSfOeggdXxpsBX7IxfyPfaRIBb
        KZM3myUg==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLOG-0006SH-MB; Tue, 14 Apr 2020 13:14:13 +0000
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
Subject: [PATCH 06/29] powerpc: add an ioremap_phb helper
Date:   Tue, 14 Apr 2020 15:13:25 +0200
Message-Id: <20200414131348.444715-7-hch@lst.de>
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

Factor code shared between pci_64 and electra_cf into a ioremap_pbh
helper that follows the normal ioremap semantics, and returns a
useful __iomem pointer.  Note that it opencodes __ioremap_at as
we know from the callers the slab is available.  Switch pci_64
to also store the result as __iomem pointer, and unmap the result
using iounmap instead of force casting and using vmalloc APIs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/include/asm/io.h         |  2 +
 arch/powerpc/include/asm/pci-bridge.h |  2 +-
 arch/powerpc/kernel/pci_64.c          | 53 ++++++++++++++++++---------
 drivers/pcmcia/electra_cf.c           | 45 ++++++++---------------
 4 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 635969b5b58e..91320985d33f 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -719,6 +719,8 @@ void __iomem *ioremap_coherent(phys_addr_t address, unsigned long size);
 
 extern void iounmap(volatile void __iomem *addr);
 
+void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size);
+
 int early_ioremap_range(unsigned long ea, phys_addr_t pa,
 			unsigned long size, pgprot_t prot);
 void __iomem *do_ioremap(phys_addr_t pa, phys_addr_t offset, unsigned long size,
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 69f4cb3b7c56..b92e81b256e5 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -66,7 +66,7 @@ struct pci_controller {
 
 	void __iomem *io_base_virt;
 #ifdef CONFIG_PPC64
-	void *io_base_alloc;
+	void __iomem *io_base_alloc;
 #endif
 	resource_size_t io_base_phys;
 	resource_size_t pci_io_size;
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index f83d1f69b1dd..2a976314f169 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -109,23 +109,46 @@ int pcibios_unmap_io_space(struct pci_bus *bus)
 	/* Get the host bridge */
 	hose = pci_bus_to_host(bus);
 
-	/* Check if we have IOs allocated */
-	if (hose->io_base_alloc == NULL)
-		return 0;
-
 	pr_debug("IO unmapping for PHB %pOF\n", hose->dn);
 	pr_debug("  alloc=0x%p\n", hose->io_base_alloc);
 
-	/* This is a PHB, we fully unmap the IO area */
-	vunmap(hose->io_base_alloc);
-
+	iounmap(hose->io_base_alloc);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pcibios_unmap_io_space);
 
-static int pcibios_map_phb_io_space(struct pci_controller *hose)
+void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size)
 {
 	struct vm_struct *area;
+	unsigned long addr;
+
+	WARN_ON_ONCE(paddr & ~PAGE_MASK);
+	WARN_ON_ONCE(size & ~PAGE_MASK);
+
+	/*
+	 * Let's allocate some IO space for that guy. We don't pass VM_IOREMAP
+	 * because we don't care about alignment tricks that the core does in
+	 * that case.  Maybe we should due to stupid card with incomplete
+	 * address decoding but I'd rather not deal with those outside of the
+	 * reserved 64K legacy region.
+	 */
+	area = __get_vm_area(size, 0, PHB_IO_BASE, PHB_IO_END);
+	if (!area)
+		return NULL;
+
+	addr = (unsigned long)area->addr;
+	if (ioremap_page_range(addr, addr + size, paddr,
+			pgprot_noncached(PAGE_KERNEL))) {
+		unmap_kernel_range(addr, size);
+		return NULL;
+	}
+
+	return (void __iomem *)addr;
+}
+EXPORT_SYMBOL_GPL(ioremap_phb);
+
+static int pcibios_map_phb_io_space(struct pci_controller *hose)
+{
 	unsigned long phys_page;
 	unsigned long size_page;
 	unsigned long io_virt_offset;
@@ -146,12 +169,11 @@ static int pcibios_map_phb_io_space(struct pci_controller *hose)
 	 * with incomplete address decoding but I'd rather not deal with
 	 * those outside of the reserved 64K legacy region.
 	 */
-	area = __get_vm_area(size_page, 0, PHB_IO_BASE, PHB_IO_END);
-	if (area == NULL)
+	hose->io_base_alloc = ioremap_phb(phys_page, size_page);
+	if (!hose->io_base_alloc)
 		return -ENOMEM;
-	hose->io_base_alloc = area->addr;
-	hose->io_base_virt = (void __iomem *)(area->addr +
-					      hose->io_base_phys - phys_page);
+	hose->io_base_virt = hose->io_base_alloc +
+				hose->io_base_phys - phys_page;
 
 	pr_debug("IO mapping for PHB %pOF\n", hose->dn);
 	pr_debug("  phys=0x%016llx, virt=0x%p (alloc=0x%p)\n",
@@ -159,11 +181,6 @@ static int pcibios_map_phb_io_space(struct pci_controller *hose)
 	pr_debug("  size=0x%016llx (alloc=0x%016lx)\n",
 		 hose->pci_io_size, size_page);
 
-	/* Establish the mapping */
-	if (__ioremap_at(phys_page, area->addr, size_page,
-			 pgprot_noncached(PAGE_KERNEL)) == NULL)
-		return -ENOMEM;
-
 	/* Fixup hose IO resource */
 	io_virt_offset = pcibios_io_space_offset(hose);
 	hose->io_resource.start += io_virt_offset;
diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index f2741c04289d..35158cfd9c1a 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -178,10 +178,9 @@ static int electra_cf_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct electra_cf_socket   *cf;
 	struct resource mem, io;
-	int status;
+	int status = -ENOMEM;
 	const unsigned int *prop;
 	int err;
-	struct vm_struct *area;
 
 	err = of_address_to_resource(np, 0, &mem);
 	if (err)
@@ -202,30 +201,19 @@ static int electra_cf_probe(struct platform_device *ofdev)
 	cf->mem_phys = mem.start;
 	cf->mem_size = PAGE_ALIGN(resource_size(&mem));
 	cf->mem_base = ioremap(cf->mem_phys, cf->mem_size);
+	if (!cf->mem_base)
+		goto out_free_cf;
 	cf->io_size = PAGE_ALIGN(resource_size(&io));
-
-	area = __get_vm_area(cf->io_size, 0, PHB_IO_BASE, PHB_IO_END);
-	if (area == NULL) {
-		status = -ENOMEM;
-		goto fail1;
-	}
-
-	cf->io_virt = (void __iomem *)(area->addr);
+	cf->io_virt = ioremap_phb(io.start, cf->io_size);
+	if (!cf->io_virt)
+		goto out_unmap_mem;
 
 	cf->gpio_base = ioremap(0xfc103000, 0x1000);
+	if (!cf->gpio_base)
+		goto out_unmap_virt;
 	dev_set_drvdata(device, cf);
 
-	if (!cf->mem_base || !cf->io_virt || !cf->gpio_base ||
-	    (__ioremap_at(io.start, cf->io_virt, cf->io_size,
-			  pgprot_noncached(PAGE_KERNEL)) == NULL)) {
-		dev_err(device, "can't ioremap ranges\n");
-		status = -ENOMEM;
-		goto fail1;
-	}
-
-
 	cf->io_base = (unsigned long)cf->io_virt - VMALLOC_END;
-
 	cf->iomem.start = (unsigned long)cf->mem_base;
 	cf->iomem.end = (unsigned long)cf->mem_base + (mem.end - mem.start);
 	cf->iomem.flags = IORESOURCE_MEM;
@@ -305,14 +293,13 @@ static int electra_cf_probe(struct platform_device *ofdev)
 	if (cf->irq)
 		free_irq(cf->irq, cf);
 
-	if (cf->io_virt)
-		__iounmap_at(cf->io_virt, cf->io_size);
-	if (cf->mem_base)
-		iounmap(cf->mem_base);
-	if (cf->gpio_base)
-		iounmap(cf->gpio_base);
-	if (area)
-		device_init_wakeup(&ofdev->dev, 0);
+	iounmap(cf->gpio_base);
+out_unmap_virt:
+	device_init_wakeup(&ofdev->dev, 0);
+	iounmap(cf->io_virt);
+out_unmap_mem:
+	iounmap(cf->mem_base);
+out_free_cf:
 	kfree(cf);
 	return status;
 
@@ -330,7 +317,7 @@ static int electra_cf_remove(struct platform_device *ofdev)
 	free_irq(cf->irq, cf);
 	del_timer_sync(&cf->timer);
 
-	__iounmap_at(cf->io_virt, cf->io_size);
+	iounmap(cf->io_virt);
 	iounmap(cf->mem_base);
 	iounmap(cf->gpio_base);
 	release_mem_region(cf->mem_phys, cf->mem_size);
-- 
2.25.1

