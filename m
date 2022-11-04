Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D5161A4B6
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiKDWpe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKDWow (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:44:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F055B69DCE;
        Fri,  4 Nov 2022 15:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601647; x=1699137647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2bikX3W+wHwtlfkK+PPS8dtSt6AtvNxDtjkqyPE4gcw=;
  b=mMIlrtIWMWsFISx/9MJZRoeVdDGAfZdnelPsCOJZvTkSsv2mSOHNZzns
   ZahLQMKNWQ+gNwKT8+JjhYkZOMdx7ieJy61lc0mqiIAqM3wRnme/W38sf
   uE79542rL/tT051S21+Ij6uIRikPl++x7sssA79+9J0oZKWECpPgnEqvL
   60x+4ArB4NqZom1py1RE2yUeBMNSR07Tud8qaB8Qj14XsRpkx6rHflaol
   u46MlKuAxOj8pgtf6aKe1jiq6rBMioCEg3WmjNsLPRd1SbI2i+keZgnDe
   NBt8fvHdrFK7u9+FDdMzzKOwgkmI7FiqKgYaomXOxKbwqHty5ypvPwI/R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840614"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840614"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514154"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514154"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:51 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 33/37] selftests/x86: Add shadow stack test
Date:   Fri,  4 Nov 2022 15:36:00 -0700
Message-Id: <20221104223604.29615-34-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a simple selftest for exercising some shadow stack behavior:
 - map_shadow_stack syscall and pivot
 - Faulting in shadow stack memory
 - Handling shadow stack violations
 - GUP of shadow stack memory
 - mprotect() of shadow stack memory
 - Userfaultfd on shadow stack memory

Since this test exercises a recently added syscall manually, it needs
to find the automatically created __NR_foo defines. Per the selftest
documentation, KHDR_INCLUDES can be used to help the selftest Makefile's
find the headers from the kernel source. This way the new selftest can
be built inside the kernel source tree without installing the headers
to the system. So also add KHDR_INCLUDES as described in the selftest
docs, to facilitate this.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v3:
 - Change "+m" to "=m" in write_shstk() (Andrew Cooper)
 - Fix userfaultfd test with transparent huge pages by doing a
   MADV_DONTNEED, since the token write faults in the while stack with
   huge pages.

v2:
 - Change print statements to more align with other selftests
 - Add more tests
 - Add KHDR_INCLUDES to Makefile

v1:
 - New patch.

 tools/testing/selftests/x86/Makefile          |   4 +-
 .../testing/selftests/x86/test_shadow_stack.c | 574 ++++++++++++++++++
 2 files changed, 576 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0388c4d60af0..cfc8a26ad151 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx
