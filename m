Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4747F37E36
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 22:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfFFUQK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 16:16:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:47825 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbfFFUPg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 16:15:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 13:15:36 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga002.jf.intel.com with ESMTP; 06 Jun 2019 13:15:34 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 21/27] x86/cet/shstk: Handle signals for shadow stack
Date:   Thu,  6 Jun 2019 13:06:40 -0700
Message-Id: <20190606200646.3951-22-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606200646.3951-1-yu-cheng.yu@intel.com>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When setting up a signal, the kernel creates a shadow stack restore
token at the current SHSTK address and then stores the token's
address in the signal frame, right after the FPU state.  Before
restoring a signal, the kernel verifies and then uses the restore
token to set the SHSTK pointer.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/ia32/ia32_signal.c            |   8 ++
 arch/x86/include/asm/cet.h             |   7 ++
 arch/x86/include/asm/fpu/internal.h    |   2 +
 arch/x86/include/asm/fpu/signal.h      |   2 +
 arch/x86/include/uapi/asm/sigcontext.h |  15 +++
 arch/x86/kernel/cet.c                  | 141 +++++++++++++++++++++++++
 arch/x86/kernel/fpu/signal.c           |  67 ++++++++++++
 arch/x86/kernel/signal.c               |   8 ++
 8 files changed, 250 insertions(+)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 629d1ee05599..5216ca782262 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -34,6 +34,7 @@
 #include <asm/sigframe.h>
 #include <asm/sighandling.h>
 #include <asm/smap.h>
+#include <asm/cet.h>
 
 /*
  * Do a signal return; undo the signal stack.
@@ -235,6 +236,7 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 		 ksig->ka.sa.sa_restorer)
 		sp = (unsigned long) ksig->ka.sa.sa_restorer;
 
+	sp = fpu__alloc_sigcontext_ext(sp);
 	sp = fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
 	*fpstate = (struct _fpstate_32 __user *) sp;
 	if (copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
@@ -295,6 +297,9 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 			restorer = &frame->retcode;
 	}
 
+	if (setup_fpu_system_states(1, (unsigned long)restorer, fpstate))
+		return -EFAULT;
+
 	put_user_try {
 		put_user_ex(ptr_to_compat(restorer), &frame->pretcode);
 
@@ -384,6 +389,9 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 				     regs, set->sig[0]);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 
+	if (!err)
+		err = setup_fpu_system_states(1, (unsigned long)restorer, fpstate);
+
 	if (err)
 		return -EFAULT;
 
diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index c952a2ec65fe..422ccb8adbb7 100644
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
@@ -19,10 +21,15 @@ struct cet_status {
 int cet_setup_shstk(void);
 void cet_disable_shstk(void);
 void cet_disable_free_shstk(struct task_struct *p);
+int cet_restore_signal(bool ia32, struct sc_ext *sc);
+int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 #else
 static inline int cet_setup_shstk(void) { return -EINVAL; }
 static inline void cet_disable_shstk(void) {}
 static inline void cet_disable_free_shstk(struct task_struct *p) {}
+static inline int cet_restore_signal(bool ia32, struct sc_ext *sc) { return -EINVAL; }
+static inline int cet_setup_signal(bool ia32, unsigned long rstor,
+				   struct sc_ext *sc) { return -EINVAL; }
 #endif
 
 #define cpu_x86_cet_enabled() \
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 148a3d8c8c35..7db8c19c9072 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -472,6 +472,8 @@ static inline void copy_kernel_to_fpregs(union fpregs_state *fpstate)
 	__copy_kernel_to_fpregs(fpstate, -1);
 }
 
+extern int setup_fpu_system_states(int is_ia32, unsigned long restorer,
+				   void __user *fp);
 extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
 
 /*
diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 7fb516b6893a..630a658aeea3 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -25,6 +25,8 @@ extern void convert_from_fxsr(struct user_i387_ia32_struct *env,
 extern void convert_to_fxsr(struct fxregs_state *fxsave,
 			    const struct user_i387_ia32_struct *env);
 
+unsigned long fpu__alloc_sigcontext_ext(unsigned long sp);
+
 unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size);
diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/uapi/asm/sigcontext.h
index 844d60eb1882..e3b08d1c0d3b 100644
--- a/arch/x86/include/uapi/asm/sigcontext.h
+++ b/arch/x86/include/uapi/asm/sigcontext.h
@@ -196,6 +196,21 @@ struct _xstate {
 	/* New processor state extensions go here: */
 };
 
