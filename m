Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BE83CB6F5
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jul 2021 13:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhGPLwO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jul 2021 07:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhGPLwO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jul 2021 07:52:14 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FAC061762
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 04:49:18 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id j27-20020a4a751b0000b029025fb3e97502so2338601ooc.12
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lb1Rl6A0HGKcykI+mvGe2MaXa5u6d/fROY/IK5zaRTs=;
        b=kfmI7F/GBLyaIo9WawznbzlWH6ij6drIqGlxEu59FhZUV2UD+jXsGsw06vW/g28CUu
         OkEYn/qu3TZDvdbN7FSaktfI24zQVp3rLNdKSD8+pikriJeoAwIuMePkoVbusCsO5H6S
         ZFo2Ljwz2qZDz13rkh9sp1y0CICP41j+d6VPmojEFhUOv/bWDS5TK+p5lvZ1R+OlnlW6
         7DYtDKLt31oRcS3Fdr7kcK/DJQEAAMP7HPG+WfPstOEZp5mo+GxGqnXsUFqkeA2M6xRY
         Q+bwSJ9DW0TedpTm8ljHXcbUgMUaqDzNpTFZQV6My6xQHa9WnGSSTm9ISAJa27qhrbkK
         scaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lb1Rl6A0HGKcykI+mvGe2MaXa5u6d/fROY/IK5zaRTs=;
        b=Mj3GULGhwIy7ptzxQ3zn9HEXl9z2FltwZhxPD/2DKUkKgwXLgq1Znsq6tkhEdgcjp9
         vX6c5ObdXCQHo1cQcxuBQx8ozJcM2DksjAUbKaubkWVvhZ2v7uVnDZ0QXOSuxgEeX4fn
         eFkmLPZwL1r1JIxmtzsIjvbWYfiZ+jXs9ZrlgX9JlS8kA29wUzoYeVc4T5ciCBtMHagj
         7C4voUaXaqlRUozUcA4vVfaB/0aqJVy53Yag0m8TeouQblPAslju0jYYZKOQDcz4VmxC
         RX+iP0B62XUl1/zSnmtfh+E8bhfR/izL0TgPPXLKX/L89bYguuqL0lcE3Zsnls9oy44m
         m9Bw==
X-Gm-Message-State: AOAM532Ei4Z3lsPrlyQ6Fcp+1AF3J59W6o6l/sbR/4mM5T6aFkaiwpgX
        z4rV5Exf9T774fo9+/ZhtJGOQg8suD2SB23j+KB+4w==
X-Google-Smtp-Source: ABdhPJzREFqTZ7ArvPJLuztAoqzKfKLxwXOr/KI5bfg2eSYQpEaQJNPFbZkKknbgh36JaHFmMLM0huJxm44XSWODz1E=
X-Received: by 2002:a4a:df02:: with SMTP id i2mr156404oou.14.1626436157547;
 Fri, 16 Jul 2021 04:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <87a6mnzbx2.fsf_-_@disp2133> <87mtqnxx89.fsf_-_@disp2133>
