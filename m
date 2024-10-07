Return-Path: <linux-arch+bounces-7759-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9A0992A82
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 13:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8262840F7
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8211B1D2F7E;
	Mon,  7 Oct 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iRYNE10A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FD1D2F6A;
	Mon,  7 Oct 2024 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301339; cv=none; b=Cgqs9fxAc+znKPGH+gd3/Iz2OG0szAf2swsfODDmIVL+Bp7CLuSCJPt6otOFitXFTEJR1kWpk0xm987WYLwkK80noGVb/fOdgUbSkKRT1MDNQuvNnM5Ab83/53is4icbrQQIa6+BQSSwxjLckHK1GVzDsRh1wYPaGTLvsVM2OZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301339; c=relaxed/simple;
	bh=xeuA4e3USzFzUnAEIRz6OTlzMDYWaJUIItfJk0b+5lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oy9f3Bgoul/uMZNcoGlpOss4myJBK0J/WDO3fxxx0iCbHeqG560icZ8JKykNDvfQg70CUO9yTtqECaxWxtZ6jfLimmkNSctfdU7IMQqWs36YNCyGl9z2ezg0PvkxHN+UewEcQrj0saIg61nuOJcKExhz8ffNZmqcfk+rFx+jF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iRYNE10A; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497BIMwh007396;
	Mon, 7 Oct 2024 11:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=pp1; bh=/REcM9slDlKOrBjKM+VYIzbggaJnZwqyiNIy6ZN+lC4=; b=i
	RYNE10ARJcoKUpcLMkcvXg2/cVfa2Iquo91wa7eY1LiIwQWB+t/xtpWKyg1igUfK
	dAysrDfdrfpbIgrTY18pvZV8uNwpOIu3m1QgRP6XHD/R3BwnFe8uzI5C3xiAQ+rx
	Bzw2Qi6qmUcmUW58Kl5cuW3Zw4rtQIX3OmqwL+D5miceYeUZc9mB8u0IQAdqZwjL
	Pus0fdKNzmZerdCN7amj8iAdBuzpwiV6ZjkTLEHHd4jKwDkbptT+T7Ic5uQfAurf
	p6LiCBuMXx3KdXGlmIGc4y92aqnFT2YSib/TB5oM3beB+Lov7G3nid7e2xkQEXnV
	z47AcqZRc+2p4A3MbF8JA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424enc8646-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497Bfv18009596;
	Mon, 7 Oct 2024 11:41:58 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424enc8641-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4979J7Ph022855;
	Mon, 7 Oct 2024 11:41:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0nycm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 11:41:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 497Bfte635717556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 11:41:56 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC33958050;
	Mon,  7 Oct 2024 11:41:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F94558045;
	Mon,  7 Oct 2024 11:41:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Oct 2024 11:41:50 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 07 Oct 2024 13:40:22 +0200
Subject: [PATCH v6 4/5] tty: serial: handle HAS_IOPORT dependencies
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-b4-has_ioport-v6-4-03f7240da6e5@linux.ibm.com>
References: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com>
In-Reply-To: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com>
To: Brian Cain <bcain@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-serial@vger.kernel.org,
        linux-arch@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15170;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=xeuA4e3USzFzUnAEIRz6OTlzMDYWaJUIItfJk0b+5lY=;
 b=kA0DAAoW+x9tocCJ5FYByyZiAGcDyNygttnouuXZkWLvfP/wh+ITM08zI4WluNoWrnsUS3rlL
 oh1BAAWCgAdFiEEoopDTq5wlDW8Uo+I+x9tocCJ5FYFAmcDyNwACgkQ+x9tocCJ5FYrqgD/fOzX
 UzsG5hwqKgNooEnFidixMmEkaGtFN8JxYKS1AGUBAIMTMhK2PKzmhAXMlsIdZZZ7q5UgpBAAWtu
 p/qM/SP0D
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QTNANkjtddkq3JVvv82WD0yeB01b8ME5
X-Proofpoint-GUID: fsk1i8SzPcVJ_ieQjYTwoWN3sQnZgRZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_02,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070081

In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
compile time. We thus need to add HAS_IOPORT as dependency for those
drivers using them unconditionally. Some 8250 serial drivers support
MMIO only use, so fence only the parts requiring I/O ports and print an
error message if a device can't be supported with the current
configuration.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/tty/Kconfig                   |  4 +--
 drivers/tty/serial/8250/8250_early.c  |  4 +++
 drivers/tty/serial/8250/8250_pci.c    | 49 ++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/8250/8250_pcilib.c |  4 +++
 drivers/tty/serial/8250/8250_port.c   | 47 ++++++++++++++++++++++++++-------
 drivers/tty/serial/8250/Kconfig       |  4 +--
 drivers/tty/serial/Kconfig            |  2 +-
 7 files changed, 98 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index a45d423ad10f02c3a818021bbb18655a8b690500..63a494d36a1fdceba5a7b39f4516060e48af0cc6 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -220,7 +220,7 @@ config MOXA_INTELLIO
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support v. 2.0"
-	depends on SERIAL_NONSTANDARD && PCI
+	depends on SERIAL_NONSTANDARD && PCI && HAS_IOPORT
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
 	  want to help develop a new version of this driver.
