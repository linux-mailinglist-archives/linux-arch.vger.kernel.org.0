Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3E1B7450
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 14:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgDXMZi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 08:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgDXMZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2020 08:25:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159EBC09B045;
        Fri, 24 Apr 2020 05:25:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so3037130pfn.3;
        Fri, 24 Apr 2020 05:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/m2SoHnzvCIGgCc9wcuMA+OMFZf3uSDqUDHh/PCPkuU=;
        b=MchSrepESAJ2s6KG6n3hJEaBdl9albxqjK3/u/OJT9zRfZxVshZWPoN9HvvaZATDQl
         hRb2YjNDNWN2qnlDGMzb+s2dNLTXWqeDAv5Kjr6/aLVOkaveyEEVHiY/RrT9PzpCgr9e
         NjOCCiUkkJWWkFQAIArXEzZDPfKCVuTFQ1rmQZ226TPtKaQ9pvEczhxI+S9UnJ471UQl
         IrjLenUCq+rBcqAjMYo9CL2ZU7nQ7T++6mXN4wlHO0W2WuuDeN9R9rFub8n8CcL3WaW6
         E4V5sOANg3b8/ecL3TfzsTPdE3jqmg0fEYRUZmAIDoCl9mw+f8Vrys3Q4RoH2TDrmGUf
         GGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/m2SoHnzvCIGgCc9wcuMA+OMFZf3uSDqUDHh/PCPkuU=;
        b=Ls/pWdK+VCl5n//5rv9WJXUelM0IaOBhAgTZpRtL7B+704ja6NRXvIXHS8ho03a5Ag
         2y8cKn51j1WPmZKxsqtF6rU37v+xZ42/RjHIQSxtLTnqofv5hxaUTNW8naXJiolmDrq4
         n8/qUfE1OpVAbZJyBf2+O+nkX9MN0UHaof3FqZsjQlZsGJ3jEYLbzLDy2Im2oHSc7hjS
         iC37/N42y27C6iv9WiVej4N1Y5PF3dEzZYgHLJE+2XjOYMovVN2dHDPZFbs3LJh6fWQL
         UwqMzSqhldGGoiZ+jnPrin+BOEHpIvV10fxvMe3GwuLFR5R5c0nzMtlDVVLxORiBDaTP
         0oew==
X-Gm-Message-State: AGi0PuZH6TTero43psDhv+yRX0CkR5zJinygWmi0qgNKTL3JHLw7O6+n
        0lc0GMuy6fKFCaE/7O97hdk=
X-Google-Smtp-Source: APiQypJmBWXSu/Q6GmOoeNYeEckdhDhjYNhU8k9Fwj6XJWETxZ2k1NMys3A9kxkYjjmo6Wex8FULBA==
X-Received: by 2002:a63:ea18:: with SMTP id c24mr9251652pgi.62.1587731133545;
        Fri, 24 Apr 2020 05:25:33 -0700 (PDT)
Received: from syed ([106.223.101.26])
        by smtp.gmail.com with ESMTPSA id v1sm5576769pfn.212.2020.04.24.05.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 05:25:33 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:55:21 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        arnd@arndb.de, linus.walleij@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Message-ID: <20200424122521.GA5552@syed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This macro iterates for each group of bits (clump) with set bits,
within a bitmap memory region. For each iteration, "start" is set to
the bit offset of the found clump, while the respective clump value is
stored to the location pointed by "clump". Additionally, the
bitmap_get_value and bitmap_set_value functions are introduced to
respectively get and set a value of n-bits in a bitmap memory region.
The n-bits can have any size less than or equal to BITS_PER_LONG.
Moreover, during setting value of n-bit in bitmap, if a situation arise
that the width of next n-bit is exceeding the word boundary, then it
will divide itself such that some portion of it is stored in that word,
while the remaining portion is stored in the next higher word. Similar
situation occurs while retrieving value of n-bits from bitmap.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h | 19 ++++++++++++
 include/linux/bitmap.h            | 61 +++++++++++++++++++++++++++++++++++++++
 include/linux/bitops.h            | 13 +++++++++
 lib/find_bit.c                    | 14 +++++++++
 4 files changed, 107 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 9fdf213..4e66007 100644
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
index 99058eb..7ab2c65 100644
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
@@ -564,6 +568,34 @@ static inline unsigned long bitmap_get_value8(const unsigned long *map,
 }
 
 /**
+ * bitmap_get_value - get a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits
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
+/**
  * bitmap_set_value8 - set an 8-bit value within a memory region
  * @map: address to the bitmap memory region
  * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
@@ -579,6 +611,35 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_set_value - set n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value of nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits
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
+		map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
+		map[index] |= value << offset;
+		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
+		map[index + 1] |= (value >> space);
+	}
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 9acf654..41c2d9c 100644
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
index 49f875f..1341bd3 100644
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
2.7.4

