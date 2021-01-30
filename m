Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EC93097F3
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 20:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhA3TTA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 14:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhA3TSr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jan 2021 14:18:47 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65668C0617A7;
        Sat, 30 Jan 2021 11:17:30 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id o18so9299419qtp.10;
        Sat, 30 Jan 2021 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eq0sMeRmDWJcO+dKhI424xhFawJ8LFDKhMRVHIBIiKc=;
        b=i2wWD9BiEfwdp8o4QD4aZ7RO9JGd8jSDB+p8g+CMv8tZqoCDhNTLpn36BCVIpTGPyK
         YBt13mliLxs7UmR2fb6aYr+m2x2HXzHRUjpF+pueIAXt9wK11UA5PXYOCRUlYcPgISp8
         0Stjd8KYqd3UhmXtEdNp9wtr7JkweWUNmLt9dFUxW74JOctIl+RTqMkaxFOnGlhYWHnY
         C1FumfHRVVvHf0aOXoOMTvLM4ollB6hYd6Z5p0474E/0eI60kqAwvfU4gKx214Zs0g9j
         zjHLjPwuKSbf6xtlHm1GApDW3fIhHu2uiJMuUAwAJ82czm+xyqB5xF8nMQhOZnPqbUCR
         T6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eq0sMeRmDWJcO+dKhI424xhFawJ8LFDKhMRVHIBIiKc=;
        b=JyXS/KO/txzDUia4QRy1nuXWh5kb8u9OWgrDRveXmzNxB7Lc54ubfF9J+bDHqCitTk
         cdhOJ/Hrcj22jLjM4Wk8YCWqLK0TtcrjjurZR6tqJfkai73FCQZq0AJuHWwSbAZbqbcq
         nUactH0Fu6ylE8AjMhxEAGEyrhf+sUGu+PlDi4sZhYi9PAU99HCvlCfVz2iJ2BVsZ3xy
         s3IwWehaxhg5RuoPKsAi/8TiDoqfd93JNaJbQAN56dq/B7hO7+JLbqi/aUO76kdO6Ai5
         QPSehgzHJDgD+uGDqpFwvUqH0ZqaUJNxhNFjiN4wqH3ciQqG3j2pPC1BDqARB9NSdQd0
         mQSw==
X-Gm-Message-State: AOAM5326KscwoU8efKGiYdHezuqMwPk5+p8DFzHi0XK/akk+hdGhOe/r
        d5kw1mJ0fe/FSeBf8Z0tyBQ=
X-Google-Smtp-Source: ABdhPJy6O1+gaCajwURLoz1VhLkw4sPJG5eCZTZ2ml5f0DSPR4fVtDNkxopibDyO7giWvXRnMOJLHg==
X-Received: by 2002:aed:2f06:: with SMTP id l6mr9078164qtd.386.1612034249570;
        Sat, 30 Jan 2021 11:17:29 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id f188sm1645793qkj.110.2021.01.30.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 11:17:29 -0800 (PST)
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
Subject: [PATCH 6/8] lib: inline _find_next_bit() wrappers
Date:   Sat, 30 Jan 2021 11:17:17 -0800
Message-Id: <20210130191719.7085-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210130191719.7085-1-yury.norov@gmail.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

lib/find_bit.c declares five single-line wrappers for _find_next_bit().
We may turn those wrappers to inline functions. It eliminates unneeded
function calls and opens room for compile-time optimizations.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitops/find.h       | 28 ++++++++++---
 include/asm-generic/bitops/le.h         | 17 ++++++--
 lib/find_bit.c                          | 56 +------------------------
 tools/include/asm-generic/bitops/find.h | 27 +++++++++---
 tools/lib/find_bit.c                    | 52 ++++++++++-------------
 5 files changed, 79 insertions(+), 101 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 9fdf21302fdf..7ad70dab8e93 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_GENERIC_BITOPS_FIND_H_
 #define _ASM_GENERIC_BITOPS_FIND_H_
 
+extern unsigned long _find_next_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long nbits,
+		unsigned long start, unsigned long invert, unsigned long le);
+
 #ifndef find_next_bit
 /**
  * find_next_bit - find the next set bit in a memory region
@@ -12,8 +16,12 @@
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
-		size, unsigned long offset);
+static inline
+unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
+			    unsigned long offset)
+{
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+}
 #endif
 
 #ifndef find_next_and_bit
@@ -27,9 +35,13 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-extern unsigned long find_next_and_bit(const unsigned long *addr1,
+static inline
+unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
-		unsigned long offset);
+		unsigned long offset)
+{
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+}
 #endif
 
 #ifndef find_next_zero_bit
@@ -42,8 +54,12 @@ extern unsigned long find_next_and_bit(const unsigned long *addr1,
  * Returns the bit number of the next zero bit
  * If no bits are zero, returns @size.
  */
-extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned
-		long size, unsigned long offset);
+static inline
+unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
+				 unsigned long offset)
+{
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+}
 #endif
 
 #ifdef CONFIG_GENERIC_FIND_FIRST_BIT
diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 188d3eba3ace..21305f6cea0b 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_GENERIC_BITOPS_LE_H_
 #define _ASM_GENERIC_BITOPS_LE_H_
 
+#include <asm-generic/bitops/find.h>
 #include <asm/types.h>
 #include <asm/byteorder.h>
 
@@ -32,13 +33,21 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
 #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
 
 #ifndef find_next_zero_bit_le
-extern unsigned long find_next_zero_bit_le(const void *addr,
-		unsigned long size, unsigned long offset);
+static inline
+unsigned long find_next_zero_bit_le(const void *addr, unsigned
+		long size, unsigned long offset)
+{
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+}
 #endif
 
 #ifndef find_next_bit_le
