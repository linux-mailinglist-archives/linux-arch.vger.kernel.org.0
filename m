Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9787016F0F9
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 22:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBYVRT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 16:17:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46937 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgBYVRS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 16:17:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id y30so148980pga.13
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 13:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cdSXT05Ed94fp+qs7+Bi9oylfzUjcK7w0NUVnrJvd2Y=;
        b=nSDyIMtVk8PHXdyFqWleK0+i718W3rwYIvftc95cYzsMGSUXEd8PX+NrsTvm9eZNI/
         vGb2paSVXXlYR3NjN2ip/nqibfDDKs61M7MHJnvVlr+pBEJ+dfes2lWqGH4C34oNu4rC
         Qy5PpFZhIn/RgnUFZkvtfV0J3UokBYYPYcSKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cdSXT05Ed94fp+qs7+Bi9oylfzUjcK7w0NUVnrJvd2Y=;
        b=iLtohp6ZZywKhtfaEOyvgm+83ZJxVDho93ZiMREtJFkUgz6PEOX63aPEtyr7x8xTF/
         Qy6/ZnVPy206MYPbxuHI2KU+OsGAhgNVRDDrZfjQJY8GFPVLSLtPeSSU7CX04gBWS3tZ
         Whru/RrZxqGtBlEa3DsRp35qIST8ig86lhVSnUcRqeEKZDngjDk8Mz8NF/QIfXumUESs
         Y+k5Fu8f8Et9qtq3w578KGfG4UUXjp+LRn8QnXhEdUTOoV8Wj593h1mpG9IHa4h/4w3j
         qji+GvMxv/BmqfYShVyJegOZkKc4UhXb4Qpgsb9MAHuGCG5Zgsxe8ahV/7kwaZt8G87t
         kCkQ==
X-Gm-Message-State: APjAAAWWxDbhh1Z/xK4EVGhKpgnVf6f5n5bkXrO7/oXr9XwPxjX//c2/
        D9IXevj5isGI2DZw/ArbdBxFJQ==
X-Google-Smtp-Source: APXvYqzDLSbTlJF3Ybvyk/Yyo9y76yn7b7JQf6LkTDhetTsdhlrPYqZ4vJBSezda2L+nr7SbZ65h/w==
X-Received: by 2002:a62:cf07:: with SMTP id b7mr632868pfg.77.1582665436739;
        Tue, 25 Feb 2020 13:17:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y190sm2391pfb.82.2020.02.25.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 13:17:15 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:17:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Subject: Re: [RFC PATCH v9 19/27] x86/cet/shstk: Handle signals for Shadow
 Stack
