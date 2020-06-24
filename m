Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42169207DD5
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391538AbgFXU6b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391542AbgFXU61 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:58:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208CDC0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f130so3545181yba.9
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NoiIGyxWoorv21h/1FusVRoLbp9FrqO2UVqUFf2Y1/c=;
        b=iIuZJRsD7dZCbTZfZ6EXMP+d9QDWoQ0/wChahgZ7/uuNBZpADZ8BtIAzBPueOY3Hfh
         4cVJkOUMp58fj00Qyw8sEhTQ/mtFhzYdoRdhqGeu6qbneu7jImviIjCc/Ja2HgylEV2z
         l9W37Vf0/q0KdrpOHj3+ExBI/+JRRyw4MZRuuOGOTGsCJdC68pRhiaISoyvnE0iEDvpm
         DhKC0FqlQkDr8vyvTmeADx+JK9vhh3kwFW4G2/4H1mPrv9ctejKgmq3k5WM7sPP6atqf
         v+Q94927gzgw0LZ5mfZcUmviwYgfVWKpWOkLXVFf1zch4S3SHYHBwbOeN40SoU1ZbocN
         B2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NoiIGyxWoorv21h/1FusVRoLbp9FrqO2UVqUFf2Y1/c=;
        b=UFnQ3eHYiqaugSklrgQ2aUo1q4rmZkoELuSvi2FzGQ/EFYyXItJx+NqB5Ihr0+Y40b
         FmZoI+MlP1P87cruT7PbF+R/ruKeUA6PGigWedB+Btjs+rjpCwaeSsovdQhqFZBBWJWY
         pxAEANkOvyVUGN4K2Vd+A2h76NZBQIgzksiTK6AFODg+fvbzONgHW1zzxJYredmCd0jY
         /7Dfhv5WjzyEQrXRylsUOOx/wBLT/z3NRNxfAvvvpPybqqP75bqGOBev0hU+sQpE9D2t
         oKhAXdxJrTppZgM8s6IJ+gk243HM72YlBKgz2r8QmQFNSaCbU45OGZUyg9/OoxtH33HL
         ln+w==
X-Gm-Message-State: AOAM531tY1Mg0JnotA9cjolWY/NyHbj7QhFZg/whlASKS6RUeNjuQfoR
        WT74yA6CZq7BhWylDnlMGTvVhvgpzQsWgy2fHaeFQA==
X-Google-Smtp-Source: ABdhPJwa6x6u4hOGw3BWr33N7HTFou21StSbvL/J42U+MbeVw7ajjJ5jtaBB5mlSam4lNRb3i7+WKSgoGoEJJt6JPou35A==
X-Received: by 2002:a25:1941:: with SMTP id 62mr52539230ybz.16.1593032305184;
 Wed, 24 Jun 2020 13:58:25 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:48 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-10-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 09/11] kunit: test: add test plan to KUnit TAP format
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

TAP 14 allows an optional test plan to be emitted before the start of
the start of testing[1]; this is valuable because it makes it possible
for a test harness to detect whether the number of tests run matches the
number of tests expected to be run, ensuring that no tests silently
failed.

