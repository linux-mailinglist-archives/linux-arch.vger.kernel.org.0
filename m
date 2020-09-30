Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8978827E448
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 10:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgI3I4G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 04:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgI3I4F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 04:56:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC79FC0613D0;
        Wed, 30 Sep 2020 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uoDyUocMuxzXBw/J3MbtQm99bSltpvYBdHObApmUBIs=; b=dFDx5ZNML+cWYXkIEd6M5bUEy8
        Ar5BHcfB6+dtOGD1wBQRyRAmE2iye02HQKfsdJJfgTOpYowgxuLIxmfM81z2HFg7z31W3toGzdsFw
        f/BScPfOqNIVdPt5GaLNORtSWW8k+e6xjfk7NoGOVGHyw3OqpC7jKOOf6ESTy4K0cgvWv/GPSbe8e
        ZMvexOaWThxdFvgc6sKB4h5+gyp7VLAC7+6NM6awEfX5YZ65ld9mVVIg6hqMD3+Pp3PhLZgH4A75W
        FTw9f8kDlC7dT408D7eY1r+Tw23zX0oMM9g3+slkfbQxiXQpBl5oCf7h3iXw/PQk6zieqGG4wEESw
        +heP/yKQ==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNXtz-0003sE-2r; Wed, 30 Sep 2020 08:55:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>, Sekhar Nori <nsekhar@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 2/9] dma-contiguous: remove dma_declare_contiguous
Date:   Wed, 30 Sep 2020 10:55:41 +0200
Message-Id: <20200930085548.920261-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930085548.920261-1-hch@lst.de>
References: <20200930085548.920261-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

dma_declare_contiguous is a trivial wrapper around
dma_contiguous_reserve_area and just has a single caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mach-davinci/devices-da8xx.c | 16 +++++++++-----
 include/linux/dma-contiguous.h        | 32 ---------------------------
 2 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index feb206bdf6e172..2e2853582b459e 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -884,6 +884,7 @@ early_param("rproc_mem", early_rproc_mem);
 
 void __init da8xx_rproc_reserve_cma(void)
 {
+	struct cma *cma;
 	int ret;
 
 	if (!rproc_base || !rproc_size) {
@@ -897,13 +898,16 @@ void __init da8xx_rproc_reserve_cma(void)
 	pr_info("%s: reserving 0x%lx @ 0x%lx...\n",
 		__func__, rproc_size, (unsigned long)rproc_base);
 
-	ret = dma_declare_contiguous(&da8xx_dsp.dev, rproc_size, rproc_base, 0);
-	if (ret)
-		pr_err("%s: dma_declare_contiguous failed %d\n", __func__, ret);
-	else
-		rproc_mem_inited = true;
+	ret = dma_contiguous_reserve_area(rproc_size, rproc_base, 0, &cma,
+			true);
+	if (ret) {
+		pr_err("%s: dma_contiguous_reserve_area failed %d\n",
+			__func__, ret);
+		return;
+	}
+	dev_set_cma_area(&da8xx_dsp.dev, cma);
+	rproc_mem_inited = true;
 }
-
 #else
 
 void __init da8xx_rproc_reserve_cma(void)
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index fe55e004f1f433..62fd55d0723546 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -83,31 +83,6 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 				       phys_addr_t limit, struct cma **res_cma,
 				       bool fixed);
 
-/**
- * dma_declare_contiguous() - reserve area for contiguous memory handling
- *			      for particular device
- * @dev:   Pointer to device structure.
- * @size:  Size of the reserved memory.
- * @base:  Start address of the reserved memory (optional, 0 for any).
- * @limit: End address of the reserved memory (optional, 0 for any).
- *
- * This function reserves memory for specified device. It should be
- * called by board specific code when early allocator (memblock or bootmem)
- * is still activate.
- */
-
-static inline int dma_declare_contiguous(struct device *dev, phys_addr_t size,
-					 phys_addr_t base, phys_addr_t limit)
-{
-	struct cma *cma;
-	int ret;
-	ret = dma_contiguous_reserve_area(size, base, limit, &cma, true);
-	if (ret == 0)
-		dev_set_cma_area(dev, cma);
-
-	return ret;
-}
-
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int order, bool no_warn);
 bool dma_release_from_contiguous(struct device *dev, struct page *pages,
@@ -135,13 +110,6 @@ static inline int dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base
 	return -ENOSYS;
 }
 
-static inline
-int dma_declare_contiguous(struct device *dev, phys_addr_t size,
-			   phys_addr_t base, phys_addr_t limit)
-{
-	return -ENOSYS;
-}
-
 static inline
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int order, bool no_warn)
-- 
2.28.0

