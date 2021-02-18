Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C414E31E4FF
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhBREIo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhBREHG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:07:06 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B55EC0611C1;
        Wed, 17 Feb 2021 20:05:31 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id a1so347992qvd.13;
        Wed, 17 Feb 2021 20:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wdFX9EW7ZSKDkfndJw3oSm6afvNog5P4ZYr8XpMLSA=;
        b=sTbbYPvfLf4cjPEXv6PIqMQqe/CsiDOdGZs5j+rg1s56RFyl+LCWx7sbg66yKBxX+Y
         6ImgifZRxTEUI81XsSv18TlR2ouioDLstJRQUnFaUzwTGRDSkxslz0e6ckoqZl32EOc1
         l7zAxVmKSEArvlYzPZjgMUV8q+rp4MwLhTiDygyASMsyw0RTWTSUV3Bp5dMo5t60p2GW
         qU51fMuGF4rYzgT8XuGdIJmCbCTSQ8N6c45FsBMooVv/b1vyovUJ/lVGarSDfHEwTAE2
         hGDjcxdFpjp8v196FkPSB19DjGNe3dTnqeXzfH+bIJlkmHSQ9MmzS7suP72rhjB4nIxB
         Q97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wdFX9EW7ZSKDkfndJw3oSm6afvNog5P4ZYr8XpMLSA=;
        b=eV40MRhO39Gs+EXrXD/ax7HUc7gLbwey9bnjqJs/3ttx8WL/IHhaiaZWqAdCEQHJRA
         dEjVqXZhhK//mZNuvsSO+SE1yoU5gkuUlEkIxUgb5Ro9zpwvvNj5P3Z+50Dj45OanjMo
         iyq7JXuYA9I0U3k2vdC+I4N9wk3hYkxu0Y4ItAil7wihAg/SCjtdXR/xD/JHqlA1sW34
         eIPnFsuHHc3e/oDzsu8E9EtEpSwvWQuJmwAw2obSHxCCIXQVfsSEJI5DS8av97qSrczv
         FbH6amgJb6WG/3vQ4eW+3GxkB7G2ouCPZFiKjvsKQZsyxKjTS5DKz/ebzI07sB60tUU8
         3gGw==
X-Gm-Message-State: AOAM530GWvjTTzB+1xTVuoLfhlzuONpEgrQUv6X+N+pfQSOkxAg405XK
        r5s/xFwjRo4P3nHUy8ZrvFfeudcJ1ZZFOw==
X-Google-Smtp-Source: ABdhPJzJ8gZQ59fVjoYHAMW8DbKl62bBXcmMfhZ/uXUFBcsHKBFXqxqYSJL8PiO2/hoUwx8ib1FdzQ==
X-Received: by 2002:a05:6214:d6d:: with SMTP id 13mr2663718qvs.60.1613621129975;
        Wed, 17 Feb 2021 20:05:29 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id b137sm3332443qkg.51.2021.02.17.20.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:29 -0800 (PST)
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
Subject: [PATCH 13/14] tools: sync lib/find_bit implementation
Date:   Wed, 17 Feb 2021 20:05:11 -0800
Message-Id: <20210218040512.709186-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218040512.709186-1-yury.norov@gmail.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add fast paths to find_*_bit() functions as per kernel implementation.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/include/asm-generic/bitops/find.h | 58 +++++++++++++++++++++++--
 tools/lib/find_bit.c                    |  4 +-
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/tools/include/asm-generic/bitops/find.h b/tools/include/asm-generic/bitops/find.h
index 9fe62d10b084..382cd80c61aa 100644
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
@@ -20,6 +23,16 @@ static inline
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, 0UL, 0);
 }
 #endif
@@ -40,6 +53,16 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
 {
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr1 & *addr2 & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
 	return _find_next_bit(addr1, addr2, size, offset, 0UL, 0);
 }
 #endif
@@ -58,6 +81,16 @@ static inline
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr | ~GENMASK(size - 1, offset);
+		return val == ~0UL ? size : ffz(val);
+	}
+
 	return _find_next_bit(addr, NULL, size, offset, ~0UL, 0);
 }
 #endif
@@ -72,8 +105,17 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
  * Returns the bit number of the first set bit.
  * If no bits are set, returns @size.
  */
-extern unsigned long find_first_bit(const unsigned long *addr,
-				    unsigned long size);
+static inline
+unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
+{
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val = *addr & BITS_FIRST(size - 1);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_bit(addr, size);
+}
 
 #endif /* find_first_bit */
 
@@ -87,7 +129,17 @@ extern unsigned long find_first_bit(const unsigned long *addr,
  * Returns the bit number of the first cleared bit.
  * If no bits are zero, returns @size.
  */
-unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size);
+static inline
+unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
+{
+	if (SMALL_CONST(size - 1)) {
+		unsigned long val = *addr | ~BITS_FIRST(size - 1);
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

