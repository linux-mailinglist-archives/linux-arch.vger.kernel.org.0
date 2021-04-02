Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BBF352998
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 12:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhDBKM7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 06:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDBKM7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 06:12:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D64C0613E6;
        Fri,  2 Apr 2021 03:12:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t18so2494086pjs.3;
        Fri, 02 Apr 2021 03:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=elvUwGrM418CXLIilNL/fwznJq0Mnf7UxWCgH8HJ9kg=;
        b=bxdBUcsc7T9mo2Lnd8uMQDUsshtUfkbRETbQsHPYB42RrNZ/m6ZOlhgozDLroTZYrN
         eON3MNfx2OHeuXOJ9Y0YosiPoGZ4eTRY0qPUvRXgcO2YAm64TkPJGRpj/ZP+IcFsKeHD
         hdYliySd+aDZPAVFw13NX0eJV4O8AR8edPEiM56usn6f5njihh4NOYdzH/AQprkH5VfK
         +9oDbjJEVymVdL03W10jK2IQtcd3wRhPVZdHwqbzwhbSE7wcJFaamH2iaB+U8agkvHuU
         SA94JWSWRiQKj+r0Hp1lRaU7pRxo1w36l3v6UFmsUfDBaeMO9Afp/l10N45s+Un3G9bX
         NZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=elvUwGrM418CXLIilNL/fwznJq0Mnf7UxWCgH8HJ9kg=;
        b=JhmSIrunidrbZt5lLp/uV7/W+IiYdDCjlGVQegADCeTvs1/Uzluoj3AYQlLsu67b5k
         nk6vbywCsD5b+VPjxlQJYNmvqIQZZ/zUPvmof9hJl7TaM//6z0TE1zubcV+H+JgjZr6r
         mX3qGYfW8FdS43Oj7s4rJ5VRd6PftDz1OLRgq0cQPGco/UmWU7J3D6jsIepC2kX/G1Ks
         vu3Ua46zjM8ILCJSYJW7f1GeXJsCTH1ABg75R/Gg5kh1u+Bl+8yWOKRqvYkcc8jQjGYI
         uP292bFhjEtSAIar0jHHylRUKuKPZs0GHM8P1TP1BGMg9WZzjM1NePB8CdgWVzVQ1nvw
         hMLw==
X-Gm-Message-State: AOAM531V9+2rXLstK5ikPZO/1U668BYwxwUewAJQnjtvId8jQYImADvK
        zO3ShhXqP1p42bx/sAPhR54=
X-Google-Smtp-Source: ABdhPJylA1WmAAVPuY/l/zHcqiwsL0HAoW7BKAkydfxcDxaVE/yXGSiIi6gPAbUvQDDTz+K36uZDUg==
X-Received: by 2002:a17:902:b602:b029:e6:cabb:10b9 with SMTP id b2-20020a170902b602b02900e6cabb10b9mr11967011pls.47.1617358378281;
        Fri, 02 Apr 2021 03:12:58 -0700 (PDT)
Received: from syed ([223.225.111.29])
        by smtp.gmail.com with ESMTPSA id a18sm8419755pfa.18.2021.04.02.03.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 03:12:58 -0700 (PDT)
Date:   Fri, 2 Apr 2021 15:42:40 +0530
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
Subject: [PATCH v4 3/3] gpio: xilinx: Utilize generic bitmap_get_value and
 _set_value
Message-ID: <00d085d4068be651c58a61564926d4f3d495ab80.1617357235.git.syednwaris@gmail.com>
References: <cover.1617357235.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617357235.git.syednwaris@gmail.com>
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
 drivers/gpio/gpio-xilinx.c | 60 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index b411d3156e0b..e0ad3a81f216 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -18,6 +18,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include "gpiolib.h"
 
 /* Register Offset Definitions */
 #define XGPIO_DATA_OFFSET   (0x0)	/* Data register  */
@@ -161,37 +162,36 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 {
 	unsigned long flags;
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
-	int index = xgpio_index(chip, 0);
-	int offset, i;
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
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
-			spin_unlock_irqrestore(&chip->gpio_lock, flags);
-			index =  xgpio_index(chip, i);
-			spin_lock_irqsave(&chip->gpio_lock, flags);
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
-	spin_unlock_irqrestore(&chip->gpio_lock, flags);
+    u32 *state = chip->gpio_state;
+    unsigned int *width = chip->gpio_width;
+    DECLARE_BITMAP(old, 64);
+    DECLARE_BITMAP(new, 64);
+    DECLARE_BITMAP(changed, 64);
+
+    spin_lock_irqsave(&chip->gpio_lock, flags);
+
+    /* Copy initial value of state bits into 'old' bit-wise */
+    bitmap_set_value(old, 64, state[0], width[0], 0);
+    bitmap_set_value(old, 64, state[1], width[1], width[0]);
+    /* Copy value from 'old' into 'new' with mask applied */
+    bitmap_replace(new, old, bits, mask, gc->ngpio);
+
+    bitmap_from_arr32(old, state, 64);
+    /* Update 'state' */
+    state[0] = bitmap_get_value(new, 0, width[0]);
+    state[1] = bitmap_get_value(new, width[0], width[1]);
+    bitmap_from_arr32(new, state, 64);
+    /* XOR operation sets only changed bits */
+    bitmap_xor(changed, old, new, 64);
+
+    if (((u32 *)changed)[0])
+        xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET, state[0]);
+    if (((u32 *)changed)[1])
+        xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
+                XGPIO_CHANNEL_OFFSET, state[1]);
+
+    spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
 
 /**
-- 
2.29.0

