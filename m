Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BA731E4E6
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhBREGl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBREGj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:06:39 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE9DC06178A;
        Wed, 17 Feb 2021 20:05:19 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id w20so556630qta.0;
        Wed, 17 Feb 2021 20:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toVAwo2dUrJDJv2KD4vMo0d0JQ5JY+mx3c/7901LESo=;
        b=P/8d8V5t7YyqbVTxXGqOGHiKpVx3UZK9jFy8tU2SBKlS4a1nND7T3fkGy7zGHIjLGL
         v6/QE3RmcMlVgwp6RJ8b0bqOijjDihWLTYw+ZZzJwkYVQ+tdRKWV7cBncWyewwnfK5tG
         S5iCkAXPO0pgQYf0RYrWvCr6eNfh7Uei4e56QD9y64/PA7QDqIohBZrx2PMo8cTSWeNO
         bchDoAdE2Jgg/ONLQ6u+1rnj+m4bmMBK3FjSc/xJHDlhWrAeV952u6ebhi4pPRyX8rO3
         rJmUWgk4k6SEA8kZTpFsfJhv4knvsK22eDvnpesqHmndPxp5Pg/Gc18WDhh1RRjhDckh
         0FQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toVAwo2dUrJDJv2KD4vMo0d0JQ5JY+mx3c/7901LESo=;
        b=BfMo7pC2mvBbVdi2A02JxyhX0g0So03+qr/seoal5NUkkjerCiVlaHoLJg6pszD0HU
         iPXcpl0zp7fEENdsuQpuNkZMRQsLnx1pFuCk5Q7uZi/lVTCOgwsSF6okz2RFh447eojn
         lHDGCcJEH9lzNHBpp2e4hsBDJ4cwglx3KnQOlzfmQtO01q8yen+ncJJzXR3IOWR2di/Y
         sIDu9l/S/OD6GfL4H663ttaT+LB46pF9whkYsw2r9ARSzvvYt3ZqeR0Jko7NsCVZZyxg
         fZhhe6SKsGQkoAFSrltPpzylnS5B1oE5e47x1gr8qWtJ+45OBxKrhU9hSH0P5jvis5gv
         hVGg==
X-Gm-Message-State: AOAM53110TBDWS8/WRUJbjELPBl/9pd04rNj+pi7/hD1bUkapNncougE
        Cj745qnn2tvjYgBqklDr3w7qD55jEQltuQ==
X-Google-Smtp-Source: ABdhPJxlk1mwoh0ClcudKh0i3H1OAdDGVjCtqQj4A2CjLRBilq+sZT8IrEH1d5fv+s/SpCSJ3nE7mA==
X-Received: by 2002:ac8:44d2:: with SMTP id b18mr2562511qto.251.1613621118068;
        Wed, 17 Feb 2021 20:05:18 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id b17sm416159qtq.56.2021.02.17.20.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:17 -0800 (PST)
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
Subject: [PATCH 02/14] tools: bitmap: sync function declarations with the kernel
Date:   Wed, 17 Feb 2021 20:05:00 -0800
Message-Id: <20210218040512.709186-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218040512.709186-1-yury.norov@gmail.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some functions in tools/include/linux/bitmap.h declare nbits as int. In the
kernel nbits is declared as unsigned int.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
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

