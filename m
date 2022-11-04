Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA76C61A44D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKDWkP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKDWjg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:39:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE3E32BAC;
        Fri,  4 Nov 2022 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601569; x=1699137569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xVzcmLcOg1LYW5UNi4yo2WlRphPxkoAotUhaYFjXMBs=;
  b=jFyUQeMrJeUUn+y/c/zTaR8TL6nII1K6dY5uUVxVujjC9kV1OaitoNZU
   l6CBoG2MbsFVgpiD7vO+7AszqSiNA3m/xuipzS5fyYwxnzlA51vqktzGr
   4BQgp6C1eeWmuPzlysfMOI/GbURgv3+PR+9VgY0XapqcNL1zoQLue9LYO
   U/3H9TwjrIYTt6gpqzjszHdMT/F0Hg99s6h5pzNRKMSJ4snB8oXWQB3sH
   Jik0neGS9duuE2JllqZJ6p0/mhbOiB3RugmPczaFQHlIY258g/s70zbJ2
   zFKcBrYldMj7ofkbD7ZqhE0a4GY7uZeEZjoM6aZGijYPDJ2t9g4OL+k5L
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840503"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840503"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668513990"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668513990"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:27 -0700
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
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH v3 07/37] x86/cet: Add user control-protection fault handler
Date:   Fri,  4 Nov 2022 15:35:34 -0700
Message-Id: <20221104223604.29615-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

A control-protection fault is triggered when a control-flow transfer
attempt violates Shadow Stack or Indirect Branch Tracking constraints.
For example, the return address for a RET instruction differs from the copy
on the shadow stack.

There already exists a control-protection fault handler for handling kernel
IBT. Refactor this fault handler into sparate user and kernel handlers,
like the page fault handler. Add a control-protection handler for usermode.

Keep the same behavior for the kernel side of the fault handler, except for
converting a BUG to a WARN in the case of a #CP happening when
!cpu_feature_enabled(). This unifies the behavior with the new shadow stack
code, and also prevents the kernel from crashing under this situation which
is potentially recoverable.

The control-protection fault handler works in a similar way as the general
protection fault handler. It provides the si_code SEGV_CPERR to the signal
handler.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>

---

v3:
 - Shorten user/kernel #CP handler function names (peterz)
 - Restore CP_ENDBR check to kernel handler (peterz)
 - Utilize CONFIG_X86_CET (Kees)
 - Unify "unexpected" warnings (Andrew Cooper)
 - Use 2d array for error code chars (Andrew Cooper)
 - Add comment about why to read SSP MSR before enabling interrupts

v2:
 - Integrate with kernel IBT fault handler
 - Update printed messages. (Dave)
 - Remove array_index_nospec() usage. (Dave)
 - Remove IBT messages. (Dave)
 - Add enclave error code bit processing it case it can get triggered
   somehow.
 - Add extra "unknown" in control_protection_err.

v1:
 - Update static asserts for NSIGSEGV

Yu-cheng v29:
 - Remove pr_emerg() since it is followed by die().
 - Change boot_cpu_has() to cpu_feature_enabled().

 arch/arm/kernel/signal.c                 |   2 +-
 arch/arm64/kernel/signal.c               |   2 +-
 arch/arm64/kernel/signal32.c             |   2 +-
 arch/sparc/kernel/signal32.c             |   2 +-
 arch/sparc/kernel/signal_64.c            |   2 +-
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/idtentry.h          |   2 +-
 arch/x86/kernel/idt.c                    |   2 +-
 arch/x86/kernel/signal_compat.c          |   2 +-
 arch/x86/kernel/traps.c                  | 107 ++++++++++++++++++++---
 arch/x86/xen/enlighten_pv.c              |   2 +-
 arch/x86/xen/xen-asm.S                   |   2 +-
 include/uapi/asm-generic/siginfo.h       |   3 +-
 13 files changed, 114 insertions(+), 24 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index e07f359254c3..9a3c9de5ac5e 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -681,7 +681,7 @@ asmlinkage void do_rseq_syscall(struct pt_regs *regs)
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 9ad911f1647c..81b13a21046e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1166,7 +1166,7 @@ void __init minsigstksz_setup(void)
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 4700f8522d27..bbd542704730 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -460,7 +460,7 @@ void compat_setup_restart_syscall(struct pt_regs *regs)
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index dad38960d1a8..82da8a2d769d 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -751,7 +751,7 @@ asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp)
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 570e43e6fda5..b4e410976e0d 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -562,7 +562,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 30cd12905499..5ff93b8165ed 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -93,6 +93,12 @@
 #define DISABLE_USER_SHSTK	(1 << (X86_FEATURE_USER_SHSTK & 31))
 #endif
 
+#ifdef CONFIG_X86_KERNEL_IBT
+#define DISABLE_IBT	0
+#else
+#define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -116,7 +122,7 @@
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
 			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
-#define DISABLED_MASK18	0
+#define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 20)
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 72184b0b2219..69e26f48d027 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -618,7 +618,7 @@ DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,	xenpv_exc_double_fault);
 #endif
 
 /* #CP */
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP,	exc_control_protection);
 #endif
 
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index a58c6bc1cd68..5074b8420359 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -107,7 +107,7 @@ static const __initconst struct idt_data def_idts[] = {
 	ISTG(X86_TRAP_MC,		asm_exc_machine_check, IST_INDEX_MCE),
 #endif
 
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 	INTG(X86_TRAP_CP,		asm_exc_control_protection),
 #endif
 
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 879ef8c72f5c..d441804443d5 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
 	 */
 	BUILD_BUG_ON(NSIGILL  != 11);
 	BUILD_BUG_ON(NSIGFPE  != 15);
-	BUILD_BUG_ON(NSIGSEGV != 9);
+	BUILD_BUG_ON(NSIGSEGV != 10);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 6);
 	BUILD_BUG_ON(NSIGCHLD != 6);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 178015a820f0..1ba42c6118ce 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -212,12 +212,7 @@ DEFINE_IDTENTRY(exc_overflow)
 	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
 }
 
