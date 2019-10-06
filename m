Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2DCD29C
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2019 17:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfJFPLm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Oct 2019 11:11:42 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43535 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfJFPLk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 11:11:40 -0400
Received: by mail-yb1-f196.google.com with SMTP id y204so3802482yby.10;
        Sun, 06 Oct 2019 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIovLVirYpbsjXR9oN+2msyJPjO/yPvE5mW4qwwn3Bw=;
        b=JF6FEn8EC+3jw8cO/sNWQ4ftB44QNrOYhPVfLhGBH2Hm8IyT3BhzBFDJINusLs6IYD
         H5WOfFWGASmL4yL+gEc6Ayk6v5MKVVE6aEg84+pTF/T5gSBHx4PvoPAgPP0m+3Ly7z36
         4fA7KWN9qfKfbBuQLpqwG8Sk+DxFiMCAPMxJamZ/d7qOW7psAuS1nva2vnkjM0Xbrj3f
         W7Xwf0lYTGdWnHeEK6gZMisfTsji2kwCUL3ng1vYtXSVQFLjO7jZNCYO/Tr40n6Jwg8Z
         dr7RlMucIoWkpmXwmw/8jhpt5lnf5we+d+zDWFpFta+vbjH9wcrIzdVHpN0S0Mhukv+I
         JVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIovLVirYpbsjXR9oN+2msyJPjO/yPvE5mW4qwwn3Bw=;
        b=L4WPm8clvaGuwhNN2WNQbqqsHQ3xPPOWCGrscAuWPX9qKLWMrZ0z+B8/09JjqzC7A6
         SJP5lqtE1447aVZfeM4ZgmO8g6v3CXA6RinB9zduUldR7Jl7+6J2zeshVSZQ01QnFGi/
         dvIqVR8oIPdanT4dFh/SYzrYdV4v4tzURdrCh4yPqbw/CJyWjIgkPUfkX3lo7wUE9DaC
         PvHhP7mCUtVgt0EVSbQHpZ13ybeRh25lQoIuawsLxS6YyL9v1UWhvPFjCmMlX1Gvj+Y7
         fcrPANKCIKRYBkufMM8sghJ2IH+1BJn4gPnvj6CrGJ5JA43s04n90ZcPxVJC+SDOwYCo
         IXUQ==
X-Gm-Message-State: APjAAAWqJILYOVZ5pvCj0pJN9INnH2l3UtDSFHHlF+W3BhUxe7iI+HeS
        wJU2qRDcv/yw/tIv05+PWc4=
X-Google-Smtp-Source: APXvYqwA8h26SKZkyCP8BNoqhEN1+EtmVC7Ww0aHbL9+MCbnnfB3320tGE4MRWQfxPf5sxw1WoI9Ig==
X-Received: by 2002:a25:570b:: with SMTP id l11mr7918895ybb.323.1570374699171;
        Sun, 06 Oct 2019 08:11:39 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id e82sm2662434ywc.43.2019.10.06.08.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 08:11:38 -0700 (PDT)
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
Subject: [PATCH v16 04/14] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Sun,  6 Oct 2019 11:11:01 -0400
Message-Id: <0092df14e087717c0f9675c8747024982800f0fc.1570374078.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570374078.git.vilhelm.gray@gmail.com>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
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