+			corrupt_xstate_header amx test_shadow_stack
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -34,7 +34,7 @@ BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
-CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
+CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
 
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
new file mode 100644
index 000000000000..b347447da317
--- /dev/null
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This program test's basic kernel shadow stack support. It enables shadow
+ * stack manual via the arch_prctl(), instead of relying on glibc. It's
+ * Makefile doesn't compile with shadow stack support, so it doesn't rely on
+ * any particular glibc. As a result it can't do any operations that require
+ * special glibc shadow stack support (longjmp(), swapcontext(), etc). Just
+ * stick to the basics and hope the compiler doesn't do anything strange.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/syscall.h>
+#include <asm/mman.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <x86intrin.h>
+#include <asm/prctl.h>
+#include <sys/prctl.h>
+#include <stdint.h>
+#include <signal.h>
+#include <pthread.h>
+#include <sys/ioctl.h>
+#include <linux/userfaultfd.h>
+
+#define SS_SIZE 0x200000
+
+#if (__GNUC__ < 8) || (__GNUC__ == 8 && __GNUC_MINOR__ < 5)
+int main(int argc, char *argv[])
+{
+	printf("[SKIP]\tCompiler does not support CET.\n");
+	return 0;
+}
+#else
+void write_shstk(unsigned long *addr, unsigned long val)
+{
+	asm volatile("wrssq %[val], (%[addr])\n"
+		     : "=m" (addr)
+		     : [addr] "r" (addr), [val] "r" (val));
+}
+
+static inline unsigned long __attribute__((always_inline)) get_ssp(void)
+{
+	unsigned long ret = 0;
+
+	asm volatile("xor %0, %0; rdsspq %0" : "=r" (ret));
+	return ret;
+}
+
+/*
+ * For use in inline enablement of shadow stack.
+ *
+ * The program can't return from the point where shadow stack get's enabled
+ * because there will be no address on the shadow stack. So it can't use
+ * syscall() for enablement, since it is a function.
+ *
+ * Based on code from nolibc.h. Keep a copy here because this can't pull in all
+ * of nolibc.h.
+ */
+#define ARCH_PRCTL(arg1, arg2)					\
+({								\
+	long _ret;						\
+	register long _num  asm("eax") = __NR_arch_prctl;	\
+	register long _arg1 asm("rdi") = (long)(arg1);		\
+	register long _arg2 asm("rsi") = (long)(arg2);		\
+								\
+	asm volatile (						\
+		"syscall\n"					\
+		: "=a"(_ret)					\
+		: "r"(_arg1), "r"(_arg2),			\
+		  "0"(_num)					\
+		: "rcx", "r11", "memory", "cc"			\
+	);							\
+	_ret;							\
+})
+
+void *create_shstk(void *addr)
+{
+	return (void *)syscall(__NR_map_shadow_stack, addr, SS_SIZE, SHADOW_STACK_SET_TOKEN);
+}
+
+void *create_normal_mem(void *addr)
+{
+	return mmap(addr, SS_SIZE, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+}
+
+void free_shstk(void *shstk)
+{
+	munmap(shstk, SS_SIZE);
+}
+
+int reset_shstk(void *shstk)
+{
+	return madvise(shstk, SS_SIZE, MADV_DONTNEED);
+}
+
+void try_shstk(unsigned long new_ssp)
+{
+	unsigned long ssp;
+
+	printf("[INFO]\tnew_ssp = %lx, *new_ssp = %lx\n",
+		new_ssp, *((unsigned long *)new_ssp));
+
+	ssp = get_ssp();
+	printf("[INFO]\tchanging ssp from %lx to %lx\n", ssp, new_ssp);
+
+	asm volatile("rstorssp (%0)\n":: "r" (new_ssp));
+	asm volatile("saveprevssp");
+	printf("[INFO]\tssp is now %lx\n", get_ssp());
+
+	/* Switch back to original shadow stack */
+	ssp -= 8;
+	asm volatile("rstorssp (%0)\n":: "r" (ssp));
+	asm volatile("saveprevssp");
+}
+
+int test_shstk_pivot(void)
+{
+	void *shstk = create_shstk(0);
+
+	if (shstk == MAP_FAILED) {
+		printf("[FAIL]\tError creating shadow stack: %d\n", errno);
+		return 1;
+	}
+	try_shstk((unsigned long)shstk + SS_SIZE - 8);
+	free_shstk(shstk);
+
+	printf("[OK]\tShadow stack pivot\n");
+	return 0;
+}
+
+int test_shstk_faults(void)
+{
+	unsigned long *shstk = create_shstk(0);
+
+	/* Read shadow stack, test if it's zero to not get read optimized out */
+	if (*shstk != 0)
+		goto err;
+
+	/* Wrss memory that was already read. */
+	write_shstk(shstk, 1);
+	if (*shstk != 1)
+		goto err;
+
+	/* Page out memory, so we can wrss it again. */
+	if (reset_shstk((void *)shstk))
+		goto err;
+
+	write_shstk(shstk, 1);
+	if (*shstk != 1)
+		goto err;
+
+	printf("[OK]\tShadow stack faults\n");
+	return 0;
+
+err:
+	return 1;
+}
+
+unsigned long saved_ssp;
+unsigned long saved_ssp_val;
+volatile bool segv_triggered;
+
+void __attribute__((noinline)) violate_ss(void)
+{
+	saved_ssp = get_ssp();
+	saved_ssp_val = *(unsigned long *)saved_ssp;
+
+	/* Corrupt shadow stack */
+	printf("[INFO]\tCorrupting shadow stack\n");
+	write_shstk((void *)saved_ssp, 0);
+}
+
+void segv_handler(int signum, siginfo_t *si, void *uc)
+{
+	printf("[INFO]\tGenerated shadow stack violation successfully\n");
+
+	segv_triggered = true;
+
+	/* Fix shadow stack */
+	write_shstk((void *)saved_ssp, saved_ssp_val);
+}
+
+int test_shstk_violation(void)
+{
+	struct sigaction sa;
+
+	sa.sa_sigaction = segv_handler;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+	sa.sa_flags = SA_SIGINFO;
+
+	segv_triggered = false;
+
+	/* Make sure segv_triggered is set before violate_ss() */
+	asm volatile("" : : : "memory");
+
+	violate_ss();
+
+	signal(SIGSEGV, SIG_DFL);
+
+	printf("[OK]\tShadow stack violation test\n");
+
+	return !segv_triggered;
+}
+
+/* Gup test state */
+#define MAGIC_VAL 0x12345678
+bool is_shstk_access;
+void *shstk_ptr;
+int fd;
+
+void reset_test_shstk(void *addr)
+{
+	if (shstk_ptr != NULL)
+		free_shstk(shstk_ptr);
+	shstk_ptr = create_shstk(addr);
+}
+
+void test_access_fix_handler(int signum, siginfo_t *si, void *uc)
+{
+	printf("[INFO]\tViolation from %s\n", is_shstk_access ? "shstk access" : "normal write");
+
+	segv_triggered = true;
+
+	/* Fix shadow stack */
+	if (is_shstk_access) {
+		reset_test_shstk(shstk_ptr);
+		return;
+	}
+
+	free_shstk(shstk_ptr);
+	create_normal_mem(shstk_ptr);
+}
+
+bool test_shstk_access(void *ptr)
+{
+	is_shstk_access = true;
+	segv_triggered = false;
+	write_shstk(ptr, MAGIC_VAL);
+
+	asm volatile("" : : : "memory");
+
+	return segv_triggered;
+}
+
+bool test_write_access(void *ptr)
+{
+	is_shstk_access = false;
+	segv_triggered = false;
+	*(unsigned long *)ptr = MAGIC_VAL;
+
+	asm volatile("" : : : "memory");
+
+	return segv_triggered;
+}
+
+bool gup_write(void *ptr)
+{
+	unsigned long val;
+
+	lseek(fd, (unsigned long)ptr, SEEK_SET);
+	if (write(fd, &val, sizeof(val)) < 0)
+		return 1;
+
+	return 0;
+}
+
+bool gup_read(void *ptr)
+{
+	unsigned long val;
+
+	lseek(fd, (unsigned long)ptr, SEEK_SET);
+	if (read(fd, &val, sizeof(val)) < 0)
+		return 1;
+
+	return 0;
+}
+
+int test_gup(void)
+{
+	struct sigaction sa;
+	int status;
+	pid_t pid;
+
+	sa.sa_sigaction = test_access_fix_handler;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+	sa.sa_flags = SA_SIGINFO;
+
+	segv_triggered = false;
+
+	fd = open("/proc/self/mem", O_RDWR);
+	if (fd == -1)
+		return 1;
+
+	reset_test_shstk(0);
+	if (gup_read(shstk_ptr))
+		return 1;
+	if (test_shstk_access(shstk_ptr))
+		return 1;
+	printf("[INFO]\tGup read -> shstk access success\n");
+
+	reset_test_shstk(0);
+	if (gup_write(shstk_ptr))
+		return 1;
+	if (test_shstk_access(shstk_ptr))
+		return 1;
+	printf("[INFO]\tGup write -> shstk access success\n");
+
+	reset_test_shstk(0);
+	if (gup_read(shstk_ptr))
+		return 1;
+	if (!test_write_access(shstk_ptr))
+		return 1;
+	printf("[INFO]\tGup read -> write access success\n");
+
+	reset_test_shstk(0);
+	if (gup_write(shstk_ptr))
+		return 1;
+	if (!test_write_access(shstk_ptr))
+		return 1;
+	printf("[INFO]\tGup write -> write access success\n");
+
+	close(fd);
+
+	/* COW/gup test */
+	reset_test_shstk(0);
+	pid = fork();
+	if (!pid) {
+		fd = open("/proc/self/mem", O_RDWR);
+		if (fd == -1)
+			exit(1);
+
+		if (gup_write(shstk_ptr)) {
+			close(fd);
+			exit(1);
+		}
+		close(fd);
+		exit(0);
+	}
+	waitpid(pid, &status, 0);
+	if (WEXITSTATUS(status)) {
+		printf("[FAIL]\tWrite in child failed\n");
+		return 1;
+	}
+	if (*(unsigned long *)shstk_ptr == MAGIC_VAL) {
+		printf("[FAIL]\tWrite in child wrote through to shared memory\n");
+		return 1;
+	}
+
+	printf("[INFO]\tCow gup write -> write access success\n");
+
+	free_shstk(shstk_ptr);
+
+	signal(SIGSEGV, SIG_DFL);
+
+	printf("[OK]\tShadow gup test\n");
+
+	return 0;
+}
+
+int test_mprotect(void)
+{
+	struct sigaction sa;
+
+	sa.sa_sigaction = test_access_fix_handler;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+	sa.sa_flags = SA_SIGINFO;
+
+	segv_triggered = false;
+
+	/* mprotect a shaodw stack as read only */
+	reset_test_shstk(0);
+	if (mprotect(shstk_ptr, SS_SIZE, PROT_READ) < 0) {
+		printf("[FAIL]\tmprotect(PROT_READ) failed\n");
+		return 1;
+	}
+
+	/* try to wrss it and fail */
+	if (!test_shstk_access(shstk_ptr)) {
+		printf("[FAIL]\tShadow stack access to read-only memory succeeded\n");
+		return 1;
+	}
+
+	/* then back to writable */
+	if (mprotect(shstk_ptr, SS_SIZE, PROT_WRITE | PROT_READ) < 0) {
+		printf("[FAIL]\tmprotect(PROT_WRITE) failed\n");
+		return 1;
+	}
+
+	/* then pivot to it and succeed */
+	if (test_shstk_access(shstk_ptr)) {
+		printf("[FAIL]\tShadow stack access to mprotect() writable memory failed\n");
+		return 1;
+	}
+
+	free_shstk(shstk_ptr);
+
+	signal(SIGSEGV, SIG_DFL);
+
+	printf("[OK]\tmprotect() test\n");
+
+	return 0;
+}
+
+char zero[4096];
+
+static void *uffd_thread(void *arg)
+{
+	struct uffdio_copy req;
+	int uffd = *(int *)arg;
+	struct uffd_msg msg;
+
+	if (read(uffd, &msg, sizeof(msg)) <= 0)
+		return (void *)1;
+
+	req.dst = msg.arg.pagefault.address;
+	req.src = (__u64)zero;
+	req.len = 4096;
+	req.mode = 0;
+
+	if (ioctl(uffd, UFFDIO_COPY, &req))
+		return (void *)1;
+
+	return (void *)0;
+}
+
+int test_userfaultfd(void)
+{
+	struct uffdio_register uffdio_register;
+	struct uffdio_api uffdio_api;
+	struct sigaction sa;
+	pthread_t thread;
+	void *res;
+	int uffd;
+
+	sa.sa_sigaction = test_access_fix_handler;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+	sa.sa_flags = SA_SIGINFO;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0) {
+		printf("[SKIP]\tUserfaultfd unavailable.\n");
+		return 0;
+	}
+
+	reset_test_shstk(0);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
+		goto err;
+
+	uffdio_register.range.start = (__u64)shstk_ptr;
+	uffdio_register.range.len = 4096;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+		goto err;
+
+	if (pthread_create(&thread, NULL, &uffd_thread, &uffd))
+		goto err;
+
+	reset_shstk(shstk_ptr);
+	test_shstk_access(shstk_ptr);
+
+	if (pthread_join(thread, &res))
+		goto err;
+
+	if (test_shstk_access(shstk_ptr))
+		goto err;
+
+	free_shstk(shstk_ptr);
+
+	signal(SIGSEGV, SIG_DFL);
+
+	if (!res)
+		printf("[OK]\tUserfaultfd test\n");
+	return !!res;
+err:
+	free_shstk(shstk_ptr);
+	close(uffd);
+	signal(SIGSEGV, SIG_DFL);
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+
+	if (ARCH_PRCTL(ARCH_CET_ENABLE, CET_SHSTK)) {
+		printf("[SKIP]\tCould not enable Shadow stack\n");
+		return 1;
+	}
+
+	if (ARCH_PRCTL(ARCH_CET_DISABLE, CET_SHSTK)) {
+		ret = 1;
+		printf("[FAIL]\tDisabling shadow stack failed\n");
+	}
+
+	if (ARCH_PRCTL(ARCH_CET_ENABLE, CET_SHSTK)) {
+		printf("[SKIP]\tCould not re-enable Shadow stack\n");
+		return 1;
+	}
+
+	if (ARCH_PRCTL(ARCH_CET_ENABLE, CET_WRSS)) {
+		printf("[SKIP]\tCould not enable WRSS\n");
+		ret = 1;
+		goto out;
+	}
+
+	/* Should have succeeded if here, but this is a test, so double check. */
+	if (!get_ssp()) {
+		printf("[FAIL]\tShadow stack disabled\n");
+		return 1;
+	}
+
+	if (test_shstk_pivot()) {
+		ret = 1;
+		printf("[FAIL]\tShadow stack pivot\n");
+		goto out;
+	}
+
+	if (test_shstk_faults()) {
+		ret = 1;
+		printf("[FAIL]\tShadow stack fault test\n");
+		goto out;
+	}
+
+	if (test_shstk_violation()) {
+		ret = 1;
+		printf("[FAIL]\tShadow stack violation test\n");
+		goto out;
+	}
+
+	if (test_gup()) {
+		ret = 1;
+		printf("[FAIL]\tShadow shadow stack gup\n");
+	}
+
+	if (test_mprotect()) {
+		ret = 1;
+		printf("[FAIL]\tShadow shadow mprotect test\n");
+	}
+
+	if (test_userfaultfd()) {
+		ret = 1;
+		printf("[FAIL]\tUserfaultfd test\n");
+	}
+
+out:
+	/*
+	 * Disable shadow stack before the function returns, or there will be a
+	 * shadow stack violation.
+	 */
+	if (ARCH_PRCTL(ARCH_CET_DISABLE, CET_SHSTK)) {
+		ret = 1;
+		printf("[FAIL]\tDisabling shadow stack failed\n");
+	}
+
+	return ret;
+}
+#endif
-- 
2.17.1

