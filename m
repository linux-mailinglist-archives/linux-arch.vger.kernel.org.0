Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C382CD294
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2019 17:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfJFPMS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Oct 2019 11:12:18 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42905 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfJFPLs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 11:11:48 -0400
Received: by mail-yb1-f193.google.com with SMTP id 4so140661ybq.9;
        Sun, 06 Oct 2019 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBleGApOd9DY5AB30uyK9JEv+41JBB1+F0GtLYOX3MQ=;
        b=gt+dpgEzdCZwKJd9QMa5Z8eOLC2T8qGgqQPEDXeJ5+hjFfNU9Bzo1oyXr5FLQacxsB
         anjs36Ex2uAl8Bvf1X9a5T2FRSJ1WsapBZeDxNxG5mNpyGFAqyQCd/SOQjspGsbjgLtq
         XyyEruQfjzgKhA9Z0+mjV4dhyRBF36HBeV442cmxACfjrVlakS6t3E3nFncy8FCToC2I
         O2bKb70qAlk//4C2wpJBPSCG/V+4vxW3eDrSYwDJOPrRFMyMhp6nYl9Q80wzA28pn8Ox
         1+xg35Su/lH4vHvw1AmMOQXkGQxaTKDv9SSwWmgSifRSUnwVGO5GOdiyHuhZZEoCUHTJ
         a+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBleGApOd9DY5AB30uyK9JEv+41JBB1+F0GtLYOX3MQ=;
        b=KTNK9nnjuakia7XGdiYGM0+DvoEW8D0c7hdQEa/C8FylgFFeivnsjeYhrOGhrPgA+O
         6dD0y8N4xhC10NN8xBoZujja1qDtf3inpg6Iz0ZYh7BZ6UORePkBF5eveusk2OpbuwFH
         ZH95wHza6FTztn2xM6pMal6YWRF2H07K2rSDvLoUoBit9e5eJc1wDmmNloAHG4zE+7y/
         LkaS+aqNok+ahxBARiFYZ8cLnFiQasBHX8FRvwMWuFEgw83ATBpathPaUHito4GBmlb7
         ZBGG3jzGUpGcmkJvdKG39ks5YhrfAgq8gt/5ySU0nbt+LQfxWLIO+fNS2KC9nO8p4o9t
         4ixQ==
X-Gm-Message-State: APjAAAUXh2FdQgCUvsI59whX9i0ZdOyqwdJhKCKD5/WNn43UIP51erUj
        Z+XxreQhMK1x8gjzmPuJ+BE=
X-Google-Smtp-Source: APXvYqyAU7nShqOfV0xQ4W/Fnp2TBk8JHLI/ydnQomXT/geTbWMbW8LY9nK13dAunNP5MmXPcWYT+Q==
X-Received: by 2002:a25:c1c7:: with SMTP id r190mr1135831ybf.64.1570374707347;
        Sun, 06 Oct 2019 08:11:47 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id e82sm2662434ywc.43.2019.10.06.08.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 08:11:46 -0700 (PDT)
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
Subject: [PATCH v16 10/14] gpio: 74x164: Utilize the for_each_set_clump8 macro
Date:   Sun,  6 Oct 2019 11:11:07 -0400
Message-Id: <13f5d24820e5e3a17a64d025f09efc37eda77739.1570374078.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570374078.git.vilhelm.gray@gmail.com>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
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

