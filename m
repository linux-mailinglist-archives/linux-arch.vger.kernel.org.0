Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A594319FCC
	for <lists+linux-arch@lfdr.de>; Fri, 12 Feb 2021 14:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhBLNX1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Feb 2021 08:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhBLNW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Feb 2021 08:22:56 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A852DC061574;
        Fri, 12 Feb 2021 05:22:15 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a24so3145223plm.11;
        Fri, 12 Feb 2021 05:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LlK4oOejkGmVCANiTlUnm8yrZASNqtveudOgthnjqjI=;
        b=iQSwM5JwXDKLM+rqGqJmII6cCxrZTr/MDyQJcOwWPdUIGET0SX5Dx13XxnWQoAB9ce
         Yl/C+Dxd75UvNlHjdqdFOvI3d49JZhiBywK3vO9N83sZOlwQU3mLGNoVFiFIMtzr/GHe
         vlII8OXJn+L2qWA7GV2gpHFjmDN84VXCKXAujllae/ClEjYEuu4ABe9ijORyyc99KJel
         iAWaJs2XjitDtSwsr1UsCh2gWMmCdk6GpV6sJLpKNDrjJ4LDnhm17LeQGe+6VHoprmpd
         qB/jEHYVAzgUPn1QREHwoiEfhRO/e2Is8Hpj3lwdSFIJdo12N8xnMPq0/3IQYvMeamib
         W4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LlK4oOejkGmVCANiTlUnm8yrZASNqtveudOgthnjqjI=;
        b=q5NcLFN9CElP2o+Glk8nn/D+z2yP8M6uLCbJBbi0xZUDht889ybZW2gPxPA5FtDe5M
         JNlHvViICdH8o3P8M6nI3ivJcYFjfBsqZEOq5WMGp+awrJNn4wrtBORtfjb00afVW6Ea
         X6ma2aEQgG8AjC7dCKGzt7HM+cqNDY8zq+fbdfA5c1qTOWE3lV2wVU3hn/bwhsX8JnF4
         YmQa4rcZOJFi/N2LxtRgRmwpNZR0tw/k93t/pMuG1R/HFQ1ZXc3aJf7RnAQdcJxk3GO7
         IytzFIvUcRiux99KVDQNC8Zl5ybcBIQ5S7ZDz3wFkZc41kWRYTC5PSxs7dnDMxZrHCSe
         i8yA==
X-Gm-Message-State: AOAM530oXakW7YIYVu7/P/+Rn6PLV4m4Zgr1P1cgXILOlR/JzARUwKeh
        6o4Zogh5i7m/OM+89L4hip4=
X-Google-Smtp-Source: ABdhPJyV9t8X6mKuwfE8e/aZK1KZFuuyTqGY4IAiBevhX62jo7ymr64zGlqJd1+zqtCK1Yew5apvoQ==
X-Received: by 2002:a17:90a:6549:: with SMTP id f9mr2754627pjs.17.1613136135243;
        Fri, 12 Feb 2021 05:22:15 -0800 (PST)
Received: from syed.domain.name ([103.201.127.1])
        by smtp.gmail.com with ESMTPSA id q43sm5591021pjq.25.2021.02.12.05.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 05:22:15 -0800 (PST)
Date:   Fri, 12 Feb 2021 18:52:00 +0530
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
Subject: [PATCH v2 3/3] gpio: xilinx: Utilize generic bitmap_get_value and
 _set_value
Message-ID: <1b1f706b60e4c571c4f17d53ac640e8bd8384856.1613134924.git.syednwaris@gmail.com>
References: <cover.1613134924.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613134924.git.syednwaris@gmail.com>
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

