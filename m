Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D98027E452
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgI3I4G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 04:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgI3I4F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 04:56:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63295C061755;
        Wed, 30 Sep 2020 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9V0ULT/63vhpFf3OmSQDncMhMeAzEIXfn9rXGfqq2h0=; b=NNPrH+BDzB1Gz5hW6C2i7uUpog
        ZyJM7Hn3YMXH691E98vFz7QLwSisBx8ZLFR4hvw/emzYT4c/JMCT9nTe9TXm2yDP2k6RCQRIWXg4J
        UrkjGyFCfj8H5lNWw7ebkL4bx0zvt4UZMklWw8R2b64eJT3vEZQkklzUN6/ghBY8fT29Hrw9ZH/7j
        pipvJQsM522bWXYrTedVWLnKB503oPqAFdB1bGkTgGcChJ3jfYSXioPc2gz7BCoh6Lo5I7W0juG0N
        buoT+P+6A1tcpxNqbWfqOwlWVC19qvNrLxL8s5lDTPvzn8KNYS/IIsy3XaQha9ABPyxfPdODQv2r/
        fSPj+flQ==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNXtx-0003s7-EU; Wed, 30 Sep 2020 08:55:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>, Sekhar Nori <nsekhar@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 1/9] dma-mapping: split <linux/dma-mapping.h>
Date:   Wed, 30 Sep 2020 10:55:40 +0200
Message-Id: <20200930085548.920261-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930085548.920261-1-hch@lst.de>
References: <20200930085548.920261-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Split out all the bits that are purely for dma_map_ops implementations
and related code into a new <linux/dma-map-ops.h> header so that they
don't get pulled into all the drivers.  That also means the architecture
specific <asm/dma-mapping.h> is not pulled in by <linux/dma-mapping.h>
any more, which leads to a missing includes that were pulled in by the
x86 or arm versions in a few not overly portable drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS                                 |   1 +
 arch/alpha/kernel/pci_iommu.c               |   2 +-
 arch/arc/mm/dma.c                           |   1 +
 arch/arm/common/dmabounce.c                 |   1 +
 arch/arm/mach-highbank/highbank.c           |   2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   2 +-
 arch/arm/mach-imx/mach-mx31moboard.c        |   2 +-
 arch/arm/mach-mvebu/coherency.c             |   2 +-
 arch/arm/mm/dma-mapping-nommu.c             |   1 +
 arch/arm/mm/dma-mapping.c                   |   2 +-
 arch/arm64/mm/dma-mapping.c                 |   1 +
 arch/ia64/hp/common/sba_iommu.c             |   2 +-
 arch/ia64/kernel/dma-mapping.c              |   2 +-
 arch/mips/jazz/jazzdma.c                    |   1 +
 arch/mips/mm/dma-noncoherent.c              |   1 +
 arch/parisc/kernel/drivers.c                |   1 +
 arch/powerpc/include/asm/iommu.h            |   2 +-
 arch/powerpc/include/asm/pci.h              |   2 +-
 arch/powerpc/platforms/ps3/system-bus.c     |   2 +-
 arch/powerpc/platforms/pseries/ibmebus.c    |   2 +-
 arch/powerpc/platforms/pseries/vio.c        |   2 +-
 arch/s390/pci/pci_dma.c                     |   2 +-
 arch/sh/boards/mach-ap325rxa/setup.c        |   1 +
 arch/sh/boards/mach-ecovec24/setup.c        |   1 +
 arch/sh/boards/mach-kfr2r09/setup.c         |   2 +-
 arch/sh/boards/mach-migor/setup.c           |   2 +-
 arch/sh/boards/mach-se/7724/setup.c         |   1 +
 arch/sh/drivers/pci/fixups-dreamcast.c      |   2 +-
 arch/sparc/kernel/iommu.c                   |   2 +-
 arch/sparc/kernel/pci_sun4v.c               |   1 +
 arch/sparc/mm/io-unit.c                     |   2 +-
 arch/sparc/mm/iommu.c                       |   2 +-
 arch/x86/kernel/amd_gart_64.c               |   1 +
 arch/x86/kernel/pci-dma.c                   |   1 +
 arch/x86/kernel/setup.c                     |   2 +
 arch/x86/xen/pci-swiotlb-xen.c              |   2 +-
 drivers/acpi/arm64/iort.c                   |   2 +-
 drivers/acpi/scan.c                         |   2 +-
 drivers/base/dd.c                           |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c     |   2 +-
 drivers/gpu/drm/msm/msm_gem.c               |   1 +
 drivers/iommu/dma-iommu.c                   |   1 +
 drivers/iommu/intel/iommu.c                 |   2 +-
 drivers/misc/mic/bus/mic_bus.c              |   1 +
 drivers/misc/mic/bus/scif_bus.c             |   2 +-
 drivers/misc/mic/bus/scif_bus.h             |   2 +-
 drivers/misc/mic/bus/vop_bus.c              |   2 +-
 drivers/misc/mic/host/mic_boot.c            |   1 +
 drivers/of/device.c                         |   1 +
 drivers/parisc/ccio-dma.c                   |   1 +
 drivers/parisc/sba_iommu.c                  |   1 +
 drivers/pci/xen-pcifront.c                  |   1 +
 drivers/remoteproc/remoteproc_core.c        |   1 +
 drivers/remoteproc/remoteproc_virtio.c      |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c            |   2 +-
 drivers/xen/swiotlb-xen.c                   |   1 +
 include/linux/dma-map-ops.h                 | 158 ++++++++++++++++++
 include/linux/dma-mapping.h                 | 168 +-------------------
 kernel/dma/coherent.c                       |   1 +
 kernel/dma/direct.c                         |   1 +
 kernel/dma/dummy.c                          |   2 +-
 kernel/dma/mapping.c                        |   2 +-
 kernel/dma/ops_helpers.c                    |   1 +
 kernel/dma/virt.c                           |   2 +-
 64 files changed, 223 insertions(+), 200 deletions(-)
 create mode 100644 include/linux/dma-map-ops.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 190c7fa2ea010a..b13fc17943079a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5202,6 +5202,7 @@ T:	git git://git.infradead.org/users/hch/dma-mapping.git
 F:	include/asm-generic/dma-mapping.h
 F:	include/linux/dma-direct.h
 F:	include/linux/dma-mapping.h
