Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874E88C32A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfHMVCi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:02:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:16057 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfHMVCg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:02:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="187901330"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2019 14:02:34 -0700
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
Subject: [PATCH v8 03/27] x86/fpu/xstate: Change names to separate XSAVES system and user states
Date:   Tue, 13 Aug 2019 13:52:01 -0700
Message-Id: <20190813205225.12032-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205225.12032-1-yu-cheng.yu@intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Control-flow Enforcement (CET) MSR contents are XSAVES system states.
To support CET, introduce XSAVES system states first.

XSAVES is a "supervisor" instruction and, comparing to XSAVE, saves
additional "supervisor" states that can be modified only from CPL 0.
However, these states are per-task and not kernel's own.  Rename
"supervisor" states to "system" states to clearly separate them from
"user" states.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/fpu/internal.h |  4 +-
 arch/x86/include/asm/fpu/xstate.h   | 20 +++----
 arch/x86/kernel/fpu/init.c          |  2 +-
 arch/x86/kernel/fpu/signal.c        | 10 ++--
 arch/x86/kernel/fpu/xstate.c        | 86 ++++++++++++++---------------
 5 files changed, 60 insertions(+), 62 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4c95c365058a..652be3853b40 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -92,7 +92,7 @@ static inline void fpstate_init_xstate(struct xregs_state *xsave)
 	 * XRSTORS requires these bits set in xcomp_bv, or it will
 	 * trigger #GP:
 	 */
-	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask;
+	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_user;
 }
 
 static inline void fpstate_init_fxstate(struct fxregs_state *fx)
@@ -225,7 +225,7 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 
 /*
  * If XSAVES is enabled, it replaces XSAVEOPT because it supports a compact
- * format and supervisor states in addition to modified optimization in
+ * format and system states in addition to modified optimization in
  * XSAVEOPT.
  *
  * Otherwise, if XSAVEOPT is enabled, XSAVEOPT replaces XSAVE because XSAVEOPT
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index c6136d79f8c0..9ded9532257d 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -25,15 +25,15 @@
 #define XFEATURE_MASK_SUPERVISOR (XFEATURE_MASK_PT)
 
 /* All currently supported features */
-#define XCNTXT_MASK		(XFEATURE_MASK_FP | \
-				 XFEATURE_MASK_SSE | \
-				 XFEATURE_MASK_YMM | \
-				 XFEATURE_MASK_OPMASK | \
-				 XFEATURE_MASK_ZMM_Hi256 | \
-				 XFEATURE_MASK_Hi16_ZMM	 | \
-				 XFEATURE_MASK_PKRU | \
-				 XFEATURE_MASK_BNDREGS | \
-				 XFEATURE_MASK_BNDCSR)
+#define SUPPORTED_XFEATURES_MASK (XFEATURE_MASK_FP | \
+				  XFEATURE_MASK_SSE | \
+				  XFEATURE_MASK_YMM | \
+				  XFEATURE_MASK_OPMASK | \
+				  XFEATURE_MASK_ZMM_Hi256 | \
+				  XFEATURE_MASK_Hi16_ZMM | \
+				  XFEATURE_MASK_PKRU | \
+				  XFEATURE_MASK_BNDREGS | \
+				  XFEATURE_MASK_BNDCSR)
 
 #ifdef CONFIG_X86_64
 #define REX_PREFIX	"0x48, "
@@ -41,7 +41,7 @@
 #define REX_PREFIX
 #endif
 
