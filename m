Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53B12D4E33
	for <lists+linux-arch@lfdr.de>; Wed,  9 Dec 2020 23:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbgLIWYt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Dec 2020 17:24:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:14593 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388257AbgLIWYh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Dec 2020 17:24:37 -0500
IronPort-SDR: 8vuBj69WIbhAtw6PPJ+pkDWW/8ErpfUmHfCcSml2B7HV19Kk4esVKrfTaxG6902d0Ac2bKDZ2X
 WNSrAhw2trFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="161918059"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="161918059"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 14:23:47 -0800
IronPort-SDR: CP6PZcmeVwvtbtuAKyd6lJn0X6rH0mwteYnL87xSNlF+yNPFTZt/Vg6lnnJN8q39PdtkULzflC
 WO5xYnJkdV+Q==
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="318543516"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 14:23:47 -0800
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
Subject: [PATCH v16 04/26] x86/cpufeatures: Introduce X86_FEATURE_CET and setup functions
Date:   Wed,  9 Dec 2020 14:22:58 -0800
Message-Id: <20201209222320.1724-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201209222320.1724-1-yu-cheng.yu@intel.com>
References: <20201209222320.1724-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce a software-defined X86_FEATURE_CET, which indicates either Shadow
Stack or Indirect Branch Tracking (or both) is present.  Also introduce
related cpu init/setup functions.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cpufeatures.h          |  2 +-
 arch/x86/include/asm/disabled-features.h    |  5 ++-
 arch/x86/include/uapi/asm/processor-flags.h |  2 ++
 arch/x86/kernel/cpu/common.c                | 40 ++++++++++++++++++++-
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index c9f6d62da463..16d445e6fa6b 100644
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
index b22ba3db6b25..e4d5ca2ba5c6 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -65,9 +65,11 @@
 #ifdef CONFIG_X86_CET_USER
 #define DISABLE_SHSTK	0
 #define DISABLE_IBT	0
+#define DISABLE_CET	0
 #else
 #define DISABLE_SHSTK	(1 << (X86_FEATURE_SHSTK & 31))
 #define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
+#define DISABLE_CET	(1 << (X86_FEATURE_CET & 31))
 #endif
 
 /*
@@ -76,7 +78,8 @@
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
index 35ad8480c464..03c367f79adc 100644
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
@@ -895,6 +903,12 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 	}
 }
 
+static void init_cet_features(struct cpuinfo_x86 *c)
+{
+	if (cpu_has(c, X86_FEATURE_SHSTK) || cpu_has(c, X86_FEATURE_IBT))
+		set_cpu_cap(c, X86_FEATURE_CET);
+}
+
 void get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
@@ -960,6 +974,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	if (c->extended_cpuid_level >= 0x8000000a)
 		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
 
+	init_cet_features(c);
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
 
@@ -1221,6 +1236,15 @@ static void detect_nopl(void)
 #endif
 }
 
+static void adjust_combined_cpu_features(void)
+{
+#ifdef CONFIG_X86_CET_USER
+	if (test_bit(X86_FEATURE_SHSTK, (unsigned long *)cpu_caps_cleared) &&
+	    test_bit(X86_FEATURE_IBT, (unsigned long *)cpu_caps_cleared))
+		setup_clear_cpu_cap(X86_FEATURE_CET);
+#endif
+}
+
 /*
  * We parse cpu parameters early because fpu__init_system() is executed
  * before parse_early_param().
@@ -1252,9 +1276,19 @@ static void __init cpu_parse_early_param(void)
 	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
 		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
 
+	/*
+	 * CET states are XSAVES states and options must be parsed early.
+	 */
+#ifdef CONFIG_X86_CET_USER
+	if (cmdline_find_option_bool(boot_command_line, "no_user_shstk"))
+		setup_clear_cpu_cap(X86_FEATURE_SHSTK);
+	if (cmdline_find_option_bool(boot_command_line, "no_user_ibt"))
+		setup_clear_cpu_cap(X86_FEATURE_IBT);
+#endif
+
 	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
 	if (arglen <= 0)
-		return;
+		goto done;
 
 	pr_info("Clearing CPUID bits:");
 	do {
@@ -1272,6 +1306,9 @@ static void __init cpu_parse_early_param(void)
 		}
 	} while (res == 2);
 	pr_cont("\n");
+
+done:
+	adjust_combined_cpu_features();
 }
 
 /*
@@ -1591,6 +1628,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	x86_init_rdrand(c);
 	setup_pku(c);
+	setup_cet(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
-- 
2.21.0

