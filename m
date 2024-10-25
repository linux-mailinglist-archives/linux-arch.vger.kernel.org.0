Return-Path: <linux-arch+bounces-8539-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12739AFE80
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 11:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094B11C2214E
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 09:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603FA1DD0FD;
	Fri, 25 Oct 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EWoI2kF0"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7D1D364C;
	Fri, 25 Oct 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849279; cv=none; b=AYK/x3Qu4JnoYpvikn29PiAU06dFoLnxSeDagH9BZUalg9Vuiey3qY5faUb7LHZ/XP3g6zN4mIrK1RcacXfWrjQ7+Tv8xXvXHup3sqA0tgKxNSb960nPc68yGQAZDrJlnVdHuu5EcvdRPSvEud/1k+vzK6wg652Mp/YqV95louk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849279; c=relaxed/simple;
	bh=zKcGzEVnkm9CSp7Mz/W/XRrnpAxAW7lFFQ1dztupItk=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fNu3EZEEc5xolHb5RHe0Y9TjlsUrExiw8/QBXfkBVGVkeaKF58qI0Myqrd1oBXPFjG1FtekRJOa60Cbd0GYobWwz28qQTkmcTzud2rncHVqkOmpS2pkLtsQL+bHryzeOpQZyVY3FNnRGwa3QmamuNLeIjvnYip85YcdyGxzzWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EWoI2kF0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=WBCThp+Q/6jOaBGTrPx+/LzFcfDXMvuZTpT311NKNDE=; b=EWoI2kF0smf1s0JbGY03zJ6pds
	7+1TyI0uc8qyQpyMesLwBt8XOHhmPlGYE6EGGOJ73mlBKdBT1KX37ZFqsrABYBwNA94a91/FQ42E0
	qEU/HMdu1bqB3bmHqSxuYrPpUtnWTkeUecZHvkEGzT2NST2LbR0+7RMTxFAPnPz2fjV7vmnBwTS5g
	jVIMPypgqKWNQJGkWzRSb3hMHT4ailPDfYV4mvfJ9mkvV5AFzSxGTSsRSCkhQ8AYpy1JO1U57kNLQ
	HPpriKCzCoE2UyasLLSWp8bGqlpPR/6bYSadxpDjWiFR6elaqL2Mg6ZY8wuFm4p7WIT7slUwynCVh
	ouy8S96w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GoV-00000008saA-0f0B;
	Fri, 25 Oct 2024 09:40:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E2BAE302179; Fri, 25 Oct 2024 11:40:57 +0200 (CEST)
Message-Id: <20241025093944.922683354@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 25 Oct 2024 11:03:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 dvhart@infradead.org,
 dave@stgolabs.net,
 andrealmeid@igalia.com,
 Andrew Morton <akpm@linux-foundation.org>,
 urezki@gmail.com,
 hch@infradead.org,
 lstoakes@gmail.com,
 Arnd Bergmann <arnd@arndb.de>,
 linux-api@vger.kernel.org,
 linux-mm@kvack.org,
 linux-arch@vger.kernel.org,
 malteskarupke@web.de,
 cl@linux.com,
 llong@redhat.com
Subject: [PATCH 6/6] futex,selftests: Extend the futex selftests for NUMA
References: <20241025090347.244183920@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

XXX

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/testing/selftests/futex/functional/Makefile     |    3 
 tools/testing/selftests/futex/functional/futex_numa.c |  262 ++++++++++++++++++
 2 files changed, 264 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -17,7 +17,8 @@ TEST_GEN_PROGS := \
 	futex_wait_private_mapped_file \
 	futex_wait \
 	futex_requeue \
