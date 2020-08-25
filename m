Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5C250D1C
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgHYAaJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:30:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:12300 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgHYAaH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:30:07 -0400
IronPort-SDR: gy/2WkXL3S9xB8z5ppgOS/JPQLsFCSybJFfuy2ckhi1jeH0yeD7X2SqvO7/dUhYGg3S0b4IAno
 HeknaMxUj45A==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136075319"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="136075319"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:42 -0700
IronPort-SDR: EE6oepsxvnikXsSwobPjqAW0f7gzd28tdP2eRsPg2VsJbjIn0NtBo5mOEBfJT5pT51HdyWWX1P
 wBS5kbqd0ISg==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474135022"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:41 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v11 20/25] x86/cet/shstk: User-mode shadow stack support
Date:   Mon, 24 Aug 2020 17:25:35 -0700
Message-Id: <20200825002540.3351-21-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200825002540.3351-1-yu-cheng.yu@intel.com>
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds basic shadow stack enabling/disabling routines.  A task's
shadow stack is allocated from memory with VM_SHSTK flag and has a fixed
size of min(RLIMIT_STACK, 4GB).

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v11:
- Modify alloc_shstk() to take flags and pass to do_mmap().
  This is to be used by an arch_prctl() introduced later.

v10:
- Change no_cet_shstk to no_user_shstk.
- Limit shadow stack size to 4 GB, and round_up to PAGE_SIZE.
- Replace checking shstk_enabled with shstk_size being zero.
- WARN_ON_ONCE() when vm_munmap() fails.

v9:
- Change cpu_feature_enabled() to static_cpu_has().
- Merge cet_disable_shstk to cet_disable_free_shstk.
- Remove the empty slot at the top of the shadow stack, as it is not
  needed.
- Move do_mmap_locked() to alloc_shstk(), which is a static function.

v6:
- Create a function do_mmap_locked() for shadow stack allocation.

v2:
- Change noshstk to no_cet_shstk.

 arch/x86/include/asm/cet.h                    |  26 ++++
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/asm/processor.h              |   5 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/cet.c                         | 138 ++++++++++++++++++
 arch/x86/kernel/cpu/common.c                  |  28 ++++
 arch/x86/kernel/process.c                     |   1 +
 .../arch/x86/include/asm/disabled-features.h  |   8 +-
 8 files changed, 214 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/kernel/cet.c

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
new file mode 100644
index 000000000000..caac0687c8e4
--- /dev/null
+++ b/arch/x86/include/asm/cet.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CET_H
+#define _ASM_X86_CET_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+struct task_struct;
+/*
+ * Per-thread CET status
+ */
+struct cet_status {
+	unsigned long	shstk_base;
+	unsigned long	shstk_size;
+};
+
+#ifdef CONFIG_X86_INTEL_CET
+int cet_setup_shstk(void);
+void cet_disable_free_shstk(struct task_struct *p);
+#else
+static inline void cet_disable_free_shstk(struct task_struct *p) {}
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_CET_H */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 4ea8584682f9..a0e1b24cfa02 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -56,6 +56,12 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+#define DISABLE_SHSTK	0
+#else
+#define DISABLE_SHSTK	(1<<(X86_FEATURE_SHSTK & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -75,7 +81,7 @@
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
-#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP)
+#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP|DISABLE_SHSTK)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 01acbd63cad8..8c874d6ce871 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -27,6 +27,7 @@ struct vm86;
 #include <asm/unwind_hints.h>
 #include <asm/vmxfeatures.h>
 #include <asm/vdso/processor.h>
