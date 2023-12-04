Return-Path: <linux-arch+bounces-658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90722804197
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 23:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33031C20C33
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 22:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED8C3B789;
	Mon,  4 Dec 2023 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaRuDXqD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779F5189
	for <linux-arch@vger.kernel.org>; Mon,  4 Dec 2023 14:19:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daf702bde7eso2693353276.3
        for <linux-arch@vger.kernel.org>; Mon, 04 Dec 2023 14:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701728384; x=1702333184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R10zjW0JVsp8M4qo1xhNAkM6zfuGofXdUJMDPp7V66o=;
        b=BaRuDXqDWbREMkH5y2FpCN+H6VV89rt+pQUcWxSLAIJzD6Qu0ygl3Ht931FdVuUOUp
         GNp2byCZ94V6JaUZg42oMXxwrMiLXw+FdhCzfV2KZfZtq6l2LzF6uWpUpg/pIxnA/wFu
         rh8TzbvJuaYhvwMcKRgAfdXAt11d6M+k38eL08cL2BOALyOFDUcqEMpMhFvbLYQbRLJh
         ujBi8sHUosLL8zKVzBByyF1JGkIz0s61iH8m67gx0P0jcKHHnHHzAzj93GhjVnabXzvV
         kaxbkF4o//s8FhUi8zTn3YLqOAd+hPG/QWjCS6AB+Fh0iXjQBOJN+X+RErrHYr41UoZD
         WHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728384; x=1702333184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R10zjW0JVsp8M4qo1xhNAkM6zfuGofXdUJMDPp7V66o=;
        b=PepDhK2+gx5iZu3UYsfXDkd9VUeswqPgSbGJPOHUa878Gqy6KB6vXDqEDBTHCs8eUw
         F1uLQRxjYXPY2WeDvcLDbzcpEwDvhXN8JtIrnKy/yJqAYti8lJ0OlP9xoC48eMqhNjoh
         0VmrM8FWiesR+TZOl1RzXz4lg+FAQzaxFvbd8Y6fY137Az8xdrtQrCwNQ+mrZjdZ44S5
         d1hVY8NJVSBMcKEMNcGVhTnRo5bE/aFRmYBL1pDCQoRAy4jWFcnjT1/6CGBubrQcRZfV
         ocTOf5dIlR2fW7mnBoxCp3oxvLxVD5SbhMl6WzlkTZPkWaVjmurejKRXE1/bK6eB8qY7
         sXbA==
X-Gm-Message-State: AOJu0YybMPKJKCjTdJHC96dY6S8YdP9A+M0jjne7g9NKA7H6rbNRRrrb
	a9sQtQp0/g7GTz/1IxsnAfcqmE4TsA==
X-Google-Smtp-Source: AGHT+IHNfy9Vk4gwqHkiSrh5NojiSYAW0yNLm2Rr7Kv9KdzVBIWaEBgpLQlFQQgTvxlSw5wFF19+m0P/LA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:3106:0:b0:da3:723b:b2a4 with SMTP id
 x6-20020a253106000000b00da3723bb2a4mr867924ybx.7.1701728384660; Mon, 04 Dec
 2023 14:19:44 -0800 (PST)
Date: Mon,  4 Dec 2023 22:19:30 +0000
In-Reply-To: <20231204221932.1465004-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204221932.1465004-5-rmoar@google.com>
Subject: [PATCH v3 5/6] kunit: add ability to run tests after boot using debugfs
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, sadiyakazi@google.com
Cc: keescook@chromium.org, arnd@arndb.de, linux-kselftest@vger.kernel.org, 
	linux-arch@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add functionality to run built-in tests after boot by writing to a
debugfs file.

Add a new debugfs file labeled "run" for each test suite to use for
this purpose.

As an example, write to the file using the following:

echo "any string" > /sys/kernel/debugfs/kunit/<testsuite>/run

This will trigger the test suite to run and will print results to the
kernel log.

To guard against running tests concurrently with this feature, add a
mutex lock around running kunit. This supports the current practice of
not allowing tests to be run concurrently on the same kernel.

This new functionality could be used to design a parameter
injection feature in the future.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v2:
- Move resetting the log to test.c
- Add is_init attribute and patches to change linker sections to avoid
  re-running tests that use init data and functions

 lib/kunit/debugfs.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c    | 10 +++++++
 2 files changed, 78 insertions(+)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 270d185737e6..2e0a92a0c461 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -8,12 +8,14 @@
 #include <linux/module.h>
 
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 
 #include "string-stream.h"
 #include "debugfs.h"
 
 #define KUNIT_DEBUGFS_ROOT             "kunit"
 #define KUNIT_DEBUGFS_RESULTS          "results"