-extern u64 xfeatures_mask;
+extern u64 xfeatures_mask_user;
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 
 extern void __init update_regset_xstate_info(unsigned int size,
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 6ce7e0a23268..73fed33e5bda 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -224,7 +224,7 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 u64 __init fpu__get_supported_xfeatures_mask(void)
 {
-	return XCNTXT_MASK;
+	return SUPPORTED_XFEATURES_MASK;
 }
 
 /* Legacy code to initialize eager fpu mode. */
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 0071b794ed19..8a63f07cf400 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -254,11 +254,11 @@ static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 {
 	if (use_xsave()) {
 		if (fx_only) {
-			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
+			u64 init_bv = xfeatures_mask_user & ~XFEATURE_MASK_FPSSE;
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 			return copy_user_to_fxregs(buf);
 		} else {
-			u64 init_bv = xfeatures_mask & ~xbv;
+			u64 init_bv = xfeatures_mask_user & ~xbv;
 			if (unlikely(init_bv))
 				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 			return copy_user_to_xregs(buf, xbv);
@@ -357,7 +357,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 
 	if (use_xsave() && !fx_only) {
-		u64 init_bv = xfeatures_mask & ~xfeatures;
+		u64 init_bv = xfeatures_mask_user & ~xfeatures;
 
 		if (using_compacted_format()) {
 			ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
@@ -388,7 +388,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 		fpregs_lock();
 		if (use_xsave()) {
-			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
+			u64 init_bv = xfeatures_mask_user & ~XFEATURE_MASK_FPSSE;
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 		}
 
@@ -462,7 +462,7 @@ void fpu__init_prepare_fx_sw_frame(void)
 
 	fx_sw_reserved.magic1 = FP_XSTATE_MAGIC1;
 	fx_sw_reserved.extended_size = size;
-	fx_sw_reserved.xfeatures = xfeatures_mask;
+	fx_sw_reserved.xfeatures = xfeatures_mask_user;
 	fx_sw_reserved.xstate_size = fpu_user_xstate_size;
 
 	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e5cb67d67c03..d560e8861a3c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -54,13 +54,16 @@ static short xsave_cpuid_features[] __initdata = {
 };
 
 /*
- * Mask of xstate features supported by the CPU and the kernel:
+ * XSAVES system states can only be modified from CPL 0 and saved by
+ * XSAVES.  The rest are user states.  The following is a mask of
+ * supported user state features derived from boot_cpu_has() and
+ * SUPPORTED_XFEATURES_MASK.
  */
-u64 xfeatures_mask __read_mostly;
+u64 xfeatures_mask_user __read_mostly;
 
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask)*8];
+static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask_user)*8];
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
@@ -76,7 +79,7 @@ unsigned int fpu_user_xstate_size;
  */
 int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
 {
-	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask;
+	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask_user;
 
 	if (unlikely(feature_name)) {
 		long xfeature_idx, max_idx;
@@ -107,15 +110,12 @@ int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
 }
 EXPORT_SYMBOL_GPL(cpu_has_xfeatures);
 
-static int xfeature_is_supervisor(int xfeature_nr)
+static int xfeature_is_system(int xfeature_nr)
 {
 	/*
-	 * We currently do not support supervisor states, but if
-	 * we did, we could find out like this.
-	 *
 	 * SDM says: If state component 'i' is a user state component,
-	 * ECX[0] return 0; if state component i is a supervisor
-	 * state component, ECX[0] returns 1.
+	 * ECX[0] is 0; if state component i is a system state component,
+	 * ECX[0] is 1.
 	 */
 	u32 eax, ebx, ecx, edx;
 
@@ -125,7 +125,7 @@ static int xfeature_is_supervisor(int xfeature_nr)
 
 static int xfeature_is_user(int xfeature_nr)
 {
-	return !xfeature_is_supervisor(xfeature_nr);
+	return !xfeature_is_system(xfeature_nr);
 }
 
 /*
@@ -158,7 +158,7 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	 * None of the feature bits are in init state. So nothing else
 	 * to do for us, as the memory layout is up to date.
 	 */
-	if ((xfeatures & xfeatures_mask) == xfeatures_mask)
+	if ((xfeatures & xfeatures_mask_user) == xfeatures_mask_user)
 		return;
 
 	/*
@@ -185,7 +185,7 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	 * in a special way already:
 	 */
 	feature_bit = 0x2;
-	xfeatures = (xfeatures_mask & ~xfeatures) >> 2;
+	xfeatures = (xfeatures_mask_user & ~xfeatures) >> 2;
 
 	/*
 	 * Update all the remaining memory layouts according to their
@@ -213,20 +213,18 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
  */
 void fpu__init_cpu_xstate(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask)
+	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_user)
 		return;
 	/*
-	 * Make it clear that XSAVES supervisor states are not yet
-	 * implemented should anyone expect it to work by changing
-	 * bits in XFEATURE_MASK_* macros and XCR0.
+	 * XCR_XFEATURE_ENABLED_MASK sets the features that are managed
+	 * by XSAVE{C, OPT} and XRSTOR.  Only XSAVE user states can be
+	 * set here.
 	 */
-	WARN_ONCE((xfeatures_mask & XFEATURE_MASK_SUPERVISOR),
-		"x86/fpu: XSAVES supervisor states are not yet implemented.\n");
 
-	xfeatures_mask &= ~XFEATURE_MASK_SUPERVISOR;
+	xfeatures_mask_user &= ~XFEATURE_MASK_SUPERVISOR;
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
-	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user);
 }
 
 /*
@@ -236,7 +234,7 @@ void fpu__init_cpu_xstate(void)
  */
 static int xfeature_enabled(enum xfeature xfeature)
 {
-	return !!(xfeatures_mask & (1UL << xfeature));
+	return !!(xfeatures_mask_user & BIT_ULL(xfeature));
 }
 
 /*
@@ -266,7 +264,7 @@ static void __init setup_xstate_features(void)
 		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
 
 		/*
-		 * If an xfeature is supervisor state, the offset
+		 * If an xfeature is a system state, the offset
 		 * in EBX is invalid. We leave it to -1.
 		 */
 		if (xfeature_is_user(i))
@@ -342,7 +340,7 @@ static int xfeature_is_aligned(int xfeature_nr)
  */
 static void __init setup_xstate_comp(void)
 {
-	unsigned int xstate_comp_sizes[sizeof(xfeatures_mask)*8];
+	unsigned int xstate_comp_sizes[sizeof(xfeatures_mask_user)*8];
 	int i;
 
 	/*
@@ -415,7 +413,7 @@ static void __init setup_init_fpu_buf(void)
 	print_xstate_features();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		init_fpstate.xsave.header.xcomp_bv = (u64)1 << 63 | xfeatures_mask;
+		init_fpstate.xsave.header.xcomp_bv = BIT_ULL(63) | xfeatures_mask_user;
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
@@ -434,8 +432,8 @@ static int xfeature_uncompacted_offset(int xfeature_nr)
 	u32 eax, ebx, ecx, edx;
 
 	/*
-	 * Only XSAVES supports supervisor states and it uses compacted
-	 * format. Checking a supervisor state's uncompacted offset is
+	 * Only XSAVES supports system states and it uses compacted
+	 * format. Checking a system state's uncompacted offset is
 	 * an error.
 	 */
 	if (XFEATURE_MASK_SUPERVISOR & BIT_ULL(xfeature_nr)) {
@@ -459,7 +457,7 @@ static int xfeature_size(int xfeature_nr)
 
 /*
  * 'XSAVES' implies two different things:
- * 1. saving of supervisor/system state
+ * 1. saving of system state
  * 2. using the compacted format
  *
  * Use this function when dealing with the compacted format so
@@ -474,8 +472,8 @@ int using_compacted_format(void)
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
 int validate_xstate_header(const struct xstate_header *hdr)
 {
-	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & (~xfeatures_mask | XFEATURE_MASK_SUPERVISOR))
+	/* No unknown or system features may be set */
+	if (hdr->xfeatures & ~xfeatures_mask_user)
 		return -EINVAL;
 
 	/* Userspace must use the uncompacted format */
@@ -582,11 +580,11 @@ static void do_extra_xstate_size_checks(void)
 
 		check_xstate_against_struct(i);
 		/*
-		 * Supervisor state components can be managed only by
+		 * System state components can be managed only by
 		 * XSAVES, which is compacted-format only.
 		 */
 		if (!using_compacted_format())
-			XSTATE_WARN_ON(xfeature_is_supervisor(i));
+			XSTATE_WARN_ON(xfeature_is_system(i));
 
 		/* Align from the end of the previous feature */
 		if (xfeature_is_aligned(i))
@@ -610,7 +608,7 @@ static void do_extra_xstate_size_checks(void)
 
 
 /*
- * Get total size of enabled xstates in XCR0/xfeatures_mask.
+ * Get total size of enabled xstates in XCR0/xfeatures_mask_user.
  *
  * Note the SDM's wording here.  "sub-function 0" only enumerates
  * the size of the *user* states.  If we use it to size a buffer
@@ -700,7 +698,7 @@ static int __init init_xstate_size(void)
  */
 static void fpu__init_disable_system_xstate(void)
 {
-	xfeatures_mask = 0;
+	xfeatures_mask_user = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 }
@@ -736,15 +734,15 @@ void __init fpu__init_system_xstate(void)
 	}
 
 	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
-	xfeatures_mask = eax + ((u64)edx << 32);
+	xfeatures_mask_user = eax + ((u64)edx << 32);
 
-	if ((xfeatures_mask & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
+	if ((xfeatures_mask_user & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
 		 * This indicates that something really unexpected happened
 		 * with the enumeration.  Disable XSAVE and try to continue
 		 * booting without it.  This is too early to BUG().
 		 */
-		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%llx.\n", xfeatures_mask);
+		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%llx.\n", xfeatures_mask_user);
 		goto out_disable;
 	}
 
@@ -753,10 +751,10 @@ void __init fpu__init_system_xstate(void)
 	 */
 	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
 		if (!boot_cpu_has(xsave_cpuid_features[i]))
-			xfeatures_mask &= ~BIT(i);
+			xfeatures_mask_user &= ~BIT_ULL(i);
 	}
 
-	xfeatures_mask &= fpu__get_supported_xfeatures_mask();
+	xfeatures_mask_user &= fpu__get_supported_xfeatures_mask();
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
@@ -766,9 +764,9 @@ void __init fpu__init_system_xstate(void)
 
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
-	 * supervisor xstates:
+	 * system xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size,	xfeatures_mask & ~XFEATURE_MASK_SUPERVISOR);
+	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user & ~XFEATURE_MASK_SUPERVISOR);
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
@@ -776,7 +774,7 @@ void __init fpu__init_system_xstate(void)
 	print_xstate_offset_size();
 
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
-		xfeatures_mask,
+		xfeatures_mask_user,
 		fpu_kernel_xstate_size,
 		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
 	return;
@@ -795,7 +793,7 @@ void fpu__resume_cpu(void)
 	 * Restore XCR0 on xsave capable CPUs:
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user);
 }
 
 /*
@@ -843,7 +841,7 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 	 * have not enabled.  Remember that pcntxt_mask is
 	 * what we write to the XCR0 register.
 	 */
-	WARN_ONCE(!(xfeatures_mask & BIT_ULL(xfeature_nr)),
+	WARN_ONCE(!(xfeatures_mask_user & BIT_ULL(xfeature_nr)),
 		  "get of unsupported state");
 	/*
 	 * This assumes the last 'xsave*' instruction to
-- 
2.17.1

