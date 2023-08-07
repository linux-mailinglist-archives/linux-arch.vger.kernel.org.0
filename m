Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE447772443
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjHGMh1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 08:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHGMhU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 08:37:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E672C10F1;
        Mon,  7 Aug 2023 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SuU6iwWIqVk8hwlYVFfKmnnvnAg5pfU6VmbV05Pxd1Q=; b=m2xRwbPdauLk+2EhPGclMbKjy4
        puYrQxvHgAAcp8hr85eED1DkcDdAE1lTN+A9fOqaeHl7t91bfzTj4keU7QiHhvPu6cu+PaHynO18U
        5NMwW4Fibt+7Smho22DvCQKeff8yfU9m5InsACn4bTC9Etg6YvAwWARYiEfacxUKtUBUQgVbHB8N/
        MUs1C1j3YXJblu64z/VmATgpiUYp0ssn4A/94t/YUT2TKBz9fAwXXGueK2nnZcgropnAYPYkwarEc
        t5ifoZn181/WXgf7EAM8oXTHzZj9PPrrotk+1oBKlSZcuSPhqw2uJh6MrFb0kuUXqd/kzcdZD8v6y
        +yk4Q2YA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qSzTl-00AxGM-HJ; Mon, 07 Aug 2023 12:36:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A1283061FF;
        Mon,  7 Aug 2023 14:36:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CB7C0201FFA49; Mon,  7 Aug 2023 14:36:54 +0200 (CEST)
Message-ID: <20230807123323.710299007@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:18:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: [PATCH  v2 14/14] futex,selftests: Extend the futex selftests
References: <20230807121843.710612856@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Extend the wait/requeue selftests to also cover the futex2 syscalls.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/testing/selftests/futex/functional/futex_requeue.c         |  100 +++++++++-
 tools/testing/selftests/futex/functional/futex_wait.c            |   56 ++++-
 tools/testing/selftests/futex/functional/futex_wait_timeout.c    |   14 +
 tools/testing/selftests/futex/functional/futex_wait_wouldblock.c |   28 ++
 tools/testing/selftests/futex/functional/futex_waitv.c           |   15 -
 tools/testing/selftests/futex/functional/run.sh                  |    6 
 tools/testing/selftests/futex/include/futex2test.h               |   39 +++
 7 files changed, 229 insertions(+), 29 deletions(-)

--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -7,8 +7,10 @@
 
 #include <pthread.h>
 #include <limits.h>
+#include <stdbool.h>
 #include "logging.h"
 #include "futextest.h"
+#include "futex2test.h"
 
 #define TEST_NAME "futex-requeue"
 #define timeout_ns  30000000
@@ -16,24 +18,58 @@
 
 volatile futex_t *f1;
 
+bool futex2 = 0;
+bool mixed = 0;
+
 void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
 	printf("  -c	Use color\n");
+	printf("  -n	Use futex2 interface\n");
+	printf("  -x	Use mixed size futex\n");
 	printf("  -h	Display this help message\n");
 	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
 	       VQUIET, VCRITICAL, VINFO);
 }
 
-void *waiterfn(void *arg)
+static void *waiterfn(void *arg)
 {
+	unsigned int flags = 0;
 	struct timespec to;
 
-	to.tv_sec = 0;
-	to.tv_nsec = timeout_ns;
+	if (futex2) {
+		unsigned long mask;
+
+		if (clock_gettime(CLOCK_MONOTONIC, &to)) {
+			printf("clock_gettime() failed errno %d", errno);
+			return NULL;
+		}
+
+		to.tv_nsec += timeout_ns;
+		if (to.tv_nsec >= 1000000000) {
+			to.tv_sec++;
+			to.tv_nsec -= 1000000000;
+		}
+
+		if (mixed) {
+			flags |= FUTEX2_SIZE_U16;
+			mask = (unsigned short)(~0U);
+		} else {
+			flags |= FUTEX2_SIZE_U32;
+			mask = (unsigned int)(~0U);
+		}
+
+		if (futex2_wait(f1, *f1, mask, flags,
+				&to, CLOCK_MONOTONIC))
+			printf("waiter failed errno %d\n", errno);
+	} else {
+
+		to.tv_sec = 0;
+		to.tv_nsec = timeout_ns;
 
-	if (futex_wait(f1, *f1, &to, 0))
-		printf("waiter failed errno %d\n", errno);
+		if (futex_wait(f1, *f1, &to, flags))
+			printf("waiter failed errno %d\n", errno);
+	}
 
 	return NULL;
 }
@@ -48,7 +84,7 @@ int main(int argc, char *argv[])
 
 	f1 = &_f1;
 
