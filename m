Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939B24F4843
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 02:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiDEVdt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 17:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384771AbiDEPPF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 11:15:05 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C8841318
        for <linux-arch@vger.kernel.org>; Tue,  5 Apr 2022 06:30:38 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-de3ca1efbaso14355760fac.9
        for <linux-arch@vger.kernel.org>; Tue, 05 Apr 2022 06:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SUjbR6d0Hm/+GiUujjBnx6+L5jTOpdyMzjgCeWVv18=;
        b=sY8UN9C1PHBoH0LvzHXIFdwX6MKoA35gbLCAShSgRkAbp8iWftwgDax7e93W769u1e
         5X9YZGkOkmmAlD6LaJg70ZOrpL2jAQA473qlyP6Cgh+uH5VJpUMbGJtJ0FVxyDL7ARzV
         lLD6TuoG/w//kxV2eLSYgVy56lG6gwfD696nmdNK0W/nDySoM8GedVz7GrRDUsDDnvoM
         QeOB6se/YnanV8WDchwRKkwez2IjGwtnsaHcBG/AkXC+luyHDLzKPtuyHgybXQNk+7Ra
         1tHz3b53Sn6tZlSfRcftDFTKqdhnbtWU9fwymXdFbZxLoXFdPVx25nY85Wwp9mfOLKq1
         +v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SUjbR6d0Hm/+GiUujjBnx6+L5jTOpdyMzjgCeWVv18=;
        b=AYOyTY/DXFGDj4E+le8wjMs6ND43Y9XUiQAYb2cLqXgb6cZOk8Z+POQS4+FGYJVEy1
         3fFez/TE1yq5J6ZmvuGmH3HZOYTHsUAipsE5fvEUsYqG2UUZWpnf2VFVcfDOGB+yoSlZ
         7GW1QRDjikjGHbK1Ibg2Ti90czl93IXEOwSB98N6q1JnBWhne0GpBv9vzWry2UcdyrF0
         qUVqSomXXsM0ehcfpK+0cmoutefK1SU8az3OLDzK3n+HAmmJ3ZnEheGfq4SljQwmGpvH
         ZVsT34RDKEcigSb7tfllMwP+gVspfpMqhs8wG/yShwPk+OQlB9xcAyRt9IJ/I5lGJIsS
         6xYg==
X-Gm-Message-State: AOAM5311+iztneN/Ei9n55Pyu6w/pg9X0M+1ZkT9AFIt8aN1ZqmFlv40
        7zzQwC+eEDkJdIldxyQWd4OwBGRFn+ru+0T5mFwz6g==
X-Google-Smtp-Source: ABdhPJwgxZbKTNmtpo4mT0qYfgd73+gzD+qfaMV68qcfH1OdXWhs2/TQa3kSn7Gi7xyKhVKfha3zBFRUnbqgNtZIEqg=
X-Received: by 2002:a05:6870:e0d1:b0:e2:1c3b:cca2 with SMTP id
 a17-20020a056870e0d100b000e21c3bcca2mr1459916oab.163.1649165437660; Tue, 05
 Apr 2022 06:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220404111204.935357-1-elver@google.com>
