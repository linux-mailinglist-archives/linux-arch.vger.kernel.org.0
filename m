Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB1472D628
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbjFMAQ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbjFMAQQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:16:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037C0173F;
        Mon, 12 Jun 2023 17:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615209; x=1718151209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FpsnqDmskVtuVWeAVhUxFxlMXuwPJqlBrZTKKFCDs5Y=;
  b=R6xK0VOk/CsKnPanl4rMbdEeh3v8uOxWqtL/Ssrl1fxL6P8qC444KXCo
   VO64BplBrjLIBbY2uer5dHGOecGDsRrFpOW+bT+yJSO2vxXhNgguXfq1Z
   SIezcfqlI2nGtaNj4d3gQr/GmtxzNrMUi9wtkiuwneTP2OiTRMSdqnEQa
   EY5u6mpQqNAZeUoO5OqG4x/BRfsRI2CMSqROi+7oaz/xZJggAXi1A5SOJ
   laxjpkUHP0jsdKehMuVS27OzGthsbrEJwxmqLZL5hsPBQDytMkOXCXRAY
   qWGhnEJ2DIBg5mQxKOHNv7x0/jzWZeyJt4t8MR5as9TW4av/hNLpi3K0m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557269"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557269"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671078"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671078"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:29 -0700
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com, Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 26/42] x86: Introduce userspace API for shadow stack
Date:   Mon, 12 Jun 2023 17:10:52 -0700
Message-Id: <20230613001108.3040476-27-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add three new arch_prctl() handles:

 - ARCH_SHSTK_ENABLE/DISABLE enables or disables the specified
   feature. Returns 0 on success or a negative value on error.

 - ARCH_SHSTK_LOCK prevents future disabling or enabling of the
   specified feature. Returns 0 on success or a negative value
   on error.

The features are handled per-thread and inherited over fork(2)/clone(2),
but reset on exec().

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/processor.h  |  6 +++++
 arch/x86/include/asm/shstk.h      | 21 +++++++++++++++
 arch/x86/include/uapi/asm/prctl.h |  6 +++++
 arch/x86/kernel/Makefile          |  2 ++
 arch/x86/kernel/process_64.c      |  6 +++++
 arch/x86/kernel/shstk.c           | 44 +++++++++++++++++++++++++++++++
 6 files changed, 85 insertions(+)
 create mode 100644 arch/x86/include/asm/shstk.h
 create mode 100644 arch/x86/kernel/shstk.c

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a1e4fa58b357..407d5551b6a7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -28,6 +28,7 @@ struct vm86;
 #include <asm/unwind_hints.h>
 #include <asm/vmxfeatures.h>
 #include <asm/vdso/processor.h>
+#include <asm/shstk.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
@@ -475,6 +476,11 @@ struct thread_struct {
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
index 000000000000..ec753809f074
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
+			       unsigned long arg2) { return -EINVAL; }
+static inline void reset_thread_features(void) {}
+#endif /* CONFIG_X86_USER_SHADOW_STACK */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_SHSTK_H */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index e8d7ebbca1a4..1cd44ecc9ce0 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -23,9 +23,15 @@
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
index abee0564b750..6b6bf47652ee 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -147,6 +147,8 @@ obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
 
 obj-$(CONFIG_X86_CET)			+= cet.o
 
+obj-$(CONFIG_X86_USER_SHADOW_STACK)	+= shstk.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3d181c16a2f6..0f89aa0186d1 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -515,6 +515,8 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		load_gs_index(__USER_DS);
 	}
 
+	reset_thread_features();
+
 	loadsegment(fs, 0);
 	loadsegment(es, _ds);
 	loadsegment(ds, _ds);
@@ -894,6 +896,10 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 		else
 			return put_user(LAM_U57_BITS, (unsigned long __user *)arg2);
 #endif
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
2.34.1

