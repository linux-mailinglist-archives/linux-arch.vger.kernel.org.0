Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DC632DC4D
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbhCDVnB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbhCDVmb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2021 16:42:31 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CB6C061574;
        Thu,  4 Mar 2021 13:41:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E4C0A426F7;
        Thu,  4 Mar 2021 21:41:42 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v3 20/27] tty: serial: samsung_tty: Add s3c24xx_port_type
Date:   Fri,  5 Mar 2021 06:38:55 +0900
Message-Id: <20210304213902.83903-21-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This decouples the TTY layer PORT_ types, which are exposed to
userspace, from the driver-internal flag of what kind of port this is.

This removes s3c24xx_serial_has_interrupt_mask, which was just checking
for a specific type anyway.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/tty/serial/samsung_tty.c | 112 +++++++++++++++++++------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 33b421dbeb83..39b2eb165bdc 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -56,9 +56,15 @@
 /* flag to ignore all characters coming in */
 #define RXSTAT_DUMMY_READ (0x10000000)
 
+enum s3c24xx_port_type {
+	TYPE_S3C24XX,
+	TYPE_S3C6400,
+};
+
 struct s3c24xx_uart_info {
 	char			*name;
-	unsigned int		type;
+	enum s3c24xx_port_type	type;
+	unsigned int		port_type;
 	unsigned int		fifosize;
 	unsigned long		rx_fifomask;
 	unsigned long		rx_fifoshift;
@@ -229,16 +235,6 @@ static int s3c24xx_serial_txempty_nofifo(struct uart_port *port)
 	return rd_regl(port, S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE;
 }
 
-/*
- * s3c64xx and later SoC's include the interrupt mask and status registers in
- * the controller itself, unlike the s3c24xx SoC's which have these registers
- * in the interrupt controller. Check if the port type is s3c64xx or higher.
- */
-static int s3c24xx_serial_has_interrupt_mask(struct uart_port *port)
-{
-	return to_ourport(port)->info->type == PORT_S3C6400;
-}
-
 static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
@@ -290,10 +286,14 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 	if (!ourport->tx_enabled)
 		return;
 
-	if (s3c24xx_serial_has_interrupt_mask(port))
+	switch (ourport->info->type) {
+	case TYPE_S3C6400:
 		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
-	else
+		break;
+	default:
 		disable_irq_nosync(ourport->tx_irq);
+		break;
+	}
 
 	if (dma && dma->tx_chan && ourport->tx_in_progress == S3C24XX_TX_DMA) {
 		dmaengine_pause(dma->tx_chan);
@@ -354,10 +354,14 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
 	u32 ucon;
 
 	/* Mask Tx interrupt */
-	if (s3c24xx_serial_has_interrupt_mask(port))
+	switch (ourport->info->type) {
+	case TYPE_S3C6400:
 		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
-	else
+		break;
+	default:
 		disable_irq_nosync(ourport->tx_irq);
+		break;
+	}
 
 	/* Enable tx dma mode */
 	ucon = rd_regl(port, S3C2410_UCON);
@@ -387,11 +391,15 @@ static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
 	wr_regl(port,  S3C2410_UCON, ucon);
 
 	/* Unmask Tx interrupt */
-	if (s3c24xx_serial_has_interrupt_mask(port))
+	switch (ourport->info->type) {
+	case TYPE_S3C6400:
 		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD,
 				  S3C64XX_UINTM);
-	else
+		break;
+	default:
 		enable_irq(ourport->tx_irq);
+		break;
+	}
 
 	ourport->tx_mode = S3C24XX_TX_PIO;
 }
