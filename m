Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B03B0A96
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2019 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfILIsC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Sep 2019 04:48:02 -0400
Received: from smtpcmd0871.aruba.it ([62.149.156.71]:46879 "EHLO
        smtpcmd0871.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILIsB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2019 04:48:01 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2019 04:47:50 EDT
Received: from localhost.localdomain ([93.146.66.165])
        by smtpcmd08.ad.aruba.it with bizsmtp
        id 0Ygg210103Zw7e501YgtKT; Thu, 12 Sep 2019 10:40:54 +0200
From:   Rodolfo Giometti <giometti@enneenne.com>
To:     linux-arch@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Genoud <richard.genoud@gmail.com>,
        Rodolfo Giometti <giometti@linux.it>,
        Joshua Henderson <joshua.henderson@microchip.com>
Subject: [PATCH 2/2] tty serial: add multidrop support for atmel serial controllers
Date:   Thu, 12 Sep 2019 10:40:32 +0200
Message-Id: <20190912084032.16927-3-giometti@enneenne.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912084032.16927-1-giometti@enneenne.com>
References: <20190912084032.16927-1-giometti@enneenne.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1568277654; bh=Tz6N7UQ/jiyprB8wtIJMMqZZNYywq2lDuVoMt+dmEOA=;
        h=From:To:Subject:Date;
        b=NpvJCfJd6g/fYEdTXT3t/zMvDD1Zk+nRTmuyI01kmf8UaEIMvBogOljCuxCRA5/yp
         ZQ/WiaBCcWYjNZaHL9s10XploaspyqSA7qjlzoiRGwVEWrRbGkm5P0Nn4NVZC3d/C1
         e/AWANaBc5MPUlDLU6HaZky06o4/0xnxl8gdAzirhR89fXOFmd4kstVn4PQC1pdsMr
         s5jIPtGgQ8HmgUHpSDgw0444gFq3j0Z3YWfl9OehCAbiuVVuGvOVxHhtaGl8075YGj
         SfwNJQ/6pccl4nTA42x+gyfK/quTDet3Di3Z7RHk6cfWZD6weLJ5WyWw4C8sjWOqSn
         hCTIGxXiyID2w==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Rodolfo Giometti <giometti@linux.it>

This patch adds multidrop support for atmel serial controllers and it
has been tested by using a SAMA5D3 CPU.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 0b4f36905321..b30b4a336907 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2178,7 +2178,7 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned long flags;
-	unsigned int old_mode, mode, imr, quot, baud, div, cd, fp = 0;
+	unsigned int old_mode, mode, mdrop, imr, quot, baud, div, cd, fp = 0;
 
 	/* save the current mode register */
 	mode = old_mode = atmel_uart_readl(port, ATMEL_US_MR);
@@ -2211,9 +2211,11 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/* parity */
 	if (termios->c_cflag & PARENB) {
-		/* Mark or Space parity */
+		/* Mark, Space or Multidrop parity */
 		if (termios->c_cflag & CMSPAR) {
-			if (termios->c_cflag & PARODD)
+			if (termios->c_cflag & PARMD)
+				mode |= ATMEL_US_PAR_MULTI_DROP;
+			else if (termios->c_cflag & PARODD)
 				mode |= ATMEL_US_PAR_MARK;
 			else
 				mode |= ATMEL_US_PAR_SPACE;
@@ -2221,8 +2223,11 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 			mode |= ATMEL_US_PAR_ODD;
 		else
 			mode |= ATMEL_US_PAR_EVEN;
+
 	} else
 		mode |= ATMEL_US_PAR_NONE;
+	mdrop = termios->c_cflag & SENDA ? ATMEL_US_SENDA : 0;
+	termios->c_cflag &= ~SENDA; /* SENDA bit must be cleared once used */
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -2363,7 +2368,8 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
 		atmel_uart_writel(port, ATMEL_US_BRGR, quot);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
-	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
+	atmel_uart_writel(port, ATMEL_US_CR,
+			  mdrop | ATMEL_US_TXEN | ATMEL_US_RXEN);
 	atmel_port->tx_stopped = false;
 
 	/* restore interrupts */
-- 
2.17.1

