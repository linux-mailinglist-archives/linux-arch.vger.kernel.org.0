Return-Path: <linux-arch+bounces-14407-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4601C1AABD
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 14:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39BA3341516
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468634AB05;
	Wed, 29 Oct 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ip9Z7zyt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y8nSbdO8"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A963491FC;
	Wed, 29 Oct 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744159; cv=none; b=PQLbEC1tgs/vkGDAMn8Q5PJgRXXQA7lRukC1gZZNxA+jCpoQigxkofZCKZxeR8abe4JCctRPz3nZzMisQJTE9S7O9Zv2ky1trY/pLSSBzHuvRoJHYGCEt33BB1xcLCIf4yC8w/FqOKgLcSo8lnX5bDY3fqyoq+s15GlWAOsAj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744159; c=relaxed/simple;
	bh=06ISzQNgJLjVggBFt8HttartK0B8H+jc0eI02K8krU0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lTLhiyJieXVkAzcSwxqh4l8+wh94f9imsc9kw+8WrvpGxbcs7K+A6k2GaBGUqwC0LfVofoEDeLgI7rfwg6eNUJco1riR0y2NFIxaJz8JybfTNnD70fRjPyCiRvNaGY1/NOhwS1plEYfjmGKBCgWbGRKLRy7RDofT0dQzMf5NPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ip9Z7zyt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y8nSbdO8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029130404.178482110@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761744155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dcLOQpuYAiP8UwPR9j6QkSdUC70FGf3yGYPnlF6MyzM=;
	b=Ip9Z7zythanZ8S1phguwtZ75lnQCs+pt9v1obBHxalcs7nSJ3DXgTiSYSdmLNGeekQvbIL
	rJsBo4AE55NgLg6oA267LMWYTBpMba+9cVNhsSrIVeVIgfQAqo+KxTf9t0B8tjekV78vIs
	6jNIL2Wzh3eaQzrSjPQXUgoc33TXC9z4RCMu0kRsz0li8WXDK+kXPI0YmLR7b7gaeHHkvg
	lLyQ0PFXZqfE4NryPv2W2kDc6rBgKGiiu6ZxA871+RNqQDekaAqodkvBqhRlbEdRYXK0Fe
	RzyNASTv+kGzvi5+9Buo/hXxhODQYKttXv01aYbkKE9UGbbpA9jsJ4VDo6Q3ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761744155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dcLOQpuYAiP8UwPR9j6QkSdUC70FGf3yGYPnlF6MyzM=;
	b=Y8nSbdO8gv7Ko3XSDctFQVpa58fXhLM7clRzn4Ydx+vX2ef+IC6DYicBWPWRecgpkX/IjB
	bzDRD5gMn17p+8DQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Subject: [patch V3 12/12] selftests/rseq: Implement time slice extension test
References: <20251029125514.496134233@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:22:34 +0100 (CET)

Provide an initial test case to evaluate the functionality. This needs to be
extended to cover the ABI violations and expose the race condition between
observing granted and arriving in rseq_slice_yield().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/rseq/.gitignore   |    1 
 tools/testing/selftests/rseq/Makefile     |    5 
 tools/testing/selftests/rseq/rseq-abi.h   |   27 ++++
 tools/testing/selftests/rseq/slice_test.c |  198 ++++++++++++++++++++++++++++++
 4 files changed, 230 insertions(+), 1 deletion(-)

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
@@ -53,6 +53,27 @@ struct rseq_abi_cs {
 	__u64 abort_ip;
 } __attribute__((aligned(4 * sizeof(__u64))));
 
+/**
+ * rseq_slice_ctrl - Time slice extension control structure
+ * @all:	Compound value
+ * @request:	Request for a time slice extension
+ * @granted:	Granted time slice extension
+ *
+ * @request is set by user space and can be cleared by user space or kernel
+ * space.  @granted is set and cleared by the kernel and must only be read
+ * by user space.
+ */
+struct rseq_slice_ctrl {
+	union {
+		__u32		all;
+		struct {
+			__u8	request;
+			__u8	granted;
+			__u16	__reserved;
+		};
+	};
+};
+
 /*
  * struct rseq_abi is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line.
@@ -165,6 +186,12 @@ struct rseq_abi {
 	__u32 mm_cid;
 
 	/*
+	 * Time slice extension control structure. CPU local updates from
+	 * kernel and user space.
+	 */
+	struct rseq_slice_ctrl slice_ctrl;
+
+	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
 	char end[];
--- /dev/null
+++ b/tools/testing/selftests/rseq/slice_test.c
@@ -0,0 +1,198 @@
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
+		bool req = false;
+
+		clock_gettime(CLOCK_MONOTONIC, &ts_cs);
+
+		RSEQ_WRITE_ONCE(rs->slice_ctrl.request, 1);
+		do {
+			clock_gettime(CLOCK_MONOTONIC, &ts_now);
+		} while (!elapsed(&ts_cs, &ts_now, variant->slice_nsecs));
+
+		/*
+		 * request can be cleared unconditionally, but for making
+		 * the stats work this is actually checking it first
+		 */
+		if (RSEQ_READ_ONCE(rs->slice_ctrl.request)) {
+			RSEQ_WRITE_ONCE(rs->slice_ctrl.request, 0);
+			/* Race between check and clear! */
+			req = true;
+			success++;
+		}
+
+		if (RSEQ_READ_ONCE(rs->slice_ctrl.granted)) {
+			/* The above raced against a late grant */
+			if (req)
+				success--;
+			yielded++;
+			if (!syscall(__NR_rseq_slice_yield))
+				raced++;
+		} else {
+			if (!req)
+				scheduled++;
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


