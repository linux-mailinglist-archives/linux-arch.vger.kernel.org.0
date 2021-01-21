Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94BC2FDE43
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 02:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbhAUA5x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 19:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388272AbhAUAI4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 19:08:56 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05450C0613ED;
        Wed, 20 Jan 2021 16:06:39 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h19so350990qtq.13;
        Wed, 20 Jan 2021 16:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLzDDsb43NyMx0AvE6OrGjVNnyH2PAQsA/iidjpcD/E=;
        b=OuPs6iN5DNL3e4a0wi5/M6GUhCYOFv7vYm1pW29MUWITn3Ao17PBRlFphOLfb3AUP+
         wKADPHJSHBkrXY4UDmFXuOvgHOXchkk29iQt0nVWV9qbWTLdP77KQvv5NN2Wb1IB1y7b
         ZZUncR1F1faGkm6WPt7F0fSGjuOiLMJnGzO4oJcaXYVGCnN5sxABXgW6RP2Y1//7cNnb
         LhpozcCLY74/7m17FnqAiOlE8DsDMlPCOJ1dwy3tIrkvTPUrH/fB26MEePjjPBQu9IN/
         Aqaf3PT7zLl29GgzKBepaIswcL4foYFDUdA2q6byv/7VGw3LH4xsxn1htTa1AOLu1Jpt
         v2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLzDDsb43NyMx0AvE6OrGjVNnyH2PAQsA/iidjpcD/E=;
        b=Qo8UXQMBYtHDYD/sDq+/ZJ49zRnUKux+/rOh/dwUIvCEMKqH2XoDSRLWlNMYZqLkHZ
         B3C7PxhEW0p9r3UtijSqAsAQrCeJJXp/pVBvdgp76Nzo4NJpiCeTPICJiU5ykyk1EOCm
         ZzVHJDRxiMXza8q1WX6yAfwrYyrLZL/GD0iEsDVbb8xRg1kb0Im2OdrPAzCzG5rjbSiW
         JZxfnRPT5C252IZrAjM1xI4alxJMNdONxB8Q/BFuaYz84fb0G/wjKusDQlSbajPQA0Hi
         Ag7zbzphDzwYRkiYNJRJggj+Z9I0Xf6I+o6WMnMAEhhO1yG7kV/7cz/yQv+DZ2Vz22Xy
         UZrg==
X-Gm-Message-State: AOAM531PoZTRGb/XmGCBlfLgNu+8x4KtwKDNcQy547wXHyGyjDAUR/5/
        9GcpRk6DFFppE4de0HDZDMc=
X-Google-Smtp-Source: ABdhPJzDAtae1ksWkHrhXovCS3XTS6Wj+QkJyM8BOP2ByMYHXOIPvEX7HVJIB1jrXMK8dV5JEOtqng==
X-Received: by 2002:ac8:36e2:: with SMTP id b31mr11511989qtc.19.1611187598218;
        Wed, 20 Jan 2021 16:06:38 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id b12sm2346703qtt.74.2021.01.20.16.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 16:06:37 -0800 (PST)
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
Subject: [PATCH 2/6] bitmap: move some macros from linux/bitmap.h to linux/bitops.h
Date:   Wed, 20 Jan 2021 16:06:26 -0800
Message-Id: <20210121000630.371883-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121000630.371883-1-yury.norov@gmail.com>
References: <20210121000630.371883-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In the following patches of the series they are used by
find_bit subsystem.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 11 -----------
 include/linux/bitops.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 70a932470b2d..5bacbc8785eb 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -219,17 +219,6 @@ extern unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int
 extern int bitmap_print_to_pagebuf(bool list, char *buf,
 				   const unsigned long *maskp, int nmaskbits);
 
-#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
-#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
-
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
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index a5a48303b0f1..a0e138bbb8ce 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -7,6 +7,17 @@
 
 #include <uapi/linux/kernel.h>
 
+#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
+#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
+
+/*
+ * The static inlines below do not handle constant nbits==0 correctly,
+ * so make such users (should any ever turn up) call the out-of-line
+ * versions.
+ */
+#define small_const_nbits(nbits) \
+	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
+
 /* Set bits in the first 'n' bytes when loaded from memory */
 #ifdef __LITTLE_ENDIAN
 #  define aligned_byte_mask(n) ((1UL << 8*(n))-1)
-- 
2.25.1

