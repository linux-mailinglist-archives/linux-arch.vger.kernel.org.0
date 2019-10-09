Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D96D153B
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfJIRPW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:15:22 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39930 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731896AbfJIRPT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:15:19 -0400
Received: by mail-yw1-f68.google.com with SMTP id n11so1087853ywn.6;
        Wed, 09 Oct 2019 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIovLVirYpbsjXR9oN+2msyJPjO/yPvE5mW4qwwn3Bw=;
        b=ah1+XT0k8DPclq+S0Z7sEWJaH9LrEz/TnwqaetNaHN1XexeohYnsPCfX3F5PAkWFde
         udifAlApSRKyTGyq2G1cXzaigaiRiAOBuoE/bcGJhj9vkySCQX9caXluonGaQEPqTGyf
         DFlD/s0GYVY/DwnM54qbU1+dQoMv8FPVhrW7MGAXT1sxjnL4UH9Psl3cgdq0H6VXr4GC
         Eub87uyAMboYgJzrMK76SEhMiQQ8Xw6VzvTxQzb53y0H1ZbIgEh3jrYaENwByZHXXjJ6
         18rLDkmpgqjGqzkXak5GUx5X6fqGw8EUfkpR7H7JU0rfknTnuM4zW6vuN61Bu8K71xye
         ueaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIovLVirYpbsjXR9oN+2msyJPjO/yPvE5mW4qwwn3Bw=;
        b=ZbCZ/KSKjfDnkkLQeGHTiGux5rTnA384K7eXXnf1facux7d4mdvcJjHJWdcmL1N33z
         sZO/hSxOFL/27+pzDJSaGlHR8lnq6dghBzGuP/hdTIM3mGWS+iYZA8vVgmKEmy3l4Ugu
         9v4Gpp0qnropV2HzCphC1UdW/DAv3vOBvog8e+eIaj4wwuA+XkfEFgwtj672i+xcLac6
         a0+U1Np1/XLerds77LCd+E9Y67xAWZrx2ngRCWbaT4cSoW73+uU8MB16czT4AePPEtCq
         8PTRxTXnrdswpTGmeMnRCq7g65w6F6kmfDGT04hR6H4Opz2UUQmcw5DmYn2EVibJaUGT
         tJUw==
X-Gm-Message-State: APjAAAWQwpvUrdQ3SfIEcMiY55fhH6XUSGqTR3uBuN4oXj1cDJ0EfKiJ
        9lQDBg17/o2Mih7V7fXIQ6E=
X-Google-Smtp-Source: APXvYqwQFwsGkdrcZC1Tb27EBqt2Nz8BBkQiMSCR+LGy/YELNkAKxSWQGrDOZxHrRpM3w94D+MxO1Q==
X-Received: by 2002:a81:2004:: with SMTP id g4mr3708572ywg.418.1570641318369;
        Wed, 09 Oct 2019 10:15:18 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id r63sm743292ywg.36.2019.10.09.10.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:15:17 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v18 04/14] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 13:14:40 -0400
Message-Id: <b0631b6d489f85008480399df283ccd33ecfe310.1570641097.git.vilhelm.gray@gmail.com>
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

