Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B0838810A
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 22:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352113AbhERUKt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 16:10:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:15754 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352102AbhERUKi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 16:10:38 -0400
IronPort-SDR: 9huY8Zvhy3/tNAuN0Xvs7GxnmAKbc86oZWERgTVi/cAiv5XJOIaTDJ9qpvaD0H+gCR26ipN6i1
 H0mdmVOf+WVg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="180411924"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="180411924"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:08:53 -0700
IronPort-SDR: aZ787fBbkXxSb4U7Oa4YD08Hm9TwIROW959K/6dLV698am9hcH/Qk2KQ9hc0lCgizyNLYwkgB4
 A5SOkI+YMC9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="394993623"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2021 13:08:53 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: [PATCH v9 4/6] selftest/sigaltstack: Use the AT_MINSIGSTKSZ aux vector if available
Date:   Tue, 18 May 2021 13:03:18 -0700
Message-Id: <20210518200320.17239-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518200320.17239-1-chang.seok.bae@intel.com>
References: <20210518200320.17239-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The SIGSTKSZ constant may not represent enough stack size in some
architectures as the hardware state size grows.

Use getauxval(AT_MINSIGSTKSZ) to increase the stack size.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Added as a new patch.
---
 tools/testing/selftests/sigaltstack/sas.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 8934a3766d20..c53b070755b6 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -17,6 +17,7 @@
 #include <string.h>
 #include <assert.h>
 #include <errno.h>
+#include <sys/auxv.h>
 
 #include "../kselftest.h"
 
@@ -24,6 +25,11 @@
 #define SS_AUTODISARM  (1U << 31)
 #endif
 
+#ifndef AT_MINSIGSTKSZ
+#define AT_MINSIGSTKSZ	51
+#endif
+
+static unsigned int stack_size;
 static void *sstack, *ustack;
 static ucontext_t uc, sc;
 static const char *msg = "[OK]\tStack preserved";
@@ -47,7 +53,7 @@ void my_usr1(int sig, siginfo_t *si, void *u)
 #endif
 
 	if (sp < (unsigned long)sstack ||
-			sp >= (unsigned long)sstack + SIGSTKSZ) {
+			sp >= (unsigned long)sstack + stack_size) {
 		ksft_exit_fail_msg("SP is not on sigaltstack\n");
 	}
 	/* put some data on stack. other sighandler will try to overwrite it */
@@ -108,6 +114,10 @@ int main(void)
 	stack_t stk;
 	int err;
 
+	/* Make sure more than the required minimum. */
+	stack_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
+	ksft_print_msg("[NOTE]\tthe stack size is %lu\n", stack_size);
+
 	ksft_print_header();
 	ksft_set_plan(3);
 
@@ -117,7 +127,7 @@ int main(void)
 	sigaction(SIGUSR1, &act, NULL);
 	act.sa_sigaction = my_usr2;
 	sigaction(SIGUSR2, &act, NULL);
-	sstack = mmap(NULL, SIGSTKSZ, PROT_READ | PROT_WRITE,
+	sstack = mmap(NULL, stack_size, PROT_READ | PROT_WRITE,
 		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
 	if (sstack == MAP_FAILED) {
 		ksft_exit_fail_msg("mmap() - %s\n", strerror(errno));
@@ -139,7 +149,7 @@ int main(void)
 	}
 
 	stk.ss_sp = sstack;
-	stk.ss_size = SIGSTKSZ;
+	stk.ss_size = stack_size;
 	stk.ss_flags = SS_ONSTACK | SS_AUTODISARM;
 	err = sigaltstack(&stk, NULL);
 	if (err) {
@@ -161,7 +171,7 @@ int main(void)
 		}
 	}
 
-	ustack = mmap(NULL, SIGSTKSZ, PROT_READ | PROT_WRITE,
+	ustack = mmap(NULL, stack_size, PROT_READ | PROT_WRITE,
 		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
 	if (ustack == MAP_FAILED) {
 		ksft_exit_fail_msg("mmap() - %s\n", strerror(errno));
@@ -170,7 +180,7 @@ int main(void)
 	getcontext(&uc);
 	uc.uc_link = NULL;
 	uc.uc_stack.ss_sp = ustack;
-	uc.uc_stack.ss_size = SIGSTKSZ;
+	uc.uc_stack.ss_size = stack_size;
 	makecontext(&uc, switch_fn, 0);
 	raise(SIGUSR1);
 
-- 
2.17.1

