Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C76D12B0
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 17:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfJIP1l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 11:27:41 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45184 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731726AbfJIP1j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 11:27:39 -0400
Received: by mail-yw1-f67.google.com with SMTP id x65so944017ywf.12;
        Wed, 09 Oct 2019 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIovLVirYpbsjXR9oN+2msyJPjO/yPvE5mW4qwwn3Bw=;
        b=fNvV9MNtNRB2SmMcOwun6o/yv/8rboCkkmmp1LS9cIP+XOAGS/CLBRGWjYiMndh3MZ
         IoIaqluJ7KFSoJe5OT6s+wPfB9CiE5OFVpx8nIHZqW5ochtR6Bws7sXUGToSTRoqXxv9
         hggfw+nZMjBoXQDaIJ1xg5Pn3N2+t+Vx/hlt5xED7zWRGrEkJbti4gbDRvyESJoublv6
         f6D1qXclG7hC0/zLrtY8JDa/MW8GOSBv+8s4H5G/AbN+Pz8T0vPIiXgAk7Vpr2z8/HQf
         JY9nBx0BfnFIHpi0FzjbSJxUhHbZhH/SjiVBjEubz0mzV8AMXXIpsoyoRVge+4PMoHAr
         L7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIovLVirYpbsjXR9oN+2msyJPjO/yPvE5mW4qwwn3Bw=;
        b=s3/SV4iRUVoqTTizagIIkOgv/vWKeHw7SyPwWZFFwE7EUvn1LEFAp5mHCDBcn3NmHT
         nNNRx8Y4rZpijxifhltjYItp6lPXcA61ZIzfrQkyuxbMQL8OYXDu3EvISr1XkBM+F9Tf
         MzgAdrVDGe7iy6yD6eihHb2TT4aeEN1B/OqVTMF7+ZCnHLrYxe6yDdl+tCCwwBFdkuAM
         fioGZrTxCY+plJq2ny0aGmi4NXjmSI/+hjIAabjkhjSfiXeRkuAa2DjjKB2U2rqA8QTC
         q2Ru8KTXcocfE9RqiHI0/FsxAWwDx9vkl5GKlDdWKqZJaoPjEQBkqEEW48NquzUq8SSF
         QC9g==
X-Gm-Message-State: APjAAAWS3OXxv8pUWbfx9BcxObb/S+WPfmCXIaslPIVmOU0U0zAHEdkj
        pU4H26dgEyd7q/YTiwLzg2A=
X-Google-Smtp-Source: APXvYqyBszE2jXf2bk8hp0wGA9HvtwkClBo3hkRqIDNzmTGUtDiqqjtr7EsHCB00LexEl4Ttme0LUg==
X-Received: by 2002:a0d:ea56:: with SMTP id t83mr2975903ywe.351.1570634858790;
        Wed, 09 Oct 2019 08:27:38 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g40sm611863ywk.14.2019.10.09.08.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:38 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v17 04/14] gpio: 104-idi-48: Utilize for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 11:27:02 -0400
Message-Id: <b0631b6d489f85008480399df283ccd33ecfe310.1570633189.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570633189.git.vilhelm.gray@gmail.com>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace verbose implementation in get_multiple/set_multiple callbacks
with for_each_set_clump8 macro to simplify code and improve clarity.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-104-idi-48.c | 36 +++++++---------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index ff53887bdaa8..bf67040cbbbb 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -85,42 +85,20 @@ static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	size_t i;
+	unsigned long offset;
+	unsigned long gpio_mask;
 	static const size_t ports[] = { 0, 1, 2, 4, 5, 6 };
-	const unsigned int gpio_reg_size = 8;
-	unsigned int bits_offset;
-	size_t word_index;
-	unsigned int word_offset;
-	unsigned long word_mask;
-	const unsigned long port_mask = GENMASK(gpio_reg_size - 1, 0);
+	unsigned int port_addr;
 	unsigned long port_state;
 
 	/* clear bits array to a clean slate */
 	bitmap_zero(bits, chip->ngpio);
 
-	/* get bits are evaluated a gpio port register at a time */
-	for (i = 0; i < ARRAY_SIZE(ports); i++) {
-		/* gpio offset in bits array */
-		bits_offset = i * gpio_reg_size;
+	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
+		port_addr = idi48gpio->base + ports[offset / 8];
+		port_state = inb(port_addr) & gpio_mask;
 
-		/* word index for bits array */
-		word_index = BIT_WORD(bits_offset);
-
-		/* gpio offset within current word of bits array */
-		word_offset = bits_offset % BITS_PER_LONG;
-
-		/* mask of get bits for current gpio within current word */
-		word_mask = mask[word_index] & (port_mask << word_offset);
-		if (!word_mask) {
-			/* no get bits in this port so skip to next one */
-			continue;
-		}
-
-		/* read bits from current gpio port */
-		port_state = inb(idi48gpio->base + ports[i]);
-
-		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= (port_state << word_offset) & word_mask;
+		bitmap_set_value8(bits, port_state, offset);
 	}
 
 	return 0;
-- 
2.23.0

