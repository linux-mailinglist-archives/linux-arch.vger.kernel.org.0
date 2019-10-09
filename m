Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5CAD129A
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 17:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfJIP1w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 11:27:52 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39878 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731773AbfJIP1v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 11:27:51 -0400
Received: by mail-yb1-f193.google.com with SMTP id v37so863661ybi.6;
        Wed, 09 Oct 2019 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBleGApOd9DY5AB30uyK9JEv+41JBB1+F0GtLYOX3MQ=;
        b=GAaw4kQJZ1t/twSnzYGj1Ye+b2rWZfgSQigTMAkCGXs7faRp9kbxzc+viRchH0iOUw
         jLQduPFHhg85mw9CZKGs3ZHhhcP9FaLFjY7wCSatMrfXGPdGXT9se2sj+/BL99Q2YvBc
         eyDG9o7N4Ton97yqY0ikl+XbQCOVNJW1GjnMWMNz+ysIw1dfIuCgoRxG5vWC6TmUuqjA
         on7aOT8hdds8tMqafPa8Np3qYdKvVkxrARA6ZLjvfnUqUMdn7xzUcrMz8yEoVs6EQA2x
         SbfDGVkowS8BcodygfJLou5vUSTzh7Ua2TWnGZSWh9VyAFMnVaTfPX2A90XPh5J0yFAF
         /rpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBleGApOd9DY5AB30uyK9JEv+41JBB1+F0GtLYOX3MQ=;
        b=lRSqjhgespL/rfvhdM+XW1i3hXXhn0tqub/DkAQh/C3bH0dv/JpOOllfxr+HhVeCOL
         +xC9GhZCUrzh5vb53/+mKc94P9mTBqP27ul8IYr31kSKnR/xtNbSdC1vuJ9TQtv3k/R+
         +zbkh+xvvX/lqhXIzg6WL72/h0n1E7w3iDnqp9WQpcTRitM5t9/o+AhpFtHZqUjh7pZ5
         F2WLlXkk1KaXZt1QEk3zyikZQsj5Uz19xxZuX3rdr76siOP/FZpimGiWHkIEXWx6ankL
         +BoB/wiCF1lDmeOVM2Jw50Esztbo96sVm7lrdxw6rFMPaT4H8bEE0Yrq2CqGewoBWJBJ
         r3ig==
X-Gm-Message-State: APjAAAXMhTs7ckvmSl4vN/RHIPRxLYYEP8gNCJCHlHqMfh32L3SHPdCT
        vHgg0CzK9Eh0pbnJVtq6Cw8=
X-Google-Smtp-Source: APXvYqwYZQffEOxLcR2DnXodNBQuIf2G4FM0ZYog/FMeKsA3x5ZeM6hVk9B5ifb9KwyjltXl8dzmPA==
X-Received: by 2002:a25:ba84:: with SMTP id s4mr2426092ybg.343.1570634870310;
        Wed, 09 Oct 2019 08:27:50 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g40sm611863ywk.14.2019.10.09.08.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:49 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v17 10/14] gpio: 74x164: Utilize the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 11:27:08 -0400
Message-Id: <ca28331339e17b7c7e3d802ce68d87ca955be7c5.1570633189.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570633189.git.vilhelm.gray@gmail.com>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace verbose implementation in set_multiple callback with
for_each_set_clump8 macro to simplify code and improve clarity.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Reid <preid@electromag.com.au>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-74x164.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index e81307f9754e..05637d585152 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2010 Miguel Gaio <miguel.gaio@efixo.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
@@ -72,20 +73,18 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 				    unsigned long *bits)
 {
 	struct gen_74x164_chip *chip = gpiochip_get_data(gc);
-	unsigned int i, idx, shift;
-	u8 bank, bankmask;
+	unsigned long offset;
+	unsigned long bankmask;
+	size_t bank;
+	unsigned long bitmask;
 
 	mutex_lock(&chip->lock);
-	for (i = 0, bank = chip->registers - 1; i < chip->registers;
-	     i++, bank--) {
-		idx = i / sizeof(*mask);
-		shift = i % sizeof(*mask) * BITS_PER_BYTE;
-		bankmask = mask[idx] >> shift;
-		if (!bankmask)
-			continue;
+	for_each_set_clump8(offset, bankmask, mask, chip->registers * 8) {
+		bank = chip->registers - 1 - offset / 8;
+		bitmask = bitmap_get_value8(bits, offset) & bankmask;
 
 		chip->buffer[bank] &= ~bankmask;
-		chip->buffer[bank] |= bankmask & (bits[idx] >> shift);
+		chip->buffer[bank] |= bitmask;
 	}
 	__gen_74x164_write_config(chip);
 	mutex_unlock(&chip->lock);
-- 
2.23.0

