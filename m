Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E9527E462
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgI3I4V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 04:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgI3I4H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 04:56:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E0C061755;
        Wed, 30 Sep 2020 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FfdHYeDTXhoYO7qCBmRlpvBIzEFqBt+3svzGl87S3x8=; b=PZTmJCKijrz58G/RG2MqzXGL/l
        olVALkl3XpDvDm+bNdqRHm/MtEDq2iMIwNKD6VJBzlMeGghnezkcE+6TEZ1VYVsca8mN2KeCerq28
        aBu6FBeZWZ72xCtrD8CpFDvjTWOv8Ydr/SMMhdFYQ7Ff1PJQUhXopL/AWUGOB+ezasg+qz+dm6vG1
        dUdK6SOxuscB000wVcJejnpRS6fJ7e99+fhXANHIgnSihBPpdi0V/qFRM/sqT/CI+VGPpEl74GR5q
        JrHqaasZKrbNuE98xnDDZbmapQPSjYEMb7ThNShXS96WvIw5i9aS7fPtTAw4w1olvLFnwyVhw4HuQ
        ux7qCDxA==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNXu0-0003sL-NR; Wed, 30 Sep 2020 08:55:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>, Sekhar Nori <nsekhar@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 3/9] dma-contiguous: remove dev_set_cma_area
Date:   Wed, 30 Sep 2020 10:55:42 +0200
Message-Id: <20200930085548.920261-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930085548.920261-1-hch@lst.de>
References: <20200930085548.920261-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

dev_set_cma_area contains a trivial assignment.  It has just three
callers that all have a non-NULL device and depend on CONFIG_DMA_CMA,
so remove the wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mach-davinci/devices-da8xx.c | 2 +-
 include/linux/dma-contiguous.h        | 8 --------
 kernel/dma/contiguous.c               | 4 ++--
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 2e2853582b459e..1207eabe8d1cc4 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -905,7 +905,7 @@ void __init da8xx_rproc_reserve_cma(void)
 			__func__, ret);
 		return;
 	}
-	dev_set_cma_area(&da8xx_dsp.dev, cma);
+	da8xx_dsp.dev.cma_area = cma;
 	rproc_mem_inited = true;
 }
 #else
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 62fd55d0723546..41ec08d81bc317 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -66,12 +66,6 @@ static inline struct cma *dev_get_cma_area(struct device *dev)
 	return dma_contiguous_default_area;
 }
 
-static inline void dev_set_cma_area(struct device *dev, struct cma *cma)
-{
-	if (dev)
-		dev->cma_area = cma;
-}
-
 static inline void dma_contiguous_set_default(struct cma *cma)
 {
 	dma_contiguous_default_area = cma;
@@ -97,8 +91,6 @@ static inline struct cma *dev_get_cma_area(struct device *dev)
 	return NULL;
 }
 
-static inline void dev_set_cma_area(struct device *dev, struct cma *cma) { }
-
 static inline void dma_contiguous_set_default(struct cma *cma) { }
 
 static inline void dma_contiguous_reserve(phys_addr_t limit) { }
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index f4c150810fd25c..95adcee972e85c 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -359,14 +359,14 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 
 static int rmem_cma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
-	dev_set_cma_area(dev, rmem->priv);
+	dev->cma_area = rmem->priv;
 	return 0;
 }
 
 static void rmem_cma_device_release(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-	dev_set_cma_area(dev, NULL);
+	dev->cma_area = NULL;
 }
 
 static const struct reserved_mem_ops rmem_cma_ops = {
-- 
2.28.0

