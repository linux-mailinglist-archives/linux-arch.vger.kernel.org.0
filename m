Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104AE437B1B
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 18:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhJVQvt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 12:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhJVQvs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 12:51:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0373CC061764;
        Fri, 22 Oct 2021 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qV4lqw51JU/WvNpOcorY6Iu1E0f9CVODkWaYzp9LC7U=; b=HfUrtUVJ/HqbBsiyYaGg+Wduzy
        1piuFHw2wMWFcXJ0A5EuVMCzC3zz3Nzce/5tZPjHsX8Ds8UdR4QxMsPyimOAI8FxS+MB0O3Qf5Zau
        300ddpyu1cuCo1eOBT4BtiZ7UPBqC9A+RdFhPsvqwXfc92WbCedOprPPzmzaOqItppkEcwIb69Gtl
        wC5GBqH/RqTg3Cj71QVfjB53mPx6C9yBToEkymb9M+/5Tq5AIBzcMe9nm5H3NoSEjHB+pOzu75Qxd
        TCozBH/2JYTeVKCrRBJ0z07+k4/sw6bWoIUAh5gQ2+Pfx0kKrMhGOcXIZmyMoNIThCr1ljmSZl6kf
        bxnHQNUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdxfP-00E1OM-9v; Fri, 22 Oct 2021 16:45:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68C11986249; Fri, 22 Oct 2021 18:45:14 +0200 (CEST)
Date:   Fri, 22 Oct 2021 18:45:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <20211022164514.GE174703@worktop.programming.kicks-ass.net>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.215612498@infradead.org>
 <202110220919.46F58199D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110220919.46F58199D@keescook>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 09:25:02AM -0700, Kees Cook wrote:
> On Fri, Oct 22, 2021 at 05:09:35PM +0200, Peter Zijlstra wrote:
> >  /**
> >   * stack_trace_save_tsk - Save a task stack trace into a storage array
> >   * @task:	The task to examine
> > @@ -135,7 +142,6 @@ EXPORT_SYMBOL_GPL(stack_trace_save);
> >  unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
> >  				  unsigned int size, unsigned int skipnr)
> >  {
> > -	stack_trace_consume_fn consume_entry = stack_trace_consume_entry_nosched;
> >  	struct stacktrace_cookie c = {
> >  		.store	= store,
> >  		.size	= size,
> > @@ -143,11 +149,8 @@ unsigned int stack_trace_save_tsk(struct
> >  		.skip	= skipnr + (current == tsk),
> >  	};
> >  
> > -	if (!try_get_task_stack(tsk))
> > -		return 0;
> > +	task_try_func(tsk, try_arch_stack_walk_tsk, &c);
> 
> Pardon my thin understanding of the scheduler, but I assume this change
> doesn't mean stack_trace_save_tsk() stops working for "current", right?
> In trying to answer this for myself, I couldn't convince myself what value
> current->__state have here. Is it one of TASK_(UN)INTERRUPTIBLE ?

current really shouldn't be using stack_trace_save_tsk(), and no you're
quite right, it will not work for current, irrespective of ->__state,
current will always be ->on_rq.

I started auditing stack_trace_save_tsk() users a few days ago, but
didn't look for this particular issue. I suppose I'll have to start over
with that.
