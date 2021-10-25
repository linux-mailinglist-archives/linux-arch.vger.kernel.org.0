Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4655F439BA4
	for <lists+linux-arch@lfdr.de>; Mon, 25 Oct 2021 18:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhJYQh3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 12:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbhJYQh3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 12:37:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AFDC061767;
        Mon, 25 Oct 2021 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=42fMSpjGEZX4Emrq8rOK2RuxYOJkvrOXksuSkuDOt4M=; b=hezmpAqbBQ7giKxgWJunkzqfEu
        GXtYpfUzoiusSLWLOT0NzN8wmKiGKAllcwQJnDgDuJz1qTTFlK2cM8W+0jM4RJIsZh0RqiS75jSQR
        kJu/Tx9zK4nEc9yCWEHn81cDHS0DwoO6bEltzDJATpH4BQqSFoWwoAERYfdm5s7bZzzQ5i958Sz+6
        5fLzKP/tcRls0Mxob0B2i5Sez+MekPLbWGFp3lTLKKzZyspeuDGz2ZHo5BbrfuMDp+n9zOS1/Bsi0
        GOnJSPGV7BK9ugKFF9U7M0geqwDmowHkEiedgi9LLhNEB/4Pz+t+IwNC88OPMc3R1TfuHGe3WaJ7F
        agGbt7yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf2oW-00GFxA-PG; Mon, 25 Oct 2021 16:27:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2737F3003A9;
        Mon, 25 Oct 2021 18:27:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 059302C00BA06; Mon, 25 Oct 2021 18:27:05 +0200 (CEST)
Date:   Mon, 25 Oct 2021 18:27:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 2/7] stacktrace,sched: Make stack_trace_save_tsk() more
 robust
Message-ID: <YXba2RDaiM4uqgKM@hirez.programming.kicks-ass.net>
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

So I took that out because task_try_func() pins the task, except now
I see that _reliable() has a comment about zombies, which I suppose is
equally applicable to here and wchan.

Alternative to failing try_get_task_stack() is checking PF_EXITING in
try_arch_stack_walk_tsk(), which seems more consistent behaviour since
it doesn't rely on CONFIG_THREAD_INFO_IN_TASK.

> +	task_try_func(tsk, try_arch_stack_walk_tsk, &c);
>  
> -	arch_stack_walk(consume_entry, &c, tsk, NULL);
> -	put_task_stack(tsk);
>  	return c.len;
>  }
>  
> 
> 
