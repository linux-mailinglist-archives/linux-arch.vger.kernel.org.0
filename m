Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068F64A3A2F
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356835AbiA3VZc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:25:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:9049 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356642AbiA3VYB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577841; x=1675113841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Em5mNWM4OERuM6Gg1HCpB/weTfMZ74vCRnQkfPKE0BY=;
  b=PhvrEzIBP2v2icfMzi5/YAojt6eKstTVynL0TFtCobpH0EWNXXbgdEQe
   q8QFP66iJb8UPugmMnnJlZw4ZYYZCKUIkQ9BQMp+GWkgpUqPj8FhnvVOe
   51VyviuGPDNf5/Bt44C4rwub8cvpaQwIF77Iroe6BHwi5j8ySVDlBEHgt
   QVufsG6Or2+oxmdMEZl901mr3eosjQS60AXk8lDAGJ1YTXNRW84qgxV20
   MLeMyiaxwoT7kPbG5uA9YPETOTffL5htrmzzAQi2dV+snqvZT3N4dJd0L
   kPqDR99kFFacFruJWOVXAZp4j/VdoQ9aTV/+ikEMQi/t66BUWhyIV8U+9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="310685828"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="310685828"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856983"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:10 -0800
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
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 31/35] x86/cet/shstk: Add arch_prctl elf feature functions
Date:   Sun, 30 Jan 2022 13:18:34 -0800
Message-Id: <20220130211838.8382-32-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Some CPU features that adjust the behavior of existing instructions
should be enabled only if the application supports these modifications.

Provide a per-thread arch_prctl interface for modifying, checking and
locking the enablement status of features like these. This interface
operates on the per-thread state which is copied for new threads. It is
intended to be mostly used early in an application (i.e. a dynamic loader)
such that the behavior will be inherited for new threads created by the
application.

Today the only user is shadow stack, but keep the names generic because
other features like LAM can use it as well.

The interface is as below:
arch_prctl(ARCH_X86_FEATURE_STATUS, u64 *args)
    Get feature status.

    The parameter 'args' is a pointer to a user buffer. The kernel returns
    the following information:

    *args = shadow stack/IBT status
    *(args + 1) = shadow stack base address
    *(args + 2) = shadow stack size

    32-bit binaries use the same interface, but only lower 32-bits of each
    item.

arch_prctl(ARCH_X86_FEATURE_DISABLE, unsigned int features)
    Disable features specified in 'features'. Return -EPERM if any of the
    passed feature are locked. Return -ECANCELED if any of the features
    failed to disable. In this case call ARCH_X86_FEATURE_STATUS to find
    out which features are still enabled.

arch_prctl(ARCH_X86_FEATURE_ENABLE, unsigned int features)
    Enable feature specified in 'features'. Return -EPERM if any of the
    passed feature are locked. Return -ECANCELED if any of the features
    failed to enable. In this case call ARCH_X86_FEATURE_STATUS to find
    out which features were enabled.

