Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2232DC61
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbhCDVnf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbhCDVnY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2021 16:43:24 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE3C061756;
        Thu,  4 Mar 2021 13:42:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0C02E426FC;
        Thu,  4 Mar 2021 21:41:49 +0000 (UTC)
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
Subject: [RFT PATCH v3 21/27] tty: serial: samsung_tty: IRQ rework
Date:   Fri,  5 Mar 2021 06:38:56 +0900
Message-Id: <20210304213902.83903-22-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Split out s3c24xx_serial_tx_chars from s3c24xx_serial_tx_irq,
  where only the latter acquires the port lock. This will be necessary
  on platforms which have edge-triggered IRQs, as we need to call
  s3c24xx_serial_tx_chars to kick off transmission from outside IRQ
  context, with the port lock held.

* Rename s3c24xx_serial_rx_chars to s3c24xx_serial_rx_irq for
  consistency with the above. All it does now is call two other
  functions anyway.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/tty/serial/samsung_tty.c | 34 +++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 39b2eb165bdc..7106eb238d8c 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -827,7 +827,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t s3c24xx_serial_rx_chars(int irq, void *dev_id)
+static irqreturn_t s3c24xx_serial_rx_irq(int irq, void *dev_id)
 {
 	struct s3c24xx_uart_port *ourport = dev_id;
 
@@ -836,16 +836,12 @@ static irqreturn_t s3c24xx_serial_rx_chars(int irq, void *dev_id)
 	return s3c24xx_serial_rx_chars_pio(dev_id);
 }
 
-static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
+static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
 {
-	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
 	struct circ_buf *xmit = &port->state->xmit;
-	unsigned long flags;
 	int count, dma_count = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
-
 	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
 
 	if (ourport->dma && ourport->dma->tx_chan &&
@@ -862,7 +858,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 		wr_reg(port, S3C2410_UTXH, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
-		goto out;
+		return;
 	}
 
 	/* if there isn't anything more to transmit, or the uart is now
@@ -871,7 +867,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
 		s3c24xx_serial_stop_tx(port);
-		goto out;
+		return;
 	}
 
 	/* try and drain the buffer... */
@@ -893,7 +889,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 
 	if (!count && dma_count) {
 		s3c24xx_serial_start_tx_dma(ourport, dma_count);
-		goto out;
+		return;
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
@@ -904,8 +900,18 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 
 	if (uart_circ_empty(xmit))
 		s3c24xx_serial_stop_tx(port);
+}
+
+static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
+{
+	struct s3c24xx_uart_port *ourport = id;
+	struct uart_port *port = &ourport->port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	s3c24xx_serial_tx_chars(ourport);
 
-out:
 	spin_unlock_irqrestore(&port->lock, flags);
 	return IRQ_HANDLED;
 }
@@ -919,11 +925,11 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 	irqreturn_t ret = IRQ_HANDLED;
 
 	if (pend & S3C64XX_UINTM_RXD_MSK) {
-		ret = s3c24xx_serial_rx_chars(irq, id);
+		ret = s3c24xx_serial_rx_irq(irq, id);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_RXD_MSK);
 	}
 	if (pend & S3C64XX_UINTM_TXD_MSK) {
-		ret = s3c24xx_serial_tx_chars(irq, id);
+		ret = s3c24xx_serial_tx_irq(irq, id);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
 	}
 	return ret;
@@ -1155,7 +1161,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 
 	ourport->rx_enabled = 1;
 
-	ret = request_irq(ourport->rx_irq, s3c24xx_serial_rx_chars, 0,
+	ret = request_irq(ourport->rx_irq, s3c24xx_serial_rx_irq, 0,
 			  s3c24xx_serial_portname(port), ourport);
 
 	if (ret != 0) {
@@ -1169,7 +1175,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 
 	ourport->tx_enabled = 1;
 
-	ret = request_irq(ourport->tx_irq, s3c24xx_serial_tx_chars, 0,
+	ret = request_irq(ourport->tx_irq, s3c24xx_serial_tx_irq, 0,
 			  s3c24xx_serial_portname(port), ourport);
 
 	if (ret) {
-- 
2.30.0

