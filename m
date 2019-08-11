Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB49589057
	for <lists+linux-arch@lfdr.de>; Sun, 11 Aug 2019 10:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfHKIF5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Aug 2019 04:05:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfHKIFz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Aug 2019 04:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dftcSzfDdyc02vTQypmmr4nqPV2SE1bB1GMbvWD2Jek=; b=UMEvzoLEwpMDTenvIB+0BTS26+
        KD8/KOYJDOvaupvERmLkq2+cOudPdXx/9YAoxoLHBIhbWE6ItR8RS/0q2pcFARGnStycuXfOJSELl
        L98cN/SUFZ/K1WBVF4aO8stRWvkRk/IP8d51FdkPvK7ZqKMWjCX/iU7n4w78ZUKQTKnGDENcpiQbL
        /hBoz5+7c3ZWPb2Avw9aNlL9bAkJ2ZEHRQ7/cZ4AqSjaLwefBbjEoCu93NOsgtOECpicixiH3M3eS
        vciuwhd+C2zn6tR2Fkb9RXE3YmkWCxeZuh1VGjS9wgNNuD08nkWVa1+3Wy2sU5Px8aHs3e6W6zj7J
        R+uzwONg==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hwir3-0001um-Fz; Sun, 11 Aug 2019 08:05:30 +0000
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
Subject: [PATCH 1/6] usb: don't create dma pools for HCDs with a localmem_pool
Date:   Sun, 11 Aug 2019 10:05:15 +0200
Message-Id: <20190811080520.21712-2-hch@lst.de>
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

If the HCD provides a localmem pool we will never use the DMA pools, so
don't create them.

Fixes: b0310c2f09bb ("USB: use genalloc for USB HCs with local memory")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/core/buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 1359b78a624e..1a5b3dcae930 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -66,9 +66,9 @@ int hcd_buffer_create(struct usb_hcd *hcd)
 	char		name[16];
 	int		i, size;
 
-	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
-	    (!is_device_dma_capable(hcd->self.sysdev) &&
-	     !hcd->localmem_pool))
+	if (hcd->localmem_pool ||
+	    !IS_ENABLED(CONFIG_HAS_DMA) ||
+	    !is_device_dma_capable(hcd->self.sysdev))
 		return 0;
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
-- 
2.20.1

