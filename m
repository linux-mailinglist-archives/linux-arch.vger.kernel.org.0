Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6BA3097F6
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 20:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhA3TTR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 14:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhA3TSq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jan 2021 14:18:46 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C55C061794;
        Sat, 30 Jan 2021 11:17:29 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id t14so9290927qto.8;
        Sat, 30 Jan 2021 11:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9qhc9BYAtLY8EP7loxZVXO/bWo6OC7wmeVoXeXbjIA=;
        b=f+HbBhAc1svnrCehEix/8kOJHnAknl0p1A3aQ/a+ykeOjZ2vbQujKJbkD/wkmQqTQC
         26S86zrvLTJcOkI5qmRPOtWwXie5i3ZJn80MCPHIEYPzJyaTyYMQY+NL/Qqszz/oZ4+U
         o+sqmSO3C7MrIMTH3hbE6EeLZwQXRakA7VAr6rlWGMwx/8PHwDuiep/m/sHQRaUbOrMU
         xH8emf7HLDJwnxMvPPdlOkMhbibpJ8GU2XhCDkBcevHYlCK9zGuptNQky0K22GPZRjSM
         sT+abrp2h6ysYTFJqoEFq1Z8hos+avveH9+wSJK9uBJcTC11DymyHi18Mb6XDEKWWrzd
         U2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9qhc9BYAtLY8EP7loxZVXO/bWo6OC7wmeVoXeXbjIA=;
        b=jejd3qsjMpGIxWzdOfSqINDifL7so4ZFHC2zBbKxUN1RN9dWuowiXK0Zi3jxhU9yQ8
         lG9h8nzftp4e/Yj9OUlWfqAibS1vUuj2kIwgX3z7C8fwHTLQL8uTJzLDxGu+uHiNadzA
         v+QRmkNHdthOYrRZZji0toFyaaEwUkGlPynNHu3GZUSnzgKTKbJGeJPzQdCvJHNjFL9r
         iuMUv7g57Dq0QtydRDFUUQ3s3+suvM9QKC0OkvaLzHQeZzRjkuQcBOCD2KSd+29DBeuE
         RiBAWDMPhLsBqe4Gqlwvy2V7rI6LNI4//4Jpq9vNhsQ5APxYjMLM4VTsAfaXTKnoR8u0
         AC5g==
X-Gm-Message-State: AOAM530Src6l57nlAIRNtXFqUFopziL3Zk4oC4scTLpHg25VRBEhGz7b
        JCOGOI2dpJ50hiW1PGXo098=
X-Google-Smtp-Source: ABdhPJySiz6OieCqZ2nBEFcl7kkAFACt+3LPmwb3+NjWqwB6dOPJP0X0Oa0Ze5QTlJiqVWQNY0vcSA==
X-Received: by 2002:ac8:1109:: with SMTP id c9mr9030204qtj.120.1612034248416;
        Sat, 30 Jan 2021 11:17:28 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id w28sm8997054qtv.93.2021.01.30.11.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 11:17:27 -0800 (PST)
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
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 5/8] bitsperlong.h: introduce SMALL_CONST() macro
Date:   Sat, 30 Jan 2021 11:17:16 -0800
Message-Id: <20210130191719.7085-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210130191719.7085-1-yury.norov@gmail.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Many algorithms become simpler if they are passed with relatively small
input values. One example is bitmap operations when the whole bitmap fits
into one word. To implement such simplifications, linux/bitmap.h declares
small_const_nbits() macro.

Other subsystems may also benefit from optimizations of this sort, like
find_bit API in the following patches. So it looks helpful to generalize
the macro and extend it's visibility.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitsperlong.h       |  2 ++
 include/linux/bitmap.h                  | 33 +++++++++++--------------
 tools/include/asm-generic/bitsperlong.h |  2 ++
 tools/include/linux/bitmap.h            | 19 ++++++--------
 4 files changed, 27 insertions(+), 29 deletions(-)

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
index adf7bd9f0467..e89f1dace846 100644
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
 		return (*dst = *src1 & *src2 & BITS_FIRST(nbits - 1)) != 0;
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
 		return (*dst = *src1 & ~(*src2) & BITS_FIRST(nbits - 1)) != 0;
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
 		return !((*src1 ^ *src2) & BITS_FIRST(nbits - 1));
 	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
