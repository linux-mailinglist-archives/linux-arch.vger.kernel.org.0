Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534F37ABAC2
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 22:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjIVU7y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 16:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjIVU7x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 16:59:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B151A1;
        Fri, 22 Sep 2023 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=m5eUhTj4OMdhGrZCCmAgS0fprpsPOZ8qVsmY+pLiWtU=; b=DCD6izECXSbSHvAInV6KQTFrIm
        AM42jx2fn31pHdWtIwgBg7UYPun61VPp7UZmrCy0O+wtnJgcLfiXyzMLfRpoWnTWzpJVGQJ8jo7J5
        bFtxuDcm4+py1iQQAF3vZol/m5JSW+wtkIYwBQUnx+DP6uHi6VjF8Qs8bA0HREM7IAbga7BkRcJ8z
        l7kAiGcSdKDyHIkEYK9JgiGqtRuvl75DEd2RCLmo9ym5K2osMT3RX8p5NMe8f3cwH2RuRKq4O4KF/
        uVS4O05DZT1B9tQivLWaNkuXz1fPyb4mCZcQheDnfTNDElGcU3IAvwCoLKAF9ShDt8Wk2e9MO5frF
        4ixJusiA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjnEs-00GXzB-2v;
        Fri, 22 Sep 2023 20:59:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id EC2F03005AA; Fri, 22 Sep 2023 22:59:03 +0200 (CEST)
Message-Id: <20230922205449.923636292@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 22 Sep 2023 22:01:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, steve.shaw@intel.com,
        marko.makela@mariadb.com, andrei.artemev@intel.com
Subject: [PATCH 16/15] futex,selftests: Extend the futex selftests for NUMA
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230922200120.011184118@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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
+//			printf("tval: %d\n", args->val);
+		}
+		printf("contenders: %d\n", total);
+	}
+
+	return 0;
+}
+


