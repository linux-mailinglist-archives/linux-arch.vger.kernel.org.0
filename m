Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A003A69BCDE
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 22:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBRVVi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 16:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjBRVVD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 16:21:03 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D6713D43;
        Sat, 18 Feb 2023 13:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676755109; x=1708291109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Fx30aEuXtnObd4pLstduxowlzqHzXgwWfGXPPH6LT+k=;
  b=L0pawwVwKKj/khbEmTJSmJsltpd7PdpshT+8UZIeZ1clspIp2Vm15lK8
   GVXYonD0J1Fa4ak5OeSKfb+ht4B6I2lrb8d4MD+2nYduXicBbZ3zpkzj8
   8aJWYjNKLlFoorvLUTi7TIMF/FS9Hw8SREEoRR4ZuWjjkRlWOR9R75gV/
   9Iflq7F5VXA4BI70A188nHSYdtS9D09BIzGYis6RHeZWdCbF3+MHQyLB1
   0qcXwl3pEpRzkeD+mRNnyt/0BL7nN6q1Otcbe3SfhzbuI8vGTZ+GC7UAu
   p1r6uJuk/qPGxfHbZN7+qSJ2+k5EWvOXdCurisiVIsPBx1QN9OzMy29RF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418427720"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="418427720"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="664241712"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="664241712"
Received: from adityava-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.80.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:19 -0800
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
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v6 29/41] x86/shstk: Add user-mode shadow stack support
Date:   Sat, 18 Feb 2023 13:14:21 -0800
Message-Id: <20230218211433.26859-30-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Introduce basic shadow stack enabling/disabling/allocation routines.
A task's shadow stack is allocated from memory with VM_SHADOW_STACK flag
and has a fixed size of min(RLIMIT_STACK, 4GB).

Keep the task's shadow stack address and size in thread_struct. This will
be copied when cloning new threads, but needs to be cleared during exec,
so add a function to do this.

Do not support IA32 emulation or x32.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---
v5:
 - Switch to EOPNOTSUPP
 - Use MAP_ABOVE4G
 - Move set_clr_bits_msrl() to patch where it is first used

v4:
 - Just set MSR_IA32_U_CET when disabling shadow stack, since we don't
   have IBT yet. (Peterz)

v3:
 - Use define for set_clr_bits_msrl() (Kees)
 - Make some functions static (Kees)
 - Change feature_foo() to features_foo() (Kees)
 - Centralize shadow stack size rlimit checks (Kees)
 - Disable x32 support

v2:
 - Get rid of unnecessary shstk->base checks
 - Don't support IA32 emulation
---
 arch/x86/include/asm/processor.h  |   2 +
 arch/x86/include/asm/shstk.h      |   7 ++
 arch/x86/include/uapi/asm/prctl.h |   3 +
 arch/x86/kernel/shstk.c           | 145 ++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index bd16e012b3e9..ff98cd6d5af2 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -479,6 +479,8 @@ struct thread_struct {
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 	unsigned long		features;
 	unsigned long		features_locked;
+
+	struct thread_shstk	shstk;
 #endif
 
 	/* Floating point and extended processor state */
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index ec753809f074..2b1f7c9b9995 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -8,12 +8,19 @@
 struct task_struct;
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK
+struct thread_shstk {
+	u64	base;
+	u64	size;
+};
+
 long shstk_prctl(struct task_struct *task, int option, unsigned long features);
 void reset_thread_features(void);
+void shstk_free(struct task_struct *p);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
 static inline void reset_thread_features(void) {}
+static inline void shstk_free(struct task_struct *p) {}
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index b2b3b7200b2d..7dfd9dc00509 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -26,4 +26,7 @@
 #define ARCH_SHSTK_DISABLE		0x5002
 #define ARCH_SHSTK_LOCK			0x5003
 
+/* ARCH_SHSTK_ features bits */
+#define ARCH_SHSTK_SHSTK		(1ULL <<  0)
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 41ed6552e0a5..3cb85224d856 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -8,14 +8,159 @@
 
 #include <linux/sched.h>
 #include <linux/bitops.h>
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
+#include <asm/fpu/xstate.h>
+#include <asm/fpu/types.h>
+#include <asm/shstk.h>
+#include <asm/special_insns.h>
+#include <asm/fpu/api.h>
 #include <asm/prctl.h>
 
+static bool features_enabled(unsigned long features)
+{
+	return current->thread.features & features;
+}
+
+static void features_set(unsigned long features)
+{
+	current->thread.features |= features;
+}
+
+static void features_clr(unsigned long features)
+{
+	current->thread.features &= ~features;
+}
+
+static unsigned long alloc_shstk(unsigned long size)
+{
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_ABOVE4G;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr, unused;
+
+	mmap_write_lock(mm);
+	addr = do_mmap(NULL, addr, size, PROT_READ, flags,
+		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
+
+	mmap_write_unlock(mm);
+
+	return addr;
+}
+
+static unsigned long adjust_shstk_size(unsigned long size)
+{
+	if (size)
+		return PAGE_ALIGN(size);
+
+	return PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
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
+static int shstk_setup(void)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	unsigned long addr, size;
+
+	/* Already enabled */
+	if (features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	/* Also not supported for 32 bit and x32 */
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_32bit_syscall())
+		return -EOPNOTSUPP;
+
+	size = adjust_shstk_size(0);
+	addr = alloc_shstk(size);
+	if (IS_ERR_VALUE(addr))
+		return PTR_ERR((void *)addr);
+
+	fpregs_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
+	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
+	fpregs_unlock();
+
+	shstk->base = addr;
+	shstk->size = size;
+	features_set(ARCH_SHSTK_SHSTK);
+
+	return 0;
+}
+
 void reset_thread_features(void)
 {
+	memset(&current->thread.shstk, 0, sizeof(struct thread_shstk));
 	current->thread.features = 0;
 	current->thread.features_locked = 0;
 }
 
+void shstk_free(struct task_struct *tsk)
+{
+	struct thread_shstk *shstk = &tsk->thread.shstk;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !features_enabled(ARCH_SHSTK_SHSTK))
+		return;
+
+	if (!tsk->mm)
+		return;
+
+	unmap_shadow_stack(shstk->base, shstk->size);
+}
+
+static int shstk_disable(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return -EOPNOTSUPP;
+
+	/* Already disabled? */
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	fpregs_lock_and_load();
+	/* Disable WRSS too when disabling shadow stack */
+	wrmsrl(MSR_IA32_U_CET, 0);
+	wrmsrl(MSR_IA32_PL3_SSP, 0);
+	fpregs_unlock();
+
+	shstk_free(current);
+	features_clr(ARCH_SHSTK_SHSTK);
+
+	return 0;
+}
+
 long shstk_prctl(struct task_struct *task, int option, unsigned long features)
 {
 	if (option == ARCH_SHSTK_LOCK) {
-- 
2.17.1

