Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B57709CB6
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjESQq0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjESQqY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 12:46:24 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4635BD2;
        Fri, 19 May 2023 09:46:23 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 0690F1C33;
        Fri, 19 May 2023 16:46:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0690F1C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684514783; bh=eVURbMBHrmInyI7Tt4uD2Av3f0HpAYpSD4vdn1u6NE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BupzjfOfZOGLRJU8WiQT2q3eixa3hd4KaaIcGsxvR6fh/FiWObhqBIRgaYEd6mmSm
         DJkLz7yDU3pqH7AohfM9GHX4pLbtf57aaO5xrWlKnJFs89bt8QdG8BdDfXripIMgRZ
         4Gs7nQq6N1AhQlkdPBVawTNegB1rx0qBnjg3LayGBzLhb6X2lgIgQRRONkhjlTq4n7
         F/6adrcv330tCvv0c7As+8ekx6/W76Thu0m+12MeBZvgVKow9Gst1xRqiTXR2DAreX
         s357bMKERGioqdOTxFlpOCHHU195G47SuIay4Q+8XdDvMr/euCv9OvWde856WEHPVl
         HQIbUpw1HkPeA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH 6/7] docs: update some straggling Documentation/arm references
Date:   Fri, 19 May 2023 10:46:06 -0600
Message-Id: <20230519164607.38845-7-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519164607.38845-1-corbet@lwn.net>
References: <20230519164607.38845-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 MAINTAINERS                          | 6 +++---
 drivers/input/touchscreen/sun4i-ts.c | 2 +-
 drivers/pwm/pwm-atmel.c              | 2 +-
 drivers/pwm/pwm-pxa.c                | 2 +-
 drivers/tty/serial/Kconfig           | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..09aa1b0ef552 100644
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
@@ -3058,7 +3058,7 @@ M:	Will Deacon <will@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
-F:	Documentation/arm64/
+F:	Documentation/arch/arm64/
 F:	arch/arm64/
 F:	tools/testing/selftests/arm64/
 X:	arch/arm64/boot/dts/
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

