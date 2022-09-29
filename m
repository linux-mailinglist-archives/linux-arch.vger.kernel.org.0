Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156F95F0098
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiI2WgG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiI2WfM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:35:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9781D88FE;
        Thu, 29 Sep 2022 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490702; x=1696026702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gU6V+WJRMKjubaZpzETKP7bqEU4+qBZvqdpAOnIAvbA=;
  b=Px8bRjCujWOco4CEirwQGje8EYIpHL3TTXrkTwcU6zUD3pSSoLhdfC7k
   HANMIHraGnW0dBUFSoQC1jfbbn8+Ov7CNqubb9rFf8T3NeLXH08Srm+3E
   TkDcbhtS8VxEzGA/nhRuvXcxLlIn5fsIqTwCa85wNHwLV8JN3nbindiro
   MZHWw+f2DqOkzQjIrW+BnH4GoLxdgFjzXXW5I2ySVbc7wDiihKPzByVCg
   yt0pqmerklzV8L3VIvivltaYXo69Pv8BVwVDBfcUkgkjyseBlJ0tZ+axv
   ULE+E8UvxyAyBFaazf8uRWxo7O0/o+jj04kHxMDsK4AemszA0+K8ZIpAZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182083"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182083"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016330"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016330"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:42 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 27/39] x86/cet/shstk: Handle signals for shadow stack
Date:   Thu, 29 Sep 2022 15:29:24 -0700
Message-Id: <20220929222936.14584-28-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>

---

v2:
 - Switch to new shstk signal format

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

 arch/x86/ia32/ia32_signal.c |   1 +
 arch/x86/include/asm/cet.h  |   5 ++
 arch/x86/kernel/shstk.c     | 126 ++++++++++++++++++++++++++++++------
 arch/x86/kernel/signal.c    |  10 +++
 4 files changed, 123 insertions(+), 19 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index c9c3859322fa..88d71b9de616 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -34,6 +34,7 @@
 #include <asm/sigframe.h>
 #include <asm/sighandling.h>
 #include <asm/smap.h>
+#include <asm/cet.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 924de99e0c61..8c6fab9f402a 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct ksignal;
 
 struct thread_shstk {
 	u64	base;
@@ -22,6 +23,8 @@ int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 void shstk_free(struct task_struct *p);
 int shstk_disable(void);
 void reset_thread_shstk(void);
+int setup_signal_shadow_stack(struct ksignal *ksig);
+int restore_signal_shadow_stack(void);
 #else
 static inline long cet_prctl(struct task_struct *task, int option,
 		      unsigned long features) { return -EINVAL; }
@@ -33,6 +36,8 @@ static inline int shstk_alloc_thread_stack(struct task_struct *p,
 static inline void shstk_free(struct task_struct *p) {}
 static inline int shstk_disable(void) { return -EOPNOTSUPP; }
 static inline void reset_thread_shstk(void) {}
+static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
+static inline int restore_signal_shadow_stack(void) { return 0; }
 #endif /* CONFIG_X86_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 8904aef487bf..04442134aadd 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -227,41 +227,129 @@ static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
 }
 
 /*
- * Verify the user shadow stack has a valid token on it, and then set
- * *new_ssp according to the token.
+ * Create a restore token on shadow stack, and then push the user-mode
+ * function return address.
  */
-static int shstk_check_rstor_token(unsigned long *new_ssp)
+static int shstk_setup_rstor_token(unsigned long ret_addr, unsigned long *new_ssp)
 {
-	unsigned long token_addr;
-	unsigned long token;
+	unsigned long ssp, token_addr;
+	int err;
+
+	if (!ret_addr)
+		return -EINVAL;
+
+	ssp = get_user_shstk_addr();
+	if (!ssp)
+		return -EINVAL;
+
+	err = create_rstor_token(ssp, &token_addr);
+	if (err)
+		return err;
+
+	ssp = token_addr - sizeof(u64);
+	err = write_user_shstk_64((u64 __user *)ssp, (u64)ret_addr);
+
+	if (!err)
+		*new_ssp = ssp;
+
+	return err;
+}
+
+static int shstk_push_sigframe(unsigned long *ssp)
+{
+	unsigned long target_ssp = *ssp;
+
+	/* Token must be aligned */
+	if (!IS_ALIGNED(*ssp, 8))
+		return -EINVAL;
 
-	token_addr = get_user_shstk_addr();
-	if (!token_addr)
+	if (!IS_ALIGNED(target_ssp, 8))
 		return -EINVAL;
 
-	if (get_user(token, (unsigned long __user *)token_addr))
+	*ssp -= SS_FRAME_SIZE;
+	if (put_shstk_data((void *__user)*ssp, target_ssp))
 		return -EFAULT;
 
-	/* Is mode flag correct? */
-	if (!(token & BIT(0)))
+	return 0;
+}
+
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
 		return -EINVAL;
 
-	/* Is busy flag set? */
-	if (token & BIT(1))
+	/* SSP in userspace? */
+	if (unlikely(token_addr >= TASK_SIZE_MAX))
 		return -EINVAL;
 
-	/* Mask out flags */
-	token &= ~3UL;
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
 
-	/* Restore address aligned? */
-	if (!IS_ALIGNED(token, 8))
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
+	    !feature_enabled(CET_SHSTK))
+		return 0;
+
+	if (!restorer)
 		return -EINVAL;
 
-	/* Token placed properly? */
-	if (((ALIGN_DOWN(token, 8) - 8) != token_addr) || token >= TASK_SIZE_MAX)
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
+	fpu_lock_and_load();
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
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
+	    !feature_enabled(CET_SHSTK))
+		return 0;
+
+	ssp = get_user_shstk_addr();
+	if (unlikely(!ssp))
 		return -EINVAL;
 
-	*new_ssp = token;
+	err = shstk_pop_sigframe(&ssp);
+	if (unlikely(err))
+		return err;
+
+	fpu_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	fpregs_unlock();
 
 	return 0;
 }
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 9c7265b524c7..d2081305f698 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -47,6 +47,7 @@
 #include <asm/syscall.h>
 #include <asm/sigframe.h>
 #include <asm/signal.h>
+#include <asm/cet.h>
 
 #ifdef CONFIG_X86_64
 /*
@@ -472,6 +473,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	frame = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe), &fp);
 	uc_flags = frame_uc_flags(regs);
 
+	if (setup_signal_shadow_stack(ksig))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -675,6 +679,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
@@ -992,6 +999,9 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (compat_restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-- 
2.17.1

