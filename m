Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C3131E4EC
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhBREGy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhBREGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:06:44 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD28C061794;
        Wed, 17 Feb 2021 20:05:21 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id m144so933958qke.10;
        Wed, 17 Feb 2021 20:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lcwxjl/dsuyts/RranSp981+qqM56LtakHjNiOSMBAs=;
        b=uozEFLdsh2DdZzhW6IYZkYUGgUCWwOwh763sTzo9ape+5Y8Wyprk+znfiiYHc1XgNp
         ylaeq/mCS4PvVGBknotIBLld5IXK/OEUC9YCI6q8PadX1+C2a6a2WJDNALAxO5LV3Hmo
         zrXy2A8VmFUtRsDU1XpcGmYsgTmWo8Vd/AayOIQ7gzSIRIcyKwFytXSADfd2SCkIFTPk
         gi+9kHqBmbic037a68ZTwXE+vtS9w3Qwi0UAC+2BckETOrY9VN21ZCE2w14NYaGqY3mO
         p3xLjk1CHgJpcHDW7nfLz1gHypRVJY99M25WpXNtPNw4L3hB8MufK6M8yMKIKvX0+fpG
         sR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lcwxjl/dsuyts/RranSp981+qqM56LtakHjNiOSMBAs=;
        b=bfOPpFi5HhYZMpyPHfDlid/HMsMWj0MM90iN31qcoXMZb1Y6Il2cMKzN/p2LCSGcR1
         DgFtTNx6i8Wy6QHy1Hx438Q0UuoWlYHzr6MhQJqqo2CaWrCbxFUDze/YOnADeMwFFLhR
         GcBktdBtx/ljBYcCp30bYuqky4kBSXwfAxebl/EAIsQpAXOeNv4yQDV+WRsaS12utc4t
         n8YK4MnSlzr9NghFHNMoEDtUcKyio2GFwaa1+CgxoSu8YwumfzYuTQjlqmuA8j6SAzCE
         yWiQkUq/HhbgxeKo2tfhxsckKQ6PtUvjA7MLrkvgz57wxe7tkR2Lg/jM87MabjkDm8N5
         EH+w==
X-Gm-Message-State: AOAM530FgnCW2DUDXNFJOumBCmI+ZDQ9FIdB573tzxJ2wYnn3FLZL+8c
        JSrzQ7KTp4lWPHsQ3iWj/1kZ3TYRJWcYmA==
X-Google-Smtp-Source: ABdhPJx86J2yiWZ4kKjAGEnb1EHUFO3H/CztpugBS7id9x9Nm/xShLmDEd5FoQHYhQnvh/S8U2oQxw==
X-Received: by 2002:a37:e214:: with SMTP id g20mr2422065qki.41.1613621120357;
        Wed, 17 Feb 2021 20:05:20 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id z28sm3254268qkj.72.2021.02.17.20.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:19 -0800 (PST)
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
Subject: [PATCH 04/14] lib: introduce BITS_{FIRST,LAST} macro
Date:   Wed, 17 Feb 2021 20:05:02 -0800
Message-Id: <20210218040512.709186-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218040512.709186-1-yury.norov@gmail.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

BITMAP_{LAST,FIRST}_WORD_MASK() in linux/bitmap.h duplicates the
functionality of GENMASK(). The scope of there macros is wider
than just bitmap. This patch defines 4 new macros: BITS_FIRST(),
BITS_LAST(), BITS_FIRST_MASK() and BITS_LAST_MASK() in linux/bits.h
on top of GENMASK() and replaces BITMAP_{LAST,FIRST}_WORD_MASK()
to avoid duplication and increase the scope of the macros.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h          | 27 ++++++++++++---------------
 include/linux/bits.h            |  6 ++++++
 include/linux/cpumask.h         |  8 ++++----
 include/linux/netdev_features.h |  2 +-
 include/linux/nodemask.h        |  2 +-
 lib/bitmap.c                    | 26 +++++++++++++-------------
 lib/find_bit.c                  |  4 ++--
 lib/genalloc.c                  |  8 ++++----
 8 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 70a932470b2d..adf7bd9f0467 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -219,9 +219,6 @@ extern unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int
 extern int bitmap_print_to_pagebuf(bool list, char *buf,
 				   const unsigned long *maskp, int nmaskbits);
 
