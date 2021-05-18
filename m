Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC2D38810D
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 22:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbhERUKy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 16:10:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:15748 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238591AbhERUKq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 16:10:46 -0400
IronPort-SDR: noZfkefOO/G1Su5w+ESszxLi6RDVnlXW5WF/nyDwXMvdzKAtsR004TiW7be+9ubtyHe/5lK0hC
 AXKu2WRI1PAQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="180411928"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="180411928"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:08:54 -0700
IronPort-SDR: mF6ESxtvGBwEPTLpSSVTm0Q5UUOfznKZFcuTFP9KoTnEtDTc3M2iW/0+gl8WcS0NjAGlaZkFFa
 tix6mZ5h+/4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="394993628"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2021 13:08:53 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v9 5/6] x86/signal: Detect and prevent an alternate signal stack overflow
Date:   Tue, 18 May 2021 13:03:19 -0700
Message-Id: <20210518200320.17239-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518200320.17239-1-chang.seok.bae@intel.com>
References: <20210518200320.17239-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel pushes context on to the userspace stack to prepare for the
user's signal handler. When the user has supplied an alternate signal
stack, via sigaltstack(2), it is easy for the kernel to verify that the
stack size is sufficient for the current hardware context.

Check if writing the hardware context to the alternate stack will exceed
it's size. If yes, then instead of corrupting user-data and proceeding with
the original signal handler, an immediate SIGSEGV signal is delivered.

Refactor the stack pointer check code from on_sig_stack() and use the new
helper.

While the kernel allows new source code to discover and use a sufficient
alternate signal stack size, this check is still necessary to protect
binaries with insufficient alternate signal stack size from data
corruption.

Reported-by: Florian Weimer <fweimer@redhat.com>
Fixes: c2bc11f10a39 ("x86, AVX-512: Enable AVX-512 States Context Switch")
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=153531
---
Changes from v8:
* Added a "\n" at the end of the sigaltstack overflow message. (Borislav
  Petkov)

Changes from v7:
* Separated the notion for entering altstack from a nested signal on the
  altstack. (Andy Lutomirski)
* Added the message for sigalstack overflow. (Andy Lutomirski)
* Refactored on_sig_stack(). (Borislav Petkov)
* Included the "Fixes" tag and the bugzilla link as this patch fixes the
  kernel behavior.

Changes from v5:
* Fixed the overflow check. (Andy Lutomirski)
* Updated the changelog.

Changes from v3:
* Updated the changelog (Borislav Petkov)

Changes from v2:
* Simplified the implementation (Jann Horn)
---
 arch/x86/kernel/signal.c     | 24 ++++++++++++++++++++----
 include/linux/sched/signal.h | 19 ++++++++++++-------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 86e53868159a..2ddcf2165bcb 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -239,10 +239,11 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	     void __user **fpstate)
 {
 	/* Default to using normal stack */
+	bool nested_altstack = on_sig_stack(regs->sp);
+	bool entering_altstack = false;
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
-	int onsigstack = on_sig_stack(sp);
 	int ret;
 
 	/* redzone */
@@ -251,15 +252,23 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (sas_ss_flags(sp) == 0)
+		/*
+		 * This checks nested_altstack via sas_ss_flags(). Sensible
+		 * programs use SS_AUTODISARM, which disables that check, and
+		 * programs that don't use SS_AUTODISARM get compatible.
+		 */
+		if (sas_ss_flags(sp) == 0) {
 			sp = current->sas_ss_sp + current->sas_ss_size;
+			entering_altstack = true;
+		}
 	} else if (IS_ENABLED(CONFIG_X86_32) &&
-		   !onsigstack &&
+		   !nested_altstack &&
 		   regs->ss != __USER_DS &&
 		   !(ka->sa.sa_flags & SA_RESTORER) &&
 		   ka->sa.sa_restorer) {
 		/* This is the legacy signal stack switching. */
 		sp = (unsigned long) ka->sa.sa_restorer;
+		entering_altstack = true;
 	}
 
 	sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
@@ -272,8 +281,15 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	 * If we are on the alternate signal stack and would overflow it, don't.
 	 * Return an always-bogus address instead so we will die with SIGSEGV.
 	 */
-	if (onsigstack && !likely(on_sig_stack(sp)))
+	if (unlikely((nested_altstack || entering_altstack) &&
+		     !__on_sig_stack(sp))) {
+
+		if (show_unhandled_signals && printk_ratelimit())
+			pr_info("%s[%d] overflowed sigaltstack\n",
+				current->comm, task_pid_nr(current));
+
 		return (void __user *)-1L;
+	}
 
 	/* save i387 and extended state */
 	ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3f6a0fcaa10c..ae60f838ebb9 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -537,6 +537,17 @@ static inline int kill_cad_pid(int sig, int priv)
 #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
 #define SEND_SIG_PRIV	((struct kernel_siginfo *) 1)
 
+static inline int __on_sig_stack(unsigned long sp)
+{
+#ifdef CONFIG_STACK_GROWSUP
+	return sp >= current->sas_ss_sp &&
+		sp - current->sas_ss_sp < current->sas_ss_size;
+#else
+	return sp > current->sas_ss_sp &&
+		sp - current->sas_ss_sp <= current->sas_ss_size;
+#endif
+}
+
 /*
  * True if we are on the alternate signal stack.
  */
@@ -554,13 +565,7 @@ static inline int on_sig_stack(unsigned long sp)
 	if (current->sas_ss_flags & SS_AUTODISARM)
 		return 0;
 
-#ifdef CONFIG_STACK_GROWSUP
-	return sp >= current->sas_ss_sp &&
-		sp - current->sas_ss_sp < current->sas_ss_size;
-#else
-	return sp > current->sas_ss_sp &&
-		sp - current->sas_ss_sp <= current->sas_ss_size;
-#endif
+	return __on_sig_stack(sp);
 }
 
 static inline int sas_ss_flags(unsigned long sp)
-- 
2.17.1

