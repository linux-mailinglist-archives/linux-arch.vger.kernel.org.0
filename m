Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1B30FE29
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbhBDUXg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbhBDUW1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:22:27 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8BC0617A9
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 12:09:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id nm1so2339829pjb.3
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 12:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/l4RZQaOQ7d1ouPGYljMviXnbT3WGsKxbFcd6Drk0Lo=;
        b=fGh06rg6gheCvBcGHTM1w3CvOKYBLWLRn9SsYCTlMhzkC4JaaPEVY9uKw0CvECVwVO
         GLeSCKWBvTR1v0FQSiY/XKcTK9KT+DVTzTKdoaxaQIGfWrhvlikM3pXCSAnIygWSjYCw
         2AQGbsH7tWwcwYgYIpccGn1vT6vFCvencsBi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/l4RZQaOQ7d1ouPGYljMviXnbT3WGsKxbFcd6Drk0Lo=;
        b=MYj3u1HwyKwk47/RxLtCv3i+8VveITNjc3PBW2TUIDli576sU67SOaT7BkYxGszW1T
         mMGOGaL5b1LD0jg4siIwuyVbvz4hJtwBeRBvFSg8dWP1x9SLPjcPdJlKhGJLYnVCOsYm
         0vD9SyF/IE+WTvrck/yT1+UJpf6D5X7Td0qhv95WjL/8W/FoQy1J59jVFVUBaxEFW9L6
         TP3d9jCzBmx3Kq6VrRs5sqQ5lvXgfUYoFFU3RuXTtQZDOafmcIxZ3Kz8PVcR2Q5uroB/
         vE4DB62IWooj9Zl6b8Ot1AdfKThhcRvS2oRKronegeoBr77+KsWJt5OM1fM8rh+PpDmY
         eHfQ==
X-Gm-Message-State: AOAM533WplEOluqS3dStYFN/pHrNXizE5rD/5Ev1FgtpBNM1H+9tqJ6y
        veDgWIwixp+gvtuPORVSXTpBGg==
