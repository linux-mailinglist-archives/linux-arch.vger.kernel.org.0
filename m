Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3043D2E23
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 22:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhGVUMl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 16:12:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:22178 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhGVUMY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 16:12:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="272854672"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="272854672"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:52:58 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="502035415"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:52:57 -0700
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
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v28 03/32] x86/cpufeatures: Add CET CPU feature flags for Control-flow Enforcement Technology (CET)
Date:   Thu, 22 Jul 2021 13:51:50 -0700
Message-Id: <20210722205219.7934-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210722205219.7934-1-yu-cheng.yu@intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
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
v25:
- Make X86_FEATURE_IBT depend on X86_FEATURE_SHSTK.

v24:
- Update for splitting CONFIG_X86_CET to CONFIG_X86_SHADOW_STACK and CONFIG_X86_IBT.
- Move DISABLE_IBT definition to the IBT series.

 arch/x86/include/asm/cpufeatures.h       | 2 ++
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/kernel/cpu/cpuid-deps.c         | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d0ce5cfd3ac1..daa47bcd2050 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -350,6 +350,7 @@
 #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
 #define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
+#define X86_FEATURE_SHSTK		(16*32+ 7) /* Shadow Stack */
 #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
 #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
 #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
@@ -385,6 +386,7 @@
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 8f28fafa98b3..b7728f7afb2b 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -65,6 +65,12 @@
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
@@ -85,7 +91,7 @@
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
+			 DISABLE_ENQCMD|DISABLE_SHSTK)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK19	0
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index defda61f372d..e21d97cc20e4 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -75,6 +75,8 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
+	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_IBT,			X86_FEATURE_SHSTK    },
 	{}
 };
 
-- 
2.21.0

