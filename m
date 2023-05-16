Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6428704BF8
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 13:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjEPLLS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 07:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjEPLLD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 07:11:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967E2D8;
        Tue, 16 May 2023 04:09:53 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GB44eq006482;
        Tue, 16 May 2023 11:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Xnmp6X0qL0zeKYH38Xvfl6ZMW1/Auj5gq04lGrIhuYs=;
 b=YlkmCd7H5u0sgJ0X74Msc0g3bz+X+QmSM6w2BaWeGdcq2KotsdMr/JoDCb63or7niaXh
 nMpGm9Ov/D+SJqaS+VLhUxmWH6nIfUGLABQQVhQuQZUiAeumUtr2iNT82WAps1U0qwR/
 Kb4y4B+8tpyBedF+rJGsVF9jdzDzRHJI6sBN90qltifLz+WacTWJ37UHITUopGARAriI
 WlNIYeUmkvi76XawiSlx9ZAjKoCUWZh56AIVe6IuUulqGdRSichNwWoHbHgjJIKaONhL
 FltTdlagv98hhtZRDLvQ23Gzl05/xkAz+w0LjeoqBwIDQW6yGa/LnePI0ESBIuEasg87 Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm8mrrc6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:08:49 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34GB5gt2017876;
        Tue, 16 May 2023 11:07:01 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm8mrr7nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:07:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G1c0ip027917;
        Tue, 16 May 2023 11:01:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qj264sjvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 11:01:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GB19vt24445640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 11:01:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B675A20043;
        Tue, 16 May 2023 11:01:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 596E220040;
        Tue, 16 May 2023 11:01:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 16 May 2023 11:01:09 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH v4 33/41] tty: serial: handle HAS_IOPORT dependencies
Date:   Tue, 16 May 2023 13:00:29 +0200
Message-Id: <20230516110038.2413224-34-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516110038.2413224-1-schnelle@linux.ibm.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: biHOP2Q-2JiF04-XB4LVy_v4nFDt1Nw_
X-Proofpoint-GUID: H3GNej9JNcqM914NpYfwBLPvDlpiYJ9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_04,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
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
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them unconditionally. For 8250 based drivers some
support MMIO only use so fence only the parts requiring I/O ports.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
      per-subsystem patches may be applied independently

 drivers/tty/Kconfig                  |  4 +--
 drivers/tty/serial/8250/8250_early.c |  4 +++
 drivers/tty/serial/8250/8250_pci.c   | 14 +++++++++
 drivers/tty/serial/8250/8250_port.c  | 44 +++++++++++++++++++++++-----
 drivers/tty/serial/8250/Kconfig      |  5 ++--
 drivers/tty/serial/Kconfig           |  2 +-
 6 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 341abaed4ce2..bdd267dbd5e4 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -222,7 +222,7 @@ config MOXA_INTELLIO
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support v. 2.0"
-	depends on SERIAL_NONSTANDARD && PCI
+	depends on SERIAL_NONSTANDARD && PCI && HAS_IOPORT
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
 	  want to help develop a new version of this driver.
@@ -303,7 +303,7 @@ config GOLDFISH_TTY_EARLY_CONSOLE
 
 config IPWIRELESS
 	tristate "IPWireless 3G UMTS PCMCIA card support"
-	depends on PCMCIA && NETDEVICES
+	depends on PCMCIA && NETDEVICES && HAS_IOPORT
 	select PPP
 	help
 	  This is a driver for 3G UMTS PCMCIA card from IPWireless company. In
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 0ebde0ab8167..4192b1ae2736 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -48,8 +48,10 @@ static unsigned int serial8250_early_in(struct uart_port *port, int offset)
 		return readl(port->membase + offset);
 	case UPIO_MEM32BE:
 		return ioread32be(port->membase + offset);
+#ifdef CONFIG_HAS_IOPORT
 	case UPIO_PORT:
 		return inb(port->iobase + offset);
+#endif
 	case UPIO_AU:
 		return port->serial_in(port, reg_offset);
 	default:
@@ -75,9 +77,11 @@ static void serial8250_early_out(struct uart_port *port, int offset, int value)
 	case UPIO_MEM32BE:
 		iowrite32be(value, port->membase + offset);
 		break;
+#ifdef CONFIG_HAS_IOPORT
 	case UPIO_PORT:
 		outb(value, port->iobase + offset);
 		break;
