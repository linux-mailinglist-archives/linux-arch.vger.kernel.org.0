Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D7A3D2E8B
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhGVURd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 16:17:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:15252 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231239AbhGVURa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 16:17:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="211800514"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="211800514"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:58:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="433273360"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:58:03 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v28 02/10] x86/cet/ibt: Add user-mode Indirect Branch Tracking support
Date:   Thu, 22 Jul 2021 13:57:15 -0700
Message-Id: <20210722205723.9476-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210722205723.9476-1-yu-cheng.yu@intel.com>
References: <20210722205723.9476-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce user-mode Indirect Branch Tracking (IBT) support.  Add routines
for the setup/disable of IBT.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v28:
- When IBT feature is not present, make ibt_setup() return success,
  since this is a setup function, and if IBT feature is not present there
  is no need for setup.

v27:
- Change struct thread_shstk: ibt_enabled to ibt.
- Create a helper for set/clear bits of MSR_IA32_U_CET.

 arch/x86/include/asm/cet.h |  9 ++++++
 arch/x86/kernel/Makefile   |  1 +
 arch/x86/kernel/ibt.c      | 58 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 arch/x86/kernel/ibt.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index c76a85fbd59f..3dfca29a7c0b 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -14,6 +14,7 @@ struct thread_shstk {
 	u64	base;
 	u64	size;
 	u64	locked:1;
+	u64	ibt:1;
 };
 
 #ifdef CONFIG_X86_SHADOW_STACK
@@ -42,6 +43,14 @@ static inline int setup_signal_shadow_stack(int ia32, void __user *restorer) { r
 static inline int restore_signal_shadow_stack(void) { return 0; }
 #endif
 
+#ifdef CONFIG_X86_IBT
+int ibt_setup(void);
+void ibt_disable(void);
+#else
+static inline int ibt_setup(void) { return 0; }
+static inline void ibt_disable(void) {}
+#endif
+
 #ifdef CONFIG_X86_SHADOW_STACK
 int prctl_cet(int option, u64 arg2);
 #else
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 39e826b5cabd..cce07a920fec 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -152,6 +152,7 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o
 obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o cet_prctl.o
+obj-$(CONFIG_X86_IBT)			+= ibt.o
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/ibt.c b/arch/x86/kernel/ibt.c
new file mode 100644
index 000000000000..4ab7af33b274
--- /dev/null
+++ b/arch/x86/kernel/ibt.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ibt.c - Intel Indirect Branch Tracking support
+ *
+ * Copyright (c) 2021, Intel Corporation.
+ * Yu-cheng Yu <yu-cheng.yu@intel.com>
+ */
+
+#include <linux/user.h>
+#include <asm/fpu/internal.h>
+#include <asm/fpu/xstate.h>
+#include <asm/fpu/types.h>
+#include <asm/msr.h>
+#include <asm/cet.h>
+
+static int ibt_set_clear_msr_bits(u64 set, u64 clear)
+{
+	u64 msr;
+	int r;
+
+	fpregs_lock();
+
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		fpregs_restore_userregs();
+
+	r = rdmsrl_safe(MSR_IA32_U_CET, &msr);
+	if (!r) {
+		msr = (msr & ~clear) | set;
+		r = wrmsrl_safe(MSR_IA32_U_CET, msr);
+	}
+
+	fpregs_unlock();
+
+	return r;
+}
+
+int ibt_setup(void)
+{
+	int r;
+
+	if (!cpu_feature_enabled(X86_FEATURE_IBT))
+		return 0;
+
+	r = ibt_set_clear_msr_bits(CET_ENDBR_EN | CET_NO_TRACK_EN, 0);
+	if (!r)
+		current->thread.shstk.ibt = 1;
+
+	return r;
+}
+
+void ibt_disable(void)
+{
+	if (!current->thread.shstk.ibt)
+		return;
+
+	ibt_set_clear_msr_bits(0, CET_ENDBR_EN);
+	current->thread.shstk.ibt = 0;
+}
-- 
2.21.0

