Return-Path: <linux-arch+bounces-655-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE0804195
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 23:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F366B20BEC
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 22:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1203D3AC26;
	Mon,  4 Dec 2023 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ac7mQyoL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B1C124
	for <linux-arch@vger.kernel.org>; Mon,  4 Dec 2023 14:19:39 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d6b751dabcso33482997b3.1
        for <linux-arch@vger.kernel.org>; Mon, 04 Dec 2023 14:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701728379; x=1702333179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6/xsp/08ebsCbpaOu2zw7fiAx95DZqURF0y3jqrrm0=;
        b=Ac7mQyoLult1CTmfc0baS2746lyGRg/DkSTfGYUeC62Jt4JCQA7E3I1tjst1bjkUSv
         eGhlKS88a8knizqfV9rLpLGjRi9+FH7Y8QCFIW86CvFP4UUzBu8N1oa3MlGYS9xIhLK1
         mQmIhntgC/G3wA/eO61QE8jUQ2SQcC3egvGISSyBi8g3yKAYcSIqPvGXA4CIdBJdEODa
         GC6grKGBT7Ny74m2GeU+AhTXOrfkwToWv46JoANHhJlm+Fq75zqgC4rVXsUCAAOL7G1t
         kBuVmJ74aQMJtcdLXN3OeciaErAhYkNhOx6Zvkh0B54KxikOJ3GaQRv84y0DHUn8TFhi
         v+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728379; x=1702333179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6/xsp/08ebsCbpaOu2zw7fiAx95DZqURF0y3jqrrm0=;
        b=w150md0NRnWj7mPatfbPfKqDpPwiitFYK245FDfTNnbtMuvK/4I3/ONRSdX/Df6Vq5
         5wAB3duc3k8ZAortrHk8HMc4geLG4JnCgGv4EyvZm2ZQG/u7rO/Te27+YmzRmPtAvxrZ
         VxdPJFlNj6pXZrHkqg/nKW+vNvq8ZawSDY2s1PEimkTuyGOcq63ILsys/dMfIOLmO8xi
         UCzmgA8ihLWZ0DibraH9chMLCq8onVyELuqCkWNq2OrXJdvn43+sevVATOILMOJcE93l
         Rv25D4Z3OsF13jnoIy6f+pyBHeW3hb/spULfecUABVF1Gz6xFq9s+T3HSpmainm8TUJ5
         JDeg==
X-Gm-Message-State: AOJu0YyyXL+NBXXJgiqw6JVYPiynQStNx3BxwrOTeOqgTrJzl344xlwZ
	tg5L7NxPPzqL9OIEWK3OrXW45Uu+Hg==
X-Google-Smtp-Source: AGHT+IF/hi7xWVRvUmfAYK2GkkcH7P0JS14ArSV7g3dal1RCvBTJEI/qyrvRO8yLzDuFDE19rnbb03SlvA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:b60d:0:b0:5d7:545e:3bd0 with SMTP id
 u13-20020a81b60d000000b005d7545e3bd0mr160730ywh.4.1701728379215; Mon, 04 Dec
 2023 14:19:39 -0800 (PST)
Date: Mon,  4 Dec 2023 22:19:27 +0000
In-Reply-To: <20231204221932.1465004-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204221932.1465004-2-rmoar@google.com>
Subject: [PATCH v3 2/6] kunit: add KUNIT_INIT_TABLE to init linker section
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, sadiyakazi@google.com
Cc: keescook@chromium.org, arnd@arndb.de, linux-kselftest@vger.kernel.org, 
	linux-arch@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add KUNIT_INIT_TABLE to the INIT_DATA linker section.

Alter the KUnit macros to create init tests:
kunit_test_init_section_suites

Update lib/kunit/executor.c to run both the suites in KUNIT_TABLE and
KUNIT_INIT_TABLE.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/asm-generic/vmlinux.lds.h |  9 ++++-
 include/kunit/test.h              | 10 ++++-
 include/linux/module.h            |  2 +
 kernel/module/main.c              |  3 ++
 lib/kunit/executor.c              | 64 ++++++++++++++++++++++++++++---
 lib/kunit/test.c                  | 26 +++++++++----
 6 files changed, 99 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1107905d37fc..5dd3a61d673d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -700,7 +700,8 @@
 	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
