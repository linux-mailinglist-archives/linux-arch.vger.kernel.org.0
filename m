Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C35D2E2D85
	for <lists+linux-arch@lfdr.de>; Sat, 26 Dec 2020 07:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgLZGpj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Dec 2020 01:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgLZGpi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Dec 2020 01:45:38 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53F6C061757;
        Fri, 25 Dec 2020 22:44:58 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b5so3688875pjl.0;
        Fri, 25 Dec 2020 22:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cZo3+PTw5pWRpFSTiqw1bRSlqmiociXW1JsWTNxLob8=;
        b=iZ+Wpcc7/IQWhI4wMBZGCPIkMQJA+acaZVVTBh/TlCPTfXQjcGbp767i84K4svjtI7
         6SJCAymiH3M8GwFWtvR8dSdghLgA38wwMDo9UyyDSU8Sr7SuwgT2fam/IiX2t7H5JZGF
         NtFW66fysXXfVgCb7e182OcWYXbbQVY6LqnobPck+pNVWktfJGRMevt4ew83kQRPGAkA
         hTjW+FLbyv7BXFJoWkZlo88b4435AUVGKc53foov9SgFlfe3QOPbtSkH02ehNliR073r
         cMDYQI0cuHr+E1ejmnYfhGzcPgwcmS90TDfElErHpARErgRYJU4hLcnbt6uqjwCxv0np
         TJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cZo3+PTw5pWRpFSTiqw1bRSlqmiociXW1JsWTNxLob8=;
        b=NmitQOXFWrUuyRrzseAEajrUGHYNnIaeG0EGHb1x6PV1KCzN4v85iHct+e+RBHUvnr
         OUV0JOPgkzB2klqWIe/Mh6yJGn2R2N1NeaVQ7j9tlXsbeA9Ve/E8F8fo3N8H+fpFVHOO
         jsSh3vQfgfxQNCeKGb1+PaJbfyX20RvpP8BohzfDq4sTk3Daki+sFhsfCllbRW4uTH4I
         ahJkqEgmD8hKn2/T3rchwYibPnei1bWF3ZghCxKBLnsu9+xe2DryV+JyXtWSagxjfRsC
         b+PaqVIMKcpm7bbRH4SwQTRPe78g65BJqd9GEwOcMdV5jLZ70n8U1IqGTNuf+gZ9Uwfo
         kbrQ==
X-Gm-Message-State: AOAM532BluIkc8ruDVFQmeWQeXydsp11/Z0A30aYnJJWA2yRizwWVxLC
        B59xmkj+NJDrLZFkuiqVe7Q=
X-Google-Smtp-Source: ABdhPJyTgzQyaOsw2EQX1jkSxgJS0PHPt5PYfLQx9hMZANlBul5W9aNDXuwUDL6hXacSn9N2QcsOPw==
X-Received: by 2002:a17:902:d351:b029:db:e003:3b88 with SMTP id l17-20020a170902d351b02900dbe0033b88mr35705660plk.70.1608965098364;
        Fri, 25 Dec 2020 22:44:58 -0800 (PST)
Received: from syed.domain.name ([103.201.127.53])
        by smtp.gmail.com with ESMTPSA id k18sm6840856pjz.26.2020.12.25.22.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 22:44:57 -0800 (PST)
Date:   Sat, 26 Dec 2020 12:14:42 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-arch@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 4/5] gpio: xilinx: Utilize generic bitmap_get_value and
 _set_value
Message-ID: <5041c8cfc423f046ca9cf4f8f0a8bd03552ab6ea.1608963095.git.syednwaris@gmail.com>
References: <cover.1608963094.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608963094.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch reimplements the xgpio_set_multiple() function in
drivers/gpio/gpio-xilinx.c to use the new generic functions:
bitmap_get_value() and bitmap_set_value(). The code is now simpler
to read and understand. Moreover, instead of looping for each bit
in xgpio_set_multiple() function, now we can check each channel at
a time and save cycles.

Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 drivers/gpio/gpio-xilinx.c | 66 +++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 67f9f82e0db0..d565fbf128b7 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/gpio/driver.h>
 #include <linux/slab.h>
