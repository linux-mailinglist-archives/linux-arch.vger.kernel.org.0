Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7099E3097EB
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 20:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhA3TS0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 14:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhA3TSW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jan 2021 14:18:22 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAAFC061786;
        Sat, 30 Jan 2021 11:17:25 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id k193so12240361qke.6;
        Sat, 30 Jan 2021 11:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2CBpM36CKPcILYu8sXZ1CztyX6+qGTuXq4AcfgGl6g=;
        b=vJTyA2udD7/v8oVbqLlFUt5tBror7ax+W68lXGM6ozPraqNQ08iH/i0WABGbx+C2K8
         UGaSOTdXmFOHvqKtllGk/XmztCWe1n7JwyhW2e+kIKu1SsqbnYL7mOUoV3UEH7zqV+ua
         hRe6xMwNDMefJ4REHPh/BcE0AAHMweai6DplGu0gvZ8RCHeTrwA1AWjFz0MFT58XNrG8
         gY7LhSefF/sbisJI6u+k5BJTEc/PC/sAYbiioSlAIOd2JeLXCXDIi85XvM7WjrQHZu61
         NmH32dANU/NR4tTX4/S5PVvZXNP+1B6Fp+VUvzg7QuIff82vYvYCukDZ9Dkzb2ORCSd3
         oVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2CBpM36CKPcILYu8sXZ1CztyX6+qGTuXq4AcfgGl6g=;
        b=BwiaLvXNJEwSlEVOKrj9ZW2IRAj1nxtgnU5+0PkxlmDmrxv51JHjr4U/fVWp5gv8aP
         +xj13Npe6fdQnheQrXhxJR28H6umDKshOJa0oyYzhuOwAodG8+5SCWUE6mRRUWB9DGay
         6j7qgVluo9bZR+G1FdxOR9dG0oxp/g2tu7co/oXWrGdlFQfU8mFGHASwvp1HWw9/p9QU
         srvYhw207OI2RefZx15HAd5T87SFQ4l4PbV/IOvrkXgF9m2hlthDepWhY8Rjq+dG+UaU
         RjomNfBZju4OUsoyENaTGayY+GWP6GSsoCTp3FCBFCFUZPGNRXyMpM21S/qsEtQQGNKC
         OjHw==
X-Gm-Message-State: AOAM532ARiXnmxo/p3UehDSEHhuHzLtqu1HfNZ0mMYlrx9Y7WbWNiiUv
        zwJz8AQcDyxfei1fa80OuFc=
X-Google-Smtp-Source: ABdhPJxL11455yjqeqIHGP6eQ90ytr5vBJbwcR5zLyqJ3kJHTmkzO+CXdzw55cPd8mNKxAPW3u9yWg==
X-Received: by 2002:a05:620a:5b4:: with SMTP id q20mr9818771qkq.218.1612034244786;
        Sat, 30 Jan 2021 11:17:24 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id p188sm8779366qkf.89.2021.01.30.11.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 11:17:24 -0800 (PST)
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
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 2/8] tools: bitmap: sync function declarations with linux kernel
Date:   Sat, 30 Jan 2021 11:17:13 -0800
Message-Id: <20210130191719.7085-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210130191719.7085-1-yury.norov@gmail.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some functions in tools/include/linux/bitmap.h declare nbits
as int. In the kernel nbits is declared as unsigned int.

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

