Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8DA8905E
	for <lists+linux-arch@lfdr.de>; Sun, 11 Aug 2019 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfHKIGO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Aug 2019 04:06:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfHKIFz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Aug 2019 04:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BWTPTBSe6VF+JMj1q5oBXZ4juxKMFESpvmk6zjCIbj4=; b=T54gvNMXlI4GYg3fjwu3d0zDzY
        vcQ2/BwnYxDmcdf8P30hP+BdF9eaVlldbGybzBoTjMMZ5Ht2M1d61x+kyKX8tldhZlxeMK88oeKS6
        w6Ditcnj640vwRc36qGze+pk9t6b2f3CQtp4sXVWztr48+C+fmUUu3fhKs7rEDm4YN7bg/PovDbG+
        Jb7KWd+bgmEzvgd1cdfol1wdRBbiFbW5VY7VRA53flXQsIXN80sQNCIkgJ5anPzbiAIus/P91/KLj
        l02u1rRCNaBogsTyRfrFTSMWsrbx7oqi4kEtQbL5BePm17KbA/D73uBIhUYBxGTFQ22C+ab+TNZ5s
        1bYOlx/g==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hwir9-0001vF-HJ; Sun, 11 Aug 2019 08:05:36 +0000
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
Subject: [PATCH 3/6] usb: add a HCD_DMA flag instead of guestimating DMA capabilities
Date:   Sun, 11 Aug 2019 10:05:17 +0200
Message-Id: <20190811080520.21712-4-hch@lst.de>
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

The usb core is the only major place in the kernel that checks for
a non-NULL device dma_mask to see if a device is DMA capable.  This
is generally a bad idea, as all major busses always set up a DMA mask,
even if the device is not DMA capable - in fact bus layers like PCI
can't even know if a device is DMA capable at enumeration time.  This
leads to lots of workaround in HCD drivers, and also prevented us from
setting up a DMA mask for platform devices by default last time we
tried.

Replace this guess with an explicit HCD_DMA that is set by drivers that
appear to have DMA support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 2 +-
 drivers/usb/core/hcd.c                  | 1 -
 drivers/usb/dwc2/hcd.c                  | 6 +++---
 drivers/usb/host/ehci-grlib.c           | 2 +-
 drivers/usb/host/ehci-hcd.c             | 2 +-
 drivers/usb/host/ehci-pmcmsp.c          | 2 +-
 drivers/usb/host/ehci-ppc-of.c          | 2 +-
 drivers/usb/host/ehci-ps3.c             | 2 +-
 drivers/usb/host/ehci-sh.c              | 2 +-
 drivers/usb/host/ehci-xilinx-of.c       | 2 +-
 drivers/usb/host/fhci-hcd.c             | 2 +-
 drivers/usb/host/fotg210-hcd.c          | 2 +-
 drivers/usb/host/imx21-hcd.c            | 2 +-
 drivers/usb/host/isp116x-hcd.c          | 6 ------
 drivers/usb/host/isp1362-hcd.c          | 5 -----
 drivers/usb/host/ohci-hcd.c             | 2 +-
 drivers/usb/host/ohci-ppc-of.c          | 2 +-
 drivers/usb/host/ohci-ps3.c             | 2 +-
 drivers/usb/host/ohci-sa1111.c          | 2 +-
 drivers/usb/host/ohci-sm501.c           | 2 +-
 drivers/usb/host/ohci-tmio.c            | 2 +-
 drivers/usb/host/oxu210hp-hcd.c         | 3 ---
 drivers/usb/host/r8a66597-hcd.c         | 6 ------
 drivers/usb/host/sl811-hcd.c            | 6 ------
 drivers/usb/host/u132-hcd.c             | 2 --
 drivers/usb/host/uhci-grlib.c           | 2 +-
 drivers/usb/host/uhci-pci.c             | 2 +-
 drivers/usb/host/uhci-platform.c        | 2 +-
 drivers/usb/host/xhci.c                 | 2 +-
 drivers/usb/isp1760/isp1760-core.c      | 3 ---
 drivers/usb/isp1760/isp1760-if.c        | 1 -
 drivers/usb/musb/musb_host.c            | 2 +-
 drivers/usb/renesas_usbhs/mod_host.c    | 2 +-
 include/linux/usb.h                     | 1 -
 include/linux/usb/hcd.h                 | 7 +++++--
 35 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cd2b777073c4..a5321cc692c5 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -3512,7 +3512,7 @@ static const struct hc_driver octeon_hc_driver = {
 	.product_desc		= "Octeon Host Controller",
 	.hcd_priv_size		= sizeof(struct octeon_hcd),
 	.irq			= octeon_usb_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
+	.flags			= HCD_MEMORY | HCD_DMA | HCD_USB2,
 	.start			= octeon_usb_start,
 	.stop			= octeon_usb_stop,
 	.urb_enqueue		= octeon_usb_urb_enqueue,
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 8592c0344fe8..add2af4af766 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2454,7 +2454,6 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
 	hcd->self.controller = dev;
 	hcd->self.sysdev = sysdev;
 	hcd->self.bus_name = bus_name;
-	hcd->self.uses_dma = (sysdev->dma_mask != NULL);
 
 	timer_setup(&hcd->rh_timer, rh_timer_func, 0);
 #ifdef CONFIG_PM
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 111787a137ee..81afe553aa66 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5062,13 +5062,13 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 		dwc2_hc_driver.reset_device = dwc2_reset_device;
 	}
 
