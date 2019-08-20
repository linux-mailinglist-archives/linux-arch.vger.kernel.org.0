Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC62F96366
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 16:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfHTO6p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 10:58:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:59944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730346AbfHTO6l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 10:58:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FE8BAFCF;
        Tue, 20 Aug 2019 14:58:39 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>
Cc:     phill@raspberryi.org, f.fainelli@gmail.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, eric@anholt.net, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org,
        frowand.list@gmail.com, m.szyprowski@samsung.com
Subject: [PATCH v2 08/11] arm64: use both ZONE_DMA and ZONE_DMA32
Date:   Tue, 20 Aug 2019 16:58:16 +0200
Message-Id: <20190820145821.27214-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820145821.27214-1-nsaenzjulienne@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

So far all arm64 devices have supported 32 bit DMA masks for their
peripherals. This is not true anymore for the Raspberry Pi 4 as most of
it's peripherals can only address the first GB or memory of a total of
up to 4 GB.

This goes against ZONE_DMA32's original intent, and breaks other
subsystems as it's expected for ZONE_DMA32 to be addressable with a 32
bit mask. So it was decided to use ZONE_DMA for this specific case.

ZONE_DMA will contain the memory addressable by all the SoC's
peripherals and ZONE_DMA32 the rest of the 32 bit addressable memory. If
all peripherals where able to address the whole 32 bit addressable space
ZONE_DMA32 will be left empty.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes in v2:
- ZONE_DMA will never be left empty
- Update comment to reflect new zones split

 arch/arm64/Kconfig   |  4 ++++
 arch/arm64/mm/init.c | 39 +++++++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3adcec05b1f6..a9fd71d3bc8e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -266,6 +266,10 @@ config GENERIC_CSUM
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
+config ZONE_DMA
+	bool "Support DMA zone" if EXPERT
+	default y
+
 config ZONE_DMA32
 	bool "Support DMA32 zone" if EXPERT
 	default y
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index bc7999020c71..c51ce79b692b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -50,6 +50,14 @@
 s64 memstart_addr __ro_after_init = -1;
 EXPORT_SYMBOL(memstart_addr);
 
+/*
+ * We create both ZONE_DMA and ZONE_DMA32. ZONE_DMA's size is decided based on
+ * whether all the device's peripherals are able to address the first naturally
+ * aligned 4G of memory. If not, ZONE_DMA covers the area common to all them
+ * and ZONE_DMA32 the rest. If ZONE_DMA fits the whole 4G area, ZONE_DMA32 is
+ * left empty.
+ */
+phys_addr_t arm64_dma_phys_limit __ro_after_init;
 phys_addr_t arm64_dma32_phys_limit __ro_after_init;
 
 #ifdef CONFIG_KEXEC_CORE
@@ -191,6 +199,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 
+#ifdef CONFIG_ZONE_DMA
+	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
+#endif
 #ifdef CONFIG_ZONE_DMA32
 	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(arm64_dma32_phys_limit);
 #endif
@@ -206,13 +217,17 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	struct memblock_region *reg;
 	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
 	unsigned long max_dma32 = min;
+	unsigned long max_dma = min;
 
 	memset(zone_size, 0, sizeof(zone_size));
 
-	/* 4GB maximum for 32-bit only capable devices */
+#ifdef CONFIG_ZONE_DMA
+	max_dma = PFN_DOWN(arm64_dma_phys_limit);
+	zone_size[ZONE_DMA] = max_dma - min;
+#endif
 #ifdef CONFIG_ZONE_DMA32
 	max_dma32 = PFN_DOWN(arm64_dma32_phys_limit);
-	zone_size[ZONE_DMA32] = max_dma32 - min;
+	zone_size[ZONE_DMA32] = max_dma32 - max_dma;
 #endif
 	zone_size[ZONE_NORMAL] = max - max_dma32;
 
@@ -224,11 +239,17 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 
 		if (start >= max)
 			continue;
-
+#ifdef CONFIG_ZONE_DMA
+		if (start < max_dma) {
+			unsigned long dma_end = min_not_zero(end, max_dma);
+			zhole_size[ZONE_DMA] -= dma_end - start;
+		}
+#endif
 #ifdef CONFIG_ZONE_DMA32
 		if (start < max_dma32) {
-			unsigned long dma_end = min(end, max_dma32);
-			zhole_size[ZONE_DMA32] -= dma_end - start;
+			unsigned long dma32_end = min(end, max_dma32);
+			unsigned long dma32_start = max(start, max_dma);
+			zhole_size[ZONE_DMA32] -= dma32_end - dma32_start;
 		}
 #endif
 		if (end > max_dma32) {
@@ -416,7 +437,9 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	/* 4GB maximum for 32-bit only capable devices */
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		arm64_dma_phys_limit = max_zone_dma_phys();
+
 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
 		arm64_dma32_phys_limit = max_zone_dma32_phys();
 	else
@@ -428,7 +451,7 @@ void __init arm64_memblock_init(void)
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 
-	dma_contiguous_reserve(arm64_dma32_phys_limit);
+	dma_contiguous_reserve(arm64_dma_phys_limit ? : arm64_dma32_phys_limit);
 }
 
 void __init bootmem_init(void)
@@ -531,7 +554,7 @@ static void __init free_unused_memmap(void)
  */
 void __init mem_init(void)
 {
-	if (swiotlb_force == SWIOTLB_FORCE ||
+	if (swiotlb_force == SWIOTLB_FORCE || arm64_dma_phys_limit ||
 	    max_pfn > (arm64_dma32_phys_limit >> PAGE_SHIFT))
 		swiotlb_init(1);
 	else
-- 
2.22.0

