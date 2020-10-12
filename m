Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8ADE28BCCB
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 17:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390575AbgJLPqH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 11:46:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:28365 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389540AbgJLPpw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Oct 2020 11:45:52 -0400
IronPort-SDR: kbiOaKC5vU/CTWeP9HTASalAvyUqioQbkNadgcM/v/zlfupa4H8UYozOP5oXpRWY8EP9eLP7oX
 GSwhyDyOmoLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="229939275"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="229939275"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 08:45:52 -0700
IronPort-SDR: +ewMVzeoFtp7hZWuheQMK+NfvJHqiZ2L5PLnIo0TG52tI9roPU3/FZ2SIb9/1eHXUJalgwAv8R
 IlBuFr16OCVQ==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="530012635"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 08:45:51 -0700
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
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v14 3/7] x86/cet/ibt: Handle signals for Indirect Branch Tracking
Date:   Mon, 12 Oct 2020 08:45:26 -0700
Message-Id: <20201012154530.28382-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201012154530.28382-1-yu-cheng.yu@intel.com>
References: <20201012154530.28382-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An indirect CALL/JMP moves the indirect branch tracking (IBT) state machine
to WAIT_ENDBR status until the instruction reaches an ENDBR opcode.  If the
CALL/JMP does not reach an ENDBR opcode, the processor raises a control-
protection fault.  WAIT_ENDBR status can be read from MSR_IA32_U_CET.

WAIT_ENDBR is cleared for signal handling, and restored for sigreturn.

IBT state machine is described in Intel SDM Vol. 1, Sec. 18.3.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/kernel/cet.c        | 27 +++++++++++++++++++++++++--
 arch/x86/kernel/fpu/signal.c |  8 +++++---
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 1dcd16aa4f90..0edcbd70f408 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -295,6 +295,13 @@ void cet_restore_signal(struct sc_ext *sc_ext)
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
@@ -335,9 +342,25 @@ int cet_setup_signal(bool ia32, unsigned long rstor_addr, struct sc_ext *sc_ext)
 		sc_ext->ssp = new_ssp;
 	}
 
-	if (ssp) {
+	if (ssp || cet->ibt_enabled) {
+
 		start_update_msrs();
-		wrmsrl(MSR_IA32_PL3_SSP, ssp);
+
+		if (ssp)
+			wrmsrl(MSR_IA32_PL3_SSP, ssp);
+
+		if (cet->ibt_enabled) {
+			u64 r;
+
+			rdmsrl(MSR_IA32_U_CET, r);
+
+			if (r & CET_WAIT_ENDBR) {
+				sc_ext->wait_endbr = 1;
+				r &= ~CET_WAIT_ENDBR;
+				wrmsrl(MSR_IA32_U_CET, r);
+			}
+		}
+
 		end_update_msrs();
 	}
 
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c0c2141cb4b3..077853ef6f48 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -57,7 +57,8 @@ int save_cet_to_sigframe(int ia32, void __user *fp, unsigned long restorer)
 {
 	int err = 0;
 
-	if (!current->thread.cet.shstk_size)
+	if (!current->thread.cet.shstk_size &&
+	    !current->thread.cet.ibt_enabled)
 		return 0;
 
 	if (fp) {
@@ -89,7 +90,8 @@ static int get_cet_from_sigframe(int ia32, void __user *fp, struct sc_ext *ext)
 
 	memset(ext, 0, sizeof(*ext));
 
-	if (!current->thread.cet.shstk_size)
+	if (!current->thread.cet.shstk_size &&
+	    !current->thread.cet.ibt_enabled)
 		return 0;
 
 	if (fp) {
@@ -577,7 +579,7 @@ static unsigned long fpu__alloc_sigcontext_ext(unsigned long sp)
 	 * sigcontext_ext is at: fpu + fpu_user_xstate_size +
 	 * FP_XSTATE_MAGIC2_SIZE, then aligned to 8.
 	 */
-	if (cet->shstk_size)
+	if (cet->shstk_size || cet->ibt_enabled)
 		sp -= (sizeof(struct sc_ext) + 8);
 
 	return sp;
-- 
2.21.0

