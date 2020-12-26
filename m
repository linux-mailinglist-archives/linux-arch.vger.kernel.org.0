Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E0F2E2D7C
	for <lists+linux-arch@lfdr.de>; Sat, 26 Dec 2020 07:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgLZGoP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Dec 2020 01:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgLZGoP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Dec 2020 01:44:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19155C061757;
        Fri, 25 Dec 2020 22:43:35 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t8so3476303pfg.8;
        Fri, 25 Dec 2020 22:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iyoEb9hlzKVSkLgnh4OjEYh5GXMeJLzcyE1sgmT2oNw=;
        b=HBGLilEzRM1YUIB6/0O9UCI9EyF+0QbyF6rlcUemBydXuyOLicfuYAXYUzXXD3pQiJ
         mAcK2uyyTZQJa8rFzOd1Qtr21mtzMRckuNrM9Vo0iQswHpGnMpAUMcdDffAqiiojRR+4
         x1jOCXT6OkAVKO+/XueGKTyiHhoWNZzwe7quWxtfunOBFAR4zpn52jJicoaeEFwKSemd
         J9JSujzmWk6BWSphrCmj0sIap/A89Zdd7gdRLsCOnlgJZExLU2MS0/g4O1VTbGF9lih5
         QrGMrmuqnncZuikkZpeQcXKeXVddu9m6vIOoewujH913LH4kxbsopV9yzlWpnHEq5q/7
         5juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iyoEb9hlzKVSkLgnh4OjEYh5GXMeJLzcyE1sgmT2oNw=;
        b=d4nPMam0OoToQB63OWrb0k7/HWkVElM041eeQpbEUE8L9O2IVQCs63h2C3D/FR0eeG
         8PdDGNgIomVDPKaaOAY/6qwEd8drubqjKZGiaxXV0vJU1uEWzxlFUYcUlTMT4W3jpYtb
         ECLYJQKeIrpKY0npI3MlxpTvi1hsIRjp2SApHQ2BsPs81ufGqA05400ZE7LJXSUu0O7s
         n/YZCr2sA6AZczQwmbduxVRGGLwyjPFrwsjvWTviJ56WOJVfZ5RvFB6mAb2MyELyRhPv
         C5skSmXgVZM0icqwZTDjyy0nXIkYs2fbL9s/E+iTFJDeEsNvt/zB+RO0LeQFDGt86ilO
         A7iA==
X-Gm-Message-State: AOAM530mnR/LOMzCsP02/B46UbiqP+gxQqDnki2spXDRO214R2xB/lai
        u95PthKPGOlrqXse8iUVA/w=
X-Google-Smtp-Source: ABdhPJybd4x6OJt+e7SFBzWb/aNHV+0FOGeWbOSyGGpMeoecJkfNNZuyYK82+1v9wkuD2O5pEkw/vQ==
X-Received: by 2002:a65:450d:: with SMTP id n13mr35295197pgq.208.1608965014708;
        Fri, 25 Dec 2020 22:43:34 -0800 (PST)
Received: from syed.domain.name ([103.201.127.53])
        by smtp.gmail.com with ESMTPSA id u3sm7489535pjf.52.2020.12.25.22.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Dec 2020 22:43:34 -0800 (PST)
Date:   Sat, 26 Dec 2020 12:13:18 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-arch@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/5] lib/test_bitmap.c: Add for_each_set_clump test cases
Message-ID: <da4eaafa84f32375319014f6e9af5c104a6153fd.1608963095.git.syednwaris@gmail.com>
References: <cover.1608963094.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608963094.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The introduction of the generic for_each_set_clump macro need test
cases to verify the implementation. This patch adds test cases for
scenarios in which clump sizes are 8 bits, 24 bits, 30 bits and 6 bits.
The cases contain situations where clump is getting split at the word
boundary and also when zeroes are present in the start and middle of
bitmap.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 lib/test_bitmap.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 4425a1dd4ef1..c5b5fb98c9dd 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <../drivers/gpio/clump_bits.h>
 
 #include "../tools/testing/selftests/kselftest_module.h"
 
@@ -155,6 +156,37 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
 	return true;
 }
 
