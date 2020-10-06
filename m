Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9800D284944
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJFJWd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFJWd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:22:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B55C061755;
        Tue,  6 Oct 2020 02:22:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id x5so628977pjv.3;
        Tue, 06 Oct 2020 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xHg5kxLdebKxx3zrIHdMCIAECN4MIkM/dVSZcjHjpVM=;
        b=boyIWT7SYUpOuLTFMeLggc+vYH5niTngyoTYRavuG50O2QPgsiKr6PkDuwooWnB94t
         jEcZuD6wqXzp7BUSEwnuPWmtcVc9bu/zI0xgwS+Js79h3CB0BF7wkmx/gyiT2r6lFuV9
         z1xOQ43qWct5KfMF6tvzTHKZyO0Y/zu+33EEgxZX8SI4e/Lr2+Wxeg3+olkZPKrugUB6
         FZoYZCUfeY5dOSZ/d29W9I1Dgj6C8Y8OZoSTD/zjxDAnfzq9aKrgYMC7wb6G/wlExYSN
         lxlxvJKn//LwP4Xas+sOdXf3UC7Lc92xvAg2JoP0UAyCwTo7IhDuLnv4GwwcB0OQlIwO
         VkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xHg5kxLdebKxx3zrIHdMCIAECN4MIkM/dVSZcjHjpVM=;
        b=DpOilbH1gU285hb3HAvwnJRWv7Ufo98ywqolpBSvhSXSnw0786hjKSPxNYo09GYwEG
         LDQ8/5yhk/QP6xsn2iiEkrAO21YuZf83pBBHA4eNt79xr4R8H1HlkRE1Hl3xd6B6XuKe
         axXXX///hwlSJxxpRBAA5G8nO87JtZ48S6omEltpkiZK4D2RRrCtK1aZhvcw5HST9rWW
         Zmo/9RJOodWHlUO8AvStNdw/0mgRoULyCBsGeFAUT9gvyIvERZtVoYOUU2p1Lo0ubKqH
         rASh603fLcrfFEsXJ86F3Zjch+KdzXWc7omD5zCX0CRdMK46zYWTXZ+FjWKvLGCvUB+6
         tmeQ==
X-Gm-Message-State: AOAM533CB5+zT1cPqErUEEFEZNpXuxG+xxxD5ALoJlayeqGH98YYLss8
        UBaDQHT0qHpn+r2s/qS6WWw=
X-Google-Smtp-Source: ABdhPJxOeiNJU3WTsgQh9z3RRvv7M6B1oLmbjYaYY2SuIYs8rKSOdFlct+TYfgkQyhCEStw6WgzNpA==
X-Received: by 2002:a17:90b:4006:: with SMTP id ie6mr3430758pjb.102.1601976152548;
        Tue, 06 Oct 2020 02:22:32 -0700 (PDT)
Received: from syed ([117.97.226.113])
        by smtp.gmail.com with ESMTPSA id 31sm2287292pgs.59.2020.10.06.02.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 02:22:32 -0700 (PDT)
Date:   Tue, 6 Oct 2020 14:52:16 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/4] bitops: Introduce the for_each_set_clump macro
Message-ID: <33de236870f7d3cf56a55d747e4574cdd2b9686a.1601974764.git.syednwaris@gmail.com>
References: <cover.1601974764.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1601974764.git.syednwaris@gmail.com>
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
The n-bits can have any size less than or equal to BITS_PER_LONG.
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
 include/linux/bitmap.h            | 63 +++++++++++++++++++++++++++++++
 include/linux/bitops.h            | 13 +++++++
 lib/find_bit.c                    | 14 +++++++
 4 files changed, 109 insertions(+)

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
index 99058eb81042..6e0cc6877b68 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -75,7 +75,11 @@
  *  bitmap_from_arr32(dst, buf, nbits)          Copy nbits from u32[] buf to dst
  *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
+ *  bitmap_get_value(map, start, nbits)		Get bit value of size
+ *						'nbits' from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_set_value(map, value, start, nbits)	Set bit value of size 'nbits'
+ *						of map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -563,6 +567,35 @@ static inline unsigned long bitmap_get_value8(const unsigned long *map,
 	return (map[index] >> offset) & 0xFF;
 }
 
+/**
+ * bitmap_get_value - get a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).
+ *	nbits less than 1 or more than BITS_PER_LONG causes undefined behaviour.
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
+	const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
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
@@ -579,6 +612,36 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_set_value - set n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value of nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).
+ *	nbits less than 1 or more than BITS_PER_LONG causes undefined behaviour.
+ */
+static inline void bitmap_set_value(unsigned long *map,
+				    unsigned long value,
+				    unsigned long start, unsigned long nbits)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+	const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
+	const unsigned long space = ceiling - start;
+
+	value &= GENMASK(nbits - 1, 0);
+
+	if (space >= nbits) {
+		map[index] &= ~(GENMASK(nbits + offset - 1, offset));
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

