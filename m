Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0603A4ED0
	for <lists+linux-arch@lfdr.de>; Sat, 12 Jun 2021 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFLMir (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 08:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhFLMiq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 08:38:46 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65950C061767;
        Sat, 12 Jun 2021 05:36:47 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i67so33865467qkc.4;
        Sat, 12 Jun 2021 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DE2uGcyognsqUK5a+kjmtRMZ8LKRFECrTdhcl5wHUr4=;
        b=fPGyp/0CsGrCUzL9sGvIJoeG5Rqa7rPCpjv7jS6jio5vxLpXLrhUdUfrMxQ32QAQr5
         PJ/ydOqx2ukNEEgk172VfvkBcO+DhdLImMJ5wNAU5c0lsvRxnc6Yk6y3T17DBk6jFzgO
         2RM7DiLV65iKK/sxvDUVknIYz7NdrgnijkckuR6Rsf+rt4qucj6IQqeUkaJiunZS1z3Y
         9DbuXGQFbj92T7CDoNy/7hXV5K1jokKsM18/lFdKXnqdZtDKwcjzNCbS52fLJSrc9Gfb
         SvgTPQIEzPk/0+YUUSlpU7nAWAQZ1tIUoMOjqUizlJ2pC7y+pmEQPfMVN0uI6C4kor4A
         g6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DE2uGcyognsqUK5a+kjmtRMZ8LKRFECrTdhcl5wHUr4=;
        b=r/30DyAFl4jN27g507+mkL9GqsSzJLWl3N6oBtZG3Kwls5NxSJQpIDKPK5X9eQarBW
         SD+NIPH0tcfuXbruDJn5pNCA+bns3T8JANu3wVksJCR8hOGa6yEFNMuFnUMRJ83fQhNr
         k9r2JQPZ/alKxthUBrrFxhMI7vY7Eu3VttI417OTBti7h4wqXvCTVHgibtzU032QITCF
         AvXWYz/jt9Z4u2WSGOzxE3TO80ZLZFlu2d4Q0tPJDvYlnBmz2TxoRzsXMXw4tonExCgF
         BtmhPUbJ5n58JFLTJ8s+BXuKXLOqoeVyIVvpPx8p6pEgrXqCC0+fa23Xec0Yc4OSgoIW
         xCRQ==
X-Gm-Message-State: AOAM533vAZGaebNu7uzPOnHJBktWndUGzlm0reBpyyFJFF3S3yxM/U8J
        yM5tpoJ1w+u74asnOD39GlakDKzor/TDZg==
X-Google-Smtp-Source: ABdhPJye1XAZdtRzrrOjvaCMTUDkGmX8khjv+qzUZKq4Op5+wwRBcpQNf1nnC4NtJR5UBBq+gwVJCQ==
X-Received: by 2002:a37:6084:: with SMTP id u126mr8358831qkb.294.1623501406350;
        Sat, 12 Jun 2021 05:36:46 -0700 (PDT)
Received: from localhost ([70.127.84.75])
        by smtp.gmail.com with ESMTPSA id y195sm204067qkb.69.2021.06.12.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:36:45 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/8] bitops: move find_bit_*_le functions from le.h to find.h
Date:   Sat, 12 Jun 2021 05:36:33 -0700
Message-Id: <20210612123639.329047-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210612123639.329047-1-yury.norov@gmail.com>
References: <20210612123639.329047-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It's convenient to have all find_bit declarations in one place.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitops/find.h | 69 +++++++++++++++++++++++++++++++
 include/asm-generic/bitops/le.h   | 64 ----------------------------
 2 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 835f959a25f2..91b1b23f2b0c 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -190,4 +190,73 @@ extern unsigned long find_next_clump8(unsigned long *clump,
 #define find_first_clump8(clump, bits, size) \
 	find_next_clump8((clump), (bits), (size), 0)
 
+#if defined(__LITTLE_ENDIAN)
+
+static inline unsigned long find_next_zero_bit_le(const void *addr,
+		unsigned long size, unsigned long offset)
+{
+	return find_next_zero_bit(addr, size, offset);
+}
+
+static inline unsigned long find_next_bit_le(const void *addr,
+		unsigned long size, unsigned long offset)
+{
+	return find_next_bit(addr, size, offset);
+}
+
+static inline unsigned long find_first_zero_bit_le(const void *addr,
+		unsigned long size)
+{
+	return find_first_zero_bit(addr, size);
+}
+
+#elif defined(__BIG_ENDIAN)
+
+#ifndef find_next_zero_bit_le
+static inline
+unsigned long find_next_zero_bit_le(const void *addr, unsigned
+		long size, unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *(const unsigned long *)addr;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = swab(val) | ~GENMASK(size - 1, offset);
+		return val == ~0UL ? size : ffz(val);
+	}
+
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+}
+#endif
+
+#ifndef find_next_bit_le
+static inline
+unsigned long find_next_bit_le(const void *addr, unsigned
+		long size, unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *(const unsigned long *)addr;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = swab(val) & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
+}
+#endif
+
+#ifndef find_first_zero_bit_le
+#define find_first_zero_bit_le(addr, size) \
+	find_next_zero_bit_le((addr), (size), 0)
+#endif
+
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 5a28629cbf4d..d51beff60375 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -2,83 +2,19 @@
 #ifndef _ASM_GENERIC_BITOPS_LE_H_
 #define _ASM_GENERIC_BITOPS_LE_H_
 
-#include <asm-generic/bitops/find.h>
 #include <asm/types.h>
 #include <asm/byteorder.h>
-#include <linux/swab.h>
 
 #if defined(__LITTLE_ENDIAN)
 
 #define BITOP_LE_SWIZZLE	0
 
-static inline unsigned long find_next_zero_bit_le(const void *addr,
-		unsigned long size, unsigned long offset)
-{
-	return find_next_zero_bit(addr, size, offset);
-}
-
-static inline unsigned long find_next_bit_le(const void *addr,
-		unsigned long size, unsigned long offset)
-{
-	return find_next_bit(addr, size, offset);
-}
-
-static inline unsigned long find_first_zero_bit_le(const void *addr,
-		unsigned long size)
-{
-	return find_first_zero_bit(addr, size);
-}
-
 #elif defined(__BIG_ENDIAN)
 
 #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
 
-#ifndef find_next_zero_bit_le
-static inline
-unsigned long find_next_zero_bit_le(const void *addr, unsigned
-		long size, unsigned long offset)
-{
-	if (small_const_nbits(size)) {
-		unsigned long val = *(const unsigned long *)addr;
-
-		if (unlikely(offset >= size))
-			return size;
-
-		val = swab(val) | ~GENMASK(size - 1, offset);
-		return val == ~0UL ? size : ffz(val);
-	}
-
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
-}
-#endif
-
-#ifndef find_next_bit_le
-static inline
-unsigned long find_next_bit_le(const void *addr, unsigned
-		long size, unsigned long offset)
-{
-	if (small_const_nbits(size)) {
-		unsigned long val = *(const unsigned long *)addr;
-
-		if (unlikely(offset >= size))
-			return size;
-
-		val = swab(val) & GENMASK(size - 1, offset);
-		return val ? __ffs(val) : size;
-	}
-
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
-}
 #endif
 
-#ifndef find_first_zero_bit_le
-#define find_first_zero_bit_le(addr, size) \
-	find_next_zero_bit_le((addr), (size), 0)
-#endif
-
-#else
-#error "Please fix <asm/byteorder.h>"
-#endif
 
 static inline int test_bit_le(int nr, const void *addr)
 {
-- 
2.30.2