-#ifdef CONFIG_X86_KERNEL_IBT
-
-static __ro_after_init bool ibt_fatal = true;
-
-extern void ibt_selftest_ip(void); /* code label defined in asm below */
-
+#ifdef CONFIG_X86_CET
 enum cp_error_code {
 	CP_EC        = (1 << 15) - 1,
 
@@ -230,15 +225,87 @@ enum cp_error_code {
 	CP_ENCL	     = 1 << 15,
 };
 
-DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+static const char control_protection_err[][10] = {
+	[0] = "unknown",
+	[1] = "near ret",
+	[2] = "far/iret",
+	[3] = "endbranch",
+	[4] = "rstorssp",
+	[5] = "setssbsy",
+};
+
+static const char *cp_err_string(unsigned long error_code)
+{
+	unsigned int cpec = error_code & CP_EC;
+
+	if (cpec >= ARRAY_SIZE(control_protection_err))
+		cpec = 0;
+	return control_protection_err[cpec];
+}
+
+static void do_unexpected_cp(struct pt_regs *regs, unsigned long error_code)
+{
+	WARN_ONCE(1, "Unexpected %s #CP, error_code: %s\n",
+		     user_mode(regs) ? "user mode" : "kernel mode",
+		     cp_err_string(error_code));
+}
+#endif /* CONFIG_X86_CET */
+
+void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code);
+
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+static DEFINE_RATELIMIT_STATE(cpf_rate, DEFAULT_RATELIMIT_INTERVAL,
+			      DEFAULT_RATELIMIT_BURST);
+
+void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
-		pr_err("Unexpected #CP\n");
-		BUG();
+	struct task_struct *tsk;
+	unsigned long ssp;
+
+	/*
+	 * An exception was just taken from userspace. Since interrupts are disabled
+	 * here, no scheduling should have messed with the registers yet and they
+	 * will be whatever is live in userspace. So read the SSP before enabling
+	 * interrupts so locking the fpregs to do it later is not required.
+	 */
+	rdmsrl(MSR_IA32_PL3_SSP, ssp);
+
+	cond_local_irq_enable(regs);
+
+	tsk = current;
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = X86_TRAP_CP;
+
+	/* Ratelimit to prevent log spamming. */
+	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
+	    __ratelimit(&cpf_rate)) {
+		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)%s",
+			 tsk->comm, task_pid_nr(tsk),
+			 regs->ip, regs->sp, ssp, error_code,
+			 cp_err_string(error_code),
+			 error_code & CP_ENCL ? " in enclave" : "");
+		print_vma_addr(KERN_CONT " in ", regs->ip);
+		pr_cont("\n");
 	}
 
-	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
+	force_sig_fault(SIGSEGV, SEGV_CPERR, (void __user *)0);
+	cond_local_irq_disable(regs);
+}
+#endif
+
+void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code);
+
+#ifdef CONFIG_X86_KERNEL_IBT
+static __ro_after_init bool ibt_fatal = true;
+
+extern void ibt_selftest_ip(void); /* code label defined in asm below */
+
+void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
+{
+	if ((error_code & CP_EC) != CP_ENDBR) {
+		do_unexpected_cp(regs, error_code);
 		return;
+	}
 
 	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
 		regs->ax = 0;
@@ -284,9 +351,25 @@ static int __init ibt_setup(char *str)
 }
 
 __setup("ibt=", ibt_setup);
-
 #endif /* CONFIG_X86_KERNEL_IBT */
 
+#ifdef CONFIG_X86_CET
+DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+{
+	if (user_mode(regs)) {
+		if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+			do_user_cp_fault(regs, error_code);
+		else
+			do_unexpected_cp(regs, error_code);
+	} else {
+		if (cpu_feature_enabled(X86_FEATURE_IBT))
+			do_kernel_cp_fault(regs, error_code);
+		else
+			do_unexpected_cp(regs, error_code);
+	}
+}
+#endif /* CONFIG_X86_CET */
+
 #ifdef CONFIG_X86_F00F_BUG
 void handle_invalid_op(struct pt_regs *regs)
 #else
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index f82857e48815..cf4ee15e956e 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -638,7 +638,7 @@ static struct trap_array_entry trap_array[] = {
 	TRAP_ENTRY(exc_coprocessor_error,		false ),
 	TRAP_ENTRY(exc_alignment_check,			false ),
 	TRAP_ENTRY(exc_simd_coprocessor_error,		false ),
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 	TRAP_ENTRY(exc_control_protection,		false ),
 #endif
 };
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 6b4fdf6b9542..32f1b05b7a3c 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -148,7 +148,7 @@ xen_pv_trap asm_exc_page_fault
 xen_pv_trap asm_exc_spurious_interrupt_bug
 xen_pv_trap asm_exc_coprocessor_error
 xen_pv_trap asm_exc_alignment_check
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 xen_pv_trap asm_exc_control_protection
 #endif
 #ifdef CONFIG_X86_MCE
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index ffbe4cec9f32..0f52d0ac47c5 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -242,7 +242,8 @@ typedef struct siginfo {
 #define SEGV_ADIPERR	7	/* Precise MCD exception */
 #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
 #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
-#define NSIGSEGV	9
+#define SEGV_CPERR	10	/* Control protection fault */
+#define NSIGSEGV	10
 
 /*
  * SIGBUS si_codes
-- 
2.17.1

