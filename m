Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856CD2B9B35
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 20:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgKSTGs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 14:06:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:21741 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbgKSTGl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 14:06:41 -0500
IronPort-SDR: tHm/mcoOBnqly1M6/rMuahSggzJDUygLVEujbYFz8VZFI0XrEtfQXxsNmSCerZTpiBTjy59jUI
 KsMUm2kKy0Xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="150614464"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="150614464"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 11:06:40 -0800
IronPort-SDR: QvspKCblnMCzsL5wITYJlqCsyv5vaoj+VeSN8G8G3ANsVrt2oRyOfr/jIoEfE+Rm7qkyy7yfoR
 iAXOglYNV5mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="431333996"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 11:06:40 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, mpe@ellerman.id.au, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow before a signal delivery
Date:   Thu, 19 Nov 2020 11:02:36 -0800
Message-Id: <20201119190237.626-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119190237.626-1-chang.seok.bae@intel.com>
References: <20201119190237.626-1-chang.seok.bae@intel.com>
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
index ee6f1ceaa7a2..cee41d684dc2 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -251,8 +251,13 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 
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
@@ -725,6 +730,15 @@ unsigned long get_sigframe_size(void)
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

