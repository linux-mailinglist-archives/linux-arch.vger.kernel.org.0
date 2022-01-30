Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571164A3A32
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356829AbiA3VZc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:25:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:9048 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356510AbiA3VX7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577839; x=1675113839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=d0Xgzna4gIh3ZuI3ZOXqKNlQFX4CnUeeaybj1VMMDGA=;
  b=ly7ijwrAjPrRN4pl8Xd7lpDFNTFdkmWCdctWv4IHuw7q199RNiYcaaWS
   Nk5Y5aHixXbNYyhfTuwvQxtxoaOmMqW37Jme0UkD02cwg6Vg8gzrNKVP3
   MFh68fEldB+J8dhdcQcEbSXyodu1fBdjBV4s53WPkzkSMcxTI8K7rTTFP
   MR9pin9PmbqBddSALYS2zkZkdTZxNBfCP6SQGPVH4zfUANdLOGOT1gERO
   xSvAWr2hgcRr5G3eFb8LCxltUBjn5OOalO2gXMUSHZVrXgGH2tFzFfWXr
   cddP8vaOPCWecVlTY2btSDhrgQy3QuXQNfSNXAUcmU997xSWx71CcYR6I
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="310685826"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="310685826"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856972"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:09 -0800
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
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 30/35] x86/cet/shstk: Handle signals for shadow stack
Date:   Sun, 30 Jan 2022 13:18:33 -0800
Message-Id: <20220130211838.8382-31-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

When a signal is handled normally the context is pushed to the stack
before handling it. For shadow stacks, since the shadow stack only track's
return addresses, there isn't any state that needs to be pushed. However,
there are still a few things that need to be done. These things are
userspace visible and which will be kernel ABI for shadow stacks.

One is to make sure the restorer address is written to shadow stack, since
the signal handler (if not changing ucontext) returns to the restorer, and
the restorer calls sigreturn. So add the restorer on the shadow stack
before handling the signal, so there is not a conflict when the signal
handler returns to the restorer.

The other thing to do is to place a restore token on the thread's shadow
stack before handling the signal and check it during sigreturn. This
is an extra layer of protection to hamper attackers calling sigreturn
manually as in SROP-like attacks.

So, when handling a signal push
 - a shadow stack restore token pointing to the current shadow stack
   address
 - the restorer address below the restore token.

In sigreturn, verify the restore token and pop the shadow stack.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
---

v1:
 - Use xsave helpers.
 - Expand commit log.

Yu-cheng v27:
 - Eliminate saving shadow stack pointer to signal context.

Yu-cheng v25:
 - Update commit log/comments for the sc_ext struct.
 - Use restorer address already calculated.
 - Change CONFIG_X86_CET to CONFIG_X86_SHADOW_STACK.
 - Change X86_FEATURE_CET to X86_FEATURE_SHSTK.
 - Eliminate writing to MSR_IA32_U_CET for shadow stack.
 - Change wrmsrl() to wrmsrl_safe() and handle error.

 arch/x86/ia32/ia32_signal.c | 25 ++++++++++++++++-----
 arch/x86/include/asm/cet.h  |  4 ++++
 arch/x86/kernel/shstk.c     | 44 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/signal.c    | 13 +++++++++++
 4 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index c9c3859322fa..a8d038409d60 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -34,6 +34,7 @@
 #include <asm/sigframe.h>
 #include <asm/sighandling.h>
 #include <asm/smap.h>
+#include <asm/cet.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
@@ -112,6 +113,10 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 
 	if (!ia32_restore_sigcontext(regs, &frame->sc))
 		goto badframe;
+
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	return regs->ax;
 
 badframe:
@@ -137,6 +142,9 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (compat_restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
@@ -261,6 +269,9 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 			restorer = &frame->retcode;
 	}
 
+	if (setup_signal_shadow_stack(1, restorer))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -318,6 +329,15 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 
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
 
@@ -333,11 +353,6 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
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
index 6e8a7a807dcc..faff8dc86159 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -22,6 +22,8 @@ void reset_thread_shstk(void);
 int shstk_setup_rstor_token(bool proc32, unsigned long restorer,
 			    unsigned long *new_ssp);
 int shstk_check_rstor_token(bool proc32, unsigned long *new_ssp);
+int setup_signal_shadow_stack(int proc32, void __user *restorer);
+int restore_signal_shadow_stack(void);
 #else
 static inline void shstk_setup(void) {}
 static inline int shstk_alloc_thread_stack(struct task_struct *p,
@@ -34,6 +36,8 @@ static inline int shstk_setup_rstor_token(bool proc32, unsigned long restorer,
 					  unsigned long *new_ssp) { return 0; }
 static inline int shstk_check_rstor_token(bool proc32,
 					  unsigned long *new_ssp) { return 0; }
+static inline int setup_signal_shadow_stack(int proc32, void __user *restorer) { return 0; }
+static inline int restore_signal_shadow_stack(void) { return 0; }
 #endif /* CONFIG_X86_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index e0caab50ca77..682d85a63a1d 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -335,3 +335,47 @@ int shstk_check_rstor_token(bool proc32, unsigned long *new_ssp)
 
 	return 0;
 }
+
+int setup_signal_shadow_stack(int proc32, void __user *restorer)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	unsigned long new_ssp;
+	void *xstate;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) || !shstk->size)
+		return 0;
+
+	err = shstk_setup_rstor_token(proc32, (unsigned long)restorer,
+				      &new_ssp);
+	if (err)
+		return err;
+
+	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
+	err = xsave_wrmsrl(xstate, MSR_IA32_PL3_SSP, new_ssp);
+	end_update_xsave_msrs();
+
+	return err;
+}
+
+int restore_signal_shadow_stack(void)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	void *xstate;
+	int proc32 = in_ia32_syscall();
+	unsigned long new_ssp;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) || !shstk->size)
+		return 0;
+
+	err = shstk_check_rstor_token(proc32, &new_ssp);
+	if (err)
+		return err;
+
+	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
+	err = xsave_wrmsrl(xstate, MSR_IA32_PL3_SSP, new_ssp);
+	end_update_xsave_msrs();
+
+	return err;
+}
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index ec71e06ae364..e6202fc2a56c 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -48,6 +48,7 @@
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
 	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
@@ -991,6 +1001,9 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (compat_restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-- 
2.17.1

