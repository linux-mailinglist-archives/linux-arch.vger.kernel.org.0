Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C21016EFBA
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 21:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgBYUGN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 15:06:13 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40834 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgBYUGM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 15:06:12 -0500
Received: by mail-pj1-f67.google.com with SMTP id 12so185995pjb.5
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 12:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OdlKKVO5mGOvrQKdRckMkLyE3BIKjX2ICgbx5DPAF2E=;
        b=JduAXjyDMiJY1ig1lVuPENUL4LPcG09ltr+/CAaEGI5+LfcaEe2Iebr+t0ZuvY5gPL
         guS+sQJCFFEMDjrsvVoa6i+6YR6m7PF3Qv5jueMbQHLk+UbtQECkvYHgSYDpQku0kMBP
         9WTJDB/0YXltDsIMwreIJ89pfQsOlWiaXpsWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdlKKVO5mGOvrQKdRckMkLyE3BIKjX2ICgbx5DPAF2E=;
        b=TxbwhNibPpSC6zgcfS86XaZ5ie2GurSD40KM7Dk9/CkDrkh4FezkFdW4m/YsnPwr0M
         MhcxEZ/xw5adDJe/2n9Hxi1QOgikRu6mJuHIz1B/jiwF81UwTP/qvsW060w/YkuElJ4Y
         b6BxJHQTKyU4tCCWQq9zlP4SrrLj/XtF2xRHJ4jeY//4n3bSUq9ih3cWiCbtvlLXCf7B
         PPmfgwtMtDIjtfMU976P8k067/loTdRZMYs7EDcb9A9hx0nDsf16kEPykKbWDquC6Psz
         30D9j6kic9ZHLJf3yhRWyHaEeuLNnxWrgi3EmRrX3nPFvApHgHU2njoCBM2jB9ED2Dii
         CS1A==
X-Gm-Message-State: APjAAAXhUd+UqDAntxO/6rhtecZunoaNOZ2H+I4SIPvnVv+22zyAjJ8w
        pwUSzXu5zqqBEmRJ76MMolQFpA==
X-Google-Smtp-Source: APXvYqwP1jSKL1SR8nAal+kFzh07jbtwCon+pWNzaARZLu4Oab04TLTelM81F6t3QI3u5AgwJNm/Yg==
X-Received: by 2002:a17:90a:e996:: with SMTP id v22mr797285pjy.53.1582661170586;
        Tue, 25 Feb 2020 12:06:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p21sm17823448pfn.103.2020.02.25.12.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:06:09 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:06:08 -0800
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
Subject: Re: [RFC PATCH v9 04/27] x86/cet: Add control-protection fault
 handler
