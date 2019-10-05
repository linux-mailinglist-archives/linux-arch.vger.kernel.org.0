Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA22CCC3D
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2019 20:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbfJESha (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Oct 2019 14:37:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46982 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbfJESh3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Oct 2019 14:37:29 -0400
Received: by mail-yw1-f68.google.com with SMTP id h10so562742ywm.13;
        Sat, 05 Oct 2019 11:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMhYgkYYNxK+vsqLS8qdyKHPOIgYu2hPpfb3+C8Zgbc=;
        b=PJp6MpKvrsmtizbGLUocxf+CPZvpLf4KR+nD7xIEA/S2O7B9mF5fhkP4GlIYwh+UxJ
         Hgd1ie0MeIGdmD46NLucfghU9T3pZGhZWd/Rgse8VKwtIf7iug+etAIJ4Zs4sBKXa2mf
         gZepBXAtUGD/xqLZdbas6DegOfQLQOXDLbGpkT7HdlZ3R/aOwAxBicU3nfjYXp6YPb6a
         zPXN0hTW8pW3JNZ8+L57xcgcMIm6hk6n3m/IrGegpRHcsnbUWo8XdMrP7yGPChvsh02k
         ftAGPtOQogH4FZe+DfCIwAoqgiTyCVo2Mjn3yMSIEN9dAFCbstmSqyTb+3HVj7eaOVdR
         E6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMhYgkYYNxK+vsqLS8qdyKHPOIgYu2hPpfb3+C8Zgbc=;
        b=gho8JXGK2dOxdJ7bbYHP1ds2t4W3S9xaTmMNCWUYo4BWxGoMMM5Ej2nksywL7DhDPg
         z+ZPYJ0AVYAnrbOALZINdGsRyiAInn4pFrC0/jTsnS2brT0w/WuCCfNVzGmJwceDWhYz
         KYO3RIrMqfV9Eeqvq5TvtB2Hty+EFrBT33gtnL57mLvVEVf5HX7kY1SRiBvFmyTglQ8W
         RaAUzhl6YxxwPlnwlYanaFFGGfWB7jFVEbJahAdNTtNhtnZGT97nrudTg66FQhx0SMSr
         21Z9Wqe2YFuZ1U61iV2L8ekLmbTTTgn3YYKPUtzo6Kl+70EOqdPw78Y0KTiZAV0E6LAG
         ypTg==
X-Gm-Message-State: APjAAAW8qnnh7KHpTRMRdJhkbr1EQEMNrIo3CRLjNRWANg/BPQy+z2Kk
        2icZFZtqywMkG7SJ6Kv7Ff4=
X-Google-Smtp-Source: APXvYqyJV8InbTPKYGyTe1whvoICAZCq4IaqhS/HYTcmh1dMKcobmoakrPeMl4a2Mk9ZLmm8bvGeKA==
X-Received: by 2002:a81:7703:: with SMTP id s3mr14393586ywc.382.1570300648113;
        Sat, 05 Oct 2019 11:37:28 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g128sm2376654ywb.13.2019.10.05.11.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 11:37:27 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v15 01/14] bitops: Introduce the for_each_set_clump8 macro
Date:   Sat,  5 Oct 2019 14:36:55 -0400
Message-Id: <be63fa49f036b9168f223152648307a63056f4ee.1570299719.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570299719.git.vilhelm.gray@gmail.com>
References: <cover.1570299719.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This macro iterates for each 8-bit group of bits (clump) with set bits,
within a bitmap memory region. For each iteration, "start" is set to the
bit offset of the found clump, while the respective clump value is
stored to the location pointed by "clump". Additionally, the
bitmap_get_value8 and bitmap_set_value8 functions are introduced to
respectively get and set an 8-bit value in a bitmap memory region.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Suggested-by: Lukas Wunner <lukas@wunner.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/asm-generic/bitops/find.h | 50 +++++++++++++++++++++++++++++++
 include/linux/bitops.h            |  5 ++++
 lib/find_bit.c                    | 14 +++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 8a1ee10014de..5277e72882ff 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -80,4 +80,54 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+/**
+ * bitmap_get_value8 - get an 8-bit value within a memory region
+ * @addr: address to the bitmap memory region
+ * @start: bit offset of the 8-bit value; must be a multiple of 8
+ *
+ * Returns the 8-bit value located at the @start bit offset within the @addr
+ * memory region.
+ */
+static inline unsigned long bitmap_get_value8(const unsigned long *addr,
+					      unsigned long start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+
+	return (addr[index] >> offset) & 0xFF;
+}
+
+/**
+ * bitmap_set_value8 - set an 8-bit value within a memory region
+ * @addr: address to the bitmap memory region
+ * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
+ * @start: bit offset of the 8-bit value; must be a multiple of 8
+ */
+static inline void bitmap_set_value8(unsigned long *addr, unsigned long value,
+				     unsigned long start)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+
+	addr[index] &= ~(0xFF << offset);
+	addr[index] |= value << offset;
+}
+
+/**
+ * find_next_clump8 - find next 8-bit clump with set bits in a memory region
+ * @clump: location to store copy of found clump
+ * @addr: address to base the search on
+ * @size: bitmap size in number of bits
+ * @offset: bit offset at which to start searching
+ *
+ * Returns the bit offset for the next set clump; the found clump value is
+ * copied to the location pointed by @clump. If no bits are set, returns @size.
+ */
+extern unsigned long find_next_clump8(unsigned long *clump,
+				      const unsigned long *addr,
+				      unsigned long size, unsigned long offset);
+
+#define find_first_clump8(clump, bits, size) \
+	find_next_clump8((clump), (bits), (size), 0)
+
 #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index cf074bce3eb3..fb94a10f7853 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -40,6 +40,11 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+#define for_each_set_clump8(start, clump, bits, size) \
+	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
+	     (start) < (size); \
+	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
+
 static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 5c51eb45178a..e35a76b291e6 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -214,3 +214,17 @@ EXPORT_SYMBOL(find_next_bit_le);
 #endif
 
 #endif /* __BIG_ENDIAN */
+
+unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
+			       unsigned long size, unsigned long offset)
+{
+	offset = find_next_bit(addr, size, offset);
+	if (offset == size)
+		return size;
+
+	offset = round_down(offset, 8);
+	*clump = bitmap_get_value8(addr, offset);
+
+	return offset;
+}
+EXPORT_SYMBOL(find_next_clump8);
-- 
2.23.0

