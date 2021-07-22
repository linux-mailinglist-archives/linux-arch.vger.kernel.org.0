Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC43F3D2E48
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 22:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhGVUM6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 16:12:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:54383 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhGVUMa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 16:12:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="275560632"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="275560632"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:53:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="502035516"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:53:03 -0700
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
Subject: [PATCH v28 27/32] x86/cet/shstk: Handle signals for shadow stack
Date:   Thu, 22 Jul 2021 13:52:14 -0700
Message-Id: <20210722205219.7934-28-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210722205219.7934-1-yu-cheng.yu@intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A signal handler (if not changing ucontext) returns to the restorer, and
the restorer calls sigreturn.  Thus, when setting up a signal frame, the
kernel:

- installs a shadow stack restore token pointing to the current shadow
  stack address, and

- installs the restorer address below the restore token.

In sigreturn, the restore token is verified and shadow stack pointer is
restored.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
---
v27:
- Eliminate saving shadow stack pointer to signal context.

v25:
- Update commit log/comments for the sc_ext struct.
- Use restorer address already calculated.
- Change CONFIG_X86_CET to CONFIG_X86_SHADOW_STACK.
- Change X86_FEATURE_CET to X86_FEATURE_SHSTK.
- Eliminate writing to MSR_IA32_U_CET for shadow stack.
- Change wrmsrl() to wrmsrl_safe() and handle error.

 arch/x86/ia32/ia32_signal.c | 25 +++++++++++++++++-----
 arch/x86/include/asm/cet.h  |  4 ++++
 arch/x86/kernel/shstk.c     | 42 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/signal.c    | 13 ++++++++++++
 4 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 5e3d9b7fd5fb..d7a30bc98e66 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -35,6 +35,7 @@
 #include <asm/sigframe.h>
 #include <asm/sighandling.h>
 #include <asm/smap.h>
+#include <asm/cet.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
@@ -113,6 +114,10 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 
 	if (ia32_restore_sigcontext(regs, &frame->sc))
 		goto badframe;
+
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	return regs->ax;
 
 badframe:
@@ -138,6 +143,9 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 	if (ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (compat_restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
@@ -262,6 +270,9 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 			restorer = &frame->retcode;
 	}
 
+	if (setup_signal_shadow_stack(1, restorer))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -319,6 +330,15 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 
 	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
 
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		restorer = ksig->ka.sa.sa_restorer;
+	else
+		restorer = current->mm->context.vdso +
+			vdso_image_32.sym___kernel_rt_sigreturn;
+
+	if (setup_signal_shadow_stack(1, restorer))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -334,11 +354,6 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	unsafe_put_user(0, &frame->uc.uc_link, Efault);
 	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
 
-	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		restorer = ksig->ka.sa.sa_restorer;
-	else
-		restorer = current->mm->context.vdso +
-			vdso_image_32.sym___kernel_rt_sigreturn;
 	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
 
 	/*
diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index aa533700ba31..2f7940d68ce3 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -24,6 +24,8 @@ void shstk_disable(void);
 int shstk_setup_rstor_token(bool ia32, unsigned long restorer,
 			    unsigned long *new_ssp);
 int shstk_check_rstor_token(bool ia32, unsigned long *new_ssp);
+int setup_signal_shadow_stack(int ia32, void __user *restorer);
+int restore_signal_shadow_stack(void);
 #else
 static inline int shstk_setup(void) { return 0; }
 static inline int shstk_alloc_thread_stack(struct task_struct *p,
@@ -35,6 +37,8 @@ static inline int shstk_setup_rstor_token(bool ia32, unsigned long restorer,
 					  unsigned long *new_ssp) { return 0; }
 static inline int shstk_check_rstor_token(bool ia32,
 					  unsigned long *new_ssp) { return 0; }
+static inline int setup_signal_shadow_stack(int ia32, void __user *restorer) { return 0; }
+static inline int restore_signal_shadow_stack(void) { return 0; }
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 89c7da3cdb92..b3d64cfa28eb 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -331,3 +331,45 @@ int shstk_check_rstor_token(bool proc32, unsigned long *new_ssp)
 
 	return 0;
 }
+
+int setup_signal_shadow_stack(int ia32, void __user *restorer)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	unsigned long new_ssp;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) || !shstk->size)
+		return 0;
+
+	err = shstk_setup_rstor_token(ia32, (unsigned long)restorer,
+				      &new_ssp);
+	if (err)
+		return err;
+
+	start_update_msrs();
+	err = wrmsrl_safe(MSR_IA32_PL3_SSP, new_ssp);
+	end_update_msrs();
+
+	return err;
+}
+
+int restore_signal_shadow_stack(void)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	int ia32 = in_ia32_syscall();
+	unsigned long new_ssp;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) || !shstk->size)
+		return 0;
+
+	err = shstk_check_rstor_token(ia32, &new_ssp);
+	if (err)
+		return err;
+
+	start_update_msrs();
+	err = wrmsrl_safe(MSR_IA32_PL3_SSP, new_ssp);
+	end_update_msrs();
+
+	return err;
+}
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index f4d21e470083..661e46803b84 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -46,6 +46,7 @@
 #include <asm/syscall.h>
 #include <asm/sigframe.h>
 #include <asm/signal.h>
+#include <asm/cet.h>
 
 #ifdef CONFIG_X86_64
 /*
@@ -471,6 +472,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	frame = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe), &fp);
 	uc_flags = frame_uc_flags(regs);
 
+	if (setup_signal_shadow_stack(0, ksig->ka.sa.sa_restorer))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -576,6 +580,9 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 
 	uc_flags = frame_uc_flags(regs);
 
+	if (setup_signal_shadow_stack(0, ksig->ka.sa.sa_restorer))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -674,6 +681,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
@@ -932,6 +942,9 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (compat_restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-- 
2.21.0

