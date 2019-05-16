Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A207A208E3
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfEPOA3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 10:00:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33267 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfEPOAX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 10:00:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so5502668edb.0
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rBkcy062NYYGXGh6TqicbzBWp7bPNVyN1NSgT1R4iSI=;
        b=SBA2Nz1vN94S1Ju76/cX3Iq2qNIMZWAqOz9NnQT+n2LMUVlrugi1VxMZtjUVjgcK9k
         due+GLQjcSxDqrflXBVQFei6HiKpDh7kApiPOrw6kmLMbbPktWHhXiOlumkx7NNcU1pA
         LDeIIhNfxe2C7tReM/gFpa3dfnLMFAPSO4pBByzIGvcpnd4z6hw8WNUNGVx+Udna4a1I
         vrAFHOvpdjC0+iCd4SPLgs7ROXDnIxLKx2xOa8zGLomxBC8L5tFYYd0k3jn/gD9zgeYE
         s1MFUtubfGy+X2H1NMfyabuSW+Ivg+MJT8zM9avfQbS+Qq1WiqQuhEumwvFTKsRnGoVk
         CFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBkcy062NYYGXGh6TqicbzBWp7bPNVyN1NSgT1R4iSI=;
        b=K0NwR0NA1zslsGEeWeLqN/9G5Vh2POusGqlDUKHUs2UtHNCrFALDP6ciRikh8LN/kf
         MNiu4+zF1qY9oNHB7KD+8Bn693Q63MEn/RJwPN1mNfesr2NCcTHXVdG4jDsal7BDFJdU
         pWAc/2o8c3wePEF1Q3Ng2J3V8a4NMTQ8SbUbIGCLkBNveFhSgsmcZjTs/sZfq3QHK40m
         XDFaVjlQwkpgMmgcCl9dgyMXT/lI/hfs5JNCHjaLqHC0n5wcQBEMWq/VjUzYv5/P4Du/
         pzYlKmI4yS+Q+/XulnHC26wvPPbWWXZKoiTcT9l2hfppiauMlbCXbNthL4bfLbvkuP3s
         qzPA==
X-Gm-Message-State: APjAAAVBSqGnvUHMo60frmcO6VEqnhGVGOEeUQcNORQRecDsL2HWu/wd
        2hDs0+pwMeJJXP7m8CfrhLNalA==
X-Google-Smtp-Source: APXvYqwK1uR02XhXcAPkNqh781MathY3wyFgpsh57U9z72OWZ2kjVfoYK27rsXdKaNrGO6FWKr6ZKQ==
X-Received: by 2002:a50:b662:: with SMTP id c31mr51477064ede.252.1558015221861;
        Thu, 16 May 2019 07:00:21 -0700 (PDT)
Received: from localhost.localdomain ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id y20sm1093563ejb.40.2019.05.16.07.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:00:21 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, oleg@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Cc:     akpm@linux-foundation.org, cyphar@cyphar.com, dhowells@redhat.com,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        keescook@chromium.org, luto@amacapital.net, luto@kernel.org,
        tglx@linutronix.de, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, joel@joelfernandes.org,
        dancol@google.com, serge@hallyn.com,
        Christian Brauner <christian@brauner.io>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH v1 2/2] tests: add pidfd_open() tests
Date:   Thu, 16 May 2019 15:59:43 +0200
Message-Id: <20190516135944.7205-2-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516135944.7205-1-christian@brauner.io>
References: <20190516135944.7205-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This adds testing for the new pidfd_open() syscalls. Specifically, we test:
- that no invalid flags can be passed to pidfd_open()
- that no invalid pid can be passed to pidfd_open()
- that a pidfd can be retrieved with pidfd_open()
- that the retrieved pidfd references the correct pid

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-api@vger.kernel.org
---
v1: unchanged
---
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 tools/testing/selftests/pidfd/pidfd.h         |  57 ++++++
 .../testing/selftests/pidfd/pidfd_open_test.c | 170 ++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_test.c    |  41 +----
 4 files changed, 229 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd.h
 create mode 100644 tools/testing/selftests/pidfd/pidfd_open_test.c

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index deaf8073bc06..b36c0be70848 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,6 +1,6 @@
 CFLAGS += -g -I../../../../usr/include/
 
