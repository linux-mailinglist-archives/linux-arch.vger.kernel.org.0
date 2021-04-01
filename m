Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB635220A
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhDAWLY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:11:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:34674 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233803AbhDAWLV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:11:21 -0400
IronPort-SDR: D/sLIm1Ui5ZAMJNrns5PkwTDwqPaFd+AKdf4ob0kPsjMnss9iqniKp3foN/3yrqg2ro3QBRkLr
 6NbMjqV02jYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189084518"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="189084518"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:20 -0700
IronPort-SDR: g1Ir270A5dk0Fj6JspCEYrJWpnUqAoVgIqbTSbyMASPwsemuprg04ttm10Pv0jCDGo9rh7yS0l
 TkQuX/16PxWA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517513848"
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
Subject: [PATCH v24 03/30] x86/cpufeatures: Add CET CPU feature flags for Control-flow Enforcement Technology (CET)
Date:   Thu,  1 Apr 2021 15:10:37 -0700
Message-Id: <20210401221104.31584-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221104.31584-1-yu-cheng.yu@intel.com>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add CPU feature flags for Control-flow Enforcement Technology (CET).

CPUID.(EAX=7,ECX=0):ECX[bit 7] Shadow stack
CPUID.(EAX=7,ECX=0):EDX[bit 20] Indirect Branch Tracking

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v24:
- Update for splitting CONFIG_X86_CET to CONFIG_X86_SHADOW_STACK and CONFIG_X86_IBT.
- Move DISABLE_IBT definition to the IBT series.

 arch/x86/include/asm/cpufeatures.h       | 2 ++
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/kernel/cpu/cpuid-deps.c         | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26d69f7..bf861fc89fef 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -345,6 +345,7 @@
 #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
 #define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
+#define X86_FEATURE_SHSTK		(16*32+ 7) /* Shadow Stack */
 #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
 #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
 #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
@@ -377,6 +378,7 @@
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index b7dd944dc867..e5c6ed9373e8 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -68,6 +68,12 @@
 # define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
 #endif
 
+#ifdef CONFIG_X86_SHADOW_STACK
+#define DISABLE_SHSTK	0
+#else
+#define DISABLE_SHSTK	(1 << (X86_FEATURE_SHSTK & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -88,7 +94,7 @@
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
+			 DISABLE_ENQCMD|DISABLE_SHSTK)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK19	0
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 42af31b64c2c..52d9a682a0e6 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -72,6 +72,8 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
+	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_IBT,			X86_FEATURE_XSAVES    },
 	{}
 };
 
-- 
2.21.0

