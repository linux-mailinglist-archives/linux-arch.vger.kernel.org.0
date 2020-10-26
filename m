Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA7A298C49
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 12:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774056AbgJZLuo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 07:50:44 -0400
Received: from foss.arm.com ([217.140.110.172]:36538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774022AbgJZLuQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Oct 2020 07:50:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E46B1474;
        Mon, 26 Oct 2020 04:50:15 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 286993F719;
        Mon, 26 Oct 2020 04:50:14 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 5/5] kselftest: Extend vdso correctness test to clock_gettime64
Date:   Mon, 26 Oct 2020 11:49:45 +0000
Message-Id: <20201026114945.48532-6-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026114945.48532-1-vincenzo.frascino@arm.com>
References: <20201026114945.48532-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the release of Linux 5.1 has been added a new syscall,
clock_gettime64, that provided a 64 bit time value for a specified
clock_ID to make the kernel Y2038 safe on 32 bit architectures.

Extend the vdso correctness test to cover the newly exposed vdso
function.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/vDSO/vdso_config.h    |   4 +-
 .../selftests/vDSO/vdso_test_correctness.c    | 115 +++++++++++++++++-
 2 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index eeb725df6045..6a6fe8d4ff55 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -66,12 +66,13 @@ static const char *versions[6] = {
 	"LINUX_4.15",
 };
 
-static const char *names[2][5] = {
+static const char *names[2][6] = {
 	{
 		"__kernel_gettimeofday",
 		"__kernel_clock_gettime",
 		"__kernel_time",
 		"__kernel_clock_getres",
+		"__kernel_getcpu",
 #if defined(VDSO_32BIT)
 		"__kernel_clock_gettime64",
 #endif
@@ -81,6 +82,7 @@ static const char *names[2][5] = {
 		"__vdso_clock_gettime",
 		"__vdso_time",
 		"__vdso_clock_getres",
+		"__vdso_getcpu",
 #if defined(VDSO_32BIT)
 		"__vdso_clock_gettime64",
 #endif
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 42052db0f870..5029ef9b228c 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -19,6 +19,10 @@
 #include <stdbool.h>
 #include <limits.h>
 
+#include "vdso_config.h"
+
+static const char **name;
+
 #ifndef SYS_getcpu
 # ifdef __x86_64__
 #  define SYS_getcpu 309
@@ -27,6 +31,17 @@
 # endif
 #endif
 
+#ifndef __NR_clock_gettime64
+#define __NR_clock_gettime64	403
+#endif
+
+#ifndef __kernel_timespec
+struct __kernel_timespec {
+	long long	tv_sec;
+	long long	tv_nsec;
+};
+#endif
+
 /* max length of lines in /proc/self/maps - anything longer is skipped here */
 #define MAPS_LINE_LEN 128
 
@@ -36,6 +51,10 @@ typedef int (*vgettime_t)(clockid_t, struct timespec *);
 
 vgettime_t vdso_clock_gettime;
 
+typedef int (*vgettime64_t)(clockid_t, struct __kernel_timespec *);
+
+vgettime64_t vdso_clock_gettime64;
+
 typedef long (*vgtod_t)(struct timeval *tv, struct timezone *tz);
 
 vgtod_t vdso_gettimeofday;
@@ -99,17 +118,23 @@ static void fill_function_pointers()
 		return;
 	}
 
-	vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
+	vdso_getcpu = (getcpu_t)dlsym(vdso, name[4]);
 	if (!vdso_getcpu)
 		printf("Warning: failed to find getcpu in vDSO\n");
 
 	vgetcpu = (getcpu_t) vsyscall_getcpu();
 
-	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
+	vdso_clock_gettime = (vgettime_t)dlsym(vdso, name[1]);
 	if (!vdso_clock_gettime)
 		printf("Warning: failed to find clock_gettime in vDSO\n");
 
-	vdso_gettimeofday = (vgtod_t)dlsym(vdso, "__vdso_gettimeofday");
+#if defined(VDSO_32BIT)
+	vdso_clock_gettime64 = (vgettime64_t)dlsym(vdso, name[5]);
+	if (!vdso_clock_gettime64)
+		printf("Warning: failed to find clock_gettime64 in vDSO\n");
+#endif
+
+	vdso_gettimeofday = (vgtod_t)dlsym(vdso, name[0]);
 	if (!vdso_gettimeofday)
 		printf("Warning: failed to find gettimeofday in vDSO\n");
 
@@ -126,6 +151,11 @@ static inline int sys_clock_gettime(clockid_t id, struct timespec *ts)
 	return syscall(__NR_clock_gettime, id, ts);
 }
 
+static inline int sys_clock_gettime64(clockid_t id, struct __kernel_timespec *ts)
+{
+	return syscall(__NR_clock_gettime64, id, ts);
+}
+
 static inline int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	return syscall(__NR_gettimeofday, tv, tz);
@@ -191,6 +221,15 @@ static bool ts_leq(const struct timespec *a, const struct timespec *b)
 		return a->tv_nsec <= b->tv_nsec;
 }
 
+static bool ts64_leq(const struct __kernel_timespec *a,
+		     const struct __kernel_timespec *b)
+{
+	if (a->tv_sec != b->tv_sec)
+		return a->tv_sec < b->tv_sec;
+	else
+		return a->tv_nsec <= b->tv_nsec;
+}
+
 static bool tv_leq(const struct timeval *a, const struct timeval *b)
 {
 	if (a->tv_sec != b->tv_sec)
@@ -254,7 +293,10 @@ static void test_one_clock_gettime(int clock, const char *name)
 	if (!ts_leq(&start, &vdso) || !ts_leq(&vdso, &end)) {
 		printf("[FAIL]\tTimes are out of sequence\n");
 		nerrs++;
+		return;
 	}
+
+	printf("[OK]\tTest Passed.\n");
 }
 
 static void test_clock_gettime(void)
@@ -275,6 +317,70 @@ static void test_clock_gettime(void)
 	test_one_clock_gettime(INT_MAX, "invalid");
 }
 
