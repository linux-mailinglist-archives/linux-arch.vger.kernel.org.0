Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510B6CCC45
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2019 20:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbfJEShf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Oct 2019 14:37:35 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43248 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388005AbfJEShd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Oct 2019 14:37:33 -0400
Received: by mail-yw1-f67.google.com with SMTP id q7so3564512ywe.10;
        Sat, 05 Oct 2019 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIovLVirYpbsjXR9oN+2msyJPjO/yPvE5mW4qwwn3Bw=;
        b=ctDGbI6dFoR2en11j32vRA1iUbwD9d5FfwePuj/i5n7oJ84HXLixaBJsZBcGvxFTVe
         SvgVPNkzQwvPOCMV4wF3f1ZtZkCNjnkpU6RbYfm/0+EHJjYU3NKd98Ciumuv9oEQ3nYM
         d1eho96eJI+qAlZ4WL0GYv8fM+AXN8qdvinRkolVJ8I/QNiXIle3ChyqM0xsbcls/xBK
         GQFOUpsWYKYM+6QHWDePoYUhHl4WRA4p0W5Kw9+twIQNEece1AQSQ1/Fktznk5aB/o1+
         5v8CxE7+rhHVZ/9MT5p+PiG5v9gvafVDjkdTtL9ZW9BfG3ZKzruQgTxJRbTnbnh/mdza
         fTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIovLVirYpbsjXR9oN+2msyJPjO/yPvE5mW4qwwn3Bw=;
        b=OkYshMvLPI+yunfIQ04HQgeUUMd0BQAGeKhkd6mAf2YNlJwtzY9nhzsmlKXY6WreC8
         HI7PDyD0cbMdIx6u6Xsir30l2xwH0SzVRgw7IOCNJXG1fSu3LPddUDO7UqqIQMX+IDgl
         ul3U5vgzGYzoP1cANAvQ2/Y12Xob5cq+oMKaxI61gUsDxzQxapiYntwkZtqpg06NHSUN
         tN9NDmi5IfB3sbBdE5zBei4wiAES3S1ifs9OqCmwvJ2cufnzEeps5BR6RXEIXyHZbBud
         swD6gFdtaNGgD9REkzm/sHV442NgNy5HnBGA6Z1KzZ25ybmHL0suEji1kPwzzSo/nmnE
         q+Zw==
X-Gm-Message-State: APjAAAXMsmXAFltkZFOOf3uIH+/GhFdNW15XL4DvqBZOeyaRgdvvEShY
        CgYW0WVKThrk28cR344xb70=
X-Google-Smtp-Source: APXvYqy75Ya2YBsMEbePYyYWW7O5StWzI583/2uSvKzl2W/yDu2iNhXyoq9hJMZwkZNVAnus/0amRw==
X-Received: by 2002:a81:3e1f:: with SMTP id l31mr14315618ywa.331.1570300652647;
        Sat, 05 Oct 2019 11:37:32 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g128sm2376654ywb.13.2019.10.05.11.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 11:37:31 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v15 04/14] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Sat,  5 Oct 2019 14:36:58 -0400
Message-Id: <21b2c3af2770a04e768ea2d7688b77493ceb640c.1570299719.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570299719.git.vilhelm.gray@gmail.com>
References: <cover.1570299719.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace verbose implementation in get_multiple/set_multiple callbacks
with for_each_set_clump8 macro to simplify code and improve clarity.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-idi-48.c | 36 +++++++---------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index ff53887bdaa8..bf67040cbbbb 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -85,42 +85,20 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	size_t i;
+	unsigned long offset;
+	unsigned long gpio_mask;
 	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = idi48gpio->base + ports[offset / 8];
+		port_state = inb(port_addr) & gpio_mask;
 
-		/* word index for bits array */
-		word_index = BIT_WORD(bits_offset);
-
-		/* gpio offset within current word of bits array */
-		word_offset = bits_offset % BITS_PER_LONG;
-
-		/* mask of get bits for current gpio within current word */
-		word_mask = mask[word_index] & (port_mask << word_offset);
-		if (!word_mask) {
-			/* no get bits in this port so skip to next one */
-			continue;
-		}
-
-		/* read bits from current gpio port */
-		port_state = inb(idi48gpio->base + ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
-- 
2.23.0

