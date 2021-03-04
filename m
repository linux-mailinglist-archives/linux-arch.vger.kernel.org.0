Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C023732DC3B
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhCDVmc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbhCDVmR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2021 16:42:17 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B269DC061765;
        Thu,  4 Mar 2021 13:41:36 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id AE9594261F;
        Thu,  4 Mar 2021 21:41:28 +0000 (UTC)
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
Subject: [RFT PATCH v3 18/27] tty: serial: samsung_tty: Separate S3C64XX ops structure
Date:   Fri,  5 Mar 2021 06:38:53 +0900
Message-Id: <20210304213902.83903-19-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of patching a single global ops structure depending on the port
type, use a separate s3c64xx_serial_ops for the S3C64XX type. This
allows us to mark the structures as const.

Also split out s3c64xx_serial_shutdown into a separate function now that
we have a separate ops structure; this avoids excessive branching
control flow and mirrors s3c64xx_serial_startup. tx_claimed and
rx_claimed are only used in the S3C24XX functions.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/tty/serial/samsung_tty.c | 71 ++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 8ae3e03fbd8c..78dc6e9240fb 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1098,27 +1098,36 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
 	if (ourport->tx_claimed) {
-		if (!s3c24xx_serial_has_interrupt_mask(port))
-			free_irq(ourport->tx_irq, ourport);
+		free_irq(ourport->tx_irq, ourport);
 		ourport->tx_enabled = 0;
 		ourport->tx_claimed = 0;
 		ourport->tx_mode = 0;
 	}
 
 	if (ourport->rx_claimed) {
-		if (!s3c24xx_serial_has_interrupt_mask(port))
-			free_irq(ourport->rx_irq, ourport);
+		free_irq(ourport->rx_irq, ourport);
 		ourport->rx_claimed = 0;
 		ourport->rx_enabled = 0;
 	}
 
-	/* Clear pending interrupts and mask all interrupts */
-	if (s3c24xx_serial_has_interrupt_mask(port)) {
-		free_irq(port->irq, ourport);
+	if (ourport->dma)
+		s3c24xx_serial_release_dma(ourport);
 
-		wr_regl(port, S3C64XX_UINTP, 0xf);
-		wr_regl(port, S3C64XX_UINTM, 0xf);
-	}
+	ourport->tx_in_progress = 0;
+}
+
+static void s3c64xx_serial_shutdown(struct uart_port *port)
+{
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
+
+	ourport->tx_enabled = 0;
+	ourport->tx_mode = 0;
+	ourport->rx_enabled = 0;
+
+	free_irq(port->irq, ourport);
+
+	wr_regl(port, S3C64XX_UINTP, 0xf);
+	wr_regl(port, S3C64XX_UINTM, 0xf);
 
 	if (ourport->dma)
 		s3c24xx_serial_release_dma(ourport);
@@ -1193,9 +1202,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 
 	/* For compatibility with s3c24xx Soc's */
 	ourport->rx_enabled = 1;
-	ourport->rx_claimed = 1;
 	ourport->tx_enabled = 0;
-	ourport->tx_claimed = 1;
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -1608,7 +1615,7 @@ static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 			 unsigned char c);
 #endif
 
-static struct uart_ops s3c24xx_serial_ops = {
+static const struct uart_ops s3c24xx_serial_ops = {
 	.pm		= s3c24xx_serial_pm,
 	.tx_empty	= s3c24xx_serial_tx_empty,
 	.get_mctrl	= s3c24xx_serial_get_mctrl,
@@ -1631,6 +1638,29 @@ static struct uart_ops s3c24xx_serial_ops = {
 #endif
 };
 
+static const struct uart_ops s3c64xx_serial_ops = {
+	.pm		= s3c24xx_serial_pm,
+	.tx_empty	= s3c24xx_serial_tx_empty,
+	.get_mctrl	= s3c24xx_serial_get_mctrl,
+	.set_mctrl	= s3c24xx_serial_set_mctrl,
+	.stop_tx	= s3c24xx_serial_stop_tx,
+	.start_tx	= s3c24xx_serial_start_tx,
+	.stop_rx	= s3c24xx_serial_stop_rx,
+	.break_ctl	= s3c24xx_serial_break_ctl,
+	.startup	= s3c64xx_serial_startup,
+	.shutdown	= s3c64xx_serial_shutdown,
+	.set_termios	= s3c24xx_serial_set_termios,
+	.type		= s3c24xx_serial_type,
+	.release_port	= s3c24xx_serial_release_port,
+	.request_port	= s3c24xx_serial_request_port,
+	.config_port	= s3c24xx_serial_config_port,
+	.verify_port	= s3c24xx_serial_verify_port,
+#if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
+	.poll_get_char = s3c24xx_serial_get_poll_char,
+	.poll_put_char = s3c24xx_serial_put_poll_char,
+#endif
+};
+
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "s3c2410_serial",
@@ -1868,10 +1898,6 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	/* setup info for port */
 	port->dev	= &platdev->dev;
 
-	/* Startup sequence is different for s3c64xx and higher SoC's */
-	if (s3c24xx_serial_has_interrupt_mask(port))
-		s3c24xx_serial_ops.startup = s3c64xx_serial_startup;
-
 	port->uartclk = 1;
 
 	if (cfg->uart_flags & UPF_CONS_FLOW) {
@@ -2019,6 +2045,17 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 			dev_get_platdata(&pdev->dev) :
 			ourport->drv_data->def_cfg;
 
+	switch (ourport->info->type) {
+	case PORT_S3C2410:
+	case PORT_S3C2412:
+	case PORT_S3C2440:
+		ourport->port.ops = &s3c24xx_serial_ops;
+		break;
+	case PORT_S3C6400:
+		ourport->port.ops = &s3c64xx_serial_ops;
+		break;
+	}
+
 	if (np) {
 		of_property_read_u32(np,
 			"samsung,uart-fifosize", &ourport->port.fifosize);
-- 
2.30.0

