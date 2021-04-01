Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531A6350B2C
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 02:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhDAAc2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 20:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbhDAAb7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 20:31:59 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB324C06175F;
        Wed, 31 Mar 2021 17:31:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id l6so366587qtq.2;
        Wed, 31 Mar 2021 17:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zuXeb5K9/k1b38lIaOCwwXbJ1mWAiSIXqXWCN5QCoNc=;
        b=keFgzC4JJSPa9AI3ZT14cZQXCaDcpV/KPqYuLBdHVu3OD9sItamUkfj2TW2Pi5X0K1
         QFb2pO4MOGs69uZ0Ty0Y5uJ1QZtL7pe1L2/aN3Q+hWHt6rpKR85BoOxv1s5rZ5MoVlHj
         Ncq+Vi+CckYrvEXKIpsjZunu8OTkBgULZQowhoNDZPyWmB1DpYrKSf2YGV/pCsXRuTW7
         w8vwTsPHxhuy0F1Qt01XYj13Mk0rGN+A8rOVR6sRVbjExIJYXj9cABGrLWxziK6JVxhk
         8aZgoBXOhTJfvXchRNQDZkhTa94b8cp4x3slDYJ61zjV9h5mCC1+lLYiSwF3y318O9Ak
         l7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zuXeb5K9/k1b38lIaOCwwXbJ1mWAiSIXqXWCN5QCoNc=;
        b=TxHgjdzZA5shdkPtCbOlcSPQONw4gTx/ETzm65hWPV8hQWnfqHZM1/RhmEaqQe6eac
         kt0WdZMLBDZ6oSMl+Z8+tQxNnFGLhG3hCfzc2mRepDVlRFCg/mb3aLFano33DuZFkLc9
         vc7CpcmDoe3Xp8cGu1ZdiysmRF2MBzeMIyMObHG46ThhFWJPCzckRx/+/L+6ZZcs5yR3
         aUBJeN7np4M/X6m9+UgXlOM6SBoh6Vujeek9X/jySEzcHro6Hq0nIE4BVVBl8RGaUC6O
         fx2CtEsyNX7SOR8xml/HCP3QPSP2hXYSizwjIv3wPPWx96XTVYG9waRqHeWYeXXbTUvd
         Ycng==
X-Gm-Message-State: AOAM532ZB7pI4kXGeuPznimuub4XMPhC42ibFB6eZDRPfpnbe71ULYeJ
        mj+6a0bWYKW95XYXNfZZj1OMBii3ssMI7A==
X-Google-Smtp-Source: ABdhPJwRQgVEvnz88QByOgsTQLb5/PnrcKX6Jc6oc0zsnAVCzSHf1zutxfXlw8fSj6+PTR1mOQ3hGQ==
X-Received: by 2002:ac8:4412:: with SMTP id j18mr4996856qtn.387.1617237117885;
        Wed, 31 Mar 2021 17:31:57 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id 84sm2770435qkg.8.2021.03.31.17.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:31:57 -0700 (PDT)
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
Subject: [PATCH 02/12] tools: bitmap: sync function declarations with the kernel
Date:   Wed, 31 Mar 2021 17:31:43 -0700
Message-Id: <20210401003153.97325-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some functions in tools/include/linux/bitmap.h declare nbits as int. In the
kernel nbits is declared as unsigned int.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 tools/include/linux/bitmap.h | 8 ++++----
 tools/lib/bitmap.c           | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 477a1cae513f..7cbd23e56d48 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -30,7 +30,7 @@ void bitmap_clear(unsigned long *map, unsigned int start, int len);
 #define small_const_nbits(nbits) \
 	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
 
-static inline void bitmap_zero(unsigned long *dst, int nbits)
+static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = 0UL;
@@ -66,7 +66,7 @@ static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
 	return find_first_zero_bit(src, nbits) == nbits;
 }
 
-static inline int bitmap_weight(const unsigned long *src, int nbits)
+static inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
@@ -74,7 +74,7 @@ static inline int bitmap_weight(const unsigned long *src, int nbits)
 }
 
 static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
-			     const unsigned long *src2, int nbits)
+			     const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = *src1 | *src2;
@@ -141,7 +141,7 @@ static inline void bitmap_free(unsigned long *bitmap)
  * @buf: buffer to store output
  * @size: size of @buf
  */
-size_t bitmap_scnprintf(unsigned long *bitmap, int nbits,
+size_t bitmap_scnprintf(unsigned long *bitmap, unsigned int nbits,
 			char *buf, size_t size);
 
 /**
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 5043747ef6c5..f4e914712b6f 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -28,11 +28,11 @@ void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		dst[k] = bitmap1[k] | bitmap2[k];
 }
 
-size_t bitmap_scnprintf(unsigned long *bitmap, int nbits,
+size_t bitmap_scnprintf(unsigned long *bitmap, unsigned int nbits,
 			char *buf, size_t size)
 {
 	/* current bit is 'cur', most recently seen range is [rbot, rtop] */
-	int cur, rbot, rtop;
+	unsigned int cur, rbot, rtop;
 	bool first = true;
 	size_t ret = 0;
 
-- 
2.25.1

