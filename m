Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D8B437ADB
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 18:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhJVQ1W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 12:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhJVQ1W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 12:27:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83277C061766
        for <linux-arch@vger.kernel.org>; Fri, 22 Oct 2021 09:25:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 187so4080510pfc.10
        for <linux-arch@vger.kernel.org>; Fri, 22 Oct 2021 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PlwcWBWsLOQw44JrpjcAsWcVY+9BoEC9WFjMVjfQ6I0=;
        b=XUIFFcWvc9Txz4T2CMJLZGVGh1Q+A/G9sujLyb6p8AKon+ee0wfk1ch3DbMPehxLPN
         njzOTNlTmmbQNboP70Nt0qXsTXJIedAsBnIJwwfts8lTDf+Hg1xmKw95P704FZKeZXtW
         5/ujg7Pb0h7HSW9MG+gRdfrkLuPFumXQFa1aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PlwcWBWsLOQw44JrpjcAsWcVY+9BoEC9WFjMVjfQ6I0=;
        b=YBXdsFzSD31voSr4KQ5hzfBvP7v1JLPHJaMjirTnqHvTPVjT0UVM5LcwiEVhREYMLv
         44qv9J2NyLCJk5slDdVWT1o24lcbR+uUxE19giF3Nxmo4UeZk5KpyzTTZP4tBkUAdMke
         9jTRIErvZMoDrvuYfj0iXsRZSmfwnpKxssF43rC0pcJjPdTLyDZSQ9BYkqeXSG/IhHFf
         Po83r6DgvAIW4xScMoi+5uQHYR0bGowNItJw5JKN1vPfwt6WzqLsPOyoo7lJRsldDiPV
         eC2PpgHj8XvJodjv4BVffSKfOCyyeus0wbe6owpinqYpVClZnlt6LhB7lGbRjG87y9Ji
         je3A==
X-Gm-Message-State: AOAM533GMdQlEd/GN2ynZJmNx9SlWjiMMu8gc0EXPNxBRxKp1QfTawXd
        Uo59Cv94BKTA9B+kWtXGTAQzjQ==
X-Google-Smtp-Source: ABdhPJxg0/AYTm53TRSO4FNaMgwfeeFw5ch0zpkUoONOenfZOjMHNG4o75ZqyIVjVolRdI1GMMZAiQ==
X-Received: by 2002:a05:6a00:1344:b0:44c:4cd7:4d4b with SMTP id k4-20020a056a00134400b0044c4cd74d4bmr607884pfu.50.1634919903966;
        Fri, 22 Oct 2021 09:25:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q16sm11929923pfu.36.2021.10.22.09.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 09:25:03 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:25:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH 2/7] stacktrace,sched: Make stack_trace_save_tsk() more
 robust