In-Reply-To: <20220404111204.935357-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 5 Apr 2022 15:30:26 +0200
Message-ID: <CACT4Y+YiDhmKokuqD3dhtj67HxZpTumiQvvRp35X-sR735qjqQ@mail.gmail.com>
Subject: Re: [PATCH] signal: Deliver SIGTRAP on perf event asynchronously if blocked
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 4 Apr 2022 at 13:12, Marco Elver <elver@google.com> wrote:
>
> With SIGTRAP on perf events, we have encountered termination of
> processes due to user space attempting to block delivery of SIGTRAP.
> Consider this case:
>
>     <set up SIGTRAP on a perf event>
>     ...
>     sigset_t s;
>     sigemptyset(&s);
>     sigaddset(&s, SIGTRAP | <and others>);
>     sigprocmask(SIG_BLOCK, &s, ...);
>     ...
>     <perf event triggers>
>
> When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
> will force the signal, but revert back to the default handler, thus
> terminating the task.
>
> This makes sense for error conditions, but not so much for explicitly
> requested monitoring. However, the expectation is still that signals
> generated by perf events are synchronous, which will no longer be the
> case if the signal is blocked and delivered later.
>
> To give user space the ability to clearly distinguish synchronous from
> asynchronous signals, introduce siginfo_t::si_perf_flags and
> TRAP_PERF_FLAG_ASYNC (opted for flags in case more binary information is
> required in future).
>
> The resolution to the problem is then to (a) no longer force the signal
> (avoiding the terminations), but (b) tell user space via si_perf_flags
> if the signal was synchronous or not, so that such signals can be
> handled differently (e.g. let user space decide to ignore or consider
> the data imprecise).
>
> The alternative of making the kernel ignore SIGTRAP on perf events if
> the signal is blocked may work for some usecases, but likely causes
> issues in others that then have to revert back to interception of
> sigprocmask() (which we want to avoid). [ A concrete example: when using
> breakpoint perf events to track data-flow, in a region of code where
> signals are blocked, data-flow can no longer be tracked accurately.
> When a relevant asynchronous signal is received after unblocking the
> signal, the data-flow tracking logic needs to know its state is
> imprecise. ]
>
> Link: https://lore.kernel.org/all/Yjmn%2FkVblV3TdoAq@elver.google.com/
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Tested-by: Dmitry Vyukov <dvyukov@google.com>

I've tested delivery of SIGTRAPs when it's blocked with sigprocmask,
it does not kill the process now.

And tested the case where previously I was getting infinite recursion
and stack overflow (SIGTRAP handler causes another SIGTRAP recursively
before being able to detect recursion and return). With this patch it
can be handled by blocking recursive SIGTRAPs (!SA_NODEFER).


