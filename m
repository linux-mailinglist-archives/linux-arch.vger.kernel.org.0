Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9A5F0089
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiI2WfQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiI2WeL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:34:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9291BB6F8;
        Thu, 29 Sep 2022 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490685; x=1696026685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=giGkTaTZmpDnHAjW9RaJP2B5vpHIjFWnvaB2xH31zds=;
  b=CV/2/N6HiWGhYFXuFI1FuR5jxJsoFT4v20kjIBylP4zQ5kbUhJgTFxzJ
   tUecb3bncCLsrhlqhmktByZ6T/TDCge8uuw2IaUdAyK6NHSzF+JNGY2f5
   B5hcDfmY6u73W6oiYmEHOStt96169wp5CPwOHeMzNcmZAF15s2shg/URs
   kh8Y3t9XBf2Dauo+u4l9bYdZjL9qiBdBUBc77hYOeyganq0IZuZGPvqSg
   ZiqODak3OIZS/I6Jf7TEC8wjU+Dd85snVyrXqSH1mtRVrvVIdio/r483r
   Y9x6/HSMjdWXyqA3d9JjoJPfS6/4xfPN3BhmJuz+ryNOMjexgeIxQYeQ+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182043"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182043"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016310"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016310"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:36 -0700
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
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 24/39] x86/cet/shstk: Add user-mode shadow stack support
Date:   Thu, 29 Sep 2022 15:29:21 -0700
Message-Id: <20220929222936.14584-25-rick.p.edgecombe@intel.com>
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

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Introduce basic shadow stack enabling/disabling/allocation routines.
A task's shadow stack is allocated from memory with VM_SHADOW_STACK flag
and has a fixed size of min(RLIMIT_STACK, 4GB).

Keep the task's shadow stack address and size in thread_struct. This will
be copied when cloning new threads, but needs to be cleared during exec,
so add a function to do this.

Do not support IA32 emulation.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---

v2:
 - Get rid of unnessary shstk->base checks
 - Don't support IA32 emulation

v1:
 - Switch to xsave helpers.
 - Expand commit log.

Yu-cheng v30:
 - Remove superfluous comments for struct thread_shstk.
 - Replace 'populate' with 'unused'.

Yu-cheng v28:
 - Update shstk_setup() with wrmsrl_safe(), returns success when shadow
   stack feature is not present (since this is a setup function).

 arch/x86/include/asm/cet.h        |  13 +++
 arch/x86/include/asm/msr.h        |  11 +++
 arch/x86/include/asm/processor.h  |   5 ++
 arch/x86/include/uapi/asm/prctl.h |   2 +
 arch/x86/kernel/Makefile          |   2 +
 arch/x86/kernel/process_64.c      |   2 +
 arch/x86/kernel/shstk.c           | 143 ++++++++++++++++++++++++++++++
 7 files changed, 178 insertions(+)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 0fa4dbc98c49..a4a1f4c0089b 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -7,12 +7,25 @@
 
 struct task_struct;
 
+struct thread_shstk {
+	u64	base;
+	u64	size;
+};
+
 #ifdef CONFIG_X86_SHADOW_STACK
 long cet_prctl(struct task_struct *task, int option,
 		      unsigned long features);
+int shstk_setup(void);
+void shstk_free(struct task_struct *p);
+int shstk_disable(void);
+void reset_thread_shstk(void);
 #else
 static inline long cet_prctl(struct task_struct *task, int option,
 		      unsigned long features) { return -EINVAL; }
+static inline int shstk_setup(void) { return -EOPNOTSUPP; }
+static inline void shstk_free(struct task_struct *p) {}
+static inline int shstk_disable(void) { return -EOPNOTSUPP; }
+static inline void reset_thread_shstk(void) {}
 #endif /* CONFIG_X86_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 65ec1965cd28..a9cb4c434e60 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -310,6 +310,17 @@ void msrs_free(struct msr *msrs);
 int msr_set_bit(u32 msr, u8 bit);
 int msr_clear_bit(u32 msr, u8 bit);
 
+static inline void set_clr_bits_msrl(u32 msr, u64 set, u64 clear)
+{
+	u64 val, new_val;
+
+	rdmsrl(msr, val);
+	new_val = (val & ~clear) | set;
+
+	if (new_val != val)
+		wrmsrl(msr, new_val);
+}
+
 #ifdef CONFIG_SMP
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a92bf76edafe..3a0c9d9d4d1d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -27,6 +27,7 @@ struct vm86;
 #include <asm/unwind_hints.h>
 #include <asm/vmxfeatures.h>
 #include <asm/vdso/processor.h>
+#include <asm/cet.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
@@ -533,6 +534,10 @@ struct thread_struct {
 	unsigned long		features;
 	unsigned long		features_locked;
 
+#ifdef CONFIG_X86_SHADOW_STACK
+	struct thread_shstk	shstk;
+#endif
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 028158e35269..41af3a8c4fa4 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -26,4 +26,6 @@
 #define ARCH_CET_DISABLE		0x4002
 #define ARCH_CET_LOCK			0x4003
 
+#define CET_SHSTK			0x1
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index a20a5ebfacd7..8950d1f71226 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -139,6 +139,8 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
+obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 8fa2c2b7de65..be544b4b4c8b 100644
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
index e3276ac9e9b9..a0b8d4adb2bf 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -8,8 +8,151 @@
 
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
+#include <asm/cet.h>
+#include <asm/special_insns.h>
+#include <asm/fpu/api.h>
 #include <asm/prctl.h>
 
+static bool feature_enabled(unsigned long features)
+{
+	return current->thread.features & features;
+}
+
+static void feature_set(unsigned long features)
+{
+	current->thread.features |= features;
+}
+
+static void feature_clr(unsigned long features)
+{
+	current->thread.features &= ~features;
+}
+
+static unsigned long alloc_shstk(unsigned long size)
+{
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
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
+
+	/* Already enabled */
+	if (feature_enabled(CET_SHSTK))
+		return 0;
+
+	/* Also not supported for 32 bit */
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) || in_ia32_syscall())
+		return -EOPNOTSUPP;
+
+	size = PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
+	addr = alloc_shstk(size);
+	if (IS_ERR_VALUE(addr))
+		return PTR_ERR((void *)addr);
+
+	fpu_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
+	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
+	fpregs_unlock();
+
+	shstk->base = addr;
+	shstk->size = size;
+	feature_set(CET_SHSTK);
+
+	return 0;
+}
+
+void reset_thread_shstk(void)
+{
+	memset(&current->thread.shstk, 0, sizeof(struct thread_shstk));
+	current->thread.features = 0;
+	current->thread.features_locked = 0;
+}
+
+void shstk_free(struct task_struct *tsk)
+{
+	struct thread_shstk *shstk = &tsk->thread.shstk;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
+	    !feature_enabled(CET_SHSTK))
+		return;
+
+	if (!tsk->mm)
+		return;
+
+	unmap_shadow_stack(shstk->base, shstk->size);
+}
+
+int shstk_disable(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return -EOPNOTSUPP;
+
+	/* Already disabled? */
+	if (!feature_enabled(CET_SHSTK))
+		return 0;
+
+	fpu_lock_and_load();
+	/* Disable WRSS too when disabling shadow stack */
+	set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_SHSTK_EN);
+	wrmsrl(MSR_IA32_PL3_SSP, 0);
+	fpregs_unlock();
+
+	shstk_free(current);
+	feature_clr(CET_SHSTK);
+
+	return 0;
+}
+
 long cet_prctl(struct task_struct *task, int option, unsigned long features)
 {
 	if (option == ARCH_CET_LOCK) {
-- 
2.17.1