+#include <asm/cet.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
@@ -542,6 +543,10 @@ struct thread_struct {
 
 	unsigned int		sig_on_uaccess_err:1;
 
+#ifdef CONFIG_X86_INTEL_CET
+	struct cet_status	cet;
+#endif
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index e77261db2391..76f27f518266 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -145,6 +145,8 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
+obj-$(CONFIG_X86_INTEL_CET)		+= cet.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
new file mode 100644
index 000000000000..a1be8ccee1cc
--- /dev/null
+++ b/arch/x86/kernel/cet.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cet.c - Control-flow Enforcement (CET)
+ *
+ * Copyright (c) 2019, Intel Corporation.
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
+#include <asm/msr.h>
+#include <asm/user.h>
+#include <asm/fpu/internal.h>
+#include <asm/fpu/xstate.h>
+#include <asm/fpu/types.h>
+#include <asm/cet.h>
+
+static void start_update_msrs(void)
+{
+	fpregs_lock();
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		__fpregs_load_activate();
+}
+
+static void end_update_msrs(void)
+{
+	fpregs_unlock();
+}
+
+static unsigned long cet_get_shstk_addr(void)
+{
+	struct fpu *fpu = &current->thread.fpu;
+	unsigned long ssp = 0;
+
+	fpregs_lock();
+
+	if (fpregs_state_valid(fpu, smp_processor_id())) {
+		rdmsrl(MSR_IA32_PL3_SSP, ssp);
+	} else {
+		struct cet_user_state *p;
+
+		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
+		if (p)
+			ssp = p->user_ssp;
+	}
+
+	fpregs_unlock();
+	return ssp;
+}
+
+static unsigned long alloc_shstk(unsigned long size, int flags)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long addr, populate;
+
+	/* VM_SHSTK requires MAP_ANONYMOUS, MAP_PRIVATE */
+	flags |= MAP_ANONYMOUS | MAP_PRIVATE;
+
+	mmap_write_lock(mm);
+	addr = do_mmap(NULL, 0, size, PROT_READ, flags, VM_SHSTK, 0,
+		       &populate, NULL);
+	mmap_write_unlock(mm);
+
+	if (populate)
+		mm_populate(addr, populate);
+
+	return addr;
+}
+
+int cet_setup_shstk(void)
+{
+	unsigned long addr, size;
+	struct cet_status *cet = &current->thread.cet;
+
+	if (!static_cpu_has(X86_FEATURE_SHSTK))
+		return -EOPNOTSUPP;
+
+	size = round_up(min(rlimit(RLIMIT_STACK), 1UL << 32), PAGE_SIZE);
+	addr = alloc_shstk(size, 0);
+
+	if (IS_ERR_VALUE(addr))
+		return PTR_ERR((void *)addr);
+
+	cet->shstk_base = addr;
+	cet->shstk_size = size;
+
+	start_update_msrs();
+	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
+	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
+	end_update_msrs();
+	return 0;
+}
+
+void cet_disable_free_shstk(struct task_struct *tsk)
+{
+	struct cet_status *cet = &tsk->thread.cet;
+
+	if (!static_cpu_has(X86_FEATURE_SHSTK) ||
+	    !cet->shstk_size || !cet->shstk_base)
+		return;
+
+	if (!tsk->mm || (tsk->mm != current->mm))
+		return;
+
+	if (tsk == current) {
+		u64 msr_val;
+
+		start_update_msrs();
+		rdmsrl(MSR_IA32_U_CET, msr_val);
+		wrmsrl(MSR_IA32_U_CET, msr_val & ~CET_SHSTK_EN);
+		wrmsrl(MSR_IA32_PL3_SSP, 0);
+		end_update_msrs();
+	}
+
+	while (1) {
+		int r;
+
+		r = vm_munmap(cet->shstk_base, cet->shstk_size);
+
+		/*
+		 * Retry if mmap_lock is not available.
+		 */
+		if (r == -EINTR) {
+			cond_resched();
+			continue;
+		}
+
+		WARN_ON_ONCE(r);
+		break;
+	}
+	cet->shstk_base = 0;
+	cet->shstk_size = 0;
+}
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c5d6f17d9b9d..5f60ddaabc46 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -56,6 +56,7 @@
 #include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
+#include <asm/cet.h>
 #include <asm/uv/uv.h>
 
 #include "cpu.h"
@@ -509,6 +510,32 @@ static __init int setup_disable_pku(char *arg)
 __setup("nopku", setup_disable_pku);
 #endif /* CONFIG_X86_64 */
 
+static __always_inline void setup_cet(struct cpuinfo_x86 *c)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) &&
+	    !cpu_feature_enabled(X86_FEATURE_IBT))
+		return;
+
+	cr4_set_bits(X86_CR4_CET);
+}
+
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+static __init int setup_disable_shstk(char *s)
+{
+	/* require an exact match without trailing characters */
+	if (s[0] != '\0')
+		return 0;
+
+	if (!boot_cpu_has(X86_FEATURE_SHSTK))
+		return 1;
+
+	setup_clear_cpu_cap(X86_FEATURE_SHSTK);
+	pr_info("x86: 'no_user_shstk' specified, disabling user Shadow Stack\n");
+	return 1;
+}
+__setup("no_user_shstk", setup_disable_shstk);
+#endif
+
 /*
  * Some CPU features depend on higher CPUID levels, which may not always
  * be available due to CPUID level capping or broken virtualization
@@ -1544,6 +1571,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	x86_init_rdrand(c);
 	setup_pku(c);
+	setup_cet(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 994d8393f2f7..e41f1a468ee3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -42,6 +42,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
+#include <asm/cet.h>
 
 #include "process.h"
 
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 4ea8584682f9..a0e1b24cfa02 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -56,6 +56,12 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+#define DISABLE_SHSTK	0
+#else
+#define DISABLE_SHSTK	(1<<(X86_FEATURE_SHSTK & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -75,7 +81,7 @@
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
-#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP)
+#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP|DISABLE_SHSTK)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
-- 
2.21.0

