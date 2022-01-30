Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE74A3A39
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356964AbiA3VZj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:25:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:52029 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356951AbiA3VY2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577868; x=1675113868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=nKIQtVTcJcJc4kRj9os/sAR9Nug8XbfOG4wi9emXZyE=;
  b=gIY6kBLkheGSetWY1Ar+Na5gX4QHM+BozZI73MFRP5QWTRvT3+oIvadC
   OHR5ecKzxyEjSbGCXicJi46Vw+FcUDUSySYrASm9ZZ64NwYEFaYc/kM+3
   zgZmhN0+DGuTec1D509KLqW/2gv7IY2izzmvpwRZsp4lzCgva6LpaJbNj
   cBI6aowr7jMiIwUuRFYbVR255289+d2IyWlnk8T2sS9EZM55wuzDvhKsl
   ihGrsD6fWSq8WdSg+G6KyP9ZjssdvrBYs70lS6k/Zy9IJty2dnb+MbpvZ
   +EBJmndfsfbi8SRK0vLA9lid30D+rD5Ec9kdyupyR8kDZsq0Djzna/XU3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104968"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104968"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856894"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:05 -0800
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
Subject: [PATCH 25/35] x86/cet/shstk: Add user-mode shadow stack support
Date:   Sun, 30 Jan 2022 13:18:28 -0800
Message-Id: <20220130211838.8382-26-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Introduce basic shadow stack enabling/disabling/allocation routines.
A task's shadow stack is allocated from memory with VM_SHADOW_STACK flag
and has a fixed size of min(RLIMIT_STACK, 4GB).

Add the user shadow stack MSRs to the xsave helpers, so they can be used
to implement the functionality.

Keep the task's shadow stack address and size in thread_struct. This will
be copied when cloning new threads, but needs to be cleared during exec,
so add a function to do this.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

v1:
 - Switch to xsave helpers.
 - Expand commit log.

Yu-cheng v30:
 - Remove superfluous comments for struct thread_shstk.
 - Replace 'populate' with 'unused'.

Yu-cheng v28:
 - Update shstk_setup() with wrmsrl_safe(), returns success when shadow
   stack feature is not present (since this is a setup function).

Yu-cheng v27:
 - Change 'struct cet_status' to 'struct thread_shstk', and change member
   types from unsigned long to u64.
 - Re-order local variables in reverse order of length.
 - WARN_ON_ONCE() when vm_munmap() fails.

 arch/x86/include/asm/cet.h       |  29 ++++++
 arch/x86/include/asm/processor.h |   5 ++
 arch/x86/kernel/Makefile         |   1 +
 arch/x86/kernel/fpu/xstate.c     |   5 +-
 arch/x86/kernel/process_64.c     |   2 +
 arch/x86/kernel/shstk.c          | 149 +++++++++++++++++++++++++++++++
 6 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/kernel/shstk.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
new file mode 100644
index 000000000000..de90e4ae083a
--- /dev/null
+++ b/arch/x86/include/asm/cet.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CET_H
+#define _ASM_X86_CET_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+struct task_struct;
+
+struct thread_shstk {
+	u64	base;
+	u64	size;
+};
+
+#ifdef CONFIG_X86_SHADOW_STACK
+int shstk_setup(void);
+void shstk_free(struct task_struct *p);
+int shstk_disable(void);
+void reset_thread_shstk(void);
+#else
+static inline void shstk_setup(void) {}
+static inline void shstk_free(struct task_struct *p) {}
+static inline void shstk_disable(void) {}
+static inline void reset_thread_shstk(void) {}
+#endif /* CONFIG_X86_SHADOW_STACK */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_CET_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2c5f12ae7d04..a9f4e9c4ca81 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -27,6 +27,7 @@ struct vm86;
 #include <asm/unwind_hints.h>
 #include <asm/vmxfeatures.h>
 #include <asm/vdso/processor.h>
+#include <asm/cet.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
@@ -528,6 +529,10 @@ struct thread_struct {
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
index 6aef9ee28a39..d60ae6c365c7 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -153,6 +153,7 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
 obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
 
+obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c5e20e0d0725..25b1b0c417fd 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1871,7 +1871,10 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
 static u64 *__get_xsave_member(void *xstate, u32 msr)
 {
 	switch (msr) {
-	/* Currently there are no MSR's supported */
+	case MSR_IA32_PL3_SSP:
+		return &((struct cet_user_state *)xstate)->user_ssp;
+	case MSR_IA32_U_CET:
+		return &((struct cet_user_state *)xstate)->user_cet;
 	default:
 		WARN_ONCE(1, "x86/fpu: unsupported xstate msr (%u)\n", msr);
 		return NULL;
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3402edec236c..f05fe27d4967 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -514,6 +514,8 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		load_gs_index(__USER_DS);
 	}
 
+	reset_thread_shstk();
+
 	loadsegment(fs, 0);
 	loadsegment(es, _ds);
 	loadsegment(ds, _ds);
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
new file mode 100644
index 000000000000..4e8686ed885f
--- /dev/null
+++ b/arch/x86/kernel/shstk.c
@@ -0,0 +1,149 @@
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
+#include <asm/special_insns.h>
+#include <asm/fpu/api.h>
+
+static unsigned long alloc_shstk(unsigned long size)
+{
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr, unused;
+
+	mmap_write_lock(mm);
+	addr = do_mmap(NULL, 0, size, PROT_READ, flags, VM_SHADOW_STACK, 0,
+		       &unused, NULL);
+	mmap_write_unlock(mm);
+
+	return addr;
+}
+
+static void unmap_shadow_stack(u64 base, u64 size)
+{
+	while (1) {
+		int r;
+
+		r = vm_munmap(base, size);
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
+}
+
+int shstk_setup(void)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	unsigned long addr, size;
+	void *xstate;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
+	    shstk->size ||
+	    shstk->base)
+		return 1;
+
+	size = PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
+	addr = alloc_shstk(size);
+	if (IS_ERR_VALUE(addr))
+		return 1;
+
+	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
+	err = xsave_wrmsrl(xstate, MSR_IA32_PL3_SSP, addr + size);
+	if (!err)
+		err = xsave_wrmsrl(xstate, MSR_IA32_U_CET, CET_SHSTK_EN);
+	end_update_xsave_msrs();
+
+	if (err) {
+		/*
+		 * Don't leak shadow stack if something went wrong with writing the
+		 * msrs. Warn about it because things may be in a weird state.
+		 */
+		WARN_ON_ONCE(1);
+		unmap_shadow_stack(addr, size);
+		return 1;
+	}
+
+	shstk->base = addr;
+	shstk->size = size;
+	return 0;
+}
+
+void reset_thread_shstk(void)
+{
+	memset(&current->thread.shstk, 0, sizeof(struct thread_shstk));
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
+	unmap_shadow_stack(shstk->base, shstk->size);
+
+	shstk->base = 0;
+	shstk->size = 0;
+}
+
+int shstk_disable(void)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	void *xstate;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
+	    !shstk->size ||
+	    !shstk->base)
+		return 1;
+
+	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
+	err = xsave_set_clear_bits_msrl(xstate, MSR_IA32_U_CET, 0, CET_SHSTK_EN);
+	if (!err)
+		err = xsave_wrmsrl(xstate, MSR_IA32_PL3_SSP, 0);
+	end_update_xsave_msrs();
+
+	if (err)
+		return 1;
+
+	shstk_free(current);
+	return 0;
+}
-- 
2.17.1

