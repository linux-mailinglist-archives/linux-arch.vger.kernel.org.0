Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3DD151B
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbfJIRP3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:15:29 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41349 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbfJIRP2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:15:28 -0400
Received: by mail-yb1-f194.google.com with SMTP id 206so980028ybc.8;
        Wed, 09 Oct 2019 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDpmcrsOD06XGrRt1a/jJQziXNR25OqwVQScSY5C/BU=;
        b=WL30k9ixHGGt8In7/erRM4QBReuvVT1dbjM4Z0OyJzYaLZ+yVohVHy/wwyVdiVrTzd
         GYBbyy6Reb0J1J9uAB2F2Zz5kopZsJyCPzW9R0TH4I0XEjXjmBOI4Uj4DhBhYmf9tRoU
         zOd9Rd1OS68jPLJkd+CnTEyokvNBvhOk1y1hFmbQc8gRO2gIJGuFBb6ExmD+gLfofmAw
         y0Rb1W/AYTay2Qkrc2rMknbwAWhg/IO6bw5zW6mrmdCy6cyfqlr3utyBexyGA3kNsMAA
         o3OiFFAL+6YXoBquyj7iomzrK7T0tH9mgamUAxHb0fvisZcWwfqh8bmI+lgXPFyVmzZS
         h+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDpmcrsOD06XGrRt1a/jJQziXNR25OqwVQScSY5C/BU=;
        b=Z2dJUh50zMkhO4hufBbRto8yIYVjoKbZsDiTjI4wkTYg2Xm2MPViLTRrh+z51dCUKj
         Uf9lT89FQi3yyLJeWjIaGrZpLYYCL7nTYhs8LpW7nichfEhrfxBSfIqq5/4loeD7ytZy
         2AEptqyuKCJZfaSgHvvO2LHmKNvCLj7Zmk8huL/Vj1shDK5iABk+aEOkEIXToDJsoArU
         xek4JqAcoxc6MtDiFzUdBkrCdcK7Ib7iT8p3q8bDjSU3vMcFImzGq1OyNNq2RenefUFQ
         IoU4xjchb6SHA316SxoNpjWxVsqm0yY5KkBVZJEYzr5G1CYyBlZ7qveurqDjI8Sk+GUC
         EbXA==
X-Gm-Message-State: APjAAAVijyDs/otYDb3fcDkWNy/J0AXu96YXb98P87AZnuMktC+cQDq6
        wmfi3SDkU1RwApineRHfk9M=
X-Google-Smtp-Source: APXvYqxaUc72YqJJOgvCdh9BAysNa4HSdJyOk3js9wuxG2zail3AaYZG6cmfZj4x10MtXUR1wfm9OQ==
X-Received: by 2002:a25:30d5:: with SMTP id w204mr2813662ybw.382.1570641326245;
        Wed, 09 Oct 2019 10:15:26 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id r63sm743292ywg.36.2019.10.09.10.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:15:25 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v18 09/14] gpio: uniphier: Utilize for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 13:14:45 -0400
Message-Id: <5b24887e97f3093e4832d7c50a1093f537e91ab4.1570641097.git.vilhelm.gray@gmail.com>
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
for_each_set_clump8 macro to simplify code and improve clarity. An
improvement in this case is that banks that are not masked will now be
skipped.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-uniphier.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index 93cdcc41e9fb..3db9c41b7954 100644
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
@@ -147,15 +144,11 @@ static void uniphier_gpio_set(struct gpio_chip *chip,
 static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
 				       unsigned long *mask, unsigned long *bits)
 {
-	unsigned int bank, shift, bank_mask, bank_bits;
-	int i;
+	unsigned long i, bank, bank_mask, bank_bits;
 
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

