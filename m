Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777AA3CB6EC
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jul 2021 13:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhGPLv1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jul 2021 07:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhGPLv1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jul 2021 07:51:27 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB4C06175F
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 04:48:31 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id b14-20020a056830310eb02904c7e78705f4so9521736ots.13
        for <linux-arch@vger.kernel.org>; Fri, 16 Jul 2021 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCAMfplbo3e2iODI9poYTm8lXc8h2ulhVqpOO6GIdUY=;
        b=D8DMuB/NoSjS+60zzJxsOOILuPr+HxIwVzVsSJVfm6zUYFS1NK0YvlI3cpD03tai3C
         GJ9bLATPo02qo5E8EMlSboDUJKP3a9sv6/pf4ZEmXdYHyqYE4X6+ykPYrw+cf9C+ZsZM
         jy/vjWBZ+SwF6pCP9/yMw+4irHxJqozlpJZ+OAQ3CHtihG4wGuaWQk4a3h02e9VhfTPi
         +PPAsxYybVsZirFe4ViK0/MrEuKSapzKgGNQIhj70Cun52P3cfjO8EJCZushXIiZI7sY
         0LPINYDjuebVi0DTeW+nsHzfkaLeQrUyZfCZXYYOUXNifGO03KOWcSSlKWPOBWDNiPVl
         VRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCAMfplbo3e2iODI9poYTm8lXc8h2ulhVqpOO6GIdUY=;
        b=daGqo3av4y9Ohp5UMU76sMnvPHdcmNvefFjiCt9ydd52+dUlmShWiNhMk1LJDsUxLT
         nIKTCI/+kcE4BCgiYd0IE4kAqz3WPwG7xDt+fiNGp++Kn7Wy31rmfj+YY+OQIbcWzxGW
         +thAjjTlhDn/xPQNqRTPH1MGklKWJCh67FL6GmCGiVlbKXv6QRBiQVWI6tWPM2xX8uZj
         UVz2AQzHs+sqBpcFTbmrRPwvSofoBuGL/IkUagyI2odJdMz6PWynhyCOEHYpPNRzAl6H
         VyV46IAHX92nqaGacvkkziUj3NbzksU1KeUewCcvJXwdSoPaU0INTAo8ZnQlBSJTkvPV
         LR1w==
X-Gm-Message-State: AOAM533kad6Ea+E7oySfcQQkHZvTcWKP+HIc1aVWwt5Wh4baJAr0fTwG
        nmuY05wRw4kr+lZYABiCYCUwGVzma83HyWerGyup1g==
X-Google-Smtp-Source: ABdhPJy8/WDKQVEqrCCE9FT/HDZN1LH/+u7mcWBjJjvPWwuIfb0/MZ3akM15S+WvAyRkg2OWOZfb6zqLz9Sg7NCFv6c=
X-Received: by 2002:a9d:d04:: with SMTP id 4mr8241154oti.251.1626436110870;
 Fri, 16 Jul 2021 04:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <87a6mnzbx2.fsf_-_@disp2133> <87bl73xx6x.fsf_-_@disp2133>
