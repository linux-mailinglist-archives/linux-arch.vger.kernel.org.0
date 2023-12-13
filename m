Return-Path: <linux-arch+bounces-1018-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65045811F36
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 20:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED571282803
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 19:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A1825743;
	Wed, 13 Dec 2023 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SX4do2Tt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D4FDC
	for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 11:44:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbcd44cdca3so889686276.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 11:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702496677; x=1703101477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQok1uBhfQkPoGi0cPucpJmmij0VDZxQ9yN4E4VUQ2c=;
        b=SX4do2TtIQuYGbaqiCa2LvlqYkCsEFfAuOtGfNCZAesSc6aSmfojhjDdWXiVpW1CYv
         w7VsGtLZzVY5llvLJSidZ/ANqj+GaqYBj8g4lDKqSUZxCviBIlIXQ7E1R7G2Wr3rHxp4
         gKZFE9PCXdmmhZOpDQrHftcpopvKHFjovj/PgzABrzWPoUlaKeqGlIEiBY83vWFsfpDs
         uQaOuyOqS68JpTXYErL1/LFsNyeUGCtB0W74VWGMukPNjRaTL3Yu567+YgXRYLIfOLEE
         p0jyMof83CfvHLUpP+2Cp4qYiNSEf8l5huOXvOblkTOmUD/ognh+FHmWCg+6DuiyIar3
         7Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496677; x=1703101477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQok1uBhfQkPoGi0cPucpJmmij0VDZxQ9yN4E4VUQ2c=;
        b=cc9nI357mn6uVuyiAZV0weA6E+AHeMSwTu24w4poG6vY26UmfbXxP8xogrkW+Qajs5
         GmKwLtn2j7c1tQt6kqNhTv+gm9+rviaojDz/nUTG4lOYqKBU9phaB3ddMqnyhts5vLQv
         qf+zL5rGHIdWdD+4s3BEkuJFoUAMvIJb/pTG7Q9kJM5gxmND85M7GVUgGvCHq2xG1TgL
         IwTU4Gr0ReDQEJEF+s3QFv1Y7kOTEexkuNVL+ILjpc0q40l6nc4RjH9fFx/Iqxc+7Zmv
         Zcz3MVQxoxPW9rSWD1CK/ooI0EQM3+BFkvBXnrlzCsNpM5mlcAzwOB7R7HwI17EbfXhn
         kSOQ==
X-Gm-Message-State: AOJu0YyoOKQbzOqoGhAwFIhGs14py/1LjIwBN+JkbDrieWS4v1URjB4Z
	ZtxD7tVyRQGCONzuCvdIr4TCwGELCQ==
X-Google-Smtp-Source: AGHT+IFR2bPHl3zKQutXVKFaZX+dvvnolgHXSOHsNmNdg1HD/2lOzglWuRZblQjG/huqwxGrs2ZNL3UQzQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:bf92:0:b0:dbc:d3fd:ac61 with SMTP id
 l18-20020a25bf92000000b00dbcd3fdac61mr25376ybk.12.1702496677685; Wed, 13 Dec
 2023 11:44:37 -0800 (PST)
Date: Wed, 13 Dec 2023 19:44:21 +0000
In-Reply-To: <20231213194421.2031671-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231213194421.2031671-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213194421.2031671-6-rmoar@google.com>
Subject: [PATCH v5 6/6] Documentation: Add debugfs docs with run after boot
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, sadiyakazi@google.com
Cc: keescook@chromium.org, arnd@arndb.de, linux-kselftest@vger.kernel.org, 
	linux-arch@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Expand the documentation on the KUnit debugfs filesystem on the
run_manual.rst page.

Add section describing how to access results using debugfs.

Add section describing how to run tests after boot using debugfs.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 Documentation/dev-tools/kunit/run_manual.rst | 51 ++++++++++++++++++--
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
index e7b46421f247..699d92885075 100644
--- a/Documentation/dev-tools/kunit/run_manual.rst
+++ b/Documentation/dev-tools/kunit/run_manual.rst
@@ -49,9 +49,52 @@ loaded.
 
 The results will appear in TAP format in ``dmesg``.
 
+debugfs
+=======
+
+KUnit can be accessed from userspace via the debugfs filesystem (See more
+information about debugfs at Documentation/filesystems/debugfs.rst).
+
+If ``CONFIG_KUNIT_DEBUGFS`` is enabled, the KUnit debugfs filesystem is
+mounted at /sys/kernel/debug/kunit. You can use this filesystem to perform
+the following actions.
+
+Retrieve Test Results
+=====================
+
+You can use debugfs to retrieve KUnit test results. The test results are
+accessible from the debugfs filesystem in the following read-only file:
+
+.. code-block :: bash
+
+	/sys/kernel/debug/kunit/<test_suite>/results
+
+The test results are printed in a KTAP document. Note this document is separate
+to the kernel log and thus, may have different test suite numbering.
+
+Run Tests After Kernel Has Booted
+=================================
+
+You can use the debugfs filesystem to trigger built-in tests to run after
+boot. To run the test suite, you can use the following command to write to
+the ``/sys/kernel/debug/kunit/<test_suite>/run`` file:
+
+.. code-block :: bash
+
+	echo "any string" > /sys/kernel/debugfs/kunit/<test_suite>/run
+
+As a result, the test suite runs and the results are printed to the kernel
+log.
+
+However, this feature is not available with KUnit suites that use init data,
+because init data may have been discarded after the kernel boots. KUnit
+suites that use init data should be defined using the
+kunit_test_init_section_suites() macro.
+
+Also, you cannot use this feature to run tests concurrently. Instead a test
+will wait to run until other tests have completed or failed.
+
 .. note ::
 
-	If ``CONFIG_KUNIT_DEBUGFS`` is enabled, KUnit test results will
-	be accessible from the ``debugfs`` filesystem (if mounted).
-	They will be in ``/sys/kernel/debug/kunit/<test_suite>/results``, in
-	TAP format.
+	For test authors, to use this feature, tests will need to correctly initialise
+	and/or clean up any data, so the test runs correctly a second time.
-- 
2.43.0.472.g3155946c3a-goog