Message-ID: <202110220919.46F58199D@keescook>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.215612498@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022152104.215612498@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 05:09:35PM +0200, Peter Zijlstra wrote:
> Recent patches to get_wchan() made it more robust by only doing the
> unwind when the task was blocked and serialized against wakeups.
> 
> Extract this functionality as a simpler companion to task_call_func()
> named task_try_func() that really only cares about blocked tasks. Then
> employ this new function to implement the same robustness for
> ARCH_STACKWALK based stack_trace_save_tsk().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/wait.h |    1 
>  kernel/sched/core.c  |   62 ++++++++++++++++++++++++++++++++++++++++++++-------
>  kernel/stacktrace.c  |   13 ++++++----
>  3 files changed, 63 insertions(+), 13 deletions(-)
> 
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -1162,5 +1162,6 @@ int autoremove_wake_function(struct wait
>  
>  typedef int (*task_call_f)(struct task_struct *p, void *arg);
>  extern int task_call_func(struct task_struct *p, task_call_f func, void *arg);
> +extern int task_try_func(struct task_struct *p, task_call_f func, void *arg);
>  
>  #endif /* _LINUX_WAIT_H */
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1966,21 +1966,21 @@ bool sched_task_on_rq(struct task_struct
>  	return task_on_rq_queued(p);
>  }
>  
> +static int try_get_wchan(struct task_struct *p, void *arg)
> +{
> +	unsigned long *wchan = arg;
> +	*wchan = __get_wchan(p);
> +	return 0;
> +}
> +
>  unsigned long get_wchan(struct task_struct *p)
>  {
>  	unsigned long ip = 0;
> -	unsigned int state;
>  
>  	if (!p || p == current)
>  		return 0;
>  
> -	/* Only get wchan if task is blocked and we can keep it that way. */
> -	raw_spin_lock_irq(&p->pi_lock);
> -	state = READ_ONCE(p->__state);
> -	smp_rmb(); /* see try_to_wake_up() */
> -	if (state != TASK_RUNNING && state != TASK_WAKING && !p->on_rq)
> -		ip = __get_wchan(p);
> -	raw_spin_unlock_irq(&p->pi_lock);
> +	task_try_func(p, try_get_wchan, &ip);
>  
>  	return ip;
>  }
> @@ -4184,6 +4184,52 @@ int task_call_func(struct task_struct *p
>  	return ret;
>  }
>  
> +/*
> + * task_try_func - Invoke a function on task in blocked state
> + * @p: Process for which the function is to be invoked
> + * @func: Function to invoke
> + * @arg: Argument to function
> + *
> + * Fix the task in a blocked state, when possible. And if so, invoke @func on it.
> + *
> + * Returns:
> + *  -EBUSY or whatever @func returns
> + */
> +int task_try_func(struct task_struct *p, task_call_f func, void *arg)
> +{
> +	unsigned long flags;
> +	unsigned int state;
> +	int ret = -EBUSY;
> +
> +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> +
> +	state = READ_ONCE(p->__state);
> +
> +	/*
> +	 * Ensure we load p->on_rq after p->__state, otherwise it would be
> +	 * possible to, falsely, observe p->on_rq == 0.
> +	 *
> +	 * See try_to_wake_up() for a longer comment.
> +	 */
> +	smp_rmb();
> +
> +	/*
> +	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
> +	 * the task is blocked. Make sure to check @state since ttwu() can drop
> +	 * locks at the end, see ttwu_queue_wakelist().
> +	 */
> +	if (state != TASK_RUNNING && state != TASK_WAKING && !p->on_rq) {
> +		/*
> +		 * The task is blocked and we're holding off wakeupsr. For any
> +		 * of the other task states, see task_call_func().
> +		 */
> +		ret = func(p, arg);
> +	}
> +
> +	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> +	return ret;
> +}
> +
>  /**
>   * wake_up_process - Wake up a specific process
>   * @p: The process to be woken up.
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -123,6 +123,13 @@ unsigned int stack_trace_save(unsigned l
>  }
>  EXPORT_SYMBOL_GPL(stack_trace_save);
>  
> +static int try_arch_stack_walk_tsk(struct task_struct *tsk, void *arg)
> +{
> +	stack_trace_consume_fn consume_entry = stack_trace_consume_entry_nosched;
> +	arch_stack_walk(consume_entry, arg, tsk, NULL);
> +	return 0;
> +}
> +
>  /**
>   * stack_trace_save_tsk - Save a task stack trace into a storage array
>   * @task:	The task to examine
> @@ -135,7 +142,6 @@ EXPORT_SYMBOL_GPL(stack_trace_save);
>  unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
>  				  unsigned int size, unsigned int skipnr)
>  {
> -	stack_trace_consume_fn consume_entry = stack_trace_consume_entry_nosched;
>  	struct stacktrace_cookie c = {
>  		.store	= store,
>  		.size	= size,
> @@ -143,11 +149,8 @@ unsigned int stack_trace_save_tsk(struct
>  		.skip	= skipnr + (current == tsk),
>  	};
>  
> -	if (!try_get_task_stack(tsk))
> -		return 0;
> +	task_try_func(tsk, try_arch_stack_walk_tsk, &c);

Pardon my thin understanding of the scheduler, but I assume this change
doesn't mean stack_trace_save_tsk() stops working for "current", right?
In trying to answer this for myself, I couldn't convince myself what value
current->__state have here. Is it one of TASK_(UN)INTERRUPTIBLE ?

Assuming this does actually remain callable for current:

Reviewed-by: Kees Cook <keescook@chromium.org>


>  
> -	arch_stack_walk(consume_entry, &c, tsk, NULL);
> -	put_task_stack(tsk);
>  	return c.len;
>  }
>  
> 
> 

-- 
Kees Cook
