Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B55F007D
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiI2Weu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiI2Wdf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:33:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF41B0502;
        Thu, 29 Sep 2022 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490676; x=1696026676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FnYcr5J2TgwiovrmqIsxREyO7fe7Xn/9OctH1SrnQU0=;
  b=dkG9KfI4E807QH3A0GH2xggT9osUKuEJKE6rsXVTPJzBDN9h8eKVhJtG
   ydgSeHM78igk8FJkWnWECxTh7MQsUxbK2gNGhR6UQiJEE0GOZkezwjQ6p
   MH5Zl5UZqZY3CnYAOXz8vt2LPFoIEMmTEUSjPG/pv06VvP53U4IXJ/36f
   orU64E9SxnLHNqLMIo1mOUE9Tw1h/PE27H8seIRdplzKWlGp4GIlRaxfm
   zICHNzZP0YdEQIbwjDWXcTXWQQ1OkXJCvlac0wOhuAjYi9C8tlPjAZt54
   7soIL8jSnsGNYHIrVcll3mMa2Pop59ytNAcQWc+65XsV5OHoa515nH/An
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182030"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182030"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016303"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016303"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:34 -0700
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
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v2 23/39] x86: Introduce userspace API for CET enabling
Date:   Thu, 29 Sep 2022 15:29:20 -0700
Message-Id: <20220929222936.14584-24-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

This is preparation patch. It does not impelement any features.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
[tweaked with feedback from tglx]
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - Only allow one enable/disable per call (tglx)
 - Return error code like a normal arch_prctl() (Alexander Potapenko)
 - Make CET only (tglx)

 arch/x86/include/asm/cet.h        | 20 ++++++++++++++++
 arch/x86/include/asm/processor.h  |  3 +++
 arch/x86/include/uapi/asm/prctl.h |  6 +++++
 arch/x86/kernel/process.c         |  4 ++++
 arch/x86/kernel/process_64.c      |  5 +++-
 arch/x86/kernel/shstk.c           | 38 +++++++++++++++++++++++++++++++
 6 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/kernel/shstk.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
new file mode 100644
index 000000000000..0fa4dbc98c49
--- /dev/null
+++ b/arch/x86/include/asm/cet.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CET_H
+#define _ASM_X86_CET_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+struct task_struct;
+
+#ifdef CONFIG_X86_SHADOW_STACK
+long cet_prctl(struct task_struct *task, int option,
+		      unsigned long features);
+#else
+static inline long cet_prctl(struct task_struct *task, int option,
+		      unsigned long features) { return -EINVAL; }
+#endif /* CONFIG_X86_SHADOW_STACK */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_CET_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 356308c73951..a92bf76edafe 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -530,6 +530,9 @@ struct thread_struct {
 	 */
 	u32			pkru;
 
+	unsigned long		features;
+	unsigned long		features_locked;
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f18..028158e35269 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -20,4 +20,10 @@
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
 
+/* Don't use 0x3001-0x3004 because of old glibcs */
+
+#define ARCH_CET_ENABLE			0x4001
+#define ARCH_CET_DISABLE		0x4002
+#define ARCH_CET_LOCK			0x4003
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 58a6ea472db9..034880311e6b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -367,6 +367,10 @@ void arch_setup_new_exec(void)
 		task_clear_spec_ssb_noexec(current);
 		speculation_ctrl_update(read_thread_flags());
 	}
+
+	/* Reset thread features on exec */
+	current->thread.features = 0;
+	current->thread.features_locked = 0;
 }
 
 #ifdef CONFIG_X86_IOPL_IOPERM
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 1962008fe743..8fa2c2b7de65 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -829,7 +829,10 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
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
index 000000000000..e3276ac9e9b9
--- /dev/null
+++ b/arch/x86/kernel/shstk.c
@@ -0,0 +1,38 @@
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

