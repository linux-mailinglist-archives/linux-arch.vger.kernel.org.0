Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E73A4A3A3F
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356714AbiA3VZn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:25:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:9047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356486AbiA3VYz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577895; x=1675113895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=G4fVgUiNuZ57ki/aV9t4t6lONJ9wFjRKKu+IxwPcJt0=;
  b=ZOSIUoV2It2xfNWtpmAFFWKirdDjHIYy1YSLPTBe2PUU4E8ugaDHJsnc
   X2hwgoorJwzXBaNk26KbSNHybSb/1HuxJ71O5b898sDESEUR398UYdMKa
   W9Z33AgJA0jd8u5b5gRf5suIaxa1Nbc1xdhGpYpTXPMx7upevrIjyz9wZ
   ukk54NTvY2/G/ShC5HHHszLQ+ybbeXbPgxQcClceaNoME4E0LOGAn8Kux
   6Dwtu6nCyxEivqsfovNdhJy4r8QbR1SMRkFgLoig86paesvcFd+BpqgpS
   bZzRtzGcWLEHZoe0yVLqwVHmY9syKkMN4WPcfQb+owB0ZW46c7dCSRakI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="310685834"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="310685834"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536857008"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:12 -0800
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com, Yu@vger.kernel.org,
        Yu-cheng <yu-cheng.yu@intel.com>
Subject: [PATCH 33/35] selftests/x86: Add map_shadow_stack syscall test
Date:   Sun, 30 Jan 2022 13:18:36 -0800
Message-Id: <20220130211838.8382-34-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a simple selftest for exercising the new map_shadow_stack syscall.

Co-developed-by: Yu, Yu-cheng <yu-cheng.yu@intel.com>
Signed-off-by: Yu, Yu-cheng <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v1:
 - New patch.

 tools/testing/selftests/x86/Makefile          |  9 ++-
 .../selftests/x86/test_map_shadow_stack.c     | 75 +++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/test_map_shadow_stack.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 8a1f62ab3c8e..9114943336f9 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -9,11 +9,13 @@ UNAME_M := $(shell uname -m)
 CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
 CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
 CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
+CAN_BUILD_WITH_SHSTK := $(shell ./check_cc.sh $(CC) trivial_program.c -mshstk -fcf-protection)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vsyscall mov_ss_trap \
-			syscall_arg_fault fsgsbase_restore sigaltstack
+			syscall_arg_fault fsgsbase_restore sigaltstack \
+			test_map_shadow_stack
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
@@ -105,3 +107,8 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
 # state.
 $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
 $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
+
+ifeq ($(CAN_BUILD_WITH_SHSTK),1)
+$(OUTPUT)/test_map_shadow_stack_64: CFLAGS += -mshstk -fcf-protection
+$(OUTPUT)/test_map_shadow_stack_32: CFLAGS += -mshstk -fcf-protection
+endif
\ No newline at end of file
diff --git a/tools/testing/selftests/x86/test_map_shadow_stack.c b/tools/testing/selftests/x86/test_map_shadow_stack.c
new file mode 100644
index 000000000000..dfd94ef0176d
--- /dev/null
+++ b/tools/testing/selftests/x86/test_map_shadow_stack.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <x86intrin.h>
+
+#define SS_SIZE 0x200000
+
+void *create_shstk(void)
+{
+	return (void *)syscall(__NR_map_shadow_stack, SS_SIZE, SHADOW_STACK_SET_TOKEN);
+}
+
+#if (__GNUC__ < 8) || (__GNUC__ == 8 && __GNUC_MINOR__ < 5)
+int main(int argc, char *argv[])
+{
+	printf("SKIP: compiler does not support CET.");
+	return 0;
+}
+#else
+void try_shstk(unsigned long new_ssp)
+{
+	unsigned long ssp0, ssp1;
+
+	printf("pid=%d\n", getpid());
+	printf("new_ssp = %lx, *new_ssp = %lx\n",
+		new_ssp, *((unsigned long *)new_ssp));
+
+	ssp0 = _get_ssp();
+	printf("changing ssp from %lx to %lx\n", ssp0, new_ssp);
+
+	/* Make sure is aligned to 8 bytes */
+	if ((ssp0 & 0xf) != 0)
+		ssp0 &= -8;
+
+	asm volatile("rstorssp (%0)\n":: "r" (new_ssp));
+	asm volatile("saveprevssp");
+	ssp1 = _get_ssp();
+	printf("ssp is now %lx\n", ssp1);
+
+	ssp0 -= 8;
+	asm volatile("rstorssp (%0)\n":: "r" (ssp0));
+	asm volatile("saveprevssp");
+}
+
+int main(int argc, char *argv[])
+{
+	void *shstk;
+
+	if (!_get_ssp()) {
+		printf("SKIP: shadow stack disabled.");
+		return 0;
+	}
+
+	shstk = create_shstk();
+	if (shstk == MAP_FAILED) {
+		printf("FAIL: Error creating shadow stack: %d\n", errno);
+		return 1;
+	}
+	try_shstk((unsigned long)shstk + SS_SIZE - 8);
+
+	printf("PASS.\n");
+	return 0;
+}
+#endif
-- 
2.17.1

