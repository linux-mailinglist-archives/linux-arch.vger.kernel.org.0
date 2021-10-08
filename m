Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8982426B12
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbhJHMnh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 08:43:37 -0400
Received: from foss.arm.com ([217.140.110.172]:49394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241408AbhJHMnh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 08:43:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DDB9ED1;
        Fri,  8 Oct 2021 05:41:41 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.27.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC3843F766;
        Fri,  8 Oct 2021 05:41:29 -0700 (PDT)
Date:   Fri, 8 Oct 2021 13:40:52 +0100
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
Subject: Re: [PATCH 6/7] arch: __get_wchan || STACKTRACE_SUPPORT
Message-ID: <20211008124052.GA976@C02TD0UTHF1T.local>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.392918519@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008111626.392918519@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[Adding Josh, since there might be a concern here from a livepatch pov]

On Fri, Oct 08, 2021 at 01:15:33PM +0200, Peter Zijlstra wrote:
> It's trivial to implement __get_wchan() with CONFIG_STACKTRACE

Possibly, but I don't think this is quite right -- semantic issue below.
 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -257,8 +257,6 @@ struct task_struct;
>  /* Free all resources held by a thread. */
>  extern void release_thread(struct task_struct *);
>  
> -unsigned long __get_wchan(struct task_struct *p);
> -
>  void update_sctlr_el1(u64 sctlr);
>  
>  /* Thread switching */
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -528,32 +528,6 @@ __notrace_funcgraph struct task_struct *
>  	return last;
>  }
>  
> -unsigned long __get_wchan(struct task_struct *p)
> -{
> -	struct stackframe frame;
> -	unsigned long stack_page, ret = 0;
> -	int count = 0;
> -
> -	stack_page = (unsigned long)try_get_task_stack(p);
> -	if (!stack_page)
> -		return 0;
> -
> -	start_backtrace(&frame, thread_saved_fp(p), thread_saved_pc(p));
> -
> -	do {
> -		if (unwind_frame(p, &frame))
> -			goto out;
> -		if (!in_sched_functions(frame.pc)) {
> -			ret = frame.pc;
> -			goto out;
> -		}
> -	} while (count++ < 16);
> -
> -out:
> -	put_task_stack(p);
> -	return ret;
> -}
> -

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1966,6 +1966,21 @@ bool sched_task_on_rq(struct task_struct
>  	return task_on_rq_queued(p);
>  }
>  
> +#ifdef CONFIG_STACKTRACE
> +static unsigned long __get_wchan(struct task_struct *p)
> +{
> +	unsigned long entry = 0;
> +
> +	stack_trace_save_tsk(p, &entry, 1, 0);

This assumes stack_trace_save_tsk() will skip sched functions, but I
don't think that's ever been a requirement? It's certinaly not
documented anywhere that I could find, and arm64 doesn't do so today,
and this patch causes wchan to just log `__switch_to` for everything.

I realise you "fix" that for some arches in the next patch, but it's not
clear to me that's the right thing to do -- I would expect that
stack_trace_save_tsk() *shouldn't* skip anything unless we've explicitly
told it to via skipnr, because I'd expect that
stack_trace_save_tsk_reliable() mustn't, in case we ever need to patch
anything in the scheduler (or arch ctxsw code) with a livepatch, or if
you ever *want* to have the sched functions in a trace.

So I have two big questions:

1) Where precisely should stack_trace_save_tsk() and
   stack_trace_save_tsk_reliable() start from?

1) What should you do when you *do* want sched functions in a trace?

We could side-step the issue here by using arch_stack_walk(), which'd
make it easy to skip sched functions in the core code.

Thanks,
Mark.
