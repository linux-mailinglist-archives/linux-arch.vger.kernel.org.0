Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE344352DD2
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhDBQhI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 12:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhDBQhH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 12:37:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA5C061788;
        Fri,  2 Apr 2021 09:37:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t20so2717605plr.13;
        Fri, 02 Apr 2021 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pjJTs/trNbCfk/Wd5AeG0sctmtT3vopPWM58p/JWi08=;
        b=rniiW33V+k97vWR8A63gBXFhFoayK+VhrSPyN1QPh9Q05cqI9iknScGDIOHhzW37Q3
         E9Yeo9XdchviKP8uebuKKVt6GzcbpKPZ325d3bjBTCpPdvbGtgZPVghMQNxYDEW/wsAr
         JRtIPcxsd9klpDnHOdoxgmSv2jYQEJaSa1txLdmw3oyj+gLMyJojW8ltMvoKHWB4yjIb
         WzuZMPiVA6tDbreMXiSoHzko92sLTCW3oKyE3A59LT2zBCBH3dItDq8zS5ZH+kitDXle
         JYAx/1dLyBGTl0mP/EPhQbsrcx6tl14JBk2PPq636maGraNQ/llDWmpeDKMswZ/xCTqU
         5zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pjJTs/trNbCfk/Wd5AeG0sctmtT3vopPWM58p/JWi08=;
        b=Zr7vwEDEHwzXzhIKErWlNt5RWJGqv7DpHyWQMgyob6FnsNPDxwB1IUGYRxtzZLjhuc
         x7LCh6h4R/WhvgKq8fvSA7R+dE3FkNhl0wuu1VFCWu+9mDdX8opS6R6O2ekFamN38/Dp
         B5LLFkZktLRPdjlhBCVG2AsuV0Vn9sT9cATc7wuN4Jl/U5ncHvBVA9bk5WNRfiUj9wCS
         709x3IrxIY5N/ebLoY71kVftp74Zmh1kbLBRvXcoaqQaJpacF94K5w+7uZbwGNQ3lss3
         0wrXxUYedowwDJQYL2dUlSakb7PEuTWP33HUdbAXp15IPTPoFahUiitf4DFd8tXt5a5i
         5I/w==
X-Gm-Message-State: AOAM5313Ap7+gyHr+8EaY4oiLLIkHjlkbAot7drvW2EMV6vqQacsKRXX
        TuxXD+52mz6JutB5oT1Z6xk=
X-Google-Smtp-Source: ABdhPJz1n7/WaQ0+zG3NLK93leEDb2jZHXIhU7HWtvH1pbg2UjdBAdvabxAjuykg5CqXPqw5r+36CA==
X-Received: by 2002:a17:90a:a613:: with SMTP id c19mr14848896pjq.141.1617381425020;
        Fri, 02 Apr 2021 09:37:05 -0700 (PDT)
Received: from syed ([223.225.109.149])
        by smtp.gmail.com with ESMTPSA id 23sm8698123pgo.53.2021.04.02.09.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 09:37:04 -0700 (PDT)
Date:   Fri, 2 Apr 2021 22:06:48 +0530
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
Subject: [RESEND PATCH v4 2/3] gpio: thunderx: Utilize for_each_set_nbits
 macro
Message-ID: <3a9bd0a593798538bec54d8b5ceab20a73d7eaa1.1617380819.git.syednwaris@gmail.com>
References: <cover.1617380819.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617380819.git.syednwaris@gmail.com>
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

