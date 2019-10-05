Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6BECCC29
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2019 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbfJEShm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Oct 2019 14:37:42 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34711 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388376AbfJEShl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Oct 2019 14:37:41 -0400
Received: by mail-yb1-f196.google.com with SMTP id m1so3279044ybm.1;
        Sat, 05 Oct 2019 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBleGApOd9DY5AB30uyK9JEv+41JBB1+F0GtLYOX3MQ=;
        b=egDthNlO5s1umgtiK9FXRVpk0H9GX/8Bk4QnVFd0taoTP2G2W75xKExNc3DItM+yGe
         NT8ZFF86AYwqK8GxzNgtGfExj3BM6LRtJtvXUjQGElwEaOyAUOxa+xIjsiKjl0UXsWfY
         avUDFy9Zwk9UltQSsG5G50UP48SUbiLa4ssfOdxMbzkCKZf/6am2a1pFsXKNZJhvSVeT
         +l8uTf0oeaRTNeMcqeoWD0MmN6ci7lpMf+OdwvQDT6IaR1yLqnP0Begz4bTlAla2unZi
         oB9DRQKVGtvx+m9cgrXsAVAfpdcI5QWz7RxXMWjQVTwYa+m7XO+qHa745Xv3CgjIZ9ir
         nMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBleGApOd9DY5AB30uyK9JEv+41JBB1+F0GtLYOX3MQ=;
        b=qeGlTDBH8dmuBWfdvDgzx2XOxJAVmX/mlw5AbYEwySU+xlm8AQR7PADqb4+UWDsLzw
         Vd+gHs0Nc8v2Js7Gijv3j8E6++9XbB7WCyc8n0Dcw8QSbMXmIhh/UaVzkzkeXz88bzYd
         32b/oMD0JVIc9fwgRBzH0Ra0QzF3pJioUWQqXr0FzRMM4CE7wOTjOTmO0GZ03toL9dOF
         tl18QoiE6bROytfB545tBd6Zxc5DgzFO90q+dYgm/JXLXZ6YD3uvhKteE2j1+unlRJ7D
         V5R2DXMYRdq8DSQKyzgKOxaT8Shg/wNFTRw7T4VQ5gBBU1l4wm3N0lcScPIDUTCU8JQL
         GFEw==
X-Gm-Message-State: APjAAAU9qcwtZ4PUhwwppzOAmHz13wT/6uC8P53jZhAIb6bNeeyuJtWV
        mv71kJOkX7Xu3R1j9Sm3H6Q=
X-Google-Smtp-Source: APXvYqzKxM5mCQgIjs1RAvEfJcvGiax7iLdf5W+jgMhBy9kkswJ85EPFlrTvT2K6ujGjO9LBRrLhgQ==
X-Received: by 2002:a25:9886:: with SMTP id l6mr3641207ybo.104.1570300660641;
        Sat, 05 Oct 2019 11:37:40 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g128sm2376654ywb.13.2019.10.05.11.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 11:37:39 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v15 10/14] gpio: 74x164: Utilize the for_each_set_clump8 macro
Date:   Sat,  5 Oct 2019 14:37:04 -0400
Message-Id: <c22abead64720532d5fb93575fd9e5dfeb573a21.1570299719.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570299719.git.vilhelm.gray@gmail.com>
References: <cover.1570299719.git.vilhelm.gray@gmail.com>
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

