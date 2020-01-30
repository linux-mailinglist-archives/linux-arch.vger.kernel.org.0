Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E965A14E60B
	for <lists+linux-arch@lfdr.de>; Fri, 31 Jan 2020 00:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgA3XI7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jan 2020 18:08:59 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44201 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgA3XIk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jan 2020 18:08:40 -0500
Received: by mail-pg1-f201.google.com with SMTP id o21so2753829pgm.11
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 15:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MP470Mm16Hbis3uK4k7c4Y0juRzNAQ4jaojQ4FBlGRU=;
        b=qUKS4/biEzUnqRfVp6CMVb9g2VsQwQM5ss8wWgmxhAEh7N2VSqjHFRlpTPo/f7mWRg
         9PO1MoSacP4zU4ZonpKGxOZYrEyppqNSUoXZa0FQt//aqOuXc89cbAvr0ezWDJ4GamtO
         BiZt1ehsxt7k4vkVItcppjb3GvfT1saAPVkTubBH/5WHPjLpLZrfNxtsAs4tlFqaM8Ct
         0NQxiswyTirVUAHgkpirY4VdeJZ14+VcQUYvCB5Hq+v/C2MpCBLC95YavwPj0wL7qRwo
         8DhYch1X7zqIrC958MLGmLeDXLdHjcpXcFAd8h8WSAOLOUVu7byljiU1Xi2E8Io7bhXC
         eiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MP470Mm16Hbis3uK4k7c4Y0juRzNAQ4jaojQ4FBlGRU=;
        b=ZVI43qHSYGw4zsl+D0ykOUIg2+7wZ/uyxda9ylqVQiwMZlSky92RoYDb0YyJjE2dFx
         c5/7Rd3g/pA9EjvwO+ZLvpBqMhkh1Jkq0En+Dng9EMH5f12besJStgIamu+ctGXY4hQo
         UG7DG6uO6Alz3oTKMKmWTNXp9hJt0/h0ed4bakiH40OOJVR7n64Qw/j54VuMHk0RNuy+
         +v5vSs/MLGUdzk5pgmYY6564RLfCTU83ga44LZNpr6N/OkKMO4XAUpaOzNMhQ8t6D/lG
         wfzczPqYlIG4PwCjzYfJVL5BcMhk/F3i5U0RoEjDnN3e1YNhYMSDp3lc4VF0SKOz/WoY
         RySw==
X-Gm-Message-State: APjAAAUYQiGHbRRHB2HJqUGKI9tXsMRKrTp2wR8JipQcMT+zZGHxsMr+
        CX2ffW3A4Q/iNFco2sgOrFQO3EYMqdig/YC6CUE7PA==
X-Google-Smtp-Source: APXvYqyakXU44AbYhg6GU2MGJUC6PijcNjm4QFympm/fEDorxw23X7egQMZVQ745p6ST6BfiY6ejMzNK6GIvB25GXWjyng==
X-Received: by 2002:a63:4503:: with SMTP id s3mr7221610pga.311.1580425719434;
 Thu, 30 Jan 2020 15:08:39 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:08:09 -0800
In-Reply-To: <20200130230812.142642-1-brendanhiggins@google.com>
Message-Id: <20200130230812.142642-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 4/7] init: main: add KUnit to kernel init
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

Remove KUnit from init calls entirely, instead call directly from
kernel_init().

Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/test.h | 9 +++++++++
 init/main.c          | 4 ++++
 lib/kunit/executor.c | 4 +---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 8a02f93a6b505..8689dd1459844 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -197,6 +197,15 @@ void kunit_init_test(struct kunit *test, const char *name);
 
 int kunit_run_tests(struct kunit_suite *suite);
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+int kunit_run_all_tests(void);
+#else
+static inline int kunit_run_all_tests(void)
+{
+	return 0;
+}
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 /*
  * If a test suite is built-in, module_init() gets translated into
  * an initcall which we don't want as the idea is that for builtins
diff --git a/init/main.c b/init/main.c
index 2cd736059416f..90301d4fbd1bb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -103,6 +103,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/initcall.h>
 
+#include <kunit/test.h>
+
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
@@ -1201,6 +1203,8 @@ static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
+	kunit_run_all_tests();
+
 	console_on_rootfs();
 
 	/*
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 6429927d598a5..b75a46c560847 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -11,7 +11,7 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
-static int kunit_run_all_tests(void)
+int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites, * const *subsuite;
 	bool has_test_failed = false;
@@ -31,6 +31,4 @@ static int kunit_run_all_tests(void)
 	return 0;
 }
 
-late_initcall(kunit_run_all_tests);
-
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
-- 
2.25.0.341.g760bfbb309-goog

