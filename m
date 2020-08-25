Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC3250D91
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHYAd3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:33:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:12289 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbgHYA3c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:29:32 -0400
IronPort-SDR: FEkZyV8K1PC/9UomPMp1REL1n1Rop6+m7ZIkEJyXev7lwzSo/ADbke6BbcA+mFdUY2vwrp1gV3
 zM+b4iWObz6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136075257"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="136075257"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:31 -0700
IronPort-SDR: 1Uy34UfhhHWygHbkYgOMSUhSqjnlyRxqEbxhNMtwxVhifSoun64rFy/ioQyUVh6XjkwOVYIsfe
 W1vp3M8sdB8w==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474134934"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:30 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v11 03/25] x86/fpu/xstate: Introduce CET MSR XSAVES supervisor states
Date:   Mon, 24 Aug 2020 17:25:18 -0700
Message-Id: <20200825002540.3351-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200825002540.3351-1-yu-cheng.yu@intel.com>
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Control-flow Enforcement Technology (CET) adds five MSRs.  Introduce them
and their XSAVES supervisor states:

    MSR_IA32_U_CET (user-mode CET settings),
    MSR_IA32_PL3_SSP (user-mode Shadow Stack pointer),
    MSR_IA32_PL0_SSP (kernel-mode Shadow Stack pointer),
    MSR_IA32_PL1_SSP (Privilege Level 1 Shadow Stack pointer),
    MSR_IA32_PL2_SSP (Privilege Level 2 Shadow Stack pointer).

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v11:
- Drop MSR_IA32 prefix for individual bits, and use BIT_ULL().
- Drop MSR_IA32_CET_BITMAP_MASK.

v6:
- Remove __packed from struct cet_user_state, struct cet_kernel_state.

 arch/x86/include/asm/fpu/types.h            | 23 +++++++++++++++--
 arch/x86/include/asm/fpu/xstate.h           |  5 ++--
 arch/x86/include/asm/msr-index.h            | 17 +++++++++++++
 arch/x86/include/uapi/asm/processor-flags.h |  2 ++
 arch/x86/kernel/fpu/xstate.c                | 28 ++++++++++++++++++---
 5 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index c87364ea6446..2a7037a6f960 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -115,8 +115,8 @@ enum xfeature {
 	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
 	XFEATURE_PKRU,
 	XFEATURE_RSRVD_COMP_10,
-	XFEATURE_RSRVD_COMP_11,
-	XFEATURE_RSRVD_COMP_12,
+	XFEATURE_CET_USER,
+	XFEATURE_CET_KERNEL,
 	XFEATURE_RSRVD_COMP_13,
 	XFEATURE_RSRVD_COMP_14,
 	XFEATURE_LBR,
@@ -134,6 +134,8 @@ enum xfeature {
 #define XFEATURE_MASK_Hi16_ZMM		(1 << XFEATURE_Hi16_ZMM)
 #define XFEATURE_MASK_PT		(1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
+#define XFEATURE_MASK_CET_USER		(1 << XFEATURE_CET_USER)
+#define XFEATURE_MASK_CET_KERNEL	(1 << XFEATURE_CET_KERNEL)
 #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
 
 #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
@@ -236,6 +238,23 @@ struct pkru_state {
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
 /*
  * State component 15: Architectural LBR configuration state.
  * The size of Arch LBR state depends on the number of LBRs (lbr_depth).
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 14ab815132d4..e4408db88bca 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -35,7 +35,7 @@
 				      XFEATURE_MASK_BNDCSR)
 
 /* All currently supported supervisor features */
-#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (0)
+#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_CET_USER)
 
 /*
  * A supervisor state component may not always contain valuable information,
@@ -62,7 +62,8 @@
  * Unsupported supervisor features. When a supervisor feature in this mask is
  * supported in the future, move it to the supported supervisor feature mask.
  */
-#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT)
+#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT | \
+					      XFEATURE_MASK_CET_KERNEL)
 
 /* All supervisor states including supported and unsupported states. */
 #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2859ee4f39a8..25bd727f6fa1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -912,4 +912,21 @@
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
+#define CET_SHSTK_EN		BIT_ULL(0)
+#define CET_WRSS_EN		BIT_ULL(1)
+#define CET_ENDBR_EN		BIT_ULL(2)
+#define CET_LEG_IW_EN		BIT_ULL(3)
+#define CET_NO_TRACK_EN		BIT_ULL(4)
+#define CET_WAIT_ENDBR		BIT_ULL(11)
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
index 038e19c0019e..705fd9b94e31 100644
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
@@ -318,6 +324,8 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_ZMM_Hi256);
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
+	print_xstate_feature(XFEATURE_MASK_CET_USER);
+	print_xstate_feature(XFEATURE_MASK_CET_KERNEL);
 }
 
 /*
@@ -592,6 +600,8 @@ static void check_xstate_against_struct(int nr)
 	XCHECK_SZ(sz, nr, XFEATURE_ZMM_Hi256, struct avx_512_zmm_uppers_state);
 	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
+	XCHECK_SZ(sz, nr, XFEATURE_CET_USER,   struct cet_user_state);
+	XCHECK_SZ(sz, nr, XFEATURE_CET_KERNEL, struct cet_kernel_state);
 
 	/*
 	 * Make *SURE* to add any feature numbers in below if
@@ -601,7 +611,8 @@ static void check_xstate_against_struct(int nr)
 	if ((nr < XFEATURE_YMM) ||
 	    (nr >= XFEATURE_MAX) ||
 	    (nr == XFEATURE_PT_UNIMPLEMENTED_SO_FAR) ||
-	    ((nr >= XFEATURE_RSRVD_COMP_10) && (nr <= XFEATURE_LBR))) {
+	    (nr == XFEATURE_RSRVD_COMP_10) ||
+	    ((nr >= XFEATURE_RSRVD_COMP_13) && (nr <= XFEATURE_LBR))) {
 		WARN_ONCE(1, "no structure for xstate: %d\n", nr);
 		XSTATE_WARN_ON(1);
 	}
@@ -831,8 +842,19 @@ void __init fpu__init_system_xstate(void)
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
 
 	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
-- 
2.21.0

