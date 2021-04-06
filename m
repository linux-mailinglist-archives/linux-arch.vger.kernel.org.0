Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199F4355F14
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 00:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbhDFWvJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 18:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344590AbhDFWuu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Apr 2021 18:50:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9033461400
        for <linux-arch@vger.kernel.org>; Tue,  6 Apr 2021 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617749441;
        bh=Zw/Q+ulrSTIaOwOBp5p9M3R0gaFZvE0ddxGgQbn3pZo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VKnl4PhPlOLO56xrF03lB63MqWMOlDooQkwDA9bhnvwDSpfbYBXwVOdv01Y+F7ZFF
         0oYm5LvqvYKpEtiybiMFDxNRvPt/tCNkSi7c+EGQySMMJBkCHH+xY7yF94xSoSwKaS
         WeoRgw2vYxr8e80vv1OkefhTlD9dqn74GrPjYXAtUMeDD5ZhdZ6TytDJYfUqK8VRIn
         Fp18EVLSQfVEnPTGEB+C9Aq3JLn/wLpeoQqXKTaBEojQBsvm5U832j1fnTcK0/nciQ
         2mBpL8BlgCqeL0mWsaklIPMWDnJm3+Y6h+mFUP2fHEjsrUOlPxKwydUcibfxwKzRxO
         k+0LSwyCvj1PQ==
Received: by mail-ed1-f46.google.com with SMTP id dd20so11254048edb.12
        for <linux-arch@vger.kernel.org>; Tue, 06 Apr 2021 15:50:41 -0700 (PDT)
X-Gm-Message-State: AOAM5314C2vGyAq5np5Kev/0Lt8upG/ZYQRRSj1f4b3OqDalw20pJA4T
        nkURbsB0UezeZMWWRBvY61hUZGcyQHy40WrYNtpEvw==
X-Google-Smtp-Source: ABdhPJzSw2fxHtEXofL+oSyccx3d44o85EB4XZyhFZ9A+WUNB3p4BRMwtUKN9jUDowQ5lpuL+Lumrw/gZIBWzqFBPCg=
X-Received: by 2002:a05:6402:382:: with SMTP id o2mr810780edv.238.1617749439981;
 Tue, 06 Apr 2021 15:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210401221104.31584-1-yu-cheng.yu@intel.com> <20210401221104.31584-26-yu-cheng.yu@intel.com>
In-Reply-To: <20210401221104.31584-26-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 6 Apr 2021 15:50:29 -0700
X-Gmail-Original-Message-ID: <CALCETrWa+gjf2c2WDVxk23xd11kTnrUmiqrMsOVXOKPL4Eg-JA@mail.gmail.com>
Message-ID: <CALCETrWa+gjf2c2WDVxk23xd11kTnrUmiqrMsOVXOKPL4Eg-JA@mail.gmail.com>
Subject: Re: [PATCH v24 25/30] x86/cet/shstk: Handle signals for shadow stack
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 1, 2021 at 3:11 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> When shadow stack is enabled, a task's shadow stack states must be saved
> along with the signal context and later restored in sigreturn.  However,
> currently there is no systematic facility for extending a signal context.
>
> Introduce a signal context extension struct 'sc_ext', which is used to save
> shadow stack restore token address and WAIT_ENDBR status[1].  The extension
> is located above the fpu states, plus alignment.
>
> Introduce routines for the allocation, save, and restore for sc_ext:
> - fpu__alloc_sigcontext_ext(),
> - save_extra_state_to_sigframe(),
> - get_extra_state_from_sigframe(),
> - restore_extra_state().
>
> [1] WAIT_ENDBR will be introduced later in the Indirect Branch Tracking
>     series, but add that into sc_ext now to keep the struct stable in case
>     the IBT series is applied later.

Please don't.  Instead, please figure out how that structure gets
extended for real, and organize your patches to demonstrate that the
extension works.

>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
> v24:
> - Split out shadow stack token routines to a separate patch.
> - Put signal frame save/restore routines to fpu/signal.c and re-name accordingly.
>
>  arch/x86/ia32/ia32_signal.c            |  16 +++
>  arch/x86/include/asm/cet.h             |   2 +
>  arch/x86/include/asm/fpu/internal.h    |   2 +
>  arch/x86/include/uapi/asm/sigcontext.h |   9 ++
>  arch/x86/kernel/fpu/signal.c           | 143 +++++++++++++++++++++++++
>  arch/x86/kernel/signal.c               |   9 ++
>  6 files changed, 181 insertions(+)
>
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 5e3d9b7fd5fb..96b87c5f0bbe 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -205,6 +205,7 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
>                                  void __user **fpstate)
>  {
>         unsigned long sp, fx_aligned, math_size;
> +       void __user *restorer = NULL;
>
>         /* Default to using normal stack */
>         sp = regs->sp;
> @@ -218,8 +219,23 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
>                  ksig->ka.sa.sa_restorer)
>                 sp = (unsigned long) ksig->ka.sa.sa_restorer;
>
> +       if (ksig->ka.sa.sa_flags & SA_RESTORER) {
> +               restorer = ksig->ka.sa.sa_restorer;
> +       } else if (current->mm->context.vdso) {
> +               if (ksig->ka.sa.sa_flags & SA_SIGINFO)
> +                       restorer = current->mm->context.vdso +
> +                               vdso_image_32.sym___kernel_rt_sigreturn;
> +               else
> +                       restorer = current->mm->context.vdso +
> +                               vdso_image_32.sym___kernel_sigreturn;
> +       }
> +

