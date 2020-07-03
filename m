Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A96E213B8C
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 16:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGCOMk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 10:12:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48331 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCOMk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 10:12:40 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49yxkD5k31z9sRf; Sat,  4 Jul 2020 00:12:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593785556;
        bh=NP1vMoWcAcgcwZZJ7iZDKAhtaSFiCcZg6bjQLr/isfg=;
        h=From:To:Cc:Subject:Date:From;
        b=g6uDLnv4PB1wG9H1Wk2mlhnrk03xAZMpXGo9Zo5pSKSg6rLzHfAkWy0k71NvMq7Ff
         kpg0GC6WHLFfec2d90/dejoFzdBgUE7aYDTA0XG+aExZXDNa+56t1rZN7HOqDdJ+0W
         J5Ag7ge3a+IXG4JMTtgtzFFaDUmAWANwLPNehlwsVXpI6OwjZ4Wr84ghLBSktzsdNK
         qYRAlNBuCBXwsw3TnV/wNuHl2c73Zjevsu186t75gKKTU7T/S+XNVMWLglAdAzLwdh
         C7MB3CLRzIxhmRPj/kb9Wl7h8vr7FwdYwV3L2dAP2Ti94xihkkI1S7LYxHAy+NfVXi
         rZQgNRt+2d1sw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com
Subject: [PATCH 1/5] selftests/powerpc: Add test of stack expansion logic
Date:   Sat,  4 Jul 2020 00:13:23 +1000
Message-Id: <20200703141327.1732550-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We have custom stack expansion checks that it turns out are extremely
badly tested and contain bugs, surprise. So add some tests that
exercise the code and capture the current boundary conditions.

The signal test currently fails on 64-bit kernels because the 2048
byte allowance for the signal frame is too small, we will fix that in
a subsequent patch.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/mm/.gitignore |   2 +
 tools/testing/selftests/powerpc/mm/Makefile   |   8 +-
 .../powerpc/mm/stack_expansion_ldst.c         | 233 ++++++++++++++++++
 .../powerpc/mm/stack_expansion_signal.c       | 114 +++++++++
 tools/testing/selftests/powerpc/pmu/lib.h     |   1 +
 5 files changed, 357 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
 create mode 100644 tools/testing/selftests/powerpc/mm/stack_expansion_signal.c

diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
index 2ca523255b1b..8bfa3b39f628 100644
--- a/tools/testing/selftests/powerpc/mm/.gitignore
+++ b/tools/testing/selftests/powerpc/mm/.gitignore
@@ -8,3 +8,5 @@ wild_bctr
 large_vm_fork_separation
 bad_accesses
 tlbie_test
+stack_expansion_ldst
+stack_expansion_signal
diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index b9103c4bb414..3937b277c288 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -3,7 +3,8 @@
 	$(MAKE) -C ../
 
 TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors wild_bctr \
-		  large_vm_fork_separation bad_accesses
+		  large_vm_fork_separation bad_accesses stack_expansion_signal \
+		  stack_expansion_ldst
 TEST_GEN_PROGS_EXTENDED := tlbie_test
 TEST_GEN_FILES := tempfile
 
@@ -18,6 +19,11 @@ $(OUTPUT)/wild_bctr: CFLAGS += -m64
 $(OUTPUT)/large_vm_fork_separation: CFLAGS += -m64
 $(OUTPUT)/bad_accesses: CFLAGS += -m64
 
+$(OUTPUT)/stack_expansion_signal: ../utils.c ../pmu/lib.c
+
+$(OUTPUT)/stack_expansion_ldst: CFLAGS += -fno-stack-protector
+$(OUTPUT)/stack_expansion_ldst: ../utils.c
+
 $(OUTPUT)/tempfile:
 	dd if=/dev/zero of=$@ bs=64k count=1
 
