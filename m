Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EE672D62A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbjFMARA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbjFMAQS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:16:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D632959;
        Mon, 12 Jun 2023 17:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615211; x=1718151211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BugAl8HBv2gDjezo8BApRaTr6a0cYuyYBztBA+16s0k=;
  b=mpCLsY8TSF9hf/sLmIsPKiD8huZmdyRhzYOMig4HbAnedB0CabA+ST70
   118AvCIZ518tWZ0k41NXJNYbSyKSHL0BW0Kp7Q6+4kqfSq3xHljhxN0vI
   0KR0FbY4cnEG6UHbdalvPFGOIS56tsKhQyJU7ApiHRmtQi0XA/ZujqDif
   JgAkGZ5srqLg9DgNslzYF6PlvmpknF8RPFb0UCDS2NYUJsJ9+bH9pxHkp
   Z0D97iVpaqg50+0SHdMoXGApqBV66wuC1jPD7sx4XCO+e+gCyY+QqfmoA
   eRCQoHy/GeFoZI2ZME67HY21Zgcs0gsni4lUvoWlHNk2whTvzqq1Be7Lm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557315"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557315"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671093"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671093"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:31 -0700
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
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 28/42] x86/shstk: Add user-mode shadow stack support
Date:   Mon, 12 Jun 2023 17:10:54 -0700
Message-Id: <20230613001108.3040476-29-rick.p.edgecombe@intel.com>
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

Introduce basic shadow stack enabling/disabling/allocation routines.
A task's shadow stack is allocated from memory with VM_SHADOW_STACK flag
and has a fixed size of min(RLIMIT_STACK, 4GB).

Keep the task's shadow stack address and size in thread_struct. This will
be copied when cloning new threads, but needs to be cleared during exec,
so add a function to do this.

32 bit shadow stack is not expected to have many users and it will
complicate the signal implementation. So do not support IA32 emulation
or x32.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/processor.h  |   2 +
 arch/x86/include/asm/shstk.h      |   7 ++
 arch/x86/include/uapi/asm/prctl.h |   3 +
 arch/x86/kernel/shstk.c           | 145 ++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 407d5551b6a7..2a5ec5750ba7 100644
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
index 1cd44ecc9ce0..6a8e0e1bff4a 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -34,4 +34,7 @@
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
2.34.1

