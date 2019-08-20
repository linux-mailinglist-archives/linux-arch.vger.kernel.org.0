Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295509634A
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 16:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfHTO6j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 10:58:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:59720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbfHTO6f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 10:58:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 292BEAFCB;
        Tue, 20 Aug 2019 14:58:34 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>
Cc:     phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        eric@anholt.net, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org,
        m.szyprowski@samsung.com
Subject: [PATCH v2 04/11] of/fdt: add early_init_dt_get_dma_zone_size()
Date:   Tue, 20 Aug 2019 16:58:12 +0200
Message-Id: <20190820145821.27214-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820145821.27214-1-nsaenzjulienne@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some devices might have weird DMA addressing limitations that only apply
to a subset of the available peripherals. For example the Raspberry Pi 4
has two interconnects, one able to address the whole lower 4G memory
area and another one limited to the lower 1G.

Being an uncommon situation we simply hardcode the device wide DMA
addressable memory size conditionally to the machine compatible name and
set 'dma_zone_size' accordingly.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes in v2:
- New approach to getting dma_zone_size, instead of parsing the dts we
  hardcode it conditionally to the machine compatible name.

 drivers/of/fdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 06ffbd39d9af..f756e8c05a77 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -27,6 +27,7 @@
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
+#include <asm/dma.h>	/* for dma_zone_size */
 
 #include "of_private.h"
 
@@ -1195,6 +1196,12 @@ void __init early_init_dt_scan_nodes(void)
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 }
 
+void __init early_init_dt_get_dma_zone_size(void)
+{
+	if (of_fdt_machine_is_compatible("brcm,bcm2711"))
+		dma_zone_size = 0x3c000000;
+}
+
 bool __init early_init_dt_scan(void *params)
 {
 	bool status;
@@ -1204,6 +1211,7 @@ bool __init early_init_dt_scan(void *params)
 		return false;
 
 	early_init_dt_scan_nodes();
+	early_init_dt_get_dma_zone_size();
 	return true;
 }
 
-- 
2.22.0

