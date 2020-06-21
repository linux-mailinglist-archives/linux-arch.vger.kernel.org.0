Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849302028D9
	for <lists+linux-arch@lfdr.de>; Sun, 21 Jun 2020 07:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgFUFmU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Jun 2020 01:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgFUFmT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Jun 2020 01:42:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CBFC061794;
        Sat, 20 Jun 2020 22:42:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id z9so15757018ljh.13;
        Sat, 20 Jun 2020 22:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tehvOPApNmeMIqm7IK8TztXqGsAj0NZyCDwOm9nhvCw=;
        b=L48tYFSPvrIjl+gZGDkayr95niJ8qRhXbt3YiTmUKPTO0HlzOhlF+XTubtPVng4JS1
         +hKUP6o5nSTlxL4XupNrIVH9jo3XJWK4d+yeg+W4Re33YzXNbOXdAkuOW2PqYS1yMvPi
         9DkQCQeSOMiljZOqMzLwUJ/+yhao+RZJFZDT+/klJJiPABXl0OJTn1ulx7MZ+2OYuAIF
         +VFe6nFFhKGir1A1gHiWHtMli2LBhVf6dt1zsg5Vs/vivMZwFgujpP9h7plERUUC9cHT
         CCN+l/7bg6UbIBGUfRhXAu6FIKdwTPHqklZaF3i0M5GnNBPQsRTbOrlRfr96bSVrN4/P
         HJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tehvOPApNmeMIqm7IK8TztXqGsAj0NZyCDwOm9nhvCw=;
        b=D0wf+HjrOXQz6dXXjaOi5JlWfMhF/Z8qCHqEFGNfSaaJJ2o6PPhFYpJtNlDUrrWwiZ
         M8/w18PD7O2Bg3D9zR4ip4mdTaEhZYg9M0jTrhTdTyom8S+02f5obT4aylsvyuU6HnYK
         QYppQJgDi5ImS8dSjxsMc1sqeV/gV4GN+xJSAjZdH44YSLovv4MhSyrxLD4i88JcicmJ
         BEje6MPbzuXLK+QGflg9riyw+iOl9MPdS254UoxkttDwq9+JcXlq5GWvShC1gq5LUZJG
         87xfy25zSctAc7T9eWH8jXgwBF6izjY1Z4HIVzEM+DmVpcmzd1ri64E6JyItLqlvs4bG
         UXrQ==
X-Gm-Message-State: AOAM530q5+ZrSrGWlaMfXkpxd8IVdWsOvHMlnjNVjdafMYfpmXowwv6C
        FEXOPripq6uiec6UTv2KUIUHLtB26Ok=
X-Google-Smtp-Source: ABdhPJzekmsfJ2VdyZeXWRJUYclj6DNFR51L/fFwBGoDDZofJ5mu9yKq88aUgorfsVPecY7f1ohBPA==
X-Received: by 2002:a2e:8783:: with SMTP id n3mr141238lji.224.1592718136480;
        Sat, 20 Jun 2020 22:42:16 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id i22sm1990323ljb.50.2020.06.20.22.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 22:42:15 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, emil.l.velikov@gmail.com,
        geert@linux-m68k.org, keescook@chromium.org,
        linus.walleij@linaro.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        rikard.falkeborn@gmail.com, syednwaris@gmail.com,
        vilhelm.gray@gmail.com, yamada.masahiro@socionext.com
Subject: [PATCH v4 2/2] bits: Add tests of GENMASK
Date:   Sun, 21 Jun 2020 07:42:10 +0200
Message-Id: <20200621054210.14804-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200621054210.14804-1-rikard.falkeborn@gmail.com>
References: <20200620213632.60c2c6b99ec9cf9392fa128d@linux-foundation.org>
 <20200621054210.14804-1-rikard.falkeborn@gmail.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Sorry about the missing MODULE_LICENSE. I assume you just will drop v3
and use this instead, or should I have sent a patch with only
MODULE_LICENSE added?

v3-v4
Added missing MODULE_LICENSE.

v2-v3
Updated commit message and ifdef after suggestion fron Geert. Also fixed
a typo in the description of the file.

v1-v2
New patch.


 lib/Kconfig.debug | 11 +++++++
 lib/Makefile      |  1 +
 lib/test_bits.c   | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 lib/test_bits.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d74ac0fd6b2d..628097773b13 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2186,6 +2186,17 @@ config LINEAR_RANGES_TEST
 
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
index b1c42c10073b..d157f6c980f7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -318,3 +318,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_BITS_TEST) += test_bits.o
diff --git a/lib/test_bits.c b/lib/test_bits.c
new file mode 100644
index 000000000000..89e0ea83511f
--- /dev/null
+++ b/lib/test_bits.c
@@ -0,0 +1,75 @@
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
+
+MODULE_LICENSE("GPL");
-- 
2.27.0