Link[1]: https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 lib/kunit/executor.c                          |  37 +++++++++
 lib/kunit/test.c                              |  11 ---
 tools/testing/kunit/kunit_kernel.py           |   2 +-
 tools/testing/kunit/kunit_parser.py           |  74 +++++++++++++++---
 .../test_is_test_passed-all_passed.log        | Bin 1562 -> 1567 bytes
 .../test_data/test_is_test_passed-crash.log   | Bin 3016 -> 3021 bytes
 .../test_data/test_is_test_passed-failure.log | Bin 1700 -> 1705 bytes
 7 files changed, 100 insertions(+), 24 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 4aab7f70a88c3..38061d456afb2 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/reboot.h>
 #include <kunit/test.h>
 
 /*
@@ -11,15 +12,51 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
+static char *kunit_shutdown;
+core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
+
+static void kunit_handle_shutdown(void)
+{
+	if (!kunit_shutdown)
+		return;
+
+	if (!strcmp(kunit_shutdown, "poweroff"))
+		kernel_power_off();
+	else if (!strcmp(kunit_shutdown, "halt"))
+		kernel_halt();
+	else if (!strcmp(kunit_shutdown, "reboot"))
+		kernel_restart(NULL);
+
+}
+
+static void kunit_print_tap_header(void)
+{
+	struct kunit_suite * const * const *suites, * const *subsuite;
+	int num_of_suites = 0;
+
+	for (suites = __kunit_suites_start;
+	     suites < __kunit_suites_end;
+	     suites++)
+		for (subsuite = *suites; *subsuite != NULL; subsuite++)
+			num_of_suites++;
+
+	pr_info("TAP version 14\n");
+	pr_info("1..%d\n", num_of_suites);
+}
+
 int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites;
 
+	kunit_print_tap_header();
+
 	for (suites = __kunit_suites_start;
 	     suites < __kunit_suites_end;
 	     suites++)
 			__kunit_test_suites_init(*suites);
 
+	kunit_handle_shutdown();
+
 	return 0;
 }
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 918dff400a9d7..b1835ccb3fce2 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -19,16 +19,6 @@ static void kunit_set_failure(struct kunit *test)
 	WRITE_ONCE(test->success, false);
 }
 
-static void kunit_print_tap_version(void)
-{
-	static bool kunit_has_printed_tap_version;
-
-	if (!kunit_has_printed_tap_version) {
-		pr_info("TAP version 14\n");
-		kunit_has_printed_tap_version = true;
-	}
-}
-
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -68,7 +58,6 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
 static void kunit_print_subtest_start(struct kunit_suite *suite)
 {
-	kunit_print_tap_version();
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
 		  suite->name);
 	kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 63dbda2d029f6..d6a575f92317c 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -172,7 +172,7 @@ class LinuxSourceTree(object):
 		return self.validate_config(build_dir)
 
 	def run_kernel(self, args=[], build_dir='', timeout=None):
-		args.extend(['mem=1G'])
+		args.extend(['mem=1G', 'kunit_shutdown=halt'])
 		outfile = 'test.log'
 		self._ops.linux_bin(args, timeout, build_dir, outfile)
 		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 64aac9dcd4314..a8998a5effaad 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -45,6 +45,7 @@ class TestStatus(Enum):
 	FAILURE = auto()
 	TEST_CRASHED = auto()
 	NO_TESTS = auto()
+	FAILURE_TO_PARSE_TESTS = auto()
 
 kunit_start_re = re.compile(r'TAP version [0-9]+$')
 kunit_end_re = re.compile('(List of all partitions:|'
@@ -109,7 +110,7 @@ OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
 
 OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
 
-OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
+OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
 
 def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
 	save_non_diagnositic(lines, test_case)
@@ -197,7 +198,9 @@ def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
 	else:
 		return TestStatus.SUCCESS
 
-def parse_ok_not_ok_test_suite(lines: List[str], test_suite: TestSuite) -> bool:
+def parse_ok_not_ok_test_suite(lines: List[str],
+			       test_suite: TestSuite,
+			       expected_suite_index: int) -> bool:
 	consume_non_diagnositic(lines)
 	if not lines:
 		test_suite.status = TestStatus.TEST_CRASHED
@@ -210,6 +213,12 @@ def parse_ok_not_ok_test_suite(lines: List[str], test_suite: TestSuite) -> bool:
 			test_suite.status = TestStatus.SUCCESS
 		else:
 			test_suite.status = TestStatus.FAILURE
+		suite_index = int(match.group(2))
+		if suite_index != expected_suite_index:
+			print_with_timestamp(
+				red('[ERROR] ') + 'expected_suite_index ' +
+				str(expected_suite_index) + ', but got ' +
+				str(suite_index))
 		return True
 	else:
 		return False
@@ -222,7 +231,7 @@ def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
 	max_test_case_status = bubble_up_errors(lambda x: x.status, test_suite.cases)
 	return max_status(max_test_case_status, test_suite.status)
 
-def parse_test_suite(lines: List[str]) -> TestSuite:
+def parse_test_suite(lines: List[str], expected_suite_index: int) -> TestSuite:
 	if not lines:
 		return None
 	consume_non_diagnositic(lines)
@@ -241,7 +250,7 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
 			break
 		test_suite.cases.append(test_case)
 		expected_test_case_num -= 1
-	if parse_ok_not_ok_test_suite(lines, test_suite):
+	if parse_ok_not_ok_test_suite(lines, test_suite, expected_suite_index):
 		test_suite.status = bubble_up_test_case_errors(test_suite)
 		return test_suite
 	elif not lines:
@@ -261,6 +270,17 @@ def parse_tap_header(lines: List[str]) -> bool:
 	else:
 		return False
 
+TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
+
+def parse_test_plan(lines: List[str]) -> int:
+	consume_non_diagnositic(lines)
+	match = TEST_PLAN.match(lines[0])
+	if match:
+		lines.pop(0)
+		return int(match.group(1))
+	else:
+		return None
+
 def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
 	return bubble_up_errors(lambda x: x.status, test_suite_list)
 
@@ -269,19 +289,34 @@ def parse_test_result(lines: List[str]) -> TestResult:
 		return TestResult(TestStatus.NO_TESTS, [], lines)
 	consume_non_diagnositic(lines)
 	if not parse_tap_header(lines):
-		return None
+		return TestResult(TestStatus.NO_TESTS, [], lines)
+	expected_test_suite_num = parse_test_plan(lines)
+	if not expected_test_suite_num:
+		return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
 	test_suites = []
-	test_suite = parse_test_suite(lines)
-	while test_suite:
-		test_suites.append(test_suite)
-		test_suite = parse_test_suite(lines)
-	return TestResult(bubble_up_suite_errors(test_suites), test_suites, lines)
+	for i in range(1, expected_test_suite_num + 1):
+		test_suite = parse_test_suite(lines, i)
+		if test_suite:
+			test_suites.append(test_suite)
+		else:
+			print_with_timestamp(
+				red('[ERROR] ') + ' expected ' +
+				str(expected_test_suite_num) +
+				' test suites, but got ' + str(i - 2))
+			break
+	test_suite = parse_test_suite(lines, -1)
+	if test_suite:
+		print_with_timestamp(red('[ERROR] ') +
+			'got unexpected test suite: ' + test_suite.name)
+	if test_suites:
+		return TestResult(bubble_up_suite_errors(test_suites), test_suites, lines)
+	else:
+		return TestResult(TestStatus.NO_TESTS, [], lines)
 
-def parse_run_tests(kernel_output) -> TestResult:
+def print_and_count_results(test_result: TestResult) -> None:
 	total_tests = 0
 	failed_tests = 0
 	crashed_tests = 0
-	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
 	for test_suite in test_result.suites:
 		if test_suite.status == TestStatus.SUCCESS:
 			print_suite_divider(green('[PASSED] ') + test_suite.name)
@@ -303,6 +338,21 @@ def parse_run_tests(kernel_output) -> TestResult:
 				print_with_timestamp(red('[FAILED] ') + test_case.name)
 				print_log(map(yellow, test_case.log))
 				print_with_timestamp('')
+	return total_tests, failed_tests, crashed_tests
+
+def parse_run_tests(kernel_output) -> TestResult:
+	total_tests = 0
+	failed_tests = 0
+	crashed_tests = 0
+	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
+	if test_result.status == TestStatus.NO_TESTS:
+		print(red('[ERROR] ') + yellow('no tests run!'))
+	elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
+		print(red('[ERROR] ') + yellow('could not parse test results!'))
+	else:
+		(total_tests,
+		 failed_tests,
+		 crashed_tests) = print_and_count_results(test_result)
 	print_with_timestamp(DIVIDER)
 	fmt = green if test_result.status == TestStatus.SUCCESS else red
 	print_with_timestamp(
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log b/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
index 62ebc0288355c4b122ccc18ae2505f971efa57bc..bc0dc8fe35b760b1feb74ec419818dbfae1adb5c 100644
GIT binary patch
delta 28
jcmbQmGoME|#4$jjEVZaOGe1wk(1goSPtRy09}gP<dC~`u

delta 23
ecmbQwGmD2W#4$jjEVZaOGe1wk&}5@94;uhhkp{*9

diff --git a/tools/testing/kunit/test_data/test_is_test_passed-crash.log b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
index 0b249870c8be417a5865bd40a24c8597bb7f5ab1..4d97f6708c4a5ad5bb2ac879e12afca6e816d83d 100644
GIT binary patch
delta 15
WcmX>hepY;fFN>j`p3z318g2k9Uj*m?

delta 10
RcmX>renNbL@5Z2NZU7lr1S$Xk

diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure.log b/tools/testing/kunit/test_data/test_is_test_passed-failure.log
index 9e89d32d5667a59d137f8adacf3a88fdb7f88baf..7a416497e3bec044eefc1535f7d84ee85703ba97 100644
GIT binary patch
delta 28
jcmZ3&yOLKp#4$jjEVZaOGe1wk(1goSPtRy0-!wJ=eKrU$

delta 23
ecmZ3<yM&i7#4$jjEVZaOGe1wk&}5_VG&TTPhX-Z=

-- 
2.27.0.212.ge8ba1cc988-goog

