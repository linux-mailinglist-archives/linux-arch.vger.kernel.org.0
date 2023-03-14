Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7F16B9347
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjCNMPs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjCNMOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:14:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844C5A0F31;
        Tue, 14 Mar 2023 05:13:42 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EC0hJT016904;
        Tue, 14 Mar 2023 12:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fpWu4bjmbT7VnYD027m5IDngZAxjc1mI0JW6ZacL0o0=;
 b=QkMCU47Ge/nds6jlv0/N3pac1xr7YEz5QljQD2oW4BIaJl9asLdzJVy3dXleup1lSCER
 hWwM4RjNHf+UhsnAFodaUwPaNwipJ52j7zNGin6GKft1UgWfKKjZLQF4d6ISJnAfDmEG
 XbbJRNDt06LieChkRy24QNnZcvD0e1iFUFuQEMpdxxyCH//WGJsRa5oacB4IA5kBoNKm
 a0mE1GKauG7jiloiWrMCyG54trmNSuQdUzd6bN0dPmB1XPC+ZrD1KdB3deVjIxJwAjzd
 RpC6l57fcrK3fWn8gAy5k5RXplZPrru0EYf4lOVwjH6TIdBYF/+AwzGAvDJdKldGu9i3 vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paph23upb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:59 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EC65mh023642;
        Tue, 14 Mar 2023 12:12:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paph23umn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:58 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E7DPQ2028627;
        Tue, 14 Mar 2023 12:12:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96msn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 12:12:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ECCrdX7471366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 12:12:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6DBE2007B;
        Tue, 14 Mar 2023 12:12:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CD702007A;
        Tue, 14 Mar 2023 12:12:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 12:12:53 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH v3 34/38] usb: handle HAS_IOPORT dependencies
Date:   Tue, 14 Mar 2023 13:12:12 +0100
Message-Id: <20230314121216.413434-35-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314121216.413434-1-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nhSUto_nfwkV3DgwBbzueh9jIN4PMo3B
X-Proofpoint-GUID: XNtd1137mSSJRENGx-OJWh6BFCPN-Tug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_06,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=852 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/usb/host/pci-quirks.c | 125 ++++++++++++++++++----------------
 drivers/usb/host/pci-quirks.h |  31 ++++++---
 drivers/usb/host/uhci-hcd.c   |   2 +-
 drivers/usb/host/uhci-hcd.h   |  36 ++++++----
 6 files changed, 117 insertions(+), 83 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index ab2f3737764e..f2e825ee3246 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -206,8 +206,10 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct hc_driver *driver)
 		goto free_irq_vectors;
 	}
 
+#ifdef CONFIG_USB_PCI_AMD
 	hcd->amd_resume_bug = (usb_hcd_amd_remote_wakeup_quirk(dev) &&
 			driver->flags & (HCD_USB11 | HCD_USB3)) ? 1 : 0;
+#endif
 
 	if (driver->flags & HCD_MEMORY) {
 		/* EHCI, OHCI */
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index eacb603ad1b2..73315ad28a75 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -376,7 +376,7 @@ config USB_ISP116X_HCD
 
 config USB_ISP1362_HCD
 	tristate "ISP1362 HCD support"
-	depends on HAS_IOMEM
+	depends on HAS_IOPORT
 	depends on COMPILE_TEST # nothing uses this
 	help
 	  Supports the Philips ISP1362 chip as a host controller
@@ -578,7 +578,7 @@ endif # USB_OHCI_HCD
 
 config USB_UHCI_HCD
 	tristate "UHCI HCD (most Intel and VIA) support"
-	depends on USB_PCI || USB_UHCI_SUPPORT_NON_PCI_HC
+	depends on (USB_PCI && HAS_IOPORT) || USB_UHCI_SUPPORT_NON_PCI_HC
 	help
 	  The Universal Host Controller Interface is a standard by Intel for
 	  accessing the USB hardware in the PC (which is also called the USB
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index ef08d68b9714..98870f26b250 100644
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
index 7cdc2fa7c28f..fd2408b553cf 100644
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
index 0688c3e5bfe2..c77705d03ed0 100644
--- a/drivers/usb/host/uhci-hcd.h
+++ b/drivers/usb/host/uhci-hcd.h
@@ -505,41 +505,49 @@ static inline bool uhci_is_aspeed(const struct uhci_hcd *uhci)
  * we use memory mapped registers.
  */
 
+#ifdef CONFIG_HAS_IOPORT
+#define UHCI_IN(x)	x
+#define UHCI_OUT(x)	x
+#else
+#define UHCI_IN(x)	0
+#define UHCI_OUT(x)
+#endif
+
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
 /* Support non-PCI host controllers */
-#ifdef CONFIG_USB_PCI
+#if defined(CONFIG_USB_PCI) && defined(HAS_IOPORT)
 /* Support PCI and non-PCI host controllers */
 #define uhci_has_pci_registers(u)	((u)->io_addr != 0)
 #else
@@ -587,7 +595,7 @@ static inline int uhci_aspeed_reg(unsigned int reg)
 static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		return inl(uhci->io_addr + reg);
+		return UHCI_IN(inl(uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		return readl(uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -601,7 +609,7 @@ static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
 static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		outl(val, uhci->io_addr + reg);
+		UHCI_OUT(outl(val, uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		writel(val, uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -615,7 +623,7 @@ static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int reg)
 static inline u16 uhci_readw(const struct uhci_hcd *uhci, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		return inw(uhci->io_addr + reg);
+		return UHCI_IN(inw(uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		return readl(uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -629,7 +637,7 @@ static inline u16 uhci_readw(const struct uhci_hcd *uhci, int reg)
 static inline void uhci_writew(const struct uhci_hcd *uhci, u16 val, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		outw(val, uhci->io_addr + reg);
+		UHCI_OUT(outw(val, uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		writel(val, uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -643,7 +651,7 @@ static inline void uhci_writew(const struct uhci_hcd *uhci, u16 val, int reg)
 static inline u8 uhci_readb(const struct uhci_hcd *uhci, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		return inb(uhci->io_addr + reg);
+		return UHCI_IN(inb(uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		return readl(uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -657,7 +665,7 @@ static inline u8 uhci_readb(const struct uhci_hcd *uhci, int reg)
 static inline void uhci_writeb(const struct uhci_hcd *uhci, u8 val, int reg)
 {
 	if (uhci_has_pci_registers(uhci))
-		outb(val, uhci->io_addr + reg);
+		UHCI_OUT(outb(val, uhci->io_addr + reg));
 	else if (uhci_is_aspeed(uhci))
 		writel(val, uhci->regs + uhci_aspeed_reg(reg));
 #ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
@@ -668,6 +676,8 @@ static inline void uhci_writeb(const struct uhci_hcd *uhci, u8 val, int reg)
 		writeb(val, uhci->regs + reg);
 }
 #endif /* CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC */
+#undef UHCI_IN
+#undef UHCI_OUT
 
 /*
  * The GRLIB GRUSBHC controller can use big endian format for its descriptors.
-- 
2.37.2

