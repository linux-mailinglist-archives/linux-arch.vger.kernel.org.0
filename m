Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5101CCC22
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2019 20:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbfJEShs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Oct 2019 14:37:48 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33529 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388376AbfJEShr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Oct 2019 14:37:47 -0400
Received: by mail-yb1-f193.google.com with SMTP id w141so2711265ybe.0;
        Sat, 05 Oct 2019 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+D/uU8MO7mShW9teASkMb7bJZjWkGz/G9NDBF9ekIAA=;
        b=D8RCOMOBnWY/mlNW/C5axvbf/3ehCZdse+eDY0V4znJS+RHth2royzKu97Yd4K1sv1
         b1mhUjoT+0vEljiChKoyxhmHsmatvUUnODBCCvx8GCUOLjvds0ykf4H3amGh7SXTzg8u
         X9xZpEiB6TREQz5mXUXnm27ZYLz+tAobmmbuLN9U2qAbuor3S1gKNiFChJhCcNu0IHBy
         q51Es6YRrewrlCCeFJTqYPfj+LwS0nSSGrTie476IIbYeGV/2HZz12NUjWAAi9/ULvij
         rodfb2+Qox6fsfRmOUNwlYKDh1abLBjlX2OH7HmMQ7MvcNyaJYXSe/cxfPAr5H+Anxpa
         kgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+D/uU8MO7mShW9teASkMb7bJZjWkGz/G9NDBF9ekIAA=;
        b=HOp7jV+c9u4ZEAqvoBf3ywibIenxeMF2wlypqc3eNy7ex2JWfsmdLvoJQIJV4IpahN
         uo/gzWlyUGVGR7/L3wNHrFk5nr9URp685CpzWN3l4LXd9VdpwKIzxhNMXVyhYqUiTZP+
         zlCEumlaPOxx3vT6ItHuedglvzkbXN+OQ/91z7hRtcjnb70bVqf12I3TkwaIQAE2AoeQ
         vQS2vA0e2kYUSN87DCRVwk2lcJjspEMHV0RJt9uoYvLbft0QRcvLkMa2C6KXAEGGbF38
         VmIqr+DoG8RAS4T7JAWCemDPCiaiXkLY5NSj7M42BmVCE0SjRsFcerSnpe0kr+v8oi2N
         v4Uw==
X-Gm-Message-State: APjAAAXkx7fg2H1U0IM5VUM8+bjpRZU5T7IGhH69o8YUKSuP2ISfiPhH
        ZVZDMb9iQeSqiknCSZVxSp0=
X-Google-Smtp-Source: APXvYqzbKeCNVgMNJGmKhK9BQMUZhI8Qkf9l6oWvXfibu1acZELcxJQyvcIBhfRHFc7pi+gD3H2O0g==
X-Received: by 2002:a25:c145:: with SMTP id r66mr5940783ybf.423.1570300665985;
        Sat, 05 Oct 2019 11:37:45 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g128sm2376654ywb.13.2019.10.05.11.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 11:37:45 -0700 (PDT)
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
Subject: [PATCH v15 14/14] gpio: pca953x: Utilize the for_each_set_clump8 macro
Date:   Sat,  5 Oct 2019 14:37:08 -0400
Message-Id: <0e06cc7486c1702c7a0d3d9f8a719379cf4993b3.1570299719.git.vilhelm.gray@gmail.com>
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