diff --git a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
new file mode 100644
index 000000000000..0587e11437f5
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that loads/stores expand the stack segment, or trigger a SEGV, in
+ * various conditions.
+ *
+ * Based on test code by Tom Lane.
+ */
+
+#undef NDEBUG
+#include <assert.h>
+
+#include <err.h>
+#include <errno.h>
+#include <stdio.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#define _KB (1024)
+#define _MB (1024 * 1024)
+
+volatile char *stack_top_ptr;
+volatile unsigned long stack_top_sp;
+volatile char c;
+
+enum access_type {
+	LOAD,
+	STORE,
+};
+
+/*
+ * Consume stack until the stack pointer is below @target_sp, then do an access
+ * (load or store) at offset @delta from either the base of the stack or the
+ * current stack pointer.
+ */
+__attribute__ ((noinline))
+int consume_stack(unsigned long target_sp, unsigned long stack_high, int delta, enum access_type type)
+{
+	unsigned long target;
+	char stack_cur;
+
+	if ((unsigned long)&stack_cur > target_sp)
+		return consume_stack(target_sp, stack_high, delta, type);
+	else {
+		// We don't really need this, but without it GCC might not
+		// generate a recursive call above.
+		stack_top_ptr = &stack_cur;
+
+#ifdef __powerpc__
+		asm volatile ("mr %[sp], %%r1" : [sp] "=r" (stack_top_sp));
+#else
+		asm volatile ("mov %%rsp, %[sp]" : [sp] "=r" (stack_top_sp));
+#endif
+
+		// Kludge, delta < 0 indicates relative to SP
+		if (delta < 0)
+			target = stack_top_sp + delta;
+		else
+			target = stack_high - delta + 1;
+
+		volatile char *p = (char *)target;
+
+		if (type == STORE)
+			*p = c;
+		else
+			c = *p;
+
+		// Do something to prevent the stack frame being popped prior to
+		// our access above.
+		getpid();
+	}
+
+	return 0;
+}
+
+static int search_proc_maps(char *needle, unsigned long *low, unsigned long *high)
+{
+	unsigned long start, end;
+	static char buf[4096];
+	char name[128];
+	FILE *f;
+	int rc;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f) {
+		perror("fopen");
+		return -1;
+	}
+
+	while (fgets(buf, sizeof(buf), f)) {
+		rc = sscanf(buf, "%lx-%lx %*c%*c%*c%*c %*x %*d:%*d %*d %127s\n",
+			    &start, &end, name);
+		if (rc == 2)
+			continue;
+
+		if (rc != 3) {
+			printf("sscanf errored\n");
+			rc = -1;
+			break;
+		}
+
+		if (strstr(name, needle)) {
+			*low = start;
+			*high = end - 1;
+			rc = 0;
+			break;
+		}
+	}
+
+	fclose(f);
+
+	return rc;
+}
+
+int child(unsigned int stack_used, int delta, enum access_type type)
+{
+	unsigned long low, stack_high;
+
+	assert(search_proc_maps("[stack]", &low, &stack_high) == 0);
+
+	assert(consume_stack(stack_high - stack_used, stack_high, delta, type) == 0);
+
+	printf("Access OK: %s delta %-7d used size 0x%06x stack high 0x%lx top_ptr %p top sp 0x%lx actual used 0x%lx\n",
+	       type == LOAD ? "load" : "store", delta, stack_used, stack_high,
+	       stack_top_ptr, stack_top_sp, stack_high - stack_top_sp + 1);
+
+	return 0;
+}
+
+static int test_one(unsigned int stack_used, int delta, enum access_type type)
+{
+	pid_t pid;
+	int rc;
+
+	pid = fork();
+	if (pid == 0)
+		exit(child(stack_used, delta, type));
+
+	assert(waitpid(pid, &rc, 0) != -1);
+
+	if (WIFEXITED(rc) && WEXITSTATUS(rc) == 0)
+		return 0;
+
+	// We don't expect a non-zero exit that's not a signal
+	assert(!WIFEXITED(rc));
+
+	printf("Faulted:   %s delta %-7d used size 0x%06x signal %d\n",
+	       type == LOAD ? "load" : "store", delta, stack_used,
+	       WTERMSIG(rc));
+
+	return 1;
+}
+
+// This is fairly arbitrary but is well below any of the targets below,
+// so that the delta between the stack pointer and the target is large.
+#define DEFAULT_SIZE	(32 * _KB)
+
+static void test_one_type(enum access_type type, unsigned long page_size, unsigned long rlim_cur)
+{
+	assert(test_one(DEFAULT_SIZE, 512 * _KB, type) == 0);
+
+	// powerpc has a special case to allow up to 1MB
+	assert(test_one(DEFAULT_SIZE, 1 * _MB, type) == 0);
+
+#ifdef __powerpc__
+	// This fails on powerpc because it's > 1MB and is not a stdu &
+	// not close to r1
+	assert(test_one(DEFAULT_SIZE, 1 * _MB + 8, type) != 0);
+#else
+	assert(test_one(DEFAULT_SIZE, 1 * _MB + 8, type) == 0);
+#endif
+
+#ifdef __powerpc__
+	// Accessing way past the stack pointer is not allowed on powerpc
+	assert(test_one(DEFAULT_SIZE, rlim_cur, type) != 0);
+#else
+	// We should be able to access anywhere within the rlimit
+	assert(test_one(DEFAULT_SIZE, rlim_cur, type) == 0);
+#endif
+
+	// But if we go past the rlimit it should fail
+	assert(test_one(DEFAULT_SIZE, rlim_cur + 1, type) != 0);
+
+	// Above 1MB powerpc only allows accesses within 2048 bytes of
+	// r1 for accesses that aren't stdu
+	assert(test_one(1 * _MB + page_size - 128, -2048, type) == 0);
+#ifdef __powerpc__
+	assert(test_one(1 * _MB + page_size - 128, -2049, type) != 0);
+#else
+	assert(test_one(1 * _MB + page_size - 128, -2049, type) == 0);
+#endif
+
+	// By consuming 2MB of stack we test the stdu case
+	assert(test_one(2 * _MB + page_size - 128, -2048, type) == 0);
+}
+
+static int test(void)
+{
+	unsigned long page_size;
+	struct rlimit rlimit;
+
+	page_size = getpagesize();
+	getrlimit(RLIMIT_STACK, &rlimit);
+	printf("Stack rlimit is 0x%lx\n", rlimit.rlim_cur);
+
+	printf("Testing loads ...\n");
+	test_one_type(LOAD, page_size, rlimit.rlim_cur);
+	printf("Testing stores ...\n");
+	test_one_type(STORE, page_size, rlimit.rlim_cur);
+
+	printf("All OK\n");
+
+	return 0;
+}
+
+#ifdef __powerpc__
+#include "utils.h"
+
+int main(void)
+{
+	return test_harness(test, "stack_expansion_ldst");
+}
+#else
+int main(void)
+{
+	return test();
+}
+#endif
diff --git a/tools/testing/selftests/powerpc/mm/stack_expansion_signal.c b/tools/testing/selftests/powerpc/mm/stack_expansion_signal.c
new file mode 100644
index 000000000000..0632deb00679
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/stack_expansion_signal.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that signal delivery is able to expand the stack segment without
+ * triggering a SEGV.
+ *
+ * Based on test code by Tom Lane.
+ */
+
+#include <err.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "../pmu/lib.h"
+#include "utils.h"
+
+#define _KB (1024)
+#define _MB (1024 * 1024)
+
+static char *stack_base_ptr;
+static char *stack_top_ptr;
+
+static volatile sig_atomic_t sig_occurred = 0;
+
+static void sigusr1_handler(int signal_arg)
+{
+	sig_occurred = 1;
+}
+
+static int consume_stack(unsigned int stack_size, union pipe write_pipe)
+{
+	char stack_cur;
+
+	if ((stack_base_ptr - &stack_cur) < stack_size)
+		return consume_stack(stack_size, write_pipe);
+	else {
+		stack_top_ptr = &stack_cur;
+
+		FAIL_IF(notify_parent(write_pipe));
+
+		while (!sig_occurred)
+			barrier();
+	}
+
+	return 0;
+}
+
+static int child(unsigned int stack_size, union pipe write_pipe)
+{
+	struct sigaction act;
+	char stack_base;
+
+	act.sa_handler = sigusr1_handler;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags = 0;
+	if (sigaction(SIGUSR1, &act, NULL) < 0)
+		err(1, "sigaction");
+
+	stack_base_ptr = (char *) (((size_t) &stack_base + 65535) & ~65535UL);
+
+	FAIL_IF(consume_stack(stack_size, write_pipe));
+
+	printf("size 0x%06x: OK, stack base %p top %p (%zx used)\n",
+		stack_size, stack_base_ptr, stack_top_ptr,
+		stack_base_ptr - stack_top_ptr);
+
+	return 0;
+}
+
+static int test_one_size(unsigned int stack_size)
+{
+	union pipe read_pipe, write_pipe;
+	pid_t pid;
+
+	FAIL_IF(pipe(read_pipe.fds) == -1);
+	FAIL_IF(pipe(write_pipe.fds) == -1);
+
+	pid = fork();
+	if (pid == 0) {
+		close(read_pipe.read_fd);
+		close(write_pipe.write_fd);
+		exit(child(stack_size, read_pipe));
+	}
+
+	close(read_pipe.write_fd);
+	close(write_pipe.read_fd);
+	FAIL_IF(sync_with_child(read_pipe, write_pipe));
+
+	kill(pid, SIGUSR1);
+
+	FAIL_IF(wait_for_child(pid));
+
+	close(read_pipe.read_fd);
+	close(write_pipe.write_fd);
+
+	return 0;
+}
+
+int test(void)
+{
+	unsigned int size;
+
+	for (size = (512 * _KB); size < (3 * _MB); size += (4 * _KB))
+		FAIL_IF(test_one_size(size));
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test, "stack_expansion_signal");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/lib.h b/tools/testing/selftests/powerpc/pmu/lib.h
index fa12e7d0b4d3..bf1bec013bbb 100644
--- a/tools/testing/selftests/powerpc/pmu/lib.h
+++ b/tools/testing/selftests/powerpc/pmu/lib.h
@@ -6,6 +6,7 @@
 #ifndef __SELFTESTS_POWERPC_PMU_LIB_H
 #define __SELFTESTS_POWERPC_PMU_LIB_H
 
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdint.h>
 #include <string.h>
-- 
2.25.1