@@ -302,7 +302,7 @@ config GOLDFISH_TTY_EARLY_CONSOLE
 
 config IPWIRELESS
 	tristate "IPWireless 3G UMTS PCMCIA card support"
-	depends on PCMCIA && NETDEVICES
+	depends on PCMCIA && NETDEVICES && HAS_IOPORT
 	select PPP
 	help
 	  This is a driver for 3G UMTS PCMCIA card from IPWireless company. In
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 6176083d0341ca10edebe5c4eebfffc922a61472..84242292176570cd2c92afbd4755d303827a4abc 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -46,8 +46,10 @@ static unsigned int serial8250_early_in(struct uart_port *port, int offset)
 		return readl(port->membase + offset);
 	case UPIO_MEM32BE:
 		return ioread32be(port->membase + offset);
+#ifdef CONFIG_HAS_IOPORT
 	case UPIO_PORT:
 		return inb(port->iobase + offset);
+#endif
 	default:
 		return 0;
 	}
@@ -70,9 +72,11 @@ static void serial8250_early_out(struct uart_port *port, int offset, int value)
 	case UPIO_MEM32BE:
 		iowrite32be(value, port->membase + offset);
 		break;
+#ifdef CONFIG_HAS_IOPORT
 	case UPIO_PORT:
 		outb(value, port->iobase + offset);
 		break;
