Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4BD298C3F
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 12:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773996AbgJZLuO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 07:50:14 -0400
Received: from foss.arm.com ([217.140.110.172]:36516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774015AbgJZLuN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Oct 2020 07:50:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E54B1396;
        Mon, 26 Oct 2020 04:50:12 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A1DB3F881;
        Mon, 26 Oct 2020 04:50:11 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 3/5] kselftest: Extend vDSO selftest to clock_getres
Date:   Mon, 26 Oct 2020 11:49:43 +0000
Message-Id: <20201026114945.48532-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026114945.48532-1-vincenzo.frascino@arm.com>
References: <20201026114945.48532-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The current version of the multiarch vDSO selftest verifies only
gettimeofday.

Extend the vDSO selftest to clock_getres, to verify that the
syscall and the vDSO library function return the same information.

The extension has been used to verify the hrtimer_resoltion fix.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/vDSO/Makefile         |   2 +
 .../selftests/vDSO/vdso_test_clock_getres.c   | 124 ++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_clock_getres.c

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 2ac7448bd414..375d80c2bff5 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -6,6 +6,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
+TEST_GEN_PROGS += $(OUTPUT)/vdso_test_clock_getres
 ifeq ($(ARCH),x86)
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
@@ -20,6 +21,7 @@ all: $(TEST_GEN_PROGS)
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
+$(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
new file mode 100644
index 000000000000..15dcee16ff72
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+/*
+ * vdso_clock_getres.c: Sample code to test clock_getres.
+ * Copyright (c) 2019 Arm Ltd.
+ *
+ * Compile with:
+ * gcc -std=gnu99 vdso_clock_getres.c
+ *
+ * Tested on ARM, ARM64, MIPS32, x86 (32-bit and 64-bit),
+ * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
+ * Might work on other architectures.
+ */
+
+#define _GNU_SOURCE
+#include <elf.h>
+#include <err.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/time.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "../kselftest.h"
+
+static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
+{
+	long ret;
+
+	ret = syscall(SYS_clock_getres, _clkid, _ts);
+
+	return ret;
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
+ * This function calls clock_getres in vdso and by system call
+ * with different values for clock_id.
+ *
+ * Example of output:
+ *
+ * clock_id: CLOCK_REALTIME [PASS]
+ * clock_id: CLOCK_BOOTTIME [PASS]
+ * clock_id: CLOCK_TAI [PASS]
+ * clock_id: CLOCK_REALTIME_COARSE [PASS]
+ * clock_id: CLOCK_MONOTONIC [PASS]
+ * clock_id: CLOCK_MONOTONIC_RAW [PASS]
+ * clock_id: CLOCK_MONOTONIC_COARSE [PASS]
+ */
+static inline int vdso_test_clock(unsigned int clock_id)
+{
+	struct timespec x, y;
+
+	printf("clock_id: %s", vdso_clock_name[clock_id]);
+	clock_getres(clock_id, &x);
+	syscall_clock_getres(clock_id, &y);
+
+	if ((x.tv_sec != y.tv_sec) || (x.tv_nsec != y.tv_nsec)) {
+		printf(" [FAIL]\n");
+		return KSFT_FAIL;
+	}
+
+	printf(" [PASS]\n");
+	return KSFT_PASS;
+}
+
+int main(int argc, char **argv)
+{
+	int ret;
+
+#if _POSIX_TIMERS > 0
+
+#ifdef CLOCK_REALTIME
+	ret = vdso_test_clock(CLOCK_REALTIME);
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
+	if (ret > 0)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
-- 
2.28.0

