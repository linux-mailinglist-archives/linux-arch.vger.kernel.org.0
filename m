Return-Path: <linux-arch+bounces-656-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B78B8804191
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 23:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303AF1F21330
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2993AC0F;
	Mon,  4 Dec 2023 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKGiKz/m"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BDF119
	for <linux-arch@vger.kernel.org>; Mon,  4 Dec 2023 14:19:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db401df7735so4054296276.3
        for <linux-arch@vger.kernel.org>; Mon, 04 Dec 2023 14:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701728381; x=1702333181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcCQtNmXpvtLNOrtNSc8AW+fCSTy7TRIqx1fWXO6kAs=;
        b=ZKGiKz/m9hGw7LczcQpuxT3EhjjjO87Nzy4G/3By6FqipWn8u12Tz3dkSc1CykkjZL
         BD86sdoNv+tqPoKuvlGV3YAPB0vumPi6mhXTcXzIocbIMt49cXIAGnnv0KF5wS/NeQYT
         IJxkUvLFPPj2Xu25KNXnxasSi67aTnhlMyI7K48B+8zleccPh+GdSY4KwUGEwKfKdNXR
         OsRgY5db7IMr3i1EIKLBkWdE0akV03KeZcVy0VCRSlWu2xK+3kIMgQeFpvHjWdPLbUFg
         nEB7FxCTvYGGU3VuzQ/LGz7mb7tJYPS1KVIiWv1J3iD8P1PsUGV1HYJxUmhtW7SnpMAe
         2FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728381; x=1702333181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcCQtNmXpvtLNOrtNSc8AW+fCSTy7TRIqx1fWXO6kAs=;
        b=bCcksFhOrfaYl4uWK4Ke+BYO8RwjYmSQEeLPar54tiDj5GIvPLh+66Uwr3fWIHtyDh
         8SJK9HMJSuxpqBJ0NWAg53LNBCX1rREaDMUdpwVI7mh7m/gOJXgIkbS0I4nTN9irh1uv
         qxUC4aoYlF/GjjMyqFvGaVV2pmCqqb6j/waHAfyS4TGanQHuXGQnCtINFfPb8+CcKXfQ
         5O3CYRjYMBxg51GnNsdG4L4ShvupTbiX5NLO/C07wKyKfc0yHQtmNZOQ33V4bMPZLHWp
         g1xTtiZbmYzKLwR46mDE92cUXmf2dN4tMbye/ewWpVq9UihfMOnElBnt6uEEQtf/ge4y
         yDVg==
X-Gm-Message-State: AOJu0YzsaT/F5edjTAaBl/3CaaWFDcR5erS3BZIEcGcbhnJtIhVMCbUo
	exXux1CxpL6fJj/Q69JeCO4DWGV7Bg==
X-Google-Smtp-Source: AGHT+IFEt3AEceWIxqns4ZzJfYejgTDzoUUTYAgBnKLjQfaNWDnwUkVOcY3Scc+JgzZPWiTKdUHhbNE0uA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:687:0:b0:db4:5e66:4a05 with SMTP id
 129-20020a250687000000b00db45e664a05mr949795ybg.2.1701728381191; Mon, 04 Dec
 2023 14:19:41 -0800 (PST)
Date: Mon,  4 Dec 2023 22:19:28 +0000
In-Reply-To: <20231204221932.1465004-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204221932.1465004-3-rmoar@google.com>
Subject: [PATCH v3 3/6] kunit: add example suite to test init suites
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
 lib/kunit/kunit-example-test.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 6bb5c2ef6696..262a68a59800 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -287,4 +287,33 @@ static struct kunit_suite example_test_suite = {
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
+static struct kunit_case example_init_test_cases[] = {
+	KUNIT_CASE(example_init_test),
+	{}
+};
+
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
2.43.0.rc2.451.g8631bc7472-goog


