Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AD5352DCE
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhDBQgm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 12:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhDBQge (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 12:36:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E2AC0613E6;
        Fri,  2 Apr 2021 09:36:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nh5so711136pjb.5;
        Fri, 02 Apr 2021 09:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uINt+NN92c/qqfcZODFiV431lREP2XSc10cIb3wY4cc=;
        b=WVKXH08lo+mqN07StvGegOHxdQZcUNV35cDwhDJQtll/QCwKno68Z5a4fmHQh4fb70
         xURek2O+oiRCGeR0GqS1Eu69+P8owxykMTeKYDtYwrtCcjHhsfGwMP7/F9rvJQNnxEUf
         xW8vsbWaSDcAbc6olGPv4WGAbHDuXI68qP4ZeFnAdzrz00FcCIxPFJMtHF0s6DO9OiqM
         MN4hbGdfIo8mJYs60Cvp2v4zB3qxjCrfaYc3Tew9M84QSe6hGjNvaAP2/dcFrLU1G7Ty
         B0ObJDx0KXRVEw71Rv0FI2tYHsJGoXsA5vsdQmI9Uo7Mtjt9hMFSb0jbLtbuTXKISvUz
         kPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uINt+NN92c/qqfcZODFiV431lREP2XSc10cIb3wY4cc=;
        b=uKTB2ElBRR2abNuSCeEQ8ijD9cJalVOBURLE8eng4bFi1oXFw4HOU9oJqpMuIsLjkQ
         jqwUDYyoj/zpw7YNepXIbzXilF5xJA+RGbFyW5b8DH95H1T2L+RUoiNaXovGfbZ0Ojiy
         dQseOjFvJruuDGt7p6NWdsXC1kyOpKEw+Ku2GIeC3H1awEpnvodzyOoRKg7aHsijG/sB
         Kx6PO1SJpHHEbNfbKaoUt/23TMDwMgZMaAteV+AXMhBPP4hMjQWtL+Sfi0p48yiM3zRb
         FlIgSl4fCBrEpMg/zWzW5GfNaxOjY1Dkv1b0aIlyrF9wrt1QLII70/fca35QWveNaoXf
         vHTQ==
X-Gm-Message-State: AOAM532jpVkMBU0N5dmPpe6+4dYFtrtmf4uzJgkWEi6ccqHzTKa0vRm0
        qvjGWzbbe1rwC5TqSmi1440=
X-Google-Smtp-Source: ABdhPJzh8UlXUoWIyn2bKWSqPS0Vwhytdxdj2cY+JYBqKtpf+XkvAEs2/n1PGBMIQ1touT07P10OEQ==
X-Received: by 2002:a17:902:7585:b029:e6:cc10:61fe with SMTP id j5-20020a1709027585b02900e6cc1061femr13379285pll.23.1617381391211;
        Fri, 02 Apr 2021 09:36:31 -0700 (PDT)
Received: from syed ([223.225.109.149])
        by smtp.gmail.com with ESMTPSA id x22sm8356885pfa.24.2021.04.02.09.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 09:36:30 -0700 (PDT)
Date:   Fri, 2 Apr 2021 22:06:14 +0530
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
Subject: [RESEND PATCH v4 1/3] gpiolib: Introduce the for_each_set_nbits macro
Message-ID: <12102d94258fc6bd5c01800b7cea680fc51d8b93.1617380819.git.syednwaris@gmail.com>
References: <cover.1617380819.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1617380819.git.syednwaris@gmail.com>
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
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpiolib.c | 90 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.h | 28 +++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1427c1be749b..5576d1465c81 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -150,6 +150,96 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc,
 }
 EXPORT_SYMBOL_GPL(gpiochip_get_desc);
 
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
 /**
  * desc_to_gpio - convert a GPIO descriptor to the integer namespace
  * @desc: GPIO descriptor
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 30bc3f80f83e..af79784dfce3 100644
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
+ * for_each_set_nbits - iterate over bitmap for each clump with set bits
+ * @start: bit offset to start search and to store the current iteration offset
+ * @clump: location to store copy of current 8-bit clump
+ * @bits: bitmap address to base the search on
+ * @size: bitmap size in number of bits
+ * @clump_size: clump size in bits
+ */
+#define for_each_set_nbits(start, clump, bits, size, clump_size) \
+	for ((start) = find_first_clump(&(clump), (bits), (size), (clump_size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump(&(clump), (bits), (size), (start) + (clump_size), (clump_size)))
+
 /*
  * Return the GPIO number of the passed descriptor relative to its chip
  */
-- 
2.29.0

