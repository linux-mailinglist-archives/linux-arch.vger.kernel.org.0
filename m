Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C9733CB11
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 02:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhCPBzI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Mar 2021 21:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhCPByf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:54:35 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBC5C061756;
        Mon, 15 Mar 2021 18:54:35 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id l4so33807179qkl.0;
        Mon, 15 Mar 2021 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikJ0eLK/6OkjCoMd1X7LK5WjQKKwDBA3WSJVKIrvN0Q=;
        b=thm8VDRl187VWW9BAPwOC8kCv3tz/sPc3K6jxuxHrQi2WSVqBsHWHPbiUjofAfCexz
         ImY/SoMwOjcRyz8NVfKis0EC6gg/vApT7MnPovsGZ7Uy/kKpaHfbx7mQhcMmuBLrrtbw
         zbm9nrZHpNeuQEQtHN1FDf7qPh+vkaboWQy1erZKH+tC8F3svak3ZXUeXUtiICuBOeWP
         pV6Zyf3+/6jFc4q6yCpq7QYNzC0rAm2Tlso554u93Fe/0LZrJ0wnhFYnrYjrpY+UgKYe
         N9xKXdYY1uCe754KhqiTeK17xy8h88hxFdngN66EwTtzFXyIvQrZEgArVusdmyl1t30Z
         aGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikJ0eLK/6OkjCoMd1X7LK5WjQKKwDBA3WSJVKIrvN0Q=;
        b=PkGf0eXeYdMn7feHV5j7Rqlr8U7e5dAbRCW908zKHwI84cT0rfEW257Gh+YCgopIIv
         kCORapm6aGnV+dCIlA7wS17aUUmxk8sGjA73nt2RNKTOM9POduSzzspW8qxVxZjLv7W2
         CmxOfegdbSRnVKeWxucLeFqxjbPMMiu1zqRv9oXD+S1bjmFX1AgSj+hu7e6IvteWnd47
         J6eSd+dvjFEGXIS/6aAJlUKDWTQ8XZnP8A4xJMlvfeANwdVym+Ee2lPWhANVqknNIR+n
         tqRDEoABwvafvG2lt+626P/H3o92mut6sSsJNxWF0+6M8iPYLnAo6oH5HgQgEULtJEnf
         4ByA==
X-Gm-Message-State: AOAM531tbB/p/RWMIPxhgGfE5fuPnvHNDlZSjjFhcQBKDbeFhCfJMUbz
        TLhrd0u4RbgQMZeT7EgYuKTyPZh/H2Y=
X-Google-Smtp-Source: ABdhPJx6j8+VLldoC176FvuGqcHrx/3F07zRS/Bj6gg26XyS4WLTQTpzvaxEcy5V4XX1782A4Eowgw==
X-Received: by 2002:a05:620a:45:: with SMTP id t5mr28757043qkt.17.1615859674236;
        Mon, 15 Mar 2021 18:54:34 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id s6sm2909385qke.44.2021.03.15.18.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:54:33 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 05/13] tools: sync BITS_MASK macros with the kernel
Date:   Mon, 15 Mar 2021 18:54:16 -0700
Message-Id: <20210316015424.1999082-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316015424.1999082-1-yury.norov@gmail.com>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove BITMAP_{FIRST,LAST}_WORD_MASK and introduce
BITS_{FIRST,LAST}{,_MASK} as per kernel implementation.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/include/linux/bitmap.h      | 20 ++++++--------------
 tools/include/linux/bits.h        |  6 ++++++
 tools/lib/bitmap.c                |  6 +++---
 tools/lib/find_bit.c              |  2 +-
 tools/testing/radix-tree/bitmap.c |  4 ++--
 5 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 7cbd23e56d48..b6e8430c8bc9 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -19,14 +19,6 @@ int __bitmap_equal(const unsigned long *bitmap1,
 		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
 
-#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
-
-#define BITMAP_LAST_WORD_MASK(nbits)					\
-(									\
-	((nbits) % BITS_PER_LONG) ?					\
-		(1UL<<((nbits) % BITS_PER_LONG))-1 : ~0UL		\
-)
-
 #define small_const_nbits(nbits) \
 	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
 
@@ -47,13 +39,13 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 		unsigned int len = (nlongs - 1) * sizeof(unsigned long);
 		memset(dst, 0xff,  len);
 	}
