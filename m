Return-Path: <linux-arch+bounces-657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C4804192
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 23:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA101C20C08
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92C3A8F5;
	Mon,  4 Dec 2023 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zd1C37Cj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B130134
	for <linux-arch@vger.kernel.org>; Mon,  4 Dec 2023 14:19:43 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3a1f612b3so68882097b3.1
        for <linux-arch@vger.kernel.org>; Mon, 04 Dec 2023 14:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701728382; x=1702333182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbKw92LwzxqFMUL9Ga0oOICdSX1CkrZsFK7gwu7z4qs=;
        b=zd1C37Cj2xtdk9jCiPLarmSLsnGa+vzL7ytwVlrPmbY/bsUz0Rl3gU32DI8qcl1alG
         /xR0SjCH9iNuJn+kBEwyGbYkK+INcks3VG3CnExAkPwZpGSDl1FaUdPLKf+OlDs3/l8k
         sgBtqSBI7sI2XQXcvHodguUvNc9smn+rNNEfjxQvf3EYPjpkKG0b3GuWXViyVoQkB8/S
         /GXZwnUXm6nwzjHyCvdY+QL5C2Ubq7xpocrmBInBAbCRLLj5cSAak54stZnKI3lIzOj0
         4StzBMrqiUBEqKQJz6YM4EI+O60yFWA1GdFiMmdmae3dDqULnbqpXuRiqh6vadyAaHr0
         Ubgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728382; x=1702333182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbKw92LwzxqFMUL9Ga0oOICdSX1CkrZsFK7gwu7z4qs=;
        b=ZTnCGrqeOkS/vbukeNNqUHF1oVYVXiLYc7rt4Riv1YpmhWC4C5jBW0YgTQaOWeHgkf
         IEuJK5DAtqiNLAcmHAR0INbxM42JUXcnOJtXK+a13vzO/TUDFWRPESysXHgutqWelKZl
         qhXrs0bLU8bWHukGSduIF+TlBVUGftrO/qrneGf48sAFcJN08vhRmj+07fWljgdiaPJR
         V2FWfc6L0QR6Kp1nmzKOYe19zIucySITGoR2Vizz5F+Eq0SIr+FvNuX2/H8BcDGGI03A
         Qn1OLB9PWESd0MHe8CDlfYr/k3CB200O48VaqxtGMnY9Blw/9dBRLpz1rnGUAU2tErrs
         Q7hw==
X-Gm-Message-State: AOJu0YwTw0Z1USESd37hQX9Q2wXwmHt70IClsYZeMjHWKrIDcachbUtu
	L8ZOLBjfBul/VhMerSMd6qNrqIU81g==
X-Google-Smtp-Source: AGHT+IE/Juv/ilq0n8BRZJDwim3hTfDwC3y2oS6G+zSu0NFvfggKc7aq+kR+KKtxvzBC3vexvVf7MpQqWQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:98a:b0:5d4:2ff3:d280 with SMTP id
 ce10-20020a05690c098a00b005d42ff3d280mr320818ywb.7.1701728382783; Mon, 04 Dec
 2023 14:19:42 -0800 (PST)
Date: Mon,  4 Dec 2023 22:19:29 +0000
In-Reply-To: <20231204221932.1465004-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204221932.1465004-4-rmoar@google.com>
Subject: [PATCH v3 4/6] kunit: add is_init test attribute
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, sadiyakazi@google.com
Cc: keescook@chromium.org, arnd@arndb.de, linux-kselftest@vger.kernel.org, 
	linux-arch@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add is_init test attribute of type bool. Add to_string, get, and filter
methods to lib/kunit/attributes.c.

Mark each of the tests in the init section with the is_init=true attribute.

Add is_init to the attributes documentation.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 .../dev-tools/kunit/running_tips.rst          |  7 +++
 include/kunit/test.h                          |  3 +
 lib/kunit/attributes.c                        | 60 +++++++++++++++++++
 lib/kunit/executor.c                          |  6 +-
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 766f9cdea0fa..024e9ad1d1e9 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -428,3 +428,10 @@ This attribute indicates the name of the module associated with the test.
 
 This attribute is automatically saved as a string and is printed for each suite.
 Tests can also be filtered using this attribute.
