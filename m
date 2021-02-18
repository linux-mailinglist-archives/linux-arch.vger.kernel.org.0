Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6666D31E4EA
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBREGv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhBREGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:06:44 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB80C0617A7;
        Wed, 17 Feb 2021 20:05:22 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id g3so378140qvl.2;
        Wed, 17 Feb 2021 20:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikJ0eLK/6OkjCoMd1X7LK5WjQKKwDBA3WSJVKIrvN0Q=;
        b=hJg6KQKGJOnvHn0vwvN/UNsRZ03BJw7giIx2ZKPCaDoI43w6V/Bb7ASZ6QVyuy6LL7
         wAy+CoCNsGnuJo4Aw+0i6YbUFzsWiCUGnhrnhrwwD5PMayJ+lSz+T3X0B36OjRd7CY0O
         9+CFQeFlikpBuYVc3jEwRO0o9N2iueXh79+fZ9SAEnGgXlZmLWPB4gOpHMiFgPW1NtAa
         a1dfEZpY70RNMlJFBDQco1J/AaC97WbbTL60/wZJtjN2Q77NzDze/Xh0X+YAyXrkE5/b
         +Ot7oyJGO7xF4PZHE6F/mUFsN06aq1qVgq0hcb0g8NykkGqzccjRAg7tna9k50ssR513
         bNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikJ0eLK/6OkjCoMd1X7LK5WjQKKwDBA3WSJVKIrvN0Q=;
        b=JxDKxj+UB3sx7WjMDFaasnbFfgiXawSZOImPytJ7em3RWBegPPQJuWkueSXRl6lIaH
         Yffol1SfTKB2T/KM/LIxjKXm2wPBkqw7uMkJ+/D65Bdb9ivGO6ax8Fmr1YzjaVXFdBTh
         Qm94a+8+HQUJfYmpHj8U+Z9EGHGTewwyekyijgAOqS2Iw8CUWSmGX/pMytSrsMXjvaRm
         OsW6Yx50hxJ7v0dtGN8ROH10v/RkMWLw+Nvtg33zoh/jd5z+rqSvsPOH/jmwo2K/JezT
         o/9kHrt2e/dq7cpIDzkEORCt0bUa2iZ+D8rEL+D7qylBbtcwexxKiajZavGv8sdhL20P
         zw9g==
X-Gm-Message-State: AOAM533PQUHUMLRpnGe76zIxk00vxpjDHD/mGFmnvHZqFth1wpLZ7X6T
        qRas0EynDECPguc6p+J0CESPpkcpliZgCw==
X-Google-Smtp-Source: ABdhPJx9Tusg+e1+VHXXdGQGgvi3R8zz4RvA+JAGQDv/ycQz9J7otTemRUSc3W5l09mHkDorr8UDFQ==
X-Received: by 2002:ad4:4631:: with SMTP id x17mr2504586qvv.6.1613621121538;
        Wed, 17 Feb 2021 20:05:21 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id j66sm3255440qkf.78.2021.02.17.20.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:21 -0800 (PST)
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
Subject: [PATCH 05/14] tools: sync BITS_MASK macros with the kernel
Date:   Wed, 17 Feb 2021 20:05:03 -0800
Message-Id: <20210218040512.709186-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218040512.709186-1-yury.norov@gmail.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
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

