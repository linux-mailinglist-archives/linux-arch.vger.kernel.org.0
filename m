Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD01B326E4B
	for <lists+linux-arch@lfdr.de>; Sat, 27 Feb 2021 18:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhB0RPm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Feb 2021 12:15:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:57118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhB0RL0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Feb 2021 12:11:26 -0500
IronPort-SDR: eRxHzVTKu0B5F43WEE3lHUXHBukC5mNNYhWCt0fRKZIdKOIK9marie1ek148sr0AFntnf2Jw1D
 sD6mOAhzzOPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="205700334"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="205700334"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 09:03:58 -0800
IronPort-SDR: ZmUda+Fms5KNz2VYmNmFv5BDorpzWBnpahyW98nhtgDSy/TuG0Rr4zWnmq3UFtmVc7+XjjfBO6
 jBG/kVKM3VbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="503906851"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2021 09:03:58 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-kselftest@vger.kernel.org
Subject: [PATCH v6 4/6] selftest/sigaltstack: Use the AT_MINSIGSTKSZ aux vector if available
Date:   Sat, 27 Feb 2021 08:59:09 -0800
Message-Id: <20210227165911.32757-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210227165911.32757-1-chang.seok.bae@intel.com>
References: <20210227165911.32757-1-chang.seok.bae@intel.com>
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

