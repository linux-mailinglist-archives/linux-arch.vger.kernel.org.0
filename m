Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3ED18C321
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfHMVCm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:02:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:16065 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfHMVCj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:02:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="187901340"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2019 14:02:37 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 05/27] x86/fpu/xstate: Introduce CET MSR system states
Date:   Tue, 13 Aug 2019 13:52:03 -0700
Message-Id: <20190813205225.12032-6-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205225.12032-1-yu-cheng.yu@intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Intel Control-flow Enforcement Technology (CET) introduces the
following MSRs.

    MSR_IA32_U_CET (user-mode CET settings),
    MSR_IA32_PL3_SSP (user-mode shadow stack),
    MSR_IA32_PL0_SSP (kernel-mode shadow stack),
    MSR_IA32_PL1_SSP (Privilege Level 1 shadow stack),
    MSR_IA32_PL2_SSP (Privilege Level 2 shadow stack).

Introduce them into XSAVES system states.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/fpu/types.h            | 22 ++++++++++++++++++
 arch/x86/include/asm/fpu/xstate.h           |  4 +++-
 arch/x86/include/asm/msr-index.h            | 18 +++++++++++++++
 arch/x86/include/uapi/asm/processor-flags.h |  2 ++
 arch/x86/kernel/fpu/xstate.c                | 25 +++++++++++++++++++--
 5 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index f098f6cab94b..d7ef4d9c7ad5 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -114,6 +114,9 @@ enum xfeature {
 	XFEATURE_Hi16_ZMM,
 	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
 	XFEATURE_PKRU,
+	XFEATURE_RESERVED,
+	XFEATURE_CET_USER,
+	XFEATURE_CET_KERNEL,
 
 	XFEATURE_MAX,
 };
@@ -128,6 +131,8 @@ enum xfeature {
 #define XFEATURE_MASK_Hi16_ZMM		(1 << XFEATURE_Hi16_ZMM)
 #define XFEATURE_MASK_PT		(1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
+#define XFEATURE_MASK_CET_USER		(1 << XFEATURE_CET_USER)
+#define XFEATURE_MASK_CET_KERNEL	(1 << XFEATURE_CET_KERNEL)
 
 #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK \
@@ -229,6 +234,23 @@ struct pkru_state {
 	u32				pad;
 } __packed;
 
+/*
+ * State component 11 is Control-flow Enforcement user states
+ */
+struct cet_user_state {
+	u64 user_cet;			/* user control-flow settings */
+	u64 user_ssp;			/* user shadow stack pointer */
+};
+
+/*
+ * State component 12 is Control-flow Enforcement kernel states
+ */
+struct cet_kernel_state {
+	u64 kernel_ssp;			/* kernel shadow stack */
+	u64 pl1_ssp;			/* privilege level 1 shadow stack */
+	u64 pl2_ssp;			/* privilege level 2 shadow stack */
+};
+
 struct xstate_header {
 	u64				xfeatures;
 	u64				xcomp_bv;
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 970bbd303cfb..ebf5979b21e7 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -30,7 +30,9 @@
 				  XFEATURE_MASK_Hi16_ZMM | \
 				  XFEATURE_MASK_PKRU | \
 				  XFEATURE_MASK_BNDREGS | \
-				  XFEATURE_MASK_BNDCSR)
+				  XFEATURE_MASK_BNDCSR | \
+				  XFEATURE_MASK_CET_USER | \
+				  XFEATURE_MASK_CET_KERNEL)
 
 #ifdef CONFIG_X86_64
 #define REX_PREFIX	"0x48, "
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6b4fc2788078..e06c1e3fde2f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -848,4 +848,22 @@
 #define MSR_VM_IGNNE                    0xc0010115
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
+/* Control-flow Enforcement Technology MSRs */
+#define MSR_IA32_U_CET		0x6a0 /* user mode cet setting */
+#define MSR_IA32_S_CET		0x6a2 /* kernel mode cet setting */
+#define MSR_IA32_PL0_SSP	0x6a4 /* kernel shstk pointer */
+#define MSR_IA32_PL1_SSP	0x6a5 /* ring-1 shstk pointer */
+#define MSR_IA32_PL2_SSP	0x6a6 /* ring-2 shstk pointer */
+#define MSR_IA32_PL3_SSP	0x6a7 /* user shstk pointer */
+#define MSR_IA32_INT_SSP_TAB	0x6a8 /* exception shstk table */
+
+/* MSR_IA32_U_CET and MSR_IA32_S_CET bits */
+#define MSR_IA32_CET_SHSTK_EN		0x0000000000000001ULL
+#define MSR_IA32_CET_WRSS_EN		0x0000000000000002ULL
+#define MSR_IA32_CET_ENDBR_EN		0x0000000000000004ULL
+#define MSR_IA32_CET_LEG_IW_EN		0x0000000000000008ULL
+#define MSR_IA32_CET_NO_TRACK_EN	0x0000000000000010ULL
+#define MSR_IA32_CET_WAIT_ENDBR	0x00000000000000800UL
+#define MSR_IA32_CET_BITMAP_MASK	0xfffffffffffff000ULL
+
 #endif /* _ASM_X86_MSR_INDEX_H */
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
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9fbe73c546df..63374bb19066 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -38,6 +38,9 @@ static const char *xfeature_names[] =
 	"Processor Trace (unused)"	,
 	"Protection Keys User registers",
 	"unknown xstate feature"	,
