Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C16D96342
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHTO6b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 10:58:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:59682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfHTO6b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 10:58:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DD42AFA5;
        Tue, 20 Aug 2019 14:58:30 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        eric@anholt.net, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org,
        frowand.list@gmail.com, m.szyprowski@samsung.com
Subject: [PATCH v2 01/11] asm-generic: add dma_zone_size
Date:   Tue, 20 Aug 2019 16:58:09 +0200
Message-Id: <20190820145821.27214-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820145821.27214-1-nsaenzjulienne@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some architectures have platform specific DMA addressing limitations.
This will allow for hardware description code to provide the constraints
in a generic manner, so as for arch code to properly setup it's memory
zones and DMA mask.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes in v2: None

 include/asm-generic/dma.h | 8 +++++++-
 mm/page_alloc.c           | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/dma.h b/include/asm-generic/dma.h
index 43d0c8af8058..c2f39cdb64f6 100644
--- a/include/asm-generic/dma.h
+++ b/include/asm-generic/dma.h
@@ -8,7 +8,13 @@
  *
  * Some code relies on seeing MAX_DMA_ADDRESS though.
  */
-#define MAX_DMA_ADDRESS PAGE_OFFSET
+#define MAX_DMA_ADDRESS	 (PAGE_OFFSET + dma_zone_size)
+
+/*
+ * Some architectures may have platform specific DMA addressing constraints.
+ * Firmware can use this to fine tune the device's DMA memory zone.
+ */
+extern u64 dma_zone_size __ro_after_init;
 
 extern int request_dma(unsigned int dmanr, const char *device_id);
 extern void free_dma(unsigned int dmanr);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 272c6de1bf4e..b514afee5451 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -133,6 +133,9 @@ EXPORT_SYMBOL(_totalram_pages);
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
 
+u64 dma_zone_size __ro_after_init;
+EXPORT_SYMBOL(dma_zone_size);
+
 int percpu_pagelist_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 #ifdef CONFIG_INIT_ON_ALLOC_DEFAULT_ON
-- 
2.22.0

