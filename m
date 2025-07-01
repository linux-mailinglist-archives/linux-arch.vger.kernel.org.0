Return-Path: <linux-arch+bounces-12532-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 094C0AEF21B
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 11:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8819B7A143C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E567326D4C2;
	Tue,  1 Jul 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="viI4fnWD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MfsGvuVb"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B6269CF1;
	Tue,  1 Jul 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360290; cv=none; b=OsFoxMbbN3WF5ri7wJDm/Xb44E6VHft+QwCd4ZetQ2JnozUYu8nsGAx5G46CHZO9gqc6npUKVjh0b6JaSQ2oZdUyGptp/VTGvr2VLV2VMGLAcJUuNwTSDRZKPbGCHoD+mqI8BcGhaT6OqLbBIg/PWj6Yy2zUTfn9fXluSiKYeeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360290; c=relaxed/simple;
	bh=aGyKXEDWrVl42o1/QdNJRr5JgUP/zN2xT7Z0rsQB31c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BB7lwvXMLBEqmVFWSPbnlUvifUSw5i48K3CuBMxci9aPat6NC2Lp5R26WnvvFJN8e3hhH9Cy4eIQ1zmPstkhWtfQO2N6tb3i8XD1ZsChXuj67c/CYNHVfYjYQfsnUp89k66bvc1o8OMebhtHa+riTP69QL226+eVsMnQXtHDAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=viI4fnWD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MfsGvuVb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zg/MZMVxe4vqEY85XexMl2BL8AO2M+KvX9W8RRyArw0=;
	b=viI4fnWD/1Y6PNl68cmZZyo1kvryQHq0LjDpVMZ6o3erxo6/lJGaeLD3bgUM4R65s+TZcI
	B4fUgiaCpsO+11/L/20PjRxzKTCcc45iKgkxyhf3jkv1sT+qM0jSJDQACU0MguKpDi4n5v
	+GRoXaV8zMA7qdbmb9LKOm9I9XwKGqDdnt1GLg6trH85sVJvNukuZC17Xjhz1HYgD2y+y3
	9BOj3l36aBoVCjQ2Bxv0cOytTgYfzfHyUjpcNjPXcv8LvlPNr/i/UHohRKVMNrD5oWOUUj
	oXSVgVZKCrVCxEKd5inKO/xYMN9JL7uvXLcXF+HLhSbsqLahoVBgSDA0xqENpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zg/MZMVxe4vqEY85XexMl2BL8AO2M+KvX9W8RRyArw0=;
	b=MfsGvuVbDo+xRfjnkyJ+4QegloQ/rHRy+k+r9C9HO+EKbIE1CUepWx9NQkHpshB0tBpGFw
	PDU4CG5N/8afO3DA==
Date: Tue, 01 Jul 2025 10:57:55 +0200
Subject: [PATCH 01/14] selftests/timers: Add testcase for auxiliary clocks
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-1-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
In-Reply-To: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher Hall <christopher.s.hall@intel.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Werner Abt <werner.abt@meinberg-usa.com>, 
 David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
 Antoine Tenart <atenart@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=9807;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aGyKXEDWrVl42o1/QdNJRr5JgUP/zN2xT7Z0rsQB31c=;
 b=O/YV9KTW7oOAMiAf3l56XmU6PUWfqXXfrs2Inr0O+Qs7JtK2sYieB6c7VLlasrdiTp04HhXFz
 jATsHeEhbjyA5g1BgZQ58/ALT4q+hODXi82draVAffT3PPCpXvV9mFn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Auxiliary clocks behave differently from regular ones.
Add a testcase to validate their functionality.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/timers/.gitignore |   1 +
 tools/testing/selftests/timers/Makefile   |   2 +-
 tools/testing/selftests/timers/auxclock.c | 319 ++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/.gitignore b/tools/testing/selftests/timers/.gitignore
