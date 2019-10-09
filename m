Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D2DD1291
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 17:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbfJIP17 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 11:27:59 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38417 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731800AbfJIP16 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 11:27:58 -0400
Received: by mail-yw1-f66.google.com with SMTP id s6so959687ywe.5;
        Wed, 09 Oct 2019 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+D/uU8MO7mShW9teASkMb7bJZjWkGz/G9NDBF9ekIAA=;
        b=M6XRUjfZq39AjkcgPSUAdckM2+dSQa7UVUtap+gSKdeq297uOsrTQOStLUzvs00Qrb
         606E6Wl/7AIVW+481GiVFj9U70JbVhcT4rJQhU8u0cdjRd/ahDVXc08IZfHlfsRisU65
         HUf/gtgrZDf8ucFfmS7yer7Q2ZO4chbV49OgeG+21rgNRnhnrhWYgbBCAc/TInIbmwv/
         1kQeiD7tPqfWieHEf4TGMLOkmFlM8tdMHUxPbTMWXppeJrqD/PuAwT34w/ZYKtG9VlRn
         zeCV/UDX85wFycgwSfM7h2+qKSN4ukBHcA7y8FcnEjOH1cWoWnqsTz0WE5j6yXxO/LoN
         Tf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+D/uU8MO7mShW9teASkMb7bJZjWkGz/G9NDBF9ekIAA=;
        b=mnRUMoeAiKH+pNpo4CxoVSDIMGnFWRLt/yxZhbKxVw9rchURr/lsvSLvQsk0LP3e7V
         HMWhPwNBEaLPtQbQpKYAOZxUJII64ztBxsxpexdt8C7hGkCUAgBRIqQ0TY9t6ejFPcDW
         ShTpKE1gEy+Ex/RQlinJ0mpmTL8DEScijH392EsW1osRKXiqAD4FjLDU2GaKEBVBEA1c
         23huAZ04BomRfVZyRA88WQYupsC2oOXrMfymCf4KW/VOM4ABSEtA0CW/mauFyWXdTXGU
         OyX+5c9fuhF/Ueg2sFbNAMSNaxwD8Fnhj3s4ciWvsOkATFD2QDITVlmzlDjj8WEBp7Qn
         JYrA==
X-Gm-Message-State: APjAAAXJNvZm7jfKjHyABZSoC4K9MJeTslTI40QFdsXhNBwL3udT9aTJ
        Hj+h/AHwTFIPdwTaZ96meuM=
X-Google-Smtp-Source: APXvYqz0Hy2G/IPQYpNgQ2+jg5eXDNlvGay9DVAaikzPXiFu+PnfuZUhGx/byXO6uT9JyUj3SwB22A==
X-Received: by 2002:a81:1ec8:: with SMTP id e191mr2994034ywe.447.1570634877541;
        Wed, 09 Oct 2019 08:27:57 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g40sm611863ywk.14.2019.10.09.08.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:56 -0700 (PDT)
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
Subject: [PATCH v17 14/14] gpio: pca953x: Utilize the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 11:27:12 -0400
Message-Id: <ec3264f6b21c61d3a04e929cc0f84be485decdaa.1570633189.git.vilhelm.gray@gmail.com>
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
for_each_set_clump8 macro to simplify code and improve clarity.

Cc: Phil Reid <preid@electromag.com.au>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-pca953x.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index de5d1383f28d..10b669b8f27d 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -456,7 +457,8 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
 				      unsigned long *mask, unsigned long *bits)
 {
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
-	unsigned int bank_mask, bank_val;
+	unsigned long offset;
+	unsigned long bank_mask;
 	int bank;
 	u8 reg_val[MAX_BANK];
 	int ret;
@@ -466,15 +468,10 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
 	if (ret)
 		goto exit;
 
-	for (bank = 0; bank < NBANK(chip); bank++) {
-		bank_mask = mask[bank / sizeof(*mask)] >>
-			   ((bank % sizeof(*mask)) * 8);
-		if (bank_mask) {
-			bank_val = bits[bank / sizeof(*bits)] >>
-				  ((bank % sizeof(*bits)) * 8);
-			bank_val &= bank_mask;
-			reg_val[bank] = (reg_val[bank] & ~bank_mask) | bank_val;
-		}
+	for_each_set_clump8(offset, bank_mask, mask, gc->ngpio) {
+		bank = offset / 8;
+		reg_val[bank] &= ~bank_mask;
+		reg_val[bank] |= bitmap_get_value8(bits, offset) & bank_mask;
 	}
 
 	pca953x_write_regs(chip, chip->regs->output, reg_val);
-- 
2.23.0

