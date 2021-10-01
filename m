Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2C041F471
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355743AbhJASO3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355714AbhJASOS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:14:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B5AC061775;
        Fri,  1 Oct 2021 11:12:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id om12-20020a17090b3a8c00b0019eff43daf5so7743871pjb.4;
        Fri, 01 Oct 2021 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WUu1xNUjvy4bTpjMlz8H2ANYID2J8eFWxeuve0Yjkwg=;
        b=H4PsUYV6RAHW48Rw+UHHaTvyS6zRnXITpO8rNyFD7etwt7OuLkkNovh0uCSvNiSQwk
         o0Tckxn0YIPr4eQc9N3Ey/DgRMh/us1zRKEPWm/ovaeCUb6GUxXgmG6yOQ/y+1SwFvgz
         aQ6WWNaqCjKsaLqxkrUXj1v0BB882G2ccIPMMR49e7JH19zSgKrj/jL31W2FPsdJNJdT
         bQm5YJ7T6aRkl5uTuCEiDHDSiyCWXRE5GCsL03ESsMuMInIMRO1w9mHQt1xZ55aU8mXy
         k1P2L9XNQfsf/iNSFHD+NvmwiUdeYD5VnRVqZLYghH6FSsjUQEF52gPUbogJZUIxm3z3
         YX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WUu1xNUjvy4bTpjMlz8H2ANYID2J8eFWxeuve0Yjkwg=;
        b=GorxL5GEGMoHuItKMYtjDUe+d9t6dhBoASQURpXCXeuJGIYj5L1+kUOHBxWnVyGFR/
         bp9Q34Eth3xYJWfb1n2iv7n5NmOUHF3WquLeQhnV3BNq5pSbZz0FB7Xa63hrTDupDhtx
         7OB1xRtK45BWCLz3Pji6rwMHEFEQRF1jrftBzypPwEdZ8IuyRgCzWNBJgEI/+sL8z75a
         jYGSfD8en1EfyYZM54q46o/wQthD1RhGwJ0M9ct6vXXZ7cRwAQP7tJT18CpzSQsvuV0U
         1PFZZKNYH8GD39/nSa6XFkYm8zRh1+JqRBnIMy5/O/vZvzPtlR3yi9eLnH0X7xN/QrjH
         6LlQ==
X-Gm-Message-State: AOAM532O4eH1JIWeMYLJbfI5xx+IRS6uIDcvheYGl1s2JGaMtcGFCSSi
        H9JVFpv3EeVsZcQqPvHZ8Ns=
X-Google-Smtp-Source: ABdhPJx68GagNvIFdEzuHAjeFvCpJR+Dpa4SQa4e6cJkqEwHLphXqCkwwSCaR4f+RJe49e4s8XN0yA==
X-Received: by 2002:a17:902:6508:b0:13e:77cd:a2fa with SMTP id b8-20020a170902650800b0013e77cda2famr7874926plk.69.1633111953781;
        Fri, 01 Oct 2021 11:12:33 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id d24sm6730470pfn.62.2021.10.01.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:12:33 -0700 (PDT)
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
Date:   Fri,  1 Oct 2021 11:12:12 -0700
Message-Id: <20211001181226.228340-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001181226.228340-1-yury.norov@gmail.com>
References: <20211001181226.228340-1-yury.norov@gmail.com>
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

