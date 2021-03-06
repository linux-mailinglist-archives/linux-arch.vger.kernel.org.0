Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D299532FB10
	for <lists+linux-arch@lfdr.de>; Sat,  6 Mar 2021 15:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhCFOGw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Mar 2021 09:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhCFOGq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Mar 2021 09:06:46 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D52CC06174A;
        Sat,  6 Mar 2021 06:06:46 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q20so4106338pfu.8;
        Sat, 06 Mar 2021 06:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hFx6a1I2nkJwtk6W8l3AUegmPbj3ciqvUl7VcTVF6SQ=;
        b=MwVXL98ND94wKWw5Al3YzSJNY2fzIAUCSOX9JbSUhk0C3PbvWpWz7v/sY0MuK5q5fz
         nF7k1NUu0qdr6lJm9XRHCHf82g/Fi0k4RRxcC5JgRkmRKQ1KFOce/XOqvX71KNfWniqr
         yo+fdfn+CDVnn8w0kVulF8fEOfWG/Y2GKBLp0lFrH8Y64SJ9zExqkVVkdASI2z9itKv8
         Z9LsLmU4tK/ZHiIpMXyrz/RLuTECx5yUzZGZ4Ih9mYe69dg2sC4hhaHINss1E3srg6Zq
         NXbDVYq0mLB/jncZceEbVXaHmb4H06XRn67N3YLX+5tdNJJibxttr34VXDBe2M52N9SF
         f8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hFx6a1I2nkJwtk6W8l3AUegmPbj3ciqvUl7VcTVF6SQ=;
        b=IfCxXrJT1fo8JOMKAaOIadjwGAO2eXwKpkSWf5DtflSJW1gPDEfBSHrchYE2YNJ5w6
         uZpFhblilhc6UHeGfYteKA6Cr4IXJwdH9r37o0ZsYM44QSxF4tUA0zrCtt9OuX2PeKYR
         C8RO6xWZeez7URwMZPLLRxh/CFb5/jDF673Yc8LRJBxWKiTN+AfT2BHWVGArv2x8kI3T
         YLuUL67WPgffLMPCGxBkUaU+CYAOQBVx3QfHcG6QEuBayUhW00rcRTiwiZQI678MkagI
         FmWoTECZzfejlxQ0HsP9CJ95y0u5NZUlL9xStTTn9GE2E770hW8Q730QW9OUGUgrJAMM
         TKPw==
X-Gm-Message-State: AOAM531/PSsuvCtZDTPtuinUKktSeFUs3Ggyoc4YaJd+CPNfAInXeM0U
        lFtbtRkl3T0yFIb4oSBJo34=
X-Google-Smtp-Source: ABdhPJxWRcBxypLN7aZe6ScySSrzKUnoLKLe8BuYkBosHIqL9XfpDozJjNmObmEzTOs1M0WRZNoosQ==
X-Received: by 2002:a65:50c8:: with SMTP id s8mr13040314pgp.68.1615039606113;
        Sat, 06 Mar 2021 06:06:46 -0800 (PST)
Received: from syed.domain.name ([103.201.127.38])
        by smtp.gmail.com with ESMTPSA id ds3sm5556779pjb.23.2021.03.06.06.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Mar 2021 06:06:45 -0800 (PST)
Date:   Sat, 6 Mar 2021 19:36:30 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     bgolaszewski@baylibre.com
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-arch@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and
 _set_value
Message-ID: <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
References: <cover.1615038553.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615038553.git.syednwaris@gmail.com>
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

Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-xilinx.c | 63 +++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index be539381fd82..8445e69cf37b 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -15,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include "gpiolib.h"
 
 /* Register Offset Definitions */
 #define XGPIO_DATA_OFFSET   (0x0)	/* Data register  */
@@ -141,37 +142,37 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
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
-- 
2.29.0