+static bool __init __check_eq_clump(const char *srcfile, unsigned int line,
+				    const unsigned int offset,
+				    const unsigned int size,
+				    const unsigned long *const clump_exp,
+				    const unsigned long *const clump,
+				    const unsigned long clump_size)
+{
+	unsigned long exp;
+
+	if (offset >= size) {
+		pr_warn("[%s:%u] bit offset for clump out-of-bounds: expected less than %u, got %u\n",
+			srcfile, line, size, offset);
+		return false;
+	}
+
+	exp = clump_exp[offset / clump_size];
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
@@ -172,6 +204,7 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
 #define expect_eq_clump8(...)		__expect_eq(clump8, ##__VA_ARGS__)
+#define expect_eq_clump(...)		__expect_eq(clump, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
 {
@@ -530,6 +563,28 @@ static void noinline __init test_mem_optimisations(void)
 	}
 }
 
+static const unsigned long clump_bitmap_data[] __initconst = {
+	0x38000201,
+	0x05ff0f38,
+	0xeffedcba,
+	0xbbbbabcd,
+	0x000000aa,
+	0x000000aa,
+	0x00ff0000,
+	0xaaaaaa00,
+	0xff000000,
+	0x00aa0000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x0f000000,
+	0x00ff0000,
+	0xaaaaaa00,
+	0xff000000,
+	0x00aa0000,
+	0x00000ac0,
+};
+
 static const unsigned char clump_exp[] __initconst = {
 	0x01,	/* 1 bit set */
 	0x02,	/* non-edge 1 bit set */
@@ -541,6 +596,94 @@ static const unsigned char clump_exp[] __initconst = {
 	0x05,	/* non-adjacent 2 bits set */
 };
 
+static const unsigned long clump_exp1[] __initconst = {
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
+static const unsigned long clump_exp2[] __initconst = {
+	0xfedcba,	/* 24 bits */
+	0xabcdef,
+	0xaabbbb,	/* Clump split between 2 words */
+	0x000000,	/* zeroes in between */
+	0x0000aa,
+	0x000000,
+	0x0000ff,
+	0xaaaaaa,
+	0x000000,
+	0x0000ff,
+};
+
+static const unsigned long clump_exp3[] __initconst = {
+	0x00000000,	/* starting with 0s*/
+	0x00000000,	/* All 0s */
+	0x00000000,
+	0x00000000,
+	0x3f00000f,     /* Non zero set */
+	0x2aa80003,
+	0x00000aaa,
+	0x00003fc0,
+};
+
+static const unsigned long clump_exp4[] __initconst = {
+	0x00,
+	0x2b,
+};
+
+struct clump_test_data_params {
+	DECLARE_BITMAP(data, 256);
+	unsigned long count;
+	unsigned long offset;
+	unsigned long limit;
+	unsigned long clump_size;
+	unsigned long const *exp;
+};
+
+static struct clump_test_data_params clump_test_data[] __initdata = {
+					{{0}, 2, 0, 64, 8, clump_exp1},
+					{{0}, 8, 2, 240, 24, clump_exp2},
+					{{0}, 8, 10, 240, 30, clump_exp3},
+					{{0}, 1, 18, 18, 6, clump_exp4} };
+
+static void __init prepare_test_data(unsigned int index)
+{
+	int i;
+	unsigned long width = 0;
+
+	for (i = 0; i < clump_test_data[index].count; i++) {
+		bitmap_set_value(clump_test_data[index].data, 256,
+			clump_bitmap_data[(clump_test_data[index].offset)++], 32, width);
+		width += 32;
+	}
+}
+
+static void __init execute_for_each_set_clump_test(unsigned int index)
+{
+	unsigned long start, clump;
+
+	for_each_set_clump(start, clump, clump_test_data[index].data,
+						clump_test_data[index].limit,
+						clump_test_data[index].clump_size)
+	expect_eq_clump(start, clump_test_data[index].limit, clump_test_data[index].exp,
+						&clump, clump_test_data[index].clump_size);
+}
+
+static void __init test_for_each_set_clump(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(clump_test_data); i++) {
+		prepare_test_data(i);
+		execute_for_each_set_clump_test(i);
+	}
+}
+
 static void __init test_for_each_set_clump8(void)
 {
 #define CLUMP_EXP_NUMBITS 64
@@ -631,6 +774,7 @@ static void __init selftest(void)
 	test_bitmap_parselist();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
+	test_for_each_set_clump();
 	test_bitmap_cut();
 }
 
-- 
2.29.0

