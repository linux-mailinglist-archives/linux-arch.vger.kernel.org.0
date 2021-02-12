Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5BF319FB8
	for <lists+linux-arch@lfdr.de>; Fri, 12 Feb 2021 14:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBLNVZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Feb 2021 08:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhBLNVX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Feb 2021 08:21:23 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E04C061574;
        Fri, 12 Feb 2021 05:20:42 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id t11so6228309pgu.8;
        Fri, 12 Feb 2021 05:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cTQEqXBmnHB2EgizLse4tydi3im1uOQRvgvnrkN47J8=;
        b=c2m4BrFm6utQ8jG49ztsui33dIHmVYha/smSZZp6CdGbN7x9X8NAVvf3UAdn+H12Jf
         Bo/Kqyr9ttnxE0XM3TbkYTsU7JNjWd8TT3R+7hMNaxPGffGQATTAcoXgDnFLcimQO7zY
         5zYQ3qsfhBtXcTRcs/ESmGyiydTjxZNKzG1rhh8VRoq6a9MfdkeUx7v83NhyFm9bCpyP
         lQcCy3UGYiCOgJAdMM9+YD2A0uiCRiHzXj9VwF/Kxu2cwhAqmwPxhWLLb1/FXUlCdi6T
         9W6s4mawVTzuZtj2f/spx5VzYgK99wKtjIGGWARfmKrjt57/SpbfdLQ3W+Bj4lS1ife7
         4wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cTQEqXBmnHB2EgizLse4tydi3im1uOQRvgvnrkN47J8=;
        b=R9U/fyBggk3SLeuVPHjKjVNCZ1AkkIOpU7kKfBifvBxDFR4GjojhaxjqLaRl6N8xnx
         yMei7Tnlm7n//oNG2FGyJFbZOQw84JaGrvsW4vfksV0qzpvIDPKy5YuVbCfJTPQ+H/7A
         Y7Q+FXHE9S7Ha/d/OfkmITkqRZPgxW/i8PDFnqgpFVIEpQ9ea5nQNZDYzcOZXQdzFBZk
         7r9iqN2va7By3/Y2OO9xZ18XhJVYlI0xZ8mzAX5yaLuTRQZeF+n+WVKao4f6/NqBV36j
         G70quBi8i2wEjSxLJ47nnUrviKcfRFEekNJJ+Z8GamAKiDnz/Or9eyV2IQ4jqjxsz30z
         uYXQ==
X-Gm-Message-State: AOAM533d3dc+QRVXRiJt0ItV2su2hPAKY4NdGOliZqGLr4bcJwrb4dKp
        JpTxp1f8SfsbCMSksOOMBks=
X-Google-Smtp-Source: ABdhPJwwF+8ia0xQ32smGqMNWm3lJv4V7czNffAMHLs+siAu92CyuitiArgz+CfLeEAsLSE+LL7sZA==
X-Received: by 2002:a65:6688:: with SMTP id b8mr3133522pgw.158.1613136041576;
        Fri, 12 Feb 2021 05:20:41 -0800 (PST)
Received: from syed.domain.name ([103.201.127.1])
        by smtp.gmail.com with ESMTPSA id w188sm7287592pfw.177.2021.02.12.05.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 05:20:41 -0800 (PST)
Date:   Fri, 12 Feb 2021 18:50:20 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     bgolaszewski@baylibre.com
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-arch@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 1/3] gpiolib: Introduce the for_each_set_clump macro
Message-ID: <f203e2d52e550f7700d49b6c4f8603b193f42c5d.1613134924.git.syednwaris@gmail.com>
References: <cover.1613134924.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1613134924.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This macro iterates for each group of bits (clump) with set bits,
within a bitmap memory region. For each iteration, "start" is set to
the bit offset of the found clump, while the respective clump value is
stored to the location pointed by "clump". Additionally, the
bitmap_get_value() and bitmap_set_value() functions are introduced to
respectively get and set a value of n-bits in a bitmap memory region.
The n-bits can have any size from 1 to BITS_PER_LONG. size less
than 1 or more than BITS_PER_LONG causes undefined behaviour.
Moreover, during setting value of n-bit in bitmap, if a situation arise
that the width of next n-bit is exceeding the word boundary, then it
will divide itself such that some portion of it is stored in that word,
while the remaining portion is stored in the next higher word. Similar
situation occurs while retrieving the value from bitmap.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Gołaszewski <bgolaszewski@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 drivers/gpio/gpiolib.c | 90 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.h | 28 +++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b02cc2abd3b6..282ae599c143 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4342,6 +4342,96 @@ static int gpiolib_seq_show(struct seq_file *s, void *v)
 	return 0;
 }
 
