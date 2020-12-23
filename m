Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E3A2E1186
	for <lists+linux-arch@lfdr.de>; Wed, 23 Dec 2020 02:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgLWB6f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Dec 2020 20:58:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:49023 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgLWB6f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Dec 2020 20:58:35 -0500
IronPort-SDR: YV/6cEsIW8UP1ReMjh0NjJu7kspgYVIMSR734cUfmi6IQA8IhYwUdcK7cyNmpJHpu13nSidyeQ
 HclGWVCsIHUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="237508819"
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; 
   d="scan'208";a="237508819"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 17:57:41 -0800
IronPort-SDR: OdpFGYu0chn/uWm4DVHIMEzjmJPRjYgdYJsFI2EIkY6G78EiLFhqi0RyIsEwPuOkNOdmsiWZi6
 CZ2eNXzH4y7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; 
   d="scan'208";a="457755751"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2020 17:57:41 -0800
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
Subject: [PATCH v3 4/4] selftest/x86/signal: Include test cases for validating sigaltstack
Date:   Tue, 22 Dec 2020 17:53:12 -0800
Message-Id: <20201223015312.4882-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223015312.4882-1-chang.seok.bae@intel.com>
References: <20201223015312.4882-1-chang.seok.bae@intel.com>
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
Changes from v2:
* Revised test messages (Borislav Pekov)
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
index 000000000000..e2cbf09723c8
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
+		printf("[FAIL]\tSIGSEGV signal delivery is wrong.\n");
+		nerrs++;
+	} else {
+		printf("[OK]\tSIGSEGV signal is delivered.\n");
+	}
+
+	siglongjmp(jmpbuf, 1);
+}
+
+static void sigalrm(int sig, siginfo_t *info, void *ctx_void)
+{
+	if (!sigalrm_expected) {
+		printf("[FAIL]\tSIGALRM sigal delivery is wrong.\n");
+		nerrs++;
+	} else {
+		printf("[OK]\tSIGALRM signal is delivered.\n");
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
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tTest an (%s) alternate signal stack\n",
+		       sigalrm_expected ? "enough" : "too-small");
+		printf("\tRaise SIGALRM. %s is expected to be delivered.\n",
+		       sigalrm_expected ? "It" : "But SIGSEGV");
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

