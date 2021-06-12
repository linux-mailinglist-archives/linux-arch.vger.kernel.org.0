Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC833A4ED8
	for <lists+linux-arch@lfdr.de>; Sat, 12 Jun 2021 14:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhFLMjL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhFLMjJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 08:39:09 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B970C0617AF;
        Sat, 12 Jun 2021 05:36:55 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id if15so7189203qvb.2;
        Sat, 12 Jun 2021 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLo8AMaH3b7FNU9Ksmkm4wMJWQ+NEW08cC5d0ZSerjY=;
        b=r3nzXZ9cysfYGfRRpOAK38jEkhDPlM8G0YFVxWiLT6XdOodtAeMvB/d7rAkZu0PVIM
         o3puagCfzwsjV6NM3IcJ0xjZ0yJTzRlIPmxab2GzlMoJZKaUxQISJepocdb10B/xRE+1
         tdP7u/PW1BRe7OGkCHWYEB57MDCWaBmGxY82IyGBNqN4UDtA+V71+ux65CdV2XteOME5
         qLvbgFhQPxxNfj5/0PhycgVg2H70tM1TBzWTjsD4Mui/pu5lYI2JLIGQ967jPW+fC1jg
         OekHf8CHwHX7UqAUtaXBaZYXZj1IJhIat+/MDb5W7AFWi4p//r+Dbx70rC9NnCkfutpL
         omKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLo8AMaH3b7FNU9Ksmkm4wMJWQ+NEW08cC5d0ZSerjY=;
        b=Re5JBcVof0AI3hrtPkw4mTX9BF+/QcLiGVdn+Bv6yWv+xw5+KDebdr9Cft2RFsaO92
         1H1slLy0AZBLHEJcNlz9uzbEdp4LXUzNeEnC3F+QMRAEdUlTKNuK0+MWYz1hCn1om2+t
         F/kyfmtw5bm0hzq8CHUlzMv7OI4yr93pJwVFvSRJdJKAh7TOpP/OMpFeBw97Xqh4Qmfr
         dA3upIjANMAOMKeUrAd0JLgylM33UHY2gqIeu/ptdRDb9MfimaZRVw1fmp7rxhynyhjA
         q9Hc5oHZe0GgI8q66WOsJ8pkX5S20UlqqRuFTN6ExBgOyAQ1uxGgkp2f6+llmwwD+EfP
         QLVg==
X-Gm-Message-State: AOAM530UptafcWMLHQvNzKjqaTqjNx0KMCTgHJIGrvh7JYvNBPDsSy1w
        KTVAyESi/elJiif2U+LQpsZz42MeLlqlhw==
X-Google-Smtp-Source: ABdhPJxPOh8JlG6BJf/SrObCFsvNHUmBeIl1EjiQynSTc+RFlIHAn7MmbQmdZcfpVFvzc49Jn+B1DQ==
X-Received: by 2002:a0c:fa91:: with SMTP id o17mr9585208qvn.36.1623501414110;
        Sat, 12 Jun 2021 05:36:54 -0700 (PDT)
