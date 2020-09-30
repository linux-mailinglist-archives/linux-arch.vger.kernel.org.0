Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BD727E44B
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgI3I4G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 04:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgI3I4G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 04:56:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA634C0613D1;
        Wed, 30 Sep 2020 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Hc4ZwUam31VwnraGp3u9+lkEQz3nnsxSY58s3rx8EN0=; b=GUmCkkS5M+DSSMVNpa1ARhdAOA
        xO1GX/XB3fZ+wQwodHpr/baxLfM1+ws4Gny5Pxmnfo3SlUOIvRDrw39kG2TLkTY5ygx0ry4qqSeGJ
        IPWIRMCwy3u3fH/caphz5js/VXACSaObZ5Bfp+MoemoiCRqD5eQCtYvXVlyzBXwIAOZ+dQV8nHd4k
        JmW/GH/dHH8+I20mR3g4P/17KMvXn0UuDKyD8IfOTCnG0K5pB8msoYd5hKoxs0zxM5HADDe6wGyWA
        1h3S1M0SgisK5DoRE9WkQVgagY0SFWqcncFM8t6V8sgMAtAVbeQJ8CmDT5lLkrTJP4gWCrpZ69Cwo
        VSXIwEqw==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNXtv-0003s2-OW; Wed, 30 Sep 2020 08:55:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>, Sekhar Nori <nsekhar@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: clean up the DMA mapping headers
Date:   Wed, 30 Sep 2020 10:55:39 +0200
Message-Id: <20200930085548.920261-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

this series cleans up the dma-mapping headers by moving everything not
required by normal drivers out of <linux/dma-mapping.h> into a new
<linux/dma-map-ops.h> and then folding most other DMA mapping related
headers either into the new dma-map-ops.h one, or by moving them to
kernel/dma/ and thus out of the global scope.  A bunch of cleanups
for the DMA CMA code are thrown in as well, as they help keeping the
exposed bits in the header small.

