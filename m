Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4060EF18
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 06:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiJ0EiX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 00:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiJ0EiR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 00:38:17 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A7314C526;
        Wed, 26 Oct 2022 21:38:16 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id l9so88973qkk.11;
        Wed, 26 Oct 2022 21:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjKP27biUqpnASva4/HbDerbIo+s90SIvtbYwBYn4Ec=;
        b=V64zp136AR+C+6AuSHFdXTgRD3nrSrJqfP0fnnxtMQ79w5MkfdPVs24tQJQ59bv3Bf
         qLxVvbHqcpKGqFURxiYyChFTvug7KGhBrSRMTSJeW4eW2K+qg/vzk3Kovv/scdmXygPb
         0Pz3bm/T06kd5E8DH1mZ/OMP/V029pAp7RC9Rs6KlY4y1dJU4hX43r6Gpcjp2nDsM0OV
         TlVUAtW6/gPVSJPou7/WCUK57e9CwlxnPfjLQiOv610kut0ljLKfBPkMp0Jth2guFhsM
         +ih5ammstBTlFtaFNnc2VLjoJaAm/ceS0QOAYBWdVdjc/ojSI3Knm9MgB4/SVCKPhHRb
         HczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjKP27biUqpnASva4/HbDerbIo+s90SIvtbYwBYn4Ec=;
        b=IPWGNISNGYRbO3VZcPMh5nlGOypP6jJzxFmNPoso5ZXjLjKcH+AHsgnNdlVCROtMmR
         nnYe9VJFLesf2ImD3mC1svmqmaFxAzYNrHY6V/tN51YvSqAsz8ZdgV6qwkBcw4OVM78P
         0hkdsNDFtBda/gOYugu6GnizrK3uh3I/0ZaHTUouS+cVDmOjXLkuNlfNy3Jc5nmZtmuo
         ULT1IZoqCshy5A5NmD/gR+b2nvz5Kto6NdyNhOQVwKSAYst9eq4nqTv6sFH0C8WMYlTh
         ckt86WZI5SsC3WpDH1K/Gpw2aqVc3mvXFlo3tdQwOw/s4RkxVRZQi7R6NduGCo0oDjP5
         5Agw==
X-Gm-Message-State: ACrzQf2dlo28gB2+OyZ+tYBu3VkkYxCU/S9dwUQQ6A4s6EydnCXUkW48
        YbH356t+FnK0QG2gALtLpvIKFqXUpOc=
X-Google-Smtp-Source: AMsMyM4FSm6Y5OgB3shikwKk/UQiaBgf5vmw9hV4ppqu4h0N4YSjPx0uG/RtaTagJQg2sahRIo2bxA==
X-Received: by 2002:a05:620a:8016:b0:6ee:9481:9298 with SMTP id ee22-20020a05620a801600b006ee94819298mr33101206qkb.251.1666845495725;
        Wed, 26 Oct 2022 21:38:15 -0700 (PDT)
Received: from localhost ([2601:589:4102:7400:ade5:9c32:44f6:bc7d])
        by smtp.gmail.com with ESMTPSA id dm45-20020a05620a1d6d00b006e8f8ca8287sm308781qkb.120.2022.10.26.21.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:38:15 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/3] bitmap: improve small_const case for find_next() functions
Date:   Wed, 26 Oct 2022 21:38:09 -0700
Message-Id: <20221027043810.350460-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027043810.350460-1-yury.norov@gmail.com>
References: <20221027043810.350460-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

find_next_bit() and friends use small_const_nbits() to detect possibility
of compile-time optimization. It works well for nbits up to BITS_PER_LONG,
i.e. for 1-word bitmaps. When nbits belongs to 2nd, 3rd or any other word,
small_const_nbits() returns false.

But when both offset and size are within the same word boundary, we still
can make a small_const optimization because the whole business is just
fetching a single word, and masking head and tail bits if needed.

This patch adds a new small_const_nbits_off() macro doing that. It replaces
small_const_nbits() in find_next_bit() functions.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitsperlong.h | 12 +++++++++
 include/linux/find.h              | 45 ++++++++++++-------------------
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
index 1023e2a4bd37..c294ff798154 100644
--- a/include/asm-generic/bitsperlong.h
+++ b/include/asm-generic/bitsperlong.h
@@ -35,4 +35,16 @@
 #define small_const_nbits(nbits) \
 	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
 
