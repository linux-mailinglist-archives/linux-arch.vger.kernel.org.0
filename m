Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBF9CD2A2
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2019 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfJFPLi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Oct 2019 11:11:38 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38276 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfJFPLh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 11:11:37 -0400
Received: by mail-yb1-f194.google.com with SMTP id k10so614677ybs.5;
        Sun, 06 Oct 2019 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BimiSAhIyu/wlnbGZzM5zv98VeK3KGxYKaa4VCWD3vc=;
        b=AKeWAJ7aA2PXvljZVsU+pEzFXbslhbblSurq4szOpIExNDWN0oOkOtHRo9yp/WiB5Y
         ff4g4nubB+suu8qFOUOmznUS4umGnlwm/sor1h+Uipqp36Q3OJSiXi2mCLqAnNKu78q0
         qKWbBuk3OVYKWkPwl0kLIiZ91GxnifeqUZDBk/u8R1Ky8V1YjngFOUkoRFa3fhiZGf91
         LhFCg13/R6Uwiga5dv2ozmD2mwtk16Qu2y+5GJbJYoKA0n4T/Ea+Mvip/ceaQSmHiw2d
         AT3BNgRPWn1XMWgQ/h4AZBtUBvDeok74osQKLHk2tR8Vnsc5kjDxvjc/SC23L4SOaTXB
         JKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BimiSAhIyu/wlnbGZzM5zv98VeK3KGxYKaa4VCWD3vc=;
        b=mJW+G18uoRJppHKbWeVmxueavXhc3TacVqckhEBt6CgYeyB8yUKrp1ONq7X65i6M8k
         0c/Xq255Y33DbEHYTvdXpdP8zCy1imHkgw9rkTE+YDG7pMwFvH+XRc8l5vQIrvH2aBxl
         BVZSIlX6DDk0AwUBbvT41XbYG5FxZHggE7JLjIxFMmC7jV/MtFSHU0ksWxAVkdC3LyQT
         fal/Iwhn2NJGN7eE1BsGoZERYftWaUywjtoN2A2hLVpUztGTs/TgNFeBICTYNjx38zMp
         QJF/VUkviVWyAooiPcTf507eBXgIbh+TCHIKv9aIsWuKhlIimnoeJMkkiN8NzScNQHTn
         A0TA==
X-Gm-Message-State: APjAAAVOjD5WAvPh+Dn3IR5fipsAZbGPmL99SGOlItjotfUh7/al1RRF
        qekkB9VoMetzl+Z5IUWJlyA=
X-Google-Smtp-Source: APXvYqyikexpni3X8Md6iVbAyTaBv894xbXgE9Vg/89s2NUfaHSQgnO977TuYCryD6LxmKVQ2LKGlg==
X-Received: by 2002:a25:2507:: with SMTP id l7mr8836043ybl.20.1570374696030;
        Sun, 06 Oct 2019 08:11:36 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id e82sm2662434ywc.43.2019.10.06.08.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 08:11:35 -0700 (PDT)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v16 02/14] lib/test_bitmap.c: Add for_each_set_clump8 test cases
Date:   Sun,  6 Oct 2019 11:10:59 -0400
Message-Id: <68a64acf894cda2ccdacabbb808d23486613a095.1570374078.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570374078.git.vilhelm.gray@gmail.com>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
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

