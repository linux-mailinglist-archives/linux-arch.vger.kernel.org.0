Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9610E2B9B33
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 20:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgKSTGr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 14:06:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:21738 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbgKSTGl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 14:06:41 -0500
IronPort-SDR: CoOWW9S1lU/DwL6pCf82prx3WqF7RkYoDe4Ldp6T+0vGKDafBdCueTSTNYDTj6SLSVKj4grBtI
 rDIg/QSrqAIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="150614466"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="150614466"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 11:06:40 -0800
IronPort-SDR: cRHXwcW+O3T3Lu6hmAFl89aA2EOI2uiwuiEY3qbl0hMiNN9OnNPbO6iLxi8CMh0omk72M3lJr0
 9grhV6NPeSzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="431333999"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 11:06:40 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, mpe@ellerman.id.au, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/4] selftest/x86/signal: Include test cases for validating sigaltstack
Date:   Thu, 19 Nov 2020 11:02:37 -0800
Message-Id: <20201119190237.626-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119190237.626-1-chang.seok.bae@intel.com>
References: <20201119190237.626-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The test measures the kernel's signal delivery with different (enough vs.
insufficient) stack sizes.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/x86/Makefile      |   2 +-
 tools/testing/selftests/x86/sigaltstack.c | 126 ++++++++++++++++++++++
 2 files changed, 127 insertions(+), 1 deletion(-)
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
index 000000000000..353679df6901
--- /dev/null
+++ b/tools/testing/selftests/x86/sigaltstack.c
@@ -0,0 +1,126 @@
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
+		printf("[FAIL]\tSIGSEGV signal delivered.\n");
+		nerrs++;
+	} else {
+		printf("[OK]\tSIGSEGV signal expectedly delivered.\n");
+	}
+
+	siglongjmp(jmpbuf, 1);
+}
+
+static void sigalrm(int sig, siginfo_t *info, void *ctx_void)
+{
+	if (!sigalrm_expected) {
+		printf("[FAIL]\tSIGALRM sigal delivered.\n");
+		nerrs++;
+	} else {
+		printf("[OK]\tSIGALRM signal expectedly delivered.\n");
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
+		printf("[RUN]\tTest an %s sigaltstack\n",
+		       sigalrm_expected ? "enough" : "insufficient");
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

