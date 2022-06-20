Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB6C551090
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 08:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiFTGlQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 02:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbiFTGlM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 02:41:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D946EDF50;
        Sun, 19 Jun 2022 23:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655707271; x=1687243271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hpHQEL0bY2235Xf8dLhHi9xQeV0+rIWxi3BbCRA7j5M=;
  b=iShlKnAvLc9LQv92CKWpcR2BaqrCFGK91dw55jqRbE43t9rZfBoa9LSn
   89JLz+LCxgkfNmTLDUcP9CNy0PYw39Re4R2JJPjAx8egTU6jwZdXYEZav
   m9OMdyvAsJr1ddLE83WgSpkHrW0tWmYe0P3m0z2rNVPThJd866j69Q1EY
   Dn16jSDOdwR37Mt588PjgKSi6uO/hPrJu9LP9QgxZ7EguYljFleYtlRiY
   9OV9/4AU2dZvxKwNwHVsdPLFeSZSMDPF0l6Cg4M5R+jmnWB3AXBmqFw7C
   4XKvD8DUJTbv6zuIvnzXoF3U3YSYhRZZImodJD3J4nI38aLA/+/ntgtKc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260247020"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260247020"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 23:41:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642967791"
Received: from lspinell-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 23:41:08 -0700
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
Subject: [PATCH v8 5/6] serial: Support for RS-485 multipoint addresses
Date:   Mon, 20 Jun 2022 09:40:29 +0300
Message-Id: <20220620064030.7938-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620064030.7938-1-ilpo.jarvinen@linux.intel.com>
References: <20220620064030.7938-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add support for RS-485 multipoint addressing using 9th bit [*]. The
addressing mode is configured through ->rs485_config().

ADDRB in termios indicates 9th bit addressing mode is enabled. In this
mode, 9th bit is used to indicate an address (byte) within the
communication line. ADDRB can only be enabled/disabled through
->rs485_config() that is also responsible for setting the destination and
receiver (filter) addresses.

The changes to serial_rs485 struct were test built with a few traps to
detect mislayouting on archs lkp/0day builts for (all went fine):
  BUILD_BUG_ON(((&rs485.delay_rts_after_send) + 1) != &rs485.padding[0]);
  BUILD_BUG_ON(&rs485.padding[1] != &rs485.padding1[0]);
  BUILD_BUG_ON(sizeof(rs485) != ((u8 *)(&rs485.padding[4]) -
				 ((u8 *)&rs485.flags) + sizeof(__u32)));

[*] Technically, RS485 is just an electronic spec and does not itself
specify the 9th bit addressing mode but 9th bit seems at least
"semi-standard" way to do addressing with RS485.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
 Documentation/driver-api/serial/driver.rst    |  2 ++
 .../driver-api/serial/serial-rs485.rst        | 26 ++++++++++++++++++-
 drivers/tty/serial/serial_core.c              | 14 +++++++++-
 drivers/tty/tty_ioctl.c                       |  4 +++
 include/uapi/asm-generic/termbits-common.h    |  1 +
 include/uapi/linux/serial.h                   | 20 ++++++++++++--
 6 files changed, 63 insertions(+), 4 deletions(-)

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
index 44c3785445e3..414099e3262a 100644
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
 
@@ -1349,7 +1360,8 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 	rs485->flags &= supported_flags;
 
 	/* Return clean padding area to userspace */
-	memset(rs485->padding, 0, sizeof(rs485->padding));
+	memset(rs485->padding0, 0, sizeof(rs485->padding0));
+	memset(rs485->padding1, 0, sizeof(rs485->padding1));
 }
 
 int uart_rs485_config(struct uart_port *port)
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
+	/* Reset any ADDRB changes, ADDRB is changed through ->rs485_config() */
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
index fa6b16e5fdd8..c4c75fd7037e 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -126,10 +126,26 @@ struct serial_rs485 {
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
+	union {
+		/* v1 */
+		__u32	padding[5];		/* Memory is cheap, new structs are a pain */
+
+		/* v2 (adds addressing mode fields) */
+		struct {
+			__u8	addr_recv;
+			__u8	addr_dest;
+			__u8	padding0[2];
+			__u32	padding1[4];
+		};
+	};
 };
 
 /*
-- 
2.30.2

