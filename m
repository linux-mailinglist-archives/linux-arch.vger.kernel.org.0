Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45425704C40
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 13:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjEPLXF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 07:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjEPLXE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 07:23:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540C6A9;
        Tue, 16 May 2023 04:22:48 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GB4U9k030858;
        Tue, 16 May 2023 11:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k1lr2gkx2EG7llhCOzfRkPYbbk1LM9LiZTc9+G/8hFg=;
 b=Gx0h2vG/4jUKpz7lJWROJQ2moEwGeFSPj/HZk0w0SLLRknImLl0ynhFGX4uDQafoehl6
 M0mKp5WfSwb7Nn5zD9RQg1sQnmpvUOBVk+7RLL8ohEzycUHCgkTIx7CUHs2yguW9x4K8
 jHKQUfEaC/7spLYmUf3zyclLlu+Pj7fTn8Y3mcMgnHA31wTtEPHNQrDuQLrPO6jxJagw
 at2xnIhBw8YlIPlArbTCRsjL0JkgJq+/C9tN4hB2I9le2YhP11j9dKc9VNZO37Qw9bzP
 pfBuVni9bBDzrF6g5uq0brfDxK3gVtSjMnhMw9LDpQShwMQxZg1kloj3D1QXFFRP4Kk+ gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm82f0t88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:05:42 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34GB4xdW002085;
        Tue, 16 May 2023 11:05:07 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm82f0pt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:05:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G36MH5019561;
        Tue, 16 May 2023 11:01:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qj264sjvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:01:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GB1BjH30146816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 11:01:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FBA32004E;
        Tue, 16 May 2023 11:01:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E332B2004D;
        Tue, 16 May 2023 11:01:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 16 May 2023 11:01:10 +0000 (GMT)
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
Subject: [PATCH v4 35/41] usb: uhci: handle HAS_IOPORT dependencies
Date:   Tue, 16 May 2023 13:00:31 +0200
Message-Id: <20230516110038.2413224-36-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516110038.2413224-1-schnelle@linux.ibm.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WJu3W9w7VBhxXeFU00kPI5t0x556P1nr
X-Proofpoint-ORIG-GUID: DNZTFNG-K6-B0c13-rs-mTZTz4QU1LYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_04,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=610 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160094
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
Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
      per-subsystem patches may be applied independently

 drivers/usb/host/uhci-hcd.c |  2 +-
 drivers/usb/host/uhci-hcd.h | 36 +++++++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 14 deletions(-)

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
2.39.2

