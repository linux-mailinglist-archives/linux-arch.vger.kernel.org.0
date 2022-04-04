Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B64F10F2
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 10:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiDDIcR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 04:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbiDDIcQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 04:32:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3047325590;
        Mon,  4 Apr 2022 01:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649061020; x=1680597020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ABizxv2oeYO2wwl4Dd5x36/ryIakHx/dr6Yh5+l52KI=;
  b=J91TomdTbrFgF+3NZ+k6Rqf9lTNSN9eW0jIXrPQlh9ytH5lXzaHai3mj
   7v8u/DMKnrm9kJn/r3H6qhTyCcI7gX6CfOHN1VQY0ZIbgqL4UVUtzJSv+
   EEDRQUwAl5Brg/8et5SHRuALN4fICWUlU0+g0Pn96mbRmm/VtDMYKN2Xn
   21T7KYwR5cIDA7+VxKjuQV7RHqcVD36rJVVm84N9/QsrJkeVbaAXKGAjA
   /UUqJYA/l3mN6SeQ3BaVMWa1VSDJhzcq8vq2f4SxRR4d19kS9j7FfXI26
   NJS508qoMnesTz5LjYhirai0/iokO1kESF//ZUCFbpgh9YbBegWQT9cgc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="323639795"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="323639795"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:30:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="569293542"
Received: from rhamza-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:30:10 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-api@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 07/12] serial: termbits: ADDRB to indicate 9th bit addressing mode
Date:   Mon,  4 Apr 2022 11:29:07 +0300
Message-Id: <20220404082912.6885-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
References: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add ADDRB to termbits to indicate 9th bit addressing mode.
This change is necessary for supporting devices with RS485
multipoint addressing [*]. A later patch in the patch series
adds support for Synopsys Designware UART capable for 9th bit
addressing mode. In this mode, 9th bit is used to indicate an
address (byte) within the communication line. The 9th bit
addressing mode is selected using ADDRB introduced by an earlier
patch.

[*] Technically, RS485 is just an electronic spec and does not
itself specify the 9th bit addressing mode but 9th bit seems
at least "semi-standard" way to do addressing with RS485.

