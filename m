Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48637CD28E
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2019 17:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfJFPLv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Oct 2019 11:11:51 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39759 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfJFPLv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 11:11:51 -0400
Received: by mail-yw1-f65.google.com with SMTP id n11so4173585ywn.6;
        Sun, 06 Oct 2019 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+SY6yjQG6ah82xj2QYbshpM9aG1FiA4CAoNvKBotSg=;
        b=n/Wb2z5ac4SZMTalEqwdc7QDCe8+Ouu08UZL+YXF3fcBU4QhQnOMhYZBFIzxQG4hr+
         7C/35KQoh+qGUCchTX2qESlNO6SVio+Kv04lyzZGh1FMtQffTTC3dxC8hVsWx2WgyTS0
         ukDGrl3CBCtNLegJ9flr0vpfmEvXTNq8RIwNfTbZ2Eh94osR07ZfF0O+MadLHMDzkp9u
         uNF3t4OunvnaFox2C78G4FKI+1i5Vtk+bbUQMoSR14BiwFhy1wRmsvd78QuW5mlGIX2G
         EGuf6JVI63VPyySprvZeTPr/Pty862/HPJ/ONMnztf4HVBAna45wfvpe0GYfdVAec3ZM
         RXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+SY6yjQG6ah82xj2QYbshpM9aG1FiA4CAoNvKBotSg=;
        b=eKOLADZfrWZWGABQEx7+0C8c6SJ2FBajc4aMVW54YDqO0oPEmueFaAgn5EtJQZiXVV
         EijQhvtMVqRvjMzVBWKRQ7IS6+20k8tWG3jnYePAOKUuEIYi0HbSRVOVOgj1GZEf0dY4
         3TN525tNa+yVk3N+Lp5Os5vTIPT/k9aP1WJmV3rNxL0bDgSoxCP3nf+gjUQgmQmNRYFG
         h7V52ALIA9EVnD3v+C/43HirIwMp2hm+oMtReUWw27fqVo3V4w0A0I/72j5nOk5qLbDc
         aaJMYXifiotGtQC8S1lWg6j3byCMqBwaWtg/NCXL8z9bfn4q6HlPYUpM4Wi54NJj8UxH
         q4uA==
X-Gm-Message-State: APjAAAVb5v59b8XLudV0RX3Fo0UoUWkYiEa2VA4U19f4kZk9gg8EkHAm
        Jtenvj+2E4Aohrf2IRzaSDs=
X-Google-Smtp-Source: APXvYqxxXXJnm8HJzt/VyDIzw3iepOO/WG++Zq0TXsTwYRrBCos7MQOYzUhEmVHDR38fp+Ki9kRL9Q==
X-Received: by 2002:a81:7743:: with SMTP id s64mr17250968ywc.183.1570374709825;
        Sun, 06 Oct 2019 08:11:49 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id e82sm2662434ywc.43.2019.10.06.08.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 08:11:49 -0700 (PDT)
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
Subject: [PATCH v16 12/14] gpio: pisosr: Utilize the for_each_set_clump8 macro
Date:   Sun,  6 Oct 2019 11:11:09 -0400
Message-Id: <19e98b4a648026055d0642d238dbf5ed5a4b4117.1570374078.git.vilhelm.gray@gmail.com>
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

