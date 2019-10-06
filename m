Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FE4CD276
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2019 17:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfJFPLy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Oct 2019 11:11:54 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38086 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfJFPLx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 11:11:53 -0400
Received: by mail-yw1-f66.google.com with SMTP id s6so4177576ywe.5;
        Sun, 06 Oct 2019 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+D/uU8MO7mShW9teASkMb7bJZjWkGz/G9NDBF9ekIAA=;
        b=bSaBzvAm7KA+Z/RsiMdo7RdD6lPZanjxLUuwHA3WYW2PklPBygtPZwz4rImtHSmqZC
         /HnjmIQeRebqFtRiVoceY8ds406L6UZJ1DYUz6ZGQMD3INfafFKEi+0wwYVbdhwnGQ4a
         bvIxyiWv7HzbHyulJAhvUugTqHm1U7VG2ajipNGF3dnH3fIqjZ5QJTm2Oq5C2bvtG91u
         mTeUEGBRdsPJ8krYvExNEWIcqP12Wr6LNuPVnkE9XcriRZf18Ct/5hZyXXXWy9yQF+98
         l7ZGiLbhCnrhPU3yw8EGIF8ZkLWst53Ovm89jxBlqlzykMnTtxQIzw8KT+2DWIoapry4
         NUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+D/uU8MO7mShW9teASkMb7bJZjWkGz/G9NDBF9ekIAA=;
        b=k+0MYw7cIXj2dtmbQ/yij8ruuhW9E7PP+qr4WWNO57jwHn4eD4fejlxVddpbm8nRdy
         JcPuQOmaqU7p0gy4oPAvsI2mgFN0a2NqcRXvlcv+xxt6jASUgc1fCcLU6p+jOAxpqX1T
         6i3wFVOP4SFNDPFbBbbp2fjNPvh2JsTWfh6rB5PZEnm4XDuhlvMfXYHsn2VOwze1PH0D
         TWsLtE+MPrx8i/GE1VQkGPGilJVUFXXTUPPzXrXk/J1f9JIUYhNxR0qN+LLtBcAVPjMM
         +P0x5xHRJ6R+3MBlFo4laKcoqYbCNzPaDbI3FqcFU2I6KcCoS5adiUsIHD0TD+sg982v
         nHng==
X-Gm-Message-State: APjAAAXD2aqqQlEZK+0bDZ0bipt93MYxMQ0ag8nK2BN028hUB5PNlbRQ
        KMskIxtHjmvUztWnAeXEC2o=
X-Google-Smtp-Source: APXvYqwr2ooDXQQ6eqsusMVR7Kxn0E0w2B0g/QYDmlIZXMarPB9hGznNphE4oCV+6ROdcWSP24S/hQ==
X-Received: by 2002:a81:6bc2:: with SMTP id g185mr16996224ywc.316.1570374712617;
        Sun, 06 Oct 2019 08:11:52 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id e82sm2662434ywc.43.2019.10.06.08.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 08:11:52 -0700 (PDT)
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
Subject: [PATCH v16 14/14] gpio: pca953x: Utilize the for_each_set_clump8 macro
Date:   Sun,  6 Oct 2019 11:11:11 -0400
Message-Id: <e72393325e58778b7ba59c80c6b79c1f93b81d8d.1570374078.git.vilhelm.gray@gmail.com>
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