+#include <../drivers/gpio/clump_bits.h>
 
 /* Register Offset Definitions */
 #define XGPIO_DATA_OFFSET   (0x0)	/* Data register  */
@@ -138,37 +139,37 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 {
 	unsigned long flags;
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
-	int index = xgpio_index(chip, 0);
-	int offset, i;
-
-	spin_lock_irqsave(&chip->gpio_lock[index], flags);
-
-	/* Write to GPIO signals */
-	for (i = 0; i < gc->ngpio; i++) {
-		if (*mask == 0)
-			break;
-		/* Once finished with an index write it out to the register */
-		if (index !=  xgpio_index(chip, i)) {
-			xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
-				       index * XGPIO_CHANNEL_OFFSET,
-				       chip->gpio_state[index]);
-			spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
-			index =  xgpio_index(chip, i);
-			spin_lock_irqsave(&chip->gpio_lock[index], flags);
-		}
-		if (__test_and_clear_bit(i, mask)) {
-			offset =  xgpio_offset(chip, i);
-			if (test_bit(i, bits))
-				chip->gpio_state[index] |= BIT(offset);
-			else
-				chip->gpio_state[index] &= ~BIT(offset);
-		}
-	}
-
-	xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
-		       index * XGPIO_CHANNEL_OFFSET, chip->gpio_state[index]);
-
-	spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
+	u32 *const state = chip->gpio_state;
+	unsigned int *const width = chip->gpio_width;
+
+	DECLARE_BITMAP(old, 64);
+	DECLARE_BITMAP(new, 64);
+	DECLARE_BITMAP(changed, 64);
+
+	spin_lock_irqsave(&chip->gpio_lock[0], flags);
+	spin_lock(&chip->gpio_lock[1]);
+
+	bitmap_set_value(old, 64, state[0], width[0], 0);
+	bitmap_set_value(old, 64, state[1], width[1], width[0]);
+	bitmap_replace(new, old, bits, mask, gc->ngpio);
+
+	bitmap_set_value(old, 64, state[0], 32, 0);
+	bitmap_set_value(old, 64, state[1], 32, 32);
+	state[0] = bitmap_get_value(new, 0, width[0]);
+	state[1] = bitmap_get_value(new, width[0], width[1]);
+	bitmap_set_value(new, 64, state[0], 32, 0);
+	bitmap_set_value(new, 64, state[1], 32, 32);
+	bitmap_xor(changed, old, new, 64);
+
+	if (((u32 *)changed)[0])
+		xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET,
+				state[0]);
+	if (((u32 *)changed)[1])
+		xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
+				XGPIO_CHANNEL_OFFSET, state[1]);
+
+	spin_unlock(&chip->gpio_lock[1]);
+	spin_unlock_irqrestore(&chip->gpio_lock[0], flags);
 }
 
 /**
@@ -292,6 +293,7 @@ static int xgpio_probe(struct platform_device *pdev)
 		chip->gpio_width[0] = 32;
 
 	spin_lock_init(&chip->gpio_lock[0]);
+	spin_lock_init(&chip->gpio_lock[1]);
 
 	if (of_property_read_u32(np, "xlnx,is-dual", &is_dual))
 		is_dual = 0;
@@ -313,8 +315,6 @@ static int xgpio_probe(struct platform_device *pdev)
 		if (of_property_read_u32(np, "xlnx,gpio2-width",
 					 &chip->gpio_width[1]))
 			chip->gpio_width[1] = 32;
-
-		spin_lock_init(&chip->gpio_lock[1]);
 	}
 
 	chip->gc.base = -1;
-- 
2.29.0

