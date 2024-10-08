Return-Path: <linux-arch+bounces-7838-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFFE994B51
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 14:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E60B288D54
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244621DF966;
	Tue,  8 Oct 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OTUkFRPo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB011CCB32;
	Tue,  8 Oct 2024 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391274; cv=none; b=Wyxsl52C5Mn2z0fjWFAXtmFtR2JXnUClpCXcuP6ir2lqRKGIRx7VZqPmxRkcCewO+0ekvziNByy1xlaKkAwYi1OZ2qc1yJSKYBL2d6ECVgkDFG7Kj5zzfn36lGO+7103GU8CKgeZDuUJmZoWUc/t6pGBI5RmNN2HBg2kAzTHlVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391274; c=relaxed/simple;
	bh=CePD+I57FUUUjfg30D6BMnhitYkO+w2RZAgWLhINGws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JiqK4YR5rxQDaUezIJ+HvqNJhhK4e53XOdisn2svtKjlyaQkTMj+py91Dv2WwF5EjALx9MlUPdIBUOE+Vu/w0muX49nGXcmJlQ0LfkWOwpwDCX+qwgOMb7gB6rwdfzGb+2ggtqo4C/ZSdOYzZhY8Y2F0qfuqXO/2iVWnuLcoN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OTUkFRPo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Anb7W003567;
	Tue, 8 Oct 2024 12:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=pp1; bh=FXiniWAvse76RkbISD8dhI8vxCqgiitHfoLpLZbJI7E=; b=O
	TUkFRPoja/wLMnuQdoEU+f/9g7PTu67XTPOfGVTEZbuyFZJKK9liYo8YnIB91j0Z
	BB1dCd1XpkyyoqVX9tQr6ZocMErxVV1c4ezWtOJDkmgPGjv73tXt+bEP85GvQCxl
	LpVH5dQVIy1/6bZITckmSPTo4bUQER8SIWvhuVLq0JHTU4MWFRJ2FQE5tlLKMBRY
	BvU5uBBX9gD3F1fVCrk965aXtI715rL/EczK2Cty0XQzTJu8W5+ix0NuBFcvEaox
	CCVvU0UFTAWhbccbpnTNhqIRdXAA9QmydRCSOX3OEB2Z89b76gg0amkz0yz9ye1b
	P564biD6JQB8ZVXuG6AFA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axrk2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498CerBa005911;
	Tue, 8 Oct 2024 12:40:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axrk2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4989r8ol022844;
	Tue, 8 Oct 2024 12:40:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9jv4yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:40:51 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498Ceoki42140102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 12:40:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 341C35805C;
	Tue,  8 Oct 2024 12:40:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 133F45805A;
	Tue,  8 Oct 2024 12:40:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 12:40:44 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 08 Oct 2024 14:39:45 +0200
Subject: [PATCH v8 4/5] tty: serial: handle HAS_IOPORT dependencies
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-b4-has_ioport-v8-4-793e68aeadda@linux.ibm.com>
References: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
In-Reply-To: <20241008-b4-has_ioport-v8-0-793e68aeadda@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14664;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=CePD+I57FUUUjfg30D6BMnhitYkO+w2RZAgWLhINGws=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNJZNbQ/hNSLz2n9buafs89/85GcCNYaHpvtNr53GZ4s1
 FEWa5LvKGVhEONikBVTZFnU5ey3rmCK6Z6g/g6YOaxMIEMYuDgFYCLlUxn+Smb8Wd8QWc13V/LB
 Vqu/gUrxU3jOLbiwsVZtjvuKud5FnIwMC3R1Qlf6ZCo+Nuad2tJ7ZepLdYc/pxglavw+F8y4sDa
 ACwA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hvM8YTlQFPLBfIulMD69I-MWBob9JPMY
X-Proofpoint-GUID: VOblZV1NR_DqbDUxA5Kbl0p2kieArSlZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_10,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080078

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
 drivers/tty/Kconfig                   |  4 ++--
 drivers/tty/serial/8250/8250_early.c  |  4 ++++
 drivers/tty/serial/8250/8250_pci.c    | 40 +++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.c | 12 ++++++++++-
 drivers/tty/serial/8250/8250_pcilib.h |  2 ++
 drivers/tty/serial/8250/8250_port.c   | 27 +++++++++++++++++++----
 drivers/tty/serial/8250/Kconfig       |  4 ++--
 drivers/tty/serial/Kconfig            |  2 +-
 include/linux/serial_core.h           |  4 ++++
 9 files changed, 89 insertions(+), 10 deletions(-)

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
index 6709b6a5f3011db38acc58dc7223158fe4fcf72e..7d7a6d62c09ceabcf4094d539c565ed09c153561 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -964,6 +964,9 @@ static int pci_ite887x_init(struct pci_dev *dev)
 	struct resource *iobase = NULL;
 	u32 miscr, uartbar, ioport;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(dev);
