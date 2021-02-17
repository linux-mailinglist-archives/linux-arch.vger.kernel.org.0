Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CE931E273
	for <lists+linux-arch@lfdr.de>; Wed, 17 Feb 2021 23:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhBQWfQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 17:35:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:13791 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234195AbhBQWdI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Feb 2021 17:33:08 -0500
IronPort-SDR: xT20hrFwDoA5mMG1O7Ko6USarht6CDVWBGzPGqaZ8tZFsErxu/U+1wpSurKm+a6qwe0t9ny7ab
 vCPt+7c2DRFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="183461489"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="183461489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 14:28:08 -0800
IronPort-SDR: HPJLuzL+9RkF0FCJokTDhpFdjJRf0xCI68pQRBaf69OOeGwSrGXpPDrfGwk/3F/ytuQlqj4OGg
 VNSHXy1qrXMg==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="400172694"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 14:28:07 -0800
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
Subject: [PATCH v21 24/26] x86/cet/shstk: Add arch_prctl functions for shadow stack
Date:   Wed, 17 Feb 2021 14:27:28 -0800
Message-Id: <20210217222730.15819-25-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210217222730.15819-1-yu-cheng.yu@intel.com>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

arch_prctl(ARCH_X86_CET_STATUS, u64 *args)
    Get CET feature status.

    The parameter 'args' is a pointer to a user buffer.  The kernel returns
    the following information:

    *args = shadow stack/IBT status
    *(args + 1) = shadow stack base address
    *(args + 2) = shadow stack size

    32-bit binaries use the same interface, but only lower 32-bits of each
    item.

arch_prctl(ARCH_X86_CET_DISABLE, unsigned int features)
    Disable CET features specified in 'features'.  Return -EPERM if CET is
    locked.

arch_prctl(ARCH_X86_CET_LOCK)
    Lock in CET features.

Also change do_arch_prctl_common()'s parameter 'cpuid_enabled' to
'arg2', as it is now also passed to prctl_cet().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/cet.h        |  3 ++
 arch/x86/include/uapi/asm/prctl.h |  4 +++
 arch/x86/kernel/Makefile          |  2 +-
 arch/x86/kernel/cet_prctl.c       | 60 +++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c         |  6 ++--
 5 files changed, 71 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/kernel/cet_prctl.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 5d66340c7a13..c2437378f339 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -14,9 +14,11 @@ struct sc_ext;
 struct cet_status {
 	unsigned long	shstk_base;
 	unsigned long	shstk_size;
+	unsigned int	locked:1;
 };
 
 #ifdef CONFIG_X86_CET
+int prctl_cet(int option, u64 arg2);
 int cet_setup_shstk(void);
 int cet_setup_thread_shstk(struct task_struct *p, unsigned long clone_flags,
 			   unsigned long stack_size);
@@ -26,6 +28,7 @@ int cet_verify_rstor_token(bool ia32, unsigned long ssp, unsigned long *new_ssp)
 void cet_restore_signal(struct sc_ext *sc);
 int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 #else
+static inline int prctl_cet(int option, u64 arg2) { return -EINVAL; }
 static inline int cet_setup_thread_shstk(struct task_struct *p,
 					 unsigned long clone_flags,
 					 unsigned long stack_size) { return 0; }
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 5a6aac9fa41f..9245bf629120 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -14,4 +14,8 @@
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
 
+#define ARCH_X86_CET_STATUS		0x3001
+#define ARCH_X86_CET_DISABLE		0x3002
+#define ARCH_X86_CET_LOCK		0x3003
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 4a9a7e7d00dc..2f60a28769f9 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -151,7 +151,7 @@ obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev-es.o
-obj-$(CONFIG_X86_CET)			+= cet.o
+obj-$(CONFIG_X86_CET)			+= cet.o cet_prctl.o
 
 ###
 # 64 bit specific files
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
new file mode 100644
index 000000000000..0030c63a08c0
--- /dev/null
+++ b/arch/x86/kernel/cet_prctl.c
@@ -0,0 +1,60 @@
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
+static int cet_copy_status_to_user(struct cet_status *cet, u64 __user *ubuf)
+{
+	u64 buf[3] = {};
+
+	if (cet->shstk_size) {
+		buf[0] |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
+		buf[1] = cet->shstk_base;
+		buf[2] = cet->shstk_size;
+	}
+
+	return copy_to_user(ubuf, buf, sizeof(buf));
+}
+
+int prctl_cet(int option, u64 arg2)
+{
+	struct cet_status *cet;
+
+	if (!cpu_feature_enabled(X86_FEATURE_CET))
+		return -ENOTSUPP;
+
+	cet = &current->thread.cet;
+
+	if (option == ARCH_X86_CET_STATUS)
+		return cet_copy_status_to_user(cet, (u64 __user *)arg2);
+
+	switch (option) {
+	case ARCH_X86_CET_DISABLE:
+		if (cet->locked)
+			return -EPERM;
+
+		if (arg2 & ~GNU_PROPERTY_X86_FEATURE_1_VALID)
+			return -EINVAL;
+		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
+			cet_disable_shstk();
+		return 0;
+
+	case ARCH_X86_CET_LOCK:
+		if (arg2)
+			return -EINVAL;
+		cet->locked = 1;
+		return 0;
+
+	default:
+		return -ENOSYS;
+	}
+}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 82ae42240392..263e2f1e70c0 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -980,14 +980,14 @@ unsigned long get_wchan(struct task_struct *p)
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled)
+			  unsigned long arg2)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
-		return set_cpuid_mode(task, cpuid_enabled);
+		return set_cpuid_mode(task, arg2);
 	}
 
-	return -EINVAL;
+	return prctl_cet(option, arg2);
 }
-- 
2.21.0

