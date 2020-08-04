Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7427E23C0F7
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 22:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHDUr6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 16:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgHDUr5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Aug 2020 16:47:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE8BC06179F
        for <linux-arch@vger.kernel.org>; Tue,  4 Aug 2020 13:47:57 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id gl22so871764pjb.3
        for <linux-arch@vger.kernel.org>; Tue, 04 Aug 2020 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dHVZunjWNtgqB5lbkdr6zaqYDYt1QTvDnOtIriqcITc=;
        b=IcRDT7zzzIHBSrHusZVDx7CrCW5d0Ool2TKTnReHwbPogBD3MyOwpMJUhQBh9rm4zE
         KggyFNCzEGg2EyqxPhl0Rdj+ei5lJGHuVpFnioCjk0lu4FpHBbMIY0hXTCZlDVx8xS2y
         gg2qiILJeCoW2bakXI0ASKjycbngl/i4xgrrPbI7oJnX2At0ZzSzs8tYbm88nKMgIzFi
         QUtVYKZT1PtEZEHWRMRFXfvSMnVMxyhWSvc6SDjylqTY1wys+dgWsWjNvIHevMzZwhmc
         uim5XW7PuDO/fsgl2lCcZB3qPkgUvwi3oQbdYITvhmMQcAOXH+DsMb2PhkXbqFpYzbPW
         9n+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dHVZunjWNtgqB5lbkdr6zaqYDYt1QTvDnOtIriqcITc=;
        b=Qtbxgz+O1d/9X8aJr9MTXbtPWqzr1C6ZdSLfNCvR39Zs+VuC0PC/43iB6gkJFitb7b
         Ile2PmWBhgL6WdWkoS0vZtntMILzexXg/uCAN8O9IcjTEuoBV13nZVtccVVurA7494lS
         tp1LINDLR+Mwpf9pg33wdUfB1NkhdoVdObJWsTSheAiwl8QejA56GaSUpHH12/0ojH4F
         k03TNPJrApZHoL1NY7vuJxwUOAah16ZFOukUxZr7kvb+o3qu1fGJnS9ulUrvtiXXD3Kz
         4sraLs7Wd30YHMqnBpRQilwrz436/nBQz2v477BUBoY1g8QL7ZC10OgS+9XT48LZw6uS
         MToA==
X-Gm-Message-State: AOAM5332lmGf0doUobmDKoKBXaKgUCpBvY7N0lC9vCsxbSIjvHLf0VOE
        pO1dytlfjuKvWVG8ybq4RTvfPaPpWDg9KU+mzZ69nQ==
X-Google-Smtp-Source: ABdhPJwENoSqQnBcQZjPTU6dBdfdbIcq1VZAvgrhVUVDWy8+rfh9R+G9wMEf2JrqW2BY3Wie2Ihd+14wTeL8KeHdO147bQ==
X-Received: by 2002:a63:7f5a:: with SMTP id p26mr207397pgn.117.1596574076050;
 Tue, 04 Aug 2020 13:47:56 -0700 (PDT)
Date:   Tue,  4 Aug 2020 13:47:42 -0700
In-Reply-To: <20200804204745.987648-1-brendanhiggins@google.com>
Message-Id: <20200804204745.987648-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200804204745.987648-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v6 2/5] kunit: test: create a single centralized executor for
 all tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alan Maguire <alan.maguire@oracle.com>

Add a centralized executor to dispatch tests rather than relying on
late_initcall to schedule each test suite separately. Centralized
execution is for built-in tests only; modules will execute tests when
loaded.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Co-developed-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Iurii Zaikin <yzaikin@google.com>
Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/kunit/test.h | 67 +++++++++++++++++++++++++++++---------------
 lib/kunit/Makefile   |  3 +-
 lib/kunit/executor.c | 28 ++++++++++++++++++
 lib/kunit/test.c     |  2 +-
 4 files changed, 76 insertions(+), 24 deletions(-)
 create mode 100644 lib/kunit/executor.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 47e61e1d53370..f3e86c3953a2b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -224,7 +224,7 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
 unsigned int kunit_test_case_num(struct kunit_suite *suite,
 				 struct kunit_case *test_case);
 
-int __kunit_test_suites_init(struct kunit_suite **suites);
+int __kunit_test_suites_init(struct kunit_suite * const * const suites);
 
 void __kunit_test_suites_exit(struct kunit_suite **suites);
 
@@ -237,34 +237,57 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
  * Registers @suites_list with the test framework. See &struct kunit_suite for
  * more information.
  *
