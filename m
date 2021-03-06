Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E3A32FB0D
	for <lists+linux-arch@lfdr.de>; Sat,  6 Mar 2021 15:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCFOGS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Mar 2021 09:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhCFOGI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Mar 2021 09:06:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91051C06174A;
        Sat,  6 Mar 2021 06:06:08 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id a4so3321514pgc.11;
        Sat, 06 Mar 2021 06:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pjJTs/trNbCfk/Wd5AeG0sctmtT3vopPWM58p/JWi08=;
        b=U2dKt8r15x6xUAhghcKyWldESLJ+JznFIoFYGd07CPrypf+p0aU5j0naQ92c7rEnSz
         gOI6IkxzWLAd0SDJVUKfcRQ4U2QjHyIkbRRhgJyZZtu9b5OTri115mV1W/ZH60C/e0l7
         fPDhbAsJxfnRsLJ7Hcg8+QW5lriKOQuzP3iUKDjOAe/MM00ydVMRq9PzkFFdnvAWTTb8
         WuTp9s6FIOTYhmv8DsQMUgE0+X1Xckm4RKIqgWdo22rZc2BM3Ek9pOKWgxzgCMGi6FTu
         xjRU3IN8LRbwASa/3jB7UKZOHRHtIbYP4ZIdYYkNd1OUfQ1SaZc5iwRmX9hS/bSCo8Tq
         HdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pjJTs/trNbCfk/Wd5AeG0sctmtT3vopPWM58p/JWi08=;
        b=makuOH23BNVsCWReO6TSc0jUCnAmgcxVKgMy6ni76YRdHRMFTKp5oF6Q9IMv+iSrQq
         Iq2ksUcBaVc0H/a0pvUiUw7EAO/sC7ZDkV5b/wBIAYN1+0dDLGvdFTxADxs4shsS1FM2
         VFpv03lTQ3CkSv6M1KtfQa0/fofCQg961/MjPoUgpjcRN5xgTIfqTldYPppckaDd6d+O
         J83dPWpTIeP3nLrxvNJr78fFFGiKGpyvGPJ2IKCys20ao01sUNehlKbpxS+4vY7GvOXf
         xyeFgA382tEdW+FkPdwnlSOeU31AL+S44kSwmcv8Cd/PGxyZTJSgzkNdYGMb6RAnGZzP
         0LXQ==
X-Gm-Message-State: AOAM532eLMu7dH478YsZif2wBCZ40aUTJDCGw4pafDVn9GWvr1kAfg8w
        2W+cDqFQAGLTIErtlQctv0k=
X-Google-Smtp-Source: ABdhPJyrmi1GNywyCTn5R2TbF405UJjc01fZTgmZwZByuwvOlyJeKPbq3BvIh/c8EzjKN+xbT7uSjw==
X-Received: by 2002:a62:3c4:0:b029:1ee:9771:2621 with SMTP id 187-20020a6203c40000b02901ee97712621mr13166864pfd.47.1615039568194;
        Sat, 06 Mar 2021 06:06:08 -0800 (PST)
Received: from syed.domain.name ([103.201.127.38])
        by smtp.gmail.com with ESMTPSA id w4sm5688111pjk.55.2021.03.06.06.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Mar 2021 06:06:07 -0800 (PST)
Date:   Sat, 6 Mar 2021 19:35:53 +0530
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
Subject: [PATCH v3 2/3] gpio: thunderx: Utilize for_each_set_nbits macro
Message-ID: <ba0f16c62a3993a43ce747a0d7c342477b99778f.1615038553.git.syednwaris@gmail.com>
References: <cover.1615038553.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615038553.git.syednwaris@gmail.com>
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

