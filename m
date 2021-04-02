Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A84A352992
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBKMY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 06:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDBKMX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 06:12:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B2CC0613E6;
        Fri,  2 Apr 2021 03:12:22 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j25so3341630pfe.2;
        Fri, 02 Apr 2021 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pjJTs/trNbCfk/Wd5AeG0sctmtT3vopPWM58p/JWi08=;
        b=X0pl6oiDGAB8riJRc8TdXBwVXf3oZNvOJwhTa2W7pA6M5M9hyfmX2bdbKbwz3pblYH
         IYZg697aXp3DpAZFoRpEwUwnG4Ag90KNmwmeUStf6J9wmarh7MIONtvf1++OG7p/D7JQ
         vHyoAHEujja+kgxFzY7F8rpzz/L+xoNeoT4okBQ8ARmhePe0AW0pahn3rGDhiHWW1FTW
         7ArCZ4+c3aZn6tz5iajWiKbQC0bX/UUDgt8X8asCIgEhk7QA4Fapo+SASiuOZj+hAU79
         E/RLY4srtg9kbXu4wHonooy57C3VgAQVj3IZLjA1ySSBcQRCXQ5L/hgzGa6aWDUkWF8Q
         glGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pjJTs/trNbCfk/Wd5AeG0sctmtT3vopPWM58p/JWi08=;
        b=SyMs5h+Z9eOR7717/2L4aVb2ovv/v1Mk37veRGhOo7AKIK/OlMD7Prm91QjT8ei4+g
         Bl+ajISffKyzI8J5JdVKBawgfQIN5uAjufeKuE6iAtbdZLBQodVwLG0vMNW3FzMLjbpi
         96Ve2wyMltFZioY1/y37/IYKR+dI2LpcgjnNXPUPEvuaefB+Ckxyaq7pGU2QGK8GrR7C
         oanhBaoJKpjtjKsPsvUVeXYr/43CUsTMfqbQotFu7nZ/mX8X6/Oxk4ifkc7Kv1YOmFYn
         Mb142h82lVQCQ8P6YV4g92+F2rGTZACrao8p6fl/bbBczX834QZpnfNBhf6Z2M2uAt6X
         J4Xw==
X-Gm-Message-State: AOAM531npC7X9VoKs48ufQuyaXY0ArLfxOmP+1wZUi285ZdcEJEL+k3L
        fjMh+slyx3bPqaTUFD/uoRM=
X-Google-Smtp-Source: ABdhPJw8RJb7DEr9GjqHs0QTLVJduTr4bs7vTfx3FKXKyLa3wkOCb2XxgyvGtFl04jQnovTx3jM9Cw==
X-Received: by 2002:a63:f542:: with SMTP id e2mr11371560pgk.338.1617358342446;
        Fri, 02 Apr 2021 03:12:22 -0700 (PDT)
Received: from syed ([223.225.111.29])
        by smtp.gmail.com with ESMTPSA id b84sm8051524pfb.162.2021.04.02.03.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 03:12:22 -0700 (PDT)
Date:   Fri, 2 Apr 2021 15:42:06 +0530
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
Subject: [PATCH v4 2/3] gpio: thunderx: Utilize for_each_set_nbits macro
Message-ID: <3a9bd0a593798538bec54d8b5ceab20a73d7eaa1.1617357235.git.syednwaris@gmail.com>
References: <cover.1617357235.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617357235.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch reimplements the thunderx_gpio_set_multiple function in
drivers/gpio/gpio-thunderx.c to use the new for_each_set_nbits macro.
Instead of looping for each bank in thunderx_gpio_set_multiple
function, now we can skip bank which is not set and save cycles.

Cc: Robert Richter <rrichter@marvell.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-thunderx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 9f66deab46ea..4349e7393a1d 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <asm-generic/msi.h>
-
+#include "gpiolib.h"
 
 #define GPIO_RX_DAT	0x0
 #define GPIO_TX_SET	0x8
@@ -275,12 +275,15 @@ static void thunderx_gpio_set_multiple(struct gpio_chip *chip,
 				       unsigned long *bits)
 {
 	int bank;
-	u64 set_bits, clear_bits;
+	unsigned long set_bits, clear_bits, gpio_mask;
+	unsigned long offset;
+
 	struct thunderx_gpio *txgpio = gpiochip_get_data(chip);
 
-	for (bank = 0; bank <= chip->ngpio / 64; bank++) {
-		set_bits = bits[bank] & mask[bank];
-		clear_bits = ~bits[bank] & mask[bank];
+	for_each_set_nbits(offset, gpio_mask, mask, chip->ngpio, 64) {
+		bank = offset / 64;
+		set_bits = bits[bank] & gpio_mask;
+		clear_bits = ~bits[bank] & gpio_mask;
 		writeq(set_bits, txgpio->register_base + (bank * GPIO_2ND_BANK) + GPIO_TX_SET);
 		writeq(clear_bits, txgpio->register_base + (bank * GPIO_2ND_BANK) + GPIO_TX_CLR);
 	}
-- 
2.29.0

