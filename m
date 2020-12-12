Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720EC2D856B
	for <lists+linux-arch@lfdr.de>; Sat, 12 Dec 2020 10:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgLLJx4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Dec 2020 04:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbgLLJxQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Dec 2020 04:53:16 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234A8C0619D6;
        Sat, 12 Dec 2020 01:34:25 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id v3so5930833plz.13;
        Sat, 12 Dec 2020 01:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WXcPd+483PEznyO4jvnkSGgGlYQfHXVeIHWzyQm2ncM=;
        b=Wl9vC+4ELxkCwMr9bDvZvx+KC5THZHjhPm3tmWD+M9RLgj5b8YQCFKEN7ze6cSmxoI
         sTgBHjeObpO7qB+0emlQqVko33ww1S/EYG0ucEwj4/LyZXKLy5o749fH6K3syw195Lcn
         ny35VKCZtysJpuLzDANZO9uBuAKAaRLia4/A1HBDTUrkARc4xtjjGUH01L26T1gQS/KX
         Ej3iX+Mm7NEjX8Wm3d0nzAjLL6N8auiVwizIFqCZsImH6wp3Tn0G2Z0TVhooQ2e/k2dc
         0w3QXvxxUWeeQkTObQ9MVg13gl4qzA8dNkI1/+xyDSOoSChGiq4g6FMu2PKR9NNHB626
         YRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WXcPd+483PEznyO4jvnkSGgGlYQfHXVeIHWzyQm2ncM=;
        b=hvn8WvRNXaUWS323wqvOfx4Ob9XVcnhgg6E5YUwe6Vh8obguZIrF4ToAV4fKq0M/iZ
         8qOINuCThMA/y4jxnSOgooaL9Gdby6rfMWXe0ZIDX/sPThJSU5c5TH22d+L6NJ12MbGP
         riMWQpseXLegSAgE0aRJjAkxvZRVL/j4chl6VN4HrvfQGOxsJbwV/KOl5ddrySX69/BO
         4YPJQackrLDYqSTpNTnehcdx3haCYElipv44X9XYewmEewvBRYVrdhIEF5hYbhiw2Sa5
         9q1EkiMiJfefLUgILt7mht6MVFBPRwdibgUz/a51loBHrsPEcAbVmePcBp9pBOacW4Sg
         rkzw==
X-Gm-Message-State: AOAM532NddzGSu4eLiOwFo553banPkwq4KWYPnMAxpKp8A/SNXg9ftbR
        8GS7u8qpJAKM1hLyllNmTPM=
X-Google-Smtp-Source: ABdhPJwxtpcsd0Ah66k1CFJHGyjxaH4DBV2uGAmTP6q9XwnXC7BsGcXL0R7gLJlD3YYYYtQTDgcz+g==
X-Received: by 2002:a17:90a:dc07:: with SMTP id i7mr16611865pjv.163.1607765664582;
        Sat, 12 Dec 2020 01:34:24 -0800 (PST)
Received: from syed ([106.202.80.219])
        by smtp.gmail.com with ESMTPSA id s24sm8063609pfh.47.2020.12.12.01.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Dec 2020 01:34:24 -0800 (PST)
Date:   Sat, 12 Dec 2020 15:04:05 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/2] bitmap: Modify bitmap_set_value() to check bitmap
 length
Message-ID: <20268bfeb500ad8819e3a11aa1bea27eade4fd39.1607765147.git.syednwaris@gmail.com>
References: <cover.1607765147.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607765147.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add explicit check to see if the value being written into the bitmap
does not fall outside the bitmap.
The situation that it is falling outside would never be possible in the
code because the boundaries are required to be correct before the
function is called. The responsibility is on the caller for ensuring the
boundaries are correct.
The code change is simply to silence the GCC warning messages
because GCC is not aware that the boundaries have already been checked.
As such, we're better off using __builtin_unreachable() here because we
can avoid the latency of the conditional check entirely.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

lib/test_bitmap.c: Modify for_each_set_clump test

Modify the test where bitmap_set_value() is called. bitmap_set_value()
now takes an extra bitmap-width as second argument and the width of
value is now present as the fourth argument.

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

gpio: xilinx: Modify bitmap_set_value() calls