-TEST_GEN_PROGS := pidfd_test
+TEST_GEN_PROGS := pidfd_test pidfd_open_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
new file mode 100644
index 000000000000..8452e910463f
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PIDFD_H
+#define __PIDFD_H
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/mount.h>
+
+#include "../kselftest.h"
+
+/*
+ * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
+ * That means, when it wraps around any pid < 300 will be skipped.
+ * So we need to use a pid > 300 in order to test recycling.
+ */
+#define PID_RECYCLE 1000
+
+/*
+ * Define a few custom error codes for the child process to clearly indicate
+ * what is happening. This way we can tell the difference between a system
+ * error, a test error, etc.
+ */
+#define PIDFD_PASS 0
+#define PIDFD_FAIL 1
+#define PIDFD_ERROR 2
+#define PIDFD_SKIP 3
+#define PIDFD_XFAIL 4
+
+int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
+
+
+#endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
new file mode 100644
index 000000000000..9b073c1ac618
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "pidfd.h"
+#include "../kselftest.h"
+
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+static int safe_int(const char *numstr, int *converted)
+{
+	char *err = NULL;
+	long sli;
+
+	errno = 0;
+	sli = strtol(numstr, &err, 0);
+	if (errno == ERANGE && (sli == LONG_MAX || sli == LONG_MIN))
+		return -ERANGE;
+
+	if (errno != 0 && sli == 0)
+		return -EINVAL;
+
+	if (err == numstr || *err != '\0')
+		return -EINVAL;
+
+	if (sli > INT_MAX || sli < INT_MIN)
+		return -ERANGE;
+
+	*converted = (int)sli;
+	return 0;
+}
+
+static int char_left_gc(const char *buffer, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (buffer[i] == ' ' ||
+		    buffer[i] == '\t')
+			continue;
+
+		return i;
+	}
+
+	return 0;
+}
+
+static int char_right_gc(const char *buffer, size_t len)
+{
+	int i;
+
+	for (i = len - 1; i >= 0; i--) {
+		if (buffer[i] == ' '  ||
+		    buffer[i] == '\t' ||
+		    buffer[i] == '\n' ||
+		    buffer[i] == '\0')
+			continue;
+
+		return i + 1;
+	}
+
+	return 0;
+}
+
+static char *trim_whitespace_in_place(char *buffer)
+{
+	buffer += char_left_gc(buffer, strlen(buffer));
+	buffer[char_right_gc(buffer, strlen(buffer))] = '\0';
+	return buffer;
+}
+
+static pid_t get_pid_from_fdinfo_file(int pidfd, const char *key, size_t keylen)
+{
+	int ret;
+	char path[512];
+	FILE *f;
+	size_t n = 0;
+	pid_t result = -1;
+	char *line = NULL;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", pidfd);
+
+	f = fopen(path, "re");
+	if (!f)
+		return -1;
+
+	while (getline(&line, &n, f) != -1) {
+		char *numstr;
+
+		if (strncmp(line, key, keylen))
+			continue;
+
+		numstr = trim_whitespace_in_place(line + 4);
+		ret = safe_int(numstr, &result);
+		if (ret < 0)
+			goto out;
+
+		break;
+	}
+
+out:
+	free(line);
+	fclose(f);
+	return result;
+}
+
+int main(int argc, char **argv)
+{
+	int pidfd = -1, ret = 1;
+	pid_t pid;
+
+	pidfd = sys_pidfd_open(-1, 0);
+	if (pidfd >= 0) {
+		ksft_print_msg(
+			"%s - succeeded to open pidfd for invalid pid -1\n",
+			strerror(errno));
+		goto on_error;
+	}
+	ksft_test_result_pass("do not allow invalid pid test: passed\n");
+	ksft_inc_pass_cnt();
+
+	pidfd = sys_pidfd_open(getpid(), 1);
+	if (pidfd >= 0) {
+		ksft_print_msg(
+			"%s - succeeded to open pidfd with invalid flag value specified\n",
+			strerror(errno));
+		goto on_error;
+	}
+	ksft_test_result_pass("do not allow invalid flag test: passed\n");
+	ksft_inc_pass_cnt();
+
+	pidfd = sys_pidfd_open(getpid(), 0);
+	if (pidfd < 0) {
+		ksft_print_msg("%s - failed to open pidfd\n", strerror(errno));
+		goto on_error;
+	}
+	ksft_test_result_pass("open a new pidfd test: passed\n");
+	ksft_inc_pass_cnt();
+
+	pid = get_pid_from_fdinfo_file(pidfd, "Pid:", sizeof("Pid:") - 1);
+	ksft_print_msg("pidfd %d refers to process with pid %d\n", pidfd, pid);
+
+	ret = 0;
+
+on_error:
+	if (pidfd >= 0)
+		close(pidfd);
+
+	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+}
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index d59378a93782..f01de87249c9 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -14,6 +14,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include "pidfd.h"
 #include "../kselftest.h"
 
 static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
@@ -62,28 +63,6 @@ static int test_pidfd_send_signal_simple_success(void)
 	return 0;
 }
 
-static int wait_for_pid(pid_t pid)
-{
-	int status, ret;
-
-again:
-	ret = waitpid(pid, &status, 0);
-	if (ret == -1) {
-		if (errno == EINTR)
-			goto again;
-
-		return -1;
-	}
-
-	if (ret != pid)
-		goto again;
-
-	if (!WIFEXITED(status))
-		return -1;
-
-	return WEXITSTATUS(status);
-}
-
 static int test_pidfd_send_signal_exited_fail(void)
 {
 	int pidfd, ret, saved_errno;
@@ -128,13 +107,6 @@ static int test_pidfd_send_signal_exited_fail(void)
 	return 0;
 }
 
-/*
- * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
- * That means, when it wraps around any pid < 300 will be skipped.
- * So we need to use a pid > 300 in order to test recycling.
- */
-#define PID_RECYCLE 1000
-
 /*
  * Maximum number of cycles we allow. This is equivalent to PID_MAX_DEFAULT.
  * If users set a higher limit or we have cycled PIDFD_MAX_DEFAULT number of
@@ -143,17 +115,6 @@ static int test_pidfd_send_signal_exited_fail(void)
  */
 #define PIDFD_MAX_DEFAULT 0x8000
 
-/*
- * Define a few custom error codes for the child process to clearly indicate
- * what is happening. This way we can tell the difference between a system
- * error, a test error, etc.
- */
-#define PIDFD_PASS 0
-#define PIDFD_FAIL 1
-#define PIDFD_ERROR 2
-#define PIDFD_SKIP 3
-#define PIDFD_XFAIL 4
-
 static int test_pidfd_send_signal_recycled_pid_fail(void)
 {
 	int i, ret;
-- 
2.21.0

