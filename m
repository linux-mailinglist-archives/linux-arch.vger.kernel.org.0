Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4ED9637E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfHTO7i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 10:59:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:59720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfHTO6d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 10:58:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A0C7AE6D;
        Tue, 20 Aug 2019 14:58:31 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org,
        nsaenzjulienne@suse.de, eric@anholt.net, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org,
        frowand.list@gmail.com, m.szyprowski@samsung.com,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 02/11] arm: use generic dma_zone_size
Date:   Tue, 20 Aug 2019 16:58:10 +0200
Message-Id: <20190820145821.27214-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820145821.27214-1-nsaenzjulienne@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

'dma_zone_size' was created as a generic replacement to
'arm_dma_zone_size'. Use it accordingly.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes in v2: None

 arch/arm/include/asm/dma.h |  8 +++++---
 arch/arm/mm/init.c         | 12 ++++--------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index a81dda65c576..52d19ffd92b4 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -2,16 +2,18 @@
 #ifndef __ASM_ARM_DMA_H
 #define __ASM_ARM_DMA_H
 
+#include <asm-generic/dma.h>
+
 /*
  * This is the maximum virtual address which can be DMA'd from.
  */
+#undef MAX_DMA_ADDRESS
 #ifndef CONFIG_ZONE_DMA
 #define MAX_DMA_ADDRESS	0xffffffffUL
 #else
 #define MAX_DMA_ADDRESS	({ \
-	extern phys_addr_t arm_dma_zone_size; \
-	arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
-		(PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
+	dma_zone_size && dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
+		(PAGE_OFFSET + dma_zone_size) : 0xffffffffUL; })
 #endif
 
 #ifdef CONFIG_ISA_DMA_API
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 16d373d587c4..95680bad245a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -79,10 +79,6 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 }
 
 #ifdef CONFIG_ZONE_DMA
-
-phys_addr_t arm_dma_zone_size __read_mostly;
-EXPORT_SYMBOL(arm_dma_zone_size);
-
 /*
  * The DMA mask corresponding to the maximum bus address allocatable
  * using GFP_DMA.  The default here places no restriction on DMA
@@ -109,8 +105,8 @@ void __init setup_dma_zone(const struct machine_desc *mdesc)
 {
 #ifdef CONFIG_ZONE_DMA
 	if (mdesc->dma_zone_size) {
-		arm_dma_zone_size = mdesc->dma_zone_size;
-		arm_dma_limit = PHYS_OFFSET + arm_dma_zone_size - 1;
+		dma_zone_size = mdesc->dma_zone_size;
+		arm_dma_limit = PHYS_OFFSET + dma_zone_size - 1;
 	} else
 		arm_dma_limit = 0xffffffff;
 	arm_dma_pfn_limit = arm_dma_limit >> PAGE_SHIFT;
@@ -164,9 +160,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 	 * Adjust the sizes according to any special requirements for
 	 * this machine type.
 	 */
-	if (arm_dma_zone_size)
+	if (dma_zone_size)
 		arm_adjust_dma_zone(zone_size, zhole_size,
-			arm_dma_zone_size >> PAGE_SHIFT);
+			dma_zone_size >> PAGE_SHIFT);
 #endif
 
 	free_area_init_node(0, zone_size, min, zhole_size);
-- 
2.22.0

