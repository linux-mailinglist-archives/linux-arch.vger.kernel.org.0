Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB42FDEE9
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 02:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbhAUA6J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 19:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390150AbhAUAI4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 19:08:56 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254CC061793;
        Wed, 20 Jan 2021 16:06:40 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 19so117584qkh.3;
        Wed, 20 Jan 2021 16:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1+v9PN1Uu2cLPRFWSGLmx3QT1L/QFpePD0yoTSiiK0=;
        b=HrQFRw+5hk0kZek6NOt9rxQ2j5aMRX5yWhHyefWYvSFs/+iQKMbRq/2PloSq3xZJgn
         wmbk94fwu0QfRMOInCiScjQrZoypNt1QxmtVmCwVt19G/gDhV2FB6/ZPNuzKCVq+2uxp
         g/1Ay3zC5NzKjiE3zDS4hKEh99dIx/cMvXaT78m25u/0sK5lAwpvO11CypKch466J0jG
         lVj0cHbLboX51SHINKwvXJVtqtvUmf5oNeSORLiisdd9teVI3gEbEHql/ppbzqnNdpOs
         4C9P/bQ0sKAMDvHyf/Vx+VPf+N4Cq9iQ/3k2Jkk4L0sV8yfZGVhoAwpg3rQm4a1U7aP+
         +U0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1+v9PN1Uu2cLPRFWSGLmx3QT1L/QFpePD0yoTSiiK0=;
        b=a/cnYCHf/JJOs9ymVRyI8ofexjmVWk+l/lz683ZM6EoAY5I43AMykuMjQN/+j+0S/E
         ZLrJWFbSB5F7HuoWO1RyumOV+9XN9+l7s7qTu+2TZBoHqEaymNDbvAiz3qLy6zngKPpl
         p/sjx/KmhjlE2W2cQir/ZNuaBOjbvSVFl8+MhGSdresXv+gSwT5VYYWaBkwC1oLHhV+y
         NDpSPSVmKW6fONdvkfX8iyD46SfG8w8vOX/EYCKY7VE5A5tK/Q2HVu25JnDvBjZOSNx7
         3YCgv8XFjk2g5iIJQahdc2K3ay7yPlGkhqK44pGq/n3lrkZUim4UN4/RtCX6kJUsxxMK
         NPxw==
X-Gm-Message-State: AOAM531erY/FAokyJX48/cDPueWJjMIa+kj54pv9owIhFZJteahzEfuH
        SPrsf9urVZJQROFIJB1UjTQ=
X-Google-Smtp-Source: ABdhPJym8sxUBV8IVA+jlYKc3NALcR/rEHBGw31xie5ZX+g9RtMimSfF0h6MmVcZ7xHV+S0h+Ei3+w==
X-Received: by 2002:ae9:e854:: with SMTP id a81mr12180102qkg.77.1611187599372;
        Wed, 20 Jan 2021 16:06:39 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id o64sm2457701qka.43.2021.01.20.16.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 16:06:38 -0800 (PST)
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
Subject: [PATCH 3/6] tools: sync bitops macro definitions with the kernel
Date:   Wed, 20 Jan 2021 16:06:27 -0800
Message-Id: <20210121000630.371883-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121000630.371883-1-yury.norov@gmail.com>
References: <20210121000630.371883-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/include/linux/bitmap.h | 11 -----------
 tools/include/linux/bitops.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 477a1cae513f..266a9291dd1f 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -19,17 +19,6 @@ int __bitmap_equal(const unsigned long *bitmap1,
 		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
 
-#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
-
-#define BITMAP_LAST_WORD_MASK(nbits)					\
-(									\
-	((nbits) % BITS_PER_LONG) ?					\
-		(1UL<<((nbits) % BITS_PER_LONG))-1 : ~0UL		\
-)
-
-#define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
-
 static inline void bitmap_zero(unsigned long *dst, int nbits)
 {
 	if (small_const_nbits(nbits))
diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index 5fca38fe1ba8..1c70919cb216 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -14,6 +14,17 @@
 #include <linux/bits.h>
 #include <linux/compiler.h>
 
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
 #define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
-- 
2.25.1

