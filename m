Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D784ACCE7
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 02:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiBHBFb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 20:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbiBGX4m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 18:56:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD2CC061355;
        Mon,  7 Feb 2022 15:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644278201; x=1675814201;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=G21F/4cXJmHG0nsJDWqQXo5LlOADSXHZqRfEJ0bXMWM=;
  b=QfkWiI2gNVdth79qWFs7rAzYk/tZ1npCLgirAp2FIeiAcHAVxfsOQWU7
   0q4VyKkrFJG/O0BNXKcOFOrE+FB8+6L8dsTOlJzVksEW2UXr6qP+JB75p
   0W1O3/8cfjd1XAwrv0PP9kgIE/j+Vk0kBVQ+Cc+w6TDpx9sLUFRZTQLQU
   5BS7y3c5ine1IYfYFPjeWEgM8UlmMz9V7n14oO5frMbMM4zKX1ARhO4mD
   H8574XsspmhT0OtGV0qchbCqd1NI5dwhUIFZs23MGljJOkuG+5qejAXvT
   C+CsQgWq8anypKrRhfwbtuddm/KpQ1YfMIUhUM+6efbnhQRdqPBd8GcAG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="335234965"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="335234965"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:56:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="525325995"
Received: from hgrunes-mobl1.amr.corp.intel.com (HELO [10.251.3.57]) ([10.251.3.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:56:39 -0800
Message-ID: <40453c9d-f08c-e419-3d04-22605e219594@intel.com>
Date:   Mon, 7 Feb 2022 15:56:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-7-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 06/35] x86/cet: Add control-protection fault handler
In-Reply-To: <20220130211838.8382-7-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/22 13:18, Rick Edgecombe wrote:
> A control-protection fault is triggered when a control-flow transfer
> attempt violates Shadow Stack or Indirect Branch Tracking constraints.
> For example, the return address for a RET instruction differs from the copy
> on the shadow stack; or an indirect JMP instruction, without the NOTRACK
> prefix, arrives at a non-ENDBR opcode.
> 
> The control-protection fault handler works in a similar way as the general
> protection fault handler.  It provides the si_code SEGV_CPERR to the signal
> handler.

It's not a big deal, but we should probably just remove IBT from the
changelogs for now.

>  arch/arm/kernel/signal.c           |  2 +-
>  arch/arm64/kernel/signal.c         |  2 +-
>  arch/arm64/kernel/signal32.c       |  2 +-
>  arch/sparc/kernel/signal32.c       |  2 +-
>  arch/sparc/kernel/signal_64.c      |  2 +-
>  arch/x86/include/asm/idtentry.h    |  4 ++
>  arch/x86/kernel/idt.c              |  4 ++
>  arch/x86/kernel/signal_compat.c    |  2 +-
>  arch/x86/kernel/traps.c            | 62 ++++++++++++++++++++++++++++++
>  include/uapi/asm-generic/siginfo.h |  3 +-
>  10 files changed, 78 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index c532a6041066..59aaadce9d52 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -681,7 +681,7 @@ asmlinkage void do_rseq_syscall(struct pt_regs *regs)
>   */
>  static_assert(NSIGILL	== 11);
>  static_assert(NSIGFPE	== 15);
> -static_assert(NSIGSEGV	== 9);
> +static_assert(NSIGSEGV	== 10);
>  static_assert(NSIGBUS	== 5);
>  static_assert(NSIGTRAP	== 6);
>  static_assert(NSIGCHLD	== 6);
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index d8aaf4b6f432..d2da57c415b8 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -983,7 +983,7 @@ void __init minsigstksz_setup(void)
>   */
>  static_assert(NSIGILL	== 11);
>  static_assert(NSIGFPE	== 15);
> -static_assert(NSIGSEGV	== 9);
> +static_assert(NSIGSEGV	== 10);
>  static_assert(NSIGBUS	== 5);
>  static_assert(NSIGTRAP	== 6);
>  static_assert(NSIGCHLD	== 6);
> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> index d984282b979f..8776a34c6444 100644
> --- a/arch/arm64/kernel/signal32.c
> +++ b/arch/arm64/kernel/signal32.c
> @@ -460,7 +460,7 @@ void compat_setup_restart_syscall(struct pt_regs *regs)
>   */
>  static_assert(NSIGILL	== 11);
>  static_assert(NSIGFPE	== 15);
> -static_assert(NSIGSEGV	== 9);
> +static_assert(NSIGSEGV	== 10);
>  static_assert(NSIGBUS	== 5);
>  static_assert(NSIGTRAP	== 6);
>  static_assert(NSIGCHLD	== 6);
> diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
> index 6cc124a3bb98..dc50b2a78692 100644
> --- a/arch/sparc/kernel/signal32.c
> +++ b/arch/sparc/kernel/signal32.c
> @@ -752,7 +752,7 @@ asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp)
>   */
>  static_assert(NSIGILL	== 11);
>  static_assert(NSIGFPE	== 15);
> -static_assert(NSIGSEGV	== 9);
> +static_assert(NSIGSEGV	== 10);
>  static_assert(NSIGBUS	== 5);
>  static_assert(NSIGTRAP	== 6);
>  static_assert(NSIGCHLD	== 6);
> diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
> index 2a78d2af1265..7fe2bd37bd1a 100644
> --- a/arch/sparc/kernel/signal_64.c
> +++ b/arch/sparc/kernel/signal_64.c
> @@ -562,7 +562,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
>   */
>  static_assert(NSIGILL	== 11);
>  static_assert(NSIGFPE	== 15);
> -static_assert(NSIGSEGV	== 9);
> +static_assert(NSIGSEGV	== 10);
>  static_assert(NSIGBUS	== 5);
>  static_assert(NSIGTRAP	== 6);
>  static_assert(NSIGCHLD	== 6);
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 1345088e9902..a90791433152 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -562,6 +562,10 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,	exc_stack_segment);
>  DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
>  DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
>  
> +#ifdef CONFIG_X86_SHADOW_STACK
> +DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP, exc_control_protection);
> +#endif
> +
>  /* Raw exception entries which need extra work */
>  DECLARE_IDTENTRY_RAW(X86_TRAP_UD,		exc_invalid_op);
>  DECLARE_IDTENTRY_RAW(X86_TRAP_BP,		exc_int3);
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index df0fa695bb09..9f1bdaabc246 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -113,6 +113,10 @@ static const __initconst struct idt_data def_idts[] = {
>  #elif defined(CONFIG_X86_32)
>  	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
>  #endif
> +
> +#ifdef CONFIG_X86_SHADOW_STACK
> +	INTG(X86_TRAP_CP,		asm_exc_control_protection),
> +#endif
>  };
>  
>  /*
> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index b52407c56000..ff50cd978ea5 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
>  	 */
>  	BUILD_BUG_ON(NSIGILL  != 11);
>  	BUILD_BUG_ON(NSIGFPE  != 15);
> -	BUILD_BUG_ON(NSIGSEGV != 9);
> +	BUILD_BUG_ON(NSIGSEGV != 10);
>  	BUILD_BUG_ON(NSIGBUS  != 5);
>  	BUILD_BUG_ON(NSIGTRAP != 6);
>  	BUILD_BUG_ON(NSIGCHLD != 6);
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c9d566dcf89a..54b7a146fd5e 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -39,6 +39,7 @@
>  #include <linux/io.h>
>  #include <linux/hardirq.h>
>  #include <linux/atomic.h>
> +#include <linux/nospec.h>
>  
>  #include <asm/stacktrace.h>
>  #include <asm/processor.h>
> @@ -641,6 +642,67 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	cond_local_irq_disable(regs);
>  }
>  
> +#ifdef CONFIG_X86_SHADOW_STACK
> +static const char * const control_protection_err[] = {
> +	"unknown",
> +	"near-ret",
> +	"far-ret/iret",
> +	"endbranch",
> +	"rstorssp",
> +	"setssbsy",
> +	"unknown",
> +};
> +
> +static DEFINE_RATELIMIT_STATE(cpf_rate, DEFAULT_RATELIMIT_INTERVAL,
> +			      DEFAULT_RATELIMIT_BURST);
> +
> +/*
> + * When a control protection exception occurs, send a signal to the responsible
> + * application.  Currently, control protection is only enabled for user mode.
> + * This exception should not come from kernel mode.
> + */

