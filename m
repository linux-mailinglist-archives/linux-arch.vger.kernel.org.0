Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A4A6DB183
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 19:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDGRTQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjDGRS6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 13:18:58 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94DD1BD2;
        Fri,  7 Apr 2023 10:18:56 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a30-20020a9d3e1e000000b006a13f728172so19183619otd.3;
        Fri, 07 Apr 2023 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680887936; x=1683479936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnyFffHnLQxEq4pI3SmE7M+GX7tfHqiqsW+FaERKQAw=;
        b=jIlUSJ0V8IR9KRd8T2N1fNohSIfYxulDOKrWe+Sq990DkAz1OcVvfROFGewgH/MkrH
         F2v5/PvnCH/3v9cQ/e67xbJ3tuTk+xM4ZqVwYDmKCjlazFoeRAmTQ6vrtEsJgfla+1Pe
         PUKzVTqbFMu9nLm/CogYzALkCR0j1bp3MfWsi2zay/NW7y88jooWDHs7LNw16zAEhpZd
         8DCASjK85Lr2VaiHk506gKEQL7F2u9f7GmiU59Qojfs08a8XxVDBJF5aHb3utyC0gp+G
         l3FFNnkWk5RJ47PucvR4oQahUt9S7Dz4uskZiuOnLi8IbLJbUIVzd+i8RscIzAnoaoQb
         AssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887936; x=1683479936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnyFffHnLQxEq4pI3SmE7M+GX7tfHqiqsW+FaERKQAw=;
        b=MqQ80HO2zfBEybkWrJbJzdAKRdc+VdT4befEUH7WtEXpctVWJhAVHb+kYSFtNhQlCw
         VCWxLH9ES3SdE7S2ee00UGLqpk45WJIUuZN9iBOK04ummF4U66E4aCR5Pqis/nuX37iH
         BAgoa1gnxYpc36yWMYkMzpk7bVtHwaGnzXqEjJLhVf1bkwD+2m7AhnekXvxaDjWlb0es
         jjdqlSjuS1EYz7dycCNuRY4KlLQYbbK5zSTG025Uajpr7mVv6+KYC9i0AxQfErmu2LAz
         cnfcDHW10NK8MLBgJaUmWQEFTZcc3VmtKk2F83hH/4QKo/JwpJU7/E7IsPUGbb0++d/B
         AyaQ==
X-Gm-Message-State: AAQBX9fgaffpScPCeSkwIj/AIrc7hgqXOcmYGi5+/MykFymlxW88cirj
        OuUZ2CYRKxdftTRrW9v61HVedYMV+xENHT4=
X-Google-Smtp-Source: AKy350b0DU99QKvkQpLh4zt6z9o4Q5IDlL+QxIGt1XaqDVs1VDiSov6WZzducFkRGrn8iye6UsISHQ==
X-Received: by 2002:a05:6830:1e90:b0:69f:a732:d4fb with SMTP id n16-20020a0568301e9000b0069fa732d4fbmr1251418otr.35.1680887936131;
        Fri, 07 Apr 2023 10:18:56 -0700 (PDT)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id l9-20020a9d7349000000b006a2ddc13c46sm1816730otk.78.2023.04.07.10.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:18:55 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v16 4/4] selftest,ptrace: Add selftest for syscall user dispatch config api
Date:   Fri,  7 Apr 2023 13:18:34 -0400
Message-Id: <20230407171834.3558-5-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230407171834.3558-1-gregory.price@memverge.com>
References: <20230407171834.3558-1-gregory.price@memverge.com>
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

