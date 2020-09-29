Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6392027D988
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgI2VBy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:01:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:60586 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbgI2VBw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Sep 2020 17:01:52 -0400
IronPort-SDR: YqjQ7BBj2w/VORYfL4iMIpRqNY1FRupbSPwRZwzhE3hDd6I35ku+MmBTA1colYUpyxWn7/4CyA
 uc7wTWOCop2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="149947659"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="149947659"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 14:01:23 -0700
IronPort-SDR: kLPKBEWv63RmoW56qUnEOBnWqvvZ02oPrWI3Wcod7olPPek2flGdR8NkXIJxICnQNb60hS0YXo
 iCrdENr9MXdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="514024816"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga006.fm.intel.com with ESMTP; 29 Sep 2020 14:01:22 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, mpe@ellerman.id.au, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [RFC PATCH 3/4] x86/signal: Prevent an alternate stack overflow before a signal delivery
Date:   Tue, 29 Sep 2020 13:57:45 -0700
Message-Id: <20200929205746.6763-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929205746.6763-1-chang.seok.bae@intel.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel pushes data on the userspace stack when entering a signal. If
using a sigaltstack(), the kernel precisely knows the user stack size.

When the kernel knows that the user stack is too small, avoid the overflow
and do an immediate SIGSEGV instead.

This overflow is known to occur on systems with large XSAVE state. The
effort to increase the size typically used for altstacks reduces the
frequency of these overflows, but this approach is still useful for legacy
binaries.

Here the kernel expects a bit conservative stack size (for 64-bit apps).
Legacy binaries used a too-small sigaltstack would be already overflowed
before this change, if they run on modern hardware.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/ia32/ia32_signal.c     | 11 ++++++++---
 arch/x86/include/asm/sigframe.h |  2 ++
 arch/x86/kernel/signal.c        | 16 +++++++++++++++-
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 81cf22398cd1..85abd9eb79d5 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -210,13 +210,18 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 	sp = regs->sp;
 
 	/* This is the X/Open sanctioned signal stack switching.  */
-	if (ksig->ka.sa.sa_flags & SA_ONSTACK)
+	if (ksig->ka.sa.sa_flags & SA_ONSTACK) {
+		/* If the altstack might overflow, die with SIGSEGV: */
+		if (!altstack_size_ok(current))
+			return (void __user *)-1L;
+
 		sp = sigsp(sp, ksig);
 	/* This is the legacy signal stack switching. */
-	else if (regs->ss != __USER32_DS &&
+	} else if (regs->ss != __USER32_DS &&
 		!(ksig->ka.sa.sa_flags & SA_RESTORER) &&
-		 ksig->ka.sa.sa_restorer)
+		 ksig->ka.sa.sa_restorer) {
 		sp = (unsigned long) ksig->ka.sa.sa_restorer;
+	}
 
 	sp = fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
 	*fpstate = (struct _fpstate_32 __user *) sp;
diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
index ac77f3f90bc9..c9f2f9ace76f 100644
--- a/arch/x86/include/asm/sigframe.h
+++ b/arch/x86/include/asm/sigframe.h
@@ -106,6 +106,8 @@ struct rt_sigframe_x32 {
 #define SIZEOF_rt_sigframe_x32	0
 #endif
 
+bool altstack_size_ok(struct task_struct *tsk);
+
 void __init init_sigframe_size(void);
 
 #endif /* _ASM_X86_SIGFRAME_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 2a313d34ec49..c042236ef52e 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -246,8 +246,13 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (sas_ss_flags(sp) == 0)
+		if (sas_ss_flags(sp) == 0) {
+			/* If the altstack might overflow, die with SIGSEGV: */
+			if (!altstack_size_ok(current))
+				return (void __user *)-1L;
+
 			sp = current->sas_ss_sp + current->sas_ss_size;
+		}
 	} else if (IS_ENABLED(CONFIG_X86_32) &&
 		   !onsigstack &&
 		   regs->ss != __USER_DS &&
@@ -713,6 +718,15 @@ unsigned long get_sigframe_size(void)
 	return max_frame_size;
 }
 
+bool altstack_size_ok(struct task_struct *tsk)
+{
+	/*
+	 * Can this task's sigaltstack accommodate the largest
+	 * signal frame the kernel might need?
+	 */
+	return (tsk->sas_ss_size >= max_frame_size);
+}
+
 static inline int is_ia32_compat_frame(struct ksignal *ksig)
 {
 	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
-- 
2.17.1

