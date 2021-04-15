Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC9A36150E
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 00:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbhDOWSX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 18:18:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:22370 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237105AbhDOWSE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 18:18:04 -0400
IronPort-SDR: xtCYAlKDdVegDrup7BxJ/UhpJrqGHkDYA3EnVEmPL/6escoCuBge0cG1M2BqXm0+e0MNwNqzyz
 GoCAe6wAD1Jg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194513391"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194513391"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:40 -0700
IronPort-SDR: c3SYBXnSl40TuFGtF6edxLCmjLOA65qtHqnoBjbLBPlJL7plxSI12Fug5mURMIoc4COMmnMNu7
 2w6deNKQRgqw==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="451270948"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:40 -0700
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
Subject: [PATCH v25 25/30] x86/cet/shstk: Handle signals for shadow stack
Date:   Thu, 15 Apr 2021 15:14:14 -0700
Message-Id: <20210415221419.31835-26-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210415221419.31835-1-yu-cheng.yu@intel.com>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When shadow stack is enabled, a task's shadow stack states must be saved
along with the signal context and later restored in sigreturn.  However,
currently there is no systematic facility for extending a signal context.
There is some space left in the ucontext, but changing ucontext is likely
to create compatibility issues and there is not enough space for further
extensions.

Introduce a signal context extension struct 'sc_ext', which is used to save
shadow stack restore token address.  The extension is located above the fpu
states, plus alignment.  The struct can be extended (such as the ibt's
wait_endbr status to be introduced later), and sc_ext.total_size field
keeps track of total size.

Introduce routines for the allocation, save, and restore for sc_ext:
- fpu__alloc_sigcontext_ext(),
- save_extra_state_to_sigframe(),
- get_extra_state_from_sigframe(),
- restore_extra_state_to_xregs().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v25:
- Update commit log/comments for the sc_ext struct.
- Use restorer address already calculated.
- Change CONFIG_X86_CET to CONFIG_X86_SHADOW_STACK.
- Change X86_FEATURE_CET to X86_FEATURE_SHSTK.
- Eliminate writing to MSR_IA32_U_CET for shadow stack.
- Change wrmsrl() to wrmsrl_safe() and handle error.

v24:
- Split out shadow stack token routines to a separate patch.
- Put signal frame save/restore routines to fpu/signal.c and re-name accordingly.

 arch/x86/ia32/ia32_signal.c            |  24 +++--
 arch/x86/include/asm/cet.h             |   2 +
 arch/x86/include/asm/fpu/internal.h    |   2 +
 arch/x86/include/uapi/asm/sigcontext.h |   9 ++
 arch/x86/kernel/fpu/signal.c           | 137 ++++++++++++++++++++++++-
 arch/x86/kernel/signal.c               |   9 ++
 6 files changed, 172 insertions(+), 11 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 5e3d9b7fd5fb..423abcd181f2 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -202,7 +202,8 @@ do {									\
  */
 static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 				 size_t frame_size,
-				 void __user **fpstate)
+				 void __user **fpstate,
+				 void __user *restorer)
 {
 	unsigned long sp, fx_aligned, math_size;
 
@@ -220,6 +221,10 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 
 	sp = fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
 	*fpstate = (struct _fpstate_32 __user *) sp;
+
+	if (save_extra_state_to_sigframe(1, *fpstate, restorer))
+		return (void __user *)-1L;
+
 	if (copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
 				     math_size) < 0)
 		return (void __user *) -1L;
