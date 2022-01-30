Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A269C4A3A46
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356743AbiA3VZw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:25:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:9102 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356634AbiA3VZJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577909; x=1675113909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=s08st2zzx9YvkrATdX2s27PCtQcWcePp2JHFEXn/D9c=;
  b=NtEouAonbUUIr1DCQByPk5TB25Ord/NwRE36BnwXhzRYjHgYivTg7/fX
   rKF7MKN2XQ1OvjOUs35NtcxvBaZXhS9MEMIcZPDY2aOJmK/qfZ1Rl6T0W
   gXVjq0TXHpU9zK5QDy5P8ScAaUArWGuoLsXRGttcZVMW5Ayl5csOHoYKM
   8lOoUuCwwRVqRagJl6DBxHeEGOpzKHDPrNEfkcwoCMSRT2D+LW0xgHUYX
   vN6uwtJQmQGO0IJ6epEyPv5HDdhqOQtxJSCaKkak2w9BCVYKIrktQ3FDr
   jFEVhPfU9gpaiPirUcPxZ/L3Kb7AdKxfYdc61oRRSDeOP5e2SFEP51TH2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="310685836"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="310685836"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536857021"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:13 -0800
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH 34/35] x86/cet/shstk: Support wrss for userspace
Date:   Sun, 30 Jan 2022 13:18:37 -0800
Message-Id: <20220130211838.8382-35-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For the current shadow stack implementation, shadow stacks contents cannot
be arbitrarily provisioned with data. This property helps apps protect
themselves better, but also restricts any potential apps that may want to
do exotic things at the expense of a little security.

The x86 shadow stack feature introduces a new instruction, wrss, which
can be enabled to write directly to shadow stack permissioned memory from
userspace. Allow it to get enabled via the prctl interface.

Only enable the userspace wrss instruction, which allows writes to
userspace shadow stacks from userspace. Do not allow it to be enabled
independently of shadow stack, as HW does not support using WRSS when
shadow stack is disabled.

Prevent shadow stack's from becoming executable to assist apps who want
W^X enforced. Add an arch_validate_flags() implementation to handle the
check. Rename the uapi/asm/mman.h header guard to be able to use it for
arch/x86/include/asm/mman.h where the arch_validate_flags() will be.

From a fault handler perspective, WRSS will behave very similar to WRUSS,
which is treated like a user access from a PF err code perspective.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v1:
 - New patch.

 arch/x86/include/asm/cet.h          |  3 +++
 arch/x86/include/asm/mman.h         |  5 ++++-
 arch/x86/include/uapi/asm/prctl.h   |  2 +-
 arch/x86/kernel/elf_feature_prctl.c |  6 +++++
 arch/x86/kernel/shstk.c             | 35 ++++++++++++++++++++++++++++-
 5 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index cbc7cfcba5dc..c8ff0bd5f5bc 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -10,6 +10,7 @@ struct task_struct;
 struct thread_shstk {
 	u64	base;
 	u64	size;
+	bool	wrss;
 };
 
 #ifdef CONFIG_X86_SHADOW_STACK
@@ -19,6 +20,7 @@ int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 void shstk_free(struct task_struct *p);
 int shstk_disable(void);
 void reset_thread_shstk(void);
+int wrss_control(bool enable);
 int shstk_setup_rstor_token(bool proc32, unsigned long restorer,
 			    unsigned long *new_ssp);
 int shstk_check_rstor_token(bool proc32, unsigned long *new_ssp);
