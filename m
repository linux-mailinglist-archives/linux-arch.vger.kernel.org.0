Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34223D2E07
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 22:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhGVUMd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 16:12:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:54377 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhGVUMZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 16:12:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="275560570"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="275560570"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:52:58 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="502035432"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:52:58 -0700
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
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH v28 06/32] x86/cet: Add control-protection fault handler
Date:   Thu, 22 Jul 2021 13:51:53 -0700
Message-Id: <20210722205219.7934-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210722205219.7934-1-yu-cheng.yu@intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A control-protection fault is triggered when a control-flow transfer
attempt violates Shadow Stack or Indirect Branch Tracking constraints.
For example, the return address for a RET instruction differs from the copy
on the shadow stack; or an indirect JMP instruction, without the NOTRACK
prefix, arrives at a non-ENDBR opcode.

The control-protection fault handler works in a similar way as the general
protection fault handler.  It provides the si_code SEGV_CPERR to the signal
handler.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
v25:
- Change CONFIG_X86_CET to CONFIG_X86_SHADOW_STACK.
- Change X86_FEATURE_CET to X86_FEATURE_SHSTK.

 arch/x86/include/asm/idtentry.h    |  4 ++
 arch/x86/kernel/idt.c              |  4 ++
 arch/x86/kernel/signal_compat.c    |  2 +-
 arch/x86/kernel/traps.c            | 63 ++++++++++++++++++++++++++++++
 include/uapi/asm-generic/siginfo.h |  3 +-
 5 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..a90791433152 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -562,6 +562,10 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,	exc_stack_segment);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
 
+#ifdef CONFIG_X86_SHADOW_STACK
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP, exc_control_protection);
+#endif
+
 /* Raw exception entries which need extra work */
 DECLARE_IDTENTRY_RAW(X86_TRAP_UD,		exc_invalid_op);
 DECLARE_IDTENTRY_RAW(X86_TRAP_BP,		exc_int3);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index df0fa695bb09..9f1bdaabc246 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -113,6 +113,10 @@ static const __initconst struct idt_data def_idts[] = {
 #elif defined(CONFIG_X86_32)
 	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
 #endif
+
+#ifdef CONFIG_X86_SHADOW_STACK
+	INTG(X86_TRAP_CP,		asm_exc_control_protection),
+#endif
 };
 
 /*
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 06743ec054d2..049ea3dcc6cb 100644
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
index a58800973aed..58664374ae8a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
+#include <linux/nospec.h>
 
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -607,6 +608,68 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	cond_local_irq_disable(regs);
 }
 
+#ifdef CONFIG_X86_SHADOW_STACK
+static const char * const control_protection_err[] = {
+	"unknown",
+	"near-ret",
+	"far-ret/iret",
+	"endbranch",
+	"rstorssp",
+	"setssbsy",
+	"unknown",
+};
+
+static DEFINE_RATELIMIT_STATE(cpf_rate, DEFAULT_RATELIMIT_INTERVAL,
+			      DEFAULT_RATELIMIT_BURST);
+
+/*
+ * When a control protection exception occurs, send a signal to the responsible
+ * application.  Currently, control protection is only enabled for user mode.
+ * This exception should not come from kernel mode.
+ */
+DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+{
+	struct task_struct *tsk;
+
+	if (!user_mode(regs)) {
+		pr_emerg("PANIC: unexpected kernel control protection fault\n");
+		die("kernel control protection fault", regs, error_code);
+		panic("Machine halted.");
+	}
+
+	cond_local_irq_enable(regs);
+
+	if (!boot_cpu_has(X86_FEATURE_SHSTK))
+		WARN_ONCE(1, "Control protection fault with CET support disabled\n");
+
+	tsk = current;
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = X86_TRAP_CP;
+
+	/*
+	 * Ratelimit to prevent log spamming.
+	 */
+	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
+	    __ratelimit(&cpf_rate)) {
+		unsigned long ssp;
+		int cpf_type;
+
+		cpf_type = array_index_nospec(error_code, ARRAY_SIZE(control_protection_err));
+
+		rdmsrl(MSR_IA32_PL3_SSP, ssp);
+		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
+			 tsk->comm, task_pid_nr(tsk),
+			 regs->ip, regs->sp, ssp, error_code,
+			 control_protection_err[cpf_type]);
+		print_vma_addr(KERN_CONT " in ", regs->ip);
+		pr_cont("\n");
+	}
+
+	force_sig_fault(SIGSEGV, SEGV_CPERR, (void __user *)0);
+	cond_local_irq_disable(regs);
+}
+#endif
+
 static bool do_int3(struct pt_regs *regs)
 {
 	int res;
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 5a3c221f4c9d..a1a153ea3cc3 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -235,7 +235,8 @@ typedef struct siginfo {
 #define SEGV_ADIPERR	7	/* Precise MCD exception */
 #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
 #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
-#define NSIGSEGV	9
+#define SEGV_CPERR	10	/* Control protection fault */
+#define NSIGSEGV	10
 
 /*
  * SIGBUS si_codes
-- 
2.21.0

