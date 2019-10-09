Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6097D152A
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbfJIRPs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:15:48 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46168 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731965AbfJIRPc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:15:32 -0400
Received: by mail-yb1-f195.google.com with SMTP id h202so967129ybg.13;
        Wed, 09 Oct 2019 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+SY6yjQG6ah82xj2QYbshpM9aG1FiA4CAoNvKBotSg=;
        b=hrLusYNvJ1DQpbUkoBMHYE55rFTTPsIggEfElG93+9hHsZ4K0HixUYO8YtR8kz6lZm
         CKS/qJQQn0/+amtUVfJ0vE+dvYvR5c5t/9gLdGfh4hY6LdV+mamSJwqSiiNyKf/r0YlX
         7ihURWvZLqe8UCDw5CXC0i8bROqdWCiRbIk4GUNT9Bf7PEQ/4N5hqF1FNhktD49xgzgt
         pOtgirxnIkRfCzZGP8CcQq2RXbDaLSUpyasA+99ihYGzDnt9YooU/GaVzG3pcKX0ue5W
         g0IL9l54W4dw24j79wxLKUL/ma998/vwsxBb/mv+Hj9ORYGfaK77WF3Eb88DEIBqiA3V
         qvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+SY6yjQG6ah82xj2QYbshpM9aG1FiA4CAoNvKBotSg=;
        b=rWx+0nNhMoBbug3wHywOKlnAgTYKrG5A/6qAdSpo0aM4+N5Y/Y1kZyViHW0+QHi9HH
         oopZui1WMxG/4zDtr8zw+ChuL3s3sfR4CuSoQ1fKbbtfsAlCQB4x3bypYt1wTEIzodAv
         6L3VzfEWqUoHIsaSuKYcFklFZVoLYwQzK5A/W2U9Wt6jp6YIMAbmiE1Ux7J39CKp3Ix0
         WJ9sENIISO0F7Dzn05c4RfQz0jUFBKl0Z7FRDX2wxhLsqSCOfiMujef/wMPAqD8tu07c
         YgVBPkVpiEpSpRtIe2smxEKORDPSQumbmoYxLuDRkNrTcIvyIvu+ybQfgwPFNKN/GavG
         oQdw==
X-Gm-Message-State: APjAAAU7CBx8YEJ/ExMbvTqcj3ybYNhJTDBTLzH6UnYd0gU6oAThVVRI
        g9av6b8GxYjVI9ETC6wzNwM=
X-Google-Smtp-Source: APXvYqwBPQgEIz1iAv+shQVmbFfhgFLw7r/9gS+jQhD5Ska0KC6Zn+TlJD16Y2mvIWdm9qJTJwx0pQ==
X-Received: by 2002:a25:55c5:: with SMTP id j188mr2791669ybb.5.1570641331036;
        Wed, 09 Oct 2019 10:15:31 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id r63sm743292ywg.36.2019.10.09.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:15:30 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Morten Hein Tiljeset <morten.tiljeset@prevas.dk>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [PATCH v18 12/14] gpio: pisosr: Utilize the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 13:14:48 -0400
Message-Id: <8a39ee772247d4b7d752b32dbacc06c1cdcb60b5.1570641097.git.vilhelm.gray@gmail.com>
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

