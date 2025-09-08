Return-Path: <linux-arch+bounces-13434-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269AB49D3B
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 01:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28B924E1AF6
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5178931E0FA;
	Mon,  8 Sep 2025 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eEzwGzN+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q+D/xV0G"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668453054E4;
	Mon,  8 Sep 2025 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372421; cv=none; b=JtB/kv+MoSzM0gc+PMRC15KqrXKmZCU9LCDgr6bqdYwlB0C7YR6Y1V3Po7T2WkMEZVLhUPJAk/9BFcIEJFGjII9qdVSTxo/Zi2OUD471CBh1hBp6N4WY47GjJOYQlRaH6LmWGdIwUz1q2Klpvj6+njAP6B0zUh85mQ9LcyJ/YRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372421; c=relaxed/simple;
	bh=TFBnJqoHxYkjFAybe9EyMqjGGU61dfvgNqTEKh7olIo=;
	h=Message-ID:From:To:Subject:References:MIME-Version:Content-Type:
	 cc:Date; b=bhmW1yfnKroejP6Nw2NRmpcmbq2tvwE5Z6yxU5UO5QS8wCtIv7uPo23s6hoKGL9+8WVLGGgsk4Kq/EAtPmVGs/wtfzaBvb7waUoqTOSVbON9mKmVPGWPCWyIcrRqAUdFJusLxZuiQFmMXC1kWXkaYMta4FkCzCSalfBgWwsb6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eEzwGzN+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q+D/xV0G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908225753.332052396@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757372417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=g114yMIHJ/N+lL2K1FcdTSWH6GyatJrycQTW2sArYtE=;
	b=eEzwGzN+zl7bNel84uq3ip/lLOcZjZ4StNjfhW09yqAVUkUwBfYwL5sr9ydM/NWBtYgOXs
	xLQPVTRKDvH0JZ2BhuWKy7Kb8jdd9VVN/Ad06OsiQ+9nljNxGGTIYviXsrr23X9vCjqYl/
	+/mdTTnpAUAMWx19riUHSXdYFbtm3qJ0G54gEgUIQ8rvhRo47XiMOqSFSY8HXT3Bdt+zRu
	jLyUhsD55wA6LqkCVzY52TmvLkeVB5uDwlo0tl5Rjs6hFyxkj2FOh6fbiqmtNGgwxUgZ/e
	qwDbq9/d5ueJ2yCptNdRXCx6EDwWPkHx0dy+FR0Kz3Awm0PiJ3/y1NnUVfFidA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757372417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=g114yMIHJ/N+lL2K1FcdTSWH6GyatJrycQTW2sArYtE=;
	b=q+D/xV0GrEUUu4dbzRFzl4eR36ktHIU8Fx4UohHebnVQsg/CjNmtOAqeBp+AbDs9+zEbfr
	eb3rWllkAYxZMRAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 12/12] selftests/rseq: Implement time slice extension test
References: <20250908225709.144709889@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
cc: Peter Zilstra <peterz@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Date: Tue,  9 Sep 2025 01:00:16 +0200 (CEST)

Provide an initial test case to evaluate the functionality. This needs to be
extended to cover the ABI violations and expose the race condition between
observing granted and ariving in rseq_slice_yield().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/rseq/.gitignore   |    1 
 tools/testing/selftests/rseq/Makefile     |    5 
 tools/testing/selftests/rseq/rseq-abi.h   |    2 
 tools/testing/selftests/rseq/slice_test.c |  217 ++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -10,3 +10,4 @@ param_test_mm_cid
 param_test_mm_cid_benchmark
 param_test_mm_cid_compare_twice
 syscall_errors_test
+slice_test
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -17,7 +17,7 @@ OVERRIDE_TARGETS = 1
 TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
 		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice \
-		syscall_errors_test
+		syscall_errors_test slice_test
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
@@ -59,3 +59,6 @@ include ../lib.mk
 $(OUTPUT)/syscall_errors_test: syscall_errors_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
 	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/slice_test: slice_test.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
