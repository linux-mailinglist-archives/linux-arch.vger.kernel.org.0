Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02575427877
	for <lists+linux-arch@lfdr.de>; Sat,  9 Oct 2021 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhJIJi2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Oct 2021 05:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230022AbhJIJi2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 Oct 2021 05:38:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C30956103B;
        Sat,  9 Oct 2021 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633772191;
        bh=SjT8GXjp2vALqAboJSsc+ya7I8HSo3JkjeRK9RdsfOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RPa5mVuZmKfBqcwzAKdwFLiOTh4k96G1uawf5srCOZkavlEliMGmiGYkMd7zaYuur
         9D/ZlUyYDul7Iscb2Mj4kG9D1oktsPMIHdKq28uLstTO+wi+4Wyqg6G/dZfjqibPlX
         BWvz/ey57e+lL7xBmVtUf/NMqHIu87QifvYy8QuWHYaUFj9311A2jnF3aSvVPWq44V
         KVZ87zyADOVHAVnZ1Ian7zheZDXzmotL+Yhr3k8r+3DZ0DNfQ8KbYtVUYfCDsrLy09
         320QguKRYhBKQczyXoi0ZYQCk6nuZOTUhkRXtLwm+lAYi62nqVX8UY3xT8x7Mc78Nv
         IW/MbN0QRJCKw==
Received: by mail-ua1-f51.google.com with SMTP id r17so189394uaf.8;
        Sat, 09 Oct 2021 02:36:31 -0700 (PDT)
X-Gm-Message-State: AOAM532YhZTiXp89NiMmfRD1AumqnX8VDxiLTqOo7S80vJ2uEkcuT+Po
        tVIxJrzhhWt214xwdiHlh4IoBbBWsCFuRZkFn9M=
X-Google-Smtp-Source: ABdhPJw4K9Vh0ayL3YzQdV/mPKwTuZ6tYl/k8iHoEU5LBj948W/50Y3El7sw3j56qe2h+lEng8MYJoY+5CCl0TmO9lE=
X-Received: by 2002:a05:6130:426:: with SMTP id ba38mr7997026uab.108.1633772190841;
 Sat, 09 Oct 2021 02:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211008111527.438276127@infradead.org> <20211008111626.455137084@infradead.org>
In-Reply-To: <20211008111626.455137084@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 9 Oct 2021 17:36:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRTbOjqfNcm16E_XCtBSxTiUyczsWYR9uy6ZYqSuR41Pg@mail.gmail.com>
Message-ID: <CAJF2gTRTbOjqfNcm16E_XCtBSxTiUyczsWYR9uy6ZYqSuR41Pg@mail.gmail.com>
Subject: Re: [PATCH 7/7] arch: Fix STACKTRACE_SUPPORT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vcaputo@pengaru.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com,
        Helge Deller <deller@gmx.de>, zhengqi.arch@bytedance.com,
        me@tobin.cc, tycho@tycho.pizza,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>, metze@samba.org,
        laijs@linux.alibaba.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>, vgupta@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Jonas Bonn <jonas@southpole.se>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        David Miller <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx Peter,

On Fri, Oct 8, 2021 at 7:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> A few archs got save_stack_trace_tsk() vs in_sched_functions() wrong.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/csky/kernel/stacktrace.c  |    7 ++++++-
>  arch/mips/kernel/stacktrace.c  |   27 ++++++++++++++++-----------
>  arch/nds32/kernel/stacktrace.c |   21 +++++++++++----------
>  3 files changed, 33 insertions(+), 22 deletions(-)
>
> --- a/arch/csky/kernel/stacktrace.c
> +++ b/arch/csky/kernel/stacktrace.c
> @@ -122,12 +122,17 @@ static bool save_trace(unsigned long pc,
>         return __save_trace(pc, arg, false);
>  }
>
> +static bool save_trace_nosched(unsigned long pc, void *arg)
> +{
> +       return __save_trace(pc, arg, true);
> +}
> +
>  /*
>   * Save stack-backtrace addresses into a stack_trace buffer.
>   */
>  void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
>  {
> -       walk_stackframe(tsk, NULL, save_trace, trace);
> +       walk_stackframe(tsk, NULL, save_trace_nosched, trace);
>  }
>  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
I think the patch should be:
@@ -138,7 +138,7 @@ static bool __save_trace(unsigned long pc, void
*arg, bool nosched)

 static bool save_trace(unsigned long pc, void *arg)
 {
-       return __save_trace(pc, arg, false);
+       return __save_trace(pc, arg, true);
 }

Another question:
If we put sched_text in the backtrace buffer, just cause put no useful
information in wchan, right?
(I think it wouldn't cause a worse problem than debugging.)


>
> --- a/arch/mips/kernel/stacktrace.c
> +++ b/arch/mips/kernel/stacktrace.c
> @@ -66,16 +66,7 @@ static void save_context_stack(struct st
>  #endif
>  }
>
> -/*
> - * Save stack-backtrace addresses into a stack_trace buffer.
> - */
> -void save_stack_trace(struct stack_trace *trace)
> -{
> -       save_stack_trace_tsk(current, trace);
> -}
> -EXPORT_SYMBOL_GPL(save_stack_trace);
> -
> -void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
> +static void __save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace, bool savesched)
>  {
>         struct pt_regs dummyregs;
>         struct pt_regs *regs = &dummyregs;
> @@ -88,6 +79,20 @@ void save_stack_trace_tsk(struct task_st
>                 regs->cp0_epc = tsk->thread.reg31;
>         } else
>                 prepare_frametrace(regs);
> -       save_context_stack(trace, tsk, regs, tsk == current);
> +       save_context_stack(trace, tsk, regs, savesched);
> +}
> +
> +/*
> + * Save stack-backtrace addresses into a stack_trace buffer.
> + */
> +void save_stack_trace(struct stack_trace *trace)
> +{
> +       __save_stack_trace_tsk(current, trace, true);
> +}
> +EXPORT_SYMBOL_GPL(save_stack_trace);
> +
> +void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
> +{
> +       __save_stack_trace_tsk(tsk, trace, false);
>  }
>  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
> --- a/arch/nds32/kernel/stacktrace.c
> +++ b/arch/nds32/kernel/stacktrace.c
> @@ -6,25 +6,16 @@
>  #include <linux/stacktrace.h>
>  #include <linux/ftrace.h>
>
> -void save_stack_trace(struct stack_trace *trace)
> -{
> -       save_stack_trace_tsk(current, trace);
> -}
> -EXPORT_SYMBOL_GPL(save_stack_trace);
> -
> -void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
> +static void __save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace, bool savesched)
>  {
>         unsigned long *fpn;
>         int skip = trace->skip;
> -       int savesched;
>         int graph_idx = 0;
>
>         if (tsk == current) {
>                 __asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(fpn));
> -               savesched = 1;
>         } else {
>                 fpn = (unsigned long *)thread_saved_fp(tsk);
> -               savesched = 0;
>         }
>
>         while (!kstack_end(fpn) && !((unsigned long)fpn & 0x3)
> @@ -50,4 +41,14 @@ void save_stack_trace_tsk(struct task_st
>                 fpn = (unsigned long *)fpp;
>         }
>  }
> +void save_stack_trace(struct stack_trace *trace)
> +{
> +       __save_stack_trace_tsk(current, trace, true);
> +}
> +EXPORT_SYMBOL_GPL(save_stack_trace);
> +
> +void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
> +{
> +       __save_stack_trace_tsk(tsk, trace, false);
> +}
>  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
>
>


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