arch_prctl(ARCH_X86_FEATURE_LOCK, unsigned int features)
    Lock in all features at their current enabled or disabled status.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v1:
 - Changed from ENOSYS and ENOTSUPP error codes per checkpatch.
 - Changed interface/filename to be more generic so it can be shared with
   LAM.
 - Add lock mask, such that some features can be locked, while leaving others
   to be enabled later.
 - Add ARCH_X86_FEATURE_ENABLE to use instead of parsing the elf header
 - Change ARCH_X86_FEATURE_DISABLE to actually return an error on
   failure.

 arch/x86/include/asm/cet.h          |  6 +++
 arch/x86/include/asm/processor.h    |  1 +
 arch/x86/include/uapi/asm/prctl.h   | 10 +++++
 arch/x86/kernel/Makefile            |  2 +-
 arch/x86/kernel/elf_feature_prctl.c | 66 +++++++++++++++++++++++++++++
 arch/x86/kernel/process.c           |  2 +-
 arch/x86/kernel/shstk.c             |  1 +
 7 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/kernel/elf_feature_prctl.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index faff8dc86159..cbc7cfcba5dc 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -40,6 +40,12 @@ static inline int setup_signal_shadow_stack(int proc32, void __user *restorer) {
 static inline int restore_signal_shadow_stack(void) { return 0; }
 #endif /* CONFIG_X86_SHADOW_STACK */
 
+#ifdef CONFIG_X86_SHADOW_STACK
+int prctl_elf_feature(int option, u64 arg2);
+#else
+static inline int prctl_elf_feature(int option, u64 arg2) { return -EINVAL; }
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_CET_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a9f4e9c4ca81..100af0f570c9 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -531,6 +531,7 @@ struct thread_struct {
 
 #ifdef CONFIG_X86_SHADOW_STACK
 	struct thread_shstk	shstk;
+	u64			feat_prctl_locked;
 #endif
 
 	/* Floating point and extended processor state */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f18..aa294c7bcf41 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -20,4 +20,14 @@
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
 
+#define ARCH_X86_FEATURE_STATUS		0x3001
+#define ARCH_X86_FEATURE_DISABLE	0x3002
+#define ARCH_X86_FEATURE_LOCK		0x3003
+#define ARCH_X86_FEATURE_ENABLE		0x3004
+
+/* x86 feature bits to be used with ARCH_X86_FEATURE arch_prctl()s */
+#define LINUX_X86_FEATURE_IBT		0x00000001
+#define LINUX_X86_FEATURE_SHSTK		0x00000002
+
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index d60ae6c365c7..531dba96d4dc 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -153,7 +153,7 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
 obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
 
-obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o
+obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o elf_feature_prctl.o
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/elf_feature_prctl.c b/arch/x86/kernel/elf_feature_prctl.c
new file mode 100644
index 000000000000..47de201db3f7
--- /dev/null
+++ b/arch/x86/kernel/elf_feature_prctl.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/errno.h>
+#include <linux/uaccess.h>
+#include <linux/prctl.h>
+#include <linux/compat.h>
+#include <linux/mman.h>
+#include <linux/elfcore.h>
+#include <linux/processor.h>
+#include <asm/prctl.h>
+#include <asm/cet.h>
+
+/* See Documentation/x86/intel_cet.rst. */
+
+static int elf_feat_copy_status_to_user(struct thread_shstk *shstk, u64 __user *ubuf)
+{
+	u64 buf[3] = {};
+
+	if (shstk->size) {
+		buf[0] = LINUX_X86_FEATURE_SHSTK;
+		buf[1] = shstk->base;
+		buf[2] = shstk->size;
+	}
+
+	return copy_to_user(ubuf, buf, sizeof(buf));
+}
+
+int prctl_elf_feature(int option, u64 arg2)
+{
+	struct thread_struct *thread = &current->thread;
+	u64 feat_succ = 0;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return -EOPNOTSUPP;
+
+	switch (option) {
+	case ARCH_X86_FEATURE_STATUS:
+		return elf_feat_copy_status_to_user(&thread->shstk, (u64 __user *)arg2);
+	case ARCH_X86_FEATURE_DISABLE:
+		if (arg2 & thread->feat_prctl_locked)
+			return -EPERM;
+
+		if (arg2 & LINUX_X86_FEATURE_SHSTK && !shstk_disable())
+			feat_succ |= LINUX_X86_FEATURE_SHSTK;
+
+		if (feat_succ != arg2)
+			return -ECANCELED;
+		return 0;
+	case ARCH_X86_FEATURE_ENABLE:
+		if (arg2 & thread->feat_prctl_locked)
+			return -EPERM;
+
+		if (arg2 & LINUX_X86_FEATURE_SHSTK && !shstk_setup())
+			feat_succ |= LINUX_X86_FEATURE_SHSTK;
+
+		if (feat_succ != arg2)
+			return -ECANCELED;
+		return 0;
+	case ARCH_X86_FEATURE_LOCK:
+		thread->feat_prctl_locked |= arg2;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 0fbcf33255fa..11bf09b60f9d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -1005,5 +1005,5 @@ long do_arch_prctl_common(struct task_struct *task, int option,
 		return fpu_xstate_prctl(task, option, arg2);
 	}
 
-	return -EINVAL;
+	return prctl_elf_feature(option, arg2);
 }
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 682d85a63a1d..f330be17e2d1 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -130,6 +130,7 @@ int shstk_setup(void)
 
 void reset_thread_shstk(void)
 {
+	current->thread.feat_prctl_locked = 0;
 	memset(&current->thread.shstk, 0, sizeof(struct thread_shstk));
 }
 
-- 
2.17.1

