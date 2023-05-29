Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA78C714C69
	for <lists+linux-arch@lfdr.de>; Mon, 29 May 2023 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjE2Otp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 May 2023 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjE2Otk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2023 10:49:40 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8598DDB;
        Mon, 29 May 2023 07:49:38 -0700 (PDT)
Received: from tp8.. (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BB9867C0;
        Mon, 29 May 2023 14:49:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BB9867C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1685371778; bh=NVpyHOmZC5FXcK453T2BsKRUZXOjXfhhxOEARwSReFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Khqmu0xzFTvZjl7lVyt9ElmHb3OSR0uOv29YeJZkC4jsoMWsSeqPDAA80UrlfDryk
         dNyn+TZ7+pDncLJlzp3+m8tYsgo75C/ktuDCFzhKPJQBQFBVMwNCks1mDdsziR2VZ6
         kPva4aNKtF80aOdUdxBKJjdZiZf0EhCoEbJbkSoOXIg6BfOwEXt+bgzA/QrlOAHH3p
         OqxFWmSLoC39CVHypHroAw2UC69fzUN86HYwpIamaQSV9mARnsKZdTFFO9MCQ+gwx7
         D+/Il8TNWr5f2Wxwz90xfEcLHBdD9XeWFj9iDCx2kh9wZxWTYvLBSerpS4efoOxHKE
         g4uplKIQw4X4g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 6/7] docs: update some straggling Documentation/arm references
Date:   Mon, 29 May 2023 08:48:55 -0600
Message-Id: <20230529144856.102755-7-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230529144856.102755-1-corbet@lwn.net>
References: <20230529144856.102755-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Arm documentation has moved to Documentation/arch/arm; update the
last remaining references to match.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-pwm@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 MAINTAINERS                          | 4 ++--
 drivers/input/touchscreen/sun4i-ts.c | 2 +-
 drivers/pwm/pwm-atmel.c              | 2 +-
 drivers/pwm/pwm-pxa.c                | 2 +-
 drivers/tty/serial/Kconfig           | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..d9525ccf2bf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2706,7 +2706,7 @@ Q:	https://patchwork.kernel.org/project/linux-samsung-soc/list/
 B:	mailto:linux-samsung-soc@vger.kernel.org
 C:	irc://irc.libera.chat/linux-exynos
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
-F:	Documentation/arm/samsung/
+F:	Documentation/arch/arm/samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
 F:	Documentation/devicetree/bindings/hwinfo/samsung,*
 F:	Documentation/devicetree/bindings/power/pd-samsung.yaml
@@ -15278,7 +15278,7 @@ OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT (DSS2)
 L:	linux-omap@vger.kernel.org
 L:	linux-fbdev@vger.kernel.org
 S:	Orphan
-F:	Documentation/arm/omap/dss.rst
+F:	Documentation/arch/arm/omap/dss.rst
 F:	drivers/video/fbdev/omap2/
 
 OMAP FRAMEBUFFER SUPPORT
diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index 577c75c83e25..bb3c6072fc82 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -22,7 +22,7 @@
  * in the kernel). So this driver offers straight forward, reliable single
  * touch functionality only.
  *
- * s.a. A20 User Manual "1.15 TP" (Documentation/arm/sunxi.rst)
+ * s.a. A20 User Manual "1.15 TP" (Documentation/arch/arm/sunxi.rst)
  * (looks like the description in the A20 User Manual v1.3 is better
  * than the one in the A10 User Manual v.1.5)
  */
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 0c567d9623cd..5f7d286871cf 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -6,7 +6,7 @@
  *		 Bo Shen <voice.shen@atmel.com>
  *
  * Links to reference manuals for the supported PWM chips can be found in
- * Documentation/arm/microchip.rst.
+ * Documentation/arch/arm/microchip.rst.
  *
  * Limitations:
  * - Periods start with the inactive level.
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 46ed668bd141..762429d5647f 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -8,7 +8,7 @@
  *		eric miao <eric.miao@marvell.com>
  *
  * Links to reference manuals for some of the supported PWM chips can be found
- * in Documentation/arm/marvell.rst.
+ * in Documentation/arch/arm/marvell.rst.
  *
  * Limitations:
  * - When PWM is stopped, the current PWM period stops abruptly at the next
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 398e5aac2e77..30bb9714f3c6 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -450,8 +450,8 @@ config SERIAL_SA1100
 	help
 	  If you have a machine based on a SA1100/SA1110 StrongARM(R) CPU you
 	  can enable its onboard serial port by enabling this option.
-	  Please read <file:Documentation/arm/sa1100/serial_uart.rst> for further
-	  info.
+	  Please read <file:Documentation/arch/arm/sa1100/serial_uart.rst> for
+	  further info.
 
 config SERIAL_SA1100_CONSOLE
 	bool "Console on SA1100 serial port"
-- 
2.40.1

