Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5998E30E68A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 00:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhBCXBK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 18:01:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:30209 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233441AbhBCW74 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 17:59:56 -0500
IronPort-SDR: I8lYm30ByER0EZPrT8GWsZAMu+jbuWNbAmxXQeHhFRhj3SGVbhaBJMcX4F0s/fmQ9MRf+ujMXV
 JiG5CFmYitSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="242642380"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="242642380"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:56:34 -0800
IronPort-SDR: Yh9CmSZxqXNMgSvUfV0e81y8JRwS3SqfTjxFvOEoH10Iho1h4OUwl2ERKxGQHevbgStzsfHJKc
 /HjiOnUu1YGQ==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="507921174"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:56:34 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v19 24/25] x86/cet/shstk: Add arch_prctl functions for shadow stack
Date:   Wed,  3 Feb 2021 14:55:46 -0800
Message-Id: <20210203225547.32221-25-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210203225547.32221-1-yu-cheng.yu@intel.com>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
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
---
 arch/x86/include/asm/cet.h        |  3 ++
 arch/x86/include/uapi/asm/prctl.h |  4 +++
 arch/x86/kernel/Makefile          |  2 +-
 arch/x86/kernel/cet_prctl.c       | 60 +++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c         |  6 ++--
 5 files changed, 71 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/kernel/cet_prctl.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index ec4b5e62d0ce..16870e5bc8eb 100644
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
 int cet_setup_thread_shstk(struct task_struct *p, unsigned long clone_flags);
 void cet_disable_shstk(void);
@@ -25,6 +27,7 @@ int cet_verify_rstor_token(bool ia32, unsigned long ssp, unsigned long *new_ssp)
 void cet_restore_signal(struct sc_ext *sc);
 int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 #else
+static inline int prctl_cet(int option, u64 arg2) { return -EINVAL; }
 static inline int cet_setup_thread_shstk(struct task_struct *p,
 					 unsigned long clone_flags) { return 0; }
 static inline void cet_disable_shstk(void) {}
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
index 3af6b36e1a5c..9e11e5f589f3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -979,14 +979,14 @@ unsigned long get_wchan(struct task_struct *p)
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

