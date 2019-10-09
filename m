Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2704AD1536
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfJIRP6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:15:58 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41443 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731948AbfJIRP2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:15:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id 129so1087876ywb.8;
        Wed, 09 Oct 2019 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBleGApOd9DY5AB30uyK9JEv+41JBB1+F0GtLYOX3MQ=;
        b=hwDrV73b1Avzv1ol5VQppYlIxu1TTuEK+isNnmnLVblA+yhsovmwg7qYnyTKByvRgk
         bxQBvPvUqDA+O/nOpVN0alP2eBcA13VvqM9ZPTXHsrZ6LQX+HRL8Xn+aFGWapS8oNDA/
         4ZtueKBJmaHTQytL3ObzqT8QkEiiQEP92dIzfq5QpY8QxhNJlRwgXJJYdzeenEOJWI0D
         fAT1lp4Pb2d4MiBr/7vlbyopDjeQ2cq/qndfd0MvciDrk9Q/oavaITOhrxTaZuCxiNy7
         LBTTeeJ8ubleTuZedOBOSJVn8h82ersc3dnGBCHLTpKiGR6RRPXyk3lXflTLge2UUwod
         nX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBleGApOd9DY5AB30uyK9JEv+41JBB1+F0GtLYOX3MQ=;
        b=gsvBQWCOMbAWKrVySRICQjWnUuMwpiro/yL5TVy1WVItuTHos/G3z+2neVSabTggtH
         XhLfcVRlS45E9aKgMBwAx5mm6qMjH96vUjc3L07r42rLgqNUYgfqg2idIHUvigFtdeMM
         Wlwd319DJzgGVE+9SL1ZnC7pWgm6KguCE8bUlvom/0+j/MJpKBUeGX3GPdeI641ZfE+B
         NlliVpN9rPJoEiW0/Bb/oR47Z7a7pKts/eB1KpzZnFtS49rA43lTeqNaytc1NSiTuXro
         0kFW2wSil4Vau/IUFYVvkxUdwLt7PVH+shRX4B/TLb+bPmtYcK9gkOSa8zKQa1Y/QL9W
         IDAA==
X-Gm-Message-State: APjAAAV6g8RyFaghwYWyGRQ6Xx1eAk7CUGe+VARVop4Cix5E29guBpvo
        /WQuM5UHlaxMv9/vhIZGGa7WPl47
X-Google-Smtp-Source: APXvYqw3uf467joL0uaxSBgA0rGZBGHi1rB15yRlN0gP0y58m3r2lite14ooWoULV1XQ2AZLPocVCw==
X-Received: by 2002:a81:2d41:: with SMTP id t62mr3704519ywt.368.1570641327784;
        Wed, 09 Oct 2019 10:15:27 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id r63sm743292ywg.36.2019.10.09.10.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:15:27 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v18 10/14] gpio: 74x164: Utilize the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 13:14:46 -0400
Message-Id: <7ea2df7182a50a1136ca36edc46dffcb2446fd27.1570641097.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570641097.git.vilhelm.gray@gmail.com>
References: <cover.1570641097.git.vilhelm.gray@gmail.com>
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

