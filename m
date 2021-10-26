Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3600243AF1F
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 11:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhJZJf7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Oct 2021 05:35:59 -0400
Received: from foss.arm.com ([217.140.110.172]:55922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhJZJf6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Oct 2021 05:35:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97339101E;
        Tue, 26 Oct 2021 02:33:34 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.74.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A4313F70D;
        Tue, 26 Oct 2021 02:33:29 -0700 (PDT)
Date:   Tue, 26 Oct 2021 10:33:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        zhengqi.arch@bytedance.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH 2/7] stacktrace,sched: Make stack_trace_save_tsk() more
 robust
Message-ID: <20211026093319.GA30152@C02TD0UTHF1T.local>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.215612498@infradead.org>
 <202110220919.46F58199D@keescook>
 <20211022165431.GF86184@C02TD0UTHF1T.local>
 <20211022170135.GF174703@worktop.programming.kicks-ass.net>
 <YXcVySsxQO4Iakbq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXcVySsxQO4Iakbq@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 25, 2021 at 10:38:33PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 22, 2021 at 07:01:35PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 22, 2021 at 05:54:31PM +0100, Mark Rutland wrote:
> > 
> > > > Pardon my thin understanding of the scheduler, but I assume this change
> > > > doesn't mean stack_trace_save_tsk() stops working for "current", right?
> > > > In trying to answer this for myself, I couldn't convince myself what value
> > > > current->__state have here. Is it one of TASK_(UN)INTERRUPTIBLE ?
> > > 
> > > Regardless of that, current->on_rq will be non-zero, so you're right that this
> > > causes stack_trace_save_tsk() to not work for current, e.g.
> > > 
> > > | # cat /proc/self/stack 
> > > | # wc  /proc/self/stack 
> > > |         0         0         0 /proc/self/stack
> > > 
> > > TBH, I think that (taking a step back from this issue in particular)
> > > stack_trace_save_tsk() *shouldn't* work for current, and callers *should* be
> > > forced to explicitly handle current separately from blocked tasks.
> > 
> > That..
> 
> So I think I'd prefer the following approach to that (and i'm not
> currently volunteering for it):
> 
>  - convert all archs to ARCH_STACKWALK; this gets the semantics out of
>    arch code and into the single kernel/stacktrace.c file.
> 
>  - bike-shed a new/improved stack_trace_save*() API and implement it
>    *once* in generic code based on arch_stack_walk().
> 
>  - convert users; delete old etc..
> 
> For now, current users of stack_trace_save_tsk() very much expect
> tsk==current to work.

While I still think it's best to have distinct arch_stack_walk_*()
functions, I'm perfectly happy to say we need to convert arches to
ARCH_STACKWALK first, and punt bikeshedding until that's done.

> > > So we could fix this in the stacktrace code with:
> > > 
> > > | diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> > > | index a1cdbf8c3ef8..327af9ff2c55 100644
> > > | --- a/kernel/stacktrace.c
> > > | +++ b/kernel/stacktrace.c
> > > | @@ -149,7 +149,10 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
> > > |                 .skip   = skipnr + (current == tsk),
> > > |         };
> > > |  
> > > | -       task_try_func(tsk, try_arch_stack_walk_tsk, &c);
> > > | +       if (tsk == current)
> > > | +               try_arch_stack_walk_tsk(tsk, &c);
> > > | +       else
> > > | +               task_try_func(tsk, try_arch_stack_walk_tsk, &c);
> > > |  
> > > |         return c.len;
> > > |  }
> > > 
> > > ... and we could rename task_try_func() to blocked_task_try_func(), and
> > > later push the distinction into higher-level callers.
> > 
> > I think I favour this fix if we have to. But that's for next week :-)
> 
> I ended up with the below delta to this patch.

With the abov in mind, the below looks good to me!

Thanks,
Mark.

> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -101,7 +101,7 @@ static bool stack_trace_consume_entry_no
>  }
>  
>  /**
> - * stack_trace_save - Save a stack trace into a storage array
> + * stack_trace_save - Save a stack trace (of current) into a storage array
>   * @store:	Pointer to storage array
>   * @size:	Size of the storage array
>   * @skipnr:	Number of entries to skip at the start of the stack trace
> @@ -132,7 +132,7 @@ static int try_arch_stack_walk_tsk(struc
>  
>  /**
>   * stack_trace_save_tsk - Save a task stack trace into a storage array
> - * @task:	The task to examine
> + * @task:	The task to examine (current allowed)
>   * @store:	Pointer to storage array
>   * @size:	Size of the storage array
>   * @skipnr:	Number of entries to skip at the start of the stack trace
> @@ -149,13 +149,25 @@ unsigned int stack_trace_save_tsk(struct
>  		.skip	= skipnr + (current == tsk),
>  	};
>  
> -	task_try_func(tsk, try_arch_stack_walk_tsk, &c);
> +	/*
> +	 * If the task doesn't have a stack (e.g., a zombie), the stack is
> +	 * empty.
> +	 */
> +	if (!try_get_task_stack(tsk))
> +		return 0;
> +
> +	if (tsk == current)
> +		try_arch_stack_walk_tsk(tsk, &c);
> +	else
> +		task_try_func(tsk, try_arch_stack_walk_tsk, &c);
> +
> +	put_task_stack(tsk);
>  
>  	return c.len;
>  }
>  
>  /**
> - * stack_trace_save_regs - Save a stack trace based on pt_regs into a storage array
> + * stack_trace_save_regs - Save a stack trace (of current) based on pt_regs into a storage array
>   * @regs:	Pointer to pt_regs to examine
>   * @store:	Pointer to storage array
>   * @size:	Size of the storage array
