Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286B264129A
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiLCAnQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiLCAmC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:42:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A101042E1;
        Fri,  2 Dec 2022 16:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027908; x=1701563908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=oXcpHnXlZARx8+yfiIaAkJ+dfiFM2oEqDcrBgXXzKas=;
  b=nk9tCHQwz3olEp/1u47Ox28tDtYJTMZQF8GEBMwjB6skfPV9SWCygZCL
   NT5CE1MTOKB5obYu178zJvAJwvkbelL1PDqyphFtXEyLnxTl6ZPfQ8x0Y
   Z0fykWezxIyhL+JfVX0nRF9i8WrEBIFkoueFCadIjqKy6oGz4RYT8lflq
   tuWDoCaOnqh5Pp5fovUUrfLzGSf4C3MKM19Ur7T4/1y/mPWhWKzbi51qL
   DWT/qBGaFHBCgcMNpiWDsgIes+CgCQNh1RvzFPFMTwEEAdL5+2BqJYXcp
   TAyzUPajlFEKMY+bQd3ddF21qufL2oRooZIpCGZqe/o+p7Iets4qmerrI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711510"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711510"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787480005"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787480005"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:40 -0800
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v4 33/39] x86: Prevent 32 bit operations for 64 bit shstk tasks
Date:   Fri,  2 Dec 2022 16:36:00 -0800
Message-Id: <20221203003606.6838-34-rick.p.edgecombe@intel.com>
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

Shadow stack is only supported in 64 bit kernels. Since 64 bit kernels can
run 32 bit applications using 32 bit emulation it would still be possible
to support shadow stack for 32 bit applications. The challenge for this
would be the shadow stack sigframe format uses noncannonical bits in the
shadow stack frame, for which there are none in 32 bit. This means the 32
bit shadow stack sigframe would need either an alternate unknown solution
or to not support any features that expand the shadow stack sigframe (alt
shadow stack). It would add complexity to separate out these future
features between the ABIs.

But shadow stack support for 32 bit would not likely be very useful. 32
bit emulation is mostly to support old apps, which should not have enabled
shadow stack. So this series disables support for 32 bit apps by blocking
the arch_prctl()s when made via a 32 bit syscall.

But PeterZ points out (see link) that some applications will utilize a 32
bit segment to run 32 bit code inside a 64 bit process. WINE does this to
run 32 bit Windows apps. However, doing this with shadow stack is not
likely to happen in practice since Windows does not support shadow stack
for 32 bit applications either.

Any preexisting applications that are marked with shadow stack are unlikely
to make it to the point where they can exercise any 32 bit signal
interactions anyway, because the HW requires that the shadow stack pointer
register needs to be in the 32 bit range in this case, but shadow stack
would have been allocated in the 64 bit address space. The shadow stack
enabled app would #GP when doing the long jump into the 32 bit segment.

So since 32 bit is not easy to support, and there are likely not many
users. More cleanly don't support 32 bit signals in a 64 bit address
space by not allowing 32 bit ABI signal handlers when shadow stack is
enabled. Do this by clearing any 32 bit ABI signal handlers when shadow
stack is enabled, and disallow any further 32 bit ABI signal handlers.
Also, return an error code for the clone operations when in a 32 bit
syscall.

Link: https://lore.kernel.org/lkml/Y3S5AKhLaU+YuUpQ@hirez.programming.kicks-ass.net/#t
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v4:
 - New patch

 arch/x86/include/asm/shstk.h       | 12 ++++++++++++
 arch/x86/include/asm/sighandling.h |  1 +
 arch/x86/kernel/shstk.c            | 10 ++++++++--
 arch/x86/kernel/signal.c           | 20 ++++++++++++++++++++
 arch/x86/kernel/signal_compat.c    |  5 +++++
 include/linux/ptrace.h             |  1 +
 kernel/signal.c                    |  8 ++++++++
 7 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 746c040f7cb6..c82f22fd5e6d 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -4,6 +4,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
+#include <asm/prctl.h>
 
 struct task_struct;
 struct ksignal;
