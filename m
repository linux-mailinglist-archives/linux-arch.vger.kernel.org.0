Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30802CD290
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2019 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfJFPLw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Oct 2019 11:11:52 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41908 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfJFPLw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 11:11:52 -0400
Received: by mail-yw1-f67.google.com with SMTP id 129so4167408ywb.8;
        Sun, 06 Oct 2019 08:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQMsvrMqAN5cYMrSu91Pu66B0Sg+HB0aWPXdvZz2KcA=;
        b=HdegEL2fpTV5hm7hUSkkzZ4H15/08rNMz0M2X1pafGXHTQhJLsKPHNgwbtw6c6lfg1
         SMO5McnqQP8Ykh3+jU8j9FjTNMKFttnbpN+/DgyhxRLu8di7tag1tcKKHnjrauFAZ1/a
         RgF5TX87i7ZmA8M2LsMwM6qDAp541QBZSnpjTi+o4XszUJDLj5+nMjvMGLtqEqfebny8
         3myOdCVECCqS6vzRlbl/QMtqj0gaooDXwjQOUhZhtP5+8nxHlWw5JrwZgIsHTCwTqm4s
         sMDxDPdORADs9WMTq9N8pDqXpwvAZ8vSUCTDWrQQBMoI1v3HYoMWj5ACxbSPCGOnDOjq
         EBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQMsvrMqAN5cYMrSu91Pu66B0Sg+HB0aWPXdvZz2KcA=;
        b=Ff4kUs3y1pcxtio3/ALKK6rWvyhPd9AZ/aeXeJsPtf735QftsjVV6KCOUt2gjy6ZPw
         9cghqg5Btja/TRl3XSq+m9dfeB/Ai8sEe+XyfZMEXtP75HzWY7iULLNYyhhZR1pki1rh
         jxZAWSZPcW5ywCR37UIrmCyqJGefTra6Ytjl7xvXLNMfHFA17cBonvltgd3UXkglyH66
         5z+BhhylBnO+xTaRyrROMnHCf+8xXSf+mZmZCSwCfVx2T1OSYcpJD+xNofrHDc8NBaiu
         +Zbwhrz13AwwQ2saaT2GOvKvKDd0D66zRunTg5HXGQsqrNVHh+nS/rnW3A3g+7h/jIQd
         qUDg==
X-Gm-Message-State: APjAAAXjZRi5+BNaGW72nfJy2HJ4YifdY+DfwH0Wz98bRQGT/iy+tw6G
        KdNvTCIO9KLhKfl+F7S7xFY=
X-Google-Smtp-Source: APXvYqxfMNyInhJxsFvLfYNQNh5jJ/+1V+3JSPgN+LhsqCDG6NcJucB+B2+9PrG0NdChfsJ9jp4jIA==
X-Received: by 2002:a0d:df83:: with SMTP id i125mr15974641ywe.260.1570374711014;
        Sun, 06 Oct 2019 08:11:51 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id e82sm2662434ywc.43.2019.10.06.08.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 08:11:50 -0700 (PDT)
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
Subject: [PATCH v16 13/14] gpio: max3191x: Utilize the for_each_set_clump8 macro
Date:   Sun,  6 Oct 2019 11:11:10 -0400
Message-Id: <821e44729c9e561899b9c746b29bcdf56201aca9.1570374078.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570374078.git.vilhelm.gray@gmail.com>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
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