Cc: linux-api@vger.kernel.org
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/alpha/include/uapi/asm/termbits.h   | 1 +
 arch/mips/include/uapi/asm/termbits.h    | 1 +
 arch/parisc/include/uapi/asm/termbits.h  | 1 +
 arch/powerpc/include/uapi/asm/termbits.h | 1 +
 arch/sparc/include/uapi/asm/termbits.h   | 1 +
 drivers/char/pcmcia/synclink_cs.c        | 2 ++
 drivers/ipack/devices/ipoctal.c          | 2 ++
 drivers/mmc/core/sdio_uart.c             | 2 ++
 drivers/net/usb/hso.c                    | 3 ++-
 drivers/s390/char/tty3270.c              | 3 +++
 drivers/staging/greybus/uart.c           | 2 ++
 drivers/tty/amiserial.c                  | 6 +++++-
 drivers/tty/moxa.c                       | 1 +
 drivers/tty/mxser.c                      | 1 +
 drivers/tty/serial/serial_core.c         | 2 ++
 drivers/tty/synclink_gt.c                | 2 ++
 drivers/tty/tty_ioctl.c                  | 2 ++
 drivers/usb/class/cdc-acm.c              | 2 ++
 drivers/usb/serial/usb-serial.c          | 6 ++++--
 include/uapi/asm-generic/termbits.h      | 1 +
 net/bluetooth/rfcomm/tty.c               | 2 ++
 21 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index 4575ba34a0ea..285169c794ec 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -180,6 +180,7 @@ struct ktermios {
 #define HUPCL	00040000
 
 #define CLOCAL	00100000
+#define ADDRB	010000000		/* address bit */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index dfeffba729b7..e7ea31cfec78 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -181,6 +181,7 @@ struct ktermios {
 #define	 B3000000 0010015
 #define	 B3500000 0010016
 #define	 B4000000 0010017
+#define ADDRB	  0020000	/* address bit */
 #define CIBAUD	  002003600000	/* input baud rate */
 #define CMSPAR	  010000000000	/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000	/* flow control */
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index 40e920f8d683..629be061f5d5 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -158,6 +158,7 @@ struct ktermios {
 #define  B3000000 0010015
 #define  B3500000 0010016
 #define  B4000000 0010017
+#define ADDRB	  0020000		/* address bit */
 #define CIBAUD    002003600000		/* input baud rate */
 #define CMSPAR    010000000000          /* mark or space (stick) parity */
 #define CRTSCTS   020000000000          /* flow control */
diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
index ed18bc61f63d..1b778ac562a4 100644
--- a/arch/powerpc/include/uapi/asm/termbits.h
+++ b/arch/powerpc/include/uapi/asm/termbits.h
@@ -171,6 +171,7 @@ struct ktermios {
 #define HUPCL	00040000
 
 #define CLOCAL	00100000
+#define ADDRB	00200000		/* address bit */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index ce5ad5d0f105..4ad60c4acf65 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -200,6 +200,7 @@ struct ktermios {
 #define B3000000  0x00001011
 #define B3500000  0x00001012
 #define B4000000  0x00001013  */
+#define ADDRB	  0x00002000  /* address bit */
 #define CIBAUD	  0x100f0000  /* input baud rate (not used) */
 #define CMSPAR	  0x40000000  /* mark or space (stick) parity */
 #define CRTSCTS	  0x80000000  /* flow control */
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 78baba55a8b5..d179b9b57a25 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -2287,6 +2287,8 @@ static void mgslpc_set_termios(struct tty_struct *tty, struct ktermios *old_term
 		== RELEVANT_IFLAG(old_termios->c_iflag)))
 	  return;
 
+	tty->termios.c_cflag &= ~ADDRB;
+
 	mgslpc_change_params(info, tty);
 
 	/* Handle transition to B0 status */
diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index 20d2b9ec1227..d66cc9683ebc 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -506,6 +506,8 @@ static void ipoctal_set_termios(struct tty_struct *tty,
 	struct ipoctal_channel *channel = tty->driver_data;
 	speed_t baud;
 
+	tty->termios.c_cflag &= ~ADDRB;
+
 	cflag = tty->termios.c_cflag;
 
 	/* Disable and reset everything before change the setup */
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 04c0823e0359..7432b01379ef 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -880,6 +880,8 @@ static void sdio_uart_set_termios(struct tty_struct *tty,
 	if (sdio_uart_claim_func(port) != 0)
 		return;
 
+	tty->termios.c_cflag &= ~ADDRB;
+
 	sdio_uart_change_speed(port, &tty->termios, old_termios);
 
 	/* Handle transition to B0 status */
diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index f97813a4e8d1..b687327bc7b1 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1099,7 +1099,8 @@ static void _hso_serial_set_termios(struct tty_struct *tty)
 		~(CSIZE		/* no size */
 		| PARENB	/* disable parity bit */
 		| CBAUD		/* clear current baud rate */
-		| CBAUDEX);	/* clear current buad rate */
+		| CBAUDEX	/* clear current baud rate */
+		| ADDRB);	/* disable 9th (addr) bit */
 
 	tty->termios.c_cflag |= CS8;	/* character size 8 bits */
 
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 5c83f71c1d0e..253d2997a1d3 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1768,6 +1768,9 @@ tty3270_set_termios(struct tty_struct *tty, struct ktermios *old)
 	tp = tty->driver_data;
 	if (!tp)
 		return;
+
+	tty->termios.c_cflag &= ~ADDRB;
+
 	spin_lock_bh(&tp->view.lock);
 	if (L_ICANON(tty)) {
 		new = L_ECHO(tty) ? TF_INPUT: TF_INPUTN;
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index dc4ed0ff1ae2..83e73aefde0f 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -487,6 +487,8 @@ static void gb_tty_set_termios(struct tty_struct *tty,
 	struct ktermios *termios = &tty->termios;
 	u8 newctrl = gb_tty->ctrlout;
 
+	termios->c_cflag &= ~ADDRB;
+
 	newline.rate = cpu_to_le32(tty_get_baud_rate(tty));
 	newline.format = termios->c_cflag & CSTOPB ?
 				GB_SERIAL_2_STOP_BITS : GB_SERIAL_1_STOP_BITS;
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 533d02b38e02..3ca97007bd6e 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1175,7 +1175,11 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 {
 	struct serial_state *info = tty->driver_data;
 	unsigned long flags;
-	unsigned int cflag = tty->termios.c_cflag;
+	unsigned int cflag;
+
+	tty->termios.c_cflag &= ~ADDRB;
+
+	cflag = tty->termios.c_cflag;
 
 	change_speed(tty, info, old_termios);
 
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index f3c72ab1476c..07cd88152d58 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -2050,6 +2050,7 @@ static int MoxaPortSetTermio(struct moxa_port *port, struct ktermios *termio,
 
 	ofsAddr = port->tableAddr;
 
+	termio->c_cflag &= ~ADDRB;
 	mode = termio->c_cflag & CSIZE;
 	if (mode == CS5)
 		mode = MX_CS5;
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 836c9eca2946..220676363a07 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -577,6 +577,7 @@ static void mxser_change_speed(struct tty_struct *tty, struct ktermios *old_term
 	struct mxser_port *info = tty->driver_data;
 	unsigned cflag, cval;
 
+	tty->termios.c_cflag &= ~ADDRB;
 	cflag = tty->termios.c_cflag;
 
 	if (mxser_set_baud(tty, tty_get_baud_rate(tty))) {
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c6ac91033e38..de198c2acefe 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1493,6 +1493,8 @@ static void uart_set_termios(struct tty_struct *tty,
 		goto out;
 	}
 
+	tty->termios.c_cflag &= ~ADDRB;
+
 	uart_change_speed(tty, state, old_termios);
 	/* reload cflag from termios; port driver may have overridden flags */
 	cflag = tty->termios.c_cflag;
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 25c558e65ece..ee767cea18ed 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -714,6 +714,8 @@ static void set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 
 	DBGINFO(("%s set_termios\n", tty->driver->name));
 
+	tty->termios.c_cflag &= ~ADDRB;
+
 	change_params(info);
 
 	/* Handle transition to B0 status */
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 63181925ec1a..934037d78868 100644
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
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 9b9aea24d58c..fd246ec70da8 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1056,6 +1056,8 @@ static void acm_tty_set_termios(struct tty_struct *tty,
 	struct usb_cdc_line_coding newline;
 	int newctrl = acm->ctrlout;
 
+	termios->c_cflag &= ~ADDRB;
+
 	newline.dwDTERate = cpu_to_le32(tty_get_baud_rate(tty));
 	newline.bCharFormat = termios->c_cflag & CSTOPB ? 2 : 0;
 	newline.bParityType = termios->c_cflag & PARENB ?
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 24101bd7fcad..8d1d170eb7e6 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -525,10 +525,12 @@ static void serial_set_termios(struct tty_struct *tty, struct ktermios *old)
 
 	dev_dbg(&port->dev, "%s\n", __func__);
 
-	if (port->serial->type->set_termios)
+	if (port->serial->type->set_termios) {
+		tty->termios.c_cflag &= ~ADDRB;
 		port->serial->type->set_termios(tty, port, old);
-	else
+	} else {
 		tty_termios_copy_hw(&tty->termios, old);
+	}
 }
 
 static int serial_break(struct tty_struct *tty, int break_state)
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 2fbaf9ae89dd..5f5228329d45 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -157,6 +157,7 @@ struct ktermios {
 #define  B3000000 0010015
 #define  B3500000 0010016
 #define  B4000000 0010017
+#define ADDRB     0020000	/* address bit */
 #define CIBAUD	  002003600000	/* input baud rate */
 #define CMSPAR	  010000000000	/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000	/* flow control */
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index ebd78fdbd6e8..832e725f23ab 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -871,6 +871,8 @@ static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	if (!dev || !dev->dlc || !dev->dlc->session)
 		return;
 
+	new->c_cflag &= ~ADDRB;
+
 	/* Handle turning off CRTSCTS */
 	if ((old->c_cflag & CRTSCTS) && !(new->c_cflag & CRTSCTS))
 		BT_DBG("Turning off CRTSCTS unsupported");
-- 
2.30.2

