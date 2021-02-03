Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8ED30E6E5
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 00:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhBCXMv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 18:12:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:30214 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233131AbhBCXAz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 18:00:55 -0500
IronPort-SDR: 880g4OySOF1yE8xfwgZPhHLfcmRs9JsWKZUGtEZK1PHX4zQB64I/p/gbbxuYhFIuOxPhAAocmJ
 DfdtvIralHmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="242642705"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="242642705"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:59:39 -0800
IronPort-SDR: QaoA9Qm3sjTuRolZEDFAFVfALqHNdS8yU5UrqTcivf/Cs5otg1hbsSCikIfGQhOhkP0pFwU/iB
 rjgdKOnbtFjA==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="392697942"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:59:38 -0800
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
Subject: [PATCH v19 2/7] x86/cet/ibt: User-mode Indirect Branch Tracking support
Date:   Wed,  3 Feb 2021 14:58:57 -0800
Message-Id: <20210203225902.479-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210203225902.479-1-yu-cheng.yu@intel.com>
References: <20210203225902.479-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce user-mode Indirect Branch Tracking (IBT) support.  Add routines
for the setup/disable of IBT.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h |  3 +++
 arch/x86/kernel/cet.c      | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 16870e5bc8eb..3a1cba579cb2 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -15,6 +15,7 @@ struct cet_status {
 	unsigned long	shstk_base;
 	unsigned long	shstk_size;
 	unsigned int	locked:1;
+	unsigned int	ibt_enabled:1;
 };
 
 #ifdef CONFIG_X86_CET
@@ -26,6 +27,8 @@ void cet_free_shstk(struct task_struct *p);
 int cet_verify_rstor_token(bool ia32, unsigned long ssp, unsigned long *new_ssp);
 void cet_restore_signal(struct sc_ext *sc);
 int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
+int cet_setup_ibt(void);
+void cet_disable_ibt(void);
 #else
 static inline int prctl_cet(int option, u64 arg2) { return -EINVAL; }
 static inline int cet_setup_thread_shstk(struct task_struct *p,
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index feb466dc2ea8..fff0b35ed0d9 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -13,6 +13,8 @@
 #include <linux/uaccess.h>
 #include <linux/sched/signal.h>
 #include <linux/compat.h>
+#include <linux/vmalloc.h>
+#include <linux/bitops.h>
 #include <asm/msr.h>
 #include <asm/user.h>
 #include <asm/fpu/internal.h>
@@ -341,3 +343,34 @@ int cet_setup_signal(bool ia32, unsigned long rstor_addr, struct sc_ext *sc_ext)
 
 	return 0;
 }
+
+int cet_setup_ibt(void)
+{
+	u64 msr_val;
+
+	if (!static_cpu_has(X86_FEATURE_IBT))
+		return -EOPNOTSUPP;
+
+	start_update_msrs();
+	rdmsrl(MSR_IA32_U_CET, msr_val);
+	msr_val |= (CET_ENDBR_EN | CET_NO_TRACK_EN);
+	wrmsrl(MSR_IA32_U_CET, msr_val);
+	end_update_msrs();
+	current->thread.cet.ibt_enabled = 1;
+	return 0;
+}
+
+void cet_disable_ibt(void)
+{
+	u64 msr_val;
+
+	if (!static_cpu_has(X86_FEATURE_IBT))
+		return;
+
+	start_update_msrs();
+	rdmsrl(MSR_IA32_U_CET, msr_val);
+	msr_val &= ~CET_ENDBR_EN;
+	wrmsrl(MSR_IA32_U_CET, msr_val);
+	end_update_msrs();
+	current->thread.cet.ibt_enabled = 0;
+}
-- 
2.21.0

