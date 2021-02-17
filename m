Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B918A31E22B
	for <lists+linux-arch@lfdr.de>; Wed, 17 Feb 2021 23:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhBQW3R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 17:29:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:13775 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233715AbhBQW3I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Feb 2021 17:29:08 -0500
IronPort-SDR: pS7EPSbSy3eZax0vnjy5exCWp26FIJXBzsfh+Djo2GkXZyi09Gl3RIaWLZ2fPdpvvh5Vb/z6ew
 tOtSbpDL84QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="183461436"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="183461436"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 14:27:56 -0800
IronPort-SDR: c2+mSaWb0KR0wfAwIEm20Wc+TTy9xS3ET+XWHcJvirCRUiuv0FDn+U9Iqygov+shBSBwrQssaY
 DtZZIJdCt9FA==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="400172604"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 14:27:56 -0800
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH v21 06/26] x86/cet: Add control-protection fault handler
Date:   Wed, 17 Feb 2021 14:27:10 -0800
Message-Id: <20210217222730.15819-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210217222730.15819-1-yu-cheng.yu@intel.com>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
 arch/x86/include/asm/idtentry.h    |  4 ++
 arch/x86/kernel/idt.c              |  4 ++
 arch/x86/kernel/signal_compat.c    |  2 +-
 arch/x86/kernel/traps.c            | 63 ++++++++++++++++++++++++++++++
 include/uapi/asm-generic/siginfo.h |  3 +-
 5 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index f656aabd1545..ff4b3bf634da 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -574,6 +574,10 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,	exc_stack_segment);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
 
+#ifdef CONFIG_X86_CET
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP, exc_control_protection);
+#endif
+
 /* Raw exception entries which need extra work */
 DECLARE_IDTENTRY_RAW(X86_TRAP_UD,		exc_invalid_op);
 DECLARE_IDTENTRY_RAW(X86_TRAP_BP,		exc_int3);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index ee1a283f8e96..e8166d9bbb10 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -105,6 +105,10 @@ static const __initconst struct idt_data def_idts[] = {
 #elif defined(CONFIG_X86_32)
 	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
 #endif
+
+#ifdef CONFIG_X86_CET
+	INTG(X86_TRAP_CP,		asm_exc_control_protection),
+#endif
 };
 
 /*
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index a5330ff498f0..dd92490b1e7f 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
 	 */
 	BUILD_BUG_ON(NSIGILL  != 11);
 	BUILD_BUG_ON(NSIGFPE  != 15);
-	BUILD_BUG_ON(NSIGSEGV != 9);
+	BUILD_BUG_ON(NSIGSEGV != 10);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 5);
 	BUILD_BUG_ON(NSIGCHLD != 6);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7f5aec758f0e..8c7fa91a57c9 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
+#include <linux/nospec.h>
 
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -606,6 +607,68 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	cond_local_irq_disable(regs);
 }
 
+#ifdef CONFIG_X86_CET
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
+/*
+ * When a control protection exception occurs, send a signal to the responsible
+ * application.  Currently, control protection is only enabled for user mode.
+ * This exception should not come from kernel mode.
+ */
+DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+{
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
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
+	if (!boot_cpu_has(X86_FEATURE_CET))
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
+	    __ratelimit(&rs)) {
+		unsigned long ssp;
+		int err;
+
+		err = array_index_nospec(error_code, ARRAY_SIZE(control_protection_err));
+
+		rdmsrl(MSR_IA32_PL3_SSP, ssp);
+		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
+			 tsk->comm, task_pid_nr(tsk),
+			 regs->ip, regs->sp, ssp, error_code,
+			 control_protection_err[err]);
+		print_vma_addr(KERN_CONT " in ", regs->ip);
+		pr_cont("\n");
+	}
+
+	force_sig_fault(SIGSEGV, SEGV_CPERR,
+			(void __user *)uprobe_get_trap_addr(regs));
+	cond_local_irq_disable(regs);
+}
+#endif
+
 static bool do_int3(struct pt_regs *regs)
 {
 	int res;
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index d2597000407a..1c2ea91284a0 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -231,7 +231,8 @@ typedef struct siginfo {
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

