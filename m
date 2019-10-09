Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54598D1279
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfJIP1g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 11:27:36 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34387 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbfJIP1g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Oct 2019 11:27:36 -0400
Received: by mail-yw1-f65.google.com with SMTP id d192so967329ywa.1;
        Wed, 09 Oct 2019 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BimiSAhIyu/wlnbGZzM5zv98VeK3KGxYKaa4VCWD3vc=;
        b=XhKVN2b3nsHyExn5g3F5i4nQkLizp/ml0iJ6nyIDo8RaY41ylVOc0vRug0oE+UZAge
         i7aiVMFgkmpOpjS+c3EgFzlyN1cpWIrthK7jSW3uToSXKlX6Jhrxju0R21SjsGZRuyKp
         Ga2EQkW+onKg8Z5LYWuREGeksADsfpjrH1z7JxA9BcGLXN0APRwI6mj/NaV9cMwQ5/s7
         vLz1sfqnQZKxpvaGz8S5aITVxusnXfh4S1dYizvCFDbrftaqF0O+58Ig46PBWrt4xcrC
         9uobcnenyu1GareDW34LUr2PUsF4xO+ILnWyjuSck5fNf8YWAoNZs6EPQI4kSCK72LVQ
         1Gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BimiSAhIyu/wlnbGZzM5zv98VeK3KGxYKaa4VCWD3vc=;
        b=IcsVKC1gDfXwBrSk+wcQnLC5qdrAl2jPn2KkAZB1txZOGGxYGjjscvgrAilA+U9Tto
         Ne08m6OqxkfwnmUDVZbRum/FgyJW5LnDUxeNZLDzqUVMB/wBx9xveVRNZo6nZfTSJshE
         57KLSg/jMzv2ydeTbOGoNVrTO2e5ymX9OpSVK3azmBHS3nROub1EpFkb15JrFEWlOSPm
         V3IgxkOmXUblAMfGqvOrIaL7elqxBKDU6ZlEFtoCipR6D7JZgapJh2TG5pHYAl1Cgy+A
         oOsQtFWqpGnZxwP9Sb0VmvXpMTPtAZHv5VMIe9IS0n52EQ+hvKeYM4PGyQVQQ4gXxBhH
         UVdg==
X-Gm-Message-State: APjAAAUhNuRTnM4AptJ+9hsjeEl2tr604oZLmAOozHDLyZZpqU2VEdAP
        UqsK6mDRKvpFtxIz0G9N9GQ=
X-Google-Smtp-Source: APXvYqwFyDfey8Cksi+zaDC4bwYRec4uXM/PDJXCjftXpBCynaS44f28FBJDexcQJTmMprUYCuEbow==
X-Received: by 2002:a81:a303:: with SMTP id a3mr3065880ywh.133.1570634854880;
        Wed, 09 Oct 2019 08:27:34 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g40sm611863ywk.14.2019.10.09.08.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:27:33 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v17 02/14] lib/test_bitmap.c: Add for_each_set_clump8 test cases
Date:   Wed,  9 Oct 2019 11:27:00 -0400
Message-Id: <febc0fb8151e3e3fdd61c34da9193d1c4d7e6c12.1570633189.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570633189.git.vilhelm.gray@gmail.com>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
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

