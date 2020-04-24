Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D877C1B74BF
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 14:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgDXM2d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 08:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgDXM2b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2020 08:28:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A57C09B045;
        Fri, 24 Apr 2020 05:28:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id ay1so3688655plb.0;
        Fri, 24 Apr 2020 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WgO0bw9umf7lMbd/P+idSXbrk9oU6oTYQoMdzW6GzaU=;
        b=dwZNh+fkufKtB1Ti88Q5X3bHh7Cjp9zk/k1kqZtXilbfCjjMVQTAwbUH6/JCM6VbCF
         T7A1yFsi9HMAeFV/MYZ5Y6Owhg/Y/SBjzOfAXRQPaRh2Zr06NtPAH3prYc15eQZlrrH8
         DgVwks93JiAjnTRcplALAFf0yQSqMeCAik/XkthTEeozHX6Nd08jODCTvv6VKGZp/VvQ
         H6ycKMZeVbG78bTkQjeAAau1T+OvDzTKEbxRyI3PafUo9PlhBKfMt3dO/BYr+HHHIlUw
         X9+rCcFmPW7gGZeuzVubDJdhztQCiJBOnWDZoUsJFFtKFm6xVBPTAXS60zGWCMFgUWxz
         pnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WgO0bw9umf7lMbd/P+idSXbrk9oU6oTYQoMdzW6GzaU=;
        b=QKFW2BDLuRRxPfeO5zshgJTKqwwM8BuJq+RebOHT4rn789dk5a9K0OLZiBuYVftCJc
         bLWZrEzdu6ELWnYbxtQ72jfBlkorBhCl5yY/fK/2VLyfGpmJxbIfurtB6Xwt759icbat
         yWBJhX/awJIwOX5yuhclNBRupu23leGxpHD6vp8qvmzvnR4iF0iU4QOe0BQhD24ExRW6
         x7AnAbUcKBQJEqj10EDmrwUS0TZT5rGTfik7qZpBLYVuMMdenwnWKfCvPA6MgMrXZ95+
         LyI0qCijFsksCHhtu5cJUFmtDHL6rMV66rqEJqV21y1EgsEGL/CyLlOjY2MGyQx7N2ng
         eQnw==
X-Gm-Message-State: AGi0PuaVcaj7atVS8g5TUihp1XbeQPLRnyS2C3+ZMXrcz7rX+0uTvLWN
        v6wfNuIG1MDhpmkeE+0AGbw=
X-Google-Smtp-Source: APiQypLNHyN25KzXNGo6RFLm4t+PHoptNymIpxFMlxOdRrbJN4i/SkhSEC8WxQ+qrZ7VS4LTexxCGA==
X-Received: by 2002:a17:902:b609:: with SMTP id b9mr9001764pls.156.1587731309756;
        Fri, 24 Apr 2020 05:28:29 -0700 (PDT)
Received: from syed ([106.223.101.26])
        by smtp.gmail.com with ESMTPSA id s145sm4891543pgs.57.2020.04.24.05.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 05:28:29 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:58:23 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        arnd@arndb.de, linus.walleij@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] bitops: Remove code related to for_each_set_clump8
Message-ID: <20200424122823.GA5619@syed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove code related to the old for_each_set_clump8 macro because
it has now been replaced by the new generic for_each_set_clump macro.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h | 17 ----------
 include/linux/bitmap.h            | 35 ---------------------
 include/linux/bitops.h            | 12 --------
 lib/find_bit.c                    | 14 ---------
 lib/test_bitmap.c                 | 65 ---------------------------------------
 5 files changed, 143 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 4e66007..d412268 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -81,23 +81,6 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
 /**
- * find_next_clump8 - find next 8-bit clump with set bits in a memory region
- * @clump: location to store copy of found clump
- * @addr: address to base the search on
- * @size: bitmap size in number of bits
- * @offset: bit offset at which to start searching
- *
- * Returns the bit offset for the next set clump; the found clump value is
- * copied to the location pointed by @clump. If no bits are set, returns @size.
- */
-extern unsigned long find_next_clump8(unsigned long *clump,
-				      const unsigned long *addr,
-				      unsigned long size, unsigned long offset);
-
-#define find_first_clump8(clump, bits, size) \
-	find_next_clump8((clump), (bits), (size), 0)
-
-/**
  * find_next_clump - find next clump with set bits in a memory region
  * @clump: location to store copy of found clump
  * @addr: address to base the search on
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7ab2c65..d6595bc1 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -74,10 +74,8 @@
  *  bitmap_allocate_region(bitmap, pos, order)  Allocate specified bit region
  *  bitmap_from_arr32(dst, buf, nbits)          Copy nbits from u32[] buf to dst
  *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
- *  bitmap_get_value8(map, start)               Get 8bit value from map at start
  *  bitmap_get_value(map, start, nbits)		Get bit value of size
  *						'nbits' from map at start
- *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
  *  bitmap_set_value(map, value, start, nbits)	Set bit value of size 'nbits'
  *						of map at start
  *
@@ -551,23 +549,6 @@ static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
 }
 
 /**
- * bitmap_get_value8 - get an 8-bit value within a memory region
- * @map: address to the bitmap memory region
- * @start: bit offset of the 8-bit value; must be a multiple of 8
- *
- * Returns the 8-bit value located at the @start bit offset within the @src
- * memory region.
- */
-static inline unsigned long bitmap_get_value8(const unsigned long *map,
-					      unsigned long start)
-{
-	const size_t index = BIT_WORD(start);
-	const unsigned long offset = start % BITS_PER_LONG;
-
-	return (map[index] >> offset) & 0xFF;
-}
-
-/**
  * bitmap_get_value - get a value of n-bits from the memory region
  * @map: address to the bitmap memory region
  * @start: bit offset of the n-bit value
@@ -596,22 +577,6 @@ static inline unsigned long bitmap_get_value(const unsigned long *map,
 }
 
 /**
- * bitmap_set_value8 - set an 8-bit value within a memory region
- * @map: address to the bitmap memory region
- * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
- * @start: bit offset of the 8-bit value; must be a multiple of 8
- */
-static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
-				     unsigned long start)
-{
-	const size_t index = BIT_WORD(start);
-	const unsigned long offset = start % BITS_PER_LONG;
-
-	map[index] &= ~(0xFFUL << offset);
-	map[index] |= value << offset;
-}
-
-/**
  * bitmap_set_value - set n-bit value within a memory region
  * @map: address to the bitmap memory region
  * @value: value of nbits
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 41c2d9c..cc0a413 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -51,18 +51,6 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
 /**
- * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
- * @start: bit offset to start search and to store the current iteration offset
- * @clump: location to store copy of current 8-bit clump
- * @bits: bitmap address to base the search on
- * @size: bitmap size in number of bits
- */
-#define for_each_set_clump8(start, clump, bits, size) \
-	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
-	     (start) < (size); \
-	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
-
-/**
  * for_each_set_clump - iterate over bitmap for each clump with set bits
  * @start: bit offset to start search and to store the current iteration offset
  * @clump: location to store copy of current 8-bit clump
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 1341bd3..6332ec1 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -177,20 +177,6 @@ EXPORT_SYMBOL(find_next_bit_le);
 
 #endif /* __BIG_ENDIAN */
 
-unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
-			       unsigned long size, unsigned long offset)
-{
-	offset = find_next_bit(addr, size, offset);
-	if (offset == size)
-		return size;
-
-	offset = round_down(offset, 8);
-	*clump = bitmap_get_value8(addr, offset);
-
-	return offset;
-}
-EXPORT_SYMBOL(find_next_clump8);
-
 unsigned long find_next_clump(unsigned long *clump, const unsigned long *addr,
 			       unsigned long size, unsigned long offset,
 			       unsigned long clump_size)
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 5c1f98f..d75d77f 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -125,36 +125,6 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 	return true;
 }
 
-static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
-				    const unsigned int offset,
-				    const unsigned int size,
-				    const unsigned char *const clump_exp,
-				    const unsigned long *const clump)
-{
-	unsigned long exp;
-
-	if (offset >= size) {
-		pr_warn("[%s:%u] bit offset for clump out-of-bounds: expected less than %u, got %u\n",
-			srcfile, line, size, offset);
-		return false;
-	}
-
-	exp = clump_exp[offset / 8];
-	if (!exp) {
-		pr_warn("[%s:%u] bit offset for zero clump: expected nonzero clump, got bit offset %u with clump value 0",
-			srcfile, line, offset);
-		return false;
-	}
-
-	if (*clump != exp) {
-		pr_warn("[%s:%u] expected clump value of 0x%lX, got clump value of 0x%lX",
-			srcfile, line, exp, *clump);
-		return false;
-	}
-
-	return true;
-}
-
 static bool __init __check_eq_clump(const char *srcfile, unsigned int line,
 				    const unsigned int offset,
 				    const unsigned int size,
@@ -203,7 +173,6 @@ static bool __init __check_eq_clump(const char *srcfile, unsigned int line,
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
-#define expect_eq_clump8(...)		__expect_eq(clump8, ##__VA_ARGS__)
 #define expect_eq_clump(...)		__expect_eq(clump, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
@@ -610,17 +579,6 @@ static void noinline __init test_mem_optimisations(void)
 	}
 }
 
-static const unsigned char clump_exp[] __initconst = {
-	0x01,	/* 1 bit set */
-	0x02,	/* non-edge 1 bit set */
-	0x00,	/* zero bits set */
-	0x38,	/* 3 bits set across 4-bit boundary */
-	0x38,	/* Repeated clump */
-	0x0F,	/* 4 bits set */
-	0xFF,	/* all bits set */
-	0x05,	/* non-adjacent 2 bits set */
-};
-
 static const unsigned long clump_exp1[] __initconst = {
 	0x01,	/* 1 bit set */
 	0x02,	/* non-edge 1 bit set */
@@ -661,28 +619,6 @@ static const unsigned long clump_exp4[] __initconst = {
 	0x2b,
 };
 
-static void __init test_for_each_set_clump8(void)
-{
-#define CLUMP_EXP_NUMBITS 64
-	DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS);
-	unsigned int start;
-	unsigned long clump;
-
-	/* set bitmap to test case */
-	bitmap_zero(bits, CLUMP_EXP_NUMBITS);
-	bitmap_set(bits, 0, 1);		/* 0x01 */
-	bitmap_set(bits, 9, 1);		/* 0x02 */
-	bitmap_set(bits, 27, 3);	/* 0x28 */
-	bitmap_set(bits, 35, 3);	/* 0x28 */
-	bitmap_set(bits, 40, 4);	/* 0x0F */
-	bitmap_set(bits, 48, 8);	/* 0xFF */
-	bitmap_set(bits, 56, 1);	/* 0x05 - part 1 */
-	bitmap_set(bits, 58, 1);	/* 0x05 - part 2 */
-
-	for_each_set_clump8(start, clump, bits, CLUMP_EXP_NUMBITS)
-		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
-}
-
 static void __init test_for_each_set_clump_8(void)  /* 8 bit clumps test using
 						  new for_each_set_clump */
 {
@@ -777,7 +713,6 @@ static void __init selftest(void)
 	test_bitmap_parselist();
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
-	test_for_each_set_clump8();
 	test_for_each_set_clump_8();
 	test_for_each_set_clump_24();
 	test_for_each_set_clump_30();
-- 
2.7.4