+F:	include/linux/dma-map-ops.h
 F:	include/linux/dma-noncoherent.h
 F:	kernel/dma/
 
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 447e0fd0ed3895..d84b19aa8e9da7 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -11,7 +11,7 @@
 #include <linux/export.h>
 #include <linux/scatterlist.h>
 #include <linux/log2.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/iommu-helper.h>
 
 #include <asm/io.h>
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index e947572a521ec0..a8c453e98d753b 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
  */
 
+#include <linux/dma-map-ops.h>
 #include <linux/dma-noncoherent.h>
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index d3e00ea9208834..7996c04393d501 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -25,6 +25,7 @@
 #include <linux/page-flags.h>
 #include <linux/device.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dmapool.h>
 #include <linux/list.h>
 #include <linux/scatterlist.h>
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 56bf29523c657c..db607955a7e451 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -5,7 +5,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clocksource.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 3da4c0920198b6..a329e50928b649 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -16,7 +16,7 @@
 #include <linux/input.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/leds.h>
 #include <linux/platform_data/asoc-mx27vis.h>
 #include <sound/tlv320aic32x4.h>
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 96845a4eaf57ea..7f780ad2d45925 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -4,7 +4,7 @@
  */
 
 #include <linux/delay.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/gfp.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 8f8748a0c84f44..49e3c8d20c2fa1 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -25,7 +25,7 @@
 #include <linux/of_address.h>
 #include <linux/io.h>
 #include <linux/smp.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/mbus.h>
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 43c6d66b6e733a..6bfd2b8845050b 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
 
 #include <asm/cachetype.h>
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7738b4d23f692f..8bf0bc6bc31172 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/dma-contiguous.h>
 #include <linux/highmem.h>
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 6c45350e33aa5a..3afd3bd659d8de 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -6,6 +6,7 @@
 
 #include <linux/gfp.h>
 #include <linux/cache.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/dma-iommu.h>
 #include <xen/xen.h>
diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index cafbb848a34e4d..9148ddbf02e501 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -33,7 +33,7 @@
 #include <linux/bitops.h>         /* hweight64() */
 #include <linux/crash_dump.h>
 #include <linux/iommu-helper.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/prefetch.h>
 #include <linux/swiotlb.h>
 
diff --git a/arch/ia64/kernel/dma-mapping.c b/arch/ia64/kernel/dma-mapping.c
index f640ed6fe1d576..cd0c166bfbc23e 100644
--- a/arch/ia64/kernel/dma-mapping.c
+++ b/arch/ia64/kernel/dma-mapping.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/export.h>
 
 /* Set this to 1 if there is a HW IOMMU in the system */
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index f53bc043334c01..b8fb42e56da0a8 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -16,6 +16,7 @@
 #include <linux/memblock.h>
 #include <linux/spinlock.h>
 #include <linux/gfp.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-noncoherent.h>
 #include <asm/mipsregs.h>
 #include <asm/jazz.h>
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index f34ad1f09799f1..f4e8404ee0490d 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -5,6 +5,7 @@
  * swiped from i386, and cloned for MIPS by Geert, polished by Ralf.
  */
 #include <linux/dma-direct.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/dma-contiguous.h>
 #include <linux/highmem.h>
diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index a5f3e50fe97619..80fa0650736ba7 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -30,6 +30,7 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/export.h>
+#include <linux/dma-map-ops.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/pdc.h>
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 5032f1593299ef..deef7c94d7b61d 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -12,7 +12,7 @@
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/bitops.h>
 #include <asm/machdep.h>
 #include <asm/types.h>
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 63ed7e3b0ba3e4..6436f0b41539e3 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -9,7 +9,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
 
 #include <asm/machdep.h>
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 7bc5f9be3e12d8..c62aaa29a9d5ee 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/export.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index a6f101c958e84b..8c6e509f696756 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -40,7 +40,7 @@
 #include <linux/export.h>
 #include <linux/console.h>
 #include <linux/kobject.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/slab.h>
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 98ed7b09b3fe50..b2797cfe4e2b08 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -20,7 +20,7 @@
 #include <linux/console.h>
 #include <linux/export.h>
 #include <linux/mm.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/kobject.h>
 
 #include <asm/iommu.h>
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 9291023e9469c2..ebc9a49523aa31 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -10,7 +10,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/iommu-helper.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/vmalloc.h>
 #include <linux/pci.h>
 #include <asm/pci_dma.h>
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 665cad452798bb..bac8a058ebd7cd 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -13,6 +13,7 @@
 
 #include <cpu/sh7723.h>
 
+#include <linux/dma-map-ops.h>
 #include <linux/clkdev.h>
 #include <linux/delay.h>
 #include <linux/device.h>
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index dd427bac5cdeb7..bab91a99124e1f 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -36,6 +36,7 @@
 #include <linux/usb/r8a66597.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/videodev2.h>
+#include <linux/dma-map-ops.h>
 
 #include <media/drv-intf/renesas-ceu.h>
 #include <media/i2c/mt9t112.h>
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 96538ba3aa323f..eeb5ce341efdd7 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -14,7 +14,6 @@
 
 #include <linux/clkdev.h>
 #include <linux/delay.h>
-#include <linux/dma-mapping.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/i2c.h>
@@ -33,6 +32,7 @@
 #include <linux/sh_intc.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/videodev2.h>
+#include <linux/dma-map-ops.h>
 
 #include <mach/kfr2r09.h>
 
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 9ed369dad62df7..6703a2122c0d6b 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2008 Magnus Damm
  */
 #include <linux/clkdev.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 32f5dd9448894a..8d6541ba01865b 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -32,6 +32,7 @@
 #include <linux/smc91x.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/videodev2.h>
+#include <linux/dma-map-ops.h>
 
 #include <mach-se/mach/se7724.h>
 #include <media/drv-intf/renesas-ceu.h>
diff --git a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
index 7be8694c0d1310..41e4daee8f043f 100644
--- a/arch/sh/drivers/pci/fixups-dreamcast.c
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c
@@ -19,7 +19,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index c3e4e2df26a8b8..a034f571d8695e 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -10,7 +10,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/errno.h>
 #include <linux/iommu-helper.h>
 #include <linux/bitmap.h>
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 6b92dd51c0026f..9de57e88f7a177 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/log2.h>
 #include <linux/of_device.h>
