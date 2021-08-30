Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022B43FBC2E
	for <lists+linux-arch@lfdr.de>; Mon, 30 Aug 2021 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbhH3SYX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Aug 2021 14:24:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:57614 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238519AbhH3SYE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Aug 2021 14:24:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="303905712"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="303905712"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:23:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="540650949"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:23:09 -0700
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
Subject: [PATCH v30 03/10] x86/cet/ibt: Handle signals for Indirect Branch Tracking
Date:   Mon, 30 Aug 2021 11:22:14 -0700
Message-Id: <20210830182221.3535-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210830182221.3535-1-yu-cheng.yu@intel.com>
References: <20210830182221.3535-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

IBT state machine tracks CALL/JMP instructions.  When a such instruction is
executed and before arriving at an ENDBR, it is in WAIT_FOR_ENDBR state,
which can be read from CET_WAIT_ENDBR bit of MSR_IA32_U_CET.

Further details are described in Intel SDM Vol. 1, Sec. 18.3.

In handling signals, WAIT_FOR_ENDBR state is saved/restored with a new
UC_WAIT_ENDBR flag being introduced.

A legacy IA32 signal frame does not have ucontext, and cannot be supported
with a uc flag.  Thus, IBT feature is not supported for ia32 app's, which
is handled in a separate patch.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/linux-api/f6e61dae-9805-c855-8873-7481ceb7ea79@intel.com/
---
 arch/x86/ia32/ia32_signal.c          | 15 ++++++++--
 arch/x86/include/asm/cet.h           |  4 +++
 arch/x86/include/uapi/asm/ucontext.h |  5 ++++
 arch/x86/kernel/ibt.c                | 41 ++++++++++++++++++++++++++++
 arch/x86/kernel/signal.c             |  6 ++++
 5 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index d7a30bc98e66..77d0fa90cc19 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -129,6 +129,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe_ia32 __user *frame;
+	unsigned int uc_flags;
 	sigset_t set;
 
 	frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
@@ -137,6 +138,11 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 		goto badframe;
 	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
 		goto badframe;
+	if (__get_user(uc_flags, &frame->uc.uc_flags))
+		goto badframe;
+
+	if (uc_flags & UC_WAIT_ENDBR)
+		ibt_set_wait_endbr();
 
 	set_current_blocked(&set);
 
@@ -312,6 +318,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 			compat_sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe_ia32 __user *frame;
+	unsigned int uc_flags = 0;
 	void __user *restorer;
 	void __user *fp = NULL;
 
@@ -339,6 +346,9 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	if (setup_signal_shadow_stack(1, restorer))
 		return -EFAULT;
 
+	if (ibt_get_clear_wait_endbr())
+		uc_flags |= UC_WAIT_ENDBR;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -348,9 +358,8 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 
 	/* Create the ucontext.  */
 	if (static_cpu_has(X86_FEATURE_XSAVE))
-		unsafe_put_user(UC_FP_XSTATE, &frame->uc.uc_flags, Efault);
-	else
-		unsafe_put_user(0, &frame->uc.uc_flags, Efault);
+		uc_flags |= UC_FP_XSTATE;
+	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
 	unsafe_put_user(0, &frame->uc.uc_link, Efault);
 	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
 
diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index bc04b2d3487d..152c717c9cdb 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -43,9 +43,13 @@ static inline int restore_signal_shadow_stack(void) { return 0; }
 #ifdef CONFIG_X86_IBT
 int ibt_setup(void);
 void ibt_disable(void);
+int ibt_get_clear_wait_endbr(void);
+int ibt_set_wait_endbr(void);
 #else
 static inline int ibt_setup(void) { return 0; }
 static inline void ibt_disable(void) {}
+static inline int ibt_get_clear_wait_endbr(void) { return 0; }
+static inline int ibt_set_wait_endbr(void) { return 0; }
 #endif
 
 #ifdef CONFIG_X86_SHADOW_STACK
diff --git a/arch/x86/include/uapi/asm/ucontext.h b/arch/x86/include/uapi/asm/ucontext.h
index 5657b7a49f03..905419de2cc7 100644
--- a/arch/x86/include/uapi/asm/ucontext.h
+++ b/arch/x86/include/uapi/asm/ucontext.h
@@ -51,6 +51,11 @@
 #define UC_STRICT_RESTORE_SS	0x4
 #endif
 
+/*
+ * Indicates IBT WAIT-ENDBR status.
+ */
+#define UC_WAIT_ENDBR		0x08
+
 #include <asm-generic/ucontext.h>
 
 #endif /* _ASM_X86_UCONTEXT_H */
diff --git a/arch/x86/kernel/ibt.c b/arch/x86/kernel/ibt.c
index 4ab7af33b274..5ab8632a1f7e 100644
--- a/arch/x86/kernel/ibt.c
+++ b/arch/x86/kernel/ibt.c
@@ -56,3 +56,44 @@ void ibt_disable(void)
 	ibt_set_clear_msr_bits(0, CET_ENDBR_EN);
 	current->thread.shstk.ibt = 0;
 }
+
+int ibt_get_clear_wait_endbr(void)
+{
+	u64 msr_val = 0;
+
+	if (!current->thread.shstk.ibt)
+		return 0;
+
+	fpregs_lock();
+
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		if (!rdmsrl_safe(MSR_IA32_U_CET, &msr_val))
+			wrmsrl(MSR_IA32_U_CET, msr_val & ~CET_WAIT_ENDBR);
+	} else {
+		struct cet_user_state *cet;
+
+		/*
+		 * If !TIF_NEED_FPU_LOAD and get_xsave_addr() returns zero,
+		 * XFEATURE_CET_USER is in init state (cet is not active).
+		 * Return zero status.
+		 */
+		cet = get_xsave_addr(&current->thread.fpu.state.xsave,
+				     XFEATURE_CET_USER);
+		if (cet) {
+			msr_val = cet->user_cet;
+			cet->user_cet = msr_val & ~CET_WAIT_ENDBR;
+		}
+	}
+
+	fpregs_unlock();
+
+	return msr_val & CET_WAIT_ENDBR;
+}
+
+int ibt_set_wait_endbr(void)
+{
+	if (!current->thread.shstk.ibt)
+		return 0;
+
+	return ibt_set_clear_msr_bits(CET_WAIT_ENDBR, 0);
+}
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 661e46803b84..a1285650852e 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -135,6 +135,9 @@ static int restore_sigcontext(struct pt_regs *regs,
 	 */
 	if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) && user_64bit_mode(regs)))
 		force_valid_ss(regs);
+
+	if (uc_flags & UC_WAIT_ENDBR)
+		ibt_set_wait_endbr();
 #endif
 
 	return fpu__restore_sig((void __user *)sc.fpstate,
@@ -455,6 +458,9 @@ static unsigned long frame_uc_flags(struct pt_regs *regs)
 	if (likely(user_64bit_mode(regs)))
 		flags |= UC_STRICT_RESTORE_SS;
 
+	if (ibt_get_clear_wait_endbr())
+		flags |= UC_WAIT_ENDBR;
+
 	return flags;
 }
 
-- 
2.21.0

