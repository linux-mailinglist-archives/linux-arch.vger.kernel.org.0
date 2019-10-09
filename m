Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BACCAD12B7
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfJIP1g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 11:27:36 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41553 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIP1e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 11:27:34 -0400
Received: by mail-yw1-f65.google.com with SMTP id 129so955895ywb.8;
        Wed, 09 Oct 2019 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFx5e6sekWj4cSXabcHlK2m6teGcz5rYDUsYdjC+rrw=;
        b=bTW6/4MVkGnys+h/1M9PGSH3rq2UOTzR9XpLFnA+nppipffdZktdKJF4bovmw7p1rJ
         zd6SSZKjL1MbUVeRkGOUx4WykBUUfIaDK8E06cLtt4fTpsI8uGDgmXlO1utF7iTXatLi
         Sq8oQC6fb/mo26oyi0+S6vlsPiuWRj70L6jCxjMrI0RjNez4O7z7Q/kqVZoqNUg7a03m
         dcPDXI+fTxHcxbsWDOhv6IGdo2r7xtkdpPG0l7FbcMOrdGdU3bbtdCKyHjXh3a1qkg77
         wi8vmRM15GZAUIg/BmrgUm4/3J5hSfthYm/saBWqjQGTsryy7LMtEv5NPNxCU0lgZMzU
         +V3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFx5e6sekWj4cSXabcHlK2m6teGcz5rYDUsYdjC+rrw=;
        b=ii1oR7Nlix0X1FvIqX/u4GTQz/I1ANh3l8KfpPbXRB4tHF1KU2CwmXNDfhzKEQ/MMO
         BqUQ0D16adOx28ZDi9XxxivokSy9NQgsiADxnfqScFBnA3MrXnnvop++ksSyrzWSY0HF
         c0hxcPHaXs2sz3Mfl1/MKA9h0mNN/Q51bQ4e+0jEzn6+QDCPySqtEJhNFsC89pYHbCH5
         22RiUp3jmjpFfnYDV1kuakowazmB5UBFYNCSoDFPWArp3BfG5qupwzNLTcvVkCopRFcF
         3t7pph5Q0OumBTZIZGBktyvtUt79hGUcUM8nXR5Kdu5EJ8jrfV+qyFnbMWzrKl82aHUA
         h7TA==
X-Gm-Message-State: APjAAAWEMjjIxJY1RcnXukUMpjSItcfUwsHesZ9Qrae5nnMhtxOnL+KT
        yDr2MfQtroQMEo1jd+cEju8=
X-Google-Smtp-Source: APXvYqz+w0i8qp/jDRjY8dr3+pmELBjImXfFAjRX8cRctYt3a8txTqVcd9y4tQiO26/UJW2sh64yyA==
X-Received: by 2002:a0d:ffc4:: with SMTP id p187mr3071146ywf.453.1570634852896;
        Wed, 09 Oct 2019 08:27:32 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g40sm611863ywk.14.2019.10.09.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:32 -0700 (PDT)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v17 01/14] bitops: Introduce the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 11:26:59 -0400
Message-Id: <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570633189.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570633189.git.vilhelm.gray@gmail.com>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This macro iterates for each 8-bit group of bits (clump) with set bits,
within a bitmap memory region. For each iteration, "start" is set to the
bit offset of the found clump, while the respective clump value is
stored to the location pointed by "clump". Additionally, the
bitmap_get_value8 and bitmap_set_value8 functions are introduced to
respectively get and set an 8-bit value in a bitmap memory region.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Suggested-by: Lukas Wunner <lukas@wunner.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h | 17 +++++++++++++++
 include/linux/bitmap.h            | 35 +++++++++++++++++++++++++++++++
 include/linux/bitops.h            |  5 +++++
 lib/find_bit.c                    | 14 +++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..9fdf21302fdf 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -80,4 +80,21 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+/**
+ * find_next_clump8 - find next 8-bit clump with set bits in a memory region
+ * @clump: location to store copy of found clump
+ * @addr: address to base the search on
+ * @size: bitmap size in number of bits
+ * @offset: bit offset at which to start searching
+ *
+ * Returns the bit offset for the next set clump; the found clump value is
+ * copied to the location pointed by @clump. If no bits are set, returns @size.
+ */
+extern unsigned long find_next_clump8(unsigned long *clump,
+				      const unsigned long *addr,
+				      unsigned long size, unsigned long offset);
+
+#define find_first_clump8(clump, bits, size) \
+	find_next_clump8((clump), (bits), (size), 0)
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 90528f12bdfa..761fab5b60a7 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -66,6 +66,8 @@
  *  bitmap_allocate_region(bitmap, pos, order)  Allocate specified bit region
  *  bitmap_from_arr32(dst, buf, nbits)          Copy nbits from u32[] buf to dst
  *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
+ *  bitmap_get_value8(map, start)               Get 8bit value from map at start
+ *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -488,6 +490,39 @@ static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
 		dst[1] = mask >> 32;
 }
 
+/**
+ * bitmap_get_value8 - get an 8-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the 8-bit value; must be a multiple of 8
+ *
+ * Returns the 8-bit value located at the @start bit offset within the @src
+ * memory region.
+ */
+static inline unsigned long bitmap_get_value8(const unsigned long *map,
+					      unsigned long start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+
+	return (map[index] >> offset) & 0xFF;
+}
+
+/**
+ * bitmap_set_value8 - set an 8-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
+ * @start: bit offset of the 8-bit value; must be a multiple of 8
+ */
+static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
+				     unsigned long start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+
+	map[index] &= ~(0xFF << offset);
+	map[index] |= value << offset;
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index cf074bce3eb3..fb94a10f7853 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -40,6 +40,11 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_clump8(start, clump, bits, size) \
+	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 5c51eb45178a..e35a76b291e6 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -214,3 +214,17 @@ EXPORT_SYMBOL(find_next_bit_le);
 #endif
 
 #endif /* __BIG_ENDIAN */
+
+unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
+			       unsigned long size, unsigned long offset)
+{
+	offset = find_next_bit(addr, size, offset);
+	if (offset == size)
+		return size;
+
+	offset = round_down(offset, 8);
+	*clump = bitmap_get_value8(addr, offset);
+
+	return offset;
+}
+EXPORT_SYMBOL(find_next_clump8);
-- 
2.23.0

