Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31E76D10C4
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 23:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjC3VWT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjC3VWL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 17:22:11 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3CC10AB1;
        Thu, 30 Mar 2023 14:22:00 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id 31so15207465qvc.1;
        Thu, 30 Mar 2023 14:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680211319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnyFffHnLQxEq4pI3SmE7M+GX7tfHqiqsW+FaERKQAw=;
        b=qGy82E+3ENcjP4pyKlmFPe7Rh90vWXbKOLSRwEGO/aHO5bEoY41v5awZCtXlioa+i3
         0A+wo83TwP8ptxERL5W65o3xpgkULS3szLyKTht2o0mlo9GzwzkxrxpVfzJiZi/Uqt90
         C7GJzzhjdGKsVqpb/QQ23/x6uY1jQaJPWXRNa85fC0rMIgS61j0bYpTpsQPQXwGZKMs2
         nKCxN+4VxxsN3/Zz0ozZW5II8cqf/rZH42qUfJt6zU/aiTR1ooYAXwQiBHF05J5clyU5
         /krP52eQpFLOajh6VrwjeK2aP/fSAtPiLvHzAHyaW5n1sW91dtqIG6Z81IimAutaElGg
         7s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680211319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnyFffHnLQxEq4pI3SmE7M+GX7tfHqiqsW+FaERKQAw=;
        b=ccooRoCGirt/hA7WCH28wtO23Ei2hOS+y1e4qNyziMCpnHtlPI67cyHzL+0cYI34dr
         x7XcjVmtoVljJhdQHabKQl2evxG9I5oAWl0vxcBor+WdeUvB3EJK0qy5m7nWJsjRV7Qb
         8xNLYLuxR4WSwIEev1GTrFXaEvcWEw9OfacPlUsuAuIHtyDbXDCmYJidKN3JhNawIdCY
         yFH16mYtXVYoydTq7XvQDCetnWDfiLzEovQru23rbMA11ctAAtmaDqRXm3pli70xROPx
         3QYno8LpE5eQbC4dBpPAfDNN8Gn04Z3H74UPTFg7edDnMVb0o3ESy7R295IB2wTWX86p
         I/jQ==
X-Gm-Message-State: AAQBX9d0EuUpuEXJ1GKheBgmD9MZ8xvM9uJ5vxLsBljVrFU/sE7YYuQo
        JfqnTyHKuzOavqJ/DpCaEmU58nNGuRZnyc4=
X-Google-Smtp-Source: AKy350b3Et7jX+Fmxv9/1Mwzxrcmn2DcucnrNsYtFsIQ442EbY0Yndt8tKpBtcXMp15ENt/6jAlzhQ==
X-Received: by 2002:a05:6214:27e1:b0:5d1:acb8:f126 with SMTP id jt1-20020a05621427e100b005d1acb8f126mr35910268qvb.38.1680211318746;
        Thu, 30 Mar 2023 14:21:58 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id mx5-20020a0562142e0500b005dd8b9345desm110761qvb.118.2023.03.30.14.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 14:21:58 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v15 4/4] selftest,ptrace: Add selftest for syscall user dispatch config api
Date:   Thu, 30 Mar 2023 17:21:25 -0400
Message-Id: <20230330212121.1688-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230330212121.1688-1-gregory.price@memverge.com>
References: <20230330212121.1688-1-gregory.price@memverge.com>
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