In-Reply-To: <87bl73xx6x.fsf_-_@disp2133>
From:   Marco Elver <elver@google.com>
Date:   Fri, 16 Jul 2021 13:48:18 +0200
Message-ID: <CANpmjNOv4mf3PiEVvAUFAXkRaA3V37UBYoB2j2P7_qF868B6mA@mail.gmail.com>
Subject: Re: [PATCH 6/6] signal: Remove the generic __ARCH_SI_TRAPNO support
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
> Now that __ARCH_SI_TRAPNO is no longer set by any architecture remove
> all of the code it enabled from the kernel.
>
> On alpha and sparc a more explict approach of using
> send_sig_fault_trapno or force_sig_fault_trapno in the very limited
> circumstances where si_trapno was set to a non-zero value.
>
> The generic support that is being removed always set si_trapno on all
> fault signals.  With only SIGILL ILL_ILLTRAP on sparc and SIGFPE and
> SIGTRAP TRAP_UNK on alpla providing si_trapno values asking all senders
> of fault signals to provide an si_trapno value does not make sense.
>
> Making si_trapno an ordinary extension of the fault siginfo layout has
> enabled the architecture generic implementation of SIGTRAP TRAP_PERF,
> and enables other faulting signals to grow architecture generic
> senders as well.
>
> v1: https://lkml.kernel.org/r/m18s4zs7nu.fsf_-_@fess.ebiederm.org
> v2: https://lkml.kernel.org/r/20210505141101.11519-8-ebiederm@xmission.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  arch/mips/include/uapi/asm/siginfo.h |  2 --
>  include/linux/sched/signal.h         |  8 --------
>  kernel/signal.c                      | 14 --------------
>  3 files changed, 24 deletions(-)
>
> diff --git a/arch/mips/include/uapi/asm/siginfo.h b/arch/mips/include/uapi/asm/siginfo.h
> index c34c7eef0a1c..8cb8bd061a68 100644
> --- a/arch/mips/include/uapi/asm/siginfo.h
> +++ b/arch/mips/include/uapi/asm/siginfo.h
> @@ -10,9 +10,7 @@
>  #ifndef _UAPI_ASM_SIGINFO_H
>  #define _UAPI_ASM_SIGINFO_H
>
> -
>  #define __ARCH_SIGEV_PREAMBLE_SIZE (sizeof(long) + 2*sizeof(int))
> -#undef __ARCH_SI_TRAPNO /* exception code needs to fill this ...  */
>
>  #define __ARCH_HAS_SWAPPED_SIGINFO
>
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 6657184cef07..928e0025d358 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -298,11 +298,6 @@ static inline void kernel_signal_stop(void)
>
>         schedule();
>  }
> -#ifdef __ARCH_SI_TRAPNO
> -# define ___ARCH_SI_TRAPNO(_a1) , _a1
> -#else
> -# define ___ARCH_SI_TRAPNO(_a1)
> -#endif
>  #ifdef __ia64__
>  # define ___ARCH_SI_IA64(_a1, _a2, _a3) , _a1, _a2, _a3
>  #else
> @@ -310,14 +305,11 @@ static inline void kernel_signal_stop(void)
>  #endif
>
>  int force_sig_fault_to_task(int sig, int code, void __user *addr
> -       ___ARCH_SI_TRAPNO(int trapno)
>         ___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
>         , struct task_struct *t);
>  int force_sig_fault(int sig, int code, void __user *addr
> -       ___ARCH_SI_TRAPNO(int trapno)
>         ___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr));
>  int send_sig_fault(int sig, int code, void __user *addr
> -       ___ARCH_SI_TRAPNO(int trapno)
>         ___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
>         , struct task_struct *t);
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index ae06a424aa72..2181423e562a 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1666,7 +1666,6 @@ void force_sigsegv(int sig)
>  }
>
>  int force_sig_fault_to_task(int sig, int code, void __user *addr
> -       ___ARCH_SI_TRAPNO(int trapno)
>         ___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
>         , struct task_struct *t)
>  {
> @@ -1677,9 +1676,6 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
>         info.si_errno = 0;
>         info.si_code  = code;
>         info.si_addr  = addr;
> -#ifdef __ARCH_SI_TRAPNO
> -       info.si_trapno = trapno;
> -#endif
>  #ifdef __ia64__
>         info.si_imm = imm;
>         info.si_flags = flags;
> @@ -1689,16 +1685,13 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
>  }
>
>  int force_sig_fault(int sig, int code, void __user *addr
> -       ___ARCH_SI_TRAPNO(int trapno)
>         ___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr))
>  {
>         return force_sig_fault_to_task(sig, code, addr
> -                                      ___ARCH_SI_TRAPNO(trapno)
>                                        ___ARCH_SI_IA64(imm, flags, isr), current);
>  }
>
>  int send_sig_fault(int sig, int code, void __user *addr
> -       ___ARCH_SI_TRAPNO(int trapno)
>         ___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
>         , struct task_struct *t)
>  {
> @@ -1709,9 +1702,6 @@ int send_sig_fault(int sig, int code, void __user *addr
>         info.si_errno = 0;
>         info.si_code  = code;
>         info.si_addr  = addr;
> -#ifdef __ARCH_SI_TRAPNO
> -       info.si_trapno = trapno;
> -#endif
>  #ifdef __ia64__
>         info.si_imm = imm;
>         info.si_flags = flags;
> @@ -3283,10 +3273,6 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
>                                  ((sig == SIGFPE) ||
>                                   ((sig == SIGTRAP) && (si_code == TRAP_UNK))))
>                                 layout = SIL_FAULT_TRAPNO;
> -#ifdef __ARCH_SI_TRAPNO
> -                       else if (layout == SIL_FAULT)
> -                               layout = SIL_FAULT_TRAPNO;
> -#endif
>                 }
>                 else if (si_code <= NSIGPOLL)
>                         layout = SIL_POLL;
> --
> 2.20.1
>
