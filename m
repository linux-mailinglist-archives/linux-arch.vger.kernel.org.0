Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA9319FC7
	for <lists+linux-arch@lfdr.de>; Fri, 12 Feb 2021 14:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhBLNWN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Feb 2021 08:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhBLNWH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Feb 2021 08:22:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5FAC061574;
        Fri, 12 Feb 2021 05:21:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gx20so433975pjb.1;
        Fri, 12 Feb 2021 05:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O/3BA4PWnT2f4RUSGMom+2MnQBkrppTk3RLQijEPW1A=;
        b=CI5X+Hq+gKpTnweohO4hVWy0QNcS0e/Z1p6h3GGl3SDgUIcmrH2thRXHitu/3yBVx1
         w0zKYSoEBxImHtT4h6U8ZqGw+wpkHluw+jlR2oQOBriYBB+9hWC0qYn7bLqyDrVgFrdW
         C/JXAg+GSJbInwC+1w1spbqz/5Wkhz1PpLj/qbyk9FpFMT92P4FX+reJHzxbGcTv5Ody
         sgchSZy9OPkf5000p+X/B0o3dSv26eYoR8gfKDUhazlCpzUd58kTi1xRW/5CVOyixkK5
         XI1jr+a0XSySYLcHyRCiBrTJ/fmys0THSFrrzIibUfdMyhgOV5k313KrZQSxjhK4P9+t
         +EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O/3BA4PWnT2f4RUSGMom+2MnQBkrppTk3RLQijEPW1A=;
        b=Twa9rps8+hFGxSBvoJeI8VRMrruGOGlf+KsReZ3msfbxe0taqJAB6xXYkZBXFGloFe
         QN85JslS+4fQikxDruy47KfIVPBQQt2zUtEhOILCBN3r37Xic+iS8A813UaJyBp3tw7E
         aCymSnCxr+XPWCYBAiq3kf5Nzbr6N05+pO+Z2+ujY0SaAnHWLS8/GKAHHmlDh4h86NPw
         KUyPIzEcu2zuf5ctpHgc33H7/RyLl+rOrn6vWrzPhxg9t+Ls3mpyA3Hcw5uFprPorEvJ
         DhYdg/Fba76hxRksdaX4oqPLnn6Ph3Mzb4eSJwCwScsOj2cHMW9V1cxNUL4FEmQDRluX
         sD+w==
X-Gm-Message-State: AOAM530OmqsWc27wLrIPEFf7Y3s4314noR4vyu6N7ISy8QlJyG9FKjBc
        /axf8gGIAoZTP3E3Z+/Ih+g=
X-Google-Smtp-Source: ABdhPJw9tWvL+iS8ZZKqxM1FZEUFcyB0qqhDeIW1+FeHi3hFhHdeu5m2XqoqQDDmxiVE6lGaF6fFaQ==
X-Received: by 2002:a17:90a:8c87:: with SMTP id b7mr2807646pjo.158.1613136086127;
        Fri, 12 Feb 2021 05:21:26 -0800 (PST)
Received: from syed.domain.name ([103.201.127.1])
        by smtp.gmail.com with ESMTPSA id 71sm9403499pgh.55.2021.02.12.05.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 05:21:25 -0800 (PST)
Date:   Fri, 12 Feb 2021 18:51:04 +0530
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
Subject: [PATCH v2 2/3] gpio: thunderx: Utilize for_each_set_clump macro
Message-ID: <3fc5bd83322c94eb2a4f48677f6d762bf81d0652.1613134924.git.syednwaris@gmail.com>
References: <cover.1613134924.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613134924.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch reimplements the thunderx_gpio_set_multiple function in
drivers/gpio/gpio-thunderx.c to use the new for_each_set_clump macro.
Instead of looping for each bank in thunderx_gpio_set_multiple
function, now we can skip bank which is not set and save cycles.

Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Robert Richter <rrichter@marvell.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 drivers/gpio/gpio-thunderx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 9f66deab46ea..0398b2d2af4b 100644
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
+	for_each_set_clump(offset, gpio_mask, mask, chip->ngpio, 64) {
+		bank = offset / 64;
+		set_bits = bits[bank] & gpio_mask;
+		clear_bits = ~bits[bank] & gpio_mask;
 		writeq(set_bits, txgpio->register_base + (bank * GPIO_2ND_BANK) + GPIO_TX_SET);
 		writeq(clear_bits, txgpio->register_base + (bank * GPIO_2ND_BANK) + GPIO_TX_CLR);
 	}
-- 
2.29.0