@@ -32,6 +34,7 @@ static inline int shstk_alloc_thread_stack(struct task_struct *p,
 static inline void shstk_free(struct task_struct *p) {}
 static inline void shstk_disable(void) {}
 static inline void reset_thread_shstk(void) {}
+static inline void wrss_control(bool enable) {}
 static inline int shstk_setup_rstor_token(bool proc32, unsigned long restorer,
 					  unsigned long *new_ssp) { return 0; }
 static inline int shstk_check_rstor_token(bool proc32,
diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
index b44fe31deb3a..c05951a36d93 100644
--- a/arch/x86/include/asm/mman.h
+++ b/arch/x86/include/asm/mman.h
@@ -8,7 +8,10 @@
 #ifdef CONFIG_X86_SHADOW_STACK
 static inline bool arch_validate_flags(unsigned long vm_flags)
 {
-	if ((vm_flags & VM_SHADOW_STACK) && (vm_flags & VM_WRITE))
+	/*
+	 * Shadow stack must not be executable, to help with W^X due to wrss.
+	 */
+	if ((vm_flags & VM_SHADOW_STACK) && (vm_flags & (VM_WRITE | VM_EXEC)))
 		return false;
 
 	return true;
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index aa294c7bcf41..210976925325 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -28,6 +28,6 @@
 /* x86 feature bits to be used with ARCH_X86_FEATURE arch_prctl()s */
 #define LINUX_X86_FEATURE_IBT		0x00000001
 #define LINUX_X86_FEATURE_SHSTK		0x00000002
-
+#define LINUX_X86_FEATURE_WRSS		0x00000010
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/elf_feature_prctl.c b/arch/x86/kernel/elf_feature_prctl.c
index 47de201db3f7..ecad6ebeb4dd 100644
--- a/arch/x86/kernel/elf_feature_prctl.c
+++ b/arch/x86/kernel/elf_feature_prctl.c
@@ -21,6 +21,8 @@ static int elf_feat_copy_status_to_user(struct thread_shstk *shstk, u64 __user *
 		buf[1] = shstk->base;
 		buf[2] = shstk->size;
 	}
+	if (shstk->wrss)
+		buf[0] |= LINUX_X86_FEATURE_WRSS;
 
 	return copy_to_user(ubuf, buf, sizeof(buf));
 }
@@ -40,6 +42,8 @@ int prctl_elf_feature(int option, u64 arg2)
 		if (arg2 & thread->feat_prctl_locked)
 			return -EPERM;
 
+		if (arg2 & LINUX_X86_FEATURE_WRSS && !wrss_control(false))
+			feat_succ |= LINUX_X86_FEATURE_WRSS;
 		if (arg2 & LINUX_X86_FEATURE_SHSTK && !shstk_disable())
 			feat_succ |= LINUX_X86_FEATURE_SHSTK;
 
@@ -52,6 +56,8 @@ int prctl_elf_feature(int option, u64 arg2)
 
 		if (arg2 & LINUX_X86_FEATURE_SHSTK && !shstk_setup())
 			feat_succ |= LINUX_X86_FEATURE_SHSTK;
+		if (arg2 & LINUX_X86_FEATURE_WRSS && !wrss_control(true))
+			feat_succ |= LINUX_X86_FEATURE_WRSS;
 
 		if (feat_succ != arg2)
 			return -ECANCELED;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 53be5d5539d4..92612236b4ef 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -230,6 +230,36 @@ void shstk_free(struct task_struct *tsk)
 	shstk->size = 0;
 }
 
+int wrss_control(bool enable)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	void *xstate;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return 1;
+	/*
+	 * Only enable wrss if shadow stack is enabled. If shadow stack is not
+	 * enabled, wrss will already be disabled, so don't bother clearing it
+	 * when disabling.
+	 */
+	if (!shstk->size || shstk->wrss == enable)
+		return 1;
+
+	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
+	if (enable)
+		err = xsave_set_clear_bits_msrl(xstate, MSR_IA32_U_CET, CET_WRSS_EN, 0);
+	else
+		err = xsave_set_clear_bits_msrl(xstate, MSR_IA32_U_CET, 0, CET_WRSS_EN);
+	end_update_xsave_msrs();
+
+	if (err)
+		return 1;
+
+	shstk->wrss = enable;
+	return 0;
+}
+
 int shstk_disable(void)
 {
 	struct thread_shstk *shstk = &current->thread.shstk;
@@ -242,7 +272,9 @@ int shstk_disable(void)
 		return 1;
 
 	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
-	err = xsave_set_clear_bits_msrl(xstate, MSR_IA32_U_CET, 0, CET_SHSTK_EN);
+	/* Disable WRSS too when disabling shadow stack */
+	err = xsave_set_clear_bits_msrl(xstate, MSR_IA32_U_CET, 0,
+					CET_SHSTK_EN | CET_WRSS_EN);
 	if (!err)
 		err = xsave_wrmsrl(xstate, MSR_IA32_PL3_SSP, 0);
 	end_update_xsave_msrs();
@@ -251,6 +283,7 @@ int shstk_disable(void)
 		return 1;
 
 	shstk_free(current);
+	shstk->wrss = 0;
 	return 0;
 }
 
-- 
2.17.1