+
 	/* search for the base-ioport */
 	for (i = 0; i < ARRAY_SIZE(inta_addr); i++) {
 		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE,
@@ -1514,6 +1517,9 @@ static int pci_quatech_init(struct pci_dev *dev)
 	const struct pci_device_id *match;
 	bool amcc = false;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(dev);
+
 	match = pci_match_id(quatech_cards, dev);
 	if (match)
 		amcc = match->driver_data;
@@ -1538,6 +1544,9 @@ static int pci_quatech_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
 		  struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(priv->dev);
+
 	/* Needed by pci_quatech calls below */
 	port->port.iobase = pci_resource_start(priv->dev, FL_GET_BASE(board->flags));
 	/* Set up the clocking */
@@ -1655,6 +1664,9 @@ static int pci_fintek_setup(struct serial_private *priv,
 	u8 config_base;
 	u16 iobase;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(pdev);
+
 	config_base = 0x40 + 0x08 * idx;
 
 	/* Get the io address from configuration space */
@@ -1686,6 +1698,9 @@ static int pci_fintek_init(struct pci_dev *dev)
 	u8 config_base;
 	struct serial_private *priv = pci_get_drvdata(dev);
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(dev);
+
 	if (!(pci_resource_flags(dev, 5) & IORESOURCE_IO) ||
 			!(pci_resource_flags(dev, 4) & IORESOURCE_IO) ||
 			!(pci_resource_flags(dev, 3) & IORESOURCE_IO))
@@ -1864,6 +1879,9 @@ static int kt_serial_setup(struct serial_private *priv,
 			   const struct pciserial_board *board,
 			   struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(priv->dev);
+
 	port->port.flags |= UPF_BUG_THRE;
 	port->port.serial_in = kt_serial_in;
 	port->port.handle_break = kt_handle_break;
@@ -1884,6 +1902,9 @@ pci_wch_ch353_setup(struct serial_private *priv,
 		    const struct pciserial_board *board,
 		    struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(priv->dev);
+
 	port->port.flags |= UPF_FIXED_TYPE;
 	port->port.type = PORT_16550A;
 	return pci_default_setup(priv, board, port, idx);
@@ -1894,6 +1915,9 @@ pci_wch_ch355_setup(struct serial_private *priv,
 		const struct pciserial_board *board,
 		struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(priv->dev);
+
 	port->port.flags |= UPF_FIXED_TYPE;
 	port->port.type = PORT_16550A;
 	return pci_default_setup(priv, board, port, idx);
@@ -1904,6 +1928,9 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 		    const struct pciserial_board *board,
 		    struct uart_8250_port *port, int idx)
 {
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(priv->dev);
+
 	port->port.flags |= UPF_FIXED_TYPE;
 	port->port.type = PORT_16850;
 	return pci_default_setup(priv, board, port, idx);
@@ -1918,6 +1945,8 @@ static int pci_wch_ch38x_init(struct pci_dev *dev)
 	int max_port;
 	unsigned long iobase;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(dev);
 
 	switch (dev->device) {
 	case 0x3853: /* 8 ports */
@@ -1937,6 +1966,11 @@ static void pci_wch_ch38x_exit(struct pci_dev *dev)
 {
 	unsigned long iobase;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
+		serial_8250_warn_need_ioport(dev);
+		return;
+	}
+
 	iobase = pci_resource_start(dev, 0);
 	outb(0x0, iobase + CH384_XINT_ENABLE_REG);
 }
@@ -2052,6 +2086,9 @@ static int pci_moxa_init(struct pci_dev *dev)
 	unsigned int i, num_ports = moxa_get_nports(device);
 	u8 val, init_mode = MOXA_RS232;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(dev);
+
 	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
 		init_mode = MOXA_RS422;
 	}
@@ -2084,6 +2121,9 @@ pci_moxa_setup(struct serial_private *priv,
 	unsigned int bar = FL_GET_BASE(board->flags);
 	int offset;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		return serial_8250_warn_need_ioport(priv->dev);
+
 	if (board->num_ports == 4 && idx == 3)
 		offset = 7 * board->uart_offset;
 	else
diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
index ea906d721b2c3eac15c9e8d62cc6fa56c3ef6150..ec4d041778027a0c9f27facbb97c2b74819cfda3 100644
--- a/drivers/tty/serial/8250/8250_pcilib.c
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -12,6 +12,14 @@
 #include "8250.h"
 #include "8250_pcilib.h"
 
+int serial_8250_warn_need_ioport(struct pci_dev *dev)
+{
+	dev_warn(&dev->dev,
+		 "Serial port not supported because of missing I/O resource\n");
+
+	return -ENXIO;
+}
+
 int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
 		   u8 bar, unsigned int offset, int regshift)
 {
@@ -27,12 +35,14 @@ int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
 		port->port.mapbase = pci_resource_start(dev, bar) + offset;
 		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
 		port->port.regshift = regshift;
-	} else {
+	} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
 		port->port.iotype = UPIO_PORT;
 		port->port.iobase = pci_resource_start(dev, bar) + offset;
 		port->port.mapbase = 0;
 		port->port.membase = NULL;
 		port->port.regshift = 0;
+	} else {
+		return serial_8250_warn_need_ioport(dev);
 	}
 	return 0;
 }
diff --git a/drivers/tty/serial/8250/8250_pcilib.h b/drivers/tty/serial/8250/8250_pcilib.h
index 1aaf1b50ce9cc9d78c098e0495838c17eb8752cd..16a274574cdef938fe7700d30b19e75dbbd9b748 100644
--- a/drivers/tty/serial/8250/8250_pcilib.h
+++ b/drivers/tty/serial/8250/8250_pcilib.h
@@ -13,3 +13,5 @@ struct uart_8250_port;
 
 int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port, u8 bar,
 		   unsigned int offset, int regshift);
+
+int serial_8250_warn_need_ioport(struct pci_dev *dev);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3509af7dc52b8816f2f5ab58f0d999696f7483e7..91369f542b0bc7fc1d044f24db9a4ac98b394660 100644
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
@@ -411,6 +414,15 @@ static void io_serial_out(struct uart_port *p, int offset, int value)
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
 
 static int serial8250_default_handle_irq(struct uart_port *port);
 
@@ -422,10 +434,12 @@ static void set_io_from_upio(struct uart_port *p)
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
@@ -446,11 +460,16 @@ static void set_io_from_upio(struct uart_port *p)
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
@@ -1174,7 +1193,7 @@ static void autoconfig(struct uart_8250_port *up)
 		 */
 		scratch = serial_in(up, UART_IER);
 		serial_out(up, UART_IER, 0);
-#ifdef __i386__
+#if defined(__i386__) && defined(CONFIG_HAS_IOPORT)
 		outb(0xff, 0x080);
 #endif
 		/*
@@ -1183,7 +1202,7 @@ static void autoconfig(struct uart_8250_port *up)
 		 */
 		scratch2 = serial_in(up, UART_IER) & UART_IER_ALL_INTR;
 		serial_out(up, UART_IER, UART_IER_ALL_INTR);
-#ifdef __i386__
+#if defined(__i386__) && defined(CONFIG_HAS_IOPORT)
 		outb(0, 0x080);
 #endif
 		scratch3 = serial_in(up, UART_IER) & UART_IER_ALL_INTR;
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
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4ab65874a850b4402ca3a7d3bdda597d7d5093f9..743b4afaad4c89a6028e592be2cae2643614c89b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -505,7 +505,11 @@ struct uart_port {
 	 * The remaining bits are serial-core specific and not modifiable by
 	 * userspace.
 	 */
+#ifdef CONFIG_HAS_IOPORT
 #define UPF_FOURPORT		((__force upf_t) ASYNC_FOURPORT       /* 1  */ )
+#else
+#define UPF_FOURPORT		0
+#endif
 #define UPF_SAK			((__force upf_t) ASYNC_SAK            /* 2  */ )
 #define UPF_SPD_HI		((__force upf_t) ASYNC_SPD_HI         /* 4  */ )
 #define UPF_SPD_VHI		((__force upf_t) ASYNC_SPD_VHI        /* 5  */ )

-- 
2.43.0