Why do we need another copy of this logic?  You're trying to push the
correct return address for the signal handler function onto the stack.
Please calculate that return address once and then use it here.

>         sp = fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
>         *fpstate = (struct _fpstate_32 __user *) sp;
> +
> +       if (save_extra_state_to_sigframe(1, *fpstate, (unsigned long)restorer))
> +               return (void __user *)-1L;
> +
>         if (copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
>                                      math_size) < 0)
>                 return (void __user *) -1L;
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> index ef6155213b7e..5e66919bd2fe 100644
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
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 8d33ad80704f..eb01eb6ea55d 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -443,6 +443,8 @@ static inline void copy_kernel_to_fpregs(union fpregs_state *fpstate)
>         __copy_kernel_to_fpregs(fpstate, -1);
>  }
>
> +extern int save_extra_state_to_sigframe(int ia32, void __user *fp,
> +                                       unsigned long restorer);
>  extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
>
>  /*
> diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/uapi/asm/sigcontext.h
> index 844d60eb1882..cf2d55db3be4 100644
> --- a/arch/x86/include/uapi/asm/sigcontext.h
> +++ b/arch/x86/include/uapi/asm/sigcontext.h
> @@ -196,6 +196,15 @@ struct _xstate {
>         /* New processor state extensions go here: */
>  };
>
> +/*
> + * Located at the end of sigcontext->fpstate, aligned to 8.
> + */
> +struct sc_ext {
> +       unsigned long total_size;
> +       unsigned long ssp;
> +       unsigned long wait_endbr;
> +};

We need some proper documentation and an extensibility story for this.
This won't be the last time we extend the signal state.  Keep in mind
that the FPU state is very likely to become genuinely variable sized
due to AVX-512 and AMX.

We also have the ability to extend ucontext, I believe, and I'd like
some analysis of why we want to put ssp and wait_endbr into the FPU
context instead of the ucontext.

> +
>  /*
>   * The 32-bit signal frame:
>   */
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index a4ec65317a7f..2e56f2fe8be0 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -52,6 +52,123 @@ static inline int check_for_xstate(struct fxregs_state __user *buf,
>         return 0;
>  }
>
> +int save_extra_state_to_sigframe(int ia32, void __user *fp, unsigned long restorer)
> +{
> +       int err = 0;
> +
> +#ifdef CONFIG_X86_CET
> +       struct cet_status *cet = &current->thread.cet;
> +       unsigned long token_addr = 0, new_ssp = 0;
> +       struct sc_ext ext = {};
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_CET))
> +               return 0;
> +
> +       if (cet->shstk_size) {
> +               err = shstk_setup_rstor_token(ia32, restorer,
> +                                             &token_addr, &new_ssp);
> +               if (err)
> +                       return err;
> +
> +               ext.ssp = token_addr;
> +
> +               fpregs_lock();
> +               if (test_thread_flag(TIF_NEED_FPU_LOAD))
> +                       __fpregs_load_activate();
> +               if (new_ssp)
> +                       wrmsrl(MSR_IA32_PL3_SSP, new_ssp);

wrmsrl_safe, please, with appropriate error handling.

> +               fpregs_unlock();
> +       }
> +
> +       if (ext.ssp) {
> +               void __user *p = fp;
> +
> +               ext.total_size = sizeof(ext);
> +
> +               p = fp;
> +               if (ia32)
> +                       p += sizeof(struct fregs_state);
> +
> +               p += fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
> +               p = (void __user *)ALIGN((unsigned long)p, 8);
> +
> +               if (copy_to_user(p, &ext, sizeof(ext)))
> +                       return -EFAULT;
> +       }
> +#endif
> +       return err;
> +}
> +
> +static int get_extra_state_from_sigframe(int ia32, void __user *fp, struct sc_ext *ext)
> +{
> +       int err = 0;
> +
> +#ifdef CONFIG_X86_CET
> +       struct cet_status *cet = &current->thread.cet;
> +       void __user *p;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_CET))
> +               return 0;
> +
> +       if (!cet->shstk_size)
> +               return 0;
> +
> +       memset(ext, 0, sizeof(*ext));
> +
> +       p = fp;
> +       if (ia32)
> +               p += sizeof(struct fregs_state);
> +
> +       p += fpu_user_xstate_size + FP_XSTATE_MAGIC2_SIZE;
> +       p = (void __user *)ALIGN((unsigned long)p, 8);
> +
> +       if (copy_from_user(ext, p, sizeof(*ext)))
> +               return -EFAULT;
> +
> +       if (ext->total_size != sizeof(*ext))
> +               return -EFAULT;
> +
> +       if (cet->shstk_size)
> +               err = shstk_check_rstor_token(ia32, ext->ssp, &ext->ssp);
> +#endif
> +       return err;
> +}
> +
> +/*
> + * Called from __fpu__restore_sig() and XSAVES buffer is protected by
> + * set_thread_flag(TIF_NEED_FPU_LOAD) in the slow path.
> + */
> +void restore_extra_state(struct sc_ext *sc_ext)
> +{
> +#ifdef CONFIG_X86_CET
> +       struct cet_status *cet = &current->thread.cet;
> +       struct cet_user_state *cet_user_state;
> +       u64 msr_val = 0;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_CET))
> +               return;
> +
> +       cet_user_state = get_xsave_addr(&current->thread.fpu.state.xsave,
> +                                       XFEATURE_CET_USER);
> +       if (!cet_user_state)
> +               return;
> +
> +       if (cet->shstk_size) {

Is fpregs_lock() needed?

> +               if (test_thread_flag(TIF_NEED_FPU_LOAD))
> +                       cet_user_state->user_ssp = sc_ext->ssp;
> +               else
> +                       wrmsrl(MSR_IA32_PL3_SSP, sc_ext->ssp);

wrmsrl_safe() please.

> +
> +               msr_val |= CET_SHSTK_EN;
> +       }
> +
> +       if (test_thread_flag(TIF_NEED_FPU_LOAD))
> +               cet_user_state->user_cet = msr_val;
> +       else
> +               wrmsrl(MSR_IA32_U_CET, msr_val);
> +#endif