> ---
>  arch/arm/kernel/signal.c           |  1 +
>  arch/arm64/kernel/signal.c         |  1 +
>  arch/arm64/kernel/signal32.c       |  1 +
>  arch/m68k/kernel/signal.c          |  1 +
>  arch/sparc/kernel/signal32.c       |  1 +
>  arch/sparc/kernel/signal_64.c      |  1 +
>  arch/x86/kernel/signal_compat.c    |  2 ++
>  include/linux/compat.h             |  1 +
>  include/linux/sched/signal.h       |  2 +-
>  include/uapi/asm-generic/siginfo.h |  7 +++++++
>  kernel/events/core.c               |  4 ++--
>  kernel/signal.c                    | 18 ++++++++++++++++--
>  12 files changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index 459abc5d1819..ea128e32e8ca 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -708,6 +708,7 @@ static_assert(offsetof(siginfo_t, si_upper) == 0x18);
>  static_assert(offsetof(siginfo_t, si_pkey)     == 0x14);
>  static_assert(offsetof(siginfo_t, si_perf_data)        == 0x10);
>  static_assert(offsetof(siginfo_t, si_perf_type)        == 0x14);
> +static_assert(offsetof(siginfo_t, si_perf_flags) == 0x18);
>  static_assert(offsetof(siginfo_t, si_band)     == 0x0c);
>  static_assert(offsetof(siginfo_t, si_fd)       == 0x10);
>  static_assert(offsetof(siginfo_t, si_call_addr)        == 0x0c);
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 4a4122ef6f39..41b5d9d3672a 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -1011,6 +1011,7 @@ static_assert(offsetof(siginfo_t, si_upper)       == 0x28);
>  static_assert(offsetof(siginfo_t, si_pkey)     == 0x20);
>  static_assert(offsetof(siginfo_t, si_perf_data)        == 0x18);
>  static_assert(offsetof(siginfo_t, si_perf_type)        == 0x20);
> +static_assert(offsetof(siginfo_t, si_perf_flags) == 0x24);
>  static_assert(offsetof(siginfo_t, si_band)     == 0x10);
>  static_assert(offsetof(siginfo_t, si_fd)       == 0x18);
>  static_assert(offsetof(siginfo_t, si_call_addr)        == 0x10);
> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> index d984282b979f..4700f8522d27 100644
> --- a/arch/arm64/kernel/signal32.c
> +++ b/arch/arm64/kernel/signal32.c
> @@ -487,6 +487,7 @@ static_assert(offsetof(compat_siginfo_t, si_upper)  == 0x18);
>  static_assert(offsetof(compat_siginfo_t, si_pkey)      == 0x14);
>  static_assert(offsetof(compat_siginfo_t, si_perf_data) == 0x10);
>  static_assert(offsetof(compat_siginfo_t, si_perf_type) == 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_perf_flags)        == 0x18);
>  static_assert(offsetof(compat_siginfo_t, si_band)      == 0x0c);
>  static_assert(offsetof(compat_siginfo_t, si_fd)                == 0x10);
>  static_assert(offsetof(compat_siginfo_t, si_call_addr) == 0x0c);
> diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
> index 49533f65958a..b9f6908a31bc 100644
> --- a/arch/m68k/kernel/signal.c
> +++ b/arch/m68k/kernel/signal.c
> @@ -625,6 +625,7 @@ static inline void siginfo_build_tests(void)
>         /* _sigfault._perf */
>         BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x10);
>         BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x14);
> +       BUILD_BUG_ON(offsetof(siginfo_t, si_perf_flags) != 0x18);
>
>         /* _sigpoll */
>         BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x0c);
> diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
> index f9fe502b81c6..dad38960d1a8 100644
> --- a/arch/sparc/kernel/signal32.c
> +++ b/arch/sparc/kernel/signal32.c
> @@ -779,5 +779,6 @@ static_assert(offsetof(compat_siginfo_t, si_upper)  == 0x18);
>  static_assert(offsetof(compat_siginfo_t, si_pkey)      == 0x14);
>  static_assert(offsetof(compat_siginfo_t, si_perf_data) == 0x10);
>  static_assert(offsetof(compat_siginfo_t, si_perf_type) == 0x14);
> +static_assert(offsetof(compat_siginfo_t, si_perf_flags)        == 0x18);
>  static_assert(offsetof(compat_siginfo_t, si_band)      == 0x0c);
>  static_assert(offsetof(compat_siginfo_t, si_fd)                == 0x10);
> diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
> index 8b9fc76cd3e0..570e43e6fda5 100644
> --- a/arch/sparc/kernel/signal_64.c
> +++ b/arch/sparc/kernel/signal_64.c
> @@ -590,5 +590,6 @@ static_assert(offsetof(siginfo_t, si_upper) == 0x28);
>  static_assert(offsetof(siginfo_t, si_pkey)     == 0x20);
>  static_assert(offsetof(siginfo_t, si_perf_data)        == 0x18);
>  static_assert(offsetof(siginfo_t, si_perf_type)        == 0x20);
> +static_assert(offsetof(siginfo_t, si_perf_flags) == 0x24);
>  static_assert(offsetof(siginfo_t, si_band)     == 0x10);
>  static_assert(offsetof(siginfo_t, si_fd)       == 0x14);
> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index b52407c56000..879ef8c72f5c 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -149,8 +149,10 @@ static inline void signal_compat_build_tests(void)
>
>         BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x18);
>         BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x20);
> +       BUILD_BUG_ON(offsetof(siginfo_t, si_perf_flags) != 0x24);
>         BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_data) != 0x10);
>         BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_type) != 0x14);
> +       BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_flags) != 0x18);
>
>         CHECK_CSI_OFFSET(_sigpoll);
>         CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 1c758b0e0359..01fddf72a81f 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -235,6 +235,7 @@ typedef struct compat_siginfo {
>                                 struct {
>                                         compat_ulong_t _data;
>                                         u32 _type;
> +                                       u32 _flags;
>                                 } _perf;
>                         };
>                 } _sigfault;
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 3c8b34876744..bab7cc56b13a 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -320,7 +320,7 @@ int send_sig_mceerr(int code, void __user *, short, struct task_struct *);
>
>  int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper);
>  int force_sig_pkuerr(void __user *addr, u32 pkey);
> -int force_sig_perf(void __user *addr, u32 type, u64 sig_data);
> +int send_sig_perf(void __user *addr, u32 type, u64 sig_data);
>
>  int force_sig_ptrace_errno_trap(int errno, void __user *addr);
>  int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno);
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index 3ba180f550d7..ffbe4cec9f32 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -99,6 +99,7 @@ union __sifields {
>                         struct {
>                                 unsigned long _data;
>                                 __u32 _type;
> +                               __u32 _flags;
>                         } _perf;
>                 };
>         } _sigfault;
> @@ -164,6 +165,7 @@ typedef struct siginfo {
>  #define si_pkey                _sifields._sigfault._addr_pkey._pkey
>  #define si_perf_data   _sifields._sigfault._perf._data
>  #define si_perf_type   _sifields._sigfault._perf._type
> +#define si_perf_flags  _sifields._sigfault._perf._flags
>  #define si_band                _sifields._sigpoll._band
>  #define si_fd          _sifields._sigpoll._fd
>  #define si_call_addr   _sifields._sigsys._call_addr
> @@ -270,6 +272,11 @@ typedef struct siginfo {
>   * that are of the form: ((PTRACE_EVENT_XXX << 8) | SIGTRAP)
>   */
>
> +/*
> + * Flags for si_perf_flags if SIGTRAP si_code is TRAP_PERF.
> + */
> +#define TRAP_PERF_FLAG_ASYNC (1u << 0)
> +
>  /*
>   * SIGCHLD si_codes
>   */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cfde994ce61c..6eafb1b0ad4a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6533,8 +6533,8 @@ static void perf_sigtrap(struct perf_event *event)
>         if (current->flags & PF_EXITING)
>                 return;
>
> -       force_sig_perf((void __user *)event->pending_addr,
> -                      event->attr.type, event->attr.sig_data);
> +       send_sig_perf((void __user *)event->pending_addr,
> +                     event->attr.type, event->attr.sig_data);
>  }
>
>  static void perf_pending_event_disable(struct perf_event *event)
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 30cd1ca43bcd..e43bc2a692f5 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1805,7 +1805,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
>  }
>  #endif
>
> -int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
> +int send_sig_perf(void __user *addr, u32 type, u64 sig_data)
>  {
>         struct kernel_siginfo info;
>
> @@ -1817,7 +1817,18 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
>         info.si_perf_data = sig_data;
>         info.si_perf_type = type;
>
> -       return force_sig_info(&info);
> +       /*
> +        * Signals generated by perf events should not terminate the whole
> +        * process if SIGTRAP is blocked, however, delivering the signal
> +        * asynchronously is better than not delivering at all. But tell user
> +        * space if the signal was asynchronous, so it can clearly be
> +        * distinguished from normal synchronous ones.
> +        */
> +       info.si_perf_flags = sigismember(&current->blocked, info.si_signo) ?
> +                                    TRAP_PERF_FLAG_ASYNC :
> +                                    0;
> +
> +       return send_sig_info(info.si_signo, &info, current);
>  }
>
>  /**
> @@ -3432,6 +3443,7 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
>                 to->si_addr = ptr_to_compat(from->si_addr);
>                 to->si_perf_data = from->si_perf_data;
>                 to->si_perf_type = from->si_perf_type;
> +               to->si_perf_flags = from->si_perf_flags;
>                 break;
>         case SIL_CHLD:
>                 to->si_pid = from->si_pid;
> @@ -3509,6 +3521,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>                 to->si_addr = compat_ptr(from->si_addr);
>                 to->si_perf_data = from->si_perf_data;
>                 to->si_perf_type = from->si_perf_type;
> +               to->si_perf_flags = from->si_perf_flags;
>                 break;
>         case SIL_CHLD:
>                 to->si_pid    = from->si_pid;
> @@ -4722,6 +4735,7 @@ static inline void siginfo_buildtime_checks(void)
>         CHECK_OFFSET(si_pkey);
>         CHECK_OFFSET(si_perf_data);
>         CHECK_OFFSET(si_perf_type);
> +       CHECK_OFFSET(si_perf_flags);
>
>         /* sigpoll */
>         CHECK_OFFSET(si_band);
> --
> 2.35.1.1094.g7c7d902a7c-goog
>