+#endif
 	case UPIO_AU:
 		port->serial_out(port, reg_offset, value);
 		break;
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index c55be6fda0ca..70bd84a05da7 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -847,6 +847,7 @@ static int pci_netmos_init(struct pci_dev *dev)
 	return num_serial;
 }
 
+#ifdef CONFIG_HAS_IOPORT
 /*
  * These chips are available with optionally one parallel port and up to
  * two serial ports. Unfortunately they all have the same product id.
@@ -973,6 +974,7 @@ static void pci_ite887x_exit(struct pci_dev *dev)
 	ioport &= 0xffff;
 	release_region(ioport, ITE_887x_IOSIZE);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 /*
  * Oxford Semiconductor Inc.
@@ -1255,6 +1257,7 @@ static int pci_asix_setup(struct serial_private *priv,
 #define QOPR_CLOCK_X8		0x0003
 #define QOPR_CLOCK_RATE_MASK	0x0003
 
+#ifdef CONFIG_HAS_IOPORT
 /* Quatech devices have their own extra interface features */
 static struct pci_device_id quatech_cards[] = {
 	{ PCI_DEVICE_DATA(QUATECH, QSC100,   1) },
@@ -1474,6 +1477,7 @@ static int pci_quatech_setup(struct serial_private *priv,
 		pci_warn(priv->dev, "software control of RS422 features not currently supported.\n");
 	return pci_default_setup(priv, board, port, idx);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static int pci_default_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
@@ -1753,6 +1757,7 @@ static int skip_tx_en_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, port, idx);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static void kt_handle_break(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
@@ -1796,6 +1801,7 @@ static int kt_serial_setup(struct serial_private *priv,
 	port->port.handle_break = kt_handle_break;
 	return skip_tx_en_setup(priv, board, port, idx);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static int pci_eg20t_init(struct pci_dev *dev)
 {
@@ -1840,6 +1846,7 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 #define CH384_XINT_ENABLE_REG   0xEB
 #define CH384_XINT_ENABLE_BIT   0x02
 
+#ifdef CONFIG_HAS_IOPORT
 static int pci_wch_ch38x_init(struct pci_dev *dev)
 {
 	int max_port;
@@ -1867,6 +1874,7 @@ static void pci_wch_ch38x_exit(struct pci_dev *dev)
 	iobase = pci_resource_start(dev, 0);
 	outb(0x0, iobase + CH384_XINT_ENABLE_REG);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 
 static int
@@ -2070,6 +2078,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.subdevice	= PCI_ANY_ID,
 		.setup		= ce4100_serial_setup,
 	},
+#ifdef CONFIG_HAS_IOPORT
 	{
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_PATSBURG_KT,
@@ -2089,6 +2098,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.setup		= pci_default_setup,
 		.exit		= pci_ite887x_exit,
 	},
+#endif
 	/*
 	 * National Instruments
 	 */
@@ -2210,6 +2220,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.exit		= pci_ni8430_exit,
 	},
 	/* Quatech */
+#ifdef CONFIG_HAS_IOPORT
 	{
 		.vendor		= PCI_VENDOR_ID_QUATECH,
 		.device		= PCI_ANY_ID,
@@ -2218,6 +2229,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.init		= pci_quatech_init,
 		.setup		= pci_quatech_setup,
 	},
+#endif
 	/*
 	 * Panacom
 	 */
@@ -2588,6 +2600,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
+#ifdef CONFIG_HAS_IOPORT
 	/* WCH CH384 8S card (16850 clone) */
 	{
 		.vendor         = PCIE_VENDOR_ID_WCH,
@@ -2598,6 +2611,7 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.exit		= pci_wch_ch38x_exit,
 		.setup          = pci_wch_ch38x_setup,
 	},
+#endif
 	/*
 	 * ASIX devices with FIFO bug
 	 */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fe8d79c4ae95..8d8606dc763b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -401,6 +401,7 @@ static void au_serial_dl_write(struct uart_8250_port *up, int value)
 
 #endif
 
+#ifdef CONFIG_HAS_IOPORT
 static unsigned int hub6_serial_in(struct uart_port *p, int offset)
 {
 	offset = offset << p->regshift;
@@ -414,6 +415,7 @@ static void hub6_serial_out(struct uart_port *p, int offset, int value)
 	outb(p->hub6 - 1 + offset, p->iobase);
 	outb(value, p->iobase + 1);
 }
+#endif /* CONFIG_HAS_IOPORT */
 
 static unsigned int mem_serial_in(struct uart_port *p, int offset)
 {
@@ -463,6 +465,7 @@ static unsigned int mem32be_serial_in(struct uart_port *p, int offset)
 	return ioread32be(p->membase + offset);
 }
 
+#ifdef CONFIG_HAS_IOPORT
 static unsigned int io_serial_in(struct uart_port *p, int offset)
 {
 	offset = offset << p->regshift;
@@ -474,6 +477,24 @@ static void io_serial_out(struct uart_port *p, int offset, int value)
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
+#ifdef CONFIG_HAS_IOPORT
+static inline bool is_upf_fourport(struct uart_port *port)
+{
+	return port->flags & UPF_FOURPORT;
+}
+#else
+#define is_upf_fourport(x)	false
+#endif
 
 static int serial8250_default_handle_irq(struct uart_port *port);
 
@@ -485,10 +506,12 @@ static void set_io_from_upio(struct uart_port *p)
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
@@ -519,10 +542,17 @@ static void set_io_from_upio(struct uart_port *p)
 		break;
 #endif
 
-	default:
+#ifdef CONFIG_HAS_IOPORT
+	case UPIO_PORT:
 		p->serial_in = io_serial_in;
 		p->serial_out = io_serial_out;
 		break;
+#endif
+
+	default:
+		WARN(1, "Unsupported UART type %x\n", p->iotype);
+		p->serial_in = no_serial_in;
+		p->serial_out = no_serial_out;
 	}
 	/* Remember loaded iotype */
 	up->cur_iotype = p->iotype;
@@ -1379,7 +1409,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	unsigned long irqs;
 	int irq;
 
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		ICP = (port->iobase & 0xfe0) | 0x1f;
 		save_ICP = inb_p(ICP);
 		outb_p(0x80, ICP);
@@ -1398,7 +1428,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	irqs = probe_irq_on();
 	serial8250_out_MCR(up, 0);
 	udelay(10);
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
 	} else {
 		serial8250_out_MCR(up,
@@ -1416,7 +1446,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	serial8250_out_MCR(up, save_mcr);
 	serial_out(up, UART_IER, save_ier);
 
-	if (port->flags & UPF_FOURPORT)
+	if (is_upf_fourport(port))
 		outb_p(save_ICP, ICP);
 
 	if (uart_console(port))
@@ -2381,7 +2411,7 @@ int serial8250_do_startup(struct uart_port *port)
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (up->port.flags & UPF_FOURPORT) {
+	if (is_upf_fourport(&up->port)) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
 	} else
@@ -2463,7 +2493,7 @@ int serial8250_do_startup(struct uart_port *port)
 	 */
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
 
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		unsigned int icp;
 		/*
 		 * Enable interrupts on the AST Fourport board
@@ -2506,7 +2536,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 		serial8250_release_dma(up);
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (port->flags & UPF_FOURPORT) {
+	if (is_upf_fourport(port)) {
 		/* reset interrupts on the AST Fourport board */
 		inb((port->iobase & 0xfe0) | 0x1f);
 		port->mctrl |= TIOCM_OUT1;
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 5313aa31930f..2a43bea7d7c3 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -6,7 +6,6 @@
 
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
-	depends on !S390
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	help
@@ -72,7 +71,7 @@ config SERIAL_8250_16550A_VARIANTS
 
 config SERIAL_8250_FINTEK
 	bool "Support for Fintek F81216A LPC to 4 UART RS485 API"
-	depends on SERIAL_8250
+	depends on SERIAL_8250 && HAS_IOPORT
 	help
 	  Selecting this option will add support for the RS485 capabilities
 	  of the Fintek F81216A LPC to 4 UART.
@@ -160,7 +159,7 @@ config SERIAL_8250_HP300
 
 config SERIAL_8250_CS
 	tristate "8250/16550 PCMCIA device support"
-	depends on PCMCIA && SERIAL_8250
+	depends on PCMCIA && SERIAL_8250 && HAS_IOPORT
 	help
 	  Say Y here to enable support for 16-bit PCMCIA serial devices,
 	  including serial port cards, modems, and the modem functions of
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 398e5aac2e77..dc41b3be6800 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -871,7 +871,7 @@ config SERIAL_TXX9_STDSERIAL
 
 config SERIAL_JSM
 	tristate "Digi International NEO and Classic PCI Support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	select SERIAL_CORE
 	help
 	  This is a driver for Digi International's Neo and Classic series
-- 
2.39.2