+/*
+ * Sigcontext extension (struct sc_ext) is located after
+ * sigcontext->fpstate.  Because currently only the shadow
+ * stack pointer is saved there and the shadow stack depends
+ * on XSAVES, we can find sc_ext from sigcontext->fpstate.
+ *
+ * The 64-bit fpstate has a size of fpu_user_xstate_size, plus
+ * FP_XSTATE_MAGIC2_SIZE when XSAVE* is used.  The struct sc_ext
+ * is located at the end of sigcontext->fpstate, aligned to 8.
+ */
+struct sc_ext {
+	unsigned long total_size;
+	unsigned long ssp;
+};
+
 /*
  * The 32-bit signal frame:
  */
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 2a48634aa6ce..b247cd15c1e2 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -19,6 +19,8 @@
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/types.h>
 #include <asm/cet.h>
+#include <asm/special_insns.h>
+#include <uapi/asm/sigcontext.h>
 
 static int set_shstk_ptr(unsigned long addr)
 {
@@ -51,6 +53,80 @@ static unsigned long get_shstk_addr(void)
 	return ptr;
 }
 
+#define TOKEN_MODE_MASK	3UL
+#define TOKEN_MODE_64	1UL
+#define IS_TOKEN_64(token) ((token & TOKEN_MODE_MASK) == TOKEN_MODE_64)
+#define IS_TOKEN_32(token) ((token & TOKEN_MODE_MASK) == 0)
+
+/*
+ * Verify the restore token at the address of 'ssp' is
+ * valid and then set shadow stack pointer according to the
+ * token.
+ */
+static int verify_rstor_token(bool ia32, unsigned long ssp,
+			      unsigned long *new_ssp)
+{
+	unsigned long token;
+
+	*new_ssp = 0;
+
+	if (!IS_ALIGNED(ssp, 8))
+		return -EINVAL;
+
+	if (get_user(token, (unsigned long __user *)ssp))
+		return -EFAULT;
+
+	/* Is 64-bit mode flag correct? */
+	if (!ia32 && !IS_TOKEN_64(token))
+		return -EINVAL;
+	else if (ia32 && !IS_TOKEN_32(token))
+		return -EINVAL;
+
+	token &= ~TOKEN_MODE_MASK;
+
+	/*
+	 * Restore address properly aligned?
+	 */
+	if ((!ia32 && !IS_ALIGNED(token, 8)) || !IS_ALIGNED(token, 4))
+		return -EINVAL;
+
+	/*
+	 * Token was placed properly?
+	 */
+	if ((ALIGN_DOWN(token, 8) - 8) != ssp)
+		return -EINVAL;
+
+	*new_ssp = token;
+	return 0;
+}
+
+/*
+ * Create a restore token on the shadow stack.
+ * A token is always 8-byte and aligned to 8.
+ */
+static int create_rstor_token(bool ia32, unsigned long ssp,
+			      unsigned long *new_ssp)
+{
+	unsigned long addr;
+
+	*new_ssp = 0;
+
+	if ((!ia32 && !IS_ALIGNED(ssp, 8)) || !IS_ALIGNED(ssp, 4))
+		return -EINVAL;
+
+	addr = ALIGN_DOWN(ssp, 8) - 8;
+
+	/* Is the token for 64-bit? */
+	if (!ia32)
+		ssp |= TOKEN_MODE_64;
+
+	if (write_user_shstk_64(addr, ssp))
+		return -EFAULT;
+
+	*new_ssp = addr;
+	return 0;
+}
+
 int cet_setup_shstk(void)
 {
 	unsigned long addr, size;
@@ -114,3 +190,68 @@ void cet_disable_free_shstk(struct task_struct *tsk)
 
 	tsk->thread.cet.shstk_enabled = 0;
 }