@@ -22,6 +23,12 @@ int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 void shstk_free(struct task_struct *p);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
+bool features_enabled(unsigned long features);
+
+static inline bool shstk_enabled(void)
+{
+	return features_enabled(ARCH_SHSTK_SHSTK);
+}
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			     unsigned long features) { return -EINVAL; }
@@ -33,6 +40,11 @@ static inline int shstk_alloc_thread_stack(struct task_struct *p,
 static inline void shstk_free(struct task_struct *p) {}
 static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
 static inline int restore_signal_shadow_stack(void) { return 0; }
+
+static inline bool shstk_enabled(void)
+{
+	return false;
+}
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index e770c4fc47f4..eba88c7a6446 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -24,4 +24,5 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
 
+void flush_32bit_signals(struct task_struct *t);
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index e59544fec96d..3a7bcc01d985 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -24,11 +24,11 @@
 #include <asm/shstk.h>
 #include <asm/special_insns.h>
 #include <asm/fpu/api.h>
-#include <asm/prctl.h>
+#include <asm/sighandling.h>
 
 #define SS_FRAME_SIZE 8
 
-static bool features_enabled(unsigned long features)
+bool features_enabled(unsigned long features)
 {
 	return current->thread.features & features;
 }
@@ -146,6 +146,8 @@ static int shstk_setup(void)
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_32bit_syscall())
 		return -EOPNOTSUPP;
 
+	flush_32bit_signals(current);
+
 	size = adjust_shstk_size(0);
 	addr = alloc_shstk(0, size, 0, false);
 	if (IS_ERR_VALUE(addr))
@@ -183,6 +185,10 @@ int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
 	if (!features_enabled(ARCH_SHSTK_SHSTK))
 		return 0;
 
+	/* If shadow stack is enabled, 32 bit syscalls are not supported */
+	if (in_32bit_syscall())
+		return 1;
+
 	/*
 	 * For CLONE_VM, except vfork, the child needs a separate shadow
 	 * stack.
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index b2c9853ce1c5..721b326d61ec 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -352,6 +352,26 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
 	force_sig(SIGSEGV);
 }
 
+void flush_32bit_signals(struct task_struct *t)
+{
+	const unsigned long flags_32 = SA_IA32_ABI | SA_X32_ABI;
+	struct k_sigaction *ka;
+	int i;
+
+	spin_lock_irq(&t->sighand->siglock);
+	ka = &t->sighand->action[0];
+	for (i = 0; i < _NSIG; i++) {
+		if (ka->sa.sa_flags & flags_32) {
+			ka->sa.sa_handler = SIG_DFL;
+			ka->sa.sa_flags = 0;
+			ka->sa.sa_restorer = NULL;
+			sigemptyset(&ka->sa.sa_mask);
+		}
+		ka++;
+	}
+	spin_unlock_irq(&t->sighand->siglock);
+}
+
 #ifdef CONFIG_DYNAMIC_SIGFRAME
 #ifdef CONFIG_STRICT_SIGALTSTACK_SIZE
 static bool strict_sigaltstack_size __ro_after_init = true;
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index d441804443d5..9c73435bc393 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -177,6 +177,11 @@ static inline void signal_compat_build_tests(void)
 	/* any new si_fields should be added here */
 }
 
+bool sigaction_compat_invalid(void)
+{
+	return in_32bit_syscall() && shstk_enabled();
+}
+
 void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
 {
 	signal_compat_build_tests();
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index c952c5ba8fab..30ec68f56caf 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -405,6 +405,7 @@ static inline void user_single_step_report(struct pt_regs *regs)
 extern int task_current_syscall(struct task_struct *target, struct syscall_info *info);
 
 extern void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact);
+bool sigaction_compat_invalid(void);
 
 /*
  * ptrace report for syscall entry and exit looks identical.
diff --git a/kernel/signal.c b/kernel/signal.c
index d140672185a4..a75351c8fc0e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4079,6 +4079,11 @@ void kernel_sigaction(int sig, __sighandler_t action)
 }
 EXPORT_SYMBOL(kernel_sigaction);
 
+bool __weak sigaction_compat_invalid(void)
+{
+	return false;
+}
+
 void __weak sigaction_compat_abi(struct k_sigaction *act,
 		struct k_sigaction *oact)
 {
@@ -4093,6 +4098,9 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 	if (!valid_signal(sig) || sig < 1 || (act && sig_kernel_only(sig)))
 		return -EINVAL;
 
+	if (sigaction_compat_invalid())
+		return -EINVAL;
+
 	k = &p->sighand->action[sig-1];
 
 	spin_lock_irq(&p->sighand->siglock);
-- 
2.17.1

