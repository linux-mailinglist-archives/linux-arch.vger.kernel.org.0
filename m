Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC1CCC2E
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2019 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbfJEShk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Oct 2019 14:37:40 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34448 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388342AbfJEShk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Oct 2019 14:37:40 -0400
Received: by mail-yw1-f65.google.com with SMTP id d192so3582973ywa.1;
        Sat, 05 Oct 2019 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAGfzyUV4XhvgurCxyCR2EqX3tIH+KR8HXshRAb1W4M=;
        b=meaD6Qb1YIg6hcr2iqLZ8pfoGbUAfBru8ksrO1rw8GydtxqzsuPLF7PwiveLKzbKd6
         pGlTm5zkAteFyRUT9IpSydDfW9bZXcmMdZ51zp0MUETDvKuvROgbIRIxioSCanUuQBfS
         ExQZIAOJfwmH43UZ1ygPayLxPergba7VybdPOGyIRPEjlBJsId28lJEW1sVSyPiKMLvc
         3lfndLlF0urpGzeYeRjZd5JhA7UFq437C/IbV5gj8hugcak0lHH7IMadiPDbhW2k5Mja
         70sSxco3OpA3Pq6YSPEp4gD6F8PmXECwXWsqeiCHYCJUloMuUhInSBeJbwkTF0Bf4a86
         PFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAGfzyUV4XhvgurCxyCR2EqX3tIH+KR8HXshRAb1W4M=;
        b=pmkTeuS32yzQk32x98dRjxypjRMppOqb1ayTYW23TXGvIdtWfrJh3KfgVCDqGMGYLg
         DZClKv8s3ksMNGzar5/vg3TnRq/J4mqLsxYUkfTUvzicv2MO4mjFU90/Vji/CgXG/5vR
         lvQ3XxceV+CidxLktvfIRNwLsUiMYZKwmyV1WKlV24T9Qmu7kOZNay+FFsmxFjpQvwQC
         lXyjNuv3qYLX4V+qjChXmB+Mm45vjFFhooxFpA+1YnSsi3cS5vppJ/GlDBIA/FYN9yf5
         mpOu8CbaNyGP9OM6bd6NI+qlP4BEUMYGcMvDSsAK3l5AhaRATtmsiJZ6DIj3oVXGMXBm
         XRng==
X-Gm-Message-State: APjAAAXlTx7sxN3YSZo9OvzdE9xizfA/8N41f2iicT3qLodDTqux/ZGv
        9Px6qOP05u0Y/m8Ub+4JpIk=
X-Google-Smtp-Source: APXvYqxEVBh3FLrxHXo5bgbmGdBZLrPOSPrV46xR9LTQFxsuxEXwqFrhKMSdyFzDUUS4tkuYrKJa1g==
X-Received: by 2002:a81:f20a:: with SMTP id i10mr4094745ywm.424.1570300659142;
        Sat, 05 Oct 2019 11:37:39 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g128sm2376654ywb.13.2019.10.05.11.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 11:37:38 -0700 (PDT)
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
Subject: [PATCH v15 09/14] gpio: uniphier: Utilize for_each_set_clump8 macro
Date:   Sat,  5 Oct 2019 14:37:03 -0400
Message-Id: <a1e0c618eefda5b06cc045a94e3794771dac92a0.1570299719.git.vilhelm.gray@gmail.com>
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

