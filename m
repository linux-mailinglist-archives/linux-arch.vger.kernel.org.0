Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB351F21C5
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 00:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgFHWSe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jun 2020 18:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgFHWSd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 18:18:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F62C08C5C3;
        Mon,  8 Jun 2020 15:18:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r125so11190926lff.13;
        Mon, 08 Jun 2020 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3cj4YRriK6RG2zO+1VlCMmTo55/LdEBC06tW7WJo9oc=;
        b=Ejr4QghZfg7ORiC6TAW55v4FZzVyc7T9LothiKRr5uPhJC+4RtkJ/vTPx0tTkxa4Yc
         e0VmKf29I5onAa+vj3jKRSS8X1LJCUYOoEnn3/t+aLfyOeY4PjPnGZH9VytJRDoimWRV
         W8hF+pM8u5X55tWNnw577pfDTPAaALWDq6475dpUfJtmoebxylNrWW1z7twPpDzLY0vF
         BOcC9qG4EEDf2BRuxvacrsbVBvH8SBrxsJq1n4gU1kR3qpRqeUDQyFG/yk/F/BxI2AV6
         ZYAeDyUhBVGUzd0gK0fwergPdFSjTjX7+ddDOzVVpwmSwXWwb6IG7yFlaa5iWavTapvZ
         dCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cj4YRriK6RG2zO+1VlCMmTo55/LdEBC06tW7WJo9oc=;
        b=Jw3QmkCCnQQzErNjRJnpx9ndwExvPIa3jZS8WRm4pcCpd0pBC4Q2+wMsimjqG7TAgY
         wjx/X9e26RJXSVqbvCaW7s09OAjo7Y/2WlmnQRcMjVb+dzUsoxiGH+YmLKq2QpZ+XvgF
         OGC8yGoNdOkLfjGYl5f8YJB7smPeCydecACaZlukCuG34+gKYkJsPtIM4h2m7R9P27HQ
         oDmPczpZTcE1w+omiBcKvFQLcD26Fbv5500Osx0fHYob3BBpMBDCdnhywkz3fi2lNLPB
         6WoDvmjlSAsRJdTQ91KvFZqZ0HXFbCpXsYAOsKZLLMjUw1KPH+cfg9soW1YpuWiHN/Mo
         CMng==
X-Gm-Message-State: AOAM532i/bNNqxKFeg0FK2UEgr8L7jFs3AQXaC6TwPne5hGFai3M5mMg
        6eHw58aQw0mO8z04KdZ4MsNOSfSoLLQ=
X-Google-Smtp-Source: ABdhPJxOVzHt7OGf4JQ/FA1hUGewxMnqHBONXLD4NI04VY1UulUbPCgAR9/lRZYz74qTjaANihgjFg==
X-Received: by 2002:a05:6512:110e:: with SMTP id l14mr12917094lfg.25.1591654709878;
        Mon, 08 Jun 2020 15:18:29 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id n1sm3966237ljg.131.2020.06.08.15.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 15:18:29 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, andy.shevchenko@gmail.com,
        arnd@arndb.de, emil.l.velikov@gmail.com, geert@linux-m68k.org,
        keescook@chromium.org, linus.walleij@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, syednwaris@gmail.com, vilhelm.gray@gmail.com,
        yamada.masahiro@socionext.com
Subject: [PATCH v3 2/2] bits: Add tests of GENMASK
Date:   Tue,  9 Jun 2020 00:18:23 +0200
Message-Id: <20200608221823.35799-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200608221823.35799-1-rikard.falkeborn@gmail.com>
References: <20200608184222.GA899@rikard>
 <20200608221823.35799-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add tests of GENMASK and GENMASK_ULL.

A few test cases that should fail compilation are provided
under #ifdef TEST_GENMASK_FAILURES

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
I did not move it to test_bitops.c, because I think it makes more sense
that test_bitops.c tests bitops.h and test_bits.c tests bits.h, but if
you disagree, I can move it.

v2-v3
Updated commit message and ifdef after suggestion fron Geert. Also fixed
a typo in the description of the file.

v1-v2
New patch.

 lib/Kconfig.debug | 11 +++++++
 lib/Makefile      |  1 +
 lib/test_bits.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 lib/test_bits.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 333e878d8af9..9557cb570fb9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2182,6 +2182,17 @@ config LINEAR_RANGES_TEST
 
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
index 315516fa4ef4..2ce9892e3e63 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -314,3 +314,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_BITS_TEST) += test_bits.o
diff --git a/lib/test_bits.c b/lib/test_bits.c
new file mode 100644
index 000000000000..e2fcf24463bf
--- /dev/null
+++ b/lib/test_bits.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test cases for functions and macros in bits.h
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
+#ifdef TEST_GENMASK_FAILURES
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
+#ifdef TEST_GENMASK_FAILURES
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