-	futex_waitv
+	futex_waitv \
+	futex_numa
 
 TEST_PROGS := run.sh
 
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_numa.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <pthread.h>
+#include <sys/shm.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <time.h>
+#include <assert.h>
+#include "logging.h"
+#include "futextest.h"
+#include "futex2test.h"
+
+typedef u_int32_t u32;
+typedef int32_t   s32;
+typedef u_int64_t u64;
+
+static int fflags = (FUTEX2_SIZE_U32 | FUTEX2_PRIVATE);
+static int fnode = FUTEX_NO_NODE;
+
+/* fairly stupid test-and-set lock with a waiter flag */
+
+#define N_LOCK		0x0000001
+#define N_WAITERS	0x0001000
+
+struct futex_numa_32 {
+	union {
+		u64 full;
+		struct {
+			u32 val;
+			u32 node;
+		};
+	};
+};
+
+void futex_numa_32_lock(struct futex_numa_32 *lock)
+{
+	for (;;) {
+		struct futex_numa_32 new, old = {
+			.full = __atomic_load_n(&lock->full, __ATOMIC_RELAXED),
+		};
+
+		for (;;) {
+			new = old;
+			if (old.val == 0) {
+				/* no waiter, no lock -> first lock, set no-node */
+				new.node = fnode;
+			}
+			if (old.val & N_LOCK) {
+				/* contention, set waiter */
+				new.val |= N_WAITERS;
+			}
+			new.val |= N_LOCK;
+
+			/* nothing changed, ready to block */
+			if (old.full == new.full)
+				break;
+
+			/*
+			 * Use u64 cmpxchg to set the futex value and node in a
+			 * consistent manner.
+			 */
+			if (__atomic_compare_exchange_n(&lock->full,
+							&old.full, new.full,
+							/* .weak */ false,
+							__ATOMIC_ACQUIRE,
+							__ATOMIC_RELAXED)) {
+
+				/* if we just set N_LOCK, we own it */
+				if (!(old.val & N_LOCK))
+					return;
+
+				/* go block */
+				break;
+			}
+		}
+
+		futex2_wait(lock, new.val, ~0U, fflags, NULL, 0);
+	}
+}
+
+void futex_numa_32_unlock(struct futex_numa_32 *lock)
+{
+	u32 val = __atomic_sub_fetch(&lock->val, N_LOCK, __ATOMIC_RELEASE);
+	assert((s32)val >= 0);
+	if (val & N_WAITERS) {
+		int woken = futex2_wake(lock, ~0U, 1, fflags);
+		assert(val == N_WAITERS);
+		if (!woken) {
+			__atomic_compare_exchange_n(&lock->val, &val, 0U,
+						    false, __ATOMIC_RELAXED,
+						    __ATOMIC_RELAXED);
+		}
+	}
+}
+
+static long nanos = 50000;
+
+struct thread_args {
+	pthread_t tid;
+	volatile int * done;
+	struct futex_numa_32 *lock;
+	int val;
+	int *val1, *val2;
+	int node;
+};
+
+static void *threadfn(void *_arg)
+{
+	struct thread_args *args = _arg;
+	struct timespec ts = {
+		.tv_nsec = nanos,
+	};
+	int node;
+
+	while (!*args->done) {
+
+		futex_numa_32_lock(args->lock);
+		args->val++;
+
+		assert(*args->val1 == *args->val2);
+		(*args->val1)++;
+		nanosleep(&ts, NULL);
+		(*args->val2)++;
+
+		node = args->lock->node;
+		futex_numa_32_unlock(args->lock);
+
+		if (node != args->node) {
+			args->node = node;
+			printf("node: %d\n", node);
+		}
+
+		nanosleep(&ts, NULL);
+	}
+
+	return NULL;
+}
+
+static void *contendfn(void *_arg)
+{
+	struct thread_args *args = _arg;
+
+	while (!*args->done) {
+		/*
+		 * futex2_wait() will take hb-lock, verify *var == val and
+		 * queue/abort.  By knowingly setting val 'wrong' this will
+		 * abort and thereby generate hb-lock contention.
+		 */
+		futex2_wait(&args->lock->val, ~0U, ~0U, fflags, NULL, 0);
+		args->val++;
+	}
+
+	return NULL;
+}
+
+static volatile int done = 0;
+static struct futex_numa_32 lock = { .val = 0, };
+static int val1, val2;
+
+int main(int argc, char *argv[])
+{
+	struct thread_args *tas[512], *cas[512];
+	int c, t, threads = 2, contenders = 0;
+	int sleeps = 10;
+	int total = 0;
+
+	while ((c = getopt(argc, argv, "c:t:s:n:N::")) != -1) {
+		switch (c) {
+		case 'c':
+			contenders = atoi(optarg);
+			break;
+		case 't':
+			threads = atoi(optarg);
+			break;
+		case 's':
+			sleeps = atoi(optarg);
+			break;
+		case 'n':
+			nanos = atoi(optarg);
+			break;
+		case 'N':
+			fflags |= FUTEX2_NUMA;
+			if (optarg)
+				fnode = atoi(optarg);
+			break;
+		default:
+			exit(1);
+			break;
+		}
+	}
+
+	for (t = 0; t < contenders; t++) {
+		struct thread_args *args = calloc(1, sizeof(*args));
+		if (!args) {
+			perror("thread_args");
+			exit(-1);
+		}
+
+		args->done = &done;
+		args->lock = &lock;
+		args->val1 = &val1;
+		args->val2 = &val2;
+		args->node = -1;
+
+		if (pthread_create(&args->tid, NULL, contendfn, args)) {
+			perror("pthread_create");
+			exit(-1);
+		}
+
+		cas[t] = args;
+	}
+
+	for (t = 0; t < threads; t++) {
+		struct thread_args *args = calloc(1, sizeof(*args));
+		if (!args) {
+			perror("thread_args");
+			exit(-1);
+		}
+
+		args->done = &done;
+		args->lock = &lock;
+		args->val1 = &val1;
+		args->val2 = &val2;
+		args->node = -1;
+
+		if (pthread_create(&args->tid, NULL, threadfn, args)) {
+			perror("pthread_create");
+			exit(-1);
+		}
+
+		tas[t] = args;
+	}
+
+	sleep(sleeps);
+
+	done = true;
+
+	for (t = 0; t < threads; t++) {
+		struct thread_args *args = tas[t];
+
+		pthread_join(args->tid, NULL);
+		total += args->val;
+//		printf("tval: %d\n", args->val);
+	}
+	printf("total: %d\n", total);
+
+	if (contenders) {
+		total = 0;
+		for (t = 0; t < contenders; t++) {
+			struct thread_args *args = cas[t];
+
+			pthread_join(args->tid, NULL);
+			total += args->val;
+			//		printf("tval: %d\n", args->val);
+		}
+		printf("contenders: %d\n", total);
+	}
+
+	return 0;
+}
+



