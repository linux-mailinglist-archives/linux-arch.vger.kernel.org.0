Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85E2D1547
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbfJIRPS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:15:18 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43569 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731861AbfJIRPR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 13:15:17 -0400
Received: by mail-yb1-f194.google.com with SMTP id y204so973662yby.10;
        Wed, 09 Oct 2019 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BimiSAhIyu/wlnbGZzM5zv98VeK3KGxYKaa4VCWD3vc=;
        b=OUI5SWFPuD/39sTZ5BHs+5gkA5885bfMd++4C7wsx0p/GKfOlJpSvV+mQpj4Vjh+Xl
         dv71rN0hSfP/aQuO7eJlheLjBoL3b29SBkAMHFIvnLwWc0c7q9QxBdkcrK2h0iK70NvI
         dRsv5LFkydnoBw30/UBzQH45OrIqbjv9qILTBaHd9LIr2p1XvsdQIlWwDyE9dFooUiau
         TeliZupE5xBb/j8J2adXzjGCkWl1Wr6CYkK4/4xrX22A6xKxuM1pD+zYvU1v5Q2pLQwU
         hETzdM83pU1URdkHGMj8bxxt2YJ7jKPiG75s1lM6ez1gNZwslXlBTM3DnZwmfVd+ra2B
         JYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BimiSAhIyu/wlnbGZzM5zv98VeK3KGxYKaa4VCWD3vc=;
        b=bSp2cxzuGRhVRrOrfxdpsDEfzV/knAZ+ysyqAvGwrGtI3SRnLdFg4I46SzHpBQGbC5
         I99i8mdxy5KiKQQ4yKoamwh9RwLoVdL7jnAxjUcTWD2cFOBea0ZwLHWuaLqpmsZyvKfo
         aqCXBPJJ9fgBO8TXC2qqKTcaycdIEGPOXnleM7WJqc+EgM3eClmoeiwFRWGmSnijAyGn
         TrGPm8bH09+exUoP11jW/XQX0RELpMap3RnAhQ7pW+AnOsXkSlzZIooOo4IDOwURY9sw
         ch99PaPcMgVij88lAZKbNBkVfPOT6avObrXtWlLEDxXpvYmrL7+mWbsR6WPry56ISV/1
         fozA==
X-Gm-Message-State: APjAAAXx4ClqdNW3hMsG15El7wY0deuQgYZKYyUiVExo/yU0Xf9AWnT7
        bH18fbeUtFaIfknhHzQkC8U=
X-Google-Smtp-Source: APXvYqyU8j677LNnX/pc+uk/WVPDpN26oJyHhTcR3Gxzmmk4vl2QfRgBx9oWN2gA9yQJfDD6KBprNA==
X-Received: by 2002:a25:7401:: with SMTP id p1mr3098750ybc.26.1570641315274;
        Wed, 09 Oct 2019 10:15:15 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id r63sm743292ywg.36.2019.10.09.10.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:15:14 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v18 02/14] lib/test_bitmap.c: Add for_each_set_clump8 test cases
Date:   Wed,  9 Oct 2019 13:14:38 -0400
Message-Id: <febc0fb8151e3e3fdd61c34da9193d1c4d7e6c12.1570641097.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570641097.git.vilhelm.gray@gmail.com>
References: <cover.1570641097.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The introduction of the for_each_set_clump8 macro warrants test cases to
verify the implementation. This patch adds test case checks for whether
an out-of-bounds clump index is returned, a zero clump is returned, or
the returned clump value differs from the expected clump value.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 lib/test_bitmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 51a98f7ee79e..dc167c13eb39 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -92,6 +92,36 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 	return true;
 }
 
+static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
+				    const unsigned int offset,
+				    const unsigned int size,
+				    const unsigned char *const clump_exp,
+				    const unsigned long *const clump)
+{
+	unsigned long exp;
+
+	if (offset >= size) {
+		pr_warn("[%s:%u] bit offset for clump out-of-bounds: expected less than %u, got %u\n",
+			srcfile, line, size, offset);
+		return false;
+	}
+
+	exp = clump_exp[offset / 8];
+	if (!exp) {
+		pr_warn("[%s:%u] bit offset for zero clump: expected nonzero clump, got bit offset %u with clump value 0",
+			srcfile, line, offset);
+		return false;
+	}
+
+	if (*clump != exp) {
+		pr_warn("[%s:%u] expected clump value of 0x%lX, got clump value of 0x%lX",
+			srcfile, line, exp, *clump);
+		return false;
+	}
+
+	return true;
+}
+
 #define __expect_eq(suffix, ...)					\
 	({								\
 		int result = 0;						\
@@ -108,6 +138,7 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
+#define expect_eq_clump8(...)		__expect_eq(clump8, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
 {
@@ -404,6 +435,39 @@ static void noinline __init test_mem_optimisations(void)
 	}
 }
 
+static const unsigned char clump_exp[] __initconst = {
+	0x01,	/* 1 bit set */
+	0x02,	/* non-edge 1 bit set */
+	0x00,	/* zero bits set */
+	0x38,	/* 3 bits set across 4-bit boundary */
+	0x38,	/* Repeated clump */
+	0x0F,	/* 4 bits set */
+	0xFF,	/* all bits set */
+	0x05,	/* non-adjacent 2 bits set */
+};
+
+static void __init test_for_each_set_clump8(void)
+{
+#define CLUMP_EXP_NUMBITS 64
+	DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS);
+	unsigned int start;
+	unsigned long clump;
+
+	/* set bitmap to test case */
+	bitmap_zero(bits, CLUMP_EXP_NUMBITS);
+	bitmap_set(bits, 0, 1);		/* 0x01 */
+	bitmap_set(bits, 9, 1);		/* 0x02 */
+	bitmap_set(bits, 27, 3);	/* 0x28 */
+	bitmap_set(bits, 35, 3);	/* 0x28 */
+	bitmap_set(bits, 40, 4);	/* 0x0F */
+	bitmap_set(bits, 48, 8);	/* 0xFF */
+	bitmap_set(bits, 56, 1);	/* 0x05 - part 1 */
+	bitmap_set(bits, 58, 1);	/* 0x05 - part 2 */
+
+	for_each_set_clump8(start, clump, bits, CLUMP_EXP_NUMBITS)
+		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -413,6 +477,7 @@ static void __init selftest(void)
 	test_bitmap_parselist();
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
+	test_for_each_set_clump8();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.23.0

