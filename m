Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCEC641290
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiLCAmg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiLCAl2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:41:28 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35D4BE6BC;
        Fri,  2 Dec 2022 16:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027895; x=1701563895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dW8pr7oLP1faANAdoTd00r5c08b8upZ7lrUCKaAAhx8=;
  b=OJMlcLXz+R+AQI6A0ne3zCDswmvAgbpTZST8YLvYG0ykdQ/H6lp6/Fta
   qWkNWLy6LW/DkkFVk4vERtmth/8v6BKKHLPIvpwvEOTtGPQVNY8d36ccc
   XJGqmuHjPhOTFjoudYMh2ytrHQspw//KfG8uqdroE3xGcvkqA90IlS3qs
   GghNQlsmnrW+gs3mqfaX+cbC/W49Ylx93Mfmq+idpXJGAi7DOo1JlGF4m
   oVPeYB2d9k5Y4polNyjeBUz7PNZTpJdnxPdaA/0V3x6HrZkrdXvpGgSds
   V1zRUhL8qPeRXtASPnvIpnDnYwj05L9ic88SuVy1pGhUBs8mnABUX54Gb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711387"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711387"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479976"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479976"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:33 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 29/39] x86/shstk: Handle signals for shadow stack
Date:   Fri,  2 Dec 2022 16:35:56 -0800
Message-Id: <20221203003606.6838-30-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

The other thing to do is to place some type of checkable token on the
thread's shadow stack before handling the signal and check it during
sigreturn. This is an extra layer of protection to hamper attackers
calling sigreturn manually as in SROP-like attacks.

For this token we can use the shadow stack data format defined earlier.
Have the data pushed be the previous SSP. In the future the sigreturn
might want to return back to a different stack. Storing the SSP (instead
of a restore offset or something) allows for future functionality that
may want to restore to a different stack.

So, when handling a signal push
 - the SSP pointing in the shadow stack data format
 - the restorer address below the restore token.

In sigreturn, verify SSP is stored in the data format and pop the shadow
stack.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
---

v3:
 - Drop shstk_setup_rstor_token() (Kees)
 - Drop x32 signal support, since x32 support is dropped

v2:
 - Switch to new shstk signal format

v1:
 - Use xsave helpers.
 - Expand commit log.

Yu-cheng v27:
 - Eliminate saving shadow stack pointer to signal context.

 arch/x86/include/asm/shstk.h |  5 ++
 arch/x86/kernel/shstk.c      | 98 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/signal.c     |  1 +
 arch/x86/kernel/signal_64.c  |  6 +++
 4 files changed, 110 insertions(+)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 172a69052770..746c040f7cb6 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct ksignal;
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 struct thread_shstk {
@@ -19,6 +20,8 @@ int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 			     unsigned long stack_size,
 			     unsigned long *shstk_addr);
 void shstk_free(struct task_struct *p);
+int setup_signal_shadow_stack(struct ksignal *ksig);
+int restore_signal_shadow_stack(void);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			     unsigned long features) { return -EINVAL; }
@@ -28,6 +31,8 @@ static inline int shstk_alloc_thread_stack(struct task_struct *p,
 					   unsigned long stack_size,
 					   unsigned long *shstk_addr) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
+static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
+static inline int restore_signal_shadow_stack(void) { return 0; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 64c60bc58520..e53225a8d39e 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -233,6 +233,104 @@ static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
 	return 0;
 }
 
+static int shstk_push_sigframe(unsigned long *ssp)
+{
+	unsigned long target_ssp = *ssp;
+
+	/* Token must be aligned */
+	if (!IS_ALIGNED(*ssp, 8))
+		return -EINVAL;
+
+	if (!IS_ALIGNED(target_ssp, 8))
+		return -EINVAL;
+
+	*ssp -= SS_FRAME_SIZE;
+	if (put_shstk_data((void *__user)*ssp, target_ssp))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int shstk_pop_sigframe(unsigned long *ssp)
+{
+	unsigned long token_addr;
+	int err;
+
+	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
+	if (unlikely(err))
+		return err;
+
+	/* Restore SSP aligned? */
+	if (unlikely(!IS_ALIGNED(token_addr, 8)))
+		return -EINVAL;
+
+	/* SSP in userspace? */
+	if (unlikely(token_addr >= TASK_SIZE_MAX))
+		return -EINVAL;
+
+	*ssp = token_addr;
+
+	return 0;
+}
+
+int setup_signal_shadow_stack(struct ksignal *ksig)
+{
+	void __user *restorer = ksig->ka.sa.sa_restorer;
+	unsigned long ssp;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	if (!restorer)
+		return -EINVAL;
+
+	ssp = get_user_shstk_addr();
+	if (unlikely(!ssp))
+		return -EINVAL;
+
+	err = shstk_push_sigframe(&ssp);
+	if (unlikely(err))
+		return err;
+
+	/* Push restorer address */
+	ssp -= SS_FRAME_SIZE;
+	err = write_user_shstk_64((u64 __user *)ssp, (u64)restorer);
+	if (unlikely(err))
+		return -EFAULT;
+
+	fpregs_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	fpregs_unlock();
+
+	return 0;
+}
+
+int restore_signal_shadow_stack(void)
+{
+	unsigned long ssp;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	ssp = get_user_shstk_addr();
+	if (unlikely(!ssp))
+		return -EINVAL;
+
+	err = shstk_pop_sigframe(&ssp);
+	if (unlikely(err))
+		return err;
+
+	fpregs_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	fpregs_unlock();
+
+	return 0;
+}
+
 void shstk_free(struct task_struct *tsk)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 1504eb8d25aa..b2c9853ce1c5 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -40,6 +40,7 @@
 #include <asm/syscall.h>
 #include <asm/sigframe.h>
 #include <asm/signal.h>
+#include <asm/shstk.h>
 
 static inline int is_ia32_compat_frame(struct ksignal *ksig)
 {
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index ff9c55064223..6708ec2b00a3 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -175,6 +175,9 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
 	uc_flags = frame_uc_flags(regs);
 
+	if (setup_signal_shadow_stack(ksig))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -260,6 +263,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-- 
2.17.1

