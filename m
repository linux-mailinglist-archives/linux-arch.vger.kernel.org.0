Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC635121C65
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 23:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfLPWHM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 17:07:12 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41488 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfLPWHD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 17:07:03 -0500
Received: by mail-pl1-f202.google.com with SMTP id z9so6323632plo.8
        for <linux-arch@vger.kernel.org>; Mon, 16 Dec 2019 14:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Okrb9rHJOSAwXic7+h2dqG6fsBBwkjlDB5IhnYj28lc=;
        b=PoZWzgWw1COthpkjvpOPoZMVnNL7EbyJBjKnF5h5ebhlahg7EO1ofCuqQyjYp9HeTw
         m2h+5dX3WRBxkQg52ozkN+0oW8260UNB9rJvCXhRcF5l2ZAEi6itglBJ/zA1T3+ZKpO5
         vyuVyrFnLzXK485fnsQxvE/4EK9lhZwonTsrjH3B6ocNiHu+UvsHYjrFvXSY17E5OL6p
         MjBY+Vw6/4tH15sgb51ab9afIxOj+yW/iJYivlCcisPom8guNlcln7c/MHbi9KClA5+y
         7CGNCI+zDqL1XjKB+BevStLinv6jb8hQXGJ7LEL7BaemNbhQDyFwDU0DhdfLoJreEwkA
         Vq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Okrb9rHJOSAwXic7+h2dqG6fsBBwkjlDB5IhnYj28lc=;
        b=YBf52aTaF//rx3ZcpiVBZd0QCvRhyW2CEjkMKlmk1+HgXnpFYP2YZd5Jf3EV/M3O3e
         4iCEzl3jou2srD4EIdUfiDWXmwzvJuInRh5BjT/21HE0fPQ0Q93QMI1FQm26GVDVXnyF
         ABAP2lYI5OOKHIT7KQDiCRyjUyrUU5OWrQLSE0fpr2vplLW2hhBHb5WhjpaRqHxmPUie
         7D6xprEM5qMGQarlgK/Q9QFtLKP3RCLeKftVDV+fcUDXwUBxqOoHyQUHjoRyaLgJF548
         DEUI/v1Yd55i7T6keeBwglavScvNKbdRU/gGgAuE43HZmHbNI+xNPgAcfMIUndqM7LYs
         GR6w==
X-Gm-Message-State: APjAAAWc6A/bsE+HdERNe+PjWstVNCtXfNkBT0JltZrcXy9iBVjSRlMV
        d0r5m3mDM1An0yBktBgfCFO/PQ/1f1lFKY+P5MSjkQ==
X-Google-Smtp-Source: APXvYqyICt9rsVwVg4Ooa0/vkucGnjbg8ET8IRydP2Mj9NlUQrpyIjCPvKiaaZkPt0F4U+I2RDuZKXxv4R/1LA1oPX5rqw==
X-Received: by 2002:a63:1402:: with SMTP id u2mr20963214pgl.224.1576534022230;
 Mon, 16 Dec 2019 14:07:02 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:05:54 -0800
In-Reply-To: <20191216220555.245089-1-brendanhiggins@google.com>
Message-Id: <20191216220555.245089-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [RFC v1 5/6] kunit: test: add test plan to KUnit TAP format
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

TAP 14 allows an optional test plan to be emitted before the start of
the start of testing[1]; this is valuable because it makes it possible
for a test harness to detect whether the number of tests run matches the
number of tests expected to be run, ensuring that no tests silently
failed.

Link[1]: https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/kunit/executor.c                          | 15 ++++
 lib/kunit/test.c                              | 11 ---
 tools/testing/kunit/kunit_parser.py           | 74 ++++++++++++++++---
 .../test_is_test_passed-all_passed.log        |  1 +
 .../test_data/test_is_test_passed-crash.log   |  1 +
 .../test_data/test_is_test_passed-failure.log |  1 +
 6 files changed, 80 insertions(+), 23 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index ca880224c0bab..d5f1d07f2f817 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -17,11 +17,26 @@
 extern struct kunit_suite *__kunit_suites_start[];
 extern struct kunit_suite *__kunit_suites_end[];
 