-extern unsigned long find_next_bit_le(const void *addr,
-		unsigned long size, unsigned long offset);
+static inline
+unsigned long find_next_bit_le(const void *addr, unsigned
+		long size, unsigned long offset)
+{
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
+}
 #endif
 
 #ifndef find_first_zero_bit_le
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 8c2a71a18793..2470ae390f3c 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -29,7 +29,7 @@
  *    searching it for one bits.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
-static unsigned long _find_next_bit(const unsigned long *addr1,
+unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, unsigned long le)
 {
@@ -68,37 +68,7 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
 
 	return min(start + __ffs(tmp), nbits);
 }
-#endif
-
-#ifndef find_next_bit
-/*
- * Find the next set bit in a memory region.
- */
-unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
-			    unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
-}
-EXPORT_SYMBOL(find_next_bit);
-#endif
-
-#ifndef find_next_zero_bit
-unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
-				 unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
-}
-EXPORT_SYMBOL(find_next_zero_bit);
-#endif
-
-#if !defined(find_next_and_bit)
-unsigned long find_next_and_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long size,
-		unsigned long offset)
-{
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
-}
-EXPORT_SYMBOL(find_next_and_bit);
+EXPORT_SYMBOL(_find_next_bit);
 #endif
 
 #ifndef find_first_bit
@@ -157,28 +127,6 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 EXPORT_SYMBOL(find_last_bit);
 #endif
 
-#ifdef __BIG_ENDIAN
-
-#ifndef find_next_zero_bit_le
-unsigned long find_next_zero_bit_le(const void *addr, unsigned
-		long size, unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
-}
-EXPORT_SYMBOL(find_next_zero_bit_le);
-#endif
-
-#ifndef find_next_bit_le
-unsigned long find_next_bit_le(const void *addr, unsigned
-		long size, unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
-}
-EXPORT_SYMBOL(find_next_bit_le);
-#endif
-
-#endif /* __BIG_ENDIAN */
-
 unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
 			       unsigned long size, unsigned long offset)
 {
diff --git a/tools/include/asm-generic/bitops/find.h b/tools/include/asm-generic/bitops/find.h
index 16ed1982cb34..9fe62d10b084 100644
--- a/tools/include/asm-generic/bitops/find.h
+++ b/tools/include/asm-generic/bitops/find.h
@@ -2,6 +2,10 @@
 #ifndef _TOOLS_LINUX_ASM_GENERIC_BITOPS_FIND_H_
 #define _TOOLS_LINUX_ASM_GENERIC_BITOPS_FIND_H_
 
+extern unsigned long _find_next_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long nbits,
+		unsigned long start, unsigned long invert, unsigned long le);
+
 #ifndef find_next_bit
 /**
  * find_next_bit - find the next set bit in a memory region
@@ -12,8 +16,12 @@
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
-		size, unsigned long offset);
+static inline
+unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
+			    unsigned long offset)
+{
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
+}
 #endif
 
 #ifndef find_next_and_bit
@@ -27,13 +35,16 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
  */
-extern unsigned long find_next_and_bit(const unsigned long *addr1,
+static inline
+unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
-		unsigned long offset);
+		unsigned long offset)
+{
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
+}
 #endif
 
 #ifndef find_next_zero_bit
-
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
  * @addr: The address to base the search on
@@ -43,8 +54,12 @@ extern unsigned long find_next_and_bit(const unsigned long *addr1,
  * Returns the bit number of the next zero bit
  * If no bits are zero, returns @size.
  */
+static inline
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
-				 unsigned long offset);
+				 unsigned long offset)
+{
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+}
 #endif
 
 #ifndef find_first_bit
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index 49abb18549cc..c3378b291205 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -28,11 +28,12 @@
  *    searching it for one bits.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
-static inline unsigned long _find_next_bit(const unsigned long *addr1,
+unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert)
+		unsigned long start, unsigned long invert, unsigned long le)
 {
-	unsigned long tmp;
+	unsigned long tmp, mask;
+	(void) le;
 
 	if (unlikely(start >= nbits))
 		return nbits;
@@ -43,7 +44,19 @@ static inline unsigned long _find_next_bit(const unsigned long *addr1,
 	tmp ^= invert;
 
 	/* Handle 1st word. */
-	tmp &= BITS_LAST_MASK(start);
+	mask = BITS_LAST_MASK(start);
+
+	/*
+	 * Due to the lack of swab() in tools, and the fact that it doesn't
+	 * need little-endian support, just comment it out
+	 */
+#if (0)
+	if (le)
+		mask = swab(mask);
+#endif
+
+	tmp &= mask;
+
 	start = round_down(start, BITS_PER_LONG);
 
 	while (!tmp) {
@@ -57,18 +70,12 @@ static inline unsigned long _find_next_bit(const unsigned long *addr1,
 		tmp ^= invert;
 	}
 
-	return min(start + __ffs(tmp), nbits);
-}
+#if (0)
+	if (le)
+		tmp = swab(tmp);
 #endif
 
-#ifndef find_next_bit
-/*
- * Find the next set bit in a memory region.
- */
-unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
-			    unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, 0UL);
+	return min(start + __ffs(tmp), nbits);
 }
 #endif
 
@@ -105,20 +112,3 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 	return size;
 }
 #endif
-
-#ifndef find_next_zero_bit
-unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
-				 unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, ~0UL);
-}
-#endif
-
-#ifndef find_next_and_bit
-unsigned long find_next_and_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long size,
-		unsigned long offset)
-{
-	return _find_next_bit(addr1, addr2, size, offset, 0UL);
-}
-#endif
-- 
2.25.1