+
+``is_init``
+
+This attribute indicates whether the test uses init data or functions.
+
+This attribute is automatically saved as a boolean and tests can also be
+filtered using this attribute.
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 06e826a0b894..65583782903d 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -82,6 +82,9 @@ enum kunit_speed {
 /* Holds attributes for each test case and suite */
 struct kunit_attributes {
 	enum kunit_speed speed;
+
+	/* private: internal use only */
+	bool is_init;
 };
 
 /**
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index 1b512f7e1838..ddacec6a3337 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -58,6 +58,16 @@ static const char *attr_enum_to_string(void *attr, const char * const str_list[]
 	return str_list[val];
 }
 
+static const char *attr_bool_to_string(void *attr, bool *to_free)
+{
+	bool val = (bool)attr;
+
+	*to_free = false;
+	if (val)
+		return "true";
+	return "false";
+}
+
 static const char *attr_speed_to_string(void *attr, bool *to_free)
 {
 	return attr_enum_to_string(attr, speed_str_list, to_free);
@@ -166,6 +176,37 @@ static int attr_string_filter(void *attr, const char *input, int *err)
 	return false;
 }
 
+static int attr_bool_filter(void *attr, const char *input, int *err)
+{
+	int i, input_int = -1;
+	long val = (long)attr;
+	const char *input_str = NULL;
+
+	for (i = 0; input[i]; i++) {
+		if (!strchr(op_list, input[i])) {
+			input_str = input + i;
+			break;
+		}
+	}
+
+	if (!input_str) {
+		*err = -EINVAL;
+		pr_err("kunit executor: filter value not found: %s\n", input);
+		return false;
+	}
+
+	if (!strcmp(input_str, "true"))
+		input_int = (int)true;
+	else if (!strcmp(input_str, "false"))
+		input_int = (int)false;
+	else {
+		*err = -EINVAL;
+		pr_err("kunit executor: invalid filter input: %s\n", input);
+		return false;
+	}
+
+	return int_filter(val, input, input_int, err);
+}
 
 /* Get Attribute Methods */
 
@@ -194,6 +235,17 @@ static void *attr_module_get(void *test_or_suite, bool is_test)
 		return (void *) "";
 }
 
+static void *attr_is_init_get(void *test_or_suite, bool is_test)
+{
+	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
+	struct kunit_case *test = is_test ? test_or_suite : NULL;
+
+	if (test)
+		return ((void *) test->attr.is_init);
+	else
+		return ((void *) suite->attr.is_init);
+}
+
 /* List of all Test Attributes */
 
 static struct kunit_attr kunit_attr_list[] = {
@@ -212,6 +264,14 @@ static struct kunit_attr kunit_attr_list[] = {
 		.filter = attr_string_filter,
 		.attr_default = (void *)"",
 		.print = PRINT_SUITE,
+	},
+	{
+		.name = "is_init",
+		.get_attr = attr_is_init_get,
+		.to_string = attr_bool_to_string,
+		.filter = attr_bool_filter,
+		.attr_default = (void *)false,
+		.print = PRINT_SUITE,
 	}
 };
 
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 847329c51e91..594de994161a 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -300,6 +300,7 @@ struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_
 	struct kunit_suite_set total_suite_set = {NULL, NULL};
 	struct kunit_suite **total_suite_start = NULL;
 	size_t init_num_suites, num_suites, suite_size;
+	int i = 0;
 
 	init_num_suites = init_suite_set.end - init_suite_set.start;
 	num_suites = suite_set.end - suite_set.start;
@@ -310,8 +311,11 @@ struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_
 	if (!total_suite_start)
 		return total_suite_set;
 
-	/* Append init suites and then all other kunit suites */
+	/* Append and mark init suites and then append all other kunit suites */
 	memcpy(total_suite_start, init_suite_set.start, init_num_suites * suite_size);
+	for (i = 0; i < init_num_suites; i++)
+		total_suite_start[i]->attr.is_init = true;
+
 	memcpy(total_suite_start + init_num_suites, suite_set.start, num_suites * suite_size);
 
 	/* Set kunit suite set start and end */
-- 
2.43.0.rc2.451.g8631bc7472-goog


