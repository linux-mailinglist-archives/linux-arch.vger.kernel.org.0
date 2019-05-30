Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A26AC2FD44
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfE3OQw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:16:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36988 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbfE3OQt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:16:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75483A78;
        Thu, 30 May 2019 07:16:49 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D65C3F59C;
        Thu, 30 May 2019 07:16:46 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
Subject: [PATCH v6 19/19] kselftest: Extend vDSO selftest
Date:   Thu, 30 May 2019 15:15:31 +0100
Message-Id: <20190530141531.43462-20-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530141531.43462-1-vincenzo.frascino@arm.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The current version of the multiarch vDSO selftest verifies only
gettimeofday.

Extend the vDSO selftest to the other library functions:
 - time
 - clock_getres
 - clock_gettime

The extension has been used to verify the unified vdso library on the
supported architectures.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/vDSO/Makefile         |   2 +
 tools/testing/selftests/vDSO/vdso_full_test.c | 261 ++++++++++++++++++
 2 files changed, 263 insertions(+)
 create mode 100644 tools/testing/selftests/vDSO/vdso_full_test.c

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 9e03d61f52fd..68e9b4a1cdcf 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -5,6 +5,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 TEST_GEN_PROGS := $(OUTPUT)/vdso_test
+TEST_GEN_PROGS += $(OUTPUT)/vdso_full_test
 ifeq ($(ARCH),x86)
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
@@ -18,6 +19,7 @@ endif
 
 all: $(TEST_GEN_PROGS)
 $(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
+$(OUTPUT)/vdso_full_test: parse_vdso.c vdso_full_test.c
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
diff --git a/tools/testing/selftests/vDSO/vdso_full_test.c b/tools/testing/selftests/vDSO/vdso_full_test.c
new file mode 100644
index 000000000000..62001d3d241b
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_full_test.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * vdso_full_test.c: Sample code to test all the timers.
+ * Copyright (c) 2019 Arm Ltd.
+ *
+ * Compile with:
+ * gcc -std=gnu99 vdso_full_test.c parse_vdso.c
+ *
+ * Tested on ARM, ARM64, MIPS32 and x86 (32-bit and 64-bit).
+ * Might work on other architectures.
+ */
+
+#include <stdint.h>
+#include <elf.h>
+#include <stdio.h>
+#include <time.h>
+#include <sys/auxv.h>
+#include <sys/time.h>
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "../kselftest.h"
+
+extern void *vdso_sym(const char *version, const char *name);
+extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
+extern void vdso_init_from_auxv(void *auxv);
+
+/*
+ * ARM64's vDSO exports its vDSO implementation with different names and
+ * a different version from other architectures, so we need to handle it
+ * as a special case.
+ */
+#if defined(__aarch64__)
+const char *version = "LINUX_2.6.39";
+const char *name[4] = {
+	"__kernel_gettimeofday",
+	"__kernel_clock_gettime",
+	"__kernel_time",
+	"__kernel_clock_getres",
+};
+#else
+/* Tested on x86, arm, mips */
+const char *version = "LINUX_2.6";
+const char *name[4] = {
+	"__vdso_gettimeofday",
+	"__vdso_clock_gettime",
+	"__vdso_time",
+	"__vdso_clock_getres",
+};
+#endif
+
+typedef long (*vdso_gettimeofday_t)(struct timeval *tv, struct timezone *tz);
+typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, struct timespec *ts);
+typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
+typedef time_t (*vdso_time_t)(time_t *t);
+
+static int vdso_test_gettimeofday(void)
+{
+	/* Find gettimeofday. */
+	vdso_gettimeofday_t vdso_gettimeofday =
+		(vdso_gettimeofday_t)vdso_sym(version, name[0]);
+
+	if (!vdso_gettimeofday) {
+		printf("Could not find %s\n", name[0]);
+		return KSFT_SKIP;
+	}
+
+	struct timeval tv;
+	long ret = vdso_gettimeofday(&tv, 0);
+
+	if (ret == 0) {
+		printf("The time is %lld.%06lld\n",
+		       (long long)tv.tv_sec, (long long)tv.tv_usec);
+	} else {
+		printf("%s failed\n", name[0]);
+		return KSFT_FAIL;
+	}
+
+	return KSFT_PASS;
+}
+
+static int vdso_test_clock_gettime(clockid_t clk_id)
+{
+	/* Find clock_gettime. */
+	vdso_clock_gettime_t vdso_clock_gettime =
+		(vdso_clock_gettime_t)vdso_sym(version, name[1]);
+
+	if (!vdso_clock_gettime) {
+		printf("Could not find %s\n", name[1]);
+		return KSFT_SKIP;
+	}
+
+	struct timespec ts;
+	long ret = vdso_clock_gettime(clk_id, &ts);
+
+	if (ret == 0) {
+		printf("The time is %lld.%06lld\n",
+		       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+	} else {
+		printf("%s failed\n", name[1]);
+		return KSFT_FAIL;
+	}
+
+	return KSFT_PASS;
+}
+
+static int vdso_test_time(void)
+{
+	/* Find time. */
+	vdso_time_t vdso_time =
+		(vdso_time_t)vdso_sym(version, name[2]);
+
+	if (!vdso_time) {
+		printf("Could not find %s\n", name[2]);
+		return KSFT_SKIP;
+	}
+
+	long ret = vdso_time(NULL);
+
+	if (ret > 0) {
+		printf("The time in hours since January 1, 1970 is %lld\n",
+				(long long)(ret / 3600));
+	} else {
+		printf("%s failed\n", name[2]);
+		return KSFT_FAIL;
+	}
+
+	return KSFT_PASS;
+}
+
+static int vdso_test_clock_getres(clockid_t clk_id)
+{
+	/* Find clock_getres. */
+	vdso_clock_getres_t vdso_clock_getres =
+		(vdso_clock_getres_t)vdso_sym(version, name[3]);
+
+	if (!vdso_clock_getres) {
+		printf("Could not find %s\n", name[3]);
+		return KSFT_SKIP;
+	}
+
+	struct timespec ts, sys_ts;
+	long ret = vdso_clock_getres(clk_id, &ts);
+
+	if (ret == 0) {
+		printf("The resolution is %lld %lld\n",
+		       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+	} else {
+		printf("%s failed\n", name[3]);
+		return KSFT_FAIL;
+	}
+
+	ret = syscall(SYS_clock_getres, clk_id, &sys_ts);
+
+	if ((sys_ts.tv_sec != ts.tv_sec) || (sys_ts.tv_nsec != ts.tv_nsec)) {
+		printf("%s failed\n", name[3]);
+		return KSFT_FAIL;
+	}
+
+	return KSFT_PASS;
+}
+
+const char *vdso_clock_name[12] = {
+	"CLOCK_REALTIME",
+	"CLOCK_MONOTONIC",
+	"CLOCK_PROCESS_CPUTIME_ID",
+	"CLOCK_THREAD_CPUTIME_ID",
+	"CLOCK_MONOTONIC_RAW",
+	"CLOCK_REALTIME_COARSE",
+	"CLOCK_MONOTONIC_COARSE",
+	"CLOCK_BOOTTIME",
+	"CLOCK_REALTIME_ALARM",
+	"CLOCK_BOOTTIME_ALARM",
+	"CLOCK_SGI_CYCLE",
+	"CLOCK_TAI",
+};
+
+/*
+ * This function calls vdso_test_clock_gettime and vdso_test_clock_getres
+ * with different values for clock_id.
+ */
+static inline int vdso_test_clock(clockid_t clock_id)
+{
+	int ret0, ret1;
+
+	ret0 = vdso_test_clock_gettime(clock_id);
+	/* A skipped test is considered passed */
+	if (ret0 == KSFT_SKIP)
+		ret0 = KSFT_PASS;
+
+	ret1 = vdso_test_clock_getres(clock_id);
+	/* A skipped test is considered passed */
+	if (ret1 == KSFT_SKIP)
+		ret1 = KSFT_PASS;
+
+	ret0 += ret1;
+
+	printf("clock_id: %s", vdso_clock_name[clock_id]);
+
+	if (ret0 > 0)
+		printf(" [FAIL]\n");
+	else
+		printf(" [PASS]\n");
+
+	return ret0;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+	int ret;
+
+	if (!sysinfo_ehdr) {
+		printf("AT_SYSINFO_EHDR is not present!\n");
+		return KSFT_SKIP;
+	}
+
+	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
+
+	ret = vdso_test_gettimeofday();
+
+#if _POSIX_TIMERS > 0
+
+#ifdef CLOCK_REALTIME
+	ret += vdso_test_clock(CLOCK_REALTIME);
+#endif
+
+#ifdef CLOCK_BOOTTIME
+	ret += vdso_test_clock(CLOCK_BOOTTIME);
+#endif
+
+#ifdef CLOCK_TAI
+	ret += vdso_test_clock(CLOCK_TAI);
+#endif
+
+#ifdef CLOCK_REALTIME_COARSE
+	ret += vdso_test_clock(CLOCK_REALTIME_COARSE);
+#endif
+
+#ifdef CLOCK_MONOTONIC
+	ret += vdso_test_clock(CLOCK_MONOTONIC);
+#endif
+
+#ifdef CLOCK_MONOTONIC_RAW
+	ret += vdso_test_clock(CLOCK_MONOTONIC_RAW);
+#endif
+
+#ifdef CLOCK_MONOTONIC_COARSE
+	ret += vdso_test_clock(CLOCK_MONOTONIC_COARSE);
+#endif
+
+#endif
+
+	ret += vdso_test_time();
+
+	if (ret > 0)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
-- 
2.21.0

