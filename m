Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E735370BACA
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjEVKyj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjEVKwi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 06:52:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7882BED;
        Mon, 22 May 2023 03:51:40 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MAMIq3004248;
        Mon, 22 May 2023 10:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5XbgjERtvad8A4tK7KgGQSkrC6CWNWduyLUB4fuD1to=;
 b=OwgdDOEYg2HQ4g69vlsOqByeEL/cTgSAyRgFyWr8JIu7wUqWVPJ82+FRiwIhzsfZUEhl
 wIZe/uRIvSNAVWlhe2AnL/EHq/fjpnk3DS8+knJDONzY1Mf3yPyb0EkI1ccv4YeH+MRr
 GTrcrl6YgJ4+fB5FlsVWV2Ny2zSidnSCIR08aIQMa1XfLd8lhxM356DHJ/lxO1rVw8fv
 cVYpWi/aBOHh7brugXKAsfHRkslSPDRha/Dph3mwufWWY22vuc6CKj4KeH8HpcFkHZfM
 dYmhPR21rLHwVZYSygZwHjg5MjKNTaIPnIff5HVkfofSjuRwMulAFEi5RrcKkcDMlaZ2 ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqfq39r3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:29 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M9muRX001159;
        Mon, 22 May 2023 10:51:28 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqfq39r33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:28 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M5UeMS016883;
        Mon, 22 May 2023 10:51:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qppe08rka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:51:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MApNTd21693082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 10:51:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFF9320043;
        Mon, 22 May 2023 10:51:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E39620040;
        Mon, 22 May 2023 10:51:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 10:51:23 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Subject: [PATCH v5 37/44] usb: uhci: handle HAS_IOPORT dependencies
Date:   Mon, 22 May 2023 12:50:42 +0200
Message-Id: <20230522105049.1467313-38-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522105049.1467313-1-schnelle@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ViFHFxaVvxN8T78mXHHfyXTZ-SSlXdkH
X-Proofpoint-GUID: g47EuQj9DrP0EAAB9ywkpXEK14NAfNDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=464
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to guard sections of code calling them
as alternative access methods with CONFIG_HAS_IOPORT checks. For
uhci-hcd there are a lot of I/O port uses that do have MMIO alternatives
all selected by uhci_has_pci_registers() so this can be handled by
UHCI_IN/OUT macros and making uhci_has_pci_registers() constant 0 if
CONFIG_HAS_IOPORT is unset.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/usb/host/uhci-hcd.c |  2 +-
 drivers/usb/host/uhci-hcd.h | 24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 8 deletions(-)

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
index 0688c3e5bfe2..13ee2a6144b2 100644
--- a/drivers/usb/host/uhci-hcd.h
+++ b/drivers/usb/host/uhci-hcd.h
@@ -505,6 +505,14 @@ static inline bool uhci_is_aspeed(const struct uhci_hcd *uhci)
  * we use memory mapped registers.
  */
 
+#ifdef CONFIG_HAS_IOPORT
+#define UHCI_IN(x)	x
+#define UHCI_OUT(x)	x
+#else
+#define UHCI_IN(x)	0
+#define UHCI_OUT(x)	do { } while (0)
+#endif
+
 #ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
 /* Support PCI only */
 static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
@@ -539,7 +547,7 @@ static inline void uhci_writeb(const struct uhci_hcd *uhci, u8 val, int reg)
 
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
2.39.2

