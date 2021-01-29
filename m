Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35209308EB1
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhA2Urj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhA2UrC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 15:47:02 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290EC061786;
        Fri, 29 Jan 2021 12:45:36 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d85so10081521qkg.5;
        Fri, 29 Jan 2021 12:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XrOPnUU4jEbWi/M2Zi06ni4mxPUtjC+T0l547A4XI6E=;
        b=e49ztA0Af1BL+k/IT0uKmcHOJLVpLTAxtd/459UXQMGKsiBwYP9TZZlT7GnG5lE9bc
         e/Pua9mryQeRc/M4GfZ7g70Ezwj7yGPGNtLwjzIZNEisH5h+nB1pN39B0DNXtJzHuMwt
         PW0xivngi/qmMI7Abh47I6kE0dHJxlM2Cya2Q85B3b794H+X7j4pqlvkknX5ixMjAI1H
         GZleweJULTfP4WiRXprwnuQEtt5/akCHh64kVCZHfr9HuutskvQ/7irdfiFkSFmfCJO/
         t6VstshNuSko0Bhl0W1kXX9TUPFdgnV0FDyqUSZzR0wfr2IgO7JRqzr3Kf+YJBv8O5EZ
         AboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XrOPnUU4jEbWi/M2Zi06ni4mxPUtjC+T0l547A4XI6E=;
        b=j8iX21eS7NaXy+mnQxdL3tlnvQ6ESp0KYDIDPIoHKzn33RezFBvNS7tbKFQurCARRC
         dLDSstvIF70ih5Y60KkSlwoL2yLpWUUftAHsI1dh2hKtNzC4hCvFaE8XaUpuVsC44hiM
         3YNzyaBXftkIkY3Nj32yM6ocY+vG2y7YlPPaebt+jXV2D0G6EoNyhfuInXLpOcMdIud0
         GoRcWtbE9s2CS4XULH4wxSpmKFSDJfCfU/ifFIHM41+y4o54sKYfDOj6MqUEtbcqcLFo
         4ach1PbtIphwAV2A66Lh3JUAdqJRp8E99o+U/eUoSiw7BUYkCastDmYLreMkoVqleC0o
         HKaw==
X-Gm-Message-State: AOAM5329Fj+1rrguQV5gm8kUFfxmYajXB7a5UQryLZh4DJWTT1JLfPv8
        KOXtUw8xavnU822VUmUKCa4=
X-Google-Smtp-Source: ABdhPJx1nrnIMv5t3d04PZEKLsT4RR6h0kU1kfuS0tY67molyRF7oIsTXPeXMVQBLoTvJA9xKRHnPw==
X-Received: by 2002:a37:4cca:: with SMTP id z193mr6030578qka.304.1611953136007;
        Fri, 29 Jan 2021 12:45:36 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id c15sm6599439qkj.129.2021.01.29.12.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:45:35 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH 2/5] bits_per_long.h: introduce SMALL_CONST() macro
Date:   Fri, 29 Jan 2021 12:45:25 -0800
Message-Id: <20210129204528.2118168-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129204528.2118168-1-yury.norov@gmail.com>
References: <20210129204528.2118168-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Many algorithms become simplier if they are passed with relatively small
input values. One example is bitmap operations when the whole bitmap fits
into one word. To implement such simplifications, linux/bitmap.h declares
small_const_nbits() macro.

Other subsystems may also benefit from optimizations of this sort, like
find_bit API in the following patches. So it looks helpful to generalize
the macro and extend it's visibility.

It should probably go to linux/kernel.h, but doing that creates circular
dependencies. So put it in asm-generic/bitsperlong.h.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitsperlong.h       |  2 ++
 include/linux/bitmap.h                  | 33 +++++++++++--------------
 include/linux/bits.h                    |  2 +-
 tools/include/asm-generic/bitsperlong.h |  2 ++
 tools/include/linux/bitmap.h            | 19 ++++++--------
 5 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
index 3905c1c93dc2..0eeb77544f1d 100644
--- a/include/asm-generic/bitsperlong.h
+++ b/include/asm-generic/bitsperlong.h
@@ -23,4 +23,6 @@
 #define BITS_PER_LONG_LONG 64
 #endif
 
+#define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n) < BITS_PER_LONG)
+
 #endif /* __ASM_GENERIC_BITS_PER_LONG */
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index c862082b4d1a..89e43ba775d4 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -224,9 +224,6 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
  * so make such users (should any ever turn up) call the out-of-line
  * versions.
  */
-#define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
-
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
@@ -278,7 +275,7 @@ extern void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap,
 static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return (*dst = *src1 & *src2 & BITS_FIRST_MASK(nbits - 1)) != 0;
 	return __bitmap_and(dst, src1, src2, nbits);
 }
@@ -286,7 +283,7 @@ static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = *src1 | *src2;
 	else
 		__bitmap_or(dst, src1, src2, nbits);
@@ -295,7 +292,7 @@ static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = *src1 ^ *src2;
 	else
 		__bitmap_xor(dst, src1, src2, nbits);
@@ -304,7 +301,7 @@ static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 static inline int bitmap_andnot(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return (*dst = *src1 & ~(*src2) & BITS_FIRST_MASK(nbits - 1)) != 0;
 	return __bitmap_andnot(dst, src1, src2, nbits);
 }
