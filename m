Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717522FDEE5
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 02:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbhAUA6O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 19:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392207AbhAUAKD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 19:10:03 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C489C061795;
        Wed, 20 Jan 2021 16:06:41 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id az16so126362qvb.5;
        Wed, 20 Jan 2021 16:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjoQ5qusNzQLb2JDxSVbTW4dQgrN6MvvxrltYUjtBfM=;
        b=F6BNWYr8cXOX0IpQyqQhpA4Po7SyfJo8bimD8NpQndaBhuMIvimhbXdB8KQDB08eXO
         Tl2zK9L+KiTRdIAoaVZSUXwWkbxLSRGYkPO9IyNesVADOn6xmdKLbtoKbE/Ls/U9KBOv
         gWEdE08lDibEJdvNr9699iNWbxCxjvPHROlEZYhGJUo+FQUaJ6y4wpgXKsaUVlfR7xx2
         00T0arBr6TXoid/DlrTR4Gcefi9RDl26xWGzqhgPjk5PdovrW1NZd3mEQhfutaJwy3yg
         2YTeoi+CkGmC6rxWNW6An3KVxv7+v3Jra1XqChCYLcfSv++asKFForrjZh2PaQKkwuRS
         3OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjoQ5qusNzQLb2JDxSVbTW4dQgrN6MvvxrltYUjtBfM=;
        b=pTLG4eKMyo0+pKzkQNrvCVI9meC7H2O8AmHCJBJWryD5W2UY+RoPBaUu/Pppg9wUs0
         YYDHENs20UPnNz23bTOGPXiWl+Eh8FGMc5UcK9tjI+ID/Q3Z2JYUT2yxthASIunGMRZK
         I0GcxiT3FOBHV8WoSNtgP38MChXqAm1OzuHTPQ2MD+q1S1D89UqFh2ZsEtx0bN7t7DsY
         6fis/CzEHjUJK1Bj1ez/pXZwPYea+hqvezfknILfbD7mSC/k8rjB7wKKx5UhIZsg2BSy
         P97s9Q5K3TiOgpbreZUY0MGkaM4LM5kFt82W/4tS3wMepKgi2iho9jqnleyzuGmkrYk3
         cbOQ==
X-Gm-Message-State: AOAM530Q8DeVyEyhcCaGVQNYB6peoN8T7mlFX+p0ORpodUbge6MNVMsL
        ZPrusVaEw2fe6ulLA68bcMo=
X-Google-Smtp-Source: ABdhPJyfvweaPAwoiJNooJ/a9FPpNrA7RfXSU1z+h9CKbsg6oOMNOa5t80UZF07EFKodjUU2Xc7lig==
X-Received: by 2002:a0c:b990:: with SMTP id v16mr11717292qvf.16.1611187600645;
        Wed, 20 Jan 2021 16:06:40 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id d1sm2512482qkf.102.2021.01.20.16.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 16:06:40 -0800 (PST)
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
Subject: [PATCH 4/6] lib: inline _find_next_bit() wrappers
Date:   Wed, 20 Jan 2021 16:06:28 -0800
Message-Id: <20210121000630.371883-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121000630.371883-1-yury.norov@gmail.com>
References: <20210121000630.371883-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

lib/find_bit.c declares five single-line wrappers for _find_next_bit().
We may turn those wrappers to inline functions. It eliminates
unneeded function calls and opens room for compile-time optimizations.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitops/find.h | 28 ++++++++++++----
 include/asm-generic/bitops/le.h   | 17 +++++++---
 lib/find_bit.c                    | 56 ++-----------------------------
 3 files changed, 37 insertions(+), 64 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 9fdf21302fdf..7ad70dab8e93 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_GENERIC_BITOPS_FIND_H_
 #define _ASM_GENERIC_BITOPS_FIND_H_
 
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
@@ -27,9 +35,13 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
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
@@ -42,8 +54,12 @@ extern unsigned long find_next_and_bit(const unsigned long *addr1,
  * Returns the bit number of the next zero bit
  * If no bits are zero, returns @size.
  */
-extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned
-		long size, unsigned long offset);
+static inline
+unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
+				 unsigned long offset)
+{
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
+}
 #endif
 
 #ifdef CONFIG_GENERIC_FIND_FIRST_BIT
diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 188d3eba3ace..4cf44ea16ec0 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -4,6 +4,7 @@
 
 #include <asm/types.h>
 #include <asm/byteorder.h>
+#include <asm-generic/bitops/find.h>
 
 #if defined(__LITTLE_ENDIAN)
 
@@ -32,13 +33,21 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
 #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
 
 #ifndef find_next_zero_bit_le
-extern unsigned long find_next_zero_bit_le(const void *addr,
-		unsigned long size, unsigned long offset);
+static inline
+unsigned long find_next_zero_bit_le(const void *addr, unsigned
+		long size, unsigned long offset)
+{
+	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
+}
 #endif
 
 #ifndef find_next_bit_le
-extern unsigned long find_next_bit_le(const void *addr,
-		unsigned long size, unsigned long offset);
+static inline
+unsigned long find_next_bit_le(const void *addr, unsigned
+		long size, unsigned long offset)
+{
+	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
+}
 #endif
 
 #ifndef find_first_zero_bit_le
diff --git a/lib/find_bit.c b/lib/find_bit.c
index f67f86fd2f62..b03a101367f8 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -29,7 +29,7 @@
  *    searching it for one bits.
  *  - The optional "addr2", which is anded with "addr1" if present.
  */
-static unsigned long _find_next_bit(const unsigned long *addr1,
+unsigned long _find_next_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long nbits,
 		unsigned long start, unsigned long invert, unsigned long le)
 {
@@ -68,37 +68,7 @@ static unsigned long _find_next_bit(const unsigned long *addr1,
 
 	return min(start + __ffs(tmp), nbits);
 }
-#endif
-
-#ifndef find_next_bit
-/*
- * Find the next set bit in a memory region.
- */
-unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
-			    unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
-}
-EXPORT_SYMBOL(find_next_bit);
-#endif
-
-#ifndef find_next_zero_bit
-unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
-				 unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
-}
-EXPORT_SYMBOL(find_next_zero_bit);
-#endif
-
-#if !defined(find_next_and_bit)
-unsigned long find_next_and_bit(const unsigned long *addr1,
-		const unsigned long *addr2, unsigned long size,
-		unsigned long offset)
-{
-	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
-}
-EXPORT_SYMBOL(find_next_and_bit);
+EXPORT_SYMBOL(_find_next_bit);
 #endif
 
 #ifndef find_first_bit
@@ -157,28 +127,6 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 EXPORT_SYMBOL(find_last_bit);
 #endif
 
-#ifdef __BIG_ENDIAN
-
-#ifndef find_next_zero_bit_le
-unsigned long find_next_zero_bit_le(const void *addr, unsigned
-		long size, unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, ~0UL, 1);
-}
-EXPORT_SYMBOL(find_next_zero_bit_le);
-#endif
-
-#ifndef find_next_bit_le
-unsigned long find_next_bit_le(const void *addr, unsigned
-		long size, unsigned long offset)
-{
-	return _find_next_bit(addr, NULL, size, offset, 0UL, 1);
-}
-EXPORT_SYMBOL(find_next_bit_le);
-#endif
-
-#endif /* __BIG_ENDIAN */
-
 unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
 			       unsigned long size, unsigned long offset)
 {
-- 
2.25.1

