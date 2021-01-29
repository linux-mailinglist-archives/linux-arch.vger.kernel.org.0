Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0969308EBD
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhA2Uto (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbhA2UrJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 15:47:09 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071BC061794;
        Fri, 29 Jan 2021 12:45:40 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id n7so10086626qkc.4;
        Fri, 29 Jan 2021 12:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PilOA4rVLqLceXna0OKUoi5iXGDJq7/RRuqJ5TI51dU=;
        b=nqyUuI8keAZPpFpRGU71c7E8HQu+DZgUtaMhxWlA3JWJyU375Q77yfKgRQ8k5kS4Rr
         5dbIc4owUFbkiapyTHILQYHseiyCoRdoaJ9/svs31kVPSVFYbPbVbPnrxes5qVXSpwqh
         SLPdXbVg9SZWlVXouTqO2ebNtNbRQAETrjRuKfgy3dVTHqZjECM63+htRrbn+ODCpOxF
         g6iKEqtYqkwkQxJrEqzAwvNGLKdMvSEpBscmnib8XuJbpDj09FAC88/QbJ2+Gz78jJhY
         W9fT4YAmUoDUBGIal9emYIEcfXzPpVrWKi7dUf109IyagdzBx90RssM0aQzlVR2vx5NB
         r02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PilOA4rVLqLceXna0OKUoi5iXGDJq7/RRuqJ5TI51dU=;
        b=mpTmMo/KkDUF+svIYGFktjrNdlhMO9qzaWurkDlZJPdBkA1iOg3wLYalvB0on2QKaU
         9Iq2bK0LL5/1Yp+HDhz2ZzT+hk/QSXEkJ4r+hiyt1fD1qPBtxg1utU9zIQ8mOafuZbgN
         i/+/qQfTSS8Gbe2cPbgjLSBHd7IAiORoqY94KBNOKsqhw8Wy9hW8f5JyAcLFM5UNc9Pv
         AWxyMnUmrl2N/x7CUqGW5YzPz2l7bUBK+Rsy03FPp7WLZB7fAy0DJuZcTmVL+rJfYpab
         l4UfkE56/6qzcb90mZbRosZkS7wFAnLx4X3Wm/Brwxd5VRBTcpWbOb4kyvZzebIm6RZa
         NrRQ==
X-Gm-Message-State: AOAM531PTQ0Bflfw4yh09R0PIammJdh6Eoyaijc9PjDm2TAtltPl+re3
        10jtTt8IiCCzreEllHil2n8=
X-Google-Smtp-Source: ABdhPJwpeRUpB3TZmdmUC5dv3IXNrJ3EFaqnYoU7Hf+tFjciP1RTlhjyne2P8LCVhF0jngjLL4K9RQ==
X-Received: by 2002:a37:5902:: with SMTP id n2mr5908699qkb.30.1611953139435;
        Fri, 29 Jan 2021 12:45:39 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id k8sm5481124qkk.79.2021.01.29.12.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:45:38 -0800 (PST)
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
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH 6/6] lib: add fast path for find_first_*_bit() and find_last_bit()
Date:   Fri, 29 Jan 2021 12:45:28 -0800
Message-Id: <20210129204528.2118168-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129204528.2118168-1-yury.norov@gmail.com>
References: <20210129204528.2118168-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similarly to bitmap functions, users will benefit if we'll handle
a case of small-size bitmaps that fit into a single word.

While here, move the find_last_bit() declaration to bitops/find.h
where other find_*_bit() functions sit.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitops/find.h       | 50 +++++++++++++++++++++++--
 include/linux/bitops.h                  | 12 ------
 lib/find_bit.c                          | 12 +++---
 tools/include/asm-generic/bitops/find.h | 28 ++++++++++++--
 tools/lib/find_bit.c                    |  4 +-
 5 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8bd7a33a889d..132dfb2da765 100644
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
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val = *addr & BITS_FIRST_MASK(size - 1);
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
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val = *addr | ~BITS_FIRST_MASK(size - 1);
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
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val = *addr & BITS_FIRST_MASK(size - 1);
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
index 2470ae390f3c..e2c301d28568 100644
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
 		unsigned long val = BITS_FIRST_MASK(size - 1);
@@ -124,7 +124,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 	}
 	return size;
 }
-EXPORT_SYMBOL(find_last_bit);
+EXPORT_SYMBOL(_find_last_bit);
 #endif
 
 unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
diff --git a/tools/include/asm-generic/bitops/find.h b/tools/include/asm-generic/bitops/find.h
index eff868bd22f8..6abd5b3e2cb0 100644
--- a/tools/include/asm-generic/bitops/find.h
+++ b/tools/include/asm-generic/bitops/find.h
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
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val = *addr & BITS_FIRST_MASK(size - 1);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_bit(addr, size);
+}
 
 #endif /* find_first_bit */
 
@@ -117,7 +129,17 @@ extern unsigned long find_first_bit(const unsigned long *addr,
  * Returns the bit number of the first cleared bit.
  * If no bits are zero, returns @size.
  */
-unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size);
+static inline
+unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
+{
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val = *addr | ~BITS_FIRST_MASK(size - 1);
+
+		return val == ~0UL ? size : ffz(val);
+	}
+
+	return _find_first_zero_bit(addr, size);
+}
 #endif
 
 #endif /*_TOOLS_LINUX_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index c3378b291205..a77884ca30ec 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -83,7 +83,7 @@ unsigned long _find_next_bit(const unsigned long *addr1,
 /*
  * Find the first set bit in a memory region.
  */
-unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
+unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
 {
 	unsigned long idx;
 
@@ -100,7 +100,7 @@ unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 /*
  * Find the first cleared bit in a memory region.
  */
-unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
+unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
 	unsigned long idx;
 
-- 
2.25.1