-	EARLY_LSM_TABLE()
+	EARLY_LSM_TABLE()						\
+	KUNIT_INIT_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
@@ -926,6 +927,12 @@
 		. = ALIGN(8);						\
 		BOUNDED_SECTION_POST_LABEL(.kunit_test_suites, __kunit_suites, _start, _end)
 
+/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
+#define KUNIT_INIT_TABLE()						\
+		. = ALIGN(8);						\
+		BOUNDED_SECTION_POST_LABEL(.kunit_init_test_suites, \
+				__kunit_init_suites, _start, _end)
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 20ed9f9275c9..06e826a0b894 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -337,6 +337,9 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
 void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builtin);
 void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr);
 
+struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_set,
+		struct kunit_suite_set suite_set);
+
 #if IS_BUILTIN(CONFIG_KUNIT)
 int kunit_run_all_tests(void);
 #else
@@ -371,6 +374,11 @@ static inline int kunit_run_all_tests(void)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
 
+#define __kunit_init_test_suites(unique_array, ...)			       \
+	static struct kunit_suite *unique_array[]			       \
+	__aligned(sizeof(struct kunit_suite *))				       \
+	__used __section(".kunit_init_test_suites") = { __VA_ARGS__ }
+
 /**
  * kunit_test_init_section_suites() - used to register one or more &struct
  *				      kunit_suite containing init functions or
@@ -392,7 +400,7 @@ static inline int kunit_run_all_tests(void)
  * this manner.
  */
 #define kunit_test_init_section_suites(__suites...)			\
-	__kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),	\
+	__kunit_init_test_suites(__UNIQUE_ID(array),			\
 			    ##__suites)
 
 #define kunit_test_init_section_suite(suite)	\
diff --git a/include/linux/module.h b/include/linux/module.h
index a98e188cf37b..9cd0009bd050 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -540,6 +540,8 @@ struct module {
 	struct static_call_site *static_call_sites;
 #endif
 #if IS_ENABLED(CONFIG_KUNIT)
+	int num_kunit_init_suites;
+	struct kunit_suite **kunit_init_suites;
 	int num_kunit_suites;
 	struct kunit_suite **kunit_suites;
 #endif
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..36681911c05a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2199,6 +2199,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->kunit_suites = section_objs(info, ".kunit_test_suites",
 					      sizeof(*mod->kunit_suites),
 					      &mod->num_kunit_suites);
+	mod->kunit_init_suites = section_objs(info, ".kunit_init_test_suites",
+					      sizeof(*mod->kunit_init_suites),
+					      &mod->num_kunit_init_suites);
 #endif
 
 	mod->extable = section_objs(info, "__ex_table",
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 1236b3cd2fbb..847329c51e91 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -12,6 +12,8 @@
  */
 extern struct kunit_suite * const __kunit_suites_start[];
 extern struct kunit_suite * const __kunit_suites_end[];
+extern struct kunit_suite * const __kunit_init_suites_start[];
+extern struct kunit_suite * const __kunit_init_suites_end[];
 
 static char *action_param;
 
@@ -292,6 +294,33 @@ void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr)
 	}
 }
 
+struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_set,
+		struct kunit_suite_set suite_set)
+{
+	struct kunit_suite_set total_suite_set = {NULL, NULL};
+	struct kunit_suite **total_suite_start = NULL;
+	size_t init_num_suites, num_suites, suite_size;
+
+	init_num_suites = init_suite_set.end - init_suite_set.start;
+	num_suites = suite_set.end - suite_set.start;
+	suite_size = sizeof(suite_set.start);
+
+	/* Allocate memory for array of all kunit suites */
+	total_suite_start = kmalloc_array(init_num_suites + num_suites, suite_size, GFP_KERNEL);
+	if (!total_suite_start)
+		return total_suite_set;
+
+	/* Append init suites and then all other kunit suites */
+	memcpy(total_suite_start, init_suite_set.start, init_num_suites * suite_size);
+	memcpy(total_suite_start + init_num_suites, suite_set.start, num_suites * suite_size);
+
+	/* Set kunit suite set start and end */
+	total_suite_set.start = total_suite_start;
+	total_suite_set.end = total_suite_start + (init_num_suites + num_suites);
+
+	return total_suite_set;
+}
+
 #if IS_BUILTIN(CONFIG_KUNIT)
 
 static char *kunit_shutdown;
