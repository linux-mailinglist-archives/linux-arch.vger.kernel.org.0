Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02D53F335E
	for <lists+linux-arch@lfdr.de>; Fri, 20 Aug 2021 20:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhHTSWY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Aug 2021 14:22:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:22456 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236037AbhHTSVu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Aug 2021 14:21:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="302407841"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="302407841"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:18:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="533074777"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:18:51 -0700
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v29 27/32] x86/cet/shstk: Handle signals for shadow stack
Date:   Fri, 20 Aug 2021 11:11:56 -0700
Message-Id: <20210820181201.31490-28-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210820181201.31490-1-yu-cheng.yu@intel.com>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
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
---
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
index 548d0552f9b3..b3105b7440a5 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -333,3 +333,45 @@ int shstk_check_rstor_token(bool proc32, unsigned long *new_ssp)
 
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