-	dst[nlongs - 1] = BITMAP_LAST_WORD_MASK(nbits);
+	dst[nlongs - 1] = BITS_FIRST(nbits - 1);
 }
 
 static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
 {
 	if (small_const_nbits(nbits))
-		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
+		return !(*src & BITS_FIRST(nbits - 1));
 
 	return find_first_bit(src, nbits) == nbits;
 }
@@ -61,7 +53,7 @@ static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
 static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
+		return !(~(*src) & BITS_FIRST(nbits - 1));
 
 	return find_first_zero_bit(src, nbits) == nbits;
 }
@@ -69,7 +61,7 @@ static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
 static inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
+		return hweight_long(*src & BITS_FIRST(nbits - 1));
 	return __bitmap_weight(src, nbits);
 }
 
@@ -155,7 +147,7 @@ static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return (*dst = *src1 & *src2 & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+		return (*dst = *src1 & *src2 & BITS_FIRST(nbits - 1)) != 0;
 	return __bitmap_and(dst, src1, src2, nbits);
 }
 
@@ -171,7 +163,7 @@ static inline int bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
+		return !((*src1 ^ *src2) & BITS_FIRST(nbits - 1));
 	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
 		return !memcmp(src1, src2, nbits / 8);
diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 7f475d59a097..8c191c29506e 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -37,6 +37,12 @@
 #define GENMASK(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
 
+#define BITS_FIRST(nr)		GENMASK((nr), 0)
+#define BITS_LAST(nr)		GENMASK(BITS_PER_LONG - 1, (nr))
+
+#define BITS_FIRST_MASK(nr)	BITS_FIRST((nr) % BITS_PER_LONG)
+#define BITS_LAST_MASK(nr)	BITS_LAST((nr) % BITS_PER_LONG)
+
 #define __GENMASK_ULL(h, l) \
 	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
 	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index f4e914712b6f..8cffad2d1f77 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -13,7 +13,7 @@ int __bitmap_weight(const unsigned long *bitmap, int bits)
 		w += hweight_long(bitmap[k]);
 
 	if (bits % BITS_PER_LONG)
-		w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
+		w += hweight_long(bitmap[k] & BITS_FIRST_MASK(bits - 1));
 
 	return w;
 }
@@ -68,7 +68,7 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		result |= (dst[k] = bitmap1[k] & bitmap2[k]);
 	if (bits % BITS_PER_LONG)
 		result |= (dst[k] = bitmap1[k] & bitmap2[k] &
-			   BITMAP_LAST_WORD_MASK(bits));
+			   BITS_FIRST_MASK(bits - 1));
 	return result != 0;
 }
 
@@ -81,7 +81,7 @@ int __bitmap_equal(const unsigned long *bitmap1,
 			return 0;
 
 	if (bits % BITS_PER_LONG)
-		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+		if ((bitmap1[k] ^ bitmap2[k]) & BITS_FIRST_MASK(bits - 1))
 			return 0;
 
 	return 1;
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index ac37022e9486..49abb18549cc 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -43,7 +43,7 @@ static inline unsigned long _find_next_bit(const unsigned long *addr1,
 	tmp ^= invert;
 
 	/* Handle 1st word. */
-	tmp &= BITMAP_FIRST_WORD_MASK(start);
+	tmp &= BITS_LAST_MASK(start);
 	start = round_down(start, BITS_PER_LONG);
 
 	while (!tmp) {
diff --git a/tools/testing/radix-tree/bitmap.c b/tools/testing/radix-tree/bitmap.c
index 66ec4a24a203..aedc15461f78 100644
--- a/tools/testing/radix-tree/bitmap.c
+++ b/tools/testing/radix-tree/bitmap.c
@@ -7,7 +7,7 @@ void bitmap_clear(unsigned long *map, unsigned int start, int len)
 	unsigned long *p = map + BIT_WORD(start);
 	const unsigned int size = start + len;
 	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
-	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+	unsigned long mask_to_clear = BITS_LAST_MASK(start);
 
 	while (len - bits_to_clear >= 0) {
 		*p &= ~mask_to_clear;
@@ -17,7 +17,7 @@ void bitmap_clear(unsigned long *map, unsigned int start, int len)
 		p++;
 	}
 	if (len) {
-		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		mask_to_clear &= BITS_FIRST_MASK(size - 1);
 		*p &= ~mask_to_clear;
 	}
 }
-- 
2.25.1

