Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D2C8C31F
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfHMVCn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:02:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:16057 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfHMVCi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:02:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:02:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="187901335"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2019 14:02:36 -0700
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
Subject: [PATCH v8 04/27] x86/fpu/xstate: Introduce XSAVES system states
Date:   Tue, 13 Aug 2019 13:52:02 -0700
Message-Id: <20190813205225.12032-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205225.12032-1-yu-cheng.yu@intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Control-flow Enforcement (CET) MSR contents are XSAVES system states.
To support CET, introduce XSAVES system states first.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/fpu/internal.h | 23 +++++++-
 arch/x86/include/asm/fpu/xstate.h   |  4 +-
 arch/x86/kernel/fpu/core.c          | 26 +++++++--
 arch/x86/kernel/fpu/init.c          | 10 ----
 arch/x86/kernel/fpu/signal.c        |  4 +-
 arch/x86/kernel/fpu/xstate.c        | 90 +++++++++++++++++++----------
 arch/x86/kernel/process.c           |  2 +-
 arch/x86/kernel/signal.c            |  2 +-
 8 files changed, 106 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 652be3853b40..2ca5c36a77d5 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -31,7 +31,8 @@ extern void fpu__save(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
 extern int  fpu__copy(struct task_struct *dst, struct task_struct *src);
-extern void fpu__clear(struct fpu *fpu);
+extern void fpu__clear_user_states(struct fpu *fpu);
+extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 extern int  dump_fpu(struct pt_regs *ptregs, struct user_i387_struct *fpstate);
 
@@ -44,7 +45,6 @@ extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system(struct cpuinfo_x86 *c);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
-extern u64 fpu__get_supported_xfeatures_mask(void);
 
 /*
  * Debugging facility:
@@ -92,7 +92,7 @@ static inline void fpstate_init_xstate(struct xregs_state *xsave)
 	 * XRSTORS requires these bits set in xcomp_bv, or it will
 	 * trigger #GP:
 	 */
-	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_user;
+	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
 }
 
 static inline void fpstate_init_fxstate(struct fxregs_state *fx)
@@ -615,6 +615,23 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 	__write_pkru(pkru_val);
 }
 
+/*
+ * On context switches, XSAVE states are not restored until returning
+ * to user-mode.  FPU registers need to be restored before any changes,
+ * and protected by fpregs_lock()/fpregs_unlock().
+ */
+static inline void modify_fpu_regs_begin(void)
+{
+	fpregs_lock();
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		__fpregs_load_activate();
+}
+
+static inline void modify_fpu_regs_end(void)
+{
+	fpregs_unlock();
+}
+
 /*
  * MXCSR and XCR definitions:
  */
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 9ded9532257d..970bbd303cfb 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -21,9 +21,6 @@
 #define XSAVE_YMM_SIZE	    256
 #define XSAVE_YMM_OFFSET    (XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET)
 
-/* Supervisor features */
-#define XFEATURE_MASK_SUPERVISOR (XFEATURE_MASK_PT)
-
 /* All currently supported features */
 #define SUPPORTED_XFEATURES_MASK (XFEATURE_MASK_FP | \
 				  XFEATURE_MASK_SSE | \
@@ -42,6 +39,7 @@
 #endif
 
 extern u64 xfeatures_mask_user;
