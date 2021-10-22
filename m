Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F393437B35
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhJVRAI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 13:00:08 -0400
Received: from foss.arm.com ([217.140.110.172]:56718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233413AbhJVRAF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Oct 2021 13:00:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C5501063;
        Fri, 22 Oct 2021 09:57:47 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F252E3F73D;
        Fri, 22 Oct 2021 09:57:43 -0700 (PDT)
Date:   Fri, 22 Oct 2021 17:57:41 +0100
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
Message-ID: <20211022165741.GG86184@C02TD0UTHF1T.local>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.215612498@infradead.org>
 <202110220919.46F58199D@keescook>
 <20211022164514.GE174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022164514.GE174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 06:45:14PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 22, 2021 at 09:25:02AM -0700, Kees Cook wrote:
> > On Fri, Oct 22, 2021 at 05:09:35PM +0200, Peter Zijlstra wrote:
> > >  /**
> > >   * stack_trace_save_tsk - Save a task stack trace into a storage array
> > >   * @task:	The task to examine
> > > @@ -135,7 +142,6 @@ EXPORT_SYMBOL_GPL(stack_trace_save);
> > >  unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
> > >  				  unsigned int size, unsigned int skipnr)
> > >  {
> > > -	stack_trace_consume_fn consume_entry = stack_trace_consume_entry_nosched;
> > >  	struct stacktrace_cookie c = {
> > >  		.store	= store,
> > >  		.size	= size,
> > > @@ -143,11 +149,8 @@ unsigned int stack_trace_save_tsk(struct
> > >  		.skip	= skipnr + (current == tsk),
> > >  	};
> > >  
> > > -	if (!try_get_task_stack(tsk))
> > > -		return 0;
> > > +	task_try_func(tsk, try_arch_stack_walk_tsk, &c);
> > 
> > Pardon my thin understanding of the scheduler, but I assume this change
> > doesn't mean stack_trace_save_tsk() stops working for "current", right?
> > In trying to answer this for myself, I couldn't convince myself what value
> > current->__state have here. Is it one of TASK_(UN)INTERRUPTIBLE ?
> 
> current really shouldn't be using stack_trace_save_tsk(), and no you're
> quite right, it will not work for current, irrespective of ->__state,
> current will always be ->on_rq.

Heh, we raced to say the same thing. :)

> I started auditing stack_trace_save_tsk() users a few days ago, but
> didn't look for this particular issue. I suppose I'll have to start over
> with that.

FWIW, this shape of thing was one of the reasons I wanted to split
arch_stack_walk() into separate:

* arch_stack_walk_current()
* arch_stack_walk_current_regs()
* arch_stack_walk_blocked_task()

... with similar applying here, since otherwise people won't consider
the distinction between current / !current at the caller level, leading
to junk like this.

Thanks,
Mark.