+	"Control-flow User registers"	,
+	"Control-flow Kernel registers"	,
+	"unknown xstate feature"	,
 };
 
 static short xsave_cpuid_features[] __initdata = {
@@ -51,6 +54,9 @@ static short xsave_cpuid_features[] __initdata = {
 	X86_FEATURE_AVX512F,
 	X86_FEATURE_INTEL_PT,
 	X86_FEATURE_PKU,
+	-1,		   /* Unused */
+	X86_FEATURE_SHSTK, /* XFEATURE_CET_USER */
+	X86_FEATURE_SHSTK, /* XFEATURE_CET_KERNEL */
 };
 
 /*
@@ -313,6 +319,8 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_ZMM_Hi256);
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
+	print_xstate_feature(XFEATURE_MASK_CET_USER);
+	print_xstate_feature(XFEATURE_MASK_CET_KERNEL);
 }
 
 /*
@@ -559,6 +567,8 @@ static void check_xstate_against_struct(int nr)
 	XCHECK_SZ(sz, nr, XFEATURE_ZMM_Hi256, struct avx_512_zmm_uppers_state);
 	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
+	XCHECK_SZ(sz, nr, XFEATURE_CET_USER,   struct cet_user_state);
+	XCHECK_SZ(sz, nr, XFEATURE_CET_KERNEL, struct cet_kernel_state);
 
 	/*
 	 * Make *SURE* to add any feature numbers in below if
@@ -770,8 +780,19 @@ void __init fpu__init_system_xstate(void)
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
 	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
-		if (!boot_cpu_has(xsave_cpuid_features[i]))
-			xfeatures_mask_all &= ~BIT_ULL(i);
+		if (xsave_cpuid_features[i] == X86_FEATURE_SHSTK) {
+			/*
+			 * X86_FEATURE_SHSTK and X86_FEATURE_IBT share
+			 * same states, but can be enabled separately.
+			 */
+			if (!boot_cpu_has(X86_FEATURE_SHSTK) &&
+			    !boot_cpu_has(X86_FEATURE_IBT))
+				xfeatures_mask_all &= ~BIT_ULL(i);
+		} else {
+			if ((xsave_cpuid_features[i] == -1) ||
+			    !boot_cpu_has(xsave_cpuid_features[i]))
+				xfeatures_mask_all &= ~BIT_ULL(i);
+		}
 	}
 
 	xfeatures_mask_all &= SUPPORTED_XFEATURES_MASK;
-- 
2.17.1

