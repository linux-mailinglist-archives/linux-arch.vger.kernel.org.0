Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2120031E4F3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhBREIJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhBREG4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:06:56 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6714C061356;
        Wed, 17 Feb 2021 20:05:24 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id r77so926856qka.12;
        Wed, 17 Feb 2021 20:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjSIeqJixMTGqRQf4pKdu4MWSI5GGmFq1M6YrJB6ms0=;
        b=NwqiIYKiwQvjkCSg9zybdmkHUmSyFt2HOQn/UnvZHP1/cFo5L0xG2Qu2pDC776jxbP
         CuAKEnW4PiUEXH+BYQwj7akf/i9yRdU6TBvYU0hxuFK4B/0KRSHcI7+ost9IZ5DjIeQh
         vgbzSHWeKp99QlRbJROnOw7SYSI0RWLKVEwEPAQC3Ch8SJSn6WtwDRvHA0Pn6czqz2lX
         3y6mYEVeSMqZHAnb1WK7uqgX4CsXsGJzryOu0kpByxDoE8jB554hRuKBlLerxp/K0upN
         SUGhK7kDp8YtmJEWeafHWGpDJT6gijvMS8TFMLYj9E8wWtCanPW5sEl9uw8zvv5thqdp
         ENQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjSIeqJixMTGqRQf4pKdu4MWSI5GGmFq1M6YrJB6ms0=;
        b=pYHXUXx9mZgpgP4z8GiUzpbnYmTfjbN5thIkT+TFqlpJxLHPVwAjUO7OgaiO9GzB85
         UB0wAoO1ZpMTsY3+z/kWEaPTsbdR7yjEP0r45ccJp9tFOLC6o8hC2rRqmgIqeWZfLNYu
         b1b1/K1HJrd9EBL0/r7V647wL7N0aogsE4yYRc46tDhQUfcFBdrxuLSL9X1u6AJpSOiR
         5jy8XZt4UTpDI4lP2sp+eism6TwU1IgTZMKpQue5eshAkZVQPTX+bgEydIFDALsT06Iw
         ueOATGKWqEJWrZ/2m3yImhRQ9n+yo5uMB0iov7ZqayGYmlTh4AhtxsuPgGNzCIyuaXBc
         zh7A==
X-Gm-Message-State: AOAM531WCLkApLPzTPFn0oJ3djUa6/1hwqMFVVZ2JMPXHPjHCd9bCCa8
        7ZUmIYKGfbcnW/5KlAAA1AmuhJ0Jjuq+sg==
X-Google-Smtp-Source: ABdhPJwWyhO8SiOvUL7zClLuBCnRg+OdrKdBQxcsMRMEOJ5MAi89x93TmlkkOhuwzoAKgXCkxlDjpQ==
X-Received: by 2002:a05:620a:166a:: with SMTP id d10mr2364582qko.213.1613621123624;
        Wed, 17 Feb 2021 20:05:23 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id c7sm2637792qtc.82.2021.02.17.20.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:23 -0800 (PST)
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
Subject: [PATCH 07/14] tools: introduce SMALL_CONST() macro
Date:   Wed, 17 Feb 2021 20:05:05 -0800
Message-Id: <20210218040512.709186-8-yury.norov@gmail.com>
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
 tools/include/asm-generic/bitsperlong.h |  2 ++
 tools/include/linux/bitmap.h            | 19 ++++++++-----------
 2 files changed, 10 insertions(+), 11 deletions(-)

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