+extern u64 xfeatures_mask_all;
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 
 extern void __init update_regset_xstate_info(unsigned int size,
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 12c70840980e..31d3cd70b5df 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -294,12 +294,16 @@ void fpu__drop(struct fpu *fpu)
  * Clear FPU registers by setting them up from
  * the init fpstate:
  */
-static inline void copy_init_fpstate_to_fpregs(void)
+static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
 {
 	fpregs_lock();
 
+	/*
+	 * Only XSAVES user states are copied.
+	 * System states are preserved.
+	 */
 	if (use_xsave())
-		copy_kernel_to_xregs(&init_fpstate.xsave, -1);
+		copy_kernel_to_xregs(&init_fpstate.xsave, features_mask);
 	else if (static_cpu_has(X86_FEATURE_FXSR))
 		copy_kernel_to_fxregs(&init_fpstate.fxsave);
 	else
@@ -318,7 +322,21 @@ static inline void copy_init_fpstate_to_fpregs(void)
  * Called by sys_execve(), by the signal handler code and by various
  * error paths.
  */
-void fpu__clear(struct fpu *fpu)
+void fpu__clear_user_states(struct fpu *fpu)
+{
+	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
+
+	fpu__drop(fpu);
+
+	/*
+	 * Make sure fpstate is cleared and initialized.
+	 */
+	fpu__initialize(fpu);
+	if (static_cpu_has(X86_FEATURE_FPU))
+		copy_init_fpstate_to_fpregs(xfeatures_mask_user);
+}
+
+void fpu__clear_all(struct fpu *fpu)
 {
 	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
 
@@ -329,7 +347,7 @@ void fpu__clear(struct fpu *fpu)
 	 */
 	fpu__initialize(fpu);
 	if (static_cpu_has(X86_FEATURE_FPU))
-		copy_init_fpstate_to_fpregs();
+		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 73fed33e5bda..0a0ba584a533 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -217,16 +217,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_user_xstate_size = fpu_kernel_xstate_size;
 }
 
-/*
- * Find supported xfeatures based on cpu features and command-line input.
- * This must be called after fpu__init_parse_early_param() is called and
- * xfeatures_mask is enumerated.
- */
-u64 __init fpu__get_supported_xfeatures_mask(void)
-{
-	return SUPPORTED_XFEATURES_MASK;
-}
-
 /* Legacy code to initialize eager fpu mode. */
 static void __init fpu__init_system_ctx_switch(void)
 {
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 8a63f07cf400..4ecf1764a971 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -285,7 +285,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
 
 	if (!buf) {
-		fpu__clear(fpu);
+		fpu__clear_user_states(fpu);
 		return 0;
 	}
 
@@ -407,7 +407,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 err_out:
 	if (ret)
-		fpu__clear(fpu);
+		fpu__clear_user_states(fpu);
 	return ret;
 }
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d560e8861a3c..9fbe73c546df 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -61,9 +61,19 @@ static short xsave_cpuid_features[] __initdata = {
  */
 u64 xfeatures_mask_user __read_mostly;
 
+/*
+ * Supported XSAVES system states.
+ */
+static u64 xfeatures_mask_system __read_mostly;
+
+/*
+ * Combined XSAVES system and user states.
+ */
+u64 xfeatures_mask_all __read_mostly;
+
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask_user)*8];
+static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask_all)*8];
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
@@ -79,7 +89,7 @@ unsigned int fpu_user_xstate_size;
  */
 int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
 {
-	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask_user;
+	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask_all;
 
 	if (unlikely(feature_name)) {
 		long xfeature_idx, max_idx;
@@ -158,7 +168,7 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	 * None of the feature bits are in init state. So nothing else
 	 * to do for us, as the memory layout is up to date.
 	 */
-	if ((xfeatures & xfeatures_mask_user) == xfeatures_mask_user)
+	if ((xfeatures & xfeatures_mask_all) == xfeatures_mask_all)
 		return;
 
 	/*
@@ -213,28 +223,27 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
  */
 void fpu__init_cpu_xstate(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_user)
+	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_all)
 		return;
 	/*
 	 * XCR_XFEATURE_ENABLED_MASK sets the features that are managed
 	 * by XSAVE{C, OPT} and XRSTOR.  Only XSAVE user states can be
 	 * set here.
 	 */
-
-	xfeatures_mask_user &= ~XFEATURE_MASK_SUPERVISOR;
-
 	cr4_set_bits(X86_CR4_OSXSAVE);
 	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user);
+
+	/*
+	 * MSR_IA32_XSS controls which system (not user) states are
+	 * to be managed by XSAVES.
+	 */
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
+		wrmsrl(MSR_IA32_XSS, xfeatures_mask_system);
 }
 
