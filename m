Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A916A4E99
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjB0Wfa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjB0Wdk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:33:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A3F2A6E8;
        Mon, 27 Feb 2023 14:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537128; x=1709073128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lP5MPQ2jM0Cm31tDJBvrQ8+bAxBLar4e9NDXZhzO2V4=;
  b=Kc4BobwEkKJAA4bi6ELw0FZhi9hUqTuc/jUd8SMz9GxjCkl9RrL0xiPv
   pO+IzvxEmwGxS5ylWsPlbz4SOUt+pH1y+eEG5Od4ccl3RzGbBzDH779P4
   DCj7AFB8kAq1mDhK2iIbNaaGkwZU9kS32ipGJ7zVr3Ndno8MjzAJKc+gP
   pnO2LCwHVyocEDAuyjX7dKRTp6VpcLRjvcrzgxa8PaniOTRmyvKvltOOL
   yRaOauSHfyiq+ovc6t9mLzitnbdfsG+iwglgyuDlpAeCVz6VozqaaSBNy
   uN07lTrGCpgoVChyg4PVsFoyL4nwuqcaYGsE5AJsooqoMGhsIGEVpnsa/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313657796"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313657796"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="848024758"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="848024758"
Received: from leonqu-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.72.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:31 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 32/41] x86/shstk: Handle signals for shadow stack
Date:   Mon, 27 Feb 2023 14:29:48 -0800
Message-Id: <20230227222957.24501-33-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
---
 arch/x86/include/asm/shstk.h |  5 ++
 arch/x86/kernel/shstk.c      | 98 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/signal.c     |  1 +
 arch/x86/kernel/signal_64.c  |  6 +++
 4 files changed, 110 insertions(+)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 1399f4df098b..acee68d30a07 100644
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
 			       unsigned long arg2) { return -EINVAL; }
@@ -28,6 +31,8 @@ static inline int shstk_alloc_thread_stack(struct task_struct *p,
 					   unsigned long stack_size,
 					   unsigned long *shstk_addr) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
+static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
+static inline int restore_signal_shadow_stack(void) { return 0; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 13c02747386f..40f0a55762a9 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -232,6 +232,104 @@ static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
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
index 004cb30b7419..356253e85ce9 100644
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
index 0e808c72bf7e..cacf2ede6217 100644
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