+#include <linux/dma-map-ops.h>
 #include <asm/iommu-common.h>
 
 #include <asm/iommu.h>
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index 430a47a1b6aeff..bf3e6d2fe5d949 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -11,7 +11,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/bitops.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 3a388b1c5d4bc9..0c0342e5b10d52 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index c96dcaa572ebd3..9ac696487b134b 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -32,6 +32,7 @@
 #include <linux/gfp.h>
 #include <linux/atomic.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-map-ops.h>
 #include <asm/mtrr.h>
 #include <asm/proto.h>
 #include <asm/iommu.h>
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 5dcedad21dffa2..4892dd043d414c 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-map-ops.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-debug.h>
 #include <linux/iommu.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3511736fbc747e..9286fa9d575e6d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -7,6 +7,7 @@
  */
 #include <linux/console.h>
 #include <linux/crash_dump.h>
+#include <linux/dma-contiguous.h>
 #include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/init_ohci1394_dma.h>
@@ -19,6 +20,7 @@
 #include <linux/hugetlb.h>
 #include <linux/tboot.h>
 #include <linux/usb/xhci-dbgp.h>
+#include <linux/swiotlb.h>
 
 #include <uapi/linux/mount.h>
 
diff --git a/arch/x86/xen/pci-swiotlb-xen.c b/arch/x86/xen/pci-swiotlb-xen.c
index 33293ce01d8db5..19ae3e4fe4e98e 100644
--- a/arch/x86/xen/pci-swiotlb-xen.c
+++ b/arch/x86/xen/pci-swiotlb-xen.c
@@ -2,7 +2,7 @@
 
 /* Glue code to lib/swiotlb-xen.c */
 
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/pci.h>
 #include <xen/swiotlb-xen.h>
 
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index de18c07ca02cc4..6446b2572f075f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -18,7 +18,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 
 #define IORT_TYPE_MASK(type)	(1 << (type))
 #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2142f155476176..e0b7d7a605b5a2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -13,7 +13,7 @@
 #include <linux/kthread.h>
 #include <linux/dmi.h>
 #include <linux/nls.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pgtable.h>
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 857b0a928e8d0d..b3d43ace5c2b94 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -19,7 +19,7 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/delay.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dma.c b/drivers/gpu/drm/exynos/exynos_drm_dma.c
index 58b89ec11b0eb3..78b8f3403c3039 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dma.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dma.c
@@ -5,7 +5,7 @@
 // Author: Andrzej Hajda <a.hajda@samsung.com>
 
 #include <linux/dma-iommu.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index b2f49152b4d4c2..6787ab0d0e431d 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -4,6 +4,7 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <linux/dma-map-ops.h>
 #include <linux/spinlock.h>
 #include <linux/shmem_fs.h>
 #include <linux/dma-buf.h>
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c12c1dc43d312e..d2e3f26228151f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi_iort.h>
 #include <linux/device.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-contiguous.h>
 #include <linux/dma-iommu.h>
 #include <linux/dma-noncoherent.h>
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2c426dbdf17f3b..bd3470142b0678 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -23,7 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/dmar.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/mempool.h>
 #include <linux/memory.h>
 #include <linux/cpu.h>
diff --git a/drivers/misc/mic/bus/mic_bus.c b/drivers/misc/mic/bus/mic_bus.c
index ed9a8351c3bfd1..a08cb29692a8fe 100644
--- a/drivers/misc/mic/bus/mic_bus.c
+++ b/drivers/misc/mic/bus/mic_bus.c
@@ -9,6 +9,7 @@
  * This implementation is very similar to the the virtio bus driver
  * implementation @ drivers/virtio/virtio.c
  */
+#include <linux/dma-map-ops.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/idr.h>
diff --git a/drivers/misc/mic/bus/scif_bus.c b/drivers/misc/mic/bus/scif_bus.c
index ae84109649d0f3..ad7c3604f1510f 100644
--- a/drivers/misc/mic/bus/scif_bus.c
+++ b/drivers/misc/mic/bus/scif_bus.c
@@ -9,7 +9,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/idr.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 
 #include "scif_bus.h"
 