@@ -249,8 +254,6 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 		0x80cd,		/* int $0x80 */
 	};
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
-
 	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
 		restorer = ksig->ka.sa.sa_restorer;
 	} else {
@@ -262,6 +265,8 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 			restorer = &frame->retcode;
 	}
 
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp, restorer);
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -317,7 +322,13 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 		0,
 	};
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		restorer = ksig->ka.sa.sa_restorer;
+	else
+		restorer = current->mm->context.vdso +
+			vdso_image_32.sym___kernel_rt_sigreturn;
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp, restorer);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
@@ -334,11 +345,6 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
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
index ef6155213b7e..5e66919bd2fe 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct sc_ext;
+
 /*
  * Per-thread CET status
  */
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 8d33ad80704f..2a3c6a160dd6 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -443,6 +443,8 @@ static inline void copy_kernel_to_fpregs(union fpregs_state *fpstate)
 	__copy_kernel_to_fpregs(fpstate, -1);
 }
 
+extern int save_extra_state_to_sigframe(int ia32, void __user *fp,
+					void __user *restorer);
 extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
 
 /*
diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/uapi/asm/sigcontext.h
index 844d60eb1882..10d7fa192d48 100644
--- a/arch/x86/include/uapi/asm/sigcontext.h
+++ b/arch/x86/include/uapi/asm/sigcontext.h
@@ -196,6 +196,15 @@ struct _xstate {
 	/* New processor state extensions go here: */
 };
 
+/*
+ * Located at the end of sigcontext->fpstate, aligned to 8.
+ * total_size keeps track of further extension of the struct.
+ */
+struct sc_ext {
+	unsigned long total_size;
+	unsigned long ssp;
+};
+
 /*
  * The 32-bit signal frame:
  */
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a4ec65317a7f..0488407bec81 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -52,6 +52,107 @@ static inline int check_for_xstate(struct fxregs_state __user *buf,
 	return 0;
 }
 
+int save_extra_state_to_sigframe(int ia32, void __user *fp, void __user *restorer)
+{
+	int err = 0;
+
+#ifdef CONFIG_X86_SHADOW_STACK
+	struct cet_status *cet = &current->thread.cet;
+	unsigned long token_addr = 0, new_ssp = 0;
+	struct sc_ext ext = {};
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return 0;
+
+	if (cet->shstk_size) {
+		err = shstk_setup_rstor_token(ia32, (unsigned long)restorer,
+					      &token_addr, &new_ssp);
+		if (err)
+			return err;
+
+		ext.ssp = token_addr;
+
+		fpregs_lock();
+		if (test_thread_flag(TIF_NEED_FPU_LOAD))
+			__fpregs_load_activate();
+		if (new_ssp)
+			err = wrmsrl_safe(MSR_IA32_PL3_SSP, new_ssp);
+		fpregs_unlock();
+	}
+
+	if (!err && ext.ssp) {
+		void __user *p = fp;
+
+		ext.total_size = sizeof(ext);
+
+		p = fp;
+		if (ia32)
+			p += sizeof(struct fregs_state);
+
+		p += fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
+		p = (void __user *)ALIGN((unsigned long)p, 8);
+
+		if (copy_to_user(p, &ext, sizeof(ext)))
+			return -EFAULT;
+	}
+#endif
+	return err;
+}
+
+static int get_extra_state_from_sigframe(int ia32, void __user *fp, struct sc_ext *ext)
+{
+	int err = 0;
+
+#ifdef CONFIG_X86_SHADOW_STACK
+	struct cet_status *cet = &current->thread.cet;
+	void __user *p;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return 0;
+
+	if (!cet->shstk_size)
+		return 0;
+
+	memset(ext, 0, sizeof(*ext));
+
+	p = fp;
+	if (ia32)
+		p += sizeof(struct fregs_state);
+
+	p += fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
+	p = (void __user *)ALIGN((unsigned long)p, 8);
+
+	if (copy_from_user(ext, p, sizeof(*ext)))
+		return -EFAULT;
+
+	if (ext->total_size != sizeof(*ext))
+		return -EFAULT;
+
+	if (cet->shstk_size)
+		err = shstk_check_rstor_token(ia32, ext->ssp, &ext->ssp);
+#endif
+	return err;
+}
+
+/*
+ * Called from __fpu__restore_sig() and protected by fpregs_lock().
+ */
+static int restore_extra_state_to_xregs(struct sc_ext *sc_ext)
+{
+	int err = 0;
+
+#ifdef CONFIG_X86_SHADOW_STACK
+	struct cet_status *cet = &current->thread.cet;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return 0;
+
+	if (cet->shstk_size)
+		err = wrmsrl_safe(MSR_IA32_PL3_SSP, sc_ext->ssp);
+#endif
+	return err;
+}
+
 /*
  * Signal frame handlers.
  */
