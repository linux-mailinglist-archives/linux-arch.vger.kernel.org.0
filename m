Return-Path: <linux-arch+bounces-12415-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C978CAE19D3
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 13:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37F94A76F7
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0C289E23;
	Fri, 20 Jun 2025 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Iw3qpn4k"
X-Original-To: linux-arch@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69EF1401B;
	Fri, 20 Jun 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418215; cv=none; b=PkoNlcc7GFw9UE96fS76QFhHtYx7ro1ledUyBYzkcUdJWxy6GiCOlCKKv3qRWKJ464b3cInK/VlToWnaVpifjxi9m1mDkShs0WlbNP0ZObBRwU3OSE8eJNUkt9alctCVwzKn1Z98T5xItmG8QkbmztCrA9xjB+k1NZl7EEps4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418215; c=relaxed/simple;
	bh=K2Jgo87dju4cELFCO0kw97qvHx35oB6UJuzlYL2k15U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvKt8MhhhvrbNZYRyJ3dsDaKPTmsfaNBt+3nuGWwf1h1vI22KNTJ3vsMvbvGwFVoJ/BYt9OfBXRN8QX/lsjNKXimwBTT320pWxerMGV6XJfwoyw9vL2hLTZ7JSw2kBWz2uSgdJf3eerQ+gLLzpN1vezfMM+v9peSkIGGT+IbCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Iw3qpn4k; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750418210; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+lnOL77aXhqazlnRRdN1jhJKODwRdDKGIkoGxnroMu0=;
	b=Iw3qpn4kHN7AGq++S/7Z/MmefhqDGX7UpfinwAMww7K7l2vS10ETKBnLmNABQ45Z6/yLUMe1ddwQ3zOkVLtXSrBGgRxg/9w3NdTrAa77tTntPDhbZpo8ARl0MJUkMFRRzkUXMut+XSqgrDfA2PAJ5qHDzreVkWAyJFY1PgX1Cpc=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WeKdQKG_1750418202 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Jun 2025 19:16:50 +0800
From: cp0613@linux.alibaba.com
To: yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	arnd@arndb.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH 1/2] bitops: generic rotate
Date: Fri, 20 Jun 2025 19:16:09 +0800
Message-ID: <20250620111610.52750-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620111610.52750-1-cp0613@linux.alibaba.com>
References: <20250620111610.52750-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

This patch introduces a generic bitops rotate implementation that moves
the ror* and rol* functions from include/linux/bitops.h.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 include/asm-generic/bitops.h        |  2 +-
 include/asm-generic/bitops/rotate.h | 98 +++++++++++++++++++++++++++++
 include/linux/bitops.h              | 80 -----------------------
 tools/include/asm-generic/bitops.h  |  2 +-
 4 files changed, 100 insertions(+), 82 deletions(-)
 create mode 100644 include/asm-generic/bitops/rotate.h

diff --git a/include/asm-generic/bitops.h b/include/asm-generic/bitops.h
index a47b8a71d6fe..8f30aac8325c 100644
--- a/include/asm-generic/bitops.h
+++ b/include/asm-generic/bitops.h
@@ -29,7 +29,7 @@
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
-
+#include <asm-generic/bitops/rotate.h>
 #include <asm-generic/bitops/atomic.h>
 #include <asm-generic/bitops/non-atomic.h>
 #include <asm-generic/bitops/le.h>