diff --git a/drivers/misc/mic/bus/scif_bus.h b/drivers/misc/mic/bus/scif_bus.h
index 642cd43bcabc6d..4981eb56f87979 100644
--- a/drivers/misc/mic/bus/scif_bus.h
+++ b/drivers/misc/mic/bus/scif_bus.h
@@ -12,7 +12,7 @@
  * Everything a scif driver needs to work with any particular scif
  * hardware abstraction layer.
  */
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 
 #include <linux/mic_common.h>
 #include "../common/mic_dev.h"
diff --git a/drivers/misc/mic/bus/vop_bus.c b/drivers/misc/mic/bus/vop_bus.c
index 3c865534868a0e..6935ddca1bd5b1 100644
--- a/drivers/misc/mic/bus/vop_bus.c
+++ b/drivers/misc/mic/bus/vop_bus.c
@@ -9,7 +9,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/idr.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 
 #include "vop_bus.h"
 
diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index fb5b3989753daf..8cb85b8b3e199b 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -10,6 +10,7 @@
 #include <linux/firmware.h>
 #include <linux/pci.h>
 #include <linux/kmod.h>
+#include <linux/dma-map-ops.h>
 #include <linux/mic_common.h>
 #include <linux/mic_bus.h>
 #include "../bus/scif_bus.h"
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 6e3ae7ebc33eeb..655dee422563f0 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -6,6 +6,7 @@
 #include <linux/of_address.h>
 #include <linux/of_iommu.h>
 #include <linux/dma-direct.h> /* for bus_dma_region */
+#include <linux/dma-map-ops.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 8cf0b9c8bdf795..b5f9ee81a46c1e 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -39,6 +39,7 @@
 #include <linux/reboot.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
 #include <linux/iommu-helper.h>
 #include <linux/export.h>
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 6fcde7980358ae..dce4cdf786cdb1 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -25,6 +25,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/pci.h>
+#include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
 #include <linux/iommu-helper.h>
 
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index c0e85be598c112..c6fe0cfec0f681 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <linux/time.h>
 #include <linux/ktime.h>