Message-ID: <202002251205.E2BA56A2B9@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-5-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:12AM -0800, Yu-cheng Yu wrote:
> A control-protection fault is triggered when a control-flow transfer
> attempt violates Shadow Stack or Indirect Branch Tracking constraints.
> For example, the return address for a RET instruction differs from the copy
> on the Shadow Stack; or an indirect JMP instruction, without the NOTRACK
> prefix, arrives at a non-ENDBR opcode.
> 
> The control-protection fault handler works in a similar way as the general
> protection fault handler.  It provides the si_code SEGV_CPERR to the signal
> handler.
> 
> v9:
> - Add Shadow Stack pointer to the fault printout.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/entry/entry_64.S          |  2 +-
>  arch/x86/include/asm/traps.h       |  3 ++
>  arch/x86/kernel/idt.c              |  4 ++
>  arch/x86/kernel/signal_compat.c    |  2 +-
>  arch/x86/kernel/traps.c            | 59 ++++++++++++++++++++++++++++++
>  include/uapi/asm-generic/siginfo.h |  3 +-
>  6 files changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 76942cbd95a1..6ca77312d008 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1034,7 +1034,7 @@ idtentry spurious_interrupt_bug		do_spurious_interrupt_bug	has_error_code=0
>  idtentry coprocessor_error		do_coprocessor_error		has_error_code=0
>  idtentry alignment_check		do_alignment_check		has_error_code=1
>  idtentry simd_coprocessor_error		do_simd_coprocessor_error	has_error_code=0
> -
> +idtentry control_protection		do_control_protection		has_error_code=1
>  
>  	/*
>  	 * Reload gs selector with exception handling
> diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
> index ffa0dc8a535e..7ac26bbd0bef 100644
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -26,6 +26,7 @@ asmlinkage void invalid_TSS(void);
>  asmlinkage void segment_not_present(void);
>  asmlinkage void stack_segment(void);
>  asmlinkage void general_protection(void);
> +asmlinkage void control_protection(void);
>  asmlinkage void page_fault(void);
>  asmlinkage void async_page_fault(void);
>  asmlinkage void spurious_interrupt_bug(void);
> @@ -84,6 +85,7 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
>  void __init trap_init(void);
>  #endif
>  dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
> +dotraplinkage void do_control_protection(struct pt_regs *regs, long error_code);
>  dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
>  dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
>  dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
> @@ -154,6 +156,7 @@ enum {
>  	X86_TRAP_AC,		/* 17, Alignment Check */
>  	X86_TRAP_MC,		/* 18, Machine Check */
>  	X86_TRAP_XF,		/* 19, SIMD Floating-Point Exception */
> +	X86_TRAP_CP = 21,	/* 21 Control Protection Fault */
>  	X86_TRAP_IRET = 32,	/* 32, IRET Exception */
>  };
>  
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index 87ef69a72c52..8ed406f469e7 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -102,6 +102,10 @@ static const __initconst struct idt_data def_idts[] = {
>  #elif defined(CONFIG_X86_32)
>  	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
>  #endif
> +
> +#ifdef CONFIG_X86_64
> +	INTG(X86_TRAP_CP,		control_protection),
> +#endif
>  };
>  
>  /*
> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index 9ccbf0576cd0..c572a3de1037 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
>  	 */
>  	BUILD_BUG_ON(NSIGILL  != 11);
>  	BUILD_BUG_ON(NSIGFPE  != 15);
> -	BUILD_BUG_ON(NSIGSEGV != 7);
> +	BUILD_BUG_ON(NSIGSEGV != 8);
>  	BUILD_BUG_ON(NSIGBUS  != 5);
>  	BUILD_BUG_ON(NSIGTRAP != 5);
>  	BUILD_BUG_ON(NSIGCHLD != 6);
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 05da6b5b167b..99c83ee522ed 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -570,6 +570,65 @@ do_general_protection(struct pt_regs *regs, long error_code)
>  }
>  NOKPROBE_SYMBOL(do_general_protection);
>  
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
> + * When a control protection exception occurs, send a signal
> + * to the responsible application.  Currently, control
> + * protection is only enabled for the user mode.  This
> + * exception should not come from the kernel mode.
> + */
> +dotraplinkage void
> +do_control_protection(struct pt_regs *regs, long error_code)
> +{
> +	struct task_struct *tsk;
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +	if (notify_die(DIE_TRAP, "control protection fault", regs,
> +		       error_code, X86_TRAP_CP, SIGSEGV) == NOTIFY_STOP)
> +		return;
> +	cond_local_irq_enable(regs);
> +
> +	if (!user_mode(regs))
> +		die("kernel control protection fault", regs, error_code);
> +
> +	if (!static_cpu_has(X86_FEATURE_SHSTK) &&
> +	    !static_cpu_has(X86_FEATURE_IBT))
> +		WARN_ONCE(1, "CET is disabled but got control protection fault\n");
> +
> +	tsk = current;
> +	tsk->thread.error_code = error_code;
> +	tsk->thread.trap_nr = X86_TRAP_CP;
> +
> +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> +	    printk_ratelimit()) {
> +		unsigned int max_err;
> +		unsigned long ssp;
> +
> +		max_err = ARRAY_SIZE(control_protection_err) - 1;
> +		if ((error_code < 0) || (error_code > max_err))
> +			error_code = 0;
> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +		pr_info("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
> +			tsk->comm, task_pid_nr(tsk),
> +			regs->ip, regs->sp, ssp, error_code,
> +			control_protection_err[error_code]);
> +		print_vma_addr(KERN_CONT " in ", regs->ip);
> +		pr_cont("\n");
> +	}
> +
> +	force_sig_fault(SIGSEGV, SEGV_CPERR,
> +			(void __user *)uprobe_get_trap_addr(regs));
> +}
> +NOKPROBE_SYMBOL(do_control_protection);
> +
>  dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
>  {
>  #ifdef CONFIG_DYNAMIC_FTRACE
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index cb3d6c267181..693071dbe641 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -229,7 +229,8 @@ typedef struct siginfo {
>  #define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
>  #define SEGV_ADIDERR	6	/* Disrupting MCD error */
>  #define SEGV_ADIPERR	7	/* Precise MCD exception */
> -#define NSIGSEGV	7
> +#define SEGV_CPERR	8
> +#define NSIGSEGV	8
>  
>  /*
>   * SIGBUS si_codes
> -- 
> 2.21.0
> 

-- 
Kees Cook
