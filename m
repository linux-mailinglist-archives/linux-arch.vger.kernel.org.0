Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DC52FDE46
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 02:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbhAUA6S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 19:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392390AbhAUAKV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 19:10:21 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC18C06179A;
        Wed, 20 Jan 2021 16:06:44 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id bd6so116379qvb.9;
        Wed, 20 Jan 2021 16:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9Hwndwgsgmr7xB4y1K4SBbnbogFtSSFcJExBJcwKqk=;
        b=RFMh/FHAbkE/EyNL0tG3uk11bRPE7HfZOd+r83jpDiJ9/caa1G1q6WinVhCnF6nGar
         +L47b9SY2mmHr8Tuof3oot/OR/J3hTRWaXPGHBNHlhttiGcpWt7e/AIO6+duRIice8fC
         BIwck75PqQT5IA6GM5oUR/0JPnOaVcaS3/saA2WDYoshJh2d5cv2TXZhIxycO4G66+BG
         WhljZsj2oLZwlCx2Zm1YAxdhEhQrz8oUhJCy/Z5W7TAlde1eKpwmnI0B4MD9ToPGjRlH
         8jiFyyUiZa5vxgtDxjDq+d55nZyKPsODHEiVAMKT0QcnJp868UGJOQr8o9/etbHkcCe4
         PEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9Hwndwgsgmr7xB4y1K4SBbnbogFtSSFcJExBJcwKqk=;
        b=jO+UI3hw3wHlTRxKGtP3KfdgZEDB2FFT5xHmr+V2Jom/IxO+5VbmNtwO4KCT4B9ez2
         eROxuuotyz92pxoN0r78x0fXeYU65rZqs76fEjxu/BkkRO9pSfEi46kx7wiU8sG7s+w1
         OWCGLRXInTefr8Iw+c9oCOuftm9df4wAzXQffddxj/vMu5H5FDuMVpXpS4L2xRH05RJF
         SG3XWE3NfMh36dCxmsVudc1cUI6XthzF//t3/LW02CcvvP0gXD7Gp3Vct286STI5YC7c
         MgV9FRTnZvSSBGo5ux5pNDyhjtk44XX30jgpLfaH433UszMYqGbjssoSoucZSpaRqKpG
         uQbg==
X-Gm-Message-State: AOAM532zmXO7SxNRd+CubT19F3OdJlRmQ5D/tDpSXmCSQPWIffcVzY+C
        1T2ng0FG5zOt3Itc49YZMYGpjbGE7JM5U/6G
X-Google-Smtp-Source: ABdhPJyjalt+WEFMHkhW/LDfaKg2ipFqZPf0duKC+2s16rFC0iS3CXo8zoD0SMDTux3fT9YyITk1MQ==
X-Received: by 2002:a05:6214:54d:: with SMTP id ci13mr12143305qvb.30.1611187603357;
        Wed, 20 Jan 2021 16:06:43 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id i13sm2508093qkk.83.2021.01.20.16.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 16:06:42 -0800 (PST)
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
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 6/6] lib: add fast path for find_first_*_bit() and find_last_bit()
Date:   Wed, 20 Jan 2021 16:06:30 -0800
Message-Id: <20210121000630.371883-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121000630.371883-1-yury.norov@gmail.com>
References: <20210121000630.371883-1-yury.norov@gmail.com>
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
 include/asm-generic/bitops/find.h | 56 ++++++++++++++++++++++++++++---
 include/linux/bitops.h            | 12 -------
 lib/find_bit.c                    | 12 +++----
 3 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index d45096069011..8708e333fc69 100644
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
@@ -111,8 +114,21 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
  * Returns the bit number of the first set bit.
  * If no bits are set, returns @size.
  */
-extern unsigned long find_first_bit(const unsigned long *addr,
-				    unsigned long size);
+static inline
+unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long idx;
+
+		if (!*addr)
+			return size;
+
+		idx = __ffs(*addr);
+		return idx < size ? idx : size;
+	}
+
+	return _find_first_bit(addr, size);
+}
 
 /**
  * find_first_zero_bit - find the first cleared bit in a memory region
@@ -122,8 +138,20 @@ extern unsigned long find_first_bit(const unsigned long *addr,
  * Returns the bit number of the first cleared bit.
  * If no bits are zero, returns @size.
  */
-extern unsigned long find_first_zero_bit(const unsigned long *addr,
-					 unsigned long size);
+static inline
+unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long idx;
+		if (*addr == ~0UL)
+			return size;
+
+		idx = ffz(*addr);
+		return idx < size ? idx : size;
+	}
+
+	return _find_first_zero_bit(addr, size);
+}
 #else /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
 #ifndef find_first_bit
@@ -135,6 +163,26 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
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
+		unsigned long val = *addr & BITMAP_LAST_WORD_MASK(size);
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
index a0e138bbb8ce..1d41193be4ab 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -297,17 +297,5 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
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

