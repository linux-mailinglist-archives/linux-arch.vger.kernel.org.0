Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4684C6CC874
	for <lists+linux-arch@lfdr.de>; Tue, 28 Mar 2023 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjC1QtR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Mar 2023 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjC1QtE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2023 12:49:04 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FC81025E;
        Tue, 28 Mar 2023 09:48:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t13so9659139qvn.2;
        Tue, 28 Mar 2023 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680022132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnyFffHnLQxEq4pI3SmE7M+GX7tfHqiqsW+FaERKQAw=;
        b=RaKG8k6OeBGdCwGbGkcS5OdQ5Cj/kY+pdn3gBmSfyUp8HeMawcyvlbGBWnTppDfvZz
         GmX8etflZqQb4L8i3UEqexXuYsbLZplcLZ8E+ISBJ/h6t3yK3EweuA+Zt3Dy3KD0a5Yj
         LD5y0tTVXAV3YczVBy2aPWipmyyfGVijFIwmspeBriqBW+rA/JeU5IOvocBmNhEnSJ5l
         eak3i0yPm3bVYdSJY7vz51ftZ8QHeCoMCsVh+LbyXhyQDoliQ1Kz2Af22b1kPfhFujz1
         HpTCy2iLHKOnOuzJAmf7dokVvN4GWLIRLZA4+RXz/BXEncyTkPufEVUEXBtXQFugfpW1
         Ocmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680022132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnyFffHnLQxEq4pI3SmE7M+GX7tfHqiqsW+FaERKQAw=;
        b=UQ9wubVc7i8MNmIoW5hv4PLKFGqoyqinTN7JOWck8jUN3OrJJg2c/hrMZXd8sFeVRY
         0AUR2rXhAo3e8hRojfBiGD0gAvt7zPcB4QIDnjG+MV5a6jPp5B+uEYAqDnb/ChsiFDxf
         QjbpkNxWbBFIk8cHj4otSEi51mG5z9cGdFu/fpEPc+06e3/qXrGHVV6U4pmB3/Ju7Zob
         mKJp84eoKKQSObTnmEZuLaZlo+leZMAxOF0v6EKEkRHJfKoEg/+x9ut/+BbAVTW1olB5
         zpbtHQqWu3PY2pemvuxp7K5sYyiXI1pu3tXxVx3Ex9YCshijRTuZBTXNsG91j7UfEybL
         25Qg==
X-Gm-Message-State: AAQBX9eDkTjaY8DwHhmlgL5KSEAdoPdMo22erI02O5TPlKRExKRBFCBU
        txzKElwqZPiRteuFnygTaEFmX4+SRAL6r6M=
X-Google-Smtp-Source: AKy350bh93G4jWcDXuFkkqPn+yZVTQZ/GR41fvaXejwO1Lo7MWUwye7UgpDItK5Z99XCNLKCdfE3Pg==
X-Received: by 2002:a05:6214:c29:b0:574:1822:a1bb with SMTP id a9-20020a0562140c2900b005741822a1bbmr26203438qvd.44.1680022132166;
        Tue, 28 Mar 2023 09:48:52 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id qh16-20020a0562144c1000b005dd8b93457bsm3938206qvb.19.2023.03.28.09.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 09:48:52 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        mark.rutland@arm.com, tongtiangen@huawei.com, robin.murphy@arm.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v14 4/4] selftest,ptrace: Add selftest for syscall user dispatch config api
Date:   Tue, 28 Mar 2023 12:48:13 -0400
Message-Id: <20230328164811.2451-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230328164811.2451-1-gregory.price@memverge.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Validate that the following new ptrace requests work as expected

* PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG
  - returns the contents of task->syscall_dispatch if enabled

* PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG
  - sets the contents of task->syscall_dispatch

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 tools/testing/selftests/ptrace/.gitignore    |  1 +
 tools/testing/selftests/ptrace/Makefile      |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c | 72 ++++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
index 792318aaa30c..b7dde152e75a 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 get_syscall_info
+get_set_sud
 peeksiginfo
 vmaccess
diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftests/ptrace/Makefile
index 2f1f532c39db..33a36b73bcb9 100644
--- a/tools/testing/selftests/ptrace/Makefile
+++ b/tools/testing/selftests/ptrace/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -std=c99 -pthread -iquote../../../../include/uapi -Wall
 
-TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess
+TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess get_set_sud
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
new file mode 100644
index 000000000000..5297b10d25c3
--- /dev/null
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <sys/prctl.h>
+
+#include "linux/ptrace.h"
+
+static int sys_ptrace(int request, pid_t pid, void *addr, void *data)
+{
+	return syscall(SYS_ptrace, request, pid, addr, data);
+}
+
+TEST(get_set_sud)
+{
+	struct ptrace_sud_config config;
+	pid_t child;
+	int ret = 0;
+	int status;
+
+	child = fork();
+	ASSERT_GE(child, 0);
+	if (child == 0) {
+		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+			TH_LOG("PTRACE_TRACEME: %m");
+		}
+		kill(getpid(), SIGSTOP);
+		_exit(1);
+	}
+
+	waitpid(child, &status, 0);
+
+	memset(&config, 0xff, sizeof(config));
+	config.mode = PR_SYS_DISPATCH_ON;
+
+	ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_OFF);
+	ASSERT_EQ(config.selector, 0);
+	ASSERT_EQ(config.offset, 0);
+	ASSERT_EQ(config.len, 0);
+
+	config.mode = PR_SYS_DISPATCH_ON;
+	config.selector = 0;
+	config.offset = 0x400000;
+	config.len = 0x1000;
+
+	ret = sys_ptrace(PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+
+	memset(&config, 1, sizeof(config));
+	ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_ON);
+	ASSERT_EQ(config.selector, 0);
+	ASSERT_EQ(config.offset, 0x400000);
+	ASSERT_EQ(config.len, 0x1000);
+
+	kill(child, SIGKILL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.39.1

