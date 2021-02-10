Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95C7316DB4
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 19:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhBJSD1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 13:03:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:41351 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233540AbhBJSBF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Feb 2021 13:01:05 -0500
IronPort-SDR: FKAjvGtdhNvxT8tz4220BoOqDk1Kvw1s0oT6uv60Bxl+DemyP9SmZmDkd7liSgpMlKPDDyqchM
 ytuc0YLyeRQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="266962667"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="266962667"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 09:58:00 -0800
IronPort-SDR: udNU0gLUMKT40xB2CzQEm1gp/rBcpMk0R7QUn82J3EKPrJexdo2eAsc2TTKQc8/WnIGsIzG86G
 5rEjO639Tdfw==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="421140707"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 09:57:59 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>, <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v20 04/25] x86/cpufeatures: Introduce X86_FEATURE_CET and setup functions
Date:   Wed, 10 Feb 2021 09:56:42 -0800
Message-Id: <20210210175703.12492-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210210175703.12492-1-yu-cheng.yu@intel.com>
References: <20210210175703.12492-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce a software-defined X86_FEATURE_CET, which indicates either Shadow
Stack or Indirect Branch Tracking (or both) is present.  Also introduce
related cpu init/setup functions.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/cpufeatures.h          |  2 +-
 arch/x86/include/asm/disabled-features.h    |  5 ++++-
 arch/x86/include/uapi/asm/processor-flags.h |  2 ++
 arch/x86/kernel/cpu/common.c                | 14 ++++++++++++++
 arch/x86/kernel/cpu/intel.c                 |  3 +++
 5 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 292fe87b26b3..d1866659edbd 100644
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
index a66e7f34b788..ab28dc7b30d0 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -71,9 +71,11 @@
 #ifdef CONFIG_X86_CET
 #define DISABLE_SHSTK	0
 #define DISABLE_IBT	0
+#define DISABLE_CET	0
 #else
 #define DISABLE_SHSTK	(1 << (X86_FEATURE_SHSTK & 31))
 #define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
+#define DISABLE_CET	(1 << (X86_FEATURE_CET & 31))
 #endif
 
 /*
@@ -82,7 +84,8 @@
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
index 35ad8480c464..6cd2d5e119ec 100644
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
@@ -1252,6 +1260,11 @@ static void __init cpu_parse_early_param(void)
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
@@ -1591,6 +1604,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	x86_init_rdrand(c);
 	setup_pku(c);
+	setup_cet(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 816fdbec795a..dc762040be05 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -333,6 +333,9 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 
 static void bsp_init_intel(struct cpuinfo_x86 *c)
 {
+	if (cpu_has(c, X86_FEATURE_SHSTK) || cpu_has(c, X86_FEATURE_IBT))
+		setup_force_cpu_cap(X86_FEATURE_CET);
+
 	resctrl_cpu_detect(c);
 }
 
-- 
2.21.0