+#include <linux/swiotlb.h>
 #include <xen/platform_pci.h>
 
 #include <asm/xen/swiotlb-xen.h>
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8157dd491d2819..dab2c0f5caf0ec 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -22,6 +22,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-direct.h> /* XXX: pokes into bus_dma_range */
 #include <linux/firmware.h>
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index dfd3808c34fdbd..0cc617f760682c 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -9,7 +9,7 @@
  * Brian Swetland <swetland@google.com>
  */
 
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/remoteproc.h>
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 62d6403271450e..2629911c29bbf4 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -18,7 +18,7 @@
 #include <linux/wait.h>
 #include <linux/uuid.h>
 #include <linux/iommu.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/sysfs.h>
 #include <linux/file.h>
 #include <linux/etherdevice.h>
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 030a225624b060..71ff4bf380738c 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -27,6 +27,7 @@
 #define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
 
 #include <linux/memblock.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/export.h>
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
new file mode 100644
index 00000000000000..4b4ba5bdcf6a8d
--- /dev/null
+++ b/include/linux/dma-map-ops.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header is for implementations of dma_map_ops and related code.
+ * It should not be included in drivers just using the DMA API.
+ */
+#ifndef _LINUX_DMA_MAP_OPS_H
+#define _LINUX_DMA_MAP_OPS_H
+
+#include <linux/dma-mapping.h>
+
+struct dma_map_ops {
+	void *(*alloc)(struct device *dev, size_t size,
+			dma_addr_t *dma_handle, gfp_t gfp,
+			unsigned long attrs);
+	void (*free)(struct device *dev, size_t size, void *vaddr,
+			dma_addr_t dma_handle, unsigned long attrs);
+	struct page *(*alloc_pages)(struct device *dev, size_t size,
+			dma_addr_t *dma_handle, enum dma_data_direction dir,
+			gfp_t gfp);
+	void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
+			dma_addr_t dma_handle, enum dma_data_direction dir);
+	void *(*alloc_noncoherent)(struct device *dev, size_t size,
+			dma_addr_t *dma_handle, enum dma_data_direction dir,
+			gfp_t gfp);
+	void (*free_noncoherent)(struct device *dev, size_t size, void *vaddr,
+			dma_addr_t dma_handle, enum dma_data_direction dir);
+	int (*mmap)(struct device *, struct vm_area_struct *,
+			void *, dma_addr_t, size_t, unsigned long attrs);
+
+	int (*get_sgtable)(struct device *dev, struct sg_table *sgt,
+			void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			unsigned long attrs);
+
+	dma_addr_t (*map_page)(struct device *dev, struct page *page,
+			unsigned long offset, size_t size,
+			enum dma_data_direction dir, unsigned long attrs);
+	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs);
+	/*
+	 * map_sg returns 0 on error and a value > 0 on success.
+	 * It should never return a value < 0.
+	 */
+	int (*map_sg)(struct device *dev, struct scatterlist *sg, int nents,
+			enum dma_data_direction dir, unsigned long attrs);
+	void (*unmap_sg)(struct device *dev, struct scatterlist *sg, int nents,
+			enum dma_data_direction dir, unsigned long attrs);
+	dma_addr_t (*map_resource)(struct device *dev, phys_addr_t phys_addr,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs);
+	void (*unmap_resource)(struct device *dev, dma_addr_t dma_handle,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs);
+	void (*sync_single_for_cpu)(struct device *dev, dma_addr_t dma_handle,
+			size_t size, enum dma_data_direction dir);
+	void (*sync_single_for_device)(struct device *dev,
+			dma_addr_t dma_handle, size_t size,
+			enum dma_data_direction dir);
+	void (*sync_sg_for_cpu)(struct device *dev, struct scatterlist *sg,
+			int nents, enum dma_data_direction dir);
+	void (*sync_sg_for_device)(struct device *dev, struct scatterlist *sg,
+			int nents, enum dma_data_direction dir);
+	void (*cache_sync)(struct device *dev, void *vaddr, size_t size,
+			enum dma_data_direction direction);
+	int (*dma_supported)(struct device *dev, u64 mask);
+	u64 (*get_required_mask)(struct device *dev);
+	size_t (*max_mapping_size)(struct device *dev);
+	unsigned long (*get_merge_boundary)(struct device *dev);
+};
+
+#ifdef CONFIG_DMA_OPS
+#include <asm/dma-mapping.h>
+
+static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+	if (dev->dma_ops)
+		return dev->dma_ops;
+	return get_arch_dma_ops(dev->bus);
+}
+
+static inline void set_dma_ops(struct device *dev,
+			       const struct dma_map_ops *dma_ops)
+{
+	dev->dma_ops = dma_ops;
+}
+#else /* CONFIG_DMA_OPS */
+static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+	return NULL;
+}
+static inline void set_dma_ops(struct device *dev,
+			       const struct dma_map_ops *dma_ops)
+{
+}
+#endif /* CONFIG_DMA_OPS */
+
+#ifdef CONFIG_DMA_DECLARE_COHERENT
+int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
+		dma_addr_t device_addr, size_t size);
+int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
+		dma_addr_t *dma_handle, void **ret);
+int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
+int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, size_t size, int *ret);
+
+void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
+		dma_addr_t *dma_handle);
+int dma_release_from_global_coherent(int order, void *vaddr);
+int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
+		size_t size, int *ret);
+
+#else
+static inline int dma_declare_coherent_memory(struct device *dev,
+		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
+{
+	return -ENOSYS;
+}
+#define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
+#define dma_release_from_dev_coherent(dev, order, vaddr) (0)
+#define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
+
+static inline void *dma_alloc_from_global_coherent(struct device *dev,
+		ssize_t size, dma_addr_t *dma_handle)
+{
+	return NULL;
+}
+static inline int dma_release_from_global_coherent(int order, void *vaddr)
+{
+	return 0;
+}
+static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
+		void *cpu_addr, size_t size, int *ret)
+{
+	return 0;
+}
+#endif /* CONFIG_DMA_DECLARE_COHERENT */
+
+#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+		const struct iommu_ops *iommu, bool coherent);
+#else
+static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
+		u64 size, const struct iommu_ops *iommu, bool coherent)
+{
+}
+#endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */
+
+#ifdef CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS
+void arch_teardown_dma_ops(struct device *dev);
+#else
+static inline void arch_teardown_dma_ops(struct device *dev)
+{
+}
+#endif /* CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS */
+
+extern const struct dma_map_ops dma_dummy_ops;
+
+#endif /* _LINUX_DMA_MAP_OPS_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 7c77cd6f3604a7..9591cd482d7c2d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -62,72 +62,6 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
-struct dma_map_ops {
-	void* (*alloc)(struct device *dev, size_t size,
-				dma_addr_t *dma_handle, gfp_t gfp,
-				unsigned long attrs);
-	void (*free)(struct device *dev, size_t size,
-			      void *vaddr, dma_addr_t dma_handle,
-			      unsigned long attrs);
-	struct page *(*alloc_pages)(struct device *dev, size_t size,
-			dma_addr_t *dma_handle, enum dma_data_direction dir,
-			gfp_t gfp);
-	void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
-			dma_addr_t dma_handle, enum dma_data_direction dir);
-	void* (*alloc_noncoherent)(struct device *dev, size_t size,
-			dma_addr_t *dma_handle, enum dma_data_direction dir,
-			gfp_t gfp);
-	void (*free_noncoherent)(struct device *dev, size_t size, void *vaddr,
-			dma_addr_t dma_handle, enum dma_data_direction dir);
-	int (*mmap)(struct device *, struct vm_area_struct *,
-			  void *, dma_addr_t, size_t,
-			  unsigned long attrs);
-
-	int (*get_sgtable)(struct device *dev, struct sg_table *sgt, void *,
-			   dma_addr_t, size_t, unsigned long attrs);
-
-	dma_addr_t (*map_page)(struct device *dev, struct page *page,
-			       unsigned long offset, size_t size,
-			       enum dma_data_direction dir,
-			       unsigned long attrs);
-	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
-			   size_t size, enum dma_data_direction dir,
-			   unsigned long attrs);
-	/*
-	 * map_sg returns 0 on error and a value > 0 on success.
-	 * It should never return a value < 0.
-	 */
-	int (*map_sg)(struct device *dev, struct scatterlist *sg,
-		      int nents, enum dma_data_direction dir,
-		      unsigned long attrs);
-	void (*unmap_sg)(struct device *dev,
-			 struct scatterlist *sg, int nents,
-			 enum dma_data_direction dir,
-			 unsigned long attrs);
-	dma_addr_t (*map_resource)(struct device *dev, phys_addr_t phys_addr,
-			       size_t size, enum dma_data_direction dir,
-			       unsigned long attrs);
-	void (*unmap_resource)(struct device *dev, dma_addr_t dma_handle,
-			   size_t size, enum dma_data_direction dir,
-			   unsigned long attrs);
-	void (*sync_single_for_cpu)(struct device *dev,
-				    dma_addr_t dma_handle, size_t size,
-				    enum dma_data_direction dir);
-	void (*sync_single_for_device)(struct device *dev,
-				       dma_addr_t dma_handle, size_t size,
-				       enum dma_data_direction dir);
-	void (*sync_sg_for_cpu)(struct device *dev,
-				struct scatterlist *sg, int nents,
-				enum dma_data_direction dir);
-	void (*sync_sg_for_device)(struct device *dev,
-				   struct scatterlist *sg, int nents,
-				   enum dma_data_direction dir);
-	int (*dma_supported)(struct device *dev, u64 mask);
-	u64 (*get_required_mask)(struct device *dev);
-	size_t (*max_mapping_size)(struct device *dev);
-	unsigned long (*get_merge_boundary)(struct device *dev);
-};
-
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
@@ -140,79 +74,9 @@ struct dma_map_ops {
  */
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
 
-extern const struct dma_map_ops dma_virt_ops;
-extern const struct dma_map_ops dma_dummy_ops;
-
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
-#ifdef CONFIG_DMA_DECLARE_COHERENT
-/*
- * These three functions are only for dma allocator.
- * Don't use them in device drivers.
- */
-int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
-				       dma_addr_t *dma_handle, void **ret);
-int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
-
-int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
-			    void *cpu_addr, size_t size, int *ret);
-
-void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size, dma_addr_t *dma_handle);
-int dma_release_from_global_coherent(int order, void *vaddr);
-int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
-				  size_t size, int *ret);
-
-#else
-#define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
-#define dma_release_from_dev_coherent(dev, order, vaddr) (0)
-#define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
-
-static inline void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
-						   dma_addr_t *dma_handle)
-{
-	return NULL;
-}
-
-static inline int dma_release_from_global_coherent(int order, void *vaddr)
-{
-	return 0;
-}
-
-static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
-						void *cpu_addr, size_t size,
-						int *ret)
-{
-	return 0;
-}
-#endif /* CONFIG_DMA_DECLARE_COHERENT */
-
 #ifdef CONFIG_HAS_DMA
