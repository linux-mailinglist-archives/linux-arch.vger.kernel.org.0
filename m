Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111EDD128C
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 17:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfJIP15 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 11:27:57 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45197 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731788AbfJIP14 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 11:27:56 -0400
Received: by mail-yw1-f68.google.com with SMTP id x65so944371ywf.12;
        Wed, 09 Oct 2019 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQMsvrMqAN5cYMrSu91Pu66B0Sg+HB0aWPXdvZz2KcA=;
        b=r+SUHFOZ26RdG6VxUf2qcKuuetu4H5Jy71X9gc45BPmyGIWDg+m2ICnyeTlBpzTaYy
         CJkhi1YwtYAxMoW2sb6vh3kuTTCfvBmqCwee3qYMm9xq9sebu8z28QBS9rsm9eXEa51A
         ub0qbTjI1gW3bcXOW4Eyo5fCs+2Re21sEbFuCcGQBVDxubUvTdPwINl476Z4v1Vj9XdB
         H7VyPRNQhG6wbT+vhq1A31C3lYT6kFCpppGlzRPxPly3PC51nS0pThzV8ALxXAWBqubq
         vWhmV++0papriWbPkg1Fa2NPp+EazD8WfSX4yTy8E/IOYfTMd4pKaHju+rZ14PSsS8WY
         qQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQMsvrMqAN5cYMrSu91Pu66B0Sg+HB0aWPXdvZz2KcA=;
        b=Ez5Pj0opTBEkIDOBOijxqvDQa2MAPSKPgzmcXCEkebC7mNe7zzxP/rbvimunrXSQtT
         d/yS/iXBfXu3z015U74IRRAZLvP4cSw58aSZTlhFnuo611l7qMJVg1gMFBo9xhCC5rfU
         mRic9EkIRge8x4OEt9g8ycfCFPkgbgc6fRy428DqPG6KwPFIWSlQEMIt3+ov0Yr9yNCd
         pc7fgMDuqS/ofQlklA4D9tesRddSDMDrTG2uZFXAKPe8MsHMgkDUH0iAtG0VmqKOQXTX
         gWQMiUEo+pbqdgRhd0ekKHEKbTLRVp9tUZaR8Uf23Qp3uoSFUT8ZmTsHqZ9URzYu7SDJ
         YUyQ==
X-Gm-Message-State: APjAAAX/4vKPwWYIZY/B3pfr/8ZBoHeDY0vndMf1GH4aBJ2tHqyrDZYR
        h3y61CnCYvC3aUAB0Zqyj/I=
X-Google-Smtp-Source: APXvYqwuNhTbWq/PG0RP9JpS27Oz9nkPF9Zk/MVFJHItYQxkkX5GUEHZmZZM8o80I0U9hChw4rzttw==
X-Received: by 2002:a81:5d5:: with SMTP id 204mr2951452ywf.441.1570634875666;
        Wed, 09 Oct 2019 08:27:55 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g40sm611863ywk.14.2019.10.09.08.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:54 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Mathias Duckeck <m.duckeck@kunbus.de>
Subject: [PATCH v17 13/14] gpio: max3191x: Utilize the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 11:27:11 -0400
Message-Id: <84b39366ee561aa63214bf3e74716d821157c531.1570633189.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570633189.git.vilhelm.gray@gmail.com>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
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

