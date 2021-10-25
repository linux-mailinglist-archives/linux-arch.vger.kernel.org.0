Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9100F43A506
	for <lists+linux-arch@lfdr.de>; Mon, 25 Oct 2021 22:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhJYUyc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhJYUyc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 16:54:32 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F09AC061767
        for <linux-arch@vger.kernel.org>; Mon, 25 Oct 2021 13:52:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x66so12038373pfx.13
        for <linux-arch@vger.kernel.org>; Mon, 25 Oct 2021 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZZh0IECXowBCWpmYDjsxrWWSCRfGtx4P6nC6kYAYt+k=;
        b=SRFft4wiXL+/ugEXttbLoM+j8UIfqavIroHiJMDmXYIx8TRomh0iWdgOO7Ckv/Z4WT
         yCnz9gP9PTdLAHIi//7ld86XOASJnBxghn5tYyopI0ye1NpM5Z/RF/f+yMvqboTp3KIV
         6mJBfeuIaVfsB7iH3AIvzwE/oEgxGA/w5uEGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZZh0IECXowBCWpmYDjsxrWWSCRfGtx4P6nC6kYAYt+k=;
        b=gUvwKHY5mEm+K+MKG1SXF5VIkRzqETyYlk8VpuSgAz28CL0GRG5DN6R2sbJbNyRbnB
         BHGhBlul5mySHyl2I/dnj79bZ1i+rVZ231EU8Sz3IWQTB6x5I1dtQVoeMylgvLGMYXYy
         3E/cdtBl4JOFfT0Bo1567BOINLjCwFybOSh6/nZSNEtdMaa7pe1MMa1215BPfnmK0eUQ
         omkFoVEyul0pfKULvyNjx44XMQgClWL4TMFhT6unH6PC3Z68UD2dqDyl7EQlsSId1Dek
         bLafzN24DJjAhQmImkrwFRXjTVnwYnhu5koEntOS+caxompFtHUkd+sCfwSPE13NYnrj
         sVig==
X-Gm-Message-State: AOAM531MXJqmGYyJlb8yu9cYSUo12QwlUBJQBKws7D0Qa6Wj2wreWblN
        lfUoPpXQ/h0gE9yv4Nnypc9eNQ==
X-Google-Smtp-Source: ABdhPJzhtzs/gZAecnK5Sw9o9EObSAFbO4gTcH0KKpFx8p4M2uBnO/r9x7fofCnnAxdG1GBvmk/XFQ==
X-Received: by 2002:a05:6a00:140c:b0:447:96be:2ade with SMTP id l12-20020a056a00140c00b0044796be2ademr20942343pfu.26.1635195128986;
        Mon, 25 Oct 2021 13:52:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gt5sm9481241pjb.49.2021.10.25.13.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 13:52:08 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:52:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
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
Message-ID: <202110251351.6B61CE297@keescook>
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
> 
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
> 
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

Looks good to me, though I did like Mark's idea to name "task_try_func"
to "task_blocked_try_func" or something like that to make the "why can
this fail?" be more self-documenting. *shrug*

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