+/**
+ * bitmap_get_value - get a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).
+ *
+ * Returns value of nbits located at the @start bit offset within the @map
+ * memory region.
+ */
+unsigned long bitmap_get_value(const unsigned long *map,
+				unsigned long start,
+				unsigned long nbits)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+	const unsigned long ceiling = round_up(start + 1, BITS_PER_LONG);
+	const unsigned long space = ceiling - start;
+	unsigned long value_low, value_high;
+
+	if (space >= nbits)
+		return (map[index] >> offset) & GENMASK(nbits - 1, 0);
+	else {
+		value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
+		value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
+		return (value_low >> offset) | (value_high << space);
+	}
+}
+EXPORT_SYMBOL_GPL(bitmap_get_value);
+
+/**
+ * bitmap_set_value - set value within a memory region
+ * @map: address to the bitmap memory region
+ * @nbits: size of map in bits
+ * @value: value of clump
+ * @value_width: size of value in bits (must be between 1 and BITS_PER_LONG inclusive)
+ * @start: bit offset of the value
+ */
+void bitmap_set_value(unsigned long *map, unsigned long nbits,
+			unsigned long value, unsigned long value_width,
+			unsigned long start)
+{
+	const unsigned long index = BIT_WORD(start);
+	const unsigned long length = BIT_WORD(nbits);
+	const unsigned long offset = start % BITS_PER_LONG;
+	const unsigned long ceiling = round_up(start + 1, BITS_PER_LONG);
+	const unsigned long space = ceiling - start;
+
+	value &= GENMASK(value_width - 1, 0);
+
+	if (space >= value_width) {
+		map[index] &= ~(GENMASK(value_width - 1, 0) << offset);
+		map[index] |= value << offset;
+	} else {
+		map[index + 0] &= ~BITMAP_FIRST_WORD_MASK(start);
+		map[index + 0] |= value << offset;
+
+		if (index + 1 >= length)
+			return;
+
+		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + value_width);
+		map[index + 1] |= value >> space;
+	}
+}
+EXPORT_SYMBOL_GPL(bitmap_set_value);
+
+/**
+ * find_next_clump - find next clump with set bits in a memory region
+ * @clump: location to store copy of found clump
+ * @addr: address to base the search on
+ * @size: bitmap size in number of bits
+ * @offset: bit offset at which to start searching
+ * @clump_size: clump size in bits
+ *
+ * Returns the bit offset for the next set clump; the found clump value is
+ * copied to the location pointed by @clump. If no bits are set, returns @size.
+ */
+unsigned long find_next_clump(unsigned long *clump, const unsigned long *addr,
+				unsigned long size, unsigned long offset,
+				unsigned long clump_size)
+{
+	offset = find_next_bit(addr, size, offset);
+	if (offset == size)
+		return size;
+
+	offset = rounddown(offset, clump_size);
+	*clump = bitmap_get_value(addr, offset, clump_size);
+	return offset;
+}
+EXPORT_SYMBOL_GPL(find_next_clump);
+
 static const struct seq_operations gpiolib_sops = {
 	.start = gpiolib_seq_start,
 	.next = gpiolib_seq_next,
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 30bc3f80f83e..41c6b24d9842 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -141,6 +141,34 @@ int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 		unsigned long lflags, enum gpiod_flags dflags);
 
+unsigned long bitmap_get_value(const unsigned long *map,
+				unsigned long start,
+				unsigned long nbits);
+
+void bitmap_set_value(unsigned long *map, unsigned long nbits,
+			unsigned long value, unsigned long value_width,
+			unsigned long start);
+
+unsigned long find_next_clump(unsigned long *clump, const unsigned long *addr,
+				unsigned long size, unsigned long offset,
+				unsigned long clump_size);
+
+#define find_first_clump(clump, bits, size, clump_size) \
+	find_next_clump((clump), (bits), (size), 0, (clump_size))
+
+/**
+ * for_each_set_clump - iterate over bitmap for each clump with set bits
+ * @start: bit offset to start search and to store the current iteration offset
+ * @clump: location to store copy of current 8-bit clump
+ * @bits: bitmap address to base the search on
+ * @size: bitmap size in number of bits
+ * @clump_size: clump size in bits
+ */
+#define for_each_set_clump(start, clump, bits, size, clump_size) \
+	for ((start) = find_first_clump(&(clump), (bits), (size), (clump_size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump(&(clump), (bits), (size), (start) + (clump_size), (clump_size)))
+
 /*
  * Return the GPIO number of the passed descriptor relative to its chip
  */
-- 
2.29.0