+/*
+ * small_const_nbits_off(nbits, off) is true precisely when it is known at
+ * compile-time that all bits in range [off, nbits) belong to the same word.
+ * Bitmaps of size 0 are very rare, and a compile-time-known-size 0 is most
+ * likely a sign of error. They will be handled correctly by the bit/bitmap
+ * APIs using the out-of-line functions, so that the inline implementations
+ * can unconditionally dereference the pointer(s).
+ */
+#define small_const_nbits_off(nbits, off) \
+	(__builtin_constant_p(nbits) && __builtin_constant_p(off) && (nbits) > 0 && \
+	 (nbits) > (off) && (off) / BITS_PER_LONG == ((nbits) - 1) / BITS_PER_LONG)
+
 #endif /* __ASM_GENERIC_BITS_PER_LONG */
diff --git a/include/linux/find.h b/include/linux/find.h
index db2f2851601d..df5c4d1adf4c 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -7,6 +7,7 @@
 #endif
 
 #include <linux/bitops.h>
+#include <linux/math.h>
 
 unsigned long _find_next_bit(const unsigned long *addr1, unsigned long nbits,
 				unsigned long start);
@@ -49,14 +50,11 @@ static __always_inline
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
-	if (small_const_nbits(size)) {
-		unsigned long val;
+	if (small_const_nbits_off(size, offset)) {
+		unsigned long val = addr[offset/BITS_PER_LONG] &
+				    GENMASK((size - 1) % BITS_PER_LONG, offset % BITS_PER_LONG);
 
-		if (unlikely(offset >= size))
-			return size;
-
-		val = *addr & GENMASK(size - 1, offset);
-		return val ? __ffs(val) : size;
+		return val ? round_down(offset, BITS_PER_LONG) + __ffs(val) : size;
 	}
 
 	return _find_next_bit(addr, size, offset);
@@ -79,14 +77,11 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
 {
-	if (small_const_nbits(size)) {
-		unsigned long val;
+	if (small_const_nbits_off(size, offset)) {
+		unsigned long val = addr1[offset/BITS_PER_LONG] & addr2[offset/BITS_PER_LONG] &
+				    GENMASK((size - 1) % BITS_PER_LONG, offset % BITS_PER_LONG);
 
-		if (unlikely(offset >= size))
-			return size;
-
-		val = *addr1 & *addr2 & GENMASK(size - 1, offset);
-		return val ? __ffs(val) : size;
+		return val ? round_down(offset, BITS_PER_LONG) + __ffs(val) : size;
 	}
 
 	return _find_next_and_bit(addr1, addr2, size, offset);
@@ -110,14 +105,11 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
 		const unsigned long *addr2, unsigned long size,
 		unsigned long offset)
 {
-	if (small_const_nbits(size)) {
-		unsigned long val;
+	if (small_const_nbits_off(size, offset)) {
+		unsigned long val = addr1[offset/BITS_PER_LONG] & ~addr2[offset/BITS_PER_LONG] &
+				    GENMASK((size - 1) % BITS_PER_LONG, offset % BITS_PER_LONG);
 
-		if (unlikely(offset >= size))
-			return size;
-
-		val = *addr1 & ~*addr2 & GENMASK(size - 1, offset);
-		return val ? __ffs(val) : size;
+		return val ? round_down(offset, BITS_PER_LONG) + __ffs(val) : size;
 	}
 
 	return _find_next_andnot_bit(addr1, addr2, size, offset);
@@ -138,14 +130,11 @@ static __always_inline
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
-	if (small_const_nbits(size)) {
-		unsigned long val;
+	if (small_const_nbits_off(size, offset)) {
+		unsigned long val = addr[offset/BITS_PER_LONG] |
+				    ~GENMASK((size - 1) % BITS_PER_LONG, offset % BITS_PER_LONG);
 
-		if (unlikely(offset >= size))
-			return size;
-
-		val = *addr | ~GENMASK(size - 1, offset);
-		return val == ~0UL ? size : ffz(val);
+		return val == ~0UL ? size : round_down(offset, BITS_PER_LONG) + ffz(val);
 	}
 
 	return _find_next_zero_bit(addr, size, offset);
-- 
2.34.1

