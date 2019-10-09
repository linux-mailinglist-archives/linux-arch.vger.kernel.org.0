Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47E4D1527
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbfJIRPg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:15:36 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36335 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731990AbfJIRPf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:15:35 -0400
Received: by mail-yw1-f66.google.com with SMTP id x64so1096084ywg.3;
        Wed, 09 Oct 2019 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+D/uU8MO7mShW9teASkMb7bJZjWkGz/G9NDBF9ekIAA=;
        b=kdbV1nKBX7QFRZZuqVlE1hddyif21obkYZGvk5fHtWvd6zoj6Pz93eZ+xnzRnwZjgS
         Nqvjk26iFkR4G8mVxThcXfh8q57/Pmn8tIVhB6h9M3pjsIcqrA2wZ8sJlc1753CAsMLP
         +JFodP7LOpcyFh9w4MnAX6uCZn7hhYk6rChrZ3eep/OSGHy+P8wGrf+g7RKM8wI9hk0c
         5Ko7/NuVNnd8hm/WAN/JQlZamaAA/MKjpFNpkKDDQZyqFRxyXKoXbiXsnuQdMs8VaUbK
         H91vFRRQYM9IUkULnr7kOYNzEbwx+cC1IQX8UKP+c1wn/Tsjq/ey0WU6Fjvf+w/mhnFs
         i53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+D/uU8MO7mShW9teASkMb7bJZjWkGz/G9NDBF9ekIAA=;
        b=WAr4OTetn4hLKaD/oHy5t8SDipzh7xBZavhflzpV6g8EsH852L+nfc7OVdyQfPXB7w
         yiOFKHB4GAyCR2ayFRVPhA6cKIrnb9kR3gYUp/Hx8C/2aQpSZDfmpk4otkvc1Oe2LEeq
         5gpcfkoBnbM19NrCsdBSE2EApV4RbxG30gDtSv9LXjyiEdzGf2sJzil78BoYXyzWSE8z
         zf/MGji+rFvp9Urmr6rStQfMcJYlbxS1oKv5e7ZJPQhEtJ7UdCSTBM18u/TEzatnvUws
         V/U0r/g6bQHdB2FHlLKBElcnObyK5gET7Kx+P/dwYpEl0aNJQ/bnT1bD6xS3cds+5RKa
         GkIw==
X-Gm-Message-State: APjAAAW/5voUX4Wyrvc29laiB+1l91+/t76gwXm8twrbX1m69K+PeA3f
        i0mVDQydjywK7o/R9NdsY6o=
X-Google-Smtp-Source: APXvYqx1ba26jfo53B5QvO53JIDI7zE0Ohda+kXHonbaNxBT3JWZ4rL68W3mYphHCXVQACx63/JBAw==
X-Received: by 2002:a0d:d490:: with SMTP id w138mr3761909ywd.139.1570641334354;
        Wed, 09 Oct 2019 10:15:34 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id r63sm743292ywg.36.2019.10.09.10.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:15:33 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v18 14/14] gpio: pca953x: Utilize the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 13:14:50 -0400
Message-Id: <3543ffc3668ad4ed4c00e8ebaf14a5559fd6ddf2.1570641097.git.vilhelm.gray@gmail.com>
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

