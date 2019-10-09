Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23532D1535
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfJIRP0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:15:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33639 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbfJIRPZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:15:25 -0400
Received: by mail-yw1-f68.google.com with SMTP id w140so1101136ywd.0;
        Wed, 09 Oct 2019 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+mqc0t3Nlu8bab/TVJ1eaLU6XWlAP9g+g7Mhy2/IA0=;
        b=D2pZaE1VGzB5l9VgSzPx9STZVU1McDSCwlcpRgp3qm5FW+WOH4P1z174i4RD63xQqT
         Nrp0nyVThjd4ngFNUwQeHfMOid1qcTNLb0SCdYrM30mNHdACuIFhBOx1X+AI1k6iqyN9
         /o6OuwQdsUEAe8TSlXxXPW7S7R8E8wyRxnGyPFaKnwD6A3ZfMY9Pff99hOL5sgAfVrXK
         4XBHDMg/x1gqUL81Uh6DYHyz/u1YXKuOK4zKVe1oakRl9vzfwmpww9i7PGtHiU/uEdtH
         UkNPGwT4/O51l+XsJJH+i5mbjC5xFyrahCFC7MyKHHUC+oEP1Nt6ereO234H6095W8pc
         d6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+mqc0t3Nlu8bab/TVJ1eaLU6XWlAP9g+g7Mhy2/IA0=;
        b=YjfsIW46kPbU9wpaOZ9Fi6qhyGWx1Z3Dlh0F3SVUDAmqbOSm+8biNuQZ5LLoTv14HF
         OPyvu06NAI3ooJDdDtGBlV05Vvl9+4IDfKk9b5PhoKfvlRz8vKgOyFo/NlifqJmTOfFT
         nV+2cGwDssI+sahRcj8A/UaXAA+ykv7AIQTzQELH8+9xmE8uLmzMqOsTy6ZL+vlFbKPv
         ADtNdvaXTtURQOSAcgfrOB8i/EcTf07glXq4/s+eRob4lUmu8TcecCB1ebji/ksi7UmI
         ShVBHLpoICYaNtn11UYcLuw2tagAGhreqzjbFPN+O6+b+pzwL/KAHlOyfKgvy5QT79tA
         VlFA==
X-Gm-Message-State: APjAAAU8DXufqHsD99DU/9XduS6JtH7mO8FnVnmkAQ2sTILb0UWwAehm
        i5dzoQk/HcdKZtKxTJAmKOYXywX6
X-Google-Smtp-Source: APXvYqz/X0PGKeHU2nq7gViF+sE/NM3LPolGKfluPJxzI0Xk2+5//+Ew8S70OC9anjKIk7we3QGR8g==
X-Received: by 2002:a81:6302:: with SMTP id x2mr3726622ywb.123.1570641324622;
        Wed, 09 Oct 2019 10:15:24 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id r63sm743292ywg.36.2019.10.09.10.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:15:24 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v18 08/14] gpio: pcie-idio-24: Utilize for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 13:14:44 -0400
Message-Id: <d5d22fa9809dcf8330f4381dbe7e7ca37990e79f.1570641097.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570641097.git.vilhelm.gray@gmail.com>
References: <cover.1570641097.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pcie-idio-24.c | 109 ++++++++++++-------------------
 1 file changed, 40 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 52f1647a46fd..924ec916b358 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -198,52 +198,34 @@ static int idio_24_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	size_t i;
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
-	unsigned long port_state;
+	unsigned long offset;
+	unsigned long gpio_mask;
 	void __iomem *ports[] = {
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23, &idio24gpio->reg->in0_7,
 		&idio24gpio->reg->in8_15, &idio24gpio->reg->in16_23,
 	};
+	size_t index;
+	unsigned long port_state;
 	const unsigned long out_mode_mask = BIT(1);
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports) + 1; i++) {
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
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
 
 		/* read bits from current gpio port (port 6 is TTL GPIO) */
-		if (i < 6)
-			port_state = ioread8(ports[i]);
+		if (index < 6)
+			port_state = ioread8(ports[index]);
 		else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask)
 			port_state = ioread8(&idio24gpio->reg->ttl_out0_7);
 		else
 			port_state = ioread8(&idio24gpio->reg->ttl_in0_7);
 
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		port_state &= gpio_mask;
+
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
@@ -294,59 +276,48 @@ static void idio_24_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_24_gpio *const idio24gpio = gpiochip_get_data(chip);
-	size_t i;
-	unsigned long bits_offset;
+	unsigned long offset;
 	unsigned long gpio_mask;
-	const unsigned int gpio_reg_size = 8;
-	const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
-	unsigned long flags;
-	unsigned int out_state;
 	void __iomem *ports[] = {
 		&idio24gpio->reg->out0_7, &idio24gpio->reg->out8_15,
 		&idio24gpio->reg->out16_23
 	};
+	size_t index;
+	unsigned long bitmask;
+	unsigned long flags;
+	unsigned long out_state;
 	const unsigned long out_mode_mask = BIT(1);
-	const unsigned int ttl_offset = 48;
-	const size_t ttl_i = BIT_WORD(ttl_offset);
-	const unsigned int word_offset = ttl_offset % BITS_PER_LONG;
-	const unsigned long ttl_mask = (mask[ttl_i] >> word_offset) & port_mask;
-	const unsigned long ttl_bits = (bits[ttl_i] >> word_offset) & ttl_mask;
-
-	/* set bits are processed a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
-
-		/* check if any set bits for current port */
-		gpio_mask = (*mask >> bits_offset) & port_mask;
-		if (!gpio_mask) {
-			/* no set bits for this port so move on to next port */
-			continue;
-		}
 
-		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
 
-		/* process output lines */
-		out_state = ioread8(ports[i]) & ~gpio_mask;
-		out_state |= (*bits >> bits_offset) & gpio_mask;
-		iowrite8(out_state, ports[i]);
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
 
-		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
-	}
+		raw_spin_lock_irqsave(&idio24gpio->lock, flags);
 
-	/* check if setting TTL lines and if they are in output mode */
-	if (!ttl_mask || !(ioread8(&idio24gpio->reg->ctl) & out_mode_mask))
-		return;
+		/* read bits from current gpio port (port 6 is TTL GPIO) */
+		if (index < 6) {
+			out_state = ioread8(ports[index]);
+		} else if (ioread8(&idio24gpio->reg->ctl) & out_mode_mask) {
+			out_state = ioread8(&idio24gpio->reg->ttl_out0_7);
+		} else {
+			/* skip TTL GPIO if set for input */
+			raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+			continue;
+		}
 
-	/* handle TTL output */
-	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
+		/* set requested bit states */
+		out_state &= ~gpio_mask;
+		out_state |= bitmask;
 
-	/* process output lines */
-	out_state = ioread8(&idio24gpio->reg->ttl_out0_7) & ~ttl_mask;
-	out_state |= ttl_bits;
-	iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
+		/* write bits for current gpio port (port 6 is TTL GPIO) */
+		if (index < 6)
+			iowrite8(out_state, ports[index]);
+		else
+			iowrite8(out_state, &idio24gpio->reg->ttl_out0_7);
 
-	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+		raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+	}
 }
 
 static void idio_24_irq_ack(struct irq_data *data)
-- 
2.23.0