Received: from localhost ([70.127.84.75])
        by smtp.gmail.com with ESMTPSA id e10sm1568357qkg.18.2021.06.12.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:36:53 -0700 (PDT)
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
Subject: [PATCH 8/8] tools: sync tools/bitmap with mother linux
Date:   Sat, 12 Jun 2021 05:36:39 -0700
Message-Id: <20210612123639.329047-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210612123639.329047-1-yury.norov@gmail.com>
References: <20210612123639.329047-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove tools/include/asm-generic/bitops/find.h and copy
include/linux/bitmap.h to tools. find_*_le() functions are not copied
because not needed in tools.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS                                   |  2 +-
 tools/include/asm-generic/bitops.h            |  1 -
 tools/include/linux/bitmap.h                  |  7 +-
 .../{asm-generic/bitops => linux}/find.h      | 81 +++++++++++++++++--
 tools/lib/find_bit.c                          | 20 +++++
 5 files changed, 100 insertions(+), 11 deletions(-)
 rename tools/include/{asm-generic/bitops => linux}/find.h (63%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c648c18c567..63e81fbb59c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3232,8 +3232,8 @@ F:	lib/bitmap.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
 F:	lib/test_bitmap.c
-F:	tools/include/asm-generic/bitops/find.h
 F:	tools/include/linux/bitmap.h
+F:	tools/include/linux/find.h
 F:	tools/lib/bitmap.c
 F:	tools/lib/find_bit.c
 
diff --git a/tools/include/asm-generic/bitops.h b/tools/include/asm-generic/bitops.h
index 5d2ab38965cc..9ab313e93555 100644
--- a/tools/include/asm-generic/bitops.h
+++ b/tools/include/asm-generic/bitops.h
@@ -18,7 +18,6 @@
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
-#include <asm-generic/bitops/find.h>
 
 #ifndef _TOOLS_LINUX_BITOPS_H_
 #error only <linux/bitops.h> can be included directly
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 330dbf7509cc..9d136fc9a8c8 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -1,9 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _PERF_BITOPS_H
-#define _PERF_BITOPS_H
+#ifndef _TOOLS_LINUX_BITMAP_H
+#define _TOOLS_LINUX_BITMAP_H
 
 #include <string.h>
 #include <linux/bitops.h>
+#include <linux/find.h>
 #include <stdlib.h>
 #include <linux/kernel.h>
 
@@ -170,4 +171,4 @@ static inline int bitmap_equal(const unsigned long *src1,
 	return __bitmap_equal(src1, src2, nbits);
 }
 
-#endif /* _PERF_BITOPS_H */
+#endif /* _TOOLS_LINUX_BITMAP_H */
diff --git a/tools/include/asm-generic/bitops/find.h b/tools/include/linux/find.h
similarity index 63%
rename from tools/include/asm-generic/bitops/find.h
rename to tools/include/linux/find.h
index 6481fd11012a..47e2bd6c5174 100644
--- a/tools/include/asm-generic/bitops/find.h
+++ b/tools/include/linux/find.h
@@ -1,11 +1,19 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _TOOLS_LINUX_ASM_GENERIC_BITOPS_FIND_H_
-#define _TOOLS_LINUX_ASM_GENERIC_BITOPS_FIND_H_
+#ifndef _TOOLS_LINUX_FIND_H_
+#define _TOOLS_LINUX_FIND_H_
+
+#ifndef _TOOLS_LINUX_BITMAP_H
+#error tools: only <linux/bitmap.h> can be included directly
+#endif
+
+#include <linux/bitops.h>
 
 extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, unsigned long le);
 extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
+extern unsigned long _find_first_and_bit(const unsigned long *addr1,
+					 const unsigned long *addr2, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
 extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
@@ -96,7 +104,6 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 #endif
 
 #ifndef find_first_bit
-
 /**
  * find_first_bit - find the first set bit in a memory region
  * @addr: The address to start the search at
@@ -116,11 +123,34 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 
 	return _find_first_bit(addr, size);
 }
+#endif
+
+#ifndef find_first_and_bit
+/**
+ * find_first_and_bit - find the first set bit in both memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
+ */
+static inline
+unsigned long find_first_and_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & *addr2 & GENMASK(size - 1, 0);
 
-#endif /* find_first_bit */
+		return val ? __ffs(val) : size;
+	}
 
-#ifndef find_first_zero_bit
+	return _find_first_and_bit(addr1, addr2, size);
+}
+#endif
 
+#ifndef find_first_zero_bit
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
  * @addr: The address to start the search at
@@ -142,4 +172,43 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
-#endif /*_TOOLS_LINUX_ASM_GENERIC_BITOPS_FIND_H_ */
+#ifndef find_last_bit
+/**
+ * find_last_bit - find the last set bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The number of bits to search
+ *
+ * Returns the bit number of the last set bit, or size.
+ */
+static inline
+unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr & GENMASK(size - 1, 0);
+
+		return val ? __fls(val) : size;
+	}
+
+	return _find_last_bit(addr, size);
+}
+#endif
+
+/**
+ * find_next_clump8 - find next 8-bit clump with set bits in a memory region
+ * @clump: location to store copy of found clump
+ * @addr: address to base the search on
+ * @size: bitmap size in number of bits
+ * @offset: bit offset at which to start searching
+ *
+ * Returns the bit offset for the next set clump; the found clump value is
+ * copied to the location pointed by @clump. If no bits are set, returns @size.
+ */
+extern unsigned long find_next_clump8(unsigned long *clump,
+				      const unsigned long *addr,
+				      unsigned long size, unsigned long offset);
+
+#define find_first_clump8(clump, bits, size) \
+	find_next_clump8((clump), (bits), (size), 0)
+
+
+#endif /*__LINUX_FIND_H_ */
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index 109aa7ffcf97..ba4b8d94e004 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -96,6 +96,26 @@ unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
+#ifndef find_first_and_bit
+/*
+ * Find the first set bit in two memory regions.
+ */
+unsigned long _find_first_and_bit(const unsigned long *addr1,
+				  const unsigned long *addr2,
+				  unsigned long size)
+{
+	unsigned long idx, val;
+
+	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
+		val = addr1[idx] & addr2[idx];
+		if (val)
+			return min(idx * BITS_PER_LONG + __ffs(val), size);
+	}
+
+	return size;
+}
+#endif
+
 #ifndef find_first_zero_bit
 /*
  * Find the first cleared bit in a memory region.
-- 
2.30.2