@@ -313,21 +342,41 @@ static void kunit_handle_shutdown(void)
 
 int kunit_run_all_tests(void)
 {
-	struct kunit_suite_set suite_set = {
+	struct kunit_suite_set suite_set = {NULL, NULL};
+	struct kunit_suite_set filtered_suite_set = {NULL, NULL};
+	struct kunit_suite_set init_suite_set = {
+		__kunit_init_suites_start, __kunit_init_suites_end,
+	};
+	struct kunit_suite_set normal_suite_set = {
 		__kunit_suites_start, __kunit_suites_end,
 	};
+	size_t init_num_suites = init_suite_set.end - init_suite_set.start;
 	int err = 0;
+
+	if (init_num_suites > 0) {
+		suite_set = kunit_merge_suite_sets(init_suite_set, normal_suite_set);
+		if (!suite_set.start)
+			goto out;
+	} else
+		suite_set = normal_suite_set;
+
 	if (!kunit_enabled()) {
 		pr_info("kunit: disabled\n");
-		goto out;
+		goto free_out;
 	}
 
 	if (filter_glob_param || filter_param) {
-		suite_set = kunit_filter_suites(&suite_set, filter_glob_param,
+		filtered_suite_set = kunit_filter_suites(&suite_set, filter_glob_param,
 				filter_param, filter_action_param, &err);
+
+		/* Free original suite set before using filtered suite set */
+		if (init_num_suites > 0)
+			kfree(suite_set.start);
+		suite_set = filtered_suite_set;
+
 		if (err) {
 			pr_err("kunit executor: error filtering suites: %d\n", err);
-			goto out;
+			goto free_out;
 		}
 	}
 
@@ -340,9 +389,12 @@ int kunit_run_all_tests(void)
 	else
 		pr_err("kunit executor: unknown action '%s'\n", action_param);
 
-	if (filter_glob_param || filter_param) { /* a copy was made of each suite */
+free_out:
+	if (filter_glob_param || filter_param)
 		kunit_free_suite_set(suite_set);
-	}
+	else if (init_num_suites > 0)
+		/* Don't use kunit_free_suite_set because suites aren't individually allocated */
+		kfree(suite_set.start);
 
 out:
 	kunit_handle_shutdown();
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f2eb71f1a66c..8bae6e2bc6a0 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -704,28 +704,40 @@ EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 #ifdef CONFIG_MODULES
 static void kunit_module_init(struct module *mod)
 {
-	struct kunit_suite_set suite_set = {
+	struct kunit_suite_set suite_set, filtered_set;
+	struct kunit_suite_set normal_suite_set = {
 		mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
 	};
+	struct kunit_suite_set init_suite_set = {
+		mod->kunit_init_suites, mod->kunit_init_suites + mod->num_kunit_init_suites,
+	};
 	const char *action = kunit_action();
 	int err = 0;
 
-	suite_set = kunit_filter_suites(&suite_set,
+	if (mod->num_kunit_init_suites > 0)
+		suite_set = kunit_merge_suite_sets(init_suite_set, normal_suite_set);
+	else
+		suite_set = normal_suite_set;
+
+	filtered_set = kunit_filter_suites(&suite_set,
 					kunit_filter_glob() ?: "*.*",
 					kunit_filter(), kunit_filter_action(),
 					&err);
 	if (err)
 		pr_err("kunit module: error filtering suites: %d\n", err);
 
-	mod->kunit_suites = (struct kunit_suite **)suite_set.start;
-	mod->num_kunit_suites = suite_set.end - suite_set.start;
+	mod->kunit_suites = (struct kunit_suite **)filtered_set.start;
+	mod->num_kunit_suites = filtered_set.end - filtered_set.start;
+
+	if (mod->num_kunit_init_suites > 0)
+		kfree(suite_set.start);
 
 	if (!action)
-		kunit_exec_run_tests(&suite_set, false);
+		kunit_exec_run_tests(&filtered_set, false);
 	else if (!strcmp(action, "list"))
-		kunit_exec_list_tests(&suite_set, false);
+		kunit_exec_list_tests(&filtered_set, false);
 	else if (!strcmp(action, "list_attr"))
-		kunit_exec_list_tests(&suite_set, true);
+		kunit_exec_list_tests(&filtered_set, true);
 	else
 		pr_err("kunit: unknown action '%s'\n", action);
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog


