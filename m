Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4947343524
	for <lists+linux-arch@lfdr.de>; Sun, 21 Mar 2021 22:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhCUVzj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Mar 2021 17:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhCUVzG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Mar 2021 17:55:06 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE36C061764;
        Sun, 21 Mar 2021 14:55:05 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o5so8726850qkb.0;
        Sun, 21 Mar 2021 14:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f29jH9p39JWfD2RtS5iC7kXU7OOMGi9+Tjbr7N4HWDA=;
        b=FgfD9GTvPoa9YBhlZc011prSCq8qTC6AGGpN1pyaTQ34Us90lEiWDk+Y3RwpoNgqQM
         bVuGGx+62+cA8olEUeC/93lQi916ahpRX13jz/NMDQ6eshKlL5/tvWSSiWv8JiPC9LkH
         3TQuSLG8OgMLhF7VaVqnUZA0X4hKDGx3o2Rxb+rkib9zlZ48hM7JVVzxsgoAMR69VuXz
         2Kwzv56rulCVal4lDwq9/LeqKtCz6VSduIGWk65nk+sHy4JxtVBsDV9/nzwaBSmSvmcu
         xOzMHnM75++h4EvCbH+w4by9EpVBGPgf8rjuWywUP6F4LHqOf6jltCxvpcqlr3rVE7Yg
         5jIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f29jH9p39JWfD2RtS5iC7kXU7OOMGi9+Tjbr7N4HWDA=;
        b=sVcB5j8ZZOUmPlYefE+Kxr4NyOxTFQqFtFkiN4FerdqZhzZR5CdghW3MCRelCIxwc5
         P9j22eUDpxbMB/lIZTloeWNoW55KK+BuEMoa1EBPvwpamLc8N4iHS9A4KJyzDVEhZ17y
         JaE+ciUcksD1fb4J0tXIlQAAmo1QEwJQ+AdxqenOmEHbVJ8yol3rkPGSA3Gx6KUYuGI5
         r1E3PsT6cPrgmWDl1uNumx+8iJCiaJ3GUiYy4KS18Q2d7aE7lT9NpINN6+l7y8MjRNDF
         vdcibLAX5ftrgGmH03Jty03aS48sfKhcfoXkp30UUqJMJowuGoPogGh+vZEd0fiiDXLb
         ZHJg==
X-Gm-Message-State: AOAM53172/Lrs6QQGrVACNc2bcPi2uozvNhckJEQX6BG5U/6lgUYUnUx
        m76d7WhTw6ARFk6V89l9AiphlMo/1k8=
X-Google-Smtp-Source: ABdhPJySPLg/YWK3a/H3R05lY9uZd84miNqrzHUkKCXCOynNx7ZqX/X/MDF+iUXO4/I98hSBuAYANA==
X-Received: by 2002:a37:638f:: with SMTP id x137mr8169808qkb.199.1616363704823;
        Sun, 21 Mar 2021 14:55:04 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id 66sm9679104qkk.18.2021.03.21.14.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 14:55:04 -0700 (PDT)
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
Subject: [PATCH 05/12] lib: extend the scope of small_const_nbits() macro
Date:   Sun, 21 Mar 2021 14:54:50 -0700
Message-Id: <20210321215457.588554-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321215457.588554-1-yury.norov@gmail.com>
References: <20210321215457.588554-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

find_bit would also benefit from small_const_nbits() optimizations.
The detailed comment is provided by Rasmus Villemoes.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/bitsperlong.h | 12 ++++++++++++
 include/linux/bitmap.h            |  8 --------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
index 3905c1c93dc2..1023e2a4bd37 100644
--- a/include/asm-generic/bitsperlong.h
+++ b/include/asm-generic/bitsperlong.h
@@ -23,4 +23,16 @@
 #define BITS_PER_LONG_LONG 64
 #endif
 
+/*
+ * small_const_nbits(n) is true precisely when it is known at compile-time
+ * that BITMAP_SIZE(n) is 1, i.e. 1 <= n <= BITS_PER_LONG. This allows
+ * various bit/bitmap APIs to provide a fast inline implementation. Bitmaps
+ * of size 0 are very rare, and a compile-time-known-size 0 is most likely
+ * a sign of error. They will be handled correctly by the bit/bitmap APIs,
+ * but using the out-of-line functions, so that the inline implementations
+ * can unconditionally dereference the pointer(s).
+ */
+#define small_const_nbits(nbits) \
+	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
+
 #endif /* __ASM_GENERIC_BITS_PER_LONG */
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 70a932470b2d..8c4adfa5cceb 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -222,14 +222,6 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
-/*
- * The static inlines below do not handle constant nbits==0 correctly,
- * so make such users (should any ever turn up) call the out-of-line
- * versions.
- */
-#define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
-
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-- 
2.25.1

