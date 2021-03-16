Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A6C33CB13
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 02:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhCPBzJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Mar 2021 21:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhCPByh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:54:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB72C061756;
        Mon, 15 Mar 2021 18:54:37 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g185so33789186qkf.6;
        Mon, 15 Mar 2021 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYrAzUMeWURki6W7HdtK2287DDTqW7C4q3t+Re6D910=;
        b=FfoDreh//zIzpyq4GJKtYtCecXiVTfCRkjVU1MOVUOXFlJfHBcMPtQRckA760HP3ji
         +X4Lbe7CAicE/7h9gh65XCYt2V10kzoK/rHVOEn09SuxAmLsMyf+g8bJjyqEI8ILPrMc
         d14Y9L+xRIUbD4Tzusws8brW+KcrbhfgegBodY3+hHZjIwKIETCKTvP7FfK8Jfxaeqx/
         KKnw8SrEhnDvPkVhmT716xc7JwXVppp4y5r2wvPbGQ+fN5KX9ASe5nbNxNgQnoBptodk
         pk4AbDqWffRG/vW4lKnNLMmlvXLiDIl/l6Lwbu0bdi/KLRnGnytctRY4jqwNt/WcZSCz
         t18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYrAzUMeWURki6W7HdtK2287DDTqW7C4q3t+Re6D910=;
        b=Lb79OKeH7qme0Zv62TNnNbuGAOHNuZNyFTSy15OfStAxR7EzkW5s1NpB3bFy2hC7Jm
         o0qi100Fh9ABqv3wlBRVL1YsxPSKtPNux1R7mjOBhLZtA2sjDsirtLo+1QARsNKho377
         LJtT7qmZ1UF8Mk28rpIaEUTAHdN1hptlpQm/X9KJfEvDA1jKVenIjlrNR5avfIZLU8kw
         krD1vUzxOoCni4/ONop2doG+SDfKSWudKN5ZoJ0APAAvzCTDymjdpyj0SkKwID5jRbB3
         Go2jfgRtXjx/zKFejmLJwUkqItTQtTjzR8jN0d04Xm1yya6L1pRrNhotkpqnEPSJkZou
         JPHQ==
X-Gm-Message-State: AOAM530DtX4OzKFiG5WfpsyQYdmxRjSp91RoG1Ca/HJ+op5QjDyfGHLq
        7yAPzecoQq+i3Tt3axqgrHZqj5lmgR4=
X-Google-Smtp-Source: ABdhPJyJaCpA4Mmd+Drq2B1sjTdXdiKx3uvORQuRwGuWu7cR4oghE5yVJRpEKu40WCuzvtbTTgVaiA==
X-Received: by 2002:a37:98f:: with SMTP id 137mr16874690qkj.357.1615859676323;
        Mon, 15 Mar 2021 18:54:36 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id d14sm13613984qkg.33.2021.03.15.18.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:54:36 -0700 (PDT)
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
Subject: [PATCH 07/13] tools: sync small_const_nbits() macro with the kernel
Date:   Mon, 15 Mar 2021 18:54:18 -0700
Message-Id: <20210316015424.1999082-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316015424.1999082-1-yury.norov@gmail.com>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
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
index 8f2283052333..60b44bb4748b 100644
--- a/tools/include/asm-generic/bitsperlong.h
+++ b/tools/include/asm-generic/bitsperlong.h
@@ -18,4 +18,7 @@
 #define BITS_PER_LONG_LONG 64
 #endif
 
+#define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n) < BITS_PER_LONG)
+#define small_const_nbits(n) SMALL_CONST((n) - 1)
+
 #endif /* __ASM_GENERIC_BITS_PER_LONG */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index b6e8430c8bc9..433997b89565 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -19,9 +19,6 @@ int __bitmap_equal(const unsigned long *bitmap1,
 		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
 
-#define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
-
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
-- 
2.25.1

