Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEF6350B3B
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 02:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhDAAch (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 20:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhDAAcG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 20:32:06 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18B9C06175F;
        Wed, 31 Mar 2021 17:32:05 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id v70so646323qkb.8;
        Wed, 31 Mar 2021 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+swu3Np37j35irSEqEb2Bh6t2nPDu1IEuD1X9CPLZTg=;
        b=VQB9YXqslNTBL+pmjhmbdEEMWIlNDDcnPzCqz8UoPhmDeiTTq+l8Fqf7F7c3WopEX1
         yKtrKgZU71vASrwmUhpINOabEwCSpdnM12eM04RGWOSzo72bMM5+bCxVbwEVRcQybYE5
         H5Cd/droGBSGzEEidsONJ0aE3E0XXoqQx9zIk5RclgK69HC4SPd4l7GauRcEXCfXNBH/
         jZryjYCRFQVcy01di+Kcj+olNHBge0JCRgCKjeR0Pgvzhp0byxi615bvNMS+6LjAX/bp
         7MotKtAbQRYuY+uVpaYTQWxLnIP6ZZQ8VysQc/Q87wm4ooSuXWeVmCOV92vLBKpyrfJl
         38qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+swu3Np37j35irSEqEb2Bh6t2nPDu1IEuD1X9CPLZTg=;
        b=XbElhcF1oYRyjumyGYwNQZqx9xfpVc6hLI5LkzhjL0BJta2bRpDwkFnvNL/BYr2w1S
         c99Rl8WvenQhv1qxGeggvBIveA9Z6S9VFTaypB1tyD+dlJzFo5XnIV7SqOoiXt4DzPiq
         3szMqh/oLbK/Tnn8+ksj2Ff15AORWV9pWJ7BWEW4q2zzpsPvKgGNSz8rL+T8WdZ4cd7K
         g+XALqesoL8OJGpgGg+UPYF9ykesx4x51GTRn7QdJPionq+5BNyPybNJUvza2j28S8sc
         DopYwkkgTIRGnm2JM9dCVi1JE6ZmL8mECh3XmsMVmdBz32ssDbL4BWMSSTzgCs3DY7/A
         uxTA==
X-Gm-Message-State: AOAM530BuLKT2vykoLXEmrwS3NqkKpYdYmoX0xu63/I9l7Kx3kZFP4AL
        5hmlih1uvpX14jtoqqBcks2QOP1q/Loj1w==
X-Google-Smtp-Source: ABdhPJy28SMSvw7lJxu4o8JDLKR9qUpy9F5ONdXm/qEUePJ9ZUvYDBmdKC0aO7IHyihcglhuUoY2Cw==
X-Received: by 2002:a37:270c:: with SMTP id n12mr5979211qkn.277.1617237124566;
        Wed, 31 Mar 2021 17:32:04 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id 124sm2694708qke.107.2021.03.31.17.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:32:04 -0700 (PDT)
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
Subject: [PATCH 08/12] tools: sync find_next_bit implementation
Date:   Wed, 31 Mar 2021 17:31:49 -0700
Message-Id: <20210401003153.97325-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sync the implementation with recent kernel changes.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 tools/include/asm-generic/bitops/find.h | 27 ++++++++++---
 tools/lib/find_bit.c                    | 52 ++++++++++---------------
 2 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/tools/include/asm-generic/bitops/find.h b/tools/include/asm-generic/bitops/find.h
index 16ed1982cb34..9fe62d10b084 100644
--- a/tools/include/asm-generic/bitops/find.h
+++ b/tools/include/asm-generic/bitops/find.h
@@ -2,6 +2,10 @@
 #ifndef _TOOLS_LINUX_ASM_GENERIC_BITOPS_FIND_H_
 #define _TOOLS_LINUX_ASM_GENERIC_BITOPS_FIND_H_
 
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
@@ -27,13 +35,16 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
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
-
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
  * @addr: The address to base the search on
@@ -43,8 +54,12 @@ extern unsigned long find_next_and_bit(const unsigned long *addr1,
  * Returns the bit number of the next zero bit
  * If no bits are zero, returns @size.
  */
+static inline
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
-				 unsigned long offset);
+				 unsigned long offset)
+{
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+}
 #endif
 
 #ifndef find_first_bit
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index ac37022e9486..589fd2f26f94 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -28,11 +28,12 @@
  *    searching it for one bits.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
-static inline unsigned long _find_next_bit(const unsigned long *addr1,
+unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
-		unsigned long start, unsigned long invert)
+		unsigned long start, unsigned long invert, unsigned long le)
 {
-	unsigned long tmp;
+	unsigned long tmp, mask;
+	(void) le;
 
 	if (unlikely(start >= nbits))
 		return nbits;
@@ -43,7 +44,19 @@ static inline unsigned long _find_next_bit(const unsigned long *addr1,
 	tmp ^= invert;
 
 	/* Handle 1st word. */
-	tmp &= BITMAP_FIRST_WORD_MASK(start);
+	mask = BITMAP_FIRST_WORD_MASK(start);
+
+	/*
+	 * Due to the lack of swab() in tools, and the fact that it doesn't
+	 * need little-endian support, just comment it out
+	 */
+#if (0)
+	if (le)
+		mask = swab(mask);
+#endif
+
+	tmp &= mask;
+
 	start = round_down(start, BITS_PER_LONG);
 
 	while (!tmp) {
@@ -57,18 +70,12 @@ static inline unsigned long _find_next_bit(const unsigned long *addr1,
 		tmp ^= invert;
 	}
 
-	return min(start + __ffs(tmp), nbits);
-}
+#if (0)
+	if (le)
+		tmp = swab(tmp);
 #endif
 
-#ifndef find_next_bit
-/*
- * Find the next set bit in a memory region.
- */
-unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
-			    unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, 0UL);
+	return min(start + __ffs(tmp), nbits);
 }
 #endif
 
@@ -105,20 +112,3 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 	return size;
 }
 #endif
-
-#ifndef find_next_zero_bit
-unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
-				 unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, ~0UL);
-}
-#endif
-
-#ifndef find_next_and_bit
-unsigned long find_next_and_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long size,
-		unsigned long offset)
-{
-	return _find_next_bit(addr1, addr2, size, offset, 0UL);
-}
-#endif
-- 
2.25.1

