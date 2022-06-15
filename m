Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7224C54C8F4
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 14:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347171AbiFOMtB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345882AbiFOMs7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 08:48:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A7618388;
        Wed, 15 Jun 2022 05:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655297338; x=1686833338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1LeS1Y26/DPWMeFDEpo81CHFZxsFn7K1q5Nm4vENnvY=;
  b=aHAIcPEmBSwj6wthbLSY4XRgTSRSZbWkh2McHCdtfd2aGGeMRV4vFzDc
   1KQu/UlwfOP1ov4RnZIjAzi9A5qWmtZtZNZXJK7NEa3FDJPMn7VJQ1QLU
   FJ7CNnbquoQmGPf185AbgjqZwoTQAnszWwMVUMlC2r7w+76wuaxE64y8A
   O8A7duGoLOjlNRTXen71dLkVsCXU8vbjts4mjjzhNmS1Zx+RKKnSTmCEf
   yKd2oQAFb/ncSOGg0iy/anyN94JDVkcEIPTJol0z9pLmV4kDONpsfcdt9
   oI60Fh1e+c9XsFFI99fl8kty7qjaGohEnK9AICVowXvbgAQUosdzvmK+F
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="261973569"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="261973569"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 05:48:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="687288095"
Received: from mgrymel-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.34])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 05:48:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v7 0/6] Add RS485 9th bit addressing mode support to DW UART
Date:   Wed, 15 Jun 2022 15:48:23 +0300
Message-Id: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset adds RS-485 9th bit addressing mode support to the DW
UART driver and the necessary serial core bits to handle it. The
addressing mode is configured through .rs485_config() as was requested
during the review of the earlier versions. The line configuration
related ADDRB is still kept in ktermios->c_cflag to be able to take
account the extra addressing bit while calculating timing, etc. but it
is set/cleared by .rs485_config().

PLEASE CHECK that the serial_rs485 .padding change looks OK (mainly
that it won't add hole under some odd condition which would alter
serial_rs485's sizeof)!

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org

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
  serial: take termios_rwsem for .rs485_config() & pass termios as param
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
 drivers/tty/serial/serial_core.c              |  26 ++++-
 drivers/tty/serial/stm32-usart.c              |   2 +-
 drivers/tty/tty_ioctl.c                       |   4 +
 include/linux/serial_8250.h                   |   7 +-
 include/linux/serial_core.h                   |   3 +-
 include/uapi/asm-generic/termbits-common.h    |   1 +
 include/uapi/linux/serial.h                   |  12 +-
 31 files changed, 222 insertions(+), 53 deletions(-)

-- 
2.30.2

