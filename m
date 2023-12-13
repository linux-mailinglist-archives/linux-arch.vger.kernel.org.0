Return-Path: <linux-arch+bounces-1017-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7557C811F35
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 20:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745AC1C210AD
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 19:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9155168280;
	Wed, 13 Dec 2023 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EExTdg2w"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082CF10A
	for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 11:44:36 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cf4696e202so83226257b3.2
        for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 11:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702496675; x=1703101475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8tncFbKtMEfDV232Jf8Udjxo5BkNQcKRErRNc1mfng=;
        b=EExTdg2wHWobqRKaLEUMOtQz6feP3N2A+c/9riOiNMnyLFl1Yx7YnbxmrvjoKGsJti
         A5cpxYa5v+rKqn7i6d79SHkkcKjVAMxx1RxgMlXQV3DOAGFZPDypgZizkq6e2v0JtdrD
         gwsHuVxymRpEdG2HQ57NRw0r3XUJhU3dbjSBC6RmObw7hqsRbNx/UY2yJXa+F970S6+Z
         7ubQaRNyLF7Y3TgNAjxw46+Pvdp5Xp7UFTo5fqAy3286jz5wNkODa393tKN0pa+qR6zF
         PiqXulLx6foMpBB3pMiD6B0DX7wdblbT1UUOL77EGAPvpCgaTiiFreVxBqG1V3sp+dtR
         vUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496675; x=1703101475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8tncFbKtMEfDV232Jf8Udjxo5BkNQcKRErRNc1mfng=;
        b=mGjB8qAIYm2CXnKT8QiE50xsfzJmVeLSW3f6Hb6GbWh1dsopQ92NTLvcS9dN5JcOvS
         Imp/0P/QK5IJNKC59VY0nzEXZQgk3aZDJeoDyNqBi3YOu9jwgi2uhmVU3qDMNpxBnu7P
         gew8GGgfzN8kUBDP01/2qPnRghSYLeuj6P87faL7xzRjedD8R7yR49fkWm7lJ3n+E7m5
         8FR+EDRxr3URQwyBYA96TSCUmVuAJbm+xM7W3wtS5T+L0+P0RHIvUsegddLNSXHVw/+U
         Y/1t1uglByjckuQSDj9IFFuQF9aCKJ5PdsyAVwSuXTr2/edrdD9N9FL4K6mXVaJ5hD+f
         gQKw==
X-Gm-Message-State: AOJu0Yy+r0sIW5eUKrNg+YvYDUKHKNirhPdwvoTNkKw5w3aZuZZFq5qc
	0IQkxtsZ+4+xCS7u1Aepcd0xMpd0Qg==
X-Google-Smtp-Source: AGHT+IGIGpvW5Hth/xS09Z3Wm6iVTz9ZW3JUyPaVJIlkAwr02Gz0pNUos512zjOZrZQLcMeYXah2urnH8Q==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:4d0:b0:dbc:b226:bd23 with SMTP id
 v16-20020a05690204d000b00dbcb226bd23mr50429ybs.0.1702496675240; Wed, 13 Dec
 2023 11:44:35 -0800 (PST)
Date: Wed, 13 Dec 2023 19:44:20 +0000
In-Reply-To: <20231213194421.2031671-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231213194421.2031671-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213194421.2031671-5-rmoar@google.com>
Subject: [PATCH v5 5/6] kunit: add ability to run tests after boot using debugfs
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

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 lib/kunit/debugfs.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c    | 10 +++++++
 2 files changed, 78 insertions(+)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 382706dfb47d..d548750a325a 100644
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
 
@@ -101,6 +105,51 @@ static int debugfs_results_open(struct inode *inode, struct file *file)
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
@@ -108,11 +157,23 @@ static const struct file_operations debugfs_results_fops = {
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
 	struct string_stream *stream;
 
+	/* If suite log already allocated, do not create new debugfs files. */
+	if (suite->log)
+		return;
+
 	/*
 	 * Allocate logs before creating debugfs representation.
 	 * The suite->log and test_case->log pointer are expected to be NULL
@@ -140,6 +201,13 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
 	debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
 			    suite->debugfs,
 			    suite, &debugfs_results_fops);
+
+	/* Do not create file to re-run test if test runs on init */
+	if (!suite->is_init) {
+		debugfs_create_file(KUNIT_DEBUGFS_RUN, S_IFREG | 0644,
+				    suite->debugfs,
+				    suite, &debugfs_run_fops);
+	}
 	return;
 
 err:
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 6c082911a85f..a52fcb9a4457 100644
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
2.43.0.472.g3155946c3a-goog