+static void kunit_print_tap_header(void)
+{
+	size_t num_of_suites;
+
+	for (num_of_suites = 0;
+	     num_of_suites + __kunit_suites_start < __kunit_suites_end;
+	     ++num_of_suites)
+		;
+
+	pr_info("TAP version 14\n");
+	pr_info("1..%zd\n", num_of_suites);
+}
+
 static bool kunit_run_all_tests(void)
 {
 	struct kunit_suite **suite;
 	bool has_test_failed = false;
 
+	kunit_print_tap_header();
+
 	for (suite = __kunit_suites_start;
 	     suite < __kunit_suites_end;
 	     ++suite) {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c83c0fa59cbd7..f8f235f9e466a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -16,16 +16,6 @@ static void kunit_set_failure(struct kunit *test)
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
 static size_t kunit_test_cases_len(struct kunit_case *test_cases)
 {
 	struct kunit_case *test_case;
@@ -39,7 +29,6 @@ static size_t kunit_test_cases_len(struct kunit_case *test_cases)
 
 static void kunit_print_subtest_start(struct kunit_suite *suite)
 {
-	kunit_print_tap_version();
 	pr_info("\t# Subtest: %s\n", suite->name);
 	pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
 }
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 4ffbae0f67325..78b3bdd03b1e4 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -45,6 +45,7 @@ class TestStatus(Enum):
 	FAILURE = auto()
 	TEST_CRASHED = auto()
 	NO_TESTS = auto()
+	FAILURE_TO_PARSE_TESTS = auto()
 
 kunit_start_re = re.compile(r'^TAP version [0-9]+$')
 kunit_end_re = re.compile('List of all partitions:')
@@ -106,7 +107,7 @@ OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
 
 OK_NOT_OK_SUBTEST = re.compile(r'^\t(ok|not ok) [0-9]+ - (.*)$')
 
-OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
+OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
 
 def parse_ok_not_ok_test_case(lines: List[str],
 			      test_case: TestCase,
@@ -196,7 +197,9 @@ def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
 	else:
 		return TestStatus.SUCCESS
 
-def parse_ok_not_ok_test_suite(lines: List[str], test_suite: TestSuite) -> bool:
+def parse_ok_not_ok_test_suite(lines: List[str],
+			       test_suite: TestSuite,
+			       expected_suite_index: int) -> bool:
 	consume_non_diagnositic(lines)
 	if not lines:
 		test_suite.status = TestStatus.TEST_CRASHED
@@ -209,6 +212,12 @@ def parse_ok_not_ok_test_suite(lines: List[str], test_suite: TestSuite) -> bool:
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
@@ -221,7 +230,7 @@ def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
 	max_test_case_status = bubble_up_errors(lambda x: x.status, test_suite.cases)
 	return max_status(max_test_case_status, test_suite.status)
 
-def parse_test_suite(lines: List[str]) -> TestSuite:
+def parse_test_suite(lines: List[str], expected_suite_index: int) -> TestSuite:
 	if not lines:
 		return None
 	consume_non_diagnositic(lines)
@@ -240,7 +249,7 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
 		test_suite.cases.append(test_case)
 		test_case = parse_test_case(lines, expected_test_case_num > 0)
 		expected_test_case_num -= 1
-	if parse_ok_not_ok_test_suite(lines, test_suite):
+	if parse_ok_not_ok_test_suite(lines, test_suite, expected_suite_index):
 		test_suite.status = bubble_up_test_case_errors(test_suite)
 		return test_suite
 	elif not lines:
@@ -260,6 +269,17 @@ def parse_tap_header(lines: List[str]) -> bool:
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
 
@@ -268,19 +288,34 @@ def parse_test_result(lines: List[str]) -> TestResult:
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
@@ -302,6 +337,21 @@ def parse_run_tests(kernel_output) -> TestResult:
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
index 62ebc0288355c..bc0dc8fe35b76 100644
--- a/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
+++ b/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
@@ -1,4 +1,5 @@
 TAP version 14
+1..2
 	# Subtest: sysctl_test
 	1..8
 	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-crash.log b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
index 0b249870c8be4..4d97f6708c4a5 100644
--- a/tools/testing/kunit/test_data/test_is_test_passed-crash.log
+++ b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
@@ -1,6 +1,7 @@
 printk: console [tty0] enabled
 printk: console [mc-1] enabled
 TAP version 14
+1..2
 	# Subtest: sysctl_test
 	1..8
 	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure.log b/tools/testing/kunit/test_data/test_is_test_passed-failure.log
index 9e89d32d5667a..7a416497e3bec 100644
--- a/tools/testing/kunit/test_data/test_is_test_passed-failure.log
+++ b/tools/testing/kunit/test_data/test_is_test_passed-failure.log
@@ -1,4 +1,5 @@
 TAP version 14
+1..2
 	# Subtest: sysctl_test
 	1..8
 	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
-- 
2.24.1.735.g03f4e72817-goog

