Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D24CCC1B
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2019 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbfJEShr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Oct 2019 14:37:47 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39816 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388502AbfJEShp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Oct 2019 14:37:45 -0400
Received: by mail-yw1-f65.google.com with SMTP id n11so3570230ywn.6;
        Sat, 05 Oct 2019 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8x7m/5RR5niKmXD30eK9BE6FJuZuruIF1z3Nwo21nyU=;
        b=mvRHq/HHO4GwcB1HoFMi/wo7FgueXzw5eKqIi0VCj5Hknn8KLncdCqbUBqhHl8erer
         +FI/3+oyVjVmaC2UL7n5fYS2JvrqSte+13DDCqfbyLy5TRbBNaJ9REgEkl1MqMZHAtK0
         1JMYaKTP3QlFopvATShTgW8I+iUra17eqLQAVLi0ziaWtcz1eF05YweLsJ1ixa7/lJ4H
         IAokoM4L6iy+VI3kJpPJ8MdLZ19m2PVNWoz8O4L8jeQuS4Vw6J+2n9NXYj+UIBkhaAe7
         4aJMsRCnhmO+ofDCpSq9gpNgpp+DnFmt7Qz11cbMNGH5YYo17Yo88LeKYk34MGGrJUh8
         d0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8x7m/5RR5niKmXD30eK9BE6FJuZuruIF1z3Nwo21nyU=;
        b=k/1WeP4Bw3XjOVELIdU86GVbxAOJoUUIh+rFRa3mb6b7Bt4zoOipXqCyWArEKmYLGU
         uK0et0vSe1iFhwbCqlZk3kbujPVDoR1N02hZm/z701ipmmqWJXUdSsOthb4XpbZmWBDD
         8xyE9Wvo7DMi5gJrnaewyLi/uuHsNUdpYY+1PvPs0KCbObL/8sC66HNPGYM6zsP2cmzt
         JtSk55jiBaPTJ1X9Z6NozAmQXXems2Am1N6EQZVaIexmhf8CVMKT7j9ZIt/mTOgsP2FF
         IdvfOvppvZOH4ohxTIEPSmBs/vLEXGURYb3rA1pHZOS7rOjgLrPBj6tWgfgqjkLVjpsK
         sCvQ==
X-Gm-Message-State: APjAAAVxOzmFxCCCnzDllA9I6CyKw8JP/rHTQ5tj9kkGo2l1vXCHrDpo
        nTJ+7U/QIwkUYxYvjb+Wduw=
X-Google-Smtp-Source: APXvYqxJqA+8g598YzD00MFUyEN8LQBOm+k91SJoO3klCvDIc3o0YrxJdN4P6a+3u132qXedMXvttA==
X-Received: by 2002:a81:bb42:: with SMTP id a2mr14686782ywl.385.1570300664365;
        Sat, 05 Oct 2019 11:37:44 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g128sm2376654ywb.13.2019.10.05.11.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 11:37:43 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Mathias Duckeck <m.duckeck@kunbus.de>
Subject: [PATCH v15 13/14] gpio: max3191x: Utilize the for_each_set_clump8 macro
Date:   Sat,  5 Oct 2019 14:37:07 -0400
Message-Id: <f07b6bb5619ea1365cc58266254a7b5be65a9082.1570299719.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570299719.git.vilhelm.gray@gmail.com>
References: <cover.1570299719.git.vilhelm.gray@gmail.com>
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
index 4b4b2ceb82fc..9a98ecf625ac 100644
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
+		bitmap_set_value8(bits, in, offset);
 	}
 
 out_unlock:
-- 
2.23.0

