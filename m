Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA1236151B
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 00:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhDOWSp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 18:18:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:58105 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236754AbhDOWSL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 18:18:11 -0400
IronPort-SDR: 1Md/Iu3a7SxsjELpFVDMO6honN92tY8fI9r3ehQnGxIeo3Xs+mXPCqMRMetCCCLPo4FDFhev6N
 Ygt2JIWDxAxQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258913071"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="258913071"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:17:46 -0700
IronPort-SDR: GR2QIhXtAvLyyLDhJK7j/d1IHPtTBJxYtrFbk4Gc6jPbT3ADRPjO7uHL3C1wy5sZxn3kgxLsz5
 h6u9BSRD23NA==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="399720965"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:17:45 -0700
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
Subject: [PATCH v25 2/9] x86/cet/ibt: Add user-mode Indirect Branch Tracking support
Date:   Thu, 15 Apr 2021 15:17:27 -0700
Message-Id: <20210415221734.32628-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210415221734.32628-1-yu-cheng.yu@intel.com>
References: <20210415221734.32628-1-yu-cheng.yu@intel.com>
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
v24:
- Move IBT routines to a separate ibt.c, update related areas accordingly.

 arch/x86/include/asm/cet.h |  9 ++++++
 arch/x86/kernel/Makefile   |  1 +
 arch/x86/kernel/ibt.c      | 57 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 arch/x86/kernel/ibt.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 662335ceb57f..17afcc9ea4d1 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -15,6 +15,7 @@ struct cet_status {
 	unsigned long	shstk_base;
 	unsigned long	shstk_size;
 	unsigned int	locked:1;
+	unsigned int	ibt_enabled:1;
 };
 
 #ifdef CONFIG_X86_SHADOW_STACK
@@ -41,6 +42,14 @@ static inline int shstk_check_rstor_token(bool ia32, unsigned long token_addr,
 					  unsigned long *new_ssp) { return 0; }
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
index eb13d578ad36..e10e007c1d80 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -151,6 +151,7 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev-es.o
 obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o cet_prctl.o
+obj-$(CONFIG_X86_IBT)			+= ibt.o
 
 ###
 # 64 bit specific files
diff --git a/arch/x86/kernel/ibt.c b/arch/x86/kernel/ibt.c
new file mode 100644
index 000000000000..d2cef1a0345b
--- /dev/null
+++ b/arch/x86/kernel/ibt.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ibt.c - Intel Indirect Branch Tracking support
+ *
+ * Copyright (c) 2021, Intel Corporation.
+ * Yu-cheng Yu <yu-cheng.yu@intel.com>
+ */
+
+#include <linux/user.h>
+#include <asm/msr.h>
+#include <asm/fpu/internal.h>
+#include <asm/fpu/xstate.h>
+#include <asm/fpu/types.h>
+#include <asm/cet.h>
+
+static void start_update_msrs(void)
+{
+	fpregs_lock();
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		__fpregs_load_activate();
+}
+
+static void end_update_msrs(void)
+{
+	fpregs_unlock();
+}
+
+int ibt_setup(void)
+{
+	u64 msr_val;
+
+	if (!cpu_feature_enabled(X86_FEATURE_IBT))
+		return -EOPNOTSUPP;
+
+	start_update_msrs();
+	rdmsrl(MSR_IA32_U_CET, msr_val);
+	msr_val |= (CET_ENDBR_EN | CET_NO_TRACK_EN);
+	wrmsrl(MSR_IA32_U_CET, msr_val);
+	end_update_msrs();
+	current->thread.cet.ibt_enabled = 1;
+	return 0;
+}
+
+void ibt_disable(void)
+{
+	u64 msr_val;
+
+	if (!cpu_feature_enabled(X86_FEATURE_IBT))
+		return;
+
+	start_update_msrs();
+	rdmsrl(MSR_IA32_U_CET, msr_val);
+	msr_val &= ~CET_ENDBR_EN;
+	wrmsrl(MSR_IA32_U_CET, msr_val);
+	end_update_msrs();
+	current->thread.cet.ibt_enabled = 0;
+}
-- 
2.21.0