@@ -312,7 +309,7 @@ static inline int bitmap_andnot(unsigned long *dst, const unsigned long *src1,
 static inline void bitmap_complement(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = ~(*src);
 	else
 		__bitmap_complement(dst, src, nbits);
@@ -328,7 +325,7 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
 static inline int bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return !((*src1 ^ *src2) & BITS_FIRST_MASK(nbits - 1));
 	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
@@ -350,7 +347,7 @@ static inline bool bitmap_or_equal(const unsigned long *src1,
 				   const unsigned long *src3,
 				   unsigned int nbits)
 {
-	if (!small_const_nbits(nbits))
+	if (!SMALL_CONST(nbits - 1))
 		return __bitmap_or_equal(src1, src2, src3, nbits);
 
 	return !(((*src1 | *src2) ^ *src3) & BITS_FIRST_MASK(nbits - 1));
@@ -359,7 +356,7 @@ static inline bool bitmap_or_equal(const unsigned long *src1,
 static inline int bitmap_intersects(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return ((*src1 & *src2) & BITS_FIRST_MASK(nbits - 1)) != 0;
 	else
 		return __bitmap_intersects(src1, src2, nbits);
@@ -368,7 +365,7 @@ static inline int bitmap_intersects(const unsigned long *src1,
 static inline int bitmap_subset(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return ! ((*src1 & ~(*src2)) & BITS_FIRST_MASK(nbits - 1));
 	else
 		return __bitmap_subset(src1, src2, nbits);
@@ -376,7 +373,7 @@ static inline int bitmap_subset(const unsigned long *src1,
 
 static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return ! (*src & BITS_FIRST_MASK(nbits - 1));
 
 	return find_first_bit(src, nbits) == nbits;
@@ -384,7 +381,7 @@ static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
 
 static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return ! (~(*src) & BITS_FIRST_MASK(nbits - 1));
 
 	return find_first_zero_bit(src, nbits) == nbits;
@@ -392,7 +389,7 @@ static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 
 static __always_inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return hweight_long(*src & BITS_FIRST_MASK(nbits - 1));
 	return __bitmap_weight(src, nbits);
 }
@@ -428,7 +425,7 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *src,
 				unsigned int shift, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = (*src & BITS_FIRST_MASK(nbits - 1)) >> shift;
 	else
 		__bitmap_shift_right(dst, src, shift, nbits);
@@ -437,7 +434,7 @@ static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *s
 static inline void bitmap_shift_left(unsigned long *dst, const unsigned long *src,
 				unsigned int shift, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = (*src << shift) & BITS_FIRST_MASK(nbits - 1);
 	else
 		__bitmap_shift_left(dst, src, shift, nbits);
@@ -449,7 +446,7 @@ static inline void bitmap_replace(unsigned long *dst,
 				  const unsigned long *mask,
 				  unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = (*old & ~(*mask)) | (*new & *mask);
 	else
 		__bitmap_replace(dst, old, new, mask, nbits);
diff --git a/include/linux/bits.h b/include/linux/bits.h
index 3a29b1190744..e07e4a55241b 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -37,7 +37,7 @@
 #define GENMASK(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
 
-#define BITS_FIRST(nr)		GENMASK(nr), 0)
+#define BITS_FIRST(nr)		GENMASK((nr), 0)
 #define BITS_LAST(nr)		GENMASK(BITS_PER_LONG - 1, (nr))
 
 #define BITS_FIRST_MASK(nr)	__GENMASK((nr) % BITS_PER_LONG, 0)
diff --git a/tools/include/asm-generic/bitsperlong.h b/tools/include/asm-generic/bitsperlong.h
index 8f2283052333..432d272baf27 100644
--- a/tools/include/asm-generic/bitsperlong.h
+++ b/tools/include/asm-generic/bitsperlong.h
@@ -18,4 +18,6 @@
 #define BITS_PER_LONG_LONG 64
 #endif
 
+#define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n) < BITS_PER_LONG)
+
 #endif /* __ASM_GENERIC_BITS_PER_LONG */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index ded716902bd0..bcbe6fe8fdab 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -19,12 +19,9 @@ int __bitmap_equal(const unsigned long *bitmap1,
 		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
 
-#define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
-
 static inline void bitmap_zero(unsigned long *dst, int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = 0UL;
 	else {
 		int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
@@ -35,7 +32,7 @@ static inline void bitmap_zero(unsigned long *dst, int nbits)
 static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int nlongs = BITS_TO_LONGS(nbits);
-	if (!small_const_nbits(nbits)) {
+	if (!SMALL_CONST(nbits - 1)) {
 		unsigned int len = (nlongs - 1) * sizeof(unsigned long);
 		memset(dst, 0xff,  len);
 	}
@@ -44,7 +41,7 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 
 static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return ! (*src & BITS_FIRST_MASK(nbits - 1));
 
 	return find_first_bit(src, nbits) == nbits;
@@ -52,7 +49,7 @@ static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
 
 static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return ! (~(*src) & BITS_FIRST_MASK(nbits - 1));
 
 	return find_first_zero_bit(src, nbits) == nbits;
@@ -60,7 +57,7 @@ static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
 
 static inline int bitmap_weight(const unsigned long *src, int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return hweight_long(*src & BITS_FIRST_MASK(nbits - 1));
 	return __bitmap_weight(src, nbits);
 }
@@ -68,7 +65,7 @@ static inline int bitmap_weight(const unsigned long *src, int nbits)
 static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = *src1 | *src2;
 	else
 		__bitmap_or(dst, src1, src2, nbits);
@@ -146,7 +143,7 @@ size_t bitmap_scnprintf(unsigned long *bitmap, int nbits,
 static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return (*dst = *src1 & *src2 & BITS_FIRST_MASK(nbits - 1)) != 0;
 	return __bitmap_and(dst, src1, src2, nbits);
 }
@@ -162,7 +159,7 @@ static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 static inline int bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return !((*src1 ^ *src2) & BITS_FIRST_MASK(nbits - 1));
 	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-- 
2.25.1

