Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C919350B38
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 02:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhDAAcg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 20:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhDAAcE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 20:32:04 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C95C06175F;
        Wed, 31 Mar 2021 17:32:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g24so344538qts.6;
        Wed, 31 Mar 2021 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Naq2YdkB33IglaRqzqhD+H/Ale9mfBPeXRg3K8w8rQ=;
        b=YosBgUnJvIjZ9FCX/OL2h1nsM7Vt2iprWfWGsKn3or2M4nu9bl1dUWFmjzcrxK3aXP
         gQW9+0huTcs3NFQ1b7XzMb7pwOBgn0Vy3gSRa1VdpmTURzWR0BC5HRZ67BMPPQs7BE47
         wQ4IzH0uoAt0bpX+ISq/ekgaa4y6jsuRdKFm4qYsuFasTdISUqEIGF+fK6ZLE8K05scT
         4Kkdbn68DHuA40IgiuL/cFzVjh/MndwPa46VtbLBTB1JpnRvbuECYyoO2c5ClM94CzE8
         PrBRBGLiw1VY7LM0qddn93DjRgla4/rpregMcg0enqP3zXFjzDf3w6+Uc7/Fq9vZkbvO
         dnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Naq2YdkB33IglaRqzqhD+H/Ale9mfBPeXRg3K8w8rQ=;
        b=KpheTIaGdnehxDlmsItIYNkZURQ988F+A9ClYZ8Jp6/MbCA78bG7A3o21bx/W3Gs7u
         ZRfnf4iPbKQQFWoVsNl4FnhD1IrIudKEqomJJcpipspsPj28bag1o/zB1MUcqpXegSt/
         osjDEy8EkVFVkeLg1SVH1RgFWL1UEFeMqjXQ0GwyLaKA/8z4gD9uTnwv9ecPV97qu8go
         cYrX+cbeZ/dnpw2hg6VtN1BXzVzI8QpYQhzbPdpYZ0w0w9ATC1yQr+MgQKsULajrF92h
         n9Y2zs4EVE2LZoisPssAldbPk9fdkiSjCDAjWULsPaj/CdX+D0WWQ8r3WktgFEV4I+qk
         XOWg==
X-Gm-Message-State: AOAM532zNP0wE/YCKsiv9MUnVWuasDtNTWjmpVJiHpC357O19O3QxE3H
        kWB5QvYYVzhkJzUZohmwxBp2/Q8jQhHWig==
X-Google-Smtp-Source: ABdhPJw+eVKfUYr0p5B+r2h0XmFjPL9498D7q0LJ06PuYKAdYHNPtzHi7BfN2vK2V0M06KlsMq565w==
X-Received: by 2002:ac8:43c5:: with SMTP id w5mr5100397qtn.334.1617237123406;
        Wed, 31 Mar 2021 17:32:03 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id b17sm2366559qtp.73.2021.03.31.17.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:32:03 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
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
Subject: [PATCH 07/12] lib: inline _find_next_bit() wrappers
Date:   Wed, 31 Mar 2021 17:31:48 -0700
Message-Id: <20210401003153.97325-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

lib/find_bit.c declares five single-line wrappers for _find_next_bit().
We may turn those wrappers to inline functions. It eliminates unneeded
function calls and opens room for compile-time optimizations.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/bitops/find.h | 28 ++++++++++++----
 include/asm-generic/bitops/le.h   | 17 +++++++---
 lib/find_bit.c                    | 56 ++-----------------------------
 3 files changed, 37 insertions(+), 64 deletions(-)

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
index f67f86fd2f62..b03a101367f8 100644
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
-- 
2.25.1