-#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
-#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
-
 /*
  * The static inlines below do not handle constant nbits==0 correctly,
  * so make such users (should any ever turn up) call the out-of-line
@@ -257,7 +254,7 @@ static inline void bitmap_copy_clear_tail(unsigned long *dst,
 {
 	bitmap_copy(dst, src, nbits);
 	if (nbits % BITS_PER_LONG)
-		dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
+		dst[nbits / BITS_PER_LONG] &= BITS_FIRST_MASK(nbits - 1);
 }
 
 /*
@@ -282,7 +279,7 @@ static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return (*dst = *src1 & *src2 & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+		return (*dst = *src1 & *src2 & BITS_FIRST(nbits - 1)) != 0;
 	return __bitmap_and(dst, src1, src2, nbits);
 }
 
@@ -308,7 +305,7 @@ static inline int bitmap_andnot(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return (*dst = *src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+		return (*dst = *src1 & ~(*src2) & BITS_FIRST(nbits - 1)) != 0;
 	return __bitmap_andnot(dst, src1, src2, nbits);
 }
 
@@ -332,7 +329,7 @@ static inline int bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
+		return !((*src1 ^ *src2) & BITS_FIRST(nbits - 1));
 	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
 		return !memcmp(src1, src2, nbits / 8);
@@ -356,14 +353,14 @@ static inline bool bitmap_or_equal(const unsigned long *src1,
 	if (!small_const_nbits(nbits))
 		return __bitmap_or_equal(src1, src2, src3, nbits);
 
-	return !(((*src1 | *src2) ^ *src3) & BITMAP_LAST_WORD_MASK(nbits));
+	return !(((*src1 | *src2) ^ *src3) & BITS_FIRST(nbits - 1));
 }
 
 static inline int bitmap_intersects(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+		return ((*src1 & *src2) & BITS_FIRST(nbits - 1)) != 0;
 	else
 		return __bitmap_intersects(src1, src2, nbits);
 }
@@ -372,7 +369,7 @@ static inline int bitmap_subset(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return ! ((*src1 & ~(*src2)) & BITMAP_LAST_WORD_MASK(nbits));
+		return !((*src1 & ~(*src2)) & BITS_FIRST(nbits - 1));
 	else
 		return __bitmap_subset(src1, src2, nbits);
 }
@@ -380,7 +377,7 @@ static inline int bitmap_subset(const unsigned long *src1,
 static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
 {
 	if (small_const_nbits(nbits))
-		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
+		return !(*src & BITS_FIRST(nbits - 1));
 
 	return find_first_bit(src, nbits) == nbits;
 }
@@ -388,7 +385,7 @@ static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
 static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
+		return !(~(*src) & BITS_FIRST(nbits - 1));
 
 	return find_first_zero_bit(src, nbits) == nbits;
 }
@@ -396,7 +393,7 @@ static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 static __always_inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
+		return hweight_long(*src & BITS_FIRST(nbits - 1));
 	return __bitmap_weight(src, nbits);
 }
 
@@ -432,7 +429,7 @@ static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *s
 				unsigned int shift, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		*dst = (*src & BITMAP_LAST_WORD_MASK(nbits)) >> shift;
+		*dst = (*src & BITS_FIRST(nbits - 1)) >> shift;
 	else
 		__bitmap_shift_right(dst, src, shift, nbits);
 }
@@ -441,7 +438,7 @@ static inline void bitmap_shift_left(unsigned long *dst, const unsigned long *sr
 				unsigned int shift, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-		*dst = (*src << shift) & BITMAP_LAST_WORD_MASK(nbits);
+		*dst = (*src << shift) & BITS_FIRST(nbits - 1);
 	else
 		__bitmap_shift_left(dst, src, shift, nbits);
 }
diff --git a/include/linux/bits.h b/include/linux/bits.h
index 7f475d59a097..8c191c29506e 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
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
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 383684e30f12..edf8d15cfd81 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -899,7 +899,7 @@ static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
 #if NR_CPUS <= BITS_PER_LONG
 #define CPU_BITS_ALL						\
 {								\
-	[BITS_TO_LONGS(NR_CPUS)-1] = BITMAP_LAST_WORD_MASK(NR_CPUS)	\
+	[BITS_TO_LONGS(NR_CPUS)-1] = BITS_FIRST_MASK(NR_CPUS - 1)	\
 }
 
 #else /* NR_CPUS > BITS_PER_LONG */
@@ -907,7 +907,7 @@ static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
 #define CPU_BITS_ALL						\
 {								\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-2] = ~0UL,		\
-	[BITS_TO_LONGS(NR_CPUS)-1] = BITMAP_LAST_WORD_MASK(NR_CPUS)	\
+	[BITS_TO_LONGS(NR_CPUS)-1] = BITS_FIRST_MASK(NR_CPUS - 1)	\
 }
 #endif /* NR_CPUS > BITS_PER_LONG */
 
