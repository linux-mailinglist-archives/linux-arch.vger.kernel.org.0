Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9308B350B36
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 02:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhDAAce (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 20:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhDAAcC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 20:32:02 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73508C06175F;
        Wed, 31 Mar 2021 17:32:02 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l13so330187qtu.9;
        Wed, 31 Mar 2021 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HxiIrO7CcOWW+YKPCypAlUNqNdBbXqeX5zuWqSw+DMQ=;
        b=mG22wbdhb7xF2gheTlnlQSG5RK/t7zmbLSOc/ZGUjVeU41jGunxWNr7iwBIa/Vs0LN
         rl3FtoUPOWAo0h3PgE7AQX3+Rm7TLAlYxueffRx70dxy9b0w8VcQ2AFVGSIYlhWhlsRU
         64cQLNksvFeag4Xj9uN+Su4AawXhKWG090Ey+v/zablanyWTP+h9VwzkXjEm8mC/mDNI
         blwvi3jx2o4eds0/zY58cUh2xechNeZ0eyBO0DEAOAgHTOwMZAekKeNn7wdk6QYocaz7
         o32AOtGrp2NgFIjyrjY6XCm/C2a3zhhHR87nRREoYOYODOE2Gbm1e6eVaj4aECIvvvrV
         kmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxiIrO7CcOWW+YKPCypAlUNqNdBbXqeX5zuWqSw+DMQ=;
        b=Z0SsUbtLtsy0qbPTnhLIRe3VU2a3QJgW2K44L1NiviSU8A/uk9ilYv5UOKWE7Ttny+
         ZdQtiFWDY64qXxnukp2aF39dCWL1zFjoVb+j5QbpTKCufhdpzdaoDMt/fh91wOXdYtR9
         V5zF12cF+aRgyUr7TyUN1C7dxSBPW0dVmFSI6qvbAmZT52tB5/14pe17yZdfVo3D74AV
         tsbXZaG2Hperp16Jk+ZMyrq8WX9yIW9bnhcxYQ5oSa+pU8sktQpQIeSVb5aWrd4I3LZ9
         X+2X1VybWX3FNb/ewWa1uD7AHckQsug4KACqvqF0IF4/6vd7qMEXx9j88sdCtjvLvMOS
         1Rkg==
X-Gm-Message-State: AOAM532C84koq1wWwDKrGg4NYciQupU8NpaYQQXYBmCVUqTsoau27CcH
        SJoLc7RTI2DmY7wSuu7YwnQm6vte90qVng==
X-Google-Smtp-Source: ABdhPJyuML+5m6sZfTOHCEwaS3AisYfUUeplssl0OLCVb/nzAAAje0xruiT+nYwBMs7QCiRxzqfGvw==
X-Received: by 2002:ac8:58cb:: with SMTP id u11mr4932645qta.348.1617237121389;
        Wed, 31 Mar 2021 17:32:01 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id v7sm2297774qtw.51.2021.03.31.17.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:32:01 -0700 (PDT)
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
Subject: [PATCH 05/12] lib: extend the scope of small_const_nbits() macro
Date:   Wed, 31 Mar 2021 17:31:46 -0700
Message-Id: <20210401003153.97325-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

find_bit would also benefit from small_const_nbits() optimizations.
The detailed comment is provided by Rasmus Villemoes.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
index 2cb1d7cfe8f9..a36cfcec4e77 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -230,14 +230,6 @@ int bitmap_print_to_pagebuf(bool list, char *buf,
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

