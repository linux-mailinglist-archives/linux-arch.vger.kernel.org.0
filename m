Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10EB14B03D
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2020 08:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgA1HUY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jan 2020 02:20:24 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35072 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgA1HUX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jan 2020 02:20:23 -0500
Received: by mail-pl1-f202.google.com with SMTP id v24so5186431plo.2
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2020 23:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x21YpalL5LqlkKKEeVGB+luOjkPbn8cAXCEug2TWCEA=;
        b=deUb+DwpQVonoSZCKQnNTMlQP1Lzh1009+cKfs6ixetvyNNornOu8L8iM6sZCZ1EC1
         bCYKufynjbeJXB6mQT5N+rQ80MPGb6Nq5LxtLqw1EuzUInMPOHZLMLJQ323CsWtY+qRE
         PduOjLakiWcWsm/JYl4yujyUNYWxhK0XgnSWANlyb1HuHAZgoChlWDq7l5tRx8kO1hZP
         x/+VkMiuaIhKU7O6AkPyqp1FNycJUgjxozfO017LW7yTyFL7y/BKWCid/0DmbvkwswzZ
         YPaYbO36+IuwVWKxpgvicBc9UUtmiORlykMio3a9p3WNgoru1bsLQuNnqQw72KkQ0tZ+
         pqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x21YpalL5LqlkKKEeVGB+luOjkPbn8cAXCEug2TWCEA=;
        b=Nc+WobOMtJpKQisJF9ZPm/pFTTVkw2tpZigughw+T/g04iIDeC0yJK8MofmxN8xjor
         tv0jW/svQ+ZKiV70CI0HF9N8+mFLVqalnK0jHTOHfCHY4KQd41sYWw6FTexctekC3ZLO
         +huUylDX9VC5Q7rLZGb6zhjp1pOW0XqzanyhOh6vP1eHHVlYfZMEwhiBiXvvCpwu5NhW
         tIPTjYdgtV0IW9V8S+AD4etQqwHqCuqCeHmniRyYpLbOF85xGy0x/UdclP+WYcxrA0xs
         QmUL9wH1lISm3ZFesBcdh+Q0NLhIXaInjcuuZ+vi0yadPaddgs622LRMCkLHw6YoEAcP
         fAEA==
X-Gm-Message-State: APjAAAXr61O0aYiRcZsWjyQVHYN5gWnIT3XJXsq0I7lJsHegFqlcA/IX
        ub2EIrE77zkiQaSL2B4zuzyeuPhOu4q2zzCUlodvUw==
X-Google-Smtp-Source: APXvYqyvri48GJhohjVjB6m2tpDcRRU9UPGKXCS7KBHLle1mVLavQCKm9xsShmoyxHcy6AoDRroUfoljdTGdalDX7CBaZQ==
X-Received: by 2002:a65:5608:: with SMTP id l8mr24168134pgs.210.1580196022999;
 Mon, 27 Jan 2020 23:20:22 -0800 (PST)
Date:   Mon, 27 Jan 2020 23:19:58 -0800
In-Reply-To: <20200128072002.79250-1-brendanhiggins@google.com>
Message-Id: <20200128072002.79250-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 3/7] kunit: test: create a single centralized executor for
 all tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
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
late_initcall to schedule each test suite separately.  Centralized
execution is for built-in tests only; modules will execute tests
when loaded.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Co-developed-by: Iurii Zaikin <yzaikin@google.com>
Signed-off-by: Iurii Zaikin <yzaikin@google.com>
Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 73 +++++++++++++++++++++++++++-----------------
 lib/kunit/Makefile   |  3 +-
 lib/kunit/executor.c | 36 ++++++++++++++++++++++
 3 files changed, 83 insertions(+), 29 deletions(-)
 create mode 100644 lib/kunit/executor.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 2dfb550c6723a..8a02f93a6b505 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -197,46 +197,63 @@ void kunit_init_test(struct kunit *test, const char *name);
 
 int kunit_run_tests(struct kunit_suite *suite);
 
-/**
- * kunit_test_suites() - used to register one or more &struct kunit_suite
- *			 with KUnit.
- *
- * @suites: a statically allocated list of &struct kunit_suite.
- *
- * Registers @suites with the test framework. See &struct kunit_suite for
- * more information.
- *
- * When builtin,  KUnit tests are all run as late_initcalls; this means
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
+/*
+ * If a test suite is built-in, module_init() gets translated into
+ * an initcall which we don't want as the idea is that for builtins
+ * the executor will manage execution.  So ensure we do not define
+ * module_{init|exit} functions for the builtin case when registering
+ * suites via kunit_test_suites() below.
  */
-#define kunit_test_suites(...)						\
-	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
-	static int kunit_test_suites_init(void)				\
+#ifdef MODULE
+#define kunit_test_suites_for_module(__suites)				\
+	static int __init kunit_test_suites_init(void)			\
 	{								\
+		struct kunit_suite *suites[] = (__suites);		\
 		unsigned int i;						\
+									\
 		for (i = 0; suites[i] != NULL; i++)			\
 			kunit_run_tests(suites[i]);			\
 		return 0;						\
 	}								\
-	late_initcall(kunit_test_suites_init);				\
+	module_init(kunit_test_suites_init);				\
+									\
 	static void __exit kunit_test_suites_exit(void)			\
 	{								\
 		return;							\
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
+	__used __aligned(8) __section(.kunit_test_suites) = unique_array
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
index fab55649b69a5..c282f02ca066b 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -3,7 +3,8 @@ obj-$(CONFIG_KUNIT) +=			kunit.o
 kunit-objs +=				test.o \
 					string-stream.o \
 					assert.o \
-					try-catch.o
+					try-catch.o \
+					executor.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
new file mode 100644
index 0000000000000..6429927d598a5
--- /dev/null
+++ b/lib/kunit/executor.c
@@ -0,0 +1,36 @@
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
+	struct kunit_suite * const * const *suites, * const *subsuite;
+	bool has_test_failed = false;
+
+	for (suites = __kunit_suites_start;
+	     suites < __kunit_suites_end;
+	     suites++) {
+		for (subsuite = *suites; *subsuite != NULL; subsuite++) {
+			if (kunit_run_tests(*subsuite))
+				has_test_failed = true;
+		}
+	}
+
+	if (has_test_failed)
+		return -EFAULT;
+
+	return 0;
+}
+
+late_initcall(kunit_run_all_tests);
+
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
-- 
2.25.0.341.g760bfbb309-goog

