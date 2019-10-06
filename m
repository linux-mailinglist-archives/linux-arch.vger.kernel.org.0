Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0859CD298
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2019 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfJFPMY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Oct 2019 11:12:24 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45780 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfJFPLp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 11:11:45 -0400
Received: by mail-yw1-f67.google.com with SMTP id x65so4158482ywf.12;
        Sun, 06 Oct 2019 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WN3x14SIuSn1oRkzpsuHsfcKOnsb1pBJ4mBFw0scg+8=;
        b=Q9IcRpiHgaJGkIsGmzwqQcahFSYeJtSIOZxAHIfBtljsiFRVHkm9ngAhTtsLIR1y9C
         uPR5z+cZT2fhLJkhpBAWjaPx0FNweWz3SzxMheu/ctoqlOz66k7d47G6NcjNJR7aulkN
         Y0/yjomzejKq2BHwohOSx10nSG2XKJkFEGI+lDGGUrg81zExMNfyixvX7dig55xT6Wc5
         dWlFoTGFXfJzd1uwj8FF82zFwh4bDbSVmA7ehuGoAF5py4+e/jfoJZR1agKvBTbNxXtD
         pBGlQVDsmZUiy91+SiTEq1bm36tvlqWCO0yhl86T2+5bHR/4DvfRsj8NnwFYRskkgL6m
         8HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WN3x14SIuSn1oRkzpsuHsfcKOnsb1pBJ4mBFw0scg+8=;
        b=re8xojUEoz+lj3V+nfXXvQA4h7D8MVH2L6RzgPY/dJbr61RpqRisCRtdzviECzsh3g
         81sYYvmHJoeLjxARrrsRJpxvmK7+q33pP9VjigJkC4R0f+esgh6Zi6HuBMKOp/f/kJ9o
         hKuV28P8Evm39RiWbB1rrwLrCwlpFwsEFeXWNyaG/MgOO3ZNd9lLUJOkbgrtyXfZXRpk
         tB09bb2kLHWwDDsRvYl8qtjvQxvnbZVFRwvRkebpS5n1AMs4r0Tv3i9PTpf0EIpD3v/I
         PQcV1rW8QFySrATTbwzOQNfmCto1C34BCIAgCyEQZlxJ1LIB1G1cEFcz5fB6F9PUIC/C
         b63g==
X-Gm-Message-State: APjAAAWHYw89qzb17zvWl6/kZVmnzxk6ww4HoCc3bScJPepxzou7mwHG
        KU8BTq7HMof8tU50mbr50WA=
X-Google-Smtp-Source: APXvYqxyPt5L9XPp93FN9vbTvtkjrPi1BLdt8kY34p8HHmkBPzyTmgeESKXwistXxK2P+a4ZaqpV7Q==
X-Received: by 2002:a81:8453:: with SMTP id u80mr17032160ywf.481.1570374703217;
        Sun, 06 Oct 2019 08:11:43 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id e82sm2662434ywc.43.2019.10.06.08.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 08:11:42 -0700 (PDT)
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
Subject: [PATCH v16 07/14] gpio: pci-idio-16: Utilize for_each_set_clump8 macro
Date:   Sun,  6 Oct 2019 11:11:04 -0400
Message-Id: <85a40d273f92c686fd651505efcd6df9093faa43.1570374078.git.vilhelm.gray@gmail.com>
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
 drivers/gpio/gpio-pci-idio-16.c | 75 ++++++++++++---------------------
 1 file changed, 27 insertions(+), 48 deletions(-)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 5aa136a6a3e0..6c117e57078c 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -100,45 +100,23 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
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
 		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
 		&idio16gpio->reg->in0_7, &idio16gpio->reg->in8_15,
 	};
+	void __iomem *port_addr;
+	unsigned long port_state;
 
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
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = ports[offset / 8];
+		port_state = ioread8(port_addr) & gpio_mask;
 
-		/* read bits from current gpio port */
-		port_state = ioread8(ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
@@ -178,30 +156,31 @@ static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
+	unsigned long offset;
+	unsigned long gpio_mask;
+	void __iomem *ports[] = {
+		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
+	};
+	size_t index;
+	void __iomem *port_addr;
+	unsigned long bitmask;
 	unsigned long flags;
-	unsigned int out_state;
+	unsigned long out_state;
 
-	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		index = offset / 8;
+		port_addr = ports[index];
 
-	/* process output lines 0-7 */
-	if (*mask & 0xFF) {
-		out_state = ioread8(&idio16gpio->reg->out0_7) & ~*mask;
-		out_state |= *mask & *bits;
-		iowrite8(out_state, &idio16gpio->reg->out0_7);
-	}
+		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
+
+		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
 
-	/* shift to next output line word */
-	*mask >>= 8;
+		out_state = ioread8(port_addr) & ~gpio_mask;
+		out_state |= bitmask;
+		iowrite8(out_state, port_addr);
 
-	/* process output lines 8-15 */
-	if (*mask & 0xFF) {
-		*bits >>= 8;
-		out_state = ioread8(&idio16gpio->reg->out8_15) & ~*mask;
-		out_state |= *mask & *bits;
-		iowrite8(out_state, &idio16gpio->reg->out8_15);
+		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 	}
-
-	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 }
 
 static void idio_16_irq_ack(struct irq_data *data)
-- 
2.23.0