diff --git a/include/asm-generic/bitops/rotate.h b/include/asm-generic/bitops/rotate.h
new file mode 100644
index 000000000000..65449fefb402
--- /dev/null
+++ b/include/asm-generic/bitops/rotate.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_BITOPS_ROTATE_H_
+#define _ASM_GENERIC_BITOPS_ROTATE_H_
+
+#include <asm/types.h>
+
+/**
+ * generic_rol64 - rotate a 64-bit value left
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static __always_inline u64 generic_rol64(u64 word, unsigned int shift)
+{
+	return (word << (shift & 63)) | (word >> ((-shift) & 63));
+}
+
+/**
+ * generic_ror64 - rotate a 64-bit value right
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static __always_inline u64 generic_ror64(u64 word, unsigned int shift)
+{
+	return (word >> (shift & 63)) | (word << ((-shift) & 63));
+}
+
+/**
+ * generic_rol32 - rotate a 32-bit value left
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static __always_inline u32 generic_rol32(u32 word, unsigned int shift)
+{
+	return (word << (shift & 31)) | (word >> ((-shift) & 31));
+}
+
+/**
+ * generic_ror32 - rotate a 32-bit value right
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static __always_inline u32 generic_ror32(u32 word, unsigned int shift)
+{
+	return (word >> (shift & 31)) | (word << ((-shift) & 31));
+}
+
+/**
+ * generic_rol16 - rotate a 16-bit value left
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static __always_inline u16 generic_rol16(u16 word, unsigned int shift)
+{
+	return (word << (shift & 15)) | (word >> ((-shift) & 15));
+}
+
+/**
+ * generic_ror16 - rotate a 16-bit value right
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static __always_inline u16 generic_ror16(u16 word, unsigned int shift)
+{
+	return (word >> (shift & 15)) | (word << ((-shift) & 15));
+}
+
+/**
+ * generic_rol8 - rotate an 8-bit value left
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static __always_inline u8 generic_rol8(u8 word, unsigned int shift)
+{
+	return (word << (shift & 7)) | (word >> ((-shift) & 7));
+}
+
+/**
+ * generic_ror8 - rotate an 8-bit value right
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static __always_inline u8 generic_ror8(u8 word, unsigned int shift)
+{
+	return (word >> (shift & 7)) | (word << ((-shift) & 7));
+}
+
+#ifndef __HAVE_ARCH_ROTATE
+#define rol64(word, shift) generic_rol64(word, shift)
+#define ror64(word, shift) generic_ror64(word, shift)
+#define rol32(word, shift) generic_rol32(word, shift)
+#define ror32(word, shift) generic_ror32(word, shift)
+#define rol16(word, shift) generic_rol16(word, shift)
+#define ror16(word, shift) generic_ror16(word, shift)
+#define rol8(word, shift)  generic_rol8(word, shift)
+#define ror8(word, shift)  generic_ror8(word, shift)
+#endif
+
+#endif /* _ASM_GENERIC_BITOPS_ROTATE_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index c1cb53cf2f0f..1f8ef472cfb3 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -97,86 +97,6 @@ static __always_inline unsigned long hweight_long(unsigned long w)
 	return sizeof(w) == 4 ? hweight32(w) : hweight64((__u64)w);
 }
 
-/**
- * rol64 - rotate a 64-bit value left
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u64 rol64(__u64 word, unsigned int shift)
-{
-	return (word << (shift & 63)) | (word >> ((-shift) & 63));
-}
-
-/**
- * ror64 - rotate a 64-bit value right
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u64 ror64(__u64 word, unsigned int shift)
-{
-	return (word >> (shift & 63)) | (word << ((-shift) & 63));
-}
-
-/**
- * rol32 - rotate a 32-bit value left
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u32 rol32(__u32 word, unsigned int shift)
-{
-	return (word << (shift & 31)) | (word >> ((-shift) & 31));
-}
-
-/**
- * ror32 - rotate a 32-bit value right
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u32 ror32(__u32 word, unsigned int shift)
-{
-	return (word >> (shift & 31)) | (word << ((-shift) & 31));
-}
-
-/**
- * rol16 - rotate a 16-bit value left
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u16 rol16(__u16 word, unsigned int shift)
-{
-	return (word << (shift & 15)) | (word >> ((-shift) & 15));
-}
-
-/**
- * ror16 - rotate a 16-bit value right
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u16 ror16(__u16 word, unsigned int shift)
-{
-	return (word >> (shift & 15)) | (word << ((-shift) & 15));
-}
-
-/**
- * rol8 - rotate an 8-bit value left
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u8 rol8(__u8 word, unsigned int shift)
-{
-	return (word << (shift & 7)) | (word >> ((-shift) & 7));
-}
-
-/**
- * ror8 - rotate an 8-bit value right
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u8 ror8(__u8 word, unsigned int shift)
-{
-	return (word >> (shift & 7)) | (word << ((-shift) & 7));
-}
-
 /**
  * sign_extend32 - sign extend a 32-bit value using specified bit as sign-bit
  * @value: value to sign extend
diff --git a/tools/include/asm-generic/bitops.h b/tools/include/asm-generic/bitops.h
index 9ab313e93555..bfa06c6babe3 100644
--- a/tools/include/asm-generic/bitops.h
+++ b/tools/include/asm-generic/bitops.h
@@ -24,7 +24,7 @@
 #endif
 
 #include <asm-generic/bitops/hweight.h>
-
+#include <asm-generic/bitops/rotate.h>
 #include <asm-generic/bitops/atomic.h>
 #include <asm-generic/bitops/non-atomic.h>
 
-- 
2.49.0