- * When builtin, KUnit tests are all run as late_initcalls; this means
- * that they cannot test anything where tests must run at a different init
- * phase. One significant restriction resulting from this is that KUnit
- * cannot reliably test anything that is initialize in the late_init phase;
- * another is that KUnit is useless to test things that need to be run in
- * an earlier init phase.
- *
- * An alternative is to build the tests as a module.  Because modules
- * do not support multiple late_initcall()s, we need to initialize an
- * array of suites for a module.
- *
- * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
- * late_initcalls.  I have some future work planned to dispatch all KUnit
- * tests from the same place, and at the very least to do so after
- * everything else is definitely initialized.
+ * If a test suite is built-in, module_init() gets translated into
+ * an initcall which we don't want as the idea is that for builtins
+ * the executor will manage execution.  So ensure we do not define
+ * module_{init|exit} functions for the builtin case when registering
+ * suites via kunit_test_suites() below.
  */
-#define kunit_test_suites(suites_list...)				\
-	static struct kunit_suite *suites[] = {suites_list, NULL};	\
-	static int kunit_test_suites_init(void)				\
+#ifdef MODULE
+#define kunit_test_suites_for_module(__suites)				\
+	static int __init kunit_test_suites_init(void)			\
 	{								\
-		return __kunit_test_suites_init(suites);		\
+		return __kunit_test_suites_init(__suites);		\
 	}								\
-	late_initcall(kunit_test_suites_init);				\
+	module_init(kunit_test_suites_init);				\
+									\
 	static void __exit kunit_test_suites_exit(void)			\
 	{								\
-		return __kunit_test_suites_exit(suites);		\
+		return __kunit_test_suites_exit(__suites);		\
 	}								\
 	module_exit(kunit_test_suites_exit)
+#else
+#define kunit_test_suites_for_module(__suites)
+#endif /* MODULE */
+
+#define __kunit_test_suites(unique_array, unique_suites, ...)		       \
+	static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
+	kunit_test_suites_for_module(unique_array);			       \
+	static struct kunit_suite **unique_suites			       \
+	__used __section(.kunit_test_suites) = unique_array
+
+/**
+ * kunit_test_suites() - used to register one or more &struct kunit_suite
+ *			 with KUnit.
+ *
+ * @suites: a statically allocated list of &struct kunit_suite.
+ *
+ * Registers @suites with the test framework. See &struct kunit_suite for
+ * more information.
+ *
+ * When builtin,  KUnit tests are all run via executor; this is done
+ * by placing the array of struct kunit_suite * in the .kunit_test_suites
+ * ELF section.
+ *
+ * An alternative is to build the tests as a module.  Because modules do not
+ * support multiple initcall()s, we need to initialize an array of suites for a
+ * module.
+ *
+ */
+#define kunit_test_suites(...)						\
+	__kunit_test_suites(__UNIQUE_ID(array),				\
+			    __UNIQUE_ID(suites),			\
+			    __VA_ARGS__)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
 
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 724b94311ca36..c49f4ffb6273a 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -3,7 +3,8 @@ obj-$(CONFIG_KUNIT) +=			kunit.o
 kunit-objs +=				test.o \
 					string-stream.o \
 					assert.o \
-					try-catch.o
+					try-catch.o \
+					executor.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
new file mode 100644
index 0000000000000..7015e7328dce7
--- /dev/null
+++ b/lib/kunit/executor.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/test.h>
+
+/*
+ * These symbols point to the .kunit_test_suites section and are defined in
+ * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
+ */
+extern struct kunit_suite * const * const __kunit_suites_start[];
+extern struct kunit_suite * const * const __kunit_suites_end[];
+
+#if IS_BUILTIN(CONFIG_KUNIT)
+
+static int kunit_run_all_tests(void)
+{
+	struct kunit_suite * const * const *suites;
+
+	for (suites = __kunit_suites_start;
+	     suites < __kunit_suites_end;
+	     suites++)
+			__kunit_test_suites_init(*suites);
+
+	return 0;
+}
+
+late_initcall(kunit_run_all_tests);
+
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index ccb2ffad8dcfa..918dff400a9d7 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -380,7 +380,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
 	kunit_debugfs_create_suite(suite);
 }
 
-int __kunit_test_suites_init(struct kunit_suite **suites)
+int __kunit_test_suites_init(struct kunit_suite * const * const suites)
 {
 	unsigned int i;
 
-- 
2.28.0.163.g6104cc2f0b6-goog

