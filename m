Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B4FCCC1D
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2019 20:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbfJEShr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Oct 2019 14:37:47 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40817 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388466AbfJESho (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Oct 2019 14:37:44 -0400
Received: by mail-yb1-f194.google.com with SMTP id g9so3262322ybi.7;
        Sat, 05 Oct 2019 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+SY6yjQG6ah82xj2QYbshpM9aG1FiA4CAoNvKBotSg=;
        b=oMsGg3qjUioiVwxhy6HbptGdKpRZ+Vr8ul2+q5EGxqAzzrdugyaLhAkacOufI2pW40
         8synDcEOXknEqQ/HbNH7xsFJhoDA13XDQKN/bpAz/sDES4DQUSo5iueUu4IZlWm9Nz9j
         zT7i11xqojBXXC74ncw0mOKVvq5xMgQ76IlP+wNmzPAWcIJ37shgKGbo5u9DH5/HQZ9U
         mRqOD4l8QybsL4Y/nrrCMW5FxwqgyxE3l8is66umR0mp4RxQUqsKojgxPIHUmONRUAbF
         GhcslhrzQLvB5Nzp6+3R/7tI3EslIHshQZB5lW7EjiH6QoevFTjwwdTc4smVnDreb2ho
         YpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+SY6yjQG6ah82xj2QYbshpM9aG1FiA4CAoNvKBotSg=;
        b=hUjUXgugPEzebYxjQkYE/QdSyOKvWVirUvkpJxibn3wBIAwmTLA2R7d1QGctvn5yiO
         aWtQbemJTL4dormVQYOapwK3c4EzzK110UQFkMJ/1ihmNDofj7jRc/dvwAU/L3jQ6Mgd
         aD1s2aAABmJrx/4AKDG0yBwksnONYWTPVbg9/39srdN0i3e0PmUdX5ZSaljE1E7DdR5Z
         dCo12hQzVo3fOTNCj70wC4JpW32GV2Zcu1Bjq51YgXM5YQYr5hYoCxT1KvSX7/fxQvic
         oVy/lqSrSjTrBYf70auz+kUWXZZD1tzxMy3nTnyLZ8XoDi/3xLXvTjxLnad3N2OmHszE
         0Mlw==
X-Gm-Message-State: APjAAAWcq4/BouBDBD3/cSF6l8jZD7dZ/h91LMSiOouIOFQX8uAO1PJ6
        lgN9Fa/kLxjy8GrZI2vhVx0=
X-Google-Smtp-Source: APXvYqzYIesCmhZv4GojWsrN/gedpRiqzq8cJBUpo5EY6y81pbrI4b8cFzrO5GvtJde6nGM7Tm00Mw==
X-Received: by 2002:a25:8485:: with SMTP id v5mr5805583ybk.460.1570300663165;
        Sat, 05 Oct 2019 11:37:43 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g128sm2376654ywb.13.2019.10.05.11.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 11:37:42 -0700 (PDT)
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
Subject: [PATCH v15 12/14] gpio: pisosr: Utilize the for_each_set_clump8 macro
Date:   Sat,  5 Oct 2019 14:37:06 -0400
Message-Id: <5f1623b622f5f8867cbae4b37d13570f1bfb3945.1570299719.git.vilhelm.gray@gmail.com>
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

Cc: Morten Hein Tiljeset <morten.tiljeset@prevas.dk>
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-pisosr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index f809a5a8e9eb..9ab2c044ef52 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -96,16 +96,16 @@ static int pisosr_gpio_get_multiple(struct gpio_chip *chip,
 				    unsigned long *mask, unsigned long *bits)
 {
 	struct pisosr_gpio *gpio = gpiochip_get_data(chip);
-	unsigned int nbytes = DIV_ROUND_UP(chip->ngpio, 8);
-	unsigned int i, j;
+	unsigned long offset;
+	unsigned long gpio_mask;
+	unsigned long buffer_state;
 
 	pisosr_gpio_refresh(gpio);
 
 	bitmap_zero(bits, chip->ngpio);
-	for (i = 0; i < nbytes; i++) {
-		j = i / sizeof(unsigned long);
-		bits[j] |= ((unsigned long) gpio->buffer[i])
-			   << (8 * (i % sizeof(unsigned long)));
+	for_each_set_clump8(offset, gpio_mask, mask, chip->ngpio) {
+		buffer_state = gpio->buffer[offset / 8] & gpio_mask;
+		bitmap_set_value8(bits, buffer_state, offset);
 	}
 
 	return 0;
-- 
2.23.0

