Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F397E89048
	for <lists+linux-arch@lfdr.de>; Sun, 11 Aug 2019 10:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfHKIFz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Aug 2019 04:05:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfHKIFy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Aug 2019 04:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5H4DKSyLtnJ8RX8GrhMYzxFLFlnlKxpwlI+kM8oQhzA=; b=gIc0HPMb2kkD9y746pngg/tZIN
        BBONBD5zHBfeFgLgtqVgkSReL2hz0BiQ8tWxlcZBGdXTJzS4Ath+2GX6SY8kDOgn0wGDxJbRWR6Ym
        /kGAt2D4y49bBi/D+c8YLGeSgiKu65k8qY+B3QSANY1FckAeC9Cxp6H6mKqnPTwSRCSdBfyPNe+Py
        jkvjkjUHLKDmgOogJ8JSIT5mTrSbJWKkEAwbjNO7fZuw2itIciNFU03pBKETjnELhrnm+Eo2l4+0L
        C2x20Pytwg6b/m1KFfyevb6gdPJ44xpY5hWZTqAQWyT8c+YytwOVfVY7bLH8Iq+nqurohNbdxi0Mq
        envVcypQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hwirC-0001w6-G8; Sun, 11 Aug 2019 08:05:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Gavin Li <git@thegavinli.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geoff Levand <geoff@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olav Kongas <ok@artecdesign.ee>,
        Tony Prisk <linux@prisktech.co.nz>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] usb/max3421: remove the dummy {un,}map_urb_for_dma methods
Date:   Sun, 11 Aug 2019 10:05:18 +0200
Message-Id: <20190811080520.21712-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190811080520.21712-1-hch@lst.de>
References: <20190811080520.21712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that we have an explicit HCD_DMA flag, there is not need to override
these methods.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/host/max3421-hcd.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index afa321ab55fc..8819f502b6a6 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1800,21 +1800,6 @@ max3421_bus_resume(struct usb_hcd *hcd)
 	return -1;
 }
 
-/*
- * The SPI driver already takes care of DMA-mapping/unmapping, so no
- * reason to do it twice.
- */
-static int
-max3421_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flags)
-{
-	return 0;
-}
-
-static void
-max3421_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
-{
-}
-
 static const struct hc_driver max3421_hcd_desc = {
 	.description =		"max3421",
 	.product_desc =		DRIVER_DESC,
@@ -1826,8 +1811,6 @@ static const struct hc_driver max3421_hcd_desc = {
 	.get_frame_number =	max3421_get_frame_number,
 	.urb_enqueue =		max3421_urb_enqueue,
 	.urb_dequeue =		max3421_urb_dequeue,
-	.map_urb_for_dma =	max3421_map_urb_for_dma,
-	.unmap_urb_for_dma =	max3421_unmap_urb_for_dma,
 	.endpoint_disable =	max3421_endpoint_disable,
 	.hub_status_data =	max3421_hub_status_data,
 	.hub_control =		max3421_hub_control,
-- 
2.20.1