+	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -164,6 +164,8 @@ struct rseq_abi {
 	 */
 	__u32 mm_cid;
 
+	__u32 slice_ctrl;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
--- /dev/null
+++ b/tools/testing/selftests/rseq/slice_test.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: LGPL-2.1
+#define _GNU_SOURCE
+#include <assert.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <syscall.h>
+#include <unistd.h>
+
+#include <linux/prctl.h>
+#include <sys/prctl.h>
+#include <sys/time.h>
+
+#include "rseq.h"
+
+#include "../kselftest_harness.h"
+
+#ifndef __NR_rseq_slice_yield
+# define __NR_rseq_slice_yield	470
+#endif
+
+#define BITS_PER_INT	32
+#define BITS_PER_BYTE	8
+
+#ifndef PR_RSEQ_SLICE_EXTENSION
+# define PR_RSEQ_SLICE_EXTENSION		79
+#  define PR_RSEQ_SLICE_EXTENSION_GET		1
+#  define PR_RSEQ_SLICE_EXTENSION_SET		2
+#  define PR_RSEQ_SLICE_EXT_ENABLE		0x01
+#endif
+
+#ifndef RSEQ_SLICE_EXT_REQUEST_BIT
+# define RSEQ_SLICE_EXT_REQUEST_BIT	0
+# define RSEQ_SLICE_EXT_GRANTED_BIT	1
+#endif
+
+#ifndef asm_inline
+# define asm_inline	asm __inline
+#endif
+
+#if defined(__x86_64__) || defined(__i386__)
+static __always_inline bool test_and_clear_request(unsigned int *addr)
+{
+	const unsigned int bit = RSEQ_SLICE_EXT_REQUEST_BIT;
+	bool res;
+
+	asm inline volatile("btrl %[__bit], %[__addr]\n"
+			    : [__addr] "+m" (*addr), "=@cc" "c" (res)
+			    : [__bit] "Ir" (bit)
+			    : "memory");
+	return res;
+}
+#else
+static __always_inline bool test_and_clear_request(unsigned int *addr)
+{
+	const unsigned int mask = (1U << RSEQ_SLICE_EXT_REQUEST_BIT);
+
+	return __atomic_fetch_and(addr, ~mask, __ATOMIC_RELAXED) & mask;
+}
+#endif
+
+static __always_inline void set_request(unsigned int *addr)
+{
+	*addr = 1U << RSEQ_SLICE_EXT_REQUEST_BIT;
+}
+
+static __always_inline bool test_granted(unsigned int *addr)
+{
+	return !!(*addr & (1U << RSEQ_SLICE_EXT_GRANTED_BIT));
+}
+
+#define NSEC_PER_SEC	1000000000L
+#define NSEC_PER_USEC	      1000L
+
+struct noise_params {
+	int	noise_nsecs;
+	int	sleep_nsecs;
+	int	run;
+};
+
+FIXTURE(slice_ext)
+{
+	pthread_t		noise_thread;
+	struct noise_params	noise_params;
+};
+
+FIXTURE_VARIANT(slice_ext)
+{
+	int64_t	total_nsecs;
+	int	slice_nsecs;
+	int	noise_nsecs;
+	int	sleep_nsecs;
+};
+
+FIXTURE_VARIANT_ADD(slice_ext, n2_2_50)
+{
+	.total_nsecs	=  5 * NSEC_PER_SEC,
+	.slice_nsecs	=  2 * NSEC_PER_USEC,
+	.noise_nsecs    =  2 * NSEC_PER_USEC,
+	.sleep_nsecs	= 50 * NSEC_PER_USEC,
+};
+
+FIXTURE_VARIANT_ADD(slice_ext, n50_2_50)
+{
+	.total_nsecs	=  5 * NSEC_PER_SEC,
+	.slice_nsecs	= 50 * NSEC_PER_USEC,
+	.noise_nsecs    =  2 * NSEC_PER_USEC,
+	.sleep_nsecs	= 50 * NSEC_PER_USEC,
+};
+
+static inline bool elapsed(struct timespec *start, struct timespec *now,
+			   int64_t span)
+{
+	int64_t delta = now->tv_sec - start->tv_sec;
+
+	delta *= NSEC_PER_SEC;
+	delta += now->tv_nsec - start->tv_nsec;
+	return delta >= span;
+}
+
+static void *noise_thread(void *arg)
+{
+	struct noise_params *p = arg;
+
+	while (RSEQ_READ_ONCE(p->run)) {
+		struct timespec ts_start, ts_now;
+
+		clock_gettime(CLOCK_MONOTONIC, &ts_start);
+		do {
+			clock_gettime(CLOCK_MONOTONIC, &ts_now);
+		} while (!elapsed(&ts_start, &ts_now, p->noise_nsecs));
+
+		ts_start.tv_sec = 0;
+		ts_start.tv_nsec = p->sleep_nsecs;
+		clock_nanosleep(CLOCK_MONOTONIC, 0, &ts_start, NULL);
+	}
+	return NULL;
+}
+
+FIXTURE_SETUP(slice_ext)
+{
+	cpu_set_t affinity;
+
+	ASSERT_EQ(sched_getaffinity(0, sizeof(affinity), &affinity), 0);
+
+	/* Pin it on a single CPU. Avoid CPU 0 */
+	for (int i = 1; i < CPU_SETSIZE; i++) {
+		if (!CPU_ISSET(i, &affinity))
+			continue;
+
+		CPU_ZERO(&affinity);
+		CPU_SET(i, &affinity);
+		ASSERT_EQ(sched_setaffinity(0, sizeof(affinity), &affinity), 0);
+		break;
+	}
+
+	ASSERT_EQ(rseq_register_current_thread(), 0);
+
+	ASSERT_EQ(prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
+			PR_RSEQ_SLICE_EXT_ENABLE, 0, 0), 0);
+
+	self->noise_params.noise_nsecs = variant->noise_nsecs;
+	self->noise_params.sleep_nsecs = variant->sleep_nsecs;
+	self->noise_params.run = 1;
+
+	ASSERT_EQ(pthread_create(&self->noise_thread, NULL, noise_thread, &self->noise_params), 0);
+}
+
+FIXTURE_TEARDOWN(slice_ext)
+{
+	self->noise_params.run = 0;
+	pthread_join(self->noise_thread, NULL);
+}
+
+TEST_F(slice_ext, slice_test)
+{
+	unsigned long success = 0, yielded = 0, scheduled = 0, raced = 0;
+	struct rseq_abi *rs = rseq_get_abi();
+	struct timespec ts_start, ts_now;
+
+	ASSERT_NE(rs, NULL);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+	do {
+		struct timespec ts_cs;
+
+		clock_gettime(CLOCK_MONOTONIC, &ts_cs);
+
+		set_request(&rs->slice_ctrl);
+		do {
+			clock_gettime(CLOCK_MONOTONIC, &ts_now);
+		} while (!elapsed(&ts_cs, &ts_now, variant->slice_nsecs));
+
+		if (!test_and_clear_request(&rs->slice_ctrl)) {
+			if (test_granted(&rs->slice_ctrl)) {
+				yielded++;
+				if (!syscall(__NR_rseq_slice_yield))
+					raced++;
+			} else {
+				scheduled++;
+			}
+		} else {
+			success++;
+		}
+
+		clock_gettime(CLOCK_MONOTONIC, &ts_now);
+	} while (!elapsed(&ts_start, &ts_now, variant->total_nsecs));
+
+	printf("# Success   %12ld\n", success);
+	printf("# Yielded   %12ld\n", yielded);
+	printf("# Scheduled %12ld\n", scheduled);
+	printf("# Raced     %12ld\n", raced);
+}
+
+TEST_HARNESS_MAIN


