Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E0F2F8766
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 22:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbhAOVQs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:16:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:45764 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbhAOVQs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Jan 2021 16:16:48 -0500
IronPort-SDR: r5ipUybHlY3EcMBvelk83ESCGpfwhlp5fwAmgg7suYc/zhbDAZgqFOzlWeguuSf82bI6Noifi+
 YYInTmu1GFTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="166277110"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="166277110"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 13:15:15 -0800
IronPort-SDR: 40vyABUWaWhyy4NQfmGRrBAid59rOdBgKOB6fF8wFnweKcu15M6rqOW4vTMcaiD8N7j/ZJytLG
 Vm5m/mct4GIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="401418976"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2021 13:15:15 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, Borislav Petkov <bp@alien8.de>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v4 4/4] selftest/x86/signal: Include test cases for validating sigaltstack
Date:   Fri, 15 Jan 2021 13:10:38 -0800
Message-Id: <20210115211038.2072-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115211038.2072-1-chang.seok.bae@intel.com>
References: <20210115211038.2072-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The test measures the kernel's signal delivery with different (enough vs.
insufficient) stack sizes.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v3:
* Revised test messages again (Borislav Petkov)

Changes from v2:
* Revised test messages (Borislav Petkov)
---
 tools/testing/selftests/x86/Makefile      |   2 +-
 tools/testing/selftests/x86/sigaltstack.c | 128 ++++++++++++++++++++++
 2 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/sigaltstack.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 6703c7906b71..e0c52e5ab49e 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vdso test_vsyscall mov_ss_trap \
-			syscall_arg_fault fsgsbase_restore
+			syscall_arg_fault fsgsbase_restore sigaltstack
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/sigaltstack.c b/tools/testing/selftests/x86/sigaltstack.c
new file mode 100644
index 000000000000..f689af75e979
--- /dev/null
+++ b/tools/testing/selftests/x86/sigaltstack.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define _GNU_SOURCE
+#include <signal.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <err.h>
+#include <errno.h>
+#include <limits.h>
+#include <sys/mman.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <sys/resource.h>
+#include <setjmp.h>
+
+/* sigaltstack()-enforced minimum stack */
+#define ENFORCED_MINSIGSTKSZ	2048
+
+#ifndef AT_MINSIGSTKSZ
+#  define AT_MINSIGSTKSZ	51
+#endif
+
+static int nerrs;
+
+static bool sigalrm_expected;
+
+static unsigned long at_minstack_size;
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static void clearhandler(int sig)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static int setup_altstack(void *start, unsigned long size)
+{
+	stack_t ss;
+
+	memset(&ss, 0, sizeof(ss));
+	ss.ss_size = size;
+	ss.ss_sp = start;
+
+	return sigaltstack(&ss, NULL);
+}
+
+static jmp_buf jmpbuf;
+
+static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
+{
+	if (sigalrm_expected) {
+		printf("[FAIL]\tWrong signal delivered: SIGSEGV (expected SIGALRM).");
+		nerrs++;
+	} else {
+		printf("[OK]\tSIGSEGV signal delivered.\n");
+	}
+
+	siglongjmp(jmpbuf, 1);
+}
+
+static void sigalrm(int sig, siginfo_t *info, void *ctx_void)
+{
+	if (!sigalrm_expected) {
+		printf("[FAIL]\tWrong signal delivered: SIGALRM (expected SIGSEGV).");
+		nerrs++;
+	} else {
+		printf("[OK]\tSIGALRM signal delivered.\n");
+	}
+}
+
+static void test_sigaltstack(void *altstack, unsigned long size)
+{
+	if (setup_altstack(altstack, size))
+		err(1, "sigaltstack()");
+
+	sigalrm_expected = (size > at_minstack_size) ? true : false;
+
+	sethandler(SIGSEGV, sigsegv, 0);
+	sethandler(SIGALRM, sigalrm, SA_ONSTACK);
+
+	if (!sigsetjmp(jmpbuf, 1)) {
+		printf("[RUN]\tTest an alternate signal stack of %ssufficient size.\n",
+		       sigalrm_expected ? "" : "in");
+		printf("\tRaise SIGALRM. %s is expected to be delivered.\n",
+		       sigalrm_expected ? "It" : "SIGSEGV");
+		raise(SIGALRM);
+	}
+
+	clearhandler(SIGALRM);
+	clearhandler(SIGSEGV);
+}
+
+int main(void)
+{
+	void *altstack;
+
+	at_minstack_size = getauxval(AT_MINSIGSTKSZ);
+
+	altstack = mmap(NULL, at_minstack_size + SIGSTKSZ, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
+	if (altstack == MAP_FAILED)
+		err(1, "mmap()");
+
+	if ((ENFORCED_MINSIGSTKSZ + 1) < at_minstack_size)
+		test_sigaltstack(altstack, ENFORCED_MINSIGSTKSZ + 1);
+
+	test_sigaltstack(altstack, at_minstack_size + SIGSTKSZ);
+
+	return nerrs == 0 ? 0 : 1;
+}
-- 
2.17.1

