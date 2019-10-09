Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A7D12AC
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbfJIP1q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 11:27:46 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38561 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbfJIP1m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 11:27:42 -0400
Received: by mail-yb1-f193.google.com with SMTP id r68so865360ybf.5;
        Wed, 09 Oct 2019 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSd0IOl/SfIaZDr2U/8RUT6ZXyKiyqc5Z3E1jM5LeZE=;
        b=s59cqFcCi40TYZt1sNhqzamuNnpU7yI5HZx+GpzmpPBLvolJ2gJAobiNucskTWhbwy
         5X7MldxyZYEl40zv+brvBsw9IQAHXCAuDfT1imjxNKisrDf087O+Kf2jNL+lnybI4fof
         K+Rr236sGJ87aahR7HnrG2b0fQosMJr2sNYfQScRl1uNTdKsbC1+4LYcPbphaAXYIgBD
         yFrvVcHkSV8GowTdigKPEo070zgSixjScZgWLjMLyx3FZ3/CvBeN2dKXEJ2XNXEYe3fK
         RfxugZsZHEfoged8fRtvGFr4HjM2neC8PP0Abbn6U00btmszXr9kjCf+MY/DLY9PMeJ3
         WRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSd0IOl/SfIaZDr2U/8RUT6ZXyKiyqc5Z3E1jM5LeZE=;
        b=ELcOucFg2uvDO3S0GwZBMKKqGnBqCNvwXnxY6NiQ3lHklL3dRSTQcxA+3wVHy3RfAh
         HYxX2xvZBusWHtZs30weIRpuS3juJP0CqHjWYqhzqZ1FkRT88w6T7bubiDwcG8aY3PPC
         /wBMewpNWfnTht2yEzmTNjdU/C7zgQr3oVbyXWM+6I4MpOIHXhi86T9v1vV5kBwjXHLJ
         5tUd7+hGyY2QwmN4PPtAk34dQcw0dJQlbri0b3Ya4GyIKEe82/fO9p1U5At9NRPLEAj1
         NPITYM7PvYfZaQ6DT+J5ey3pNQTU+kmqOOSdcklf5yFsW3jg+v9sOFtQyAZWPMcneKj+
         2dTg==
X-Gm-Message-State: APjAAAUv3LqYMUHuUda8Yf4X24IxWRBrlgth1B0qimAFp0xuYmLQGkQY
        YXvlVejtbqLq74ZjvgLpKcY=
X-Google-Smtp-Source: APXvYqyA1KHkJv26/egzO/q7ZbvxPLWPrp9fmutImGee9Mmc/KS8b0c/D4Vyd2SYl0w7uZmFUX98Pw==
X-Received: by 2002:a25:7245:: with SMTP id n66mr2468443ybc.27.1570634860582;
        Wed, 09 Oct 2019 08:27:40 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g40sm611863ywk.14.2019.10.09.08.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:39 -0700 (PDT)
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
Subject: [PATCH v17 05/14] gpio: gpio-mm: Utilize for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 11:27:03 -0400
Message-Id: <0de53d7021b2d6db10294473cd8a1b6102bcec94.1570633189.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570633189.git.vilhelm.gray@gmail.com>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-gpio-mm.c | 73 +++++++++++--------------------------
 1 file changed, 21 insertions(+), 52 deletions(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 78a1db24e931..72196ea36358 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -164,46 +164,25 @@ static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(port_state & mask);
 }
 
+static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
+
 static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	size_t i;
-	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned long offset;
+	unsigned long gpio_mask;
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
-
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
-		port_state = inb(gpiommgpio->base + ports[i]);
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = gpiommgpio->base + ports[offset / 8];
+		port_state = inb(port_addr) & gpio_mask;
 
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
@@ -234,37 +213,27 @@ static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-	unsigned int i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int port;
-	unsigned int out_port;
-	unsigned int bitmask;
+	unsigned long offset;
+	unsigned long gpio_mask;
+	size_t index;
+	unsigned int port_addr;
+	unsigned long bitmask;
 	unsigned long flags;
 
-	/* set bits are evaluated a gpio register size at a time */
-	for (i = 0; i < chip->ngpio; i += gpio_reg_size) {
-		/* no more set bits in this mask word; skip to the next word */
-		if (!mask[BIT_WORD(i)]) {
-			i = (BIT_WORD(i) + 1) * BITS_PER_LONG - gpio_reg_size;
-			continue;
-		}
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
+		port_addr = gpiommgpio->base + ports[index];
 
-		port = i / gpio_reg_size;
-		out_port = (port > 2) ? port + 1 : port;
-		bitmask = mask[BIT_WORD(i)] & bits[BIT_WORD(i)];
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
 		spin_lock_irqsave(&gpiommgpio->lock, flags);
 
 		/* update output state data and set device gpio register */
-		gpiommgpio->out_state[port] &= ~mask[BIT_WORD(i)];
-		gpiommgpio->out_state[port] |= bitmask;
-		outb(gpiommgpio->out_state[port], gpiommgpio->base + out_port);
+		gpiommgpio->out_state[index] &= ~gpio_mask;
+		gpiommgpio->out_state[index] |= bitmask;
+		outb(gpiommgpio->out_state[index], port_addr);
 
 		spin_unlock_irqrestore(&gpiommgpio->lock, flags);
-
-		/* prepare for next gpio register set */
-		mask[BIT_WORD(i)] >>= gpio_reg_size;
-		bits[BIT_WORD(i)] >>= gpio_reg_size;
 	}
 }
 
-- 
2.23.0