+	if (hsotg->params.host_dma)
+		dwc2_hc_driver.flags |= HCD_DMA;
+
 	hcd = usb_create_hcd(&dwc2_hc_driver, hsotg->dev, dev_name(hsotg->dev));
 	if (!hcd)
 		goto error1;
 
-	if (!hsotg->params.host_dma)
-		hcd->self.uses_dma = 0;
-
 	hcd->has_tt = 1;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/usb/host/ehci-grlib.c b/drivers/usb/host/ehci-grlib.c
index 656b8c08efc8..a2c3b4ec8a8b 100644
--- a/drivers/usb/host/ehci-grlib.c
+++ b/drivers/usb/host/ehci-grlib.c
@@ -30,7 +30,7 @@ static const struct hc_driver ehci_grlib_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
+	.flags			= HCD_MEMORY | HCD_DMA | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 9da7e22848c9..cf2b7ae93b7e 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1193,7 +1193,7 @@ static const struct hc_driver ehci_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq =			ehci_irq,
-	.flags =		HCD_MEMORY | HCD_USB2 | HCD_BH,
+	.flags =		HCD_MEMORY | HCD_DMA | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-pmcmsp.c b/drivers/usb/host/ehci-pmcmsp.c
index 46e160370d6e..a2b610dbedfc 100644
--- a/drivers/usb/host/ehci-pmcmsp.c
+++ b/drivers/usb/host/ehci-pmcmsp.c
@@ -250,7 +250,7 @@ static const struct hc_driver ehci_msp_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq =			ehci_irq,
-	.flags =		HCD_MEMORY | HCD_USB2 | HCD_BH,
+	.flags =		HCD_MEMORY | HCD_DMA | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
index 576f7d79ad4e..9d17e0695e35 100644
--- a/drivers/usb/host/ehci-ppc-of.c
+++ b/drivers/usb/host/ehci-ppc-of.c
@@ -31,7 +31,7 @@ static const struct hc_driver ehci_ppc_of_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
+	.flags			= HCD_MEMORY | HC_DMA | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
index 454d8c624a3f..fb52133c3557 100644
--- a/drivers/usb/host/ehci-ps3.c
+++ b/drivers/usb/host/ehci-ps3.c
@@ -59,7 +59,7 @@ static const struct hc_driver ps3_ehci_hc_driver = {
 	.product_desc		= "PS3 EHCI Host Controller",
 	.hcd_priv_size		= sizeof(struct ehci_hcd),
 	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
+	.flags			= HCD_MEMORY | HCD_DMA | HCD_USB2 | HCD_BH,
 	.reset			= ps3_ehci_hc_reset,
 	.start			= ehci_run,
 	.stop			= ehci_stop,
diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
index a9ee767952c1..6a28fb93b9f1 100644
--- a/drivers/usb/host/ehci-sh.c
+++ b/drivers/usb/host/ehci-sh.c
@@ -33,7 +33,7 @@ static const struct hc_driver ehci_sh_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq				= ehci_irq,
-	.flags				= HCD_USB2 | HCD_MEMORY | HCD_BH,
+	.flags				= HCD_USB2 | HCD_DMA | HCD_MEMORY | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-xilinx-of.c b/drivers/usb/host/ehci-xilinx-of.c
index d2a27578e440..67a6ee8cb5d8 100644
--- a/drivers/usb/host/ehci-xilinx-of.c
+++ b/drivers/usb/host/ehci-xilinx-of.c
@@ -66,7 +66,7 @@ static const struct hc_driver ehci_xilinx_of_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
+	.flags			= HCD_MEMORY | HCD_DMA | HCD_USB2 | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 48fe9e6c2465..04733876c9c6 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -538,7 +538,7 @@ static const struct hc_driver fhci_driver = {
 
 	/* generic hardware linkage */
 	.irq = fhci_irq,
-	.flags = HCD_USB11 | HCD_MEMORY,
+	.flags = HCD_DMA | HCD_USB11 | HCD_MEMORY,
 
 	/* basic lifecycle operation */
 	.start = fhci_start,
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 77cc36efae95..8d7ccd032d47 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -5504,7 +5504,7 @@ static const struct hc_driver fotg210_fotg210_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq			= fotg210_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
+	.flags			= HCD_MEMORY | HCD_DMA | HCD_USB2,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/imx21-hcd.c b/drivers/usb/host/imx21-hcd.c
index 6e3dad19d369..bd5fcc935e09 100644
--- a/drivers/usb/host/imx21-hcd.c
+++ b/drivers/usb/host/imx21-hcd.c
@@ -1771,7 +1771,7 @@ static const struct hc_driver imx21_hc_driver = {
 	.product_desc = "IMX21 USB Host Controller",
 	.hcd_priv_size = sizeof(struct imx21),
 
-	.flags = HCD_USB11,
+	.flags = HCD_DMA | HCD_USB11,
 	.irq = imx21_irq,
 
 	.reset = imx21_hc_reset,
diff --git a/drivers/usb/host/isp116x-hcd.c b/drivers/usb/host/isp116x-hcd.c
index 74da136d322a..a87c0b26279e 100644
--- a/drivers/usb/host/isp116x-hcd.c
+++ b/drivers/usb/host/isp116x-hcd.c
@@ -1581,12 +1581,6 @@ static int isp116x_probe(struct platform_device *pdev)
 	irq = ires->start;
 	irqflags = ires->flags & IRQF_TRIGGER_MASK;
 
-	if (pdev->dev.dma_mask) {
-		DBG("DMA not supported\n");
-		ret = -EINVAL;
-		goto err1;
-	}
-
 	if (!request_mem_region(addr->start, 2, hcd_name)) {
 		ret = -EBUSY;
 		goto err1;
diff --git a/drivers/usb/host/isp1362-hcd.c b/drivers/usb/host/isp1362-hcd.c
index 28bf8bfb091e..96f8daa11f25 100644
--- a/drivers/usb/host/isp1362-hcd.c
+++ b/drivers/usb/host/isp1362-hcd.c
@@ -2645,11 +2645,6 @@ static int isp1362_probe(struct platform_device *pdev)
 	if (pdev->num_resources < 3)
 		return -ENODEV;
 
-	if (pdev->dev.dma_mask) {
-		DBG(1, "won't do DMA");
-		return -ENODEV;
-	}
-
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!irq_res)
 		return -ENODEV;
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index b457fdaff297..1eb8d17e19db 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1178,7 +1178,7 @@ static const struct hc_driver ohci_hc_driver = {
 	 * generic hardware linkage
 	*/
 	.irq =                  ohci_irq,
-	.flags =                HCD_MEMORY | HCD_USB11,
+	.flags =                HCD_MEMORY | HCD_DMA | HCD_USB11,
 
 	/*
 	* basic lifecycle operations
diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
index 76a9b40b08f1..45f7cceb6df3 100644
--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -50,7 +50,7 @@ static const struct hc_driver ohci_ppc_of_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq =			ohci_irq,
-	.flags =		HCD_USB11 | HCD_MEMORY,
+	.flags =		HCD_USB11 | HCD_DMA | HCD_MEMORY,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
index 395f9d3bc849..f77cd6af0ccf 100644
--- a/drivers/usb/host/ohci-ps3.c
+++ b/drivers/usb/host/ohci-ps3.c
@@ -46,7 +46,7 @@ static const struct hc_driver ps3_ohci_hc_driver = {
 	.product_desc		= "PS3 OHCI Host Controller",
 	.hcd_priv_size		= sizeof(struct ohci_hcd),
 	.irq			= ohci_irq,
-	.flags			= HCD_MEMORY | HCD_USB11,
+	.flags			= HCD_MEMORY | HCD_DMA | HCD_USB11,
 	.reset			= ps3_ohci_hc_reset,
 	.start			= ps3_ohci_hc_start,
 	.stop			= ohci_stop,
diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index ebec9a7699e3..8e19a5eb5b62 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -84,7 +84,7 @@ static const struct hc_driver ohci_sa1111_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq =			ohci_irq,
-	.flags =		HCD_USB11 | HCD_MEMORY,
+	.flags =		HCD_USB11 | HCD_DMA | HCD_MEMORY,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index c158cda9e4b9..0b2aea6e28d4 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -49,7 +49,7 @@ static const struct hc_driver ohci_sm501_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq =			ohci_irq,
-	.flags =		HCD_USB11 | HCD_MEMORY,
+	.flags =		HCD_USB11 | HCD_DMA | HCD_MEMORY,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index d5a293a707b6..8edbacd3eb17 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -153,7 +153,7 @@ static const struct hc_driver ohci_tmio_hc_driver = {
 
 	/* generic hardware linkage */
 	.irq =			ohci_irq,
-	.flags =		HCD_USB11 | HCD_MEMORY,
+	.flags =		HCD_USB11 | HCD_DMA | HCD_MEMORY,
 
 	/* basic lifecycle operations */
 	.start =		ohci_tmio_start,
diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index 47c5515a9ce4..29a49cc8a1ed 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -2649,9 +2649,6 @@ static int oxu_reset(struct usb_hcd *hcd)
 	INIT_LIST_HEAD(&oxu->urb_list);
 	oxu->urb_len = 0;
 
-	/* FIMXE */
-	hcd->self.controller->dma_mask = NULL;
-
 	if (oxu->is_otg) {
 		oxu->caps = hcd->regs + OXU_OTG_CAP_OFFSET;
 		oxu->regs = hcd->regs + OXU_OTG_CAP_OFFSET + \
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 42668aeca57c..0c03ac6b0213 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -2411,12 +2411,6 @@ static int r8a66597_probe(struct platform_device *pdev)
 	if (usb_disabled())
 		return -ENODEV;
 
-	if (pdev->dev.dma_mask) {
-		ret = -EINVAL;
-		dev_err(&pdev->dev, "dma not supported\n");
-		goto clean_up;
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENODEV;
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 5b061e599948..72a34a1eb618 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1632,12 +1632,6 @@ sl811h_probe(struct platform_device *dev)
 	irq = ires->start;
 	irqflags = ires->flags & IRQF_TRIGGER_MASK;
 
-	/* refuse to confuse usbcore */
-	if (dev->dev.dma_mask) {
-		dev_dbg(&dev->dev, "no we won't dma\n");
-		return -EINVAL;
-	}
-
 	/* the chip may be wired for either kind of addressing */
 	addr = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	data = platform_get_resource(dev, IORESOURCE_MEM, 1);
diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 400c40bc43a6..4efee34f154f 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3077,8 +3077,6 @@ static int u132_probe(struct platform_device *pdev)
 	retval = ftdi_read_pcimem(pdev, roothub.a, &rh_a);
 	if (retval)
 		return retval;
-	if (pdev->dev.dma_mask)
-		return -EINVAL;
 
 	hcd = usb_create_hcd(&u132_hc_driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd) {
diff --git a/drivers/usb/host/uhci-grlib.c b/drivers/usb/host/uhci-grlib.c
index 2103b1ed0f8f..0a201a73b196 100644
--- a/drivers/usb/host/uhci-grlib.c
+++ b/drivers/usb/host/uhci-grlib.c
@@ -63,7 +63,7 @@ static const struct hc_driver uhci_grlib_hc_driver = {
 
 	/* Generic hardware linkage */
 	.irq =			uhci_irq,
-	.flags =		HCD_MEMORY | HCD_USB11,
+	.flags =		HCD_MEMORY | HCD_DMA | HCD_USB11,
 
 	/* Basic lifecycle operations */
 	.reset =		uhci_grlib_init,
diff --git a/drivers/usb/host/uhci-pci.c b/drivers/usb/host/uhci-pci.c
index 0dd944277c99..0fa3d72bae26 100644
--- a/drivers/usb/host/uhci-pci.c
+++ b/drivers/usb/host/uhci-pci.c
@@ -261,7 +261,7 @@ static const struct hc_driver uhci_driver = {
 
 	/* Generic hardware linkage */
 	.irq =			uhci_irq,
-	.flags =		HCD_USB11,
+	.flags =		HCD_DMA | HCD_USB11,
 
 	/* Basic lifecycle operations */
 	.reset =		uhci_pci_init,
diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 89700e26fb29..70dbd95c3f06 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -41,7 +41,7 @@ static const struct hc_driver uhci_platform_hc_driver = {
 
 	/* Generic hardware linkage */
 	.irq =			uhci_irq,
-	.flags =		HCD_MEMORY | HCD_USB11,
+	.flags =		HCD_MEMORY | HCD_DMA | HCD_USB11,
 
 	/* Basic lifecycle operations */
 	.reset =		uhci_platform_init,
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 03d1e552769b..e315c0158e90 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5217,7 +5217,7 @@ static const struct hc_driver xhci_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq =			xhci_irq,
-	.flags =		HCD_MEMORY | HCD_USB3 | HCD_SHARED,
+	.flags =		HCD_MEMORY | HCD_DMA | HCD_USB3 | HCD_SHARED,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/isp1760/isp1760-core.c b/drivers/usb/isp1760/isp1760-core.c
index 55b94fd10331..fdeb4cf97cc5 100644
--- a/drivers/usb/isp1760/isp1760-core.c
+++ b/drivers/usb/isp1760/isp1760-core.c
@@ -120,9 +120,6 @@ int isp1760_register(struct resource *mem, int irq, unsigned long irqflags,
 	    (!IS_ENABLED(CONFIG_USB_ISP1761_UDC) || udc_disabled))
 		return -ENODEV;
 
-	/* prevent usb-core allocating DMA pages */
-	dev->dma_mask = NULL;
-
 	isp = devm_kzalloc(dev, sizeof(*isp), GFP_KERNEL);
 	if (!isp)
 		return -ENOMEM;
diff --git a/drivers/usb/isp1760/isp1760-if.c b/drivers/usb/isp1760/isp1760-if.c
index 241a00d75027..07cc82ff327c 100644
--- a/drivers/usb/isp1760/isp1760-if.c
+++ b/drivers/usb/isp1760/isp1760-if.c
@@ -139,7 +139,6 @@ static int isp1761_pci_probe(struct pci_dev *dev,
 
 	pci_set_master(dev);
 
-	dev->dev.dma_mask = NULL;
 	ret = isp1760_register(&dev->resource[3], dev->irq, 0, &dev->dev,
 			       devflags);
 	if (ret < 0)
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index eb308ec35c66..5a44b70372d9 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2689,7 +2689,7 @@ static const struct hc_driver musb_hc_driver = {
 	.description		= "musb-hcd",
 	.product_desc		= "MUSB HDRC host driver",
 	.hcd_priv_size		= sizeof(struct musb *),
-	.flags			= HCD_USB2 | HCD_MEMORY,
+	.flags			= HCD_USB2 | HCD_DMA | HCD_MEMORY,
 
 	/* not using irq handler or reset hooks from usbcore, since
 	 * those must be shared with peripheral code for OTG configs
diff --git a/drivers/usb/renesas_usbhs/mod_host.c b/drivers/usb/renesas_usbhs/mod_host.c
index ddd3be48f948..ae54221011c3 100644
--- a/drivers/usb/renesas_usbhs/mod_host.c
+++ b/drivers/usb/renesas_usbhs/mod_host.c
@@ -1283,7 +1283,7 @@ static const struct hc_driver usbhsh_driver = {
 	/*
 	 * generic hardware linkage
 	 */
-	.flags =		HCD_USB2,
+	.flags =		HCD_DMA | HCD_USB2,
 
 	.start =		usbhsh_host_start,
 	.stop =			usbhsh_host_stop,
diff --git a/include/linux/usb.h b/include/linux/usb.h
index e87826e23d59..85a8865f9e83 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -426,7 +426,6 @@ struct usb_bus {
 	struct device *sysdev;		/* as seen from firmware or bus */
 	int busnum;			/* Bus number (in order of reg) */
 	const char *bus_name;		/* stable id (PCI slot_name etc) */
-	u8 uses_dma;			/* Does the host controller use DMA? */
 	u8 uses_pio_for_control;	/*
 					 * Does the host controller use PIO
 					 * for control transfers?
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index a20e7815d814..8d3869c7de85 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -256,6 +256,7 @@ struct hc_driver {
 
 	int	flags;
 #define	HCD_MEMORY	0x0001		/* HC regs use memory (else I/O) */
+#define	HCD_DMA		0x0002		/* HC uses DMA */
 #define	HCD_SHARED	0x0004		/* Two (or more) usb_hcds share HW */
 #define	HCD_USB11	0x0010		/* USB 1.1 */
 #define	HCD_USB2	0x0020		/* USB 2.0 */
@@ -422,8 +423,10 @@ static inline bool hcd_periodic_completion_in_progress(struct usb_hcd *hcd,
 	return hcd->high_prio_bh.completing_ep == ep;
 }
 
-#define hcd_uses_dma(hcd) \
-	(IS_ENABLED(CONFIG_HAS_DMA) && (hcd)->self.uses_dma)
+static inline bool hcd_uses_dma(struct usb_hcd *hcd)
+{
+	return IS_ENABLED(CONFIG_HAS_DMA) && (hcd->driver->flags & HCD_DMA);
+}
 
 extern int usb_hcd_link_urb_to_ep(struct usb_hcd *hcd, struct urb *urb);
 extern int usb_hcd_check_unlink_urb(struct usb_hcd *hcd, struct urb *urb,
-- 
2.20.1