Diffstat:
 arch/arm/include/asm/dma-contiguous.h             |   15 
 b/Documentation/admin-guide/kernel-parameters.txt |    2 
 b/MAINTAINERS                                     |    2 
 b/arch/alpha/kernel/pci_iommu.c                   |    2 
 b/arch/arc/mm/dma.c                               |    2 
 b/arch/arm/common/dmabounce.c                     |    1 
 b/arch/arm/include/asm/dma-iommu.h                |    1 
 b/arch/arm/include/asm/dma-mapping.h              |    1 
 b/arch/arm/mach-davinci/devices-da8xx.c           |   18 -
 b/arch/arm/mach-highbank/highbank.c               |    2 
 b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c     |    2 
 b/arch/arm/mach-imx/mach-mx31moboard.c            |    2 
 b/arch/arm/mach-mvebu/coherency.c                 |    2 
 b/arch/arm/mach-shmobile/setup-rcar-gen2.c        |    2 
 b/arch/arm/mm/dma-mapping-nommu.c                 |    1 
 b/arch/arm/mm/dma-mapping.c                       |    5 
 b/arch/arm/mm/init.c                              |    2 
 b/arch/arm/xen/mm.c                               |    2 
 b/arch/arm64/mm/dma-mapping.c                     |    2 
 b/arch/arm64/mm/init.c                            |    3 
 b/arch/c6x/mm/dma-coherent.c                      |    2 
 b/arch/csky/kernel/setup.c                        |    2 
 b/arch/csky/mm/dma-mapping.c                      |    4 
 b/arch/hexagon/kernel/dma.c                       |    2 
 b/arch/ia64/hp/common/sba_iommu.c                 |    2 
 b/arch/ia64/kernel/dma-mapping.c                  |    2 
 b/arch/ia64/mm/init.c                             |    2 
 b/arch/m68k/kernel/dma.c                          |    2 
 b/arch/microblaze/kernel/dma.c                    |    3 
 b/arch/microblaze/mm/consistent.c                 |    2 
 b/arch/microblaze/mm/init.c                       |    2 
 b/arch/mips/jazz/jazzdma.c                        |    2 
 b/arch/mips/kernel/setup.c                        |    2 
 b/arch/mips/mm/dma-noncoherent.c                  |    3 
 b/arch/nds32/kernel/dma.c                         |    2 
 b/arch/openrisc/kernel/dma.c                      |    2 
 b/arch/parisc/kernel/drivers.c                    |    1 
 b/arch/parisc/kernel/pci-dma.c                    |    2 
 b/arch/powerpc/include/asm/iommu.h                |    2 
 b/arch/powerpc/include/asm/pci.h                  |    2 
 b/arch/powerpc/mm/dma-noncoherent.c               |    2 
 b/arch/powerpc/platforms/ps3/system-bus.c         |    2 
 b/arch/powerpc/platforms/pseries/ibmebus.c        |    2 
 b/arch/powerpc/platforms/pseries/vio.c            |    2 
 b/arch/s390/kernel/setup.c                        |    2 
 b/arch/s390/pci/pci_dma.c                         |    2 
 b/arch/sh/boards/mach-ap325rxa/setup.c            |    1 
 b/arch/sh/boards/mach-ecovec24/setup.c            |    1 
 b/arch/sh/boards/mach-kfr2r09/setup.c             |    2 
 b/arch/sh/boards/mach-migor/setup.c               |    2 
 b/arch/sh/boards/mach-se/7724/setup.c             |    1 
 b/arch/sh/drivers/pci/fixups-dreamcast.c          |    2 
 b/arch/sh/drivers/pci/pci.c                       |    1 
 b/arch/sh/kernel/dma-coherent.c                   |    2 
 b/arch/sparc/kernel/iommu.c                       |    2 
 b/arch/sparc/kernel/ioport.c                      |    2 
 b/arch/sparc/kernel/pci_sun4v.c                   |    1 
 b/arch/sparc/mm/io-unit.c                         |    2 
 b/arch/sparc/mm/iommu.c                           |    2 
 b/arch/x86/include/asm/dma-mapping.h              |    2 
 b/arch/x86/kernel/amd_gart_64.c                   |    1 
 b/arch/x86/kernel/pci-dma.c                       |    2 
 b/arch/x86/kernel/setup.c                         |    2 
 b/arch/x86/xen/pci-swiotlb-xen.c                  |    2 
 b/arch/xtensa/kernel/pci-dma.c                    |    3 
 b/arch/xtensa/mm/init.c                           |    2 
 b/drivers/acpi/arm64/iort.c                       |    2 
 b/drivers/acpi/scan.c                             |    2 
 b/drivers/base/dd.c                               |    2 
 b/drivers/dma-buf/heaps/cma_heap.c                |    2 
 b/drivers/gpu/drm/exynos/exynos_drm_dma.c         |    2 
 b/drivers/gpu/drm/msm/msm_gem.c                   |    1 
 b/drivers/iommu/amd/iommu.c                       |    3 
 b/drivers/iommu/dma-iommu.c                       |    3 
 b/drivers/iommu/intel/iommu.c                     |    4 
 b/drivers/media/platform/exynos4-is/fimc-is.c     |    1 
 b/drivers/misc/mic/bus/mic_bus.c                  |    1 
 b/drivers/misc/mic/bus/scif_bus.c                 |    2 
 b/drivers/misc/mic/bus/scif_bus.h                 |    2 
 b/drivers/misc/mic/bus/vop_bus.c                  |    2 
 b/drivers/misc/mic/host/mic_boot.c                |    1 
 b/drivers/of/device.c                             |    1 
 b/drivers/parisc/ccio-dma.c                       |    1 
 b/drivers/parisc/sba_iommu.c                      |    1 
 b/drivers/pci/pci-driver.c                        |    1 
 b/drivers/pci/xen-pcifront.c                      |    1 
 b/drivers/remoteproc/remoteproc_core.c            |    1 
 b/drivers/remoteproc/remoteproc_virtio.c          |    2 
 b/drivers/vdpa/vdpa_sim/vdpa_sim.c                |    2 
 b/drivers/xen/swiotlb-xen.c                       |    2 
 b/include/asm-generic/Kbuild                      |    1 
 b/include/linux/dma-direct.h                      |  108 -------
 b/include/linux/dma-map-ops.h                     |  339 ++++++++++++++++++++++
 b/include/linux/dma-mapping.h                     |  172 -----------
 b/kernel/dma/Kconfig                              |    2 
 b/kernel/dma/coherent.c                           |    1 
 b/kernel/dma/contiguous.c                         |   42 ++
 b/kernel/dma/debug.c                              |    5 
 b/kernel/dma/debug.h                              |   44 --
 b/kernel/dma/direct.c                             |    4 
 b/kernel/dma/direct.h                             |  119 +++++++
 b/kernel/dma/dummy.c                              |    2 
 b/kernel/dma/mapping.c                            |    5 
 b/kernel/dma/ops_helpers.c                        |    3 
 b/kernel/dma/pool.c                               |    3 
 b/kernel/dma/swiotlb.c                            |    2 
 b/kernel/dma/virt.c                               |    2 
 b/mm/memory.c                                     |    1 
 include/asm-generic/dma-contiguous.h              |   10 
 include/linux/dma-contiguous.h                    |  182 -----------
 include/linux/dma-noncoherent.h                   |  109 -------
 111 files changed, 620 insertions(+), 737 deletions(-)
