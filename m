Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93BF480205
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 17:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhL0Qok (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 11:44:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54030 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230493AbhL0QoY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 11:44:24 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGfnCe017488;
        Mon, 27 Dec 2021 16:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JtfYKoojqdMxdzqlhDCFMu4QHr7ax+Od1FH9Y1z7lrc=;
 b=NqiJoGGQxGa73BrsSxdQPc8ZPCvdt1lE04PLFX4aONyLp4WzApskQYNal/U0KnSm7m1K
 6hapMtnSHqC/wudcwK+Sdm8TLmaHe8C81wz7Zy4/hte/nxkUJMzrfwfFY0gxp47KKFVW
 FtOLWQXA6KNNRC6qfsAnQ1t2sziq4hG9tOLz54rCeMCSDihEj/0EfeIVzyRMw3U82RVS
 LU9PrqPaSlXjHC7ThtVYk41femckJWMrSXudPs/9UkG6hveRd8RWct6yVBsxv3mkfRvM
 k5RfKtlMN1T/P5+hMPPW+mjngsVfOK099orHqiH1rTUo/8Dqo3+ZloS5HrNo6TcUynn9 UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7h7u810w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:59 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRGhwNa024213;
        Mon, 27 Dec 2021 16:43:58 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7h7u810a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:58 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGhWeQ028590;
        Mon, 27 Dec 2021 16:43:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3d5tx92sqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 16:43:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRGhr3q42664410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 16:43:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B4BBA405C;
        Mon, 27 Dec 2021 16:43:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7C95A405B;
        Mon, 27 Dec 2021 16:43:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 16:43:52 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC 31/32] usb: handle HAS_IOPORT dependencies
Date:   Mon, 27 Dec 2021 17:43:16 +0100
Message-Id: <20211227164317.4146918-32-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227164317.4146918-1-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 10dnCpmQSuf8uogZvjEhfJqKB7OgiiS2
X-Proofpoint-ORIG-GUID: DmCPH8LcvP2nav80rIO2RknewOuhghAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_08,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112270080
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to guard sections of code calling them
as alternative access methods with CONFIG_HAS_IOPORT checks. Similarly
drivers requiring these functions need to depend on HAS_IOPORT.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/usb/core/hcd-pci.c    |   3 +-
 drivers/usb/host/Kconfig      |   4 +-
 drivers/usb/host/pci-quirks.c | 127 ++++++++++++++++++----------------
 drivers/usb/host/pci-quirks.h |  33 ++++++---
 drivers/usb/host/uhci-hcd.c   |   2 +-
 drivers/usb/host/uhci-hcd.h   |  77 ++++++++++++++-------
 6 files changed, 148 insertions(+), 98 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index d630cccd2e6e..1ade46cec91a 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -212,7 +212,8 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id,
 		goto free_irq_vectors;
 	}
 
