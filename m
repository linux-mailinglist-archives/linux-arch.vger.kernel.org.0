Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70C827E455
	for <lists+linux-arch@lfdr.de>; Wed, 30 Sep 2020 10:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgI3I4W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 04:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbgI3I4H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 04:56:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A002C0613D0;
        Wed, 30 Sep 2020 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7wlocwmYpV53gq2F4Jsvj5msvlzhpCuIuqnDE5DhBvk=; b=Ur7y8KKe3cjA7e0c1Ea7QqV9r0
        vY6VIBz2QcoRLJe9lf7uVRs2DNjFyCceMqUuaJygZTMw/RtSXGJbPOPzNAzKNsJ1k73ddTiasezFZ
        d0hr/6pxdWLxOh5G5wi2tXE5PItFpNtOtmzrOATkrGIFj+CSQRKxjTQP+80GSwnqfxLRzI5GIQM7t
        K+UXTWNBUwSNRxuZWs4qixxTrx0/+tQCjZOLhctLfzeUlYLst+FOknUyqNZ8n7HjsVmTEyGAD7Iid
        mBbuQ58px4mSIIt4V5A5liJNpP0MRtl24PqVZybE6L48rdfFCi+v4WRhR7c4l8YwN7EX093oOyrEQ
        MiD31FuA==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNXu2-0003sf-CF; Wed, 30 Sep 2020 08:55:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>, Sekhar Nori <nsekhar@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 4/9] dma-contiguous: remove dma_contiguous_set_default
Date:   Wed, 30 Sep 2020 10:55:43 +0200
Message-Id: <20200930085548.920261-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930085548.920261-1-hch@lst.de>
References: <20200930085548.920261-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

dma_contiguous_set_default contains a trivial assignment, and has a
single caller that is compiled if CONFIG_CMA_DMA is enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-contiguous.h | 7 -------
 kernel/dma/contiguous.c        | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 41ec08d81bc317..f9ce1ee58d4180 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -66,11 +66,6 @@ static inline struct cma *dev_get_cma_area(struct device *dev)
 	return dma_contiguous_default_area;
 }
 
-static inline void dma_contiguous_set_default(struct cma *cma)
-{
-	dma_contiguous_default_area = cma;
-}
-
 void dma_contiguous_reserve(phys_addr_t addr_limit);
 
 int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
@@ -91,8 +86,6 @@ static inline struct cma *dev_get_cma_area(struct device *dev)
 	return NULL;
 }
 
-static inline void dma_contiguous_set_default(struct cma *cma) { }
-
 static inline void dma_contiguous_reserve(phys_addr_t limit) { }
 
 static inline int dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 95adcee972e85c..bf05ec2256e149 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -407,7 +407,7 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
 	if (default_cma)
-		dma_contiguous_set_default(cma);
+		dma_contiguous_default_area = cma;
 
 	rmem->ops = &rmem_cma_ops;
 	rmem->priv = cma;
-- 
2.28.0

