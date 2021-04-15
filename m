Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941C336152D
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 00:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbhDOWTR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 18:19:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:58096 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235893AbhDOWSn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 18:18:43 -0400
IronPort-SDR: sm4ag+/Qa70uuYdkXnhmRj8NvxzzZBjfCmKEs+VGhjl3oC9H2LkolMCZkcHV3dNmR9Fv7TP/ZQ
 Xl6igypGTNeg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258913074"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="258913074"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:17:47 -0700
IronPort-SDR: eZcpF59bidmyafLieAacJAhx8mMsmULeB5Sao3Mqc2gvetg0QfZZRAPTppGbp89WtKAy+oy8ie
 f4sqCPQh4dgQ==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="399720968"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:17:46 -0700
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v25 3/9] x86/cet/ibt: Handle signals for Indirect Branch Tracking
Date:   Thu, 15 Apr 2021 15:17:28 -0700
Message-Id: <20210415221734.32628-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210415221734.32628-1-yu-cheng.yu@intel.com>
References: <20210415221734.32628-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When an indirect CALL/JMP instruction is executed and before it reaches
the target, it is in 'WAIT_ENDBR' status, which can be read from
MSR_IA32_U_CET.  The status is part of a task's status before a signal is
raised and preserved in the signal frame.  It is restored for sigreturn.

IBT state machine is described in Intel SDM Vol. 1, Sec. 18.3.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v25:
- Move the addition of sc_ext.wait_endbr from an earlier shadow stack
  patch to here.
- Change X86_FEATURE_CET to X86_FEATURE_SHSTK.
- Change wrmsrl() to wrmsrl_safe() and handle error.
v24:
- Update for changes from splitting shadow stack and ibt.

 arch/x86/include/uapi/asm/sigcontext.h |  1 +
 arch/x86/kernel/fpu/signal.c           | 33 +++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/uapi/asm/sigcontext.h
index 10d7fa192d48..ee5bacce7d87 100644
--- a/arch/x86/include/uapi/asm/sigcontext.h
+++ b/arch/x86/include/uapi/asm/sigcontext.h
@@ -203,6 +203,7 @@ struct _xstate {
 struct sc_ext {
 	unsigned long total_size;
 	unsigned long ssp;
+	unsigned long wait_endbr;
 };
 
 /*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 0488407bec81..0ed01e70b09e 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -71,16 +71,29 @@ int save_extra_state_to_sigframe(int ia32, void __user *fp, void __user *restore
 			return err;
 
 		ext.ssp = token_addr;
+	}
 
+	if (new_ssp || cet->ibt_enabled) {
 		fpregs_lock();
 		if (test_thread_flag(TIF_NEED_FPU_LOAD))
 			__fpregs_load_activate();
 		if (new_ssp)
 			err = wrmsrl_safe(MSR_IA32_PL3_SSP, new_ssp);
+
+		if (!err && cet->ibt_enabled) {
+			u64 msr_val;
+
+			err = rdmsrl_safe(MSR_IA32_U_CET, &msr_val);
+			if (!err && (msr_val & CET_WAIT_ENDBR)) {
+				ext.wait_endbr = 1;
+				msr_val &= ~CET_WAIT_ENDBR;
+				err = wrmsrl_safe(MSR_IA32_U_CET, msr_val);
+			}
+		}
 		fpregs_unlock();
 	}
 
-	if (!err && ext.ssp) {
+	if (!err && (ext.ssp || cet->ibt_enabled)) {
 		void __user *p = fp;
 
 		ext.total_size = sizeof(ext);
@@ -110,7 +123,8 @@ static int get_extra_state_from_sigframe(int ia32, void __user *fp, struct sc_ex
 	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
 		return 0;
 
-	if (!cet->shstk_size)
+	if (!cet->shstk_size &&
+	    !cet->ibt_enabled)
 		return 0;
 
 	memset(ext, 0, sizeof(*ext));
@@ -149,6 +163,19 @@ static int restore_extra_state_to_xregs(struct sc_ext *sc_ext)
 
 	if (cet->shstk_size)
 		err = wrmsrl_safe(MSR_IA32_PL3_SSP, sc_ext->ssp);
+
+	if (err)
+		return err;
+
+	if (cet->ibt_enabled && sc_ext->wait_endbr) {
+		u64 msr_val;
+
+		err = rdmsrl_safe(MSR_IA32_U_CET, &msr_val);
+		if (!err) {
+			msr_val |= CET_WAIT_ENDBR;
+			err = wrmsrl_safe(MSR_IA32_U_CET, msr_val);
+		}
+	}
 #endif
 	return err;
 }
@@ -616,7 +643,7 @@ static unsigned long fpu__alloc_sigcontext_ext(unsigned long sp)
 	 * sigcontext_ext is at: fpu + fpu_user_xstate_size +
 	 * FP_XSTATE_MAGIC2_SIZE, then aligned to 8.
 	 */
-	if (cet->shstk_size)
+	if (cet->shstk_size || cet->ibt_enabled)
 		sp -= (sizeof(struct sc_ext) + 8);
 #endif
 	return sp;
-- 
2.21.0

