Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE1031E4EF
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBREG4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhBREGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:06:44 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF837C0617AA;
        Wed, 17 Feb 2021 20:05:23 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id o21so541972qtr.3;
        Wed, 17 Feb 2021 20:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FLaYtqlcPj5mHz3wttzpDxqmTsU3JE46pi9R7LZnzQ=;
        b=WcaKUrkhzBFoblnjEi373y1rNZ+Iv84R7dXzYpvVZucFwksStCrd6i+xfoTRvzjJCq
         pZ1p7BEIF1oOl+8FXZnEcQO7Npv/GMkHu1QWg8/QJhaIxfjbElNQHBmj6gm877PsEv0T
         TDOoAofxpjcDqhfwMtM8gPlCe+I0JWxfCYi6ihiCdDFzArG+TPvOrCMJkU++TbXEfEiT
         1zxvaAnq/cA5O1yr7F1afKon6lgZ8WfLkKYHoBMo80PWnN+I2029y+WVvqvqpDKWwwle
         UONBe+qp7YxJa2xfjoLbNO2oNbcUgQ20gwlyJuz4CnPLVlJWN0LUwcpBUJwAack17TPk
         qPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FLaYtqlcPj5mHz3wttzpDxqmTsU3JE46pi9R7LZnzQ=;
        b=ew+AURVtAl9Aa7vr81MgAd+yKHxWc7fG8+Wr42vyXuuVSXttMReVx5MNvBSja63ceL
         2V1g4Z3CVpiY9fr0QIZLGAtCcq5dXAnlEVLh3BwdAkHotC+Pm20R2vrlAFFdD44NRM+8
         mWZg3zAbQOSdheLNpAqd+4/dtrxLT5w9uTPrrlxVG7LN68RBx0Y2aQndJcQbfqAOMVcd
         4SyBUAMHtY8e+1r//LtXjtxkvO1fKFiGhp3u+Bx+FKKDeWqT1ux0o0bklghSL4auwZEI
         wsYVAgNs6mqN+bQnh0WlNO8EpvJEytceCuUZ0Hz/rbmj7S86HamfIjK6uS6NyCyHLFAV
         mL7A==
X-Gm-Message-State: AOAM533WAHPypmfat0Jl4+cfp+c44AgDhiYwy02au/6dWQ4vTp1+AzS3
        MN5zvSvoVdE6bNRYHW/TK0rwMyAdWWzQXA==
X-Google-Smtp-Source: ABdhPJzD9ex6BPIwZwBTxQRWM29pvG7PcO8nqZzvvxw3eMNa8TLjrRaZkC8xW/fyY/pkdE6kuXRemg==
X-Received: by 2002:ac8:ac4:: with SMTP id g4mr1888414qti.88.1613621122627;
        Wed, 17 Feb 2021 20:05:22 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id g5sm3199230qki.90.2021.02.17.20.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:22 -0800 (PST)
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
Subject: [PATCH 06/14] bitsperlong.h: introduce SMALL_CONST() macro
Date:   Wed, 17 Feb 2021 20:05:04 -0800
Message-Id: <20210218040512.709186-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218040512.709186-1-yury.norov@gmail.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
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
 include/asm-generic/bitsperlong.h |  2 ++
 include/linux/bitmap.h            | 33 ++++++++++++++-----------------
 2 files changed, 17 insertions(+), 18 deletions(-)

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
-- 
2.25.1