+#define KUNIT_DEBUGFS_RUN              "run"
 
 /*
  * Create a debugfs representation of test suites:
@@ -21,6 +23,8 @@
  * Path						Semantics
  * /sys/kernel/debug/kunit/<testsuite>/results	Show results of last run for
  *						testsuite
+ * /sys/kernel/debug/kunit/<testsuite>/run	Write to this file to trigger
+ *						testsuite to run
  *
  */
 
@@ -99,6 +103,51 @@ static int debugfs_results_open(struct inode *inode, struct file *file)
 	return single_open(file, debugfs_print_results, suite);
 }
 
+/*
+ * Print a usage message to the debugfs "run" file
+ * (/sys/kernel/debug/kunit/<testsuite>/run) if opened.
+ */
+static int debugfs_print_run(struct seq_file *seq, void *v)
+{
+	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
+
+	seq_puts(seq, "Write to this file to trigger the test suite to run.\n");
+	seq_printf(seq, "usage: echo \"any string\" > /sys/kernel/debugfs/kunit/%s/run\n",
+			suite->name);
+	return 0;
+}
+
+/*
+ * The debugfs "run" file (/sys/kernel/debug/kunit/<testsuite>/run)
+ * contains no information. Write to the file to trigger the test suite
+ * to run.
+ */
+static int debugfs_run_open(struct inode *inode, struct file *file)
+{
+	struct kunit_suite *suite;
+
+	suite = (struct kunit_suite *)inode->i_private;
+
+	return single_open(file, debugfs_print_run, suite);
+}
+
+/*
+ * Trigger a test suite to run by writing to the suite's "run" debugfs
+ * file found at: /sys/kernel/debug/kunit/<testsuite>/run
+ *
+ * Note: what is written to this file will not be saved.
+ */
+static ssize_t debugfs_run(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct inode *f_inode = file->f_inode;
+	struct kunit_suite *suite = (struct kunit_suite *) f_inode->i_private;
+
+	__kunit_test_suites_init(&suite, 1);
+
+	return count;
+}
+
 static const struct file_operations debugfs_results_fops = {
 	.open = debugfs_results_open,
 	.read = seq_read,
@@ -106,10 +155,22 @@ static const struct file_operations debugfs_results_fops = {
 	.release = debugfs_release,
 };
 
+static const struct file_operations debugfs_run_fops = {
+	.open = debugfs_run_open,
+	.read = seq_read,
+	.write = debugfs_run,
+	.llseek = seq_lseek,
+	.release = debugfs_release,
+};
+
 void kunit_debugfs_create_suite(struct kunit_suite *suite)
 {
 	struct kunit_case *test_case;
 
+	/* If suite log already allocated, do not create new debugfs files. */
+	if (suite->log)
+		return;
+
 	/* Allocate logs before creating debugfs representation. */
 	suite->log = alloc_string_stream(GFP_KERNEL);
 	string_stream_set_append_newlines(suite->log, true);
@@ -124,6 +185,13 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
 	debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
 			    suite->debugfs,
 			    suite, &debugfs_results_fops);
+
+	/* Do not create file to re-run test if test runs on init */
+	if (!suite->attr.is_init) {
+		debugfs_create_file(KUNIT_DEBUGFS_RUN, S_IFREG | 0644,
+				    suite->debugfs,
+				    suite, &debugfs_run_fops);
+	}
 }
 
 void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 8bae6e2bc6a0..58e46bb3b4c4 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
@@ -22,6 +23,8 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+static DEFINE_MUTEX(kunit_run_lock);
+
 /*
  * Hook to fail the current test and print an error message to the log.
  */
@@ -654,6 +657,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
 	kunit_debugfs_create_suite(suite);
 	suite->status_comment[0] = '\0';
 	suite->suite_init_err = 0;
+	string_stream_clear(suite->log);
 }
 
 bool kunit_enabled(void)
@@ -670,6 +674,11 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 		return 0;
 	}
 
+	/* Use mutex lock to guard against running tests concurrently. */
+	if (mutex_lock_interruptible(&kunit_run_lock)) {
+		pr_err("kunit: test interrupted\n");
+		return -EINTR;
+	}
 	static_branch_inc(&kunit_running);
 
 	for (i = 0; i < num_suites; i++) {
@@ -678,6 +687,7 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 	}
 
 	static_branch_dec(&kunit_running);
+	mutex_unlock(&kunit_run_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
-- 
2.43.0.rc2.451.g8631bc7472-goog