-	while ((c = getopt(argc, argv, "cht:v:")) != -1) {
+	while ((c = getopt(argc, argv, "xncht:v:")) != -1) {
 		switch (c) {
 		case 'c':
 			log_color(1);
@@ -59,6 +95,12 @@ int main(int argc, char *argv[])
 		case 'v':
 			log_verbosity(atoi(optarg));
 			break;
+		case 'x':
+			mixed=1;
+			/* fallthrough */
+		case 'n':
+			futex2=1;
+			break;
 		default:
 			usage(basename(argv[0]));
 			exit(1);
@@ -79,7 +121,22 @@ int main(int argc, char *argv[])
 	usleep(WAKE_WAIT_US);
 
 	info("Requeuing 1 futex from f1 to f2\n");
-	res = futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
+	if (futex2) {
+		struct futex_waitv futexes[2] = {
+			{
+				.val = 0,
+				.uaddr = (unsigned long)f1,
+				.flags = mixed ? FUTEX2_SIZE_U16 : FUTEX2_SIZE_U32,
+			},
+			{
+				.uaddr = (unsigned long)&f2,
+				.flags = FUTEX2_SIZE_U32,
+			},
+		};
+		res = futex2_requeue(futexes, 0, 0, 1);
+	} else {
+		res = futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
+	}
 	if (res != 1) {
 		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
 				      res ? errno : res,
@@ -89,7 +146,11 @@ int main(int argc, char *argv[])
 
 
 	info("Waking 1 futex at f2\n");
-	res = futex_wake(&f2, 1, 0);
+	if (futex2) {
+		res = futex2_wake(&f2, ~0U, 1, FUTEX2_SIZE_U32);
+	} else {
+		res = futex_wake(&f2, 1, 0);
+	}
 	if (res != 1) {
 		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
 				      res ? errno : res,
@@ -112,7 +173,22 @@ int main(int argc, char *argv[])
 	usleep(WAKE_WAIT_US);
 
 	info("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
-	res = futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
+	if (futex2) {
+		struct futex_waitv futexes[2] = {
+			{
+				.val = 0,
+				.uaddr = (unsigned long)f1,
+				.flags = mixed ? FUTEX2_SIZE_U16 : FUTEX2_SIZE_U32,
+			},
+			{
+				.uaddr = (unsigned long)&f2,
+				.flags = FUTEX2_SIZE_U32,
+			},
+		};
+		res = futex2_requeue(futexes, 0, 3, 7);
+	} else {
+		res = futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
+	}
 	if (res != 10) {
 		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
 				      res ? errno : res,
@@ -121,7 +197,11 @@ int main(int argc, char *argv[])
 	}
 
 	info("Waking INT_MAX futexes at f2\n");
-	res = futex_wake(&f2, INT_MAX, 0);
+	if (futex2) {
+		res = futex2_wake(&f2, ~0U, INT_MAX, FUTEX2_SIZE_U32);
+	} else {
+		res = futex_wake(&f2, INT_MAX, 0);
+	}
 	if (res != 7) {
 		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
 				      res ? errno : res,
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -9,8 +9,10 @@
 #include <sys/shm.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include <stdbool.h>
 #include "logging.h"
 #include "futextest.h"
+#include "futex2test.h"
 
 #define TEST_NAME "futex-wait"
 #define timeout_ns  30000000
@@ -19,10 +21,13 @@
 
 void *futex;
 
+bool futex2 = 0;
+
 void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
 	printf("  -c	Use color\n");
+	printf("  -n	Use futex2 interface\n");
 	printf("  -h	Display this help message\n");
 	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
 	       VQUIET, VCRITICAL, VINFO);
@@ -30,17 +35,35 @@ void usage(char *prog)
 
 static void *waiterfn(void *arg)
 {
-	struct timespec to;
 	unsigned int flags = 0;
+	struct timespec to;
 
 	if (arg)
 		flags = *((unsigned int *) arg);
 
-	to.tv_sec = 0;
-	to.tv_nsec = timeout_ns;
+	if (futex2) {
+		if (clock_gettime(CLOCK_MONOTONIC, &to)) {
+			printf("clock_gettime() failed errno %d", errno);
+			return NULL;
+		}
 
-	if (futex_wait(futex, 0, &to, flags))
-		printf("waiter failed errno %d\n", errno);
+		to.tv_nsec += timeout_ns;
+		if (to.tv_nsec >= 1000000000) {
+			to.tv_sec++;
+			to.tv_nsec -= 1000000000;
+		}
+
+		if (futex2_wait(futex, 0, ~0U, flags | FUTEX2_SIZE_U32,
+				&to, CLOCK_MONOTONIC))
+			printf("waiter failed errno %d\n", errno);
+	} else {
+
+		to.tv_sec = 0;
+		to.tv_nsec = timeout_ns;
+
+		if (futex_wait(futex, 0, &to, flags))
+			printf("waiter failed errno %d\n", errno);
+	}
 
 	return NULL;
 }
@@ -55,7 +78,7 @@ int main(int argc, char *argv[])
 
 	futex = &f_private;
 
-	while ((c = getopt(argc, argv, "cht:v:")) != -1) {
+	while ((c = getopt(argc, argv, "ncht:v:")) != -1) {
 		switch (c) {
 		case 'c':
 			log_color(1);
@@ -66,6 +89,9 @@ int main(int argc, char *argv[])
 		case 'v':
 			log_verbosity(atoi(optarg));
 			break;
+		case 'n':
+			futex2=1;
+			break;
 		default:
 			usage(basename(argv[0]));
 			exit(1);
@@ -84,7 +110,11 @@ int main(int argc, char *argv[])
 	usleep(WAKE_WAIT_US);
 
 	info("Calling private futex_wake on futex: %p\n", futex);
-	res = futex_wake(futex, 1, FUTEX_PRIVATE_FLAG);
+	if (futex2) {
+		res = futex2_wake(futex, ~0U, 1, FUTEX2_SIZE_U32 | FUTEX2_PRIVATE);
+	} else {
+		res = futex_wake(futex, 1, FUTEX_PRIVATE_FLAG);
+	}
 	if (res != 1) {
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      errno, strerror(errno));
@@ -112,7 +142,11 @@ int main(int argc, char *argv[])
 	usleep(WAKE_WAIT_US);
 
 	info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
-	res = futex_wake(futex, 1, 0);
+	if (futex2) {
+		res = futex2_wake(futex, ~0U, 1, FUTEX2_SIZE_U32);
+	} else {
+		res = futex_wake(futex, 1, 0);
+	}
 	if (res != 1) {
 		ksft_test_result_fail("futex_wake shared (page anon) returned: %d %s\n",
 				      errno, strerror(errno));
@@ -151,7 +185,11 @@ int main(int argc, char *argv[])
 	usleep(WAKE_WAIT_US);
 
 	info("Calling shared (file backed) futex_wake on futex: %p\n", futex);
-	res = futex_wake(shm, 1, 0);
+	if (futex2) {
+		res = futex2_wake(shm, ~0U, 1, FUTEX2_SIZE_U32);
+	} else {
+		res = futex_wake(shm, 1, 0);
+	}
 	if (res != 1) {
 		ksft_test_result_fail("futex_wake shared (file backed) returned: %d %s\n",
 				      errno, strerror(errno));
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -125,7 +125,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(9);
+	ksft_set_plan(11);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
@@ -194,6 +194,18 @@ int main(int argc, char *argv[])
 	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_REALTIME);
 	test_timeout(res, &ret, "futex_waitv realtime", ETIMEDOUT);
 
+	/* futex2_wait with CLOCK_MONOTONIC */
+	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex2_wait(&f1, f1, 1, FUTEX2_SIZE_U32, &to, CLOCK_MONOTONIC);
+	test_timeout(res, &ret, "futex2_wait monotonic", ETIMEDOUT);
+
+	/* futex2_wait with CLOCK_REALTIME */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex2_wait(&f1, f1, 1, FUTEX2_SIZE_U32, &to, CLOCK_REALTIME);
+	test_timeout(res, &ret, "futex2_wait realtime", ETIMEDOUT);
+
 	ksft_print_cnts();
 	return ret;
 }
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -46,7 +46,7 @@ int main(int argc, char *argv[])
 	struct futex_waitv waitv = {
 			.uaddr = (uintptr_t)&f1,
 			.val = f1+1,
-			.flags = FUTEX_32,
+			.flags = FUTEX2_SIZE_U32 | FUTEX2_PRIVATE,
 			.__reserved = 0
 		};
 
@@ -68,7 +68,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(2);
+	ksft_set_plan(3);
 	ksft_print_msg("%s: Test the unexpected futex value in FUTEX_WAIT\n",
 	       basename(argv[0]));
 
@@ -106,6 +106,30 @@ int main(int argc, char *argv[])
 		ksft_test_result_pass("futex_waitv\n");
 	}
 
+	if (clock_gettime(CLOCK_MONOTONIC, &to)) {
+		error("clock_gettime failed\n", errno);
+		return errno;
+	}
+
+	to.tv_nsec += timeout_ns;
+
+	if (to.tv_nsec >= 1000000000) {
+		to.tv_sec++;
+		to.tv_nsec -= 1000000000;
+	}
+
+	info("Calling futex2_wait on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
+	res = futex2_wait(&f1, f1+1, ~0U, FUTEX2_SIZE_U32 | FUTEX2_PRIVATE,
+			  &to, CLOCK_MONOTONIC);
+	if (!res || errno != EWOULDBLOCK) {
+		ksft_test_result_pass("futex2_wait returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_wait\n");
+	}
+
 	ksft_print_cnts();
 	return ret;
 }
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -88,7 +88,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < NR_FUTEXES; i++) {
 		waitv[i].uaddr = (uintptr_t)&futexes[i];
-		waitv[i].flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
+		waitv[i].flags = FUTEX2_SIZE_U32 | FUTEX2_PRIVATE;
 		waitv[i].val = 0;
 		waitv[i].__reserved = 0;
 	}
@@ -99,7 +99,8 @@ int main(int argc, char *argv[])
 
 	usleep(WAKE_WAIT_US);
 
-	res = futex_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), 1, FUTEX_PRIVATE_FLAG);
+	res = futex2_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), ~0U, 1,
+			  FUTEX2_PRIVATE | FUTEX2_SIZE_U32);
 	if (res != 1) {
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      res ? errno : res,
@@ -122,7 +123,7 @@ int main(int argc, char *argv[])
 
 		*shared_data = 0;
 		waitv[i].uaddr = (uintptr_t)shared_data;
-		waitv[i].flags = FUTEX_32;
+		waitv[i].flags = FUTEX2_SIZE_U32;
 		waitv[i].val = 0;
 		waitv[i].__reserved = 0;
 	}
@@ -145,8 +146,8 @@ int main(int argc, char *argv[])
 	for (i = 0; i < NR_FUTEXES; i++)
 		shmdt(u64_to_ptr(waitv[i].uaddr));
 
-	/* Testing a waiter without FUTEX_32 flag */
-	waitv[0].flags = FUTEX_PRIVATE_FLAG;
+	/* Testing a waiter without FUTEX2_SIZE_U32 flag */
+	waitv[0].flags = FUTEX2_PRIVATE;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
 		error("gettime64 failed\n", errno);
@@ -160,11 +161,11 @@ int main(int argc, char *argv[])
 				      res ? strerror(errno) : "");
 		ret = RET_FAIL;
 	} else {
-		ksft_test_result_pass("futex_waitv without FUTEX_32\n");
+		ksft_test_result_pass("futex_waitv without FUTEX2_SIZE_U32\n");
 	}
 
 	/* Testing a waiter with an unaligned address */
-	waitv[0].flags = FUTEX_PRIVATE_FLAG | FUTEX_32;
+	waitv[0].flags = FUTEX2_PRIVATE | FUTEX2_SIZE_U32;
 	waitv[0].uaddr = 1;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -76,9 +76,15 @@ echo
 
 echo
 ./futex_wait $COLOR
+echo
+./futex_wait -n $COLOR
 
 echo
 ./futex_requeue $COLOR
+echo
+./futex_requeue -n $COLOR
+echo
+./futex_requeue -x $COLOR
 
 echo
 ./futex_waitv $COLOR
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -8,6 +8,28 @@
 
 #define u64_to_ptr(x) ((void *)(uintptr_t)(x))
 
+#ifndef __NR_futex_wake
+#define __NR_futex_wake 452
+#define __NR_futex_wait 453
+#define __NR_futex_requeue 454
+#endif
+
+#ifndef FUTEX2_SIZE_U8
+/*
+ * Flags for futex2 syscalls.
+ */
+#define FUTEX2_SIZE_U8		0x00
+#define FUTEX2_SIZE_U16		0x01
+#define FUTEX2_SIZE_U32		0x02
+#define FUTEX2_SIZE_U64		0x03
+#define FUTEX2_NUMA		0x04
+			/*	0x08 */
+			/*	0x10 */
+			/*	0x20 */
+			/*	0x40 */
+#define FUTEX2_PRIVATE		FUTEX_PRIVATE_FLAG
+#endif
+
 /**
  * futex_waitv - Wait at multiple futexes, wake on any
  * @waiters:    Array of waiters
@@ -20,3 +42,20 @@ static inline int futex_waitv(volatile s
 {
 	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
 }
+
+static inline int futex2_wake(volatile void *uaddr, unsigned long mask, int nr, unsigned int flags)
+{
+	return syscall(__NR_futex_wake, uaddr, mask, nr, flags);
+}
+
+static inline int futex2_wait(volatile void *uaddr, unsigned long val, unsigned long mask,
+			      unsigned int flags, struct timespec *timo, clockid_t clockid)
+{
+	return syscall(__NR_futex_wait, uaddr, val, mask, flags, timo, clockid);
+}
+
+static inline int futex2_requeue(struct futex_waitv *futexes, unsigned int flags,
+				 int nr_wake, int nr_requeue)
+{
+	return syscall(__NR_futex_requeue, futexes, flags, nr_wake, nr_requeue);
+}


