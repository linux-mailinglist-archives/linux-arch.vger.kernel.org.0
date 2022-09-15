Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247BE5B9E54
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiIOPJO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiIOPHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:07:35 -0400
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AE091097
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:45 -0700 (PDT)
Received: by mail-lj1-x249.google.com with SMTP id 6-20020a05651c008600b0026bda5a6db8so5515859ljq.5
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=3JQH+J/1Qh9DH/M6ilWXMVRmgzlMCJMKRJCWECEwFhM=;
        b=hVH6JxmqkPAVzxeh25koLhHIC+qlvQ/v36Wv3NB3JdyqAusa/ZzT6ma1Ky+EuJeUT5
         DYU+gsGphMjPbBGQ/fO4+YQHA4cDEhDqfkCIE1oFQrI9RqKyCg0R5uF4g7oGIAZyQa+r
         plOkgO7rIgngF6jlBPQ8CRDb213UVNRZCB4zW3IpKY95uj9/tQQeLbO9KS7kWXZqzHxc
         XifZgy400obs25pNvlwFPEkLgryaR0prvF3+cbKzL29bVoCw5CqbYiZ0rhJMpT/U5mrr
         CX1+jfh7DA7iLEafB5UFAALxMwVXUT+IZqPd0wngPrItnGUDI25hkuS0Zjfh2rRRNXhC
         X2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=3JQH+J/1Qh9DH/M6ilWXMVRmgzlMCJMKRJCWECEwFhM=;
        b=1BXtD37+O6uhQJ/UfgPCRTLGBq5O9mu4hbrtT3JriFQ/8t904/XAjUGL9aJc2jqnLH
         gaODHZkZs+/WL2ayIklqOm9z+GEpDF/gNllJ7pFVSfFZI0shpHkQCxpOO8vc3CIeZ28G
         IxpVuMPMmXV7WgD9aXxkYmIwr+Rka2Xp+XeORplGUocYL3rY8NDlaH3uePQV3d9A1WwG
         fQ7/NHb0pIFwnCYhqdaoC+FBrblvT5xra5/W+4JSCG1OPl6fzg6Z1UCb9FPY1LhadW9e
         3enrB+DTc1CKe3xPH8FjLQzH7l3xtt4slpZJrRk1R459GrpAgjKYqPQ5OeJKEoODlAnr
         odRQ==
X-Gm-Message-State: ACrzQf0j+aR0bCzErAqq0BYEepzwYKsDF7LbgqVc1731/QQqxoteEyv9
        gconV1sowIZPu/Z6ovwSb8wa2Dv+5t0=
X-Google-Smtp-Source: AMsMyM5V1/lgGe3MYN2LPDbxUiTzSwP3Ml9DNSMU1gaSoc4tzm3jrt1fIH5eYBdawlwar5MFfW/8kwQd+aI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:ac2:5f98:0:b0:49a:d9ad:f9c5 with SMTP id
 r24-20020ac25f98000000b0049ad9adf9c5mr124072lfe.14.1663254343865; Thu, 15 Sep
 2022 08:05:43 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:58 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-25-glider@google.com>
Subject: [PATCH v7 24/43] kmsan: add tests for KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The testing module triggers KMSAN warnings in different cases and checks
that the errors are properly reported, using console probes to capture
the tool's output.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- add memcpy tests

v4:
 -- change sizeof(type) to sizeof(*ptr)
 -- add test expectations for CONFIG_KMSAN_CHECK_PARAM_RETVAL

v5:
 -- reapply clang-format
 -- use modern style for-loops
 -- address Marco Elver's comments

v7:
 -- add test_long_origin_chain to check for origin chains exceeding max
    depth

Link: https://linux-review.googlesource.com/id/I49c3f59014cc37fd13541c80beb0b75a75244650
---
 lib/Kconfig.kmsan     |  12 +
 mm/kmsan/Makefile     |   4 +
 mm/kmsan/kmsan_test.c | 581 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 597 insertions(+)
 create mode 100644 mm/kmsan/kmsan_test.c

diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
index 5b19dbd34d76e..b2489dd6503fa 100644
--- a/lib/Kconfig.kmsan
+++ b/lib/Kconfig.kmsan
@@ -47,4 +47,16 @@ config KMSAN_CHECK_PARAM_RETVAL
 	  may potentially report errors in corner cases when non-instrumented
 	  functions call instrumented ones.
 
+config KMSAN_KUNIT_TEST
+	tristate "KMSAN integration test suite" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
+	depends on TRACEPOINTS && KUNIT
+	help
+	  Test suite for KMSAN, testing various error detection scenarios,
+	  and checking that reports are correctly output to console.
+
+	  Say Y here if you want the test to be built into the kernel and run
+	  during boot; say M if you want the test to build as a module; say N
+	  if you are unsure.
+
 endif
diff --git a/mm/kmsan/Makefile b/mm/kmsan/Makefile
index 401acb1a491ce..98eab2856626f 100644
--- a/mm/kmsan/Makefile
+++ b/mm/kmsan/Makefile
@@ -22,3 +22,7 @@ CFLAGS_init.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_instrumentation.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_report.o := $(CC_FLAGS_KMSAN_RUNTIME)
 CFLAGS_shadow.o := $(CC_FLAGS_KMSAN_RUNTIME)
+
+obj-$(CONFIG_KMSAN_KUNIT_TEST) += kmsan_test.o
+KMSAN_SANITIZE_kmsan_test.o := y
+CFLAGS_kmsan_test.o += $(call cc-disable-warning, uninitialized)
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
new file mode 100644
index 0000000000000..9a29ea2dbfb9b
--- /dev/null
+++ b/mm/kmsan/kmsan_test.c
@@ -0,0 +1,581 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for KMSAN.
+ * For each test case checks the presence (or absence) of generated reports.
+ * Relies on 'console' tracepoint to capture reports as they appear in the
+ * kernel log.
+ *
+ * Copyright (C) 2021-2022, Google LLC.
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#include <kunit/test.h>
+#include "kmsan.h"
+
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/kmsan.h>
+#include <linux/mm.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/tracepoint.h>
+#include <trace/events/printk.h>
+
+static DEFINE_PER_CPU(int, per_cpu_var);
+
+/* Report as observed from console. */
+static struct {
+	spinlock_t lock;
+	bool available;
+	bool ignore; /* Stop console output collection. */
+	char header[256];
+} observed = {
+	.lock = __SPIN_LOCK_UNLOCKED(observed.lock),
+};
+
+/* Probe for console output: obtains observed lines of interest. */
+static void probe_console(void *ignore, const char *buf, size_t len)
+{
+	unsigned long flags;
+
+	if (observed.ignore)
+		return;
+	spin_lock_irqsave(&observed.lock, flags);
+
+	if (strnstr(buf, "BUG: KMSAN: ", len)) {
+		/*
+		 * KMSAN report and related to the test.
+		 *
+		 * The provided @buf is not NUL-terminated; copy no more than
+		 * @len bytes and let strscpy() add the missing NUL-terminator.
+		 */
+		strscpy(observed.header, buf,
+			min(len + 1, sizeof(observed.header)));
+		WRITE_ONCE(observed.available, true);
+		observed.ignore = true;
+	}
+	spin_unlock_irqrestore(&observed.lock, flags);
+}
+
+/* Check if a report related to the test exists. */
+static bool report_available(void)
+{
+	return READ_ONCE(observed.available);
+}
+
+/* Information we expect in a report. */
+struct expect_report {
+	const char *error_type; /* Error type. */
+	/*
+	 * Kernel symbol from the error header, or NULL if no report is
+	 * expected.
+	 */
+	const char *symbol;
+};
+
+/* Check observed report matches information in @r. */
+static bool report_matches(const struct expect_report *r)
+{
+	typeof(observed.header) expected_header;
+	unsigned long flags;
+	bool ret = false;
+	const char *end;
+	char *cur;
+
+	/* Doubled-checked locking. */
+	if (!report_available() || !r->symbol)
+		return (!report_available() && !r->symbol);
+
+	/* Generate expected report contents. */
+
+	/* Title */
+	cur = expected_header;
+	end = &expected_header[sizeof(expected_header) - 1];
+
+	cur += scnprintf(cur, end - cur, "BUG: KMSAN: %s", r->error_type);
+
+	scnprintf(cur, end - cur, " in %s", r->symbol);
+	/* The exact offset won't match, remove it; also strip module name. */
+	cur = strchr(expected_header, '+');
+	if (cur)
+		*cur = '\0';
+
+	spin_lock_irqsave(&observed.lock, flags);
+	if (!report_available())
+		goto out; /* A new report is being captured. */
+
+	/* Finally match expected output to what we actually observed. */
+	ret = strstr(observed.header, expected_header);
+out:
+	spin_unlock_irqrestore(&observed.lock, flags);
+
+	return ret;
+}
+
+/* ===== Test cases ===== */
+
+/* Prevent replacing branch with select in LLVM. */
+static noinline void check_true(char *arg)
+{
+	pr_info("%s is true\n", arg);
+}
+
+static noinline void check_false(char *arg)
+{
+	pr_info("%s is false\n", arg);
+}
+
+#define USE(x)                           \
+	do {                             \
+		if (x)                   \
+			check_true(#x);  \
+		else                     \
+			check_false(#x); \
+	} while (0)
+
+#define EXPECTATION_ETYPE_FN(e, reason, fn) \
+	struct expect_report e = {          \
+		.error_type = reason,       \
+		.symbol = fn,               \
+	}
+
+#define EXPECTATION_NO_REPORT(e) EXPECTATION_ETYPE_FN(e, NULL, NULL)
+#define EXPECTATION_UNINIT_VALUE_FN(e, fn) \
+	EXPECTATION_ETYPE_FN(e, "uninit-value", fn)
+#define EXPECTATION_UNINIT_VALUE(e) EXPECTATION_UNINIT_VALUE_FN(e, __func__)
+#define EXPECTATION_USE_AFTER_FREE(e) \
+	EXPECTATION_ETYPE_FN(e, "use-after-free", __func__)
+
+/* Test case: ensure that kmalloc() returns uninitialized memory. */
+static void test_uninit_kmalloc(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE(expect);
+	int *ptr;
+
+	kunit_info(test, "uninitialized kmalloc test (UMR report)\n");
+	ptr = kmalloc(sizeof(*ptr), GFP_KERNEL);
+	USE(*ptr);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/*
+ * Test case: ensure that kmalloc'ed memory becomes initialized after memset().
+ */
+static void test_init_kmalloc(struct kunit *test)
+{
+	EXPECTATION_NO_REPORT(expect);
+	int *ptr;
+
+	kunit_info(test, "initialized kmalloc test (no reports)\n");
+	ptr = kmalloc(sizeof(*ptr), GFP_KERNEL);
+	memset(ptr, 0, sizeof(*ptr));
+	USE(*ptr);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/* Test case: ensure that kzalloc() returns initialized memory. */
+static void test_init_kzalloc(struct kunit *test)
+{
+	EXPECTATION_NO_REPORT(expect);
+	int *ptr;
+
+	kunit_info(test, "initialized kzalloc test (no reports)\n");
+	ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
+	USE(*ptr);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/* Test case: ensure that local variables are uninitialized by default. */
+static void test_uninit_stack_var(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE(expect);
+	volatile int cond;
+
+	kunit_info(test, "uninitialized stack variable (UMR report)\n");
+	USE(cond);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/* Test case: ensure that local variables with initializers are initialized. */
+static void test_init_stack_var(struct kunit *test)
+{
+	EXPECTATION_NO_REPORT(expect);
+	volatile int cond = 1;
+
+	kunit_info(test, "initialized stack variable (no reports)\n");
+	USE(cond);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+static noinline void two_param_fn_2(int arg1, int arg2)
+{
+	USE(arg1);
+	USE(arg2);
+}
+
+static noinline void one_param_fn(int arg)
+{
+	two_param_fn_2(arg, arg);
+	USE(arg);
+}
+
+static noinline void two_param_fn(int arg1, int arg2)
+{
+	int init = 0;
+
+	one_param_fn(init);
+	USE(arg1);
+	USE(arg2);
+}
+
+static void test_params(struct kunit *test)
+{
+#ifdef CONFIG_KMSAN_CHECK_PARAM_RETVAL
+	/*
+	 * With eager param/retval checking enabled, KMSAN will report an error
+	 * before the call to two_param_fn().
+	 */
+	EXPECTATION_UNINIT_VALUE_FN(expect, "test_params");
+#else
+	EXPECTATION_UNINIT_VALUE_FN(expect, "two_param_fn");
+#endif
+	volatile int uninit, init = 1;
+
+	kunit_info(test,
+		   "uninit passed through a function parameter (UMR report)\n");
+	two_param_fn(uninit, init);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+static int signed_sum3(int a, int b, int c)
+{
+	return a + b + c;
+}
+
+/*
+ * Test case: ensure that uninitialized values are tracked through function
+ * arguments.
+ */
+static void test_uninit_multiple_params(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE(expect);
+	volatile char b = 3, c;
+	volatile int a;
+
+	kunit_info(test, "uninitialized local passed to fn (UMR report)\n");
+	USE(signed_sum3(a, b, c));
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/* Helper function to make an array uninitialized. */
+static noinline void do_uninit_local_array(char *array, int start, int stop)
+{
+	volatile char uninit;
+
+	for (int i = start; i < stop; i++)
+		array[i] = uninit;
+}
+
+/*
+ * Test case: ensure kmsan_check_memory() reports an error when checking
+ * uninitialized memory.
+ */
+static void test_uninit_kmsan_check_memory(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE_FN(expect, "test_uninit_kmsan_check_memory");
+	volatile char local_array[8];
+
+	kunit_info(
+		test,
+		"kmsan_check_memory() called on uninit local (UMR report)\n");
+	do_uninit_local_array((char *)local_array, 5, 7);
+
+	kmsan_check_memory((char *)local_array, 8);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/*
+ * Test case: check that a virtual memory range created with vmap() from
+ * initialized pages is still considered as initialized.
+ */
+static void test_init_kmsan_vmap_vunmap(struct kunit *test)
+{
+	EXPECTATION_NO_REPORT(expect);
+	const int npages = 2;
+	struct page **pages;
+	void *vbuf;
+
+	kunit_info(test, "pages initialized via vmap (no reports)\n");
+
+	pages = kmalloc_array(npages, sizeof(*pages), GFP_KERNEL);
+	for (int i = 0; i < npages; i++)
+		pages[i] = alloc_page(GFP_KERNEL);
+	vbuf = vmap(pages, npages, VM_MAP, PAGE_KERNEL);
+	memset(vbuf, 0xfe, npages * PAGE_SIZE);
+	for (int i = 0; i < npages; i++)
+		kmsan_check_memory(page_address(pages[i]), PAGE_SIZE);
+
+	if (vbuf)
+		vunmap(vbuf);
+	for (int i = 0; i < npages; i++) {
+		if (pages[i])
+			__free_page(pages[i]);
+	}
+	kfree(pages);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/*
+ * Test case: ensure that memset() can initialize a buffer allocated via
+ * vmalloc().
+ */
+static void test_init_vmalloc(struct kunit *test)
+{
+	EXPECTATION_NO_REPORT(expect);
+	int npages = 8;
+	char *buf;
+
+	kunit_info(test, "vmalloc buffer can be initialized (no reports)\n");
+	buf = vmalloc(PAGE_SIZE * npages);
+	buf[0] = 1;
+	memset(buf, 0xfe, PAGE_SIZE * npages);
+	USE(buf[0]);
+	for (int i = 0; i < npages; i++)
+		kmsan_check_memory(&buf[PAGE_SIZE * i], PAGE_SIZE);
+	vfree(buf);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/* Test case: ensure that use-after-free reporting works. */
+static void test_uaf(struct kunit *test)
+{
+	EXPECTATION_USE_AFTER_FREE(expect);
+	volatile int value;
+	volatile int *var;
+
+	kunit_info(test, "use-after-free in kmalloc-ed buffer (UMR report)\n");
+	var = kmalloc(80, GFP_KERNEL);
+	var[3] = 0xfeedface;
+	kfree((int *)var);
+	/* Copy the invalid value before checking it. */
+	value = var[3];
+	USE(value);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/*
+ * Test case: ensure that uninitialized values are propagated through per-CPU
+ * memory.
+ */
+static void test_percpu_propagate(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE(expect);
+	volatile int uninit, check;
+
+	kunit_info(test,
+		   "uninit local stored to per_cpu memory (UMR report)\n");
+
+	this_cpu_write(per_cpu_var, uninit);
+	check = this_cpu_read(per_cpu_var);
+	USE(check);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/*
+ * Test case: ensure that passing uninitialized values to printk() leads to an
+ * error report.
+ */
+static void test_printk(struct kunit *test)
+{
+#ifdef CONFIG_KMSAN_CHECK_PARAM_RETVAL
+	/*
+	 * With eager param/retval checking enabled, KMSAN will report an error
+	 * before the call to pr_info().
+	 */
+	EXPECTATION_UNINIT_VALUE_FN(expect, "test_printk");
+#else
+	EXPECTATION_UNINIT_VALUE_FN(expect, "number");
+#endif
+	volatile int uninit;
+
+	kunit_info(test, "uninit local passed to pr_info() (UMR report)\n");
+	pr_info("%px contains %d\n", &uninit, uninit);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/*
+ * Test case: ensure that memcpy() correctly copies uninitialized values between
+ * aligned `src` and `dst`.
+ */
+static void test_memcpy_aligned_to_aligned(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE_FN(expect, "test_memcpy_aligned_to_aligned");
+	volatile int uninit_src;
+	volatile int dst = 0;
+
+	kunit_info(
+		test,
+		"memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
+	memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
+	kmsan_check_memory((void *)&dst, sizeof(dst));
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/*
+ * Test case: ensure that memcpy() correctly copies uninitialized values between
+ * aligned `src` and unaligned `dst`.
+ *
+ * Copying aligned 4-byte value to an unaligned one leads to touching two
+ * aligned 4-byte values. This test case checks that KMSAN correctly reports an
+ * error on the first of the two values.
+ */
+static void test_memcpy_aligned_to_unaligned(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE_FN(expect, "test_memcpy_aligned_to_unaligned");
+	volatile int uninit_src;
+	volatile char dst[8] = { 0 };
+
+	kunit_info(
+		test,
+		"memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
+	memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
+	kmsan_check_memory((void *)dst, 4);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+/*
+ * Test case: ensure that memcpy() correctly copies uninitialized values between
+ * aligned `src` and unaligned `dst`.
+ *
+ * Copying aligned 4-byte value to an unaligned one leads to touching two
+ * aligned 4-byte values. This test case checks that KMSAN correctly reports an
+ * error on the second of the two values.
+ */
+static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE_FN(expect,
+				    "test_memcpy_aligned_to_unaligned2");
+	volatile int uninit_src;
+	volatile char dst[8] = { 0 };
+
+	kunit_info(
+		test,
+		"memcpy()ing aligned uninit src to unaligned dst - part 2 (UMR report)\n");
+	memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
+	kmsan_check_memory((void *)&dst[4], sizeof(uninit_src));
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+static noinline void fibonacci(int *array, int size, int start) {
+	if (start < 2 || (start == size))
+		return;
+	array[start] = array[start - 1] + array[start - 2];
+	fibonacci(array, size, start + 1);
+}
+
+static void test_long_origin_chain(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE_FN(expect,
+				    "test_long_origin_chain");
+	/* (KMSAN_MAX_ORIGIN_DEPTH * 2) recursive calls to fibonacci(). */
+	volatile int accum[KMSAN_MAX_ORIGIN_DEPTH * 2 + 2];
+	int last = ARRAY_SIZE(accum) - 1;
+
+	kunit_info(
+		test,
+		"origin chain exceeding KMSAN_MAX_ORIGIN_DEPTH (UMR report)\n");
+	/*
+	 * We do not set accum[1] to 0, so the uninitializedness will be carried
+	 * over to accum[2..last].
+	 */
+	accum[0] = 1;
+	fibonacci((int *)accum, ARRAY_SIZE(accum), 2);
+	kmsan_check_memory((void *)&accum[last], sizeof(int));
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
+static struct kunit_case kmsan_test_cases[] = {
+	KUNIT_CASE(test_uninit_kmalloc),
+	KUNIT_CASE(test_init_kmalloc),
+	KUNIT_CASE(test_init_kzalloc),
+	KUNIT_CASE(test_uninit_stack_var),
+	KUNIT_CASE(test_init_stack_var),
+	KUNIT_CASE(test_params),
+	KUNIT_CASE(test_uninit_multiple_params),
+	KUNIT_CASE(test_uninit_kmsan_check_memory),
+	KUNIT_CASE(test_init_kmsan_vmap_vunmap),
+	KUNIT_CASE(test_init_vmalloc),
+	KUNIT_CASE(test_uaf),
+	KUNIT_CASE(test_percpu_propagate),
+	KUNIT_CASE(test_printk),
+	KUNIT_CASE(test_memcpy_aligned_to_aligned),
+	KUNIT_CASE(test_memcpy_aligned_to_unaligned),
+	KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
+	KUNIT_CASE(test_long_origin_chain),
+	{},
+};
+
+/* ===== End test cases ===== */
+
+static int test_init(struct kunit *test)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&observed.lock, flags);
+	observed.header[0] = '\0';
+	observed.ignore = false;
+	observed.available = false;
+	spin_unlock_irqrestore(&observed.lock, flags);
+
+	return 0;
+}
+
+static void test_exit(struct kunit *test)
+{
+}
+
+static void register_tracepoints(struct tracepoint *tp, void *ignore)
+{
+	check_trace_callback_type_console(probe_console);
+	if (!strcmp(tp->name, "console"))
+		WARN_ON(tracepoint_probe_register(tp, probe_console, NULL));
+}
+
+static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
+{
+	if (!strcmp(tp->name, "console"))
+		tracepoint_probe_unregister(tp, probe_console, NULL);
+}
+
+static int kmsan_suite_init(struct kunit_suite *suite)
+{
+	/*
+	 * Because we want to be able to build the test as a module, we need to
+	 * iterate through all known tracepoints, since the static registration
+	 * won't work here.
+	 */
+	for_each_kernel_tracepoint(register_tracepoints, NULL);
+	return 0;
+}
+
+static void kmsan_suite_exit(struct kunit_suite *suite)
+{
+	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
+	tracepoint_synchronize_unregister();
+}
+
+static struct kunit_suite kmsan_test_suite = {
+	.name = "kmsan",
+	.test_cases = kmsan_test_cases,
+	.init = test_init,
+	.exit = test_exit,
+	.suite_init = kmsan_suite_init,
+	.suite_exit = kmsan_suite_exit,
+};
+kunit_test_suites(&kmsan_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alexander Potapenko <glider@google.com>");
-- 
2.37.2.789.g6183377224-goog