@@ -350,7 +347,7 @@ static inline bool bitmap_or_equal(const unsigned long *src1,
 				   const unsigned long *src3,
 				   unsigned int nbits)
 {
-	if (!small_const_nbits(nbits))
+	if (!SMALL_CONST(nbits - 1))
 		return __bitmap_or_equal(src1, src2, src3, nbits);
 
 	return !(((*src1 | *src2) ^ *src3) & BITS_FIRST(nbits - 1));
@@ -359,7 +356,7 @@ static inline bool bitmap_or_equal(const unsigned long *src1,
 static inline int bitmap_intersects(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return ((*src1 & *src2) & BITS_FIRST(nbits - 1)) != 0;
 	else
 		return __bitmap_intersects(src1, src2, nbits);
@@ -368,7 +365,7 @@ static inline int bitmap_intersects(const unsigned long *src1,
 static inline int bitmap_subset(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return !((*src1 & ~(*src2)) & BITS_FIRST(nbits - 1));
 	else
 		return __bitmap_subset(src1, src2, nbits);
@@ -376,7 +373,7 @@ static inline int bitmap_subset(const unsigned long *src1,
 
 static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return !(*src & BITS_FIRST(nbits - 1));
 
 	return find_first_bit(src, nbits) == nbits;
@@ -384,7 +381,7 @@ static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
 
 static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return !(~(*src) & BITS_FIRST(nbits - 1));
 
 	return find_first_zero_bit(src, nbits) == nbits;
@@ -392,7 +389,7 @@ static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 
 static __always_inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return hweight_long(*src & BITS_FIRST(nbits - 1));
 	return __bitmap_weight(src, nbits);
 }
@@ -428,7 +425,7 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *src,
 				unsigned int shift, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = (*src & BITS_FIRST(nbits - 1)) >> shift;
 	else
 		__bitmap_shift_right(dst, src, shift, nbits);
@@ -437,7 +434,7 @@ static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *s
 static inline void bitmap_shift_left(unsigned long *dst, const unsigned long *src,
 				unsigned int shift, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = (*src << shift) & BITS_FIRST(nbits - 1);
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
index b6e8430c8bc9..fdc0b64bbdbf 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -19,12 +19,9 @@ int __bitmap_equal(const unsigned long *bitmap1,
 		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
 
-#define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
-
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = 0UL;
 	else {
 		int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
@@ -35,7 +32,7 @@ static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
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
 		return !(*src & BITS_FIRST(nbits - 1));
 
 	return find_first_bit(src, nbits) == nbits;
@@ -52,7 +49,7 @@ static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
 
 static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return !(~(*src) & BITS_FIRST(nbits - 1));
 
 	return find_first_zero_bit(src, nbits) == nbits;
@@ -60,7 +57,7 @@ static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
 
 static inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return hweight_long(*src & BITS_FIRST(nbits - 1));
 	return __bitmap_weight(src, nbits);
 }
@@ -68,7 +65,7 @@ static inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
 static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		*dst = *src1 | *src2;
 	else
 		__bitmap_or(dst, src1, src2, nbits);
@@ -146,7 +143,7 @@ size_t bitmap_scnprintf(unsigned long *bitmap, unsigned int nbits,
 static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return (*dst = *src1 & *src2 & BITS_FIRST(nbits - 1)) != 0;
 	return __bitmap_and(dst, src1, src2, nbits);
 }
@@ -162,7 +159,7 @@ static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 static inline int bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
-	if (small_const_nbits(nbits))
+	if (SMALL_CONST(nbits - 1))
 		return !((*src1 ^ *src2) & BITS_FIRST(nbits - 1));
 	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-- 
2.25.1

