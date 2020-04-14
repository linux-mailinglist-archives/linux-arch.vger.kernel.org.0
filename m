Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1DB1A7E41
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbgDNNfw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502811AbgDNNPb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 09:15:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD055C061A10;
        Tue, 14 Apr 2020 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J3GKe+LnzmvEZkshr8z32ndR4j0MvDyZMMYBvJP8rpA=; b=Xq+K2mziXAcFNoeIFJDjPsWR53
        oAquzR/7oWgic8OGSzzRE/7waOx7o8yen0eds5cCBH1Dn9GpzcPQoSIOcDIlZTtktp5R3ZhBgRN5L
        8THhGnYNdNEtTlDwy/lHgbGULPOA2R3QO0U9Dxt7luDp+VIdZhgs+irFIyr9G57j0gu/fEvay/b/W
        +2iWha7fJrWw+UJG2tvszEY3ndPnK5fStj7t6SAynZZTXtGSQxv3lQMxmx6ulM6hcJytqKouFn/Z1
        CFezBjcKxPLVgbWu+/U57fiPEpQdDap+OrwdlO/ThiAOahflGAV/HAtuKETqVF5sUpy47K8OCINE/
        7CQnrRMA==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLP0-0007EL-Uw; Tue, 14 Apr 2020 13:14:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 20/29] gpu/drm: remove the powerpc hack in drm_legacy_sg_alloc
Date:   Tue, 14 Apr 2020 15:13:39 +0200
Message-Id: <20200414131348.444715-21-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414131348.444715-1-hch@lst.de>
References: <20200414131348.444715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The non-cached vmalloc mapping was initially added as a hack for the
first-gen amigaone platform (6xx/book32s), isn't fully supported
upstream, and which used the legacy radeon driver together with
non-coherent DMA. However this only ever worked reliably for DRI .

Remove the hack as it is the last user of __vmalloc passing a page
protection flag other than PAGE_KERNEL and didn't do anything for
other platforms with non-coherent DMA.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/gpu/drm/drm_scatter.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
index ca520028b2cb..f4e6184d1877 100644
--- a/drivers/gpu/drm/drm_scatter.c
+++ b/drivers/gpu/drm/drm_scatter.c
@@ -43,15 +43,6 @@
 
 #define DEBUG_SCATTER 0
 
-static inline void *drm_vmalloc_dma(unsigned long size)
-{
-#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
-	return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
-#else
-	return vmalloc_32(size);
-#endif
-}
-
 static void drm_sg_cleanup(struct drm_sg_mem * entry)
 {
 	struct page *page;
@@ -126,7 +117,7 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
 		return -ENOMEM;
 	}
 
-	entry->virtual = drm_vmalloc_dma(pages << PAGE_SHIFT);
+	entry->virtual = vmalloc_32(pages << PAGE_SHIFT);
 	if (!entry->virtual) {
 		kfree(entry->busaddr);
 		kfree(entry->pagelist);
-- 
2.25.1

