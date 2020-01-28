Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6576D14B057
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2020 08:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgA1HUn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jan 2020 02:20:43 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:56596 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgA1HU3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jan 2020 02:20:29 -0500
Received: by mail-ua1-f74.google.com with SMTP id b15so1331494uas.23
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2020 23:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IqhCaLiTa6tkSv6MqqTRbQ1OxRAqlbeQ5TORP1OY+H8=;
        b=HMEhAWPAVi8fXHcRzXG1ocnoi+Wf7sJWZZvrJgc7dj1SrfM2IsLqHVShu0ax/Rv82/
         FaDqV+ZJjs1QMmtrAtEUjym/D18scMntZgPjiiq/YyfMU9Hz561IcwWD+ix97mZv1g80
         wIBiZFbXNFFjg+3onUfkK6RbTJ50Okuu6i5ER6ZA9Tu4iQOPZcZcb8FIuxK2duvrx8pS
         PcYIxc08dxalxZxvllmiCcvNc6lctDrhxeVCanVs3Jc+Bah5k8Yrg6jgACxT3LdR6h5Y
         RVTeu435MBdJtas8Fn0z+zlbRbqBcJesMZSJrj550SKuEPqFdWIIkMSmfuX36XcQTOo9
         gNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IqhCaLiTa6tkSv6MqqTRbQ1OxRAqlbeQ5TORP1OY+H8=;
        b=D4/3bmjBxjqr1J2QI4+wPjYp72q3FnEicaruFqfDWnrK/HqA13DG4SOrtj19pwuTb/
         u95L9OhuqEQiz+kGCiI9QkWjLertlE+ow8MWI5hhM3yJgLkIF263rA26LjFpcLaT4bg5
         xY9NOjJAwK1Xl/PpHUy85iY3b+R2kaOL30y/2Md9OIar9xLmJwD9FLw+jGamrySLTvvf
         i/qhgIa6+6W68/sE9s8d09+ScUp3sncOKZ0nzNoZ2edRWispLM5Cpsiufjp/LglEEd+E
         nJMB1vcMSDchcYWTVFlThAUTn1RdA/sNigYegu+TRnrRLBlPbfRz460jfCHSurAgizQu
         yBoQ==
X-Gm-Message-State: APjAAAVMm03xanzIWAEkTTuJQJRHh0u05SEqA6FW1AFSNFikkURoAoVq
        /3l3Z5szLn4NHahdFmV16q+mdXrW4VsqBHPhel4Zaw==
X-Google-Smtp-Source: APXvYqxN/dSzZFnpnWN+8dy9ahPF0y6uCD8a0afnFwJsgDEBq8MmvpkWF7wtdalyug22LdJf630eX8k6Zrgbb9wuMRlnLg==
X-Received: by 2002:ab0:714c:: with SMTP id k12mr12158617uao.124.1580196028122;
 Mon, 27 Jan 2020 23:20:28 -0800 (PST)
Date:   Mon, 27 Jan 2020 23:20:00 -0800
In-Reply-To: <20200128072002.79250-1-brendanhiggins@google.com>
Message-Id: <20200128072002.79250-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 5/7] kunit: test: add test plan to KUnit TAP format
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

TAP 14 allows an optional test plan to be emitted before the start of
the start of testing[1]; this is valuable because it makes it possible
for a test harness to detect whether the number of tests run matches the
number of tests expected to be run, ensuring that no tests silently
failed.

Link[1]: https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 lib/kunit/executor.c                          | 17 +++++
 lib/kunit/test.c                              | 11 ---
 tools/testing/kunit/kunit_parser.py           | 74 ++++++++++++++++---
 .../test_is_test_passed-all_passed.log        |  1 +
 .../test_data/test_is_test_passed-crash.log   |  1 +
 .../test_data/test_is_test_passed-failure.log |  1 +
 6 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index b75a46c560847..7fd16feff157e 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -11,11 +11,28 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
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
 	struct kunit_suite * const * const *suites, * const *subsuite;
 	bool has_test_failed = false;
 
+	kunit_print_tap_header();
+
 	for (suites = __kunit_suites_start;
 	     suites < __kunit_suites_end;
 	     suites++) {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 9242f932896c7..da56b94261b43 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -18,16 +18,6 @@ static void kunit_set_failure(struct kunit *test)
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
@@ -41,7 +31,6 @@ static size_t kunit_test_cases_len(struct kunit_case *test_cases)
 
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
2.25.0.341.g760bfbb309-goog

