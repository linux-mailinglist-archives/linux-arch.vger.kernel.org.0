Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF241F47C
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355733AbhJASOs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355760AbhJASOl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:14:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16365C0613E6;
        Fri,  1 Oct 2021 11:12:52 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h3so10157014pgb.7;
        Fri, 01 Oct 2021 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WUu1xNUjvy4bTpjMlz8H2ANYID2J8eFWxeuve0Yjkwg=;
        b=ov7FJ5YR1prsEmnFcQ2MfOrZC7nXCQOC7+xrjxbOjSYqjHKgX8+bZeprWx2edVP+CR
         su+b1sBF99MqT0vKJHitHx3kdq291vbMm1OyGLacXX+rZ8WDQb5EdfFD1nEQuuktStTm
         ymi0/UzZIKf4ZFoIrDxCH9C8ASEPWOwtdg7i2vaopm8NZcj2m9F8OvDnlq7QlORS4m4h
         +pTuaZZR7TFyTbq2s+MhVajfefi5u+HfAFyeoL8CvUMNteSlSCk1hif22t8XVr/iCh4o
         RZ9+s5HGNIZn6Y9/DxyjMJJU+t61ADt0z7B2l3l+FwaCx/mGGHvMnVrU4Sp5hvqyHzvU
         t4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WUu1xNUjvy4bTpjMlz8H2ANYID2J8eFWxeuve0Yjkwg=;
        b=fDZB3dDL/dIR6uGW4T3ETPlYCsiiGzS5J0Eo2hY4UpbQeeuqYBL9LqM4TLDMw4jz7d
         apLk3Hv71sSlCab6ZIuaIadBlYE1PKgSSDtqbBvbgxx1B4qvI57XeJvvbCKXRQPVMh36
         TpxGXthJa2WzyNir6m1BYkFd2BzGCx6Xf8zG0XNmd7GxVPIsj6ZM9O8QF40wrUpdZyXM
         5R9VcYFtbwnejk/0yrlUI2ToEtDhO/4EWQ1dq39uZAUihUaLtIGqEUUjrOtELl2vn0Ql
         srxdj53Vm5Bbk56MA4DUvAKfuMRhYqBZLZMlbnvXkimNJn+Yjz+F8lS8Mmlvp+kGgmKr
         n9KA==
X-Gm-Message-State: AOAM5329+XYcNkQWld4oj/bNrDhZIsbqEWoIbi/LEHJoavtNVqfFdcLL
        fCqTJEx/emcQQJXybanZhAg=
X-Google-Smtp-Source: ABdhPJzPOcrUNy0gIM6+s0Y8R+3zLTRwfuyQLUBCR2cOIa6VzJ5cL91GoDPT7fH4Q+oHGX1GEd+U4w==
X-Received: by 2002:a62:3383:0:b0:438:4b0d:e50e with SMTP id z125-20020a623383000000b004384b0de50emr11498344pfz.9.1633111971569;
        Fri, 01 Oct 2021 11:12:51 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id q21sm5996000pjg.55.2021.10.01.11.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:12:51 -0700 (PDT)
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
Subject: [PATCH 02/16] bitops: move find_bit_*_le functions from le.h to find.h
Date:   Fri,  1 Oct 2021 11:12:31 -0700
Message-Id: <20211001181245.228419-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181245.228419-1-yury.norov@gmail.com>
References: <20211001181245.228419-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It's convenient to have all find_bit declarations in one place.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
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

