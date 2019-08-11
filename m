Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CF08905F
	for <lists+linux-arch@lfdr.de>; Sun, 11 Aug 2019 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfHKIGO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Aug 2019 04:06:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfHKIFz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Aug 2019 04:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/qPzNIpevvN/qwi+1IcOX2emVd7L7tcHzjYkoXjMmbs=; b=rx2STIcad83YqjkOlc8pS3EKFK
        tm5EQbOmD/zVesaB2Yrka4WpJlP1wkoqY2lwbZhzszanIlrNAV4QTyV8TCOF9F3eI3zuLrIJd1Zkz
        /6Qz6H0Uu+YmAp0zzbW9uv0aN73hwVJ4eagsQzRMNy+wzoMs2+vf0kHt/V80B+ZW/AG3/htUUV1KM
        3LsUroqS4mhIvTAjCxTfIBA/5IwbT+2Jq4jOGvfRcgkAsYpujmAHbQNcQxfqKUure4D6FDtoCq9+k
        thu7CtXONgfv8pgEAme12GQ8RHhMiE8QEIZeEdrfspL7BjvQUUI7VGUabnM6ngSB7IYK8iw/PwVYb
        0AgEyMFg==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hwirF-0001yq-Iw; Sun, 11 Aug 2019 08:05:42 +0000
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
Subject: [PATCH 5/6] dma-mapping: remove is_device_dma_capable
Date:   Sun, 11 Aug 2019 10:05:19 +0200
Message-Id: <20190811080520.21712-6-hch@lst.de>
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

No users left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f7d1eea32c78..14702e2d6fa8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -149,11 +149,6 @@ static inline int valid_dma_direction(int dma_direction)
 		(dma_direction == DMA_FROM_DEVICE));
 }
 
-static inline int is_device_dma_capable(struct device *dev)
-{
-	return dev->dma_mask != NULL && *dev->dma_mask != DMA_MASK_NONE;
-}
-
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 /*
  * These three functions are only for dma allocator.
-- 
2.20.1

