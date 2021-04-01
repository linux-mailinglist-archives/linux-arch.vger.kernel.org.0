Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328DF35220C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhDAWL0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:11:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:34676 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234023AbhDAWLW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:11:22 -0400
IronPort-SDR: UvqOEgKFXaXHa5rWM6r8Km+lnDuIZj/8gcJZIQftNsamtz5YzYQPn6cUAVA1bq14jWw6R1QMl6
 v0JqAkhkLwOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189084521"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="189084521"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:20 -0700
IronPort-SDR: DJYH4ZSS3iY/Oz3QycP6ZmTD0guvKii0n9VIIH6v8SWjnpjZja1ZEZiPwOsSUPJibEzATGikd8
 BxKwP5D8X1Fw==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517513854"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:20 -0700
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
Subject: [PATCH v24 04/30] x86/cpufeatures: Introduce X86_FEATURE_CET and setup functions
Date:   Thu,  1 Apr 2021 15:10:38 -0700
Message-Id: <20210401221104.31584-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221104.31584-1-yu-cheng.yu@intel.com>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce a software-defined X86_FEATURE_CET, which indicates either Shadow
Stack or Indirect Branch Tracking (or both) is present.  Also introduce
related cpu init/setup functions.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v24:
- Update #ifdef placement to reflect Kconfig changes of splitting shadow stack and ibt.

 arch/x86/include/asm/cpufeatures.h          |  2 +-
 arch/x86/include/asm/disabled-features.h    |  9 ++++++++-
 arch/x86/include/uapi/asm/processor-flags.h |  2 ++
 arch/x86/kernel/cpu/common.c                | 14 ++++++++++++++
 arch/x86/kernel/cpu/intel.c                 |  3 +++
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index bf861fc89fef..d771e62677de 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -108,7 +108,7 @@
 #define X86_FEATURE_EXTD_APICID		( 3*32+26) /* Extended APICID (8 bits) */
 #define X86_FEATURE_AMD_DCM		( 3*32+27) /* AMD multi-node processor */
 #define X86_FEATURE_APERFMPERF		( 3*32+28) /* P-State hardware coordination feedback capability (APERF/MPERF MSRs) */
-/* free					( 3*32+29) */
+#define X86_FEATURE_CET			( 3*32+29) /* Control-flow enforcement */
 #define X86_FEATURE_NONSTOP_TSC_S3	( 3*32+30) /* TSC doesn't stop in S3 state */
 #define X86_FEATURE_TSC_KNOWN_FREQ	( 3*32+31) /* TSC has known frequency */
 
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index e5c6ed9373e8..018cd7acd3e9 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -74,13 +74,20 @@
 #define DISABLE_SHSTK	(1 << (X86_FEATURE_SHSTK & 31))
 #endif
 
+#ifdef CONFIG_X86_CET
+#define DISABLE_CET	0
+#else
+#define DISABLE_CET	(1 << (X86_FEATURE_CET & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
 #define DISABLED_MASK0	(DISABLE_VME)
 #define DISABLED_MASK1	0
 #define DISABLED_MASK2	0
-#define DISABLED_MASK3	(DISABLE_CYRIX_ARR|DISABLE_CENTAUR_MCR|DISABLE_K6_MTRR)
+#define DISABLED_MASK3	(DISABLE_CYRIX_ARR|DISABLE_CENTAUR_MCR|DISABLE_K6_MTRR| \
+			 DISABLE_CET)
 #define DISABLED_MASK4	(DISABLE_PCID)
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index bcba3c643e63..a8df907e8017 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -130,6 +130,8 @@
 #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
 #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
+#define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement */
+#define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ab640abe26b6..6bd07727089e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -510,6 +510,14 @@ static __init int setup_disable_pku(char *arg)
 __setup("nopku", setup_disable_pku);
 #endif /* CONFIG_X86_64 */
 
+static __always_inline void setup_cet(struct cpuinfo_x86 *c)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_CET))
+		return;
+
+	cr4_set_bits(X86_CR4_CET);
+}
+
 /*
  * Some CPU features depend on higher CPUID levels, which may not always
  * be available due to CPUID level capping or broken virtualization
@@ -1255,6 +1263,11 @@ static void __init cpu_parse_early_param(void)
 	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
 		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
 
+	if (cmdline_find_option_bool(boot_command_line, "no_user_shstk"))
+		setup_clear_cpu_cap(X86_FEATURE_SHSTK);
+	if (cmdline_find_option_bool(boot_command_line, "no_user_ibt"))
+		setup_clear_cpu_cap(X86_FEATURE_IBT);
+
 	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
 	if (arglen <= 0)
 		return;
@@ -1594,6 +1607,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	x86_init_rdrand(c);
 	setup_pku(c);
+	setup_cet(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0e422a544835..2e11d9555e9b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -334,6 +334,9 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 
 static void bsp_init_intel(struct cpuinfo_x86 *c)
 {
+	if (cpu_has(c, X86_FEATURE_SHSTK) || cpu_has(c, X86_FEATURE_IBT))
+		setup_force_cpu_cap(X86_FEATURE_CET);
+
 	resctrl_cpu_detect(c);
 }
 
-- 
2.21.0