+static void test_one_clock_gettime64(int clock, const char *name)
+{
+	struct __kernel_timespec start, vdso, end;
+	int vdso_ret, end_ret;
+
+	printf("[RUN]\tTesting clock_gettime64 for clock %s (%d)...\n", name, clock);
+
+	if (sys_clock_gettime64(clock, &start) < 0) {
+		if (errno == EINVAL) {
+			vdso_ret = vdso_clock_gettime64(clock, &vdso);
+			if (vdso_ret == -EINVAL) {
+				printf("[OK]\tNo such clock.\n");
+			} else {
+				printf("[FAIL]\tNo such clock, but __vdso_clock_gettime64 returned %d\n", vdso_ret);
+				nerrs++;
+			}
+		} else {
+			printf("[WARN]\t clock_gettime64(%d) syscall returned error %d\n", clock, errno);
+		}
+		return;
+	}
+
+	vdso_ret = vdso_clock_gettime64(clock, &vdso);
+	end_ret = sys_clock_gettime64(clock, &end);
+
+	if (vdso_ret != 0 || end_ret != 0) {
+		printf("[FAIL]\tvDSO returned %d, syscall errno=%d\n",
+		       vdso_ret, errno);
+		nerrs++;
+		return;
+	}
+
+	printf("\t%llu.%09ld %llu.%09ld %llu.%09ld\n",
+	       (unsigned long long)start.tv_sec, start.tv_nsec,
+	       (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
+	       (unsigned long long)end.tv_sec, end.tv_nsec);
+
+	if (!ts64_leq(&start, &vdso) || !ts64_leq(&vdso, &end)) {
+		printf("[FAIL]\tTimes are out of sequence\n");
+		nerrs++;
+		return;
+	}
+
+	printf("[OK]\tTest Passed.\n");
+}
+
+static void test_clock_gettime64(void)
+{
+	if (!vdso_clock_gettime64) {
+		printf("[SKIP]\tNo vDSO, so skipping clock_gettime64() tests\n");
+		return;
+	}
+
+	for (int clock = 0; clock < sizeof(clocknames) / sizeof(clocknames[0]);
+	     clock++) {
+		test_one_clock_gettime64(clock, clocknames[clock]);
+	}
+
+	/* Also test some invalid clock ids */
+	test_one_clock_gettime64(-1, "invalid");
+	test_one_clock_gettime64(INT_MIN, "invalid");
+	test_one_clock_gettime64(INT_MAX, "invalid");
+}
+
 static void test_gettimeofday(void)
 {
 	struct timeval start, vdso, end;
@@ -327,9 +433,12 @@ static void test_gettimeofday(void)
 
 int main(int argc, char **argv)
 {
+	name = (const char **)&names[VDSO_NAMES];
+
 	fill_function_pointers();
 
 	test_clock_gettime();
+	test_clock_gettime64();
 	test_gettimeofday();
 
 	/*
-- 
2.28.0