I don't understand. Why are you recomputing MSR_IA32_U_CET here?

As another general complaint about this patch set, there's
cet->shstk_size and there's MSR_IA32_U_CET (and its copy in the fpu
state), and they seem to be used somewhat interchangably.  Why are
both needed?  Could there be some new helpers to help manage them all
in a unified way?


> +}
> +
>  /*
>   * Signal frame handlers.
>   */
> @@ -295,6 +412,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>         struct task_struct *tsk = current;
>         struct fpu *fpu = &tsk->thread.fpu;
>         struct user_i387_ia32_struct env;
> +       struct sc_ext sc_ext;
>         u64 user_xfeatures = 0;
>         int fx_only = 0;
>         int ret = 0;
> @@ -335,6 +453,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>         if ((unsigned long)buf_fx % 64)
>                 fx_only = 1;
>
> +       ret = get_extra_state_from_sigframe(ia32_fxstate, buf, &sc_ext);
> +       if (ret)
> +               return ret;
> +
>         if (!ia32_fxstate) {
>                 /*
>                  * Attempt to restore the FPU registers directly from user
> @@ -349,6 +471,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>                 pagefault_enable();
>                 if (!ret) {
>
> +                       restore_extra_state(&sc_ext);
> +
>                         /*
>                          * Restore supervisor states: previous context switch
>                          * etc has done XSAVES and saved the supervisor states
> @@ -423,6 +547,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>                 if (unlikely(init_bv))
>                         copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
>
> +               restore_extra_state(&sc_ext);
> +
>                 /*
>                  * Restore previously saved supervisor xstates along with
>                  * copied-in user xstates.
> @@ -491,12 +617,29 @@ int fpu__restore_sig(void __user *buf, int ia32_frame)
>         return __fpu__restore_sig(buf, buf_fx, size);
>  }
>
> +static unsigned long fpu__alloc_sigcontext_ext(unsigned long sp)
> +{
> +#ifdef CONFIG_X86_CET
> +       struct cet_status *cet = &current->thread.cet;
> +
> +       /*
> +        * sigcontext_ext is at: fpu + fpu_user_xstate_size +
> +        * FP_XSTATE_MAGIC2_SIZE, then aligned to 8.
> +        */
> +       if (cet->shstk_size)
> +               sp -= (sizeof(struct sc_ext) + 8);
> +#endif
> +       return sp;
> +}
> +
>  unsigned long
>  fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
>                      unsigned long *buf_fx, unsigned long *size)
>  {
>         unsigned long frame_size = xstate_sigframe_size();
>
> +       sp = fpu__alloc_sigcontext_ext(sp);
> +
>         *buf_fx = sp = round_down(sp - frame_size, 64);
>         if (ia32_frame && use_fxsr()) {
>                 frame_size += sizeof(struct fregs_state);
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index f306e85a08a6..111faa5a398f 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -239,6 +239,9 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>         unsigned long buf_fx = 0;
>         int onsigstack = on_sig_stack(sp);
>         int ret;
> +#ifdef CONFIG_X86_64
> +       void __user *restorer = NULL;
> +#endif
>
>         /* redzone */
>         if (IS_ENABLED(CONFIG_X86_64))
> @@ -270,6 +273,12 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>         if (onsigstack && !likely(on_sig_stack(sp)))
>                 return (void __user *)-1L;
>
> +#ifdef CONFIG_X86_64
> +       if (ka->sa.sa_flags & SA_RESTORER)
> +               restorer = ka->sa.sa_restorer;
> +       ret = save_extra_state_to_sigframe(0, *fpstate, (unsigned long)restorer);
> +#endif
> +
>         /* save i387 and extended state */
>         ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);
>         if (ret < 0)
> --
> 2.21.0
>
