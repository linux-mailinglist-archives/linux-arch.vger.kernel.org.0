Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2510292033
	for <lists+linux-arch@lfdr.de>; Sun, 18 Oct 2020 23:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgJRVix (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Oct 2020 17:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJRVix (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Oct 2020 17:38:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65112C061755;
        Sun, 18 Oct 2020 14:38:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gm14so4230388pjb.2;
        Sun, 18 Oct 2020 14:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F16s9Kp6Nj0lceIbc1UWwdaamCJNkpZK0Tcg5Nb3uOg=;
        b=fyoTKx4bhN9/dIR7XDdWsVFL3J2p+oeIyDHek1q5Pk4YCdDCue6arI40Qfkuh6t5Uy
         k3NYC5mUXiMPDcgQai5anwhA0ZplpvvxFpYYvxokdDL2vpZJ1j+TQDdm/J7P59OphKJY
         8y47atwhSLSbzVazxAHS4pHA2YP0Yx0GHlfcVydBSFGP/pLgFd3LQND73HggSq0+GCU9
         hFYy6SZh6mCulyHuYT/U5XYHfY0qrR2kacPdwrUBt6WYWn8iwQB9AWzK04qADnu+tKfC
         cDyVrOSQ4EF0M3pBmYQ4Gjp9uZk5RTkW0EckeWxiK5ZAgtGYd+9E8FsVR3s17o9mRQzE
         WswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F16s9Kp6Nj0lceIbc1UWwdaamCJNkpZK0Tcg5Nb3uOg=;
        b=CM8FgmdHPQo428lnFgPuSlrFJ8BlkT1d2346ein9WatmWrKoh3r2EgH7kC49ZD6E/P
         0bYE3DaD04Q3UHkkO1bvE4AiO0cCR0F5Dcitr8SVVBQIAy9iepEH5I8NM4vgkeXdhydH
         tXnTqGN62CtRrV9dvifDiSj0ytFdYltoPxnQaodtnhMVup6D8U143YITQUM6sqKpq+6k
         AkbPiqUG51ANC/F3BjPYylxbsQ7wxxA7e6UR4veXaZmg1IrBaDQOTbSy74XWesfi8tqW
         SFMLLlPdotpTiYohu/l2vj0kqmgh+zh+XKxs+d6fhTI+qHpDFsa0qRIYCJ5cQw9gfbCH
         91LA==
X-Gm-Message-State: AOAM532ki8o4rSfBMi1W2vEDqISDSyKUckUjXdxLWHzI/x/OvOUZZ7vG
        /2juIMDxO1SzUpVwfsLfYg0=
X-Google-Smtp-Source: ABdhPJwHPaZ6UeVqkCbYpvndeEx/NXPImBbuQ8yoIRxh7tPnjUUCNvuvpkWTX0gjOg8ByII2CFBktQ==
X-Received: by 2002:a17:90a:cc0f:: with SMTP id b15mr14546391pju.202.1603057132929;
        Sun, 18 Oct 2020 14:38:52 -0700 (PDT)
Received: from syed ([2401:4900:47f3:e624:90f9:25c2:806b:19c8])
        by smtp.gmail.com with ESMTPSA id j11sm9604503pfh.143.2020.10.18.14.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Oct 2020 14:38:52 -0700 (PDT)
Date:   Mon, 19 Oct 2020 03:08:35 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/4] bitops: Introduce the for_each_set_clump macro
Message-ID: <199b749c404450d1acb667e629ec4da37f44b60c.1603055402.git.syednwaris@gmail.com>
References: <cover.1603055402.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603055402.git.syednwaris@gmail.com>
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

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v12:
 - Format and modify comments.
 - Optimize code using '<<' operator with GENMASK.

Changes in v11:
 - Document valid range of values that 'nbits' can take.

Changes in v10:
 - No change.

Changes in v9:
 - No change.

Changes in v8:
 - No change.

Changes in v7:
 - No change.

Changes in v6:
 - No change.

Changes in v5:
 - No change.

Changes in v4:
 - No change.

Changes in v3:
 - No change.

Changes in v2:
 - No change.

 include/asm-generic/bitops/find.h | 19 ++++++++++
 include/linux/bitmap.h            | 61 +++++++++++++++++++++++++++++++
 include/linux/bitops.h            | 13 +++++++
 lib/find_bit.c                    | 14 +++++++
 4 files changed, 107 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 9fdf21302fdf..4e6600759455 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -97,4 +97,23 @@ extern unsigned long find_next_clump8(unsigned long *clump,
 #define find_first_clump8(clump, bits, size) \
 	find_next_clump8((clump), (bits), (size), 0)
 
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
+extern unsigned long find_next_clump(unsigned long *clump,
+				      const unsigned long *addr,
+				      unsigned long size, unsigned long offset,
+				      unsigned long clump_size);
+
+#define find_first_clump(clump, bits, size, clump_size) \
+	find_next_clump((clump), (bits), (size), 0, (clump_size))
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99058eb81042..2ee934484532 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -75,7 +75,11 @@
  *  bitmap_from_arr32(dst, buf, nbits)          Copy nbits from u32[] buf to dst
  *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
+ *  bitmap_get_value(map, start, nbits)		Get bit value of size
+ *                                              'nbits' from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_set_value(map, value, start, nbits)	Set bit value of size 'nbits'
+ *                                              of map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -563,6 +567,34 @@ static inline unsigned long bitmap_get_value8(const unsigned long *map,
 	return (map[index] >> offset) & 0xFF;
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
+static inline unsigned long bitmap_get_value(const unsigned long *map,
+					      unsigned long start,
+					      unsigned long nbits)
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
+
 /**
  * bitmap_set_value8 - set an 8-bit value within a memory region
  * @map: address to the bitmap memory region
@@ -579,6 +611,35 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_set_value - set n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value of nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).
+ */
+static inline void bitmap_set_value(unsigned long *map,
+				    unsigned long value,
+				    unsigned long start, unsigned long nbits)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+	const unsigned long ceiling = round_up(start + 1, BITS_PER_LONG);
+	const unsigned long space = ceiling - start;
+
+	value &= GENMASK(nbits - 1, 0);
+
+	if (space >= nbits) {
+		map[index] &= ~(GENMASK(nbits - 1, 0) << offset);
+		map[index] |= value << offset;
+	} else {
+		map[index + 0] &= ~BITMAP_FIRST_WORD_MASK(start);
+		map[index + 0] |= value << offset;
+		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
+		map[index + 1] |= value >> space;
+	}
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 99f2ac30b1d9..36a445e4a7cc 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -62,6 +62,19 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (start) < (size); \
 	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
 
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
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 49f875f1baf7..1341bd39b32a 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -190,3 +190,17 @@ unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
 	return offset;
 }
 EXPORT_SYMBOL(find_next_clump8);
+
+unsigned long find_next_clump(unsigned long *clump, const unsigned long *addr,
+			       unsigned long size, unsigned long offset,
+			       unsigned long clump_size)
+{
+	offset = find_next_bit(addr, size, offset);
+	if (offset == size)
+		return size;
+
+	offset = rounddown(offset, clump_size);
+	*clump = bitmap_get_value(addr, offset, clump_size);
+	return offset;
+}
+EXPORT_SYMBOL(find_next_clump);
-- 
2.26.2

