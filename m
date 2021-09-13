Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308F9409DB3
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 22:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbhIMUFx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 16:05:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:38689 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347789AbhIMUFr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Sep 2021 16:05:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307336365"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="307336365"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643912"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2021 13:04:30 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 04/13] x86/fpu/xstate: Enumerate User Interrupts supervisor state
Date:   Mon, 13 Sep 2021 13:01:23 -0700
Message-Id: <20210913200132.3396598-5-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Enable xstate supervisor support for User Interrupts by default.

The user interrupt state for a task consists of the MSR state and the
User Interrupt Flag (UIF) value. XSAVES and XRSTORS handle saving and
restoring both of these states.

<The supervisor XSTATE code might be reworked based on issues reported
in the past. The Uintr context switching code would also need rework and
additional testing in that regard.>

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/fpu/types.h  | 20 +++++++++++++++++++-
 arch/x86/include/asm/fpu/xstate.h |  3 ++-
 arch/x86/kernel/cpu/common.c      |  6 ++++++
 arch/x86/kernel/fpu/xstate.c      | 20 +++++++++++++++++---
 4 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index f5a38a5f3ae1..b614f1416bea 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -118,7 +118,7 @@ enum xfeature {
 	XFEATURE_RSRVD_COMP_11,
 	XFEATURE_RSRVD_COMP_12,
 	XFEATURE_RSRVD_COMP_13,
-	XFEATURE_RSRVD_COMP_14,
+	XFEATURE_UINTR,
 	XFEATURE_LBR,
 
 	XFEATURE_MAX,
@@ -135,6 +135,7 @@ enum xfeature {
 #define XFEATURE_MASK_PT		(1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
 #define XFEATURE_MASK_PASID		(1 << XFEATURE_PASID)
+#define XFEATURE_MASK_UINTR		(1 << XFEATURE_UINTR)
 #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
 
 #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
@@ -237,6 +238,23 @@ struct pkru_state {
 	u32				pad;
 } __packed;
 
+/*
+ * State component 14 is supervisor state used for User Interrupts state.
+ * The size of this state is 48 bytes
+ */
+struct uintr_state {
+	u64 handler;
+	u64 stack_adjust;
+	u32 uitt_size;
+	u8  uinv;
+	u8  pad1;
+	u8  pad2;
+	u8  uif_pad3;		/* bit 7 - UIF, bits 6:0 - reserved */
+	u64 upid_addr;
+	u64 uirr;
+	u64 uitt_addr;
+} __packed;
+
 /*
  * State component 15: Architectural LBR configuration state.
  * The size of Arch LBR state depends on the number of LBRs (lbr_depth).
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 109dfcc75299..4dd4e83c0c9d 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -44,7 +44,8 @@
 	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
 
 /* All currently supported supervisor features */
-#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
+#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID | \
+					    XFEATURE_MASK_UINTR)
 
 /*
  * A supervisor state component may not always contain valuable information,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 55fee930b6d1..3a0a3f5cfe0f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -334,6 +334,12 @@ static __always_inline void setup_uintr(struct cpuinfo_x86 *c)
 	if (!cpu_has(c, X86_FEATURE_UINTR))
 		goto disable_uintr;
 
+	/* Confirm XSAVE support for UINTR is present. */
+	if (!cpu_has_xfeatures(XFEATURE_MASK_UINTR, NULL)) {
+		pr_info_once("x86: User Interrupts (UINTR) not enabled. XSAVE support for UINTR is missing.\n");
+		goto clear_uintr_cap;
+	}
+
 	/*
 	 * User Interrupts currently doesn't support PTI. For processors that
 	 * support User interrupts PTI in auto mode will default to off.  Need
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8def1b7f8fb..ab19403effb0 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -38,6 +38,10 @@ static const char *xfeature_names[] =
 	"Processor Trace (unused)"	,
 	"Protection Keys User registers",
 	"PASID state",
+	"unknown xstate feature 11",
+	"unknown xstate feature 12",
+	"unknown xstate feature 13",
+	"User Interrupts registers",
 	"unknown xstate feature"	,
 };
 
@@ -53,6 +57,10 @@ static short xsave_cpuid_features[] __initdata = {
 	X86_FEATURE_INTEL_PT,
 	X86_FEATURE_PKU,
 	X86_FEATURE_ENQCMD,
+	-1,			/* Unknown 11 */
+	-1,			/* Unknown 12 */
+	-1,			/* Unknown 13 */
+	X86_FEATURE_UINTR,
 };
 
 /*
@@ -236,6 +244,7 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
 	print_xstate_feature(XFEATURE_MASK_PASID);
+	print_xstate_feature(XFEATURE_MASK_UINTR);
 }
 
 /*
@@ -372,7 +381,8 @@ static void __init print_xstate_offset_size(void)
 	 XFEATURE_MASK_PKRU |			\
 	 XFEATURE_MASK_BNDREGS |		\
 	 XFEATURE_MASK_BNDCSR |			\
-	 XFEATURE_MASK_PASID)
+	 XFEATURE_MASK_PASID |			\
+	 XFEATURE_MASK_UINTR)
 
 /*
  * setup the xstate image representing the init state
@@ -532,6 +542,7 @@ static void check_xstate_against_struct(int nr)
 	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
 	XCHECK_SZ(sz, nr, XFEATURE_PASID,     struct ia32_pasid_state);
+	XCHECK_SZ(sz, nr, XFEATURE_UINTR,     struct uintr_state);
 
 	/*
 	 * Make *SURE* to add any feature numbers in below if
@@ -539,9 +550,12 @@ static void check_xstate_against_struct(int nr)
 	 * numbers.
 	 */
 	if ((nr < XFEATURE_YMM) ||
-	    (nr >= XFEATURE_MAX) ||
 	    (nr == XFEATURE_PT_UNIMPLEMENTED_SO_FAR) ||
-	    ((nr >= XFEATURE_RSRVD_COMP_11) && (nr <= XFEATURE_LBR))) {
+	    (nr == XFEATURE_RSRVD_COMP_11) ||
+	    (nr == XFEATURE_RSRVD_COMP_12) ||
+	    (nr == XFEATURE_RSRVD_COMP_13) ||
+	    (nr == XFEATURE_LBR) ||
+	    (nr >= XFEATURE_MAX)) {
 		WARN_ONCE(1, "no structure for xstate: %d\n", nr);
 		XSTATE_WARN_ON(1);
 	}
-- 
2.33.0