+#endif
 	}
 }
 
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6709b6a5f3011db38acc58dc7223158fe4fcf72e..6a638feb44e443a1998980dd037748f227ec1bc8 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -156,6 +156,14 @@ static const struct pci_device_id pci_use_msi[] = {
 static int pci_default_setup(struct serial_private*,
 	  const struct pciserial_board*, struct uart_8250_port *, int);
 
+static int serial_8250_need_ioport(struct pci_dev *dev)
+{
+	dev_warn(&dev->dev,
+		 "Serial port not supported because of missing I/O resource\n");
+
+	return -ENXIO;
+}
+
 static void moan_device(const char *str, struct pci_dev *dev)
 {
 	pci_err(dev, "%s\n"
@@ -964,6 +972,9 @@ static int pci_ite887x_init(struct pci_dev *dev)
 	struct resource *iobase = NULL;
 	u32 miscr, uartbar, ioport;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
+
 	/* search for the base-ioport */
 	for (i = 0; i < ARRAY_SIZE(inta_addr); i++) {
 		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE,
@@ -1514,6 +1525,9 @@ static int pci_quatech_init(struct pci_dev *dev)
 	const struct pci_device_id *match;
 	bool amcc = false;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
+
 	match = pci_match_id(quatech_cards, dev);
 	if (match)
 		amcc = match->driver_data;
@@ -1538,6 +1552,9 @@ static int pci_quatech_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
 		  struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(priv->dev);
+
 	/* Needed by pci_quatech calls below */
 	port->port.iobase = pci_resource_start(priv->dev, FL_GET_BASE(board->flags));
 	/* Set up the clocking */
@@ -1655,6 +1672,9 @@ static int pci_fintek_setup(struct serial_private *priv,
 	u8 config_base;
 	u16 iobase;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(pdev);
+
 	config_base = 0x40 + 0x08 * idx;
 
 	/* Get the io address from configuration space */
@@ -1686,6 +1706,9 @@ static int pci_fintek_init(struct pci_dev *dev)
 	u8 config_base;
 	struct serial_private *priv = pci_get_drvdata(dev);
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
+
 	if (!(pci_resource_flags(dev, 5) & IORESOURCE_IO) ||
 			!(pci_resource_flags(dev, 4) & IORESOURCE_IO) ||
 			!(pci_resource_flags(dev, 3) & IORESOURCE_IO))
@@ -1864,6 +1887,9 @@ static int kt_serial_setup(struct serial_private *priv,
 			   const struct pciserial_board *board,
 			   struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(priv->dev);
+
 	port->port.flags |= UPF_BUG_THRE;
 	port->port.serial_in = kt_serial_in;
 	port->port.handle_break = kt_handle_break;
@@ -1884,6 +1910,9 @@ pci_wch_ch353_setup(struct serial_private *priv,
 		    const struct pciserial_board *board,
 		    struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(priv->dev);
+
 	port->port.flags |= UPF_FIXED_TYPE;
 	port->port.type = PORT_16550A;
 	return pci_default_setup(priv, board, port, idx);
@@ -1894,6 +1923,9 @@ pci_wch_ch355_setup(struct serial_private *priv,
 		const struct pciserial_board *board,
 		struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(priv->dev);
+
 	port->port.flags |= UPF_FIXED_TYPE;
 	port->port.type = PORT_16550A;
 	return pci_default_setup(priv, board, port, idx);
@@ -1904,6 +1936,9 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 		    const struct pciserial_board *board,
 		    struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(priv->dev);
+
 	port->port.flags |= UPF_FIXED_TYPE;
 	port->port.type = PORT_16850;
 	return pci_default_setup(priv, board, port, idx);
@@ -1918,6 +1953,8 @@ static int pci_wch_ch38x_init(struct pci_dev *dev)
 	int max_port;
 	unsigned long iobase;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
 
 	switch (dev->device) {
 	case 0x3853: /* 8 ports */
@@ -1937,11 +1974,15 @@ static void pci_wch_ch38x_exit(struct pci_dev *dev)
 {
 	unsigned long iobase;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
+		serial_8250_need_ioport(dev);
+		return;
+	}
+
 	iobase = pci_resource_start(dev, 0);
 	outb(0x0, iobase + CH384_XINT_ENABLE_REG);
 }
 
-
 static int
 pci_sunix_setup(struct serial_private *priv,
 		const struct pciserial_board *board,
@@ -2052,6 +2093,9 @@ static int pci_moxa_init(struct pci_dev *dev)
 	unsigned int i, num_ports = moxa_get_nports(device);
 	u8 val, init_mode = MOXA_RS232;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(dev);
+
 	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
 		init_mode = MOXA_RS422;
 	}
@@ -2084,6 +2128,9 @@ pci_moxa_setup(struct serial_private *priv,
 	unsigned int bar = FL_GET_BASE(board->flags);
 	int offset;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_need_ioport(priv->dev);
+
 	if (board->num_ports == 4 && idx == 3)
 		offset = 7 * board->uart_offset;
 	else
diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
index ea906d721b2c3eac15c9e8d62cc6fa56c3ef6150..fc1882d7515b5814ff1240ffdbe1009ab908ad6b 100644
--- a/drivers/tty/serial/8250/8250_pcilib.c
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -28,6 +28,10 @@ int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
 		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
 		port->port.regshift = regshift;
 	} else {
+		if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
+			pr_err("Serial port %lx requires I/O port support\n", port->port.iobase);
+			return -EINVAL;
+		}
 		port->port.iotype = UPIO_PORT;
 		port->port.iobase = pci_resource_start(dev, bar) + offset;
 		port->port.mapbase = 0;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3509af7dc52b8816f2f5ab58f0d999696f7483e7..74717675dc41db6a5b5b0dd1da84b4ea23bd9928 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -338,6 +338,7 @@ static void default_serial_dl_write(struct uart_8250_port *up, u32 value)
 	serial_out(up, UART_DLM, value >> 8 & 0xff);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static unsigned int hub6_serial_in(struct uart_port *p, int offset)
 {
 	offset = offset << p->regshift;
@@ -351,6 +352,7 @@ static void hub6_serial_out(struct uart_port *p, int offset, int value)
 	outb(p->hub6 - 1 + offset, p->iobase);
 	outb(value, p->iobase + 1);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static unsigned int mem_serial_in(struct uart_port *p, int offset)
 {
@@ -400,6 +402,7 @@ static unsigned int mem32be_serial_in(struct uart_port *p, int offset)
 	return ioread32be(p->membase + offset);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static unsigned int io_serial_in(struct uart_port *p, int offset)
 {
 	offset = offset << p->regshift;
@@ -411,6 +414,23 @@ static void io_serial_out(struct uart_port *p, int offset, int value)
 	offset = offset << p->regshift;
 	outb(value, p->iobase + offset);
 }
+#endif
+static unsigned int no_serial_in(struct uart_port *p, int offset)
+{
+	return (unsigned int)-1;
+}
+
+static void no_serial_out(struct uart_port *p, int offset, int value)
+{
+}
+
+static __always_inline bool is_upf_fourport(struct uart_port *port)
+{
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return false;
+
+	return port->flags & UPF_FOURPORT;
+}
 
 static int serial8250_default_handle_irq(struct uart_port *port);
 
@@ -422,10 +442,12 @@ static void set_io_from_upio(struct uart_port *p)
 	up->dl_write = default_serial_dl_write;
 
 	switch (p->iotype) {
+#ifdef CONFIG_HAS_IOPORT
 	case UPIO_HUB6:
 		p->serial_in = hub6_serial_in;
 		p->serial_out = hub6_serial_out;
 		break;
+#endif
 
 	case UPIO_MEM:
 		p->serial_in = mem_serial_in;
@@ -446,11 +468,16 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_in = mem32be_serial_in;
 		p->serial_out = mem32be_serial_out;
 		break;
-
-	default:
+#ifdef CONFIG_HAS_IOPORT
+	case UPIO_PORT:
 		p->serial_in = io_serial_in;
 		p->serial_out = io_serial_out;
 		break;
+#endif
+	default:
+		WARN(1, "Unsupported UART type %x\n", p->iotype);
+		p->serial_in = no_serial_in;
+		p->serial_out = no_serial_out;
 	}
 	/* Remember loaded iotype */
 	up->cur_iotype = p->iotype;
@@ -1174,7 +1201,7 @@ static void autoconfig(struct uart_8250_port *up)
 		 */
 		scratch = serial_in(up, UART_IER);
 		serial_out(up, UART_IER, 0);
-#ifdef __i386__
+#if defined(__i386__) && defined(CONFIG_HAS_IOPORT)
 		outb(0xff, 0x080);
 #endif
 		/*
@@ -1183,7 +1210,7 @@ static void autoconfig(struct uart_8250_port *up)
 		 */
 		scratch2 = serial_in(up, UART_IER) & UART_IER_ALL_INTR;
 		serial_out(up, UART_IER, UART_IER_ALL_INTR);
-#ifdef __i386__
+#if defined(__i386__) && defined(CONFIG_HAS_IOPORT)
 		outb(0, 0x080);
 #endif
 		scratch3 = serial_in(up, UART_IER) & UART_IER_ALL_INTR;
@@ -1306,12 +1333,12 @@ static void autoconfig_irq(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
 	unsigned char save_mcr, save_ier;
+	unsigned long irqs;
 	unsigned char save_ICP = 0;
 	unsigned int ICP = 0;
-	unsigned long irqs;
 	int irq;
 
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		ICP = (port->iobase & 0xfe0) | 0x1f;
 		save_ICP = inb_p(ICP);
 		outb_p(0x80, ICP);
@@ -1330,7 +1357,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	irqs = probe_irq_on();
 	serial8250_out_MCR(up, 0);
 	udelay(10);
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
 	} else {
 		serial8250_out_MCR(up,
@@ -1354,7 +1381,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	serial_out(up, UART_IER, save_ier);
 	uart_port_unlock_irq(port);
 
-	if (port->flags & UPF_FOURPORT)
+	if (is_upf_fourport(port))
 		outb_p(save_ICP, ICP);
 
 	port->irq = (irq > 0) ? irq : 0;
@@ -2435,7 +2462,7 @@ int serial8250_do_startup(struct uart_port *port)
 	 */
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
 
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		unsigned int icp;
 		/*
 		 * Enable interrupts on the AST Fourport board
@@ -2480,7 +2507,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 		serial8250_release_dma(up);
 
 	uart_port_lock_irqsave(port, &flags);
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		/* reset interrupts on the AST Fourport board */
 		inb((port->iobase & 0xfe0) | 0x1f);
 		port->mctrl |= TIOCM_OUT1;
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 47ff50763c048c89b19b7c9f13f462bc5368ab43..1eb20350fcf432d41cb416bed3be72ed8ab129bb 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -72,7 +72,7 @@ config SERIAL_8250_16550A_VARIANTS
 
 config SERIAL_8250_FINTEK
 	bool "Support for Fintek variants"
-	depends on SERIAL_8250
+	depends on SERIAL_8250 && HAS_IOPORT
 	help
 	  Selecting this option will add support for the RS232 and RS485
 	  capabilities of the Fintek F81216A LPC to 4 UART as well similar
@@ -163,7 +163,7 @@ config SERIAL_8250_HP300
 
 config SERIAL_8250_CS
 	tristate "8250/16550 PCMCIA device support"
-	depends on PCMCIA && SERIAL_8250
+	depends on PCMCIA && SERIAL_8250 && HAS_IOPORT
 	help
 	  Say Y here to enable support for 16-bit PCMCIA serial devices,
 	  including serial port cards, modems, and the modem functions of
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 28e4beeabf8f373fc76e09ea7d1c9d55a66f4964..45f0f779fbf960e9fa66375dbc44c379edc63bef 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -877,7 +877,7 @@ config SERIAL_TXX9_STDSERIAL
 
 config SERIAL_JSM
 	tristate "Digi International NEO and Classic PCI Support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select SERIAL_CORE
 	help
 	  This is a driver for Digi International's Neo and Classic series

-- 
2.43.0


