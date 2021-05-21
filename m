Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A66338D127
	for <lists+linux-arch@lfdr.de>; Sat, 22 May 2021 00:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhEUWSq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 18:18:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:55699 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhEUWSi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 18:18:38 -0400
IronPort-SDR: vG2jVoYj2A5PMYPsPtZAgd7P+yNJ6hmDr91lU589Q9rfL6IE9PMkVnD1TGB+4ZaUQE45jJDppA
 nKht0iYe09/A==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="287124413"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="287124413"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:16:28 -0700
IronPort-SDR: sX3cB7hOdv0qYkzvqnGfwpYlLqksLfnqQW4oUdnnbgSm4pZJdbp6FyVdDgFv9kAmVvkt0guYF4
 SovxeF13fxoQ==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441269428"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:16:28 -0700
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v27 02/10] x86/cet/ibt: Add user-mode Indirect Branch Tracking support
Date:   Fri, 21 May 2021 15:15:23 -0700
Message-Id: <20210521221531.30168-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210521221531.30168-1-yu-cheng.yu@intel.com>
References: <20210521221531.30168-1-yu-cheng.yu@intel.com>
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
index 2741c91104ac..bc4dc013e1ed 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -151,6 +151,7 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o
 obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o cet_prctl.o
+obj-$(CONFIG_X86_IBT)			+= ibt.o
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/ibt.c b/arch/x86/kernel/ibt.c
new file mode 100644
index 000000000000..629d4100fc40
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
+		__fpregs_load_activate();
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
+		return -EOPNOTSUPP;
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

