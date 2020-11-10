Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA222ADBE3
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 17:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgKJQWy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 11:22:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:25988 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729832AbgKJQWw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 11:22:52 -0500
IronPort-SDR: 9naFayjCKgph3vD4EDW/gjm2IhQm3NWZCW37+OvnxDfZe/arpK1zGsb/nBN8z6Y19TiCtk1Ke9
 62+iDDE9Ma9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="157008696"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="157008696"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:22:49 -0800
IronPort-SDR: RM6xXfN8oX3Dr4XV78qkjqOmoSj2pAboBFck1WoyyHk5TCpHDAdBoEP5uTKUNj1t5caH+27bwl
 pksp/Ww6S/oQ==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="365572804"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:22:48 -0800
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
Subject: [PATCH v15 02/26] x86/cpufeatures: Add CET CPU feature flags for Control-flow Enforcement Technology (CET)
Date:   Tue, 10 Nov 2020 08:21:47 -0800
Message-Id: <20201110162211.9207-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201110162211.9207-1-yu-cheng.yu@intel.com>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add CPU feature flags for Control-flow Enforcement Technology (CET).

CPUID.(EAX=7,ECX=0):ECX[bit 7] Shadow stack
CPUID.(EAX=7,ECX=0):EDX[bit 20] Indirect Branch Tracking

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 arch/x86/kernel/cpu/cpuid-deps.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dad350d42ecf..c9f6d62da463 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -343,6 +343,7 @@
 #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
 #define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
+#define X86_FEATURE_SHSTK		(16*32+ 7) /* Shadow Stack */
 #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
 #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
 #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
@@ -374,6 +375,7 @@
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index d502241995a3..9a3971e2f98f 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -71,6 +71,8 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
+	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_IBT,			X86_FEATURE_XSAVES    },
 	{}
 };
 
-- 
2.21.0

