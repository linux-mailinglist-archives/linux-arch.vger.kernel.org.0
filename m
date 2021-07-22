Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB70A3D2E3F
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 22:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhGVUMx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 16:12:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:54383 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhGVUM2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 16:12:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="275560619"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="275560619"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:53:03 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="502035499"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:53:02 -0700
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
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v28 23/32] x86/cet/shstk: Add user-mode shadow stack support
Date:   Thu, 22 Jul 2021 13:52:10 -0700
Message-Id: <20210722205219.7934-24-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210722205219.7934-1-yu-cheng.yu@intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce basic shadow stack enabling/disabling/allocation routines.
A task's shadow stack is allocated from memory with VM_SHADOW_STACK flag
and has a fixed size of min(RLIMIT_STACK, 4GB).

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v28:
- Update shstk_setup() with wrmsrl_safe().  Return success when shadow
  stack feature is not present, because this is a setup init function
  and when the feature is not present, no setup is necessary.

v27:
- Change 'struct cet_status' to 'struct thread_shstk', and change member
  types from unsigned long to u64.
- Re-order local variables in reverse order of length.
- WARN_ON_ONCE() when vm_munmap() fails.

 arch/x86/include/asm/cet.h       |  30 +++++++
 arch/x86/include/asm/processor.h |   5 ++
 arch/x86/kernel/Makefile         |   1 +
 arch/x86/kernel/shstk.c          | 134 +++++++++++++++++++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/kernel/shstk.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
new file mode 100644
index 000000000000..6432baf4de1f
--- /dev/null
+++ b/arch/x86/include/asm/cet.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CET_H
+#define _ASM_X86_CET_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+struct task_struct;
+
+/*
+ * Per-thread CET status
+ */
+struct thread_shstk {
+	u64	base;
+	u64	size;
+};
+
+#ifdef CONFIG_X86_SHADOW_STACK
+int shstk_setup(void);
+void shstk_free(struct task_struct *p);
+void shstk_disable(void);
+#else
+static inline int shstk_setup(void) { return 0; }
+static inline void shstk_free(struct task_struct *p) {}
+static inline void shstk_disable(void) {}
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_CET_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f3020c54e2cb..10497634b7a4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -27,6 +27,7 @@ struct vm86;
 #include <asm/unwind_hints.h>
 #include <asm/vmxfeatures.h>
 #include <asm/vdso/processor.h>
+#include <asm/cet.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
@@ -527,6 +528,10 @@ struct thread_struct {
 	 */
 	u32			pkru;
 
+#ifdef CONFIG_X86_SHADOW_STACK
+	struct thread_shstk	shstk;
+#endif
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3e625c61f008..9e064845e497 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
+obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
new file mode 100644
index 000000000000..5993aa8db338
--- /dev/null
+++ b/arch/x86/kernel/shstk.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * shstk.c - Intel shadow stack support
+ *
+ * Copyright (c) 2021, Intel Corporation.
+ * Yu-cheng Yu <yu-cheng.yu@intel.com>
+ */
+
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/sched/signal.h>
+#include <linux/compat.h>
+#include <linux/sizes.h>
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
+		fpregs_restore_userregs();
+}
+
+static void end_update_msrs(void)
+{
+	fpregs_unlock();
+}
+
+static unsigned long alloc_shstk(unsigned long size)
+{
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr, populate;
+
+	mmap_write_lock(mm);
+	addr = do_mmap(NULL, 0, size, PROT_READ, flags, VM_SHADOW_STACK, 0,
+		       &populate, NULL);
+	mmap_write_unlock(mm);
+
+	return addr;
+}
+
+int shstk_setup(void)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	unsigned long addr, size;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return 0;
+
+	size = round_up(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G), PAGE_SIZE);
+	addr = alloc_shstk(size);
+	if (IS_ERR_VALUE(addr))
+		return PTR_ERR((void *)addr);
+
+	start_update_msrs();
+	err = wrmsrl_safe(MSR_IA32_PL3_SSP, addr + size);
+	if (!err)
+		wrmsrl_safe(MSR_IA32_U_CET, CET_SHSTK_EN);
+	end_update_msrs();
+
+	if (!err) {
+		shstk->base = addr;
+		shstk->size = size;
+	}
+
+	return err;
+}
+
+void shstk_free(struct task_struct *tsk)
+{
+	struct thread_shstk *shstk = &tsk->thread.shstk;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
+	    !shstk->size ||
+	    !shstk->base)
+		return;
+
+	if (!tsk->mm)
+		return;
+
+	while (1) {
+		int r;
+
+		r = vm_munmap(shstk->base, shstk->size);
+
+		/*
+		 * vm_munmap() returns -EINTR when mmap_lock is held by
+		 * something else, and that lock should not be held for a
+		 * long time.  Retry it for the case.
+		 */
+		if (r == -EINTR) {
+			cond_resched();
+			continue;
+		}
+
+		/*
+		 * For all other types of vm_munmap() failure, either the
+		 * system is out of memory or there is bug.
+		 */
+		WARN_ON_ONCE(r);
+		break;
+	}
+
+	shstk->base = 0;
+	shstk->size = 0;
+}
+
+void shstk_disable(void)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	u64 msr_val;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
+	    !shstk->size ||
+	    !shstk->base)
+		return;
+
+	start_update_msrs();
+	rdmsrl(MSR_IA32_U_CET, msr_val);
+	wrmsrl(MSR_IA32_U_CET, msr_val & ~CET_SHSTK_EN);
+	wrmsrl(MSR_IA32_PL3_SSP, 0);
+	end_update_msrs();
+
+	shstk_free(current);
+}
-- 
2.21.0

