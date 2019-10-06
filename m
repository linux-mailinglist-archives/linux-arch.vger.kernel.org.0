Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22110CD287
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2019 17:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfJFPLr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Oct 2019 11:11:47 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43536 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfJFPLq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 11:11:46 -0400
Received: by mail-yb1-f194.google.com with SMTP id y204so3802544yby.10;
        Sun, 06 Oct 2019 08:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAGfzyUV4XhvgurCxyCR2EqX3tIH+KR8HXshRAb1W4M=;
        b=GtS6gs70VznAEpE2zLW1HedOyrDMpLzJ6UeoorAujopSa+qhwD4xHWRXDvRRAag8ec
         BIBJF6kT8KUbQj6YnDOh5lhx5NXR/lmeOmS7WUiYvEQnZveYblSgpxEcmTDrO3FVRjGV
         evXGitZJ/SL52CNaHwt7OoxAWvFw7FcX2QJgUQznma4XmqSeVJSETalBItQb8XU2qKhq
         QVlxodWNhRAUek3TjPVeE7Ta7nq4MzvQB0cd4Efu+un9Z2Seu30mePZj61R5PrGuHvvE
         uooT9HKxO52RzljoGFGHw3IWoJeQNI05NkX7fLoccXAaiJm4V+rkbW/rmaumdbUWGjqh
         cY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAGfzyUV4XhvgurCxyCR2EqX3tIH+KR8HXshRAb1W4M=;
        b=YwQnPxcSMfT/nJzif6hsbPdjXaeC3EeM5Luhr9kzyF8lDS3Kzl4EegMxNAcUwi/qel
         A7LRRgKIt3rnPGF/ivPJTMzVX1clqH5NpmwYHKQ4lXAdUEQj22ETpVxUakddAT0XDekO
         4TfykbSMn8btVazEyErMhk4/rLnpK1UrtiFDkavToanNSA1+sZw9PtnAN81VmUoPFUQ3
         CHOAJ3bnZWFL/hQzVaJrhFSPrD9nyLL/AGeIXCJxQNSrTE0YdvoEPKKnEvdOw0/rMOm8
         x5UWBEqF9HK8DobOH/PLtBfUxKi3WkZVJxwCyp6upn4a2FecOJGnDEEOXK4qeFxrbnoM
         Vj4g==
X-Gm-Message-State: APjAAAVfUwMO+1FyhHVCbQRNFnpA+wIE61eWmYUDOLALkCdcXbD7U5+I
        689UfTTP+1YzD5WfrDkW7tY=
X-Google-Smtp-Source: APXvYqyq3uVVL9kPfmFGH4SOWTus7M7n/0M7rzZEKBUlMww+5mkAvPmWOzPbLiX69cClqOpDe2/zkg==
X-Received: by 2002:a25:76ce:: with SMTP id r197mr7978156ybc.158.1570374705731;
        Sun, 06 Oct 2019 08:11:45 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id e82sm2662434ywc.43.2019.10.06.08.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 08:11:45 -0700 (PDT)
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
Subject: [PATCH v16 09/14] gpio: uniphier: Utilize for_each_set_clump8 macro
Date:   Sun,  6 Oct 2019 11:11:06 -0400
Message-Id: <158460d4e9cb33a9a29aacf9596ac65227b5f2b1.1570374078.git.vilhelm.gray@gmail.com>
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

