Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58A332DC68
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbhCDVng (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbhCDVn1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2021 16:43:27 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597AFC061761;
        Thu,  4 Mar 2021 13:42:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 28BE042709;
        Thu,  4 Mar 2021 21:41:56 +0000 (UTC)
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
Subject: [RFT PATCH v3 22/27] tty: serial: samsung_tty: Use devm_ioremap_resource
Date:   Fri,  5 Mar 2021 06:38:57 +0900
Message-Id: <20210304213902.83903-23-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This picks up the non-posted I/O mode needed for Apple platforms to
work properly.

This removes the request/release functions, which are no longer
necessary, since devm_ioremap_resource takes care of that already. Most
other drivers already do it this way, anyway.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/tty/serial/samsung_tty.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 7106eb238d8c..26cb05992e9f 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1573,26 +1573,11 @@ static const char *s3c24xx_serial_type(struct uart_port *port)
 	}
 }
 
-#define MAP_SIZE (0x100)
-
-static void s3c24xx_serial_release_port(struct uart_port *port)
-{
-	release_mem_region(port->mapbase, MAP_SIZE);
-}
-
-static int s3c24xx_serial_request_port(struct uart_port *port)
-{
-	const char *name = s3c24xx_serial_portname(port);
-
-	return request_mem_region(port->mapbase, MAP_SIZE, name) ? 0 : -EBUSY;
-}
-
 static void s3c24xx_serial_config_port(struct uart_port *port, int flags)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 
-	if (flags & UART_CONFIG_TYPE &&
-	    s3c24xx_serial_request_port(port) == 0)
+	if (flags & UART_CONFIG_TYPE)
 		port->type = info->port_type;
 }
 
@@ -1645,8 +1630,6 @@ static const struct uart_ops s3c24xx_serial_ops = {
 	.shutdown	= s3c24xx_serial_shutdown,
 	.set_termios	= s3c24xx_serial_set_termios,
 	.type		= s3c24xx_serial_type,
-	.release_port	= s3c24xx_serial_release_port,
-	.request_port	= s3c24xx_serial_request_port,
 	.config_port	= s3c24xx_serial_config_port,
 	.verify_port	= s3c24xx_serial_verify_port,
 #if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
@@ -1668,8 +1651,6 @@ static const struct uart_ops s3c64xx_serial_ops = {
 	.shutdown	= s3c64xx_serial_shutdown,
 	.set_termios	= s3c24xx_serial_set_termios,
 	.type		= s3c24xx_serial_type,
-	.release_port	= s3c24xx_serial_release_port,
-	.request_port	= s3c24xx_serial_request_port,
 	.config_port	= s3c24xx_serial_config_port,
 	.verify_port	= s3c24xx_serial_verify_port,
 #if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
@@ -1927,8 +1908,8 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	dev_dbg(port->dev, "resource %pR)\n", res);
 
-	port->membase = devm_ioremap(port->dev, res->start, resource_size(res));
-	if (!port->membase) {
+	port->membase = devm_ioremap_resource(port->dev, res);
+	if (IS_ERR(port->membase)) {
 		dev_err(port->dev, "failed to remap controller address\n");
 		return -EBUSY;
 	}
-- 
2.30.0

