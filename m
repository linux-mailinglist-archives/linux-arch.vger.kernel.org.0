Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E07343525
	for <lists+linux-arch@lfdr.de>; Sun, 21 Mar 2021 22:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhCUVzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Mar 2021 17:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhCUVzI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Mar 2021 17:55:08 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4998C061762;
        Sun, 21 Mar 2021 14:55:07 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x14so8742734qki.10;
        Sun, 21 Mar 2021 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwA2cUb85T9JjpQPbY/6COGL/CUriqATjd8tfCcmoPM=;
        b=JbAfXjtAe15y1kS+7IaFTggfvujveF1cK3f5jZxEldzZ/m1Ho4Q9YknDuSePA4G8/D
         uTFhF/CviVNAYxBHcidYUsuJBQBCEfRVMSREyXI5UteU1kRyHsYozRkz+bluzvYq1qbF
         AwMBmIGFPF1K9eAoqUE4trcGPyicePZw3GGMqZE7NYRyJkXXE0KlybIDoVudFw35ftjw
         tfO9e+mlEQ/R+n/zlr6Il0wLAhA3NFaDcJgSF+OuRAZ+pQY/ZpnMmlPfrzrPH7oX5Q+M
         M9mwBA15z4/lo7hdvpJV4No7VfTs1NCyPXI98PWHDEKjcpztr/7dsup6/Q9I/FsO0UH3
         Kt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwA2cUb85T9JjpQPbY/6COGL/CUriqATjd8tfCcmoPM=;
        b=QKic8S+Ke9pq7xa92zusiPySgQjnOzgGOEqwTQRb7gKJX4PAiXZcV2hhqaFkIO6YGy
         XHJFtquRX8Y0S+8D6XAU7q1a4xmsfHkoxCkZc7rVc8tchFBly3s8dw7rrGP0ut+Vyr+X
         kHwpehJHQ9XZdbW1yjJxBLaJRQd7HpMgGKbUYb2Rwuw3buIYcmp0KtvAVGqq2t/yH/SY
         04IHLTysmMKKuo/zadKdPfBzHKkm31A6d55jbmjb5x/PdMQBfLS0zkVTxyCxRvlrT3Nk
         yEgObdvL7zigVBA2MfQBwbJ8ensvi4VyrWRp0I+3KbPTm52t16mr0bi1mXeRiY63Ki5+
         Nhtw==
X-Gm-Message-State: AOAM531mqVKi3Z0YXqKXI+lf+DowDJ9cXHNQ739aqS7trDa240q64M8n
        gVXSZu2JARuFhbTfyKUb0AWefi1JLFI=
X-Google-Smtp-Source: ABdhPJxafm3glUkN+Jtk/wdMbfHF2M33p0SM3wF5hFkI6KCIrWJUzhkvYqpTPQLDwVzOpRuRDHwNmQ==
X-Received: by 2002:a37:6115:: with SMTP id v21mr8399368qkb.239.1616363706780;
        Sun, 21 Mar 2021 14:55:06 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id w6sm7894605qtt.96.2021.03.21.14.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 14:55:06 -0700 (PDT)
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
Subject: [PATCH 07/12] lib: inline _find_next_bit() wrappers
Date:   Sun, 21 Mar 2021 14:54:52 -0700
Message-Id: <20210321215457.588554-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321215457.588554-1-yury.norov@gmail.com>
References: <20210321215457.588554-1-yury.norov@gmail.com>
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

