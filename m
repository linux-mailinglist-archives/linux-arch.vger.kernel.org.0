Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D6A641280
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiLCAlh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiLCAkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:40:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921257F8A5;
        Fri,  2 Dec 2022 16:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027886; x=1701563886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hb52f1kQ206uopv1axYH6ww07mmrNoR971WJZuI+W7k=;
  b=gUETHRQ0XkCpDQP9hUx9hmXj0yqEi5jmVex3bB5y+9Qst9aUHPfkIraD
   EGmJHNuGBiU6mDZlP4lNBhgl3pk5btap4d9vRRxyd+HBQ8Jh/XvePcjc6
   wBvzra2r1t2BNODXH/DPIDk7fahP882mxDOwscwlF3HK8dJ25wkDwEK+e
   LLKutZrUis67DvYhUz/xmBK9d9AGyixAGqWQ6kEY1DIbwdmoHs/0i4Y+W
   mdy67xI4ZELisH7oLXON3aO8MknWHfVaM5vH5tamRSGxdtB8BzAq9G4II
   bSh9+UK8L7mmkVArVOD9UgTNNTQzGzAQ0CClTC4hBjH0/pzwsE3IWnpoB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711273"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711273"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479947"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479947"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:25 -0800
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v4 25/39] x86: Introduce userspace API for shadow stack
Date:   Fri,  2 Dec 2022 16:35:52 -0800
Message-Id: <20221203003606.6838-26-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Add three new arch_prctl() handles:

 - ARCH_SHSTK_ENABLE/DISABLE enables or disables the specified
   feature. Returns 0 on success or an error.

 - ARCH_SHSTK_LOCK prevents future disabling or enabling of the
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

v4:
 - Remove references to CET and replace with shadow stack (Peterz)

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

 arch/x86/include/asm/processor.h  |  5 ++++
 arch/x86/include/asm/shstk.h      | 21 +++++++++++++++
 arch/x86/include/uapi/asm/prctl.h |  6 +++++
 arch/x86/kernel/Makefile          |  2 ++
 arch/x86/kernel/process_64.c      |  6 +++++
 arch/x86/kernel/shstk.c           | 44 +++++++++++++++++++++++++++++++
 6 files changed, 84 insertions(+)
 create mode 100644 arch/x86/include/asm/shstk.h
 create mode 100644 arch/x86/kernel/shstk.c

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4e35c66edeb7..ff1c0b1aca8c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -475,6 +475,11 @@ struct thread_struct {
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
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
new file mode 100644
index 000000000000..58f9ee675be0
--- /dev/null
+++ b/arch/x86/include/asm/shstk.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SHSTK_H
+#define _ASM_X86_SHSTK_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+struct task_struct;
+
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+long shstk_prctl(struct task_struct *task, int option, unsigned long features);
+void reset_thread_features(void);
+#else
+static inline long shstk_prctl(struct task_struct *task, int option,
+			     unsigned long features) { return -EINVAL; }
+static inline void reset_thread_features(void) {}
+#endif /* CONFIG_X86_USER_SHADOW_STACK */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_SHSTK_H */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index eb290d89cb32..8b427aea2345 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -20,9 +20,15 @@
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
 
+/* Don't use 0x3001-0x3004 because of old glibcs */
+
 #define ARCH_GET_UNTAG_MASK		0x4001
 #define ARCH_ENABLE_TAGGED_ADDR		0x4002
 #define ARCH_GET_MAX_TAG_BITS		0x4003
 #define ARCH_FORCE_TAGGED_SVA		0x4004
 
+#define ARCH_SHSTK_ENABLE		0x5001
+#define ARCH_SHSTK_DISABLE		0x5002
+#define ARCH_SHSTK_LOCK			0x5003
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 96d51bbc2bd4..2260891609b4 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -145,6 +145,8 @@ obj-$(CONFIG_CFI_CLANG)			+= cfi.o
 
 obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
 
+obj-$(CONFIG_X86_USER_SHADOW_STACK)	+= shstk.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 084ec467dbb1..4ddd7d9209e1 100644
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
@@ -916,6 +918,10 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 			return put_user(0, (unsigned long __user *)arg2);
 		else
 			return put_user(LAM_U57_BITS, (unsigned long __user *)arg2);
+	case ARCH_SHSTK_ENABLE:
+	case ARCH_SHSTK_DISABLE:
+	case ARCH_SHSTK_LOCK:
+		return shstk_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
new file mode 100644
index 000000000000..41ed6552e0a5
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
+long shstk_prctl(struct task_struct *task, int option, unsigned long features)
+{
+	if (option == ARCH_SHSTK_LOCK) {
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
+	if (option == ARCH_SHSTK_DISABLE) {
+		return -EINVAL;
+	}
+
+	/* Handle ARCH_SHSTK_ENABLE */
+	return -EINVAL;
+}
-- 
2.17.1

