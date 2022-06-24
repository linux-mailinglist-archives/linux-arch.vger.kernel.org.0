Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189D255A2E6
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 22:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiFXUme (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiFXUme (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 16:42:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040D463630;
        Fri, 24 Jun 2022 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656103353; x=1687639353;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gi3SedSmi1CW56jyMna7RkNN3gSo+ueP2DFVYUbNY9U=;
  b=YefmMOMqvvVJvEHGPSKQPiimdM9YM7A/kg4R4YOXzwTW+N51B2JPngLV
   4nFYRTZ9IalC5azRscGaP49CHo1OTxSzEFboL8AquRzpWCCC9xy8ffs4J
   FIkr2SDpFM1Sxoi3osPDvcMN4XJGklfTuMjwKGHQMIvFZDdklj5yomIL9
   P58Ac/+ztsNLbCwL8ZhXMskOn/Gk/kVfwAAlsNh/tddQfwHphf95A7dAu
   LhpyfiZ8FhH+Fs89lH2yanFc9Lvg/MvKjPVn5t+iNtfr+HqVfu7v9vE8J
   YqJ8T9ivI0Od2WZw3r7KSZsZQuUe77CVrXq5waFzFukMVkK00hoLthANJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="278633905"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="278633905"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:42:32 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="593381014"
Received: from vhavel-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.91])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:42:29 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v9 0/6] Add RS485 9th bit addressing mode support to DW UART
Date:   Fri, 24 Jun 2022 23:42:04 +0300
Message-Id: <20220624204210.11112-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset adds RS-485 9th bit addressing mode support to the DW
UART driver and the necessary serial core bits to handle it. The
addressing mode is configured through ->rs485_config() as was requested
during the review of the earlier versions. The line configuration
related ADDRB is still kept in ktermios->c_cflag to be able to take
account the extra addressing bit while calculating timing, etc. but it
is set/cleared by ->rs485_config().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org

v8 -> v9:
- Tweak comments (struct fields info & one callback style correction)
- Add struct layout checks as static_asserts

v7 -> v8:
- Use anonymous union/struct in serial_rs485 to create "v2" of it
- Remove a stray newline change
- Reorder local var declarations
- Put ktermios param before serial_rs485 for rs485_config

v6 -> v7:
- Fixed typos in documentation & comment
- Changes lsr typing from unsigned int to u16

v5 -> v6:
- Reorder remaining patches
- LSR changes are simpler due to helper added by LSR fix series
- Depend on rs485_struct sanitization on catching much of invalid config
- In order to be able to alter ADDRB in termios .c_cflag within
  .rs485_config(), take termios_rwsem and pass ktermios to it.
- Moved addressing mode setup entirely into .rs485_config()
- Use ndelay() instead of udelay() (uart_port->frame_time is in nsecs)


Ilpo Järvinen (6):
  serial: 8250: make saved LSR larger
  serial: 8250: create lsr_save_mask
  serial: 8250_lpss: Use 32-bit reads
  serial: take termios_rwsem for ->rs485_config() & pass termios as
    param
  serial: Support for RS-485 multipoint addresses
  serial: 8250_dwlib: Support for 9th bit multipoint addressing

 Documentation/driver-api/serial/driver.rst    |   2 +
 .../driver-api/serial/serial-rs485.rst        |  26 ++++-
 drivers/tty/serial/8250/8250.h                |   9 +-
 drivers/tty/serial/8250/8250_core.c           |   4 +
 drivers/tty/serial/8250/8250_dw.c             |   2 +-
 drivers/tty/serial/8250/8250_dwlib.c          | 105 +++++++++++++++++-
 drivers/tty/serial/8250/8250_exar.c           |  11 +-
 drivers/tty/serial/8250/8250_fintek.c         |   2 +-
 drivers/tty/serial/8250/8250_fsl.c            |   2 +-
 drivers/tty/serial/8250/8250_ingenic.c        |   2 +-
 drivers/tty/serial/8250/8250_lpc18xx.c        |   2 +-
 drivers/tty/serial/8250/8250_lpss.c           |   2 +-
 drivers/tty/serial/8250/8250_omap.c           |   7 +-
 drivers/tty/serial/8250/8250_pci.c            |   2 +-
 drivers/tty/serial/8250/8250_port.c           |  20 ++--
 drivers/tty/serial/amba-pl011.c               |   2 +-
 drivers/tty/serial/ar933x_uart.c              |   2 +-
 drivers/tty/serial/atmel_serial.c             |   2 +-
 drivers/tty/serial/fsl_lpuart.c               |   4 +-
 drivers/tty/serial/imx.c                      |   2 +-
 drivers/tty/serial/max310x.c                  |   2 +-
 drivers/tty/serial/mcf.c                      |   3 +-
 drivers/tty/serial/omap-serial.c              |   3 +-
 drivers/tty/serial/sc16is7xx.c                |   2 +-
 drivers/tty/serial/serial_core.c              |  36 +++++-
 drivers/tty/serial/stm32-usart.c              |   2 +-
 drivers/tty/tty_ioctl.c                       |   4 +
 include/linux/serial_8250.h                   |   7 +-
 include/linux/serial_core.h                   |   1 +
 include/uapi/asm-generic/termbits-common.h    |   1 +
 include/uapi/linux/serial.h                   |  20 +++-
 31 files changed, 238 insertions(+), 53 deletions(-)

-- 
2.30.2

