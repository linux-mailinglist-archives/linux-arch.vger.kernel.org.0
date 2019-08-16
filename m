Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91FB48FB03
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2019 08:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfHPG3M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Aug 2019 02:29:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfHPG3M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Aug 2019 02:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3t34NdMYaxK3b7q79OweXtc3LDVxX2AkiLPLkSCTGmc=; b=RM7e0gK123NroqwYE8zX1F6r2q
        yxSRLYUH2Q8Qta2OCb7gqfmgUK1raZgteCZXzL7kQE58HrFT8CfIQxy8zbVoeer53slrr6PJpVn9n
        vEB8yj0UWRGu3Okfbuy4VRV3IB1PAEx5p34A5chbLRZZVlWNTERps+kZvu7AuZG2NXCuxFQ0w6UCL
        fEIS7PGqIE7Glv12lV5Wr4vqZYhwpUTI5wNGPoD09z94PUW9jqHdw0JaUlYewIPUl1wv6mGOVkGES
        z5bAGT1o94h5sOX2vK8nLsnqeWlpx4qmhQ/nOAjTSTpxFoUN3bEncITdksE5PsYUeMzwfgmuSYq1t
        3TmmbhQg==;
Received: from [2001:4bb8:18c:28b5:44f9:d544:957f:32cb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyVjS-00068I-4k; Fri, 16 Aug 2019 06:29:02 +0000
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
        Mathias Nyman <mathias.nyman@intel.com>,
        Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] usb: add a hcd_uses_dma helper
Date:   Fri, 16 Aug 2019 08:24:31 +0200
Message-Id: <20190816062435.881-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816062435.881-1-hch@lst.de>
References: <20190816062435.881-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The USB buffer allocation code is the only place in the usb core (and in
fact the whole kernel) that uses is_device_dma_capable, while the URB
mapping code uses the uses_dma flag in struct usb_bus.  Switch the buffer
allocation to use the uses_dma flag used by the rest of the USB code,
and create a helper in hcd.h that checks this flag as well as the
CONFIG_HAS_DMA to simplify the caller a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/core/buffer.c | 10 +++-------
 drivers/usb/core/hcd.c    |  4 ++--
 drivers/usb/dwc2/hcd.c    |  2 +-
 include/linux/usb.h       |  2 +-
 include/linux/usb/hcd.h   |  3 +++
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 1a5b3dcae930..6cf22c27f2d2 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -66,9 +66,7 @@ int hcd_buffer_create(struct usb_hcd *hcd)
 	char		name[16];
 	int		i, size;
 
-	if (hcd->localmem_pool ||
-	    !IS_ENABLED(CONFIG_HAS_DMA) ||
-	    !is_device_dma_capable(hcd->self.sysdev))
+	if (hcd->localmem_pool || !hcd_uses_dma(hcd))
 		return 0;
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
@@ -129,8 +127,7 @@ void *hcd_buffer_alloc(
 		return gen_pool_dma_alloc(hcd->localmem_pool, size, dma);
 
 	/* some USB hosts just use PIO */
-	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
-	    !is_device_dma_capable(bus->sysdev)) {
+	if (!hcd_uses_dma(hcd)) {
 		*dma = ~(dma_addr_t) 0;
 		return kmalloc(size, mem_flags);
 	}
@@ -160,8 +157,7 @@ void hcd_buffer_free(
 		return;
 	}
 
-	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
-	    !is_device_dma_capable(bus->sysdev)) {
+	if (!hcd_uses_dma(hcd)) {
 		kfree(addr);
 		return;
 	}
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 2ccbc2f83570..8592c0344fe8 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1412,7 +1412,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 	if (usb_endpoint_xfer_control(&urb->ep->desc)) {
 		if (hcd->self.uses_pio_for_control)
 			return ret;
-		if (IS_ENABLED(CONFIG_HAS_DMA) && hcd->self.uses_dma) {
+		if (hcd_uses_dma(hcd)) {
 			if (is_vmalloc_addr(urb->setup_packet)) {
 				WARN_ONCE(1, "setup packet is not dma capable\n");
 				return -EAGAIN;
@@ -1446,7 +1446,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
 	if (urb->transfer_buffer_length != 0
 	    && !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
-		if (IS_ENABLED(CONFIG_HAS_DMA) && hcd->self.uses_dma) {
+		if (hcd_uses_dma(hcd)) {
 			if (urb->num_sgs) {
 				int n;
 
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index ee144ff8af5b..111787a137ee 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4608,7 +4608,7 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 
 	buf = urb->transfer_buffer;
 
-	if (hcd->self.uses_dma) {
+	if (hcd_uses_dma(hcd)) {
 		if (!buf && (urb->transfer_dma & 3)) {
 			dev_err(hsotg->dev,
 				"%s: unaligned transfer with no transfer_buffer",
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 83d35d993e8c..e87826e23d59 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1457,7 +1457,7 @@ typedef void (*usb_complete_t)(struct urb *);
  * field rather than determining a dma address themselves.
  *
  * Note that transfer_buffer must still be set if the controller
- * does not support DMA (as indicated by bus.uses_dma) and when talking
+ * does not support DMA (as indicated by hcd_uses_dma()) and when talking
  * to root hub. If you have to trasfer between highmem zone and the device
  * on such controller, create a bounce buffer or bail out with an error.
  * If transfer_buffer cannot be set (is in highmem) and the controller is DMA
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index bab27ccc8ff5..a20e7815d814 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -422,6 +422,9 @@ static inline bool hcd_periodic_completion_in_progress(struct usb_hcd *hcd,
 	return hcd->high_prio_bh.completing_ep == ep;
 }
 
+#define hcd_uses_dma(hcd) \
+	(IS_ENABLED(CONFIG_HAS_DMA) && (hcd)->self.uses_dma)
+
 extern int usb_hcd_link_urb_to_ep(struct usb_hcd *hcd, struct urb *urb);
 extern int usb_hcd_check_unlink_urb(struct usb_hcd *hcd, struct urb *urb,
 		int status);
-- 
2.20.1