+
+/*
+ * Called from __fpu__restore_sig() under the protection
+ * of fpregs_lock().
+ */
+int cet_restore_signal(bool ia32, struct sc_ext *sc_ext)
+{
+	unsigned long new_ssp = 0;
+	u64 msr_ia32_u_cet = 0;
+	int err;
+
+	if (current->thread.cet.shstk_enabled) {
+		err = verify_rstor_token(ia32, sc_ext->ssp, &new_ssp);
+		if (err)
+			return err;
+
+		msr_ia32_u_cet |= MSR_IA32_CET_SHSTK_EN;
+	}
+
+	wrmsrl(MSR_IA32_PL3_SSP, new_ssp);
+	wrmsrl(MSR_IA32_U_CET, msr_ia32_u_cet);
+	return 0;
+}
+
+/*
+ * Setup the shadow stack for the signal handler: first,
+ * create a restore token to keep track of the current ssp,
+ * and then the return address of the signal handler.
+ */
+int cet_setup_signal(bool ia32, unsigned long rstor_addr, struct sc_ext *sc_ext)
+{
+	unsigned long ssp = 0, new_ssp = 0;
+	u64 msr_ia32_u_cet = 0;
+	int err;
+
+	msr_ia32_u_cet = 0;
+	ssp = 0;
+
+	if (current->thread.cet.shstk_enabled) {
+		ssp = get_shstk_addr();
+		err = create_rstor_token(ia32, ssp, &new_ssp);
+		if (err)
+			return err;
+
+		if (ia32) {
+			ssp = new_ssp - sizeof(u32);
+			err = write_user_shstk_32(ssp, (unsigned int)rstor_addr);
+		} else {
+			ssp = new_ssp - sizeof(u64);
+			err = write_user_shstk_64(ssp, rstor_addr);
+		}
+
+		if (err)
+			return err;
+
+		msr_ia32_u_cet |= MSR_IA32_CET_SHSTK_EN;
+		sc_ext->ssp = new_ssp;
+	}
+
+	modify_fpu_regs_begin();
+	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	wrmsrl(MSR_IA32_U_CET, msr_ia32_u_cet);
+	modify_fpu_regs_end();
+	return 0;
+}
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index e38b272793b1..0a67518c142f 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -51,6 +51,58 @@ static inline int check_for_xstate(struct fxregs_state __user *buf,
 	return 0;
 }
 
+int setup_fpu_system_states(int is_ia32, unsigned long restorer,
+				   void __user *fp)
+{
+	int err = 0;
+
+#ifdef CONFIG_X86_64
+	if (cpu_x86_cet_enabled() && fp) {
+		struct sc_ext ext = {0, 0};
+
+		err = cet_setup_signal(is_ia32, restorer, &ext);
+		if (!err) {
+			void __user *p;
+
+			ext.total_size = sizeof(ext);
+
+			p = fp + fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
+			p = (void __user *)ALIGN((unsigned long)p, 8);
+
+			if (copy_to_user(p, &ext, sizeof(ext)))
+				return -EFAULT;
+		}
+	}
+#endif
+
+	return err;
+}
+
+static int restore_fpu_system_states(int is_ia32, void __user *fp)
+{
+	int err = 0;
+
+#ifdef CONFIG_X86_64
+	if (cpu_x86_cet_enabled() && fp) {
+		struct sc_ext ext = {0, 0};
+		void __user *p;
+
+		p = fp + fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
+		p = (void __user *)ALIGN((unsigned long)p, 8);
+
+		if (copy_from_user(&ext, p, sizeof(ext)))
+			return -EFAULT;
+
+		if (ext.total_size != sizeof(ext))
+			return -EFAULT;
+
+		err = cet_restore_signal(is_ia32, &ext);
+	}
+#endif
+
+	return err;
+}
+
 /*
  * Signal frame handlers.
  */
@@ -349,6 +401,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		pagefault_disable();
 		ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only);
 		pagefault_enable();
+
+		if (!ret)
+			ret = restore_fpu_system_states(0, buf);
+
 		if (!ret) {
 			fpregs_mark_activate();
 			fpregs_unlock();
@@ -435,6 +491,17 @@ int fpu__restore_sig(void __user *buf, int ia32_frame)
 	return __fpu__restore_sig(buf, buf_fx, size);
 }
 
+unsigned long fpu__alloc_sigcontext_ext(unsigned long sp)
+{
+	/*
+	 * sigcontext_ext is at: fpu + fpu_user_xstate_size +
+	 * FP_XSTATE_MAGIC2_SIZE, then aligned to 8.
+	 */
+	if (cpu_x86_cet_enabled())
+		sp -= (sizeof(struct sc_ext) + 8);
+	return sp;
+}
+
 unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size)
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 3b0dcec597ce..c81192bdc96c 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -46,6 +46,7 @@
 
 #include <asm/sigframe.h>
 #include <asm/signal.h>
+#include <asm/cet.h>
 
 #define COPY(x)			do {			\
 	get_user_ex(regs->x, &sc->x);			\
@@ -264,6 +265,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 		sp = (unsigned long) ka->sa.sa_restorer;
 	}
 
+	sp = fpu__alloc_sigcontext_ext(sp);
 	sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
 				  &buf_fx, &math_size);
 	*fpstate = (void __user *)sp;
@@ -493,6 +495,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fp, regs, set->sig[0]);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 
+	if (!err)
+		err = setup_fpu_system_states(0, (unsigned long)ksig->ka.sa.sa_restorer, fp);
+
 	if (err)
 		return -EFAULT;
 
@@ -579,6 +584,9 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 				regs, set->sig[0]);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 
+	if (!err)
+		err = setup_fpu_system_states(0, (unsigned long)ksig->ka.sa.sa_restorer, fpstate);
+
 	if (err)
 		return -EFAULT;
 
-- 
2.17.1

