Return-Path: <linux-arch+bounces-7936-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7AD9976BE
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 22:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764151F23B68
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 20:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB4B1E7C0E;
	Wed,  9 Oct 2024 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="aqSCXevP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B81E2837;
	Wed,  9 Oct 2024 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506545; cv=none; b=bAg0T+faUVmRUJBa+1/JYqDdyX5Y9uCf2ADaYkakqfowGgDf9qSRoGujSgDjpZMFHa3ug0epDpKxAUCvmDiiCRyk682ZH8TH0UXCtU0qlW/iSmn9bwWiDS/j1XehdB2gdb6WFsXLpmw6Oaq2x0FC2P4xvu6tGmG41Yz2pu4viZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506545; c=relaxed/simple;
	bh=Bzh9OsJFyVxxs0UUl9I/hXyHe//SV8qmyJ8G0kkUtCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+mEVMyi2RnFOu9c2YNyc8tVgJr6qQrxsHJttiRZCmEo2UFrmCuFFIMWSPf0n+GqokJnDZRtU1GQRyJq+U3WZDKJUa1TPiyIzM5d5MTqBQH3SNCCqwjvuVpZId3Fj6Y2d2Epeo9E3JqNhlwFPVLMEI08GvkCeChosxLgS/qBUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=aqSCXevP; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XP4ZK6FVVz9sxv;
	Wed,  9 Oct 2024 22:42:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728506537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCw4fcVlYhpmb9a93CqGmQEl9A3eKBG5nIi80087L/A=;
	b=aqSCXevPhGic0cJ9OkLYPD+sV6xE4TcjrcPcDD1CWorkSWN9E4yUA6wyDA9c7rscNa2hUP
	tTvGQNvA9tUGluO0AkKKQDbx4DIkBxy5NGPv9UbMdSvlQ86qsFIbjLwOCR9mtm2V7MpTKU
	eL0aZe9Lp+Acj0ZgkOZcOKkIPXGwg3TcFV2L3nxFnp1D+fos+jqFgEMmCXKovDHGS4Jurz
	X1tNpH+CvbXy4y8gpH7UiID892FwozPJFIRtT4i5PrsAY4VRGqcuU8FpkkrelBL5JlvfDO
	u2uFoULN6HokrvCgNuRDygFaGokxFLEt9MCUdI7jawDDn0gV4i5BCJS7db5NwA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 10 Oct 2024 07:40:41 +1100
Subject: [PATCH RFC v3 08/10] selftests: clone3: add CHECK_FIELDS selftests
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-extensible-structs-check_fields-v3-8-d2833dfe6edd@cyphar.com>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
In-Reply-To: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9631; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Bzh9OsJFyVxxs0UUl9I/hXyHe//SV8qmyJ8G0kkUtCU=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaSzvQpi1mQPm3r7gEiysmFAV+ChnxdLX6QWstceSjmps
 2Ka/aeIjlIWBjEuBlkxRZZtfp6hm+YvvpL8aSUbzBxWJpAhDFycAjARsVJGhrelKXfjBGQTHhXe
 FTvSsiFp1y+pz2qOMX3PnuZJCl0SqGZk+Mr+p0kwrGTfzIX6yr+Ebua1tZmLbXwfGviz/8+zB9H
 b2AA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/clone3/.gitignore          |   1 +
 tools/testing/selftests/clone3/Makefile            |   4 +-
 .../testing/selftests/clone3/clone3_check_fields.c | 264 +++++++++++++++++++++
 3 files changed, 267 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/selftests/clone3/.gitignore
index 83c0f6246055..4ec3e1ecd273 100644
--- a/tools/testing/selftests/clone3/.gitignore
+++ b/tools/testing/selftests/clone3/.gitignore
@@ -3,3 +3,4 @@ clone3
 clone3_clear_sighand
 clone3_set_tid
 clone3_cap_checkpoint_restore
+clone3_check_fields
diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
index 84832c369a2e..37141ca13f7c 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
+CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
 TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
-	clone3_cap_checkpoint_restore
+	clone3_cap_checkpoint_restore clone3_check_fields
 
 include ../lib.mk
