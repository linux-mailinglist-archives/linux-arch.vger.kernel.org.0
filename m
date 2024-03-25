Return-Path: <linux-arch+bounces-3158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 335CB88B498
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 23:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0793B64252
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8696C126F15;
	Mon, 25 Mar 2024 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNiheVXE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD86839E1;
	Mon, 25 Mar 2024 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389183; cv=none; b=QnBpdFm0Q1wDgibq/GOTEN8YIKUIMEvSWSO9crVz4wZJSEpgqk7qqcCaiWzkjCatEztWTtHBOo/FAf93nYnIMrUCDxzV+OPuoLK4+kZKqQl5y97GONDFaDtn6PU+HMODW7ifnBsZnE9EiI7M/Mc4vb+Sm4fI0YnRHy/bk6FCZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389183; c=relaxed/simple;
	bh=Q4GDe2OF/UogPfEQ1Rxv6tM7a2FMPTCpZuxl7c7+zL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kh87/0peYYPRBeJqkwSqHcXVPIBZ7CzbHvIIdAJPYp0AOo3D/qzGgaG78gFnBEhuEVIxF14kryB4igYQhl+PQYtxinyrIaRTSTU7uxdfi1Bj0rr2hTSapWBchU9z6+SXPkU3GF1BfdVF9mxz8UyB+Xjv6WLdQp0i4S40IXVCZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNiheVXE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29ddfada0d0so2399366a91.3;
        Mon, 25 Mar 2024 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389180; x=1711993980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAqubCL51IrVA5I7nNJRuv0X36LpccPRVheB6cZNZ0A=;
        b=bNiheVXEWDRl6+YRC8wg/Pu63FeLtgf9CATQH98Vt0Ia8oxdh8QjQB73vdHRikMw1N
         VzYOsA86f0LBZpM549L4kKVUH7The186WVcwq7ed2LJWEIdZvTBebI63kJBEukP2uNua
         FqE5F/ZR/VKK/LY7r7Vzi04kFkTYvsamQlpCJJx3xATzNsclNDGIsqzCP5UUUXBGwapl
         oyT8DcjV6pMcRI18SK2d+Nj2JwayoSanpu/R2bOce13D1ZEdN0ObF1/Iot5q+xJnVpNN
         ORq6r9cWx6FkqbWo0d6rAwLH8hhOa3u7OSvmklbt9THSCG/P1As9VBHveyGaazFAStmg
         PXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389180; x=1711993980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WAqubCL51IrVA5I7nNJRuv0X36LpccPRVheB6cZNZ0A=;
        b=o2/mprYruip5ls/BUx7eXu3u8E9XdZeBHSiV6Ix55vup7uOB6rzNOjsZKdULCuq69v
         oh0oHItL+SXdSh2V7GWWJAxnQDk977M5yLGKq8SbZEqFCRtmyHcsf5o0dDtZzJjVS2n4
         gdGq5B731CzrA+6FN5gXAcEaZOEdnSGClZ/e7eHcng5N2G7cSDkK47OFCoA2ViyphGil
         SnQ7XqlTb7IsbJY3YY/nJyu/AxfX/KoVfUQRdopVDo2/Fv96ss3qhtmA+wYkEBk4D8n9
         uobAmGUscF3+Bhdk6pV6BX0AXpeQisxs37RHBSe0DgyK8u6lbxmfGzGvP7gxeVW2LZYx
         GAbg==
X-Forwarded-Encrypted: i=1; AJvYcCWvhIcSDPNCUplkeoiOEHykpCnxeGns45x9LpDNk+hzW+Qyb5N6S/RgdnkfZ5qCmVQ+NHQNMtBfWkSAcng3iIo8jVeBfb39g8i5fzaOx++Cbq9oUVVFusZOcOfL9xgsIorPFoDW1FftwFufoTrQeqwvwGIYkI/e7jjfwEZaUr65qHF15I5ZlWKZfuJd48OsBxXalZkf9TsauAFd4lJWO3nEcwpfj1HFv0d7osqCbFfRsVTfTEnyge3WlkC1aQ4+KlaFH29QVj1/YWjXv+mMSjZcDQohC70pYyts4EJkqGb0b0gh89uzhGXiKqPl8RHuHw==
X-Gm-Message-State: AOJu0YxW9DWJHerhp62Glealx5GA7BuDSaNOo8+qD/VjeRQhErc+d+KF
	pgjVmf25qPgVu6h8iCPgKoq9sKDzKXAYKx3EhnnkwbCaT4wK/mUhSJ21oHmV
X-Google-Smtp-Source: AGHT+IEZGgr3SHHp7IQgBYCFkoLblCFSkGv9KaSvXEQxhqKmotSHNR4v/ZnArS+Gaiul6D7vvEZjeA==
X-Received: by 2002:a17:90b:17c3:b0:2a0:84f8:3096 with SMTP id me3-20020a17090b17c300b002a084f83096mr202747pjb.5.1711389180022;
        Mon, 25 Mar 2024 10:53:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fv9-20020a17090b0e8900b0029c7963a33fsm10424210pjb.10.2024.03.25.10.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:52:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v2 03/14] kunit: Add test cases for backtrace warning suppression
Date: Mon, 25 Mar 2024 10:52:37 -0700
Message-Id: <20240325175248.1499046-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325175248.1499046-1-linux@roeck-us.net>
References: <20240325175248.1499046-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add unit tests to verify that warning backtrace suppression works.

If backtrace suppression does _not_ work, the unit tests will likely
trigger unsuppressed backtraces, which should actually help to get
the affected architectures / platforms fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option

 lib/kunit/Makefile                     |   7 +-
 lib/kunit/backtrace-suppression-test.c | 104 +++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 lib/kunit/backtrace-suppression-test.c

diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 545b57c3be48..3eee1bd0ce5e 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -16,10 +16,13 @@ endif
 
 # KUnit 'hooks' and bug handling are built-in even when KUnit is built
 # as a module.
-obj-y +=				hooks.o \
-					bug.o
+obj-y +=				hooks.o
+obj-$(CONFIG_KUNIT_SUPPRESS_BACKTRACE) += bug.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
+ifeq ($(CCONFIG_KUNIT_SUPPRESS_BACKTRACE),y)
+obj-$(CONFIG_KUNIT_TEST) +=		backtrace-suppression-test.o
+endif
 
 # string-stream-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtrace-suppression-test.c
new file mode 100644
index 000000000000..47c619283802
--- /dev/null
+++ b/lib/kunit/backtrace-suppression-test.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for suppressing warning tracebacks
+ *
+ * Copyright (C) 2024, Guenter Roeck
+ * Author: Guenter Roeck <linux@roeck-us.net>
+ */
+
+#include <kunit/test.h>
+#include <linux/bug.h>
+
+static void backtrace_suppression_test_warn_direct(struct kunit *test)
+{
+	DEFINE_SUPPRESSED_WARNING(backtrace_suppression_test_warn_direct);
+
+	START_SUPPRESSED_WARNING(backtrace_suppression_test_warn_direct);
+	WARN(1, "This backtrace should be suppressed");
+	END_SUPPRESSED_WARNING(backtrace_suppression_test_warn_direct);
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(backtrace_suppression_test_warn_direct), 1);
+}
+
+static void trigger_backtrace_warn(void)
+{
+	WARN(1, "This backtrace should be suppressed");
+}
+
+static void backtrace_suppression_test_warn_indirect(struct kunit *test)
+{
+	DEFINE_SUPPRESSED_WARNING(trigger_backtrace_warn);
+
+	START_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	trigger_backtrace_warn();
+	END_SUPPRESSED_WARNING(trigger_backtrace_warn);
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(trigger_backtrace_warn), 1);
+}
+
+static void backtrace_suppression_test_warn_multi(struct kunit *test)
+{
+	DEFINE_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	DEFINE_SUPPRESSED_WARNING(backtrace_suppression_test_warn_multi);
+
+	START_SUPPRESSED_WARNING(backtrace_suppression_test_warn_multi);
+	START_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	WARN(1, "This backtrace should be suppressed");
+	trigger_backtrace_warn();
+	END_SUPPRESSED_WARNING(trigger_backtrace_warn);
+	END_SUPPRESSED_WARNING(backtrace_suppression_test_warn_multi);
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(backtrace_suppression_test_warn_multi), 1);
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(trigger_backtrace_warn), 1);
+}
+
+static void backtrace_suppression_test_warn_on_direct(struct kunit *test)
+{
+	DEFINE_SUPPRESSED_WARNING(backtrace_suppression_test_warn_on_direct);
+
+	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE) && !IS_ENABLED(CONFIG_KALLSYMS))
+		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE or CONFIG_KALLSYMS");
+
+	START_SUPPRESSED_WARNING(backtrace_suppression_test_warn_on_direct);
+	WARN_ON(1);
+	END_SUPPRESSED_WARNING(backtrace_suppression_test_warn_on_direct);
+
+	KUNIT_EXPECT_EQ(test,
+			SUPPRESSED_WARNING_COUNT(backtrace_suppression_test_warn_on_direct), 1);
+}
+
+static void trigger_backtrace_warn_on(void)
+{
+	WARN_ON(1);
+}
+
+static void backtrace_suppression_test_warn_on_indirect(struct kunit *test)
+{
+	DEFINE_SUPPRESSED_WARNING(trigger_backtrace_warn_on);
+
+	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE))
+		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE");
+
+	START_SUPPRESSED_WARNING(trigger_backtrace_warn_on);
+	trigger_backtrace_warn_on();
+	END_SUPPRESSED_WARNING(trigger_backtrace_warn_on);
+
+	KUNIT_EXPECT_EQ(test, SUPPRESSED_WARNING_COUNT(trigger_backtrace_warn_on), 1);
+}
+
+static struct kunit_case backtrace_suppression_test_cases[] = {
+	KUNIT_CASE(backtrace_suppression_test_warn_direct),
+	KUNIT_CASE(backtrace_suppression_test_warn_indirect),
+	KUNIT_CASE(backtrace_suppression_test_warn_multi),
+	KUNIT_CASE(backtrace_suppression_test_warn_on_direct),
+	KUNIT_CASE(backtrace_suppression_test_warn_on_indirect),
+	{}
+};
+
+static struct kunit_suite backtrace_suppression_test_suite = {
+	.name = "backtrace-suppression-test",
+	.test_cases = backtrace_suppression_test_cases,
+};
+kunit_test_suites(&backtrace_suppression_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.39.2


