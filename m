Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F5F426B50
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbhJHMyy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 08:54:54 -0400
Received: from foss.arm.com ([217.140.110.172]:50226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242035AbhJHMyy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 08:54:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A56F81063;
        Fri,  8 Oct 2021 05:52:58 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.27.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 138C33F66F;
        Fri,  8 Oct 2021 05:52:41 -0700 (PDT)
Date:   Fri, 8 Oct 2021 13:52:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, jannh@google.com,
        linux-kernel@vger.kernel.org, vcaputo@pengaru.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net
Subject: Re: [PATCH 7/7] arch: Fix STACKTRACE_SUPPORT
Message-ID: <20211008125238.GC976@C02TD0UTHF1T.local>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.455137084@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008111626.455137084@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 08, 2021 at 01:15:34PM +0200, Peter Zijlstra wrote:
> A few archs got save_stack_trace_tsk() vs in_sched_functions() wrong.

As mentioned on the last patch, it's not clear to me what the intended
semantic of save_stack_trace_tsk() is w.r.t. sched functions, as the
naive reading is that it should report *everything* a task may return
to.

If it's meant to skip sched functions, I think we need some explicit
documentation/commentary to that effect. In that case, there are other
architectures that need a fixup (e.g. arm64).

TBH, I don't think it *should* skip sched functions, and we should
filter out sched functions as required at a higher level, or deprecate
this interface in favour of arch_stack_walk() where it's easier to have
common filter functions invoked during the walk....

Thanks,
Mark.

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
>  	return __save_trace(pc, arg, false);
>  }
>  
> +static bool save_trace_nosched(unsigned long pc, void *arg)
> +{
> +	return __save_trace(pc, arg, true);
> +}
> +
>  /*
>   * Save stack-backtrace addresses into a stack_trace buffer.
>   */
>  void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
>  {
> -	walk_stackframe(tsk, NULL, save_trace, trace);
> +	walk_stackframe(tsk, NULL, save_trace_nosched, trace);
>  }
>  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
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
> -	save_stack_trace_tsk(current, trace);
> -}
> -EXPORT_SYMBOL_GPL(save_stack_trace);
> -
> -void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
> +static void __save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace, bool savesched)
>  {
>  	struct pt_regs dummyregs;
>  	struct pt_regs *regs = &dummyregs;
> @@ -88,6 +79,20 @@ void save_stack_trace_tsk(struct task_st
>  		regs->cp0_epc = tsk->thread.reg31;
>  	} else
>  		prepare_frametrace(regs);
> -	save_context_stack(trace, tsk, regs, tsk == current);
> +	save_context_stack(trace, tsk, regs, savesched);
> +}
> +
> +/*
> + * Save stack-backtrace addresses into a stack_trace buffer.
> + */
> +void save_stack_trace(struct stack_trace *trace)
> +{
> +	__save_stack_trace_tsk(current, trace, true);
> +}
> +EXPORT_SYMBOL_GPL(save_stack_trace);
> +
> +void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
> +{
> +	__save_stack_trace_tsk(tsk, trace, false);
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
> -	save_stack_trace_tsk(current, trace);
> -}
> -EXPORT_SYMBOL_GPL(save_stack_trace);
> -
> -void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
> +static void __save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace, bool savesched)
>  {
>  	unsigned long *fpn;
>  	int skip = trace->skip;
> -	int savesched;
>  	int graph_idx = 0;
>  
>  	if (tsk == current) {
>  		__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(fpn));
> -		savesched = 1;
>  	} else {
>  		fpn = (unsigned long *)thread_saved_fp(tsk);
> -		savesched = 0;
>  	}
>  
>  	while (!kstack_end(fpn) && !((unsigned long)fpn & 0x3)
> @@ -50,4 +41,14 @@ void save_stack_trace_tsk(struct task_st
>  		fpn = (unsigned long *)fpp;
>  	}
>  }
> +void save_stack_trace(struct stack_trace *trace)
> +{
> +	__save_stack_trace_tsk(current, trace, true);
> +}
> +EXPORT_SYMBOL_GPL(save_stack_trace);
> +
> +void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
> +{
> +	__save_stack_trace_tsk(tsk, trace, false);
> +}
>  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
> 
> 
