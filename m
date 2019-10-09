Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D99D129D
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 17:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfJIP1u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 11:27:50 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43139 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbfJIP1t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 11:27:49 -0400
Received: by mail-yw1-f68.google.com with SMTP id q7so948949ywe.10;
        Wed, 09 Oct 2019 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAGfzyUV4XhvgurCxyCR2EqX3tIH+KR8HXshRAb1W4M=;
        b=kXMUo3pNLSF6Bp5VuIy+BzgCHpXZAPVHaSL4XcqD5U2yDdjIyMtggpchGRC0lzQ9cl
         8OsrKzXBk/gvBZY4XUMDYanF00odndN8hUaCsXTmXQQfOsi0yqoZ2BGaAgFZFTAwKYY+
         72CDl/NCip1wkGco+vDpg3SscZRhlC7j9N9wrj/CQme5+DfjMpt2WHmkxeUc3cArczYr
         41q2EJWcGZl/6ZNW5izQrtO1dmpxsC6dnYwpz0u1TXcMnSwV361ENBPmaynMnEGAo58F
         rBF+krBfJm17uq7xmqcSlvUL0UfaU89yEGJYBAsU3aElh6RV8Q0XCRUggxxrmH0b1uli
         FBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAGfzyUV4XhvgurCxyCR2EqX3tIH+KR8HXshRAb1W4M=;
        b=bOkL+vFUslFsfafdPJFKvX0bGi728Fxz5vwzIKBy4zSN3mJTnmAtkr+L8cTEMES/4o
         zQWYfyXQTtyJ5MP75xBjw3r+c5YK/HsWcK9edpnxXVsdRpR7ZJHzlzoDvXz7QY57CExl
         RP7Lz0vJW3sr5mTbuStASrXyqSHJmmTgSFmupMUbjQqAnfUeX4TcklMkSC1Do//zbc0v
         2Ne9AYo+Nji78LT9TjoYXERsjeLGuR+XyFrARaGjbQR/r5P3PKD9iAAayWqJhf6BvX2T
         QFoh03PX+NqQe/FY4qwrwED9DMT9BdbaE1qBSUL5gYYlC8uIUg6L7hU2vqAKT4132VkK
         L6PA==
X-Gm-Message-State: APjAAAU9Nv7kjbVjAiQASqElHkGTZ4GrPtMcZwsPQpn1T9P2dyQDTAFF
        349PgS144b3p1YLfwDejjO0=
X-Google-Smtp-Source: APXvYqzU4mk2ALxC5shgv1Btwp1xQb3tD3PCuvxgw7dxEmZhlvqDmfddDtyomz4/6eWxAvTEX7t0SQ==
X-Received: by 2002:a81:7446:: with SMTP id p67mr3018012ywc.457.1570634868449;
        Wed, 09 Oct 2019 08:27:48 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g40sm611863ywk.14.2019.10.09.08.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:47 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v17 09/14] gpio: uniphier: Utilize for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 11:27:07 -0400
Message-Id: <271a7735b02b6a8b1f54c018e38ea932d1fd299e.1570633189.git.vilhelm.gray@gmail.com>
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
for_each_set_clump8 macro to simplify code and improve clarity. An
improvement in this case is that banks that are not masked will now be
skipped.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-uniphier.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index 93cdcc41e9fb..3e4b15d0231e 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -15,9 +15,6 @@
 #include <linux/spinlock.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
-#define UNIPHIER_GPIO_BANK_MASK		\
-				GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
-
 #define UNIPHIER_GPIO_IRQ_MAX_NUM	24
 
 #define UNIPHIER_GPIO_PORT_DATA		0x0	/* data */
@@ -147,15 +144,14 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
 static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
 				       unsigned long *mask, unsigned long *bits)
 {
-	unsigned int bank, shift, bank_mask, bank_bits;
-	int i;
+	unsigned long i;
+	unsigned long bank_mask;
+	unsigned long bank;
+	unsigned long bank_bits;
 
-	for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
+	for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
 		bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
-		shift = i % BITS_PER_LONG;
-		bank_mask = (mask[BIT_WORD(i)] >> shift) &
-						UNIPHIER_GPIO_BANK_MASK;
-		bank_bits = bits[BIT_WORD(i)] >> shift;
+		bank_bits = bitmap_get_value8(bits, i);
 
 		uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
 					 bank_mask, bank_bits);
-- 
2.23.0

