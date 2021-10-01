Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377C841F49E
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355798AbhJASPR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355831AbhJASO4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:14:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B41C0613E9;
        Fri,  1 Oct 2021 11:13:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t4so6861154plo.0;
        Fri, 01 Oct 2021 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5B/I0Xe9HMRYD3b4tnVSfUGdA9D9n8WqulexMqR4aY=;
        b=bUc33umft6MuWrYPRT5FMslyaAynQOUh3+pp5WwjGOadPJB/tC5Qnre4GA+C83AthV
         HSDvF3h22/MNxKNPPEYOFMSQ1UBRAuaiPagnoxUwByVCRzmNb+5CyPew+VNoHIH5wqKD
         qHB3wcvDQSjOX9JLb14TGoMjCSPVsJguAwO1/jdX81eWYgFY34h6eBJgObrQAK9+7R18
         Bp0tC9pZgKxICQOUKJG6kZFSSNepRxPxZLLrVUame3GmJaatWvCVkPjnlp8nirb4Zgn9
         nDlrEjG61VApPbT21d0seGk6RuW9SZQlNgIM/AlkoJzMyOYmtrrUXRp5sQQsxaCSFgf6
         VQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5B/I0Xe9HMRYD3b4tnVSfUGdA9D9n8WqulexMqR4aY=;
        b=bOjZfupeohG1LoHrtjeWplpuFRgGLCG4MYyqnSBZknn/dTOH2yB40t/YlG63jfY4/p
         wYTBZOk3e6Ha9MBQHeEKrDiJTLKHJdedr3QLHRqun6FlyeWtntYPO7oXOC7zkxUpjjN0
         rwqIcY321yngZqCg97siyss53TGbMwYQNFkiKppnfAK1FcAtGKxcJPI6THDS99qvUSFe
         cDccfiHIi7/eDYTf07npugMDx5zWz6WsH12faLzn5dyyh0UNYIV7j1H8czDuQP4zJ4PU
         j4MxTEHkyVZcU6NjYbLjiS9YzWP4RXmglgg2CzvXNeHHeB6Sc/IvorCbGLRzRuimUdYh
         v1TQ==
X-Gm-Message-State: AOAM530opkHJ+sc3K3rvGgiHUQOWKTlsiGCaZLht7OUxH+utNPOL59+d
        g5yVyyXIVwAdG8eRwKbUFDI=
X-Google-Smtp-Source: ABdhPJy9PIhO7F65MXCLRmg/xrOep8WqEk2JWBCaDV1bOzenRvbf0I00j8t3WnF4awKcnz1pft8Wvw==
X-Received: by 2002:a17:90a:8912:: with SMTP id u18mr14404434pjn.69.1633111991232;
        Fri, 01 Oct 2021 11:13:11 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id e11sm6831323pfm.79.2021.10.01.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:13:10 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Joe Perches <joe@perches.com>, Jonas Bonn <jonas@southpole.se>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Sean Christopherson <seanjc@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 08/16] tools: sync tools/bitmap with mother linux
Date:   Fri,  1 Oct 2021 11:12:37 -0700
Message-Id: <20211001181245.228419-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove tools/include/asm-generic/bitops/find.h and copy
include/linux/bitmap.h to tools. find_*_le() functions are not copied
because not needed in tools.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 MAINTAINERS                                   |  2 +-
 tools/include/asm-generic/bitops.h            |  1 -
 tools/include/linux/bitmap.h                  |  7 +-
 .../{asm-generic/bitops => linux}/find.h      | 81 +++++++++++++++++--
 tools/lib/find_bit.c                          | 20 +++++
 5 files changed, 100 insertions(+), 11 deletions(-)
 rename tools/include/{asm-generic/bitops => linux}/find.h (63%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 181139d30068..4409a57a40a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3314,8 +3314,8 @@ F:	lib/bitmap.c
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
index 95611df1d26e..ea97804d04d4 100644
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
 
@@ -181,4 +182,4 @@ static inline int bitmap_intersects(const unsigned long *src1,
 		return __bitmap_intersects(src1, src2, nbits);
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