X-Google-Smtp-Source: ABdhPJznzHpDv1tAkuCyPFHIVKGk/b0KKU4u5/1VBsGpliEe4MBq48F17ma54ciAn2Co22Y5ztJK+w==
X-Received: by 2002:a17:903:1d0:b029:df:d098:f1cb with SMTP id e16-20020a17090301d0b02900dfd098f1cbmr865803plh.49.1612469350638;
        Thu, 04 Feb 2021 12:09:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15sm510608pgt.35.2021.02.04.12.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:09:09 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:09:08 -0800
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v19 06/25] x86/cet: Add control-protection fault handler
Message-ID: <202102041201.C2B93F8D8A@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-7-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:28PM -0800, Yu-cheng Yu wrote:
> A control-protection fault is triggered when a control-flow transfer
> attempt violates Shadow Stack or Indirect Branch Tracking constraints.
> For example, the return address for a RET instruction differs from the copy
> on the shadow stack; or an indirect JMP instruction, without the NOTRACK
> prefix, arrives at a non-ENDBR opcode.
> 
> The control-protection fault handler works in a similar way as the general
> protection fault handler.  It provides the si_code SEGV_CPERR to the signal
> handler.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> ---
>  arch/x86/include/asm/idtentry.h    |  4 ++
>  arch/x86/kernel/idt.c              |  4 ++
>  arch/x86/kernel/signal_compat.c    |  2 +-
>  arch/x86/kernel/traps.c            | 60 ++++++++++++++++++++++++++++++
>  include/uapi/asm-generic/siginfo.h |  3 +-
>  5 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index f656aabd1545..ff4b3bf634da 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -574,6 +574,10 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,	exc_stack_segment);
>  DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
>  DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
>  
> +#ifdef CONFIG_X86_CET
> +DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP, exc_control_protection);
> +#endif
> +
>  /* Raw exception entries which need extra work */
>  DECLARE_IDTENTRY_RAW(X86_TRAP_UD,		exc_invalid_op);
>  DECLARE_IDTENTRY_RAW(X86_TRAP_BP,		exc_int3);
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index ee1a283f8e96..e8166d9bbb10 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -105,6 +105,10 @@ static const __initconst struct idt_data def_idts[] = {
>  #elif defined(CONFIG_X86_32)
>  	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
>  #endif
> +
> +#ifdef CONFIG_X86_CET
> +	INTG(X86_TRAP_CP,		asm_exc_control_protection),
> +#endif
>  };
>  
>  /*
> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index a5330ff498f0..dd92490b1e7f 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
>  	 */
>  	BUILD_BUG_ON(NSIGILL  != 11);
>  	BUILD_BUG_ON(NSIGFPE  != 15);
> -	BUILD_BUG_ON(NSIGSEGV != 9);
> +	BUILD_BUG_ON(NSIGSEGV != 10);
>  	BUILD_BUG_ON(NSIGBUS  != 5);
>  	BUILD_BUG_ON(NSIGTRAP != 5);
>  	BUILD_BUG_ON(NSIGCHLD != 6);
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 7f5aec758f0e..f5354c35df32 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -606,6 +606,66 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	cond_local_irq_disable(regs);
>  }
>  
> +#ifdef CONFIG_X86_CET
> +static const char * const control_protection_err[] = {
> +	"unknown",
> +	"near-ret",
> +	"far-ret/iret",
> +	"endbranch",
> +	"rstorssp",
> +	"setssbsy",
> +};
> +
> +/*
> + * When a control protection exception occurs, send a signal to the responsible
> + * application.  Currently, control protection is only enabled for user mode.
> + * This exception should not come from kernel mode.
> + */
> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +{
> +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);
> +	struct task_struct *tsk;
> +
> +	if (!user_mode(regs)) {
> +		pr_emerg("PANIC: unexpected kernel control protection fault\n");
> +		die("kernel control protection fault", regs, error_code);
> +		panic("Machine halted.");
> +	}
> +
> +	cond_local_irq_enable(regs);
> +
> +	if (!boot_cpu_has(X86_FEATURE_CET))
> +		WARN_ONCE(1, "Control protection fault with CET support disabled\n");
> +
> +	tsk = current;
> +	tsk->thread.error_code = error_code;
> +	tsk->thread.trap_nr = X86_TRAP_CP;
> +
> +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> +	    __ratelimit(&rs)) {
> +		unsigned int max_err;
> +		unsigned long ssp;
> +
> +		max_err = ARRAY_SIZE(control_protection_err) - 1;
> +		if (error_code < 0 || error_code > max_err)
> +			error_code = 0;

Do you want to mask the error_code here before printing its value?

> +
> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
> +			 tsk->comm, task_pid_nr(tsk),
> +			 regs->ip, regs->sp, ssp, error_code,
> +			 control_protection_err[error_code]);

Instead, you could clamp error_code to ARRAY_SIZE(control_protection_err),
and add another "unknown" to the end of the strings:

	control_protection_err[
		array_index_nospec(error_code,
				   ARRAY_SIZE(control_protection_err))]

Everything else looks good.

> +		print_vma_addr(KERN_CONT " in ", regs->ip);
> +		pr_cont("\n");
> +	}
> +
> +	force_sig_fault(SIGSEGV, SEGV_CPERR,
> +			(void __user *)uprobe_get_trap_addr(regs));
> +	cond_local_irq_disable(regs);
> +}
> +#endif
> +
>  static bool do_int3(struct pt_regs *regs)
>  {
>  	int res;
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index d2597000407a..1c2ea91284a0 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -231,7 +231,8 @@ typedef struct siginfo {
>  #define SEGV_ADIPERR	7	/* Precise MCD exception */
>  #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
>  #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
> -#define NSIGSEGV	9
> +#define SEGV_CPERR	10	/* Control protection fault */
> +#define NSIGSEGV	10
>  
>  /*
>   * SIGBUS si_codes
> -- 
> 2.21.0
> 

-- 
Kees Cook
