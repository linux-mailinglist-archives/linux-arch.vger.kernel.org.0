Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCE36121C5D
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 23:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfLPWHH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 17:07:07 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48570 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbfLPWHF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 17:07:05 -0500
Received: by mail-pf1-f202.google.com with SMTP id u13so2421437pfl.15
        for <linux-arch@vger.kernel.org>; Mon, 16 Dec 2019 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q0qe2kR+bAay0VBCKejOtYmpF3XJORWe/2Y7Sg9amhw=;
        b=KXEdzR5sEfYW47IOMB4cZpps1PEpUNY54j1THILz0FDue58d4xDTo4xEyITzycC8WI
         cty59wubaPPbwA/praz2PhIRWbMoNlSfJ5HI5lCRKkz8ZEl+1Q+Mgi5nnUk4hwIMFFyK
         o9a7hgBtcB2M5nWh7oleILEiPMeC9wsSl3JvL9uyI3jcWOWl2HiNpuPS3tm/2kuzXz/2
         ZwrcD9NIwbP+TD9B5epGkERp4xEk54xjjIh2KP3BOzg2dWatvs23FcGoe18LGv9tigsN
         zk7enm6BbQ+IPvYpT59CVbQcLcAbQsDC1kmQ7hMOW4aOh6ehkNGuohUloJyoEOImpdB0
         og2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q0qe2kR+bAay0VBCKejOtYmpF3XJORWe/2Y7Sg9amhw=;
        b=QWH3UrFdIEZGt3HjOivlmXvpo5r9tpOiaxiBse7AqWl7MdgGRIFdJNbJ4fKpVrLpJq
         McQCYSmD7Y1Cue7ZKSidueb2fqBRh+dQY/vLpQPX4JHqDo8jlHOWZXKZiuqYYHmAkXWG
         gnLZmOTFt3Yu1mAxiYjOJto64lqnzeKDDOXL+WxhFbsslRHOe6mUDsrHFZFnU+0nizx2
         5qmZG/iAX38dGSu6gxJFThBrkT2LipxdBmOg8AbOvtWwPQXXAHUNaD44eCDBZiYmSP4A
         zT3VJWjqlCkuyyTK3e0Btcw6k23I8LXXx+91e5pHNsIOxh+7a5naAgqzGxrz95f5/t3C
         CpRw==
X-Gm-Message-State: APjAAAUXse/zwfqwTEgEBjv3WEDmLeyuNMSxbO1dyo/DEkHiJycd8y/e
        bHCyAWl6zUTOxoBdCGl4meCdTwfaAGB2Nuq6WBLwIA==
X-Google-Smtp-Source: APXvYqxRhQSngjdpwvFolaB1SLzzXTDEa/g1lTeVrAduuwj0fvc+F3k5fBaVV1qGODXsFPGnv0IqlV0v+/1bKZjWCdvWlA==
X-Received: by 2002:a63:9548:: with SMTP id t8mr9143009pgn.205.1576534024897;
 Mon, 16 Dec 2019 14:07:04 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:05:55 -0800
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Message-Id: <20191216220555.245089-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [RFC v1 6/6] kunit: Add 'kunit_shutdown' option
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: David Gow <davidgow@google.com>

Add a new kernel command-line option, 'kunit_shutdown', which allows the
user to specify that the kernel poweroff, halt, or reboot after
completing all KUnit tests; this is very handy for running KUnit tests
on UML or a VM so that the UML/VM process exits cleanly immediately
after running all tests without needing a special initramfs.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/kunit/executor.c                | 18 ++++++++++++++++++
 tools/testing/kunit/kunit_kernel.py |  2 +-
 tools/testing/kunit/kunit_parser.py |  2 +-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index d5f1d07f2f817..32462ecb94eb6 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -7,7 +7,9 @@
  */
 
 #include <linux/init.h>
+#include <linux/moduleparam.h>
 #include <linux/printk.h>
+#include <linux/reboot.h>
 #include <kunit/test.h>
 
 /*
@@ -17,6 +19,9 @@
 extern struct kunit_suite *__kunit_suites_start[];
 extern struct kunit_suite *__kunit_suites_end[];
 
+static char *kunit_shutdown;
+core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
+
 static void kunit_print_tap_header(void)
 {
 	size_t num_of_suites;
@@ -30,6 +35,17 @@ static void kunit_print_tap_header(void)
 	pr_info("1..%zd\n", num_of_suites);
 }
 
+static void kunit_handle_shutdown(void)
+{
+	if (!strcmp(kunit_shutdown, "poweroff")) {
+		kernel_power_off();
+	} else if (!strcmp(kunit_shutdown, "halt")) {
+		kernel_halt();
+	} else if (!strcmp(kunit_shutdown, "reboot")) {
+		kernel_restart(NULL);
+	}
+}
+
 static bool kunit_run_all_tests(void)
 {
 	struct kunit_suite **suite;
@@ -44,6 +60,8 @@ static bool kunit_run_all_tests(void)
 			has_test_failed = true;
 	}
 
+	kunit_handle_shutdown();
+
 	return !has_test_failed;
 }
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bf38768353313..0070c6b807d2a 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -141,7 +141,7 @@ class LinuxSourceTree(object):
 		return True
 
 	def run_kernel(self, args=[], timeout=None, build_dir=None):
-		args.extend(['mem=256M'])
+		args.extend(['mem=256M', 'kunit_shutdown=halt'])
 		process = self._ops.linux_bin(args, timeout, build_dir)
 		with open('test.log', 'w') as f:
 			for line in process.stdout:
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 78b3bdd03b1e4..633811dd9bce8 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -48,7 +48,7 @@ class TestStatus(Enum):
 	FAILURE_TO_PARSE_TESTS = auto()
 
 kunit_start_re = re.compile(r'^TAP version [0-9]+$')
-kunit_end_re = re.compile('List of all partitions:')
+kunit_end_re = re.compile(r'reboot: System halted')
 
 def isolate_kunit_output(kernel_output):
 	started = False
-- 
2.24.1.735.g03f4e72817-goog