@@ -295,6 +396,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
+	struct sc_ext sc_ext;
 	u64 user_xfeatures = 0;
 	int fx_only = 0;
 	int ret = 0;
@@ -335,6 +437,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	if ((unsigned long)buf_fx % 64)
 		fx_only = 1;
 
+	ret = get_extra_state_from_sigframe(ia32_fxstate, buf, &sc_ext);
+	if (ret)
+		return ret;
+
 	if (!ia32_fxstate) {
 		/*
 		 * Attempt to restore the FPU registers directly from user
@@ -365,9 +471,17 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			    xfeatures_mask_supervisor())
 				copy_kernel_to_xregs(&fpu->state.xsave,
 						     xfeatures_mask_supervisor());
-			fpregs_mark_activate();
+
+			ret = restore_extra_state_to_xregs(&sc_ext);
+			if (!ret) {
+				fpregs_mark_activate();
+			} else {
+				fpregs_deactivate(fpu);
+				fpu__clear_user_states(fpu);
+			}
+
 			fpregs_unlock();
-			return 0;
+			return ret;
 		}
 		fpregs_unlock();
 	} else {
@@ -430,6 +544,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		ret = copy_kernel_to_xregs_err(&fpu->state.xsave,
 					       user_xfeatures | xfeatures_mask_supervisor());
 
+		if (!ret)
+			ret = restore_extra_state_to_xregs(&sc_ext);
 	} else if (use_fxsr()) {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
 		if (ret) {
@@ -491,12 +607,29 @@ int fpu__restore_sig(void __user *buf, int ia32_frame)
 	return __fpu__restore_sig(buf, buf_fx, size);
 }
 
+static unsigned long fpu__alloc_sigcontext_ext(unsigned long sp)
+{
+#ifdef CONFIG_X86_SHADOW_STACK
+	struct cet_status *cet = &current->thread.cet;
+
+	/*
+	 * sigcontext_ext is at: fpu + fpu_user_xstate_size +
+	 * FP_XSTATE_MAGIC2_SIZE, then aligned to 8.
+	 */
+	if (cet->shstk_size)
+		sp -= (sizeof(struct sc_ext) + 8);
+#endif
+	return sp;
+}
+
 unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size)
 {
 	unsigned long frame_size = xstate_sigframe_size();
 
+	sp = fpu__alloc_sigcontext_ext(sp);
+
 	*buf_fx = sp = round_down(sp - frame_size, 64);
 	if (ia32_frame && use_fxsr()) {
 		frame_size += sizeof(struct fregs_state);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index f306e85a08a6..56d2412174c8 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -239,6 +239,9 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	unsigned long buf_fx = 0;
 	int onsigstack = on_sig_stack(sp);
 	int ret;
+#ifdef CONFIG_X86_64
+	void __user *restorer = NULL;
+#endif
 
 	/* redzone */
 	if (IS_ENABLED(CONFIG_X86_64))
@@ -270,6 +273,12 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	if (onsigstack && !likely(on_sig_stack(sp)))
 		return (void __user *)-1L;
 
+#ifdef CONFIG_X86_64
+	if (ka->sa.sa_flags & SA_RESTORER)
+		restorer = ka->sa.sa_restorer;
+	ret = save_extra_state_to_sigframe(0, *fpstate, restorer);
+#endif
+
 	/* save i387 and extended state */
 	ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);
 	if (ret < 0)
-- 
2.21.0

