Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8BF1F0FA5
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jun 2020 22:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFGUe0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Jun 2020 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGUeY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2020 16:34:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80EAC08C5C3;
        Sun,  7 Jun 2020 13:34:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w15so8914704lfe.11;
        Sun, 07 Jun 2020 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9ZL4bFff5Er8oLhMb1PsGzfxpNMARGPvDA5uII5OY4=;
        b=LVIN/tSzxv2cWcA0R2eBl3l1jsy/nSsTp7IW1zeNPCSNiyk2qFWqQwqAX0uAmzTAMy
         2gNzF4/xU/46W82J2Rb7WSfIXdOgvLGvS0BDr/x/o0vW8EU3h0GuHnLwbLDS3iBB4xe4
         XRwGQJZJgVdbb1qKnanFKqMRwUT/TX/EYzpxSwBquAussft+f47QI3H5DtjRhawjKEmS
         D+TQOpgLB/njNCZzInMUt9R7GHTfEf3i3h2G05h+w4ZM8BEY+1cTF1CUjMxb7okLhur0
         jsq1dvt3UqRNgsRmC3qGOzUV6bkSJGSj1sJ7BmimhGn9a8xqDQAlGbGS5hLHTCGcJQup
         dSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9ZL4bFff5Er8oLhMb1PsGzfxpNMARGPvDA5uII5OY4=;
        b=omQLOVAC7gGjKiLTg9PiupIJ47S2OdLOJWe4nYD/yyhSrUeompXBTnysmP+htmOnCT
         QyoaONlfh13oY4dvRsRZtzGXZQ408scQY5W0jX9oOU15c/wlP1Z0Vb4AXtG49ELwxfPE
         Yod8mIod1vUrABuG+20asHiJ7M7VAMlGV6NiYJROx/aqPGm9gzbhRNcKWCLPSM8P5LYn
         DvTgpQrT44M6jR8ijpO+RZ4RpcPHXWAYJcXNYHrmQF0UOGDW7brw3aeVGpB0N8PQhk9l
         Ek6cX2y1VWTImUAQvcei3SfgD46qWpRi9P+UA9y43g6wvvEzaMd7W20mOTMDwRSXQpSc
         DbGw==
X-Gm-Message-State: AOAM533u4m/HhhXgRDH5nOQnSAIyRd94rNSn8rp08aiQuPBQCsZEhviH
        1LkPkPCGABCEFHIcYPkhqzU=
X-Google-Smtp-Source: ABdhPJwGHNBNkkZzK3/fsKn5e6ePSZAzfGvWtcRBCImjfcpumkzowMl0QclbLOBXt8XpVYc7Z1NDaQ==
X-Received: by 2002:a19:7605:: with SMTP id c5mr10664566lff.213.1591562062408;
        Sun, 07 Jun 2020 13:34:22 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id j133sm3850029lfd.58.2020.06.07.13.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 13:34:21 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, andy.shevchenko@gmail.com,
        arnd@arndb.de, emil.l.velikov@gmail.com, keescook@chromium.org,
        linus.walleij@linaro.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, syednwaris@gmail.com,
        vilhelm.gray@gmail.com, yamada.masahiro@socionext.com
Subject: [PATCH v2 2/2] bits: Add tests of GENMASK
Date:   Sun,  7 Jun 2020 22:34:11 +0200
Message-Id: <20200607203411.70913-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200607203411.70913-1-rikard.falkeborn@gmail.com>
References: <20200604233003.GA102768@rikard>
 <20200607203411.70913-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add tests of GENMASK and GENMASK_ULL.

A few test cases that should fail compilation are provided under ifdef.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
v1-v2
* New patch. First time I wrote a KUnittest so may be room for
  improvements...

 lib/Kconfig.debug | 11 +++++++
 lib/Makefile      |  1 +
 lib/test_bits.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 lib/test_bits.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9bd4eb7f5ec1..1b28ef6bb081 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2170,6 +2170,17 @@ config LINEAR_RANGES_TEST
 
 	  If unsure, say N.
 
+config BITS_TEST
+	tristate "KUnit test for bits.h"
+	depends on KUNIT
+	help
+	  This builds the bits unit test.
+	  Tests the logic of macros defined in bits.h.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 32f19b4d1d2a..77673af9dd11 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -314,3 +314,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_BITS_TEST) += test_bits.o
diff --git a/lib/test_bits.c b/lib/test_bits.c
new file mode 100644
index 000000000000..5bd7a0ef0a3b
--- /dev/null
+++ b/lib/test_bits.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test cases for functions and macrso in bits.h
+ */
+
+#include <kunit/test.h>
+#include <linux/bits.h>
+
+
+void genmask_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1ul, GENMASK(0, 0));
+	KUNIT_EXPECT_EQ(test, 3ul, GENMASK(1, 0));
+	KUNIT_EXPECT_EQ(test, 6ul, GENMASK(2, 1));
+	KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, GENMASK(31, 0));
+
+#ifdef TEST_BITS_COMPILE
+	/* these should fail compilation */
+	GENMASK(0, 1);
+	GENMASK(0, 10);
+	GENMASK(9, 10);
+#endif
+
+
+}
+
+void genmask_ull_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1ull, GENMASK_ULL(0, 0));
+	KUNIT_EXPECT_EQ(test, 3ull, GENMASK_ULL(1, 0));
+	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_ULL(39, 21));
+	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_ULL(63, 0));
+
+#ifdef TEST_BITS_COMPILE
+	/* these should fail compilation */
+	GENMASK_ULL(0, 1);
+	GENMASK_ULL(0, 10);
+	GENMASK_ULL(9, 10);
+#endif
+}
+
+void genmask_input_check_test(struct kunit *test)
+{
+	unsigned int x, y;
+	int z, w;
+
+	/* Unknown input */
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, 0));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, x));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, y));
+
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, 0));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, z));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, w));
+
+	/* Valid input */
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1));
+	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21));
+}
+
+
+static struct kunit_case bits_test_cases[] = {
+	KUNIT_CASE(genmask_test),
+	KUNIT_CASE(genmask_ull_test),
+	KUNIT_CASE(genmask_input_check_test),
+	{}
+};
+
+static struct kunit_suite bits_test_suite = {
+	.name = "bits-test",
+	.test_cases = bits_test_cases,
+};
+kunit_test_suite(bits_test_suite);
-- 
2.27.0

