Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050AA317095
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 20:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhBJTtm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 14:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233093AbhBJTt1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Feb 2021 14:49:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62A2064ED4
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 19:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612986526;
        bh=FAPGExqOTkOBqOlkCN+OURryuSv/6YZbk+hA40//uP4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qqXiVHqcEQzlQMKfWyZGVyXTnVfbR0Nh8XzPsU/TsXK2AOyNqURhBBi73UGFdA2aB
         rboYLFKEEveMuxdXxvRGNnyTxB7ojs/J4VffGjotsaBzDPMUT3o78Ziq9yw5Ek9VcO
         r6ll9iFBr5goU8h60p/GWFjs9v9A5CXyWQqK5lTv65sAP/Jkrx9bCvjEqQ0FOEG713
         Ao7Rnj1kfBo1n5tZHIJbUdNXJ3b9GITeeP8/oJplZbIDGzW8C8sYZvwBTSA7f2Xlke
         ntUR0nnFo4lOMKI3sdwmwjBA8942xZ4C7JtIgne4ft3/ISBJZn16iHJVig8dw8pkEb
         ThMuCmO5hLOqQ==
Received: by mail-ej1-f43.google.com with SMTP id w2so6243305ejk.13
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 11:48:46 -0800 (PST)
X-Gm-Message-State: AOAM532fM5kTYL2W0MZQXzLTVkvi0dAdXwS7rO5OJYE+Euxk8fEEBJ1A
        RJEo2fOIqZFQ3JBZCUkf5UuO8UdOxBPhjFRPxfC9rg==
X-Google-Smtp-Source: ABdhPJxZ1Oe7ZfDn2o8sh5z16NgXDE74CZwTf3R65dv3ub1JlsAMldes56Bodh/Kn0gw1S45DR4gxiZj4SL+x2P51Tw=
X-Received: by 2002:a17:906:17d3:: with SMTP id u19mr4829127eje.316.1612986524982;
 Wed, 10 Feb 2021 11:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20210210175703.12492-1-yu-cheng.yu@intel.com> <20210210175703.12492-7-yu-cheng.yu@intel.com>
In-Reply-To: <20210210175703.12492-7-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 10 Feb 2021 11:48:33 -0800
X-Gmail-Original-Message-ID: <CALCETrVBTocCecYfTMEqeeHSquyWLPYBDP4eWQECo9WFYg2_pg@mail.gmail.com>
Message-ID: <CALCETrVBTocCecYfTMEqeeHSquyWLPYBDP4eWQECo9WFYg2_pg@mail.gmail.com>
Subject: Re: [PATCH v20 06/25] x86/cet: Add control-protection fault handler
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
        "Huang, Haitao" <haitao.huang@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 10, 2021 at 9:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
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
>  arch/x86/kernel/traps.c            | 63 ++++++++++++++++++++++++++++++
>  include/uapi/asm-generic/siginfo.h |  3 +-
>  5 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index f656aabd1545..ff4b3bf634da 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -574,6 +574,10 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,    exc_stack_segment);
>  DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,        exc_general_protection);
>  DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,        exc_alignment_check);
>
> +#ifdef CONFIG_X86_CET
> +DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP, exc_control_protection);
> +#endif
> +
>  /* Raw exception entries which need extra work */
>  DECLARE_IDTENTRY_RAW(X86_TRAP_UD,              exc_invalid_op);
>  DECLARE_IDTENTRY_RAW(X86_TRAP_BP,              exc_int3);
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index ee1a283f8e96..e8166d9bbb10 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -105,6 +105,10 @@ static const __initconst struct idt_data def_idts[] = {
>  #elif defined(CONFIG_X86_32)
>         SYSG(IA32_SYSCALL_VECTOR,       entry_INT80_32),
>  #endif
> +
> +#ifdef CONFIG_X86_CET
> +       INTG(X86_TRAP_CP,               asm_exc_control_protection),
> +#endif
>  };
>
>  /*
> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index a5330ff498f0..dd92490b1e7f 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
>          */
>         BUILD_BUG_ON(NSIGILL  != 11);
>         BUILD_BUG_ON(NSIGFPE  != 15);
> -       BUILD_BUG_ON(NSIGSEGV != 9);
> +       BUILD_BUG_ON(NSIGSEGV != 10);
>         BUILD_BUG_ON(NSIGBUS  != 5);
>         BUILD_BUG_ON(NSIGTRAP != 5);
>         BUILD_BUG_ON(NSIGCHLD != 6);
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 7f5aec758f0e..8c7fa91a57c9 100644
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
> @@ -606,6 +607,68 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>         cond_local_irq_disable(regs);
>  }
>
> +#ifdef CONFIG_X86_CET
> +static const char * const control_protection_err[] = {
> +       "unknown",
> +       "near-ret",
> +       "far-ret/iret",
> +       "endbranch",
> +       "rstorssp",
> +       "setssbsy",
> +       "unknown",
> +};
> +
> +/*
> + * When a control protection exception occurs, send a signal to the responsible
> + * application.  Currently, control protection is only enabled for user mode.
> + * This exception should not come from kernel mode.
> + */
> +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> +{
> +       static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +                                     DEFAULT_RATELIMIT_BURST);
> +       struct task_struct *tsk;
> +
> +       if (!user_mode(regs)) {
> +               pr_emerg("PANIC: unexpected kernel control protection fault\n");
> +               die("kernel control protection fault", regs, error_code);
> +               panic("Machine halted.");

I think it would be nice to decode the error code and print the cause.

> +       }
> +
> +       cond_local_irq_enable(regs);

We got rid of user mode irqs off a while ago.   You can just do
local_irq_enable();

> +
> +       if (!boot_cpu_has(X86_FEATURE_CET))
> +               WARN_ONCE(1, "Control protection fault with CET support disabled\n");
> +
> +       tsk = current;
> +       tsk->thread.error_code = error_code;
> +       tsk->thread.trap_nr = X86_TRAP_CP;



> +
> +       /*
> +        * Ratelimit to prevent log spamming.
> +        */
> +       if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
> +           __ratelimit(&rs)) {
> +               unsigned long ssp;
> +               int err;
> +
> +               err = array_index_nospec(error_code, ARRAY_SIZE(control_protection_err));

Shouldn't this do a bounds check?  You also need to handle the ENCL bit.

> +
> +               rdmsrl(MSR_IA32_PL3_SSP, ssp);
> +               pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
> +                        tsk->comm, task_pid_nr(tsk),
> +                        regs->ip, regs->sp, ssp, error_code,
> +                        control_protection_err[err]);

That should be pr_info();

> +               print_vma_addr(KERN_CONT " in ", regs->ip);
> +               pr_cont("\n");
> +       }
> +
> +       force_sig_fault(SIGSEGV, SEGV_CPERR,
> +                       (void __user *)uprobe_get_trap_addr(regs));
> +       cond_local_irq_disable(regs);
> +}
> +#endif
> +
>  static bool do_int3(struct pt_regs *regs)
>  {
>         int res;
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index d2597000407a..1c2ea91284a0 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -231,7 +231,8 @@ typedef struct siginfo {
>  #define SEGV_ADIPERR   7       /* Precise MCD exception */
>  #define SEGV_MTEAERR   8       /* Asynchronous ARM MTE error */
>  #define SEGV_MTESERR   9       /* Synchronous ARM MTE exception */
> -#define NSIGSEGV       9
> +#define SEGV_CPERR     10      /* Control protection fault */
> +#define NSIGSEGV       10
>
>  /*
>   * SIGBUS si_codes
> --
> 2.21.0
>
