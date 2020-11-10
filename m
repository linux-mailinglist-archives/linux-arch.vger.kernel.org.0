Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A752ADC09
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 17:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgKJQZF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 11:25:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:63836 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732834AbgKJQZE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 11:25:04 -0500
IronPort-SDR: xaSCqcuEvp5bg32IDcRkhkH5p3mliK7k7x1Q2gwtAMimDszYui8FsghVMYmlVjY2POys2hodVD
 qYdL4kNnr66Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="149278318"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="149278318"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:25:02 -0800
IronPort-SDR: 8hgy2zFq9onRjh7g758jB74HvoHVkLx01eYQqxR7t+8c+cFHTnNUjJcWrg6QUnqmj2H39xLTpa
 zTD1oIqDRbGg==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="308469034"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:25:02 -0800
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
Subject: [PATCH v15 2/7] x86/cet/ibt: User-mode Indirect Branch Tracking support
Date:   Tue, 10 Nov 2020 08:24:43 -0800
Message-Id: <20201110162448.9846-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201110162448.9846-1-yu-cheng.yu@intel.com>
References: <20201110162448.9846-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce user-mode Indirect Branch Tracking (IBT) support.  Update setup
routines to include IBT.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h               |  3 +++
 arch/x86/include/asm/disabled-features.h |  8 +++++-
 arch/x86/kernel/cet.c                    | 33 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c             | 17 ++++++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)

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
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 6a9fb7f9bc01..e634a03fee14 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -68,6 +68,12 @@
 #define DISABLE_SHSTK	(1 << (X86_FEATURE_SHSTK & 31))
 #endif
 
+#ifdef CONFIG_X86_BRANCH_TRACKING_USER
+#define DISABLE_IBT	0
+#else
+#define DISABLE_IBT	(1<<(X86_FEATURE_IBT & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -90,7 +96,7 @@
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
 			 DISABLE_ENQCMD|DISABLE_SHSTK)
 #define DISABLED_MASK17	0
-#define DISABLED_MASK18	0
+#define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index d57f3a433af9..1dcd16aa4f90 100644
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
+	msr_val &= CET_SHSTK_EN;
+	wrmsrl(MSR_IA32_U_CET, msr_val);
+	end_update_msrs();
+	current->thread.cet.ibt_enabled = 0;
+}
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3d38ae02d9d3..496d25e1c0a1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -537,6 +537,23 @@ static __init int setup_disable_shstk(char *s)
 __setup("no_user_shstk", setup_disable_shstk);
 #endif
 
+#ifdef CONFIG_X86_BRANCH_TRACKING_USER
+static __init int setup_disable_ibt(char *s)
+{
+	/* require an exact match without trailing characters */
+	if (s[0] != '\0')
+		return 0;
+
+	if (!boot_cpu_has(X86_FEATURE_IBT))
+		return 1;
+
+	setup_clear_cpu_cap(X86_FEATURE_IBT);
+	pr_info("x86: 'no_user_ibt' specified, disabling user Branch Tracking\n");
+	return 1;
+}
+__setup("no_user_ibt", setup_disable_ibt);
+#endif
+
 /*
  * Some CPU features depend on higher CPUID levels, which may not always
  * be available due to CPUID level capping or broken virtualization
-- 
2.21.0