In-Reply-To: <87mtqnxx89.fsf_-_@disp2133>
From:   Marco Elver <elver@google.com>
Date:   Fri, 16 Jul 2021 13:49:06 +0200
Message-ID: <CANpmjNMW0QAbv6D5a+xFhTetD=8y9Pf6pX+y3hW0XxTQiAfXUQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] signal/sparc: si_trapno is only used with SIGILL ILL_ILLTRP
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 15 Jul 2021 at 20:12, Eric W. Biederman <ebiederm@xmission.com> wrote:
> While reviewing the signal handlers on sparc it became clear that
> si_trapno is only set to a non-zero value when sending SIGILL with
> si_code ILL_ILLTRP.
>
> Add force_sig_fault_trapno and send SIGILL ILL_ILLTRP with it.
>
> Remove the define of __ARCH_SI_TRAPNO and remove the always zero
> si_trapno parameter from send_sig_fault and force_sig_fault.
>
> v1: https://lkml.kernel.org/r/m1eeers7q7.fsf_-_@fess.ebiederm.org
> v2: https://lkml.kernel.org/r/20210505141101.11519-7-ebiederm@xmission.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  arch/sparc/include/uapi/asm/siginfo.h |  3 --
>  arch/sparc/kernel/process_64.c        |  2 +-
>  arch/sparc/kernel/sys_sparc_32.c      |  2 +-
>  arch/sparc/kernel/sys_sparc_64.c      |  2 +-
>  arch/sparc/kernel/traps_32.c          | 22 +++++++-------
>  arch/sparc/kernel/traps_64.c          | 44 ++++++++++++---------------
>  arch/sparc/kernel/unaligned_32.c      |  2 +-
>  arch/sparc/mm/fault_32.c              |  2 +-
>  arch/sparc/mm/fault_64.c              |  2 +-
>  include/linux/sched/signal.h          |  1 +
>  kernel/signal.c                       | 19 ++++++++++++
>  11 files changed, 56 insertions(+), 45 deletions(-)
>
> diff --git a/arch/sparc/include/uapi/asm/siginfo.h b/arch/sparc/include/uapi/asm/siginfo.h
> index 68bdde4c2a2e..0e7c27522aed 100644
> --- a/arch/sparc/include/uapi/asm/siginfo.h
> +++ b/arch/sparc/include/uapi/asm/siginfo.h
> @@ -8,9 +8,6 @@
>
>  #endif /* defined(__sparc__) && defined(__arch64__) */
>
> -
> -#define __ARCH_SI_TRAPNO
> -
>  #include <asm-generic/siginfo.h>
>
>
> diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
> index d33c58a58d4f..547b06b49ce3 100644
> --- a/arch/sparc/kernel/process_64.c
> +++ b/arch/sparc/kernel/process_64.c
> @@ -518,7 +518,7 @@ void synchronize_user_stack(void)
>
>  static void stack_unaligned(unsigned long sp)
>  {
> -       force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) sp, 0);
> +       force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) sp);
>  }
>
>  static const char uwfault32[] = KERN_INFO \
> diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
> index be77538bc038..082a551897ed 100644
> --- a/arch/sparc/kernel/sys_sparc_32.c
> +++ b/arch/sparc/kernel/sys_sparc_32.c
> @@ -151,7 +151,7 @@ sparc_breakpoint (struct pt_regs *regs)
>  #ifdef DEBUG_SPARC_BREAKPOINT
>          printk ("TRAP: Entering kernel PC=%x, nPC=%x\n", regs->pc, regs->npc);
>  #endif
> -       force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc, 0);
> +       force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
>
>  #ifdef DEBUG_SPARC_BREAKPOINT
>         printk ("TRAP: Returning to space: PC=%x nPC=%x\n", regs->pc, regs->npc);
> diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
> index 6b92fadb6ec7..1e9a9e016237 100644
> --- a/arch/sparc/kernel/sys_sparc_64.c
> +++ b/arch/sparc/kernel/sys_sparc_64.c
> @@ -514,7 +514,7 @@ asmlinkage void sparc_breakpoint(struct pt_regs *regs)
>  #ifdef DEBUG_SPARC_BREAKPOINT
>          printk ("TRAP: Entering kernel PC=%lx, nPC=%lx\n", regs->tpc, regs->tnpc);
>  #endif
> -       force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->tpc, 0);
> +       force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->tpc);
>  #ifdef DEBUG_SPARC_BREAKPOINT
>         printk ("TRAP: Returning to space: PC=%lx nPC=%lx\n", regs->tpc, regs->tnpc);
>  #endif
> diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
> index 247a0d9683b2..5630e5a395e0 100644
> --- a/arch/sparc/kernel/traps_32.c
> +++ b/arch/sparc/kernel/traps_32.c
> @@ -102,8 +102,8 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
>         if(regs->psr & PSR_PS)
>                 die_if_kernel("Kernel bad trap", regs);
>
> -       force_sig_fault(SIGILL, ILL_ILLTRP,
> -                       (void __user *)regs->pc, type - 0x80);
> +       force_sig_fault_trapno(SIGILL, ILL_ILLTRP,
> +                              (void __user *)regs->pc, type - 0x80);
>  }
>
>  void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
> @@ -116,7 +116,7 @@ void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned lon
>                regs->pc, *(unsigned long *)regs->pc);
>  #endif
>
> -       send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, 0, current);
> +       send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, current);
>  }
>
>  void do_priv_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
> @@ -124,7 +124,7 @@ void do_priv_instruction(struct pt_regs *regs, unsigned long pc, unsigned long n
>  {
>         if(psr & PSR_PS)
>                 die_if_kernel("Penguin instruction from Penguin mode??!?!", regs);
> -       send_sig_fault(SIGILL, ILL_PRVOPC, (void __user *)pc, 0, current);
> +       send_sig_fault(SIGILL, ILL_PRVOPC, (void __user *)pc, current);
>  }
>
>  /* XXX User may want to be allowed to do this. XXX */
> @@ -145,7 +145,7 @@ void do_memaccess_unaligned(struct pt_regs *regs, unsigned long pc, unsigned lon
>  #endif
>         send_sig_fault(SIGBUS, BUS_ADRALN,
>                        /* FIXME: Should dig out mna address */ (void *)0,
> -                      0, current);
> +                      current);
>  }
>
>  static unsigned long init_fsr = 0x0UL;
> @@ -291,7 +291,7 @@ void do_fpe_trap(struct pt_regs *regs, unsigned long pc, unsigned long npc,
>                 else if (fsr & 0x01)
>                         code = FPE_FLTRES;
>         }
> -       send_sig_fault(SIGFPE, code, (void __user *)pc, 0, fpt);
> +       send_sig_fault(SIGFPE, code, (void __user *)pc, fpt);
>  #ifndef CONFIG_SMP
>         last_task_used_math = NULL;
>  #endif
> @@ -305,7 +305,7 @@ void handle_tag_overflow(struct pt_regs *regs, unsigned long pc, unsigned long n
>  {
>         if(psr & PSR_PS)
>                 die_if_kernel("Penguin overflow trap from kernel mode", regs);
> -       send_sig_fault(SIGEMT, EMT_TAGOVF, (void __user *)pc, 0, current);
> +       send_sig_fault(SIGEMT, EMT_TAGOVF, (void __user *)pc, current);
>  }
>
>  void handle_watchpoint(struct pt_regs *regs, unsigned long pc, unsigned long npc,
> @@ -327,13 +327,13 @@ void handle_reg_access(struct pt_regs *regs, unsigned long pc, unsigned long npc
>         printk("Register Access Exception at PC %08lx NPC %08lx PSR %08lx\n",
>                pc, npc, psr);
>  #endif
> -       force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)pc, 0);
> +       force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)pc);
>  }
>
>  void handle_cp_disabled(struct pt_regs *regs, unsigned long pc, unsigned long npc,
>                         unsigned long psr)
>  {
> -       send_sig_fault(SIGILL, ILL_COPROC, (void __user *)pc, 0, current);
> +       send_sig_fault(SIGILL, ILL_COPROC, (void __user *)pc, current);
>  }
>
>  void handle_cp_exception(struct pt_regs *regs, unsigned long pc, unsigned long npc,
> @@ -343,13 +343,13 @@ void handle_cp_exception(struct pt_regs *regs, unsigned long pc, unsigned long n
>         printk("Co-Processor Exception at PC %08lx NPC %08lx PSR %08lx\n",
>                pc, npc, psr);
>  #endif
> -       send_sig_fault(SIGILL, ILL_COPROC, (void __user *)pc, 0, current);
> +       send_sig_fault(SIGILL, ILL_COPROC, (void __user *)pc, current);
>  }
>
>  void handle_hw_divzero(struct pt_regs *regs, unsigned long pc, unsigned long npc,
>                        unsigned long psr)
>  {
> -       send_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)pc, 0, current);
> +       send_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)pc, current);
>  }
>
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
> diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
> index a850dccd78ea..6863025ed56d 100644
> --- a/arch/sparc/kernel/traps_64.c
> +++ b/arch/sparc/kernel/traps_64.c
> @@ -107,8 +107,8 @@ void bad_trap(struct pt_regs *regs, long lvl)
>                 regs->tpc &= 0xffffffff;
>                 regs->tnpc &= 0xffffffff;
>         }
> -       force_sig_fault(SIGILL, ILL_ILLTRP,
> -                       (void __user *)regs->tpc, lvl);
> +       force_sig_fault_trapno(SIGILL, ILL_ILLTRP,
> +                              (void __user *)regs->tpc, lvl);
>  }
>
>  void bad_trap_tl1(struct pt_regs *regs, long lvl)
> @@ -201,8 +201,7 @@ void spitfire_insn_access_exception(struct pt_regs *regs, unsigned long sfsr, un
>                 regs->tpc &= 0xffffffff;
>                 regs->tnpc &= 0xffffffff;
>         }
> -       force_sig_fault(SIGSEGV, SEGV_MAPERR,
> -                       (void __user *)regs->tpc, 0);
> +       force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)regs->tpc);
>  out:
>         exception_exit(prev_state);
>  }
> @@ -237,7 +236,7 @@ void sun4v_insn_access_exception(struct pt_regs *regs, unsigned long addr, unsig
>                 regs->tpc &= 0xffffffff;
>                 regs->tnpc &= 0xffffffff;
>         }
> -       force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *) addr, 0);
> +       force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *) addr);
>  }
>
>  void sun4v_insn_access_exception_tl1(struct pt_regs *regs, unsigned long addr, unsigned long type_ctx)
> @@ -321,7 +320,7 @@ void spitfire_data_access_exception(struct pt_regs *regs, unsigned long sfsr, un
>         if (is_no_fault_exception(regs))
>                 return;
>
> -       force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)sfar, 0);
> +       force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)sfar);
>  out:
>         exception_exit(prev_state);
>  }
> @@ -385,13 +384,13 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
>          */
>         switch (type) {
>         case HV_FAULT_TYPE_INV_ASI:
> -               force_sig_fault(SIGILL, ILL_ILLADR, (void __user *)addr, 0);
> +               force_sig_fault(SIGILL, ILL_ILLADR, (void __user *)addr);
>                 break;
>         case HV_FAULT_TYPE_MCD_DIS:
> -               force_sig_fault(SIGSEGV, SEGV_ACCADI, (void __user *)addr, 0);
> +               force_sig_fault(SIGSEGV, SEGV_ACCADI, (void __user *)addr);
>                 break;
>         default:
> -               force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)addr, 0);
> +               force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)addr);
>                 break;
>         }
>  }
> @@ -568,7 +567,7 @@ static void spitfire_ue_log(unsigned long afsr, unsigned long afar, unsigned lon
>                 regs->tpc &= 0xffffffff;
>                 regs->tnpc &= 0xffffffff;
>         }
> -       force_sig_fault(SIGBUS, BUS_OBJERR, (void *)0, 0);
> +       force_sig_fault(SIGBUS, BUS_OBJERR, (void *)0);
>  }
>
>  void spitfire_access_error(struct pt_regs *regs, unsigned long status_encoded, unsigned long afar)
> @@ -2069,8 +2068,7 @@ void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
>         /* Send SIGSEGV to the userspace process with the right signal
>          * code
>          */
> -       force_sig_fault(SIGSEGV, SEGV_ADIDERR, (void __user *)ent.err_raddr,
> -                       0);
> +       force_sig_fault(SIGSEGV, SEGV_ADIDERR, (void __user *)ent.err_raddr);
>  }
>
>  /* We run with %pil set to PIL_NORMAL_MAX and PSTATE_IE enabled in %pstate.
> @@ -2184,7 +2182,7 @@ bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
>         }
>         if (attrs & SUN4V_ERR_ATTRS_PIO) {
>                 force_sig_fault(SIGBUS, BUS_ADRERR,
> -                               (void __user *)sun4v_get_vaddr(regs), 0);
> +                               (void __user *)sun4v_get_vaddr(regs));
>                 return true;
>         }
>
> @@ -2340,8 +2338,7 @@ static void do_fpe_common(struct pt_regs *regs)
>                         else if (fsr & 0x01)
>                                 code = FPE_FLTRES;
>                 }
> -               force_sig_fault(SIGFPE, code,
> -                               (void __user *)regs->tpc, 0);
> +               force_sig_fault(SIGFPE, code, (void __user *)regs->tpc);
>         }
>  }
>
> @@ -2395,8 +2392,7 @@ void do_tof(struct pt_regs *regs)
>                 regs->tpc &= 0xffffffff;
>                 regs->tnpc &= 0xffffffff;
>         }
> -       force_sig_fault(SIGEMT, EMT_TAGOVF,
> -                       (void __user *)regs->tpc, 0);
> +       force_sig_fault(SIGEMT, EMT_TAGOVF, (void __user *)regs->tpc);
>  out:
>         exception_exit(prev_state);
>  }
> @@ -2415,8 +2411,7 @@ void do_div0(struct pt_regs *regs)
>                 regs->tpc &= 0xffffffff;
>                 regs->tnpc &= 0xffffffff;
>         }
> -       force_sig_fault(SIGFPE, FPE_INTDIV,
> -                       (void __user *)regs->tpc, 0);
> +       force_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)regs->tpc);
>  out:
>         exception_exit(prev_state);
>  }
> @@ -2612,7 +2607,7 @@ void do_illegal_instruction(struct pt_regs *regs)
>                         }
>                 }
>         }
> -       force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, 0);
> +       force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc);
>  out:
>         exception_exit(prev_state);
>  }
> @@ -2632,7 +2627,7 @@ void mem_address_unaligned(struct pt_regs *regs, unsigned long sfar, unsigned lo
>         if (is_no_fault_exception(regs))
>                 return;
>
> -       force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)sfar, 0);
> +       force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)sfar);
>  out:
>         exception_exit(prev_state);
>  }
> @@ -2650,7 +2645,7 @@ void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_c
>         if (is_no_fault_exception(regs))
>                 return;
>
> -       force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) addr, 0);
> +       force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) addr);
>  }
>
>  /* sun4v_mem_corrupt_detect_precise() - Handle precise exception on an ADI
> @@ -2697,7 +2692,7 @@ void sun4v_mem_corrupt_detect_precise(struct pt_regs *regs, unsigned long addr,
>                 regs->tpc &= 0xffffffff;
>                 regs->tnpc &= 0xffffffff;
>         }
> -       force_sig_fault(SIGSEGV, SEGV_ADIPERR, (void __user *)addr, 0);
> +       force_sig_fault(SIGSEGV, SEGV_ADIPERR, (void __user *)addr);
>  }
>
>  void do_privop(struct pt_regs *regs)
> @@ -2712,8 +2707,7 @@ void do_privop(struct pt_regs *regs)
>                 regs->tpc &= 0xffffffff;
>                 regs->tnpc &= 0xffffffff;
>         }
> -       force_sig_fault(SIGILL, ILL_PRVOPC,
> -                       (void __user *)regs->tpc, 0);
> +       force_sig_fault(SIGILL, ILL_PRVOPC, (void __user *)regs->tpc);
>  out:
>         exception_exit(prev_state);
>  }
> diff --git a/arch/sparc/kernel/unaligned_32.c b/arch/sparc/kernel/unaligned_32.c
> index ef5c5207c9ff..455f0258c745 100644
> --- a/arch/sparc/kernel/unaligned_32.c
> +++ b/arch/sparc/kernel/unaligned_32.c
> @@ -278,5 +278,5 @@ asmlinkage void user_unaligned_trap(struct pt_regs *regs, unsigned int insn)
>  {
>         send_sig_fault(SIGBUS, BUS_ADRALN,
>                        (void __user *)safe_compute_effective_address(regs, insn),
> -                      0, current);
> +                      current);
>  }
> diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
> index de2031c2b2d7..fa858626b85b 100644
> --- a/arch/sparc/mm/fault_32.c
> +++ b/arch/sparc/mm/fault_32.c
> @@ -83,7 +83,7 @@ static void __do_fault_siginfo(int code, int sig, struct pt_regs *regs,
>                 show_signal_msg(regs, sig, code,
>                                 addr, current);
>
> -       force_sig_fault(sig, code, (void __user *) addr, 0);
> +       force_sig_fault(sig, code, (void __user *) addr);
>  }
>
>  static unsigned long compute_si_addr(struct pt_regs *regs, int text_fault)
> diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
> index 0a6bcc85fba7..9a9652a15fed 100644
> --- a/arch/sparc/mm/fault_64.c
> +++ b/arch/sparc/mm/fault_64.c
> @@ -176,7 +176,7 @@ static void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
>         if (unlikely(show_unhandled_signals))
>                 show_signal_msg(regs, sig, code, addr, current);
>
> -       force_sig_fault(sig, code, (void __user *) addr, 0);
> +       force_sig_fault(sig, code, (void __user *) addr);
>  }
>
>  static unsigned int get_fault_insn(struct pt_regs *regs, unsigned int insn)
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index b9126fe06c3f..99a9ab2b169a 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -329,6 +329,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey);
>  int force_sig_perf(void __user *addr, u32 type, u64 sig_data);
>
>  int force_sig_ptrace_errno_trap(int errno, void __user *addr);
> +int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno);
>
>  extern int send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
>  extern void force_sigsegv(int sig);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index a3229add4455..87a374225277 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1808,6 +1808,22 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr)
>         return force_sig_info(&info);
>  }
>
> +/* For the rare architectures that include trap information using
> + * si_trapno.
> + */
> +int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno)
> +{
> +       struct kernel_siginfo info;
> +
> +       clear_siginfo(&info);
> +       info.si_signo = sig;
> +       info.si_errno = 0;
> +       info.si_code  = code;
> +       info.si_addr  = addr;
> +       info.si_trapno = trapno;
> +       return force_sig_info(&info);
> +}
> +
>  int kill_pgrp(struct pid *pid, int sig, int priv)
>  {
>         int ret;
> @@ -3243,6 +3259,9 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
>  #endif
>                         else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
>                                 layout = SIL_PERF_EVENT;
> +                       else if (IS_ENABLED(CONFIG_SPARC) &&
> +                                (sig == SIGILL) && (si_code == ILL_ILLTRP))
> +                               layout = SIL_FAULT_TRAPNO;
>  #ifdef __ARCH_SI_TRAPNO
>                         else if (layout == SIL_FAULT)
>                                 layout = SIL_FAULT_TRAPNO;
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/87mtqnxx89.fsf_-_%40disp2133.
