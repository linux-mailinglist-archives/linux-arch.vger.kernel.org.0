Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C036CF02AD
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 17:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389760AbfKEQ3A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 11:29:00 -0500
Received: from verein.lst.de ([213.95.11.211]:46395 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390137AbfKEQ3A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Nov 2019 11:29:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D251368AFE; Tue,  5 Nov 2019 17:28:56 +0100 (CET)
Date:   Tue, 5 Nov 2019 17:28:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Olof Johansson <olof@lixom.net>
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
Message-ID: <20191105162856.GA15402@lst.de>
References: <20181213112511.GA4574@lst.de> <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de> <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de> <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de> <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de> <20190103073622.GA24323@lst.de> <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de> <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de> <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de> <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 05, 2019 at 08:56:27AM +0100, Christian Zigotzky wrote:
> Hi All,
>
> We still have DMA problems with some PCI devices. Since the PowerPC updates 
> 4.21-1 [1] we need to decrease the RAM to 3500MB (mem=3500M) if we want to 
> work with our PCI devices. The FSL P5020 and P5040 have these problems 
> currently.
>
> Error message:
>
> [   25.654852] bttv 1000:04:05.0: overflow 0x00000000fe077000+4096 of DMA 
> mask ffffffff bus mask df000000
>
> All 5.x Linux kernels can't initialize a SCSI PCI card anymore so booting 
> of a Linux userland isn't possible.
>
> PLEASE check the DMA changes in the PowerPC updates 4.21-1 [1]. The kernel 
> 4.20 works with all PCI devices without limitation of RAM.

Can you send me the .config and a dmesg?  And in the meantime try the
patch below?

---
From 4d659b7311bd4141fdd3eeeb80fa2d7602ea01d4 Mon Sep 17 00:00:00 2001
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Fri, 18 Oct 2019 13:00:43 +0200
Subject: dma-direct: check for overflows on 32 bit DMA addresses

As seen on the new Raspberry Pi 4 and sta2x11's DMA implementation it is
possible for a device configured with 32 bit DMA addresses and a partial
DMA mapping located at the end of the address space to overflow. It
happens when a higher physical address, not DMAable, is translated to
it's DMA counterpart.

For example the Raspberry Pi 4, configurable up to 4 GB of memory, has
an interconnect capable of addressing the lower 1 GB of physical memory
with a DMA offset of 0xc0000000. It transpires that, any attempt to
translate physical addresses higher than the first GB will result in an
overflow which dma_capable() can't detect as it only checks for
addresses bigger then the maximum allowed DMA address.

Fix this by verifying in dma_capable() if the DMA address range provided
is at any point lower than the minimum possible DMA address on the bus.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 include/linux/dma-direct.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index adf993a3bd58..6ad9e9ea7564 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -3,6 +3,7 @@
 #define _LINUX_DMA_DIRECT_H 1
 
 #include <linux/dma-mapping.h>
+#include <linux/memblock.h> /* for min_low_pfn */
 #include <linux/mem_encrypt.h>
 
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
@@ -27,6 +28,13 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	if (!dev->dma_mask)
 		return false;
 
+#ifndef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	/* Check if DMA address overflowed */
+	if (min(addr, addr + size - 1) <
+		__phys_to_dma(dev, (phys_addr_t)(min_low_pfn << PAGE_SHIFT)))
+		return false;
+#endif
+
 	return addr + size - 1 <=
 		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
 }
-- 
2.20.1

