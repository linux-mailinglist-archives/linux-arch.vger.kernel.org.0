Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54724D1520
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbfJIRPe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:15:34 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44499 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731978AbfJIRPd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:15:33 -0400
Received: by mail-yw1-f65.google.com with SMTP id m13so1076089ywa.11;
        Wed, 09 Oct 2019 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQMsvrMqAN5cYMrSu91Pu66B0Sg+HB0aWPXdvZz2KcA=;
        b=PGJQlbBDuENA6RKdMPrsxNZh6nst1zCDQfAK+p2cso3insZOWY8FJEwOLv8XenLtXO
         bGBQwd34unyuouDzIG7HmrZIvPHnyWr41NSFvJAL/xOS82fgD1NfhseCwhfw2DikqEu5
         eVmbp/Vn7KgewV0075KN8zTpeX7qMQSNUokumcZaEeZsJG5VO/PfXYDcOLC9JCZ890KW
         y0sQAJpfgG+FsGKD3Iys1Y+e55c+N8gknc5iUoa49tq8VWF2un0vL+D3LELYFnV+GDFv
         gzgYMpXOTFDKPjhHGuCRvpkZSc1A0imSUuHlDqkMGLTgqTAaC53i29PN+CEA9l1XwD0+
         tT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQMsvrMqAN5cYMrSu91Pu66B0Sg+HB0aWPXdvZz2KcA=;
        b=ilEmj9c+yWGjLBz4zNmfUn7fJy5PhUcZFbCxXzk5qx1ZSrKwnFAJq9tfrjQHruGs1H
         l9EcyIXPbjVS3yX0uQJszWHKh+nrAoDtzWr7VaGpDLAvK73gHYXV+WKR9DyTDYmvBdHd
         hBccHxzIL+RqbNuC+jM2CVfduw0ua9EnZ2Uj0tZkSOTq9T6XW6ibQmctTrZ+09Y5EyTk
         r/WqjvQU8gl3V9oEDdMV4cqLj3K67A24Obp4jPOBV20IpPati6DqMIol8vSSd9C7a+6y
         wzrqsfSExOp1gZKXteoQmDfn4OBSmog/F3WOAS6ZVrRG0RjxK1qYdKWx23B4yeYPCN2Z
         UDog==
X-Gm-Message-State: APjAAAVhQ24qf9KJAqPXNsw3hrhdB/ljou5sg1Gucjij8twIE0UOvOLC
        k2NFwbft4uFxq63IBYZUiLk=
X-Google-Smtp-Source: APXvYqxPf397BWAZAXQxl/ej3ydag60BplqntuCWiFdPKrkxGZDZCFC0ugMw5RZO4Kunw4jd93LwwA==
X-Received: by 2002:a0d:d042:: with SMTP id s63mr3399648ywd.356.1570641332590;
        Wed, 09 Oct 2019 10:15:32 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id r63sm743292ywg.36.2019.10.09.10.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:15:31 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Mathias Duckeck <m.duckeck@kunbus.de>
Subject: [PATCH v18 13/14] gpio: max3191x: Utilize the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 13:14:49 -0400
Message-Id: <c2b1ed62caf6fce6e5681809a50c05ce6acdf2a6.1570641097.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570641097.git.vilhelm.gray@gmail.com>
References: <cover.1570641097.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace verbose implementation in get_multiple callback with
for_each_set_clump8 macro to simplify code and improve clarity.

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-max3191x.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index 4b4b2ceb82fc..0242c6187bf5 100644
--- a/drivers/gpio/gpio-max3191x.c
+++ b/drivers/gpio/gpio-max3191x.c
@@ -31,6 +31,7 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/bitops.h>
 #include <linux/crc8.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
@@ -232,16 +233,20 @@ static int max3191x_get_multiple(struct gpio_chip *gpio, unsigned long *mask,
 				 unsigned long *bits)
 {
 	struct max3191x_chip *max3191x = gpiochip_get_data(gpio);
-	int ret, bit = 0, wordlen = max3191x_wordlen(max3191x);
+	const unsigned int wordlen = max3191x_wordlen(max3191x);
+	int ret;
+	unsigned long bit;
+	unsigned long gpio_mask;
+	unsigned long in;
 
 	mutex_lock(&max3191x->lock);
 	ret = max3191x_readout_locked(max3191x);
 	if (ret)
 		goto out_unlock;
 
-	while ((bit = find_next_bit(mask, gpio->ngpio, bit)) != gpio->ngpio) {
+	bitmap_zero(bits, gpio->ngpio);
+	for_each_set_clump8(bit, gpio_mask, mask, gpio->ngpio) {
 		unsigned int chipnum = bit / MAX3191X_NGPIO;
-		unsigned long in, shift, index;
 
 		if (max3191x_chip_is_faulting(max3191x, chipnum)) {
 			ret = -EIO;
@@ -249,12 +254,8 @@ static int max3191x_get_multiple(struct gpio_chip *gpio, unsigned long *mask,
 		}
 
 		in = ((u8 *)max3191x->xfer.rx_buf)[chipnum * wordlen];
-		shift = round_down(bit % BITS_PER_LONG, MAX3191X_NGPIO);
-		index = bit / BITS_PER_LONG;
-		bits[index] &= ~(mask[index] & (0xff << shift));
-		bits[index] |= mask[index] & (in << shift); /* copy bits */
-
-		bit = (chipnum + 1) * MAX3191X_NGPIO; /* go to next chip */
+		in &= gpio_mask;
+		bitmap_set_value8(bits, in, bit);
 	}
 
 out_unlock:
-- 
2.23.0

