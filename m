Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F951C27D4
	for <lists+linux-arch@lfdr.de>; Sat,  2 May 2020 20:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgEBSsG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 May 2020 14:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726306AbgEBSsG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 May 2020 14:48:06 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D73C061A0C;
        Sat,  2 May 2020 11:48:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s8so6352880pgq.1;
        Sat, 02 May 2020 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mfOLDE6UUMU5OcBvJn1mHU5j28JB9edMl3msANDc27Y=;
        b=UHRqdpNu6KyLBD354s9wcv0zArsyXuxJRJzCXGcugmFX1zF5gwF1AkbxVrqOzj0R8r
         tybFyQs8ce466404iA12hBA7QW0zcEI+Mc1DpVfIy9Nf/wwWM0wA9OZOiKQnmRr2x5i3
         HGNK25Ee75IPA2pO3ElBq6XdR6Rf7kwXsMWh77G7QSdzdjAfIwvJy6dpO45rjscFr+DM
         ykslQnIrno6OBSlCGLsSQoVEViJLs/EypMjwX/DcQDG7DxZHw0ZeXnfSw+vEPplXhjgf
         Wh6C/CaRHEXswUqzZPfKy4O2wpBBHc9q08Ov4SAQr0tDoecakFcfVJdykOy2AQvXgQdn
         /mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mfOLDE6UUMU5OcBvJn1mHU5j28JB9edMl3msANDc27Y=;
        b=pSJetlYSKaAmFVUq1H+++92ONTtf6ZL+QIeLij4TRo7OECZBZxgPPh3dDyMe3x12RY
         hd5CKEPq6gwY87ow/SyXfENUvBYK/fwhXs5etmpmWlIYWYsNNXAlfi7Ld5xjT2oC7Tll
         0ayYwpamcXq+k5iRuIETaEDoldGbuyLv3dfSteWJuE6GhCNqtmkVwxzDhOvAaVhtci/v
         qFAgXpliRkhzGnk4yk7ysoS3/W3S+XS9prVIyaTP/rQuzGw1ozu+w5ZQPX8NAIxo/yxg
         EWWaW3vwT0ARHVf5QQqQid2pWi+kkmcqPiMETJpRIRUPFgL3gJuxGce3itj39CJEho3a
         aiQw==
X-Gm-Message-State: AGi0PuaZiOiManUkQRUA5An+MjBDBTPutL26jAL/S++hLFBVqp6nm5zm
        WWqor9NOI0BDvxB4EeKBcpQ=
X-Google-Smtp-Source: APiQypJFlejTyUYrvBFtRM6MzYTDxULVjTS6qEJ7ois0QT2GIgek4ip6V2VcZLhloPF9k4G4s1ZN/Q==
X-Received: by 2002:a63:585a:: with SMTP id i26mr9827217pgm.39.1588445284359;
        Sat, 02 May 2020 11:48:04 -0700 (PDT)
Received: from syed ([106.210.101.167])
        by smtp.gmail.com with ESMTPSA id k4sm4541266pgg.88.2020.05.02.11.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2020 11:48:04 -0700 (PDT)
Date:   Sun, 3 May 2020 00:17:48 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        arnd@arndb.de, linus.walleij@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] bitops: Introduce the the for_each_set_clump macro
Message-ID: <2334ac49d10856db92cb1ca791641fd3200f18af.1588443578.git.syednwaris@gmail.com>
References: <cover.1588443578.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588443578.git.syednwaris@gmail.com>
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
Changes in v4:
 - No change

Changes in v3:
 - No change

Changes in v2:
 - No change

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
index 99058eb81042..7ab2c65fc964 100644
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
@@ -563,6 +567,34 @@ static inline unsigned long bitmap_get_value8(const unsigned long *map,
 	return (map[index] >> offset) & 0xFF;
 }
 
+/**
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
index 9acf654f0b19..41c2d9ce63e7 100644
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

