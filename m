Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDDB33CB0C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 02:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhCPBzF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Mar 2021 21:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhCPByc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:54:32 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE071C061762;
        Mon, 15 Mar 2021 18:54:31 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id l132so33802477qke.7;
        Mon, 15 Mar 2021 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toVAwo2dUrJDJv2KD4vMo0d0JQ5JY+mx3c/7901LESo=;
        b=iDbq6Pg9hPkYtWVyqCNtXDjG0T8uIzF1ajhpxTH2vtEikCMyAcuI4lHBg02/I9Oxhq
         YXR8zIlyTYxG6QFMsgngaRmFrp9tyJx9kYvLf7B8nSLnSW8oBSY591O+TkVeaX+0pMUh
         iL+RELn7L93DXDqGTOIGHsjyuFdS56RhOKSJkBPb4Go1DRipSEoYhkijl78l4j5ZnKjy
         Ca189D3EHEWKoolMPh3q0v7amLttAFiLjCWFApGi83e6t4O898XcJ81TMUss9p5C4Y8z
         niF7EUgy6sAO0mXsBhrdA+4akUCRQyMuR0MXBTSxYcpZcMTj32EDuDO5FZThl8qn3SuG
         fDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toVAwo2dUrJDJv2KD4vMo0d0JQ5JY+mx3c/7901LESo=;
        b=f38jDetUByGADDvvtRxTghDUpGURYddpfetr3Ei+nEHQMn3peOoXCb5TOR9oj9ep98
         7vmZlb6eJ2vfLUGtBEEqM6cRJ5yZ+2EzmSUVw0omvuj0HmsMxA3kCroD4GdqpSOIl98h
         SdYg7G0p9HT61UqNvQrR1esx4oa7z+clepnuw7WxA98v3evw0escfDDeUiuxecL4SbJ+
         E8T4DJt2h4mR9++zdAtcp+RHkvMMojq9UTIX9QiEWgWYW6FiTgLOT+AaJ+FYKS+Aj8c2
         qXqZo4osWGiv9b86ehPD1/QVX709bhu90GB0AwzXdinZn4343mHY9T+rCfLE2n4arvLw
         pg9g==
X-Gm-Message-State: AOAM533qsc5GYR+RK9hi8DfQf+jELlUw7POQ6tUtXHXSJXF7IkpttPzg
        Ch3S5IiOL3hRJgM5hs48tqtlLFgVss0=
X-Google-Smtp-Source: ABdhPJzRyYVyVXZgRJpjlcMOsbLIiyVQHSTf+jURPkmkc5NUSgvFeMkwAVlTW5ljBhdUcykRAbxE8w==
X-Received: by 2002:a37:8181:: with SMTP id c123mr28281911qkd.287.1615859670915;
        Mon, 15 Mar 2021 18:54:30 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id z11sm14421596qkg.52.2021.03.15.18.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:54:30 -0700 (PDT)
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
Subject: [PATCH 02/13] tools: bitmap: sync function declarations with the kernel
Date:   Mon, 15 Mar 2021 18:54:13 -0700
Message-Id: <20210316015424.1999082-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316015424.1999082-1-yury.norov@gmail.com>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
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

