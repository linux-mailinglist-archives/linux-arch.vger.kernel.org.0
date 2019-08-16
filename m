Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF94A9090E
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2019 21:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfHPT4k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Aug 2019 15:56:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43061 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfHPT4k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Aug 2019 15:56:40 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyiKn-000829-0q; Fri, 16 Aug 2019 21:56:25 +0200
Date:   Fri, 16 Aug 2019 21:56:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [PATCH v8 04/27] x86/fpu/xstate: Introduce XSAVES system
 states
In-Reply-To: <20190813205225.12032-5-yu-cheng.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1908161703010.1923@nanos.tec.linutronix.de>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com> <20190813205225.12032-5-yu-cheng.yu@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 13 Aug 2019, Yu-cheng Yu wrote:
> +/*
> + * On context switches, XSAVE states are not restored until returning
> + * to user-mode.  FPU registers need to be restored before any changes,
> + * and protected by fpregs_lock()/fpregs_unlock().

I really had to read this comment twice to figure out what it means.

> + */
> +static inline void modify_fpu_regs_begin(void)

Please use a proper name space. fpu_regs_....

> +{
> +	fpregs_lock();
> +	if (test_thread_flag(TIF_NEED_FPU_LOAD))
> +		__fpregs_load_activate();
> +}
> +
> +static inline void modify_fpu_regs_end(void)
> +{
> +	fpregs_unlock();
> +}

Also why are those inlines in this particular patch? I see no relation at all.

>  /*
>   * MXCSR and XCR definitions:
>   */
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 9ded9532257d..970bbd303cfb 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -21,9 +21,6 @@
>  #define XSAVE_YMM_SIZE	    256
>  #define XSAVE_YMM_OFFSET    (XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET)
>  
> -/* Supervisor features */
> -#define XFEATURE_MASK_SUPERVISOR (XFEATURE_MASK_PT)
> -
>  /* All currently supported features */
>  #define SUPPORTED_XFEATURES_MASK (XFEATURE_MASK_FP | \
>  				  XFEATURE_MASK_SSE | \
> @@ -42,6 +39,7 @@
>  #endif
>  
>  extern u64 xfeatures_mask_user;
> +extern u64 xfeatures_mask_all;
>  extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
>  
>  extern void __init update_regset_xstate_info(unsigned int size,
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 12c70840980e..31d3cd70b5df 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -294,12 +294,16 @@ void fpu__drop(struct fpu *fpu)
>   * Clear FPU registers by setting them up from
>   * the init fpstate:
>   */
> -static inline void copy_init_fpstate_to_fpregs(void)
> +static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
>  {
>  	fpregs_lock();
>  
> +	/*
> +	 * Only XSAVES user states are copied.
> +	 * System states are preserved.

Fits nicely in one line and aside of that this comment is blatantly
wrong. See that caller:

> +		copy_init_fpstate_to_fpregs(xfeatures_mask_all);

xfeatures_mask_all includes xfeatures_mask_system unless I'm missing
something.

> +	 */
>  	if (use_xsave())
> -		copy_kernel_to_xregs(&init_fpstate.xsave, -1);
> +		copy_kernel_to_xregs(&init_fpstate.xsave, features_mask);
>  	else if (static_cpu_has(X86_FEATURE_FXSR))
>  		copy_kernel_to_fxregs(&init_fpstate.fxsave);

The change of this function should also be split out into a separate
patch. This one is way too big to be reviewable.

>  	else
> @@ -318,7 +322,21 @@ static inline void copy_init_fpstate_to_fpregs(void)
>   * Called by sys_execve(), by the signal handler code and by various
>   * error paths.
>   */
> -void fpu__clear(struct fpu *fpu)
> +void fpu__clear_user_states(struct fpu *fpu)
> +{
> +	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */

1) Please do not use tail comments. They break the reading flow.

2) Please do not comment the obvious. Put comments where they make sense. I
   know you copied it, but that does not make it any better.

> +	fpu__drop(fpu);
> +
> +	/*
> +	 * Make sure fpstate is cleared and initialized.
> +	 */
> +	fpu__initialize(fpu);
> +	if (static_cpu_has(X86_FEATURE_FPU))
> +		copy_init_fpstate_to_fpregs(xfeatures_mask_user);
> +}
> +
> +void fpu__clear_all(struct fpu *fpu)
>  {
>  	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
> @@ -329,7 +347,7 @@ void fpu__clear(struct fpu *fpu)
>  	 */
>  	fpu__initialize(fpu);
>  	if (static_cpu_has(X86_FEATURE_FPU))
> -		copy_init_fpstate_to_fpregs();
> +		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
>  }
>  
>  /*
> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> index 73fed33e5bda..0a0ba584a533 100644
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -217,16 +217,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
>  	fpu_user_xstate_size = fpu_kernel_xstate_size;
>  }
>  
> -/*
> - * Find supported xfeatures based on cpu features and command-line input.
> - * This must be called after fpu__init_parse_early_param() is called and
> - * xfeatures_mask is enumerated.
> - */
> -u64 __init fpu__get_supported_xfeatures_mask(void)
> -{
> -	return SUPPORTED_XFEATURES_MASK;
> -}
> -
>  /* Legacy code to initialize eager fpu mode. */
>  static void __init fpu__init_system_ctx_switch(void)
>  {
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 8a63f07cf400..4ecf1764a971 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -285,7 +285,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  			 IS_ENABLED(CONFIG_IA32_EMULATION));
>  
>  	if (!buf) {
> -		fpu__clear(fpu);
> +		fpu__clear_user_states(fpu);
>  		return 0;
>  	}
>  
> @@ -407,7 +407,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  
>  err_out:
>  	if (ret)
> -		fpu__clear(fpu);
> +		fpu__clear_user_states(fpu);
>  	return ret;
>  }
>  
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index d560e8861a3c..9fbe73c546df 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -61,9 +61,19 @@ static short xsave_cpuid_features[] __initdata = {
>   */
>  u64 xfeatures_mask_user __read_mostly;
>  
> +/*
> + * Supported XSAVES system states.
> + */
> +static u64 xfeatures_mask_system __read_mostly;
> +
> +/*
> + * Combined XSAVES system and user states.
> + */
> +u64 xfeatures_mask_all __read_mostly;
> +
>  static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
>  static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
> -static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask_user)*8];
> +static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask_all)*8];

  [sizeof(...) * 8]

