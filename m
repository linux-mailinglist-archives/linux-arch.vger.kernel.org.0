Return-Path: <linux-arch+bounces-1014-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32571811F2D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 20:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344551C211C2
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE136828F;
	Wed, 13 Dec 2023 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrUJuQvr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0938CF
	for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 11:44:29 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5e27479b6e2so17985947b3.0
        for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 11:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702496669; x=1703101469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4TObfz1XUUxLwH4P+ACZXOttJNkOujnn5ZtfX3k7NE=;
        b=mrUJuQvr5S6HrbxhYtKpNvDO3oXuZ6po6B0Dif+EoCmz9mDEiSQiMWr4YwIFNhrQ2D
         pyBUXbQM0X46ODwo2dfhbsmMaUr2oKGVYYeWH0l071+3eWOPJJ0b+2t9yIt09524htIl
         zPy+8YY+ACP63K51D8vG5NS0AMlr8+5HJ6z8m/QHSIImTr8Ws549LzkbG79aYskFViX1
         uQAKaejQdtfd0zgfL9+0xsO8cEl+c5wV8Y8k+N4LJaxRTG/qihvV7q446bpzFwtlOxPh
         iBuu8z7qvZl0pmxmYVcY2RueVGR87HCHLMX4gaEjDbqGY1oAjV+EnDW1cFzYU2g0OvFa
         xbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496669; x=1703101469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4TObfz1XUUxLwH4P+ACZXOttJNkOujnn5ZtfX3k7NE=;
        b=ire5wcGvwYHTZc4zEH/fQxbI9eVHEzdR2ugkZ4Qm5qWeAUSqCEaFQsydVTic5FOvBh
         DBnkOiRtirAmzD4W1r9JX1xQKY2BeTmX6sZZkeY/RPWIRnE+2HQ+aMTsdfmaMeMq8ZCs
         T7kUIynKEMFvb6Sg+iaAtGxxiLu9hAW6EwaJO3REpHNN/EiFOD7Vo1xKxemtNbXxgN6x
         1CJiplzbx5cEeTabmKdWTttJ5F18mgJlu+Y+ko0KW63VaMgo5mQbjBj3+oFuUXNukFaM
         W2foWMPwZejZ2PlVutbQC1ylWQsrSX3nHmufFm5uiBfbK6q6rvZNEUS6BTU+R1Ira6Ct
         67PA==
X-Gm-Message-State: AOJu0Yxv0H/2+bKKKr80Y7DkWgC+5+54YrVuhLtN5DzZJc2l75jxuXSa
	5ikumdCL+N+Jxv/Y9L29Bb1eQAspxQ==
X-Google-Smtp-Source: AGHT+IFC8i63zmTQQu5ER5Ld9i31lO+PjlnVCodbcMq+pmEV0/5euoQT67GZvzG1ZP0xHcCxgPEdQp94kg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:9705:0:b0:db5:45eb:75b0 with SMTP id
 d5-20020a259705000000b00db545eb75b0mr69769ybo.6.1702496668909; Wed, 13 Dec
 2023 11:44:28 -0800 (PST)
Date: Wed, 13 Dec 2023 19:44:17 +0000
In-Reply-To: <20231213194421.2031671-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231213194421.2031671-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213194421.2031671-2-rmoar@google.com>
Subject: [PATCH v5 2/6] kunit: add KUNIT_INIT_TABLE to init linker section
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

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/asm-generic/vmlinux.lds.h |  9 ++++-
 include/kunit/test.h              | 30 +++++++++------
 include/linux/module.h            |  2 +
 kernel/module/main.c              |  3 ++
 lib/kunit/executor.c              | 64 ++++++++++++++++++++++++++++---
 lib/kunit/test.c                  | 26 +++++++++----
 6 files changed, 109 insertions(+), 25 deletions(-)

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
index 20ed9f9275c9..fe79cd736e94 100644
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
@@ -378,21 +386,21 @@ static inline int kunit_run_all_tests(void)
  *
  * @__suites: a statically allocated list of &struct kunit_suite.
  *
- * This functions identically as kunit_test_suites() except that it suppresses
- * modpost warnings for referencing functions marked __init or data marked
- * __initdata; this is OK because currently KUnit only runs tests upon boot
- * during the init phase or upon loading a module during the init phase.
+ * This functions similar to kunit_test_suites() except that it compiles the
+ * list of suites during init phase.
+ *
+ * This macro also suffixes the array and suite declarations it makes with
+ * _probe; so that modpost suppresses warnings about referencing init data
+ * for symbols named in this manner.
  *
- * NOTE TO KUNIT DEVS: If we ever allow KUnit tests to be run after boot, these
- * tests must be excluded.
+ * Note: these init tests are not able to be run after boot so there is no
+ * "run" debugfs file generated for these tests.
  *
- * The only thing this macro does that's different from kunit_test_suites is
- * that it suffixes the array and suite declarations it makes with _probe;
- * modpost suppresses warnings about referencing init data for symbols named in
- * this manner.
+ * Also, do not mark the suite or test case structs with __initdata because
+ * they will be used after the init phase with debugfs.
  */
 #define kunit_test_init_section_suites(__suites...)			\
-	__kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),	\
+	__kunit_init_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe), \
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
index 0308865194bb..6c082911a85f 100644
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
2.43.0.472.g3155946c3a-goog


