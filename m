Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D5C3CB6F0
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jul 2021 13:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhGPLvq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jul 2021 07:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhGPLvp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jul 2021 07:51:45 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91841C061764
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 04:48:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w188so10527194oif.10
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBDiVd1cIkOM0UYh+A3OX5H90z0c0oFIied3Z31qv0U=;
        b=gSPmr7lU1oUhLDXOUzHAv8ekI3BKFM0jh/vQdNZoh+RYnQYQSi9u0tDVeJJZN2eRsf
         YGChMn2y0O/oOdUG954AtIkWRKiJVrorBf/W6GGSk27+zPJH/6LXgEwQ1r5NER1AhbQR
         2wdIi7xU94X/B8g2gZ0jYxsPiR6nWD2NFG9SkYbhsfsZVfWuEFyi9NakKL/zLjlwLn6Y
         uszvMIR8nKDP/1cxzBWl0rW1x2krgK93IIzHtrmZXODzNgUA10cppjag6Dwt2zFyCeZ0
         RHAaQtINMzrMkOrTfXcYfdFNcdjLJ/BqlS4p4YmsOlc7XHs3Nz3TrhBqe5Tl5fUBnyXL
         zh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBDiVd1cIkOM0UYh+A3OX5H90z0c0oFIied3Z31qv0U=;
        b=FDkhDzLVvG+mRBdOq9JKoUx8MGHHEmhszBi9svAfZMCCXQx3Vmk3p8JijUnMvemxjs
         cNGVM6LYnjm24VyTL0eNT9nLnwLgOTt7W+8FJLNZMZz9x2Sp9Xn/ld8j1887IGiaBojR
         ZDjRySTa1CExcz+uCPalLtWhdzsP3d5jcxB2+5B03tZ/ivdvTYQ9DGLwZ7j2MyRC6Acn
         btttDSQ2o+5dUbHinSFyt2INqvZsIN1hnfWpyCI/PA1wcmIfSTPfblcaek+QyxW+CzZa
         chbNebxdi8neIjpky5++NHDce254McorCKw5y8CVCy+WvWb2ShijidedEGd4yDbivVro
         CL4A==
X-Gm-Message-State: AOAM532hPMtedF/NIXM5VAxDiy6+RSGZ3yvSbPCRJgBzDe15x83Llqt6
        O9G64ZQgsiul/tGSMLRCi2bdyKc6uiS+ipzcwmQyhg==
X-Google-Smtp-Source: ABdhPJyocGIukR05lU8SBX3qok1ulYZ/9i3tbqXridnWz1yVkLUgDFIkcTRoM0E6lyFhuN6rd9iN7CzLs/G01va3i8Q=
X-Received: by 2002:aca:4705:: with SMTP id u5mr7755996oia.70.1626436128741;
 Fri, 16 Jul 2021 04:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <87a6mnzbx2.fsf_-_@disp2133> <87h7gvxx7l.fsf_-_@disp2133>
In-Reply-To: <87h7gvxx7l.fsf_-_@disp2133>
From:   Marco Elver <elver@google.com>
Date:   Fri, 16 Jul 2021 13:48:37 +0200
Message-ID: <CANpmjNNUX0cz39a2TYU+MVwd2MzACkBs9E+rECFGgE-1p8nPFA@mail.gmail.com>
Subject: Re: [PATCH 5/6] signal/alpha: si_trapno is only used with SIGFPE and
 SIGTRAP TRAP_UNK
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

