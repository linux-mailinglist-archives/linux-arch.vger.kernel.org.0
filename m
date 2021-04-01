Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D214D350B3E
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 02:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhDAAci (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 20:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhDAAcI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 20:32:08 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073F2C06175F;
        Wed, 31 Mar 2021 17:32:08 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id q12so241777qvc.8;
        Wed, 31 Mar 2021 17:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxk1x20X1hnopKqSpU5fRPKa2nNYpg8SC0ATwCXnGOY=;
        b=iDfEDccou2dL1t8r+QrK51cNoAiX2OPuSvlEnLZt0B5H9AhOq6m9oMKC3Uv66Vpcf2
         0hrWbZRruD+S3pM5H2DwjUde2HSbaiR+APtwrBWyznYUDiBgGup7Jk9fir96Iuems0uc
         aPE6Ai5CGAz4OjaFVLrNMV5gmEil/+HIb0VrrTJpQQfZHOGrbrZ4NvOv+mHCrsyd0nlA
         Dgc1leIrFmLN/tZCC75I1QiqjRAXQotUvMEst1oaZZAnJ3Bgs6RuR21pI2QXgoJyf7jC
         jdZDYUNBc1XZx+dFnksdby4Asc9/MO1gOB56oF2dppQ0GLuShjYxgVqCO5I38YA6vYs+
         le0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxk1x20X1hnopKqSpU5fRPKa2nNYpg8SC0ATwCXnGOY=;
        b=YjnEyYblr28V24mCP+gxkdxxUhCwXN+SK89tPvCXuxgnwiry4LjTmBu0eTkLoU6mxE
         HMl8txQre8HwTizUn29fl7RMLbm/FaaDfAmie+IWo7eSIPcIW1JCNrs9JP0fOtoywnRv
         VCu1Y/u56m49lCAGabwYAEipebtfGQIrQmQ+gnRUU8mZBFNB25S1wbxdXd3EgHmYOutN
         Dwbfao5xICaD8LsU5lfF+gLFW0YHvBWJfNXM99zUx6W12vZHiPuVi3vV+vy4JfFRhpSs
         WlhTp5XsLqLLsonMck5fgxLEL0mjrs77oDcfX2blmxTEkcrINscHLS6LxIv11P5KgiKI
         E5Sw==
X-Gm-Message-State: AOAM533GB/+2gsneHNVKPuDj+FsoAvJU7KtTGJn96BZtxs9LoD+W7OrQ
        9jBDHeCy9f9ZUIZ3pLG0BVhfuIDkoPLjGg==
X-Google-Smtp-Source: ABdhPJxpDEohmf8RrWI+qZ1o2e1vtGgE92f3rXHNVVQTVhAdgQNCbWXn0xHdk1KZXmuFG5AMIWCDfA==
X-Received: by 2002:ad4:5629:: with SMTP id cb9mr5833336qvb.62.1617237126876;
        Wed, 31 Mar 2021 17:32:06 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id 19sm1425205qtt.32.2021.03.31.17.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:32:06 -0700 (PDT)
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
Subject: [PATCH 10/12] lib: add fast path for find_first_*_bit() and find_last_bit()
Date:   Wed, 31 Mar 2021 17:31:51 -0700
Message-Id: <20210401003153.97325-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similarly to bitmap functions, users would benefit if we'll handle
a case of small-size bitmaps that fit into a single word.

While here, move the find_last_bit() declaration to bitops/find.h
where other find_*_bit() functions sit.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/bitops/find.h | 50 ++++++++++++++++++++++++++++---
 include/linux/bitops.h            | 12 --------
 lib/find_bit.c                    | 12 ++++----
 3 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 4148c74a1e4d..0d132ee2a291 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -5,6 +5,9 @@
 extern unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, unsigned long le);
+extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long size);
+extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
+extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
 
 #ifndef find_next_bit
 /**
@@ -102,8 +105,17 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
  * Returns the bit number of the first set bit.
  * If no bits are set, returns @size.
  */
-extern unsigned long find_first_bit(const unsigned long *addr,
-				    unsigned long size);
+static inline
+unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_bit(addr, size);
+}
 
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
@@ -113,8 +125,17 @@ extern unsigned long find_first_bit(const unsigned long *addr,
  * Returns the bit number of the first cleared bit.
  * If no bits are zero, returns @size.
  */
-extern unsigned long find_first_zero_bit(const unsigned long *addr,
-					 unsigned long size);
+static inline
+unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr | ~GENMASK(size - 1, 0);
+
+		return val == ~0UL ? size : ffz(val);
+	}
+
+	return _find_first_zero_bit(addr, size);
+}
 #else /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
 #ifndef find_first_bit
@@ -126,6 +147,27 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
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
 /**
  * find_next_clump8 - find next 8-bit clump with set bits in a memory region
  * @clump: location to store copy of found clump
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index a5a48303b0f1..26bf15e6cd35 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -286,17 +286,5 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
 })
 #endif
 
-#ifndef find_last_bit
-/**
- * find_last_bit - find the last set bit in a memory region
- * @addr: The address to start the search at
- * @size: The number of bits to search
- *
- * Returns the bit number of the last set bit, or size.
- */
-extern unsigned long find_last_bit(const unsigned long *addr,
-				   unsigned long size);
-#endif
-
 #endif /* __KERNEL__ */
 #endif
diff --git a/lib/find_bit.c b/lib/find_bit.c
index b03a101367f8..0f8e2e369b1d 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -75,7 +75,7 @@ EXPORT_SYMBOL(_find_next_bit);
 /*
  * Find the first set bit in a memory region.
  */
-unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
+unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
 {
 	unsigned long idx;
 
@@ -86,14 +86,14 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 
 	return size;
 }
-EXPORT_SYMBOL(find_first_bit);
+EXPORT_SYMBOL(_find_first_bit);
 #endif
 
 #ifndef find_first_zero_bit
 /*
  * Find the first cleared bit in a memory region.
  */
-unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
+unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
 	unsigned long idx;
 
@@ -104,11 +104,11 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 
 	return size;
 }
-EXPORT_SYMBOL(find_first_zero_bit);
+EXPORT_SYMBOL(_find_first_zero_bit);
 #endif
 
 #ifndef find_last_bit
-unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
+unsigned long _find_last_bit(const unsigned long *addr, unsigned long size)
 {
 	if (size) {
 		unsigned long val = BITMAP_LAST_WORD_MASK(size);
@@ -124,7 +124,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 	}
 	return size;
 }
-EXPORT_SYMBOL(find_last_bit);
+EXPORT_SYMBOL(_find_last_bit);
 #endif
 
 unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
-- 
2.25.1

