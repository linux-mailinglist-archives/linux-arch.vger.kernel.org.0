Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7F9227D14
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 12:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgGUKap (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgGUKao (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 06:30:44 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA559C0619D8
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:43 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id c81so833842wmd.2
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lzumWwjBCjoWvyaVpmfup+Sfq7jvpdMDLzihovn9kHY=;
        b=XzNICzMl96GTqpwyTEKH5WKZeDkOtiAXlCZP7pH5ox0PR5UXpNDwNxPWg0EGzpsMmu
         pA0+IUug3DbSzs9VGjOzLmSr3vBkQeKlCW9ITE52cMpX7CELsrfKiDprEb6vyeO/i//a
         EXRVaWM8cgtlHEsKnsJKojvbtRlSct98lnKW3um17+/QFnGZWjLF6FamD28VnpVYBOWv
         vLkPioi7u19bxDSdsCzD3iiN0ltF+/KoY0jpmm9tn3GglNEajbwwkYqGCjw/skwhz3YH
         lEMqA9pADOQz3uvTCf6N6bmiD7Yi1So40YbiDDmED7qaHwFjYZxF0J2Y89LQ3VIMCmPt
         pc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lzumWwjBCjoWvyaVpmfup+Sfq7jvpdMDLzihovn9kHY=;
        b=jbjXDisKSh2B3slxqmj8wDJokITDwYoWLBBLDQ/LqU6vpw92pAbMe2c0gK5hsbcI7x
         hP2yvmog2eyNkG7h3Sg0gcCt7enZVxSfWIKw2q5f0STAfPFcGIfLU9j8mwK/Igpvx90/
         WiO0z4BUEQzLf2j1ASk/cpmkeGht2+AnxQ4cZzr3xRsviBykNlobQN31ZCywcgVkdXzg
         +1oGIeNlvWpoW2qUbhBF8OIZovwmnNc5j9tYOa6KLt69RERLcXZM1VrcpDyr5bZ2QnxT
         +Cdi3fDXtGc/RTWGcHundNZilLRLN7csjho2j6dS/DA5/ZMJ0hJQJphAbxDHl8V3ypOI
         qD+g==
X-Gm-Message-State: AOAM531Ag+RNFWOKCQAIoCtI7bYNJ/T/oruoBAbbA+Ehtdpsz2eB0hqF
        N43Jhg68cMosme7xsOrNvJiyrDSz6A==
X-Google-Smtp-Source: ABdhPJwgd8IpT+jUQd7OWmDImA2feZ4wIkPNBF7HY1ArJ7SmudBXqMqL+teaLONo/sLplPkXM8vt+KfgUQ==
X-Received: by 2002:a1c:984d:: with SMTP id a74mr3644277wme.140.1595327442395;
 Tue, 21 Jul 2020 03:30:42 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:30:13 +0200
In-Reply-To: <20200721103016.3287832-1-elver@google.com>
Message-Id: <20200721103016.3287832-6-elver@google.com>
Mime-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 5/8] kcsan: Test support for compound instrumentation
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Changes kcsan-test module to support checking reports that include
compound instrumentation. Since we should not fail the test if this
support is unavailable, we have to add a config variable that the test
can use to decide what to check for.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan-test.c | 65 ++++++++++++++++++++++++++++++---------
 lib/Kconfig.kcsan         |  5 +++
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
index 721180cbbab1..ebe7fd245104 100644
--- a/kernel/kcsan/kcsan-test.c
+++ b/kernel/kcsan/kcsan-test.c
@@ -27,6 +27,12 @@
 #include <linux/types.h>
 #include <trace/events/printk.h>
 
+#ifdef CONFIG_CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
+#define __KCSAN_ACCESS_RW(alt) (KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE)
+#else
+#define __KCSAN_ACCESS_RW(alt) (alt)
+#endif
+
 /* Points to current test-case memory access "kernels". */
 static void (*access_kernels[2])(void);
 
@@ -186,20 +192,21 @@ static bool report_matches(const struct expect_report *r)
 
 	/* Access 1 & 2 */
 	for (i = 0; i < 2; ++i) {
+		const int ty = r->access[i].type;
 		const char *const access_type =
-			(r->access[i].type & KCSAN_ACCESS_ASSERT) ?
-				((r->access[i].type & KCSAN_ACCESS_WRITE) ?
-					 "assert no accesses" :
-					 "assert no writes") :
-				((r->access[i].type & KCSAN_ACCESS_WRITE) ?
-					 "write" :
-					 "read");
+			(ty & KCSAN_ACCESS_ASSERT) ?
+				      ((ty & KCSAN_ACCESS_WRITE) ?
+					       "assert no accesses" :
+					       "assert no writes") :
+				      ((ty & KCSAN_ACCESS_WRITE) ?
+					       ((ty & KCSAN_ACCESS_COMPOUND) ?
+							"read-write" :
+							"write") :
+					       "read");
 		const char *const access_type_aux =
-			(r->access[i].type & KCSAN_ACCESS_ATOMIC) ?
-				" (marked)" :
-				((r->access[i].type & KCSAN_ACCESS_SCOPED) ?
-					 " (scoped)" :
-					 "");
+			(ty & KCSAN_ACCESS_ATOMIC) ?
+				      " (marked)" :
+				      ((ty & KCSAN_ACCESS_SCOPED) ? " (scoped)" : "");
 
 		if (i == 1) {
 			/* Access 2 */
@@ -277,6 +284,12 @@ static noinline void test_kernel_write_atomic(void)
 	WRITE_ONCE(test_var, READ_ONCE_NOCHECK(test_sink) + 1);
 }
 
+static noinline void test_kernel_atomic_rmw(void)
+{
+	/* Use builtin, so we can set up the "bad" atomic/non-atomic scenario. */
+	__atomic_fetch_add(&test_var, 1, __ATOMIC_RELAXED);
+}
+
 __no_kcsan
 static noinline void test_kernel_write_uninstrumented(void) { test_var++; }
 
@@ -439,8 +452,8 @@ static void test_concurrent_races(struct kunit *test)
 	const struct expect_report expect = {
 		.access = {
 			/* NULL will match any address. */
-			{ test_kernel_rmw_array, NULL, 0, KCSAN_ACCESS_WRITE },
-			{ test_kernel_rmw_array, NULL, 0, 0 },
+			{ test_kernel_rmw_array, NULL, 0, __KCSAN_ACCESS_RW(KCSAN_ACCESS_WRITE) },
+			{ test_kernel_rmw_array, NULL, 0, __KCSAN_ACCESS_RW(0) },
 		},
 	};
 	static const struct expect_report never = {
@@ -629,6 +642,29 @@ static void test_read_plain_atomic_write(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, match_expect);
 }
 
+/* Test that atomic RMWs generate correct report. */
+__no_kcsan
+static void test_read_plain_atomic_rmw(struct kunit *test)
+{
+	const struct expect_report expect = {
+		.access = {
+			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
+			{ test_kernel_atomic_rmw, &test_var, sizeof(test_var),
+				KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC },
+		},
+	};
+	bool match_expect = false;
+
+	if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))
+		return;
+
+	begin_test_checks(test_kernel_read, test_kernel_atomic_rmw);
+	do {
+		match_expect = report_matches(&expect);
+	} while (!end_test_checks(match_expect));
+	KUNIT_EXPECT_TRUE(test, match_expect);
+}
+
 /* Zero-sized accesses should never cause data race reports. */
 __no_kcsan
 static void test_zero_size_access(struct kunit *test)
@@ -942,6 +978,7 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_write_write_struct_part),
 	KCSAN_KUNIT_CASE(test_read_atomic_write_atomic),
 	KCSAN_KUNIT_CASE(test_read_plain_atomic_write),
+	KCSAN_KUNIT_CASE(test_read_plain_atomic_rmw),
 	KCSAN_KUNIT_CASE(test_zero_size_access),
 	KCSAN_KUNIT_CASE(test_data_race),
 	KCSAN_KUNIT_CASE(test_assert_exclusive_writer),
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 3d282d51849b..cde5b62b0a01 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -40,6 +40,11 @@ menuconfig KCSAN
 
 if KCSAN
 
+# Compiler capabilities that should not fail the test if they are unavailable.
+config CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
+	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-compound-read-before-write=1)) || \
+		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param -tsan-compound-read-before-write=1))
+
 config KCSAN_VERBOSE
 	bool "Show verbose reports with more information about system state"
 	depends on PROVE_LOCKING
-- 
2.28.0.rc0.105.gf9edc3c819-goog

