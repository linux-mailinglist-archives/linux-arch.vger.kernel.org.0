Return-Path: <linux-arch+bounces-944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C33E81072C
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 02:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9901C20E1A
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 01:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BBEEB8;
	Wed, 13 Dec 2023 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrZF9X5Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FB3A1
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 17:02:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3911218b3so75808557b3.1
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 17:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702429337; x=1703034137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E22eCM3LpsQRbUKK8mf1gNlUuS672sImUrgswyDx+34=;
        b=HrZF9X5YmvD0GskdZCZQpePwImD3tsPLvsOosEn2DDBbrl4XjLQEBLzeKmtRHiKvX5
         dyeZHJBuemQ/bCbdoXpdFjaQWnGh4xWXxbSS14vLrDNSeg7I0TtLruqHMjKtiv4MquiE
         4nM2n91CYSxUfziR1Q+K3UGkpfUvmfDBaIrP+uJmSxjjOnDP5V3TrlaMSuVYinIn2drJ
         DKfVsJ44V80B2DmAj55XqXOaZb4DvQ6//C3RecfrA7Dt8LDtJ3oQNuMf4kPNmp+3wd73
         moVa3uZKIop4xYIfblTX2nUM/h6IoKB0dky9frLonJdC5oQ2l6TuLLfzrraZtflN31Na
         cHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702429337; x=1703034137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E22eCM3LpsQRbUKK8mf1gNlUuS672sImUrgswyDx+34=;
        b=CZBCSPWFwpyVIyWnIyimymva7DvzGS9PR0xLqqWCaHS6yiSHm5mxYXMv1xUPlQJ6tA
         CCv9yIplahu+f7AlLA4jGq2JbnvxEw9SaBdzwNpTFsTVBR8i7QB0bsssdlT4E4IPGjDI
         P/JrC2UFzozL+Pc5XPZ2oVOt/VBYTRs7nmKTqmiePMVDF92VFRMpckcrfmsI0Bwt5Kbt
         8MifD1BQpCWa/RFHHVwEvo6kkIKviN2jjU6mF8REuG48n7vz6eyljXmUEt/7ggBKCOXy
         qbqyR/nLND+nXDeiREFSyoQ8N9UTV81v1x/mNGsl+GpAEsqGUfXqsdCAt2mhbcPKckmj
         flcQ==
X-Gm-Message-State: AOJu0Yx8jaiY1tqznihnhlUSpWPB5nll8wQq9bxcsgzgJxZJF+JDoZIK
	Zr2/rt8tBhRHRsNpqWjFMfnqnNhU2w==
X-Google-Smtp-Source: AGHT+IGltObfsdg01UYA5d4+n+6B+G0+b86q4J7GB+VeEGumubgZh3WUZ1xvjp8dhZKDMCUJj4j1VIDHfQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:4b1:b0:dbc:bfb7:1f48 with SMTP id
 r17-20020a05690204b100b00dbcbfb71f48mr7176ybs.9.1702429337531; Tue, 12 Dec
 2023 17:02:17 -0800 (PST)
Date: Wed, 13 Dec 2023 01:01:58 +0000
In-Reply-To: <20231213010201.1802507-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231213010201.1802507-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213010201.1802507-3-rmoar@google.com>
Subject: [PATCH v4 3/6] kunit: add example suite to test init suites
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, sadiyakazi@google.com
Cc: keescook@chromium.org, arnd@arndb.de, linux-kselftest@vger.kernel.org, 
	linux-arch@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add example_init_test_suite to allow for testing the feature of running
test suites marked as init to indicate they use init data and/or
functions.

This suite should always pass and uses a simple init function.

This suite can also be used to test the is_init attribute introduced in
the next patch.

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v3:
- I ended up not changing anything as adding __init to the test gave
  a build warning. It did still work so I could add it back if wanted.

 lib/kunit/kunit-example-test.c | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 6bb5c2ef6696..18495778de7c 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -287,4 +287,41 @@ static struct kunit_suite example_test_suite = {
  */
 kunit_test_suites(&example_test_suite);
 
+static int __init init_add(int x, int y)
+{
+	return (x + y);
+}
+
+/*
+ * This test should always pass. Can be used to test init suites.
+ */
+static void example_init_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, init_add(1, 1), 2);
+}
+
+/*
+ * The kunit_case struct cannot be marked as __initdata as this will be
+ * used in debugfs to retrieve results after test has run
+ */
+static struct kunit_case example_init_test_cases[] = {
+	KUNIT_CASE(example_init_test),
+	{}
+};
+
+/*
+ * The kunit_suite struct cannot be marked as __initdata as this will be
+ * used in debugfs to retrieve results after test has run
+ */
+static struct kunit_suite example_init_test_suite = {
+	.name = "example_init",
+	.test_cases = example_init_test_cases,
+};
+
+/*
+ * This registers the test suite and marks the suite as using init data
+ * and/or functions.
+ */
+kunit_test_init_section_suites(&example_init_test_suite);
+
 MODULE_LICENSE("GPL v2");
-- 
2.43.0.472.g3155946c3a-goog