diff --git a/tools/testing/selftests/clone3/clone3_check_fields.c b/tools/testing/selftests/clone3/clone3_check_fields.c
new file mode 100644
index 000000000000..477604f9a3fb
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3_check_fields.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2024 SUSE LLC
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sched.h>
+
+#include "../kselftest.h"
+#include "clone3_selftests.h"
+
+#ifndef CHECK_FIELDS
+#define CHECK_FIELDS (1ULL << 63)
+#endif
+
+struct __clone_args_v0 {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+};
+
+struct __clone_args_v1 {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+	__aligned_u64 set_tid;
+	__aligned_u64 set_tid_size;
+};
+
+struct __clone_args_v2 {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+	__aligned_u64 set_tid;
+	__aligned_u64 set_tid_size;
+	__aligned_u64 cgroup;
+};
+
+static int call_clone3(void *clone_args, size_t size)
+{
+	int status;
+	pid_t pid;
+
+	pid = sys_clone3(clone_args, size);
+	if (pid < 0)
+		return -errno;
+
+	if (pid == 0) {
+		ksft_print_msg("I am the child, my PID is %d\n", getpid());
+		_exit(EXIT_SUCCESS);
+	}
+
+	ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
+			getpid(), pid);
+
+	if (waitpid(-1, &status, __WALL) < 0) {
+		ksft_print_msg("waitpid() returned %s\n", strerror(errno));
+		return -errno;
+	}
+	if (!WIFEXITED(status)) {
+		ksft_print_msg("Child did not exit normally, status 0x%x\n",
+			       status);
+		return EXIT_FAILURE;
+	}
+	if (WEXITSTATUS(status))
+		return WEXITSTATUS(status);
+
+	return 0;
+}
+
+static bool check(bool *failed, bool pred)
+{
+	*failed |= pred;
+	return pred;
+}
+
+static void test_clone3_check_fields(const char *test_name, size_t struct_size)
+{
+	size_t bufsize;
+	void *buffer;
+	pid_t pid;
+	bool failed = false;
+	void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+
+	/* Allocate some bytes after clone_args to verify they are cleared. */
+	bufsize = struct_size + 16;
+	buffer = malloc(bufsize);
+	/* Set the structure to dummy values. */
+	memset(buffer, 0, bufsize);
+	memset(buffer, 0xAB, struct_size);
+
+	pid = call_clone3(buffer, CHECK_FIELDS | struct_size);
+	if (check(&failed, (pid != -EEXTSYS_NOOP)))
+		ksft_print_msg("clone3(CHECK_FIELDS) returned the wrong error code: %d (%s) != %d\n",
+			       pid, strerror(-pid), -EEXTSYS_NOOP);
+
+	switch (struct_size) {
+	case sizeof(struct __clone_args_v2): {
+		struct __clone_args_v2 *args = buffer;
+
+		if (check(&failed, (args->cgroup != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong cgroup field: 0x%.16llx != 0x%.16llx\n",
+				       args->cgroup, 0xFFFFFFFFFFFFFFFF);
+
+		/* fallthrough; */
+	}
+	case sizeof(struct __clone_args_v1): {
+		struct __clone_args_v1 *args = buffer;
+
+		if (check(&failed, (args->set_tid != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong set_tid field: 0x%.16llx != 0x%.16llx\n",
+				       args->set_tid, 0xFFFFFFFFFFFFFFFF);
+		if (check(&failed, (args->set_tid_size != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong set_tid_size field: 0x%.16llx != 0x%.16llx\n",
+				       args->set_tid_size, 0xFFFFFFFFFFFFFFFF);
+
+		/* fallthrough; */
+	}
+	case sizeof(struct __clone_args_v0): {
+		struct __clone_args_v0 *args = buffer;
+
+		if (check(&failed, !(args->flags & CLONE_NEWUSER)))
+			ksft_print_msg("clone3(CHECK_FIELDS) is missing CLONE_NEWUSER in flags: 0x%.16llx (0x%.16llx)\n",
+				       args->flags, CLONE_NEWUSER);
+		if (check(&failed, !(args->flags & CLONE_THREAD)))
+			ksft_print_msg("clone3(CHECK_FIELDS) is missing CLONE_THREAD in flags: 0x%.16llx (0x%.16llx)\n",
+				       args->flags, CLONE_THREAD);
+		/*
+		 * CLONE_INTO_CGROUP was added in v2, but it will be set even
+		 * with smaller structure sizes.
+		 */
+		if (check(&failed, !(args->flags & CLONE_INTO_CGROUP)))
+			ksft_print_msg("clone3(CHECK_FIELDS) is missing CLONE_INTO_CGROUP in flags: 0x%.16llx (0x%.16llx)\n",
+				       args->flags, CLONE_INTO_CGROUP);
+
+		if (check(&failed, (args->exit_signal != 0xFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong exit_signal field: 0x%.16llx != 0x%.16llx\n",
+				       args->exit_signal, 0xFF);
+
+		if (check(&failed, (args->stack != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong stack field: 0x%.16llx != 0x%.16llx\n",
+				       args->stack, 0xFFFFFFFFFFFFFFFF);
+		if (check(&failed, (args->stack_size != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong stack_size field: 0x%.16llx != 0x%.16llx\n",
+				       args->stack_size, 0xFFFFFFFFFFFFFFFF);
+		if (check(&failed, (args->tls != 0xFFFFFFFFFFFFFFFF)))
+			ksft_print_msg("clone3(CHECK_FIELDS) has wrong tls field: 0x%.16llx != 0x%.16llx\n",
+				       args->tls, 0xFFFFFFFFFFFFFFFF);
+
+		break;
+	}
+	default:
+		fprintf(stderr, "INVALID STRUCTURE SIZE: %d\n", struct_size);
+		abort();
+	}
+
+	/* Verify that the trailing parts of the buffer are still 0. */
+	for (size_t i = struct_size; i < bufsize; i++) {
+		char ch = ((char *)buffer)[i];
+		if (check(&failed, (ch != '\x00')))
+			ksft_print_msg("clone3(CHECK_FIELDS) touched a byte outside the size: buffer[%d] = 0x%.2x\n",
+				       i, ch);
+	}
+
+	if (failed)
+		resultfn = ksft_test_result_fail;
+
+	resultfn("clone3(CHECK_FIELDS) with %s\n", test_name);
+	free(buffer);
+}
+
+struct check_fields_test {
+	const char *name;
+	size_t struct_size;
+};
+
+static struct check_fields_test check_fields_tests[] = {
+	{"struct v0", sizeof(struct __clone_args_v0)},
+	{"struct v1", sizeof(struct __clone_args_v1)},
+	{"struct v2", sizeof(struct __clone_args_v2)},
+};
+
+static int test_clone3_check_fields_badsize(const char *test_name,
+					    size_t struct_size)
+{
+	void *buffer;
+	pid_t pid;
+	bool failed = false;
+	int expected_err;
+	void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
+
+	buffer = malloc(struct_size);
+	memset(buffer, 0xAB, struct_size);
+
+	if (struct_size < sizeof(struct __clone_args_v0))
+		expected_err = -EINVAL;
+	if (struct_size > 4096)
+		expected_err = -E2BIG;
+
+	pid = call_clone3(buffer, CHECK_FIELDS | struct_size);
+	if (check(&failed, (pid != expected_err)))
+		ksft_print_msg("clone3(CHECK_FIELDS) returned the wrong error code: %d (%s) != %d (%s)\n",
+			       pid, strerror(-pid),
+			       expected_err, strerror(-expected_err));
+
+	if (failed)
+		resultfn = ksft_test_result_fail;
+
+	resultfn("clone3(CHECK_FIELDS) with %s returns %d (%s)\n", test_name,
+		 expected_err, strerror(-expected_err));
+	free(buffer);
+}
+
+static struct check_fields_test bad_size_tests[] = {
+	{"short struct (< v0)", 1},
+	{"long struct (> PAGE_SIZE)", 0xF000},
+};
+
+int main(void)
+{
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(check_fields_tests) + ARRAY_SIZE(bad_size_tests));
+	test_clone3_supported();
+
+	for (int i = 0; i < ARRAY_SIZE(check_fields_tests); i++) {
+		struct check_fields_test *test = &check_fields_tests[i];
+		test_clone3_check_fields(test->name, test->struct_size);
+	}
+	for (int i = 0; i < ARRAY_SIZE(bad_size_tests); i++) {
+		struct check_fields_test *test = &bad_size_tests[i];
+		test_clone3_check_fields_badsize(test->name, test->struct_size);
+	}
+
+	ksft_finished();
+}

-- 
2.46.1


