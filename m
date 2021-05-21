Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FA338D108
	for <lists+linux-arch@lfdr.de>; Sat, 22 May 2021 00:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhEUWRJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 18:17:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:55681 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhEUWQN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 18:16:13 -0400
IronPort-SDR: 3BEgX9McpAfickL0EZf3mHQKJbGPKuUTdmxjv/VCqiP9FAkqj4r05Pd6/rtXWkVhTwKdB63q7V
 w7Juuvuo4QbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201618786"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201618786"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:13:23 -0700
IronPort-SDR: K6AzeOaBXw6o2B0W4IVNFfcn0e1ZFZqulGTulQFN/BCKw9st0wR5M/umm28cMI9JiucurWsxV5
 yOnn1fqmjdGA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441116248"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:13:22 -0700
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
Subject: [PATCH v27 28/31] x86/cet/shstk: Add arch_prctl functions for shadow stack
Date:   Fri, 21 May 2021 15:12:08 -0700
Message-Id: <20210521221211.29077-29-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210521221211.29077-1-yu-cheng.yu@intel.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
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
 arch/x86/include/asm/cet.h        |  7 ++++
 arch/x86/include/uapi/asm/prctl.h |  4 +++
 arch/x86/kernel/Makefile          |  1 +
 arch/x86/kernel/cet_prctl.c       | 60 +++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c         |  6 ++--
 5 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/kernel/cet_prctl.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 2f7940d68ce3..c76a85fbd59f 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -13,6 +13,7 @@ struct task_struct;
 struct thread_shstk {
 	u64	base;
 	u64	size;
+	u64	locked:1;
 };
 
 #ifdef CONFIG_X86_SHADOW_STACK
@@ -41,6 +42,12 @@ static inline int setup_signal_shadow_stack(int ia32, void __user *restorer) { r
 static inline int restore_signal_shadow_stack(void) { return 0; }
 #endif
 
+#ifdef CONFIG_X86_SHADOW_STACK
+int prctl_cet(int option, u64 arg2);
+#else
+static inline int prctl_cet(int option, u64 arg2) { return -EINVAL; }
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_CET_H */
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
index b0e599102277..2741c91104ac 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o
+obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o cet_prctl.o
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
new file mode 100644
index 000000000000..b426d200e070
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
+static int cet_copy_status_to_user(struct thread_shstk *shstk, u64 __user *ubuf)
+{
+	u64 buf[3] = {};
+
+	if (shstk->size) {
+		buf[0] |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
+		buf[1] = shstk->base;
+		buf[2] = shstk->size;
+	}
+
+	return copy_to_user(ubuf, buf, sizeof(buf));
+}
+
+int prctl_cet(int option, u64 arg2)
+{
+	struct thread_shstk *shstk;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return -ENOTSUPP;
+
+	shstk = &current->thread.shstk;
+
+	if (option == ARCH_X86_CET_STATUS)
+		return cet_copy_status_to_user(shstk, (u64 __user *)arg2);
+
+	switch (option) {
+	case ARCH_X86_CET_DISABLE:
+		if (shstk->locked)
+			return -EPERM;
+
+		if (arg2 & ~GNU_PROPERTY_X86_FEATURE_1_VALID)
+			return -EINVAL;
+		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
+			shstk_disable();
+		return 0;
+
+	case ARCH_X86_CET_LOCK:
+		if (arg2)
+			return -EINVAL;
+		shstk->locked = 1;
+		return 0;
+
+	default:
+		return -ENOSYS;
+	}
+}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 7a583a28ddb2..821cf5221f4f 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -990,14 +990,14 @@ unsigned long get_wchan(struct task_struct *p)
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

