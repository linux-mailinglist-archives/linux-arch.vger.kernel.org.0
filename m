Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57B296377
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfHTO6i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 10:58:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:59750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730180AbfHTO6g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 10:58:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88554AFCC;
        Tue, 20 Aug 2019 14:58:35 +0000 (UTC)
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
        frowand.list@gmail.com, m.szyprowski@samsung.com
Subject: [PATCH v2 05/11] arm64: mm: use arm64_dma_phys_limit instead of calling max_zone_dma_phys()
Date:   Tue, 20 Aug 2019 16:58:13 +0200
Message-Id: <20190820145821.27214-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820145821.27214-1-nsaenzjulienne@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

By the time we call zones_sizes_init() arm64_dma_phys_limit already
contains the result of max_zone_dma_phys(). We use the variable instead
of calling the function directly to save some precious cpu time.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes in v2: None

 arch/arm64/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f3c795278def..6112d6c90fa8 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -181,7 +181,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 
 #ifdef CONFIG_ZONE_DMA32
-	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_dma_phys());
+	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max;
 
-- 
2.22.0