Modify the bitmap_set_value() calls. bitmap_set_value()
now takes an extra bitmap width as second argument and the width of
value is now present as the fourth argument.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 drivers/gpio/gpio-xilinx.c | 12 ++++++------
 include/linux/bitmap.h     | 35 +++++++++++++++++++++--------------
 lib/test_bitmap.c          |  4 ++--
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index ad4ee4145db4..05dae086c4d0 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -151,16 +151,16 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	spin_lock_irqsave(&chip->gpio_lock[0], flags);
 	spin_lock(&chip->gpio_lock[1]);
 
-	bitmap_set_value(old, state[0], 0, width[0]);
-	bitmap_set_value(old, state[1], width[0], width[1]);
+	bitmap_set_value(old, 64, state[0], width[0], 0);
+	bitmap_set_value(old, 64, state[1], width[1], width[0]);
 	bitmap_replace(new, old, bits, mask, gc->ngpio);
 
-	bitmap_set_value(old, state[0], 0, 32);
-	bitmap_set_value(old, state[1], 32, 32);
+	bitmap_set_value(old, 64, state[0], 32, 0);
+	bitmap_set_value(old, 64, state[1], 32, 32);
 	state[0] = bitmap_get_value(new, 0, width[0]);
 	state[1] = bitmap_get_value(new, width[0], width[1]);
-	bitmap_set_value(new, state[0], 0, 32);
-	bitmap_set_value(new, state[1], 32, 32);
+	bitmap_set_value(new, 64, state[0], 32, 0);
+	bitmap_set_value(new, 64, state[1], 32, 32);
 	bitmap_xor(changed, old, new, 64);
 
 	if (((u32 *)changed)[0])
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 386d08777342..efb6199ea1e7 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -78,8 +78,9 @@
  *  bitmap_get_value(map, start, nbits)		Get bit value of size
  *                                              'nbits' from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
- *  bitmap_set_value(map, value, start, nbits)	Set bit value of size 'nbits'
- *                                              of map at start
+ *  bitmap_set_value(map, nbits, value, value_width, start)
+ *                                              Set bit value of size value_width
+ *                                              to map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -610,30 +611,36 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 }
 
 /**
- * bitmap_set_value - set n-bit value within a memory region
+ * bitmap_set_value - set value within a memory region
  * @map: address to the bitmap memory region
- * @value: value of nbits
- * @start: bit offset of the n-bit value
- * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).
+ * @nbits: size of map in bits
+ * @value: value of clump
+ * @value_width: size of value in bits (must be between 1 and BITS_PER_LONG inclusive)
+ * @start: bit offset of the value
  */
-static inline void bitmap_set_value(unsigned long *map,
-				    unsigned long value,
-				    unsigned long start, unsigned long nbits)
+static inline void bitmap_set_value(unsigned long *map, unsigned long nbits,
+				    unsigned long value, unsigned long value_width,
+				    unsigned long start)
 {
-	const size_t index = BIT_WORD(start);
+	const unsigned long index = BIT_WORD(start);
+	const unsigned long length = BIT_WORD(nbits);
 	const unsigned long offset = start % BITS_PER_LONG;
 	const unsigned long ceiling = round_up(start + 1, BITS_PER_LONG);
 	const unsigned long space = ceiling - start;
 
-	value &= GENMASK(nbits - 1, 0);
+	value &= GENMASK(value_width - 1, 0);
 
-	if (space >= nbits) {
-		map[index] &= ~(GENMASK(nbits - 1, 0) << offset);
+	if (space >= value_width) {
+		map[index] &= ~(GENMASK(value_width - 1, 0) << offset);
 		map[index] |= value << offset;
 	} else {
 		map[index + 0] &= ~BITMAP_FIRST_WORD_MASK(start);
 		map[index + 0] |= value << offset;
-		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
+
+		if (index + 1 >= length)
+			__builtin_unreachable();
+
+		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + value_width);
 		map[index + 1] |= value >> space;
 	}
 }
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 1c5791ff02cb..7fafe6a0bc08 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -656,8 +656,8 @@ static void __init prepare_test_data(unsigned int index)
 	unsigned long width = 0;
 
 	for (i = 0; i < clump_test_data[index].count; i++) {
-		bitmap_set_value(clump_test_data[index].data,
-			clump_bitmap_data[(clump_test_data[index].offset)++], width, 32);
+		bitmap_set_value(clump_test_data[index].data, 256,
+			clump_bitmap_data[(clump_test_data[index].offset)++], 32, width);
 		width += 32;
 	}
 }
-- 
2.29.0