@@ -931,13 +931,13 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
 #if NR_CPUS <= BITS_PER_LONG
 #define CPU_MASK_ALL							\
 (cpumask_t) { {								\
-	[BITS_TO_LONGS(NR_CPUS)-1] = BITMAP_LAST_WORD_MASK(NR_CPUS)	\
+	[BITS_TO_LONGS(NR_CPUS)-1] = BITS_FIRST_MASK(NR_CPUS - 1)	\
 } }
 #else
 #define CPU_MASK_ALL							\
 (cpumask_t) { {								\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-2] = ~0UL,			\
-	[BITS_TO_LONGS(NR_CPUS)-1] = BITMAP_LAST_WORD_MASK(NR_CPUS)	\
+	[BITS_TO_LONGS(NR_CPUS)-1] = BITS_FIRST_MASK(NR_CPUS - 1)	\
 } }
 #endif /* NR_CPUS > BITS_PER_LONG */
 
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 3de38d6a0aea..4cef7fe02f09 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -173,7 +173,7 @@ enum {
  */
 static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 {
-	/* like BITMAP_LAST_WORD_MASK() for u64
+	/* like BITS_FIRST_MASK() for u64
 	 * this sets the most significant 64 - start to 0.
 	 */
 	feature &= ~0ULL >> (-start & ((sizeof(feature) * 8) - 1));
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index ac398e143c9a..2df0787c9155 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -302,7 +302,7 @@ static inline int __first_unset_node(const nodemask_t *maskp)
 			find_first_zero_bit(maskp->bits, MAX_NUMNODES));
 }
 
-#define NODE_MASK_LAST_WORD BITMAP_LAST_WORD_MASK(MAX_NUMNODES)
+#define NODE_MASK_LAST_WORD BITS_FIRST_MASK(MAX_NUMNODES - 1)
 
 #if MAX_NUMNODES <= BITS_PER_LONG
 
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 75006c4036e9..2507fef664ad 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -52,7 +52,7 @@ int __bitmap_equal(const unsigned long *bitmap1,
 			return 0;
 
 	if (bits % BITS_PER_LONG)
-		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+		if ((bitmap1[k] ^ bitmap2[k]) & BITS_FIRST_MASK(bits - 1))
 			return 0;
 
 	return 1;
@@ -76,7 +76,7 @@ bool __bitmap_or_equal(const unsigned long *bitmap1,
 		return true;
 
 	tmp = (bitmap1[k] | bitmap2[k]) ^ bitmap3[k];
-	return (tmp & BITMAP_LAST_WORD_MASK(bits)) == 0;
+	return (tmp & BITS_FIRST_MASK(bits - 1)) == 0;
 }
 
 void __bitmap_complement(unsigned long *dst, const unsigned long *src, unsigned int bits)
@@ -103,7 +103,7 @@ void __bitmap_shift_right(unsigned long *dst, const unsigned long *src,
 {
 	unsigned k, lim = BITS_TO_LONGS(nbits);
 	unsigned off = shift/BITS_PER_LONG, rem = shift % BITS_PER_LONG;
-	unsigned long mask = BITMAP_LAST_WORD_MASK(nbits);
+	unsigned long mask = BITS_FIRST_MASK(nbits - 1);
 	for (k = 0; off + k < lim; ++k) {
 		unsigned long upper, lower;
 
@@ -246,7 +246,7 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		result |= (dst[k] = bitmap1[k] & bitmap2[k]);
 	if (bits % BITS_PER_LONG)
 		result |= (dst[k] = bitmap1[k] & bitmap2[k] &
-			   BITMAP_LAST_WORD_MASK(bits));
+			   BITS_FIRST_MASK(bits - 1));
 	return result != 0;
 }
 EXPORT_SYMBOL(__bitmap_and);
@@ -284,7 +284,7 @@ int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 		result |= (dst[k] = bitmap1[k] & ~bitmap2[k]);
 	if (bits % BITS_PER_LONG)
 		result |= (dst[k] = bitmap1[k] & ~bitmap2[k] &
-			   BITMAP_LAST_WORD_MASK(bits));
+			   BITS_FIRST_MASK(bits - 1));
 	return result != 0;
 }
 EXPORT_SYMBOL(__bitmap_andnot);
@@ -310,7 +310,7 @@ int __bitmap_intersects(const unsigned long *bitmap1,
 			return 1;
 
 	if (bits % BITS_PER_LONG)
-		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+		if ((bitmap1[k] & bitmap2[k]) & BITS_FIRST_MASK(bits - 1))
 			return 1;
 	return 0;
 }
