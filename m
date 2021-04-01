Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CAC35229C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhDAWOi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:14:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:14872 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235648AbhDAWOc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:14:32 -0400
IronPort-SDR: r96STJ4pmPSvxKuGrwztCF4oL9DL3hn9vCtAUDMzAYcuHejfIZSVKwrFurt1WYrf9kKbPAtXGc
 m6SmewgmLT1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="192444271"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192444271"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:14:21 -0700
IronPort-SDR: 7atfJo7+ybHJIawrPasNPqL1tsPBYkSVsVYulWtdvTLKsDQXL0qwpGh70BGDvYih2E+b6Se2m4
 ARnXJqX9iTgA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="394700333"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:14:20 -0700
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
Subject: [PATCH v24 3/9] x86/cet/ibt: Handle signals for Indirect Branch Tracking
Date:   Thu,  1 Apr 2021 15:13:57 -0700
Message-Id: <20210401221403.32253-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221403.32253-1-yu-cheng.yu@intel.com>
References: <20210401221403.32253-1-yu-cheng.yu@intel.com>
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
v24:
- Update for changes from splitting shadow stack and ibt.

 arch/x86/kernel/fpu/signal.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 2e56f2fe8be0..1f54c18607c9 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -71,16 +71,32 @@ int save_extra_state_to_sigframe(int ia32, void __user *fp, unsigned long restor
 			return err;
 
 		ext.ssp = token_addr;
+	}
 
+	if (new_ssp || cet->ibt_enabled) {
 		fpregs_lock();
 		if (test_thread_flag(TIF_NEED_FPU_LOAD))
 			__fpregs_load_activate();
+
 		if (new_ssp)
 			wrmsrl(MSR_IA32_PL3_SSP, new_ssp);
+
+		if (cet->ibt_enabled) {
+			u64 r;
+
+			rdmsrl(MSR_IA32_U_CET, r);
+
+			if (r & CET_WAIT_ENDBR) {
+				ext.wait_endbr = 1;
+				r &= ~CET_WAIT_ENDBR;
+				wrmsrl(MSR_IA32_U_CET, r);
+			}
+		}
+
 		fpregs_unlock();
 	}
 
-	if (ext.ssp) {
+	if (ext.ssp || cet->ibt_enabled) {
 		void __user *p = fp;
 
 		ext.total_size = sizeof(ext);
@@ -110,7 +126,8 @@ static int get_extra_state_from_sigframe(int ia32, void __user *fp, struct sc_ex
 	if (!cpu_feature_enabled(X86_FEATURE_CET))
 		return 0;
 
-	if (!cet->shstk_size)
+	if (!cet->shstk_size &&
+	    !cet->ibt_enabled)
 		return 0;
 
 	memset(ext, 0, sizeof(*ext));
@@ -162,6 +179,13 @@ void restore_extra_state(struct sc_ext *sc_ext)
 		msr_val |= CET_SHSTK_EN;
 	}
 
+	if (cet->ibt_enabled) {
+		msr_val |= (CET_ENDBR_EN | CET_NO_TRACK_EN);
+
+		if (sc_ext->wait_endbr)
+			msr_val |= CET_WAIT_ENDBR;
+	}
+
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		cet_user_state->user_cet = msr_val;
 	else
@@ -626,7 +650,7 @@ static unsigned long fpu__alloc_sigcontext_ext(unsigned long sp)
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