On Thu, 15 Jul 2021 at 20:13, Eric W. Biederman <ebiederm@xmission.com> wrote:
> While reviewing the signal handlers on alpha it became clear that
> si_trapno is only set to a non-zero value when sending SIGFPE and when
> sending SITGRAP with si_code TRAP_UNK.
>
> Add send_sig_fault_trapno and send SIGTRAP TRAP_UNK, and SIGFPE with it.
>
> Remove the define of __ARCH_SI_TRAPNO and remove the always zero
> si_trapno parameter from send_sig_fault and force_sig_fault.
>
> v1: https://lkml.kernel.org/r/m1eeers7q7.fsf_-_@fess.ebiederm.org
> v2: https://lkml.kernel.org/r/20210505141101.11519-7-ebiederm@xmission.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  arch/alpha/include/uapi/asm/siginfo.h |  2 --
>  arch/alpha/kernel/osf_sys.c           |  2 +-
>  arch/alpha/kernel/signal.c            |  4 ++--
>  arch/alpha/kernel/traps.c             | 26 +++++++++++++-------------
>  arch/alpha/mm/fault.c                 |  4 ++--
>  include/linux/sched/signal.h          |  2 ++
>  kernel/signal.c                       | 21 +++++++++++++++++++++
>  7 files changed, 41 insertions(+), 20 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/siginfo.h b/arch/alpha/include/uapi/asm/siginfo.h
> index 6e1a2af2f962..e08eae88182b 100644
> --- a/arch/alpha/include/uapi/asm/siginfo.h
> +++ b/arch/alpha/include/uapi/asm/siginfo.h
> @@ -2,8 +2,6 @@
>  #ifndef _ALPHA_SIGINFO_H
>  #define _ALPHA_SIGINFO_H
>
> -#define __ARCH_SI_TRAPNO
> -
>  #include <asm-generic/siginfo.h>
>
>  #endif
> diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> index d5367a1c6300..bbdb1a9a5fd8 100644
> --- a/arch/alpha/kernel/osf_sys.c
> +++ b/arch/alpha/kernel/osf_sys.c
> @@ -876,7 +876,7 @@ SYSCALL_DEFINE5(osf_setsysinfo, unsigned long, op, void __user *, buffer,
>                         if (fex & IEEE_TRAP_ENABLE_DZE) si_code = FPE_FLTDIV;
>                         if (fex & IEEE_TRAP_ENABLE_INV) si_code = FPE_FLTINV;
>
> -                       send_sig_fault(SIGFPE, si_code,
> +                       send_sig_fault_trapno(SIGFPE, si_code,
>                                        (void __user *)NULL,  /* FIXME */
>                                        0, current);
>                 }
> diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
> index 948b89789da8..bc077babafab 100644
> --- a/arch/alpha/kernel/signal.c
> +++ b/arch/alpha/kernel/signal.c
> @@ -219,7 +219,7 @@ do_sigreturn(struct sigcontext __user *sc)
>
>         /* Send SIGTRAP if we're single-stepping: */
>         if (ptrace_cancel_bpt (current)) {
> -               send_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *) regs->pc, 0,
> +               send_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *) regs->pc,
>                                current);
>         }
>         return;
> @@ -247,7 +247,7 @@ do_rt_sigreturn(struct rt_sigframe __user *frame)
>
>         /* Send SIGTRAP if we're single-stepping: */
>         if (ptrace_cancel_bpt (current)) {
> -               send_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *) regs->pc, 0,
> +               send_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *) regs->pc,
>                                current);
>         }
>         return;
> diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
> index 921d4b6e4d95..e9e3de18793b 100644
> --- a/arch/alpha/kernel/traps.c
> +++ b/arch/alpha/kernel/traps.c
> @@ -227,7 +227,7 @@ do_entArith(unsigned long summary, unsigned long write_mask,
>         }
>         die_if_kernel("Arithmetic fault", regs, 0, NULL);
>
> -       send_sig_fault(SIGFPE, si_code, (void __user *) regs->pc, 0, current);
> +       send_sig_fault_trapno(SIGFPE, si_code, (void __user *) regs->pc, 0, current);
>  }
>
>  asmlinkage void
> @@ -268,13 +268,13 @@ do_entIF(unsigned long type, struct pt_regs *regs)
>                         regs->pc -= 4;  /* make pc point to former bpt */
>                 }
>
> -               send_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc, 0,
> +               send_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc,
>                                current);
>                 return;
>
>               case 1: /* bugcheck */
> -               send_sig_fault(SIGTRAP, TRAP_UNK, (void __user *) regs->pc, 0,
> -                              current);
> +               send_sig_fault_trapno(SIGTRAP, TRAP_UNK,
> +                                     (void __user *) regs->pc, 0, current);
>                 return;
>
>               case 2: /* gentrap */
> @@ -335,8 +335,8 @@ do_entIF(unsigned long type, struct pt_regs *regs)
>                         break;
>                 }
>
> -               send_sig_fault(signo, code, (void __user *) regs->pc, regs->r16,
> -                              current);
> +               send_sig_fault_trapno(signo, code, (void __user *) regs->pc,
> +                                     regs->r16, current);
>                 return;
>
>               case 4: /* opDEC */
> @@ -360,9 +360,9 @@ do_entIF(unsigned long type, struct pt_regs *regs)
>                         if (si_code == 0)
>                                 return;
>                         if (si_code > 0) {
> -                               send_sig_fault(SIGFPE, si_code,
> -                                              (void __user *) regs->pc, 0,
> -                                              current);
> +                               send_sig_fault_trapno(SIGFPE, si_code,
> +                                                     (void __user *) regs->pc,
> +                                                     0, current);
>                                 return;
>                         }
>                 }
> @@ -387,7 +387,7 @@ do_entIF(unsigned long type, struct pt_regs *regs)
>                       ;
>         }
>
> -       send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)regs->pc, 0, current);
> +       send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)regs->pc, current);
>  }
>
>  /* There is an ifdef in the PALcode in MILO that enables a
> @@ -402,7 +402,7 @@ do_entDbg(struct pt_regs *regs)
>  {
>         die_if_kernel("Instruction fault", regs, 0, NULL);
>
> -       force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)regs->pc, 0);
> +       force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)regs->pc);
>  }
>
>
> @@ -964,12 +964,12 @@ do_entUnaUser(void __user * va, unsigned long opcode,
>                         si_code = SEGV_MAPERR;
>                 mmap_read_unlock(mm);
>         }
> -       send_sig_fault(SIGSEGV, si_code, va, 0, current);
> +       send_sig_fault(SIGSEGV, si_code, va, current);
>         return;
>
>  give_sigbus:
>         regs->pc -= 4;
> -       send_sig_fault(SIGBUS, BUS_ADRALN, va, 0, current);
> +       send_sig_fault(SIGBUS, BUS_ADRALN, va, current);
>         return;
>  }
>
> diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
> index 09172f017efc..eee5102c3d88 100644
> --- a/arch/alpha/mm/fault.c
> +++ b/arch/alpha/mm/fault.c
> @@ -219,13 +219,13 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
>         mmap_read_unlock(mm);
>         /* Send a sigbus, regardless of whether we were in kernel
>            or user mode.  */
> -       force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) address, 0);
> +       force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) address);
>         if (!user_mode(regs))
>                 goto no_context;
>         return;
>
>   do_sigsegv:
> -       force_sig_fault(SIGSEGV, si_code, (void __user *) address, 0);
> +       force_sig_fault(SIGSEGV, si_code, (void __user *) address);
>         return;
>
>  #ifdef CONFIG_ALPHA_LARGE_VMALLOC
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 99a9ab2b169a..6657184cef07 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -330,6 +330,8 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data);
>
>  int force_sig_ptrace_errno_trap(int errno, void __user *addr);
>  int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno);
> +int send_sig_fault_trapno(int sig, int code, void __user *addr, int trapno,
> +                       struct task_struct *t);
>
>  extern int send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
>  extern void force_sigsegv(int sig);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 87a374225277..ae06a424aa72 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1824,6 +1824,23 @@ int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno)
>         return force_sig_info(&info);
>  }
>
> +/* For the rare architectures that include trap information using
> + * si_trapno.
> + */
> +int send_sig_fault_trapno(int sig, int code, void __user *addr, int trapno,
> +                         struct task_struct *t)
> +{
> +       struct kernel_siginfo info;
> +
> +       clear_siginfo(&info);
> +       info.si_signo = sig;
> +       info.si_errno = 0;
> +       info.si_code  = code;
> +       info.si_addr  = addr;
> +       info.si_trapno = trapno;
> +       return send_sig_info(info.si_signo, &info, t);
> +}
> +
>  int kill_pgrp(struct pid *pid, int sig, int priv)
>  {
>         int ret;
> @@ -3262,6 +3279,10 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
>                         else if (IS_ENABLED(CONFIG_SPARC) &&
>                                  (sig == SIGILL) && (si_code == ILL_ILLTRP))
>                                 layout = SIL_FAULT_TRAPNO;
> +                       else if (IS_ENABLED(CONFIG_ALPHA) &&
> +                                ((sig == SIGFPE) ||
> +                                 ((sig == SIGTRAP) && (si_code == TRAP_UNK))))
> +                               layout = SIL_FAULT_TRAPNO;
>  #ifdef __ARCH_SI_TRAPNO
>                         else if (layout == SIL_FAULT)
>                                 layout = SIL_FAULT_TRAPNO;
> --
> 2.20.1
>