@@ -325,7 +325,7 @@ int __bitmap_subset(const unsigned long *bitmap1,
 			return 0;
 
 	if (bits % BITS_PER_LONG)
-		if ((bitmap1[k] & ~bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+		if ((bitmap1[k] & ~bitmap2[k]) & BITS_FIRST_MASK(bits - 1))
 			return 0;
 	return 1;
 }
@@ -340,7 +340,7 @@ int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
 		w += hweight_long(bitmap[k]);
 
 	if (bits % BITS_PER_LONG)
-		w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
+		w += hweight_long(bitmap[k] & BITS_FIRST_MASK(bits - 1));
 
 	return w;
 }
@@ -351,7 +351,7 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len)
 	unsigned long *p = map + BIT_WORD(start);
 	const unsigned int size = start + len;
 	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
-	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
+	unsigned long mask_to_set = BITS_LAST_MASK(start);
 
 	while (len - bits_to_set >= 0) {
 		*p |= mask_to_set;
@@ -361,7 +361,7 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len)
 		p++;
 	}
 	if (len) {
-		mask_to_set &= BITMAP_LAST_WORD_MASK(size);
+		mask_to_set &= BITS_FIRST_MASK(size - 1);
 		*p |= mask_to_set;
 	}
 }
@@ -372,7 +372,7 @@ void __bitmap_clear(unsigned long *map, unsigned int start, int len)
 	unsigned long *p = map + BIT_WORD(start);
 	const unsigned int size = start + len;
 	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
-	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+	unsigned long mask_to_clear = BITS_LAST_MASK(start);
 
 	while (len - bits_to_clear >= 0) {
 		*p &= ~mask_to_clear;
@@ -382,7 +382,7 @@ void __bitmap_clear(unsigned long *map, unsigned int start, int len)
 		p++;
 	}
 	if (len) {
-		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		mask_to_clear &= BITS_FIRST_MASK(size - 1);
 		*p &= ~mask_to_clear;
 	}
 }
@@ -1282,7 +1282,7 @@ void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned int nbits
 
 	/* Clear tail bits in last word beyond nbits. */
 	if (nbits % BITS_PER_LONG)
-		bitmap[(halfwords - 1) / 2] &= BITMAP_LAST_WORD_MASK(nbits);
+		bitmap[(halfwords - 1) / 2] &= BITS_FIRST_MASK(nbits - 1);
 }
 EXPORT_SYMBOL(bitmap_from_arr32);
 
diff --git a/lib/find_bit.c b/lib/find_bit.c
index f67f86fd2f62..8c2a71a18793 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -44,7 +44,7 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
 	tmp ^= invert;
 
 	/* Handle 1st word. */
-	mask = BITMAP_FIRST_WORD_MASK(start);
+	mask = BITS_LAST_MASK(start);
 	if (le)
 		mask = swab(mask);
 
@@ -141,7 +141,7 @@ EXPORT_SYMBOL(find_first_zero_bit);
 unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 {
 	if (size) {
-		unsigned long val = BITMAP_LAST_WORD_MASK(size);
+		unsigned long val = BITS_FIRST_MASK(size - 1);
 		unsigned long idx = (size-1) / BITS_PER_LONG;
 
 		do {
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 5dcf9cdcbc46..0af7275517ff 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -87,7 +87,7 @@ bitmap_set_ll(unsigned long *map, unsigned long start, unsigned long nr)
 	unsigned long *p = map + BIT_WORD(start);
 	const unsigned long size = start + nr;
 	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
-	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
+	unsigned long mask_to_set = BITS_LAST_MASK(start);
 
 	while (nr >= bits_to_set) {
 		if (set_bits_ll(p, mask_to_set))
@@ -98,7 +98,7 @@ bitmap_set_ll(unsigned long *map, unsigned long start, unsigned long nr)
 		p++;
 	}
 	if (nr) {
-		mask_to_set &= BITMAP_LAST_WORD_MASK(size);
+		mask_to_set &= BITS_FIRST_MASK(size - 1);
 		if (set_bits_ll(p, mask_to_set))
 			return nr;
 	}
@@ -123,7 +123,7 @@ bitmap_clear_ll(unsigned long *map, unsigned long start, unsigned long nr)
 	unsigned long *p = map + BIT_WORD(start);
 	const unsigned long size = start + nr;
 	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
-	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+	unsigned long mask_to_clear = BITS_LAST_MASK(start);
 
 	while (nr >= bits_to_clear) {
 		if (clear_bits_ll(p, mask_to_clear))
@@ -134,7 +134,7 @@ bitmap_clear_ll(unsigned long *map, unsigned long start, unsigned long nr)
 		p++;
 	}
 	if (nr) {
-		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		mask_to_clear &= BITS_FIRST_MASK(size - 1);
 		if (clear_bits_ll(p, mask_to_clear))
 			return nr;
 	}
-- 
2.25.1