>  
>  /*
>   * The XSAVE area of kernel can be in standard or compacted format;
> @@ -79,7 +89,7 @@ unsigned int fpu_user_xstate_size;
>   */
>  int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
>  {
> -	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask_user;
> +	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask_all;
>  
>  	if (unlikely(feature_name)) {
>  		long xfeature_idx, max_idx;
> @@ -158,7 +168,7 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
>  	 * None of the feature bits are in init state. So nothing else
>  	 * to do for us, as the memory layout is up to date.
>  	 */
> -	if ((xfeatures & xfeatures_mask_user) == xfeatures_mask_user)
> +	if ((xfeatures & xfeatures_mask_all) == xfeatures_mask_all)
>  		return;
>  
>  	/*
> @@ -213,28 +223,27 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
>   */
>  void fpu__init_cpu_xstate(void)
>  {
> -	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_user)
> +	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_all)
>  		return;
>  	/*
>  	 * XCR_XFEATURE_ENABLED_MASK sets the features that are managed
>  	 * by XSAVE{C, OPT} and XRSTOR.  Only XSAVE user states can be
>  	 * set here.
>  	 */
> -
> -	xfeatures_mask_user &= ~XFEATURE_MASK_SUPERVISOR;
> -
>  	cr4_set_bits(X86_CR4_OSXSAVE);
>  	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user);
> +
> +	/*
> +	 * MSR_IA32_XSS controls which system (not user) states are

We know that system state is not including user state. Please stop
documenting the obvious.

> +	 * to be managed by XSAVES.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_XSAVES))
> +		wrmsrl(MSR_IA32_XSS, xfeatures_mask_system);
>  }
>  
> -/*
> - * Note that in the future we will likely need a pair of
> - * functions here: one for user xstates and the other for
> - * system xstates.  For now, they are the same.
> - */
>  static int xfeature_enabled(enum xfeature xfeature)
>  {
> -	return !!(xfeatures_mask_user & BIT_ULL(xfeature));
> +	return !!(xfeatures_mask_all & BIT_ULL(xfeature));
>  }
>  
>  /*
> @@ -340,7 +349,7 @@ static int xfeature_is_aligned(int xfeature_nr)
>   */
>  static void __init setup_xstate_comp(void)
>  {
> -	unsigned int xstate_comp_sizes[sizeof(xfeatures_mask_user)*8];
> +	unsigned int xstate_comp_sizes[sizeof(xfeatures_mask_all)*8];

See above

>  	int i;
>  
>  	/*
> @@ -413,7 +422,7 @@ static void __init setup_init_fpu_buf(void)
>  	print_xstate_features();
>  
>  	if (boot_cpu_has(X86_FEATURE_XSAVES))
> -		init_fpstate.xsave.header.xcomp_bv = BIT_ULL(63) | xfeatures_mask_user;
> +		init_fpstate.xsave.header.xcomp_bv = BIT_ULL(63) | xfeatures_mask_all;
>  
>  	/*
>  	 * Init all the features state with header.xfeatures being 0x0
> @@ -436,7 +445,7 @@ static int xfeature_uncompacted_offset(int xfeature_nr)
>  	 * format. Checking a system state's uncompacted offset is
>  	 * an error.
>  	 */
> -	if (XFEATURE_MASK_SUPERVISOR & BIT_ULL(xfeature_nr)) {
> +	if (~xfeatures_mask_user & BIT_ULL(xfeature_nr)) {

Sigh. Why can't this use xfeatures_mask_system? That would be too obvious.

>  		WARN_ONCE(1, "No fixed offset for xstate %d\n", xfeature_nr);
>  		return -1;
>  	}
> @@ -608,15 +617,12 @@ static void do_extra_xstate_size_checks(void)
>  
>  
>  /*
> - * Get total size of enabled xstates in XCR0/xfeatures_mask_user.
> + * Get total size of enabled xstates in XCR0 | IA32_XSS.
>   *
>   * Note the SDM's wording here.  "sub-function 0" only enumerates
>   * the size of the *user* states.  If we use it to size a buffer
>   * that we use 'XSAVES' on, we could potentially overflow the
>   * buffer because 'XSAVES' saves system states too.
> - *
> - * Note that we do not currently set any bits on IA32_XSS so
> - * 'XCR0 | IA32_XSS == XCR0' for now.
>   */
>  static unsigned int __init get_xsaves_size(void)
>  {
> @@ -698,6 +704,7 @@ static int __init init_xstate_size(void)
>   */
>  static void fpu__init_disable_system_xstate(void)
>  {
> +	xfeatures_mask_all = 0;
>  	xfeatures_mask_user = 0;
>  	cr4_clear_bits(X86_CR4_OSXSAVE);
>  	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
> @@ -733,10 +740,23 @@ void __init fpu__init_system_xstate(void)
>  		return;
>  	}
>  
> +	/*
> +	 * Find user states supported by the processor.
> +	 * Only these bits can be set in XCR0.
> +	 */
>  	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
>  	xfeatures_mask_user = eax + ((u64)edx << 32);
>  
> -	if ((xfeatures_mask_user & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
> +	/*
> +	 * Find system states supported by the processor.
> +	 * Only these bits can be set in IA32_XSS MSR.
> +	 */
> +	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
> +	xfeatures_mask_system = ecx + ((u64)edx << 32);
> +
> +	xfeatures_mask_all = xfeatures_mask_user | xfeatures_mask_system;
> +
> +	if ((xfeatures_mask_all & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {

xfeatures_mask_all is wrong here. FPSSE is clearly user state.

>  		/*
>  		 * This indicates that something really unexpected happened
>  		 * with the enumeration.  Disable XSAVE and try to continue
> @@ -751,10 +771,12 @@ void __init fpu__init_system_xstate(void)
>  	 */
>  	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
>  		if (!boot_cpu_has(xsave_cpuid_features[i]))
> -			xfeatures_mask_user &= ~BIT_ULL(i);
> +			xfeatures_mask_all &= ~BIT_ULL(i);
>  	}
>  
> -	xfeatures_mask_user &= fpu__get_supported_xfeatures_mask();
> +	xfeatures_mask_all &= SUPPORTED_XFEATURES_MASK;
> +	xfeatures_mask_user &= xfeatures_mask_all;
> +	xfeatures_mask_system &= xfeatures_mask_all;
>  
>  	/* Enable xstate instructions to be able to continue with initialization: */
>  	fpu__init_cpu_xstate();
> @@ -766,7 +788,7 @@ void __init fpu__init_system_xstate(void)
>  	 * Update info used for ptrace frames; use standard-format size and no
>  	 * system xstates:
>  	 */
> -	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user & ~XFEATURE_MASK_SUPERVISOR);
> +	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user);
>

And exactly this hunk shows that the whole refactoring approach is wrong
from the very beginning. I stared at that in the previous patch already and
had the feeling that it's bogus.

Just doing a s/xfeatures_mask/xfeatures_mask_user/g really does not make
any sense. Simply because the current code assumes that xfeatures_mask ==
xfeatures_mask_all. So if a global rename is the right approach then
s/xfeatures_mask/xfeatures_mask_all/ and not that completely backwards
rename to _user.

That refactoring wants to be done in the following steps:

   1) Introduce xfeatures_mask_user and initialize it with

       xfeatures_mask_user = xfeatures_mask ^ ~XFEATURE_MASK_SUPERVISOR;

   2) Fix up the usage sites in reviewable chunks. It does not matter
      whether that could be folded into a larger all in one patch. What
      matters is that it makes sense and is reviewable.

   3) Change the signature of copy_init_fpstate_to_fpregs() so it takes a
      mask and fix up the call sites accordingly. Without the bogus comment
      of course.

   4) Introduce xfeatures_mask_system and eventually needed helper functions.

   5) Change the affected usage sites

Details may be slightly different but you get the idea.

Thanks,

	tglx
