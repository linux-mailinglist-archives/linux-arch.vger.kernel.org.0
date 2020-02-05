Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00A153804
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 19:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBESX2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 13:23:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:43407 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbgBESX1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Feb 2020 13:23:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 10:23:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="343835176"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001.fm.intel.com with ESMTP; 05 Feb 2020 10:23:25 -0800
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
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 3/7] x86/cet/ibt: Handle signals for Indirect Branch Tracking
Date:   Wed,  5 Feb 2020 10:23:04 -0800
Message-Id: <20200205182308.4028-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200205182308.4028-1-yu-cheng.yu@intel.com>
References: <20200205182308.4028-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Indirect Branch Tracking setting does not change in signal delivering or
sigreturn; except the WAIT_ENDBR status.  In general, a task is in
WAIT_ENDBR after an indirect CALL/JMP and before the next instruction
starts.

WAIT_ENDBR status can be read from MSR_IA32_U_CET.  It is reset for signal
delivering, but preserved on a task's stack and restored for sigreturn.

v9:
- Fix missing WAIT_ENDBR in signal handling.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/kernel/cet.c        | 24 ++++++++++++++++++++++--
 arch/x86/kernel/fpu/signal.c |  8 +++++---
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 26f5d7c4fbff..07864bef23f9 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -280,7 +280,7 @@ int cet_restore_signal(bool ia32, struct sc_ext *sc_ext)
 	u64 msr_val = 0;
 	int err;
 
-	if (!cet->shstk_enabled)
+	if (!cet->shstk_enabled && !cet->ibt_enabled)
 		return 0;
 
 	cet_user_state = get_xsave_addr(&current->thread.fpu.state.xsave,
@@ -297,6 +297,16 @@ int cet_restore_signal(bool ia32, struct sc_ext *sc_ext)
 		msr_val |= MSR_IA32_CET_SHSTK_EN;
 	}
 
+	if (cet->ibt_enabled) {
+		msr_val |= (MSR_IA32_CET_ENDBR_EN | MSR_IA32_CET_NO_TRACK_EN);
+
+		if (cet->ibt_bitmap_used)
+			msr_val |= (cet->ibt_bitmap_base | MSR_IA32_CET_LEG_IW_EN);
+
+		if (sc_ext->wait_endbr)
+			msr_val |= MSR_IA32_CET_WAIT_ENDBR;
+	}
+
 	cet_user_state->user_cet = msr_val;
 	return 0;
 }
@@ -312,7 +322,7 @@ int cet_setup_signal(bool ia32, unsigned long rstor_addr, struct sc_ext *sc_ext)
 	unsigned long ssp = 0, new_ssp = 0;
 	int err;
 
-	if (!cet->shstk_enabled)
+	if (!cet->shstk_enabled && !cet->ibt_enabled)
 		return 0;
 
 	if (cet->shstk_enabled) {
@@ -339,6 +349,16 @@ int cet_setup_signal(bool ia32, unsigned long rstor_addr, struct sc_ext *sc_ext)
 	}
 
 	start_update_msrs();
+	if (cet->ibt_enabled) {
+		u64 r;
+
+		rdmsrl(MSR_IA32_U_CET, r);
+		if (r & MSR_IA32_CET_WAIT_ENDBR) {
+			sc_ext->wait_endbr = 1;
+			wrmsrl(MSR_IA32_U_CET, r & ~MSR_IA32_CET_WAIT_ENDBR);
+		}
+	}
+
 	if (cet->shstk_enabled)
 		wrmsrl(MSR_IA32_PL3_SSP, ssp);
 	end_update_msrs();
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 875cc0fadce3..1d8a75408b95 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -57,7 +57,8 @@ int save_cet_to_sigframe(void __user *fp, unsigned long restorer, int is_ia32)
 	int err = 0;
 
 #ifdef CONFIG_X86_INTEL_CET
-	if (!current->thread.cet.shstk_enabled)
+	if (!current->thread.cet.shstk_enabled &&
+	    !current->thread.cet.ibt_enabled)
 		return 0;
 
 	if (fp) {
@@ -89,7 +90,8 @@ static int restore_cet_from_sigframe(int is_ia32, void __user *fp)
 	int err = 0;
 
 #ifdef CONFIG_X86_INTEL_CET
-	if (!current->thread.cet.shstk_enabled)
+	if (!current->thread.cet.shstk_enabled &&
+	    !current->thread.cet.ibt_enabled)
 		return 0;
 
 	if (fp) {
@@ -548,7 +550,7 @@ static unsigned long fpu__alloc_sigcontext_ext(unsigned long sp)
 	if (cpu_x86_cet_enabled()) {
 		struct cet_status *cet = &current->thread.cet;
 
-		if (cet->shstk_enabled)
+		if (cet->shstk_enabled || cet->ibt_enabled)
 			sp -= (sizeof(struct sc_ext) + 8);
 	}
 
-- 
2.21.0