-	hcd->amd_resume_bug = (usb_hcd_amd_remote_wakeup_quirk(dev) &&
+	hcd->amd_resume_bug = (IS_ENABLED(CONFIG_USB_PCI_AMD) &&
+			usb_hcd_amd_remote_wakeup_quirk(dev) &&
 			driver->flags & (HCD_USB11 | HCD_USB3)) ? 1 : 0;
 
 	if (driver->flags & HCD_MEMORY) {
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d1d926f8f9c2..5fb207e2d5e8 100644
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
index ef08d68b9714..bba320194027 100644
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
@@ -632,7 +590,52 @@ bool usb_amd_pt_check_port(struct device *device, int port)
 	return !(value & BIT(port_shift));
 }
 EXPORT_SYMBOL_GPL(usb_amd_pt_check_port);
+#endif
 
+static int usb_asmedia_wait_write(struct pci_dev *pdev)
+{
+	unsigned long retry_count;
+	unsigned char value;
+
+	for (retry_count = 1000; retry_count > 0; --retry_count) {
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
+
+	/* send data to device */
+	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_FLOWCTL_DATA);
+	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_PSEUDO_DATA);
+	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
+}
+EXPORT_SYMBOL_GPL(usb_asmedia_modifyflowcontrol);
+
+#if IS_ENABLED(CONFIG_USB_UHCI_HCD) && defined(CONFIG_HAS_IOPORT)
 /*
  * Make sure the controller is completely inactive, unable to
  * generate interrupts or do DMA.
@@ -713,6 +716,7 @@ int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(uhci_check_and_reset_hc);
+#endif
 
 static inline int io_type_enabled(struct pci_dev *pdev, unsigned int mask)
 {
@@ -728,7 +732,7 @@ static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
 	unsigned long base = 0;
 	int i;
 
-	if (!pio_enabled(pdev))
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT) || !pio_enabled(pdev))
 		return;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++)
@@ -1273,7 +1277,8 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
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
index e729de21fad7..42eb18be37af 100644
--- a/drivers/usb/host/pci-quirks.h
+++ b/drivers/usb/host/pci-quirks.h
@@ -2,33 +2,50 @@
 #ifndef __LINUX_USB_PCI_QUIRKS_H
 #define __LINUX_USB_PCI_QUIRKS_H
 
-#ifdef CONFIG_USB_PCI
 void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
 int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
-int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *pdev);
+
+struct pci_dev;
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
index 8ae5ccd26753..8e30116b6fd2 100644
--- a/drivers/usb/host/uhci-hcd.h
+++ b/drivers/usb/host/uhci-hcd.h
@@ -586,12 +586,14 @@ static inline int uhci_aspeed_reg(unsigned int reg)
 
 static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
 {
+#ifdef CONFIG_HAS_IOPORT
 	if (uhci_has_pci_registers(uhci))
 		return inl(uhci->io_addr + reg);
-	else if (uhci_is_aspeed(uhci))
+#endif
+	if (uhci_is_aspeed(uhci))
 		return readl(uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
-	else if (uhci_big_endian_mmio(uhci))
+	if (uhci_big_endian_mmio(uhci))
 		return readl_be(uhci->regs + reg);
 #endif
 	else
@@ -600,72 +602,97 @@ static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
 
 static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int reg)
 {
-	if (uhci_has_pci_registers(uhci))
+#ifdef CONFIG_HAS_IOPORT
+	if (uhci_has_pci_registers(uhci)) {
 		outl(val, uhci->io_addr + reg);
-	else if (uhci_is_aspeed(uhci))
+		return;
+	}
+#endif
+	if (uhci_is_aspeed(uhci)) {
 		writel(val, uhci->regs + uhci_aspeed_reg(reg));
+		return;
+	}
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
-	else if (uhci_big_endian_mmio(uhci))
+	if (uhci_big_endian_mmio(uhci)) {
 		writel_be(val, uhci->regs + reg);
+		return;
+	}
 #endif
-	else
-		writel(val, uhci->regs + reg);
+	writel(val, uhci->regs + reg);
 }
 
 static inline u16 uhci_readw(const struct uhci_hcd *uhci, int reg)
 {
+#ifdef CONFIG_HAS_IOPORT
 	if (uhci_has_pci_registers(uhci))
 		return inw(uhci->io_addr + reg);
-	else if (uhci_is_aspeed(uhci))
+#endif
+	if (uhci_is_aspeed(uhci))
 		return readl(uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
-	else if (uhci_big_endian_mmio(uhci))
+	if (uhci_big_endian_mmio(uhci))
 		return readw_be(uhci->regs + reg);
 #endif
-	else
-		return readw(uhci->regs + reg);
+	return readw(uhci->regs + reg);
 }
 
 static inline void uhci_writew(const struct uhci_hcd *uhci, u16 val, int reg)
 {
-	if (uhci_has_pci_registers(uhci))
+#ifdef CONFIG_HAS_IOPORT
+	if (uhci_has_pci_registers(uhci)) {
 		outw(val, uhci->io_addr + reg);
-	else if (uhci_is_aspeed(uhci))
+		return;
+	}
+#endif
+	if (uhci_is_aspeed(uhci)) {
 		writel(val, uhci->regs + uhci_aspeed_reg(reg));
+		return;
+	}
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
-	else if (uhci_big_endian_mmio(uhci))
+	if (uhci_big_endian_mmio(uhci)) {
 		writew_be(val, uhci->regs + reg);
+		return;
+	}
 #endif
-	else
-		writew(val, uhci->regs + reg);
+
+	writew(val, uhci->regs + reg);
 }
 
 static inline u8 uhci_readb(const struct uhci_hcd *uhci, int reg)
 {
+#ifdef CONFIG_HAS_IOPORT
 	if (uhci_has_pci_registers(uhci))
 		return inb(uhci->io_addr + reg);
-	else if (uhci_is_aspeed(uhci))
+#endif
+	if (uhci_is_aspeed(uhci))
 		return readl(uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
-	else if (uhci_big_endian_mmio(uhci))
+	if (uhci_big_endian_mmio(uhci))
 		return readb_be(uhci->regs + reg);
 #endif
-	else
-		return readb(uhci->regs + reg);
+
+	return readb(uhci->regs + reg);
 }
 
 static inline void uhci_writeb(const struct uhci_hcd *uhci, u8 val, int reg)
 {
-	if (uhci_has_pci_registers(uhci))
+#ifdef CONFIG_HAS_IOPORT
+	if (uhci_has_pci_registers(uhci)) {
 		outb(val, uhci->io_addr + reg);
-	else if (uhci_is_aspeed(uhci))
+		return;
+	}
+#endif
+	if (uhci_is_aspeed(uhci)) {
 		writel(val, uhci->regs + uhci_aspeed_reg(reg));
+		return;
+	}
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
-	else if (uhci_big_endian_mmio(uhci))
+	if (uhci_big_endian_mmio(uhci)) {
 		writeb_be(val, uhci->regs + reg);
+		return;
+	}
 #endif
-	else
-		writeb(val, uhci->regs + reg);
+	writeb(val, uhci->regs + reg);
 }
 #endif /* CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC */
 
-- 
2.32.0