Please move that last sentence to the code which enforces that expectation.

> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +{
> +	struct task_struct *tsk;
> +
> +	if (!user_mode(regs)) {
> +		die("kernel control protection fault", regs, error_code);
> +		panic("Unexpected kernel control protection fault.  Machine halted.");
> +	}

s/  Machine halted.//

I think they'll get the point when they see "kernel panic".

> +
> +	cond_local_irq_enable(regs);
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		WARN_ONCE(1, "Control protection fault with CET support disabled\n");
> +
> +	tsk = current;
> +	tsk->thread.error_code = error_code;
> +	tsk->thread.trap_nr = X86_TRAP_CP;
> +
> +	/*
> +	 * Ratelimit to prevent log spamming.
> +	 */
> +	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> +	    __ratelimit(&cpf_rate)) {
> +		unsigned long ssp;
> +		int cpf_type;
> +
> +		cpf_type = array_index_nospec(error_code, ARRAY_SIZE(control_protection_err));

Isn't 'error_code' generated by the hardware?  Is this defending against
userspace which can somehow get trigger this with an arbitrary 'error_code'?

I'm also not sure I like using array_index_nospec() as the *only* bounds
checking on the array.  Is that the way folks are using it these days?
Even the comment above it has a pattern like this:

>  *     if (index < size) {
>  *         index = array_index_nospec(index, size);
>  *         val = array[index];
>  *     }


> +		rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
> +			 tsk->comm, task_pid_nr(tsk),
> +			 regs->ip, regs->sp, ssp, error_code,
> +			 control_protection_err[cpf_type]);
> +		print_vma_addr(KERN_CONT " in ", regs->ip);
> +		pr_cont("\n");
> +	}
> +
> +	force_sig_fault(SIGSEGV, SEGV_CPERR, (void __user *)0);
> +	cond_local_irq_disable(regs);
> +}
> +#endif
> +
>  static bool do_int3(struct pt_regs *regs)
>  {
>  	int res;
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 3ba180f550d7..081f4b37d22c 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -240,7 +240,8 @@ typedef struct siginfo {
>  #define SEGV_ADIPERR	7	/* Precise MCD exception */
>  #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
>  #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
> -#define NSIGSEGV	9
> +#define SEGV_CPERR	10	/* Control protection fault */
> +#define NSIGSEGV	10
>  
>  /*
>   * SIGBUS si_codes

