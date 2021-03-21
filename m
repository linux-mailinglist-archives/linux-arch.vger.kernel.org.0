Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0ED343528
	for <lists+linux-arch@lfdr.de>; Sun, 21 Mar 2021 22:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhCUVzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Mar 2021 17:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhCUVzJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Mar 2021 17:55:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA390C061764;
        Sun, 21 Mar 2021 14:55:08 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r14so11003228qtt.7;
        Sun, 21 Mar 2021 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Fw/cm/i6XifIVH4DNb94Y5ofZtMxUzPCQFU6ODCPvU=;
        b=Nzc2sEsafDH3iTOPMqypNrn6OMfvn6OJXE5aXvx9xNr7vx7DkSVFlYF18HG+D1EyAG
         +KIUkVmp39/4CIlrzBAzSLQaHDAlSk1Xda4L40qsS02zy+2v2a1HB9yxFrIAprc7Vylt
         14UjFSnxTqPXN55o20eNJCkpsdL1nwWH7bE4HFAtQH3dqRc0RYcvWKs+j+u1zIURO6u9
         tftZly7r+DnZu8A5p+RTz+pAOcR4kUDTR6ogXz5azOFhqFdInQoCWOWc0a5IAg4vyN8x
         8HT+9EobJvp1/DFzuUMnobZ8mIeskpny0uP3vb87q4C+y603I1vvv9vUcHFe8tEi7M/S
         xvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Fw/cm/i6XifIVH4DNb94Y5ofZtMxUzPCQFU6ODCPvU=;
        b=VBErC0SMmZr471dVoWSVaqVJ5U4C1KQs6KrFR4RJCUf1MAQ5gUQegSmT6JFwM5yxUa
         WQds4CQThQjJGkKRWhgLN9JD0VNHx7sLX1MrorXG4t15ZacScTVSogwQsXLksfk6SozR
         Z4u/hFyEBrERscE+QOImNjTKlf8yJu+q/aYcXxq5CbM8348COfikmXSwDmH3WmlHXZqk
         X2SaYB/Z9qQG8IsXR3W4+BcYDYo6tXWCFEdZBxuqhQRKO1z8tFH7Fs2M9xRwjd5GocVR
         ZDBDqvY90wVDc4RVU1vnQUw7RH3hZXj2MqVmbmDY9Yed+or0txib9MMpuca30DbS5j5Z
         ibCg==
X-Gm-Message-State: AOAM533J6PCFkOSDTwtIGTvgUPG1ZpTwC39unVO/8uWPjX/mCq9aYRi1
        2FR803vjp+xiWWAVQogI3XPKcEmOok4=
X-Google-Smtp-Source: ABdhPJzhzKQ3PJDhejUl/WrEb4JJyX/rhBH0LAogvL3uyBp+SPb8iHnvsfDsxZWGtfQ06QBQ0UB/LA==
X-Received: by 2002:aed:2ce3:: with SMTP id g90mr7354526qtd.308.1616363707766;
        Sun, 21 Mar 2021 14:55:07 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id n2sm7598617qta.61.2021.03.21.14.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 14:55:07 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Date:   Sun, 21 Mar 2021 14:54:53 -0700
Message-Id: <20210321215457.588554-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321215457.588554-1-yury.norov@gmail.com>
References: <20210321215457.588554-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sync the implementation with recent kernel changes.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
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

