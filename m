Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745DE352DD5
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhDBQhy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbhDBQhx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 12:37:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952BC0613E6;
        Fri,  2 Apr 2021 09:37:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w11so2737815ply.6;
        Fri, 02 Apr 2021 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y8eBCCmlCiBAb49e1Y44XUdLGF33+F00lNn7YXoNQhY=;
        b=KqSpFXxoAFj8zHVyLFT5IkMX4zwL3c8hnpc9JsakNm1CZF9IM3UGDbEnWaMcb2mMmo
         Q/MWeiiRAzvfoWInmPS1blTIipL/ScTf4jC244bntda/aGUjxfJ0EpO0Ny1zzhooAcaH
         mq43vWBksxacKe8s7/I16HSHsuDik6MLfmRa+qTlZOcdYSy9QY1kAxDpoJSu/Neml0XY
         jBYsELkh3XAYBRveHCc4Yjy7zJwYieQmgKALjbSO/8YH3Tc68y1xL8r2iPqUwDUehANo
         HWMksLHa8GKauJpUdqdqWDsxmcX4u/dWfKgDiMhlk6h19f+Ojcaii/OLE24awJXjNcdL
         ktmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y8eBCCmlCiBAb49e1Y44XUdLGF33+F00lNn7YXoNQhY=;
        b=Qq6cBpq76d6klR6/XDU966Bs0rdhZzqkiJz3hD/8EJUO9ZggKuCoPjEJTYXV6Bkc2U
         7pfboVwX5Nz3BGbgefvn8MPkhfTsRKtWnhvJzSPvexQk0EEBGQn4OgtiJpJa9ynisGIr
         OeGfpuQhq0MhsGDhaJ2UiyUqjlUCb2zgd2x+bwPmXccwpMDW5Dt6FZKhVo/miugp0Yw1
         zu16l2zKxkgHrmUMD4TciK1WxBd+VmANS5y1o12SNFJsmusp9Jr3uk9e3vsYfS0BGjHa
         6xLAa2Jht+np2RJSCQ6j5C/e4Z95QWtZJKsmbnDNQParlJQRMk1bqtsRlRGguRYhYj2B
         lqww==
X-Gm-Message-State: AOAM532JFrvLbHGhReOdY3zzgo2q9/zXMhSWi5+TJWwE3Io8umvoQ71j
        xNSdOFn+xHfajBpZYLCtfLY=
X-Google-Smtp-Source: ABdhPJyGQMF+MUGjKiku6ifz1SggVMS5kG1l6WlgiEaxFGfXZfiER05E3luxOPCRSpCAxle6KdWV1w==
X-Received: by 2002:a17:902:7b90:b029:e6:f01d:9db2 with SMTP id w16-20020a1709027b90b02900e6f01d9db2mr13415174pll.69.1617381472160;
        Fri, 02 Apr 2021 09:37:52 -0700 (PDT)
Received: from syed ([223.225.109.149])
        by smtp.gmail.com with ESMTPSA id g10sm8352570pfh.212.2021.04.02.09.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 09:37:51 -0700 (PDT)
Date:   Fri, 2 Apr 2021 22:07:36 +0530
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
Subject: [RESEND PATCH v4 3/3] gpio: xilinx: Utilize generic bitmap_get_value
 and _set_value
Message-ID: <d150bd18acc767c86c23ec06cc2abd5ca74ccbbb.1617380819.git.syednwaris@gmail.com>
References: <cover.1617380819.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617380819.git.syednwaris@gmail.com>
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
 drivers/gpio/gpio-xilinx.c | 52 +++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index b411d3156e0b..512198250b02 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -18,6 +18,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include "gpiolib.h"
 
 /* Register Offset Definitions */
 #define XGPIO_DATA_OFFSET   (0x0)	/* Data register  */
@@ -161,35 +162,34 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 {
 	unsigned long flags;
 	struct xgpio_instance *chip = gpiochip_get_data(gc);
-	int index = xgpio_index(chip, 0);
-	int offset, i;
 
-	spin_lock_irqsave(&chip->gpio_lock, flags);
+	u32 *state = chip->gpio_state;
+	unsigned int *width = chip->gpio_width;
+	DECLARE_BITMAP(old, 64);
+	DECLARE_BITMAP(new, 64);
+	DECLARE_BITMAP(changed, 64);
 
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
+	spin_lock_irqsave(&chip->gpio_lock, flags);
 
-	xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
-		       index * XGPIO_CHANNEL_OFFSET, chip->gpio_state[index]);
+	/* Copy initial value of state bits into 'old' contiguously */
+	bitmap_set_value(old, 64, state[0], width[0], 0);
+	bitmap_set_value(old, 64, state[1], width[1], width[0]);
+	/* Copy value from 'old' into 'new' with mask applied */
+	bitmap_replace(new, old, bits, mask, gc->ngpio);
+
+	bitmap_from_arr32(old, state, 64);
+	/* Update 'state' */
+	state[0] = bitmap_get_value(new, 0, width[0]);
+	state[1] = bitmap_get_value(new, width[0], width[1]);
+	bitmap_from_arr32(new, state, 64);
+	/* XOR operation sets only changed bits */
+	bitmap_xor(changed, old, new, 64);
+
+	if (((u32 *)changed)[0])
+		xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET, state[0]);
+	if (((u32 *)changed)[1])
+		xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
+			XGPIO_CHANNEL_OFFSET, state[1]);
 
 	spin_unlock_irqrestore(&chip->gpio_lock, flags);
 }
-- 
2.29.0

