Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DE3514C0A
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 15:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376875AbiD2N76 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 09:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376878AbiD2N54 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 09:57:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B950CFBAD;
        Fri, 29 Apr 2022 06:52:20 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TB4Her024408;
        Fri, 29 Apr 2022 13:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LtY0U54p1j8DNuMexzH2liiZILMDtwwYZ4XNR2a0COU=;
 b=MMdo2ddUfmbKgQZYheX93Ub9LJpcNEVGOt6DkuEFegw9w20JKfCK6Qi/7F1Zavh9kbta
 87bo5an8SedjTC18WCALxEmxaIzfiZdAF6MA/B3YwPHi2hnWo2jAB4xVLgEiiJ2Z/vl9
 0Gir7mfywMPxVefoObENo32n3oIBwrB2pof4mux6mTZ/hhyiCrAzmy2w8gwt1ALDIeRE
 S8z8b8B6LeYf00q8Rv5XPj9RCsOO6CaSBJZeObKAdI/IsMIxTb7kGaeDNBJQIawIbc5y
 WNUeS+bJTp7OKp5AO5qQURUX1lYIUzo9O4yS5KAg3wuxYHr2TNFpPN4q3K0gcwArLBR9 +g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqnke421b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:52 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TDS1XR027891;
        Fri, 29 Apr 2022 13:51:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3fm938yank-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 13:51:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TDccAZ53608796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 13:38:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCE744C040;
        Fri, 29 Apr 2022 13:51:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C5F84C044;
        Fri, 29 Apr 2022 13:51:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 13:51:46 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [RFC v2 35/39] usb: handle HAS_IOPORT dependencies
Date:   Fri, 29 Apr 2022 15:51:02 +0200
Message-Id: <20220429135108.2781579-65-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429135108.2781579-1-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AU2KwRPtisH_A7Cod8QttpmB897aRDm3
X-Proofpoint-GUID: AU2KwRPtisH_A7Cod8QttpmB897aRDm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=780 bulkscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to guard sections of code calling them
as alternative access methods with CONFIG_HAS_IOPORT checks. Similarly
drivers requiring these functions need to depend on HAS_IOPORT.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/usb/core/hcd-pci.c    |   2 +
 drivers/usb/host/Kconfig      |   4 +-
 drivers/usb/host/pci-quirks.c | 128 ++++++++++++++++++----------------
 drivers/usb/host/pci-quirks.h |  31 +++++---
 drivers/usb/host/uhci-hcd.c   |   2 +-
 drivers/usb/host/uhci-hcd.h   |  33 +++++----
 6 files changed, 117 insertions(+), 83 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 8176bc81a635..4d119154acd0 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -212,8 +212,10 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id,
 		goto free_irq_vectors;
 	}
 
+#ifdef CONFIG_USB_PCI_AMD
 	hcd->amd_resume_bug = (usb_hcd_amd_remote_wakeup_quirk(dev) &&
 			driver->flags & (HCD_USB11 | HCD_USB3)) ? 1 : 0;