index bb5326ff900b8edc3aa2d8d596599973593fbaf0..dcee43b3ecd9351c9bb0483088d712ccd7b57367 100644
--- a/tools/testing/selftests/timers/.gitignore
+++ b/tools/testing/selftests/timers/.gitignore
@@ -20,3 +20,4 @@ valid-adjtimex
 adjtick
 set-tz
 freq-step
+auxclock
diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index 32203593c62e1e0cdfd3de6f567ea1e82913f2ef..3a8833b3fb7449495c66a92c4d82e35a6755b5e8 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -5,7 +5,7 @@ LDLIBS += -lrt -lpthread -lm
 # these are all "safe" tests that don't modify
 # system time or require escalated privileges
 TEST_GEN_PROGS = posix_timers nanosleep nsleep-lat set-timer-lat mqueue-lat \
-	     inconsistency-check raw_skew threadtest rtcpie
+	     inconsistency-check raw_skew threadtest rtcpie auxclock
 
 DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
 		      skew_consistency clocksource-switch freq-step leap-a-day \
diff --git a/tools/testing/selftests/timers/auxclock.c b/tools/testing/selftests/timers/auxclock.c
new file mode 100644
index 0000000000000000000000000000000000000000..0ba2f9996114ade3147f0f3aec49904556a23cd4
--- /dev/null
+++ b/tools/testing/selftests/timers/auxclock.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Work around type conflicts between libc and the UAPI headers */
+#define _SYS_TIME_H
+#define __timeval_defined
+#define _GNU_SOURCE
+
+#include <fcntl.h>
+#include <linux/types.h>
+#include <linux/timex.h>
+#include <sched.h>
+#include <stdio.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef CLOCK_AUX
+#define	CLOCK_AUX	16
+#endif
+
+#ifndef NSEC_PER_SEC
+#define NSEC_PER_SEC 1000000000ULL
+#endif
+
+#define AUXCLOCK_SELFTEST_TIMENS_OFFSET 10000
+
+static int configure_auxclock(__kernel_clockid_t clockid, bool enable)
+{
+	char path[100];
+	int fd, ret;
+
+	ret = snprintf(path, sizeof(path),
+		       "/sys/kernel/time/aux_clocks/%d/aux_clock_enable",
+		       (int)clockid - CLOCK_AUX);
+	if (ret >= sizeof(path))
+		return -ENOSPC;
+
+	fd = open(path, O_WRONLY);
+	if (fd == -1)
+		return -errno;
+
+	/* Always disable to reset */
+	ret = dprintf(fd, "0\n");
+	if (enable)
+		ret = dprintf(fd, "1\n");
+	close(fd);
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/* Everything is done in terms of 64bit time values to keep the code readable */
+
+static inline void timespec_to_kernel_timespec(const struct timespec *ts,
+					       struct __kernel_timespec *kts)
+{
+	if (!kts)
+		return;
+
+	kts->tv_sec = ts->tv_sec;
+	kts->tv_nsec = ts->tv_nsec;
+}
+
+static inline void kernel_timespec_to_timespec(const struct __kernel_timespec *kts,
+					       struct timespec *ts)
+{
+	if (!kts)
+		return;
+
+	ts->tv_sec = kts->tv_sec;
+	ts->tv_nsec = kts->tv_nsec;
+}
+
+static int sys_clock_getres_time64(__kernel_clockid_t clockid, struct __kernel_timespec *ts)
+{
+#if defined(__NR_clock_getres_time64)
+	return syscall(__NR_clock_getres_time64, clockid, ts);
+#elif defined(__NR_clock_getres)
+	struct timespec _ts;
+	int ret;
+
+	ret = syscall(__NR_clock_getres, clockid, &_ts);
+	if (!ret)
+		timespec_to_kernel_timespec(&_ts, ts);
+	return ret;
+#else
+#error "No clock_getres() support"
+#endif
+}
+
+static int sys_clock_gettime64(__kernel_clockid_t clockid, struct __kernel_timespec *ts)
+{
+#if defined(__NR_clock_gettime64)
+	return syscall(__NR_clock_gettime64, clockid, ts);
+#elif defined(__NR_clock_gettime)
+	struct timespec _ts;
+	int ret;
+
+	ret = syscall(__NR_clock_gettime, clockid, &_ts);
+	if (!ret)
+		timespec_to_kernel_timespec(&_ts, ts);
+	return ret;
+#else
+#error "No clock_gettime() support"
+#endif
+}
+
+static int sys_clock_settime64(__kernel_clockid_t clockid, const struct __kernel_timespec *ts)
+{
+#if defined(__NR_clock_settime64)
+	return syscall(__NR_clock_settime64, clockid, ts);
+#elif defined(__NR_clock_settime)
+	struct timespec _ts;
+
+	kernel_timespec_to_timespec(ts, &_ts);
+	return syscall(__NR_clock_settime, clockid, &_ts);
+#else
+#error "No clock_settime() support"
+#endif
+}
+
+static int sys_clock_adjtime64(__kernel_clockid_t clockid, struct __kernel_timex *tx)
+{
+#if defined(__NR_clock_adjtime64)
+	return syscall(__NR_clock_adjtime64, clockid, tx);
+#elif __LONG_WIDTH__ == 64 && defined(__NR_clock_adjtime)
+	return syscall(__NR_clock_adjtime, clockid, tx);
+#else
+#error "No clock_adjtime() support"
+#endif
+}
+
+FIXTURE(auxclock) {};
+
+FIXTURE_VARIANT(auxclock) {
+	__kernel_clockid_t clock;
+	bool clock_enabled;
+	bool use_timens;
+};
+
+FIXTURE_VARIANT_ADD(auxclock, default) {
+	.clock		= CLOCK_AUX,
+	.clock_enabled	= true,
+	.use_timens	= false,
+};
+
+FIXTURE_VARIANT_ADD(auxclock, timens) {
+	.clock		= CLOCK_AUX,
+	.clock_enabled	= true,
+	.use_timens	= true,
+};
+
+FIXTURE_VARIANT_ADD(auxclock, disabled) {
+	.clock		= CLOCK_AUX,
+	.clock_enabled	= false,
+	.use_timens	= false,
+};
+
+/* No timens_disabled to keep the testmatrix smaller. */
+
+static void enter_timens(struct __test_metadata *_metadata)
+{
+	int ret, fd;
+	char buf[100];
+
+	ret = unshare(CLONE_NEWTIME);
+	if (ret != 0 && errno == EPERM)
+		SKIP(return, "no permissions for unshare(CLONE_NEWTIME)");
+	if (ret != 0 && errno == EINVAL)
+		SKIP(return, "time namespaces not available");
+	ASSERT_EQ(0, ret) TH_LOG("unshare(CLONE_NEWTIME) failed: %s", strerror(errno));
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd == -1 && errno == ENOENT)
+		SKIP(return, "no support for time namespaces");
+	ASSERT_NE(-1, fd);
+	/* Fiddle with the namespace to make the tests more meaningful */
+	ret = snprintf(buf, sizeof(buf), "monotonic %d 0\nboottime %d 0\n",
+		       AUXCLOCK_SELFTEST_TIMENS_OFFSET, AUXCLOCK_SELFTEST_TIMENS_OFFSET);
+	ASSERT_TRUE(ret > 0 && ret < sizeof(buf));
+	ret = write(fd, buf, ret);
+	ASSERT_NE(-1, ret);
+	close(fd);
+	fd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	ASSERT_NE(-1, fd);
+	ret = setns(fd, CLONE_NEWTIME);
+	close(fd);
+	ASSERT_EQ(0, ret);
+}
+
+FIXTURE_SETUP(auxclock) {
+	int ret;
+
+	ret = configure_auxclock(variant->clock, variant->clock_enabled);
+	if (ret == -ENOENT)
+		SKIP(return, "auxclocks not enabled");
+	ASSERT_EQ(0, ret);
+
+	if (variant->use_timens)
+		enter_timens(_metadata);
+}
+
+FIXTURE_TEARDOWN(auxclock) {
+	int ret;
+
+	ret = configure_auxclock(variant->clock, false);
+	ASSERT_EQ(0, ret);
+}
+
+TEST_F(auxclock, sys_clock_getres) {
+	struct __kernel_timespec ts;
+	int ret;
+
+	/* clock_getres() is always expected to work */
+	ret = sys_clock_getres_time64(variant->clock, &ts);
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(0, ts.tv_sec);
+	ASSERT_EQ(1, ts.tv_nsec);
+}
+
+TEST_F(auxclock, sys_clock_gettime) {
+	struct __kernel_timespec ts;
+	int ret;
+
+	ret = sys_clock_gettime64(variant->clock, &ts);
+	if (variant->clock_enabled) {
+		ASSERT_EQ(0, ret);
+	} else {
+		ASSERT_EQ(-1, ret);
+		ASSERT_EQ(ENODEV, errno);
+	}
+}
+
+static void auxclock_validate_progression(struct __test_metadata *_metadata,
+					  const struct __kernel_timespec *a,
+					  const struct __kernel_timespec *b)
+{
+	int64_t diff;
+
+	diff = (b->tv_sec - a->tv_sec) * NSEC_PER_SEC;
+	diff += b->tv_nsec - a->tv_nsec;
+
+	/* Arbitrary values */
+	ASSERT_LT(1, diff);
+	ASSERT_GT(1 * NSEC_PER_SEC, diff);
+}
+
+TEST_F(auxclock, sys_clock_settime) {
+	struct __kernel_timespec a, b = {};
+	int ret;
+
+	a.tv_sec = 1234;
+	a.tv_nsec = 5678;
+
+	ret = sys_clock_settime64(variant->clock, &a);
+	if (!variant->clock_enabled) {
+		ASSERT_EQ(-1, ret);
+		ASSERT_EQ(ENODEV, errno);
+		return;
+	}
+
+	ASSERT_EQ(0, ret);
+
+	ret = sys_clock_gettime64(variant->clock, &b);
+	ASSERT_EQ(0, ret);
+
+	auxclock_validate_progression(_metadata, &a, &b);
+}
+
+TEST_F(auxclock, sys_clock_adjtime) {
+	struct __kernel_timex tx;
+	int ret, realtime_freq;
+
+	memset(&tx, 0, sizeof(tx));
+	tx.modes = ADJ_FREQUENCY;
+	ret = sys_clock_adjtime64(CLOCK_REALTIME, &tx);
+	ASSERT_NE(-1, ret);
+	ASSERT_TRUE(tx.modes & ADJ_FREQUENCY);
+	realtime_freq = tx.freq;
+
+	ret = sys_clock_adjtime64(variant->clock, &tx);
+	if (variant->clock_enabled) {
+		ASSERT_NE(-1, ret);
+		ASSERT_EQ(realtime_freq, tx.freq);
+	} else {
+		ASSERT_EQ(-1, ret);
+		ASSERT_EQ(ENODEV, errno);
+	}
+}
+
+TEST_F(auxclock, progression) {
+	struct __kernel_timespec a, b;
+	int ret;
+
+	if (!variant->clock_enabled) {
+		TH_LOG("no progression on disabled clocks");
+		return;
+	}
+
+	/* set up reference */
+	ret = sys_clock_gettime64(variant->clock, &a);
+	ASSERT_EQ(0, ret);
+
+	for (int i = 0; i < 100; i++) {
+		memset(&b, 0, sizeof(b));
+		ret = sys_clock_gettime64(variant->clock, &b);
+		ASSERT_EQ(0, ret);
+		auxclock_validate_progression(_metadata, &a, &b);
+
+		memset(&a, 0, sizeof(a));
+		ret = sys_clock_gettime64(variant->clock, &a);
+		ASSERT_EQ(0, ret);
+		auxclock_validate_progression(_metadata, &b, &a);
+	}
+}
+
+TEST_HARNESS_MAIN

-- 
2.50.0


