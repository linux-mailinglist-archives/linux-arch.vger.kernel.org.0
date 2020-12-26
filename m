Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0962E2D7F
	for <lists+linux-arch@lfdr.de>; Sat, 26 Dec 2020 07:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgLZGo5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Dec 2020 01:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgLZGo5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Dec 2020 01:44:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ECCC061757;
        Fri, 25 Dec 2020 22:44:16 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id f14so3324967pju.4;
        Fri, 25 Dec 2020 22:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iXNqUNlDxA192iSDhXK8T34CWCe+lAvUgPxne7auzLU=;
        b=X3VqkGTtPHgY1bRWcNfIIEzEkd4CnRBVwL6y4V5NGTcXyshWxpSPWcwaHQU8OKHq6B
         yBpnK5X5s/GS0m91eQwyqhsBGtP3KFY5xpHkasoNxDOsGuajYXohFFWto5HX2wHOfyz6
         W8YvxplDXEFPL3eb5vXxsoD7GZ8hUqYo7ClG/2qpwlTFEzayzUR9sNvZlyckR2Z2S59r
         7FQO44kuK+Y/v/K0F6Rqei6vBf+rVPeMM3rCOUzxlS5eHYGQ/lVOcrm4y32oxnzB9D3H
         UmtXExLbDEPjcAVKVEGRSYCfj3yJwOkw/ODwlHCoEcawrRfmC3TUQIl2D6kI8gU4kCba
         sLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXNqUNlDxA192iSDhXK8T34CWCe+lAvUgPxne7auzLU=;
        b=rIMeG6kcMrJJV37Tf2Ex1iEMgGbwKQhDeFW/8QNgkqbHf6x/vu8/8sbDnZNEzgZC85
         vLQXt0bEwcvMBpDacQI9vA5rJzTYpxwmpv6+Lb/uZSC2L2JIkhWIZw6h523vis+P+31c
         87Oh44+IhmAeNT6hPCeDt6MyXYcZHXXAuMgGwu5ct+WMyCpC/r+O+1d3JcAqdpulELOx
         zY65+YcE3uxqx3QbnZ+1VmHb5226jg9AvYFcFeGBCv3bCtJJJ9l0nwJ42A5U3PPX2SSt
         c2oAssOZxxsaFKlY6RI+T2UqpsYh2S2v1by97UzINFZ+PjT/S5jhsYi7z+hdeG5RxFbn
         feeQ==
X-Gm-Message-State: AOAM532qlsvo2i5pkUt9snj09/0+WEO+CXHCzzZ1UcCfyYnD8xiEdn3Y
        vkvL9jVq9cIzYh+ty1VUQys=
X-Google-Smtp-Source: ABdhPJziO6I42bYuv8uPNtCMThaNM13m0w03d0WDcSIMvWOVwMMh5b8LH0b40IFyd3zK8pLldMrW0w==
X-Received: by 2002:a17:90b:128a:: with SMTP id fw10mr11311388pjb.113.1608965056485;
        Fri, 25 Dec 2020 22:44:16 -0800 (PST)
Received: from syed.domain.name ([103.201.127.53])
        by smtp.gmail.com with ESMTPSA id r185sm30254706pfc.53.2020.12.25.22.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 22:44:16 -0800 (PST)
Date:   Sat, 26 Dec 2020 12:13:58 +0530
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
Subject: [PATCH 3/5] gpio: thunderx: Utilize for_each_set_clump macro
Message-ID: <f450622ed527a63a4a9a05fce6fbb5062372c95b.1608963095.git.syednwaris@gmail.com>
References: <cover.1608963094.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608963094.git.syednwaris@gmail.com>
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
 drivers/gpio/gpio-thunderx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 9f66deab46ea..716b75ba7df6 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <asm-generic/msi.h>
+#include <../drivers/gpio/clump_bits.h>
 
 
 #define GPIO_RX_DAT	0x0
@@ -275,12 +276,15 @@ static void thunderx_gpio_set_multiple(struct gpio_chip *chip,
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

