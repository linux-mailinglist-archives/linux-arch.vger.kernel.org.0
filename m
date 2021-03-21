Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4465234351E
	for <lists+linux-arch@lfdr.de>; Sun, 21 Mar 2021 22:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhCUVzj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Mar 2021 17:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhCUVzH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Mar 2021 17:55:07 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0758C061762;
        Sun, 21 Mar 2021 14:55:06 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x9so11010182qto.8;
        Sun, 21 Mar 2021 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKoW45iRrqJm4cP5Y0oqqtzPpwCuxVWTABg237jJhgc=;
        b=s14/AZMMT+1hwW+PkXEUIdWFB3GaXeYhVmjP/jQ89SI2MJnBLzaqoc6k6xAFA50MGM
         5Wm/+S7MrbOmEzcPVJ2jxu2/2t6j47rUCKhZTvsdyXHKgkG+auMPwEq8HzdbFuXNH3Pl
         0xSZlG9CXYdDDlHUr8LYS9SFFb372LPliYJOz5LFMyHkt4fdnD4Lo4s9B01OLxrf3ghC
         sQ8HZWIL6zdY13cDxGRkwCusoz0+pppAPtHT5NPoahyNgL8utqMBfT84UBPgn7bQSFt5
         YAMmekb7QIEGRr/J0P/6G2MBTqRAgol/KGFLO/X79W6oeympuq3WGiLvXy5ufzct/1Xc
         vrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKoW45iRrqJm4cP5Y0oqqtzPpwCuxVWTABg237jJhgc=;
        b=j0mPzrA/5s0pOTGCB+2xC3MJKKCUOLCwnTYYJGWX/YLRTdGYfj1InwMxVu9C6oS8GZ
         QR8ojwuA8CaF7S43c7g2LeouKmCOOynV1VhlX01WYGCSrd4cT40MlfjlC3gZqLrgbjan
         NvxEnVLo5yZX42twqhe4pogRyEN1OmmtrOUzmIKpH/q51OpLuq02JmyOKgjz/wnCIRlF
         JU9/RHjU09QVmK2g/MldNx4HIinMYHqBvPYjcoIV0aUIvrB2YvDYX/YYSZg7MxMs6Hgk
         TpaNyeCz7EyYYcB6jlrFD6WC9UELfbujvMB+YTgv9FcYnA+hMcGVZn8EQAePsN9cnzD2
         QT1A==
X-Gm-Message-State: AOAM533hW/sQUGoIlhN8GGdv3wLKLkSdOO0JGg2A1MRVg6wj40KUedzn
        4qaazIou70u73ynj14b+tyGFHDYSEEI=
X-Google-Smtp-Source: ABdhPJxKdZTRfjjvJ/+gkigU1JnWkd+RKtYEVruDA4jBCAAnhQ4SC4APeVEEYD1eoQ5s5v0I/on7qw==
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr7440756qtx.98.1616363705695;
        Sun, 21 Mar 2021 14:55:05 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id i6sm5878249qkf.96.2021.03.21.14.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 14:55:05 -0700 (PDT)
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
Subject: [PATCH 06/12] tools: sync small_const_nbits() macro with the kernel
Date:   Sun, 21 Mar 2021 14:54:51 -0700
Message-Id: <20210321215457.588554-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321215457.588554-1-yury.norov@gmail.com>
References: <20210321215457.588554-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move the macro from tools/include/asm-generic/bitsperlong.h
to tools/include/linux/bitmap.h

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/include/asm-generic/bitsperlong.h | 3 +++
 tools/include/linux/bitmap.h            | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/asm-generic/bitsperlong.h b/tools/include/asm-generic/bitsperlong.h
index 8f2283052333..f530da2506cc 100644
--- a/tools/include/asm-generic/bitsperlong.h
+++ b/tools/include/asm-generic/bitsperlong.h
@@ -18,4 +18,7 @@
 #define BITS_PER_LONG_LONG 64
 #endif
 
+#define small_const_nbits(nbits) \
+	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
+
 #endif /* __ASM_GENERIC_BITS_PER_LONG */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 4aabc23ec747..330dbf7509cc 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -22,9 +22,6 @@ void bitmap_clear(unsigned long *map, unsigned int start, int len);
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
-#define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
-
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-- 
2.25.1