-#include <asm/dma-mapping.h>
-
-#ifdef CONFIG_DMA_OPS
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
-{
-	if (dev->dma_ops)
-		return dev->dma_ops;
-	return get_arch_dma_ops(dev->bus);
-}
-
-static inline void set_dma_ops(struct device *dev,
-			       const struct dma_map_ops *dma_ops)
-{
-	dev->dma_ops = dma_ops;
-}
-#else /* CONFIG_DMA_OPS */
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
-{
-	return NULL;
-}
-static inline void set_dma_ops(struct device *dev,
-			       const struct dma_map_ops *dma_ops)
-{
-}
-#endif /* CONFIG_DMA_OPS */
-
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	debug_dma_mapping_error(dev, dma_addr);
@@ -595,24 +459,6 @@ static inline bool dma_addressing_limited(struct device *dev)
 			    dma_get_required_mask(dev);
 }
 
-#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-		const struct iommu_ops *iommu, bool coherent);
-#else
-static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
-		u64 size, const struct iommu_ops *iommu, bool coherent)
-{
-}
-#endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */
-
-#ifdef CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS
-void arch_teardown_dma_ops(struct device *dev);
-#else
-static inline void arch_teardown_dma_ops(struct device *dev)
-{
-}
-#endif /* CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS */
-
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->max_segment_size)
@@ -672,18 +518,6 @@ static inline int dma_get_cache_alignment(void)
 	return 1;
 }
 