Message-ID: <202002251312.BB2EB60D@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-20-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-20-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:27AM -0800, Yu-cheng Yu wrote:
> To deliver a signal, create a Shadow Stack (SHSTK) restore token and put
> the token and the signal restorer address on the SHSTK.  For sigreturn,
> verify the token and restore the SHSTK pointer.
> 
> Introduce a signal context extension struct 'sc_ext', which is used to save
> SHSTK restore token address and WAIT_ENDBR status.  WAIT_ENDBR will be
> introduced later in the Indirect Branch Tracking (IBT) series, but add that
> into sc_ext now to keep the struct stable in case the IBT series is applied
> later.
> 
> v9:
> - Update CET MSR access according to XSAVES supervisor state changes.
> - Add 'wait_endbr' to struct 'sc_ext'.
> - Update and simplify signal frame allocation, setup, and restoration.
> - Update commit log text.
> 
> v2:
> - Move CET status from sigcontext to a separate struct sc_ext, which is
>   located above the fpstate on the signal frame.
> - Add a restore token for sigreturn address.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/ia32/ia32_signal.c            |  17 +++
>  arch/x86/include/asm/cet.h             |   7 ++
>  arch/x86/include/asm/fpu/internal.h    |   2 +
>  arch/x86/include/uapi/asm/sigcontext.h |   9 ++
>  arch/x86/kernel/cet.c                  | 153 +++++++++++++++++++++++++
>  arch/x86/kernel/fpu/signal.c           |  89 ++++++++++++++
>  arch/x86/kernel/signal.c               |  10 ++
>  7 files changed, 287 insertions(+)
> 
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 30416d7f19d4..c0bb350a3d2d 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -35,6 +35,7 @@
>  #include <asm/sigframe.h>
>  #include <asm/sighandling.h>
>  #include <asm/smap.h>
> +#include <asm/cet.h>
>  
>  /*
>   * Do a signal return; undo the signal stack.
> @@ -223,6 +224,7 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
>  				 void __user **fpstate)
>  {
>  	unsigned long sp, fx_aligned, math_size;
> +	void __user *restorer = NULL;
>  
>  	/* Default to using normal stack */
>  	sp = regs->sp;
> @@ -236,8 +238,23 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
>  		 ksig->ka.sa.sa_restorer)
>  		sp = (unsigned long) ksig->ka.sa.sa_restorer;
>  
> +	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
> +		restorer = ksig->ka.sa.sa_restorer;
> +	} else if (current->mm->context.vdso) {
> +		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
> +			restorer = current->mm->context.vdso +
> +				vdso_image_32.sym___kernel_rt_sigreturn;
> +		else
> +			restorer = current->mm->context.vdso +
> +				vdso_image_32.sym___kernel_sigreturn;
> +	}
> +
>  	sp = fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
>  	*fpstate = (struct _fpstate_32 __user *) sp;
> +
> +	if (save_cet_to_sigframe(*fpstate, (unsigned long)restorer, 1))
> +		return (void __user *) -1L;
> +
>  	if (copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
>  				     math_size) < 0)
>  		return (void __user *) -1L;
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> index c44c991ca91f..409d4f91a0dc 100644
> --- a/arch/x86/include/asm/cet.h
> +++ b/arch/x86/include/asm/cet.h
> @@ -6,6 +6,8 @@
>  #include <linux/types.h>
>  
>  struct task_struct;
> +struct sc_ext;
> +
>  /*
>   * Per-thread CET status
>   */
> @@ -18,8 +20,13 @@ struct cet_status {
>  #ifdef CONFIG_X86_INTEL_CET
>  int cet_setup_shstk(void);
>  void cet_disable_free_shstk(struct task_struct *p);
> +int cet_restore_signal(bool ia32, struct sc_ext *sc);
> +int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
>  #else
>  static inline void cet_disable_free_shstk(struct task_struct *p) {}
> +static inline int cet_restore_signal(bool ia32, struct sc_ext *sc) { return -EINVAL; }
> +static inline int cet_setup_signal(bool ia32, unsigned long rstor,
> +				   struct sc_ext *sc) { return -EINVAL; }
>  #endif
>  
>  #define cpu_x86_cet_enabled() \
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 42159f45bf9c..241521c0ed02 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -476,6 +476,8 @@ static inline void copy_kernel_to_fpregs(union fpregs_state *fpstate)
>  	__copy_kernel_to_fpregs(fpstate, -1);
>  }
>  
> +extern int save_cet_to_sigframe(void __user *fp, unsigned long restorer,
> +				int is_ia32);
>  extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
>  
>  /*
> diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/uapi/asm/sigcontext.h
> index 844d60eb1882..cf2d55db3be4 100644
> --- a/arch/x86/include/uapi/asm/sigcontext.h
> +++ b/arch/x86/include/uapi/asm/sigcontext.h
> @@ -196,6 +196,15 @@ struct _xstate {
>  	/* New processor state extensions go here: */
>  };
>  
> +/*
> + * Located at the end of sigcontext->fpstate, aligned to 8.
> + */
> +struct sc_ext {
> +	unsigned long total_size;
> +	unsigned long ssp;
> +	unsigned long wait_endbr;
> +};
> +
>  /*
>   * The 32-bit signal frame:
>   */
> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> index b4c7d88e9a8f..cba5c7656aab 100644
> --- a/arch/x86/kernel/cet.c
> +++ b/arch/x86/kernel/cet.c
> @@ -19,6 +19,8 @@
>  #include <asm/fpu/xstate.h>
>  #include <asm/fpu/types.h>
>  #include <asm/cet.h>
> +#include <asm/special_insns.h>
> +#include <uapi/asm/sigcontext.h>
>  
>  static void start_update_msrs(void)
>  {
> @@ -69,6 +71,80 @@ static unsigned long alloc_shstk(unsigned long size)
>  	return addr;
>  }
>  
> +#define TOKEN_MODE_MASK	3UL
> +#define TOKEN_MODE_64	1UL
> +#define IS_TOKEN_64(token) ((token & TOKEN_MODE_MASK) == TOKEN_MODE_64)
> +#define IS_TOKEN_32(token) ((token & TOKEN_MODE_MASK) == 0)
> +
> +/*
> + * Verify the restore token at the address of 'ssp' is
> + * valid and then set shadow stack pointer according to the
> + * token.
> + */
> +static int verify_rstor_token(bool ia32, unsigned long ssp,
> +			      unsigned long *new_ssp)
> +{
> +	unsigned long token;
> +
> +	*new_ssp = 0;
> +
> +	if (!IS_ALIGNED(ssp, 8))
> +		return -EINVAL;
> +
> +	if (get_user(token, (unsigned long __user *)ssp))
> +		return -EFAULT;
> +
> +	/* Is 64-bit mode flag correct? */
> +	if (!ia32 && !IS_TOKEN_64(token))
> +		return -EINVAL;
> +	else if (ia32 && !IS_TOKEN_32(token))
> +		return -EINVAL;
> +
> +	token &= ~TOKEN_MODE_MASK;
> +
> +	/*
> +	 * Restore address properly aligned?
> +	 */
> +	if ((!ia32 && !IS_ALIGNED(token, 8)) || !IS_ALIGNED(token, 4))
> +		return -EINVAL;
> +
> +	/*
> +	 * Token was placed properly?
> +	 */
> +	if ((ALIGN_DOWN(token, 8) - 8) != ssp)
> +		return -EINVAL;
> +
> +	*new_ssp = token;
> +	return 0;
> +}
> +
> +/*
> + * Create a restore token on the shadow stack.
> + * A token is always 8-byte and aligned to 8.
> + */
> +static int create_rstor_token(bool ia32, unsigned long ssp,
> +			      unsigned long *new_ssp)
> +{
> +	unsigned long addr;
> +
> +	*new_ssp = 0;
> +
> +	if ((!ia32 && !IS_ALIGNED(ssp, 8)) || !IS_ALIGNED(ssp, 4))
> +		return -EINVAL;
> +
> +	addr = ALIGN_DOWN(ssp, 8) - 8;
> +
> +	/* Is the token for 64-bit? */
> +	if (!ia32)
> +		ssp |= TOKEN_MODE_64;
> +
> +	if (write_user_shstk_64(addr, ssp))
> +		return -EFAULT;
> +
> +	*new_ssp = addr;
> +	return 0;
> +}
> +
>  int cet_setup_shstk(void)
>  {
>  	unsigned long addr, size;
> @@ -119,3 +195,80 @@ void cet_disable_free_shstk(struct task_struct *tsk)
>  	cet->shstk_size = 0;
>  	cet->shstk_enabled = 0;
>  }
> +
> +/*
> + * Called from __fpu__restore_sig() and XSAVES buffer is protected by
> + * set_thread_flag(TIF_NEED_FPU_LOAD).
> + */
> +int cet_restore_signal(bool ia32, struct sc_ext *sc_ext)
> +{
> +	struct cet_user_state *cet_user_state;
> +	struct cet_status *cet = &current->thread.cet;
> +	unsigned long new_ssp = 0;
> +	u64 msr_val = 0;
> +	int err;
> +
> +	if (!cet->shstk_enabled)
> +		return 0;
> +
> +	cet_user_state = get_xsave_addr(&current->thread.fpu.state.xsave,
> +					XFEATURE_CET_USER);
> +	if (!cet_user_state)
> +		return -1;
> +
> +	if (cet->shstk_enabled) {
> +		err = verify_rstor_token(ia32, sc_ext->ssp, &new_ssp);
> +		if (err)
> +			return err;
> +
> +		cet_user_state->user_ssp = new_ssp;
> +		msr_val |= MSR_IA32_CET_SHSTK_EN;
> +	}
> +
> +	cet_user_state->user_cet = msr_val;
> +	return 0;
> +}
> +
> +/*
> + * Setup the shadow stack for the signal handler: first,
> + * create a restore token to keep track of the current ssp,
> + * and then the return address of the signal handler.
> + */
> +int cet_setup_signal(bool ia32, unsigned long rstor_addr, struct sc_ext *sc_ext)
> +{
> +	struct cet_status *cet = &current->thread.cet;
> +	unsigned long ssp = 0, new_ssp = 0;
> +	int err;
> +
> +	if (!cet->shstk_enabled)
> +		return 0;
> +
> +	if (cet->shstk_enabled) {

This if isn't needed any more.

> +		if (!rstor_addr)
> +			return -EINVAL;
> +
> +		ssp = cet_get_shstk_addr();
> +		err = create_rstor_token(ia32, ssp, &new_ssp);
> +		if (err)
> +			return err;
> +
> +		if (ia32) {
> +			ssp = new_ssp - sizeof(u32);
> +			err = write_user_shstk_32(ssp, (unsigned int)rstor_addr);
> +		} else {
> +			ssp = new_ssp - sizeof(u64);
> +			err = write_user_shstk_64(ssp, rstor_addr);
> +		}
> +
> +		if (err)
> +			return err;
> +
> +		sc_ext->ssp = new_ssp;
> +	}
> +
> +	start_update_msrs();
> +	if (cet->shstk_enabled)
> +		wrmsrl(MSR_IA32_PL3_SSP, ssp);
> +	end_update_msrs();
> +
> +	return 0;
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 0d3e06a772b0..875cc0fadce3 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -52,6 +52,69 @@ static inline int check_for_xstate(struct fxregs_state __user *buf,
>  	return 0;
>  }
>  
> +int save_cet_to_sigframe(void __user *fp, unsigned long restorer, int is_ia32)
> +{
> +	int err = 0;
> +
> +#ifdef CONFIG_X86_INTEL_CET
> +	if (!current->thread.cet.shstk_enabled)
> +		return 0;

The general guidelines for #ifdef in code is to instead use
IS_ENABLED() instead, which helps with readability. e.g.:

	if (!IS_ENABLED(CONFIG_X86_INTEL_CET))
		return 0;

But since you're using parts of the structure that's only visible with
that CONFIG, maybe just shorten the ifdef?

#ifndef CONFIG_X86_INTEL_CET
	return 0;
#else
	...whole function...
#endif

I've also seen people prefer to have the entire function declaration
wrapped:

#ifndef CONFIG_X86_INTEL_CET
int save_cet_to_sigframe(void __user *fp, unsigned long restorer, int is_ia32)
{
	return 0;
}
#else
int save_cet_to_sigframe(void __user *fp, unsigned long restorer, int is_ia32)
{
...
}
#endif

> +	int err = 0;
> +
> +#ifdef CONFIG_X86_INTEL_CET
> +	if (!current->thread.cet.shstk_enabled)
> +
> +	if (fp) {
> +		struct sc_ext ext = {0, 0, 0};
> +
> +		err = cet_setup_signal(is_ia32, restorer, &ext);
> +		if (!err) {
> +			void __user *p = fp;
> +
> +			ext.total_size = sizeof(ext);
> +
> +			if (is_ia32)
> +				p += sizeof(struct fregs_state);
> +
> +			p += fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
> +			p = (void __user *)ALIGN((unsigned long)p, 8);
> +
> +			if (copy_to_user(p, &ext, sizeof(ext)))
> +				return -EFAULT;
> +		}
> +	}
> +#endif
> +
> +	return err;
> +}
> +
> +static int restore_cet_from_sigframe(int is_ia32, void __user *fp)
> +{
> +	int err = 0;
> +
> +#ifdef CONFIG_X86_INTEL_CET
> +	if (!current->thread.cet.shstk_enabled)
> +		return 0;
> +
> +	if (fp) {
> +		struct sc_ext ext = {0, 0, 0};
> +		void __user *p = fp;
> +
> +		if (is_ia32)
> +			p += sizeof(struct fregs_state);
> +
> +		p += fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
> +		p = (void __user *)ALIGN((unsigned long)p, 8);
> +
> +		if (copy_from_user(&ext, p, sizeof(ext)))
> +			return -EFAULT;
> +
> +		if (ext.total_size != sizeof(ext))
> +			return -EFAULT;
> +
> +		err = cet_restore_signal(is_ia32, &ext);
> +	}
> +#endif
> +
> +	return err;
> +}
> +
>  /*
>   * Signal frame handlers.
>   */
> @@ -367,6 +430,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		pagefault_disable();
>  		ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures_user, fx_only);
>  		pagefault_enable();
> +
> +		if (!ret)
> +			ret = restore_cet_from_sigframe(0, buf);
> +
>  		if (!ret) {
>  			if (xfeatures_mask_supervisor())
>  				copy_kernel_to_xregs(&fpu->state.xsave,
> @@ -397,6 +464,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		sanitize_restored_user_xstate(&fpu->state, envp, xfeatures_user,
>  					      fx_only);
>  
> +		ret = restore_cet_from_sigframe((int)ia32_fxstate, buf);
> +		if (ret)
> +			goto err_out;
> +
>  		fpregs_lock();
>  		if (unlikely(init_bv))
>  			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
> @@ -468,12 +539,30 @@ int fpu__restore_sig(void __user *buf, int ia32_frame)
>  	return __fpu__restore_sig(buf, buf_fx, size);
>  }
>  
> +static unsigned long fpu__alloc_sigcontext_ext(unsigned long sp)
> +{
> +	/*
> +	 * sigcontext_ext is at: fpu + fpu_user_xstate_size +
> +	 * FP_XSTATE_MAGIC2_SIZE, then aligned to 8.
> +	 */
> +	if (cpu_x86_cet_enabled()) {
> +		struct cet_status *cet = &current->thread.cet;
> +
> +		if (cet->shstk_enabled)
> +			sp -= (sizeof(struct sc_ext) + 8);
> +	}
> +
> +	return sp;
> +}
> +
>  unsigned long
>  fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
>  		     unsigned long *buf_fx, unsigned long *size)
>  {
>  	unsigned long frame_size = xstate_sigframe_size();
>  
> +	sp = fpu__alloc_sigcontext_ext(sp);
> +
>  	*buf_fx = sp = round_down(sp - frame_size, 64);
>  	if (ia32_frame && use_fxsr()) {
>  		frame_size += sizeof(struct fregs_state);
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index ce9421ec285f..b26f5084a8a1 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -46,6 +46,7 @@
>  
>  #include <asm/sigframe.h>
>  #include <asm/signal.h>
> +#include <asm/cet.h>
>  
>  #define COPY(x)			do {			\
>  	get_user_ex(regs->x, &sc->x);			\
> @@ -246,6 +247,9 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>  	unsigned long buf_fx = 0;
>  	int onsigstack = on_sig_stack(sp);
>  	int ret;
> +#ifdef CONFIG_X86_64
> +	void __user *restorer = NULL;
> +#endif
>  
>  	/* redzone */
>  	if (IS_ENABLED(CONFIG_X86_64))
> @@ -277,6 +281,12 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>  	if (onsigstack && !likely(on_sig_stack(sp)))
>  		return (void __user *)-1L;
>  
> +#ifdef CONFIG_X86_64
> +	if (ka->sa.sa_flags & SA_RESTORER)
> +		restorer = ka->sa.sa_restorer;
> +	ret = save_cet_to_sigframe(*fpstate, (unsigned long)restorer, 0);
> +#endif
> +
>  	/* save i387 and extended state */
>  	ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);
>  	if (ret < 0)
> -- 
> 2.21.0
> 

-- 
Kees Cook