-/*
- * Note that in the future we will likely need a pair of
- * functions here: one for user xstates and the other for
- * system xstates.  For now, they are the same.
- */
 static int xfeature_enabled(enum xfeature xfeature)
 {
-	return !!(xfeatures_mask_user & BIT_ULL(xfeature));
+	return !!(xfeatures_mask_all & BIT_ULL(xfeature));
 }
 
 /*
@@ -340,7 +349,7 @@ static int xfeature_is_aligned(int xfeature_nr)
  */
 static void __init setup_xstate_comp(void)
 {
-	unsigned int xstate_comp_sizes[sizeof(xfeatures_mask_user)*8];
+	unsigned int xstate_comp_sizes[sizeof(xfeatures_mask_all)*8];
 	int i;
 
 	/*
@@ -413,7 +422,7 @@ static void __init setup_init_fpu_buf(void)
 	print_xstate_features();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		init_fpstate.xsave.header.xcomp_bv = BIT_ULL(63) | xfeatures_mask_user;
+		init_fpstate.xsave.header.xcomp_bv = BIT_ULL(63) | xfeatures_mask_all;
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
@@ -436,7 +445,7 @@ static int xfeature_uncompacted_offset(int xfeature_nr)
 	 * format. Checking a system state's uncompacted offset is
 	 * an error.
 	 */
-	if (XFEATURE_MASK_SUPERVISOR & BIT_ULL(xfeature_nr)) {
+	if (~xfeatures_mask_user & BIT_ULL(xfeature_nr)) {
 		WARN_ONCE(1, "No fixed offset for xstate %d\n", xfeature_nr);
 		return -1;
 	}
@@ -608,15 +617,12 @@ static void do_extra_xstate_size_checks(void)
 
 
 /*
- * Get total size of enabled xstates in XCR0/xfeatures_mask_user.
+ * Get total size of enabled xstates in XCR0 | IA32_XSS.
  *
  * Note the SDM's wording here.  "sub-function 0" only enumerates
  * the size of the *user* states.  If we use it to size a buffer
  * that we use 'XSAVES' on, we could potentially overflow the
  * buffer because 'XSAVES' saves system states too.
- *
- * Note that we do not currently set any bits on IA32_XSS so
- * 'XCR0 | IA32_XSS == XCR0' for now.
  */
 static unsigned int __init get_xsaves_size(void)
 {
@@ -698,6 +704,7 @@ static int __init init_xstate_size(void)
  */
 static void fpu__init_disable_system_xstate(void)
 {
+	xfeatures_mask_all = 0;
 	xfeatures_mask_user = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
@@ -733,10 +740,23 @@ void __init fpu__init_system_xstate(void)
 		return;
 	}
 
+	/*
+	 * Find user states supported by the processor.
+	 * Only these bits can be set in XCR0.
+	 */
 	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
 	xfeatures_mask_user = eax + ((u64)edx << 32);
 
-	if ((xfeatures_mask_user & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
+	/*
+	 * Find system states supported by the processor.
+	 * Only these bits can be set in IA32_XSS MSR.
+	 */
+	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
+	xfeatures_mask_system = ecx + ((u64)edx << 32);
+
+	xfeatures_mask_all = xfeatures_mask_user | xfeatures_mask_system;
+
+	if ((xfeatures_mask_all & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
 		 * This indicates that something really unexpected happened
 		 * with the enumeration.  Disable XSAVE and try to continue
@@ -751,10 +771,12 @@ void __init fpu__init_system_xstate(void)
 	 */
 	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
 		if (!boot_cpu_has(xsave_cpuid_features[i]))
-			xfeatures_mask_user &= ~BIT_ULL(i);
+			xfeatures_mask_all &= ~BIT_ULL(i);
 	}
 
-	xfeatures_mask_user &= fpu__get_supported_xfeatures_mask();
+	xfeatures_mask_all &= SUPPORTED_XFEATURES_MASK;
+	xfeatures_mask_user &= xfeatures_mask_all;
+	xfeatures_mask_system &= xfeatures_mask_all;
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
@@ -766,7 +788,7 @@ void __init fpu__init_system_xstate(void)
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * system xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user & ~XFEATURE_MASK_SUPERVISOR);
+	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user);
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
@@ -774,7 +796,7 @@ void __init fpu__init_system_xstate(void)
 	print_xstate_offset_size();
 
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
-		xfeatures_mask_user,
+		xfeatures_mask_all,
 		fpu_kernel_xstate_size,
 		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
 	return;
@@ -794,6 +816,12 @@ void fpu__resume_cpu(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE))
 		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user);
+
+	/*
+	 * Restore IA32_XSS
+	 */
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
+		wrmsrl(MSR_IA32_XSS, xfeatures_mask_system);
 }
 
 /*
@@ -839,9 +867,9 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 	/*
 	 * We should not ever be requesting features that we
 	 * have not enabled.  Remember that pcntxt_mask is
-	 * what we write to the XCR0 register.
+	 * what we write to the XCR0 | IA32_XSS registers.
 	 */
-	WARN_ONCE(!(xfeatures_mask_user & BIT_ULL(xfeature_nr)),
+	WARN_ONCE(!(xfeatures_mask_all & BIT_ULL(xfeature_nr)),
 		  "get of unsupported state");
 	/*
 	 * This assumes the last 'xsave*' instruction to
@@ -989,7 +1017,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= ~XFEATURE_MASK_SUPERVISOR;
+	header.xfeatures &= xfeatures_mask_user;
 
 	/*
 	 * Copy xregs_state->header:
@@ -1073,7 +1101,7 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= ~XFEATURE_MASK_SUPERVISOR;
+	header.xfeatures &= xfeatures_mask_user;
 
 	/*
 	 * Copy xregs_state->header:
@@ -1166,7 +1194,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':
 	 */
-	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
+	xsave->header.xfeatures &= xfeatures_mask_system;
 
 	/*
 	 * Add back in the features that came in from userspace:
@@ -1222,7 +1250,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':
 	 */
-	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
+	xsave->header.xfeatures &= xfeatures_mask_system;
 
 	/*
 	 * Add back in the features that came in from userspace:
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 75fea0d48c0e..d360bf4d696b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -139,7 +139,7 @@ void flush_thread(void)
 	flush_ptrace_hw_breakpoint(tsk);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
-	fpu__clear(&tsk->thread.fpu);
+	fpu__clear_all(&tsk->thread.fpu);
 }
 
 void disable_TSC(void)
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8eb7193e158d..ce9421ec285f 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -763,7 +763,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		/*
 		 * Ensure the signal handler starts with the new fpu state.
 		 */
-		fpu__clear(fpu);
+		fpu__clear_user_states(fpu);
 	}
 	signal_setup_done(failed, ksig, stepping);
 }
-- 
2.17.1