@@ -514,11 +522,15 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
 
 	if (ourport->rx_enabled) {
 		dev_dbg(port->dev, "stopping rx\n");
-		if (s3c24xx_serial_has_interrupt_mask(port))
+		switch (ourport->info->type) {
+		case TYPE_S3C6400:
 			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD,
 					S3C64XX_UINTM);
-		else
+			break;
+		default:
 			disable_irq_nosync(ourport->rx_irq);
+			break;
+		}
 		ourport->rx_enabled = 0;
 	}
 	if (dma && dma->rx_chan) {
@@ -1543,14 +1555,12 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 
 static const char *s3c24xx_serial_type(struct uart_port *port)
 {
-	switch (port->type) {
-	case PORT_S3C2410:
-		return "S3C2410";
-	case PORT_S3C2440:
-		return "S3C2440";
-	case PORT_S3C2412:
-		return "S3C2412";
-	case PORT_S3C6400:
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
+
+	switch (ourport->info->type) {
+	case TYPE_S3C24XX:
+		return "S3C24XX";
+	case TYPE_S3C6400:
 		return "S3C6400/10";
 	default:
 		return NULL;
@@ -1577,7 +1587,7 @@ static void s3c24xx_serial_config_port(struct uart_port *port, int flags)
 
 	if (flags & UART_CONFIG_TYPE &&
 	    s3c24xx_serial_request_port(port) == 0)
-		port->type = info->type;
+		port->type = info->port_type;
 }
 
 /*
@@ -1588,7 +1598,7 @@ s3c24xx_serial_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 
-	if (ser->type != PORT_UNKNOWN && ser->type != info->type)
+	if (ser->type != PORT_UNKNOWN && ser->type != info->port_type)
 		return -EINVAL;
 
 	return 0;
@@ -1927,11 +1937,16 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		ourport->tx_irq = ret + 1;
 	}
 
-	if (!s3c24xx_serial_has_interrupt_mask(port)) {
+	switch (ourport->info->type) {
+	case TYPE_S3C24XX:
 		ret = platform_get_irq(platdev, 1);
 		if (ret > 0)
 			ourport->tx_irq = ret;
+		break;
+	default:
+		break;
 	}
+
 	/*
 	 * DMA is currently supported only on DT platforms, if DMA properties
 	 * are specified.
@@ -1967,10 +1982,14 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		pr_warn("uart: failed to enable baudclk\n");
 
 	/* Keep all interrupts masked and cleared */
-	if (s3c24xx_serial_has_interrupt_mask(port)) {
+	switch (ourport->info->type) {
+	case TYPE_S3C6400:
 		wr_regl(port, S3C64XX_UINTM, 0xf);
 		wr_regl(port, S3C64XX_UINTP, 0xf);
 		wr_regl(port, S3C64XX_UINTSP, 0xf);
+		break;
+	default:
+		break;
 	}
 
 	dev_dbg(port->dev, "port: map=%pa, mem=%p, irq=%d (%d,%d), clock=%u\n",
@@ -2042,12 +2061,10 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 			ourport->drv_data->def_cfg;
 
 	switch (ourport->info->type) {
-	case PORT_S3C2410:
-	case PORT_S3C2412:
-	case PORT_S3C2440:
+	case TYPE_S3C24XX:
 		ourport->port.ops = &s3c24xx_serial_ops;
 		break;
-	case PORT_S3C6400:
+	case TYPE_S3C6400:
 		ourport->port.ops = &s3c64xx_serial_ops;
 		break;
 	}
@@ -2175,7 +2192,8 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 
 	if (port) {
 		/* restore IRQ mask */
-		if (s3c24xx_serial_has_interrupt_mask(port)) {
+		switch (ourport->info->type) {
+		case TYPE_S3C6400: {
 			unsigned int uintm = 0xf;
 
 			if (ourport->tx_enabled)
@@ -2189,6 +2207,10 @@ static int s3c24xx_serial_resume_noirq(struct device *dev)
 			if (!IS_ERR(ourport->baudclk))
 				clk_disable_unprepare(ourport->baudclk);
 			clk_disable_unprepare(ourport->clk);
+			break;
+		}
+		default:
+			break;
 		}
 	}
 
@@ -2413,7 +2435,8 @@ static struct console s3c24xx_serial_console = {
 static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung S3C2410 UART",
-		.type		= PORT_S3C2410,
+		.type		= TYPE_S3C24XX,
+		.port_type	= PORT_S3C2410,
 		.fifosize	= 16,
 		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
 		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
@@ -2440,7 +2463,8 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
 static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung S3C2412 UART",
-		.type		= PORT_S3C2412,
+		.type		= TYPE_S3C24XX,
+		.port_type	= PORT_S3C2412,
 		.fifosize	= 64,
 		.has_divslot	= 1,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
@@ -2469,7 +2493,8 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
 static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung S3C2440 UART",
-		.type		= PORT_S3C2440,
+		.type		= TYPE_S3C24XX,
+		.port_type	= PORT_S3C2440,
 		.fifosize	= 64,
 		.has_divslot	= 1,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
@@ -2498,7 +2523,8 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
 static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung S3C6400 UART",
-		.type		= PORT_S3C6400,
+		.type		= TYPE_S3C6400,
+		.port_type	= PORT_S3C6400,
 		.fifosize	= 64,
 		.has_divslot	= 1,
 		.rx_fifomask	= S3C2440_UFSTAT_RXMASK,
@@ -2526,7 +2552,8 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
 static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 	.info = &(struct s3c24xx_uart_info) {
 		.name		= "Samsung S5PV210 UART",
-		.type		= PORT_S3C6400,
+		.type		= TYPE_S3C6400,
+		.port_type	= PORT_S3C6400,
 		.has_divslot	= 1,
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
@@ -2554,7 +2581,8 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 #define EXYNOS_COMMON_SERIAL_DRV_DATA				\
 	.info = &(struct s3c24xx_uart_info) {			\
 		.name		= "Samsung Exynos UART",	\
-		.type		= PORT_S3C6400,			\
+		.type		= TYPE_S3C6400,			\
+		.port_type	= PORT_S3C6400,			\
 		.has_divslot	= 1,				\
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
 		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,	\
-- 
2.30.0