-#ifdef CONFIG_DMA_DECLARE_COHERENT
-int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
-				dma_addr_t device_addr, size_t size);
-#else
-static inline int
-dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
-			    dma_addr_t device_addr, size_t size)
-{
-	return -ENOSYS;
-}
-#endif /* CONFIG_DMA_DECLARE_COHERENT */
-
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
@@ -741,4 +575,6 @@ static inline int dma_mmap_wc(struct device *dev,
 int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 		dma_addr_t dma_start, u64 size);
 
+extern const struct dma_map_ops dma_virt_ops;
+
 #endif /* _LINUX_DMA_MAPPING_H */
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index c0685196fb6d42..5b5b6c7ec7f28e 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-map-ops.h>
 
 struct dma_coherent_mem {
 	void		*virt_base;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 121a9c1969dd3a..8cf5689a8c4044 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-contiguous.h>
 #include <linux/pfn.h>
diff --git a/kernel/dma/dummy.c b/kernel/dma/dummy.c
index 6974b1bd7d0b88..eacd4c5b10bf6d 100644
--- a/kernel/dma/dummy.c
+++ b/kernel/dma/dummy.c
@@ -2,7 +2,7 @@
 /*
  * Dummy DMA ops that always fail.
  */
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 
 static int dma_dummy_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9669550656a0b4..2e13e6d3903fa0 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -8,7 +8,7 @@
 #include <linux/memblock.h> /* for max_pfn */
 #include <linux/acpi.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/of_device.h>
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index 5828e5e01b7913..60d7b6cdfd8d15 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -4,6 +4,7 @@
  * the allocated memory contains normal pages in the direct kernel mapping.
  */
 #include <linux/dma-contiguous.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dma-noncoherent.h>
 
 /*
diff --git a/kernel/dma/virt.c b/kernel/dma/virt.c
index 6986bf1fd6689c..59d32317dd574a 100644
--- a/kernel/dma/virt.c
+++ b/kernel/dma/virt.c
@@ -4,7 +4,7 @@
  */
 #include <linux/export.h>
 #include <linux/mm.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
 
 static void *dma_virt_alloc(struct device *dev, size_t size,
-- 
2.28.0

