Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FEE61A48E
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiKDWni (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiKDWnA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:43:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA6259FDF;
        Fri,  4 Nov 2022 15:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601598; x=1699137598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YH9KUY8mxtUoG/C7O+owx6kIzcNei0xchFyR6pwYJYk=;
  b=l7kc6a2lgzOgTJRzzXLDuIUJ5wNlXL0rkVlEyNEp+q9K6JjnXaK5JCNl
   6cqhdu9R6mPtxGd/uLx1xou8AsbWAUj2/v0GHSd60NYZm85xYuFe0aQ/a
   ZDJtBstL6Jdpzlep1XLv43DGEZyd1O9YrlOjLcpPFSj5dYTZNIKEh9RoC
   q2jP2ZK9/ZNoPyNoJ9bRGCyOG7g5GrRDUK/POkcpjxgkwVAXxWx/ExJYG
   TfVYb4SfQJrwFFPpDebKbesFAyA31vZrPzgHPrT5cJq56fLf27H4IHOTl
   O20wgI6fNkStZSTI19COhaYVkjRp5zhbBIBGVasEMm+v3UuI+g8aPmFMV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840575"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840575"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514107"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514107"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:43 -0700
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v3 24/37] x86: Introduce userspace API for CET enabling
Date:   Fri,  4 Nov 2022 15:35:51 -0700
Message-Id: <20221104223604.29615-25-rick.p.edgecombe@intel.com>
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

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Add three new arch_prctl() handles:

 - ARCH_CET_ENABLE/DISABLE enables or disables the specified
   feature. Returns 0 on success or an error.

 - ARCH_CET_LOCK prevents future disabling or enabling of the
   specified feature. Returns 0 on success or an error

The features are handled per-thread and inherited over fork(2)/clone(2),
but reset on exec().

This is preparation patch. It does not implement any features.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
[tweaked with feedback from tglx]
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v3:
 - Move shstk.c Makefile changes earlier (Kees)
 - Add #ifdef around features_locked and features (Kees)
 - Encapsulate features reset earlier in reset_thread_features() so
   features and features_locked are not referenced in code that would be
   compiled !CONFIG_X86_USER_SHADOW_STACK. (Kees)
 - Fix typo in commit log (Kees)
 - Switch arch_prctl() numbers to avoid conflict with LAM

v2:
 - Only allow one enable/disable per call (tglx)
 - Return error code like a normal arch_prctl() (Alexander Potapenko)
 - Make CET only (tglx)

 arch/x86/include/asm/cet.h        | 21 +++++++++++++++
 arch/x86/include/asm/processor.h  |  5 ++++
 arch/x86/include/uapi/asm/prctl.h |  6 +++++
 arch/x86/kernel/Makefile          |  2 ++
 arch/x86/kernel/process_64.c      |  7 ++++-
 arch/x86/kernel/shstk.c           | 44 +++++++++++++++++++++++++++++++
 6 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/kernel/shstk.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
new file mode 100644
index 000000000000..a2f3c6e06ef5
--- /dev/null
+++ b/arch/x86/include/asm/cet.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CET_H
+#define _ASM_X86_CET_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+struct task_struct;
+
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+long cet_prctl(struct task_struct *task, int option, unsigned long features);
+void reset_thread_features(void);
+#else
+static inline long cet_prctl(struct task_struct *task, int option,
+			     unsigned long features) { return -EINVAL; }
+static inline void reset_thread_features(void) {}
+#endif /* CONFIG_X86_USER_SHADOW_STACK */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_CET_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67c9d73b31fa..ca66d320a263 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -530,6 +530,11 @@ struct thread_struct {
 	 */
 	u32			pkru;
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+	unsigned long		features;
+	unsigned long		features_locked;
+#endif
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f18..2dae9997ee17 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -20,4 +20,10 @@
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
 
+/* Don't use 0x3001-0x3004 because of old glibcs */
+
+#define ARCH_CET_ENABLE			0x5001
+#define ARCH_CET_DISABLE		0x5002
+#define ARCH_CET_LOCK			0x5003
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f901658d9f7c..fbb1cb34188d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -143,6 +143,8 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
 obj-$(CONFIG_CFI_CLANG)			+= cfi.o
 
+obj-$(CONFIG_X86_USER_SHADOW_STACK)	+= shstk.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6b3418bff326..17fec059317c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -514,6 +514,8 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		load_gs_index(__USER_DS);
 	}
 
+	reset_thread_features();
+
 	loadsegment(fs, 0);
 	loadsegment(es, _ds);
 	loadsegment(ds, _ds);
@@ -830,7 +832,10 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_MAP_VDSO_64:
 		return prctl_map_vdso(&vdso_image_64, arg2);
 #endif
-
+	case ARCH_CET_ENABLE:
+	case ARCH_CET_DISABLE:
+	case ARCH_CET_LOCK:
+		return cet_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
new file mode 100644
index 000000000000..ed6f25cc07c5
--- /dev/null
+++ b/arch/x86/kernel/shstk.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * shstk.c - Intel shadow stack support
+ *
+ * Copyright (c) 2021, Intel Corporation.
+ * Yu-cheng Yu <yu-cheng.yu@intel.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/bitops.h>
+#include <asm/prctl.h>
+
+void reset_thread_features(void)
+{
+	current->thread.features = 0;
+	current->thread.features_locked = 0;
+}
+
+long cet_prctl(struct task_struct *task, int option, unsigned long features)
+{
+	if (option == ARCH_CET_LOCK) {
+		task->thread.features_locked |= features;
+		return 0;
+	}
+
+	/* Don't allow via ptrace */
+	if (task != current)
+		return -EINVAL;
+
+	/* Do not allow to change locked features */
+	if (features & task->thread.features_locked)
+		return -EPERM;
+
+	/* Only support enabling/disabling one feature at a time. */
+	if (hweight_long(features) > 1)
+		return -EINVAL;
+
+	if (option == ARCH_CET_DISABLE) {
+		return -EINVAL;
+	}
+
+	/* Handle ARCH_CET_ENABLE */
+	return -EINVAL;
+}
-- 
2.17.1

