Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE7D1548
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfJIRPP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:15:15 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41340 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJIRPP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:15:15 -0400
Received: by mail-yb1-f193.google.com with SMTP id 206so979811ybc.8;
        Wed, 09 Oct 2019 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFx5e6sekWj4cSXabcHlK2m6teGcz5rYDUsYdjC+rrw=;
        b=vU5nENGi+96qwP1zXySRiWdFjmgbqu2wz/Nv/G+uJKJJ3evWwp5yKBdbAOYOxR1UD6
         02e0fvSrnPTf7cs9XAocBH5tfFvYAD8DjRLbupbDBxhqDO1OnyL0+YkJOZJ78rYIuDkv
         4lHksmb169tCjBIbSMDL/SXap1/9ySx+oH7+ANVrRMaxo6Z8e8hlkvhRqH9aJvh0tyXE
         O8OC4U47zNrp1IPyOfx9kyFntLDoj3vwq3s2lkMmrk0n6z46+gIjoW4Xjo/uPQWtzRz3
         Tkr5VXvUolO44bthr8sCq3XyND0NpqFKhBnozXvK/qa7maJKhSBEnwQ5UtCvBGg6SWgz
         ZYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFx5e6sekWj4cSXabcHlK2m6teGcz5rYDUsYdjC+rrw=;
        b=Sx7xgE8EFtXsp2M7Rlpy7G8JpN8sX7Z6Rw4B3fvSLCjjWZ2WFVJAs493RNmbMyaxbS
         hf+wctYISSgjLnmgnJqiNMHlfyvTTefqzXwSPrklvo/83NIcXq5JDGp0Sh5rPloXJ594
         WrBJWOnFtT/fETTV5XVSVWutAz7QMMdR9PR4Bywxr9XO7GXdm96sH1zMxfhM57CVI4FW
         GNYEYT2/EJ1ZOcmQNB+wqvppdJcfP3i6Pr91hrrBbi1GBVnvPuO0v9nTXIuvJBqHhlK+
         zF3dUmPEGrtE5zTdT2cXi9XFhadobp9/vdeDogSI7mRZ4LARZKRMuPKECwT+Fcl58b4P
         flpA==
X-Gm-Message-State: APjAAAXOQrIn2eqickt56oYXwmkcIHT0Jpu89FyZ5+Hy9GnbtSC8u0ek
        3shajPKLFVZIV+WqANftOE8=
X-Google-Smtp-Source: APXvYqyo/6BM6QV7w2AEso0LDLVV9QJhxnkgkXCJdqwwCDn8k8vz3H54P9dTdCDOoxtGL1DTt4y1QA==
X-Received: by 2002:a25:49c7:: with SMTP id w190mr2853099yba.140.1570641313477;
        Wed, 09 Oct 2019 10:15:13 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id r63sm743292ywg.36.2019.10.09.10.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:15:11 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v18 01/14] bitops: Introduce the for_each_set_clump8 macro
Date:   Wed,  9 Oct 2019 13:14:37 -0400
Message-Id: <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570641097.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570641097.git.vilhelm.gray@gmail.com>
References: <cover.1570641097.git.vilhelm.gray@gmail.com>
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

