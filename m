Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64F054C900
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 14:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349116AbiFOMtZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 08:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348943AbiFOMtS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 08:49:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA701EEDE;
        Wed, 15 Jun 2022 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655297351; x=1686833351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=367w6HIi5GuVANWSFTtVUtm5HUURP3exi/rAwUOCYro=;
  b=eFVFiz6v2QeJtZk1tlymIJ5IXgtDaoQ7zPvEOw3or3V99MUgb0nppZHs
   vkNYlE6wCDMhuQi4gqONyiZcmvHd7k2lxYqhU7LlRaQ9V9zvMgIX7Ibj/
   pR9ogVD2Sm47BEmyYa5zFVFOzo6VIlnJXrB0fjlpxxzqcUDi5LLzguUFY
   GDwv/mQHy8/5mbJX01iY1rsjTM/UM9Oifw0ZcSsNB5fVVLWcxMOCyKLSW
   ntMaQ+bTpc9dzwZJDx19Ppwpq00HhGNSCUgjW7U1LNkpIuIKYh3JdaWXG
   8GA+yuV503EwK1dFVbt1cvWK2I0/vc3y9WvRsggigWiZ/PlZRgKxNEUbO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="258800977"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="258800977"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 05:49:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="687288139"
Received: from mgrymel-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.34])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 05:49:07 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: [PATCH v7 5/6] serial: Support for RS-485 multipoint addresses
Date:   Wed, 15 Jun 2022 15:48:28 +0300
Message-Id: <20220615124829.34516-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add support for RS-485 multipoint addressing using 9th bit [*]. The
addressing mode is configured through .rs485_config().

ADDRB in termios indicates 9th bit addressing mode is enabled. In this
mode, 9th bit is used to indicate an address (byte) within the
communication line. ADDRB can only be enabled/disabled through
.rs485_config() that is also responsible for setting the destination and
receiver (filter) addresses.

[*] Technically, RS485 is just an electronic spec and does not itself
specify the 9th bit addressing mode but 9th bit seems at least
"semi-standard" way to do addressing with RS485.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 Documentation/driver-api/serial/driver.rst    |  2 ++
 .../driver-api/serial/serial-rs485.rst        | 26 ++++++++++++++++++-
 drivers/tty/serial/serial_core.c              | 11 ++++++++
 drivers/tty/tty_ioctl.c                       |  4 +++
 include/uapi/asm-generic/termbits-common.h    |  1 +
 include/uapi/linux/serial.h                   | 12 +++++++--
 6 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index 7ef83fd3917b..35fb3866bb3d 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -261,6 +261,8 @@ hardware.
 			- parity enable
 		PARODD
 			- odd parity (when PARENB is in force)
+		ADDRB
+			- address bit (changed through .rs485_config()).
 		CREAD
 			- enable reception of characters (if not set,
 			  still receive characters from the port, but
diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index 00b5d333acba..6ebad75c74ed 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -99,7 +99,31 @@ RS485 Serial Communications
 		/* Error handling. See errno. */
 	}
 
-5. References
+5. Multipoint Addressing
+========================
+
+   The Linux kernel provides addressing mode for multipoint RS-485 serial
+   communications line. The addressing mode is enabled with SER_RS485_ADDRB
+   flag in serial_rs485. Struct serial_rs485 has two additional flags and
+   fields for enabling receive and destination addresses.
+
+   Address mode flags:
+	- SER_RS485_ADDRB: Enabled addressing mode (sets also ADDRB in termios).
+	- SER_RS485_ADDR_RECV: Receive (filter) address enabled.
+	- SER_RS485_ADDR_DEST: Set destination address.
+
+   Address fields (enabled with corresponding SER_RS485_ADDR_* flag):
+	- addr_recv: Receive address.
+	- addr_dest: Destination address.
+
+   Once a receive address is set, the communication can occur only with the
+   particular device and other peers are filtered out. It is left up to the
+   receiver side to enforce the filtering. Receive address will be cleared
+   if SER_RS485_ADDR_RECV is not set.
+
+   Note: not all devices supporting RS485 support multipoint addressing.
+
+6. References
 =============
 
  [1]	include/uapi/linux/serial.h
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 76bb1b77b06e..b2bce1696540 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1294,6 +1294,17 @@ static int uart_check_rs485_flags(struct uart_port *port, struct serial_rs485 *r
 	if (flags & ~port->rs485_supported->flags)
 		return -EINVAL;
 
+	/* Asking for address w/o addressing mode? */
+	if (!(rs485->flags & SER_RS485_ADDRB) &&
+	    (rs485->flags & (SER_RS485_ADDR_RECV|SER_RS485_ADDR_DEST)))
+		return -EINVAL;
+
+	/* Address given but not enabled? */
+	if (!(rs485->flags & SER_RS485_ADDR_RECV) && rs485->addr_recv)
+		return -EINVAL;
+	if (!(rs485->flags & SER_RS485_ADDR_DEST) && rs485->addr_dest)
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index adae687f654b..ed253f2337a7 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -319,6 +319,8 @@ unsigned char tty_get_frame_size(unsigned int cflag)
 		bits++;
 	if (cflag & PARENB)
 		bits++;
+	if (cflag & ADDRB)
+		bits++;
 
 	return bits;
 }
@@ -353,6 +355,8 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 	old_termios = tty->termios;
 	tty->termios = *new_termios;
 	unset_locked_termios(tty, &old_termios);
+	/* Reset any ADDRB changes, ADDRB is changed through .rs485_config() */
+	tty->termios.c_cflag ^= (tty->termios.c_cflag ^ old_termios.c_cflag) & ADDRB;
 
 	if (tty->ops->set_termios)
 		tty->ops->set_termios(tty, &old_termios);
diff --git a/include/uapi/asm-generic/termbits-common.h b/include/uapi/asm-generic/termbits-common.h
index 4d084fe8def5..4a6a79f28b21 100644
--- a/include/uapi/asm-generic/termbits-common.h
+++ b/include/uapi/asm-generic/termbits-common.h
@@ -46,6 +46,7 @@ typedef unsigned int	speed_t;
 #define EXTA		B19200
 #define EXTB		B38400
 
+#define ADDRB		0x20000000	/* address bit */
 #define CMSPAR		0x40000000	/* mark or space (stick) parity */
 #define CRTSCTS		0x80000000	/* flow control */
 
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index fa6b16e5fdd8..9df86f0a3d46 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -126,10 +126,18 @@ struct serial_rs485 {
 #define SER_RS485_TERMINATE_BUS		(1 << 5)	/* Enable bus
 							   termination
 							   (if supported) */
+
+/* RS-485 addressing mode */
+#define SER_RS485_ADDRB			(1 << 6)	/* Enable addressing mode */
+#define SER_RS485_ADDR_RECV		(1 << 7)	/* Receive address filter */
+#define SER_RS485_ADDR_DEST		(1 << 8)	/* Destination address */
+
 	__u32	delay_rts_before_send;	/* Delay before send (milliseconds) */
 	__u32	delay_rts_after_send;	/* Delay after send (milliseconds) */
-	__u32	padding[5];		/* Memory is cheap, new structs
-					   are a royal PITA .. */
+	__u8	addr_recv;
+	__u8	addr_dest;
+	__u8	padding[2 + 4 * sizeof(__u32)];		/* Memory is cheap, new structs
+							 * are a royal PITA .. */
 };
 
 /*
-- 
2.30.2