+#endif
 
 	if (driver->flags & HCD_MEMORY) {
 		/* EHCI, OHCI */
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 57ca5f97a3dc..cd1faa3174e3 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -369,7 +369,7 @@ config USB_ISP116X_HCD
 
 config USB_ISP1362_HCD
 	tristate "ISP1362 HCD support"
-	depends on HAS_IOMEM
+	depends on HAS_IOPORT
 	depends on COMPILE_TEST # nothing uses this
 	help
 	  Supports the Philips ISP1362 chip as a host controller
@@ -605,7 +605,7 @@ endif # USB_OHCI_HCD
 
 config USB_UHCI_HCD
 	tristate "UHCI HCD (most Intel and VIA) support"
-	depends on USB_PCI || USB_UHCI_SUPPORT_NON_PCI_HC
+	depends on (USB_PCI && HAS_IOPORT) || USB_UHCI_SUPPORT_NON_PCI_HC
 	help
 	  The Universal Host Controller Interface is a standard by Intel for
 	  accessing the USB hardware in the PC (which is also called the USB
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index ef08d68b9714..4fd06b48149d 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -60,6 +60,23 @@
 #define EHCI_USBLEGCTLSTS	4		/* legacy control/status */
 #define EHCI_USBLEGCTLSTS_SOOE	(1 << 13)	/* SMI on ownership change */
 
+/* ASMEDIA quirk use */
+#define ASMT_DATA_WRITE0_REG	0xF8
+#define ASMT_DATA_WRITE1_REG	0xFC
+#define ASMT_CONTROL_REG	0xE0
+#define ASMT_CONTROL_WRITE_BIT	0x02
+#define ASMT_WRITEREG_CMD	0x10423
+#define ASMT_FLOWCTL_ADDR	0xFA30
+#define ASMT_FLOWCTL_DATA	0xBA
+#define ASMT_PSEUDO_DATA	0
+
+/* Intel quirk use */
+#define USB_INTEL_XUSB2PR      0xD0
+#define USB_INTEL_USB2PRM      0xD4
+#define USB_INTEL_USB3_PSSEN   0xD8
+#define USB_INTEL_USB3PRM      0xDC
+
+#ifdef CONFIG_USB_PCI_AMD
 /* AMD quirk use */
 #define	AB_REG_BAR_LOW		0xe0
 #define	AB_REG_BAR_HIGH		0xe1
@@ -93,21 +110,6 @@
 #define	NB_PIF0_PWRDOWN_0	0x01100012
 #define	NB_PIF0_PWRDOWN_1	0x01100013
 
-#define USB_INTEL_XUSB2PR      0xD0
-#define USB_INTEL_USB2PRM      0xD4
-#define USB_INTEL_USB3_PSSEN   0xD8
-#define USB_INTEL_USB3PRM      0xDC
-
-/* ASMEDIA quirk use */
-#define ASMT_DATA_WRITE0_REG	0xF8
-#define ASMT_DATA_WRITE1_REG	0xFC
-#define ASMT_CONTROL_REG	0xE0
-#define ASMT_CONTROL_WRITE_BIT	0x02
-#define ASMT_WRITEREG_CMD	0x10423
-#define ASMT_FLOWCTL_ADDR	0xFA30
-#define ASMT_FLOWCTL_DATA	0xBA
-#define ASMT_PSEUDO_DATA	0
-
 /*
  * amd_chipset_gen values represent AMD different chipset generations
  */
@@ -460,50 +462,6 @@ void usb_amd_quirk_pll_disable(void)
 }
 EXPORT_SYMBOL_GPL(usb_amd_quirk_pll_disable);
 
-static int usb_asmedia_wait_write(struct pci_dev *pdev)
-{
-	unsigned long retry_count;
-	unsigned char value;
-
-	for (retry_count = 1000; retry_count > 0; --retry_count) {
-
-		pci_read_config_byte(pdev, ASMT_CONTROL_REG, &value);
-
-		if (value == 0xff) {
-			dev_err(&pdev->dev, "%s: check_ready ERROR", __func__);
-			return -EIO;
-		}
-
-		if ((value & ASMT_CONTROL_WRITE_BIT) == 0)
-			return 0;
-
-		udelay(50);
-	}
-
-	dev_warn(&pdev->dev, "%s: check_write_ready timeout", __func__);
-	return -ETIMEDOUT;
-}
-
-void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev)
-{
-	if (usb_asmedia_wait_write(pdev) != 0)
-		return;
-
-	/* send command and address to device */
-	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_WRITEREG_CMD);
-	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_FLOWCTL_ADDR);
-	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
-
-	if (usb_asmedia_wait_write(pdev) != 0)
-		return;
-
-	/* send data to device */
-	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_FLOWCTL_DATA);
-	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_PSEUDO_DATA);
-	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
-}
-EXPORT_SYMBOL_GPL(usb_asmedia_modifyflowcontrol);
-
 void usb_amd_quirk_pll_enable(void)
 {
 	usb_amd_quirk_pll(0);
@@ -632,7 +590,53 @@ bool usb_amd_pt_check_port(struct device *device, int port)
 	return !(value & BIT(port_shift));
 }
 EXPORT_SYMBOL_GPL(usb_amd_pt_check_port);
+#endif
+
+static int usb_asmedia_wait_write(struct pci_dev *pdev)
+{
+	unsigned long retry_count;
+	unsigned char value;
+
+	for (retry_count = 1000; retry_count > 0; --retry_count) {
+
+		pci_read_config_byte(pdev, ASMT_CONTROL_REG, &value);
+
+		if (value == 0xff) {
+			dev_err(&pdev->dev, "%s: check_ready ERROR", __func__);
+			return -EIO;
+		}
+
+		if ((value & ASMT_CONTROL_WRITE_BIT) == 0)
+			return 0;
+
+		udelay(50);
+	}
+
+	dev_warn(&pdev->dev, "%s: check_write_ready timeout", __func__);
+	return -ETIMEDOUT;
+}
+
+void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev)
+{
+	if (usb_asmedia_wait_write(pdev) != 0)
+		return;
+
+	/* send command and address to device */
+	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_WRITEREG_CMD);
+	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_FLOWCTL_ADDR);
+	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
+
+	if (usb_asmedia_wait_write(pdev) != 0)
+		return;
 
+	/* send data to device */
+	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_FLOWCTL_DATA);
+	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_PSEUDO_DATA);
+	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
+}
+EXPORT_SYMBOL_GPL(usb_asmedia_modifyflowcontrol);
+
+#ifdef CONFIG_HAS_IOPORT
 /*
  * Make sure the controller is completely inactive, unable to
  * generate interrupts or do DMA.
@@ -713,6 +717,7 @@ int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(uhci_check_and_reset_hc);
+#endif
 
 static inline int io_type_enabled(struct pci_dev *pdev, unsigned int mask)
 {
@@ -725,6 +730,7 @@ static inline int io_type_enabled(struct pci_dev *pdev, unsigned int mask)
 
 static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
 {
+#ifdef HAS_IOPORT
 	unsigned long base = 0;
 	int i;
 
@@ -739,6 +745,7 @@ static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
 
 	if (base)
 		uhci_check_and_reset_hc(pdev, base);
+#endif
 }
 
 static int mmio_resource_enabled(struct pci_dev *pdev, int idx)
@@ -1273,7 +1280,8 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
 			 "Can't enable PCI device, BIOS handoff failed.\n");
 		return;
 	}
-	if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
+	if (IS_ENABLED(CONFIG_USB_UHCI_HCD) &&
+	    pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
 		quirk_usb_handoff_uhci(pdev);
 	else if (pdev->class == PCI_CLASS_SERIAL_USB_OHCI)
 		quirk_usb_handoff_ohci(pdev);
diff --git a/drivers/usb/host/pci-quirks.h b/drivers/usb/host/pci-quirks.h
index e729de21fad7..5642318fd1d1 100644
--- a/drivers/usb/host/pci-quirks.h
+++ b/drivers/usb/host/pci-quirks.h
@@ -2,33 +2,48 @@
 #ifndef __LINUX_USB_PCI_QUIRKS_H
 #define __LINUX_USB_PCI_QUIRKS_H
 
-#ifdef CONFIG_USB_PCI
 void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
 int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
-int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *pdev);
+
+#ifdef CONFIG_USB_PCI_AMD
 bool usb_amd_hang_symptom_quirk(void);
 bool usb_amd_prefetch_quirk(void);
 void usb_amd_dev_put(void);
 bool usb_amd_quirk_pll_check(void);
 void usb_amd_quirk_pll_disable(void);
 void usb_amd_quirk_pll_enable(void);
-void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev);
-void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev);
-void usb_disable_xhci_ports(struct pci_dev *xhci_pdev);
 void sb800_prefetch(struct device *dev, int on);
 bool usb_amd_pt_check_port(struct device *device, int port);
 #else
-struct pci_dev;
+static inline bool usb_amd_hang_symptom_quirk(void)
+{
+	return false;
+};
+static inline bool usb_amd_prefetch_quirk(void)
+{
+	return false;
+}
+static inline bool usb_amd_quirk_pll_check(void)
+{
+	return false;
+}
 static inline void usb_amd_quirk_pll_disable(void) {}
 static inline void usb_amd_quirk_pll_enable(void) {}
-static inline void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev) {}
 static inline void usb_amd_dev_put(void) {}
-static inline void usb_disable_xhci_ports(struct pci_dev *xhci_pdev) {}
 static inline void sb800_prefetch(struct device *dev, int on) {}
 static inline bool usb_amd_pt_check_port(struct device *device, int port)
 {
 	return false;
 }
+#endif /* CONFIG_USB_PCI_AMD */
+
+#ifdef CONFIG_USB_PCI
+void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev);
+void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev);
+void usb_disable_xhci_ports(struct pci_dev *xhci_pdev);
+#else
+static inline void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev) {}
+static inline void usb_disable_xhci_ports(struct pci_dev *xhci_pdev) {}
 #endif  /* CONFIG_USB_PCI */
 
 #endif  /*  __LINUX_USB_PCI_QUIRKS_H  */
diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
index d90b869f5f40..a3b0d3d3b395 100644
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -841,7 +841,7 @@ static int uhci_count_ports(struct usb_hcd *hcd)
 
 static const char hcd_name[] = "uhci_hcd";
 
-#ifdef CONFIG_USB_PCI
+#if defined(CONFIG_USB_PCI) && defined(CONFIG_HAS_IOPORT)
 #include "uhci-pci.c"
 #define	PCI_DRIVER		uhci_pci_driver
 #endif
diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
index 8ae5ccd26753..be4aee1f0ca5 100644
--- a/drivers/usb/host/uhci-hcd.h
+++ b/drivers/usb/host/uhci-hcd.h
@@ -505,36 +505,43 @@ static inline bool uhci_is_aspeed(const struct uhci_hcd *uhci)
  * we use memory mapped registers.
  */
 
+#ifdef CONFIG_HAS_IOPORT
+#define UHCI_IN(x)	x
+#define UHCI_OUT(x)	x
+#else
+#define UHCI_IN(x)	0
+#define UHCI_OUT(x)
+#endif
 #ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
 /* Support PCI only */
 static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
 {
-	return inl(uhci->io_addr + reg);
+	return UHCI_IN(inl(uhci->io_addr + reg));
 }
 
 static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int reg)
 {
-	outl(val, uhci->io_addr + reg);
+	UHCI_OUT(outl(val, uhci->io_addr + reg));
 }
 
 static inline u16 uhci_readw(const struct uhci_hcd *uhci, int reg)
 {
-	return inw(uhci->io_addr + reg);
+	return UHCI_IN(inw(uhci->io_addr + reg));
 }
 
 static inline void uhci_writew(const struct uhci_hcd *uhci, u16 val, int reg)
 {
-	outw(val, uhci->io_addr + reg);
+	UHCI_OUT(outw(val, uhci->io_addr + reg));
 }
 
 static inline u8 uhci_readb(const struct uhci_hcd *uhci, int reg)
 {
-	return inb(uhci->io_addr + reg);
+	return UHCI_IN(inb(uhci->io_addr + reg));
 }
 
 static inline void uhci_writeb(const struct uhci_hcd *uhci, u8 val, int reg)
 {
-	outb(val, uhci->io_addr + reg);
+	UHCI_OUT(outb(val, uhci->io_addr + reg));
 }
 
 #else
@@ -587,7 +594,7 @@ static inline int uhci_aspeed_reg(unsigned int reg)
 static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		return inl(uhci->io_addr + reg);
+		return UHCI_IN(inl(uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		return readl(uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -601,7 +608,7 @@ static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
 static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		outl(val, uhci->io_addr + reg);
+		UHCI_OUT(outl(val, uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		writel(val, uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -615,7 +622,7 @@ static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int reg)
 static inline u16 uhci_readw(const struct uhci_hcd *uhci, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		return inw(uhci->io_addr + reg);
+		return UHCI_IN(inw(uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		return readl(uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -629,7 +636,7 @@ static inline u16 uhci_readw(const struct uhci_hcd *uhci, int reg)
 static inline void uhci_writew(const struct uhci_hcd *uhci, u16 val, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		outw(val, uhci->io_addr + reg);
+		UHCI_OUT(outw(val, uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		writel(val, uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -643,7 +650,7 @@ static inline void uhci_writew(const struct uhci_hcd *uhci, u16 val, int reg)
 static inline u8 uhci_readb(const struct uhci_hcd *uhci, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		return inb(uhci->io_addr + reg);
+		return UHCI_IN(inb(uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		return readl(uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -657,7 +664,7 @@ static inline u8 uhci_readb(const struct uhci_hcd *uhci, int reg)
 static inline void uhci_writeb(const struct uhci_hcd *uhci, u8 val, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		outb(val, uhci->io_addr + reg);
+		UHCI_OUT(outb(val, uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		writel(val, uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -668,6 +675,8 @@ static inline void uhci_writeb(const struct uhci_hcd *uhci, u8 val, int reg)
 		writeb(val, uhci->regs + reg);
 }
 #endif /* CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC */
+#undef UHCI_IN
+#undef UHCI_OUT
 
 /*
  * The GRLIB GRUSBHC controller can use big endian format for its descriptors.
-- 
2.32.0

